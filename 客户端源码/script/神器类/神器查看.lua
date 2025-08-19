
local 神器查看 = class()
local insert = table.insert
local mouseb = 引擎.鼠标弹起
local mousea = 引擎.鼠标按住
local tp,zt1,zt2,zt3
local 神器属性 = {[1]={},[2]={},[3]={}}
local 技能介绍 = {
		藏锋敛锐 = {[1]= "横扫千军消耗的气血有50%的\n几率转化为等量护盾。",[2]="横扫千军消耗的气血有100%的\n几率转化为等量护盾。"},
		惊锋     = {[1]= "每次攻击提升自身10点伤害，\n最多叠加12层，死亡后清零。",[2]="每次攻击提升自身20点伤害\n，最多叠加12层，死亡后清\n零。"},
		披坚执锐 = {[1]= "遭受攻击时，有4%的几率免受\n90%的伤害。",[2]="遭受攻击时，有8%的几率免受\n90%的伤害。"},
		金汤之固 = {[1]= "气血小于30%时，提升240点抗\n封等级。",[2]="气血小于30%时，提升480点抗\n封等级。"},
		风起云墨 = {[1]= "受到你治疗的首目标本回合内\n受到的所有伤害降低4%。",[2]="受到你治疗的首目标本回合内\n受到的所有伤害降低8%。"},
		挥毫     = {[1]= "受到你的治疗时，目标每带有\n一个增益状态，额外恢复25点气血。",[2]="受到你的治疗时，目标每带有\n一个增益状态，额外恢复50点气血。"},
		盏中晴雪 = {[1]= "若你的速度高于施法者，提升\n速度差×0.5的抗封等级。",[2]="若你的速度高于施法者，提升\n速度差×1的抗封等级。"},
		泪光盈盈 = {[1]= "笑里藏刀额外减少目标6点愤\n怒。",[2]="笑里藏刀额外减少目标12点\n愤怒。"},
		凭虚御风 = {[1]= "每点被消耗的风灵增加40点法\n术伤害结果，最多叠加三层，\n死亡后清零。",[2]="每点被消耗的风灵增加80点法\n术伤害结果，最多叠加三层，\n死亡后清零。"},
		钟灵     = {[1]= "被使用3级药是有一定几率获\n得1层风灵。",[2]="被使用3级药是有较大几率获\n得1层风灵。"},
		亡灵泣语 = {[1]= "你的锢魂术会使得目标额外受\n到5%的物法伤害。",[2]="你的锢魂术会使得目标额外受\n到10%的物法伤害。"},
		魂魇     = {[1]= "被你的物理伤害攻击的单位在\n当回合内的法术伤害结果减少\n100点。",[2]="被你的物理伤害攻击的单位在\n当回合内的法术伤害结果减少\n200点。"},
		业焰明光 = {[1]= "你的法术有25%的几率造\n成额外25%的伤害。",[2]="你的法术有25%的几率造\n成额外50%的伤害。"},
		流火     = {[1]= "攻击气血百分比小于你的单位\n时，增加8%的伤害。",[2]="攻击气血百分比小于你的单位\n时，增加16%的伤害。"},
		蛮血     = {[1]= "增加（1-自身气血/气血上限）\n×8%的狂暴几率。",[2]="增加（1-自身气血/气血上限）\n×16%的狂暴几率。"},
		狂战     = {[1]= "每有一个己方召唤兽被击飞\n，增加30点伤害力，可叠加\n4层，死亡后消失。",[2]="每有一个己方召唤兽被击飞\n，增加60点伤害力，可叠加\n4层，死亡后消失。"},
		镜花水月 = {[1]= "受到治疗时，有8%的几率获\n得一个等额度的护盾。",[2]="受到治疗时，有16%的几率获\n得一个等额度的护盾。"},
		澄明     = {[1]= "每回合结束时，增加3点抵\n抗封印等级。",[2]="每回合结束时，增加6点抵抗\n封印等级。"},
		情思悠悠 = {[1]= "地涌金莲的目标获得治疗量\n10%的护盾。",[2]="地涌金莲的目标获得治疗量\n20%的护盾。"},
		相思     = {[1]= "偶数回合结束时，增加3点\n速度。",[2]="每个回合结束时，增加3点\n速度。"},
		弦外之音 = {[1]= "回合结束时，每个主动法宝\n效果会增加你3点愤怒。",[2]="回合结束时，每个主动法宝\n效果会增加你6点愤怒。"},
		裂帛     = {[1]= "  伤害性法术首目标伤害增加\n  8%。",[2]="  伤害性法术首目标伤害增加\n  16%。"},
		定风波   = {[1]= "受到的法术暴击伤害降低30%。",[2]="受到的法术暴击伤害降低60%。"},
		沧浪赋   = {[1]= "攻击气血小于30%的目标时，\n额外提升120点的法术伤害。",[2]="攻击气血小于30%的目标时，\n额外提升240点的法术伤害。"},
		斗转参横 = {[1]= "带有状态生命之泉时，日月\n乾坤命中率增加3%。",[2]="带有状态生命之泉时，日月\n乾坤命中率增加6%。"},
		静笃     = {[1]= "每次击杀敌方单位，增加60点\n伤害。",[2]= "每次击杀敌方单位，增加120\n点伤害。"},
		玉魄     = {[1]= "消耗愤怒的100%转化为下一次\n释放恢复性技能时的治疗能力。",[2]="消耗愤怒的200%转化为下一次\n释放恢复性技能时的治疗能力。"},
		璇华     = {[1]= "使用五行法术时，增\n加10%的伤害。",[2]="五使用五行法术时，增\n加20%的伤害。"},
		威服天下 = {[1]= "暴击伤害增加12%。",[2]="暴击伤害增加24%。"},
		酣战     = {[1]= "每点消耗的战意，会提升30点\n物理暴击等级，可叠加6次，\n死亡后清零。",[2]="每点消耗的战意，会提升60\n点物理暴击等级，可叠加6次，\n死亡后清零。"},
		万物滋长 = {[1]= "使用特技时将会获得（消耗愤\n怒值×等级×5%）的护盾和\n气血回复。",[2]="使用特技时将会获得（消耗愤\n怒值×等级×10%）的护盾和\n气血回复。"},
		开辟     = {[1]= "每次使用如意神通，提升20点\n自身伤害，最多叠加6层，死\n亡后清零。",[2]="每次使用如意神通，提升40点\n自身伤害，最多叠加6层，死\n亡后清零。"},
		鸣空     = {[1]= "每当令目标浮空时，你获得12点狂暴等级并且造成的物理伤害结果提高2%，最多叠加6层，阵亡后清零",[2]="每当令目标浮空时，你获得24点狂暴等级并且造成的物理伤害结果提高2%，最多叠加6层，阵亡后清零"},
		骇神     = {[1]= "受到物理伤害时，若攻击者物理伤害低于你，伤害结果降低10%",[2]="受到物理伤害时，若攻击者物理伤害低于你，伤害结果降低20%"},

	}
