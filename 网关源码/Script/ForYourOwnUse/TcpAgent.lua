-- @Author: baidwwy
-- @Date:   2017-08-22 19:07:39
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2020-06-22 11:43:43


local TcpAgent = class(require"script/ForYourOwnUse/Socket")
TcpAgent._mode = 'push'
TcpAgent._new  = require("luahp.agent")
function TcpAgent:初始化()
    if self._mode == 'push' then
        self._hp = self._new(__gge.cs,__gge.state)
        self._hp:Create_TcpAgent(self)
    end
end
--准备连接
function TcpAgent:OnPrepareConnect(dwConnID,socket)
    if self.准备连接 then
        return __gge.safecall(self.准备连接,self,dwConnID,socket) or 0
    end
    return 1
end
--连接完成
function TcpAgent:OnConnect(dwConnID)
    if self.连接成功 then
        return __gge.safecall(self.连接成功,self,dwConnID) or 0
    end
    return 1
end
--关闭服务
function TcpAgent:OnShutdown()

    return 1
end
--已发送数据通知
function TcpAgent:OnSend(dwConnID,pData,iLength)
    if self.发送事件 then
        return __gge.safecall(self.发送事件,self,dwConnID,pData,iLength) or 0
    end
    return 1
end
--通信错误通知
local EnSocketOperation={
    [0]='UNKNOWN'  , --   // Unknown
    [1]='ACCEPT'   , --   // Acccept
    [2]='CONNECT'  , --   // Connect
    [3]='SEND'     , --   // Send
    [4]='RECEIVE'  , --   // Receive
    [5]='CLOSE'    , --   // Close
}
function TcpAgent:OnClose(enOperation,iErrorCode)
    if self.连接断开 then
        return __gge.safecall(self.连接断开,self,EnSocketOperation[enOperation],iErrorCode) or 0
    end
    return 1
end
--数据到达通知
function TcpAgent:OnReceive(dwConnID,pData,iLength)
    if self.数据到达 then
        __gge.safecall(self.数据到达,self,dwConnID,pData,iLength)
        return 0
    end
    return 1
end
function TcpAgent:启动(ip,async)
    if self._hp:Start(ip,async) == 0 then
        return false
    end
    return true
end
function TcpAgent:连接(ip,port)
    if self._hp:Connect(ip,port) == 0 then
        return false
    end
    return true
end
--/* 设置是否启用地址重用机制（默认：不启用） */
function TcpAgent:置地址重用(bReuseAddress)
    self._hp:SetReuseAddress(bReuseAddress and 1 or 0)
end
--  /* 检测是否启用地址重用机制 */
function TcpAgent:是否地址重用()
    return self._hp:IsReuseAddress()==1
end
--  /* 设置通信数据缓冲区大小（根据平均通信数据包大小调整设置，通常设置为 1024 的倍数） */
function TcpAgent:置缓冲区大小(v)
    self._hp:SetSocketBufferSize(v)
    return self
end
--  /* 设置心跳包间隔（毫秒，0 则不发送心跳包） */
function TcpAgent:置正常心跳间隔(v)
    self._hp:SetKeepAliveTime(v)
    return self
end
--  /* 设置心跳确认包检测间隔（毫秒，0 不发送心跳包，如果超过若干次 [默认：WinXP 5 次, Win7 10 次] 检测不到心跳确认包则认为已断线） */
function TcpAgent:置异常心跳间隔(v)
    self._hp:SetKeepAliveInterval(v)
    return self
end
--  /* 获取通信数据缓冲区大小 */
function TcpAgent:取缓冲区大小()
    return self._hp:GetSocketBufferSize()
end
--  /* 获取正常心跳包间隔 */
function TcpAgent:取正常心跳间隔()
    return self._hp:GetKeepAliveTime()
end
--  /* 获取异常心跳包间隔 */
function TcpAgent:取异常心跳间隔()
    return self._hp:GetKeepAliveInterval()
end
return TcpAgent