--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-06-16 00:54:32
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 客户端类 = class()
local 回调 = require("script/网络/数据交换")

function 客户端类:初始化()
  self.连接账号=""
  self.连接密码=""
  self.连接结果=false
fgf="12345*-*12345"
fgc="12345@+@12345"
end

function 客户端类:更新(dt)

end

function 请求服务(id,内容)
  if 内容==nil then 内容={} end
  客户端:请求服务(id,内容,1)
end

function 客户端类:请求服务(序号,内容,数组转换)
  回调:请求服务(序号,内容,数组转换)
end

function 客户端类:连接处理(ip,端口,账号,密码)

  self.连接结果=回调:连接(ip,端口)
  if self.连接结果==false then
      tp.常规提示:打开("#R/连接服务器失败，请确认服务器是否在维护中或本机网络出现故障")
  end
  self.连接结果 = false
end

function 客户端类:重新连接()

  if 回调:连接(系统参数.服务器.ip,系统参数.服务器.端口) then
       网关连接 = true
  else
      客户端连接断开()
  end
end

-- function 客户端类:重新连接()
--   if 回调:连接(系统参数.服务器.ip,系统参数.服务器.端口) then
--       当前状态 = true
--       重连=true
--   else
--       停止连接 = false
--   end
-- end


function 客户端类:取状态(连接)
  return self:取状态()
end

function 客户端类:断开(数据)
  回调:断开(数据)
end

function 客户端类:数据到达(序号,内容,时间)

end

return 客户端类