local 神器名称图 = {
		大唐官府 = "130113D0",化生寺 = "9EE14769",方寸山 = "C160C703",女儿村 = "A0498994",
		天宫 = "D840B4EA",普陀山 = "721B7187",龙宫 = "A8758DA8",五庄观 = "EA50FC9B",
		魔王寨 = "87798740",狮驼岭 = "50CCD3E0",盘丝洞 = "DCF3158D",阴曹地府 = "D07C437B",
		神木林 = "C0CD7B01",凌波城 = "29CCB8D3",无底洞 = "AF274C97"
	}
local 神器被动 = {
	    神木林   = {凭虚御风="2025B3FD",钟灵="DA548BBF"},
	    大唐官府 = {藏锋敛锐="503D8CA7",惊锋="A03CFC3B"},
	    化生寺   = {风起云墨="A63913D4",挥毫 = "4B329E45"},
	    女儿村   = {盏中晴雪="36B2E3CF",泪光盈盈="4BBDA193"},
	    方寸山   = {披坚执锐="684B4E25",金汤之固="F792D518"},
	    龙宫     = {定风波="853AE759",沧浪赋="DDBE29E9"},
	    普陀山   = {璇华="8D1C2046",玉魄="46A6CE38"},
	    五庄观   = {斗转参横="046FA0C3",静笃="BDCF66D5"},
	    天宫     = {弦外之音="28F6C70D",裂帛="42D44907"},
	    凌波城   = {威服天下="B4A9C912",酣战="A74ADDE5"},
	    狮驼岭   = {蛮血="309D98AB",狂战="4BF53DD6"},
	    魔王寨   = {业焰明光="93AE558D",流火="E237CD7F"},
	    盘丝洞   = {镜花水月="FD08B56C",澄明="B0349D39"},
	    阴曹地府 = {亡灵泣语="6C48C19C",魂魇="A1CC4CB3"},
	    无底洞   = {情思悠悠="790A1C24",相思="5BCC0F87"},
	    花果山 = {"万物滋长","开辟"},
	    九黎城 = {"鸣空","骇神"},
	}

local 神器渲染背景 = {
		神木林 = "92A0D697",
		凌波城 = "087BEF28",
		盘丝洞 = "D9EC5E82",
		女儿村 = "5E688B50",
		无底洞 = "8CBAED1B",
		天宫   = "6918E30A",
		狮驼岭 = "FAF8A22D",
		阴曹地府 = "97E88B79",
		方寸山 = "69C5B0D1",
		魔王寨 = "FD1F847B",
		普陀山 = "119883BC",
		大唐官府 = "754D40E2",
		化生寺 = "5587BEF3",
		龙宫   = "F9A0A6B9",
		五庄观 = "5E4F6929", --"A20D7D9D",--5E4F6929--两个
	}
