local 法宝 = class()
local insert = table.insert
local mousea = 引擎.鼠标弹起

local 神器大图与坐标 = {
		大唐官府 = {"01AC0090",320,100,"01AC0046"},
		化生寺 = {"01AC0092",330,120,"01AC0052"},
		方寸山 = {"01AC0091",320,100,"01AC0057"},
		女儿村 = {"01AC0093",300,70,"01AC0055"},
		天宫 = {"01AC0099",310,90,"01AC0059"},
		普陀山 = {"01AC0104",305,85,"01AC0058"},
		龙宫 = {"01AC0102",310,90,"01AC0051"},
		五庄观 = {"01AC0100",320,100,"01AC0047"},
		魔王寨 = {"01AC0096",310,100,"01AC0053"},
		狮驼岭 = {"01AC0097",325,105,"01AC0050"},
		盘丝洞 = {"01AC0098",310,95,"01AC0056"},
		阴曹地府 = {"01AC0095",310,90,"01AC0049"},
		神木林 = {"01AC0094",300,75,"01AC0045"},
		凌波城 = {"01AC0101",300,95,"01AC0048"},
		无底洞 = {"01AC0103",320,100,"01AC0054"},
		花果山 = {"0C000015",320,100,"01AC0054"},
		九黎城 = {"mxj.png",320,100,"mxj.png"},
	}

local 神器属性 = {
		大唐官府 = {"伤　　害","物理暴击"},化生寺 = {"防　　御","治疗能力"},方寸山 = {"封印命中","法术伤害"},女儿村 = {"封印命中","固定伤害"},天宫 = {"法术伤害","封印命中"},
		普陀山 = {"固定伤害","治疗能力"},龙宫 = {"法术伤害","法术暴击"},五庄观 = {"伤　　害","封印命中"},魔王寨 = {"法术伤害","法术暴击"},狮驼岭 = {"伤　　害","物理暴击"},
		盘丝洞 = {"封印命中","法术防御"},阴曹地府 = {"伤　　害","法术防御"},神木林 = {"法术伤害","法术暴击"},凌波城 = {"伤　　害","物理暴击"},无底洞 = {"封印命中","治疗能力"},
		花果山 = {"伤害","物理暴击"},九黎城 = {"伤害","物理暴击"}
	}

local 神器技能 = {
		藏锋敛锐 = {[1]= "横扫千军消耗的气血有50%的几率转化为等量护盾。",[2]="横扫千军消耗的气血有100%的几率转化为等量护盾。"},                 ---大唐
		惊锋     = {[1]= "每次攻击提升自身10点伤害，最多叠加12层，死亡后清零。",[2]="每次攻击提升自身20点伤害，最多叠加12层，死亡后清零。"},     ---大唐
		披坚执锐 = {[1]= "遭受攻击时，有4%的几率免受90%的伤害。",[2]="遭受攻击时，有8%的几率免受90%的伤害。"},
		金汤之固 = {[1]= "气血小于30%时，提升240点抗封等级。",[2]="气血小于30%时，提升480点抗封等级。"},
		风起云墨 = {[1]= "受到你治疗的首目标本回合内受到的所有伤害降低4%。",[2]="受到你治疗的首目标本回合内受到的所有伤害降低8%。"},
		挥毫     = {[1]= "受到你的治疗时，目标每带有一个增益状态，额外恢复25点气血。",[2]="受到你的治疗时，目标每带有一个增益状态，额外恢复50点气血。"},
		盏中晴雪 = {[1]= "若你的速度高于施法者，提升速度差×0.5的抗封等级。",[2]="若你的速度高于施法者，提升速度差×1的抗封等级。"},
		泪光盈盈 = {[1]= "笑里藏刀额外减少目标6点愤怒。",[2]="笑里藏刀额外减少目标12点愤怒。"},
		凭虚御风 = {[1]= "每点被消耗的风灵增加40点法术伤害结果，最多叠加三层，死亡后清零。",[2]="每点被消耗的风灵增加80点法术伤害结果，最多叠加三层，死亡后清零。"},
		钟灵     = {[1]= "被使用3级药是有一定几率获得1层风灵。",[2]="被使用3级药是有较大几率获得1层风灵。"},
		亡灵泣语 = {[1]= "你的锢魂术会使得目标额外受到5%的物法伤害。",[2]="你的锢魂术会使得目标额外受到10%的物法伤害。"},
		魂魇     = {[1]= "被你的物理伤害攻击的单位在当回合内的法术伤害结果减少100点。",[2]="被你的物理伤害攻击的单位在当回合内的法术伤害结果减少200点。"},
		业焰明光 = {[1]= "你的法术有25%的几率造成额外25%的伤害。",[2]="你的法术有25%的几率造成额外50%的伤害。"},
		流火     = {[1]= "攻击气血百分比小于你的单位时，增加8%的伤害。",[2]="攻击气血百分比小于你的单位时，增加16%的伤害。"},
		蛮血     = {[1]= "增加（1-自身气血/气血上限）×8%的狂暴几率。",[2]="增加（1-自身气血/气血上限）×16%的狂暴几率。"},
		狂战     = {[1]= "每有一个己方召唤兽被击飞，增加30点伤害力，可叠加4层，死亡后消失。",[2]="每有一个己方召唤兽被击飞，增加60点伤害力，可叠加4层，死亡后消失。"},
		镜花水月 = {[1]= "受到治疗时，有8%的几率获得一个等额度的护盾。",[2]="受到治疗时，有16%的几率获得一个等额度的护盾。"},
		澄明     = {[1]= "每回合结束时，增加3点抵抗封印等级。",[2]="每回合结束时，增加6点抵抗封印等级。"},
		情思悠悠 = {[1]= "地涌金莲的目标获得治疗量10%的护盾。",[2]="地涌金莲的目标获得治疗量20%的护盾。"},
		相思     = {[1]= "偶数回合结束时，增加3点速度。",[2]="每个回合结束时，增加3点速度。"},
		弦外之音 = {[1]= "回合结束时，每个主动法宝效果会增加你3点愤怒。",[2]="回合结束时，每个主动法宝效果会增加你6点愤怒。"},
		裂帛     = {[1]= "伤害性法术首目标伤害增加8%。",[2]="伤害性法术首目标伤害增加16%。"},
		定风波   = {[1]= "受到的法术暴击伤害降低30%。",[2]="受到的法术暴击伤害降低60%。"},
		沧浪赋   = {[1]= "攻击气血小于30%的目标时，额外提升120点的法术伤害。",[2]="攻击气血小于30%的目标时，额外提升240点的法术伤害。"},
		斗转参横 = {[1]= "带有状态生命之泉时，日月乾坤命中率增加3%。",[2]="带有状态生命之泉时，日月乾坤命中率增加6%。"},
		静笃     = {[1]= "每次击杀敌方单位，增加60点伤害。",[2]= "每次击杀敌方单位，增加120点伤害。"},
		玉魄     = {[1]= "消耗愤怒的100%转化为下一次释放恢复性技能时的治疗能力。",[2]="消耗愤怒的200%转化为下一次释放恢复性技能时的治疗能力。"},
		璇华     = {[1]= "使用五行法术时，增加10%的伤害。",[2]="使用五行法术时，增加20%的伤害。"},
		威服天下 = {[1]= "暴击伤害增加12%。",[2]="暴击伤害增加24%。"},
		酣战     = {[1]= "每点消耗的战意，会提升30点物理暴击等级，可叠加6次，死亡后清零。",[2]="每点消耗的战意，会提升60点物理暴击等级，可叠加6次，死亡后清零。"},
		万物滋长 = {[1]= "使用特技时将会获得（消耗愤怒值×等级×5%）的护盾和气血回复。",[2]="使用特技时将会获得（消耗愤怒值×等级×10%）的护盾和气血回复。"},
		开辟     = {[1]= "每次使用如意神通，提升20点自身伤害，最多叠加6层，死亡后清零。",[2]="每次使用如意神通，提升40点自身伤害，最多叠加6层，死亡后清零。"},
		鸣空     = {[1]= "每当令目标浮空时，你获得12点狂暴等级并且造成的物理伤害结果提高2%，最多叠加6层，阵亡后清零",[2]="每当令目标浮空时，你获得24点狂暴等级并且造成的物理伤害结果提高2%，最多叠加6层，阵亡后清零"},
		骇神     = {[1]= "受到物理伤害时，若攻击者物理伤害低于你，伤害结果降低10%",[2]="受到物理伤害时，若攻击者物理伤害低于你，伤害结果降低20%"},


	}
