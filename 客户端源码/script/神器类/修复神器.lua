local 修复神器 = class()
local insert = table.insert
local mouseb = 引擎.鼠标弹起
local mousea = 引擎.鼠标按住
local qjq = 引擎.取金钱颜色
local tp,zt1,zt2,zt3

local 技能介绍 = {
		藏锋敛锐 = {[1]= "横扫千军消耗的气血有50%的\n几率转化为等量护盾。",[2]="横扫千军消耗的气血有100%的\n几率转化为等量护盾。"},-----
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
		璇华     = {[1]= "使用五行法术时，增\n加10%的伤害。",[2]="使用五行法术时，增\n加20%的伤害。"},

		威服天下 = {[1]= "暴击伤害增加12%。",[2]="暴击伤害增加24%。"},
		酣战     = {[1]= "每点消耗的战意，会提升30点\n物理暴击等级，可叠加6次，\n死亡后清零。",[2]="每点消耗的战意，会提升60\n点物理暴击等级，可叠加6次，\n死亡后清零。"},
		----------------------------------------------
		万物滋长 = {[1]= "使用特技时将会获得（消耗愤\n怒值×等级×5%）的护盾和\n气血回复。",[2]="使用特技时将会获得（消耗愤\n怒值×等级×10%）的护盾和\n气血回复。"},
		开辟     = {[1]= "每次使用如意神通，提升20点\n自身伤害，最多叠加6层，死\n亡后清零。",[2]="每次使用如意神通，提升40点\n自身伤害，最多叠加6层，死\n亡后清零。"},
		鸣空     = {[1]= "每当令目标浮空时，你获得12点狂暴等级并且造成的物理伤害结果提高2%，最多叠加6层，阵亡后清零",[2]="每当令目标浮空时，你获得24点狂暴等级并且造成的物理伤害结果提高2%，最多叠加6层，阵亡后清零"},
		骇神     = {[1]= "受到物理伤害时，若攻击者物理伤害低于你，伤害结果降低10%",[2]="受到物理伤害时，若攻击者物理伤害低于你，伤害结果降低20%"},


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
	    九黎城 = {鸣空="790A1C24",骇神="5BCC0F87"},
	}
local 神器属性 = {
		大唐官府 = {"伤　　害","物理暴击"},化生寺 = {"防　　御","治疗能力"},方寸山 = {"封印命中","法术伤害"},女儿村 = {"封印命中","固定伤害"},天宫 = {"法术伤害","封印命中"},
		普陀山 = {"固定伤害","治疗能力"},龙宫 = {"法术伤害","法术暴击"},五庄观 = {"伤　　害","封印命中"},魔王寨 = {"法术伤害","法术暴击"},狮驼岭 = {"伤　　害","物理暴击"},
		盘丝洞 = {"封印命中","法术防御"},阴曹地府 = {"伤　　害","法术防御"},神木林 = {"法术伤害","法术暴击"},凌波城 = {"伤　　害","物理暴击"},无底洞 = {"封印命中","治疗能力"},
		花果山 = {"伤　　害","物理暴击"},九黎城 = {"伤　　害","物理暴击"}
	}
local 神器图 = {
                天宫   = {"861333DE","D3F019A9","D90C5658"},
                龙宫   = {"C163A3CB","C5A94CBC","64893E31"},
                化生寺 = {"BCD2FD04","94748447","23906569"},
		        方寸山 = {"F4468EB3","7ADF0AD5","6AD0DD5B"},
		        女儿村 = {"2FE3D5CB","AE659408","478C415A"},
		        普陀山 = {"ACD7AC8C","A26045E7","AF7234E1"},
		        五庄观 = {"7C4D3F9D","0A7537A9","F9CE015C"},
				魔王寨 = {"01AC0038","01AC0039","01AC0040"},
				狮驼岭 = {"898E3905","C621DCE5","768B550B"},
				盘丝洞 = {"767F7971","72527A8B","9F45CA15"},
				神木林 = {"01AC0038","96D9A247","1934A199"},
				凌波城 = {"C068EA63","8794D94E","C0AA056C"},
				无底洞 = {"2034FC4A","0CBEA6CD","FFC9DADB"},
				花果山 = {"861333DE","D3F019A9","D90C5658"},
				大唐官府 = {"467F2FCB","732620A1","AF99EF70"},
		        阴曹地府 = {"E4E601D2","04847348","8F90B0F7"},
		        九黎城 = {"E4E601D2","04847348","8F90B0F7"},
	}
-- 0x64893E31
--0x01AC0037

local 神器名称图 = {
		大唐官府 = "130113D0",化生寺 = "9EE14769",方寸山 = "C160C703",女儿村 = "A0498994",
		天宫 = "D840B4EA",普陀山 = "721B7187",龙宫 = "A8758DA8",五庄观 = "EA50FC9B",
		魔王寨 = "87798740",狮驼岭 = "50CCD3E0",盘丝洞 = "DCF3158D",阴曹地府 = "D07C437B",
		神木林 = "C0CD7B01",凌波城 = "29CCB8D3",无底洞 = "AF274C97"
	}
local 五行图 = {
		金 = "01AC0010",木 = "01AC0011",水 = "01AC0012",火 = "01AC0013",土 = "01AC0014"
	}

local 神器图坐标 = {{207,35},{350,35}}
local 神器卡槽坐标 = {{293,133},{405,243},{293,358},{182,243}}
local 神器已解锁卡槽坐标 = {{296,135},{408,245},{296,360},{185,245}}
local 棱形坐标 = {{313,202},{378,266},{313,330},{249,266}}
local 五行坐标 = {{321,208},{386,272},{321,337},{257,272}}
local 滑动数值 = 1

