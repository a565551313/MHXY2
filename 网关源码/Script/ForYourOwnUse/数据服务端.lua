local mp = require("script/ForYourOwnUse/MessagePack")
local 数据服务端类 = require("script/ForYourOwnUse/PackClient")()

数据服务端类.发送_ = 数据服务端类.发送
function 数据服务端类:发送(...)
    self:发送_(mp.pack{...})
end

function 数据服务端类:断开重连()
  if self:连接(网关参数.连接ip,网关参数.连接端口) then
    __S服务:输出("连接服务端成功！")
    __S服务:置标题(网关参数.名称)
  end
end
function 数据服务端类:连接处理()
  if self:连接(网关参数.连接ip,网关参数.连接端口) then
    __S服务:输出("连接服务端成功！")
    __S服务:置标题(网关参数.名称)

  else
    __S服务:输出("连接服务端失败！")
  end
end

function 数据服务端类:发送数据(id,内容)
  self:发送_(mp.pack{id,内容})
end

function 数据服务端类:连接成功()
    已连接服务端 = 1
    for n,v in pairs(__C客户信息) do
      if __C客户信息[n]~=nil  then
        处理类:断开连接(n)  --重连到服务器时断开所有客户端
      end
    end
    -- print('连接成功')
end

function 数据服务端类:连接断开(so,ec)
    --print('连接断开')
    已连接服务端 = 0
    --要踢出已连接账号
    __S服务:输出("服务端连接已断开！")
end

function 数据服务端类:数据到达(内容)
    data1 = mp.unpack(内容)
    local arg = data1
    local id = arg[1]
    if id==nil then return end
    local 数据=table.loadstring(arg[2])
    if  数据==nil  then
        return
    elseif __C客户信息[id+0]~=nil then
        __C客户信息[id+0].jb=2
        if 数据.序号==-2 then
            __C客户信息[id+0].数字id=数据.内容
            return
        end

        __S服务:发送(id+0,arg[2])

    end
end

function 数据服务端类:更新连接数()
  self:发送数据(1,table.tostring({序号=99997,人数=取连接数()}))
end

function 数据服务端类:更新(dt) end
function 数据服务端类:初始化() end
function 数据服务端类:更新(dt) end
function 数据服务端类:显示(x,y) end
return 数据服务端类