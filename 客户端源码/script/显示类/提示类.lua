--======================================================================--
--======================================================================--
local 系统类_提示框 = class()
local floor = math.floor
local format = string.format
local remove = table.remove
local insert = table.insert
local jls = nil
local min = math.min
local gxs = 引擎.取物品功效
local qwp = 引擎.取物品
local tp = nil
local ARGB = ARGB
local pairs = pairs
local ff


local 神话属性={
    洪荒力魄={描述="物伤结果提高4%",部位="所有部位",限制="无"},
    太初神念={描述="法伤结果提高4%",部位="所有部位",限制="无"},
    鸿蒙元魂={描述="固伤结果提高4%",部位="所有部位",限制="无"},
    无极命源={描述="治疗结果提高4%",部位="所有部位",限制="无"},
    不灭金身={描述="受到物伤消弱4%",部位="所有部位",限制="无"},
    法天象地={描述="受到法伤削弱4%",部位="所有部位",限制="无"},
    道法自然={描述="技能连击提高4%",部位="所有部位",限制="无"},
    超然物外={描述="受到固伤消弱4%",部位="所有部位",限制="无"},
    无相法门={描述="封印几率提高5%",部位="所有部位",限制="无"},
    飞天遁地={描述="抗封几率提高5%",部位="所有部位",限制="无"},
    兽语御灵={描述="召唤兽造成的物理、法术伤害提高8%",部位="头盔|项链",限制="无"},
    奇经山海={描述="对召唤兽造成的物理、法术伤害削弱8%",部位="头盔|项链",限制="无"},
    连破六合={描述="横扫千军有15%几率不进入“休息”状态",部位="武器|衣服",限制="大唐官府"},
    无双剑意={描述="物理伤害结果增加8%",部位="武器|衣服",限制="大唐官府"},
    十方光明={描述="推气过宫有12%几率触发满血,失败后附加15%治疗气血加成",部位="武器|衣服",限制="化生寺"},
    万佛朝宗={描述="推气过宫有18%几率触发连击",部位="武器|衣服",限制="化生寺"},
    花语倾城={描述="战斗开始时有12%几率速度增加15%,失败后增加角色等级的速度",部位="武器|衣服",限制="女儿村"},
    一笑倾国={描述="战斗开始时有12%几率伤害增加15%,失败后增加角色等级的伤害",部位="武器|衣服",限制="女儿村"},
    卫灵神咒={描述="战斗开始时有12%几率提高8%封印命中等级,失败后增加角色等级*0.6的封印命中等级",部位="武器|衣服",限制="方寸山"},
    雷法天尊={描述="法术伤害结果增加8%",部位="武器|衣服",限制="方寸山"},
    霹霹电芒={描述="雷霆万钧和天雷斩有15%几率额外作用1个单位",部位="武器|衣服",限制="天宫"},
    天神下凡={描述="雷霆万钧和天雷斩有15几率触发连击",部位="武器|衣服",限制="天宫"},
    慧眼观世={描述="战斗开始时有12%几率固定伤害增加8%,失败后增加角色等级/2的固定伤害",部位="武器|衣服",限制="普陀山"},
    九天玄女={描述="普渡众生有15%几率额外作用1个单位",部位="武器|衣服",限制="普陀山"},
    沧溟龙魄={描述="战斗开始时有10%几率法术伤害增加8%,失败后增加角色等级*0.8的法术伤害",部位="武器|衣服",限制="龙宫"},
    蛟龙出海={描述="龙卷雨击有12%几率触发连击",部位="武器|衣服",限制="龙宫"},
    潇湘骤雨={描述="烟雨剑法有15%几率增加一次攻击,飘渺式有15%几率额外作用1个单位",部位="武器|衣服",限制="五庄观"},
    地仙老祖={描述="日月乾坤有15%几率增加10%基础封印命中,天命剑法50%触发5次以上攻击",部位="武器|衣服",限制="五庄观"},
    鹰抟九天={描述="物理伤害结果增加10%",部位="武器|衣服",限制="狮驼岭"},
    鹏程万里={描述="鹰击有16%几率不休息",部位="武器|衣服",限制="狮驼岭"},
    五火神焰={描述="法术伤害结果增加10%",部位="武器|衣服",限制="魔王寨"},
    魔王在世={描述="飞砂走石有15%几率连击一次,有8%几率额外作用1个单位",部位="武器|衣服",限制="魔王寨"},
    无常索命={描述="战斗开始时有12%几率提高10%固定伤害,失败后增加角色等级的固定伤害",部位="武器|衣服",限制="阴曹地府"},
    钟馗转生={描述="物理伤害结果提升10%",部位="武器|衣服",限制="阴曹地府"},
    天网蛛狩={描述="战斗开始时有12%几率提高8%封印命中等级,失败后增加角色等级/2的封印命中等级",部位="武器|衣服",限制="盘丝洞"},
    九尾天狐={描述="含情脉脉有16%几率无视对方抗封等级直接命中",部位="武器|衣服",限制="盘丝洞"},
    月影重光={描述="法术攻击有18%几率触发连击",部位="武器|衣服",限制="神木林"},
    月神附体={描述="治疗类技能结果有12%几率翻倍,失败后附加相应等级*2的治疗量",部位="武器|衣服",限制="神木林"},
    超级战息={描述="战斗开始时有15%几率提高8%物理暴击等级,失败后增加角色等级*0.6的物理暴击等级",部位="武器|衣服",限制="凌波城"},
    劈山救母={描述="浪涌有16%几率额外作用1个单位",部位="武器|衣服",限制="凌波城"},
    烛照九幽={描述="夺命咒有12%几率触发连击",部位="武器|衣服",限制="无底洞"},
    藕断丝连={描述="地涌金莲有12%几率额外作用1个单位",部位="武器|衣服",限制="无底洞"},
    逐鹿中原={描述="物理伤害结果增加5%",部位="武器|衣服",限制="九黎城"},
    五马分尸={描述="每次增加连击值时有8%几率+1连击值",部位="武器|衣服",限制="九黎城"}
}

local 境界属性={
      健体={类型="人物体质",分类="所有部位",共鸣=false,优秀=6,稀有=12,传说=24,神话=24},
      千钧={类型="人物力量",分类="所有部位",共鸣=false,优秀=6,稀有=12,传说=24,神话=24},
      疾风={类型="人物敏捷",分类="所有部位",共鸣=false,优秀=6,稀有=12,传说=24,神话=24},
      灵脉={类型="人物魔力",分类="所有部位",共鸣=false,优秀=6,稀有=12,传说=24,神话=24},
      坚韧={类型="人物耐力",分类="所有部位",共鸣=false,优秀=6,稀有=12,传说=24,神话=24},


      尖锋={类型="人物伤害",分类="头盔|武器|腰带",共鸣=true,优秀=12,稀有=24,传说=48,神话=48},
      攻心={类型="法术伤害",分类="头盔|武器|腰带",共鸣=true,优秀=12,稀有=24,传说=48,神话=48},
      破竹={类型="穿刺等级",分类="头盔|武器|腰带",共鸣=true,优秀=12,稀有=24,传说=48,神话=48},
      摧破={类型="固定伤害",分类="头盔|武器|腰带",共鸣=true,优秀=12,稀有=24,传说=48,神话=48},
      杀意={类型="物理暴击",分类="头盔|武器|腰带",共鸣=true,优秀=8,稀有=20,传说=40,神话=40},
      会心={类型="法术暴击",分类="头盔|武器|腰带",共鸣=true,优秀=8,稀有=20,传说=40,神话=40},
      无双={类型="法伤结果",分类="头盔|武器|腰带",共鸣=true,优秀=8,稀有=20,传说=40,神话=40},
      桎梏={类型="封印命中",分类="头盔|武器|腰带",共鸣=true,优秀=8,稀有=20,传说=40,神话=40},
      金身={类型="抗法术暴击",分类="头盔|武器|腰带",共鸣=true,优秀=16,稀有=32,传说=64,神话=64},


      血脉={类型="人物气血",分类="项链|衣服|鞋子",共鸣=true,优秀=40,稀有=80,传说=160,神话=160},
      神速={类型="人物速度",分类="项链|衣服|鞋子",共鸣=true,优秀=10,稀有=18,传说=36,神话=36},
      厚甲={类型="人物防御",分类="项链|衣服|鞋子",共鸣=true,优秀=10,稀有=18,传说=36,神话=36},
      化劲={类型="格挡值",分类="项链|衣服|鞋子",共鸣=true,优秀=10,稀有=18,传说=36,神话=36},
      护心={类型="法术防御",分类="项链|衣服|鞋子",共鸣=true,优秀=10,稀有=18,传说=36,神话=36},
      战神={类型="狂暴等级",分类="项链|衣服|鞋子",共鸣=true,优秀=10,稀有=18,传说=36,神话=36},
      济世={类型="治疗能力",分类="项链|衣服|鞋子",共鸣=true,优秀=10,稀有=18,传说=36,神话=36},
      无羁={类型="抵抗封印",分类="项链|衣服|鞋子",共鸣=true,优秀=16,稀有=32,传说=64,神话=64},
      无敌={类型="抗物理暴击",分类="项链|衣服|鞋子",共鸣=true,优秀=16,稀有=32,传说=64,神话=64}
}





local function 取钟灵石套装(套装,等级)
	if  套装=="心源" then
		if 等级<=3 then
			return "降低受到的物理伤害5%。"
		 else
		 	return "降低受到的物理伤害10%。"
		end
     elseif 套装=="气血方刚" then
		if 等级<=3 then
			return "气血上限提升6%"
		 else
		 	return "气血上限提升12%"
		end
    elseif 套装=="通真达灵" then
  	   if 等级 <=3 then
			return "降低受到的法术伤害5%"
		else
			return "降低受到的法术伤害10%"
		end
 elseif 套装=="心无旁骛" then
  	   if 等级 <=3 then
			return "增加100点抵抗封印等级"
		else
			return "增加300点抵抗封印等级"
		end
 elseif 套装=="健步如飞" then
  	   if 等级 <=3 then
			return "增加50点速度"
		else
			return "增加150点速度"
		end
 elseif 套装=="回春之术" then
  	   if 等级 <=3 then
			return "增加100点治疗能力"
		else
			return "增加350点治疗能力"
		end
 elseif 套装=="风雨不动" then
  	   if 等级 <=3 then
			return "增加100点抗法术暴击等级"
		else
			return "增加300点抗法术暴击等级"
		end
 elseif 套装=="固若金汤" then
  	   if 等级 <=3 then
			return "增加100点抗物理暴击等级"
		else
			return "增加300点抗物理暴击等级"
		end
 elseif 套装=="气壮山河" then
  	   if 等级 <=3 then
			return "增加80点气血回复效果"
		else
			return "增加240点气血回复效果"
		end
 elseif 套装=="锐不可当" then
  	   if 等级 <=3 then
			return "增加100点固定伤害"
		else
			return "增加350点固定伤害"
		end

 end
 return "未知错误"
end



function 系统类_提示框:初始化(根)
	ff = 根._丰富文本
	self.介绍文本 = ff(246,480,根.字体表.普通字体)
	self.道具文本 = ff(187,480,根.字体表.普通字体)
	self.道具文本1 = ff(187,480,根.字体表.普通字体)
	self.道具文本2 = ff(187,480,根.字体表.普通字体)
	self.道具文本3 = ff(187,480,根.字体表.普通字体)
	self.超级文本 = ff(200,480,根.字体表.普通字体)
	self.超级文本1 = ff(200,480,根.字体表.普通字体)
	:添加元素("f",0xFFFF6EC7)
	self.文本 = {}
	self.寄存内容 = {}
	self.寄存高度 = {}
	self.最高 = 0
	jls = 根.提示框
	tp = 根

	self.xx= 0
	self.yy= 0
	self.x=0
	self.y=0
	self.移动窗口 = true
end


function 系统类_提示框:显示(dt,x,y)
	if #self.文本 == 0 then
		return false
	end
	for n=1,#self.文本 do
		if self.文本[n] ~= nil then
			self.文本[n].tiem = self.文本[n].tiem - 1
			if self.文本[n].tiem <= 0 then
				table.remove(self.文本, n)
			end
		end
	end
	for n=1,#self.文本 do
		if self.文本[n] ~= nil then
			local h=self.文本[n].h
			jls:置宽高(全局游戏宽度-460,h+16)
			jls:显示(self.文本[n].x,self.文本[n].y)
			self.文本[n].ffs:显示(self.文本[n].x+6.5,self.文本[n].y+6.5)

		end
	end
end



function 系统类_提示框:小地图(x,y,text)
	local x = x + 28
	local y = y
	local w = 86
	local h = 16
	if y - h <= 0 then
		y = 0
	end
	if x + w+18 >= 992 then
		x = 992-w
	end
	if y + h >= 612 then
		y = 612 - h
	end
	jls:置宽高(w+15,h+16)
	jls:显示(x,y)
	tp.字体表.普通字体:置颜色(-256):显示(x + 16,y + 8,text)
end
-- function 系统类_提示框:战斗提示(x,y,text,f)
-- 	local x = x+25
-- 	local y = y-10
-- 	local w = floor(tp.字体表.普通字体:取宽度(text))-1
-- 	local h = 12
-- 	if x + w >= 全局游戏宽度-20 then
-- 		x = 全局游戏宽度-20-w
-- 		if f then
-- 			x = x - (w/1.3)
-- 		end
-- 	end
-- 	if y+30 >= 600 then
-- 		y = 600-h-18
-- 	end
-- 	if y <= 2 then
-- 		y = 2
-- 	end
-- 	jls:置宽高(w+15,h+16)
-- 	jls:显示(x,y)
-- 	tp.字体表.普通字体:置颜色(-256):显示(x + 7,y + 7,text)
-- end
function 系统类_提示框:战斗提示(x,y,text,f)
	local x = x - 60
	local y = y + 30
	local w = 200
	self.介绍文本:清空()
	-- table.print()
	local 内容 = text
	for k,v in pairs(内容) do
		if k == "战意" then
			self.介绍文本:添加文本("#G/"..k.."\n#Y/还剩#R/"..v.."#Y点")
		elseif k == "超级战意" then
			if v > 0 then
	        	self.介绍文本:添加文本("#G/"..k.."\n#Y/还剩#R/"..v.."#Y点")
	        end
		elseif k == "爪印" then
			self.介绍文本:添加文本("#G/"..k.."\n#Y/当前层数:#R/"..v.层数.."#Y层")
		elseif k == "护盾" then
			self.介绍文本:添加文本("#P/护盾值;(#W/"..v.护盾值.."#P/)")
        elseif k == "风灵" or k == "剑意"  or k == "符咒"
              or k == "雷法崩裂" or k == "雷法震煞" or k == "雷法坤伏"
              or k == "雷法翻天" or k == "雷法倒海" or k == "五行珠金"
              or k == "五行珠木" or k == "五行珠水" or k == "五行珠火"
              or k == "五行珠土"
        	then
        	if v > 0 then
	        	self.介绍文本:添加文本("#G/"..k.."\n#Y/当前层数:#R/"..v.."#Y层")
	        end
        elseif k == "灵药红" or  k == "灵药蓝" or k == "灵药黄" then
        	if v > 0 then
	        	self.介绍文本:添加文本("#G/"..k.."\n#Y/当前数量:#R/"..v.."#Y颗")
	        end
        elseif k == "人参娃娃" then
        	if v.层数>0 and v.回合>0 then
        	  self.介绍文本:添加文本("#G/"..k.."\n#Y/当前层数:#R/"..v.层数.."#Y层".."\n#Y/剩余#R/"..v.回合.."#Y回合")
        	end
        elseif v.回合 then
          self.介绍文本:添加文本("#G/"..k.."\n#Y/剩余#R/"..v.回合.."#Y回合")
		end
	end
	-- for k,v in pairs(内容) do
	-- 	-- if k == "风灵" then
	-- 	-- 	self.介绍文本:添加文本("#G/"..k..":\n#Y/当前层数:#R/"..v.风灵层数.."#Y")
	-- 	-- else
	-- 		if k~="战意" then

	-- 		end
	-- 		-- if k == "雾痕" then
	-- 		-- self.介绍文本:添加文本("#Y/当前层数:#R/"..v.层数.."#Y")
	-- 		-- end
	-- 		if k == "爪印" then
	-- 		self.介绍文本:添加文本("#Y/当前层数:#R/"..v.层数.."#Y")
	-- 		end
	-- 		if k == "护盾" then
	-- 		self.介绍文本:添加文本("#P/护盾值;(#W/"..v.护盾值.."#P/)")
	-- 	    end
	-- 	--end
	-- end
	local h = self.介绍文本.显示表.高度
	if x + w >= 780 then
		x = 780 - w
	end
	if y + h >= 580 then
		y = y - h - 30
	end
	self.寄存内容 = {}
	self.寄存内容[1] = {}
	tp.字体表.普通字体:置阴影颜色(nil)
	self.寄存内容[1].文字 = tp.字体表.普通字体
	self.寄存内容[1].内容 = self.介绍文本
	self.寄存内容[1].x = x + 10
	self.寄存内容[1].y = y + 5
	self.寄存内容.提示坐标 = {[1]=x,[2]=y,[3]=w,[4]=h}
	self.寄存内容.开启提示 = true
end

function 系统类_提示框:阵法(x,y,我阵型,敌阵型,显示)
	local x = x - 60
	local y = y + 30
	local w = 200
	self.介绍文本:清空()
    if 我阵型==敌阵型 then
   	   self.克制=0
   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")
   	end
	if 我阵型=="普通" then
	   if 敌阵型=="天覆阵" or 敌阵型=="风扬阵"or 敌阵型=="龙飞阵"or 敌阵型=="鸟翔阵"or 敌阵型=="鹰啸阵" then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")
	   elseif 敌阵型=="地载阵" or 敌阵型=="云垂阵"or 敌阵型=="虎翼阵"or 敌阵型=="蛇蟠阵"or 敌阵型=="雷绝阵" then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")
	   end
	   self.介绍文本:添加文本("1号位: (#G无特效#W)")
	   self.介绍文本:添加文本("2号位: (#G无特效#W)")
	   self.介绍文本:添加文本("3号位: (#G无特效#W)")
	   self.介绍文本:添加文本("4号位: (#G无特效#W)")
	   self.介绍文本:添加文本("5号位: (#G无特效#W)")
	elseif 我阵型=="天覆阵" then
	   if 敌阵型=="普通" or 敌阵型=="鸟翔阵"or 敌阵型=="鹰啸阵"  then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")
	   elseif 敌阵型=="地载阵"or 敌阵型=="龙飞阵"  then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")

	   elseif 敌阵型=="风扬阵"or 敌阵型=="蛇蟠阵"  then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")
	   elseif 敌阵型=="云垂阵"or 敌阵型=="虎翼阵"or 敌阵型=="雷绝阵"  then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")
	   end
	   self.介绍文本:添加文本("1号位: (#G全伤+20%#W)".."(".."#R速度-10%".."#W)")
	   self.介绍文本:添加文本("2号位: (#G全伤+20%#W)".."(".."#R速度-10%".."#W)")
	   self.介绍文本:添加文本("3号位: (#G全伤+20%#W)".."(".."#R速度-10%".."#W)")
	   self.介绍文本:添加文本("4号位: (#G全伤+20%#W)".."(".."#R速度-10%".."#W)")
	   self.介绍文本:添加文本("5号位: (#G全伤+20%#W)".."(".."#R速度-10%".."#W)")
	elseif 我阵型=="地载阵" then
	   if 敌阵型=="云垂阵"or 敌阵型=="蛇蟠阵"  then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")
	   elseif 敌阵型=="风扬阵"or 敌阵型=="虎翼阵"or 敌阵型=="雷绝阵" then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")

	   elseif 敌阵型=="天覆阵"or 敌阵型=="鸟翔阵"or 敌阵型=="鹰啸阵" then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")
	   elseif 敌阵型=="普通" or 敌阵型=="龙飞阵"  then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")
	   end
	   self.介绍文本:添加文本("1号位: (#G全防+15%#W)")
	   self.介绍文本:添加文本("2号位: (#G全伤+15%#W)")
	   self.介绍文本:添加文本("3号位: (#G全防+15%#W)")
	   self.介绍文本:添加文本("4号位: (#G全防+15%#W)")
	   self.介绍文本:添加文本("5号位: (#G速度+10%#W)")
	elseif 我阵型=="风扬阵" then
	   if 敌阵型=="普通"or 敌阵型=="天覆阵"or 敌阵型=="蛇蟠阵"  then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")--+++++++++++
	   elseif 敌阵型=="风扬阵" or 敌阵型=="鸟翔阵"or 敌阵型=="鹰啸阵" then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")--+++++++++++

	   elseif 敌阵型=="地载阵"or 敌阵型=="虎翼阵"or 敌阵型=="雷绝阵" then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")---------------
	   elseif 敌阵型=="云垂阵"or 敌阵型=="龙飞阵"  then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")---------------
	   end
	   self.介绍文本:添加文本("1号位: (#G全伤+20%#W)")
	   self.介绍文本:添加文本("2号位: (#G全伤+10%#W)")
	   self.介绍文本:添加文本("3号位: (#G全伤+10%#W)")
	   self.介绍文本:添加文本("4号位: (#G速度+10%#W)")
	   self.介绍文本:添加文本("5号位: (#G速度+10%#W)")
	elseif 我阵型=="云垂阵" then
	   if 敌阵型=="天覆阵" or 敌阵型=="风扬阵"  then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")--+++++++++++
	   elseif 敌阵型=="鸟翔阵"or 敌阵型=="蛇蟠阵"or 敌阵型=="鹰啸阵" then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")--+++++++++++

	   elseif 敌阵型=="龙飞阵"or 敌阵型=="虎翼阵" or 敌阵型=="雷绝阵" then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")---------------
	   elseif 敌阵型=="普通" or 敌阵型=="地载阵"  then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")---------------
	   end
	   self.介绍文本:添加文本("1号位: (#G物防+40%#W)".."(".."#R速度-30%".."#W)")
	   self.介绍文本:添加文本("2号位: (#G全防+10%#W)")
	   self.介绍文本:添加文本("3号位: (#G全伤+20%#W)")
	   self.介绍文本:添加文本("4号位: (#G速度+15%#W)")
	   self.介绍文本:添加文本("5号位: (#G速度+15%#W)")
	elseif 我阵型=="龙飞阵" then
	   if 敌阵型=="普通"or 敌阵型=="地载阵" or 敌阵型=="风扬阵"  then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")--+++++++++++
	   elseif 敌阵型=="云垂阵"or 敌阵型=="雷绝阵" then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")--+++++++++++

	   elseif 敌阵型=="天覆阵"or 敌阵型=="鹰啸阵"then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")---------------
	   elseif 敌阵型=="虎翼阵" or 敌阵型=="鸟翔阵"or 敌阵型=="蛇蟠阵"  then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")---------------
	   end
	   self.介绍文本:添加文本("1号位: (#G法防+20%#W)")
	   self.介绍文本:添加文本("2号位: (#G物防+20%#W)")
	   self.介绍文本:添加文本("3号位: (#G法伤+30%#W)".."(".."#R速度-30%".."#W)")
	   self.介绍文本:添加文本("4号位: (#G速度+15%#W)")
	   self.介绍文本:添加文本("5号位: (#G全伤+20%#W)")
	elseif 我阵型=="虎翼阵" then
	   if 敌阵型=="天覆阵"or 敌阵型=="龙飞阵"or 敌阵型=="雷绝阵"  then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")--+++++++++++
	   elseif 敌阵型=="风扬阵"or 敌阵型=="云垂阵" then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")--+++++++++++

	   elseif 敌阵型=="地载阵"or 敌阵型=="鸟翔阵"then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")---------------
	   elseif 敌阵型=="普通"or 敌阵型=="蛇蟠阵"or 敌阵型=="鹰啸阵"  then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")---------------
	   end
	   self.介绍文本:添加文本("1号位: (#G全伤+25%#W)")
	   self.介绍文本:添加文本("2号位: (#G全防+10%#W)")
	   self.介绍文本:添加文本("3号位: (#G全防+10%#W)")
	   self.介绍文本:添加文本("4号位: (#G全伤+10%#W)")
	   self.介绍文本:添加文本("5号位: (#G全伤+10%#W)")
	elseif 我阵型=="鸟翔阵" then
	   if 敌阵型=="普通"or 敌阵型=="龙飞阵"or 敌阵型=="鹰啸阵"  then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")--+++++++++++
	   elseif 敌阵型=="地载阵"or 敌阵型=="虎翼阵" then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")--+++++++++++

	   elseif 敌阵型=="风扬阵"or 敌阵型=="云垂阵"then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")---------------
	   elseif 敌阵型=="天覆阵"or 敌阵型=="蛇蟠阵"or 敌阵型=="雷绝阵"  then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")---------------
	   end
	   self.介绍文本:添加文本("1号位: (#G速度+20%#W)")
	   self.介绍文本:添加文本("2号位: (#G速度+20%#W)")
	   self.介绍文本:添加文本("3号位: (#G速度+20%#W)")
	   self.介绍文本:添加文本("4号位: (#G速度+20%#W)")
	   self.介绍文本:添加文本("5号位: (#G速度+20%#W)")
	elseif 我阵型=="蛇蟠阵" then
	   if 敌阵型=="地载阵"or 敌阵型=="风扬阵"or 敌阵型=="龙飞阵"or 敌阵型=="虎翼阵"or 敌阵型=="鸟翔阵"or 敌阵型=="雷绝阵"  then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")--+++++++++++
	   elseif 敌阵型=="天覆阵" then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")--+++++++++++

	   elseif 敌阵型=="云垂阵"then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")---------------
	   elseif 敌阵型=="普通"or 敌阵型=="鹰啸阵"  then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")---------------
	   end
	   self.介绍文本:添加文本("1号位: (#G法防+15%#W)")
	   self.介绍文本:添加文本("2号位: (#G法防+15%#W)")
	   self.介绍文本:添加文本("3号位: (#G法防+15%#W)")
	   self.介绍文本:添加文本("4号位: (#G全伤+10%#W)")
	   self.介绍文本:添加文本("5号位: (#G全伤+10%#W)")
	elseif 我阵型=="鹰啸阵" then
	   if 敌阵型=="普通"or 敌阵型=="虎翼阵"or 敌阵型=="蛇蟠阵"  then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")--+++++++++++
	   elseif 敌阵型=="地载阵"or 敌阵型=="龙飞阵" then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")--+++++++++++

	   elseif 敌阵型=="风扬阵"or 敌阵型=="云垂阵"or 敌阵型=="鸟翔阵"or 敌阵型=="雷绝阵"then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")---------------
	   elseif 敌阵型=="天覆阵"  then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")---------------
	   end
	   self.介绍文本:添加文本("1号位: (#G全防+10%#W)")
	   self.介绍文本:添加文本("2号位: (#G速度+15%#W)")
	   self.介绍文本:添加文本("3号位: (#G速度+15%#W)")
	   self.介绍文本:添加文本("4号位: (#G全伤+15%#W)")
	   self.介绍文本:添加文本("5号位: (#G全伤+10%#W)")
	elseif 我阵型=="雷绝阵" then
	   if 敌阵型=="天覆阵"or 敌阵型=="鸟翔阵"or 敌阵型=="鹰啸阵"then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")--+++++++++++
	   elseif 敌阵型=="风扬阵"or 敌阵型=="云垂阵" then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#G克制+"..self.克制.."%#W)")--+++++++++++

	   elseif 敌阵型=="地载阵"or 敌阵型=="龙飞阵" then
	   	   self.克制=10
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")---------------
	   elseif 敌阵型=="普通"or 敌阵型=="虎翼阵"or 敌阵型=="蛇蟠阵"  then
	   	   self.克制=5
	   	   self.介绍文本:添加文本(我阵型.."(#R克制-"..self.克制.."%#W)")---------------
	   end
	   self.介绍文本:添加文本("1号位: (#G固伤+20%#W)")
	   self.介绍文本:添加文本("2号位: (#G固伤+20%#W)")
	   self.介绍文本:添加文本("3号位: (#G固伤+20%#W)")
	   self.介绍文本:添加文本("4号位: (#G全伤+10%#W)")
	   self.介绍文本:添加文本("5号位: (#G全伤+10%#W)")
	end

	local h = self.介绍文本.显示表.高度
	if x + w >= 780 then
		x = 780 - w
	end
	if y + h >= 580 then
		y = y - h - 30
	end
	self.寄存内容 = {}
	self.寄存内容[1] = {}
	tp.字体表.普通字体:置阴影颜色(nil)
	self.寄存内容[1].文字 = tp.字体表.普通字体
	self.寄存内容[1].内容 = self.介绍文本
	self.寄存内容[1].x = x + 10
	self.寄存内容[1].y = y + 5
	self.寄存内容.提示坐标 = {[1]=x,[2]=y,[3]=w,[4]=h}
	self.寄存内容.开启提示 = true
