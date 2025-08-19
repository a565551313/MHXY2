
format = string.format
random = math.random
-- 封包加密=require("Script/封包加密")
处理类=require("Script/客户处理类").创建()
f函数=require("ffi函数")
require("lfs")
require("Script/common/common")
localmp =nil
localmp = require("script/ForYourOwnUse/MessagePack")
客户端类=require("script/ForYourOwnUse/数据服务端")

__S服务 = require("script/ForYourOwnUse/PackServer")('服务')
__S服务.发送_ = __S服务.发送
function __S服务:发送(id,...)
  --self:发送_(id,jm(localmp.pack{...}))
  self:发送_(id,localmp.pack{...})
end
-- and and  and  and  and  and  and  if if if if if if if
__S服务:置标题("网关")

fgf="12345*-*12345"
fgc="12345@+@12345"

版本号是=645448950
网关参数={}
代码函数=loadstring(读入文件([[配置文件.txt]]))
代码函数()
-- 网关参数.启动ip="175.155.66.35"
-- 网关参数.启动端口=9079
-- 网关参数.连接ip="175.155.66.35"
-- 网关参数.连接端口=9088
-- 网关参数.记录开关=1
-- 网关参数.每秒数量=5
-- 网关参数.版本号=1.2
-- 网关参数.当前连接数=0
-- 网关参数.最大连接数=500
-- 网关参数.登录等待=300
-- 网关参数.收发阻断=false
-- 网关参数.是否多线=0
--计时器
已连接服务端=0
--上次时间=os.time()
心跳检测=os.time()
重复清理=os.time()
断开重连=os.time()
DOS检测=os.time()
统计人数=os.time()
启动时间=os.time()
登陆记录={}
__计次信息={}
CC封禁={}
连接次数={}


__S服务:启动(网关参数.启动ip,网关参数.启动端口)
 __S服务:置标题(网关参数.名称.."网关")
f函数 = require("ffi函数")
程序目录=取当前目录().."/"
local __N连接数 	= 0
__C客户信息 	= {}

__S服务:置工作线程数量(500)
__S服务:置预投递数量(5000)


function 取连接数()
  local 数量=0
  for n, v in pairs(__C客户信息) do
    数量=数量+1
  end
  return 数量
end

function __S服务:启动成功()
	return 0
end

function __S服务:连接进入(ID,IP,PORT)

 if CC封禁[IP] then return end
  if 连接次数[IP]==nil then
     连接次数[IP] = 0
  end
  if os.time()-启动时间>20 then
     连接次数[IP] = 连接次数[IP] + 1
  end
  if 连接次数[IP]>=30 then
     CC封禁[IP]=true
  end
 if f函数.读配置(程序目录 .. "ip封禁.ini", "ip", IP)=="1" or f函数.读配置(程序目录 .. "ip封禁.ini", "ip", IP)==1 then
      __S服务:输出(string.format("封禁ip的客户进入试图进入(%s):%s:%s", ID, IP, PORT))
      CC封禁[IP]=true
      处理类:发送数据(ID,7,"您的已被禁止登陆!")
      return 0
  end
if 网关参数.当前连接数 < 网关参数.最大连接数  then
    __S服务:输出(string.format('客户进入(%s):%s:%s',ID, IP,PORT))
    网关参数.当前连接数=网关参数.当前连接数+1
     __C客户信息[ID] = {
      IP = IP,
      PORT = PORT,
      sj=os.time(),
      id=ID,
      数字id=nil,
      key=nil,
      jb=1, --1未登录  2登录成功
      认证=1, --1未验证 2验证成功
      异常尝试数=0, --用于防CC
      心跳验证=os.time() --用于心跳验证
    }
     处理类:连接处理(__C客户信息[ID])
     客户端类:更新连接数()
  else
    __S服务:断开连接(ID)
    客户端类:更新连接数()
  end
end





