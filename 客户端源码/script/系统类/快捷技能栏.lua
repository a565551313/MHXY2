--======================================================================--
-- @作者: GGE研究群: 34211 9466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:26:01
--======================================================================--
local 系统类_快捷技能栏 = class()
local tp,zts1
local mouseb = 引擎.鼠标按下
local keyb   = 引擎.按键弹起
local bw     = require("gge包围盒")(650,555,262,31)
local ski    = 引擎.取技能
local gl     = 引擎.置纹理过滤
function 系统类_快捷技能栏:初始化(根)
	local 按钮 = 根._按钮
	local 资源 = 根.资源
	self.格子 = 资源:载入('UI.wdf',"网易WDF动画",0x00000032)
	self.格子选中 = 资源:载入('房屋图标.wdf',"网易WDF动画",0X358A4A58)
	self.锁住 = 按钮.创建(资源:载入('UI.wdf',"网易WDF动画",0X00000035),0,0,4,true)
	self.未锁 = 按钮.创建(资源:载入('UI.wdf',"网易WDF动画",0X00000034),0,0,4,true)
	self.上一页 = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0X72ECBE07),0,0,4,true)--wzife.wdf 0X72ECBE07
	self.下一页 = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0X5B0263AB),0,0,4,true)--'wzife.wdf 0X5B0263AB
	self.小技能格 = 按钮.创建(资源:载入('UI.wdf',"网易WDF动画",0X00000033),0,0,1,true)--
	self.小技能格选中 = 资源:载入('房屋图标.wdf',"网易WDF动画",0XC9B8E681)
	self.上下格子 = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0X382A3975),0,0,4,true)

	tp = 根
	zts1 = 根.字体表.描边字体
	self.图片组 = {}
	self.操作员 = nil
	self.技能格子={}
	local jn = tp._技能格子
	for i=1,24 do
		self.技能格子[i] = jn(0,0,i,"辅助技能")
	end
	self.锁住开关=false
	self.格子数量 = 0
end

function 系统类_快捷技能栏:设置技能(参数,x,y)
	local 选中编号=0
	for i=1,8 do
		self.格子:显示(全局游戏宽度-350+i*33,全局游戏高度-65)
		if self.格子:是否选中(x,y) then
			选中编号=i
		end
	end
	if 选中编号==0 then
		return
	end
	if not self.锁住开关 then
    	tp.常规提示:打开("#Y/请先解锁技能栏按钮")
    	return
	end
	请求服务(11,{位置=选中编号 + self.格子数量,名称=参数.名称,类型=参数.类型})
end

function 系统类_快捷技能栏:刷新(数据,禁止)
	if 禁止==nil then
		tp.快捷技能显示 = not tp.快捷技能显示
	end
	--local 数据={{名称="仙灵店铺"},{名称="横扫千军"},{名称="火眼金睛"},{名称="打坐"},{名称="调息"}}
	if tp.快捷技能显示 then
		for i=1,24 do
			-- print(self.技能格子[i])
			self.技能格子[i]:置技能(数据[i])
			if self.技能格子[i].技能~=nil then
				self.技能格子[i].技能.模型=self.技能格子[i].技能.小模型
			end
			--table.print(self.技能格子[i])
		end
	end
end