local 门派神器名称 = {
	    大唐官府 = "轩辕剑",化生寺 = "墨魂笔",方寸山 = "黄金甲",女儿村 = "泪痕碗",天宫 = "独弦琴",
	    普陀山 = "华光玉",龙宫 = "清泽谱",五庄观 = "星斗盘",魔王寨 = "明火珠",狮驼岭 = "噬魂齿",
	    盘丝洞 = "昆仑镜",阴曹地府 = "四神鼎",神木林 = "月光草",凌波城 = "天罡印",无底洞 = "玲珑结",
	    花果山 = "鸿蒙石",九黎城 = "魔息角",
	}



function 法宝:初始化(根)
    self.ID = 41
	self.x = 310
	self.y = 0
	self.xx = 0
	self.yy = 0
	self.注释 = "法宝类"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.右键关闭=nil
	local 字体 = tp.字体表.新字体4
	self.法宝数量 = 0
	self.法宝选中 = 0
	self.佩戴选中 = 0
	self.灵宝选中 = 0
	self.灵宝佩戴 = 0
	self.灵宝数量 = 0
	self.时间 = 0
end

function 法宝:加载资源()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.背景 = 资源:载入('nice.rpk',"网易WDF动画",0x1F73D091)
	self.关闭 = 按钮.创建(资源:载入('nice.rpk',"网易WDF动画",0x81DD40D3),0,0,3,true,true)
	self.资源组 = {
		[1] = 按钮.创建(资源:载入('nice.rpk',"网易WDF动画",0x1F73D093),0,0,3,true,true,"1"),
		[2] = 按钮.创建(资源:载入('nice.rpk',"网易WDF动画",0x1F73D093),0,0,3,true,true,"2"),
		[3] = 按钮.创建(资源:载入('nice.rpk',"网易WDF动画",0x1F73D093),0,0,3,true,true,"3"),
		[4] = 按钮.创建(资源:载入('nice.rpk',"网易WDF动画",0x1F73D093),0,0,3,true,true,"看"),
		[5] = 按钮.创建(资源:载入('nice.rpk',"网易WDF动画",0x1F73D099),0,0,3,true,true,"背包"),
		[6] = 按钮.创建(资源:载入('nice.rpk',"网易WDF动画",0x1F73D099),0,0,3,true,true,"行囊"),
		[7] = 按钮.创建(自适应.创建(12,4,58,20,1,3),0,0,4,true,true,"法宝"),
		[8] = 按钮.创建(自适应.创建(12,4,58,20,1,3),0,0,4,true,true,"神器"),
		[9] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"装备"),
		[10] = 按钮.创建(自适应.创建(12,4,58,20,1,3),0,0,4,true,true,"灵宝"),
	}

	for i=2,8 do
		self.资源组[i]:绑定窗口_(41)
	end
	self.关闭:绑定窗口_(41)
	local 格子 = tp._物品格子
	self.法宝列表 = {}
	for i=1,100 do
		self.法宝列表[i] = 格子(0,0,nil,"法宝")
	end
	self.佩戴法宝 = {}
	for n=1,4 do
	    self.佩戴法宝[n] = 格子(0,0,nil,"佩戴法宝")
	end
     self.佩戴灵宝 = {}
	for i=1,2 do
		self.佩戴灵宝[i] = 格子(0,0,nil,"佩戴灵宝")
	end
	self.灵宝列表 = {}
	for i=1,100 do
		self.灵宝列表[i] = 格子(0,0,nil,"灵宝")
	end
	self.佩戴神器 = 格子(0,0,nil,"佩戴神器")
	self.shenqizu={
		[12] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0041"),
		[13] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0042"),
		[14] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0043"),
		[15] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0044"),
		}

	self.介绍文本 = tp._丰富文本(100,300)
	self.物品单格子 = 资源:载入('nice.rpk',"网易WDF动画",0x1F73D092)
	self.物品列表单格子 = 资源:载入('nice.rpk',"网易WDF动画",0x1F73D097)
	self.物品格子背景 = 资源:载入('nice.rpk',"网易WDF动画",0x1F73D094)
	self.滑动条 = 资源:载入('nice.rpk',"网易WDF动画",0x1F73D095)
	self.文本显示背景 = 资源:载入('nice.rpk',"网易WDF动画",0x1F73D096)
	self.使用 = 按钮.创建(资源:载入('nice.rpk',"网易WDF动画",0x1F73D098),0,0,3,true,true,"使用")
	self.修炼 = 按钮.创建(资源:载入('nice.rpk',"网易WDF动画",0x1F73D098),0,0,3,true,true,"修炼")
	self.补充灵气 = 按钮.创建(资源:载入('nice.rpk',"网易WDF动画",0x1F73D098),0,0,3,true,true,"补充灵气")
	self.佩戴选中光圈 = 资源:载入('nice.rpk',"网易WDF动画",0x1F73D101)
	self.快速卸下法宝 = 按钮.创建(资源:载入('nice.rpk',"网易WDF动画",0x1F73D100),0,0,3,true,true)
	self.使用:绑定窗口_(41)
	self.修炼:绑定窗口_(41)
	self.补充灵气:绑定窗口_(41)
	self.快速卸下法宝:绑定窗口_(41)
	self.使用:置偏移(28,8)
 	self.修炼:置偏移(28,8)
	self.补充灵气:置偏移(15,8)
	self.资源组[5]:置偏移(28,4)
	self.资源组[6]:置偏移(28,4)
	self.资源组[7]:置偏移(8,-2)
	self.资源组[8]:置偏移(8,-2)
	self.资源组[10]:置偏移(8,-2)
	--self.资源组[9]:置偏移(3,3)

end

