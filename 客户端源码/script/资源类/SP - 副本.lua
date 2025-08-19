--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2024-11-17 19:46:52
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
require("script/txt2wpal")
local ffi     = require("ffi")
local _bor    = bit.bor
local _lshift = bit.lshift
local _rshift = bit.rshift
local _band   = bit.band
local _copy   = ffi.copy
local _cast   = ffi.cast
local _new    = ffi.new



local was = class()
local wls = require("gge纹理类")
local kwl = wls():空白纹理()

function was:初始化(路径,长度)
	if 长度 then
		if 长度 == 0 then
			self.Data = _cast("uint8_t*",路径)
		else
			self.Data = _new('uint8_t[?]',长度)
			_copy(self.Data,路径,长度)
		end
		self.DLen = 长度
	else
		self.was = __gge.readfile(路径)
		self.Data = _cast("uint8_t*",self.was)
		self.DLen = #self.was
	end
	local head = _cast("WAS_HEADER*",self.Data)
	self.方向数 = head.Group
	self.帧数   = head.Frame
	self.宽度   = head.Width
	self.高度   = head.Height
	self.总帧数   = self.帧数*self.方向数-1
	-- self.HLen = head.HLen+4
	-- self.Palette16 = _cast("uint16_t*",self.Data+self.HLen)
	-- self.Palette32 = _new('int32_t[?]',256)
	-- self.Number = head.Group*head.Frame;
	-- self.FrameList = _cast("uint32_t*",self.Data+self.HLen+512);
	-- for i=0,255 do
	-- 	if i < self.Number and self.FrameList[i]>0 then
	-- 		self.FrameList[i] = self.FrameList[i]+self.HLen
	-- 	end
	-- 	_RGB565to888(self.Palette16[i],self.Palette32+i,255)
	-- end
	-- if head.Flag==0x3344 then
	-- 	self.兼容 = true
	-- end
	-- self.HLen = head.HLen+4
	-- if self.兼容 then
	-- 	self.HLen = 16
	-- 	self.colorlen = 256
	-- 	self.Palette32_0 = _cast("uint32_t*",self.Data+self.HLen)
	-- 	self.Palette32 = ffi.new('int32_t[?]',256)
	-- 	if head.HLen>0 then
	-- 		for i=0,255 do
	-- 			_RGB8888to8888(self.Palette32_0[i],self.Palette32+i)
	-- 		end
	-- 	end
	-- 	self.Number = head.Group*head.Frame;
	-- 	self.FrameList = _cast("uint32_t*",self.Data+self.HLen+head.HLen);
	-- else
	-- 	self.HLen = head.HLen+4
	-- 	self.colorlen = 256
	-- 	self.Palette16 = _cast("uint16_t*",self.Data+self.HLen)
	-- 	self.Palette32 = ffi.new('int32_t[?]',256)
	-- 	for i=0,255 do
	-- 		_RGB565to888(self.Palette16[i],self.Palette32+i)
	-- 	end
	-- 	self.Number = head.Group*head.Frame;
	-- 	self.FrameList = _cast("uint32_t*",self.Data+self.HLen+512);
	-- end
	-- for i=0,self.Number-1 do
	-- 	if self.FrameList[i]>0 then
	-- 		if self.兼容 then
	-- 			self.FrameList[i] = self.FrameList[i]
	-- 		else
	-- 			self.FrameList[i] = self.FrameList[i]+self.HLen
	-- 		end
	-- 	end
	-- end

	if head.Flag==0x3344 then
        self.兼容 = true
    end
    self.HLen = head.HLen+4
    if self.兼容 then
        self.HLen = 16
        self.colorlen = 256
        self.Palette32_0 = _cast("uint32_t*",self.Data+self.HLen)
        self.Palette32 = ffi.new('int32_t[?]',self.colorlen)
        if head.HLen>0 then
            for i=0,255 do
                _RGB8888to8888(self.Palette32_0[i],self.Palette32+i)
            end
        end
        self.Number = head.Group*head.Frame;
        self.FrameList = _cast("uint32_t*",self.Data+self.HLen+head.HLen);
    else
        self.HLen = head.HLen+4
        self.colorlen = 256
        self.Palette16 = _cast("uint16_t*",self.Data+self.HLen)
        self.Palette32 = ffi.new('int32_t[?]',self.colorlen)
        for i=0,255 do
            _RGB565to888(self.Palette16[i],self.Palette32+i)
        end
        self.Number = head.Group*head.Frame;
        self.FrameList = _cast("uint32_t*",self.Data+self.HLen+512);
    end
    for i=0,self.Number-1 do
        if self.FrameList[i]>0 then
            if self.兼容 then
                self.FrameList[i] = self.FrameList[i]
            else
                self.FrameList[i] = self.FrameList[i]+self.HLen
            end
        end
    end