function 修复神器:初始化(根)
	self.ID = 142
	self.x = 0
	self.y = 0
	self.xx = 0
	self.yy = 0
	self.注释 = "修复神器"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口时间 = 0
	tp = 根
end

function 修复神器:打开(数据)

	if self.可视 then
		self.可视 = false
		self.鼠标 = false
		self.选中卡槽 = nil
		return
	else
		-- table.print(数据)
		insert(tp.窗口_,self)
		self:初始化数据(数据)
		if self.资源组==nil then
			self:加载资源()
		end
		self.资源组[21]:置起始点(0)
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
	end
end

function 修复神器:重新载入()
	self.资源组=nil
end

function 修复神器:加载资源()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 资源:载入('wdf/pic/神器素材/sqbj.png',"图片"),--zip:取精灵([[sqbj.png]]),
		[2] = 按钮.创建(资源:载入('新加界面.npk',"网易WDF动画","20FD5715"),0,0,3,true,true), --关闭
		[3] = 资源:载入('wdf/pic/神器素材/tbwzbj.png',"图片"),--zip:取精灵([[tbwzbj.png]]),--资源:载入("pic/sq/tbwzbj.png","图片"),
		[4] = 资源:载入('新加界面.npk',"网易WDF动画","C057E026"), --动态
		[5] = 资源:载入('wdf/pic/神器素材/swbj.png',"图片"),--zip:取精灵([[swbj.png]]),
		[6] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0009"), --解锁点白框
		[7] = 按钮.创建(资源:载入('新加界面.npk',"网易WDF动画","01AC0020"),0,0,3,true,true), --解锁点+
		[8] = 按钮.创建(资源:载入('新加界面.npk',"网易WDF动画","01AC0021"),0,0,3,true,true), --展开
		[9] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0006"), --竖框
		[10] = 按钮.创建(资源:载入('新加界面.npk',"网易WDF动画","01AC0019"),0,0,3,true,true), --收起
		[11] = 资源:载入('wdf/pic/神器素材/sqyjs.png',"图片"),--zip:取精灵([[sqyjs.png]]),
		[12] = 资源:载入('wdf/pic/神器素材/sqjs.png',"图片"),--zip:取精灵([[sqjs.png]]),
		[13] = 资源:载入('wdf/pic/神器素材/gh.png',"图片"),--zip:取精灵([[gh.png]]),
		[14] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0007"), --小斜正方形
		[15] = 按钮.创建(资源:载入('新加界面.npk',"网易WDF动画","01AC0016"),0,0,3,true,true), --结束修复
		[16] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0007"), --小斜正方形
		[17] = 按钮.创建(资源:载入('新加界面.npk',"网易WDF动画","01AC0017"),0,0,3,true,true), --解锁区域
		[18] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0113"), --黄圈
		[19] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0111"), --物品格子
		[20] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0114"), --滑轮背景
		[21] = tp._滑块.创建(资源:载入('新加界面.npk',"网易WDF动画","01AC0115"),4,14,270,2), --暂 引擎.取鼠标滚轮() ==1
		[22] = 资源:载入('wdf/pic/神器素材/321.png',"图片"),--zip:取精灵([[321.png]]), --字底条
		[23] = 资源:载入('wdf/pic/神器素材/123.png',"图片"),--zip:取精灵([[123.png]]), --属性框
		[24] = 资源:载入('新加界面.npk',"网易WDF动画","8A3AED59"), --左下角
		[25] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0112"), --选中光标
		[26] = 资源:载入('新加界面.npk',"网易WDF动画","7371454A"), --预镶嵌动态
		[27] = 按钮.创建(资源:载入('新加界面.npk',"网易WDF动画","01AC0035"),0,0,3,true,true), --保存结果
		[28] = 按钮.创建(资源:载入('新加界面.npk',"网易WDF动画","01AC0036"),0,0,3,true,true), --放弃本次
	}
	self.资源组[2]:绑定窗口_(self.ID)
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
	zt1 = tp.字体表.自动栏字体
	zt2 =tp.字体表.标题字体
	zt3 = tp.字体表.普通字体
	if self.门派~="无" and self.门派~="花果山" and self.门派~="九黎城" then
		self.神器名字 = tp.资源:载入('新加界面.npk',"网易WDF动画",神器名称图[self.门派])
		self.神器技能 = tp.资源:载入('新加界面.npk',"网易WDF动画",神器被动[self.门派][self.技能])
	end
end

