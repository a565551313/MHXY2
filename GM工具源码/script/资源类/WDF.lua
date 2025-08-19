--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2020-02-19 13:47:58
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local ffi  = require("ffi")
local new  = ffi.new
local wdf  = class()
local 文件 = require("文件类")
local _Ptr = new('char[10485760]')--全局共享内存

function wdf:初始化(路径)
    self.File  = 文件(路径)
    self.List  = {}
    local head = self.File:读入数据(new("WDF_HEADER"))
    local flag = ffi.string(head.Flag,4)
    self.File:移动读写位置(head.Offset,self.File.SEEK_SET)
    self.Clist = self.File:读入数据(new("FILELIST[?]",head.Number))
    for i=0,head.Number-1 do
        self.List[self.Clist[i].Hash] = self.Clist[i]
    end
end

function wdf:读数据(Hash)
    if self.List[Hash] then
        self.File:移动读写位置(self.List[Hash].Offset,self.File.SEEK_SET)
        self.File:读入数据(_Ptr,self.List[Hash].Size)
        return _Ptr,self.List[Hash].Size
    end
end

function wdf:读偏移(Hash)
    if self.List[Hash] then
        return self.List[Hash].Offset,self.List[Hash].Size
    end
end

return wdf