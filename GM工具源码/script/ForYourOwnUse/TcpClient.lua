-- @Author: baidwwy
-- @Date:   2017-08-22 19:07:39
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2020-06-22 18:23:54

local TcpClient = class(require "script/ForYourOwnUse/Client")
TcpClient._mode = 'push'
TcpClient._new  = require("luahp.client")
function TcpClient:初始化()
    if self._mode == 'push' then
        self._hp = self._new(__gge.cs,__gge.state)
        self._hp:Create_TcpClient(self)
    end
end
function TcpClient:OnReceive(pData,iLength)--数据到达
    if  self.数据到达 then
        __gge.safecall(self.数据到达,self,pData,iLength)
    end
    return 1
end
--向指定连接发送 4096 KB 以下的小文件
function TcpClient:发送小文件(dwConnID,lpszFileName,pHead,pTail)
    return self._hp:SendSmallFile(dwConnID,lpszFileName,pHead,pTail)
end
--/* 设置通信数据缓冲区大小（根据平均通信数据包大小调整设置，通常设置为：(N * 1024) - sizeof(TBufferObj)） */
function TcpClient:置缓冲区大小(dwSocketBufferSize)
    self._hp:SetSocketBufferSize(dwSocketBufferSize)
    return self
end
--/* 设置正常心跳包间隔（毫秒，0 则不发送心跳包，默认：30 * 1000） */
function TcpClient:置正常心跳间隔(dwKeepAliveTime)
    self._hp:SetKeepAliveTime(dwKeepAliveTime)
    return self
end
--/* 设置异常心跳包间隔（毫秒，0 不发送心跳包，，默认：10 * 1000，如果超过若干次 [默认：WinXP 5 次, Win7 10 次] 检测不到心跳确认包则认为已断线） */
function TcpClient:置异常心跳间隔(dwKeepAliveInterval)
    self._hp:SetKeepAliveInterval(dwKeepAliveInterval)
    return self
end
--/* 获取通信数据缓冲区大小 */
function TcpClient:取缓冲区大小()
    return self._hp:GetSocketBufferSize()
end
--/* 获取正常心跳包间隔 */
function TcpClient:取正常心跳间隔()
    return self._hp:GetKeepAliveTime()
end
--/* 获取异常心跳包间隔 */
function TcpClient:取异常心跳间隔()
    return self._hp:GetKeepAliveInterval()
end

return TcpClient