--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-14 05:58:54
--======================================================================--
local 内存类_队伍 = class()
local jnzb = require("script/显示类/技能")
local floor = math.floor
local ceil = math.ceil
local insert = table.insert
local remove = table.remove
local tp
function 内存类_队伍:初始化(跟)
	tp = 跟
	self.等级 = 0
	self.名称 = ""
	self.性别 = 0
	self.模型 = ""
	self.种族 = ""
	self.帮派 = "无帮派"
	self.门派 = "无门派"
	self.人气 = 600
	self.门贡 = 0
	self.帮贡 = 0
	self.气血 = 0
	self.魔法 = 0
	self.愤怒 = 0
	self.活力 = 100
	self.体力 = 100
	self.命中 = 0
	self.伤害 = 0
	self.防御 = 0
	self.速度 = 0
	self.躲避 = 0
	self.灵力 = 0
	self.法伤 = 0
	self.法防 = 0
	self.体质 = 0
	self.魔力 = 0
	self.力量 = 0
	self.耐力 = 0
	self.敏捷 = 0
	self.潜力 = 5
	self.坐骑 = {}
	self.称谓 = {}
	self.修炼 = {攻击修炼={0,0},法术修炼={0,0},防御修炼={0,0},速度修炼={0,0}}
	self.最大体力 = 100
	self.最大活力 = 100
	self.最大气血 = 0
	self.最大魔法 = 0
	self.当前经验 = 0
	self.最大经验 = 0
	self.宝宝列表 = {}
	self.子女列表 = {}
	self.参战宝宝 = {}
	self.可选门派 = {}
	self.当前称谓=""
	self.装备 = {}
	self.灵饰 = {}
	self.锦衣 = {}
	self.法宝 = {}
	self.灵宝 = {}
	self.神器数据={}
	self.师门技能 = {}
	self.人物技能 = {}
	self.特殊技能 = {}
	self.辅助技能 = {}
	self.战斗技能 = {}
	self.快捷技能 = {}
	self.道具列表 = {}
	self.行囊列表 = {}
	self.坐骑列表 = {}
	self.法宝佩戴 = {}
	self.灵宝佩戴 = {}
	self.加点记录 = {}
	self.战斗道具 = {}
	self.染色方案 = 0
	self.染色组 = {}
	self.技能等级 = {0,0,0,0}
	self.装备属性 = {气血=0,魔法=0,命中=0,伤害=0,防御=0,速度=0,躲避=0,灵力=0,体质=0,魔力=0,力量=0,耐力=0,敏捷=0,
               气血回复效果=0,抗法术暴击等级=0,格挡值=0,法术防御=0,抗物理暴击等级=0,封印命中等级=0,穿刺等级=0,
                抵抗封印等级=0,固定伤害=0,法术伤害=0,法术暴击等级=0,物理暴击等级=0,狂暴等级=0,法术伤害结果=0,
                治疗能力=0}

	self.临时属性 = {气血=0,魔法=0,命中=0,伤害=0,防御=0,速度=0,躲避=0,灵力=0,体质=0,魔力=0,力量=0,耐力=0,敏捷=0}
	self.奇经八脉 = {}
	self.经脉流派 = "无"
    self.乾元丹 = {乾元丹=0,附加乾元丹=0,剩余乾元丹=0,可换乾元丹=1}

    self.月饼 = 0
	self.人物状态 = {}
	self.变身 = {}
	self.默认技能 = false
	self.可持有武器 = nil
	self.自动 = nil
	self.默认技能 = nil

end

function 内存类_队伍:刷新宝宝技能(编号,技能)
	if 编号 ~= nil and 技能 ~= nil then
		local 临时技能=""
		if self.宝宝列表[编号]~=nil then
			self.宝宝列表[编号].技能 = 技能
			for i=1,#self.宝宝列表[编号].技能 do
				临时技能=self.宝宝列表[编号].技能[i]
				self.宝宝列表[编号].技能[i]=tp._技能.创建()
				self.宝宝列表[编号].技能[i]:置对象(临时技能,2)
			end
		end
	else
		local 临时技能=""
		for n=1,#self.宝宝列表 do
			if self.宝宝列表[n]~=nil and self.宝宝列表[n].技能~=nil and #self.宝宝列表[n].技能>0 then
			    for i=1,#self.宝宝列表[n].技能 do
					临时技能=self.宝宝列表[n].技能[i]
					self.宝宝列表[n].技能[i]=tp._技能.创建()
					self.宝宝列表[n].技能[i]:置对象(临时技能,2)
				end
			end
		end
	end
end

function 内存类_队伍:刷新宝宝认证技能()
	local 临时技能=""
	for n=1,#self.宝宝列表 do
		if self.宝宝列表[n]~=nil and self.宝宝列表[n].法术认证~=nil and #self.宝宝列表[n].法术认证>0 then
		    for i=1,#self.宝宝列表[n].法术认证 do
				临时技能=self.宝宝列表[n].法术认证[i]
				self.宝宝列表[n].法术认证[i]=tp._技能.创建()
				self.宝宝列表[n].法术认证[i]:置对象(临时技能,2)
			end
		end
	end
end