function 法宝:打开()
	if self.可视 then
		self.可视 = false
		self.鼠标 = false
		self.焦点 = false
		self.背景=nil
		self.关闭=nil
		self.资源组=nil
		self.法宝列表=nil
		self.灵宝列表=nil
		self.佩戴法宝=nil
		self.佩戴灵宝=nil
		self.佩戴神器=nil
		self.物品列表单格子 = nil
		self.物品格子背景 = nil
		self.滑动条 = nil
		self.文本显示背景 = nil
		self.使用 = nil
		if tp.窗口.法宝方案2.可视 then
	    	tp.窗口.法宝方案2:打开()
	    end
	    if tp.窗口.法宝方案3.可视 then
	    	tp.窗口.法宝方案3:打开()
	    end
		self.修炼 = nil
		self.补充灵气 = nil
		self.佩戴选中光圈 = nil
		self.快速卸下法宝 = nil
		return

	else
		insert(tp.窗口_,self)
		self:加载资源()
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.x = (全局游戏宽度/2)-272
		self.y = (全局游戏高度/2)-157
		if self.法宝选中~=0 and self.法宝列表[self.法宝选中].确定 then
	    	self.法宝列表[self.法宝选中].确定=false
	    end
	    self.窗口="法宝"
		self.法宝选中 = 0
		self.佩戴选中 = 0
		self.法宝数量 = 0
	    for i=1,100 do
	    	if tp.队伍[1].法宝[i]~=nil then
	    		self.法宝列表[i]:置根(tp)
	        	self.法宝列表[i]:置物品(tp.队伍[1].法宝[i])
	        	self.法宝数量 = self.法宝数量 + 1
	        else
	            self.法宝列表[i]:置物品(nil)
	        end
	    end
	    for i=1,4 do
	    	if tp.队伍[1].法宝佩戴[i]~=nil then
	    		self.佩戴法宝[i]:置根(tp)
	        	self.佩戴法宝[i]:置物品(tp.队伍[1].法宝佩戴[i])
	        else
	            self.佩戴法宝[i]:置物品(nil)
	        end
	    end

	    self.方案=1
      ----------------------------------------------------灵宝
      if self.灵宝选中~=0 and self.灵宝列表[self.灵宝选中].确定 then
	    	self.灵宝列表[self.灵宝选中].确定=false
	    end
		self.灵宝选中 = 0
		self.灵宝佩戴 = 0
		self.灵宝数量 = 0
	    for i=1,100 do
	    	if tp.队伍[1].灵宝[i]~=nil then
	    		self.灵宝列表[i]:置根(tp)
	        	self.灵宝列表[i]:置物品(tp.队伍[1].灵宝[i])
	        	self.灵宝数量 = self.灵宝数量 + 1
	        else
	            self.灵宝列表[i]:置物品(nil)
	        end
	    end
	    for i=1,2 do
	    	if tp.队伍[1].灵宝佩戴[i]~=nil then
	    		self.佩戴灵宝[i]:置根(tp)
	        	self.佩戴灵宝[i]:置物品(tp.队伍[1].灵宝佩戴[i])
	        else
	            self.佩戴灵宝[i]:置物品(nil)
	        end
	    end
	     self.佩戴神器:置物品(nil)
     -----------------------------------------------------------------
	    -- tp.窗口.法宝方案2:打开(self.x,self.y,self.ID+self.方案,"方案"..self.方案+1)
	    -- tp.窗口.法宝方案3:打开(self.x,self.y,self.ID+self.方案+1,"方案"..self.方案+2)
        if tp.队伍[1].神器数据 and tp.队伍[1].神器数据.神器技能 and tp.队伍[1].门派~=nil and tp.队伍[1].门派~="无门派" and tp.队伍[1].门派~="无" and tp.队伍[1].门派~="" then
           self:神器刷新(tp.队伍[1].神器数据)
        end



	end
end

function 法宝:更新(dt)

end



function 法宝:神器刷新(数据)
	if not 数据 or not 数据.神器技能 then return end
	if  tp.队伍[1].门派=="九黎城" then
		self.神器图片集 = tp.资源:载入(wdf配置.."/pic/神器素材/mxj.png", "图片")
	else
	    self.神器图片集 = tp.资源:载入('新加界面.npk',"网易WDF动画",神器大图与坐标[tp.队伍[1].门派][1])
		self.神器文字集 = tp.资源:载入('新加界面.npk',"网易WDF动画",神器大图与坐标[tp.队伍[1].门派][4])
	end
	self.神器属性 = 数据
	self.属性数值 = {速度=0,气血=0,抵抗封印=0}
	for n=1,2 do
	    if 神器属性[tp.队伍[1].门派][n] == "伤　　害" then
	    	self.属性数值.伤害 = 0
	    elseif 神器属性[tp.队伍[1].门派][n] == "防　　御" then
	    	self.属性数值.防御 = 0
	    else
	        self.属性数值[神器属性[tp.队伍[1].门派][n]] = 0
	    end
	end
    self.介绍文本:清空()
	self.介绍文本:添加文本(神器技能[self.神器属性.神器技能.名称][self.神器属性.神器技能.等级])
	for k,v in pairs(self.神器属性.神器解锁) do
	    for n=1,#v.神器五行属性 do
	    	if self.属性数值[v.神器五行属性[n]] then
	    	    self.属性数值[v.神器五行属性[n]] = self.属性数值[v.神器五行属性[n]] + v.神器五行数值[n]
	    	end

	    end
	end
	self.佩戴神器:置物品(nil)
	if tp.队伍[1].神器佩戴 then
          self.佩戴神器:置物品({名称=门派神器名称[tp.队伍[1].门派]})
    end
	self.miaoshu={}
	self.miaoshu["速度"]={"速　　度",177}
	self.miaoshu["气血"]={"气　　血",202}
	self.miaoshu["伤害"]={"伤　　害",227}
	self.miaoshu["防御"]={"防    御",227}
	self.miaoshu["封印命中"]={"封印命中",227}
	self.miaoshu["法术伤害"]={"法术伤害",227}
	self.miaoshu["固定伤害"]={"固定伤害",227}
	self.miaoshu["物理暴击"]={"物理暴击",252}
	self.miaoshu["治疗能力"]={"治疗能力",252}
	self.miaoshu["法术暴击"]={"法术暴击",252}
	self.miaoshu["法术防御"]={"法术防御",252}
	self.miaoshu["抵抗封印"]={"抵抗封印",277}
end

function 法宝:更新神器属性(数据)
	self.神器属性 = 数据
	self.属性数值 = {速度=0,气血=0,抵抗封印=0}
	for n=1,2 do
	    if 神器属性[tp.队伍[1].门派][n] == "伤　　害" then
	    	self.属性数值.伤害 = 0
	    elseif 神器属性[tp.队伍[1].门派][n] == "防　　御" then
	    	self.属性数值.防御 = 0
	    else
	        self.属性数值[神器属性[tp.队伍[1].门派][n]] = 0
	    end
	end
	self.佩戴神器:置物品(nil)
	if tp.队伍[1].神器佩戴 then
          self.佩戴神器:置物品({名称=门派神器名称[tp.队伍[1].门派]})
    end
end




function 法宝:刷新()
	if self.法宝选中~=0 and self.法宝列表[self.法宝选中].确定 then
    	self.法宝列表[self.法宝选中].确定=false
    end
    if self.灵宝选中~=0 and self.灵宝列表[self.灵宝选中].确定 then
    	self.灵宝列表[self.灵宝选中].确定=false
    end
    self.法宝数量 = 0
    self.灵宝数量 = 0
	self.法宝选中 = 0
	self.灵宝选中 = 0
	self.佩戴选中 = 0
	self.灵宝佩戴 = 0

    for i=1,100 do
    	if tp.队伍[1].法宝[i]~=nil then
        	self.法宝列表[i]:置物品(tp.队伍[1].法宝[i])
        	self.法宝数量 = self.法宝数量 + 1
        else
            self.法宝列表[i]:置物品(nil)
        end
    end
    for i=1,4 do
    	if tp.队伍[1].法宝佩戴[i]~=nil then
        	self.佩戴法宝[i]:置物品(tp.队伍[1].法宝佩戴[i])
        else
            self.佩戴法宝[i]:置物品(nil)
        end
    end
     for i=1,100 do
    	if tp.队伍[1].灵宝[i]~=nil then
        	self.灵宝列表[i]:置物品(tp.队伍[1].灵宝[i])
        	self.灵宝数量 = self.灵宝数量 + 1
        else
            self.灵宝列表[i]:置物品(nil)
        end
    end
    for i=1,2 do
    	if tp.队伍[1].灵宝佩戴[i]~=nil then
        	self.佩戴灵宝[i]:置物品(tp.队伍[1].灵宝佩戴[i])
        else
            self.佩戴灵宝[i]:置物品(nil)
        end
    end
    if tp.队伍[1].神器数据 and tp.队伍[1].神器数据.神器技能 and  tp.队伍[1].门派~=nil and tp.队伍[1].门派~="无门派" and tp.队伍[1].门派~="无" and tp.队伍[1].门派~=""  then
       self:更新神器属性(tp.队伍[1].神器数据)
    end

    self:刷新法宝显示()
