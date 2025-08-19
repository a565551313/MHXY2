local ffii = require("ffi")
ffii.cdef[[
    int _access(const char*, int);
    int MessageBoxA(void *, const char*, const char*, int);
]]

local _bor    = bit.bor
local _lshift = bit.lshift
local _rshift = bit.rshift
local _band   = bit.band
local _copy   = ffii.copy
local _cast   = ffii.cast
local _new    = ffii.new
-- local ifile = io.open('1.wpal', 'rb')
--local str = ifile:read("*a")
--ifile:close()
-- for k = 5, #str, 4 do
-- 	local h = string.byte(str, k)
-- 	local l = string.byte(str, k + 1)
-- 	print(h + l * 256)
-- end

function read_number(file)
	return file:read('*n')
end

function read_line(file)
	return file:read('*l')
end

function write_number(file, i)
	file:write(string.char(i % 256))
	file:write(string.char(math.floor(i / 256)))
	file:write(string.char(0))
	file:write(string.char(0))
end

function txt_write_to_wpal(txtfile, wpalfile)
	local txt = io.open(txtfile, 'r')
    if not txt then return end
    local wpal = io.open(wpalfile, 'wb')
    if not wpal then return end
	local head = read_number(txt)
	local partsCount = (head % 10)
	wpal:write('wpal')
	write_number(wpal, partsCount)
	local temp
	for k = 1, partsCount + 1 do
		temp = read_number(txt)
		write_number(wpal, temp)
	end
	read_line(txt)
	for k = 1, partsCount do
		local matrixsCount = read_number(txt)
		write_number(wpal, matrixsCount)
		read_line(txt)
		for i = 1, matrixsCount do
			if head > 1000 then read_line(txt) end
			for m = 1, 9 do
				temp = read_number(txt)
				write_number(wpal, temp)
			end
			if head > 1000 then read_line(txt) end
			read_line(txt)
		end
	end
	txt:close()
	wpal:close()
end


function apply_txt_to_wpal(wpalfile)
    if ffii.C._access(wpalfile, 0) == 0 then return end
    local txtfile = string.sub(wpalfile, 1, #wpalfile - 4) .. 'txt'
    if ffii.C._access(txtfile, 0) ~= 0 then
        ffii.C.MessageBoxA(nil, wpalfile .. '/' .. txtfile, 'file is not exist', 0)
        return
    end
    txt_write_to_wpal(txtfile, wpalfile)
end


function _RGB8888to8888(p,p32,alpha)
	p32 = _cast("uint8_t*",p32)

	local a = _band(_rshift(p,24),0xFF)
	local r = _band(_rshift(p,16),0xFF)
	local g = _band(_rshift(p,8),0xFF)
	local b = _band(_rshift(p,0),0xFF)

	p32[0]  = b--B
	p32[1]  = g--G
	p32[2]  = r--R
	p32[3]  = alpha or 255 --a--_bor(_lshift(a,2),_rshift(a,4))--a
end

function _RGB8888to8888_Pal(p,p32,P)
	p32 = _cast("uint8_t*",p32)
	local a = _band(_rshift(p,24),0xFF)
	local r = _band(_rshift(p,16),0xFF)
	local g = _band(_rshift(p,8),0xFF)
	local b = _band(_rshift(p,0),0xFF)

	local r2 = r*P[0].R + g*P[0].G + b*P[0].B;
	local g2 = r*P[1].R + g*P[1].G + b*P[1].B;
	local b2 = r*P[2].R + g*P[2].G + b*P[2].B;
	r = _rshift(r2,8)
	g = _rshift(g2,8)
	b = _rshift(b2,8)
	r = r>0xFF and 0xFF or r
	g = g>0xFF and 0xFF or g
	b = b>0xFF and 0xFF or b
	p32[0] = b--B
	p32[1] = g--G
	p32[2] = r--R
	p32[3] = 255
end

function _RGB565to888(p16,p32,alpha)
	p32 = _cast("uint8_t*",p32)
	local r = _band(_rshift(p16,11),0x1F)
	local g = _band(_rshift(p16,5),0x3F)
	local b = _band(p16,0x1F)
	p32[0]  = _bor(_lshift(b,3),_rshift(b,2))--B
	p32[1]  = _bor(_lshift(g,2),_rshift(g,4))--G
	p32[2]  = _bor(_lshift(r,3),_rshift(r,2))--R
	p32[3]  = alpha or 255
end

function _RGB565to888_Pal(p16,p32,P)
	p32 = _cast("uint8_t*",p32)
	local r  = _band(_rshift(p16,11),0x1F)
	local g  = _band(_rshift(p16,5),0x3F)
	local b  = _band(p16,0x1F)
	local r2 = r*P[0].R + g*P[0].G + b*P[0].B;
	local g2 = r*P[1].R + g*P[1].G + b*P[1].B;
	local b2 = r*P[2].R + g*P[2].G + b*P[2].B;
	r = _rshift(r2,8)
	g = _rshift(g2,8)
	b = _rshift(b2,8)
	r = r>0x1F and 0x1F or r
	g = g>0x3F and 0x3F or g
	b = b>0x1F and 0x1F or b
	p32[0] = _bor(_lshift(b,3),_rshift(b,2))--B
	p32[1] = _bor(_lshift(g,2),_rshift(g,4))--G
	p32[2] = _bor(_lshift(r,3),_rshift(r,2))--R
	p32[3] = 255
end

function _SetAlpha(p32,alpha)
	return _bor(_band(p32,0xFFFFFF),_lshift(alpha,24))
end