function 修复神器:初始化数据(数据)
	self.门派=tp.队伍[1].门派
	self.x = (全局游戏宽度/2)-314
	self.y = (全局游戏高度/2)-282
	self.技能 = 数据.神器.神器技能.名称
	self.灵犀玉背景展开 = true
	self.神器属性 = 数据.神器
	self.灵犀玉物品 = 数据.灵犀玉
	self.灵犀玉数量 = 0
	self.数 = 1
	-- table.print(self.灵犀玉物品)
	self.物品右 = {}
	for i=1,100 do
		self.物品右[i] = tp._物品格子.创建(0,0,i,"灵犀玉物品")
	end
	self.物品左 = {}
	for i=1,4 do
		self.物品左[i] = tp._物品格子.创建(0,0,i,"测试")
	end
	for n=1,100 do
		if self.灵犀玉物品[n]~=nil then
			self.物品右[self.数]:置根(tp)
			self.物品右[self.数]:置物品(self.灵犀玉物品[n],true)
			self.物品右[self.数].物品格子 = n
			self.数 = self.数 + 1
		end
		if self.灵犀玉物品[n]~=nil then
			self.灵犀玉数量 = self.灵犀玉数量 + 1
		end
	end
	self.物品加入 = 0
	self.神器显示图 = {}
	self.主显示部件 = 1
	self.副显示部件 = {2,3}
	self.神器已解封卡槽 = {}
	self.神器未解封卡槽 = {}
	self.神器锁链 = {}
	self.五行显示图 = {}
	self.解封动画 = false
	---------
	self.预览开关 = {}
	self.特性激活 = {}
	self.临时镶嵌属性 = {}
	self.原本镶嵌属性 = {}
	self.灵犀玉基础属性 = {}
	self.镶嵌插槽 = 1
	self.镶嵌等级 = 0
	self.镶嵌特性 ="无"
	self.已更改 = false
	self.镶嵌部位 = 1
	self.灵犀玉 = {}
	for i=1,4 do
		self.临时镶嵌属性[i] = 0--数据.神器.神器解锁[self.主显示部件].神器五行数值[i]
		self.原本镶嵌属性[i] = 数据.神器.神器解锁[self.主显示部件].神器五行数值[i]
		self.灵犀玉基础属性[i] = 0
		self.预览开关[i] = false
		self.特性激活[i] = {}
		self.特性激活[i] = {蔓延=false,天平=false,相生=false,相克=false,耀=false,利=false}
	end
	self:更新已镶嵌灵犀玉(self.神器属性)
	for n=1,3 do
		if self.神器属性.神器解锁[n]~=nil then
			self.神器显示图[n] = tp._按钮.创建(tp.资源:载入("新加界面.npk","网易WDF动画",神器图[self.门派][n]),0,0,3,true,true)
			self.神器已解封卡槽[n] = {}
			self.五行显示图[n] = {}
			for j=1,4 do
				if self.神器属性.神器解锁[n].神器卡槽解锁[j]~=nil then
					self.神器已解封卡槽[n][j] = tp.资源:载入('新加界面.npk',"网易WDF动画","01AC0109") --无锁
				else
					self.神器已解封卡槽[n][j] = tp._按钮.创建(tp.资源:载入("新加界面.npk","网易WDF动画","01AC0110"),0,0,3,true,true) --有锁
				end
				self.五行显示图[n][j] = tp.资源:载入('新加界面.npk',"网易WDF动画",五行图[self.神器属性.神器解锁[n].神器五行[j]])
			end
		else
			self.神器未解封卡槽[n] = {}

			self.神器显示图[n] = tp._按钮.创建(tp.资源:载入("新加界面.npk","网易WDF动画",神器图[self.门派][n]),0,0,3,true,true)

			for j=1,4 do
				self.神器未解封卡槽[n][j] = tp.资源:载入('新加界面.npk',"网易WDF动画","01AC0108")
			end
			self.神器锁链[n] = tp.资源:载入('新加界面.npk',"网易WDF动画","C3F66FE8")
		end
	end
end