end

function 系统类_提示框:其他提示(x,y,f)
	local x = x+25
	local y = y-10
	local w = 105
	local h = 27
	if f ~= nil and f.性别 ~= nil then
		h = 43
	end
	if x + w >= 全局游戏宽度-20 then
		x = 全局游戏宽度-20-w
		if f then
			x = x - (w/1.8)
		end
	end
	jls:置宽高(w+15,h+16)
	jls:显示(x,y)
	local zt = tp.字体表.普通字体
	zt:置颜色(-256)
	if h == 43 then
		zt:显示(x + 7,y + 7,format("气血:%d/%d",f.气血,f.最大气血))
		zt:显示(x + 7,y + 23,format("魔法:%d/%d",f.魔法,f.最大魔法))
		zt:显示(x + 7,y + 39,format("愤怒:%d/150",f.愤怒))
	else
		zt:显示(x + 7,y + 7,format("气血:%d/%d",f.气血,f.最大气血))
		zt:显示(x + 7,y + 23,format("魔法:%d/%d",f.魔法,f.最大魔法))
	end
end
function 系统类_提示框:自定义(x,y,txt)
	local x = x + 25
	local y = y
	self.介绍文本:清空()
	self.介绍文本:添加文本(txt)
	local w = self.介绍文本.显示表.宽度
	local h = self.介绍文本.显示表.高度
	if x + w >= 全局游戏宽度-20 then
		x = 全局游戏宽度-20 - w
	end
	if y + h >= 600 then
		y = y - h - 30
	end
	self.寄存内容 = {}
	self.寄存内容[1] = {}
	self.寄存内容[1].内容 = self.介绍文本
	self.寄存内容[1].x = x + 6
	self.寄存内容[1].y = y + 6
	self.寄存内容.提示坐标 = {[1]=x,[2]=y,[3]=w,[4]=h}
	self.寄存内容.开启提示 = true
end
function 系统类_提示框:技能(x,y,skill,冷却,ps)
	local x = x + 30
	local y = y
	local w = 243
	self.介绍文本:清空()
	self.介绍文本:添加文本("")
	self.介绍文本:添加文本("")
	self.介绍文本:添加文本(skill.介绍)
	if skill.消耗说明 ~= nil then
		self.介绍文本:添加文本("#G/消耗："..skill.消耗说明)
	end
	if skill.使用条件 ~= nil and skill.学会 == false and not tp.战斗中 and not ps then
		self.介绍文本:添加文本(format("#G/条件：%s",skill.使用条件))
	end
	if skill.冷却 ~= nil then
		self.介绍文本:添加文本(format("#G/冷却：%s",skill.冷却))
	end
	if 冷却 ~= nil then
		self.介绍文本:添加文本(format("#R/剩余冷却回合：%d回合",冷却))
	end
	local h = self.介绍文本.显示表.高度-10
	if x + w >= 全局游戏宽度-20 then
		x = 全局游戏宽度-20 - w
	end
	if y + h >= 600 then
		y = y - h - 30
	end
	self.寄存内容 = {}
	self.寄存内容[1] = {}
	self.寄存内容[1].内容 = self.介绍文本
	self.寄存内容[1].x = x + 9
	self.寄存内容[1].y = y - 5
	self.寄存内容[2] = {}
	tp.字体表.人物字体_:置阴影颜色(nil)
	self.寄存内容[2].文字 = tp.字体表.人物字体_
	self.寄存内容[2].颜色 = ARGB(255,0,255,0)
	self.寄存内容[2].文本 = skill.名称
	self.寄存内容[2].坐标 = {[1]=x+10,[2] =y+10}
	self.寄存内容.提示坐标 = {[1]=x,[2]=y,[3]=w,[4]=h}
	self.寄存内容.开启提示 = true
end



function 系统类_提示框:超级技能(x,y,名称,进化)
	local x = x + 30
	local y = y
	local w = 255
	local 超级名称=名称
	if 名称=="奔雷咒"or 名称=="泰山压顶"or 名称=="水漫金山"or 名称=="壁垒击破"or 名称=="地狱烈火" then
		超级名称="超级"..名称
	else
	    if string.find(名称, "高级")~= nil then
	    	local 临时名称=分割文本(名称, "高级")
	    	 超级名称="超级"..临时名称[2]
		end
	end
	local 超级资源=引擎.取技能(超级名称)
	local 超级图标=tp.资源:载入(超级资源[6],"网易WDF动画",超级资源[7])
	local  临时资源=引擎.取技能(名称)
	local 高级图标= tp.资源:载入(临时资源[6],"网易WDF动画",临时资源[7])
	self.超级文本:清空()
	self.超级文本:添加文本("")
	self.超级文本:添加文本("#G"..超级资源[1])
	self.超级文本1:清空()
	self.超级文本1:添加文本("")
	self.超级文本1:添加文本("#G"..临时资源[1])




	local h = self.超级文本.显示表.高度+self.超级文本1.显示表.高度+30
	if x + w >= 全局游戏宽度-20 then
		x = 全局游戏宽度-20 - w
	end
	if y + h >= 600 then
		y = y - h - 30
	end
	self.寄存内容 = {}
	self.寄存内容[1] = {}
	self.寄存内容[1].内容 = 超级图标
	self.寄存内容[1].x = x + 10
	self.寄存内容[1].y = y + 10
	self.寄存内容[2] = {}
	self.寄存内容[2].内容 = self.超级文本
	self.寄存内容[2].x = x + 60
	self.寄存内容[2].y = y + 10

	self.寄存内容[3] = {}
	self.寄存内容[3].内容 =  高级图标
	self.寄存内容[3].x = x + 10
	self.寄存内容[3].y = y + self.超级文本.显示表.高度+30
	self.寄存内容[4] = {}
	self.寄存内容[4].内容 = self.超级文本1
	self.寄存内容[4].x = x + 60
	self.寄存内容[4].y = y + self.超级文本.显示表.高度+30
	tp.字体表.人物字体_:置阴影颜色(nil)
	self.寄存内容[5] = {}
	self.寄存内容[5].文字 = tp.字体表.人物字体_
	self.寄存内容[5].颜色 = 0xFFFF0000
	if 进化 then
	  self.寄存内容[5].文本 = 超级名称..进化
	else
	  self.寄存内容[5].文本 = 超级名称.."(进化后获得)"
	end
	self.寄存内容[5].坐标 = {[1]=x+60,[2] =y+5}

	self.寄存内容[6] = {}
	self.寄存内容[6].文字 = tp.字体表.人物字体_
	self.寄存内容[6].颜色 =0xFFFFFF00
	self.寄存内容[6].文本 = 名称
	self.寄存内容[6].坐标 = {[1]=x+60,[2] =y+self.超级文本.显示表.高度+25}
	local ht = tp.资源:载入("登陆资源.wdf","网易WDF动画",0x381EAF65)
	 ht:置区域(0,0,270,2)
	self.寄存内容[7] = {}
	self.寄存内容[7].内容 = ht
	self.寄存内容[7].x = x
	self.寄存内容[7].y = y + self.超级文本.显示表.高度+18




	self.寄存内容.提示坐标 = {[1]=x,[2]=y,[3]=w,[4]=h}
	self.寄存内容.开启提示 = true
end






function 系统类_提示框:经脉技能(x,y,skill,冷却,ps)
	local x = x + 30
	local y = y
	local w = 243
	-- if self:取经脉介绍(skill.名称) ~= nil and self:取经脉介绍(skill.名称)[1] ~= nil then
	--  skill.介绍 = 引擎.取奇经八脉技能(skill.名称)[1]
	-- end
	self.介绍文本:清空()
	self.介绍文本:添加文本("")
	self.介绍文本:添加文本("")
	self.介绍文本:添加文本(skill.介绍)
	if skill.消耗说明 ~= nil then
		self.介绍文本:添加文本("#G/消耗："..skill.消耗说明)
	end
	if skill.使用条件 ~= nil and skill.学会 == false and not tp.战斗中 and not ps then
		self.介绍文本:添加文本(format("#G/条件：%s",skill.使用条件))
	end
	if skill.冷却 ~= nil then
		self.介绍文本:添加文本(format("#G/冷却：%s",skill.冷却))
	end
	if 冷却 ~= nil then
		self.介绍文本:添加文本(format("#R/剩余冷却回合：%d回合",冷却))
	end
	local h = self.介绍文本.显示表.高度-10
	if x + w >= 全局游戏宽度-20 then
		x = 全局游戏宽度-20 - w
	end
	if y + h >= 600 then
		y = y - h - 30
	end
	self.寄存内容 = {}
	self.寄存内容[1] = {}
	self.寄存内容[1].内容 = self.介绍文本
	self.寄存内容[1].x = x + 9
	self.寄存内容[1].y = y - 5
	self.寄存内容[2] = {}
	tp.字体表.人物字体_:置阴影颜色(nil)
	self.寄存内容[2].文字 = tp.字体表.人物字体_
	self.寄存内容[2].颜色 = ARGB(255,0,255,0)
	self.寄存内容[2].文本 = skill.名称
	self.寄存内容[2].坐标 = {[1]=x+10,[2] =y+10}
	self.寄存内容.提示坐标 = {[1]=x,[2]=y,[3]=w,[4]=h}
	self.寄存内容.开启提示 = true
end

function 系统类_提示框:印记(x,y,yj)
	local x = x + 25
	local y = y + 25
	local xs = 0
	self.道具文本:清空()
    for i,v in pairs(yj) do
		self.道具文本:添加文本(format("#Y/%s印记#R/%d#Y/层",i,v))
		xs = 1
	end
	if xs == 0 then
		return false
	end
	local h = self.道具文本.显示表.高度
	if x >= 全局游戏宽度-100 then
		x = 全局游戏宽度-100
	end
	if y + h > 600 then
		y = y - h - 30
	end
	self.寄存内容 = {}
	self.寄存内容[1] = {}
	self.寄存内容[1].内容 = self.道具文本
	self.寄存内容[1].x = x+7
	self.寄存内容[1].y = y+8
	self.寄存内容.提示坐标 = {[1]=x,[2]=y,[3]=80,[4]=h}
	self.寄存内容.开启提示 = true
end
function 系统类_提示框:内丹提示(x,y,png,ad)
	local x = x + 30
	local y = y
	local w = 238
	self.介绍文本:清空()
	if ad.等级 ~= nil then
	    self.介绍文本:添加文本("#G/"..ad.等级.."层/5层")
	end
	self.介绍文本:添加文本(ad.说明)
	if ad.效果 ~= nil then
	    self.介绍文本:添加文本("#Y/"..ad.效果)
	end
	local h = self.介绍文本.显示表.高度+48
	if h < 80 then
		h = 80
	end
	if x < 3 then
		x = 3
	end
	if x + w >= 全局游戏宽度-20 then
		x = 全局游戏宽度-20 - w
	end
	if y + h > 600 then
		y = y - h - 30
	end
	self.寄存内容 = {}
	self.寄存内容[1] = {}
	self.寄存内容[1].内容 = png
	self.寄存内容[1].x = x+10
	self.寄存内容[1].y = y+10
	if ad.名称 ~= nil then
	    self.寄存内容[2] = {}
		self.寄存内容[2].内容 = self.介绍文本
		self.寄存内容[2].x = x + 49
		self.寄存内容[2].y = y + 30
	else
		self.寄存内容[2] = {}
		self.寄存内容[2].内容 = self.介绍文本
		self.寄存内容[2].x = x + 5
		self.寄存内容[2].y = y + 48
	end
	if ad.技能 ~= nil then
		self.寄存内容[3] = {}
		self.寄存内容[3].文字 = tp.字体表.人物字体_
		self.寄存内容[3].颜色 = -256
		self.寄存内容[3].文本 = ad.技能
		self.寄存内容[3].坐标 = {[1]=x+55,[2] =y+20}
	else
		self.寄存内容[3] = {}
		self.寄存内容[3].文字 = tp.字体表.人物字体_
		self.寄存内容[3].颜色 = -256
		self.寄存内容[3].文本 = ad.名称
		self.寄存内容[3].坐标 = {[1]=x+50,[2] =y+11}
	end

	self.寄存内容.提示坐标 = {[1]=x,[2]=y,[3]=w,[4]=h}
	self.寄存内容.开启提示 = true
end
function 系统类_提示框:红尘试炼(x,y,ad)
	local x = x + 30
	local y = y
	local w = 135
	local h = 15
	self.道具文本:清空()
	self.道具文本:添加文本("#Y/红尘试炼·"..(ad[5] or ad[1]))
	if x < 3 then
		x = 3
	end
	if x + w >= 全局游戏宽度-20 then
		x = 全局游戏宽度-20 - w
	end
	if y + h > 600 then
		y = y - h - 30
	end
	self.寄存内容 = {}
	self.寄存内容[1] = {}
	self.寄存内容[1].内容 = png
	self.寄存内容[1].x = x+10
	self.寄存内容[1].y = y+10
	self.寄存内容[2] = {}
	self.寄存内容[2].内容 = self.道具文本
	self.寄存内容[2].x = x + 5
	self.寄存内容[2].y = y + 5
	self.寄存内容.提示坐标 = {[1]=x,[2]=y,[3]=w,[4]=h}
	self.寄存内容.开启提示 = true
end
local function 取境界(j,w)
	if w==1 then
		if j == 0 then
			return "#C/略晓变化"
		elseif j == 1 then
			return "#W/略晓变化"
	    elseif j == 2 then
			return "#S/驾轻就熟"
		elseif j == 3 then
			return "#S/心领神会"
		elseif j == 4 then
			return "#S/出类拔萃"
		elseif j == 5 then
			return "#S/腾云驾雾"
		elseif j == 6 then
			return "#S/降龙伏虎"
		elseif j == 7 then
			return "#S/神乎其技"
		elseif j == 8 then
			return "#S/纵横三界"
	  	elseif j == 9 then
			return "#S/不堕轮回"
		end
 	elseif w==2 then
	 	if  j==0 or j==1 then
			return "#C/了然于胸"
		elseif j == 2 then
			return "#W/妙领天机"
		elseif j == 3 then
			return "#S/渐入佳境"
		elseif j == 4 then
			return "#S/预知福祸"
		elseif j == 5 then
			return "#S/脱胎换骨"
		elseif j == 6 then
			return "#S/出神入化"
		elseif j == 7 then
			return "#S/呼风唤雨"
		elseif j == 8 then
			return "#S/随心所欲"
		elseif j == 9 then
			return "#S/登峰造极"
	   	elseif j == 10 then
			return "#S/道满根归"
	   	elseif j == 11 then
			return "#S/不堕轮回"
	   	elseif j == 12 then
			return "#S/法力无边"
		end
  	elseif w==3 then
	 	if  j==0 or j==1 then
			return "#C/一日千里"
		elseif j == 2 then
			return "#W/脱胎换骨"
		elseif j == 3 then
			return "#S/负海担山"
		elseif j == 4 then
			return "#S/霞举飞升"
		elseif j == 5 then
			return "#S/移星换斗"
		elseif j == 6 then
			return "#S/变幻莫测"
		elseif j == 7 then
			return "#S/擎日挽月"
		elseif j == 8 then
			return "#S/道满根归"
		elseif j == 9 then
			return "#S/不堕轮回"
	   	elseif j == 10 then
			return "#S/举世无双"
	   	elseif j == 11 then
			return "#S/纵横三界"
	   	elseif j == 12 then
		 	return "#S/笑傲西游"
	   	elseif j == 13 then
		 	return "#S/法力无边"
	   	elseif j == 14 then
		 	return "#S/反璞归真"
	   	elseif j == 15 then
		 	return "#S/天人合一"
	   	end
	elseif w==4 then
		if  j==0 or j==1 then
			return "#C/一日千里"
		elseif j == 2 then
			return "#W/脱胎换骨"
		elseif j == 3 then
			return "#S/负海担山"
		elseif j == 4 then
			return "#S/霞举飞升"
		elseif j == 5 then
			return "#S/移星换斗"
		elseif j == 6 then
			return "#S/变幻莫测"
		elseif j == 7 then
			return "#S/擎日挽月"
		elseif j == 8 then
			return "#S/道满根归"
		elseif j == 9 then
			return "#S/不堕轮回"
	   	elseif j == 10 then
			return "#S/举世无双"
	   	elseif j == 11 then
			return "#S/纵横三界"
	   	elseif j == 12 then
		 	return "#S/笑傲西游"
	   	elseif j == 13 then
		 	return "#S/法力无边"
	   	elseif j == 14 then
		 	return "#S/反璞归真"
	   	elseif j == 15 then
		 	return "#S/天人合一"
		elseif j == 16 then
		 	return "#S/元神初具"
		elseif j == 17 then
		 	return "#S/再历劫尘"
		elseif j == 18 then
		 	return "#f/欲火涅槃"
	   	end
  	end
end