local 神器底图 = {
		神木林 = "4902C991",
		凌波城 = "37364FA2",
		女儿村 = "350639BB",
		无底洞 = "A40E6707",
		天宫   = "B7F12AC8",
		大唐官府 = "593B5349",
		方寸山 = "C8326D89",
		魔王寨 = "F244CEF3",
		五庄观 = "5E4F6929",
	}
local 神器模型 = {
		神木林 = {"018013AE","48A22679","27504873"}, --树枝，月亮，树叶
		天宫 = {"290ACCB0","B2A9682E","C68841B3"}, --上,身，尾
        盘丝洞 = {"131B5F07","507F5020","D2EAC261"}, --镜面，上，下
		凌波城 = {"9B10DFD8","65BB498B","3AAA5BED"}, --身子，头，底部
		女儿村 = {"909F588F","14488877","F57FB4C6"}, --碗右，中，左
		无底洞 = {"F991023F","16E503E3","4428166E"}, --上，中，下
		狮驼岭 = {"7A43A176","8167254F","3BECCD5C"}, --上，中，下
		阴曹地府 = {"64DDB00C","523D76AB","D02AC1C7"}, --上，中，脚
		大唐官府 = {"828B7E27","780B0000","52E6A411"}, --剑柄，剑身，剑鞘 --剑身没有
		化生寺 = {"E2F71BD1","DA956848","5CC81540"}, --吊坠，身，鼻毛
		龙宫 = {"6EDC07C1","C7A953A8","F288E253"}, --左，中，右
		五庄观 = {"A00DD3E7","E1CF43ED","DE964585"}, --外圈，中圈，中外圈
		魔王寨 = {"FDF8D071","FDF8D071","FDF8D071"}, --没有
		普陀山 = {"FDF8D071","FDF8D071","FDF8D071"}, --没有
		花果山 = {"FDF8D071","FDF8D071","FDF8D071"}, --没有
		方寸山 = {"FDF8D071","FDF8D071","FDF8D071"}, --没有
		九黎城 = {0x10000079,0x10000080,0x10000081},
	}

function 神器查看:初始化(根)
 	self.ID = 141
	self.x = 0
	self.y = 0
	self.xx = 0
	self.yy = 0
	self.注释 = "神器查看"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口时间 = 0
	tp = 根
end

function 神器查看:重新载入()
    self.资源组=nil
end