function 系统类_快捷技能栏:显示(dt,x,y)
	self.鼠标=false
	if not tp.快捷技能显示 then
		return
	end
	if self.锁住~=nil then
	    self.锁住:更新(x,y)
	end
	self.上一页:更新(x,y,self.格子数量 >= 8)
	self.下一页:更新(x,y,self.格子数量 < 16)
	self.小技能格:显示(全局游戏宽度-349+13-26,全局游戏高度-61)
	if self.锁住:事件判断() then
		if self.锁住开关 then
		    self.锁住开关=false
		    self.锁住 = tp._按钮.创建(tp.资源:载入('UI.wdf',"网易WDF动画",0X00000035),0,0,4,true)--锁
		else
			self.锁住 = tp._按钮.创建(tp.资源:载入('UI.wdf',"网易WDF动画",0X00000034),0,0,4,true)--未锁
			self.锁住开关=true
		end
	elseif self.上一页:事件判断() and self.格子数量 >= 8 then
		self.格子数量 = self.格子数量 - 8
	elseif self.下一页:事件判断() and self.格子数量 < 16 then
		self.格子数量=self.格子数量+8
	end
	if self.锁住~=nil then
	    self.锁住:显示(全局游戏宽度-350+13-22.4,全局游戏高度-58)
	    if self.锁住:是否选中(x,y) then
	    	-- self.小技能格选中:显示(全局游戏宽度-350+13-22.4,全局游戏高度-58)
	    	-- tp.常规提示:打开("#Y/技能框锁!点击解锁方可拖动技能到技能框哦!")
	    	tp.提示:自定义(x,y+37,"#Y/技能框锁!点击解锁方可拖动技能到技能框哦!")
	    end
	end
	self.上下格子:显示(全局游戏宽度-350+14,全局游戏高度-64)
	self.上一页:显示(全局游戏宽度-350+17,全局游戏高度-62)
	self.下一页:显示(全局游戏宽度-350+17,全局游戏高度-48)
	local kj = (self.操作员 or tp.队伍[1]).快捷技能
	kj={名称={"横扫千军"}}
	for i=1,8 do
		self.格子:显示(全局游戏宽度-348+i*33,全局游戏高度-63)
		if self.格子:是否选中(x,y) then
			self.鼠标=true
		end
		self.技能格子[i + self.格子数量]:置坐标(全局游戏宽度-347+i*33+1,全局游戏高度-61)
		self.技能格子[i + self.格子数量]:显示(x,y,self.鼠标)
		zts1:置颜色(0xFFFFFFFF)
		zts1:显示(全局游戏宽度-342+i*33,全局游戏高度-81,"F"..i)
		if self.技能格子[i + self.格子数量].焦点 then
			self.格子选中:显示(全局游戏宽度-350+i*33,全局游戏高度-65)
			tp.提示:技能(x,y,self.技能格子[i + self.格子数量].技能)
			if 引擎.鼠标弹起(右键) then --and self.技能格子[i].技能~=nil then
				if tp.战斗中==false then
					请求服务(13,{序列=i + self.格子数量})
				elseif self.技能格子[i + self.格子数量]~=nil and 战斗类.进程=="命令"  then
					if self:取战斗可用(self.技能格子[i + self.格子数量].技能.名称) then
						战斗类.战斗指令:设置法术参数(self.技能格子[i + self.格子数量])
					else
						tp.常规提示:打开("#Y/该技能无法在战斗中使用")
					end
				end
			end
		end
	end
	local ax = self:快捷焦点按下()
	if ax~=0 then
		if tp.战斗中==false then
			请求服务(13,{序列=ax + self.格子数量})
		elseif self.技能格子[ax + self.格子数量]~=nil and 战斗类.进程=="命令"  then
			if self.技能格子[ax + self.格子数量].技能~=nil and self:取战斗可用(self.技能格子[ax + self.格子数量].技能.名称) then
				战斗类.战斗指令:设置法术参数(self.技能格子[ax + self.格子数量])
			else
				tp.常规提示:打开("#Y/该技能无法在战斗中使用")
			end
		end
	end
end
function 系统类_快捷技能栏:取战斗可用(名称)
	if self:物攻技能(名称) then
		return true
	elseif self:封印技能(名称) then
		return true
	elseif self:增益技能(名称) then
		return true
	elseif self:减益技能(名称) then
		return true
	elseif self:法攻技能(名称) then
		return true
	elseif self:恢复技能(名称) then
		return true
	elseif 名称=="妙手空空" then
		return true
	end
end
function 系统类_快捷技能栏:恢复技能(名称)
	local 临时名称={"无穷妙道","地涌金莲","星月之惠","玉清诀","晶清诀","冰清诀","水清诀","四海升平","命归术","气归术","凝神诀","凝气诀","命疗术","心疗术","气疗术","归元咒","乾天罡气","我佛慈悲","杨柳甘露","推拿","推气过宫","解毒","百毒不侵","宁心","解封","清心","驱魔","驱尸","寡欲令","复苏"}
	for n=1,#临时名称 do
		if 临时名称[n]==名称 then return true end
	end
	return false