function 系统类_提示框:取符石组合介绍(数据)
  local jies = {}
    if 数据.符石组合=="无心插柳" then
        if 数据.等级 == 1 then
            jies.介绍="每回合第1下物理攻击怪物目标时溅射其他目标并造成当前伤害的15%伤害。"
        elseif 数据.等级 == 2 then
            jies.介绍="每回合第1下物理攻击怪物目标时溅射其他目标并造成当前伤害的20%伤害。"
        elseif 数据.等级 == 3 then
          	jies.介绍="每回合第1下物理攻击怪物目标时溅射其他目标并造成当前伤害的25%伤害。"
        elseif 数据.等级 == 4 then
          	jies.介绍="每回合第1下物理攻击怪物目标时溅射其他目标并造成当前伤害的30%伤害。"
        end
        jies.门派 = "无"
        jies.部位 = "所有"
    elseif 数据.符石组合=="万丈霞光" then
        if 数据.等级 == 1 then
            jies.介绍="增加50点治疗能力，包括师门技能和特技"
        elseif 数据.等级 == 2 then
            jies.介绍="增加80点治疗能力，包括师门技能和特技"
        elseif 数据.等级 == 3 then
          jies.介绍="增加120点治疗能力，包括师门技能和特技"
        elseif 数据.等级 == 4 then
          jies.介绍="增加200点治疗能力，包括师门技能和特技"
        end
        jies.门派 = "无"
        jies.部位 = "所有"
    elseif 数据.符石组合=="飞檐走壁" then
        if 数据.等级 == 1 then
            jies.介绍="释放法术时降低8%的MP消耗"
        elseif 数据.等级 == 2 then
            jies.介绍="释放法术时降低12%的MP消耗"
        elseif 数据.等级 == 3 then
          jies.介绍="释放法术时降低16%的MP消耗"
        end
        jies.门派 = "无"
        jies.部位 = "所有"
    elseif 数据.符石组合=="百步穿杨" then
        if 数据.等级 == 1 then
            jies.介绍="物理类攻击时有20%的几率给目标额外造成20点伤害"
        elseif 数据.等级 == 2 then
            jies.介绍="物理类攻击时有20%的几率给目标额外造成45点伤害"
        elseif 数据.等级 == 3 then
          jies.介绍="物理类攻击时有20%的几率给目标额外造成60点伤害"
        elseif 数据.等级 == 4 then
          jies.介绍="物理类攻击时有20%的几率给目标额外造成80点伤害"
        end
        jies.门派 = "无"
        jies.部位 = "所有"
    elseif 数据.符石组合=="隔山打牛" then
        if 数据.等级 == 1 then
            jies.介绍="法术攻击时有20%的几率临时提升自身20点灵力"
        elseif 数据.等级 == 2 then
            jies.介绍="法术攻击时有20%的几率临时提升自身30点灵力"
        elseif 数据.等级 == 3 then
          jies.介绍="法术攻击时有25%的几率临时提升自身50点灵力"
        elseif 数据.等级 == 4 then
          jies.介绍="法术攻击时有25%的几率临时提升自身70点灵力"
        end
        jies.门派 = "无"
        jies.部位 = "所有"
    elseif 数据.符石组合=="心随我动" then
        if 数据.等级 == 1 then
            jies.介绍="遭受物理类攻击时有25%几率抵挡25点伤害"
        elseif 数据.等级 == 2 then
            jies.介绍="遭受物理攻击时有25%几率抵挡40点伤害"
        elseif 数据.等级 == 3 then
          jies.介绍="遭受物理类攻击时有25%几率抵挡70点伤害"
        elseif 数据.等级 == 4 then
          jies.介绍="遭受物理类攻击时有25%几率抵挡90点伤害"
        end
        jies.门派 = "无"
        jies.部位 = "所有"
    elseif 数据.符石组合=="云随风舞" then
        if 数据.等级 == 1 then
            jies.介绍="遭受法术攻击时有20%几率抵挡20点伤害"
        elseif 数据.等级 == 2 then
            jies.介绍="遭受法术攻击时有20%几率抵挡40点伤害"
        elseif 数据.等级 == 3 then
          jies.介绍="遭受法术攻击时有20%几率抵挡70点伤害"
        elseif 数据.等级 == 4 then
          jies.介绍="遭受法术攻击时有20%几率抵挡80点伤害"
        end
        jies.门派 = "无"
        jies.部位 = "所有"
    elseif 数据.符石组合=="风卷残云" then
        if 数据.等级 == 1 then
          jies.介绍="击倒鬼魂目标时有5%几率将其打飞出场"
        elseif 数据.等级 == 2 then
          jies.介绍="击倒鬼魂目标时有10%几率将其打飞出场"
        elseif 数据.等级 == 3 then
          jies.介绍="击倒鬼魂目标时有15%几率将其打飞出场"
        elseif 数据.等级 == 4 then
          jies.介绍="击倒鬼魂目标时有20%几率将其打飞出场"
        end
        jies.门派 = "无"
        jies.部位 = "所有"
    elseif 数据.符石组合=="天降大任" then
        if 数据.等级 == 1 then
          jies.介绍="无视召唤兽5%的物理防御进行攻击。(该组合全身只有一件装备起效)"
        elseif 数据.等级 == 2 then
          jies.介绍="无视召唤兽10%的物理防御进行攻击。(该组合全身只有一件装备起效)"
        elseif 数据.等级 == 3 then
          jies.介绍="无视召唤兽15%的物理防御进行攻击。(该组合全身只有一件装备起效)"
        end
        jies.门派 = "无"
        jies.部位 = "所有"
    elseif 数据.符石组合=="无懈可击" then
        jies.介绍="提升自身30点防御力"
        jies.门派 = "无"
        jies.部位 = "所有"
    elseif 数据.符石组合=="望穿秋水" then
        jies.介绍="提升自身30点灵力"
        jies.门派 = "无"
        jies.部位 = "所有"
    elseif 数据.符石组合=="万里横行" then
        jies.介绍="提升自身40点伤害"
        jies.门派 = "无"
        jies.部位 = "所有"
    elseif 数据.符石组合=="日落西山" then
        jies.介绍="提升自身40点速度"
        jies.门派 = "无"
        jies.部位 = "所有"
    elseif 数据.符石组合=="网罗乾坤" then
        if 数据.等级 == 1 then
        jies.介绍="使用天罗地网时，增加人物等级/2的伤害"
        elseif 数据.等级 == 2 then
        jies.介绍="使用天罗地网时，增加人物等级/1.5的伤害"
        elseif 数据.等级 == 3 then
        jies.介绍="使用天罗地网时，增加人物等级的伤害"
        end
        jies.门派 = "盘丝洞"
        jies.部位 = "所有"
    elseif 数据.符石组合=="石破天惊" then
        if 数据.等级 == 1 then
            jies.介绍="使用落雷符时增加人物等级/2的伤害，装备该组合时降低5%的防御"
        elseif 数据.等级 == 2 then
            jies.介绍="使用落雷符时增加人物等级/1.5的伤害，装备该组合时降低5%的防御"
        elseif 数据.等级 == 3 then
          jies.介绍="使用落雷符时增加人物等级的伤害，装备该组合时降低5%的防御"
        end
        jies.门派 = "方寸山"
        jies.部位 = "所有"
    elseif 数据.符石组合=="天雷地火" then
        if 数据.等级 == 1 then
            jies.介绍="使用天雷斩、雷霆万钧时增加人物等级/2的伤害，装备该组合时降低5%的防御"
        elseif 数据.等级 == 2 then
            jies.介绍="使用天雷斩、雷霆万钧时增加人物等级/1.5的伤害，装备该组合时降低5%的防御"
        elseif 数据.等级 == 3 then
          jies.介绍="使用天雷斩、雷霆万钧时增加人物等级的伤害，装备该组合时降低5%的防御"
        end
        jies.门派 = "天宫"
        jies.部位 = "所有"
    elseif 数据.符石组合=="烟雨飘摇" then
        if 数据.等级 == 1 then
            jies.介绍="使用烟雨剑法、飘渺式时增加人物等级/2的伤害，装备该组合时降低5%的防御"
        elseif 数据.等级 == 2 then
            jies.介绍="使用烟雨剑法、飘渺式时增加人物等级/1.5的伤害，装备该组合时降低5%的防御"
        elseif 数据.等级 == 3 then
          jies.介绍="使用烟雨剑法、飘渺式时增加人物等级的伤害，装备该组合时降低5%的防御"
        end
        jies.门派 = "五庄观"
        jies.部位 = "所有"
    elseif 数据.符石组合=="索命无常" then
        if 数据.等级 == 1 then
            jies.介绍="使用阎罗令时，增加人物等级/2的伤害，装备该组合时降低5%的防御"
        elseif 数据.等级 == 2 then
            jies.介绍="使用阎罗令时，增加人物等级/1.5的伤害，装备该组合时降低5%的防御"
        elseif 数据.等级 == 3 then
          jies.介绍="使用阎罗令时，增加人物等级的伤害，装备该组合时降低5%的防御"
        end
        jies.门派 = "阴曹地府"
        jies.部位 = "所有"
    elseif 数据.符石组合=="行云流水" then
        if 数据.等级 == 1 then
            jies.介绍="使用五行法术时，增加人物等级/2的伤害，装备该组合时降低5%的防御"
        elseif 数据.等级 == 2 then
            jies.介绍="使用五行法术时，增加人物等级/1.5的伤害，装备该组合时降低5%的防御"
        elseif 数据.等级 == 3 then
          jies.介绍="使用五行法术时，增加人物等级的伤害，装备该组合时降低5%的防御"
        end
        jies.门派 = "普陀山"
        jies.部位 = "所有"
    elseif 数据.符石组合=="福泽天下" then
        if 数据.等级 == 1 then
            jies.介绍="使用唧唧歪歪时，增加人物等级/2的伤害，装备该组合时降低5%的防御"
        elseif 数据.等级 == 2 then
            jies.介绍="使用唧唧歪歪时，增加人物等级/2的伤害，装备该组合时降低5%的防御"
        elseif 数据.等级 == 3 then
          jies.介绍="使用唧唧歪歪时，增加人物等级/2的伤害，装备该组合时降低5%的防御"
        end
        jies.门派 = "化生寺"
        jies.部位 = "所有"
    elseif 数据.符石组合=="暗度陈仓" then
        jies.介绍="受到物理攻击时，降低3%的所受伤害。"
        jies.门派 = "无"
        jies.部位 = "所有"
    elseif 数据.符石组合=="点石成金" then
        jies.介绍="防御时，遭受物理攻击所受到的伤害降低20%"
        jies.门派 = "无"
        jies.部位 = "所有"
    elseif 数据.符石组合=="化敌为友" then
        jies.介绍="受到法术攻击时，降低3%的所受伤害。"
        jies.门派 = "无"
        jies.部位 = "所有"
    elseif 数据.符石组合=="凤舞九天" then
        if 数据.等级 == 1 then
            jies.介绍="使用暗器时增加人物等级/3的伤害"
        elseif 数据.等级 == 2 then
            jies.介绍="使用暗器时增加人物等级/1.5的伤害"
        elseif 数据.等级 == 3 then
          jies.介绍="使用暗器时增加人物等级×1的伤害"
        end
        jies.门派 = "女儿村"
        jies.部位 = "所有"
    elseif 数据.符石组合=="高山流水" then
        if 数据.等级 == 1 then
            jies.介绍="增加人物等级/3+30的法术伤害。(该组合全身只有一件装备起效)"
        elseif 数据.等级 == 2 then
            jies.介绍="增加人物等级/2+30的法术伤害。(该组合全身只有一件装备起效)"
        elseif 数据.等级 == 3 then
          jies.介绍="增加人物等级+30的法术伤害。(该组合全身只有一件装备起效)"
        end
        jies.门派 = "无"
        jies.部位 = "所有"
    elseif 数据.符石组合=="百无禁忌" then
        if 数据.等级 == 1 then
            jies.介绍="提高自身4%对抗封印类技能的能力"
        elseif 数据.等级 == 2 then
            jies.介绍="提高自身8%对抗封印类技能的能力"
        elseif 数据.等级 == 3 then
          jies.介绍="提高自身12%对抗封印类技能的能力"
        end
        jies.门派 = "无"
        jies.部位 = "靴"
    elseif 数据.符石组合=="为官之道符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能为官之道等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能为官之道等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能为官之道等级6级"
        end
        jies.门派 = "大唐官府"
        jies.部位 = "头盔/发钗"
    elseif 数据.符石组合=="黄庭经符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能黄庭经等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能黄庭经等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能黄庭经等级6级"
        end
        jies.门派 = "方寸山"
        jies.部位 = "头盔/发钗"
    elseif 数据.符石组合=="小乘佛法符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能小乘佛法等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能小乘佛法等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能小乘佛法等级6级"
        end
        jies.门派 = "化生寺"
        jies.部位 = "头盔/发钗"
    elseif 数据.符石组合=="毒经符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能毒经等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能毒经等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能毒经等级6级"
        end
        jies.门派 = "女儿村"
        jies.部位 = "头盔/发钗"
    elseif 数据.符石组合=="天罡气符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能天罡气等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能天罡气等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能天罡气等级6级"
        end
        jies.门派 = "天宫"
        jies.部位 = "头盔/发钗"
    elseif 数据.符石组合=="九龙诀符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能九龙诀等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能九龙诀等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能九龙诀等级6级"
        end
        jies.门派 = "龙宫"
        jies.部位 = "头盔/发钗"
    elseif 数据.符石组合=="周易学符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能周易学等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能周易学等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能周易学等级6级"
        end
        jies.门派 = "五庄观"
        jies.部位 = "头盔/发钗"
    elseif 数据.符石组合=="灵性符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能灵性等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能灵性等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能灵性等级6级"
        end
        jies.门派 = "普陀山"
        jies.部位 = "头盔/发钗"
    elseif 数据.符石组合=="灵通术符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能灵通术等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能灵通术等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能灵通术等级6级"
        end
        jies.门派 = "阴曹地府"
        jies.部位 = "头盔/发钗"
    elseif 数据.符石组合=="牛逼神功符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能牛逼神功等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能牛逼神功等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能牛逼神功等级6级"
        end
        jies.门派 = "魔王寨"
        jies.部位 = "头盔/发钗"
    elseif 数据.符石组合=="魔兽神功符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能魔兽神功等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能魔兽神功等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能魔兽神功等级6级"
        end
        jies.门派 = "狮驼岭"
        jies.部位 = "头盔/发钗"
    elseif 数据.符石组合=="蛛丝阵法符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能蛛丝阵法等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能蛛丝阵法等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能蛛丝阵法等级6级"
        end
        jies.门派 = "盘丝洞"
        jies.部位 = "头盔/发钗"
    elseif 数据.符石组合=="文韬武略符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能文韬武略等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能文韬武略等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能文韬武略等级6级"
        end
        jies.门派 = "大唐官府"
        jies.部位 = "腰带"
    elseif 数据.符石组合=="归元心法符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能归元心法等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能归元心法等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能归元心法等级6级"
        end
        jies.门派 = "方寸山"
        jies.部位 = "腰带"
    elseif 数据.符石组合=="佛光普照符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能佛光普照等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能佛光普照等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能佛光普照等级6级"
        end
        jies.门派 = "化生寺"
        jies.部位 = "腰带"
    elseif 数据.符石组合=="倾国倾城符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能倾国倾城等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能倾国倾城等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能倾国倾城等级6级"
        end
        jies.门派 = "女儿村"
        jies.部位 = "腰带"
    elseif 数据.符石组合=="傲世诀符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能傲世诀等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能傲世诀等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能傲世诀等级6级"
        end
        jies.门派 = "天宫"
        jies.部位 = "腰带"
    elseif 数据.符石组合=="逆鳞符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能逆鳞等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能逆鳞等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能逆鳞等级6级"
        end
        jies.门派 = "龙宫"
        jies.部位 = "腰带"
    elseif 数据.符石组合=="明性修身符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能明性修身等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能明性修身等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能明性修身等级6级"
        end
        jies.门派 = "五庄观"
        jies.部位 = "腰带"
    elseif 数据.符石组合=="五行扭转符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能五行扭转等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能五行扭转等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能五行扭转等级6级"
        end
        jies.门派 = "普陀山"
        jies.部位 = "腰带"
    elseif 数据.符石组合=="拘魂诀符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能拘魂诀等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能拘魂诀等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能拘魂诀等级6级"
        end
        jies.门派 = "阴曹地府"
        jies.部位 = "腰带"
    elseif 数据.符石组合=="回身击符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能回身击等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能回身击等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能回身击等级6级"
        end
        jies.门派 = "魔王寨"
        jies.部位 = "腰带"
    elseif 数据.符石组合=="魔兽反嗜符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能魔兽反噬等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能魔兽反噬等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能魔兽反噬等级6级"
        end
        jies.门派 = "狮驼岭"
        jies.部位 = "腰带"
    elseif 数据.符石组合=="盘丝大法符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能盘丝大法等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能盘丝大法等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能盘丝大法等级6级"
        end
        jies.门派 = "盘丝洞"
        jies.部位 = "腰带"
    elseif 数据.符石组合=="化神以灵符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能化神以灵等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能化神以灵等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能化神以灵等级6级"
        end
        jies.门派 = "女魃墓"
        jies.部位 = "武器"
    elseif 数据.符石组合=="十方无敌符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能十方无敌等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能十方无敌等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能十方无敌等级6级"
        end
        jies.门派 = "大唐官府"
        jies.部位 = "铠甲/女衣"
    elseif 数据.符石组合=="符之术符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能符之术等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能符之术等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能符之术等级6级"
        end
        jies.门派 = "方寸山"
        jies.部位 = "铠甲/女衣"
    elseif 数据.符石组合=="歧黄之术符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能歧黄之术等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能歧黄之术等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能歧黄之术等级6级"
        end
        jies.门派 = "化生寺"
        jies.部位 = "铠甲/女衣"
    elseif 数据.符石组合=="闭月羞花符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能闭月羞花等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能闭月羞花等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能闭月羞花等级6级"
        end
        jies.门派 = "女儿村"
        jies.部位 = "铠甲/女衣"
    elseif 数据.符石组合=="乾坤塔符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能乾坤塔等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能乾坤塔等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能乾坤塔等级6级"
        end
        jies.门派 = "天宫"
        jies.部位 = "铠甲/女衣"
    elseif 数据.符石组合=="呼风唤雨符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能呼风唤雨等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能呼风唤雨等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能呼风唤雨等级6级"
        end
        jies.门派 = "龙宫"
        jies.部位 = "铠甲/女衣"
    elseif 数据.符石组合=="乾坤袖符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能乾坤袖等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能乾坤袖等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能乾坤袖等级6级"
        end
        jies.门派 = "五庄观"
        jies.部位 = "铠甲/女衣"
    elseif 数据.符石组合=="金刚经符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能金刚经等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能金刚经等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能金刚经等级6级"
        end
        jies.门派 = "普陀山"
        jies.部位 = "铠甲/女衣"
    elseif 数据.符石组合=="幽冥术符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能幽冥术等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能幽冥术等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能幽冥术等级6级"
        end
        jies.门派 = "阴曹地府"
        jies.部位 = "铠甲/女衣"
    elseif 数据.符石组合=="火牛阵符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能火牛阵等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能火牛阵等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能火牛阵等级6级"
        end
        jies.门派 = "魔王寨"
        jies.部位 = "铠甲/女衣"
    elseif 数据.符石组合=="生死搏符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能生死搏等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能生死搏等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能生死搏等级6级"
        end
        jies.门派 = "狮驼岭"
        jies.部位 = "铠甲/女衣"
    elseif 数据.符石组合=="催情大法符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能催情大法等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能催情大法等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能催情大法等级6级"
        end
        jies.门派 = "盘丝洞"
        jies.部位 = "铠甲/女衣"
    elseif 数据.符石组合=="神兵鉴赏符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能神兵鉴赏等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能神兵鉴赏等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能神兵鉴赏等级6级"
        end
        jies.门派 = "大唐官府"
        jies.部位 = "武器"
    elseif 数据.符石组合=="霹雳咒符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能霹雳咒等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能霹雳咒等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能霹雳咒等级6级"
        end
        jies.门派 = "方寸山"
        jies.部位 = "武器"
    elseif 数据.符石组合=="诵经符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能诵经等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能诵经等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能诵经等级6级"
        end
        jies.门派 = "化生寺"
        jies.部位 = "武器"
    elseif 数据.符石组合=="沉鱼落雁符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能沉鱼落雁等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能沉鱼落雁等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能沉鱼落雁等级6级"
        end
        jies.门派 = "女儿村"
        jies.部位 = "武器"
    elseif 数据.符石组合=="宁气诀符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能宁气诀等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能宁气诀等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能宁气诀等级6级"
        end
        jies.门派 = "天宫"
        jies.部位 = "武器"
    elseif 数据.符石组合=="破浪诀符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能破浪诀等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能破浪诀等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能破浪诀等级6级"
        end
        jies.门派 = "龙宫"
        jies.部位 = "武器"
    elseif 数据.符石组合=="潇湘仙雨符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能潇湘仙雨等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能潇湘仙雨等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能潇湘仙雨等级6级"
        end
        jies.门派 = "五庄观"
        jies.部位 = "武器"
    elseif 数据.符石组合=="五行学说符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能五行学说等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能五行学说等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能五行学说等级6级"
        end
        jies.门派 = "普陀山"
        jies.部位 = "武器"
    elseif 数据.符石组合=="尸腐恶符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能尸腐恶等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能尸腐恶等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能尸腐恶等级6级"
        end
        jies.门派 = "阴曹地府"
        jies.部位 = "武器"
    elseif 数据.符石组合=="牛虱阵符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能牛虱阵等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能牛虱阵等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能牛虱阵等级6级"
        end
        jies.门派 = "魔王寨"
        jies.部位 = "武器"
    elseif 数据.符石组合=="阴阳二气诀符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能阴阳二气诀等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能阴阳二气诀等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能阴阳二气诀等级6级"
        end
        jies.门派 = "狮驼岭"
        jies.部位 = "武器"
    elseif 数据.符石组合=="姊妹相随符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能姊妹相随等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能姊妹相随等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能姊妹相随等级6级"
        end
        jies.门派 = "盘丝洞"
        jies.部位 = "武器"
    elseif 数据.符石组合=="无双一击符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能无双一击等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能无双一击等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能无双一击等级6级"
        end
        jies.门派 = "大唐官府"
        jies.部位 = "武器"
    elseif 数据.符石组合=="磬龙灭法符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能磬龙灭法等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能磬龙灭法等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能磬龙灭法等级6级"
        end
        jies.门派 = "方寸山"
        jies.部位 = "武器"
    elseif 数据.符石组合=="金刚伏魔符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能金刚伏魔等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能金刚伏魔等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能金刚伏魔等级6级"
        end
        jies.门派 = "化生寺"
        jies.部位 = "武器"
    elseif 数据.符石组合=="玉质冰肌符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能玉质冰肌等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能玉质冰肌等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能玉质冰肌等级6级"
        end
        jies.门派 = "女儿村"
        jies.部位 = "武器"
    elseif 数据.符石组合=="混天术符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能混天术等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能混天术等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能混天术等级6级"
        end
        jies.门派 = "天宫"
        jies.部位 = "武器"
    elseif 数据.符石组合=="龙附符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能龙附等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能龙附等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能龙附等级6级"
        end
        jies.门派 = "龙宫"
        jies.部位 = "武器"
    elseif 数据.符石组合=="修仙术符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能修仙术等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能修仙术等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能修仙术等级6级"
        end
        jies.门派 = "五庄观"
        jies.部位 = "武器"
    elseif 数据.符石组合=="护法金刚符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能护法金刚等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能护法金刚等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能护法金刚等级6级"
        end
        jies.门派 = "普陀山"
        jies.部位 = "武器"
    elseif 数据.符石组合=="六道轮回符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能六道轮回等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能六道轮回等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能六道轮回等级6级"
        end
        jies.门派 = "阴曹地府"
        jies.部位 = "武器"
    elseif 数据.符石组合=="震天诀符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能震天诀等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能震天诀等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能震天诀等级6级"
        end
        jies.门派 = "魔王寨"
        jies.部位 = "武器"
    elseif 数据.符石组合=="狂兽诀符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能狂兽诀等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能狂兽诀等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能狂兽诀等级6级"
        end
        jies.门派 = "狮驼岭"
        jies.部位 = "武器"
    elseif 数据.符石组合=="秋波暗送符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能秋波暗送等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能秋波暗送等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能秋波暗送等级6级"
        end
        jies.门派 = "盘丝洞"
        jies.部位 = "武器"
    elseif 数据.符石组合=="紫薇之术符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能紫薇之术等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能紫薇之术等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能紫薇之术等级6级"
        end
        jies.门派 = "大唐官府"
        jies.部位 = "项链"
    elseif 数据.符石组合=="神道无念符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能神道无念等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能神道无念等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能神道无念等级6级"
        end
        jies.门派 = "方寸山"
        jies.部位 = "项链"
    elseif 数据.符石组合=="大慈大悲符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能大慈大悲等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能大慈大悲等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能大慈大悲等级6级"
        end
        jies.门派 = "化生寺"
        jies.部位 = "项链"
    elseif 数据.符石组合=="香飘兰麝符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能香飘兰麝等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能香飘兰麝等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能香飘兰麝等级6级"
        end
        jies.门派 = "女儿村"
        jies.部位 = "项链"
    elseif 数据.符石组合=="清明自在符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能清明自在等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能清明自在等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能清明自在等级6级"
        end
        jies.门派 = "天宫"
        jies.部位 = "项链"
    elseif 数据.符石组合=="龙腾符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能龙腾等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能龙腾等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能龙腾等级6级"
        end
        jies.门派 = "龙宫"
        jies.部位 = "项链"
    elseif 数据.符石组合=="混元道果符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能混元道果等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能混元道果等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能混元道果等级6级"
        end
        jies.门派 = "五庄观"
        jies.部位 = "项链"
    elseif 数据.符石组合=="观音咒符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能观音咒等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能观音咒等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能观音咒等级6级"
        end
        jies.门派 = "普陀山"
        jies.部位 = "项链"
    elseif 数据.符石组合=="九幽阴魂符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能九幽阴魂等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能九幽阴魂等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能九幽阴魂等级6级"
        end
        jies.门派 = "阴曹地府"
        jies.部位 = "项链"
    elseif 数据.符石组合=="火云术符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能火云术等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能火云术等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能火云术等级6级"
        end
        jies.门派 = "魔王寨"
        jies.部位 = "项链"
    elseif 数据.符石组合=="训兽诀符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能训兽诀等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能训兽诀等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能训兽诀等级6级"
        end
        jies.门派 = "狮驼岭"
        jies.部位 = "项链"
    elseif 数据.符石组合=="天外魔音符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能天外魔音等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能天外魔音等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能天外魔音等级6级"
        end
        jies.门派 = "盘丝洞"
        jies.部位 = "项链"
    elseif 数据.符石组合=="疾风步符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能疾风步等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能疾风步等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能疾风步等级6级"
        end
        jies.门派 = "大唐官府"
        jies.部位 = "靴"
    elseif 数据.符石组合=="斜月步符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能斜月步等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能斜月步等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能斜月步等级6级"
        end
        jies.门派 = "方寸山"
        jies.部位 = "靴"
    elseif 数据.符石组合=="渡世步符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能渡世步等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能渡世步等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能渡世步等级6级"
        end
        jies.门派 = "化生寺"
        jies.部位 = "靴"
    elseif 数据.符石组合=="清歌妙舞符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能清歌妙舞等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能清歌妙舞等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能清歌妙舞等级6级"
        end
        jies.门派 = "女儿村"
        jies.部位 = "靴"
    elseif 数据.符石组合=="云霄步符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能云霄步等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能云霄步等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能云霄步等级6级"
        end
        jies.门派 = "天宫"
        jies.部位 = "靴"
    elseif 数据.符石组合=="游龙术符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能游龙术等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能游龙术等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能游龙术等级6级"
        end
        jies.门派 = "龙宫"
        jies.部位 = "靴"
    elseif 数据.符石组合=="七星遁符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能七星遁等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能七星遁等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能七星遁等级6级"
        end
        jies.门派 = "五庄观"
        jies.部位 = "靴"
    elseif 数据.符石组合=="莲花宝座符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能莲花宝座等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能莲花宝座等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能莲花宝座等级6级"
        end
        jies.门派 = "普陀山"
        jies.部位 = "靴"
    elseif 数据.符石组合=="无常步符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能无常步等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能无常步等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能无常步等级6级"
        end
        jies.门派 = "阴曹地府"
        jies.部位 = "靴"
    elseif 数据.符石组合=="裂石步符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能裂石步等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能裂石步等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能裂石步等级6级"
        end
        jies.门派 = "魔王寨"
        jies.部位 = "靴"
    elseif 数据.符石组合=="大鹏展翅符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能大鹏展翅等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能大鹏展翅等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能大鹏展翅等级6级"
        end
        jies.门派 = "狮驼岭"
        jies.部位 = "靴"
    elseif 数据.符石组合=="移形换影符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能移形换影等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能移形换影等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能移形换影等级6级"
        end
        jies.门派 = "盘丝洞"
        jies.部位 = "靴"
    --凌波城
    elseif 数据.符石组合=="天地无极符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能天地无极等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能天地无极等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能天地无极等级6级"
        end
        jies.门派 = "凌波城"
        jies.部位 = "武器"
    elseif 数据.符石组合=="啸傲符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能啸傲等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能啸傲等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能啸傲等级6级"
        end
        jies.门派 = "凌波城"
        jies.部位 = "武器"
    elseif 数据.符石组合=="法天象地符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能法天象地等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能法天象地等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能法天象地等级6级"
        end
        jies.门派 = "凌波城"
        jies.部位 = "靴"
    elseif 数据.符石组合=="气吞山河符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能气吞山河等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能气吞山河等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能气吞山河等级6级"
        end
        jies.门派 = "凌波城"
        jies.部位 = "铠甲/女衣"
    elseif 数据.符石组合=="武神显圣符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能武神显圣等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能武神显圣等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能武神显圣等级6级"
        end
        jies.门派 = "凌波城"
        jies.部位 = "腰带"
    elseif 数据.符石组合=="诛魔符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能诛魔等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能诛魔等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能诛魔等级6级"
        end
        jies.门派 = "凌波城"
        jies.部位 = "头盔/发钗"
    elseif 数据.符石组合=="九转玄功符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能九转玄功等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能九转玄功等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能九转玄功等级6级"
        end
        jies.门派 = "凌波城"
        jies.部位 = "项链"
    --神木林
    elseif 数据.符石组合=="天人庇护符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能天人庇护等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能天人庇护等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能天人庇护等级6级"
        end
        jies.门派 = "神木林"
        jies.部位 = "武器"
    elseif 数据.符石组合=="神木恩泽符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能神木恩泽等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能神木恩泽等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能神木恩泽等级6级"
        end
        jies.门派 = "神木林"
        jies.部位 = "武器"
    elseif 数据.符石组合=="驭灵咒符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能驭灵咒等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能驭灵咒等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能驭灵咒等级6级"
        end
        jies.门派 = "神木林"
        jies.部位 = "靴"
    elseif 数据.符石组合=="瞬息万变符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能瞬息万变等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能瞬息万变等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能瞬息万变等级6级"
        end
        jies.门派 = "神木林"
        jies.部位 = "铠甲/女衣"
    elseif 数据.符石组合=="万物轮转符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能万物轮转等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能万物轮转等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能万物轮转等级6级"
        end
        jies.门派 = "神木林"
        jies.部位 = "腰带"
    elseif 数据.符石组合=="巫咒符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能巫咒等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能巫咒等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能巫咒等级6级"
        end
        jies.门派 = "神木林"
        jies.部位 = "头盔/发钗"
    elseif 数据.符石组合=="万灵诸念符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能万灵诸念等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能万灵诸念等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能万灵诸念等级6级"
        end
        jies.门派 = "神木林"
        jies.部位 = "项链"
    --无底洞
    elseif 数据.符石组合=="秘影迷踪符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能秘影迷踪等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能秘影迷踪等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能秘影迷踪等级6级"
        end
        jies.门派 = "无底洞"
        jies.部位 = "武器"
    elseif 数据.符石组合=="混元神功符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能混元神功等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能混元神功等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能混元神功等级6级"
        end
        jies.门派 = "无底洞"
        jies.部位 = "武器"
    elseif 数据.符石组合=="鬼蛊灵蕴符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能鬼蛊灵蕴等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能鬼蛊灵蕴等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能鬼蛊灵蕴等级6级"
        end
        jies.门派 = "无底洞"
        jies.部位 = "靴"
    elseif 数据.符石组合=="阴风绝章符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能阴风绝章等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能阴风绝章等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能阴风绝章等级6级"
        end
        jies.门派 = "无底洞"
        jies.部位 = "铠甲/女衣"
    elseif 数据.符石组合=="地冥妙法符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能地冥妙法等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能地冥妙法等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能地冥妙法等级6级"
        end
        jies.门派 = "无底洞"
        jies.部位 = "腰带"
    elseif 数据.符石组合=="燃灯灵宝符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能燃灯灵宝等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能燃灯灵宝等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能燃灯灵宝等级6级"
        end
        jies.门派 = "无底洞"
        jies.部位 = "头盔/发钗"
    elseif 数据.符石组合=="枯骨心法符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能枯骨心法等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能枯骨心法等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能枯骨心法等级6级"
        end
        jies.门派 = "无底洞"
        jies.部位 = "项链"
    --花果山符石组合
    elseif 数据.符石组合=="灵猴九窍符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能灵猴九窍等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能灵猴九窍等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能灵猴九窍等级6级"
        end
        jies.门派 = "花果山"
        jies.部位 = "头盔/发钗"
    elseif 数据.符石组合=="金刚之躯符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能金刚之躯等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能金刚之躯等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能金刚之躯等级6级"
        end
        jies.门派 = "花果山"
        jies.部位 = "腰带"
    elseif 数据.符石组合=="七十二变符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能七十二变等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能七十二变等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能七十二变等级6级"
        end
        jies.门派 = "花果山"
        jies.部位 = "铠甲/女衣"
    elseif 数据.符石组合=="神通广大符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能神通广大等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能神通广大等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能神通广大等级6级"
        end
        jies.门派 = "花果山"
        jies.部位 = "武器"
    elseif 数据.符石组合=="如意金箍符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能如意金箍等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能如意金箍等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能如意金箍等级6级"
        end
        jies.门派 = "花果山"
        jies.部位 = "武器"
    elseif 数据.符石组合=="齐天逞胜符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能齐天逞胜等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能齐天逞胜等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能齐天逞胜等级6级"
        end
        jies.门派 = "花果山"
        jies.部位 = "项链"
    elseif 数据.符石组合=="腾云驾霧符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能腾云驾霧等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能腾云驾霧等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能腾云驾霧等级6级"
        end
        jies.门派 = "花果山"
        jies.部位 = "鞋子"
    --女魃墓符石组合
    elseif 数据.符石组合=="天火献誓符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能天火献誓等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能天火献誓等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能天火献誓等级6级"
        end
        jies.门派 = "女魃墓"
        jies.部位 = "头盔/发钗"
    elseif 数据.符石组合=="藻光灵狱符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能藻光灵狱等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能藻光灵狱等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能藻光灵狱等级6级"
        end
        jies.门派 = "女魃墓"
        jies.部位 = "腰带"
    elseif 数据.符石组合=="煌火无明符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能煌火无明等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能煌火无明等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能煌火无明等级6级"
        end
        jies.门派 = "女魃墓"
        jies.部位 = "铠甲/女衣"
    elseif 数据.符石组合=="化神以灵符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能化神以灵等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能化神以灵等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能化神以灵等级6级"
        end
        jies.门派 = "女魃墓"
        jies.部位 = "武器"
    elseif 数据.符石组合=="弹指成烬符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能弹指成烬等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能弹指成烬等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能弹指成烬等级6级"
        end
        jies.门派 = "女魃墓"
        jies.部位 = "武器"
    elseif 数据.符石组合=="天罚之焰符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能天罚之焰等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能天罚之焰等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能天罚之焰等级6级"
        end
        jies.门派 = "女魃墓"
        jies.部位 = "项链"
    elseif 数据.符石组合=="离魂符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能离魂等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能离魂等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能离魂等级6级"
        end
        jies.门派 = "女魃墓"
        jies.部位 = "鞋子"
    --天机城符石组合
    elseif 数据.符石组合=="神工无形符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能神工无形等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能神工无形等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能神工无形等级6级"
        end
        jies.门派 = "天机城"
        jies.部位 = "头盔/发钗"
    elseif 数据.符石组合=="千机奇巧符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能千机奇巧等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能千机奇巧等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能千机奇巧等级6级"
        end
        jies.门派 = "天机城"
        jies.部位 = "腰带"
    elseif 数据.符石组合=="匠心不移符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能匠心不移等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能匠心不移等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能匠心不移等级6级"
        end
        jies.门派 = "天机城"
        jies.部位 = "铠甲/女衣"
    elseif 数据.符石组合=="攻玉以石符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能攻玉以石等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能攻玉以石等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能攻玉以石等级6级"
        end
        jies.门派 = "天机城"
        jies.部位 = "武器"
    elseif 数据.符石组合=="擎天之械符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能擎天之械等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能擎天之械等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能擎天之械等级6级"
        end
        jies.门派 = "天机城"
        jies.部位 = "武器"
    elseif 数据.符石组合=="探奥索隐符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能探奥索隐等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能探奥索隐等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能探奥索隐等级6级"
        end
        jies.门派 = "天机城"
        jies.部位 = "项链"
    elseif 数据.符石组合=="运思如电符石" then
        if 数据.等级 == 1 then
            jies.介绍="增加门派技能运思如电等级2级"
        elseif 数据.等级 == 2 then
            jies.介绍="增加门派技能运思如电等级4级"
        elseif 数据.等级 == 3 then
          jies.介绍="增加门派技能运思如电等级6级"
        end
        jies.门派 = "天机城"
        jies.部位 = "鞋子"
   	end
  return jies
