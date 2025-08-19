require("gge函数")
require("script/全局/自己_专用")--引用头
f函数=require("ffi函数2")
wdf配置 = "wdf"
程序目录=取当前目录()..[[\]]
全局游戏宽度 = 360
全局游戏高度 = 233
function 读入文件(fileName)
    local f = assert(io.open(fileName,'r'))
    local content = f:read('*all')
    f:close()
    return content
end
键盘符号={
    左键=0x00,
    中键=0x02,
    右键=0x01,
    退格=0x08,
    回车=0x0D,
    空格=0x20,
    tab=0x9,
    左=0x25,
    上=0x26,
    右=0x27,
    下=0x28
}

kemy={}
mab = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/*=.，'
key={["B"]="Cb,",["S"]="3C,",["5"]="6D,",["D"]="2W,",["c"]="dc,",["E"]="cj,",["b"]="vt,",["3"]="Iv,",["s"]="j1,",["N"]="23,",["d"]="mP,",["6"]="wd,",["7"]="7R,",["e"]="ET,",["t"]="nB,",["8"]="9v,",["4"]="yP,",["W"]="j6,",["9"]="Wa,",["H"]="D2,",["G"]="Ve,",["g"]="JA,",["I"]="Au,",["X"]="NR,",["m"]="DG,",["w"]="Cx,",["Y"]="Qi,",["V"]="es,",["F"]="pF,",["z"]="CO,",["K"]="XC,",["f"]="aW,",["J"]="DT,",["x"]="S9,",["y"]="xi,",["v"]="My,",["L"]="PW,",["u"]="Aa,",["k"]="Yx,",["M"]="qL,",["j"]="ab,",["r"]="fN,",["q"]="0W,",["T"]="de,",["l"]="P8,",["0"]="q6,",["n"]="Hu,",["O"]="A2,",["1"]="VP,",["i"]="hY,",["h"]="Uc,",["C"]="cK,",["A"]="f4,",["P"]="is,",["U"]="u2,",["o"]="m9,",["Q"]="vd,",["R"]="gZ,",["2"]="Zu,",["Z"]="Pf,",["a"]="Lq,",["p"]="Sw,"}

function jm(数据)
  数据=encodeBase641(数据)
  local jg=""
  for n=1,#数据 do
    local z=string.sub(数据,n,n)
    if z~="" then
      if key[z]==nil then
        jg=jg..z
      else
        jg=jg..key[z]
      end
    end
  end
  return jg
end

function jm1(数据)
  local jg=数据
  for n=1,#mab do
    local z=string.sub(mab,n,n)
    if key[z]~=nil then
       jg=string.gsub(jg,key[z],z)
    end
  end
  return decodeBase641(jg)
end




fgf="12345*-*12345"
fgc="12345@+@12345"
获取账号 =""
-------------
function 发送数据(id,内容)
  if 内容==nil then 内容={} end
  客户端:发送数据(id,内容,1)
end


function 数据交总控处理(序号,内容)


  if 序号==1 then
    tp.进程 = 1
    tp.登陆=nil
    引擎.置宽高(800, 500)
    全局游戏宽度 = 800
    全局游戏高度 = 500
  elseif 序号==7 then
    tp.提示:写入(内容)
  elseif 序号==8 then
    tp.功能界面:刷新(内容)
  elseif 序号==9 then
    tp.功能界面:监控加入(内容)
  elseif 序号==10 then
    tp.功能界面:角色信息嵌入(内容)
  elseif 序号==11 then
    tp.功能界面:召唤兽信息获取(内容)
  elseif 序号==12 then
    tp.功能界面:道具加入(内容)
  elseif 序号==13 then
   获取账号=内容
 elseif 序号==14 then
    tp.功能界面:坐骑信息获取(内容)


  elseif 序号==999 then
    f函数.信息框(内容,"下线通知")
    引擎.关闭()
  elseif 序号==998 then
    f函数.信息框(内容,"下线通知")
    引擎.关闭()
  end

end




 引擎("梦江南超级GM工具",360,233,60,true)
版本 = 1.2
yq = 引擎
 时间 = 0
yq.场景 = require("script/全局/主控")()

yq.垂直同步(true)
tp = yq.场景
鼠标={x=0,y=0}
local xrks = yq.渲染开始
local xrqc = yq.渲染清除
local xrjs = yq.渲染结束
local jc = false
local s时间,上次时间=0,0
function 客户端连接断开()
end

function 渲染函数(dt,x,y)--鼠标x,鼠标y

	if 连接状态==false and 重连开始 and 停止连接==false then
		停止连接 = true
		--客户端:重新连接()
	end
    s时间=os.time()
  if s时间-上次时间>=1 then
      时间=s时间
    上次时间=os.time()
  end

  	全局dt=dt
  	鼠标.x,鼠标.y=x,y
	xrks()
	xrqc()
  	if tp~=nil then
    	tp:显示(dt,x,y)
  	elseif tp==nil and yq~=nil and yq.场景~=nil then
    	tp = yq.场景
  	end
  	xrjs()
end

function 时间转换(时间)
  return  "["..os.date("%m", 时间).."月"..os.date("%d", 时间).."日 "..os.date("%X", 时间).."]"
end

function 引擎关闭开始()
	引擎.关闭()
end

function 取年月日(时间)
  return  os.date("%Y",时间).."年"..os.date("%m",时间).."月"..os.date("%d",时间).."日"
end



