function 修复神器:显示(dt,x,y)
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[4]:更新(dt)
	self.资源组[26]:更新(dt)
	self.资源组[4]:显示(self.x - 90,self.y - 70)
	self.资源组[5]:显示(self.x + 133,self.y + 35)
	self.资源组[3]:显示(self.x + 175,self.y - 5)
	self.资源组[2]:更新(x,y)
	self.资源组[2]:显示(self.x + 585,self.y - 5)
	self.资源组[22]:显示(self.x+13,self.y+290) --字底条
	self.资源组[23]:显示(self.x,self.y+255) --属性框
	self.资源组[24]:显示(self.x+10,self.y+343)
	zt1:置颜色(绿色):显示(self.x +71 ,self.y + 321,"(已激活)")
	-- zt1:置颜色(0xFFFF6666):显示(self.x +13+55 ,self.y + 50-20+70+190+10+48-32+5,"(未激活)")
	zt1:置颜色(白色):显示(self.x +53 ,self.y + 348,技能介绍[self.技能][self.神器属性.神器技能.等级])
	if self.门派~="无" and self.门派~="花果山" and self.门派~="九黎城"  then
			self.神器名字:显示(self.x + 273,self.y)
			self.神器技能:显示(self.x +57 ,self.y+293)
	else
		if self.门派=="花果山" then
			zt2:置颜色(黄色):显示(self.x + 280,self.y,"鸿蒙石")
		elseif self.门派=="九黎城" then
			zt2:置颜色(黄色):显示(self.x + 280,self.y,"魔息角")
		end
		if self.技能 then
			zt3:置颜色(白色):显示(self.x +65 ,self.y+295,self.技能)
		end
	end
	-- self.神器技能:显示(self.x +57 ,self.y+293)
	if self.解封动画 then
		self.神器锁链[self.主显示部件]:更新(dt)
		if self.神器锁链[self.主显示部件].当前帧 == self.神器锁链[self.主显示部件].结束帧 then
			self:解锁更新内容()
			self.解封动画 = false
		end
	end
	for n=1,3 do
		self.神器显示图[n]:更新(x,y)
	end
	self.神器显示图[self.主显示部件]:显示(self.x + 280,self.y + 37,nil,nil,nil,true,4)
	for n=1,2 do
		self.神器显示图[self.副显示部件[n]]:显示(self.x + 神器图坐标[n][1],self.y + 神器图坐标[n][2])
		if self.神器显示图[self.副显示部件[n]]:事件判断() then
			local 加入 = self.主显示部件
			self.主显示部件 = self.副显示部件[n]
			self.副显示部件[n] = 加入
			self.选中卡槽 = nil
			self:更新已镶嵌灵犀玉(self.神器属性)
		end
	end
	if self.神器属性.神器解锁[self.主显示部件]~=nil then
		self.资源组[6]:显示(self.x + 80,self.y + 135)
		self.资源组[7]:更新(x,y)
		self.资源组[7]:显示(self.x + 160,self.y + 128)
		self.资源组[8]:更新(x,y)
		self.资源组[10]:更新(x,y)
		self.资源组[13]:显示(self.x + 148,self.y + 110)
		self.资源组[11]:显示(self.x + 175,self.y + 125)
		if self.已更改 then
			self.资源组[27]:更新(x,y)
			self.资源组[28]:更新(x,y)
			self.资源组[27]:显示(self.x + 204,self.y + 440)
			self.资源组[28]:显示(self.x + 364,self.y + 440)
		else
			self.资源组[15]:更新(x,y)
			self.资源组[15]:显示(self.x + 257,self.y + 440)
		end
		zt3:置颜色(白色):显示(self.x + 30,self.y + 138,"解锁点")
		zt3:置颜色(黑色):显示(self.x + 130,self.y + 139,self.神器属性.神器解锁点)
		if self.灵犀玉背景展开 then
			self.资源组[9]:显示(self.x + 512,self.y + 128)
			local 物品数 = 1
			for n=1,100 do
				if self.灵犀玉数量 <= 4 then
					self.物品右[n]:置坐标(self.x + 537,self.y + 77 + 物品数 * 70)
					if self.物品右[n].物品~=nil then
						self.资源组[19]:显示(self.x + 525,self.y + 72 + 物品数 * 70)
						local istrue = false
						for i=1,4 do
							if self.物品左[i].物品~=nil and self.物品左[i].物品.识别码 == self.物品右[n].物品.识别码 then
								istrue = true
								break
							end
						end
						self.物品右[n]:显示(dt,x,y,self.鼠标,nil,nil,nil,true,self.物品右[n].物品.特性,nil,istrue)
						-- if self.物品右[n].物品.特性 ~= "无" then
						--     zt1:置颜色(黄色):显示(self.x + 545,self.y + 115 + 物品数 * 70,self.物品右[n].物品.特性)
						-- end
						if self.物品右[n].焦点 then
							self.资源组[25]:显示(self.x + 525,self.y + 72 + 物品数 * 70)
							tp.提示:道具行囊(x,y,self.物品右[n].物品,true)
							if tp.场景.抓取物品 == nil and mousea(0x00) then
								tp.场景.抓取物品 = self.物品右[n].物品
								tp.场景.抓取物品ID = n
								tp.场景.抓取物品注释 = self.物品右[n].注释
							end
						end
						if tp.场景.抓取物品 ~= nil and tp.场景.抓取物品注释 == "灵犀玉物品" then
							if 引擎.鼠标弹起(右键) then
								tp.场景.抓取物品 = nil
								tp.场景.抓取物品ID = nil
								tp.场景.抓取物品注释 = nil
								self.物品右[n].物品.选中=nil
							end
						end
						物品数 = 物品数 + 1
					end
				else
					if 物品数 < 5 then
						-- self.物品右[n + self.物品加入]:置坐标(self.x + 532,self.y + 77 + 物品数 * 70)
						-- if self.物品右[n + self.物品加入].物品~=nil then
						if self.物品右[n + self.物品加入]~=nil and self.物品右[n + self.物品加入].物品~=nil then
							self.物品右[n + self.物品加入]:置坐标(self.x + 532,self.y + 77 + 物品数 * 70)
							-- print(n + self.物品加入)
							self.资源组[19]:显示(self.x + 520,self.y + 72 + 物品数 * 70)
							local istrue = false
							for i=1,4 do
								if self.物品左[i].物品~=nil and self.物品左[i].物品.识别码 == self.物品右[n + self.物品加入].物品.识别码 then
									istrue = true
									break
								end
							end
							self.物品右[n + self.物品加入]:显示(dt,x,y,self.鼠标,nil,nil,nil,true,self.物品右[n + self.物品加入].物品.特性,nil,istrue)
							-- if self.物品右[n + self.物品加入].物品.特性 ~= "无" then
					  --   	    zt1:置颜色(黄色):显示(self.x + 543,self.y + 115 + 物品数 * 70,self.物品右[n + self.物品加入].物品.特性)
					  --   	end
							-- if self.神器已解封卡槽[self.主显示部件][j]:是否选中(x,y) then
							if self.物品右[n + self.物品加入].焦点 then
								self.资源组[25]:显示(self.x + 520,self.y + 72 + 物品数 * 70)
								tp.提示:道具行囊(x,y,self.物品右[n + self.物品加入].物品,true)
								if tp.场景.抓取物品 == nil and mousea(0x00) then
									tp.场景.抓取物品 = self.物品右[n + self.物品加入].物品
									tp.场景.抓取物品ID = n + self.物品加入
									tp.场景.抓取物品注释 = self.物品右[n + self.物品加入].注释
								end
							end
							if tp.场景.抓取物品 ~= nil and tp.场景.抓取物品注释 == "灵犀玉物品" then
								if 引擎.鼠标弹起(右键) then
									tp.场景.抓取物品 = nil
									tp.场景.抓取物品ID = nil
									tp.场景.抓取物品注释 = nil
									self.物品右[n + self.物品加入].物品.选中=nil
								end
							end

							物品数 = 物品数 + 1
						end
					end
					self.资源组[21]:置起始点(self.资源组[21]:取百分比转换(滑动数值,0,270))
					self.资源组[20]:显示(self.x + 594,self.y + 138)
					self.资源组[21]:显示(self.x + 595,self.y + 141,x,y,self.鼠标)
				end
			end
			self.资源组[10]:显示(self.x + 520,self.y + 418)
			if 引擎.取鼠标滚轮() ==-1 then
				滑动数值=滑动数值+35
				if 滑动数值>=270 then
					滑动数值=270
				end
				self.物品加入 = math.floor(滑动数值 / (270 / (self.灵犀玉数量 - 4)))
				-- self.焦点 = true
			elseif 引擎.取鼠标滚轮() ==1 then
				滑动数值=滑动数值-35
				if 滑动数值<=0 then
					滑动数值=0
				end
				self.物品加入 = math.floor(滑动数值 / (270 / (self.灵犀玉数量 - 4)))
				-- self.焦点 = true
			end
		else
			self.资源组[8]:显示(self.x + 520,self.y + 118)
		end

		for j=1,4 do
			if self.神器属性.神器解锁[self.主显示部件].神器卡槽解锁[j]~=nil then
				-- print(11111)
				self.神器已解封卡槽[self.主显示部件][j]:显示(self.x+神器已解锁卡槽坐标[j][1],self.y+神器已解锁卡槽坐标[j][2])
				-- print(self.神器已解封卡槽[self.主显示部件][j])
				if self.神器已解封卡槽[self.主显示部件][j]:是否选中(x,y) then
					-- print(2222)
					self.焦点 = true
					if tp.场景.抓取物品 ~= nil and tp.场景.抓取物品注释 == "灵犀玉物品" then
						if mouseb(0) then
							for i=1,4 do
								if self.物品左[i].物品~=nil and tp.场景.抓取物品.识别码==self.物品左[i].物品.识别码 then --某个卡槽的灵犀玉和抓取的灵犀玉为同一个，那么按下的同时清空上一个卡槽的灵犀玉
									self.神器属性.神器解锁[self.主显示部件].镶嵌灵犀玉[i]={}
									self.临时镶嵌属性[i]=0
									self.预览开关[i]=false
									self.物品左[i]:置物品(nil)
									break
								end
							end
							self.物品左[j]:置物品(tp.场景.抓取物品)
							self.预览开关[j] = true
							self.镶嵌等级 = self.物品左[j].物品.子类
							self.镶嵌特性 = self.物品左[j].物品.特性
							self.镶嵌插槽=j
							self.已更改 = true
							self.镶嵌部位=self.主显示部件
							self.灵犀玉[j] = {识别码=self.物品左[j].物品.识别码} --等级=self.物品左[j].物品.子类,特性=self.物品左[j].物品.特性,
							tp.场景.抓取物品 = nil
							tp.场景.抓取物品ID = nil
							tp.场景.抓取物品注释 = nil
							self:计算属性(self.神器属性)
						end
					end
					if mouseb(0) then
						self.选中卡槽 = j
					end
				end
				if self.物品左[j].物品 ~= nil  then
					self.物品左[j]:置坐标(self.x+神器已解锁卡槽坐标[j][1]+9,self.y+神器已解锁卡槽坐标[j][2]+8)
					self.物品左[j]:显示(dt,x,y,self.鼠标,nil,nil,nil,true)
					self.资源组[26]:显示(self.x+神器已解锁卡槽坐标[j][1]+33,self.y+神器已解锁卡槽坐标[j][2]+36)
					if self.物品左[j].物品.特性 ~= "无" then
						zt1:置颜色(黄色):显示(self.x+神器已解锁卡槽坐标[j][1]+17,self.y+神器已解锁卡槽坐标[j][2]+40,self.物品左[j].物品.特性)
					end
					if self.物品左[j].焦点 then
						tp.提示:道具行囊(x,y,self.物品左[j].物品,true)
					end
				end
			else
				self.神器已解封卡槽[self.主显示部件][j]:更新(x,y)
				self.神器已解封卡槽[self.主显示部件][j]:显示(self.x+神器卡槽坐标[j][1],self.y+神器卡槽坐标[j][2])
				if self.神器已解封卡槽[self.主显示部件][j]:事件判断() then
					-- 请求服务(159,{部件=self.主显示部件,插槽位=j})
					tp.窗口.对话栏:文本("","","神器被某种力量封印，需要100点解锁点和50000000经验激活，现有解锁点："..self.神器属性.神器解锁点.."点，是否继续激活这个插槽？",{"确定紅","取消"},{部件=self.主显示部件,插槽位=j})
				end
			end
			self.资源组[14]:显示(self.x+棱形坐标[j][1],self.y+棱形坐标[j][2])
			self.五行显示图[self.主显示部件][j]:显示(self.x+五行坐标[j][1],self.y+五行坐标[j][2])
			if self.预览开关[j] == false then
				zt3:置颜色(白色):显示(self.x + 290,self.y + 233 + (j-1)*25,self.miaoshu[self.神器属性.神器解锁[self.主显示部件].神器五行属性[j]].." +"..self.神器属性.神器解锁[self.主显示部件].神器五行数值[j])
			else
				zt3:置颜色(黄色):显示(self.x + 290,self.y + 233 + (j-1)*25,self.miaoshu[self.神器属性.神器解锁[self.主显示部件].神器五行属性[j]].." +"..self.临时镶嵌属性[j])
				zt3:置颜色(绿色):显示(self.x + 290,self.y + 233 + (j-1)*25,"            ↑")
			end
		end
		if self.选中卡槽~=nil then
			self.资源组[18]:显示(self.x+神器已解锁卡槽坐标[self.选中卡槽][1],self.y+神器已解锁卡槽坐标[self.选中卡槽][2])
		end
	else
		self.资源组[17]:更新(x,y)
		self.资源组[12]:显示(self.x + 184,self.y + 134)
		self.资源组[17]:显示(self.x + 257,self.y + 433)
		for j=1,4 do
			self.神器未解封卡槽[self.主显示部件][j]:显示(self.x+神器卡槽坐标[j][1],self.y+神器卡槽坐标[j][2])
			self.资源组[16]:灰度级()
			self.资源组[16]:显示(self.x+棱形坐标[j][1],self.y+棱形坐标[j][2])
		end
		if self.神器锁链[self.主显示部件]~=nil then
			self.神器锁链[self.主显示部件]:显示(self.x + 317,self.y + 366)
		end
	end

	if self.资源组[21].接触 then
		滑动数值 = math.ceil(270*self.资源组[21]:取百分比())
		self.物品加入 = math.floor(滑动数值 / (270 / (self.灵犀玉数量 - 4)))
		self.焦点 = true
	end

	if self.资源组[2]:事件判断() or self.资源组[15]:事件判断() then
		self.可视 = false
	elseif self.资源组[7]:事件判断() then
		-- 请求服务(158)

			tp.窗口.对话栏:文本("","","您是否需要5000000两梦幻币购买50点神器解锁点？",{"确定藍","取消"})

	elseif self.资源组[8]:事件判断() then
		self.灵犀玉背景展开 = true
	elseif self.资源组[10]:事件判断() then
		self.灵犀玉背景展开 = false
	elseif self.资源组[27]:事件判断() then --保存
		-- table.print(self.灵犀玉)
		-- table.print(self.临时镶嵌属性)
		请求服务(3774,{灵犀玉=self.灵犀玉,部件=self.镶嵌部位,客户端属性=self.临时镶嵌属性}) --发送到道具
		self.灵犀玉={}
		for i=1,4 do
			self.临时镶嵌属性[i]=self.神器属性.神器解锁[self.主显示部件].神器五行数值[i]
		end
		-- self.临时镶嵌属性={}
	elseif self.资源组[28]:事件判断() then --放弃本次
		请求服务(6205)
	elseif self.资源组[17]:事件判断() then
		local 修复 = true
		for n=1,3 do
			if self.神器属性.神器解锁[n]~=nil then
				if #self.神器属性.神器解锁[n].神器卡槽解锁 ~= 4 then
					修复 = false
					break
				end
			end
		end
		if 修复 then
			local 事件 = function()
			请求服务(6204,{区域=self.主显示部件})
			end
			tp.窗口.文本栏:载入("这个部件被未知的力量封印，解锁这个部件需消耗#R5000000#W两梦幻币。",nil,true,事件)
		else
			tp.常规提示:打开("#Y/请先将已解锁区域的卡槽全部修复后，才能继续解锁该区域。")
		end
	end