function 内存类_队伍:取包含技能(名称)
  local 技能 = {
    为官之道 = {"杀气诀"},
    无双一击 = {"后发制人"},
    神兵鉴赏 = {"兵器谱"},
    疾风步 = {"千里神行"},
    十方无敌 =  {"横扫千军","破釜沉舟"},
    紫薇之术 = {"斩龙诀"},
    文韬武略 = {"反间之计","安神诀","嗜血"},
    黄庭经 = {"三星灭魔"},
    磐龙灭法 = {"离魂符","失魂符","定身符","碎甲符","落雷符"},
    霹雳咒 = {"五雷咒"},
    符之术 = {"飞行符","兵解符","催眠符","失心符","落魄符","失忆符","追魂符"},
    归元心法 =  {"归元咒","凝神术"},
    神道无念 = {"乾天罡气","分身术","神兵护法"},
    斜月步 = {"乙木仙遁"},
    小乘佛法 = {"紫气东来"},
    金刚伏魔 = {"佛法无边"},
    诵经 = {"唧唧歪歪","谆谆教诲"},
    佛光普照 = {"达摩护体","金刚护法","韦陀护法","金刚护体","一苇渡江","拈花妙指"},
    大慈大悲 =  {"我佛慈悲"},
    歧黄之术 = {"推拿","活血","推气过宫","妙手回春","救死扶伤","解毒","舍身取义"},
    渡世步 = {"佛门普渡"},
    毒经 = {nil},
    倾国倾城 = {"红袖添香","楚楚可怜","一笑倾城"},
    沉鱼落雁 = {"满天花雨","情天恨海","雨落寒沙","子母神针"},
    闭月羞花 = {"莲步轻舞","如花解语","似玉生香","娉婷袅娜"},
    香飘兰麝 =  {"轻如鸿毛"},
    玉质冰肌 = {"百毒不侵"},
    清歌妙舞 = {"移形换影","飞花摘叶"},
    灵通术 = {"堪察令","寡欲令"},
    六道轮回 = {"魂飞魄散"},
    幽冥术 = {"阎罗令","锢魂术","黄泉之息"},
    拘魂诀 = {"判官令","还阳术","尸气漫天"},
    九幽阴魂 =  {"幽冥鬼眼","冤魂不散"},
    尸腐恶 = {"尸腐毒","修罗隐身"},
    无常步 = {"杳无音讯"},
    牛逼神功 = {"魔王护持"},
    震天诀 = {"踏山裂石"},
    火云术 = {"飞砂走石","三昧真火","火甲术"},
    火牛阵 = {"牛劲"},
    牛虱阵 =  {"无敌牛虱","无敌牛妖","摇头摆尾"},
    回身击 = {"魔王回首"},
    裂石步 = {"牛屎遁"},
    魔兽神功 = {"变身","魔兽啸天"},
    生死搏 = {"象形","鹰击","狮搏","天魔解体"},
    训兽诀 = {"威慑"},
    阴阳二气诀 = {"定心术","魔息术"},
    狂兽诀 =  {"连环击","神力无穷"},
    大鹏展翅 = {"振翅千里"},
    魔兽反噬 = {"极度疯狂"},
    蛛丝阵法 = {"盘丝舞","夺命蛛丝"},
    迷情大法 = {"含情脉脉","瘴气","魔音摄魂"},
    秋波暗送 = {"勾魂","摄魄"},
    天外魔音 = {nil},
    盘丝大法 =  {"盘丝阵","复苏"},
    盘丝步 = {"天罗地网","天蚕丝","幻镜术"},
    姊妹相随 = {"姐妹同心"},
    天罡气 = {"天神护体","天神护法","天诛地灭","五雷轰顶","雷霆万钧","浩然正气"},
    傲世诀 = {"天雷斩"},
    清明自在 = {"知己知彼"},
    宁气诀 =  {"宁心"},
    乾坤塔 = {"镇妖","错乱"},
    混天术 = {"百万神兵","金刚镯"},
    云霄步 = {"腾云驾雾"},
    九龙诀 = {"解封","清心","二龙戏珠"},
    破浪诀 = {"神龙摆尾"},
    呼风唤雨 = {"龙卷雨击"},
    龙腾术 =  {"龙腾"},
    逆鳞术 = {"逆鳞"},
    游龙术 = {"乘风破浪","水遁"},
    龙附术 = {"龙吟","龙啸九天","龙附"},
    灵性 = {"自在心法"},
    护法金刚 = {nil},
    观音咒 = {"紧箍咒","杨柳甘露"},
    五行学说 =  {"日光华","靛沧海","巨岩破","苍茫树","地裂火"},
    金刚经 = {"普渡众生","灵动九天","莲华妙法"},
    五行扭转 = {"五行错位","颠倒五行"},
    莲花宝座 = {"坐莲"},
    周易学 = {"驱魔","驱尸"},
    潇湘仙雨= {"烟雨剑法","飘渺式"},
    乾坤袖= {"日月乾坤","天地同寿","乾坤妙法"},
    修仙术=  {"炼气化神","生命之泉","一气化三清"},
    混元道果 = {"太极生化"},
    明性修身 = {"三花聚顶"},
    七星遁 = {"斗转星移"},
    瞬息万变 = {"落叶萧萧"},
    万灵诸念= {"荆棘舞","尘土刃","冰川怒"},
    巫咒 = {"雾杀","血雨"},
    万物轮转 =  {"星月之惠"},
    天人庇护 = {"炎护","叶隐"},
    神木恩泽 = {"神木呓语"},
    驭灵咒 = {"蜜润","蝼蚁蚀天"},
    天地无极 = {"穿云破空"},
    九转玄功 = {"不动如山"},
    武神显圣 = {"碎星诀","镇魂诀"},
    啸傲 = {"指地成钢"},
    气吞山河 = {"裂石","断岳势","天崩地裂","浪涌","惊涛怒","翻江搅海"},
    诛魔 = {"腾雷"},
    法天象地 = {"无穷妙道","纵地金光"},
    枯骨心法 = {"移魂化骨"},
    阴风绝章 = {"夺魄令","煞气诀","惊魂掌","摧心术"},
    鬼蛊灵蕴 = {"夺命咒"},
    燃灯灵宝 = {"明光宝烛","金身舍利"},
    地冥妙法 = {"地涌金莲","万木凋枯"},
    混元神功 = {"元阳护体"},
    秘影迷踪 = {"遁地术"},
    天火献誓 = {nil},
    天罚之焰 = {"炽火流离","极天炼焰"},
    煌火无明 = {"谜毒之缚","诡蝠之刑","怨怖之泣","誓血之祭"},
    化神以灵 = {"唤灵·魂火","唤魔·堕羽","唤魔·毒魅","唤灵·焚魂","天魔觉醒"},
    弹指成烬 = {"净世煌火","焚魔烈焰"},
    藻光灵狱 = {"幽影灵魄"},
    离魂 = {"魂兮归来"},
    神工无形 = {"一发而动"},
    攻玉以石 = {"针锋相对","攻守易位"},
    擎天之械 = {"锋芒毕露"},
    千机奇巧 = {"诱袭","匠心·破击"},
    匠心不移 = {"匠心·削铁","匠心·固甲","匠心·蓄锐"},
    运思如电 = {"天马行空"},
    探奥索隐 = {"鬼斧神工","移山填海"},
    神通广大 = {"威震凌霄","气慑天军"},
    如意金箍 = {"当头一棒","神针撼海","杀威铁棒","泼天乱棒"},
    齐天逞胜 = {"九幽除名","移星换斗","云暗天昏"},
    金刚之躯 = {"担山赶月","铜头铁臂"},
    灵猴九窍 = {"无所遁形","天地洞明","除光息焰"},
    七十二变 = {"呼子唤孙","八戒上身"},
    腾云驾霧 = {"筋斗云"},

    九黎战歌 = {"黎魂","战鼓","怒哮","炎魂"},
    魂枫战舞 = {"枫影二刃"},
    兵铸乾坤 = {"一斧开天"},
    燃铁飞花 = {"三荒尽灭","铁火双扬"},
    战火雄魂 = {"铁血生风"},
    魔神降世 = {"力劈苍穹"},
    风行九黎 = {"故壤归心"},

  }
  return 技能[名称]
