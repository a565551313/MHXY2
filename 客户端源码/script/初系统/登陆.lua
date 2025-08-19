--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-14 01:12:20
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 登录类 = class()
local tp
local 包围盒 = require("gge包围盒")

function 登录类:初始化(根)
	  local 资源 = 根.资源
    self.标题背景 = 资源:载入('界面修复.wdf',"网易WDF动画",0xabcde003)
    self.场景覆盖 = 资源:载入('界面修复.wdf',"网易WDF动画",0xEB3FD8C3)
    self.场景计次 = self.场景覆盖.宽度
    self.场景覆盖:置区域(self.场景计次,0,全局游戏宽度,全局游戏高度)
    self.标题背景公告 = 根._按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0xD8632D23),0,0,3,true,true)
    self.特效覆盖 = 资源:载入('界面修复.wdf',"网易WDF动画",0xEC1A0419)
    self.特效计次 = self.特效覆盖.宽度
    self.特效覆盖:置区域(self.特效计次,0,全局游戏宽度,全局游戏高度)

  local dh = {0xDC739617,0x22E6E35C,0x16CC1B46,0xD8632D20}
    self.动画 = {}
  for n=1,4 do
      self.动画[n] = 资源:载入('登陆资源.wdf',"网易WDF动画",dh[n])
  end
 -- self.登录背景 =资源:载入('界面修复.wdf',"网易WDF动画",0xabcde001)
  self.登录背景 =资源:载入(wdf配置.."/pic/账号背景.png", "图片")
 -- self.梦幻LOGO = 资源:载入('界面修复.wdf',"网易WDF动画",0x00010006)
  self.梦幻LOGO = 资源:载入(wdf配置.."/pic/logo.png", "图片")
	self.注册账号 = 根._按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0xD8632D2C),0,0,3,true,true)
	self.上一步 = 根._按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0xD8632D29),0,0,3,true,true)
	self.下一步 = 根._按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0xD8632D21),0,0,3,true,true)
  self.账号下拉 = 根._按钮(资源:载入('other1.wdf',"网易WDF动画",0x00000033),0,0,3,true,true)
  --self.账号选框 = 根._小型选项栏.创建(自适应.创建(105,1,189,160,3,9),"")
  self.账号背景 = 根._自适应.创建(6,1,189,130,3,9)
  self.清除账号={}
  for i=1,6 do
    self.清除账号[i]= 根._按钮(资源:载入('UI.wdf',"网易WDF动画",0x00000001),0,0,3,true,true)
  end



	tp = 根
	self.背景图片={}

	self.背景图片[3]=资源:载入('登陆资源.wdf',"网易WDF动画",0Xd8632d2b)



	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('创建控件')
	总控件:置可视(true,true)
	self.账号输入框 = 总控件:创建输入("账号输入",0,0,160,14,根)
	self.账号输入框:置可视(false,false)
	self.账号输入框:置限制字数(12)
	self.账号输入框:置光标颜色(4294967295)
	self.账号输入框:置文字颜色(4294967295)
	self.账号输入框:置文本("账号输入")
	self.密码输入框 = 总控件:创建输入("密码输入",0,0,200,14,根)

	self.密码输入框:置可视(false,false)
	self.密码输入框:置限制字数(12)
	self.密码输入框:置光标颜色(4294967295)
	self.密码输入框:置文字颜色(4294967295)
	self.密码输入框:置密码模式()
	self.账号输入框:置文本(f函数.读配置(程序目录.."config.ini","mhxy","账号"))
	self.密码输入框:置文本(f函数.读配置(程序目录.."config.ini","mhxy","密码"))
  self.加载账号 = {}
  self.账号包围={}
  self.显示账号 = false
  self.选中账号 = 0

  for i=1,6 do
      local 账号信息=f函数.读配置(程序目录.."config.ini","mhxy","账号"..i)
      local 密码信息=f函数.读配置(程序目录.."config.ini","mhxy","密码"..i)
      if 账号信息 and 账号信息~="空" and 账号信息~=""
         and 密码信息 and 密码信息~="空" and 密码信息~="" then
         self.加载账号[i]={账号=tostring(账号信息),密码=tostring(密码信息)}
      end
      self.账号包围[i]=包围盒(0,0,160,20)
  end



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