end

function 修复神器:镶嵌完成(数据)
	-- table.print(数据)
	self.神器属性 = 数据.神器
	self.灵犀玉数量 = 0
	self.数 = 1
	self.灵犀玉物品 = 数据.灵犀玉
	for n=1,100 do
		self.物品右[n]:置物品(nil)
		if self.灵犀玉物品.道具[n]~=nil then
			self.物品右[self.数]:置根(tp)
			self.物品右[self.数]:置物品(self.灵犀玉物品.道具[n],true) --tp.道具列表[q]
			self.物品右[self.数].物品格子 = n
			self.数 = self.数 + 1
			-- table.print(self.灵犀玉物品.道具[n])
		end
		if self.灵犀玉物品.道具[n]~=nil then
			self.灵犀玉数量 = self.灵犀玉数量 + 1
		end
	end
	for i=1,4 do
		self.预览开关[i] = false
	end
	-- self.已更改 = false
end

function 修复神器:放弃镶嵌(数据)
	self.灵犀玉={}
	for i=1,4 do
		self.预览开关[i] = false
	end
	-- self.临时镶嵌属性={}
	for i=1,4 do
		self.临时镶嵌属性[i]=self.神器属性.神器解锁[self.主显示部件].神器五行数值[i]
	end
	self.神器属性 = 数据
	local lxy={}
	if 数据.神器解锁[self.主显示部件]~=nil then
		-- print(2)
		lxy = 数据.神器解锁[self.主显示部件].镶嵌灵犀玉
	end
	-- table.print(lxy)
	if not 判断是否为空表(lxy) then
		-- print(123)
		for i=1,4 do
			self.物品左[i]:置物品(nil)
			if not 判断是否为空表(lxy[i]) then
				local 玉 = tp._物品.创建()
				玉:置对象("灵犀玉")
				玉.子类 = lxy[i].子类
				玉.特性 = lxy[i].特性
				self.物品左[i]:置物品(玉)
			end
		end
	end