end

function 法宝:更新修炼(数据)
	if self.法宝列表[数据.id]~=nil and self.法宝列表[数据.id].物品~=nil then
		self.法宝列表[数据.id].物品.当前经验=数据.当前经验
		self.法宝列表[数据.id].物品.升级经验=数据.升级经验
		self.法宝列表[数据.id].物品.气血=数据.境界
		self.法宝列表[数据.id].物品.魔法=数据.灵气
	end
end



function 法宝:刷新法宝显示()
		if self.法宝选中~=0 and self.法宝列表[self.法宝选中].确定 then
	    	self.法宝列表[self.法宝选中].确定=false
	    end
	    if self.灵宝选中~=0 and self.灵宝列表[self.灵宝选中].确定 then
	    	self.灵宝列表[self.灵宝选中].确定=false
	    end
	    self.法宝选中 = 0
		self.佩戴选中 = 0
		self.灵宝选中 = 0
		self.灵宝佩戴 = 0
		tp.场景.抓取物品 = nil
		tp.场景.抓取物品ID = nil
		tp.场景.抓取物品注释 = nil
		tp.场景.抓取类型 = nil


end

function 法宝:显示(dt,x,y)
	local 字体 = tp.字体表.普通字体
	self.焦点 = false
	self.关闭:更新(x,y)
	self.资源组[1]:更新(x,y)-------------按钮是否能按压
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y)
	--elf.资源组[4]:更新(x,y)
	self.资源组[7]:更新(x,y)
	self.资源组[8]:更新(x,y)
	self.资源组[10]:更新(x,y)
	self.快速卸下法宝:更新(x,y)
	self.使用:更新(x,y)
	self.修炼:更新(x,y)
	self.补充灵气:更新(x,y)
 	self.背景:显示(self.x,self.y)
 	self.关闭:显示(self.x+522,self.y+15)

 	self.资源组[1]:显示(self.x+98,self.y+42,nil,nil,nil,self.方案==1,2)
 	self.资源组[2]:显示(self.x+138,self.y+42,nil,nil,nil,self.方案==2,2)
 	self.资源组[3]:显示(self.x+178,self.y+42,nil,nil,nil,self.方案==3,2)
 	--self.资源组[4]:显示(self.x+218,self.y+42)

	self.资源组[7]:显示(self.x+288,self.y+44,nil,nil,nil,self.窗口=="法宝",2)
	self.资源组[8]:显示(self.x+380,self.y+44,nil,nil,nil,self.窗口=="神器",2)
    self.资源组[10]:显示(self.x+480,self.y+44,nil,nil,nil,self.窗口=="灵宝",2)

	--self.资源组[9]:显示(self.x+440,self.y+44)

	if tp.场景.抓取物品ID~=nil and self.佩戴选中~=0 and self.佩戴法宝[self.佩戴选中].焦点 and self.佩戴选中==tp.场景.抓取物品ID and 引擎.鼠标弹起(左键) then
		self.佩戴法宝[self.佩戴选中]:置物品(tp.队伍[1].法宝佩戴[self.佩戴选中])
		self.时间 = os.clock()
		self.佩戴选中 = 0
		self:刷新法宝显示()
	end
	if tp.场景.抓取物品ID~=nil and self.佩戴选中==tp.场景.抓取物品ID and 引擎.鼠标弹起(右键) then
		self.佩戴法宝[self.佩戴选中]:置物品(tp.队伍[1].法宝佩戴[self.佩戴选中])
		self.时间 = os.clock()
		self.灵宝选中 = 0
		self:刷新法宝显示()
	end

	if tp.场景.抓取物品ID~=nil and self.灵宝佩戴~=0 and self.佩戴灵宝[self.灵宝佩戴].焦点 and self.灵宝选中==tp.场景.抓取物品ID and 引擎.鼠标弹起(左键) then
		self.佩戴灵宝[self.灵宝佩戴]:置物品(tp.队伍[1].灵宝佩戴[self.灵宝佩戴])
		self.时间 = os.clock()
		self.灵宝佩戴 = 0
		self:刷新法宝显示()
	end
	if tp.场景.抓取物品ID~=nil and self.灵宝佩戴==tp.场景.抓取物品ID and 引擎.鼠标弹起(右键) then
		self.佩戴灵宝[self.灵宝佩戴]:置物品(tp.队伍[1].灵宝佩戴[self.灵宝佩戴])
		self.时间 = os.clock()
		self.灵宝佩戴 = 0
		self:刷新法宝显示()
	end
  if self.窗口=="法宝" then
	 	for n=1,4 do
	 	    self.物品单格子:显示(self.x + 26 + (n-1) * 58 ,self.y + 78)
	 	    if self.佩戴法宝[n]~=nil then
	 			self.佩戴法宝[n]:置坐标(self.x + 28 + (n-1) * 58 ,self.y + 78)
	 			self.佩戴法宝[n]:显示(dt,x,y,self.鼠标,nil,nil,nil,1)
	            if self.佩戴法宝[n].焦点 and not tp.消息栏焦点 then
	            	self.佩戴选中光圈:显示(self.x + 15 + (n-1) * 58 ,self.y + 69)
	                if self.佩戴法宝[n].物品 ~= nil then
	                	if self.佩戴选中~=0 and self.快速卸下法宝:是否选中(x,y) then
	                		tp.提示:自定义(鼠标.x,鼠标.y,"快速卸下法宝")
	                		self.时间 = os.clock()
	                	else
	                		tp.提示:道具行囊(x,y,self.佩戴法宝[n].物品)
	                	end
					end
					if self.窗口 =="法宝" then
					    if tp.场景.抓取物品 == nil and self.佩戴法宝[n].物品 ~= nil and mousea(0) and (self.时间==0 or os.clock() - self.时间 > 0.1) then
							if self.佩戴法宝[self.佩戴选中]~=nil then
								self.佩戴法宝[self.佩戴选中].选中=nil
							end
						 	tp.场景.抓取物品 = self.佩戴法宝[n].物品
						 	tp.场景.抓取物品ID = n
						 	tp.场景.抓取物品注释 = self.佩戴法宝[n].注释
						 	self.佩戴选中 = n
						 	self.佩戴法宝[n]:置物品(nil)
						 	tp.场景.抓取类型 = "法宝"
						end
						if tp.场景.抓取物品ID~=nil and self.佩戴选中~=0 and n~=tp.场景.抓取物品ID  and 引擎.鼠标弹起(左键)  then
							请求服务(3729,{序列=tp.场景.抓取物品ID,序列1=n})
							self:刷新法宝显示()
						end
						if tp.场景.抓取物品ID~=nil and self.法宝选中~=0  and 引擎.鼠标弹起(左键) then
							请求服务(3735,{序列=tp.场景.抓取物品ID,序列1=n})
							self.法宝列表[self.法宝选中]:置物品(tp.队伍[1].法宝[self.法宝选中])
							self.法宝列表[self.法宝选中].确定=false
							self.法宝选中=0
							self:刷新法宝显示()
						end
						if tp.场景.抓取物品 == nil and self.佩戴法宝[n].物品 ~= nil and mousea(1) then
							if self.佩戴法宝[self.佩戴选中]~=nil then
								self.佩戴选中 = 0
							end
							if self.法宝列表[self.法宝选中]~=nil then
								self.法宝列表[self.法宝选中].确定=false
							end
							if self.佩戴选中~=n then
								self.佩戴选中=n
							else
								self.佩戴法宝[self.佩戴选中].选中=nil
								self.佩戴选中=0
							end
						end
					end

				end
	 		end
	 	end

	elseif self.窗口=="神器" then
		 	self.物品单格子:显示(self.x + 26,self.y + 78)
	 	    if self.佩戴神器~=nil then
	 			self.佩戴神器:置坐标(self.x + 28 ,self.y + 78)
	 			self.佩戴神器:显示(dt,x,y,self.鼠标,nil,nil,nil,1)
	            if self.佩戴神器.焦点 and not tp.消息栏焦点 then
	            	self.佩戴选中光圈:显示(self.x + 15 ,self.y + 69)
	                if self.佩戴神器.物品 ~= nil then
	                		tp.提示:道具行囊(x,y,self.佩戴神器.物品)
					end
			    end
			end


	elseif self.窗口=="灵宝" then

						for n=1,2 do
							self.物品单格子:显示(self.x + 85 + (n-1) * 58 ,self.y + 78)
								if self.佩戴灵宝[n]~=nil then
						 			self.佩戴灵宝[n]:置坐标(self.x + 87 + (n-1) * 58 ,self.y + 78)
						 			self.佩戴灵宝[n]:显示(dt,x,y,self.鼠标,nil,nil,nil,1)
						            if self.佩戴灵宝[n].焦点 and not tp.消息栏焦点 then
						            	self.佩戴选中光圈:显示(self.x + 74 + (n-1) * 58 ,self.y + 69)
						                if self.佩戴灵宝[n].物品 ~= nil then
						                	if self.灵宝佩戴~=0 and self.快速卸下法宝:是否选中(x,y) then
						                		tp.提示:自定义(鼠标.x,鼠标.y,"快速卸下法宝")
						                		self.时间 = os.clock()
						                	else
						                		tp.提示:道具行囊(x,y,self.佩戴灵宝[n].物品)
						                	end
										end

										    if tp.场景.抓取物品 == nil and self.佩戴灵宝[n].物品 ~= nil and mousea(0) and (self.时间==0 or os.clock() - self.时间 > 0.1) then
												if self.佩戴灵宝[self.灵宝佩戴]~=nil then
													self.佩戴灵宝[self.灵宝佩戴].选中=nil
												end
											 	tp.场景.抓取物品 = self.佩戴灵宝[n].物品
											 	tp.场景.抓取物品ID = n
											 	tp.场景.抓取物品注释 = self.佩戴灵宝[n].注释
											 	self.灵宝佩戴 = n
											 	self.佩戴灵宝[n]:置物品(nil)
											 	tp.场景.抓取类型 = "灵宝"
											end
											if tp.场景.抓取物品ID~=nil and self.灵宝佩戴~=0 and n~=tp.场景.抓取物品ID  and 引擎.鼠标弹起(左键)  then
												请求服务(3729.1,{序列=tp.场景.抓取物品ID,序列1=n})
												self:刷新法宝显示()
											end
											if tp.场景.抓取物品ID~=nil and self.灵宝选中~=0  and 引擎.鼠标弹起(左键) then
												请求服务(3735.1,{序列=tp.场景.抓取物品ID,序列1=n})
												self.灵宝列表[self.灵宝选中]:置物品(tp.队伍[1].灵宝[self.灵宝选中])
												self.灵宝列表[self.灵宝选中].确定=false
												self.灵宝选中=0
												self:刷新法宝显示()
											end
											if tp.场景.抓取物品 == nil and self.佩戴灵宝[n].物品 ~= nil and mousea(1) then
												if self.佩戴灵宝[self.灵宝佩戴]~=nil then
													self.灵宝佩戴 = 0
												end
												if self.灵宝列表[self.灵宝选中]~=nil then
													self.灵宝列表[self.灵宝选中].确定=false
												end
												if self.灵宝佩戴~=n then
													self.灵宝佩戴=n
												else
													self.佩戴灵宝[self.灵宝佩戴].选中=nil
													self.灵宝佩戴=0
												end

                                      		end
                                   end
                             end

                        end

	end








	if tp.场景.抓取物品ID~=nil then
		self.右键关闭 = 1
	elseif self.时间==0 or os.clock() - self.时间 > 0.1 then
	    self.右键关闭 = nil
	end

	if tp.场景.抓取物品ID~=nil and self.法宝选中~=0 and self.法宝列表[self.法宝选中].焦点 and self.法宝选中==tp.场景.抓取物品ID and 引擎.鼠标弹起(左键) then
		self.法宝列表[self.法宝选中].确定=false
		self.法宝列表[self.法宝选中]:置物品(tp.队伍[1].法宝[self.法宝选中])
		self.时间 = os.clock()
		self.法宝选中 = 0
		self:刷新法宝显示()
	end
	if tp.场景.抓取物品ID~=nil and self.法宝选中==tp.场景.抓取物品ID and 引擎.鼠标弹起(右键) then
		self.法宝列表[self.法宝选中].确定=false
		self.法宝列表[self.法宝选中]:置物品(tp.队伍[1].法宝[self.法宝选中])
		self.时间 = os.clock()
		self.法宝选中 = 0
		self:刷新法宝显示()
	end

	if tp.场景.抓取物品ID~=nil and self.灵宝选中~=0 and self.灵宝列表[self.灵宝选中].焦点 and self.灵宝选中==tp.场景.抓取物品ID and 引擎.鼠标弹起(左键) then
		self.灵宝列表[self.灵宝选中].确定=false
		self.灵宝列表[self.灵宝选中]:置物品(tp.队伍[1].灵宝[self.灵宝选中])
		self.时间 = os.clock()
		self.灵宝选中 = 0
		self:刷新法宝显示()
	end
	if tp.场景.抓取物品ID~=nil and self.灵宝选中==tp.场景.抓取物品ID and 引擎.鼠标弹起(右键) then
		self.灵宝列表[self.灵宝选中].确定=false
		self.灵宝列表[self.灵宝选中]:置物品(tp.队伍[1].灵宝[self.灵宝选中])
		self.时间 = os.clock()
		self.灵宝选中 = 0
		self:刷新法宝显示()
	end


	字体:置颜色(白色):显示(self.x+30,self.y+50,"已装备灵宝")
 if self.窗口 =="法宝" then
		self.资源组[5]:更新(x,y)
		self.资源组[6]:更新(x,y)
	 	self.物品格子背景:显示(self.x+260,self.y+75)
	 	self.滑动条:显示(self.x+525,self.y+80)
		self.资源组[5]:显示(self.x+355,self.y+303)
		self.资源组[6]:显示(self.x+445,self.y+303)
		self.使用:置文字("使用")
		self.修炼:置文字("修炼")
	 	self.使用:显示(self.x+10,self.y+300)
		self.修炼:显示(self.x+90,self.y+300)
		self.补充灵气:显示(self.x+170,self.y+300)
	 	local h=0
	 	local s=0
		for n=1,20 do
	 	    self.物品列表单格子:显示(self.x + 267 + h * 51 ,self.y + 82 + s * 51)
	 	    if self.法宝列表[n]~=nil then
				self.法宝列表[n]:置坐标(self.x + 270 + h * 51 ,self.y + 82 + s * 51)
	 			self.法宝列表[n]:显示(dt,x,y,self.鼠标)
	            if self.法宝列表[n].焦点 and not tp.消息栏焦点 then
	                if self.法宝列表[n].物品 ~= nil then
						tp.提示:道具行囊(x,y,self.法宝列表[n].物品)
					end
					if tp.场景.抓取物品 == nil and self.法宝列表[n].物品 ~= nil and mousea(0) and (self.时间==0 or os.clock() - self.时间 > 0.1) then
						if self.法宝列表[self.法宝选中]~=nil then
							self.法宝列表[self.法宝选中].确定=false
						end
					 	tp.场景.抓取物品 = self.法宝列表[n].物品
					 	tp.场景.抓取物品ID = n
					 	tp.场景.抓取物品注释 = "法宝"
					 	tp.场景.抓取类型 = "法宝"
					 	self.法宝选中 = n
					 	self.法宝列表[n]:置物品(nil)
					end
					if tp.场景.抓取物品ID~=nil and self.佩戴选中~=0 and self.法宝列表[n].物品 == nil and 引擎.鼠标弹起(左键) then
							请求服务(3734,{序列=tp.场景.抓取物品ID,序列1=n})
							self:刷新法宝显示()
					elseif tp.场景.抓取物品ID~=nil and self.佩戴选中~=0 and self.法宝列表[n].物品 ~= nil and 引擎.鼠标弹起(左键) then
							请求服务(3730,{序列=tp.场景.抓取物品ID,序列1=n})
							self.佩戴法宝[self.佩戴选中]:置物品(tp.队伍[1].法宝佩戴[self.佩戴选中])
							self.佩戴选中=0
							self:刷新法宝显示()
					end
					if tp.场景.抓取物品ID~=nil and self.法宝选中~=0 and n~=tp.场景.抓取物品ID and 引擎.鼠标弹起(左键) then
						请求服务(3731,{序列=tp.场景.抓取物品ID,序列1=n})
						self:刷新法宝显示()
					end
					if tp.场景.抓取物品 == nil and self.法宝列表[n].物品 ~= nil and mousea(1) then
						if self.佩戴法宝[self.佩戴选中]~=nil then
							self.佩戴选中 = 0
						end
						if self.法宝列表[self.法宝选中]~=nil then
							self.法宝列表[self.法宝选中].确定=false
						end
						if self.法宝选中~=n then
							self.法宝选中=n
						else
							self.法宝列表[self.法宝选中].确定=false
							self.法宝选中=0
						end
					end
				end
	 		end
	 	    if h < 4 then
	 	    	h=h+1
	 	    else
	 	        h=0
	 	        s=s+1
	 	    end
	 	end


	 	tp.字体表.标题字体:置颜色(白色):显示(self.x+252,self.y+16,"法 宝")
	 	字体:置颜色(白色):显示(self.x+280,self.y+311,"把法宝移动至")
	 	字体:置颜色(黄色):显示(self.x+310,self.y+340,"左键抓取，右键选定")
	 	字体:置颜色(绿色):显示(self.x+440,self.y+340,"法宝总数："..self.法宝数量)
	 	字体:置颜色(白色):显示(self.x+20,self.y+170,"法宝名称:")
	 	self.文本显示背景:显示(self.x+84,self.y+164)
	 	字体:置颜色(白色):显示(self.x+20,self.y+210,"升级经验:")
	 	self.文本显示背景:显示(self.x+84,self.y+204)
	 	字体:置颜色(白色):显示(self.x+20,self.y+250,"修炼经验:")
	 	self.文本显示背景:显示(self.x+84,self.y+244)
	 	if self.佩戴选中~= 0 and self.佩戴法宝[self.佩戴选中]~=nil then
	 		self.法宝选中= 0
	 		self.佩戴选中光圈:显示(self.x + 15 + (self.佩戴选中-1) * 58 ,self.y + 69)
	 		if tp.队伍[1].法宝[tp.场景.抓取物品ID]==nil and tp.队伍[1].法宝佩戴[tp.场景.抓取物品ID]==nil then
	 			self.快速卸下法宝:显示(self.x + 56 + (self.佩戴选中-1) * 58 ,self.y + 108)
	 		end
	 		if self.佩戴法宝[self.佩戴选中]~=nil and self.佩戴法宝[self.佩戴选中].物品~=nil and self.佩戴法宝[self.佩戴选中].物品.当前经验~=nil then
	 			字体:置颜色(白色):显示(self.x+95,self.y+171,self.佩戴法宝[self.佩戴选中].物品.名称)
	            字体:置颜色(白色):显示(self.x+95,self.y+211,self.佩戴法宝[self.佩戴选中].物品.当前经验.." / "..self.佩戴法宝[self.佩戴选中].物品.升级经验)
	            字体:置颜色(白色):显示(self.x+95,self.y+251,self.佩戴法宝[self.佩戴选中].物品.升级经验 - self.佩戴法宝[self.佩戴选中].物品.当前经验)
	        end
	 	end
	 	if self.法宝选中~= 0 and self.法宝列表[self.法宝选中]~=nil then
	 		self.佩戴选中= 0
	 		self.法宝列表[self.法宝选中].确定=true
	 		if self.法宝列表[self.法宝选中]~=nil and self.法宝列表[self.法宝选中].物品~=nil and self.法宝列表[self.法宝选中].物品.当前经验~=nil then
	 			字体:置颜色(白色):显示(self.x+95,self.y+171,self.法宝列表[self.法宝选中].物品.名称)
	            字体:置颜色(白色):显示(self.x+95,self.y+211,self.法宝列表[self.法宝选中].物品.当前经验.." / "..self.法宝列表[self.法宝选中].物品.升级经验)
	            字体:置颜色(白色):显示(self.x+95,self.y+251,self.法宝列表[self.法宝选中].物品.升级经验 - self.法宝列表[self.法宝选中].物品.当前经验)
	        end
	 	end
		 	if self.修炼:事件判断() then
				if self.佩戴选中~=0 then
					tp.常规提示:打开("#Y/请先卸下法宝后修炼")
				elseif self.法宝选中 ~= 0 then
					请求服务(3733,{序列=self.法宝选中})
				else
					tp.常规提示:打开("#Y/请先选中法宝后修炼")
				end
			elseif self.使用:事件判断() then
				if self.佩戴选中~=0 then
					tp.常规提示:打开("#Y/请先卸下法宝后使用")
				elseif self.法宝选中 ~= 0 then
					请求服务(3736,{序列=self.法宝选中})
				else
					tp.常规提示:打开("#Y/请先选中法宝后使用")
				end
			elseif self.补充灵气:事件判断() then
				if self.佩戴选中~=0 then
					tp.常规提示:打开("#Y/请先卸下法宝后补充")
				elseif self.法宝选中 ~= 0 then
					请求服务(3739,{序列=self.法宝选中})----补充灵气
				else
					tp.常规提示:打开("#Y/请先选中法宝后补充")
				end
			elseif self.资源组[5]:是否选中(x,y) and self.鼠标 then
		 		tp.提示:自定义(鼠标.x-50,鼠标.y-50,"抓取法宝后点击此处，会被移动到道具栏")
		 		if self.资源组[5]:事件判断() then
		 			if self.佩戴选中~=0 then
						tp.常规提示:打开("#Y/请先卸下法宝")
					elseif self.法宝选中 ~= 0 and tp.场景.抓取物品ID~=nil and tp.场景.抓取类型~=nil then
						请求服务(3701.1,{抓取id=tp.场景.抓取物品ID,放置id=0,放置类型="道具",抓取类型=tp.场景.抓取类型})
						self:刷新法宝显示()
					else
						tp.常规提示:打开("#Y/请先抓取法宝")
					end
		 		end
			elseif self.资源组[6]:是否选中(x,y) and self.鼠标 then
				tp.提示:自定义(鼠标.x-50,鼠标.y-50,"抓取法宝后点击此处，会被移动到行囊栏")
				if self.资源组[6]:事件判断() then
					if self.佩戴选中~=0 then
						tp.常规提示:打开("#Y/请先卸下法宝")
					elseif self.法宝选中 ~= 0 and tp.场景.抓取物品ID~=nil and tp.场景.抓取类型~=nil then
						请求服务(3701.1,{抓取id=tp.场景.抓取物品ID,放置id=0,放置类型="行囊",抓取类型=tp.场景.抓取类型})
						self:刷新法宝显示()
					else
						tp.常规提示:打开("#Y/请先抓取法宝")
					end
				end
			end

 elseif self.窗口=="灵宝" then
  -----------------------------------------------------------------------------------------------
	    self.资源组[5]:更新(x,y)
		self.资源组[6]:更新(x,y)
	 	self.物品格子背景:显示(self.x+260,self.y+75)
	 	self.滑动条:显示(self.x+525,self.y+80)
		self.资源组[5]:显示(self.x+355,self.y+303)
		self.资源组[6]:显示(self.x+445,self.y+303)
		self.使用:置文字("使用")
		self.修炼:置文字("修炼")
	 	self.使用:显示(self.x+10,self.y+300)
		self.修炼:显示(self.x+90,self.y+300)
		self.补充灵气:显示(self.x+170,self.y+300)
		local h=0
	 	local s=0
		for n=1,20 do
	 	    self.物品列表单格子:显示(self.x + 267 + h * 51 ,self.y + 82 + s * 51)
	 	    if self.灵宝列表[n]~=nil then
				self.灵宝列表[n]:置坐标(self.x + 270 + h * 51 ,self.y + 82 + s * 51)
	 			self.灵宝列表[n]:显示(dt,x,y,self.鼠标)
	            if self.灵宝列表[n].焦点 and not tp.消息栏焦点 then
	                if self.灵宝列表[n].物品 ~= nil then
						tp.提示:道具行囊(x,y,self.灵宝列表[n].物品)
					end
					if tp.场景.抓取物品 == nil and self.灵宝列表[n].物品 ~= nil and mousea(0) and (self.时间==0 or os.clock() - self.时间 > 0.1) then
						if self.灵宝列表[self.灵宝选中]~=nil then
							self.灵宝列表[self.灵宝选中].确定=false
						end
					 	tp.场景.抓取物品 = self.灵宝列表[n].物品
					 	tp.场景.抓取物品ID = n
					 	tp.场景.抓取物品注释 = "灵宝"
					 	tp.场景.抓取类型 = "灵宝"
					 	self.灵宝选中 = n
					 	self.灵宝列表[n]:置物品(nil)
					end
					if tp.场景.抓取物品ID~=nil and self.灵宝佩戴~=0 and self.灵宝列表[n].物品 == nil and 引擎.鼠标弹起(左键) then
						请求服务(3734.1,{序列=tp.场景.抓取物品ID,序列1=n})--
						self:刷新法宝显示()
					elseif tp.场景.抓取物品ID~=nil and self.灵宝佩戴~=0 and self.灵宝列表[n].物品 ~= nil and 引擎.鼠标弹起(左键) then
						请求服务(3730.1,{序列=tp.场景.抓取物品ID,序列1=n})

						self.佩戴灵宝[self.灵宝佩戴]:置物品(tp.队伍[1].灵宝佩戴[self.灵宝佩戴])
						self.灵宝佩戴=0
						self:刷新法宝显示()
					end
					if tp.场景.抓取物品ID~=nil and self.灵宝选中~=0 and n~=tp.场景.抓取物品ID and 引擎.鼠标弹起(左键) then
						请求服务(3731.1,{序列=tp.场景.抓取物品ID,序列1=n})
						self:刷新法宝显示()
					end
					if tp.场景.抓取物品 == nil and self.灵宝列表[n].物品 ~= nil and mousea(1) then
						if self.佩戴灵宝[self.灵宝佩戴]~=nil then
							self.灵宝佩戴 = 0
						end
						if self.灵宝列表[self.灵宝选中]~=nil then
							self.灵宝列表[self.灵宝选中].确定=false
						end
						if self.灵宝选中~=n then
							self.灵宝选中=n
						else
							self.灵宝列表[self.灵宝选中].确定=false
							self.灵宝选中=0
						end
					end
				end
	 		end
	 	    if h < 4 then
	 	    	h=h+1
	 	    else
	 	        h=0
	 	        s=s+1
	 	    end
	 	end



	 	tp.字体表.标题字体:置颜色(白色):显示(self.x+252,self.y+16,"灵 宝")
	 	字体:置颜色(白色):显示(self.x+280,self.y+311,"把灵宝移动至")
	 	字体:置颜色(黄色):显示(self.x+310,self.y+340,"左键抓取，右键选定")
	 	字体:置颜色(绿色):显示(self.x+440,self.y+340,"灵宝总数："..self.灵宝数量)
	 	字体:置颜色(白色):显示(self.x+20,self.y+170,"灵宝名称:")
	 	self.文本显示背景:显示(self.x+84,self.y+164)
	 	字体:置颜色(白色):显示(self.x+20,self.y+210,"升级经验:")
	 	self.文本显示背景:显示(self.x+84,self.y+204)
	 	字体:置颜色(白色):显示(self.x+20,self.y+250,"修炼经验:")
	 	self.文本显示背景:显示(self.x+84,self.y+244)
		if self.灵宝佩戴~= 0 and self.佩戴灵宝[self.灵宝佩戴]~=nil then
	 		self.灵宝选中= 0
	 		self.佩戴选中光圈:显示(self.x + 74 + (self.灵宝佩戴-1) * 58 ,self.y + 69)
	 		if tp.队伍[1].灵宝[tp.场景.抓取物品ID]==nil and tp.队伍[1].灵宝佩戴[tp.场景.抓取物品ID]==nil then
	 			self.快速卸下法宝:显示(self.x + 115 + (self.灵宝佩戴-1) * 58 ,self.y + 108)
	 		end
	 		if self.佩戴灵宝[self.灵宝佩戴]~=nil and self.佩戴灵宝[self.灵宝佩戴].物品~=nil and self.佩戴灵宝[self.灵宝佩戴].物品.当前经验~=nil then
	 			字体:置颜色(白色):显示(self.x+95,self.y+171,self.佩戴灵宝[self.灵宝佩戴].物品.名称)
	            字体:置颜色(白色):显示(self.x+95,self.y+211,self.佩戴灵宝[self.灵宝佩戴].物品.当前经验.." / "..self.佩戴灵宝[self.灵宝佩戴].物品.升级经验)
	            字体:置颜色(白色):显示(self.x+95,self.y+251,self.佩戴灵宝[self.灵宝佩戴].物品.升级经验 - self.佩戴灵宝[self.灵宝佩戴].物品.当前经验)
	        end
	 	end
	 	if self.灵宝选中~= 0 and self.灵宝列表[self.灵宝选中]~=nil then
	 		self.灵宝佩戴= 0
	 		self.灵宝列表[self.灵宝选中].确定=true
	 		if self.灵宝列表[self.灵宝选中]~=nil and self.灵宝列表[self.灵宝选中].物品~=nil and self.灵宝列表[self.灵宝选中].物品.当前经验~=nil then
	 			字体:置颜色(白色):显示(self.x+95,self.y+171,self.灵宝列表[self.灵宝选中].物品.名称)
	            字体:置颜色(白色):显示(self.x+95,self.y+211,self.灵宝列表[self.灵宝选中].物品.当前经验.." / "..self.灵宝列表[self.灵宝选中].物品.升级经验)
	            字体:置颜色(白色):显示(self.x+95,self.y+251,self.灵宝列表[self.灵宝选中].物品.升级经验 - self.灵宝列表[self.灵宝选中].物品.当前经验)
	        end
	 	end
		 	if self.修炼:事件判断() then
				if self.灵宝佩戴~=0 then
					tp.常规提示:打开("#Y/请先卸下灵宝后修炼")
				elseif self.灵宝选中 ~= 0 then
					请求服务(3733.1,{序列=self.灵宝选中})
				else
					tp.常规提示:打开("#Y/请先选中灵宝后修炼")
				end
			elseif self.使用:事件判断() then
				if self.灵宝佩戴~=0 then
					tp.常规提示:打开("#Y/请先卸下灵宝后使用")
				elseif self.灵宝选中 ~= 0 then
					--请求服务(3736.1,{序列=self.灵宝选中})
				else
					tp.常规提示:打开("#Y/请先选中灵宝后使用")
				end
			elseif self.补充灵气:事件判断() then
				if self.灵宝佩戴~=0 then
					tp.常规提示:打开("#Y/请先卸下法宝后补充")
				elseif self.灵宝选中 ~= 0 then
					请求服务(3739.1,{序列=self.灵宝选中})----补充灵气
				else
					tp.常规提示:打开("#Y/请先选中灵宝后补充")
				end
			elseif self.资源组[5]:是否选中(x,y) and self.鼠标 then
		 		tp.提示:自定义(鼠标.x-50,鼠标.y-50,"抓取法宝后点击此处，会被移动到道具栏")
		 		if self.资源组[5]:事件判断() then
		 			if self.灵宝佩戴~=0 then
						tp.常规提示:打开("#Y/请先卸下灵宝")
					elseif self.灵宝选中 ~= 0 and tp.场景.抓取物品ID~=nil and tp.场景.抓取类型~=nil then
						请求服务(3701.1,{抓取id=tp.场景.抓取物品ID,放置id=o,放置类型="道具",抓取类型=tp.场景.抓取类型})
						self:刷新法宝显示()
					else
						tp.常规提示:打开("#Y/请先抓取灵宝")
					end
		 		end
			elseif self.资源组[6]:是否选中(x,y) and self.鼠标 then
				tp.提示:自定义(鼠标.x-50,鼠标.y-50,"抓取法宝后点击此处，会被移动到行囊栏")
				if self.资源组[6]:事件判断() then
					if self.灵宝佩戴~=0 then
						tp.常规提示:打开("#Y/请先卸下灵宝")
					elseif self.灵宝选中 ~= 0 and tp.场景.抓取物品ID~=nil and tp.场景.抓取类型~=nil then
						请求服务(3701.1,{抓取id=tp.场景.抓取物品ID,放置id=o,放置类型="行囊",抓取类型=tp.场景.抓取类型})
						self:刷新法宝显示()
					else
						tp.常规提示:打开("#Y/请先抓取灵宝")
					end
				end
			end