end



function 内存类_队伍:重置属性(属性)

	for n, v in pairs(属性) do
		if type(n)~="function" and type(n)~="运行父函数" and n~="存档数据" and n~="宝宝列表"  then
			if type(n)=="table" then ----------
				self[n]=table.loadstring(table.tostring(v))
			else
				self[n]=v
			end
		end
	end
	local 临时技能=0
	for n=1,#self.师门技能 do
		临时技能=require("script/显示类/技能")()
		临时技能:置对象(self.师门技能[n].名称)
		临时技能.包含技能={}
		临时技能.学会=self.师门技能[n].学会
		临时技能.等级=self.师门技能[n].等级
		local w = self:取包含技能(self.师门技能[n].名称)
		for s=1,#w do
			临时技能.包含技能[s] = require("script/显示类/技能")()
			临时技能.包含技能[s]:置对象(w[s])
			临时技能.包含技能[s].学会=self.师门技能[n].包含技能[s].学会
			临时技能.包含技能[s].等级=self.师门技能[n].包含技能[s].等级
		end
		self.师门技能[n]=临时技能
	end
	self.角色坐标={x=self.地图数据.x,y=self.地图数据.y}
end

-- function 内存类_队伍:置根(根)
-- 	tp = 根
-- end

function 内存类_队伍:置新对象(ID)
	local ms = tp:取模型(ID)
	local ls = tp:队伍角色(ms)
	self.ID = ID
	self.名称 = ls.名称
	self.性别 = ls.性别
	self.模型 = ls.模型
	self.种族 = ls.种族
	self.可选门派 = ls.门派
	self.染色组 = {}
	self.染色方案 = ls.染色方案
	self.当前称谓=ls.当前称谓
	self.可持有武器 = ls.武器
	local cs = tp:取初始属性(self.种族)
	self.体质 = cs[1]
	self.魔力 = cs[2]
	self.力量 = cs[3]
	self.耐力 = cs[4]
	self.敏捷 = cs[5]
	if not self:有无技能("牛刀小试") then
		local 初始技能 = jnzb()
		初始技能:置对象("牛刀小试")
		insert(self.人物技能,初始技能)
	end
	local fz = {"强身术","冥想","强壮","暗器技巧"}
	for i=1,#fz do
		local 辅助技能 = jnzb()
		辅助技能:置对象(fz[i])
		辅助技能.等级 = 0
		insert(self.辅助技能,辅助技能)
	end
	self:刷新信息("1")
end

function 内存类_队伍:穿戴装备(装备,格子)
	self.装备属性.气血 = self.装备属性.气血 +  (装备.气血 or 0)
	self.装备属性.魔法 = self.装备属性.魔法 + (装备.魔法 or 0)
	self.装备属性.命中 = self.装备属性.命中 + (装备.命中 or 0)
	self.装备属性.伤害 = self.装备属性.伤害 + (装备.伤害 or 0)
	self.装备属性.防御 = self.装备属性.防御 +  (装备.防御 or 0)
	self.装备属性.速度 = self.装备属性.速度 +  (装备.速度 or 0)
	self.装备属性.躲避 = self.装备属性.躲避 +  (装备.躲避 or 0)
	self.装备属性.灵力 = self.装备属性.灵力 + (装备.灵力 or 0)
	self.装备属性.气血 = self.装备属性.气血 + (装备.体质 or 0)*5
	self.装备属性.魔法 = self.装备属性.魔法 + (装备.魔力 or 0)*5
	self.装备属性.伤害 = self.装备属性.伤害 + floor(((装备.力量 or 0)*3.5))
	self.装备属性.防御 = self.装备属性.防御 + floor(((装备.耐力 or 0)*2.3))
	self.装备属性.速度 = self.装备属性.速度 + floor(((装备.敏捷 or 0)*2.3))
	if 格子 < 7 then
		self.装备[格子] = 装备
		if 装备.特技 ~= nil then
			self.特殊技能[格子] = jnzb()
			self.特殊技能[格子]:置对象(装备.特技)
		end
		if 装备.套装效果 ~= nil then
			local sl = {}
			local ab = true
			for i=1,#self.套装 do
				if self.套装[i][1] == 装备.套装效果[1] and self.套装[i][2] == 装备.套装效果[2] then
					local abc = false
					local abd = true
					for s=1,#self.套装[i][4] do
						if self.套装[i][4][s] == 格子 then
						    abd = false
						    break
						end
					end
					if abd then
						insert(self.套装[i][4],格子)
						abc = true
					end
					if abc then
						self.套装[i][3] = (self.套装[i][3] or 0) + 1
					end
					ab = false
					break
				end
			end
			if ab then
				insert(self.套装,{装备.套装效果[1],装备.套装效果[2],1,{格子}})
			end
		end

	else
		self.灵饰[格子-9] = 装备

	end
	self:刷新信息("2")