end

function 修复神器:更新已镶嵌灵犀玉(数据)

	local lxy={}
	if 数据.神器解锁[self.主显示部件]~=nil then
		-- print(2)
		lxy = 数据.神器解锁[self.主显示部件].镶嵌灵犀玉
	end
	-- table.print(lxy)
	if not 判断是否为空表(lxy) then
		-- print(123)
		for i=1,4 do
			self.物品左[i]:置物品(nil)
			if not 判断是否为空表(lxy[i]) then
				local 玉 = tp._物品.创建()
				玉:置对象("灵犀玉")
				玉.子类 = lxy[i].子类
				玉.特性 = lxy[i].特性
				self.物品左[i]:置物品(玉)
			end
		end
	end
end

function 修复神器:计算属性(神器)
	--等会儿要写一个 每个插槽是否受到影响，受到影响那么就给他的预览开关打开
	local sq = 神器.神器解锁[self.主显示部件]
	--这里加上灵犀玉基础属性
	sq.镶嵌灵犀玉[self.镶嵌插槽].子类 = self.镶嵌等级
	sq.镶嵌灵犀玉[self.镶嵌插槽].特性 = self.镶嵌特性

	--重新给每个插槽赋值
	for i=1,4 do
		self.特性激活[i] = {蔓延=false,天平=false,相生=false,相克=false,耀=false}
		self.预览开关[i] = false
		-- self.灵犀玉基础属性[i] = 0
	end
	-- table.print(sq.镶嵌灵犀玉)
	for i=1,4 do
		if not 判断是否为空表(sq.镶嵌灵犀玉[i]) then
			if sq.神器五行属性[i]=="速度" or sq.神器五行属性[i]=="防御" or sq.神器五行属性[i]=="法术防御"
					or sq.神器五行属性[i]=="封印命中" or sq.神器五行属性[i]=="抵抗封印" then
				if sq.镶嵌灵犀玉[i].子类==1 then
					self.灵犀玉基础属性[i]=6
				elseif sq.镶嵌灵犀玉[i].子类==2 then
					self.灵犀玉基础属性[i]=12
				else
					self.灵犀玉基础属性[i]=24
				end
				-- print(sq.镶嵌灵犀玉[i].子类)
				-- print("===============")
				-- print(self.灵犀玉基础属性[i])
			elseif sq.神器五行属性[i]=="气血" then
				if sq.镶嵌灵犀玉[i].子类==1 then
					self.灵犀玉基础属性[i]=9
				elseif sq.镶嵌灵犀玉[i].子类==2 then
					self.灵犀玉基础属性[i]=18
				else
					self.灵犀玉基础属性[i]=36
				end
			else
				if sq.镶嵌灵犀玉[i].子类==1 then
					self.灵犀玉基础属性[i]=3
				elseif sq.镶嵌灵犀玉[i].子类==2 then
					self.灵犀玉基础属性[i]=6
				else
					self.灵犀玉基础属性[i]=12
				end
			end
		end
	end
	for i=1,4 do
		if not 判断是否为空表(sq.镶嵌灵犀玉[i]) then
			for n=1,4 do
				if sq.镶嵌灵犀玉[i].特性==sq.神器五行[n].."耀" then
					self.特性激活[n].耀=true
					self.预览开关[n]=true
				end
			end
			if sq.镶嵌灵犀玉[i].特性=="蔓延" and (i==1 or i==3) then
				self.特性激活[2].蔓延=true
				self.特性激活[4].蔓延=true
				self.预览开关[2]=true
				self.预览开关[4]=true
			end
			if sq.镶嵌灵犀玉[i].特性=="天平" and (i==2 or i==4) then
				self.特性激活[2].天平=true
				self.特性激活[4].天平=true
				self.预览开关[2]=true
				self.预览开关[4]=true
				-- print(self.灵犀玉基础属性[2])
			end
			if sq.镶嵌灵犀玉[i].特性=="相生" then
				if i==1 or i==3 then
					if self:取五行相生(sq.神器五行[i])==sq.神器五行[2] then
						self.特性激活[2].相生=true
						self.预览开关[2]=true
					end
					if self:取五行相生(sq.神器五行[i])==sq.神器五行[4] then
						self.特性激活[4].相生=true
						self.预览开关[4]=true
					end
				elseif i==2 or i==4 then
					if self:取五行相生(sq.神器五行[i])==sq.神器五行[1] then
						self.特性激活[1].相生=true
						self.预览开关[1]=true
					end
					if self:取五行相生(sq.神器五行[i])==sq.神器五行[3] then
						self.特性激活[3].相生=true
						self.预览开关[3]=true
					end
				end
			end
			if sq.镶嵌灵犀玉[i].特性=="相克" then
				if i==1 or i==3 then
					if self:取五行相克(sq.神器五行[i])==sq.神器五行[2] then
						self.特性激活[2].相克=true
						self.预览开关[2]=true
					end
					if self:取五行相克(sq.神器五行[i])==sq.神器五行[4] then
						self.特性激活[4].相克=true
						self.预览开关[4]=true
					end
				elseif i==2 or i==4 then
					if self:取五行相克(sq.神器五行[i])==sq.神器五行[1] then
						self.特性激活[1].相克=true
						self.预览开关[1]=true
					end
					if self:取五行相克(sq.神器五行[i])==sq.神器五行[3] then
						self.特性激活[3].相克=true
						self.预览开关[3]=true
					end
				end
			end
			if sq.镶嵌灵犀玉[i].特性=="利"..sq.神器五行[i] then
				self.特性激活[i].利=true
				self.预览开关[i]=true
			end
		end
	end
	---上面的所有激活特性全部计算完后再计算属性加成
	for i=1,4 do
		if not 判断是否为空表(sq.镶嵌灵犀玉[i]) then
			if self.特性激活[i].耀 then --受影响的全部插槽的属性全部加
				if sq.神器五行属性[i]=="伤害" or sq.神器五行属性[i]=="法术伤害" or sq.神器五行属性[i]=="固定伤害"  then
					self.灵犀玉基础属性[i]=self.灵犀玉基础属性[i]+8
				elseif sq.神器五行属性[i]=="气血" then
					self.灵犀玉基础属性[i]=self.灵犀玉基础属性[i]+10
				else
					self.灵犀玉基础属性[i]=self.灵犀玉基础属性[i]+4
				end
			end





			if self.特性激活[i].蔓延 then
				-- print(i)
				if sq.神器五行属性[i]=="伤害" or sq.神器五行属性[i]=="法术伤害" or sq.神器五行属性[i]=="固定伤害"  then
					self.灵犀玉基础属性[i]=self.灵犀玉基础属性[i]+8
				elseif sq.神器五行属性[i]=="气血" then
					self.灵犀玉基础属性[i]=self.灵犀玉基础属性[i]+10
				else
					self.灵犀玉基础属性[i]=self.灵犀玉基础属性[i]+4
				end
			end
			if self.特性激活[i].天平 then
				-- print(i)
				if sq.神器五行属性[i]=="伤害" or sq.神器五行属性[i]=="法术伤害" or sq.神器五行属性[i]=="固定伤害"  then
					self.灵犀玉基础属性[i]=self.灵犀玉基础属性[i]+8
				elseif sq.神器五行属性[i]=="气血" then
					self.灵犀玉基础属性[i]=self.灵犀玉基础属性[i]+10
				else
					self.灵犀玉基础属性[i]=self.灵犀玉基础属性[i]+4
				end
			end
			if self.特性激活[i].相生 then
				if sq.神器五行属性[i]=="伤害" or sq.神器五行属性[i]=="法术伤害" or sq.神器五行属性[i]=="固定伤害"  then
					self.灵犀玉基础属性[i]=self.灵犀玉基础属性[i]+8
				elseif sq.神器五行属性[i]=="气血" then
					self.灵犀玉基础属性[i]=self.灵犀玉基础属性[i]+10
				else
					self.灵犀玉基础属性[i]=self.灵犀玉基础属性[i]+4
				end
			end
			if self.特性激活[i].相克 then
				if sq.神器五行属性[i]=="伤害" or sq.神器五行属性[i]=="法术伤害" or sq.神器五行属性[i]=="固定伤害" then
					self.灵犀玉基础属性[i]=self.灵犀玉基础属性[i]+8
				elseif sq.神器五行属性[i]=="气血" then
					self.灵犀玉基础属性[i]=self.灵犀玉基础属性[i]+10
				else
					self.灵犀玉基础属性[i]=self.灵犀玉基础属性[i]+4
				end
			end
			if self.特性激活[i].利 then
				if sq.神器五行属性[i]=="伤害" or sq.神器五行属性[i]=="法术伤害" or sq.神器五行属性[i]=="固定伤害"  then
					self.灵犀玉基础属性[i]=self.灵犀玉基础属性[i]+8
				elseif sq.神器五行属性[i]=="气血" then
					self.灵犀玉基础属性[i]=self.灵犀玉基础属性[i]+10
				else
					self.灵犀玉基础属性[i]=self.灵犀玉基础属性[i]+4
				end
			end
			-- print(self.灵犀玉基础属性[2])
			self.临时镶嵌属性[i]=self.灵犀玉基础属性[i]
			if self.临时镶嵌属性[i]~=self.原本镶嵌属性[i] then
				self.预览开关[i]=true
			end
		end
	end

	-- table.print(self.灵犀玉基础属性)