function 神器查看:加载资源()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	self.资源组 = {
		[1] = 资源:载入('wdf/pic/神器素材/sqbj.png',"图片"),--zip:取精灵([[sqbj.png]]),
		[2] = 按钮.创建(资源:载入('新加界面.npk',"网易WDF动画","20FD5715"),0,0,3,true,true),
		[3] = 资源:载入('wdf/pic/神器素材/tbwzbj.png',"图片"),--zip:取精灵([[tbwzbj.png]]),
		[4] = 资源:载入('新加界面.npk',"网易WDF动画","C057E026"),
		[5] = 资源:载入('wdf/pic/神器素材/321.png',"图片"),--zip:取精灵([[321.png]]), --字底条
		[6] = 资源:载入('wdf/pic/神器素材/123.png',"图片"),--zip:取精灵([[123.png]]), --属性框
		[7] = 资源:载入('新加界面.npk',"网易WDF动画","013253E7"), --五庄观的棋子
		[8] = 资源:载入('新加界面.npk',"网易WDF动画","A46F777B"), --左上角
		[9] = 资源:载入('新加界面.npk',"网易WDF动画","240C67DC"), --右上角
		[10] = 资源:载入('新加界面.npk',"网易WDF动画","8A3AED59"), --左下角
	}
	if self.门派=="普陀山" then
		self.资源组[13] = 资源:载入('wdf/pic/神器素材/pt1.png',"图片") -- 云
		self.资源组[14] = 资源:载入('wdf/pic/神器素材/pt2.png',"图片")--zip:取精灵([[pt2.png]]) -- 蛋下
		self.资源组[15] = 资源:载入('wdf/pic/神器素材/pt3.png',"图片")--zip:取精灵([[pt3.png]]) -- 蛋上
		self.资源组[16] = 资源:载入('wdf/pic/神器素材/pt11.png',"图片")--zip:取精灵([[pt11.png]]) -- 云
		self.资源组[17] = 资源:载入('wdf/pic/神器素材/pt22.png',"图片")--zip:取精灵([[pt22.png]]) -- 蛋下
		self.资源组[18] = 资源:载入('wdf/pic/神器素材/pt33.png',"图片")--zip:取精灵([[pt33.png]]) -- 蛋上
    elseif self.门派=="魔王寨" then
		self.资源组[19] = 资源:载入('wdf/pic/神器素材/mw1.png',"图片")--zip:取精灵([[mw1.png]]) -- 大圈
		self.资源组[20] = 资源:载入('wdf/pic/神器素材/mw2.png',"图片")--zip:取精灵([[mw2.png]]) -- 火苗
		self.资源组[21] = 资源:载入('wdf/pic/神器素材/mw3.png',"图片")--zip:取精灵([[mw3.png]]) -- S
		self.资源组[22] = 资源:载入('wdf/pic/神器素材/mw11.png',"图片")--zip:取精灵([[mw11.png]]) -- 大圈
		self.资源组[23] = 资源:载入('wdf/pic/神器素材/mw22.png',"图片")--zip:取精灵([[mw22.png]]) -- 火苗
		self.资源组[24] = 资源:载入('wdf/pic/神器素材/mw33.png',"图片")--zip:取精灵([[mw33.png]]) -- S
	elseif self.门派=="方寸山" then
		self.资源组[25] = 资源:载入('wdf/pic/神器素材/fc1.png',"图片")--zip:取精灵([[fc1.png]]) -- 衣
		self.资源组[26] = 资源:载入('wdf/pic/神器素材/fc2.png',"图片")--zip:取精灵([[fc2.png]]) -- 领
		self.资源组[27] = 资源:载入('wdf/pic/神器素材/fc3.png',"图片")--zip:取精灵([[fc3.png]]) -- 肩膀
		self.资源组[28] = 资源:载入('wdf/pic/神器素材/fc11.png',"图片")--zip:取精灵([[fc11.png]]) -- 衣
		self.资源组[29] = 资源:载入('wdf/pic/神器素材/fc22.png',"图片")--zip:取精灵([[fc22.png]]) -- 领
		self.资源组[30] = 资源:载入('wdf/pic/神器素材/fc33.png',"图片")--zip:取精灵([[fc33.png]]) -- 肩膀
	elseif self.门派=="花果山" then
		self.资源组[31] = 资源:载入('wdf/pic/神器素材/hg1.png',"图片")--zip:取精灵([[hg1.png]]) -- 云
		self.资源组[32] = 资源:载入('wdf/pic/神器素材/hg2.png',"图片")--zip:取精灵([[hg2.png]]) -- 下
		self.资源组[33] = 资源:载入('wdf/pic/神器素材/hg3.png',"图片")--zip:取精灵([[hg3.png]]) -- 上
		self.资源组[34] = 资源:载入('wdf/pic/神器素材/hg11.png',"图片")--zip:取精灵([[hg11.png]]) -- 云
		self.资源组[35] = 资源:载入('wdf/pic/神器素材/hg22.png',"图片")--zip:取精灵([[hg22.png]]) -- 下
		self.资源组[36] = 资源:载入('wdf/pic/神器素材/hg33.png',"图片")--zip:取精灵([[hg33.png]]) -- 上
	-- elseif self.门派=="九黎城" then
	-- 	self.资源组[37] = 资源:载入('wdf/pic/神器素材/mxjs.png',"图片")--zip:取精灵([[hg1.png]]) -- 云
	-- 	self.资源组[38] = 资源:载入('wdf/pic/神器素材/mxjz.png',"图片")--zip:取精灵([[hg2.png]]) -- 下
	-- 	self.资源组[39] = 资源:载入('wdf/pic/神器素材/mxjm.png',"图片")--zip:取精灵([[hg3.png]]) -- 上
	end
	zt1 = tp.字体表.自动栏字体
	zt2 =tp.字体表.标题字体
	zt3 = tp.字体表.普通字体
end

function 神器查看:打开(数据)
	-- table.print(数据)
 	if self.可视 then
		self.可视 = false
		self.神器名字 = nil
		self.神器渲染 = nil
		self.神器光源 = nil
		-- self.寄存内容 = nil
		self.神器渲染 = nil
		return
	else
		-- table.print(数据)
		insert(tp.窗口_,self)

		self.门派=tp.队伍[1].门派
		if self.资源组==nil then
		    self:加载资源()
		end
		-- self.寄存内容 = 数据
		self.技能 = 数据.神器.神器技能.名称
		self.等级 = 数据.神器.神器技能.等级
		for n=1,3 do
			if 数据.神器.神器解锁[n]~=nil then
			    神器属性[n]=数据.神器.神器解锁[n]
			end
		end
		-- table.print(神器属性)
		if self.门派~="无" and self.门派~="花果山"and self.门派~="九黎城" then
			  	self.神器名字 = tp.资源:载入('新加界面.npk',"网易WDF动画",神器名称图[self.门派])
				if 神器渲染背景[self.门派]~=nil then
				    self.神器渲染 = tp.资源:载入('新加界面.npk',"网易WDF动画",神器渲染背景[self.门派])
				end
				if 神器底图[self.门派]~=nil then
				    self.神器光源 = tp.资源:载入('新加界面.npk',"网易WDF动画",神器底图[self.门派])
				end
	            self.神器技能 = tp.资源:载入('新加界面.npk',"网易WDF动画",神器被动[self.门派][self.技能])

		end
		self.神器拼接按钮={}
		if self.门派~="无" then
			for n=1,3 do
				if self.门派=="九黎城" then
					self.神器拼接按钮[n] = tp._按钮.创建(tp.资源:载入("jmtb.wdf","网易WDF动画",神器模型[self.门派][n]),0,0,3,true,true)
				else
					self.神器拼接按钮[n] = tp._按钮.创建(tp.资源:载入("新加界面.npk","网易WDF动画",神器模型[self.门派][n]),0,0,3,true,true)
				end
			end
			-- table.print(神器被动[self.门派])
		end
		self.miaoshu={}
		self.miaoshu["速度"]="速　　度"
		self.miaoshu["气血"]="气　　血"
		self.miaoshu["伤害"]="伤　　害"
		self.miaoshu["防御"]="防    御"
		self.miaoshu["封印命中"]="封印命中"
		self.miaoshu["法术伤害"]="法术伤害"
		self.miaoshu["固定伤害"]="固定伤害"
		self.miaoshu["物理暴击"]="物理暴击"
		self.miaoshu["治疗能力"]="治疗能力"
		self.miaoshu["法术暴击"]="法术暴击"
		self.miaoshu["法术防御"]="法术防御"
		self.miaoshu["抵抗封印"]="抵抗封印"
		self.x = (全局游戏宽度/2)-282
		self.y = (全局游戏高度/2)-282
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
		-- print(5)
	end