end

function 内存类_队伍:卸下装备(装备,格子)
	self.装备属性.气血 = self.装备属性.气血 -  (装备.气血 or 0)
	self.装备属性.魔法 = self.装备属性.魔法 - (装备.魔法 or 0)
	self.装备属性.命中 = self.装备属性.命中 - (装备.命中 or 0)
	self.装备属性.伤害 = self.装备属性.伤害 - (装备.伤害 or 0)
	self.装备属性.防御 = self.装备属性.防御 -  (装备.防御 or 0)
	self.装备属性.速度 = self.装备属性.速度 -  (装备.速度 or 0)
	self.装备属性.躲避 = self.装备属性.躲避 - (装备.躲避 or 0)
	self.装备属性.灵力 = self.装备属性.灵力 - (装备.灵力 or 0)
	self.装备属性.气血 = self.装备属性.气血 - (装备.体质 or 0)*5
	self.装备属性.魔法 = self.装备属性.魔法 - (装备.魔力 or 0)*5
	self.装备属性.伤害 = self.装备属性.伤害 - floor(((装备.力量 or 0)*3.5))
	self.装备属性.防御 = self.装备属性.防御 - floor(((装备.耐力 or 0)*2.3))
	self.装备属性.速度 = self.装备属性.速度 - floor(((装备.敏捷 or 0)*2.3))
	if 格子 < 7 then
		if 装备.套装效果 ~= nil then
			for i=1,#self.套装 do
				if self.套装[i] ~= nil and self.套装[i][1] == 装备.套装效果[1] and self.套装[i][2] == 装备.套装效果[2] then
					local abd = nil
					for s=1,#self.套装[i][4] do
						if self.套装[i][4][s] == 格子 then
						    abd = s
						    break
						end
					end
					if abd then
						remove(self.套装[i][4],abd)
					end
					if #self.套装[i][4] == 0 then
						remove(self.套装,i)
					end
				end
			end
		end
		self.装备[格子] = nil
	else
		self.灵饰[格子-9] = nil
	end
	self:刷新信息("2")
end

function 内存类_队伍:置门派(门派)
	self.门派 = 门派
	self.人物技能 = {}
	if not self:有无技能("牛刀小试") then
		local 初始技能 = jnzb()
		初始技能:置对象("牛刀小试")
		insert(self.人物技能,初始技能)
	end
	local 列表 = tp:取门派技能(self.门派)
	for n=1,#列表 do
		self.师门技能[n] = jnzb()
		self.师门技能[n]:置对象(列表[n])
		self.师门技能[n].等级 = 1
		local w = self:取包含技能(self.师门技能[n].名称)
		self.师门技能[n].包含技能 = {}
	 	for s=1,#w do
	 		if w[s] ~= nil then
				self.师门技能[n].包含技能[s] = jnzb()
				self.师门技能[n].包含技能[s]:置对象(w[s])
				self.师门技能[n].包含技能[s].等级 = self.师门技能[n].等级
			end
		end
		self:升级技能(self.师门技能[n])
	end
	self:刷新信息("1")
end

function 内存类_队伍:升级()
	self.等级 = self.等级 + 1
	self.体质 = self.体质 + 1
	self.魔力 = self.魔力 + 1
	self.力量 = self.力量 + 1
	self.耐力 = self.耐力 + 1
	self.敏捷 = self.敏捷 + 1
	self.潜力 = self.潜力 + 5
	self.最大体力 = self.最大体力 + 10
	self.最大活力 = self.最大活力 + 10
	self.当前经验 = self.当前经验 - self.最大经验
	self:刷新信息("1")
end

function 内存类_队伍:降级(级数)
	self.等级 = self.等级 - 级数
	self.体质 = self.体质 -级数
	self.魔力 = self.魔力 - 级数
	self.力量 = self.力量 - 级数
	self.耐力 = self.耐力 - 级数
	self.敏捷 = self.敏捷 - 级数
	self.潜力 = self.潜力 - 级数 * 5
	self.最大体力 = self.最大体力 - 级数 * 10
	self.最大活力 = self.最大活力 - 级数 * 10
	if self.潜力 <= 0 then
		self.潜力 = 0
	end
	self:刷新信息("1")
end

