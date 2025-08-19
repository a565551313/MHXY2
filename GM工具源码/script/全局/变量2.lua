local tonumber = tonumber
local setmetatable = setmetatable
local byte = string.byte
local pairs = pairs
local lshift = bit.lshift
local insert = table.insert
local byte = string.byte
local sub = string.sub
local randomseed = math.randomseed
local number = tonumber
local string = tostring
local time = os.time()
local sort = table.sort
local random = math.random
local 是否刷新队伍显示 = 1--########################################################?自己修改?##########################################
--===========系统专用========================
黄色=0xFFFFFF00
黑色=0xFF000000
黄色=0xFFFFFF00
绿色=0xFF00FF00
红色=0xFFFF0000
白色=0xFFFFFFFF
紫色=0xFF6B238E
蓝色=0xFF0000FF
--=============================
function ARGB(a,r,g,b)
	return (lshift(a,24) + lshift(r,16) + lshift(g,8) + b)
end

function 分割字符(str,tv)
	local t = tv or {}
	local i = 1
	local ascii = 0
	while true do
		ascii = byte(str, i)
		if ascii then
			if ascii < 127 then
				insert(t,sub(str, i, i))
				i = i+1
			else
				insert(t,sub(str, i, i+1))
			    i = i+2
			end
		else
		    break
		end
	end
	return t
end

local ffi = require("ffi")
  ffi.cdef[[
    const char* EnCode(const char *qq);
  ]]

function 动态加密(qq)
  if FunModel==nil then
       FunModel = ffi.load("luacl.dll")
   end
   local Web=FunModel.EnCode(qq)
   return ffi.string(Web)
end

local ffi = require("ffi")
  ffi.cdef[[
    const char* MemoryOptimize(const char *qq);
  ]]

function 内存优化(qq)
  if FunModel==nil then
       FunModel = ffi.load("luacl.dll")
   end
   local Web=FunModel.MemoryOptimize(qq)
   --return ffi.string(Web)
end
local ffi = require("ffi")
  ffi.cdef[[
    const char* PackingCheck(const char *qq);
  ]]

function 检测WPE(qq)
  if FunModel==nil then
       FunModel = ffi.load("FunModel.dll")
   end
   local Web=FunModel.PackingCheck(qq)
   --return ffi.string(Web)
end
local ffi = require("ffi")
  ffi.cdef[[
    const char* PackingCheck2(const char *qq);
  ]]

function 检测WPE2(qq)
  if FunModel==nil then
       FunModel = ffi.load("FunModel.dll")
   end
   local Web=FunModel.PackingCheck2(qq)
   --return ffi.string(Web)
end
local ffi = require("ffi")
  ffi.cdef[[
    const char* PackingCheck3(const char *qq);
  ]]

function 检测WPE3(qq)
  if FunModel==nil then
       FunModel = ffi.load("FunModel.dll")
   end
   local Web=FunModel.PackingCheck3(qq)
   --return ffi.string(Web)
end
local ffi = require("ffi")
  ffi.cdef[[
    const char* PackingCheck4(const char *qq);
  ]]

function 检测WPE4(qq)
  if FunModel==nil then
       FunModel = ffi.load("FunModel.dll")
   end
   local Web=FunModel.PackingCheck4(qq)
   --return ffi.string(Web)
end
local ffi = require("ffi")
  ffi.cdef[[
    const char* PackingCheck5(const char *qq);
  ]]

function 检测WPE5(qq)
  if FunModel==nil then
       FunModel = ffi.load("FunModel.dll")
   end
   local Web=FunModel.PackingCheck5(qq)
   --return ffi.string(Web)
end
local ffi = require("ffi")
  ffi.cdef[[
    const char* GetMachine();
  ]]