end


function 系统类_提示框:特性(x,y,ad,ac,aa)
 local xa ={}
	local x = x-80
	local y = y+15
	self.介绍文本:清空()

 if ad == "力破" and aa == 1 then
        xa ={"#G/80#Y/","#R/10#Y/"}
	elseif ad == "力破" and aa == 2 then
         xa ={"#G/120#Y/","#R/10#Y/"}
	elseif ad == "力破" and aa == 3 then
		xa ={"#G/160#Y/","#R/5%#Y/"}
	elseif ad == "力破" and aa == 4 then
		xa ={"#G/200#Y/","#R/5%#Y/"}
	elseif ad == "力破" and aa == 5 then
		xa ={"#G/240#Y/","#R/5%#Y/"}
    elseif ad == "识物" and aa == 1 then
        xa ={"#G/5%#Y/","#R/8#Y/"}
	elseif ad == "识物" and aa == 2 then
		 xa ={"#G/8%#Y/","#R/8#Y/"}
	elseif ad == "识物" and aa == 3 then
		 xa ={"#G/10%#Y/","#R/4#Y/"}
	elseif ad == "识物" and aa == 4 then
		 xa ={"#G/13%#Y/","#R/4#Y/"}
    elseif ad == "识物" and aa == 5 then
    	 xa ={"#G/16%#Y/","#R/4#Y/"}
	elseif ad == "灵刃" and aa == 1 then
		 xa ={"#G/33%#Y/","#R/10%#Y/"}
	elseif ad == "灵刃" and aa == 2 then
		 xa ={"#G/50%#Y/","#R/10%#Y/"}
	elseif ad == "灵刃" and aa == 3 then
		 xa ={"#G/66%#Y/","#R/5%#Y/"}
    elseif ad == "灵刃" and aa == 4 then
    	 xa ={"#G/83%#Y/","#R/5%#Y/"}
	elseif ad == "灵刃" and aa == 5 then
		 xa ={"#G/100%#Y/","#R/5%#Y/"}
	elseif ad == "瞬击" and aa == 1 then
		 xa ={"#G/33%#Y/","#R/10%#Y/"}
	elseif ad == "瞬击" and aa == 2 then
		 xa ={"#G/50%#Y/","#R/10%#Y/"}
    elseif ad == "瞬击" and aa == 3 then
    	 xa ={"#G/66%#Y/","#R/5%#Y/"}
	elseif ad == "瞬击" and aa == 4 then
		 xa ={"#G/83%#Y/","#R/5%#Y/"}
	elseif ad == "瞬击" and aa == 5 then
		 xa ={"#G/100%#Y/","#R/5%#Y/"}
	elseif ad == "复仇" and aa == 1 then
		 xa ={"#G/33%#Y/","#R/10%#Y/"}
	elseif ad == "复仇" and aa == 2 then
		 xa ={"#G/50%#Y/","#R/10%#Y/"}
    elseif ad == "复仇" and aa == 3 then
    	 xa ={"#G/66%#Y/","#R/5%#Y/"}
	elseif ad == "复仇" and aa == 4 then
		 xa ={"#G/83%#Y/","#R/5%#Y/"}
	elseif ad == "复仇" and aa == 5 then
		 xa ={"#G/100%#Y/","#R/5%#Y/"}
	elseif ad == "弑神" and aa == 1 then
		 xa ={"#G/60#Y/","#R/40%#Y/"}
	elseif ad == "弑神" and aa == 2 then
		 xa ={"#G/90#Y/","#R/40%#Y/"}
    elseif ad == "弑神" and aa == 3 then
    	 xa ={"#G/120#Y/","#R/20%#Y/"}
	elseif ad == "弑神" and aa == 4 then
		 xa ={"#G/150#Y/","#R/20%#Y/"}
	elseif ad == "弑神" and aa == 5 then
		 xa ={"#G/180#Y/","#R/20%#Y/"}
	elseif ad == "吮魔" and aa == 1 then
		 xa ={"#G/1%#Y/","#R/1%#Y/"}
	elseif ad == "吮魔" and aa == 2 then
		 xa ={"#G/2%#Y/","#R/1%#Y/"}
    elseif ad == "吮魔" and aa == 3 then
    	 xa ={"#G/3%#Y/","#R/5%#Y/"}
	elseif ad == "吮魔" and aa == 4 then
		 xa ={"#G/4%#Y/","#R/5%#Y/"}
	elseif ad == "吮魔" and aa == 5 then
		 xa ={"#G/5%#Y/","#R/5%#Y/"}
	elseif ad == "自恋" and aa == 1 then
        xa ={"#G/33%#Y/","#R/8#Y/"}
    elseif ad == "自恋" and aa == 2 then
    	 xa ={"#G/50%#Y/","#R/8#Y/"}
	elseif ad == "自恋" and aa == 3 then
		 xa ={"#G/66%#Y/","#R/4#Y/"}
	elseif ad == "自恋" and aa == 4 then
		 xa ={"#G/83%#Y/","#R/4#Y/"}
	elseif ad == "自恋" and aa == 5 then
		 xa ={"#G/100%#Y/","#R/4#Y/"}
    elseif ad == "乖巧" and aa == 1 then
        xa ={"#G/6%#Y/","#R/8#Y/"}
	elseif ad == "乖巧" and aa == 2 then
		xa ={"#G/10%#Y/","#R/8#Y/"}
	elseif ad == "乖巧" and aa == 3 then
		xa ={"#G/13%#Y/","#R/4#Y/"}
	elseif ad == "乖巧" and aa == 4 then
		xa ={"#G/16%#Y/","#R/4#Y/"}
    elseif ad == "乖巧" and aa == 5 then
    	xa ={"#G/20%#Y/","#R/4#Y/"}
	elseif ad == "灵动" and aa == 1 then
	    xa ={"#G/5%#Y/","#R/8#Y/"}
	elseif ad == "灵动" and aa == 2 then
		xa ={"#G/10%#Y/","#R/8#Y/"}
	elseif ad == "灵动" and aa == 3 then
		xa ={"#G/15%#Y/","#R/4#Y/"}
    elseif ad == "灵动" and aa == 4 then
    	xa ={"#G/20%#Y/","#R/4#Y/"}
	elseif ad == "灵动" and aa == 5 then
		xa ={"#G/25%#Y/","#R/4#Y/"}
	elseif ad == "逆境" and aa == 1 then
       xa ={"#G/33%#Y/","#R/30%#Y/"}
	elseif ad == "逆境" and aa == 2 then
		xa ={"#G/50%#Y/","#R/30%#Y/"}
    elseif ad == "逆境" and aa == 3 then
    	xa ={"#G/66%#Y/","#R/15%#Y/"}
	elseif ad == "逆境" and aa == 4 then
		xa ={"#G/83%#Y/","#R/15%#Y/"}
	elseif ad == "逆境" and aa == 5 then
		xa ={"#G/100%#Y/","#R/10%#Y/"}
	elseif ad == "灵断" and aa == 1 then
        xa ={"#G/33%#Y/","#R/5%#Y/"}
    elseif ad == "灵断" and aa == 2 then
        xa ={"#G/50%#Y/","#R/10%#Y/"}
	elseif ad == "灵断" and aa == 3 then
		xa ={"#G/66%#Y/","#R/5%#Y/"}
	elseif ad == "灵断" and aa == 4 then
		xa ={"#G/83%#Y/","#R/5%#Y/"}
	elseif ad == "灵断" and aa == 5 then
		xa ={"#G/100%#Y/","#R/5%#Y/"}

    elseif ad == "争锋" and aa == 1 then
        xa ={"#G/4%#Y/","#R/10%#Y/"}
	elseif ad == "争锋" and aa == 2 then
		xa ={"#G/8%#Y/","#R/10%#Y/"}
	elseif ad == "争锋" and aa == 3 then
		xa ={"#G/12%#Y/","#R/10%#Y/"}
	elseif ad == "争锋" and aa == 4 then
		xa ={"#G/16%#Y/","#R/10%#Y/"}
    elseif ad == "争锋" and aa == 5 then
    	xa ={"#G/20%#Y/","#R/10%#Y/"}

	elseif ad == "暗劲" and aa == 1 then
       xa ={"#G/6%#Y/","#R/40%#Y/"}
	elseif ad == "暗劲" and aa == 2 then
		xa ={"#G/10%#Y/","#R/20%#Y/"}
	elseif ad == "暗劲" and aa == 3 then
		xa ={"#G/13%#Y/","#R/20%#Y/"}
    elseif ad == "暗劲" and aa == 4 then
    	xa ={"#G/16%#Y/","#R/20%#Y/"}
	elseif ad == "暗劲" and aa == 5 then
		xa ={"#G/20%#Y/","#R/20%#Y/"}
	elseif ad == "顺势" and aa == 1 then
       xa ={"#G/60#Y/","#R/90#Y/"}
	elseif ad == "顺势" and aa == 2 then
		xa ={"#G/90#Y/","#R/90#Y/"}
	elseif ad == "顺势" and aa == 3 then
		xa ={"#G/120#Y/","#R/90#Y/"}
    elseif ad == "顺势" and aa == 4 then
    	xa ={"#G/150#Y/","#R/90#Y/"}
	elseif ad == "顺势" and aa == 5 then
		xa ={"#G/180#Y/","#R/90#Y/"}
	elseif ad == "阳护" and aa == 1 then
       xa ={"#G/33%#Y/","#R/30%#Y/"}
	elseif ad == "阳护" and aa == 2 then
		xa ={"#G/50%#Y/","#R/15%#Y/"}
	elseif ad == "阳护" and aa == 3 then
		xa ={"#G/66%#Y/","#R/15%#Y/"}
    elseif ad == "阳护" and aa == 4 then
    	xa ={"#G/83%#Y/","#R/15%#Y/"}
	elseif ad == "阳护" and aa == 5 then
		xa ={"#G/100%#Y/","#R/15%#Y/"}
	elseif ad == "预知" and aa == 1 then
       xa ={"#G/10%#Y/","#R/8#Y/"}
	elseif ad == "预知" and aa == 2 then
		xa ={"#G/16%#Y/","#R/4#Y/"}
	elseif ad == "预知" and aa == 3 then
		xa ={"#G/21%#Y/","#R/4#Y/"}
    elseif ad == "预知" and aa == 4 then
    	xa ={"#G/26%#Y/","#R/4#Y/"}
	elseif ad == "预知" and aa == 5 then
		xa ={"#G/32%#Y/","#R/4#Y/"}
	elseif ad == "识药" and aa == 1 then
       xa ={"#G/1.2%#Y/","#R/20%#Y/"}
	elseif ad == "识药" and aa == 2 then
		xa ={"#G/2.4%#Y/","#R/10%#Y/"}
	elseif ad == "识药" and aa == 3 then
		xa ={"#G/3.6%#Y/","#R/10%#Y/"}
    elseif ad == "识药" and aa == 4 then
    	xa ={"#G/4.8%#Y/","#R/10%#Y/"}
	elseif ad == "识药" and aa == 5 then
		xa ={"#G/6.0%#Y/","#R/10%#Y/"}
	elseif ad == "御风" and aa == 1 then
       xa ={"#G/5#Y/","#R/10%#Y/"}
	elseif ad == "御风" and aa == 2 then
		xa ={"#G/10#Y/","#R/10%#Y/"}
	elseif ad == "御风" and aa == 3 then
		xa ={"#G/15#Y/","#R/10%#Y/"}
    elseif ad == "御风" and aa == 4 then
    	xa ={"#G/20#Y/","#R/10%#Y/"}
	elseif ad == "御风" and aa == 5 then
		xa ={"#G/25#Y/","#R/10%#Y/"}
	elseif ad == "瞬法" and aa == 1 then
       xa ={"#G/33%#Y/","#R/10%#Y/"}
	elseif ad == "瞬法" and aa == 2 then
		xa ={"#G/50%#Y/","#R/10%#Y/"}
	elseif ad == "瞬法" and aa == 3 then
		xa ={"#G/66%#Y/","#R/5%#Y/"}
    elseif ad == "瞬法" and aa == 4 then
    	xa ={"#G/83%#Y/","#R/5%#Y/"}
	elseif ad == "瞬法" and aa == 5 then
		xa ={"#G/100%#Y/","#R/5%#Y/"}
	elseif ad == "灵法" and aa == 1 then
       xa ={"#G/5%#Y/","#R/10%#Y/"}
	elseif ad == "灵法" and aa == 2 then
		xa ={"#G/10%#Y/","#R/10%#Y/"}
	elseif ad == "灵法" and aa == 3 then
		xa ={"#G/15%#Y/","#R/10%#Y/"}
    elseif ad == "灵法" and aa == 4 then
    	xa ={"#G/20%#Y/","#R/10%#Y/"}
	elseif ad == "灵法" and aa == 5 then
		xa ={"#G/25%#Y/","#R/10%#Y/"}
	elseif ad == "怒吼" and aa == 1 then
       xa ={"#G/10#Y/","#R/10%#Y/"}
	elseif ad == "怒吼" and aa == 2 then
		xa ={"#G/20#Y/","#R/10%#Y/"}
	elseif ad == "怒吼" and aa == 3 then
		xa ={"#G/30#Y/","#R/10%#Y/"}
    elseif ad == "怒吼" and aa == 4 then
    	xa ={"#G/40#Y/","#R/10%#Y/"}
	elseif ad == "怒吼" and aa == 5 then
		xa ={"#G/50#Y/","#R/10%#Y/"}


	elseif ad == "洞察" 	and aa == 1 then
       xa ={"#G/5%#Y/","#R/8#Y/"}
	elseif ad == "洞察" and aa == 2 then
		xa ={"#G/10%#Y/","#R/7#Y/"}
	elseif ad == "洞察" and aa == 3 then
		xa ={"#G/15%#Y/","#R/6#Y/"}
    elseif ad == "洞察" and aa == 4 then
    	xa ={"#G/20%#Y/","#R/5#Y/"}
	elseif ad == "洞察" and aa == 5 then
		xa ={"#G/25%#Y/","#R/4#Y/"}
		------------------------------------------
	elseif ad == "抗物" and aa == 1 then
       xa ={"#G/6%#Y/","#R/3%#Y/"}
	elseif ad == "抗物" and aa == 2 then
		xa ={"#G/12%#Y/","#R/6%#Y/"}
	elseif ad == "抗物" and aa == 3 then
		xa ={"#G/18%#Y/","#R/9%#Y/"}
    elseif ad == "抗物" and aa == 4 then
    	xa ={"#G/24%#Y/","#R/12%#Y/"}
	elseif ad == "抗物" and aa == 5 then
		xa ={"#G/30%#Y/","#R/15%#Y/"}
		-------------------------------------------
	elseif ad == "抗法" and aa == 1 then
        xa ={"#G/6%#Y/","#R/3%#Y/"}
	elseif ad == "抗法" and aa == 2 then
		xa ={"#G/12%#Y/","#R/6%#Y/"}
	elseif ad == "抗法" and aa == 3 then
		xa ={"#G/18%#Y/","#R/9%#Y/"}
    elseif ad == "抗法" and aa == 4 then
    	xa ={"#G/24%#Y/","#R/12%#Y/"}
	elseif ad == "抗法" and aa == 5 then
		xa ={"#G/30%#Y/","#R/15%#Y/"}

--------------------------------------

	elseif ad == "护佑" and aa == 1 then
       xa ={"#G/10#Y/","#R/10%#Y/"}
	elseif ad == "护佑" and aa == 2 then
		xa ={"#G/20#Y/","#R/10%#Y/"}
	elseif ad == "护佑" and aa == 3 then
		xa ={"#G/30#Y/","#R/10%#Y/"}
    elseif ad == "护佑" and aa == 4 then
    	xa ={"#G/40#Y/","#R/10%#Y/"}
	elseif ad == "护佑" and aa == 5 then
		xa ={"#G/50#Y/","#R/10%#Y/"}
	elseif ad == "巧劲" and aa == 1 then
       xa ={"#G/2#Y/","#R/23%#Y/"}
	elseif ad == "巧劲" and aa == 2 then
		xa ={"#G/5#Y/","#R/20%#Y/"}
	elseif ad == "巧劲" and aa == 3 then
		xa ={"#G/8#Y/","#R/17%#Y/"}
    elseif ad == "巧劲" and aa == 4 then
    	xa ={"#G/12#Y/","#R/15%#Y/"}
	elseif ad == "巧劲" and aa == 5 then
		xa ={"#G/25#Y/","#R/12%#Y/"}
	end





	local a
	if ad == "灵刃" then
	  a ="#Y/第二回合以后进场时，"..xa[1].."概率对自身造成#R/30%#Y/气血上限的伤害并且物理伤害结果提高#R/50%#Y/，持续4回合，防御力，法术防御力降低"..xa[2].."(带有鬼混和神佑类技能，伤害结果只提高10%)"
	elseif ad == "预知" then
	　a = "#Y/感受到危险时有"..xa[1].."概率喊话,每场战斗最多3次,全属性降低"..xa[2]
	elseif ad == "灵动" then
		a= "#Y/行动时有"..xa[1].."概率与队友进行交流，每场战斗最多3次，全属性降低"..xa[2]
	elseif ad == "瞬击" then
		a= "#Y/第二回合以后进场时，"..xa[1].."概率对气血百分比最低的单位发动一次攻击，防御降低"..xa[2]
	elseif ad == "抗法" then
		a="#Y/在场时，我方所有单位法术防御增加"..xa[1].."，自身受到物理伤害增加"..xa[2]
	elseif ad == "阳护" then
	    a="#Y/第二回合以后进场时，"..xa[1].."减少所有我方单位身上“死亡召唤”状态2回合，防御力下降"..xa[2]
	   elseif ad == "识物" then
	   a="#Y/召唤兽套装附带的技能为法术技能时，触发概率提高"..xa[1].."全属性降低"..xa[2]
	elseif ad == "洞察" then
	a="#Y/PVP战斗中行动时有"..xa[1].."概率发现什么，全属性降低"..xa[2]
	elseif ad == "弑神" then
	a="#Y/对已经神佑过的召唤兽法术伤害增加"..xa[1].."，普通攻击命中率下降"..xa[2]
	elseif ad == "御风" then
		a="#Y/进场时提高主人的速度"..xa[1].."，倒地或者死亡后无效，持续3回合，受到所有伤害增加"..xa[2]
	elseif ad == "顺势" then
		a="#Y/对气血百分低于#G/70%#Y/的单位法术伤害增加"..xa[1].."，对其余单位法术伤害力降低"..xa[2]
	elseif ad == "复仇" then
		a="#Y/主人被击倒时，有"..xa[1].."概率向敌方单位发动一次攻击，最多生效3次。减少所有防御力"..xa[2]
	elseif ad == "自恋" then
		a="#Y/普通物理攻击击杀任意单位时有"..xa[1].."概率进行炫耀，每场战斗最多1次，全属性降低"..xa[2]
	elseif ad == "怒吼" then
		a="#Y/第二回合以后进场时，"..xa[1].."%概率我方伤害最高的单位提高20%伤害，持续2回合，法术伤害力降低"..xa[2].."自身防御降低10%持续到战斗结束。"
	elseif ad == "暗劲" then
		　a="#Y/属性法术被吸收时，有"..xa[1].."概率使恢复量不超过1,普通物理攻击命中率下降"..xa[2]
	elseif ad == "逆境" then
		a="#Y/进场时，若已方四个以上单位处于被封印状态，则"..xa[1].."解除我方所有单位异常状态，防御力下降"..xa[2]
	elseif ad == "瞬法" then
		a="#Y/第2回合以后进场时，"..xa[1].."概率对血量百分比最低的单位使用随机法术，气血上限降低"..xa[2]
	elseif ad == "乖巧" then
		a="#Y/使用超级巫医时，耗费的银两降低"..xa[1].."，全属性降低"..xa[2]
	elseif ad == "抗物" then
		a="#Y/在场时，我方所有单位物理防御增加"..xa[1].."，自身受到法术伤害增加"..xa[2]
	elseif ad == "护佑" then
		a="#Y/第2回合进场，"..xa[1].."%概率使我方气血百分比最低的单位受到的伤害降低50%持续2回合，法术伤害力降低#R/"..xa[2]
	elseif ad == "识药" then
		a="#Y/药物效果提高"..xa[1].."受到的所有伤害增加"..xa[2]
	elseif ad == "吮魔" then
		a="#Y/普通物理攻击时吸取"..xa[1].."的魔法，对当前魔法高于#R/50%#Y/的单位伤害结果少"..xa[2]
	elseif ad == "灵断" then
		a="#Y/第二回合以后进场是，"..xa[1].."的几率队自身造成#R/30%#Y/气血上限的伤害并且无视地方神佑鬼魂类技能，持续#R/4#Y/回合，气血上限降低#G/5%#Y/(带有鬼魂类或者神佑技能时，进场对自己造成"..xa[2].."气血上限伤害)"
	elseif ad == "争锋" then
		a="#Y/对召唤兽物理伤害结果增加"..xa[1].."对人物伤害结果减少"..xa[2]
	elseif ad == "力破" then
		a="#Y/忽略人物角色#R/"..xa[1].."#Y/防御力".."减少对召唤兽的伤害结果"..xa[2]
	elseif ad == "灵法" then
		a="#Y/第二回合进场后，提高"..xa[1].."自身法术伤害。持续#R/2#Y/回合,减少防御力"..xa[2]
	elseif ad == "巧劲" then
	　　a="#Y/普通攻击增加伤害结果"..xa[1].."受到的所有伤害增加"..xa[2]
 end

	self.介绍文本:添加文本(a)
	local w = self.介绍文本.显示表.宽度
	local h = self.介绍文本.显示表.高度
	if x + w >= 780 then
		x = 780 - w
	end
	if y + h >= 580 then
		y = y - h - 30
	end
	self.寄存内容 = {}
	self.寄存内容[1] = {}
	self.寄存内容[1].内容 =self.介绍文本
	self.寄存内容[1].x = x + 10
	self.寄存内容[1].y = y + 10
	self.寄存内容.提示坐标 = {[1]=x,[2]=y,[3]=w,[4]=h}
	self.寄存内容.开启提示 = true

