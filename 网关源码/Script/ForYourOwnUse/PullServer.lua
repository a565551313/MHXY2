-- @Author: baidwwy
-- @Date:   2017-08-22 19:07:39
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2020-06-22 11:43:42

local PullServer = class(require"script/ForYourOwnUse/TcpServer")
PullServer._mode = 'pull'
PullServer._new  = require("luahp.server")
function PullServer:初始化()
    self._hp = self._new(__gge.cs,__gge.state)
    self._hp:Create_TcpPullServer(self)
    self._sendbuf   = require("ggebuf")()
    self._recbuf    = require("ggebuf")()
    self._info    = {}
end
function PullServer:置收发BUF(a,b)
    self._sendbuf   = b
    self._recbuf    = a
    return self
end
function PullServer:发送(dwConnID,...)
    local buf,len = self._sendbuf:添加数据(...)
    return self._hp:Send(dwConnID,buf,len,0)==1
end
function TcpServer:OnAccept(dwConnID,soClient)--连接进入
    local ip,port = unpack(self._hp:GetRemoteAddress(dwConnID))
    self._info[dwConnID] = {
        ishead = true,
        len    = self._recbuf and self._recbuf:取头长() or 0,
        ip     = ip,
        port   = port
    }
    if self.连接进入 then
        return __gge.safecall(self.连接进入,self,dwConnID,ip,port) or 0
    end
    return 1
end
function PullServer:OnReceive(dwConnID,iLength)--数据到达
    local required  = self._info[dwConnID].len
    local remain    = iLength
    while remain >= required do
        remain = remain -required --剩余数据长度
        local FR_OK = self._hp:Fetch(dwConnID,self._recbuf:取指针(),required)
        if FR_OK == 0 then
            if self._info[dwConnID].ishead then--是否是包头
                required = self._recbuf:校验头(self._info[dwConnID]) --获取包体长度
                if required == 0 then --非法数据
                    return 2
                end
            else
                if self.数据到达 then
                    __gge.safecall(self.数据到达,self,dwConnID,
                        unpack(self._recbuf:取数据(self._info[dwConnID])))
                end
                required = self._recbuf:取头长()--获取包头长度
            end
            self._info[dwConnID].ishead   = not self._info[dwConnID].ishead
            self._info[dwConnID].len      = required
        else
            --error('获取失败')
            break
        end
    end

    return 0
end

return PullServer