function 登录类:更新(dt)

    if self.i ~= nil then
  self.i = self.i +1.5
  if self.i >100 then
      self.i = 1
  end
  渐进加载界面_进度条:置位置(self.i)
  if self.i==91 then
    self.i=nil
      tp.进程=1
      渐进加载界面_进度条:置可视(false)
  end
end

end

function 登录类:显示(dt,x,y)
   self.标题背景:置区域(self.特效计次,0,全局游戏宽度,全局游戏高度)
    self.标题背景:显示(0,-200)
  self.场景计次 = self.场景计次 - 0.3
  self.场景覆盖:置区域(self.场景计次,0,全局游戏宽度,全局游戏高度)
   self.场景覆盖:显示(0,550)
  for n=1,4 do
    self.动画[n]:更新(dt)
      self.动画[n]:显示(全局游戏宽度-600 + (n-1) *110,全局游戏高度-100)
  end
  if self.特效覆盖 ~= nil then
    self.特效计次 = self.特效计次 - 0.7
    self.特效覆盖:置区域(self.特效计次,0,全局游戏宽度,全局游戏高度)
    self.特效覆盖:显示(0,全局游戏高度)
  end



  引擎.置标题(全局游戏标题.."- 登陆")


 -- self.登录背景:显示(全局游戏宽度/2-170,全局游戏高度/2-110)
   self.登录背景:显示(全局游戏宽度/2-180,全局游戏高度/2-180+60)
  -- self.密码输入框:置坐标(全局游戏宽度/2-30,全局游戏高度/2-42+60)
  -- self.账号输入框:置坐标(全局游戏宽度/2-30,全局游戏高度/2-92+60)
  self.密码输入框:置坐标(全局游戏宽度/2-85,全局游戏高度/2-42+60)
  self.账号输入框:置坐标(全局游戏宽度/2-85,全局游戏高度/2-90+60)
  --self.背景图片[3]:显示(全局游戏宽度/2-120,全局游戏高度/2-180+130)
  self.控件类:更新(dt,x,y)
  self.控件类:显示(x,y)
  self.上一步:更新(x,y)
  self.下一步:更新(x,y)

  --self.梦幻LOGO:显示(全局游戏宽度/2-140,全局游戏高度/2-215)
  --self.梦幻LOGO:显示(全局游戏宽度/2-140,全局游戏高度/2-240)
  self.梦幻LOGO:显示(全局游戏宽度/2-120,全局游戏高度/2-10-230)
  -- self.上一步:显示(全局游戏宽度/2-130,全局游戏高度/2-10+70)
  -- self.下一步:显示(全局游戏宽度/2+50,全局游戏高度/2-10+70)
  self.上一步:显示(全局游戏宽度/2-145,全局游戏高度/2-10+130)
  self.下一步:显示(全局游戏宽度/2+30,全局游戏高度/2-10+130)
  self.注册账号:更新(x,y)
  self.注册账号:显示(全局游戏宽度-130,全局游戏高度-50)
  self.账号下拉:更新(x,y)
  self.账号下拉:显示(全局游戏宽度/2+71,全局游戏高度/2-36)
  if self.账号下拉:事件判断() then
      self.选中账号 = 0
      if self.显示账号 then
          self.显示账号=false
      else
          self.显示账号= true
          if self.账号输入框:取文本() and self.账号输入框:取文本()~="" then
              for k,v in pairs(self.加载账号) do
                  if self.账号输入框:取文本()==v.账号 then
                      self.选中账号 = k
                  end
              end
          end
      end
  end
  local yy = 0
  if self.显示账号 then
      tp.鼠标.还原鼠标()
      self.账号背景:显示(全局游戏宽度/2-89,全局游戏高度/2-10)
      for i=1,6 do
          if self.加载账号[i] then
              local zx,zy = 全局游戏宽度/2-85,全局游戏高度/2-5+yy*20
              self.账号包围[i]:置坐标(zx,zy)
              self.清除账号[i]:更新(x,y)
              self.清除账号[i]:显示(zx+163,zy)
              if self.选中账号~=0 and self.选中账号==i then
                  引擎.画矩形(zx-2,zy-2,zx+160,zy+18,0xff1E90FF)
              end
              if self.账号包围[i]:检查点(x,y) then
                  引擎.画矩形(zx-2,zy-2,zx+160,zy+18,0xFFFFFF00)
                  if 引擎.鼠标弹起(0) then
                      self.显示账号=false
                      self.账号输入框:置文本(self.加载账号[i].账号)
                      self.密码输入框:置文本(self.加载账号[i].密码)
                  end

              end
              zts:显示(zx,zy,self.加载账号[i].账号)
              if self.清除账号[i]:事件判断() then
                  self.加载账号[i]=nil
                  f函数.写配置(程序目录.."config.ini","mhxy","账号"..i,"")
                    f函数.写配置(程序目录.."config.ini","mhxy","密码"..i,"")
                    if self.选中账号~=0 and self.选中账号==i then
                              self.账号输入框:置文本("")
                              self.密码输入框:置文本("")
                    end
              end
              yy=yy+1
          end
      end
  end




  if 引擎.按键弹起(键盘符号.tab) then
        self.显示账号=false
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
      tp.进程 = 1
      系统退出=true
      客户端:断开(1)
      self.显示账号=false
  elseif self.下一步:事件判断() then
        self.显示账号=false
        if not 服务状态 then
           tp.常规提示:打开("#Y/连接断开请检查网络")
          return 0
        elseif self.账号输入框:取文本()=="" or self.密码输入框:取文本()=="" then
          tp.常规提示:打开("#Y/请先输入账号或密码")
          return 0
        elseif #self.账号输入框:取文本() <6 or #self.密码输入框:取文本() <6  then
          tp.常规提示:打开("#Y/账号或密码格式不正确")
          return 0

        else
            系统参数.账号=self.账号输入框:取文本()
            系统参数.密码=self.密码输入框:取文本()
            local 查找不同 =0
            local 查找相同 = 0
            for i=1,6 do
                if not self.加载账号[i]then
                      查找不同=i
                      break
                elseif self.加载账号[i].账号==系统参数.账号 and self.加载账号[i].密码~=系统参数.密码 then
                        查找不同=i
                        break
                elseif self.加载账号[i].账号==系统参数.账号 and self.加载账号[i].密码==系统参数.密码 then
                        查找相同=i
                        break
                end
            end
            if 查找相同==0 and 查找不同~=0 then
                    self.加载账号[查找不同]={账号=系统参数.账号,密码=系统参数.密码}
                    f函数.写配置(程序目录.."config.ini","mhxy","账号"..查找不同,系统参数.账号)
                    f函数.写配置(程序目录.."config.ini","mhxy","密码"..查找不同,系统参数.密码)
            elseif 查找相同==0 and 查找不同==0 then
                    self.加载账号[1]={账号=系统参数.账号,密码=系统参数.密码}
                    f函数.写配置(程序目录.."config.ini","mhxy","账号1",系统参数.账号)
                    f函数.写配置(程序目录.."config.ini","mhxy","密码1",系统参数.密码)
            end
            f函数.写配置(程序目录.."config.ini","mhxy","账号",系统参数.账号)
            f函数.写配置(程序目录.."config.ini","mhxy","密码",系统参数.密码)
            客户端:请求服务(1,版本..fgc..系统参数.账号..fgc..系统参数.密码..fgc..版本)
        end
  elseif self.注册账号:事件判断() then
          self.显示账号=false
          tp.进程 = 5
  end
end

return 登录类