----------------------------------------------------------------------------------------------------
 else-----神器
 	  tp.字体表.标题字体:置颜色(白色):显示(self.x+252,self.y+16,"神 器")
 	  if tp.队伍[1].神器佩戴 then
		 self.使用:置文字("卸下")
	  else
		 self.使用:置文字("装备")
	  end
	  self.修炼:置文字("修复")

      self.使用:显示(self.x + 265,self.y + 328)
	  self.修炼:显示(self.x + 360,self.y + 328)
	  self.补充灵气:显示(self.x + 455,self.y + 328)
	  self.shenqizu[12]:显示(self.x + 265,self.y + 80)
	  self.shenqizu[13]:显示(self.x + 30,self.y + 145)
	  self.shenqizu[14]:显示(self.x + 145,self.y + 145)
	  self.shenqizu[15]:显示(self.x + 140,self.y + 195)
	  if tp.队伍[1].门派=="九黎城" then
	  	 self.神器图片集:显示(self.x + 280,self.y + 100)
	  else
	      self.神器图片集:显示(self.x + 神器大图与坐标[tp.队伍[1].门派][2],self.y + 神器大图与坐标[tp.队伍[1].门派][3])
	  	  self.神器文字集:显示(self.x + 280,self.y + 100)
	  end

	  for k,v in pairs(self.属性数值) do
			if v>0 then
				字体:置颜色(白色):显示(self.x + 40, self.y + self.miaoshu[k][2],self.miaoshu[k][1].." +"..v)
			else
			    字体:置颜色(ARGB(255,125,125,125)):显示(self.x + 40, self.y + self.miaoshu[k][2],self.miaoshu[k][1].." +0")
			end
		end
		 字体:置颜色(白色):显示(self.x + 160,self.y + 175,self.神器属性.神器技能.名称)
		self.介绍文本:置行距(5):显示(self.x + 150,self.y + 205)
		字体:置颜色(0xffffcc66):显示(self.x + 80,self.y + 340,"点击右侧装备按钮，装备神器。")
		字体:置颜色(白色):显示(self.x + 415,self.y + 285,"剩余灵气："..self.神器属性.灵气)
		if self.修炼:事件判断() then
			请求服务(6208)
			if tp.窗口.道具行囊.可视 then
				tp.窗口.道具行囊:打开()
            end
			if tp.窗口.新道具行囊.可视 then
				tp.窗口.新道具行囊:打开()
            end
			self:打开()
			return
		elseif self.使用:事件判断() then
				请求服务(3748)
		elseif self.补充灵气:事件判断() then

		end










 end




 	if self.关闭:事件判断() then
		self:打开()
		return


	elseif self.资源组[4]:事件判断() then
		if tp.窗口.法宝方案2.可视==false or tp.窗口.法宝方案3.可视==false then
			if tp.窗口.法宝方案2.可视==false then
				tp.窗口.法宝方案2:打开(self.x,self.y,self.ID+self.方案,"方案"..self.方案+1)
			end
			if tp.窗口.法宝方案3.可视==false then
		    	tp.窗口.法宝方案3:打开(self.x,self.y,self.ID+self.方案+1,"方案"..self.方案+2)
		    end
		else
		    tp.窗口.法宝方案2:打开()
		    tp.窗口.法宝方案3:打开()
		end
	elseif self.快速卸下法宝:事件判断() then
		if self.佩戴选中~=0 and tp.场景.抓取物品ID==nil then
			请求服务(3734,{序列=self.佩戴选中})
		elseif self.灵宝佩戴~=0 and tp.场景.抓取物品ID==nil then
			请求服务(3734.1,{序列=self.灵宝佩戴})
		end
    elseif self.资源组[8]:事件判断() then --打开神器经脉
			self.法宝选中 = 0
			self.灵宝选中 = 0
		    if tp.队伍[1].神器数据 and tp.队伍[1].神器数据.神器技能 then
				self.窗口 ="神器"
				请求服务(6203)
				self:刷新法宝显示()
		     else
		     	tp.常规提示:打开("#Y/你还未获得神器!")
		     end
    elseif self.资源组[7]:事件判断() then
			self.法宝选中 = 0
			self.灵宝选中 = 0
			self.窗口 ="法宝"
			self:刷新法宝显示()
    elseif self.资源组[10]:事件判断() then
	    	self.法宝选中 = 0
	    	self.灵宝选中 = 0
			self.窗口 ="灵宝"
			self:刷新法宝显示()


	end

	if self.方案==1 then
		self.资源组[1]:置偏移(7,3)
	else
	    self.资源组[1]:置偏移(7,4)
	end
	if self.方案==2 then
		self.资源组[2]:置偏移(7,3)
	else
	    self.资源组[2]:置偏移(7,4)
	end
	if self.方案==3 then
		self.资源组[3]:置偏移(7,3)
	else
	    self.资源组[3]:置偏移(7,4)
	end
	if self.方案==4 then
		self.资源组[4]:置偏移(5,3)
	else
	    self.资源组[4]:置偏移(5,4)
	end
end

function 法宝:检查点(x,y)
	if self.可视 and self.背景:是否选中(x,y)  then
		return true
	else
		return false
	end
end
function 法宝:初始移动(x,y)
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

function 法宝:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
		tp.窗口.法宝方案2:更新(self.x,self.y)
		tp.窗口.法宝方案3:更新(self.x,self.y)
	end
end
return 法宝