end

function 系统类_提示框:商城提示(x,y,名称,介绍,动画,备注,神兽)
	local x = x + 30
	local y = y
	local w = 310
	local h = 18
    self.道具文本:清空()
    self.道具文本:添加文本(介绍)
    if 备注~=nil then
     	self.道具文本:添加文本("#Y/"..备注)
    end

    if x + w >= 全局游戏宽度-20 then
		x = 全局游戏宽度 - 20 - w
	end
	h = self.道具文本.显示表.高度+30

	if h < 130 then
		h = 130
	end
	if y + h > 全局游戏高度-20 then
		y = 全局游戏高度-h-20
	end
    self.寄存内容 = {}
	self.寄存内容[1] = {}
	self.寄存内容[1].内容 = 动画
	self.寄存内容[1].x = x+3
	self.寄存内容[1].y = y+5
	--print(神兽)
	if 神兽 then
      	self.寄存内容[1].y =self.寄存内容[1].y +110
      	self.寄存内容[1].x =self.寄存内容[1].x +50
	end
	self.寄存内容[2] = {}
	self.寄存内容[2].内容 = self.道具文本
	self.寄存内容[2].x = x + 128
	self.寄存内容[2].y = y + 35
	self.寄存内容[3] = {}
	self.寄存内容[3].文字 = tp.字体表.道具字体
	self.寄存内容[3].颜色 = -256
	self.寄存内容[3].文本 = 名称
	self.寄存内容[3].坐标 = {[1]=x+128.8,[2] =y+4}
	self.寄存内容.提示坐标 = {[1]=x,[2]=y,[3]=w,[4]=h}
	self.寄存内容.开启提示 = true
 end

