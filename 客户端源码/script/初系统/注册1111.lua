--======================================================================--
--	☆ 作者：飞蛾扑火 QQ：1415559882
--======================================================================--
local 场景类_注册 = class()
local tp
local mouseb = 引擎.鼠标按下
function 场景类_注册:初始化(根)
	local 资源 = 根.资源
	local 按钮 = 根._按钮
	local 滑块 = 根._滑块
	local 自适应 = 根._自适应
	self.标题背景 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xD8632D2D)
	self.上一步 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0xD8632D29),0,0,3,true,true)
	self.确定游戏 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0xD8632D2C),0,0,3,true,true)
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
	self.确定密码输入框 = 总控件:创建输入("密码确定",0,0,200,14,根)
	self.确定密码输入框:置可视(true,true)
	self.确定密码输入框:置限制字数(12)
	self.确定密码输入框:置光标颜色(4294967295)
	self.确定密码输入框:置文字颜色(4294967295)
	self.确定密码输入框:置密码模式()
  	self.事件 = false
	self.焦点 = false
	self.开启 = false
	self.编号 = 编号
	self.双击 = nil
	self.时间 = 0
	self.账号输入焦点 = false
	self.密码输入焦点 = false
	self.置坐标 = false
end

function 场景类_注册:显示(dt,x,y)

	引擎.置新标题(全局游戏标题.."- 注册")
	self.标题背景:显示(全局游戏宽度/2-250+35,全局游戏高度/2-180)
	self.账号输入框:置坐标(全局游戏宽度/2-140+35,全局游戏高度/2-130+45)
	self.密码输入框:置坐标(全局游戏宽度/2-140+35,全局游戏高度/2-104+50+18)
	self.确定密码输入框:置坐标(全局游戏宽度/2-140+35,全局游戏高度/2-78+50+42)
	self.控件类:更新(dt,x,y)
	self.控件类:显示(x,y)
	--self.上一步:更新(x,y)
	self.确定游戏:更新(x,y)
	if 引擎.按键弹起(键盘符号.tab) then
	    if self.账号输入焦点 then
	      self.账号输入框:置焦点(false)
	      self.密码输入框:置焦点(true)
	      self.确定密码输入框:置焦点(false)
	      self.账号输入焦点 = false
	      self.密码输入焦点 = true
	      self.确定密码输入焦点 = false
	    elseif self.密码输入焦点 then
	      self.密码输入框:置焦点(false)
	      self.确定密码输入框:置焦点(true)
	      self.账号输入框:置焦点(false)
	      self.账号输入焦点 = false
	      self.密码输入焦点 = false
	      self.确定密码输入焦点 = true
	    elseif self.确定密码输入焦点 then
	      self.密码输入框:置焦点(false)
	      self.确定密码输入框:置焦点(false)
	      self.账号输入框:置焦点(true)
	      self.账号输入焦点 = true
	      self.密码输入焦点 = false
	      self.确定密码输入焦点 = false
	    else
	      self.账号输入框:置焦点(true)
	      self.账号输入焦点 = true
	    end
	  end
	-- if self.上一步:事件判断() then
	-- 	tp.进程 = 7
	-- else
	if self.确定游戏:事件判断() then
		if self.账号输入框:取文本()=="" or self.密码输入框:取文本()=="" or self.确定密码输入框:取文本()=="" then
	        tp.常规提示:打开("#Y/请先输入账号或密码或确认密码")
	        return 0
	    elseif #self.账号输入框:取文本() <7 or #self.密码输入框:取文本() <6 or #self.确定密码输入框:取文本() <6  then
		    tp.常规提示:打开("#Y/账号或密码或确认密码格式不正确")
		    return 0
	    elseif self.密码输入框:取文本() ~= self.确定密码输入框:取文本() then
	    	tp.常规提示:打开("#Y/请检查密码与确认密码是否一致")
	      	return 0
	    else
			系统参数.账号=self.账号输入框:取文本()
		    系统参数.密码=self.密码输入框:取文本()
		    f函数.写配置(程序目录.."config.ini","mhxy","账号",系统参数.账号)
		    f函数.写配置(程序目录.."config.ini","mhxy","密码",系统参数.密码)
		    客户端:请求服务(34,版本..fgc..系统参数.账号..fgc..系统参数.密码..fgc..版本)
		end
	end
	--self.上一步:显示(全局游戏宽度/2-150+82,全局游戏高度-145)
	self.确定游戏:显示(全局游戏宽度/2-150+82,全局游戏高度/2+50+18)
end

return 场景类_注册