end
function 系统类_快捷技能栏:法攻技能(名称)
	local 临时名称={"夺命咒","落叶萧萧","荆棘舞","逍遥游","尘土刃","叱咤风云","天降灵葫","冰川怒","自爆","唧唧歪歪","五雷咒","落雷符","雨落寒沙","五雷轰顶","雷霆万钧","龙卷雨击","龙吟","二龙戏珠","龙腾","苍茫树","靛沧海","日光华","地裂火","巨岩破","三昧真火","飞砂走石","判官令","阎罗令","水攻","烈火","落岩","雷击","泰山压顶","水漫金山","地狱烈火","奔雷咒"}
	for n=1,#临时名称 do
		if 临时名称[n]==名称 then return true end
	end
	return false
end
function 系统类_快捷技能栏:物攻技能(名称)
	local 临时名称={"翻江搅海","惊涛怒","浪涌","天崩地裂","断岳势","裂石","满天花雨","破血狂攻","破碎无双","弱点击破","善恶有报","惊心一剑","壁垒击破","横扫千军","狮搏","象形","连环击","鹰击","烟雨剑法","飘渺式","天雷斩","裂石","断岳势","天崩地裂","浪涌","惊涛怒"}
	for n=1,#临时名称 do
		if 临时名称[n]==名称 then return true end
	end
	return false
end
function 系统类_快捷技能栏:封印技能(名称)
	local 临时名称={"摧心术","惊魂掌","煞气诀","夺魄令","反间之计","催眠符","失心符","落魄符","失忆符","追魂符","离魂符","失魂符","定身符","莲步轻舞","如花解语","似玉生香","娉婷嬝娜","镇妖","错乱","百万神兵","日月乾坤","威慑","含情脉脉","魔音摄魂","夺魄令","惊魂掌","煞气诀"}
	for n=1,#临时名称 do
		if 临时名称[n]==名称 then return true end
	end
	return false
end
function 系统类_快捷技能栏:减益技能(名称)
	local 临时名称={"尸腐毒","紧箍咒","勾魂","摄魄","雾杀"}
	for n=1,#临时名称 do
		if 临时名称[n]==名称 then return true end
	end
	return false
end
function 系统类_快捷技能栏:增益技能(名称)
	local 临时名称={"变身","碎星诀","不动如山","明光宝烛","移魂化骨","蜜润","炎护","后发制人","罗汉金钟","杀气诀","安神诀","分身术","达摩护体","金刚护法","金刚护体","韦陀护法","一苇渡江","佛法无边","楚楚可怜","天神护法","乘风破浪","神龙摆尾","生命之泉","炼气化神","天地同寿","乾坤妙法","普渡众生","灵动九天","幽冥鬼眼","修罗隐身","火甲术","魔王回首","定心术","极度疯狂","魔息术","天魔解体","盘丝阵","幻境术","不动如山","碎星诀","镇魂诀","明光宝烛","金身舍利","炎护","蜜润"}
	for n=1,#临时名称 do
		if 临时名称[n]==名称 then return true end
	end
	return false
end
function 系统类_快捷技能栏:快捷焦点按下()
	if keyb(KEY.F1) then
		return 1
	elseif keyb(KEY.F2) then
		return 2
	elseif keyb(KEY.F3) then
		return 3
	elseif keyb(KEY.F4) then
		return 4
	elseif keyb(KEY.F5) then
		return 5
	elseif keyb(KEY.F6) then
		return 6
	elseif keyb(KEY.F7) then
		return 7
	elseif keyb(KEY.F8) then
		return 8
	end
	return 0
end
function 系统类_快捷技能栏:检查点(x,y)
	return tp.快捷技能显示 and bw:检查点(x,y)
end
return 系统类_快捷技能栏