end


function was:取空染色()
    local copyData = ffi.new('int32_t[?]', self.colorlen)
    ffi.copy(copyData, self.Palette32, ffi.sizeof(self.Palette32))
    return copyData
end


function was:取纹理(id)
	local Frameofs = self.FrameList[id]
	if id < self.Number and Frameofs>0 then
		local pData     = self.Data
		local Frame     = _cast("FRAME*",pData+Frameofs)
		local FrameLine = _cast("uint32_t*",pData+(Frameofs+16));
		if Frame.Width>0 and Frame.Height>0 then
			local t   = wls():空白纹理(Frame.Width,Frame.Height)
			local buf = _cast('int32_t*',t:锁定())
			local PixelLen = Frame.Width
			local Palette32 = self.Palette32
			local Level,Repeat,Color,style,rp,pos,poslen =0,0,0
			for h=0,Frame.Height-1 do
				rp     = Frameofs+FrameLine[h]
				pos    = h*PixelLen
				poslen = pos+PixelLen
				while pData[rp]>0 do
					style=_rshift(pData[rp],6)
					if style==0 then--{00******}
						if _band(pData[rp],0x20)==0x20 then-- {001*****} 表示带有Alpha通道的单个像素
							Level = _band(pData[rp],0x1F);rp=rp+1
							if pos<poslen+1 then
								buf[pos] = _SetAlpha(Palette32[pData[rp]],_bor(_lshift(Level,3),_rshift(Level,2)))
								pos=pos+1;rp=rp+1
							else break
							end
						else--{000*****} 表示重复n次带有Alpha通道的像素
							Repeat = _band(pData[rp],0x1F);rp=rp+1
							Level = pData[rp];rp=rp+1
							Color = _SetAlpha(Palette32[pData[rp]],_bor(_lshift(Level,3),_rshift(Level,2)))
							for i=1,Repeat do
								if pos<poslen+1 then
									buf[pos] = Color
									pos=pos+1
								else break
								end
							end
							rp=rp+1
						end
					elseif style==1 then--{01******} 表示不带Alpha通道不重复的n个像素组成的数据段
						Repeat = _band(pData[rp],0x3F);rp=rp+1
						for i=1,Repeat do
							if pos<poslen+1 then
								buf[pos] = Palette32[pData[rp]]
								pos=pos+1;rp=rp+1
							else break
							end
						end
					elseif style==2 then--{10******} 表示重复n次像素
						Repeat = _band(pData[rp],0x3F);rp=rp+1
						Color = Palette32[pData[rp]]
						for i=1,Repeat do
							if pos<poslen+1 then
								buf[pos] = Color
								pos=pos+1
							else break
							end
						end
						rp=rp+1
					elseif style==3 then--{11******} 表示跳过n个像素，跳过的像素用透明色代替
						-- Repeat = _band(pData[rp],0x3F);
						-- if Repeat==0 then--特殊处理
						-- 	rp=rp+2
						-- else
						-- 	for i=1,Repeat do
						-- 		if pos<poslen+1 then
						-- 			pos=pos+1
						-- 		else break
						-- 		end
						-- 	end
						-- end
						-- rp=rp+1
						Repeat = _band(pData[rp],0x3F);
						if Repeat==0 then
							if pos-1>=0 and not self.不补全 then
								if _band(pData[rp+1],0x20)==0x20 then
									local Level = _band(pData[rp+1],0x1F)
									Level = _bor(_lshift(Level,3),_rshift(Level,2))
									local lv2 = _rshift(buf[pos-1],24)
									if Level>lv2 then
										buf[pos-1] = _SetAlpha(Palette32[pData[rp+2]],Level)
									end
								end
							end
							if rp+3<self.DLen then
								rp=rp+2
							end
						else
							for i=1,Repeat do
								if pos<poslen then
									pos=pos+1
								else break
								end
							end
						end
						rp=rp+1
					end
				end
				if h > 0 and pData[rp] == 0 and pos==(poslen-PixelLen) then
					if pData[Frameofs+FrameLine[h-1]]~=0 then--法术处理
						_copy(buf+pos,buf+(pos-PixelLen),PixelLen*4)
					end
				end
			end
		    t:解锁()
		    return {t,Frame.Key_X,Frame.Key_Y,Frame.Width,Frame.Height}
		end
	end
	return {kwl,0,0}