function 内存类_队伍:刷新信息(是否,体质,魔力)
	local 五维属性 = tp:取属性(self.种族,{self.体质,self.魔力,self.力量,self.耐力,self.敏捷},self.技能等级)
	self.命中=五维属性["命中"] + self.装备属性.命中
	self.伤害=五维属性["伤害"] + self.装备属性.伤害 + floor(self.装备属性.命中/3)
	self.防御=五维属性["防御"] + self.装备属性.防御
	self.速度=五维属性["速度"] + self.装备属性.速度
	self.灵力=五维属性["灵力"] + self.装备属性.灵力
	self.躲避= 五维属性["躲避"] + self.装备属性.躲避
	self.最大气血 = 五维属性["气血"]  + self.装备属性.气血
	self.最大魔法 = 五维属性["法力"]  + self.装备属性.魔法
	if 是否 == "1" then
		self.气血 = self.最大气血
		self.魔法 = self.最大魔法
	end
	if 体质 ~= nil and 体质 > 0  then
	    self.气血 = self.最大气血
	end
	if 魔力 ~= nil and 魔力 > 0  then
	    self.魔法 = self.最大魔法
	end
	self.气血 = self.气血 + self.装备属性.气血
	self.魔法 = self.魔法 + self.装备属性.魔法

	-- if self.功德录 and self.功德录.激活 then
 --        for i=1,#self.功德录.九珠副 do
 --           if self.功德录.九珠副[i].类型=="气血" then
 --              self.最大气血=self.最大气血+self.功德录.九珠副[i].数值
 --              self.气血 = self.气血+self.功德录.九珠副[i].数值
 --           elseif self.功德录.九珠副[i].类型=="伤害" then
 --              self.伤害=self.伤害+self.功德录.九珠副[i].数值
 --           elseif self.功德录.九珠副[i].类型=="防御" then
 --              self.防御=self.防御+self.功德录.九珠副[i].数值
 --           elseif self.功德录.九珠副[i].类型=="防御" then
 --              self.速度=self.速度+self.功德录.九珠副[i].数值
 --           end
 --       end
 --   end



	if self.气血 > self.最大气血 then
		self.气血 = self.最大气血
	end
	if self.魔法 > self.最大魔法 then
		self.魔法 = self.最大魔法
	end
	if self.愤怒 > 150 then
		self.愤怒 = 150 - self.愤怒 + self.愤怒
	end
	if self.活力 > 100 then
		self.活力 = 100 - self.活力 + self.活力
	end
	if self.体力 > 100 then
		self.体力 = 100 - self.体力 + self.体力
	end









	self.等级 = self.等级
	if self.等级 <= 174 then
		self.最大经验 = tp:取经验(1,self.等级)
	end
	if self.门派 ~= "无" and self.门派 ~= "无门派" and self.师门技能[1] == nil then
		local 列表 = tp:取门派技能(self.门派)
		for n=1,#列表 do
		    self.师门技能[n] = jnzb()
		    self.师门技能[n]:置对象(列表[n])
		    self.师门技能[n].包含技能 = {}
		    local w = self:取包含技能(self.师门技能[n].名称)
		    for s=1,#w do
			    self.师门技能[n].包含技能[s] = jnzb()
			   	self.师门技能[n].包含技能[s]:置对象(w[s])
			end
		end
	end
	if self.师门技能[1] ~= nil then
		if 是否 == "2" then
			for n=1,7 do
				for l=1,#self.师门技能[n].包含技能 do
					if self:有无技能(self.师门技能[n].包含技能[l].名称) then
						self.师门技能[n].包含技能[l].学会 = true
					end
				end
			end
		end
	end
end

function 内存类_队伍:刷新临时信息(是否,体质,魔力)
	local 五维属性 = self:临时取属性(self.种族,{self.临时属性.体质,self.临时属性.魔力,self.临时属性.力量,self.临时属性.耐力,self.临时属性.敏捷},self.技能等级)
	self.临时属性 = {气血=五维属性["气血"],魔法=五维属性["法力"],命中=五维属性["命中"],伤害=五维属性["伤害"],防御=五维属性["防御"],速度=五维属性["速度"],躲避=五维属性["躲避"],灵力=五维属性["灵力"],体质=self.临时属性.体质,魔力=self.临时属性.魔力,力量=self.临时属性.力量,耐力=self.临时属性.耐力,敏捷=self.临时属性.敏捷}
end

function 内存类_队伍:临时取属性(种族,五维,技能)
	local 属性={}
	local 力量 = 五维[3]
	local 体力 = 五维[1]
	local 魔力 = 五维[2]
	local 耐力 = 五维[4]
	local 敏捷 = 五维[5]
	技能 = 技能 or {0,0,0,0}
	if 种族 =="人" or 种族 == 1 then
		属性={
					命中=ceil(力量*2),
					伤害=ceil(力量*0.67),
					防御=ceil(耐力*1.5),
					速度=ceil(敏捷),
					灵力=ceil(体力*0.3+魔力*0.7+耐力*0.2+力量*0.4),
					躲避=ceil(敏捷),
					气血=ceil((体力*5+100)*(1+技能[1]/100)+技能[3]*4)-100,
					法力=ceil((魔力*3+80)*(1+技能[2]/100))-80,
		}
	elseif 种族 =="魔" or 种族 == 2 then
		属性={
					命中=ceil(力量*2.3),
					伤害=ceil(力量*0.77),
					防御=ceil(耐力*214/153),
					速度=ceil(敏捷),
					灵力=ceil(体力*0.3+魔力*0.7+耐力*0.2+力量*0.4-0.3),
					躲避=ceil(敏捷),
					气血=ceil((体力*6+100)*(1+技能[1]/100)+技能[3]*4)-100,
					法力=ceil((魔力*2.5+80)*(1+技能[2]/100))-80,
		}
	elseif 种族 =="仙" or 种族 == 3 then
		属性={
					命中=ceil(力量*1.7),
					伤害=ceil(力量*0.57),
					防御=ceil(耐力*1.6),
					速度=ceil(敏捷),
					灵力=ceil(体力*0.3+魔力*0.7+耐力*0.2+力量*0.4-0.3),
					躲避=ceil(敏捷),
					气血=ceil((体力*4.5+100)*(1+技能[1]/100)+技能[3]*4)-100,
					法力=ceil((魔力*3.5+80)*(1+技能[2]/100))-80,
		}
	end
	return 属性
end

function 内存类_队伍:有无技能(名称)
	for n=1,#self.人物技能 do
		if self.人物技能[n].名称 == 名称 then
			return true
		end
	end
	return false
end

function 内存类_队伍:学会技能(id,gz)
	if self.师门技能[id] ~= nil then
		for s=1,#self.师门技能[id].包含技能 do
			if self.师门技能[id].包含技能[s].名称 == gz and not self:有无技能(gz) then
				self.师门技能[id].包含技能[s].学会 = true
				self.师门技能[id].包含技能[s].等级 = self.师门技能[id].等级
				insert(self.人物技能,self.师门技能[id].包含技能[s])
				tp.窗口.消息框:添加文本("学会技能 "..gz)
			end
		end
	end
end

