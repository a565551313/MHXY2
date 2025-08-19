--======================================================================--
--	☆ 作者：飞蛾扑火 QQ：1415559882
--======================================================================--
local 坐骑资料库 = class()
local 读取坐骑 = require("script/属性控制/坐骑")
local insert = table.insert
function 坐骑资料库:初始化() end

function 坐骑资料库:获取坐骑(id,模型,名称,类型,属性,等级,染色方案,技能组,资质组,成长,参战等级,属性表)
	local n = 读取坐骑()
	local mx = 模型 == "小毛头" or 模型 == "小丫丫"
	if mx then
		类型 = "孩子"
	end
	n:置新对象(模型,名称,类型,属性,等级,染色方案,技能组,资质组,成长,参战等级,属性表,id)
	if #玩家数据[id].角色.数据.坐骑列表 <= 6 then
		insert(玩家数据[id].角色.数据.坐骑列表, n)
	else
		常规提示(id,玩家数据[id].角色.数据.名称.."携带的坐骑已到上限无法再获得坐骑，请放生一只坐骑")
	end
end

function 坐骑资料库:增加坐骑(id,坐骑)
	if 坐骑==nil then return end
	local 坐骑物品 ={坐骑,nil}--"空"
	if 玩家数据[id].角色.数据.坐骑列表==nil  then
	    玩家数据[id].角色.数据.坐骑列表={}
	end
	insert(玩家数据[id].角色.数据.坐骑列表, 坐骑物品)
end

function 坐骑资料库:取坐骑库(人物)
	local zqsQQ = "宝贝葫芦"
	if 人物.种族 == "人" and 人物.模型 ~= "偃无师" then
		local zqsQ = 取随机数(1,2)
		if zqsQ==1 then
		    zqsQQ = "汗血宝马"
		else
			zqsQQ = "欢喜羊羊"
		end
	elseif 人物.种族 == "魔" and 人物.模型 ~= "鬼潇潇" then
		local zqsQ = 取随机数(1,2)
		if zqsQ==1 then
		    zqsQQ = "魔力斗兽"
		else
			zqsQQ = "披甲战狼"
		end
	elseif 人物.种族 == "仙" and 人物.模型 ~= "桃夭夭" then
		local zqsQ = 取随机数(1,2)
		if zqsQ==1 then
		   zqsQQ = "闲云野鹤"
		else
			zqsQQ = "云魅仙鹿"
		end
	end
	if 取随机数(1,2)==1 and 人物.模型 ~= "偃无师" and 人物.模型 ~= "鬼潇潇" and 人物.模型 ~= "桃夭夭" then
		zqsQQ = "神气小龟"
	end
	if 取随机数(1,2)==1 and (人物.模型 == "龙太子" or 人物.模型 == "骨精灵") then
		zqsQQ = "宝贝葫芦"
	end
	return zqsQQ
end

