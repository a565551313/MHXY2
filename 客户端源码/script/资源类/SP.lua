--require("script/txt2wpal")
local ffi     = require("ffi")
local _bor    = bit.bor
local _lshift = bit.lshift
local _rshift = bit.rshift
local _band   = bit.band
local _copy   = ffi.copy
local _cast   = ffi.cast
local _new    = ffi.new

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


function 取染色方案(id)
    for k,v in pairs(染色信息) do
        if v.id == id then
            return {v.方案[1],v.方案[2],0,0}
        end
    end
     return {1,0,0,0}
    -- body
end

local function _SetAlpha(p32,alpha)
    return _bor(_band(p32,0xFFFFFF),_lshift(alpha,24))
end

local was = class()
local wls = require("gge纹理类")
local kwl = wls():空白纹理()

function was:初始化(路径,长度) --新版本修改本脚本直接替换
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
    self.缓存 = setmetatable({}, {__mode = 'v'})
    self.colorlen = nil
    -- self.HLen = head.HLen+4
    -- self.Palette16 = _cast("uint16_t*",self.Data+self.HLen)
    -- self.Palette32 = _new('int32_t[?]',256)
    -- self.Number = head.Group*head.Frame;
    -- self.FrameList = _cast("uint32_t*",self.Data+self.HLen+512);
    -- for i=0,255 do
    --  if i < self.Number and self.FrameList[i]>0 then
    --      self.FrameList[i] = self.FrameList[i]+self.HLen
    --  end
    --  _RGB565to888(self.Palette16[i],self.Palette32+i,255)
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


function was:取纹理(id,p32)
    local Frameofs = self.FrameList[id]
    if id < self.Number and Frameofs>0 then
        local pData     = self.Data
        local Frame     = _cast("FRAME*",pData+Frameofs)
        local FrameLine = _cast("uint32_t*",pData+(Frameofs+16));
        if Frame.Width>0 and Frame.Height>0 then
            local t   = wls():空白纹理(Frame.Width,Frame.Height)
            local buf = _cast('int32_t*',t:锁定())
            local PixelLen = Frame.Width
            local Palette32 = p32 or self.Palette32
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
                        --  rp=rp+2
                        -- else
                        --  for i=1,Repeat do
                        --      if pos<poslen+1 then
                        --          pos=pos+1
                        --      else break
                        --      end
                        --  end
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

-- function was:置调色板(路径)
--     apply_txt_to_wpal(路径)
--     self.wpal = __gge.readfile(路径)
--     self.wData = _cast("uint32_t*",self.wpal)
--      if self.wData[0] == 1635017060 or 1818325111 then
--         local num = self.wData[1]
--         self.PalList = self.wData+2--调色板位置列表
--         self.Palette = {}--方案
--         self.wData = self.wData+(3+num)
--         for i=0,num-1 do
--             self.Palette[i] = {n=self.wData[0],p=_cast("PalProgram*",self.wData+1)}
--             self.wData = self.wData+(1+self.wData[0]*9)
--         end
--     else
--         error("文件错误！")
--     end
--     return self
-- end

function was:置调色板(路径,编号)
    self.wpal = __gge.readfile(路径)
    self.wData = _cast("uint32_t*",self.wpal)
    if self.wData[0] == 0x6C617077 or self.wData[0] == 0x6E6C7377 then
        local num = self.wData[1]
        self.PalList = self.wData+2--调色板位置列表
        self.Palette = {}--方案
        if 编号 == 1 then
            self.PalList[1] =57
            self.PalList[2] =112
            self.PalList[3] =172
        elseif 编号 == 201 then
            self.PalList[1] =45
            self.PalList[2] =81
            self.PalList[3] =181
        elseif  编号 == 202 then
            self.PalList[1] =50
            self.PalList[2] =166
            self.PalList[3] =206
        elseif 编号 == 203 then
            self.PalList[1] =40
            self.PalList[2] =126
            self.PalList[3] =206
        elseif  编号 == 7  then
            self.PalList[1] =40
            self.PalList[2] =130
            self.PalList[3] =191
        elseif  编号 == 3 then
            self.PalList[1] =55
            self.PalList[2] =104
            self.PalList[3] =186
        elseif  编号 == 5 then
            self.PalList[1] =62
            self.PalList[2] =122
            self.PalList[3] =184
        elseif  编号 == 6 then
            self.PalList[1] =70
            self.PalList[2] =140
            self.PalList[3] =186
        -- elseif  编号 == 8 then --骨精灵染色
        --  print(111)
        --  self.PalList[1] =60
        --  self.PalList[2] =126
        --  self.PalList[3] =186
        elseif  编号 == 9 then
            self.PalList[1] =40
            self.PalList[2] =115
            self.PalList[3] =190
        elseif  编号 == 10 then
            self.PalList[1] =50
            self.PalList[2] =100
            self.PalList[3] =196
        elseif  编号 == 11 then
            self.PalList[1] =66
            self.PalList[2] =146
            self.PalList[3] =186
        elseif  编号 == 12 then
            self.PalList[1] =50
            self.PalList[2] =110
            self.PalList[3] =190
        elseif 编号 == 204 then
            self.PalList[1] =50
            self.PalList[2] =130
            self.PalList[3] =200
        elseif 编号 == 205 then
            self.PalList[1] =50
            self.PalList[2] =136
            self.PalList[3] =201
        elseif  编号 == 206  then
            self.PalList[1] =50
            self.PalList[2] =130
            self.PalList[3] =200
        elseif  编号 == 301  then
            self.PalList[1] =0
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 300  then
            self.PalList[1] =0
            self.PalList[2] =0
            self.PalList[3] =2
        elseif  编号 == 700  then
            self.PalList[1] =0
            self.PalList[2] =0
            self.PalList[3] =2
        elseif  编号 == 701  then
            self.PalList[1] =240
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 702  then
            self.PalList[1] =0
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 703  then
            self.PalList[1] =150
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 704  then
            self.PalList[1] =100
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 705  then
            self.PalList[1] =120
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 706  then
            self.PalList[1] =80
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 707  then
            self.PalList[1] =50
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 708 then
            self.PalList[1] =170
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 709  then
            self.PalList[1] =110
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 710  then
            self.PalList[1] =180
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 711  then
            self.PalList[1] =90
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 712  then
            self.PalList[1] =200
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 713  then
            self.PalList[1] =196
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 714  then
            self.PalList[1] =190
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 715  then
            self.PalList[1] =160
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 716  then
            self.PalList[1] =210
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 717  then
            self.PalList[1] =130
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 718  then
            self.PalList[1] =180
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 719  then
            self.PalList[1] =140
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 720  then
            self.PalList[1] =230
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 721  then
            self.PalList[1] =60
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 722  then
            self.PalList[1] =130
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 722  then
            self.PalList[1] =0
            self.PalList[2] =256
            self.PalList[3] =2
        elseif  编号 == 103  then
            self.PalList[1] =100
            self.PalList[2] =256
            self.PalList[3] =2
            -- for i=0,255 do
            --  print("序号:"..i,_band(_rshift(self.Palette16[i],11),0x1F),_band(_rshift(self.Palette16[i],5),0x3F),_band(self.Palette16[i],0x1F),self.Palette16[i])
            -- end
        end
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

return was