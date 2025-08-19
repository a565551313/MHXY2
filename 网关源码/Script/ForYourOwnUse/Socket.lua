-- @Author: baidwwy
-- @Date:   2018-04-05 07:23:54
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2018-04-05 23:45:11


--IComplexSocket
local socket = class()
-- function socket:初始化()

-- end

function socket:停止()
    return self._hp:Stop()
end
function socket:暂停(dwConnID)
    self._hp:PauseReceive(dwConnID,1)
end
function socket:恢复(dwConnID)
    self._hp:PauseReceive(dwConnID,0)
end
function socket:发送(dwConnID,pBuffer,iLength,iOffset)
    return self._hp:Send(dwConnID,pBuffer,iLength,iOffset or 0)==1
end
--向指定连接发送多组数据
function socket:发送_组(dwConnID,pBuffers,iCount)
    self._hp:SendPackets(dwConnID,pBuffers,iCount)
end
-- 连接 ID-- 是否强制断开连接
function socket:断开连接(dwConnID,bForce)
    return self._hp:Disconnect(dwConnID,(bForce==nil or bForce) and 1 or 0) ==1
end
-- 时长（毫秒）-- 是否强制断开连接
function socket:断开超时连接(dwPeriod,bForce)
    return self._hp:DisconnectLongConnections(dwPeriod,(bForce==nil or bForce) and 1 or 0) ==1
end
-- 时长（毫秒）-- 是否强制断开连接
function socket:断开静默连接(dwPeriod,bForce)
    return self._hp:DisconnectSilenceConnections(dwPeriod,(bForce==nil or bForce) and 1 or 0) ==1
end
function socket:是否已启动()
    return self._hp:HasStarted() ==1
end
--  /* 查看通信组件当前状态 */
-- enum EnServiceState
-- {
--  SS_STARTING = 0,    // 正在启动
--  SS_STARTED  = 1,    // 已经启动
--  SS_STOPPING = 2,    // 正在停止
--  SS_STOPPED  = 3,    // 已经停止
-- };
function socket:取状态()
    return self._hp:GetState()
end
--  /* 获取连接数 */
function socket:取连接数()
    return self._hp:GetConnectionCount()
end
--/* 获取所有连接的 CONNID */
function socket:取连接ID()
    return self._hp:GetAllConnectionIDs()
end
--  /* 获取某个连接时长（毫秒） */
function socket:取连接时长(dwConnID)
    return self._hp:GetConnectPeriod(dwConnID)
end
--  /* 获取某个连接静默时间（毫秒） */
function socket:取静默时长(dwConnID)
    return self._hp:GetSilencePeriod(dwConnID)
end
--  /* 获取某个连接的本地地址信息 */
function socket:取本地地址信息(dwConnID)
    return self._hp:GetLocalAddress(dwConnID)
end
--/* 获取某个连接的远程地址信息 */
function socket:取远程地址信息(dwConnID)
    return self._hp:GetRemoteAddress(dwConnID)
end
--  /* 获取最近一次失败操作的错误代码 */
function socket:取错误代码()
    return self._hp:GetLastError()
end
--  /* 获取最近一次失败操作的错误描述 */
function socket:取错误描述()
    return self._hp:GetLastErrorDesc()
end
--/* 获取连接中未发出数据的长度 */
function socket:取未发出数据长度(dwConnID)
    return self._hp:GetPendingDataLength(dwConnID)
end
--/* 获取连接的数据接收状态 */
function socket:是否暂停(dwConnID)
    return self._hp:IsPauseReceive(dwConnID)
end

--/* 设置数据发送策略 */
-- enum EnSendPolicy
-- {
--  SP_PACK             = 0,    // 打包模式（默认）
--  SP_SAFE             = 1,    // 安全模式
--  SP_DIRECT           = 2,    // 直接模式
-- };
function socket:置数据发送策略(enSendPolicy)
    self._hp:SetSendPolicy(enSendPolicy)
    return self
end
--  /* 设置最大连接数（组件会根据设置值预分配内存，因此需要根据实际情况设置，不宜过大）*/
function socket:置最大连接数(dwMaxConnectionCount)
    self._hp:SetMaxConnectionCount(dwMaxConnectionCount)
    return self
end
--/* 设置 Socket 缓存对象锁定时间（毫秒，在锁定期间该 Socket 缓存对象不能被获取使用） */
function socket:置缓存对象锁定时间(dwFreeSocketObjLockTime)
    self._hp:SetFreeSocketObjLockTime(dwFreeSocketObjLockTime)
    return self
end
--/* 设置 Socket 缓存池大小（通常设置为平均并发连接数量的 1/3 - 1/2） */
function socket:置Socket缓存池大小(dwFreeSocketObjPool)
    self._hp:SetFreeSocketObjPool(dwFreeSocketObjPool)
    return self
end
--/* 设置内存块缓存池大小（通常设置为 Socket 缓存池大小的 2 - 3 倍） */
function socket:置内存块缓存池大小(dwFreeBufferObjPool)
    self._hp:SetFreeBufferObjPool(dwFreeBufferObjPool)
    return self
end
--/* 设置 Socket 缓存池回收阀值（通常设置为 Socket 缓存池大小的 3 倍） */
function socket:置Socket缓存池回收阀值(dwFreeSocketObjHold)
    self._hp:SetFreeSocketObjHold(dwFreeSocketObjHold)
    return self
end
--/* 设置内存块缓存池回收阀值（通常设置为内存块缓存池大小的 3 倍） */
function socket:置内存块缓存池回收阀值(dwFreeBufferObjHold)
    self._hp:SetFreeBufferObjHold(dwFreeBufferObjHold)
    return self
end
--/* 设置工作线程数量（通常设置为 2 * CPU + 2） */
function socket:置工作线程数量(dwWorkerThreadCount)
    self._hp:SetWorkerThreadCount(dwWorkerThreadCount)
    return self
end
--/* 设置是否标记静默时间（设置为 TRUE 时 DisconnectSilenceConnections() 和 GetSilencePeriod() 才有效，默认：FALSE） */
function socket:置静默时间(bMarkSilence)
    self._hp:SetMarkSilence(bMarkSilence and 1 or 0)
    return self
end


--/* 获取数据发送策略 */
function socket:取数据发送策略()
    return self._hp:GetSendPolicy()
end
--/* 获取最大连接数 */
function socket:取最大连接数()
    return self._hp:GetMaxConnectionCount()
end
--/* 获取 Socket 缓存对象锁定时间 */
function socket:取缓存对象锁定时间()
    return self._hp:GetFreeSocketObjLockTime()
end
--/* 获取 Socket 缓存池大小 */
function socket:取Socket缓存池大小()
    return self._hp:GetFreeSocketObjPool()
end
--/* 获取内存块缓存池大小 */
function socket:取内存块缓存池大小()
    return self._hp:GetFreeBufferObjPool()
end
--/* 获取 Socket 缓存池回收阀值 */
function socket:取Socket缓存池回收阀值()
    return self._hp:GetFreeSocketObjHold()
end
--/* 获取内存块缓存池回收阀值 */
function socket:取内存块缓存池回收阀值()
    return self._hp:GetFreeBufferObjHold()
end
--/* 获取工作线程数量 */
function socket:取工作线程数量()
    return self._hp:GetWorkerThreadCount()
end
--/* 检测是否标记静默时间 */
function socket:是否静默()
    return self._hp:IsMarkSilence()
end

return socket