function 坐骑资料库:取坐骑库1(人物)
	local zqsQQ = "蓝色狐狸"
	if 人物.种族 == "人" or 人物.种族 == "魔" or 人物.种族 == "仙" then
	local zqsQ = 取随机数(1,26)
	if zqsQ==1 then
	zqsQQ = "黄金狮子"
	elseif zqsQ==2 then
	zqsQQ = "蓝色狐狸"
	elseif zqsQ==3 then
	zqsQQ = "七彩祥云"
	elseif zqsQ==4 then
	zqsQQ = "粉红火鸡"
	elseif zqsQ==5 then
	zqsQQ = "彩虹毛驴"
	elseif zqsQ==6 then
	zqsQQ = "粉嫩小猪"
	elseif zqsQ==7 then
	zqsQQ = "水晶芭蕉"
	elseif zqsQ==8 then
	zqsQQ = "深海狂鲨"
	elseif zqsQ==9 then
	zqsQQ = "雷霆黑豹"
	elseif zqsQ==10 then
	zqsQQ = "砖石小马"
	elseif zqsQ==11 then
	zqsQQ = "雷天红狮"
	elseif zqsQ==12 then
	zqsQQ = "通天金牛"
	elseif zqsQ==13 then
	zqsQQ = "神域孔雀"
	elseif zqsQ==14 then
	zqsQQ = "远古恐龙"
	elseif zqsQ==15 then
	zqsQQ = "神猫头鹰"
	elseif zqsQ==16 then
	zqsQQ = "鬼火南瓜"
	elseif zqsQ==17 then
	zqsQQ = "圣诞狂欢"
	elseif zqsQ==18 then
	zqsQQ = "神偷兔兔"
	elseif zqsQ==19 then
	zqsQQ = "国宝熊猫"
	elseif zqsQ==20 then
	zqsQQ = "繁星月亮"
	elseif zqsQ==21 then
	zqsQQ = "繁星珍珠"
	elseif zqsQ==22 then
	zqsQQ = "天南蝙蝠"
	elseif zqsQ==23 then
	zqsQQ = "飞天神鱼"
	elseif zqsQ==24 then
	zqsQQ = "飞天神象"
	elseif zqsQ==25 then
	zqsQQ = "飞天神虎"
	else
	zqsQQ = "九尾妖狐"
	end
  end
	return zqsQQ
end





function 坐骑资料库:取坐骑饰品(bb)
	if bb=="云魅仙鹿" then
	    return ""
	end
end

function 坐骑资料库:取坐骑(bb)
	local bbs = {}
	local 数量 = 取随机数(1,3)
	local 坐骑技能 = {}
	local ms = {"反震","吸血","反击","连击","飞行","感知","再生","冥思","慧根","必杀","幸运","神迹","招架","永恒","偷袭","毒","驱鬼","鬼魂术","魔之心","神佑复生","精神集中","法术连击","法术暴击","法术波动","土属性吸收","火属性吸收","水属性吸收"}
	for i=1,数量 do
		local 随机技能 = 取随机数(1,#ms)
	    table.insert(坐骑技能,ms[随机技能])
	    table.remove(ms,随机技能)
	end
	if bb == "宝贝葫芦" or bb == "蓝色狐狸" or bb == "黄金狮子" or bb == "七彩祥云" or bb == "粉红火鸡" or bb == "彩虹毛驴"
		or bb == "粉嫩小猪" or bb == "水晶芭蕉" or bb == "深海狂鲨" or bb == "雷霆黑豹" or bb == "九尾妖狐" or bb == "砖石小马"
		or bb == "天南蝙蝠" or bb == "繁星珍珠" or bb == "繁星月亮" or bb == "飞天神虎"
        or bb == "国宝熊猫" or bb == "神偷兔兔" or bb == "圣诞狂欢" or bb == "鬼火南瓜" or bb == "神猫头鹰"
        or bb == "远古恐龙" or bb == "神域孔雀" or bb == "通天金牛" or bb == "雷天红狮" or bb == "飞天神鱼"
        or bb == "飞天神象" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.058,1.069,1.08,1.09,1.101}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "汗血宝马" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.058,1.069,1.08,1.09,1.101}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "欢喜羊羊" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.058,1.069,1.08,1.09,1.101}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "魔力斗兽" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.058,1.069,1.08,1.09,1.101}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "披甲战狼" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.058,1.069,1.08,1.09,1.101}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "闲云野鹤" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.058,1.069,1.08,1.09,1.101}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "云魅仙鹿" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.058,1.069,1.08,1.09,1.101}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "神气小龟" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.058,1.069,1.08,1.09,1.101}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "七彩神驴" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "银色穷奇" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "天使猪猪" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "九尾神狐" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "金鳞仙子" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "踏雪灵熊" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "九霄冰凤" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "战火穷奇" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "玄冰灵虎" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "御风灵貂" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "青霄天麟" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "琉璃宝象" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "莽林猛犸" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "暗影战豹" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "鹤雪锦犀" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "猪猪小侠" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "飞天猪猪" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "沉星寒犀" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "妙缘暖犀" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "玄火神驹" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "怒雷狂狮" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "月影天马" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "魔骨战熊" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "轻云羊驼" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "粉红小驴" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	elseif bb == "腾云仙牛" then
	    bbs[1] = 45
		bbs[2] = 200
		bbs[3] = 200
		bbs[4] = 200
		bbs[5] = 200
		bbs[6] = 200
		bbs[7] = 200
		bbs[8] = {1.101,1.15,1.22,1.37,1.5}
	    bbs[9] = 坐骑技能
	    bbs[10] = 取随机数(4000,8000)
	end
	return bbs