end


function 修复神器:解锁区域(数据)
	self.解封动画 = true
	self.存储数据 = 数据
	self:更新已镶嵌灵犀玉(数据)

end




function 修复神器:解锁更新内容()
	self.神器属性 = self.存储数据
	for n=1,3 do
		if self.神器属性.神器解锁[n]~=nil then
		    self.神器显示图[n] = tp._按钮.创建(tp.资源:载入("新加界面.npk","网易WDF动画",神器图[self.门派][n]),0,0,3,true,true)
			self.神器已解封卡槽[n] = {}
			self.五行显示图[n] = {}
			for j=1,4 do
				if self.神器属性.神器解锁[n].神器卡槽解锁[j]~=nil then
					self.神器已解封卡槽[n][j] = tp.资源:载入('新加界面.npk',"网易WDF动画","01AC0109") --无锁
				else
					self.神器已解封卡槽[n][j] = tp._按钮.创建(tp.资源:载入("新加界面.npk","网易WDF动画","01AC0110"),0,0,3,true,true) --有锁
				end
				self.五行显示图[n][j] = tp.资源:载入('新加界面.npk',"网易WDF动画",五行图[self.神器属性.神器解锁[n].神器五行[j]])
			end
		else
			self.神器未解封卡槽[n] = {}

				self.神器显示图[n] = tp._按钮.创建(tp.资源:载入("新加界面.npk","网易WDF动画",神器图[self.门派][n]),0,0,3,true,true)
			for j=1,4 do
				self.神器未解封卡槽[n][j] = tp.资源:载入('新加界面.npk',"网易WDF动画","01AC0108")
			end
		end
	end

	tp.常规提示:打开("#Y/恭喜你成功解锁一个全新的区域。")