end

function 神器查看:显示(dt,x,y)
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[4]:更新(dt)
	self.资源组[4]:显示(self.x - 90,self.y - 70)
	self.资源组[3]:显示(self.x + 175,self.y - 5)
	self.资源组[2]:更新(x,y)
	self.资源组[2]:显示(self.x + 585,self.y - 5)
	if self.门派~="无" and self.门派~="花果山" and self.门派~="九黎城" and self.神器名字 then
		self.神器名字:显示(self.x + 273,self.y)
	else
		if self.门派=="花果山" then
			 zt2:置颜色(黄色):显示(self.x + 280,self.y,"鸿蒙石")
		elseif self.门派=="九黎城" then
			zt2:置颜色(黄色):显示(self.x + 280,self.y,"魔息角")
		end
	end
	    --do
	-- end
	self.资源组[6]:显示(self.x +408,self.y +258) --属性框
    self.资源组[5]:显示(self.x +453 ,self.y + 290) --字底条
    if self.门派~="无" then
	    for n=1,3 do
			self.神器拼接按钮[n]:更新(x,y)
		end
	end
    if self.门派~="无" then
    	if self.门派=="神木林" then
    		self.神器光源:显示(self.x + 109,self.y + 30) --发光圆圈
    		self.神器拼接按钮[1]:显示(self.x + 260,self.y + 67) --,nil,nil,nil,true,4) ,nil,nil,nil,true,2
    		self.神器渲染:显示(self.x + 110,self.y + 29)
			self.神器拼接按钮[2]:显示(self.x + 234,self.y + 137)
			self.神器拼接按钮[3]:显示(self.x + 203,self.y + 134)
		elseif self.门派=="大唐官府" then
			self.神器渲染:显示(self.x + 73,self.y + 50)
			self.神器拼接按钮[3]:显示(self.x + 119,self.y + 240)
			self.神器光源:显示(self.x + 75,self.y + 45) --龙
			self.神器拼接按钮[2]:显示(self.x + 39,self.y + 191) --暗剑身
		    self.神器拼接按钮[1]:显示(self.x + 260,self.y + 114)
	    elseif self.门派=="化生寺" then
		    self.神器渲染:显示(self.x + 53,self.y + 32)
		    self.神器拼接按钮[3]:显示(self.x + 86,self.y + 216)
			self.神器拼接按钮[2]:显示(self.x + 201,self.y + 70)
		    self.神器拼接按钮[1]:显示(self.x + 336,self.y + 136)
	    elseif self.门派=="女儿村" then
		    self.神器渲染:显示(self.x + 78,self.y + 12)
		    self.神器拼接按钮[3]:显示(self.x + 108,self.y + 155)
		    self.神器拼接按钮[2]:显示(self.x + 193,self.y + 185)
		    self.神器拼接按钮[1]:显示(self.x + 146,self.y + 63)
		    self.神器光源:显示(self.x + 80,self.y + 10)
	    elseif self.门派=="方寸山" then
			self.神器渲染:显示(self.x + 111,self.y + 18)
			self.资源组[25]:显示(self.x + 96,self.y + 65)
			self.资源组[26]:显示(self.x + 96,self.y + 65)
			self.资源组[27]:显示(self.x + 96,self.y + 65)
			self.神器光源:显示(self.x + 114,self.y + 13)
			if self.资源组[25]:是否选中(x,y) then
				self.资源组[28]:显示(self.x + 96,self.y + 65)
				self.资源组[6]:显示(self.x,self.y +10)
		    	self.资源组[8]:显示(self.x,self.y +45)
		    	for i=1,4 do
		    		zt1:置颜色(白色):显示(self.x+40,self.y +73+(i-1)*25,self.miaoshu[神器属性[1].神器五行属性[i]].."  +"..神器属性[1].神器五行数值[i])
		    	end
			end
			if self.资源组[26]:是否选中(x,y) then
				self.资源组[29]:显示(self.x + 96,self.y + 65)
				self.资源组[6]:显示(self.x +408,self.y +10)
		    	self.资源组[9]:显示(self.x +408,self.y +45)
		    	if not 判断是否为空表(神器属性[2]) then
			    	for i=1,4 do
			    		zt1:置颜色(白色):显示(self.x+520,self.y +73+(i-1)*25,self.miaoshu[神器属性[2].神器五行属性[i]].."  +"..神器属性[2].神器五行数值[i])
			    	end
			    end
			end
			if self.资源组[27]:是否选中(x,y) then
				self.资源组[30]:显示(self.x + 96,self.y + 65)
				self.资源组[6]:显示(self.x,self.y +258)
		    	self.资源组[10]:显示(self.x,self.y +331)
		    	if not 判断是否为空表(神器属性[3]) then
			    	for i=1,4 do
			    		zt1:置颜色(白色):显示(self.x+40,self.y +323+(i-1)*25,self.miaoshu[神器属性[3].神器五行属性[i]].."  +"..神器属性[3].神器五行数值[i])
			    	end
			    end
			end
			for i=25,27 do
				if 引擎.鼠标弹起(左键) and self.资源组[i]:是否选中(x,y) then
				    请求服务(6210)
		    		self:打开()
		    		return
				end
			end
	    elseif self.门派=="龙宫" then
	    	self.神器渲染:显示(self.x + 108,self.y + 18)
		    self.神器拼接按钮[3]:显示(self.x + 76,self.y + 71)
		    self.神器拼接按钮[2]:显示(self.x + 232,self.y + 66)
		    self.神器拼接按钮[1]:显示(self.x + 127,self.y + 66)
	    elseif self.门派=="普陀山" then
		    self.神器渲染:显示(self.x + 138,self.y + 25)
            self.资源组[14]:显示(self.x + 126,self.y + 33) --2
            self.资源组[15]:显示(self.x + 126,self.y + 33) --3
            self.资源组[13]:显示(self.x + 126,self.y + 33) --1
            if self.资源组[13]:是否选中(x,y) then
				self.资源组[16]:显示(self.x + 126,self.y + 33)
				self.资源组[6]:显示(self.x,self.y +10)
		    	self.资源组[8]:显示(self.x,self.y +45)
		    	for i=1,4 do
		    		zt1:置颜色(白色):显示(self.x+40,self.y +73+(i-1)*25,self.miaoshu[神器属性[1].神器五行属性[i]].."  +"..神器属性[1].神器五行数值[i])
		    	end
			end
			if self.资源组[14]:是否选中(x,y) then
				self.资源组[17]:显示(self.x + 126,self.y + 33)
				self.资源组[13]:显示(self.x + 126,self.y + 33)
				self.资源组[6]:显示(self.x +408,self.y +10)
		    	self.资源组[9]:显示(self.x +408,self.y +45)
		    	if not 判断是否为空表(神器属性[2]) then
			    	for i=1,4 do
			    		zt1:置颜色(白色):显示(self.x+520,self.y +73+(i-1)*25,self.miaoshu[神器属性[2].神器五行属性[i]].."  +"..神器属性[2].神器五行数值[i])
			    	end
			    end
			end
			if self.资源组[15]:是否选中(x,y) then
				self.资源组[18]:显示(self.x + 126,self.y + 33)
				self.资源组[13]:显示(self.x + 126,self.y + 33)
				self.资源组[6]:显示(self.x,self.y +258)
		    	self.资源组[10]:显示(self.x,self.y +331)
		    	if not 判断是否为空表(神器属性[3]) then
			    	for i=1,4 do
			    		zt1:置颜色(白色):显示(self.x+40,self.y +323+(i-1)*25,self.miaoshu[神器属性[3].神器五行属性[i]].."  +"..神器属性[3].神器五行数值[i])
			    	end
			    end
			end
			for i=13,15 do
				if 引擎.鼠标弹起(左键) and self.资源组[i]:是否选中(x,y) then
				    请求服务(6210)
		    		self:打开()
		    		return
				end
			end
	    elseif self.门派=="五庄观" then
    		self.神器渲染:显示(self.x + 88,self.y + 44)
		    self.神器拼接按钮[3]:显示(self.x + 153,self.y + 159)
		    self.神器拼接按钮[1]:显示(self.x + 156,self.y + 86)--外圈，中圈，中外圈
		    self.神器拼接按钮[2]:显示(self.x + 193,self.y + 186)
		    self.神器光源:显示(self.x + 88,self.y + 41)
		    self.资源组[7]:显示(self.x + 89,self.y + 42)  --五庄观的棋子
	    elseif self.门派=="天宫" then
	    	self.神器渲染:显示(self.x + 108,self.y + 46)
		    self.神器拼接按钮[3]:显示(self.x + 177,self.y + 232) --尾
		    self.神器拼接按钮[2]:显示(self.x + 121,self.y + 122) --身
		    self.神器拼接按钮[1]:显示(self.x + 277,self.y + 66) --上
		    self.神器光源:显示(self.x + 114,self.y + 43)
	    elseif self.门派=="凌波城" then
	    	self.神器光源:显示(self.x + 88,self.y + 45)
		    self.神器拼接按钮[3]:显示(self.x + 104,self.y + 201) --底部
		    self.神器拼接按钮[2]:显示(self.x + 148,self.y + 91) --头
		    self.神器拼接按钮[1]:显示(self.x + 183,self.y + 66) ----身子，头，底部
		    self.神器渲染:显示(self.x + 85,self.y + 48)
	    elseif self.门派=="狮驼岭" then
			self.神器拼接按钮[3]:显示(self.x + 213,self.y + 239)
			self.神器拼接按钮[2]:显示(self.x + 150,self.y + 143)
			self.神器拼接按钮[1]:显示(self.x + 135,self.y + 60)--上，中，下
			self.神器渲染:显示(self.x + 83,self.y + 47)
	    elseif self.门派=="魔王寨" then
			self.神器光源:显示(self.x + 88,self.y + 45)
			self.资源组[19]:显示(self.x + 96,self.y + 33)
			self.资源组[20]:显示(self.x + 96,self.y + 33)
			self.资源组[21]:显示(self.x + 96,self.y + 33)
			if self.资源组[19]:是否选中(x,y) and not self.资源组[20]:是否选中(x,y) and not self.资源组[21]:是否选中(x,y) then
				self.资源组[22]:显示(self.x + 96,self.y + 33)
				self.资源组[20]:显示(self.x + 96,self.y + 33)
				self.资源组[21]:显示(self.x + 96,self.y + 33)
				self.资源组[6]:显示(self.x,self.y +10)
		    	self.资源组[8]:显示(self.x,self.y +45)
		    	for i=1,4 do
		    		zt1:置颜色(白色):显示(self.x+40,self.y +73+(i-1)*25,self.miaoshu[神器属性[1].神器五行属性[i]].."  +"..神器属性[1].神器五行数值[i])
		    	end
			end
			if self.资源组[20]:是否选中(x,y) then
				self.资源组[23]:显示(self.x + 96,self.y + 33)
				self.资源组[6]:显示(self.x +408,self.y +10)
		    	self.资源组[9]:显示(self.x +408,self.y +45)
		    	if not 判断是否为空表(神器属性[2]) then
			    	for i=1,4 do
			    		zt1:置颜色(白色):显示(self.x+520,self.y +73+(i-1)*25,self.miaoshu[神器属性[2].神器五行属性[i]].."  +"..神器属性[2].神器五行数值[i])
			    	end
			    end
			end
			if self.资源组[21]:是否选中(x,y) then
				self.资源组[24]:显示(self.x + 96,self.y + 33)
				self.资源组[6]:显示(self.x,self.y +258)
		    	self.资源组[10]:显示(self.x,self.y +331)
		    	if not 判断是否为空表(神器属性[3]) then
			    	for i=1,4 do
			    		zt1:置颜色(白色):显示(self.x+40,self.y +323+(i-1)*25,self.miaoshu[神器属性[3].神器五行属性[i]].."  +"..神器属性[3].神器五行数值[i])
			    	end
			    end
			end
			for i=19,21 do
				if 引擎.鼠标弹起(左键) and self.资源组[i]:是否选中(x,y) then
				    请求服务(6210)
		    		self:打开()
		    		return
				end
			end
	    elseif self.门派=="阴曹地府" then
		    self.神器拼接按钮[3]:显示(self.x + 151,self.y + 261)
			self.神器拼接按钮[2]:显示(self.x + 165,self.y + 173)
			self.神器拼接按钮[1]:显示(self.x + 115,self.y + 126)--上，中，脚
			self.神器渲染:显示(self.x + 88,self.y + 29)
	    elseif self.门派=="无底洞" then
		    self.神器拼接按钮[3]:显示(self.x + 137,self.y + 238)
			self.神器拼接按钮[2]:显示(self.x + 234,self.y + 151)
			self.神器拼接按钮[1]:显示(self.x + 323,self.y + 60)--上，中，下
			self.神器渲染:显示(self.x + 118,self.y + 28)
			self.神器光源:显示(self.x + 116,self.y + 33)
		elseif self.门派=="盘丝洞" then
			self.神器渲染:显示(self.x + 97,self.y + 23)
			self.神器拼接按钮[1]:显示(self.x + 165,self.y + 120)--镜面，上，下
			self.神器拼接按钮[3]:显示(self.x + 138,self.y + 189)
			self.神器拼接按钮[2]:显示(self.x + 125,self.y + 53)
		elseif self.门派=="九黎城" then
			self.神器拼接按钮[1]:显示(self.x + 130,self.y + 70)--镜面，上，下
			self.神器拼接按钮[3]:显示(self.x + 130,self.y + 70)
			self.神器拼接按钮[2]:显示(self.x + 130,self.y + 70)
	    elseif self.门派=="花果山" then
			self.资源组[32]:显示(self.x + 96,self.y + 37)
			self.资源组[33]:显示(self.x + 96,self.y + 37)
			self.资源组[31]:显示(self.x + 96,self.y + 37)
			if self.资源组[31]:是否选中(x,y) then
				self.资源组[34]:显示(self.x + 96,self.y + 37)
				self.资源组[6]:显示(self.x,self.y +10)
		    	self.资源组[8]:显示(self.x,self.y +45)
		    	for i=1,4 do
		    		zt1:置颜色(白色):显示(self.x+40,self.y +73+(i-1)*25,self.miaoshu[神器属性[1].神器五行属性[i]].."  +"..神器属性[1].神器五行数值[i])
		    	end
			end
			if self.资源组[32]:是否选中(x,y) then
				self.资源组[35]:显示(self.x + 96,self.y + 37)
				self.资源组[31]:显示(self.x + 96,self.y + 37)
				self.资源组[6]:显示(self.x +408,self.y +10)
		    	self.资源组[9]:显示(self.x +408,self.y +45)
		    	if not 判断是否为空表(神器属性[2]) then
			    	for i=1,4 do
			    		zt1:置颜色(白色):显示(self.x+520,self.y +73+(i-1)*25,self.miaoshu[神器属性[2].神器五行属性[i]].."  +"..神器属性[2].神器五行数值[i])
			    	end
			    end
			end
			if self.资源组[33]:是否选中(x,y) then
				self.资源组[36]:显示(self.x + 96,self.y + 37)
				self.资源组[31]:显示(self.x + 96,self.y + 37)
				self.资源组[6]:显示(self.x,self.y +258)
		    	self.资源组[10]:显示(self.x,self.y +331)
		    	if not 判断是否为空表(神器属性[3]) then
			    	for i=1,4 do
			    		zt1:置颜色(白色):显示(self.x+40,self.y +323+(i-1)*25,self.miaoshu[神器属性[3].神器五行属性[i]].."  +"..神器属性[3].神器五行数值[i])
			    	end
			    end
			end
			for i=31,33 do
				if 引擎.鼠标弹起(左键) and self.资源组[i]:是否选中(x,y) then
				    请求服务(6210)
		    		self:打开()
		    		return
				end
			end
    	end
    end
    if self.门派~="无" and self.门派~="花果山" and self.门派~="九黎城" and self.神器技能 then
	    self.神器技能:显示(self.x +498 ,self.y + 293)
	else
		if self.技能 then
		 	zt3:置颜色(白色):显示(self.x +506 ,self.y + 295,self.技能)
		end
	end

    if self.神器拼接按钮[1]:是否选中(x,y) then--1
    	self.资源组[6]:显示(self.x,self.y +10)
    	self.资源组[8]:显示(self.x,self.y +45)
    	for i=1,4 do
    		zt1:置颜色(白色):显示(self.x+40,self.y +73+(i-1)*25,self.miaoshu[神器属性[1].神器五行属性[i]].."  +"..神器属性[1].神器五行数值[i])
    	end
    elseif self.神器拼接按钮[2]:是否选中(x,y) then --2
    	self.资源组[6]:显示(self.x +408,self.y +10)
    	self.资源组[9]:显示(self.x +408,self.y +45)
    	if not 判断是否为空表(神器属性[2]) then
    		for i=1,4 do
	    		zt1:置颜色(白色):显示(self.x+520,self.y +73+(i-1)*25,self.miaoshu[神器属性[2].神器五行属性[i]].."  +"..神器属性[2].神器五行数值[i])
	    	end
	    end
    elseif self.神器拼接按钮[3]:是否选中(x,y) then--3
    	self.资源组[6]:显示(self.x,self.y +258)
    	self.资源组[10]:显示(self.x,self.y +331)
    	if not 判断是否为空表(神器属性[3]) then
    		for i=1,4 do
	    		zt1:置颜色(白色):显示(self.x+40,self.y +323+(i-1)*25,self.miaoshu[神器属性[3].神器五行属性[i]].."  +"..神器属性[3].神器五行数值[i])
	    	end
	    end
    end
    zt1:置颜色(白色):显示(self.x +480,self.y + 336,技能介绍[self.技能][self.等级])
    -- if self.神器拼接按钮[1]:事件判断() then
    -- 	if tp.窗口.修复神器.可视 == false then
	   --    tp.窗口.修复神器:打开(self.寄存内容)
	   --  end
    -- 	self:打开()
    -- return
    -- end
    for i=1,3 do
    	if self.神器拼接按钮[i]:事件判断() then
    		请求服务(6210)
    		self:打开()
    		return
    	end
    end
    if self.资源组[2]:事件判断() then --关闭
		self:打开()
		return
	end

end


function 神器查看:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
		self.窗口时间 = tp.运行时间
	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 神器查看:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end
function 神器查看:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		return true
	else
		return false
	end
end
return 神器查看