function 内存类_队伍:升级技能(jn) -- 升级获得技能
	-- 化生
	if jn.等级 == nil then
		jn.等级 = 1
	end
	if jn.名称 == "小乘佛法" then

	elseif jn.名称 == "金刚伏魔" then

		if jn.等级 >= 120 then
			self:学会技能(2,"佛法无边")
		end
	elseif jn.名称 == "诵经" then
		if jn.等级 >= 1 then
			self:学会技能(3,"唧唧歪歪")
			self:学会技能(3,"谆谆教诲")
		end
	elseif jn.名称 == "佛光普照" then
		if jn.等级 >= 20 then
			self:学会技能(4,"韦陀护法")
		end
		if jn.等级 >= 35 then
			self:学会技能(4,"金刚护体")
		end
		if jn.等级 >= 30 then
			self:学会技能(4,"达摩护体")
			self:学会技能(4,"一苇渡江")
			self:学会技能(4,"金刚护法")
		end
	elseif jn.名称 == "大慈大悲" then
		if jn.等级 >= 40 then
			self:学会技能(5,"我佛慈悲")
		end

	elseif jn.名称 == "歧黄之术" then
		if jn.等级 >= 10 then
			self:学会技能(6,"推拿")
		end
		if jn.等级 >= 15 then
			self:学会技能(6,"解毒")
		end
		if jn.等级 >= 25 then
			self:学会技能(6,"活血")
		end
		if jn.等级 >= 35 then
			self:学会技能(6,"推气过宫")
		end
		if jn.等级 >= 120 then
			self:学会技能(6,"舍身取义")
		end
	elseif jn.名称 == "渡世步" then
		if jn.等级 == 1 then
			self:学会技能(7,"佛门普渡")
		end

	-- 大唐
	elseif jn.名称 == "为官之道" then
		if jn.等级 >= 15 then
			self:学会技能(1,"杀气诀")
		end
	elseif jn.名称 == "无双一击" then
		if jn.等级 >= 25 then
			self:学会技能(2,"后发制人")
		end

	elseif jn.名称 == "神兵鉴赏" then
	elseif jn.名称 == "疾风步" then
		if jn.等级 >= 1 then
			self:学会技能(4,"千里神行")
		end

	elseif jn.名称 == "十方无敌" then
		if jn.等级 >= 30 then
			self:学会技能(5,"横扫千军")
		end
		if jn.等级 >= 120 then
			self:学会技能(5,"破釜沉舟")
		end

	elseif jn.名称 == "紫薇之术" then

	elseif jn.名称 == "文韬武略" then
		if jn.等级 >= 120 then
			self:学会技能(7,"安神诀")
		end

	-- 龙宫
	elseif jn.名称 == "九龙诀" then
		if jn.等级 >= 15 then
			self:学会技能(1,"清心")
		end
		if jn.等级 >= 30 then
			self:学会技能(1,"解封")
		end
		if jn.等级 >= 130 then
			self:学会技能(1,"二龙戏珠")
		end

	elseif jn.名称 == "破浪诀" then

		if jn.等级 >= 120 then
			self:学会技能(2,"神龙摆尾")
		end
	elseif jn.名称 == "呼风唤雨" then
		if jn.等级 >= 15 then
			self:学会技能(3,"龙卷雨击")
		end
	elseif jn.名称 == "龙腾术" then
		if jn.等级 >= 50 then
			self:学会技能(4,"龙腾")
		end
	elseif jn.名称 == "逆鳞术" then
		if jn.等级 >= 30 then
			self:学会技能(5,"逆鳞")
		end

	elseif jn.名称 == "游龙术" then
		if jn.等级 >= 1 then
			self:学会技能(6,"水遁")
		end
		if jn.等级 >= 20 then
			self:学会技能(6,"乘风破浪")
		end

	elseif jn.名称 == "龙附术" then
		if jn.等级 >= 25 then
			self:学会技能("龙啸九天")
		end
		if jn.等级 >= 30 then
			self:学会技能(7,"龙吟")
		end
		if jn.等级 >= 35 then
			self:学会技能(7,"龙附")
		end
	-- 方寸
    elseif jn.名称 == "磐龙灭法" then
    if jn.等级 >= 25 then
    self:学会技能(2,"离魂符")
    end
    if jn.等级 >= 25 then
    self:学会技能(2,"失魂符")
    end
    if jn.等级 >= 30 then
    self:学会技能(2,"定身符")
    end
    if jn.等级 >= 20 then
    self:学会技能(2,"落雷符")
    end
    if jn.等级 >= 120 then
    self:学会技能(2,"碎甲符")
    end

	elseif jn.名称 == "霹雳咒" then
		if jn.等级 >= 1 then
			self:学会技能(3,"五雷咒")
		end
	elseif jn.名称 == "符之术" then
    if jn.等级 >= 10 then
      self:学会技能(4,"催眠符")
    end
    if jn.等级 >= 15 then
      self:学会技能(4,"落魄符")
    end
    if jn.等级 >= 20 then
      self:学会技能(4,"追魂符")
    end
    if jn.等级 >= 21 then
      self:学会技能(4,"飞行符")
    end
    if jn.等级 >= 20 then
      self:学会技能(4,"失忆符")
    end
    if jn.等级 >= 40 then
      self:学会技能(4,"失心符")
    end
	elseif jn.名称 == "归元心法" then
		if jn.等级 >= 10 then
			self:学会技能(5,"归元咒")
		end

	elseif jn.名称 == "神道无念" then
		if jn.等级 >= 30 then
			self:学会技能(6,"乾天罡气")
		end
		if jn.等级 >= 120 then
			self:学会技能(6,"分身术")
		end

	elseif jn.名称 == "斜月步" then
		if jn.等级 >= 1 then
			self:学会技能(7,"乙木仙遁")
		end

	-- 地府
	elseif jn.名称 == "幽冥术" then
		if jn.等级 >= 25 then
			self:学会技能(3,"阎罗令")
		end
		if jn.等级 >= 75 then
      self:学会技能(3,"锢魂术")
        end
        if jn.等级 >= 120 then
      self:学会技能(3,"黄泉之息")
        end
	elseif jn.名称 == "六道轮回" then

	elseif jn.名称 == "拘魂诀" then
		if jn.等级 >= 20 then
			self:学会技能(4,"判官令")
		end
		if jn.等级 >= 120 then
			self:学会技能(4,"还阳术")
		end
	elseif jn.名称 == "九幽阴魂" then

	elseif jn.名称 == "尸腐恶" then
		if jn.等级 >= 20 then
			self:学会技能(6,"尸腐毒")
		end

	elseif jn.名称 == "无常步" then
		if jn.等级 >= 1 then
			self:学会技能(7,"杳无音讯")
		end

	-- 天宫
	elseif jn.名称 == "天罡气" then
		if jn.等级 >= 30 then
			self:学会技能(1,"天神护体")
		end
		if jn.等级 >= 40 then
			self:学会技能(1,"天神护法")
		end
		if jn.等级 >= 35 then
			self:学会技能(1,"五雷轰顶")
		end
		if jn.等级 >= 120 then
			self:学会技能(1,"雷霆万钧")
		end

	elseif jn.名称 == "傲世诀" then
		if jn.等级 >= 25 then
			self:学会技能(2,"天雷斩")
		end
	elseif jn.名称 == "宁气诀" then

	elseif jn.名称 == "清明自在" then

	elseif jn.名称 == "乾坤塔" then
		if jn.等级 >= 50 then
			self:学会技能(5,"错乱")
		end

	elseif jn.名称 == "混天术" then
		if jn.等级 >= 40 then
			self:学会技能(6,"百万神兵")
		end
	elseif jn.名称 == "云霄步" then
		if jn.等级 >= 1 then
			self:学会技能(7,"腾云驾雾")
		end

	-- 魔王
	elseif jn.名称 == "火云术" then
		if jn.等级 >= 30 then
			self:学会技能(3,"飞砂走石")
		end
		if jn.等级 >= 20 then
			self:学会技能(3,"三昧真火")
		end
	elseif jn.名称 == "裂石步" then
		if jn.等级 >= 1 then
			self:学会技能(7,"牛屎遁")
		end

	elseif jn.名称 == "震天诀" then

	elseif jn.名称 == "火牛阵" then
		if jn.等级 >= 30 then
			self:学会技能(4,"牛劲")
		end

	elseif jn.名称 == "回身击" then

	elseif jn.名称 == "裂石步" then

	--普陀
	elseif jn.名称 == "灵性" then

	elseif jn.名称 == "护法金刚" then

	elseif jn.名称 == "金刚经" then
		if jn.等级 >= 15 then
			self:学会技能(5,"普渡众生")
		end
		if jn.等级 >= 120 then
			self:学会技能(5,"灵动九天")
		end
	elseif jn.名称 == "观音咒" then
		if jn.等级 >= 30 then
			self:学会技能(3,"紧箍咒")
		end
		if jn.等级 >= 20 then
			self:学会技能(3,"杨柳甘露")
		end
	elseif jn.名称 == "五行学说" then
		if jn.等级 >= 10 then
			self:学会技能(4,"日光华")
		end
		if jn.等级 >= 10 then
			self:学会技能(4,"靛沧海")
		end
		if jn.等级 >= 10 then
			self:学会技能(4,"巨岩破")
		end
		if jn.等级 >= 10 then
			self:学会技能(4,"苍茫树")
		end
		if jn.等级 >= 10 then
			self:学会技能(4,"地裂火")
		end
	elseif jn.名称 == "五行扭转" then
		if jn.等级 >= 20 then
			self:学会技能(6,"颠倒五行")
		end

	elseif jn.名称 == "莲花宝座" then
		if jn.等级 >= 1 then
			self:学会技能(7,"坐莲")
		end

	-- 五庄观
	elseif jn.名称 == "周易学" then

	elseif jn.名称 == "潇湘仙雨" then
		if jn.等级 >= 25 then
			self:学会技能(2,"烟雨剑法")
		end
		if jn.等级 >= 20 then
			self:学会技能(2,"飘渺式")
		end

	elseif jn.名称 == "乾坤袖" then
		if jn.等级 >= 20 then
			self:学会技能(3,"日月乾坤")
		end
	elseif jn.名称 == "修仙术" then
		if jn.等级 >= 30 then
			self:学会技能(4,"炼气化神")
		end
		if jn.等级 >= 30 then
			self:学会技能(4,"生命之泉")
		end
	elseif jn.名称 == "混元道果" then

	elseif jn.名称 == "明性修身" then
		if jn.等级 >= 30 then
			self:学会技能(6,"三花聚顶")
		end

	elseif jn.名称 == "七星遁" then
		if jn.等级 >= 1 then
			self:学会技能(7,"斗转星移")
		end

	-- 狮驼岭
	elseif jn.名称 == "魔兽神功" then
		if jn.等级 >= 20 then
			self:学会技能(1,"变身")
		end
	elseif jn.名称 == "生死搏" then
		if jn.等级 >= 20 then
			self:学会技能(2,"象形")
		end
		if jn.等级 >= 30 then
			self:学会技能(2,"鹰击")
		end
		if jn.等级 >= 20 then
			self:学会技能(2,"狮搏")
		end

	elseif jn.名称 == "训兽诀" then

	elseif jn.名称 == "狂兽诀" then
		if jn.等级 >= 30 then
			self:学会技能(5,"连环击")
		end
	elseif jn.名称 == "大鹏展翅" then
		if jn.等级 >= 1 then
			self:学会技能(6,"振翅千里")
		end

	elseif jn.名称 == "魔兽反噬" then

	-- 盘丝洞
	elseif jn.名称 == "秋波暗送" then
		if jn.等级 >= 20 then
			self:学会技能(3,"勾魂")
		end
		if jn.等级 >= 20 then
			self:学会技能(3,"摄魄")
		end

	elseif jn.名称 == "蛛丝阵法" then
		if jn.等级 >= 30 then
			self:学会技能(35,"盘丝舞")
		end

	elseif jn.名称 == "迷情大法" then
		if jn.等级 >= 30 then
			self:学会技能(2,"含情脉脉")
		end
	elseif jn.名称 == "盘丝大法" then
		if jn.等级 >= 20 then
			self:学会技能(5,"盘丝阵")
		end

	elseif jn.名称 == "盘丝步" then
		if jn.等级 >= 15 then
			self:学会技能(6,"天罗地网")
		end
		if jn.等级 >= 1 then
			self:学会技能(6,"天蚕丝")
		end

	-- 凌波城
	elseif jn.名称 == "九转玄功" then
		if jn.等级 >= 25 then
			self:学会技能(2,"不动如山")
		end
	elseif jn.名称 == "武神显圣" then
		if jn.等级 >= 30 then
			self:学会技能(3,"碎星诀")
		end
	elseif jn.名称 == "气吞山河" then
		if jn.等级 >= 25 then
			self:学会技能(5,"裂石")
		end
		if jn.等级 >= 25 then
			self:学会技能(5,"浪涌")
		end
		if jn.等级 >= 35 then
			self:学会技能(5,"断岳势")
		end
		if jn.等级 >= 45 then
			self:学会技能(5,"天崩地裂")
		end
		if jn.等级 >= 45 then
			self:学会技能(5,"翻江搅海")
		end
		if jn.等级 >= 35 then
			self:学会技能(5,"惊涛怒")
		end

	elseif jn.名称 == "啸傲" then

	elseif jn.名称 == "诛魔" then

	elseif jn.名称 == "法天象地" then
		if jn.等级 >= 1 then
			self:学会技能(7,"纵地金光")
		end

	-- 神木林
	elseif jn.名称 == "瞬息万变" then
		if jn.等级 >= 35 then
			self:学会技能(1,"落叶萧萧")
		end
	elseif jn.名称 == "万灵诸念" then
		if jn.等级 >= 20 then
			self:学会技能(2,"荆棘舞")
		end
		if jn.等级 >= 20 then
			self:学会技能(2,"尘土刃")
		end
		if jn.等级 >= 20 then
			self:学会技能(2,"冰川怒")
		end

	elseif jn.名称 == "巫咒" then
		if jn.等级 >= 40 then
			self:学会技能(3,"雾杀")
		end
		if jn.等级 >= 40 then
			self:学会技能(3,"血雨")
		end

	elseif jn.名称 == "万物轮转" then
		if jn.等级 >= 35 then
			self:学会技能(4,"星月之惠")
		end

	elseif jn.名称 == "天人庇护" then
		if jn.等级 >= 50 then
			self:学会技能(5,"炎护")
		end
		if jn.等级 >= 1 then
			self:学会技能(5,"叶隐")
		end

	elseif jn.名称 == "神木恩泽" then
	elseif jn.名称 == "驭灵咒" then
		if jn.等级 >= 20 then
			self:学会技能(7,"蜜润")
		end

	-- 无底洞
	elseif jn.名称 == "枯骨心法" then
		if jn.等级 >= 20 then
			self:学会技能(1,"移魂化骨")
		end
	elseif jn.名称 == "阴风绝章" then
		if jn.等级 >= 25 then
			self:学会技能(2,"夺魄令")
		end
		if jn.等级 >= 30 then
			self:学会技能(2,"煞气决")
		end
		if jn.等级 >= 50 then
			self:学会技能(2,"惊魂掌")
		end
		if jn.等级 >= 20 then
			self:学会技能(2,"摧心术")
		end
	elseif jn.名称 == "鬼蛊灵蕴" then
		if jn.等级 >= 35 then
			self:学会技能(3,"夺命咒")
		end

	elseif jn.名称 == "燃灯灵宝" then
		if jn.等级 >= 35 then
			self:学会技能(4,"明光宝烛")
		end

	elseif jn.名称 == "地冥妙法" then
		if jn.等级 >= 20 then
			self:学会技能(5,"地涌金莲")
		end
	elseif jn.名称 == "混元神功" then

	elseif jn.名称 == "秘影迷踪" then
		if jn.等级 >= 1 then
			self:学会技能(7,"遁地术")
		end

	-- 女儿
	elseif jn.名称 == "毒经" then

	elseif jn.名称 == "倾国倾城" then
		if jn.等级 >= 20 then
			self:学会技能(2,"红袖添香")
		end
		if jn.等级 >= 10 then
			self:学会技能(2,"楚楚可怜")
		end
		if jn.等级 >= 120 then
			self:学会技能(2,"一笑倾城")
		end
	elseif jn.名称 == "沉鱼落雁" then
		if jn.等级 >= 25 then
			self:学会技能(3,"满天花雨")
		end
		if jn.等级 >= 20 then
			self:学会技能(3,"雨落寒沙")
			self:学会技能(3,"子母神针")
		end
	elseif jn.名称 == "闭月羞花" then
		if jn.等级 >= 30 then
			self:学会技能(4,"莲步轻舞")
		end
		if jn.等级 >= 30 then
			self:学会技能(4,"如花解语")
		end
		if jn.等级 >= 40 then
			self:学会技能(4,"似玉生香")
		end
		if jn.等级 >= 25 then
			self:学会技能(4,"娉婷袅娜")
		end
	elseif jn.名称 == "香飘兰麝" then

	elseif jn.名称 == "玉质冰肌" then
		if jn.等级 >= 10 then
			self:学会技能(6,"百毒不侵")
		end

	elseif jn.名称 == "清歌妙舞" then
		if jn.等级 >= 1 then
			self:学会技能(7,"移形换影")
		end
		if jn.等级 >= 120 then
			self:学会技能(7,"飞花摘叶")
		end

	end
	self:刷新信息()
end

return 内存类_队伍