end

function was:置调色板(路径)
    apply_txt_to_wpal(路径)
    self.wpal = __gge.readfile(路径)
    self.wData = _cast("uint32_t*",self.wpal)
     if self.wData[0] == 1635017060 or 1818325111 then
        local num = self.wData[1]
        self.PalList = self.wData+2--调色板位置列表
        self.Palette = {}--方案
        self.wData = self.wData+(3+num)
        for i=0,num-1 do
            self.Palette[i] = {n=self.wData[0],p=_cast("PalProgram*",self.wData+1)}
            self.wData = self.wData+(1+self.wData[0]*9)
        end
    else
        error("文件错误！")
    end
    return self
end

function was:调色(...)
	local v = {...}
	local n,p = 0
	for i=0,255 do
		if i==self.PalList[n] then--调色板位置
			if v[n+1] and v[n+1]<self.Palette[n].n then
				p=self.Palette[n].p[v[n+1]].Color --方案位置
				if p[0].R ~= 255 and p[1].R ~= 255 and p[1].G ~= 255 and p[2].R ~= 255 then

				end
			else
				p=self.Palette[n].p[0].Color --方案位置
			end
			n=n+1
		end
		_RGB565to888_Pal(self.Palette16[i],self.Palette32+i,p)
	end
end
function was:炫彩调色(sj1,sj)
	local v = sj1
	local rs = sj
	local n,p = 0
	for i=0,255 do
		if i==self.PalList[n] then--调色板位置
			if v[n+1] and v[n+1]<self.Palette[n].n then
				p=self.Palette[n].p[v[n+1]].Color --方案位置
				if rs[v[n+1]] then
				    if p[0].R ~= 255 and p[1].R ~= 255 and p[1].G ~= 255 and p[2].R ~= 255 then
					  	p[0] = {R=rs[v[n+1]][1].R,G=rs[v[n+1]][1].G,B=rs[v[n+1]][1].B}
					  	p[1] = {R=rs[v[n+1]][2].R,G=rs[v[n+1]][2].G,B=rs[v[n+1]][2].B}
					  	p[2] = {R=rs[v[n+1]][3].R,G=rs[v[n+1]][3].G,B=rs[v[n+1]][3].B}
					end
				else --我加的
					if p[0].R ~= 255 and p[1].R ~= 255 and p[1].G ~= 255 and p[2].R ~= 255 then
					  	p[0] = {R=rs[1][1].R,G=rs[1][1].G,B=rs[1][1].B}
					  	p[1] = {R=rs[2][2].R,G=rs[2][2].R,B=rs[2][2].R}
					  	p[2] = {R=rs[3][3].B,G=rs[3][3].B,B=rs[3][3].B}
					end
				end
			else
				p=self.Palette[n].p[0].Color --方案位置
			end
			n=n+1
		end
		_RGB565to888_Pal(self.Palette16[i],self.Palette32+i,p)
	end
end
function was:恢复调色()
	for i=0,255 do
		_RGB565to888(self.Palette16[i],self.Palette32+i)
	end
end
return was