-- @Author: baidwwy
-- @Date:   2017-08-22 19:07:39
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2023-06-07 22:56:22

local PullClient = class(require "script/连接网络/TcpClient")
PullClient._mode = 'pull'
PullClient._new  = require("luahp.client")

function PullClient:初始化()
    self._hp = self._new(__gge.cs,__gge.state)
    self._hp:Create_TcpPullClient(self)
    self._sendbuf = require("ggebuf")()
    self._recbuf  = require("ggebuf")()
end
function PullClient:置收发BUF(a,b)
    self._sendbuf = b
    self._recbuf  = a
    return self
end
function PullClient:发送(...)
    local buf,len = self._sendbuf:添加数据(...)
    assert(len>self._sendbuf:取头长(), "空包")
    return self._hp:Send(buf,len,0) == 1
end
-- typedef enum EnHandleResult
-- {
--     HR_OK       = 0,    // 成功
--     HR_IGNORE   = 1,    // 忽略
--     HR_ERROR    = 2,    // 错误
-- } En_HP_HandleResult;
--准备连接通知
function PullClient:OnPrepareConnect(socket)
    self._info = {
        ishead = true,
        len    = self._recbuf and self._recbuf:取头长() or 0
    }
    return 1
end
function PullClient:OnReceive(iLength)
    local required = self._info.len
    local remain   = iLength
    while remain >= required do
        remain = remain -required --剩余数据长度
        local FR_OK = self._hp:Fetch(self._recbuf:取指针(),required)
        if FR_OK == 0 then
            if self._info.ishead then--是否是包头
                required = self._recbuf:校验头(self._info) --获取包体长度
                if required == 0 then --非法数据
                    return 2 --HR_ERROR会触发OnClose
                end
            else
                if self.数据到达 then
                    __gge.safecall(self.数据到达,self,unpack(self._recbuf:取数据(self._info)))
                end
                required = self._recbuf:取头长()--获取包头长度
            end
            self._info.ishead = not self._info.ishead
            self._info.len    = required
        else
            print("Fetch失败!")
        end
    end
    return 0--HR_OK
end


return PullClient