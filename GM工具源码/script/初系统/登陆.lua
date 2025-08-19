--======================================================================--
local 登录类 = class()
local tp
local mouseb = 引擎.鼠标按下

function 登录类:初始化(根)
	local 资源 = 根.资源
	self.上一步 = 根._按钮(资源:载入('gj.wdf',"网易WDF动画",0x00010011),0,0,3,true,true)
	self.下一步 = 根._按钮(资源:载入('gj.wdf',"网易WDF动画",0x00010010),0,0,3,true,true)
  self.背景 = 资源:载入('gj.wdf',"网易WDF动画",0x00010016)
	tp = 根
	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('创建控件')
	总控件:置可视(true,true)
	self.账号输入框 = 总控件:创建输入("账号输入",0,0,240,14,根)
	self.账号输入框:置可视(true,true)
	self.账号输入框:置限制字数(12)
	self.账号输入框:置光标颜色(4294967295)
	self.账号输入框:置文字颜色(4294967295)
	self.密码输入框 = 总控件:创建输入("密码输入",0,0,200,14,根)
	self.密码输入框:置可视(true,true)
	self.密码输入框:置限制字数(12)
	self.密码输入框:置光标颜色(4294967295)
	self.密码输入框:置文字颜色(4294967295)
	self.密码输入框:置密码模式()
	self.账号输入框:置文本(f函数.读配置(程序目录.."config.ini","mhxy","账号"))
	self.密码输入框:置文本(f函数.读配置(程序目录.."config.ini","mhxy","密码"))
  local 端口=f函数.读配置(程序目录.."config.ini","mhxy","端口")
  local 连接ip=f函数.读配置(程序目录.."config.ini","mhxy","连接ip")
  客户端:连接处理(连接ip,端口)
end

function 登录类:显示(dt,x,y)
  self.密码输入框:置坐标(96,135)
  self.账号输入框:置坐标(96,90)
  self.背景:显示(0,0)
  self.控件类:更新(dt,x,y)
  self.控件类:显示(x,y)
  self.上一步:更新(x,y)
  self.下一步:更新(x,y)
  self.上一步:显示(全局游戏宽度/2-130,全局游戏高度/2-10+60)
  self.下一步:显示(全局游戏宽度/2+10,全局游戏高度/2-10+60)
  if 引擎.按键弹起(键盘符号.tab) then
    if self.账号输入焦点 then
      self.账号输入框:置焦点(false)
      self.密码输入框:置焦点(true)
      self.账号输入焦点 = false
      self.密码输入焦点 = true
    elseif self.密码输入焦点 then
      self.密码输入框:置焦点(false)
      self.账号输入框:置焦点(true)
      self.账号输入焦点 = true
      self.密码输入焦点 = false
    else
      self.账号输入框:置焦点(true)
      self.账号输入焦点 = true
    end
  end
  if self.上一步:事件判断() then
    os.exit()
  elseif self.下一步:事件判断() then
    if self.账号输入框:取文本()=="" or self.密码输入框:取文本()=="" then
      tp.提示:写入("#Y/请先输入账号或密码")
      return 0
    elseif #self.账号输入框:取文本() <6 or #self.密码输入框:取文本() <6  then
      tp.提示:写入("#Y/账号或密码格式不正确")
      return 0
    else
        f函数.写配置(程序目录.."config.ini","mhxy","账号",self.账号输入框:取文本())
        f函数.写配置(程序目录.."config.ini","mhxy","密码",self.密码输入框:取文本())
       -- 客户端:发送数据(1.2,版本..fgc..self.账号输入框:取文本()..fgc..self.密码输入框:取文本()..fgc..f函数.取硬盘序列号())
        发送数据(1,{账号=self.账号输入框:取文本(),密码=self.密码输入框:取文本()})
    end
  end
end

return 登录类