end

function 坐骑资料库:补差(zq)
	local zqs={}
	zqs.x,zqs.y=0,0
	if zq=="蝎子坐骑" then
		zqs.x,zqs.y=0,0
	    return zqs.x,zqs.y
	elseif zq=="小狐狸坐骑" then
		zqs.x,zqs.y=0,0
	    return zqs.x,zqs.y
	elseif zq=="大黑虎坐骑" then
		zqs.x,zqs.y=0,0
	    return zqs.x,zqs.y
	elseif zq=="飞天黄金狮坐骑2" then
		zqs.x,zqs.y=0,0
	    return zqs.x,zqs.y
	end
	return zqs.x,zqs.y
end

function 坐骑资料库:坐骑库(id,zq,sp,sp2)
	-- 站立，行走
	if sp2 == nil then
	    sp2 = "空"
	end
	if sp == nil then
	    sp = "空"
	end
	local zqs = {--坐骑名称 = {站立资源,行走资源,人物类型,WDF文件},
				宝贝葫芦 = {0x63C1AA04,0x939B6AA2,1,"shape.wd5"},
				神气小龟 = {0xE88353,0x702610D3,2,"shape.wd5"},
				汗血宝马 = {0x7B49FA9A,0x3F76F5B2,3,"shape.wd5"},
				欢喜羊羊 = {0x8D4DBAAE,0x2636063C,4,"shape.wd5"},
				魔力斗兽 = {0x4B0E16F1,0x28F7499E,3,"shape.wd5"},
				披甲战狼 = {0x3B0CC9,0xF6B76F79,4,"shape.wd5"},
				闲云野鹤 = {0x49CAB729,0x1544FBAD,3,"shape.wd5"},
				云魅仙鹿 = {0x621ECF47,0x98D7DB2,4,"shape.wd5"},
				飞天黄金狮坐骑 = {0x9EA86797,0x7B745DE4,2,"shape.wdc"},
				飞天黄金狮坐骑2 = {0x804119A2,0xF260474D,2,"shape.wdc"},
				未知坐骑3 = {0xE65707DE,0xE65707DE,3,"shape.wdc"},
				大黑虎坐骑 = {0x33668F97,0xDD66EE9C,2,"shape.wdc"},
				黄金象坐骑 = {0xD8E8D600,0x4771DEA3,3,"shape.wdc"},
				飞天猪坐骑粉 = {0xD3DAA128,0xD3DAA128,3,"shape.wdc"},--9E1A3456
				飞天猪坐骑黑 = {0xCB51189B,0xBB051DE9,3,"shape.wdc"},
				小狐狸坐骑 = {0xC6FED2C7,0xC6FED2C7,2,"shape.wdc"},--C4835466  小狐狸坐骑跑动
				蝎子坐骑 = {0x94FD9126,0xFCB0282F,2,"shape.wdc"},
				未知坐骑1 = {0xFC14DF68,0xFC14DF68,3,"shape.wdb"},
				七彩神驴 = {0x03633E07,0x01040DCE,3,"shape.wd5"},
				银色穷奇 = {0x0536E9A0,0x023E3D97,3,"shape.wd5"},
				天使猪猪 = {0x02549905,0x055833D5,3,"shape.wd5"},
				九尾神狐 = {0x03C81881,0x03E53AEF,2,"shape.wd5"},
				金鳞仙子 = {0x05B30629,0x065C9E28,3,"shape.wd5"},
				踏雪灵熊 = {0x0773EB94,0x23C8E5DE,3,"shape.wd5"},
				九霄冰凤 = {0x08DB9888,0x0C2671A9,3,"shape.wd5"},
				战火穷奇 = {0x0A5927A8,0x0BDDE762,3,"shape.wd5"},
				玄冰灵虎 = {0x0A648F68,0x0A8F525E,3,"shape.wd5"},
				御风灵貂 = {0x5BCF5B7B,0x0A6E3345,3,"shape.wd5"},
				青霄天麟 = {0x0BBA930C,0xF5B6264C,3,"shape.wd5"},
				琉璃宝象 = {0xC01D7558,0x343087B3,3,"shape.wd5"},
				莽林猛犸 = {0xBE8BCD59,0x1EE017FE,3,"shape.wd5"},
				暗影战豹 = {0x2283C8E4,0x256B2E02,4,"shape.wd5"},
				鹤雪锦犀 = {0x2C490405,0x61F5973D,3,"shape.wd5"},
				猪猪小侠 = {0x2D5B61B8,0x366A7D69,3,"shape.wd5"},
				飞天猪猪 = {0x2D7948EF,0xD9195AA8,3,"shape.wd5"},
				沉星寒犀 = {0x43E7BE1F,0x77C1746C,3,"shape.wd5"},
				妙缘暖犀 = {0x52282FC2,0x843816AD,3,"shape.wd5"},
				玄火神驹 = {0x5504B0BE,0xE8DD3341,3,"shape.wd5"},
				怒雷狂狮 = {0xEC31AF3B,0x55E4FB5C,3,"shape.wd5"},
				月影天马 = {0xC9086441,0x76C33E92,3,"shape.wd5"},
				魔骨战熊 = {0xBB49CBB2,0x8247EBC3,3,"shape.wd5"},
				轻云羊驼 = {0x9BDE4F15,0xC5C3525E,3,"shape.wd5"},
				粉红小驴 = {0xC7655C83,0xAD4889BD,3,"shape.wd5"},
				独角兽 = {0xFF100011,0xFF100010,5,"jy.wdf"},
				独角兽1 = {0x30303016,0x30303017,6,"jy.wdf"},
				海豚恋人 = {0x00300100,0x00300101,5,"jy.wdf"},
				冰晶魅灵 = {0x00300601,0x00300602,6,"wzife.wd5"},
				炫影天马 = {0x02010225,0x02010226,5,"wzife.wd5"},
				玲珑雪狐 = {0x01000078,0x01000077,7,"wzife.wd5"},
				玲珑雪狐女 = {0x01000080,0x01000079,5,"wzife.wd5"},
				烈焰雄狮 = {0x01000083,0x01000082,5,"wzife.wd5"},
				九尾神狐1 = {0x01000084,0x01000085,8,"wzife.wd5"},

	}
	local sps = {
				展翅高飞 = {0x2DC16EF4,0x47A59E6C,"shape.wd5"},旗开得胜 = {0x4FB7A645,0xC89B8D7B,"shape.wd5"},霸王雄风 = {0x8AC5514E,0xD30116BE,"shape.wd5"},--宝贝葫芦
				独眼观天 = {0xCB41BF07,0x6D415352,"shape.wd5"},威武不屈 = {0xE385373B,0x71FE0155,"shape.wd5"},深藏不露 = {0x2529E5A5,0x51C03CD4,"shape.wd5"},--神气小龟
				异域浓情 = {0xE8B35E96,0x3949C769,"shape.wd5"},流星天马 = {0x72489CFD,0x4D136355,"shape.wd5"},威猛将军 = {0x5BDBA7CB,0x5CDC5A5E,"shape.wd5"},--汗血宝马
				知情达理 = {0xCCBF24B8,0xFE4B37F2,"shape.wd5"},气宇轩昂 = {0xEC4C09DF,0x57B096DF,"shape.wd5"},如花似玉 = {0xA6966FD2,0xCA8864D1,"shape.wd5"},--欢喜羊羊
				傲视天下 = {0xBB906984,0x2549904, "shape.wd5"},铁血豪情 = {0x742FBF19,0x103FFB93,"shape.wd5"},唯我独尊 = {0x7F6FFC35,0x716B5DC1,"shape.wd5"},--魔力斗兽
				叱诧风云 = {0x1FED0CD8,0xD8EB6880,"shape.wd5"},异域风情 = {0xAB007164,0x2E177381,"shape.wd5"},假面勇者 = {0xE7CB8205,0xE615404,"shape.wd5"},--披甲战狼
				霓裳魅影 = {0xE0CB07C8,0xD9D958E6,"shape.wd5"},披星戴月 = {0x8ED6D8CC,0xC5D8F53D,"shape.wd5"},烈焰燃情 = {0x8C575D26,0x7B15590A,"shape.wd5"},--闲云野鹤
				天雨流芳 = {0x503F394B,0x23BF657B,"shape.wd5"},灵光再现 = {0xC4D118C5,0xCBC6930A,"shape.wd5"},倾国倾城 = {0x1F01B8BE,0xBDA4DDAB,"shape.wd5"},--云魅仙鹿
				空 = {}
	}
	local scs
	if id == "飞燕女" then
		scs = {{0x4492502E,0xF6D6D5E6,"shape.wd5"},{0xDCB946EC,0xDCC84D4E,"shape.wd5"},{0xDF01F29D,0xA77B55E4,"shape.wd5"},{0x6E0AD379,0x87C7A650,"shape.wd5"}}
	elseif id == "英女侠" then
		scs = {{0xD43912A9,0xD2D4CAD3,"shape.wd5"},{0x70291C50,0x30CABF19,"shape.wd5"},{0x726C392E,0x68FB1969,"shape.wd5"},{0x2474769B,0xACD868DE,"shape.wd5"}}
	elseif id == "巫蛮儿" then
		scs = {{0xF2BC9369,0xB11F6642,"shape.wda"},{0x9B73C75F,0xDA0A8B06,"shape.wda"},{0x2F5EAD3F,0x499F9D37,"shape.wda"},{0xCCC0985C,0xC8F56BA3,"shape.wda"}}
	elseif id == "偃无师" then
		scs = {{0x00000110,0x00000111,"common/shape.wda"},{0,0,"common/shape.wda"},{0,0,"common/shape.wda"},{0,0,"common/shape.wda"}}
	elseif id == "逍遥生" then
		scs = {{0xA35491C9,0x49D7C76E,"shape.wd5"},{0xB770EAD4,0x9A1479D8,"shape.wd5"},{0x76D629EA,0xFB50C58F,"shape.wd5"},{0x3D392EF4,0xA5E02A65,"shape.wd5"}}
	elseif id == "剑侠客" then
		scs = {{0x67101CB7,0x9C8790BA,"shape.wd5"},{0x32DA9583,0xEC9AC961,"shape.wd5"},{0x766731D,0x8C50358A,"shape.wd5"},{0xA95A126D,0x513DDE6C,"shape.wd5"}}
	elseif id == "狐美人" then
		scs = {{0xE3123BDA,0x956305B5,"shape.wd5"},{0xFB798485,0xD1997415,"shape.wd5"},{0x64C21A63,0xD5D2FA14,"shape.wd5"},{0xBCD86DDA,0xF0062006,"shape.wd5"}}
	elseif id == "骨精灵" then
		scs = {{0xBEEF3795,0x3C6BF98F,"shape.wd5"},{0xE2C1CDE4,0xBAD0F711,"shape.wd5"},{0x75B09FA1,0x5E5736EE,"shape.wd5"},{0x83DD50D3,0xB84C7C38,"shape.wd5"}}
	elseif id == "鬼潇潇" then
		scs = {{0x00000118,0x00000119,"common/shape.wdc"},{0,0,"common/shape.wdc"},{0,0,"common/shape.wdc"},{0,0,"common/shape.wdc"}}
	elseif id == "杀破狼" then
		scs = {{0xE137A55D,0xDB553291,"shape.wda"},{0x8BEA762D,0x14EE7109,"shape.wda"},{0x46A79E5,0x3CD5444,"shape.wda"},{0xF974CEB,0x54A8F096,"shape.wda"}}
	elseif id == "巨魔王" then
		scs = {{0x21ED721D,0x5A05E1C0,"shape.wd5"},{0x9DFEB143,0x77C20678,"shape.wd5"},{0x1AF61311,0x6E370D46,"shape.wd5"},{0xCC1426ED,0x39FE09DB,"shape.wd5"}}
	elseif id == "虎头怪" then
		scs = {{0x99AD84CD,0x9FA6D533,"shape.wd5"},{0xF56603D1,0x83DBBA94,"shape.wd5"},{0x37FFB9DF,0x64426F93,"shape.wd5"},{0x95BC0425,0xC6053278,"shape.wd5"}}
	elseif id == "舞天姬" then
		scs = {{0x54DB4F4D,0xCB722714,"shape.wd5"},{0xD92FC3DE,0x809F42FE,"shape.wd5"},{0x212848A1,0xAAD7CB93,"shape.wd5"},{0xB44DF735,0xECA5DB49,"shape.wd5"}}
	elseif id == "玄彩娥" then
		scs = {{0x861EE4D9,0x9F2F9C11,"shape.wd5"},{0x3316877C,0x31F77503,"shape.wd5"},{0x779A3DF,0x622664DC,"shape.wd5"},{0xA6FD7850,0xB9FD9DBD,"shape.wd5"}}
	elseif id == "桃夭夭" then
		scs = {{0x00000109,0x00000110,"common/shape.wdb"},{0,0,"common/shape.wdb"},{0,0,"common/shape.wdb"},{0,0,"common/shape.wdb"}}
	elseif id == "羽灵神" then
		scs = {{0x7D31F43E,0x76E4E3D6,"shape.wda"},{0x7B86A5F4,0xE496A2D7,"shape.wda"},{0x8072202A,0x6528F013,"shape.wda"},{0x4BBD02E6,0x694A236B,"shape.wda"}}
	elseif id == "神天兵" then
		scs = {{0x77104303,0xBC38000F,"shape.wd5"},{0xF4EF98B5,0x7C731501,"shape.wd5"},{0x7F6D09AB,0x13AD1C23,"shape.wd5"},{0x60A47C21,0x63930A54,"shape.wd5"}}
	elseif id == "龙太子" then
		scs = {{0x4F27A59F,0x801F438D,"shape.wd5"},{0x46F4FDF6,0xC9EF2751,"shape.wd5"},{0x5B0EDDAD,0xB227D39F,"shape.wd5"},{0x643F7DDE,0xCC8E0921,"shape.wd5"}}
	end
	local bh = zqs[zq][3]
	return {坐骑资源=zqs[zq][4],坐骑站立=zqs[zq][1],坐骑行走=zqs[zq][2],人物资源=scs[bh][3],人物站立=scs[bh][1],人物行走=scs[bh][2],坐骑饰品站立=sps[sp][1],坐骑饰品行走=sps[sp][2],坐骑饰品资源=sps[sp][3],坐骑饰品2站立=sps[sp2][1],坐骑饰品2行走=sps[sp2][2],坐骑饰品2资源=sps[sp2][3]}
end

return 坐骑资料库