function 系统类_提示框:道具行囊(x,y,item,jd,q)
	if item == nil then
		return
	end
	local x = x + 30
	local y = y
	local w = 300
	local h = 18
	local zf = "#W/"
	if jd == nil then
	 	zf = "#Y/"
	end
	self.道具文本:清空()
	self.道具文本:添加文本("")
	if q then
		item.大模型 = tp.资源:载入(item.资源,"网易WDF动画",item.大模型资源)
	end
	if item.加星 ~= nil then
		local 临时文本1 = ""
		local 临时文本2 = ""
		local 临时文本3 = ""
		for i=1,item.加星 do
			if i<=5 then
			    临时文本1 = 临时文本1.."★"
			elseif i<=10 then
				临时文本2 = 临时文本2.."★"
			else
				临时文本3 = 临时文本3.."★"
			end

		end
		if item.加星 < 5 then
			self.道具文本:添加文本("#G"..临时文本1)
		elseif item.加星 < 10 then
		    self.道具文本:添加文本("#G"..临时文本1.."#Y"..临时文本2)
		else
			self.道具文本:添加文本("#G"..临时文本1.."#Y"..临时文本2.."#R"..临时文本3)
		end
	end



	-- if item.装备境界 and  item.装备境界.升级值>0 then
	-- 	if item.装备境界.升级值>0 then
	-- 		if item.装备境界.洗练值>0 then
	-- 			self.道具文本:添加文本("#P/境界值:"..item.装备境界.升级值.."  仙宝值:"..item.装备境界.洗练值)
	-- 		else
	-- 			self.道具文本:添加文本("#P/境界值:"..item.装备境界.升级值)
	-- 		end
	-- 	end
	-- end

	self.道具文本:添加文本(item.介绍)
	local zls = item.总类
	--print(item.总类,item.子类,item.分类)
	if zls == 1 then
		local gs = ""
		local qgx = gxs(item.名称,item.阶品,item.食材)
		if item.分类 ~= 10 and item.分类 ~= 11 then
		  if item.子类==1 and item.分类==4 then
		  	  if item.名称=="包子" then
                 self.道具文本:添加文本("【功效】恢复气血100点")
                elseif   item.名称=="女儿红" then
                 self.道具文本:添加文本("【功效】恢复愤怒值=20")
                 self.道具文本:添加文本("附加昏睡状态")
               elseif item.名称=="臭豆腐" then
                 self.道具文本:添加文本("【功效】")
                 self.道具文本:添加文本("恢复气血=品质*20+200")
                 self.道具文本:添加文本("#Y/品质 "..item.阶品)
                elseif item.名称=="烤鸭" then
                 self.道具文本:添加文本("【功效】")
                 self.道具文本:添加文本("恢复气血=品质*10+100")
                 self.道具文本:添加文本("#Y/品质 "..item.阶品)
                 elseif item.名称=="烤肉" then
                 self.道具文本:添加文本("【功效】")
                 self.道具文本:添加文本("恢复气血=品质*10")
                 self.道具文本:添加文本("#Y/品质 "..item.阶品)
                elseif item.名称=="佛跳墙" then
                 self.道具文本:添加文本("【功效】")
                 self.道具文本:添加文本("恢复魔法=品质*10+100")
                 self.道具文本:添加文本("#Y/品质 "..item.阶品)
                elseif item.名称=="桂花丸" then
                 self.道具文本:添加文本("【功效】")
                 self.道具文本:添加文本("恢复召唤兽寿命=品质*0.5")
                 self.道具文本:添加文本("#Y/品质 "..item.阶品)
                elseif item.名称=="豆斋果" then
                 self.道具文本:添加文本("【功效】")
                 self.道具文本:添加文本("恢复召唤兽寿命=品质*3")
                 self.道具文本:添加文本("但有3%几率出现食物中毒而减少某些资质。")
                 self.道具文本:添加文本("#Y/品质 "..item.阶品)
                elseif item.名称=="长寿面" then
                 self.道具文本:添加文本("【功效】")
                 self.道具文本:添加文本("恢复召唤兽寿命=品质*2+50")
                 self.道具文本:添加文本("但有3%几率出现食物中毒而减少某些资质。")
                 self.道具文本:添加文本("#Y/品质 "..item.阶品)
                elseif item.名称=="翡翠豆腐" then
                 self.道具文本:添加文本("【功效】")
                 self.道具文本:添加文本("恢复气血=品质*15+150")
                 self.道具文本:添加文本("魔法=品质*10+100")
                 self.道具文本:添加文本("#Y/品质 "..item.阶品)
                elseif item.名称=="珍露酒" then
                 self.道具文本:添加文本("【功效】")
                 self.道具文本:添加文本("恢复愤怒值=品质*0.4+10")
                 self.道具文本:添加文本("#Y/品质 "..item.阶品)
               elseif item.名称=="梅花酒" then
                 self.道具文本:添加文本("【功效】")
                 self.道具文本:添加文本("恢复愤怒值=品质*0.6")
                 self.道具文本:添加文本("昏睡2~3回合")
                 self.道具文本:添加文本("#Y/品质 "..item.阶品)
                elseif item.名称=="百味酒" then
                 self.道具文本:添加文本("【功效】")
                 self.道具文本:添加文本("恢复愤怒值=品质*0.7")
                 self.道具文本:添加文本("昏睡2~3回合或附加中毒状态")
                 self.道具文本:添加文本("#Y/品质 "..item.阶品)
                elseif item.名称=="蛇胆酒" then
                 self.道具文本:添加文本("【功效】")
                 self.道具文本:添加文本("恢复愤怒值=品质*1")
                 self.道具文本:添加文本("减少防御=品质*1.5")
                 self.道具文本:添加文本("#Y/品质 "..item.阶品)
                elseif item.名称=="醉生梦死" then
                 self.道具文本:添加文本("【功效】")
                 self.道具文本:添加文本("恢复愤怒值=品质*1")
                 self.道具文本:添加文本("附加疯狂状态3~4回合")
                 self.道具文本:添加文本("#Y/品质 "..item.阶品)
                elseif item.名称=="虎骨酒" then
                 self.道具文本:添加文本("【功效】")
                 self.道具文本:添加文本("恢复愤怒值=20")
                 self.道具文本:添加文本("附加疯狂状态")
                 self.道具文本:添加文本("#Y/品质 "..item.阶品)
		  	  	 end
            else
             --self.道具文本:添加文本("#Y/品质:"..item.阶品)
		  	 end
           if item.名称=="金创药" then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复气血400点")
              self.道具文本:添加文本("#Y/恢复气血400,等级：3")
              --self.道具文本:添加文本("#Y/品质 "..item.阶品)
           elseif item.名称=="金香玉" then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复气血=品质*12+150")
              self.道具文本:添加文本("#Y/品质 "..item.阶品..",恢复气血="..(item.阶品*12+150)..",等级: 3")
              if item.药性 ~= nil then self.道具文本:添加文本("#S/药性："..item.药性) end
            elseif item.名称=="小还丹" then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复气血=品质*8+100")
              self.道具文本:添加文本("#Y/品质 "..item.阶品..",恢复气血="..(item.阶品*8+100)..",等级: 3")
              if item.药性 ~= nil then self.道具文本:添加文本("#S/药性："..item.药性) end
            elseif item.名称=="千年保心丹" then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复气血=品质*4+200")
              self.道具文本:添加文本("#Y/品质 "..item.阶品..",恢复气血="..(item.阶品*4+200)..",等级: 3")
              if item.药性 ~= nil then self.道具文本:添加文本("#S/药性："..item.药性) end
            elseif item.名称=="风水混元丹" then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复魔法=品质*3+50")
              self.道具文本:添加文本("恢复灵力=品质*0.3")
              self.道具文本:添加文本("#Y/品质 "..item.阶品..",恢复魔法="..(item.阶品*3+50)..",等级: 3")
              if item.药性 ~= nil then self.道具文本:添加文本("#S/药性："..item.药性) end
            elseif item.名称=="定神香" then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("解除奇经八脉技能产生的异常状态，恢复魔法=品质*5+50")
              self.道具文本:添加文本("#Y/品质 "..item.阶品..",恢复魔法="..(item.阶品*5+50)..",等级: 3")
              if item.药性 ~= nil then self.道具文本:添加文本("#S/药性："..item.药性) end
             elseif item.名称=="蛇蝎美人" then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复魔法=品质*5+100")
              self.道具文本:添加文本("#Y/品质 "..item.阶品..",恢复魔法="..(item.阶品*5+100)..",等级: 3")
              if item.药性 ~= nil then self.道具文本:添加文本("#S/药性："..item.药性) end
            elseif item.名称=="九转回魂丹" then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("复活、恢复气血=品质*5+100")
              self.道具文本:添加文本("#Y/品质 "..item.阶品..",恢复气血="..(item.阶品*5+100)..",等级: 3")
              if item.药性 ~= nil then self.道具文本:添加文本("#S/药性："..item.药性) end
           elseif item.名称=="佛光舍利子" then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("复活、恢复气血=品质*3")
              self.道具文本:添加文本("#Y/品质 "..item.阶品..",恢复气血="..(item.阶品*3)..",等级: 3")
              if item.药性 ~= nil then self.道具文本:添加文本("#S/药性："..item.药性) end
           elseif item.名称=="五龙丹" then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("解除封类异常状态")
              self.道具文本:添加文本("恢复气血=品质*3")
              self.道具文本:添加文本("#Y/品质 "..item.阶品..",恢复气血="..(item.阶品*3)..",等级: 3")
              if item.药性 ~= nil then self.道具文本:添加文本("#S/药性："..item.药性) end
            elseif item.名称=="十香返生丸" then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("解除酒类异常状态")
              self.道具文本:添加文本("恢复魔法=品质*3+50")
              self.道具文本:添加文本("#Y/品质 "..item.阶品..",恢复魔法="..(item.阶品*3+50)..",等级: 3")
              if item.药性 ~= nil then self.道具文本:添加文本("#S/药性："..item.药性) end
            elseif item.名称=="天不老" or item.名称=="紫石英" then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复气血100点")
              self.道具文本:添加文本("#Y/恢复气血100, 等级:2")
           elseif item.名称=="血色茶花" or item.名称=="鹿茸" then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复气血150点")
              self.道具文本:添加文本("#Y/恢复气血150, 等级:2")
           elseif item.名称=="六道轮回" or item.名称=="熊胆" then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复气血200点")
              self.道具文本:添加文本("#Y/恢复气血200, 等级:2")
            elseif item.名称=="凤凰尾" or item.名称=="硫磺草" then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复气血250点")
              self.道具文本:添加文本("#Y/恢复气血250, 等级:2")
            elseif item.名称=="龙之心屑" or item.名称=="火凤之睛" then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复气血300点")
              self.道具文本:添加文本("#Y/恢复气血300, 等级:2")
            elseif item.名称=="四叶花" then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复气血40点")
              self.道具文本:添加文本("#Y/恢复气血40, 等级:1")
            elseif item.名称=="天青地白"  then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复气血80点")
              self.道具文本:添加文本("#Y/恢复气血80, 等级:1")
           elseif item.名称=="七叶莲"  then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复气血60点")
              self.道具文本:添加文本("#Y/恢复气血60, 等级:1")
            elseif item.名称=="丁香水" or item.名称=="月星子" then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复魔法75点")
              self.道具文本:添加文本("#Y/恢复魔法75, 等级:2")
            elseif item.名称=="仙狐涎" or item.名称=="地狱灵芝" or item.名称=="麝香" or item.名称=="血珊瑚" or item.名称=="餐风饮露" or item.名称=="白露为霜"   then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复魔法100点")
              self.道具文本:添加文本("#Y/恢复魔法100, 等级:2")
            elseif item.名称=="天龙水" or item.名称=="孔雀红"    then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复魔法150点")
              self.道具文本:添加文本("#Y/恢复魔法150, 等级:2")
             elseif item.名称=="紫丹罗" or item.名称=="佛手" or item.名称=="旋复花"   then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复魔法20点")
              self.道具文本:添加文本("#Y/恢复魔法20, 等级:1")
            elseif item.名称=="龙须草" or item.名称=="百色花" or item.名称=="香叶"   then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复魔法30点")
              self.道具文本:添加文本("#Y/恢复魔法30, 等级:1")
            elseif item.名称=="白玉骨头" or item.名称=="鬼切草" or item.名称=="灵脂"   then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复气魔法40点")
              self.道具文本:添加文本("#Y/恢复魔法40, 等级:1")
            elseif item.名称=="曼陀罗花"   then
              self.道具文本:添加文本("【功效】")
              self.道具文本:添加文本("恢复魔法50点")
              self.道具文本:添加文本("#Y/恢复魔法50, 等级:1")
             elseif item.名称=="秘制红罗羹"   then
              self.道具文本:添加文本("【功效】战斗结束后自动恢复人物气血")
              self.道具文本:添加文本("#Y/剩余次数：100")
            elseif item.名称=="秘制绿罗羹"   then
              self.道具文本:添加文本("【功效】战斗结束后自动恢复人物魔法")
              self.道具文本:添加文本("#Y/剩余次数：100")
             elseif item.名称=="超级红罗羹"   then
              self.道具文本:添加文本("【功效】战斗结束后自动恢复人物气血")
              self.道具文本:添加文本("#Y/剩余次数：2000")
            elseif item.名称=="超级绿罗羹"   then
              self.道具文本:添加文本("【功效】战斗结束后自动恢复人物魔法")
              self.道具文本:添加文本("#Y/剩余次数：2000")




		    end
			if qgx == nil and item.子类~=1 and item.子类~=2 and item.分类~=4  then
				if item.分类 == 4 and item.子类 >= 2 then
					if item.气血 ~= 0 and item.气血 ~= nil  then
						gs = gs..zf.."\n"..zf.."增加储备气血 "..item.气血
					end
					if item.魔法 ~= 0 and item.魔法 ~= nil then
						gs = gs..zf.."\n"..zf.."增加储备魔法 "..item.魔法
					end
					if item.子类 == 2 then
						gs = gs..zf.."\n"..zf.."恢复寿命 5".."+".."品质*5"
					end
                 elseif item.分类 == 11 then --月华露
        	           gs=gs..zf.."\n"..zf.."增加召唤兽经验=品质*2*服用召唤兽等级"
        	           self.道具文本:添加文本("#Y/品质:"..item.阶品)
				else
				 if item.子类~=4 then
					if item.气血 ~= 0 and item.气血 ~= nil  then
						--gs = gs..zf.."\n"..zf.."恢复气血 "..item.气血.."点"
					end
					if item.魔法 ~= 0 and item.魔法 ~= nil then
						--gs = gs..zf.."\n"..zf.."恢复魔法 "..item.魔法.."点"
					end
					if item.子类 == 2 then
						--gs = gs..zf.."\n"..zf.."恢复寿命 5".."+".."品质*5"
					end
				  end
				end
			elseif item.子类~=1 and item.子类~=2 and item.分类~=4  then
				if qgx.复活 ~= nil then
					--gs = gs..zf.."\n"..zf.."复活"
				end
			  	if qgx.气血 ~= nil then
					--gs = gs..zf.."\n"..zf.."恢复气血 "..qgx.气血
				end
				if qgx.魔法 ~= nil then
					--gs = gs..zf.."\n"..zf.."恢复魔法 "..qgx.魔法
				end
				if qgx.功效 ~= nil then
					--gs = gs..zf.."\n"..zf..qgx.功效
				end
			end
         if item.子类~=1 and item.子类~=2 and item.分类~=4  then
             -- self.道具文本:添加文本(zf.."【功效】"..gs)
             end
        elseif item.分类 == 11 then --月华露
          if item.名称=="月华露" then
        	  gs=gs..zf.."#W/【功效】增加召唤兽经验=品质*2*服用召唤兽等级"
        	  self.道具文本:添加文本(gs)
        	  self.道具文本:添加文本("#Y/品质:"..item.阶品)
        	elseif item.名称=="九转金丹" then
	        	 self.道具文本:添加文本("【功效】增加人物修炼经验=品质*0.5")
	        	 self.道具文本:添加文本("#Y/品质:"..item.阶品)
           elseif item.名称=="修炼果" then
        	    self.道具文本:添加文本("【功能】提高某种修炼经验，经验达到要求后可提高修炼等级，从而控制召唤兽发挥出更强的潜力。")
           elseif item.名称=="银子" or item.名称=="仙玉" then
	           	self.道具文本:添加文本("#Y/功能：某种疾病的特效药")
	           	self.道具文本:添加文本("#Y/疗程：获取的越多见效越快,失去的越多病情越轻")
	           	self.道具文本:添加文本("#Y/隐患：最痛苦的是还活着它没了，最悲哀的是死了它还有很多")
	           	self.数额转换 = 数额尾数转换(item.数额)
	           	self.道具文本:添加文本("#G/货币面值:"..self.数额转换)
           elseif item.名称=="强化升级丹" then
           		self.道具文本:添加文本("#G/升级技能:"..item.阶品)
           elseif item.名称 == "灵犀玉" then
					self.道具文本:添加文本("#Y/等级："..item.子类)
					self.道具文本:添加文本("#Y/【可以用于修复神器】")
					if item.特性~="无" then
						local 组合语句="#S/"
						if item.特性=="蔓延" then
							组合语句=组合语句..item.特性.."：放置于上下位置插槽时，额外提升相邻插槽的效果。"
						elseif item.特性=="天平" then
							组合语句=组合语句..item.特性.."：放置于左右位置插槽时，额外提升左右插槽的效果。"
						elseif item.特性=="相生" then
							组合语句=组合语句..item.特性.."：提升相邻相生插槽的效果。"
						elseif item.特性=="相克" then
							组合语句=组合语句..item.特性.."：提升相邻相克插槽的效果。"
						elseif item.特性=="聚气" then
							组合语句=组合语句..item.特性.."：本区域所有特性带来的加成效果将集中在该插槽。"
						elseif item.特性=="金耀" then
							组合语句=组合语句..item.特性.."：提升区域中每个金属性插槽的效果。"
						elseif item.特性=="木耀" then
							组合语句=组合语句..item.特性.."：提升区域中每个木属性插槽的效果。"
						elseif item.特性=="水耀" then
							组合语句=组合语句..item.特性.."：提升区域中每个水属性插槽的效果。"
						elseif item.特性=="火耀" then
							组合语句=组合语句..item.特性.."：提升区域中每个火属性插槽的效果。"
						elseif item.特性=="土耀" then
							组合语句=组合语句..item.特性.."：提升区域中每个土属性插槽的效果。"
						elseif item.特性=="利金" then
							组合语句=组合语句..item.特性.."：放置于金属性插槽时，提升其效果。"
						elseif item.特性=="利木" then
							组合语句=组合语句..item.特性.."：放置于木属性插槽时，提升其效果。"
						elseif item.特性=="利水" then
							组合语句=组合语句..item.特性.."：放置于水属性插槽时，提升其效果。"
						elseif item.特性=="利火" then
							组合语句=组合语句..item.特性.."：放置于火属性插槽时，提升其效果。"
						elseif item.特性=="利土" then
							组合语句=组合语句..item.特性.."：放置于土属性插槽时，提升其效果。"
						end
						self.道具文本:添加文本(组合语句)
					end

           end
       elseif item.子类 == 4 then
		else
			if item.名称=="元宵" then
              self.道具文本:添加文本("【食材】"..item.食材)
            end
			if qgx.功效 ~= nil then
				gs = gs..qgx.功效
			end
			self.道具文本:添加文本(zf.."【功效】"..gs)
		end
	elseif zls == 67 then
    	self.道具文本:添加文本("#Y/等级 "..item.级别限制)
    elseif zls == 65 then
    	self.道具文本:添加文本("#Y/右键直接打开幻化界面")
    elseif zls == 66 then
    	self.道具文本:添加文本(" ")
 		self.道具文本:添加文本("#Y/等级 "..item.级别限制)
 		local sx = ""
		local 气血 = item.幻化元身属性.气血
		local 魔法 = item.幻化元身属性.魔法
		local 命中 = item.幻化元身属性.命中
		local 伤害 = item.幻化元身属性.伤害
		local 防御 = item.幻化元身属性.防御
		local 速度 = item.幻化元身属性.速度
		local 躲避 = item.幻化元身属性.躲避
		local 灵力 = item.幻化元身属性.灵力
		local 体质 = item.幻化元身属性.体质
		local 魔力 = item.幻化元身属性.魔力
		local 力量 = item.幻化元身属性.力量
		local 耐力 = item.幻化元身属性.耐力
		local 敏捷 = item.幻化元身属性.敏捷
		if 气血 ~= 0 and 气血 ~= nil then
			sx = sx.."气血 +"..气血.." "
		end
		if 魔法 ~= 0 and 魔法 ~= nil then
			sx = sx.."魔法 +"..魔法.." "
		end
		if 命中 ~= 0  and 命中 ~= nil then
			sx = sx.."命中 +"..命中.." "
		end
		if 伤害 ~= 0 and 伤害 ~= nil then
			sx = sx.."伤害 +"..伤害.." "
		end
		if 防御 ~= 0 and 防御 ~= nil  then
			sx = sx.."防御 +"..防御.." "
		end
		if 速度 ~= 0 and 速度 ~= nil  then
			sx = sx.."速度 +"..速度.." "
		end
		if 灵力 ~= 0 and 灵力 ~= nil  then
			sx = sx.."灵力 +"..灵力.." "
		end
		if 敏捷 ~= 0 and 敏捷~=nil and item.元身序列 == 25 then
			sx = sx.."敏捷 +"..敏捷.." "
		end
		if sx ~= "" then
			self.道具文本:添加文本("#Y/"..sx)
		end

		local ds = ""
		if 体质 ~= nil and 体质 ~= 0 then
			ds = ds..体质.." "
		end
		if 魔力 ~= nil and 魔力 ~= 0  then
			ds = ds..魔力.." "
		end
		if 力量 ~= nil and 力量 ~= 0 then
			ds = ds..力量.." "
		end
		if 耐力 ~= nil and 耐力 ~= 0 then
			ds = ds..耐力.." "
		end
		if 敏捷 ~= nil and 敏捷 ~= 0 and item.元身序列 ~= 25 then
			ds = ds..敏捷.." "
		end
		if ds ~= "" then
			self.道具文本:添加文本("#G/"..ds)
		end
		if item.幻化元身属性.特技 ~= nil then
			self.道具文本:添加文本("#S/"..item.幻化元身属性.特技)
		end
		if item.幻化元身属性.特效 ~= nil then
			self.道具文本:添加文本("#S/"..item.幻化元身属性.特效)
		end
		if item.幻化次数 ~= nil then
			self.道具文本:添加文本("#Y/幻化次数："..item.幻化次数)
		end
		self.道具文本:添加文本(" ")
    elseif zls == 2 then
    	    if item.灵饰 then
			    self.道具文本:添加文本("【装备条件】等级"..item.级别限制)
			    self.道具文本:添加文本("【灵饰类型】"..item.部位类型)
			    if item.鉴定 then
			    	self.道具文本:添加文本("#Y/等级 "..item.级别限制)
			        self.道具文本:添加文本("#Y/"..item.幻化属性.基础.类型.." +"..item.幻化属性.基础.数值)
			      	if item.耐久 ~= nil then
			      		item.耐久=math.floor(item.耐久)
			      		if item.修理失败~=nil and item.修理失败~=0 then
			      		    self.道具文本:添加文本(format("#Y/耐久度：%s  修理失败 %s次",item.耐久,item.修理失败))
			      		else
			      			self.道具文本:添加文本(format("#Y/耐久度 "..item.耐久))
			      		end
			      		if item.专用 ~= nil then
							self.道具文本:添加文本(format("#Y/不可交易"))
						end
			      	end
			      	if item.特效 ~= nil then
					  self.道具文本:添加文本(format("#S/特效：%s",item.特效))
				  	end
			      	if item.幻化等级>0 then self.道具文本:添加文本("#Y/精炼等级 "..item.幻化等级) end
			      	for n=1,#item.幻化属性.附加 do
			          	if item.幻化等级==0 then
			             	self.道具文本:添加文本("#G/"..item.幻化属性.附加[n].类型.." +"..item.幻化属性.附加[n].数值)
			            else
			             	self.道具文本:添加文本("#G/"..item.幻化属性.附加[n].类型.." +"..item.幻化属性.附加[n].数值.." #X/[+"..item.幻化属性.附加[n].强化.."]")
			          	end
			      	end
			     	if item.制造者~=nil then
			           	self.道具文本:添加文本("制造者："..item.制造者)
			     	end
			     	if item.附加特性 ~= nil and item.附加特性.幻化等级 ~= nil then
			     		     self.道具文本:添加文本("#S特效： "..item.附加特性.幻化类型.."("..item.附加特性.幻化等级.."级)")
								 if item.附加特性.幻化类型 == "心源" then
									 self.道具文本:添加文本("#S物理防御 +"..(item.附加特性.幻化等级*4))
								 elseif item.附加特性.幻化类型=="气血方刚" then
										self.道具文本:添加文本("#S/气血上限 +"..(item.附加特性.幻化等级*14))
								 elseif item.附加特性.幻化类型=="通真达灵" then
										self.道具文本:添加文本("#S/法术防御 +"..(item.附加特性.幻化等级*4))
								 elseif item.附加特性.幻化类型=="心无旁骛" then
										self.道具文本:添加文本("#S/抵抗封印等级 +"..(item.附加特性.幻化等级*6))
								 elseif item.附加特性.幻化类型=="健步如飞" then
										self.道具文本:添加文本("#S/速度 +"..(item.附加特性.幻化等级*3))
								 elseif item.附加特性.幻化类型=="回春之术" then
										self.道具文本:添加文本("#S/治疗能力 +"..(item.附加特性.幻化等级*10))
								 elseif item.附加特性.幻化类型=="风雨不动" then
										self.道具文本:添加文本("#S/抗法术暴击等级 +"..(item.附加特性.幻化等级*6))
								 elseif item.附加特性.幻化类型=="固若金汤" then
										self.道具文本:添加文本("#S/抗物理暴击等级 +"..(item.附加特性.幻化等级*6))
								 elseif item.附加特性.幻化类型=="气壮山河" then
										self.道具文本:添加文本("#S/气血回复效果 +"..(item.附加特性.幻化等级*5))
							     elseif item.附加特性.幻化类型=="锐不可当" then
										self.道具文本:添加文本("#S/固定伤害 +"..(item.附加特性.幻化等级*10))
								 end
								 if item.灵饰套装~=nil then
								 	   if item.灵饰套装<2 then
								 			local 文本 = 取钟灵石套装(item.附加特性.幻化类型,item.灵饰套装)
								 			self.道具文本:添加文本("#C/【套装效果】"..文本.."(未生效)["..item.灵饰套装.."/2]")
								 	    elseif item.灵饰套装<=3 then
								 	    	local 文本 = 取钟灵石套装(item.附加特性.幻化类型,item.灵饰套装)
								 			self.道具文本:添加文本("#S/【套装效果】"..文本.."(已生效)["..item.灵饰套装.."/2]")
								 			local 文本1 = 取钟灵石套装(item.附加特性.幻化类型,4)
								 			self.道具文本:添加文本("#C/【套装效果】"..文本1.."(未生效)["..item.灵饰套装.."/4]")
								 		else
								 			local 文本 = 取钟灵石套装(item.附加特性.幻化类型,4)
								 			self.道具文本:添加文本("#S/【套装效果】"..文本.."(已生效)["..item.灵饰套装.."/4]")
								 		end
								 end
			     	end
			     else
						self.道具文本:添加文本("#G/未鉴定物品")
			     end
            elseif item.分类 == 15 or item.分类 == 16 or item.分类 == 17 or item.分类 == 18 then
			    	   if item.分类 == 15 then
			    	   	  self.道具文本:添加文本("#S/气血 +10%")
			    	   	  self.道具文本:添加文本("#S/魔法 +10%")
			    	   	  self.道具文本:添加文本("#S/伤害 +5%")
			    	   	  self.道具文本:添加文本("#S/法伤 +5%")
			    	   elseif item.分类 == 16 then
			    	   	  self.道具文本:添加文本("#S/防御 +5%")
			    	   	  self.道具文本:添加文本("#S/法防 +5%")
			    	   elseif item.分类 == 17 then
			    	   	  self.道具文本:添加文本("#S/速度 +8%")
			    	   end
	        elseif not item.灵饰 then
					self.道具文本1:清空()
					self.道具文本1:添加文本("")
					self.道具文本1:添加文本(item.介绍)
					self.道具文本2:清空()
					self.道具文本2:添加文本("")
					--self.道具文本2:添加文本(item.介绍)
					self.道具文本3:清空()
					self.道具文本3:添加文本("")
					--local 介绍长度 = string.len(item.介绍)+26
					local 介绍长度 = string.len(item.介绍)
					if item.鉴定 then
						if item.分类 == 3 then
							self.道具文本:添加文本("#W/【装备条件】等级"..item.级别限制)
							self.道具文本1:添加文本("#W/【装备条件】等级"..item.级别限制)
							if item.角色限制[2] == nil then
								self.道具文本:添加文本("#W/【装备角色】"..item.角色限制[1])
								self.道具文本1:添加文本("#W/【装备角色】"..item.角色限制[1])
							elseif item.角色限制[3] == nil then
									self.道具文本:添加文本("#W/【装备角色】"..item.角色限制[1].."、"..item.角色限制[2])
									self.道具文本1:添加文本("#W/【装备角色】"..item.角色限制[1].."、"..item.角色限制[2])
							elseif item.角色限制[4] == nil then
									self.道具文本:添加文本("#W/【装备角色】"..item.角色限制[1].."、"..item.角色限制[2].."、"..item.角色限制[3])
									self.道具文本1:添加文本("#W/【装备角色】"..item.角色限制[1].."、"..item.角色限制[2].."、"..item.角色限制[3])
									介绍长度 = 介绍长度 + 26
							else
								self.道具文本:添加文本("#W/【装备角色】"..item.角色限制[1].."、"..item.角色限制[2].."、"..item.角色限制[3].."、"..item.角色限制[4])
								self.道具文本1:添加文本("#W/【装备角色】"..item.角色限制[1].."、"..item.角色限制[2].."、"..item.角色限制[3].."、"..item.角色限制[4])
								介绍长度 = 介绍长度 + 26
							end
						elseif item.分类 == 1 or item.分类 == 4 then
								self.道具文本:添加文本("#W/【装备条件】等级"..item.级别限制)
								self.道具文本1:添加文本("#W/【装备条件】等级"..item.级别限制)
								if item.分类 == 4  and  string.find(item.名称,"(坤)") and item.角色限制 and item.角色限制[1]=="影精灵" then
										self.道具文本:添加文本("#W/【装备角色】"..item.角色限制[1])
										self.道具文本1:添加文本("#W/【装备角色】"..item.角色限制[1])
								else
									self.道具文本:添加文本("#W/【装备角色】"..item.性别限制)
									self.道具文本1:添加文本("#W/【装备角色】"..item.性别限制)
								end
						elseif item.分类 > 6 and  item.分类 < 10 then
							self.道具文本:添加文本("#W/【角色限制】召唤兽")
							self.道具文本1:添加文本("#W/【角色限制】召唤兽")
						elseif item.分类 >= 10 then
							self.道具文本:添加文本("#W/【装备等级】"..item.级别限制)
							 self.道具文本1:添加文本("#W/【装备等级】"..item.级别限制)
						else
							self.道具文本:添加文本("#W/【装备条件】等级"..item.级别限制)
							self.道具文本:添加文本("#W/【装备角色】无")
							self.道具文本1:添加文本("#W/【装备条件】等级"..item.级别限制)
							self.道具文本1:添加文本("#W/【装备角色】无")
						end
							self.道具文本:添加文本("#Y/等级 "..item.级别限制.." 五行 "..item.五行)
							if 介绍长度<105 then
								self.道具文本1:添加文本("#Y/等级 "..item.级别限制.." 五行 "..item.五行)
	                        else
	                            self.道具文本2:添加文本("#Y/等级 "..item.级别限制.." 五行 "..item.五行)
	                        end
			              local 基础显示 =""
						  if item.分类==1 then
							 if item.魔法 ~= 0 and item.魔法 ~= nil  then
							 	基础显示 = 基础显示.."#Y/魔法 +"..item.魔法.." "
							 end
							 if item.防御 ~= 0 and item.防御 ~= nil   then
							  	 基础显示 = 基础显示.."#Y/防御 +"..item.防御.." "
							 end
						  elseif item.分类==2 then
						  	     if item.灵力 ~= 0 and item.灵力 ~= nil  then
								   基础显示 =基础显示.."#Y/灵力 +"..item.灵力.." "
								end
						  elseif item.分类==3 then
						  	     if item.命中 ~= 0 and item.命中 ~= nil  then
								   基础显示 =基础显示.."#Y/命中 +"..item.命中.." "
								end
								if item.伤害 ~= 0 and item.伤害 ~= nil  then
								   基础显示 =基础显示.."#Y/伤害 +"..item.伤害.." "
								end
				          elseif item.分类==4 then

				          	if   string.find(item.名称,"(坤)") and item.角色限制 and item.角色限制[1]=="影精灵" then
								  if item.命中 ~= 0 and item.命中 ~= nil  then
									   基础显示 =基础显示.."#Y/命中 +"..item.命中.." "
								  end
								  if item.伤害 ~= 0 and item.伤害 ~= nil  then
									   基础显示 =基础显示.."#Y/伤害 +"..item.伤害.." "
								  end
							else
						  	     if item.防御 ~= 0 and item.防御 ~= nil  then
								   基础显示 =基础显示.."#Y/防御 +"..item.防御.." "
								 end
							end
						  elseif item.分类==5 then
						   	      if item.气血 ~= 0 and item.气血 ~= nil  then
						   	      	基础显示 =基础显示.."#Y/气血 +"..item.气血.." "
								end
						  	     if item.防御 ~= 0 and item.防御 ~= nil  then
								   基础显示 =基础显示.."#Y/防御 +"..item.防御.." "
								end
						   elseif item.分类==6 then
						   	     if item.敏捷 ~= 0 and item.敏捷 ~= nil  then
								   基础显示 =基础显示.."#Y/敏捷 +"..item.敏捷.." "
								end
						  	    if item.防御 ~= 0 and item.防御 ~= nil  then
								    基础显示 =基础显示.."#Y/防御 +"..item.防御.." "
								end
						   elseif item.分类>=7 and item.分类<=9 then
						   	      if item.气血 ~= 0 and item.气血 ~= nil  then
									 基础显示 =基础显示.."#Y/气血 +"..item.气血.." "
								  end
								  if item.魔法 ~= 0 and item.魔法 ~= nil  then
									 基础显示 =基础显示.."#Y/魔法 +"..item.魔法.." "
								  end
								  if  item.分类==7 then
								  	  if item.命中 ~= 0 and item.命中 ~= nil  then ---- 伤害
										 基础显示 =基础显示.."#Y/命中 +"..item.命中.." "
									  end
								  elseif  item.分类==8 then
									  if item.速度 ~= 0 and item.速度 ~= nil  then ---- 伤害
										 基础显示 =基础显示.."#Y/速度 +"..item.速度.." "
									  end
								  elseif  item.分类==9 then
								  	  if item.防御 ~= 0 and item.防御 ~= nil  then ---- 伤害
										 基础显示 =基础显示.."#Y/防御 +"..item.防御.." "
									  end
								 end
								 if item.伤害 ~= 0 and item.伤害 ~= nil  then
									基础显示 =基础显示.."#Y/伤害 +"..item.伤害.." "
								 end
								 if item.灵力 ~= 0 and item.灵力 ~= nil  then
									基础显示 =基础显示.."#Y/灵力 +"..item.灵力.." "
								 end
						   end
						   if 基础显示~="" then
							   self.道具文本:添加文本(基础显示)
							   if 介绍长度<79 then
									self.道具文本1:添加文本(基础显示)
		                       else
		                            self.道具文本2:添加文本(基础显示)
		                       end
							end
						   local 属性显示 =""
						   if item.分类==3 or item.分类==4  or item.分类==7 or item.分类==8 or item.分类==9 then
								 if item.分类==7 then
									  if item.速度 ~= 0 and item.速度 ~= nil  then
										 属性显示 =属性显示.."#G/速度 +"..item.速度.." "
									  end
									   if item.防御 ~= 0 and item.防御 ~= nil  then
										 属性显示 =属性显示.."#G/防御 +"..item.防御.." "
									  end
								  elseif  item.分类==8 then
									  if item.防御 ~= 0 and item.防御 ~= nil  then
										 属性显示 =属性显示.."#G/防御 +"..item.防御.." "
									  end
									  if item.命中 ~= 0 and item.命中 ~= nil  then
										 属性显示 =属性显示.."#G/命中 +"..item.命中.." "
									  end
								  elseif  item.分类==9 then
									  if item.命中 ~= 0 and item.命中 ~= nil  then
										 属性显示 =属性显示.."#G/命中 +"..item.命中.." "
									  end
									  if item.速度 ~= 0 and item.速度 ~= nil  then
										 属性显示 =属性显示.."#G/速度 +"..item.速度.." "
									  end
								 end
							   	   if item.体质 ~= 0 and item.体质 ~= nil  then
							   	   	  属性显示 =属性显示.."#G/体质 +"..item.体质.." "
								   end
								   if item.魔力 ~= 0 and item.魔力 ~= nil  then
									   属性显示 =属性显示.."#G/魔力 +"..item.魔力.." "
								   end
								   if item.力量 ~= 0 and item.力量 ~= nil  then
									   属性显示 =属性显示.."#G/力量 +"..item.力量.." "
								   end
								   if item.耐力 ~= 0 and item.耐力 ~= nil  then
									   属性显示 =属性显示.."#G/耐力 +"..item.耐力.." "
								   end
								   if item.敏捷 ~= 0 and item.敏捷 ~= nil  then
									   属性显示 =属性显示.."#G/敏捷 +"..item.敏捷.." "
								   end

						   end
						   if 属性显示~="" then
							   self.道具文本:添加文本(属性显示)
							   if 介绍长度<53 then
									self.道具文本1:添加文本(属性显示)
		                       else
		                            self.道具文本2:添加文本(属性显示)
		                       end

						   end
						if item.耐久 ~= nil then
							item.耐久=math.floor(item.耐久)
				      		if item.修理失败~=nil and item.修理失败~=0 then
				      		    self.道具文本:添加文本(format("#Y/耐久度：%s  修理失败 %s次",item.耐久,item.修理失败))
				      		    if 属性显示~="" then
				      		    	self.道具文本2:添加文本(format("#Y/耐久度：%s  修理失败 %s次",item.耐久,item.修理失败))
				      		    else
				      		        if 介绍长度<53 then
				      		        	self.道具文本1:添加文本(format("#Y/耐久度：%s  修理失败 %s次",item.耐久,item.修理失败))
				      		    	else
				      		    	    self.道具文本2:添加文本(format("#Y/耐久度：%s  修理失败 %s次",item.耐久,item.修理失败))
				      		    	end
				      		    end
				      		else
				      			self.道具文本:添加文本(format("#Y/耐久度 "..item.耐久))
				      			if 属性显示~="" then
				      		       self.道具文本2:添加文本(format("#Y/耐久度 "..item.耐久))
				      		    else
				      		    	 if 介绍长度<53 then
				      		    	 	self.道具文本1:添加文本(format("#Y/耐久度 "..item.耐久))
				      		    	 else
				      		    	     self.道具文本2:添加文本(format("#Y/耐久度 "..item.耐久))
				      		    	 end
				      		    end


				      		end
			      		end
						if item.锻炼等级 ~= nil then
							local bsz = ""
							for i=1,#item.镶嵌宝石 do
								local sw = "、"
								if i == #item.镶嵌宝石 then
									sw = ""
								end
								bsz = bsz..item.镶嵌宝石[i]..sw
							end
							self.道具文本:添加文本(format("#Y/锻炼等级 %s   镶嵌宝石 %s",item.锻炼等级,bsz))
							self.道具文本2:添加文本(format("#Y/锻炼等级 %s   镶嵌宝石 %s",item.锻炼等级,bsz))
							local 宝石显示 = ""
							if item.分类==1 then
							   if item.命中 ~= 0 and item.命中 ~= nil  then
							   	   宝石显示 =宝石显示.."#G/命中 +"..item.命中.." "
							    end
							    if item.伤害 ~= 0 and item.伤害 ~= nil  then
								   宝石显示 =宝石显示.."#G/伤害 +"..item.伤害.." "
							    end
							elseif item.分类==3 then
								if item.躲避 ~= 0 and item.躲避 ~= nil  then
								   宝石显示 =宝石显示.."#G/躲避 +"..item.躲避.." "
							    end
							elseif item.分类==4 then
								if item.灵力 ~= 0 and item.灵力 ~= nil  then
								   宝石显示 =宝石显示.."#G/灵力 +"..item.灵力.." "
							    end
							    if item.气血 ~= 0 and item.气血 ~= nil  then
								   宝石显示 =宝石显示.."#G/气血 +"..item.气血.." "
							    end
							elseif item.分类==5 or item.分类==6 then
								 if item.速度 ~= 0 and item.速度 ~= nil  then
								   宝石显示 =宝石显示.."#G/速度 +"..item.速度.." "
							    end
								if item.躲避 ~= 0 and item.躲避 ~= nil  then
								   宝石显示 =宝石显示.."#G/躲避 +"..item.躲避.." "
							    end
							end
							if  宝石显示~="" then
								self.道具文本:添加文本(宝石显示)
							    self.道具文本2:添加文本(宝石显示)
							 end
						end


						if item.镶嵌等级 ~= nil and item.分类 > 6 and  item.分类 < 10  then
							self.道具文本:添加文本(format("#Y/锻炼等级 %s   镶嵌属性 %s",item.镶嵌等级,item.镶嵌宝石))
							self.道具文本2:添加文本(format("#Y/锻炼等级 %s   镶嵌属性 %s",item.镶嵌等级,item.镶嵌宝石))
						end

						if item.临时附魔 ~= nil then
							if item.分类 == 1 then
						    	if item.临时附魔.命中.数值 ~= 0 then
						            self.道具文本:添加文本(format("#G/临时命中 "..item.临时附魔.命中.数值.." "..item.临时附魔.命中.时间))
						            self.道具文本2:添加文本(format("#G/临时命中 "..item.临时附魔.命中.数值.." "..item.临时附魔.命中.时间))
						        end
						        if item.临时附魔.耐力.数值 ~= 0 then
						            self.道具文本:添加文本(format("#G/临时耐力 "..item.临时附魔.耐力.数值.." "..item.临时附魔.耐力.时间))
						            self.道具文本2:添加文本(format("#G/临时耐力 "..item.临时附魔.耐力.数值.." "..item.临时附魔.耐力.时间))
						        end
						    elseif item.分类 == 2 then
						        if item.临时附魔.体质.数值 ~= 0 then
						            self.道具文本:添加文本(format("#G/临时体质 "..item.临时附魔.体质.数值.." "..item.临时附魔.体质.时间))
						            self.道具文本2:添加文本(format("#G/临时体质 "..item.临时附魔.体质.数值.." "..item.临时附魔.体质.时间))
						        end
						        if item.临时附魔.法术伤害.数值 ~= 0 then
						            self.道具文本:添加文本(format("#G/临时法伤 "..item.临时附魔.法术伤害.数值.." "..item.临时附魔.法术伤害.时间))
						             self.道具文本2:添加文本(format("#G/临时法伤 "..item.临时附魔.法术伤害.数值.." "..item.临时附魔.法术伤害.时间))
						        end
						    elseif item.分类 == 3 then
						    	if item.临时附魔.伤害.数值 ~= 0 then
						            self.道具文本:添加文本(format("#G/临时伤害 "..item.临时附魔.伤害.数值.." "..item.临时附魔.伤害.时间))
						         self.道具文本2:添加文本(format("#G/临时伤害 "..item.临时附魔.伤害.数值.." "..item.临时附魔.伤害.时间))
						        end
						        if item.临时附魔.气血.数值 ~= 0 then
						            self.道具文本:添加文本(format("#G/临时气血 "..item.临时附魔.气血.数值.." "..item.临时附魔.气血.时间))
						            self.道具文本2:添加文本(format("#G/临时气血 "..item.临时附魔.气血.数值.." "..item.临时附魔.气血.时间))
						        end
						        if item.临时附魔.魔法.数值 ~= 0 then
						            self.道具文本:添加文本(format("#G/临时魔法 "..item.临时附魔.魔法.数值.." "..item.临时附魔.魔法.时间))
						             self.道具文本2:添加文本(format("#G/临时魔法 "..item.临时附魔.魔法.数值.." "..item.临时附魔.魔法.时间))
						        end
						        if item.临时附魔.防御.数值 ~= 0 then
						            self.道具文本:添加文本(format("#G/临时防御 "..item.临时附魔.防御.数值.." "..item.临时附魔.防御.时间))
						            self.道具文本2:添加文本(format("#G/临时防御 "..item.临时附魔.防御.数值.." "..item.临时附魔.防御.时间))
						        end
						    elseif item.分类 == 4 then
						        if item.临时附魔.法术防御.数值 ~= 0 then
						            self.道具文本:添加文本(format("#G/临时法防 "..item.临时附魔.法术防御.数值.." "..item.临时附魔.法术防御.时间))
						            self.道具文本2:添加文本(format("#G/临时法防 "..item.临时附魔.法术防御.数值.." "..item.临时附魔.法术防御.时间))
						        end
						        if item.临时附魔.魔力.数值 ~= 0 then
						            self.道具文本:添加文本(format("#G/临时魔力 "..item.临时附魔.魔力.数值.." "..item.临时附魔.魔力.时间))
						             self.道具文本2:添加文本(format("#G/临时魔力 "..item.临时附魔.魔力.数值.." "..item.临时附魔.魔力.时间))
						        end
						    elseif item.分类 == 5 then
						        if item.临时附魔.愤怒.数值 ~= 0 then
						            self.道具文本:添加文本(format("#G/临时愤怒 "..item.临时附魔.愤怒.数值.." "..item.临时附魔.愤怒.时间))
						            self.道具文本2:添加文本(format("#G/临时愤怒 "..item.临时附魔.愤怒.数值.." "..item.临时附魔.愤怒.时间))
						        end
						        if item.临时附魔.伤害.数值 ~= 0 then
						            self.道具文本:添加文本(format("#G/临时伤害 "..item.临时附魔.伤害.数值.." "..item.临时附魔.伤害.时间))
						            self.道具文本2:添加文本(format("#G/临时伤害 "..item.临时附魔.伤害.数值.." "..item.临时附魔.伤害.时间))
						        end
						    elseif item.分类 == 6 then
						        if item.临时附魔.速度.数值 ~= 0 then
						            self.道具文本:添加文本(format("#G/临时速度 "..item.临时附魔.速度.数值.." "..item.临时附魔.速度.时间))
						            self.道具文本2:添加文本(format("#G/临时速度 "..item.临时附魔.速度.数值.." "..item.临时附魔.速度.时间))
						        end
						        if item.临时附魔.魔法.数值 ~= 0 then
						            self.道具文本:添加文本(format("#G/临时魔法 "..item.临时附魔.魔法.数值.." "..item.临时附魔.魔法.时间))
						            self.道具文本2:添加文本(format("#G/临时魔法 "..item.临时附魔.魔法.数值.." "..item.临时附魔.魔法.时间))
						        end
						    end
						end

						if item.赐福 ~= nil then
							if item.赐福.总类=="基础" then
								self.道具文本:添加文本("#P/[仙人赐福]#R/"..item.赐福.类型.."#P/ +#R/"..item.赐福.数值)
								self.道具文本2:添加文本("#P/[仙人赐福]#R/"..item.赐福.类型.."#P/ +#R/"..item.赐福.数值)
							else
								self.道具文本:添加文本("#P/[仙人赐福]#R/"..item.赐福.类型.."#P/ +#R/"..item.赐福.数值.."%")
								self.道具文本2:添加文本("#P/[仙人赐福]#R/"..item.赐福.类型.."#P/ +#R/"..item.赐福.数值.."%")
							end
						end

						if item.特技 ~= nil then
							self.道具文本:添加文本(format("#S/特技：%s",item.特技))
							self.道具文本2:添加文本(format("#S/特技：%s",item.特技))
						end
						if item.特效 ~= nil then
							self.道具文本:添加文本(format("#S/特效：%s",item.特效))
							self.道具文本2:添加文本(format("#S/特效：%s",item.特效))
						end
						if item.第二特效 ~= nil then--"龙宫
						  	self.道具文本:添加文本(format("#S/特效：%s",item.第二特效))
						  	self.道具文本2:添加文本(format("#S/特效：%s",item.第二特效))
						end
						if item.套装效果 ~= nil then
							self.道具文本:添加文本(format("#S/套装效果：%s",item.套装效果[1]..item.套装效果[2]))
							self.道具文本2:添加文本(format("#S/套装效果：%s",item.套装效果[1]..item.套装效果[2]))
						end
						if item.装备境界 and item.装备境界.品质~="普通" then
								local 装备词条 = item.装备境界.词条
								local 装备品质 = item.装备境界.品质
								if item.装备境界.品质~="传说" and item.装备境界.品质~="神话" and item.装备境界.升级值 and item.装备境界.升级值>0 then
									self.道具文本:添加文本("#G/境界值:"..item.装备境界.升级值)
									self.道具文本2:添加文本("#G/境界值:"..item.装备境界.升级值)
								end
								if item.装备境界.洗练值 and (item.装备境界.洗练值>0 or (装备词条 and (装备词条[1] or 装备词条[2] or 装备词条[3]))) then
									self.道具文本:添加文本("#G/仙宝值:"..item.装备境界.洗练值)
									self.道具文本2:添加文本("#G/仙宝值:"..item.装备境界.洗练值)
								end
								if 装备词条 and  装备词条[1] and 境界属性[装备词条[1].类型]  then
									self.道具文本:添加文本("#G/["..装备词条[1].类型.."] "..境界属性[装备词条[1].类型].类型.." +"..装备词条[1].数额.."("..境界属性[装备词条[1].类型][装备品质]..")")
									self.道具文本2:添加文本("#G/["..装备词条[1].类型.."] "..境界属性[装备词条[1].类型].类型.." +"..装备词条[1].数额.."("..境界属性[装备词条[1].类型][装备品质]..")")
								end
								if 装备词条 and  装备词条[2] and 装备词条[2].类型 and 境界属性[装备词条[2].类型] then
								    self.道具文本:添加文本("#G/["..装备词条[2].类型.."] "..境界属性[装备词条[2].类型].类型.." +"..装备词条[2].数额.."("..math.floor(境界属性[装备词条[2].类型][装备品质]/2)..")")
									self.道具文本2:添加文本("#G/["..装备词条[2].类型.."] "..境界属性[装备词条[2].类型].类型.." +"..装备词条[2].数额.."("..math.floor(境界属性[装备词条[2].类型][装备品质]/2)..")")
								end
								if 装备词条 and  装备词条[3] and 装备词条[3].类型 and 境界属性[装备词条[3].类型] then
								    self.道具文本:添加文本("#G/["..装备词条[3].类型.."] "..境界属性[装备词条[3].类型].类型.." +"..装备词条[3].数额.."("..math.floor(境界属性[装备词条[3].类型][装备品质]/2)..")")
									self.道具文本2:添加文本("#G/["..装备词条[3].类型.."] "..境界属性[装备词条[3].类型].类型.." +"..装备词条[3].数额.."("..math.floor(境界属性[装备词条[3].类型][装备品质]/2)..")")
								end

								if item.装备境界.神话值 and (item.装备境界.神话值>0 or (item.装备境界.神话词条~=nil and item.装备境界.神话词条~=""))  then
									self.道具文本:添加文本("#R/神话值:"..item.装备境界.神话值)
									self.道具文本2:添加文本("#R/神话值:"..item.装备境界.神话值)
								end
								if item.装备境界.神话词条~=nil and item.装备境界.神话词条~="" then
									if 境界属性[item.装备境界.神话词条] then
										self.道具文本:添加文本("#R/["..item.装备境界.神话词条.."] "..境界属性[item.装备境界.神话词条].类型.." +"..境界属性[item.装备境界.神话词条][装备品质])
										self.道具文本2:添加文本("#R/["..item.装备境界.神话词条.."] "..境界属性[item.装备境界.神话词条].类型.." +"..境界属性[item.装备境界.神话词条][装备品质])
									elseif 神话属性[item.装备境界.神话词条] then
										self.道具文本:添加文本("#R/限制门派:"..神话属性[item.装备境界.神话词条].限制)
										self.道具文本2:添加文本("#R/限制门派:"..神话属性[item.装备境界.神话词条].限制)
										self.道具文本:添加文本("#R/["..item.装备境界.神话词条.."] "..神话属性[item.装备境界.神话词条].描述)
										self.道具文本2:添加文本("#R/["..item.装备境界.神话词条.."] "..神话属性[item.装备境界.神话词条].描述)
									end
								end
								if 装备词条 and 装备词条[1] and 装备词条[2] and 装备词条[3] then
									if 装备词条[1].类型 ~=装备词条[2].类型 and 装备词条[1].类型~=装备词条[3].类型 and 装备词条[2].类型~=装备词条[3].类型  then
										if 境界属性[装备词条[1].类型].共鸣 then
											self.道具文本:添加文本("#C/共鸣效果:")
									    	self.道具文本2:添加文本("#C/共鸣效果:")
									    	self.道具文本:添加文本("#C/["..装备词条[1].类型.."] 效果提升25%(1/3)")
											self.道具文本2:添加文本("#C/["..装备词条[1].类型.."] 效果提升25%(1/3)")

										elseif not 境界属性[装备词条[1].类型].共鸣 and 境界属性[装备词条[2].类型].共鸣  then
												self.道具文本:添加文本("#C/共鸣效果:")
										    	self.道具文本2:添加文本("#C/共鸣效果:")
										    	self.道具文本:添加文本("#C/["..装备词条[2].类型.."] 效果提升25%(1/3)")
												self.道具文本2:添加文本("#C/["..装备词条[2].类型.."] 效果提升25%(1/3)")
										elseif not 境界属性[装备词条[1].类型].共鸣 and not 境界属性[装备词条[2].类型].共鸣  and 境界属性[装备词条[3].类型].共鸣 then
												self.道具文本:添加文本("#C/共鸣效果:")
										    	self.道具文本2:添加文本("#C/共鸣效果:")
										    	self.道具文本:添加文本("#C/["..装备词条[3].类型.."] 效果提升25%(1/3)")
												self.道具文本2:添加文本("#C/["..装备词条[3].类型.."] 效果提升25%(1/3)")
										end
								    elseif 装备词条[1].类型 ==装备词条[2].类型 and 装备词条[1].类型~=装备词条[3].类型  then
								    		if 境界属性[装备词条[1].类型].共鸣 then
									    		self.道具文本:添加文本("#C/共鸣效果:")
											    self.道具文本2:添加文本("#C/共鸣效果:")
												self.道具文本:添加文本("#C/["..装备词条[1].类型.."] 效果提升25%(2/3)")
												self.道具文本2:添加文本("#C/["..装备词条[1].类型.."] 效果提升25%(2/3)")
											elseif not 境界属性[装备词条[1].类型].共鸣  and 境界属性[装备词条[3].类型].共鸣   then
												self.道具文本:添加文本("#C/共鸣效果:")
											    self.道具文本2:添加文本("#C/共鸣效果:")
											    self.道具文本:添加文本("#C/["..装备词条[3].类型.."] 效果提升25%(1/3)")
												self.道具文本2:添加文本("#C/["..装备词条[3].类型.."] 效果提升25%(1/3)")
											end
								    elseif 装备词条[1].类型 ~=装备词条[2].类型 and 装备词条[1].类型==装备词条[3].类型 then
											if 境界属性[装备词条[1].类型].共鸣 then
									    		self.道具文本:添加文本("#C/共鸣效果:")
											    self.道具文本2:添加文本("#C/共鸣效果:")
												self.道具文本:添加文本("#C/["..装备词条[1].类型.."] 效果提升25%(2/3)")
												self.道具文本2:添加文本("#C/["..装备词条[1].类型.."] 效果提升25%(2/3)")
											elseif not 境界属性[装备词条[1].类型].共鸣  and 境界属性[装备词条[2].类型].共鸣   then
												self.道具文本:添加文本("#C/共鸣效果:")
											    self.道具文本2:添加文本("#C/共鸣效果:")
											    self.道具文本:添加文本("#C/["..装备词条[2].类型.."] 效果提升25%(1/3)")
												self.道具文本2:添加文本("#C/["..装备词条[2].类型.."] 效果提升25%(1/3)")
											end
									elseif 装备词条[1].类型 ~=装备词条[2].类型 and 装备词条[2].类型==装备词条[3].类型 then
											if 境界属性[装备词条[2].类型].共鸣 then
									    		self.道具文本:添加文本("#C/共鸣效果:")
											    self.道具文本2:添加文本("#C/共鸣效果:")
												self.道具文本:添加文本("#C/["..装备词条[2].类型.."] 效果提升25%(2/3)")
												self.道具文本2:添加文本("#C/["..装备词条[2].类型.."] 效果提升25%(2/3)")
											elseif not 境界属性[装备词条[2].类型].共鸣  and 境界属性[装备词条[1].类型].共鸣   then
												self.道具文本:添加文本("#C/共鸣效果:")
											    self.道具文本2:添加文本("#C/共鸣效果:")
											    self.道具文本:添加文本("#C/["..装备词条[1].类型.."] 效果提升25%(1/3)")
												self.道具文本2:添加文本("#C/["..装备词条[1].类型.."] 效果提升25%(1/3)")
											end
									elseif 装备词条[1].类型 ==装备词条[2].类型 and 装备词条[1].类型==装备词条[3].类型 and 境界属性[装备词条[1].类型].共鸣 then
								    		self.道具文本:添加文本("#S/共鸣效果:")
										    self.道具文本2:添加文本("#S/共鸣效果:")
											self.道具文本:添加文本("#S/["..装备词条[1].类型.."] 效果提升25%(3/3)")
											self.道具文本2:添加文本("#S/["..装备词条[1].类型.."] 效果提升25%(3/3)")
									end
								end


						end






						if item.镶嵌四相 ~= nil then
							self.道具文本:添加文本(format("#S/四相 %s",item.镶嵌四相))
							self.道具文本2:添加文本(format("#S/四相 %s",item.镶嵌四相))
						end
						if item.开运孔数 ~= nil and item.开运孔数.当前 ~= nil and item.开运孔数.当前  ~= 0 then
							self.道具文本:添加文本(format("#G/开运孔数：%s",item.开运孔数.当前 .."孔/"..item.开运孔数.上限 .."孔"))
							self.道具文本3:添加文本(format("#G/开运孔数：%s",item.开运孔数.当前 .."孔/"..item.开运孔数.上限 .."孔"))
						end
						if item.星位~=nil then
							self.道具文本3:添加文本(format("#Y/符石属性:"))
			         		for n=1,5 do
			         			if item.星位[n]~=nil then
									local  组合语句="#G符石："
						            for k,v in pairs(item.星位[n].符石属性) do
						                组合语句=组合语句..k.." +"..v.." "
						            end
									self.道具文本:添加文本(组合语句)
									self.道具文本3:添加文本(组合语句)
								end
							end
					  	end
					  	if item.星位组~=nil then
				  		 	if item.星位~=nil and item.星位[6] ~= nil then
					            local 临时属性 = ""
					            for k,v in pairs(item.星位[6].符石属性) do
					                临时属性 = k.." +"..v
					            end
					            self.道具文本:添加文本("#G/星位: "..临时属性)
					            self.道具文本3:添加文本("#G/星位: "..临时属性)
					            if item.星位[6].相互~=nil then
						            local 临时属性 = ""
						            for k,v in pairs(item.星位[6].相互) do
						                临时属性 = k.." +"..v
						            end
						            self.道具文本:添加文本("#G/星相互合: "..临时属性)
						            self.道具文本3:添加文本("#G/星相互合: "..临时属性)
						        end
					        else
					            self.道具文本:添加文本("#G/星位: 已开")
					            self.道具文本3:添加文本("#G/星位: 已开")
					        end
					  	end
					  	if item.星位~=nil and item.星位.组合~=nil then
							self.道具文本:添加文本(format("#X/符石组合： %s",item.星位.组合))
							self.道具文本:添加文本(format("#X/门派条件： %s",item.星位.门派 or "无"))
							self.道具文本:添加文本(format("#X/部位条件： %s",取符石部位(item.星位.部位)))
							self.道具文本:添加文本(format("#X/%s",取符石组合说明(item.星位.组合,item.星位.组合等级)))
							self.道具文本3:添加文本(format("#X/符石组合： %s",item.星位.组合))
							self.道具文本3:添加文本(format("#X/门派条件： %s",item.星位.门派 or "无"))
							self.道具文本3:添加文本(format("#X/部位条件： %s",取符石部位(item.星位.部位)))
							self.道具文本3:添加文本(format("#X/%s",取符石组合说明(item.星位.组合,item.星位.组合等级)))
						end
						if item.专用 ~= nil then
							self.道具文本:添加文本(format("#Y/玩家%s专用",item.专用))
							self.道具文本2:添加文本(format("#Y/玩家%s专用",item.专用))
						end

						if item.制造者 ~= nil then
							self.道具文本:添加文本(format("#W/制造者：%s",item.制造者))
							self.道具文本2:添加文本(format("#W/制造者：%s",item.制造者))
						end
						if item.限时 ~= nil then
							self.道具文本:添加文本(format("#S/有效期至：%s",os.date("%Y-%m-%d %H:%M:%S",item.限时)))
							self.道具文本2:添加文本(format("#S/有效期至：%s",os.date("%Y-%m-%d %H:%M:%S",item.限时)))

						end
						if item.熔炼属性 ~= nil then
							self.道具文本:添加文本(format("#Y/熔炼效果："))
							self.道具文本3:添加文本(format("#Y/熔炼效果："))
							if item.熔炼属性[4] ~= nil then
								self.道具文本:添加文本(format("#F/%s%s%s %s%s%s",item.熔炼属性[3][3],math.abs(item.熔炼属性[3][2]),item.熔炼属性[3][1],item.熔炼属性[4][3],math.abs(item.熔炼属性[4][2]),item.熔炼属性[4][1]))
								self.道具文本:添加文本(format("#F/%s%s%s %s%s%s",item.熔炼属性[1][3],math.abs(item.熔炼属性[1][2]),item.熔炼属性[1][1],item.熔炼属性[2][3],math.abs(item.熔炼属性[2][2]),item.熔炼属性[2][1]))
								self.道具文本3:添加文本(format("#F/%s%s%s %s%s%s",item.熔炼属性[3][3],math.abs(item.熔炼属性[3][2]),item.熔炼属性[3][1],item.熔炼属性[4][3],math.abs(item.熔炼属性[4][2]),item.熔炼属性[4][1]))
								self.道具文本3:添加文本(format("#F/%s%s%s %s%s%s",item.熔炼属性[1][3],math.abs(item.熔炼属性[1][2]),item.熔炼属性[1][1],item.熔炼属性[2][3],math.abs(item.熔炼属性[2][2]),item.熔炼属性[2][1]))
							elseif item.熔炼属性[3] ~= nil then
								self.道具文本:添加文本(format("#F/%s%s%s %s%s%s",item.熔炼属性[3][3],math.abs(item.熔炼属性[3][2]),item.熔炼属性[3][1],item.熔炼属性[1][3],math.abs(item.熔炼属性[1][2]),item.熔炼属性[1][1]))
								self.道具文本:添加文本(format("#F/%s%s%s",item.熔炼属性[2][3],math.abs(item.熔炼属性[2][2]),item.熔炼属性[2][1]))
								self.道具文本3:添加文本(format("#F/%s%s%s %s%s%s",item.熔炼属性[3][3],math.abs(item.熔炼属性[3][2]),item.熔炼属性[3][1],item.熔炼属性[1][3],math.abs(item.熔炼属性[1][2]),item.熔炼属性[1][1]))
								self.道具文本3:添加文本(format("#F/%s%s%s",item.熔炼属性[2][3],math.abs(item.熔炼属性[2][2]),item.熔炼属性[2][1]))
							elseif item.熔炼属性[2] ~= nil then
								self.道具文本:添加文本(format("#F/%s%s%s %s%s%s",item.熔炼属性[1][3],math.abs(item.熔炼属性[1][2]),item.熔炼属性[1][1],item.熔炼属性[2][3],math.abs(item.熔炼属性[2][2]),item.熔炼属性[2][1]))
								self.道具文本3:添加文本(format("#F/%s%s%s %s%s%s",item.熔炼属性[1][3],math.abs(item.熔炼属性[1][2]),item.熔炼属性[1][1],item.熔炼属性[2][3],math.abs(item.熔炼属性[2][2]),item.熔炼属性[2][1]))
							else
								self.道具文本:添加文本(format("#F/%s%s%s",item.熔炼属性[1][3],math.abs(item.熔炼属性[1][2]),item.熔炼属性[1][1]))
								self.道具文本3:添加文本(format("#F/%s%s%s",item.熔炼属性[1][3],math.abs(item.熔炼属性[1][2]),item.熔炼属性[1][1]))
							end
						end
						if item.幻化特性 ~= nil then
			     			self.道具文本:添加文本("#Y特性："..item.幻化特性.名称.."+"..item.幻化特性.数额.."%")
			     			self.道具文本2:添加文本("#Y特性："..item.幻化特性.名称.."+"..item.幻化特性.数额.."%")
			     		end
					else
						   if item.分类 == 3 then
								self.道具文本:添加文本("#W/【装备条件】等级"..item.级别限制)
								self.道具文本1:添加文本("#W/【装备条件】等级"..item.级别限制)
								if item.角色限制[2] == nil then
									self.道具文本:添加文本("#W/【装备角色】"..item.角色限制[1])
									self.道具文本1:添加文本("#W/【装备角色】"..item.角色限制[1])
								elseif item.角色限制[3] == nil then
										self.道具文本:添加文本("#W/【装备角色】"..item.角色限制[1].."、"..item.角色限制[2])
										self.道具文本1:添加文本("#W/【装备角色】"..item.角色限制[1].."、"..item.角色限制[2])
								else
									self.道具文本:添加文本("#W/【装备角色】"..item.角色限制[1].."、"..item.角色限制[2].."、"..item.角色限制[3])
									self.道具文本1:添加文本("#W/【装备角色】"..item.角色限制[1].."、"..item.角色限制[2].."、"..item.角色限制[3])
								end

							elseif item.分类 == 1 or item.分类 == 4 then
								self.道具文本:添加文本("#W/【装备角色】"..item.性别限制)
								self.道具文本1:添加文本("#W/【装备角色】"..item.性别限制)
							elseif item.分类 > 6 then
								self.道具文本:添加文本("#W/【角色限制】召唤兽")
								self.道具文本1:添加文本("#W/【角色限制】召唤兽")
							else
								self.道具文本:添加文本("#W/【角色限制】无角色限制")
								self.道具文本1:添加文本("#W/【角色限制】无角色限制")
							end
							if jd == nil  then
								self.道具文本:添加文本("#Y/等级 "..item.级别限制)
								self.道具文本:添加文本("#G/未鉴定物品")
							end
					end
			end
	elseif zls == 3 then
		if item.分类 == 1 then
		  	if item.附带技能==nil then
             	item.附带技能="购买后随机生成"
		  	end
			self.道具文本:添加文本("#Y/所带技能: "..item.附带技能)
		elseif item.分类 == 3 then
			if item.子类==0 then
			    if item.附带技能 == nil then
					self.道具文本:添加文本("#Y/随机生成内丹")
				else
					self.道具文本:添加文本("#Y/所带内丹技能:"..item.附带技能)
					self.道具文本:添加文本(self:取内丹介绍(item.附带技能))
			    end
			else
				self.道具文本:添加文本("#Y/等级 "..item.级别限制)
			end
	   	elseif item.分类 == 10 then
		   self.道具文本:添加文本("#Y/种类 "..item.种类..",等级 "..item.级别限制)
	   	elseif item.分类 == 11 then
		   self.道具文本:添加文本("#Y/等级 "..item.级别限制..",灵气 "..item.灵气)
		end
    elseif zls == 4 then
    	if item.名称 == "神兵图鉴" then
    		self.道具文本:添加文本("#W/【功效】 使用可以鉴定等级≤图鉴等级的衣服和武器")
    		self.道具文本:添加文本(format("#Y/等级: %d",item.子类))
    	elseif item.名称 == "灵宝图鉴" then
    		self.道具文本:添加文本("#W/【功效】 使用可以鉴定等级≤图鉴等级的头盔、腰带、饰品和鞋子")
    		self.道具文本:添加文本(format("#Y/等级: %d",item.子类))
    	elseif item.名称 == "灵饰图鉴" then
    		self.道具文本:添加文本("#W/【功效】 使用可以鉴定等级≤图鉴等级的灵饰")
    		self.道具文本:添加文本(format("#Y/等级: %d",item.子类))
    	end
    	if item.名称 == "附魔宝珠" or item.名称 == "超级附魔宝珠" then

    		self.道具文本:添加文本(format("#Y/等级: %s",item.级别限制))

    	end
	elseif zls == 5 then
		if item.分类 == 1 then
			local it = tp:取武器子类(item.特效)
			self.道具文本:添加文本("#Y/种类 "..it..", 等级 "..item.子类)
		elseif item.分类 == 2 or item.分类 == 21 then
		  if item.名称=="元灵晶石" and item.子类==nil then
             self.道具文本:添加文本("#Y/购买后随机生成元灵晶石")
          else
			 self.道具文本:添加文本(format("#Y/等级 %d",item.子类))
          end
        elseif item.名称=="点化石" then
			if item.附带技能==nil then
			   item.附带技能="购买后随机生成"
			end
			self.道具文本:添加文本("#Y/所带技能: "..item.附带技能)
		elseif item.名称=="精魄灵石" then
			if  item.级别限制 then
				local 显示属性 = ""
				if item.子类==1 then
					self.道具文本:添加文本("#W/【镶嵌装备】项圈")
					  if item.属性 =="伤害" then
					  	 self.道具文本:添加文本("#Y/等级:"..item.级别限制..",增加10点伤害")
					  else
					  	 self.道具文本:添加文本("#Y/等级:"..item.级别限制..",增加4点灵力")
					  end
					elseif item.子类==2 then
						  self.道具文本:添加文本("#W/【镶嵌装备】护腕")
						  self.道具文本:添加文本("#Y/等级:"..item.级别限制..",增加6点速度")
					else
						self.道具文本:添加文本("#W/【镶嵌装备】铠甲")
						 if item.属性 =="气血" then
						  	self.道具文本:添加文本("#Y/等级:"..item.级别限制..",增加30点气血")
						  else
						  	 self.道具文本:添加文本("#Y/等级:"..item.级别限制..",增加8点防御")
						  end
					end
           else
               self.道具文本:添加文本("#Y/（购买后随机生成。)")
           end

		elseif item.分类 == 3 then
			self.道具文本:添加文本("#Y/功效 用于分解装备获得宝石")
		elseif item.分类 == 4 then
			--self.道具文本:添加文本(format("#Y/功效 %s",item.特效))
		elseif item.分类 == 6 then
		   	if item.名称~="星辉石" and item.名称 ~= "钟灵石" and item.名称 ~= "钨金" then
			  self.道具文本:添加文本(format("#W/【镶嵌装备】%s",item.角色限制))
			  self.道具文本:添加文本(format("#W/【镶嵌效果】%s",item.特效))
			elseif item.名称=="钨金" then
			self.道具文本:添加文本(format("#W/【镶嵌装备】%s","熔炼装备属性"))
			self.道具文本:添加文本(format("#W/【镶嵌效果】%s","增加12维属性"))
			elseif item.名称=="钟灵石" then


			  self.道具文本:添加文本(format("#Y/附加特性：%s(等级%s)",item.附加特性,item.级别限制))
               if item.附加特性=="气血方刚" then
				  	self.道具文本:添加文本("#S/所有部位:增加气血上限")
				  elseif item.附加特性=="通真达灵" then
				  	self.道具文本:添加文本("#S/所有部位:增加法术防御")
				  elseif item.附加特性=="心无旁骛" then
				  	self.道具文本:添加文本("#S/所有部位:增加抵抗封印等级")
				  elseif item.附加特性=="健步如飞" then
				  	self.道具文本:添加文本("#S/所有部位:增加速度")
				  elseif item.附加特性=="回春之术" then
				  	self.道具文本:添加文本("#S/所有部位:增加治疗能力")
				  elseif item.附加特性=="风雨不动" then
				  	self.道具文本:添加文本("#S/所有部位:增加抗法术暴击等级")
				  elseif item.附加特性=="固若金汤" then
				  	self.道具文本:添加文本("#S/所有部位:增加抗物理暴击等级")
				  elseif item.附加特性=="气壮山河" then
				  	self.道具文本:添加文本("#S/所有部位:增加气血回复效果")
				  elseif item.附加特性=="锐不可当" then
				  	self.道具文本:添加文本("#S/所有部位:增加固定伤害")
				  elseif item.附加特性=="心源" then
				   self.道具文本:添加文本("#S/所有部位:增加物理防御")
				  end




			end
			if  item.名称~="钟灵石" then
				self.道具文本:添加文本(format("#Y/等级 %s",item.级别限制))
			end
		elseif item.分类 == 7 then
			self.道具文本:添加文本("#Y/购买后随机生成"..item.名称)
		elseif item.分类 == 8 then
			self.道具文本:添加文本("#Y/购买后随机生成"..item.名称)
     	elseif item.分类 == 20 then
         	if item.特效~=nil and item.子类~=nil then
	          	self.道具文本:添加文本("#Y/种类 "..item.特效..", 等级 "..item.子类)
	        else
	           	self.道具文本:添加文本("#Y/购买后随机生成灵饰指南书")
	       	end
		end
	elseif zls == 7 then
		if item.分类 == 1 then
			if item.名称=="藏宝图" then
                self.道具文本:添加文本("#Y/【类型】普通藏宝图")
            elseif item.名称=="高级藏宝图" then
                 self.道具文本:添加文本("#Y/【类型】高级藏宝图")
            elseif item.名称=="玲珑宝图" then
                 self.道具文本:添加文本("#Y/【类型】玲珑宝图")
			end
			self.道具文本:添加文本(format("#Y/【坐标】#G/%s(%s,%s)",item.地图名称,item.x,item.y))
			--self.道具文本:添加文本(format("#Y/坐标 X：%d Y：%d",item.气血,item.魔法))
		end
	elseif zls == 9 then
		if item.名称 == "清灵净瓶" then
		    self.道具文本:添加文本("#Y/使用后随机开出初级,中级,高级清灵仙露")
		end
		if item.分类 == 1 and item.名称 ~= "魔兽残卷" then
			self.道具文本:添加文本("#Y/右键使用")
		end
	elseif zls == 10 then
		if item.分类 == 4 then
			self.道具文本:添加文本("#Y/右键使用")
		elseif item.分类 == 3 then
			self.道具文本:添加文本("#Y/右键使用可增加150点的体力和活力")
		end
	elseif zls == 11 then
		--print(item.分类)
     	if item.分类==1 then
	         if item.地图==nil then
	            self.道具文本:添加文本("#Y/右击后定标")
	          else
	           local map = 取地图名称(item.地图)
	           self.道具文本:添加文本(format("#Y/%s(%d,%d)",map,item.x,item.y))
		       self.道具文本:添加文本(format("#Y/还可使用%s次",item.次数))
	         end
        elseif item.分类==2 then
         	self.道具文本:添加文本(format("#Y/场景:%s,还能使用%s次",取地图名称(item.地图),item.次数))
        end

	elseif zls == 12 then
		self.道具文本:添加文本(format("#Y/变化对象：%s",item.子类))
	elseif zls == 13 then
		self.道具文本:添加文本(format("#Y/阵型:%s",item.子类))
	elseif zls == 21  then
		if item.特效 then
			self.道具文本:添加文本(format("#Y/说明：%s",item.特效))
	    end
	    if item.附带词条 then

	    	if 境界属性[item.附带词条] then
	    		self.道具文本:添加文本("#Y/所属属性:"..境界属性[item.附带词条].类型)
	    		self.道具文本:添加文本("#Y/附魔部位:"..境界属性[item.附带词条].分类)
	    		if item.数额 and item.数额+0>0 then
			        self.道具文本:添加文本("#G/类型:"..item.附带词条.."  数值:"..item.数额)
			    else
			      	self.道具文本:添加文本("#G/类型:"..item.附带词条.."  数值:"..境界属性[item.附带词条].神话)
			    end
			elseif 神话属性[item.附带词条] then
					self.道具文本:添加文本("#Y/限制门派:"..神话属性[item.附带词条].限制)
					self.道具文本:添加文本("#Y/附魔部位:"..神话属性[item.附带词条].部位)
					self.道具文本:添加文本("#G/神话类型:"..item.附带词条)
	        else
	            self.道具文本:添加文本("#Y/该物品数据错误,请联系管理员")

	        end
	    end
	elseif zls == 30 then
		self.道具文本:添加文本(format("#W/卡片类型：%s",item.造型))
		self.道具文本:添加文本(format("#W/技能要求：%s",数字转大写(item.等级).."级变化之术"))
		local 变身卡技能=item.技能
		local 货币加成=item.货币加成
		local 经验加成=item.经验加成
		local 扩展属性=item.多属性
		-- 安全检查扩展属性是否存在
		--[[if 扩展属性 and #扩展属性 > 0 then
			print("扩展属性存在，第一个属性:", 扩展属性[1].类型, 扩展属性[1].加成)
		else
			print("扩展属性为空或不存在")
		end]]--
		if 变身卡技能=="" then 变身卡技能="无" end
		self.道具文本:添加文本(format("#S/【附加技能】%s",变身卡技能))
		local 组合语句=""
		if item.属性==0 then
          组合语句="无"
        elseif item.单独==1 then
        	if item.正负==1 then
             组合语句=item.类型.."+"..item.属性
            else
             组合语句=item.类型.."-"..item.属性
        		end
       else
         if item.正负==1 then
             组合语句=item.类型.."+"..item.属性.."%"
            else
             组合语句=item.类型.."-"..item.属性.."%"
        		end
			end
		self.道具文本:添加文本(format("#G/【属性影响】%s",组合语句))
		
		-- 显示扩展属性信息
		-- 显示货币加成
		local 货币加成语句 = "无"
		if 货币加成 and #货币加成 > 0 then
			货币加成语句 = ""
			for i, 加成信息 in ipairs(货币加成) do
				if i > 1 then 货币加成语句 = 货币加成语句 .. " " end
				local 加成描述 = ""
				if 加成信息.正负 == 1 then
					加成描述 = 加成信息.类型 .. "+" .. 加成信息.加成
				elseif 加成信息.正负 == 2 then
					加成描述 = 加成信息.类型 .. "+" .. 加成信息.加成 .. "%"
				elseif 加成信息.正负 == 3 then
					加成描述 = 加成信息.类型 .. "x" .. 加成信息.加成
				end
				货币加成语句 = 货币加成语句 .. 加成描述
			end
		end
		self.道具文本:添加文本(format("#G/【货币加成】%s",货币加成语句))
		
		-- 显示经验加成
		local 经验加成语句 = "无"
		if 经验加成 and #经验加成 > 0 then
			经验加成语句 = ""
			for i, 加成信息 in ipairs(经验加成) do
				if i > 1 then 经验加成语句 = 经验加成语句 .. " " end
				local 加成描述 = ""
				if 加成信息.正负 == 1 then
					加成描述 = 加成信息.类型 .. "+" .. 加成信息.加成
				elseif 加成信息.正负 == 2 then
					加成描述 = 加成信息.类型 .. "+" .. 加成信息.加成 .. "%"
				elseif 加成信息.正负 == 3 then
					加成描述 = 加成信息.类型 .. "x" .. 加成信息.加成
				end
				经验加成语句 = 经验加成语句 .. 加成描述
			end
		end
		self.道具文本:添加文本(format("#G/【经验加成】%s",经验加成语句))
		
		-- 显示多属性加成
		local 多属性语句 = "无"
		if 扩展属性 and type(扩展属性) == "table" and #扩展属性 > 0 then
			多属性语句 = ""
			for i, 属性信息 in ipairs(扩展属性) do
				if 属性信息 and 属性信息.类型 and 属性信息.加成 then
					if i > 1 then 多属性语句 = 多属性语句 .. " " end
					local 属性描述 = ""
					if 属性信息.正负 == 1 then
						属性描述 = 属性信息.类型 .. "+" .. 属性信息.加成
					elseif 属性信息.正负 == 2 then
						属性描述 = 属性信息.类型 .. "+" .. 属性信息.加成 .. "%"
					elseif 属性信息.正负 == 3 then
						属性描述 = 属性信息.类型 .. "x" .. 属性信息.加成
					end
					多属性语句 = 多属性语句 .. 属性描述
				end
			end
		end
		self.道具文本:添加文本(format("#G/【扩展属性】%s",多属性语句))
		
		self.道具文本:添加文本(format("#Y/等级：%s  剩余使用次数：%s",item.等级,item.次数))
		self.道具文本:添加文本(format("#Y/持续时间：%s分钟","15分钟*(1+变化之术等级)"))
	-- elseif zls == 55 then --
	-- 	local fssx = qwp(item.名称)
	-- 	self.属性1 = fssx[18]
	-- 	self.属性值1 = fssx[19]
	-- 	self.属性2 = fssx[21]
	-- 	self.属性值2 = fssx[22]
	-- 	self.等级=fssx[16]
	-- 	self.颜色=fssx[20]
	-- 	if item.耐久度 ~=nil then
	-- 	    self.耐久=math.floor(item.耐久度)
	-- 	end
	-- 	self.道具文本:添加文本("#W/【用途】 可镶嵌在有开运孔数的装备上")
	-- 	self.道具文本:添加文本(format("#Y/等级：%s  %s",self.等级,self.颜色))
	-- 	if fssx[16] == 1 or fssx[16] == 2 then
	-- 		self.道具文本:添加文本(format("#Y/"..self.属性1.." +%s",self.属性值1))
	-- 	else
	-- 		self.道具文本:添加文本(format("#Y/"..self.属性1.." +%s "..self.属性2.." +%s ",self.属性值1,self.属性值2))
	-- 	end
	-- 	if item.耐久度~=nil then
 --      		self.道具文本:添加文本(format("#Y/耐久度 "..item.耐久度))\\

	-- 	end


	elseif zls == 150 then --最初西游会员卡
        	if item.分类 == 1 and item.子类 == 10 and  string.find(item.名称,"会员卡")~=nil then
        		if item.限时 ~= nil then
					self.道具文本:添加文本(format("#S/有效期至：%s",os.date("%Y-%m-%d %H:%M:%S",item.限时)))
					self.道具文本2:添加文本(format("#S/有效期至：%s",os.date("%Y-%m-%d %H:%M:%S",item.限时)))
				end

			if item.专用 ~= nil then
				self.道具文本:添加文本(format("#S/不可交易"))
				self.道具文本:添加文本(format("#Y/玩家ID:#R/ %s #Y/专用",item.专用))

			end
		end
	elseif zls == 151 then
		if item.名称=="房屋地契" then
			self.道具文本:添加文本(format("#Y/房屋规模: %s ",item.房屋规模))
			self.道具文本:添加文本(format("#G/房屋样式: %s ",item.房屋样式))
			self.道具文本:添加文本(format("#G/庭院样式: %s ",item.庭院规模))
		elseif item.名称=="设计图" then
			self.道具文本:添加文本("#Y/"..item.类型.."#Y/,等级#Y/ "..item.等级)
		elseif item.名称=="归墟之证" then
				if item.等级 and item.类型 then
	                local 星级=""
	                for i = 1, tonumber(item.等级) do
	                     星级=星级.."★"
	                end
	                self.道具文本:添加文本("#Y类型:"..item.类型)
					self.道具文本:添加文本("#Y难度:"..星级)
				end

		end
	elseif zls == 889 then
		if item.名称=="一级未激活符石" or item.名称=="二级未激活符石" or item.名称=="三级未激活符石" then
			self.道具文本:添加文本("【激活方式】鼠标右键点击使用激活")
			self.道具文本:添加文本("#Y/当前状态:#R/未激活")
			if item.子类~=nil and item.颜色~=nil then
				self.道具文本:添加文本("#Y/等级 "..item.子类.."  "..item.颜色)
			end
			if  item.符石属性~=nil then
			   local 组合语句="#Y/"
				for k,v in pairs(item.符石属性) do
					组合语句 = 组合语句..k.." +"..v.."  "
				end
				self.道具文本:添加文本(组合语句)
			end
		elseif item.名称=="未激活的星石" then
			self.道具文本:添加文本("#Y/镶嵌部位: "..取星石部位(item.子类))
			self.道具文本:添加文本("#R/激活后为专用，无法转移给他人。")
			self.道具文本:添加文本("【激活方式】鼠标右键点击使用激活")
			self.道具文本:添加文本("#Y/当前状态:#R/未激活")
			self.道具文本:添加文本("#Y/等级 4")
			self.道具文本:添加文本("#G/镶嵌在星位后，激活属性")
		elseif item.分类 == 91 and item.类型==nil then
			self.道具文本:添加文本("#Y/等级 4")
			local ys = 取星位颜色(item.子类)
			self.道具文本:添加文本("#Y/正面颜色: "..ys[1].." 反面颜色: "..ys[2])
			self.道具文本:添加文本("#Y/镶嵌部位: "..取星石部位(item.子类))
			self.道具文本:添加文本("#G/镶嵌于开运装备的星位，穿戴整套镶有星石的装备可触发符石套装效果")
			self.道具文本:添加文本("#Y/耐久 150")
		elseif item.分类 == 91 and item.类型~=nil then
			self.道具文本:添加文本("#Y/等级 4")
			local ys = 取星位颜色(item.子类)
			self.道具文本:添加文本("#Y/颜色: "..ys[item.类型])
			self.道具文本:添加文本("#Y/镶嵌部位: "..取星石部位(item.子类))
			self.道具文本:添加文本("#G/镶嵌于开运装备的星位，左键点击翻转")
			self.道具文本:添加文本("#G/星位: "..item.sx)
			self.道具文本:添加文本("#Y/耐久 150")
		elseif item.名称=="符石卷轴" then
			self.道具文本:添加文本("#w/【说明】需要加入此卷轴才可以合成三级符石，在合成过程中会被消耗。")
		else
			self.道具文本:添加文本("【用途】可镶嵌有开孔数的装备上")
			if item.不可交易 then
				self.道具文本:添加文本(format("#Y/不可交易"))
			end
			local 组合语句="#Y/"
			for k,v in pairs(item.符石属性) do
				组合语句 = 组合语句..k.." +"..v.."  "
			end
			self.道具文本:添加文本("#Y/等级 "..item.子类.."  "..item.颜色)
			self.道具文本:添加文本(组合语句)
			self.道具文本:添加文本("#Y/耐久 150")
		end
	elseif zls == 56 then
		self.道具文本:添加文本("#W/【激活方式】#Y鼠标右键点击使用激活")
	elseif zls == 101 then
		self.道具文本:添加文本("#W/【期限】#G效果持续一周")

		if item.类型=="嗜血" then
		self.道具文本:添加文本(format("#Y/以"..item.等级.."级的#Z"..item.类型.."#Y法术效果\n#G【体质】#Y强化一件#S项链"))
		elseif item.类型=="莲华妙法" then
		self.道具文本:添加文本(format("#Y/以"..item.等级.."级的#Z"..item.类型.."#Y法术效果\n#G【法伤】#Y强化一件#S项链"))
		elseif item.类型=="轻如鸿毛" then
		self.道具文本:添加文本(format("#Y/以"..item.等级.."级的#Z"..item.类型.."#Y法术效果\n#G【魔法】#Y强化一件#S武器"))
		elseif item.类型=="神木呓语" then
		self.道具文本:添加文本(format("#Y/以"..item.等级.."级的#Z"..item.类型.."#Y法术效果\n#G【魔法】#Y强化一件#S鞋子"))
		elseif item.类型=="拈花妙指" then
		self.道具文本:添加文本(format("#Y/以"..item.等级.."级的#Z"..item.类型.."#Y法术效果\n#G【速度】#Y强化一件#S鞋子"))
		elseif item.类型=="盘丝舞" then
		self.道具文本:添加文本(format("#Y/以"..item.等级.."级的#Z"..item.类型.."#Y法术效果\n#G【防御】#Y强化一件#S武器"))
		elseif item.类型=="一气化三清" then
		self.道具文本:添加文本(format("#Y/以"..item.等级.."级的#Z"..item.类型.."#Y法术效果\n#G【魔力】#Y强化一件#S衣服"))
		elseif item.类型=="浩然正气" then
		self.道具文本:添加文本(format("#Y/以"..item.等级.."级的#Z"..item.类型.."#Y法术效果\n#G【法防】#Y强化一件#S衣服"))
		elseif item.类型=="龙附" then
		self.道具文本:添加文本(format("#Y/以"..item.等级.."级的#Z"..item.类型.."#Y法术效果\n#G【伤害】#Y强化一件#S武器"))
		elseif item.类型=="穿云破空" then
		self.道具文本:添加文本(format("#Y/以"..item.等级.."级的#Z"..item.类型.."#Y法术效果\n#G【伤害】#Y强化一件#S腰带"))
		elseif item.类型=="神兵护法" then
		self.道具文本:添加文本(format("#Y/以"..item.等级.."级的#Z"..item.类型.."#Y法术效果\n#G【命中】#Y强化一件#S帽子"))
		elseif item.类型=="魔王护持" then
		self.道具文本:添加文本(format("#Y/以"..item.等级.."级的#Z"..item.类型.."#Y法术效果\n#G【气血】#Y强化一件#S武器"))
		elseif item.类型=="元阳护体" then
		self.道具文本:添加文本(format("#Y/以"..item.等级.."级的#Z"..item.类型.."#Y法术效果\n#G【气血】#Y强化一件#S武器"))
		elseif item.类型=="神力无穷" then
		self.道具文本:添加文本(format("#Y/以"..item.等级.."级的#Z"..item.类型.."#Y法术效果\n#G【愤怒】#Y强化一件#S腰带"))
		elseif item.类型=="尸气漫天" then
		self.道具文本:添加文本(format("#Y/以"..item.等级.."级的#Z"..item.类型.."#Y法术效果\n#G【耐力】#Y强化一件#S帽子"))
		end
	elseif zls == "召唤兽道具" then

		if item.名称 == "初级清灵仙露" or item.名称 == "中级清灵仙露" or item.名称 == "高级清灵仙露"  or item.名称 == "超级清灵仙露" or item.名称 == "终级清灵仙露" then
		    self.道具文本:添加文本("#Y/灵气: "..item.灵气)
		end
	elseif zls == 1000 then
	--	self.道具文本:添加文本(format("【法宝等级】%s级法宝",item.分类))
		self.道具文本:添加文本(string.format("#G/%d#Y/级法宝,修炼境界：\n#Y第#G/%d#Y/层 %s",item.分类,item.气血,取境界(item.气血,item.分类)))
		self.道具文本:添加文本(string.format("#Y/灵气:#G/%d #Y/五行:#G/%s",item.魔法,item.五行))
		local xz=""
		if item.名称=="月光宝盒" and  item.地图~=nil then
             xz=format("#Y传送至%s(%s,%s),",取地图名称(item.地图),item.x,item.y)
			 end
		if item.使用 == 0 then
			xz =xz.."#Z佩戴战斗中发挥效用"
	   	elseif item.使用 ==2 then
			xz = xz.."无需佩戴,非战斗中选择使用"
		else
		    xz = xz..format("#Z无需佩戴，在战斗中选择使用\n#Y使用回合限制：#G/%d#Y/",item.角色限制)
		end
		self.道具文本:添加文本(format("#Y/%s",xz))
		self.道具文本:添加文本(format("#Y/使用装备限制：\n#G/人物等级≥%d",item.特技))
      elseif zls == 1005 then   ----------灵宝

		local 消耗 = ""
		if item.使用 == 1 then
			消耗="1/3/7"
		elseif item.使用 == 2 then
			消耗="1"
		elseif item.使用 == 3 then
			消耗="全部"
		end
		self.道具文本:添加文本("#W/【使用条件】")
		self.道具文本:添加文本(format("#G/%s门派专用，消耗#G/%s#W点灵元",item.特技,消耗))
		self.道具文本:添加文本("#R/【战斗效果】")
		self.道具文本:添加文本(format("#F/%s",item.效果))
		--self.道具文本:添加文本(format("#Y/灵气：#G/%s",item.魔法))
		--self.道具文本:添加文本(format("#Y/修炼境界：第#G/%d#Y/层 %s",item.气血,取境界(item.气血,item.分类)))
	elseif zls == 1003 then

	elseif zls == 2000 then
		self.道具文本:添加文本("【基本伤害】"..item.分类)
		self.道具文本:添加文本(" #Y/耐久度 "..math.floor(item.耐久))
	elseif zls == "坐骑饰品" then
		self.道具文本:添加文本(format("【类    型】 %s",item.总类))
		self.道具文本:添加文本(format("【装备坐骑】 %s",item.子类))
	end
	h = self.道具文本.显示表.高度+10
	if h < 130 then
		h = 130
	end
	if x + w >= 全局游戏宽度-20 then
		x = 全局游戏宽度-20 - w
	end
	if h >380 and zls == 2 and item.分类 <= 6 then
		w = 400
		local lsgd = 0
		if self.道具文本2.显示表.高度 > self.道具文本3.显示表.高度 then
		 	lsgd = self.道具文本2.显示表.高度
		else
		 	lsgd = self.道具文本3.显示表.高度
		end
		h = 110+lsgd + 35
	end
	if y + h > 全局游戏高度-20 then
		y = 全局游戏高度 - h - 20
	end
	if w == 400  then
		local ht = tp.资源:载入("登陆资源.wdf","网易WDF动画",0x381EAF65)
		ht:置区域(0,0,370,2)
		self.寄存内容 = {}
		self.寄存内容[1] = {}
		self.寄存内容[1].内容 = item.大模型
		self.寄存内容[1].x = x+43
		self.寄存内容[1].y = y+25
		self.寄存内容[2] = {}
		self.寄存内容[2].内容 = ht
		self.寄存内容[2].x = x+23
		self.寄存内容[2].y = y+156
		self.寄存内容[3] = {}
		self.寄存内容[3].内容 = self.道具文本1
		self.寄存内容[3].x = x + 210
		self.寄存内容[3].y = y + 20
		self.寄存内容[4] = {}
		self.寄存内容[4].内容 = self.道具文本2
		self.寄存内容[4].x = x + 10
		self.寄存内容[4].y = y + 150
		self.寄存内容[5] = {}
		self.寄存内容[5].内容 = self.道具文本3
		self.寄存内容[5].x = x + 210
		self.寄存内容[5].y = y + 150
		self.寄存内容[6] = {}
		self.寄存内容[6].文字 = tp.字体表.道具字体
		self.寄存内容[6].颜色 = -256
		self.寄存内容[6].文本 = item.名称
		self.寄存内容[6].坐标 = {[1]=x+210,[2] =y+4}
	else
		self.寄存内容 = {}
		self.寄存内容[1] = {}
		self.寄存内容[1].内容 = item.大模型
		self.寄存内容[1].x = x+3
		self.寄存内容[1].y = y+5
		self.寄存内容[2] = {}
		self.寄存内容[2].内容 = self.道具文本
		self.寄存内容[2].x = x + 128
		self.寄存内容[2].y = y + 15
		self.寄存内容[3] = {}
		self.寄存内容[3].文字 = tp.字体表.道具字体
		self.寄存内容[3].颜色 = -256
		self.寄存内容[3].文本 = item.名称
		self.寄存内容[3].坐标 = {[1]=x+128.8,[2] =y+4}
	end

	if item.装备境界  and item.装备境界.品质~="普通" then
		if item.装备境界.品质 =="优秀" then
			self.寄存内容.装备底图=tp._自适应.创建(120,1,1,1,3,9)
		elseif item.装备境界.品质 =="稀有" then
					self.寄存内容.装备底图=tp._自适应.创建(121,1,1,1,3,9)
		elseif item.装备境界.品质 =="传说" then
				self.寄存内容.装备底图=tp._自适应.创建(122,1,1,1,3,9)
		elseif item.装备境界.品质 =="神话" then
				self.寄存内容.装备底图=tp._自适应.创建(123,1,1,1,3,9)
		end
	end


	self.寄存内容.提示坐标 = {[1]=x,[2]=y,[3]=w,[4]=h}
	self.寄存内容.开启提示 = true
