-- @Author: baidwwy
-- @Date:   2017-08-22 19:07:39
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2020-06-22 11:42:54

local PackClient = class(require"script/ForYourOwnUse/TcpClient")
PackClient._mode = 'pack'
PackClient._new  = require("luahp.client")
function PackClient:初始化()
    self._hp = self._new(__gge.cs,__gge.state)
    self._hp:Create_TcpPackClient(self)
    local Flag = 0
    for i,v in ipairs{string.byte("GGELUA_FLAG", 1, 11)} do
        Flag = Flag+v
    end
    self._hp:SetPackHeaderFlag(Flag)
end

function PackClient:OnReceive(pData)--数据到达
    if self.数据到达 then
        __gge.safecall(self.数据到达,self,pData)
    end
    return 0
end
function PackClient:发送(Data)
    assert(#Data<4194303, '数据过长！')
    self._hp:SendPack(Data)
end
--/* 设置数据包最大长度（有效数据包最大长度不能超过 4194303/0x3FFFFF 字节，默认：262144/0x40000） */
function PackClient:置数据最大长度(dwMaxPackSize)
    self._hp:SetMaxPackSize(dwMaxPackSize)
end
--/* 设置包头标识（有效包头标识取值范围 0 ~ 1023/0x3FF，当包头标识为 0 时不校验包头，默认：0） */
function PackClient:置包头标识(usPackHeaderFlag)
    assert(usPackHeaderFlag<1023, message)
    self._hp:SetPackHeaderFlag(usPackHeaderFlag)
end
--/* 获取数据包最大长度 */
function PackClient:取数据包最大长度()
    return self._hp:GetMaxPackSize()
end
--/* 获取包头标识 */
function PackClient:取包头标识()
    return self._hp:GetPackHeaderFlag()
end


return PackClient