local mp = require("script/ForYourOwnUse/MessagePack")
local 服务客户端类 = require("script/ForYourOwnUse/PackClient")()
辅助服务端=false
服务客户端类.发送_ = 服务客户端类.发送
function 服务客户端类:发送(...)
    self:发送_(mp.pack{...})
end

function 服务客户端类:连接处理(ip,端口)
  if self:连接(ip,端口) then
  end
end


-- function jjm(数据)
--   数据=encodeBase641(数据)
--   local jg=""
--   for n=1,#数据 do
--     local z=string.sub(数据,n,n)
--     --print(z,key[z],n,#数据)
--     if z~="" then
--       if key[z]==nil then
--         jg=jg..z
--       else
--         jg=jg..key[z]
--       end
--     end
--   end
--   return jg
-- end

-- function jjm1(数据)
--   local jg=数据
--   for n=1,#mab do
--     local z=string.sub(mab,n,n)
--     -- print(key[z],z)
--     if z=="," then print(66) end
--     if key[z]~=nil then
--       jg=string.gsub(jg,key[z],z)
--     end
--   end
--   return decodeBase641(jg)
-- end



function 服务客户端类:发送数据(序号,内容,数组转换)
  if 内容==nil then
    内容="1"
  end
  if 数组转换~=nil then
    内容=table.tostring(内容)
  end
  local 组合数据=序号..fgf..内容..fgf..获取账号
  self:发送(jm(组合数据))

end

function 服务客户端类:连接成功()
 -- print('连接成功')
end

function 服务客户端类:连接断开(so,ec)
  if 系统退出 then
    系统退出=false
    tp.进程 = 1
    引擎.置标题(全局游戏标题)
  else
    f函数.信息框("服务器连接断开!.....")
    引擎.关闭()
  end
end

function 服务客户端类:数据到达(内容)

  data1 = mp.unpack(内容)

  if data1==nil or (data1~=nil and data1[1]==nil) then
   return
  end
  内容=data1[1]
  内容=jm1(内容)
  if 内容==nil or 内容=="" then self:断开() return  end
  local 数据=table.loadstring(内容)

  数据.序号=数据.序号+0

  if 数据.序号==999 then
     f函数.信息框(数据.内容,"下线通知")
    self:断开()
    return
  end
  数据交总控处理(数据.序号,数据.内容)
end

function 服务客户端类:更新(dt) end
function 服务客户端类:初始化() end
function 服务客户端类:显示(x,y) end
return 服务客户端类