end

function 修复神器:更新(数据)
	self.神器属性.神器解锁点 = 数据
end

function 修复神器:激活插槽更新(数据)
	-- table.print(数据)
	self.神器属性 = 数据
	for j=1,4 do
		if self.神器属性.神器解锁[self.主显示部件].神器卡槽解锁[j]~=nil then
			self.神器已解封卡槽[self.主显示部件][j] = tp.资源:载入('新加界面.npk',"网易WDF动画","01AC0109") --无锁
		else
			self.神器已解封卡槽[self.主显示部件][j] = tp._按钮.创建(tp.资源:载入("新加界面.npk","网易WDF动画","01AC0110"),0,0,3,true,true) --有锁
		end
	end
end

function 修复神器:取五行相生(五行)
  local 相生="水"
  if 五行=="金" then
	 相生="水"
  elseif 五行=="水" then
	 相生="木"
  elseif 五行=="木" then
	 相生="水"
  elseif 五行=="火" then
	 相生="土"
  elseif 五行=="土" then
	 相生="金"
  end
  return 相生
end

function 修复神器:取五行相克(五行)
  local 相克="木"
  if 五行=="金" then
	 相克="木"
  elseif 五行=="木" then
	 相克="土"
  elseif 五行=="土" then
	 相克="水"
  elseif 五行=="水" then
	 相克="火"
  elseif 五行=="火" then
	 相克="金"
  end
  return 相克
end

function 修复神器:初始移动(x,y)
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

function 修复神器:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end
function 修复神器:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y) and tp.场景.抓取物品 == nil then
		return true
	else
		return false
	end
end
return 修复神器