function random_array(arr)
	randomseed(number(string(time):reverse():sub(1,6)))
    local tmp, index
    for i=1, #arr-1 do
        index = random(i, #arr)
        if i ~= index then
            tmp = arr[index]
            arr[index] = arr[i]
            arr[i] = tmp
        end
    end
    return arr
end

function 生成XY(x,y)
	local f ={}
	f.x = tonumber(x) or 0
	f.y = tonumber(y) or 0
	setmetatable(f,{
	__add = function (a,b)
		return 生成XY(a.x + b.x,a.y + b.y)
	end,
	__sub = function (a,b)
		return 生成XY(a.x - b.x,a.y - b.y)
	end
	})
	return f
end

local xys = 生成XY
local pi = math.pi
local pi2 = pi*2
local sqrt = math.sqrt
local pow = math.pow
local abs = math.abs
local atan = math.atan
local deg = math.deg
local floor = math.floor
local cos = math.cos
local sin = math.sin
local insert = table.insert
local remove = table.remove
local random = 引擎.取随机整数
--########################################################?自己修改?##########################################
with = 引擎.宽度2
hegt = 引擎.高度2
withs = 引擎.宽度
hegts = 引擎.高度
--########################################################?自己修改?##########################################

function 取两点距离(src,dst)
	if src.x==nil then
	    src.x=1
	end
	if src.y==nil then
	    src.y=1
	end
	if dst.x==nil then
	    dst.x=1
	end
	if dst.y==nil then
	    dst.y=1
	end
    return sqrt(pow(src.x-dst.x,2) + pow(src.y-dst.y,2))
end
function 取两点距离a(x,y,x1,y1)
    return sqrt(pow(x-x1,2) + pow(y-y1,2))
end
function 取两点孤度(src,dst)
	if(dst.y ==src.y and dst.x==src.x)then
		return 0
	elseif(dst.y >=src.y and dst.x<=src.x)then
		return pi-abs(atan((dst.y-src.y)/(dst.x-src.x)))
	elseif(dst.y <=src.y and dst.x>=src.x)then
		return pi2-abs(atan((dst.y-src.y)/(dst.x-src.x)))
	elseif(dst.y <=src.y and dst.x<=src.x)then
		return atan((dst.y-src.y)/(dst.x-src.x))+pi

	elseif(dst.y >=src.y and dst.x>=src.x)then
		return atan((dst.y-src.y)/(dst.x-src.x))
	end
end
function 取两点孤度a(x,y,x1,y1)
	if(y1 ==y and x1==x)then
		return 0
	elseif(y1 >=y and x1<=x)then
		return pi-abs(atan((y1-y)/(x1-x)))
	elseif(y1 <=y and x1>=x)then
		return math.pi2-abs(atan((y1-y)/(x1-x)))
	elseif(y1 <=y and x1<=x)then
		return atan((y1-y)/(x1-x))+pi

	elseif(y1 >=y and x1>=x)then
		return atan((y1-y)/(x1-x))
	end
end

function 取两点角度(src,dst)
	return deg(取两点孤度(src,dst))
end
function 取两点角度a(x,y,x1,y1)
	return deg(取两点孤度a(x,y,x1,y1))
end

function 取距离坐标(xy,r,a) --r距离,a孤度
	local x1,y1 = 0,0
	x1=r* cos(a) + xy.x
	y1=r* sin(a) + xy.y
	return xys(floor(x1),floor(y1))
end
function 取距离坐标a(x,y,r,a) --r距离,a孤度
	local x1,y1 = 0,0

	x1=r* cos(a)+x
	y1=r* sin(a)+y
	return floor(x1),floor(y1)
end
function 取移动坐标(src,dst,r)
	local a = 取两点孤度 (src,dst)
	return xys(r* cos(a) +src.x ,r* sin(a)+src.y)
end

function 取画面坐标(x,y,w,h,yd) --人物坐标,地图宽高
	local w2,h2 = with,hegt--窗口宽高的一半
	local rx,ry = 0,0
	if w==nil then
	    w=0
	end
	if h==nil then
	    h=0
	end
	if (x>w2 and x<w-w2) then
		rx = -(x-w2)
	elseif x<=w2 then
		rx=0
	elseif x>=w-w2 then
		rx=-(w-withs)
	end
	if (y>h2 and y<h-h2) then
		ry = -(y-h2)
	elseif y<=h2 then
		ry=0
	elseif y>=h-h2 then
		ry=-(h-hegts)
	end
	if w < withs then
		rx = floor(withs - w)
	end
	if h < hegts then
		ry = floor(hegts - h)
	end
	return xys(rx,ry)
end

function 取画面坐标1(x,y,w,h,sd) --人物坐标,地图宽高
	local w2,h2 = with,hegt--窗口宽高的一半
	local rx,ry = 0,0
	if (x>w2 and x<w-w2) then
		rx = -(x-w2)
	elseif x<=w2 then
		rx=0
	elseif x>=w-w2 then
		rx=-(w-withs)
	end
	if (y>h2 and y<h-h2) then
		ry = -(y-h2)
	elseif y<=h2 then
		ry=0
	elseif y>=h-h2 then
		ry=-(h-hegts)
	end
	if w < withs then
		rx = floor(withs - w)
	end
	if h < hegts then
		ry = floor(hegts - h)
	end
	return xys(rx - sd,ry - sd)
end

function tablefor(table)
	local mfc = {}
	for i=1,#table do
		for j=i+1,#table do
			if(table[i] == table[j]) then
				table[i] = - 1
			end
		end
	end
	k = 1;
	for i=1, #table do
		if (table[k] == -1) then
			remove(table, k);k=k - 1
		end
		k=k+1
	end
	for j=1,#table do
		insert(mfc,table[j])
	end
end

local function chsize(char)
      if not char then
         return 0
     elseif char > 240 then
         return 4
     elseif char > 225 then
         return 3
     elseif char > 192 then
         return 2
     else
         return 1
     end
 end

function 随机表(表,限制)
	if #表 <= 0 then
		return
	end
	local a=表
	local b={}
	限制 = 限制 or 0
	while #a > 限制 do
		local c=random(1,#a)
		insert(b,a[c])
		remove(a,c)
	end
	return 表
end

function 删除重复(key)
	local k;
	for i=1,#key do
		for j=i+1,#key do
			if(key[i] == key[j]) then
				key[i] = - 1
			end
		end
	end
	k = 1;
	for i=1, #key do
		if (key[k] == -1) then
			table.remove(key, k);k=k - 1
		end
		k=k+1
	end
	k = nil;
	return key
end

function 删除重复1(key)
	local b = {}
	for i=1,#key do
		for j=i+1,#key do
			if key[i][1] == key[j][1] and key[i][2] == key[j][2] then
				b = key[i]
				break
			end
		end
	end
	for i=1,#key do
		if key[i][1] ~= b[1] or key[i][2] ~= b[2] then
			key[i] = nil
		end
	end
	local ks = {}
	for i=1,#key do
		if key[i] ~= nil then
			insert(ks,key[i])
		end
	end
	return ks,b
end

function 取文本中间(str, startChar, numChars)
    local startIndex = 1
     while startChar > 1 do
         local char = byte(str, startIndex)
         startIndex = startIndex + chsize(char)
         startChar = startChar - 1
     end

     local currentIndex = startIndex

     while numChars > 0 and currentIndex <= #str do
        local char = byte(str, currentIndex)
        currentIndex = currentIndex + chsize(char)
         numChars = numChars -1
     end
     return str:sub(startIndex, currentIndex - 1)
 end

function 相生相克(a,b)
	local xs = 0 -- 既不相生也不相克 相克 相生
	local sx = {}
	sx["金"] = {[1]="水",[2]="金",[3]={"木","火","土"}}
	sx["水"] = {[1]={"木","金"},[2]="水",[3]={"火","土"}}
	sx["木"] = {[1]={"水","火"},[2]="木",[3]={"金","土"}}
	sx["火"] = {[1]={"金","水"},[2]="火",[3]={"木","土"}}
	sx["土"] = {[1]="火",[2]="土",[3]={"金","水","木"}}
	-- 开始取相生
	if type(sx[a][1]) == "string" then
		if b == sx[a][1] then
			xs = 2
		end
	else
		-- 开始寻找五行
		for n=1,#sx[a][1] do
			if sx[a][1][n] == b then
				xs = 2
			end
		end
	end
	-- 开始取无关
	if b == sx[a][2] then
		xs = 0
	end
	-- 开始取相克
	for i=1,#sx[a][3] do
		if sx[a][3][i] == b then
			xs = 1
		end
	end
	return xs
end

function 取数组内容(table,txt)
	for i,v in pairs(table) do
		if v == txt then
			return true
		end
	end
	return false
end

function 开关取内容(激活,未激活,开关)
	if 开关 then
		return 激活
	end
	return 未激活
end


function 取八方向(角,t)
	local 方向 = 0
	if(角 > 157 and 角 < 203) then
		方向 = 5 --"左"
	elseif(角 >202 and 角 < 248) then
		方向 = 2 --"左上"
	elseif(角 > 247 and 角 < 293) then
		方向 = 6 --"上"
	elseif(角 > 292 and 角 < 338) then
		方向 = 3 --"右上"
	elseif(角 > 337 or 角 < 24 ) then
		方向 = 7        --"右"
	elseif( 角 > 23 and 角 < 69 ) then
		方向 = 0       --"右下"
	elseif(角 > 68 and 角 < 114 )then
		方向 = 4 --"下"
	elseif(角 > 113 ) then
		方向 = 1 --"左下"
	end
	if t then
		方向 = 取四至八方向(方向)
	end
	return 方向
end

function 取四至八方向(d)
	n = 0
	if d == 0 or d == 4 then
		n = 0
	elseif d == 1 or d == 5 then
		n = 1
	elseif d == 2 or d == 6 then
		n = 2
	elseif d == 3 or d == 7 then
		n = 3
	end
	return n
end

function 取四方向(j)
	local f = 0
	if j < 90 then
		f =0
	elseif j<180 then
		f= 1
	elseif j<270 then
		f= 2
	elseif j<360 then
		f= 3
	end
	return f
end