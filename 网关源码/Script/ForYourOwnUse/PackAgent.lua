-- @Author: baidwwy
-- @Date:   2018-04-05 17:07:50
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2020-06-22 12:05:02
local ffi = require("ffi")
local __hpserver = require("__ggehpserver__")

local PackAgent = class(require"script/ForYourOwnUse/TcpAgent")
PackAgent._mode = 'pack'
PackAgent._new  = require("luahp.agent")

function PackAgent:初始化(t)
    self._hp = self._new(__gge.cs,__gge.state)
    self._hp:Create_TcpPackAgent(self)
     self._title     = t or ''
    -- __gge.print(false,15,"-------------------------------------------------------------------------\n")
    -- __gge.print(true,15,string.format("创建%s-->", self._title))
    -- __gge.print(false,10,"【成功】！\n")
    -- __gge.print(false,15,"-------------------------------------------------------------------------\n")
    local Flag = 0
    for i,v in ipairs{string.byte("GGELUA_FLAG", 1, 11)} do
        Flag = Flag+v
    end
    self._hp:SetPackHeaderFlag(Flag)
end

function PackAgent:启动(ip,async)
    -- __gge.print(false,15,"-------------------------------------------------------------------------\n")
    -- __gge.print(true,15,string.format('启动%s-->', self._title))
    if  not self._hp:Start(ip,async) then
        -- __gge.print(false,12,"【失败】！\n")
        return false
    end
    -- __gge.print(false,10,"【成功】！\n")
    return true
end

function PackAgent:连接(ip,port,t)
    -- __gge.print(false,15,"-------------------------------------------------------------------------\n")
    __gge.print(true,15,string.format('启动[%s]服务端："%s:%s"',  t or self._title,ip,port))
    if not self._hp:Connect(ip,port) then
        __gge.print(false,12," 【失败】！\n")
        return false
    else
        __gge.print(false,10," 【成功】！\n")
    end
    return true
end


function PackAgent:OnReceive(dwConnID,pData)--数据到达
    if self.数据到达 then
        __gge.safecall(self.数据到达,self,dwConnID,pData)
    end
    return 0
end
function PackAgent:发送(dwConnID,Data)
    assert(#Data<4194303, '数据过长！')
    return self._hp:SendPack(dwConnID,Data)==1
end

--/* 设置数据包最大长度（有效数据包最大长度不能超过 4194303/0x3FFFFF 字节，默认：262144/0x40000） */
function PackAgent:置数据最大长度(dwMaxPackSize)
    self._hp:SetMaxPackSize(dwMaxPackSize)
end
--/* 设置包头标识（有效包头标识取值范围 0 ~ 1023/0x3FF，当包头标识为 0 时不校验包头，默认：0） */
function PackAgent:置包头标识(usPackHeaderFlag)
    assert(usPackHeaderFlag<1023, message)
    self._hp:SetPackHeaderFlag(usPackHeaderFlag)
end
--/* 获取数据包最大长度 */
function PackAgent:取数据包最大长度()
    return self._hp:GetMaxPackSize()
end
--/* 获取包头标识 */
function PackAgent:取包头标识()
    return self._hp:GetPackHeaderFlag()
end

return PackAgent