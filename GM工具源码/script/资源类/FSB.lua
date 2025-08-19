--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2019-08-31 18:25:57
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local ffi   = require("ffi")
local _cast   = ffi.cast
local _sizeof = ffi.sizeof
local _string = ffi.string
local _band   = bit.band
local _bor    = bit.bor
local _lshift = bit.lshift
ffi.cdef[[

]]
local FMOD = require("Fmod类")
local fsb = class(FMOD)

function 创建音效(id)
    return FMOD类3.创建(系统参数.目录.."sound.wdf",1,sound:取偏移(id),2565224)
end

function 创建音乐(id)
    return FMOD类2.创建("wdf/music.wdf",2,music:取偏移(id))
end

function fsb:初始化(数据,长度,根)
    if 数据 == nil then
        tp = 根
        return
    end
    local head = _cast("FSB4_HEADER*",数据)
    self.List = {}
    if head.flag == 0x34425346 then--FSB4
        self.Data = self._data
        local list = _cast("FSB4_LIST*",self.Data+_sizeof("FSB4_HEADER"))
        local offset = _sizeof("FSB4_HEADER")+head.shdrsize
        for i=0,head.Number-1 do
            self.List[i+1] = {
                off      = self.Data+offset,
                len      = list[i].clen,
                wav      = _band(list[i].mode,0x00000200) == 0,--非mp3
                deffreq  = list[i].deffreq,--采样
                channels = list[i].channels--通道
            }
            self.List[_string(list[i].name)]=self.List[i+1]
            offset=offset+list[i].clen
        end
    end
end

function fsb:播放(重复,id,声音大小)
    id = id or 1
    if self.List==nil then return 0 end
    if self.List[id] then
        if self.List[id].wav then
            local head = _cast("uint32_t*",self.List[id].off)
            head[0] = 0x46464952 -- RIFF
            head[1] = self.List[id].len-8--wavlen
            head[2] = 0x45564157 --WAVE
            head[3] = 0x20746d66 --fmt\32
            head[4] = 16--len
            head[5] = _bor(_lshift(self.List[id].channels, 16),1)
            head[6] = self.List[id].deffreq--44100
            head[7] = self.List[id].deffreq*self.List[id].channels*2
            head[8] = _bor(0x100000,self.List[id].channels*2)
            head[9] = 0x61746164 --data
            head[10] = self.List[id].len-44--datalen
        end
        self:打开(self.List[id].off,self.List[id].len)
    end
    self:运行父函数(FMOD,"播放",重复)
    self:运行父函数(FMOD,"置音量",tp.系统设置.声音设置[2])
    return self
end



return fsb