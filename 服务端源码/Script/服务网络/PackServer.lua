--======================================================================--
-- @作者: baidwwy@vip.qq.com(313738139) 老毕
-- 单机GGE研究群: 34211 9466 (如果要研究商业 那请勿进!)
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-06-07 12:10:02
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解梦幻西游所有资源
--======================================================================--
local ffi = require("ffi")
local __hpserver = require("__ggehpserver__")
local PackServer = class(require"Script/服务网络/TcpServer")
PackServer._mode = 'pack'
PackServer._new  = require("luahp.server")
function PackServer:初始化(t,网向)
    self._hp = self._new(__gge.cs,__gge.state)
    self._hp:Create_TcpPackServer(self)
    self._title         = t or ''
    self._网向          = 网向 or ''
    -- __gge.print(false,15,"-------------------------------------------------------------------------\n")
    -- __gge.print(true,7,string.format("创建%s-->", self._title))
    -- __gge.print(false,10,"【成功】！\n")
    -- __gge.print(false,15,"-------------------------------------------------------------------------\n")
    local Flag = 0
    for i,v in ipairs{string.byte("GGELUA_FLAG", 1, 11)} do
        Flag = Flag+v
    end
    self._hp:SetPackHeaderFlag(Flag)
end

function PackServer:启动(ip,port)
    __gge.print(false,10,"-------------------------------------------------------------------------\n")
    __gge.print(true,10,string.format('启动[%s]服务端："%s:%s"', self._title,ip,port))
    if self._hp:Start(ip,port) == 0 then
        __gge.print(false,12," 【失败】！\n")
        return false
    end
    return true
end

function PackServer:OnPrepareListen(soListen)--启动成功
   __gge.print(false,10," 【成功】！"..self._网向.."\n")
   __gge.print(false,10,"-------------------------------------------------------------------------\n")
    __gge.print(false,7,"工作线程数量:")
    __gge.print(false,11,self:取工作线程数量())
    __gge.print(false,7,"|并发请求数量:")
    __gge.print(false,11,self:取预投递数量())
    __gge.print(false,7,"|缓冲区大小:")
    __gge.print(false,11,self:取缓冲区大小().."\n")
    -- __gge.print(false,7,"|等候队列大小:")
    -- __gge.print(false,11,self:取等候队列大小().."\n")
     __gge.print(false,10,"-------------------------------------------------------------------------\n")
    if self.启动成功 then
        return __gge.safecall(self.启动成功,self)
    end
    return 0
end

function PackServer:置标题(str)
    ffi.C.SetConsoleTitleA(str)
    return self
end

function PackServer:OnReceive(dwConnID,pData)--数据到达
    if self.数据到达 then
        __gge.safecall(self.数据到达,self,dwConnID,pData)
    end
    return 0
end
function PackServer:发送(dwConnID,Data)
    assert(#Data<4194303, '数据过长！')
    return self._hp:SendPack(dwConnID,Data)==1
end
--/* 设置数据包最大长度（有效数据包最大长度不能超过 4194303/0x3FFFFF 字节，默认：262144/0x40000） */
function PackServer:置数据最大长度(dwMaxPackSize)
    self._hp:SetMaxPackSize(dwMaxPackSize)
end
--/* 设置包头标识（有效包头标识取值范围 0 ~ 1023/0x3FF，当包头标识为 0 时不校验包头，默认：0） */
function PackServer:置包头标识(usPackHeaderFlag)
    assert(usPackHeaderFlag<1023, message)
    self._hp:SetPackHeaderFlag(usPackHeaderFlag)
end
--/* 获取数据包最大长度 */
function PackServer:取数据包最大长度()
    return self._hp:GetMaxPackSize()
end
--/* 获取包头标识 */
function PackServer:取包头标识()
    return self._hp:GetPackHeaderFlag()
end

function PackServer:输出(str)
    __gge.print(true,7,str.."\n")
end

return PackServer