end

function 系统类_提示框:取内丹介绍(a)
	if a =="迅敏" then
		return "#Y/拥有此技能会提高自己的伤害力与速度。"
	elseif a =="狂怒" then
		return "#Y/在此狂乱状态下必杀的伤害更高，但是受到水、土系法术攻击时承受额外的伤害。"
	elseif a =="阴伤" then
		return "#Y/疯狂攻击的第二次伤害更高，但是受到火、雷系法术攻击时承受额外的伤害。"
	elseif a =="静岳" then
	   return "#Y/拥有此技能会提高自己的灵力与气血。"
	elseif a =="擅咒" then
	   return "#Y/你对目标的法术伤害得到提升。"
	elseif a =="灵身" then
	   return "#Y/法术带来的暴发性更强烈，承受额外50%物理伤害"
	elseif a =="矫健" then
	   return "#Y/拥有此技能会提高自身的气血与速度。"
	elseif a =="深思" then
	   return "#Y/高冥思的效果得到加强。"
	elseif a =="坚甲" then
	   return "#Y/拥有此技能后对敌人造成的反震伤害得到加强。"
	elseif a =="钢化" then
	   return "#Y/带有高级防御、防御技能时的防御值增加，但是所带来的代价是受到法术伤害额外打击。"
	elseif a =="慧心" then
	   return "#Y/只要集中精神，抵御封印的能力就会加强。"
	elseif a =="撞击" then
	   return "#Y/物理攻击时增加一定的伤害结果，效果与体质点成正比"
	elseif a =="无畏" then
	   return "#Y/拥有此技能能够更好的突破反震、高级反震技能，对目标造成更大的物理伤害。"
	elseif a =="愤恨" then
	   return "#Y/拥有此技能能够更好的突破幸运、高级幸运技能，对目标造成更大的物理伤害。"
	elseif a =="淬毒" then
	   return "#Y/满淬毒汁的毒牙使对手更加胆寒。"
	elseif a =="狙刺" then
	   return "#Y/该召唤兽对第一目标造成的法术伤害更大。"
	elseif a =="连环" then
		return "#Y/拥有此技能时，召唤兽触发连击的几率增加。"
	elseif a =="圣洁" then
	    return "#Y/拥有此技能后，你的召唤兽使用法术攻击时驱鬼和高驱鬼效果得到提升。"
	elseif a =="灵光" then
	    return "#Y/法术的精修必然会为你带来更多好处。"
	elseif a =="神机步" then
	    return "#Y/入场时你总是活力无限，3回合内极大的增加你的躲避力。"
	elseif a =="腾挪劲" then
	    return "#Y/神奇的护盾，有一定几率能够将你所受的一部分物理伤害腾挪到另一个世界。"
	elseif a =="玄武躯" then
	    return "#Y/你放弃了伤害，得到的是气血的大幅度提升。"
	elseif a =="龙胄铠" then
	    return "#Y/你放弃了伤害，得到的是防御的大幅度提升。"
	elseif a =="玉砥柱" then
	    return "#Y/最尖锐的矛也遇到了一点麻烦。"
	elseif a =="碎甲刃" then
	    return "#Y/以千钧之力击碎目标的护甲，2回合内降低目标一定防御值，效果与自身力量点相关。"
	elseif a =="阴阳护" then
	     return "#Y/激发潜力，增加召唤兽的魔法值"
	elseif a =="凛冽气" then
	     return "#Y/激发潜力，增加召唤兽的敏捷"
	elseif a =="舍身击" then
	     return "#Y/提升召唤兽的力量,随召唤兽等级提升而增加"
	elseif a =="电魂闪" then
	     return "#Y/神奇的法术，总在不经意间给你惊喜，有可能将目标携带的增益状态驱散。"
	elseif a =="通灵法" then
	     return "#Y/敏锐的洞察力！能够找出目标法术防御的漏洞，可以扣除目标一定的法术防御。"
	elseif a =="双星暴" then
	     return "#Y/强大的法术攻击接踵而来，法术连击的威力更强大。"
	elseif a =="催心浪" then
	     return "#Y/虽然带有法术波动技能时法术力量无法控制，但是总会向更好的方向发展。"
	elseif a =="隐匿击" then
	     return "#Y/拥有隐身技能的召唤兽伤害值提高"
	elseif a =="生死决" then
	     return "#Y/提升召唤兽将自身防御的一部分转化为伤害力的几率，提升效果持续到本回合结束。"
    elseif a =="血债偿" then
	     return "#Y/本方不带本技能召唤兽每被击飞一次，提升一次拥有本技能召唤兽对目标造成的法术伤害，持续到战斗结束。提升效果最多叠加5次，且受召唤兽自身魔力点数影响，不能与鬼魂和高级鬼魂技能共存。"

	end

end





function 系统类_提示框:清空寄存()
	if #self.寄存内容 ~= 0 then
		self.寄存内容 = {}
	end
end
return 系统类_提示框