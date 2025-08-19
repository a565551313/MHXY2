-- @Author: baidwwy
-- @Date:   2018-04-05 23:03:57
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2020-06-22 11:43:42

local PullAgent = class(require"script/ForYourOwnUse/TcpAgent")
PullAgent._mode = 'pull'
PullAgent._new  = require("luahp.agent")

function PullAgent:初始化()
    self._hp = self._new(__gge.cs,__gge.state)
    self._hp:Create_TcpPullAgent(self)
    self._sendbuf   = require("ggebuf")()
    self._recbuf    = require("ggebuf")()
    self._client    = {}
end

function PullAgent:置收发BUF(a,b)
    self._sendbuf   = b
    self._recbuf    = a
    return self
end
function PullAgent:发送(dwConnID,...)
    local 指针,长度 = self._sendbuf:添加数据(...)
    return self._hp:Send(dwConnID,指针,长度,0)==1
end
function TcpServer:OnPrepareConnect(dwConnID,socket)--准备连接
    self._client[dwConnID] = {
        ishead = true,
        len    = self._recbuf and self._recbuf:取头长() or 0
    }
    return 1
end
function PullAgent:OnReceive(dwConnID,iLength)--数据到达
    local required  = self._client[dwConnID].len
    local remain    = iLength
    while remain >= required do
        remain = remain -required --剩余数据长度
        local FR_OK = self._hp:Fetch(dwConnID,self._recbuf:取指针(),required)
        if FR_OK == 0 then
            if self._client[dwConnID].ishead then--是否是包头
                required = self._recbuf:校验头(self._client[dwConnID]) --获取包体长度
                if required == 0 then --非法数据
                    return 2
                end
            else
                if self.数据到达 then
                    __gge.safecall(self.数据到达,self,dwConnID,
                        unpack(self._recbuf:取数据(self._client[dwConnID])))
                end
                required = self._recbuf:取头长()--获取包头长度
            end
            self._client[dwConnID].ishead   = not self._client[dwConnID].ishead
            self._client[dwConnID].len      = required
        else
            --error('获取失败')
            break
        end
    end

    return 0
end

return PullAgent