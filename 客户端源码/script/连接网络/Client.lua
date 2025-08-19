-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-11-13 10:12:10
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-09-29 04:09:11

local Client = class()

-- function Client:初始化()

-- end

function Client:连接(ip,port,async)--地址，端口，异步
    return self._hp:Start(ip,port,async and 1 or 0) ==1
end
function Client:断开()
    self._hp:Stop()
end
function Client:暂停()
    self._hp:PauseReceive(1)
end
function Client:恢复()
    self._hp:PauseReceive(0)
end
function Client:发送(pBuffer,iLength)
    return self._hp:Send(pBuffer,iLength,0) == 1
end
--向指定连接发送多组数据
function Client:发送_组(pBuffers,iCount)
    self._hp:SendPackets(pBuffers,iCount)
end

--准备连接通知
function Client:OnPrepareConnect(socket)
    return 1
end
--连接完成通知
function Client:OnConnect()
    if self.连接成功 then
        return __gge.safecall(self.连接成功,self) or 0
    end
    return 1
end
--已发送数据通知
function Client:OnSend(pData,iLength)
    if self.发送事件 then
        return __gge.safecall(self.发送事件,self) or 0
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
function Client:OnClose(enOperation,iErrorCode)
    if self.连接断开 then
        return __gge.safecall(self.连接断开,self,enOperation,iErrorCode) or 0
    end

    客户端连接断开()
    return 1
end

--数据到达通知
function Client:OnReceive()
    return 1
end
--===============================================
function Client:是否连接()
    return self._hp:HasStarted() ==1
end
-- enum EnServiceState
-- {
--  SS_STARTING = 0,    // 正在启动
--  SS_STARTED  = 1,    // 已经启动
--  SS_STOPPING = 2,    // 正在停止
--  SS_STOPPED  = 3,    // 已经停止
-- };
function Client:取状态()
    return self._hp:GetState()
end
function Client:取错误代码()
    return self._hp:GetLastError()
end
function Client:取错误描述()
    return self._hp:GetLastErrorDesc()
end
--/* 获取该组件对象的连接 ID */
function Client:取连接ID()
    return self._hp:GetConnectionID()
end
--  /* 获取 Client Socket 的地址信息 */
function Client:取本地地址信息()
    return self._hp:GetLocalAddress()
end
--/* 获取连接的远程主机信息 */
function Client:取远程地址信息()
    return self._hp:GetRemoteHost()
end
--/* 获取连接中未发出数据的长度 */
function Client:取未发出数据长度()
    return self._hp:GetPendingDataLength()
end
--/* 获取连接的数据接收状态 */
function Client:是否暂停()
    return self._hp:IsPauseReceive()
end
--/* 设置内存块缓存池大小（通常设置为 -> PUSH 模型：5 - 10；PULL 模型：10 - 20 ） */
function Client:置缓存池大小(dwFreeBufferPoolSize)
    self._hp:SetFreeBufferPoolSize(dwFreeBufferPoolSize)
    return self
end
--/* 设置内存块缓存池回收阀值（通常设置为内存块缓存池大小的 3 倍） */
function Client:置缓存池回收阀值(dwFreeBufferPoolHold)
    self._hp:SetFreeBufferPoolHold(dwFreeBufferPoolHold)
    return self
end
--/* 获取内存块缓存池大小 */
function Client:取缓存池大小()
    return self._hp:GetFreeBufferPoolSize()
end
--/* 获取内存块缓存池回收阀值 */
function Client:取缓存池回收阀值()
    return self._hp:GetFreeBufferPoolHold()
end
return Client