function __S服务:连接退出(ID)
	if __C客户信息[ID] then
	   __S服务:输出(string.format('客户退出(%s):%s:%s', ID,__C客户信息[ID].IP,__C客户信息[ID].PORT))
	    处理类:断开处理(__C客户信息[ID])
      -- 网关参数.当前连接数=网关参数.当前连接数-1
      __C客户信息[ID]=nil
      客户端类:更新连接数()
	else
		--__S服务:输出("连接不存在(连接退出)。")
	end
  collectgarbage("collect")
end

function __S服务:数据到达(ID,...)

  local arg = localmp.unpack(...)

  if __C客户信息[ID] then
      __计次信息[ID]=(__计次信息[ID] or 0)+1
      处理类:数据处理(ID,arg[1])
  else

  end
end

function __S服务:错误事件(ID,EO,IE)
	if __C客户信息[ID] then
	    __S服务:输出(string.format('错误事件(%s):%s,%s:%s', ID,__错误[EO] or EO,__C客户信息[ID].IP,__C客户信息[ID].PORT))
	else
		__S服务:输出("连接不存在(错误事件)。")
	end
end

function DOS检测循环()
    for c,z in pairs(__计次信息) do
      if __计次信息[c]~=nil  then
        local num1 = __计次信息[c]
          if num1 > 200 then
            __S服务:断开连接(c)
          --  保存语句1=保存语句..时间转换(os.time())..'-'.."连接ID:"..c..",在2秒内总计发送了"..num1.."次请求".."\n"
            __S服务:输出(时间转换(os.time())..'-'.."连接ID:"..c..",在2秒内总计发送了"..num1.."次数据,已断开连接")
          end
      end
    end
    __计次信息 = {}
end


function 心跳循环检测()
        登陆记录={}
        for n,v in pairs(__C客户信息) do
            if __C客户信息[n]~=nil  then
                if os.time()-v.心跳验证 >= 30 and v.认证~=2 then
                   __S服务:断开连接(v.id)
                else
                    处理类:发送数据(n,76541,{时间=os.time(),服务状态=已连接服务端})  --每2秒给客户端发送一个时间做为认证使用
                    if v.认证==2 then
                        if 连接次数[v.IP] then
                            连接次数[v.IP] = 0
                        end
                        if CC封禁[v.IP] then
                            CC封禁[v.IP] = nil
                        end
                    end
                    if 登陆记录[v.IP]==nil then
                       登陆记录[v.IP] = 1
                    end
                end
            end
        end
        if os.time()-统计人数>=1800 then
            local 实际人数 = 0
            for k,v in pairs(登陆记录) do
                  实际人数 = 实际人数 +1
            end
            __S服务:置标题(网关参数.名称.."网关 - 当前在线人数:"..网关参数.当前连接数.."实际人数:"..实际人数)
            统计人数=os.time()
        end
end


--主Runable接口
function 发送服务断开()
   for n,v in pairs(__C客户信息) do
      if __C客户信息[n]~=nil  then
        处理类:发送数据(n,76543)  --每2秒给客户端发送一个时间做为认证使用
      end
   end
end
function 循环函数()---=================屏蔽向客户端发送时间

  --给客户端发送心跳检测
  if os.time()-心跳检测>=10 then
    心跳循环检测()
    心跳检测=os.time()
  end
  --与服务器的断线重连
  if os.time()-断开重连>=5 then
    if 已连接服务端==0 then
      __S服务:输出("未连接到服务器，尝试重连...")
      发送服务断开()
      客户端类:断开重连()
    end
    断开重连=os.time()
  end

  --DOS/CC攻击检测
  if os.time()-DOS检测>=2 then
    DOS检测循环()
    DOS检测=os.time()
  end



end

function 常规提示(id,内容)
  __S服务:发送(id,7,"#Y/"..内容)
end
function 输入函数(t)
  if t=="@QKCC" then
     CC封禁 ={}
  end
end
function 退出函数() end


客户端类:连接处理()

