-- @Author: baidwwy
-- @Date:   2017-08-22 19:07:39
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2023-06-07 12:10:06

local TcpServer = class(require"Script/服务网络/Socket")
TcpServer._mode = 'push'
TcpServer._new  = require("luahp.server")
function TcpServer:初始化()
	if self._mode == 'push' then
		self._hp = self._new(__gge.cs,__gge.state)
		self._hp:Create_TcpServer(self)
	end
end
--准备监听通知
function TcpServer:OnPrepareListen(soListen)--启动成功
    if self.启动成功 then
        return __gge.safecall(self.启动成功,self,soListen) or 0
    end
    return 1
end
--接收连接通知
function TcpServer:OnAccept(dwConnID,soClient)--连接进入
    local ip,port= unpack(self._hp:GetRemoteAddress(dwConnID))
    if self.连接进入 then
        return __gge.safecall(self.连接进入,self,dwConnID,ip,port) or 0
    end
    return 1
end
--已发送数据通知
function TcpServer:OnSend(dwConnID,pData,iLength)--发送事件
    return 0
end
--通信错误通知
-- typedef enum EnSocketOperation
-- {
--     SO_UNKNOWN  = 0,    // Unknown
--     SO_ACCEPT   = 1,    // Acccept
--     SO_CONNECT  = 2,    // Connect
--     SO_SEND     = 3,    // Send
--     SO_RECEIVE  = 4,    // Receive
--     SO_CLOSE    = 5,    // Close
-- } En_HP_SocketOperation;
function TcpServer:OnClose(dwConnID,enOperation,iErrorCode)--连接退出
    if self.连接退出 then
        return __gge.safecall(self.连接退出,self,dwConnID,enOperation,iErrorCode) or 0
    end
    return 1
end
--关闭通信组件通知
function TcpServer:OnShutdown()
    return 1
end
function TcpServer:OnReceive(dwConnID,pData,iLength)--数据到达
    if  self.数据到达 then
        __gge.safecall(self.数据到达,self,dwConnID,pData,iLength)
    end
	return 1
end
function TcpServer:发送(dwConnID,指针,长度,偏移)
    return self._hp:Send(dwConnID,指针,长度,偏移 or 0)==1
end
function TcpServer:启动(ip,port)--IServer
	if self._hp:Start(ip,port) == 0 then
		return false
	end
	return true
end
--/* 获取监听 Socket 的地址信息 */
function TcpServer:取监听地址()--IServer
	return self._hp:GetListenAddress()
end
--向指定连接发送 4096 KB 以下的小文件
function TcpServer:发送小文件(dwConnID,lpszFileName,pHead,pTail)
	return self._hp:SendSmallFile(dwConnID,lpszFileName,pHead,pTail)
end
--	/* 设置 Accept 预投递数量（根据负载调整设置，Accept 预投递数量越大则支持的并发连接请求越多） */
function TcpServer:置预投递数量(v)
	self._hp:SetAcceptSocketCount(v)
	return self
end
--	/* 设置通信数据缓冲区大小（根据平均通信数据包大小调整设置，通常设置为 1024 的倍数） */
function TcpServer:置缓冲区大小(v)
	self._hp:SetSocketBufferSize(v)
	return self
end
--	/* 设置监听 Socket 的等候队列大小（根据并发连接数量调整设置） */
function TcpServer:置等候队列大小(v)
	self._hp:SetSocketListenQueue(v)
	return self
end
--	/* 设置心跳包间隔（毫秒，0 则不发送心跳包） */
function TcpServer:置正常心跳间隔(v)
	self._hp:SetKeepAliveTime(v)
	return self
end
--	/* 设置心跳确认包检测间隔（毫秒，0 不发送心跳包，如果超过若干次 [默认：WinXP 5 次, Win7 10 次] 检测不到心跳确认包则认为已断线） */
function TcpServer:置异常心跳间隔(v)
	self._hp:SetKeepAliveInterval(v)
	return self
end
--	/* 获取 Accept 预投递数量 */
function TcpServer:取预投递数量()
	return self._hp:GetAcceptSocketCount()
end
--	/* 获取通信数据缓冲区大小 */
function TcpServer:取缓冲区大小()
	return self._hp:GetSocketBufferSize()
end
--	/* 获取监听 Socket 的等候队列大小 */
function TcpServer:取等候队列大小()
	return self._hp:GetSocketListenQueue()
end
--	/* 获取正常心跳包间隔 */
function TcpServer:取正常心跳间隔()
	return self._hp:GetKeepAliveTime()
end
--	/* 获取异常心跳包间隔 */
function TcpServer:取异常心跳间隔()
	return self._hp:GetKeepAliveInterval()
end

return TcpServer