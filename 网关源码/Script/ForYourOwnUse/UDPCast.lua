-- @Author: baidwwy
-- @Date:   2017-08-22 19:07:39
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2020-06-22 11:43:43


local UdpCast   = class(require"script/ForYourOwnUse/Client")
UdpCast._mode   = 'udp'
UdpCast._new  = require("luahp.client")
function UdpCast:初始化()
    self._hp = self._new(__gge.cs,__gge.state)
    self._hp:Create_UdpCast(self)
end

function UdpCast:OnReceive(pData)--数据到达
    if self.数据到达 then
        __gge.safecall(self.数据到达,self,pData)
    end
    return 0
end
--"233.0.0.1"
function UdpCast:连接(ip,port,async,bind)--地址，端口，异步
    return self._hp:Start(ip,port,async and 1 or 0,bind or "0.0.0.0") ==1
end
function UdpCast:发送(Data)
    return self._hp:SendPack(Data)==1
end
--/* 设置数据报文最大长度（建议在局域网环境下不超过 1472 字节，在广域网环境下不超过 548 字节） */
function UdpCast:置数据最大长度(dwMaxDatagramSize)
    self._hp:SetMaxDatagramSize(dwMaxDatagramSize)
end
--/* 设置是否启用地址重用机制（默认：不启用） */
function UdpCast:置地址重用(bReuseAddress)
    self._hp:SetReuseAddress(bReuseAddress and 1 or 0)
end
--/* 获取数据报文最大长度 */
function UdpCast:取数据最大长度()
    return self._hp:GetMaxDatagramSize()
end
--  /* 检测是否启用地址重用机制 */
function UdpCast:是否地址重用()
    return self._hp:IsReuseAddress()==1
end
--  /* 设置传播模式（组播或广播） */
    -- CM_MULTICAST = 0,    // 组播
    -- CM_BROADCAST = 1,    // 广播
function UdpCast:置传播模式(enCastMode)
    self._hp:SetCastMode(enCastMode)
end
--  /* 获取传播模式 */
function UdpCast:取传播模式()
    return self._hp:GetCastMode()
end
--  /* 设置组播报文的 TTL（0 - 255） */
function UdpCast:置组播TTL(iMCTtl)
    self._hp:SetMultiCastTtl(iMCTtl)
end
--  /* 获取组播报文的 TTL */
function UdpCast:取组播TTL()
    return self._hp:GetMultiCastTtl()
end
--  /* 设置是否启用组播环路（TRUE or FALSE） */
function UdpCast:置组播环路(bMCLoop)
    self._hp:SetMultiCastLoop(bMCLoop and 1 or 0)
end
--  /* 检测是否启用组播环路 */
function UdpCast:是否组播环路()
    return self._hp:IsMultiCastLoop()==1
end
--  /* 获取当前数据报的远程地址信息（通常在 OnReceive 事件中调用） */
function UdpCast:取远程地址()
    return unpack(self._hp:GetRemoteAddress())
end
return UdpCast