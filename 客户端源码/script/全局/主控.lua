--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19//

--======================================================================--
local 场景类_场景 = class()
local 假人最终库 = require("script/全局/假人")
function 生活技能消耗(目标技能等级,类型)
  local cc = 0
  local vv = 0
  local 等级 = 目标技能等级
  if 等级 > 0 and 等级 <= 2 then
    cc = 8*(目标技能等级+1)*目标技能等级
  elseif 等级 > 2 and 等级 <= 5 then
    cc = 8*(目标技能等级+1)*目标技能等级+2^目标技能等级
  elseif 等级 > 5 and 等级 <= 11 then
    cc = 目标技能等级*目标技能等级*(目标技能等级+5)
  elseif 等级 > 11 and 等级 <= 18 then
    cc = 目标技能等级*(目标技能等级+1)*10*(1.625+(目标技能等级-12)*0.2)
  elseif 等级 > 18 and 等级 <= 25 then
    cc = 目标技能等级*(目标技能等级+10)*10*(2.37+(目标技能等级-19)*0.25)
  elseif 等级 > 25 and 等级 <= 31 then
    cc = 目标技能等级*(目标技能等级-10)*(94.3+(目标技能等级-26)*5.5)
  elseif 等级 > 25 and 等级 <= 31 then
    cc = 目标技能等级*(目标技能等级-10)*(94.3+(目标技能等级-26)*5.5)
  elseif 等级 > 31 and 等级 <= 40 then
    cc = 目标技能等级*(目标技能等级-10)*(130.22+(目标技能等级-32)*8)
  elseif 等级 > 40 and 等级 <= 50 then
    cc = 目标技能等级*(目标技能等级-10)*(207.4+(目标技能等级-41)*11)
  elseif 等级 > 50 and 等级 <= 60 then
    cc = 目标技能等级*(目标技能等级-10)*(329.41+(目标技能等级-51)*16)
  elseif 等级 > 60 and 等级 <= 70 then
    cc = 目标技能等级*(目标技能等级-10)*(495.2+(目标技能等级-61)*21)
  elseif 等级 > 70 and 等级 <= 80 then
    cc = 目标技能等级*(目标技能等级-10)*(710.93+(目标技能等级-71)*26)
  elseif 等级 > 80 and 等级 <= 90 then
    cc = 目标技能等级*(目标技能等级-10)*(982.9+(目标技能等级-81)*33)
  elseif 等级 > 90 and 等级 <= 100 then
    cc = 目标技能等级*(目标技能等级-10)*(1317.47+(目标技能等级-91)*39)
  elseif 等级 > 100 and 等级 <= 110 then
    cc = 目标技能等级*(目标技能等级-10)*(1720.997+(目标技能等级-101)*47)
  elseif 等级 > 110 and 等级 <= 120 then
    cc = 目标技能等级*(目标技能等级-10)*(2199.87+(目标技能等级-111)*55)
  elseif 等级 > 120 and 等级 <= 130 then
    cc = 目标技能等级*(目标技能等级-10)*(2760.33+(目标技能等级-121)*64)
  elseif 等级 > 130 and 等级 <= 140 then
    cc = 目标技能等级*(目标技能等级-10)*(3409.09+(目标技能等级-131)*73)
  elseif 等级 > 140 and 等级 <= 150 then
    cc = 目标技能等级*(目标技能等级-10)*(4152.37+(目标技能等级-141)*83)
  elseif 等级 > 150 and 等级 <= 155 then
    cc = 目标技能等级*(目标技能等级-10)*(5152.78+(目标技能等级-151)*247)
  elseif 等级 > 155 and 等级 <= 160 then
    cc = 目标技能等级*(目标技能等级-10)*(6557.72+(目标技能等级-156)*417)
  elseif 等级 > 160 and 等级 <= 170 then
    cc = 目标技能等级*(目标技能等级-10)*(8739.79+(目标技能等级-161)*503)
  elseif 等级 > 170 and 等级 <= 174 then
    cc = 目标技能等级*(目标技能等级-10)*(13980.32+(目标技能等级-171)*707)
  elseif 等级 > 174 and 等级 <= 179 then
    cc = 目标技能等级*(目标技能等级-10)*(16804.73+(目标技能等级-175)*918)
  elseif 等级 > 179 then
      local 临时等级 = 目标技能等级 -1
      cc=临时等级*(临时等级-10)*(16804.73+(临时等级-175)*918)*1.2
  end
  if 等级 > 0 and 等级 <= 3 then
    vv = 3*(目标技能等级+1)*目标技能等级
  elseif 等级 > 3 and 等级 <= 9 then
    vv = (目标技能等级+1)*目标技能等级*(3.25+(目标技能等级-4)*0.25)
  elseif 等级 > 9 and 等级 <= 16 then
    vv = (目标技能等级-5)*目标技能等级*(11.12+(目标技能等级-10)*0.4)
  elseif 等级 > 16 and 等级 <= 20 then
    vv = (目标技能等级-10)*目标技能等级*(24.91+(目标技能等级-17)*0.55)
  elseif 等级 > 20 and 等级 <= 30 then
    vv = (目标技能等级-10)*目标技能等级*(27.73+(目标技能等级-21)*1.7)
  elseif 等级 > 30 and 等级 <= 40 then
    vv = (目标技能等级-10)*目标技能等级*(46.24+(目标技能等级-31)*3)--
  elseif 等级 > 40 and 等级 <= 50 then
    vv = (目标技能等级-10)*目标技能等级*(77.75+(目标技能等级-41)*4.4)
  elseif 等级 > 50 and 等级 <= 60 then
    vv = (目标技能等级-10)*目标技能等级*(123.51+(目标技能等级-51)*6)
  elseif 等级 > 60 and 等级 <= 70 then
    vv = (目标技能等级-10)*目标技能等级*(185.69+(目标技能等级-61)*7.8)
  elseif 等级 > 70 and 等级 <= 80 then
    vv = (目标技能等级-10)*目标技能等级*(266.59+(目标技能等级-71)*10)
  elseif 等级 > 80 and 等级 <= 90 then
    vv = (目标技能等级-10)*目标技能等级*(368.58+(目标技能等级-81)*12.3)
  elseif 等级 > 90 and 等级 <= 100 then
    vv = (目标技能等级-10)*目标技能等级*(494.04+(目标技能等级-91)*14.8)
  elseif 等级 > 100 and 等级 <= 110 then
    vv = (目标技能等级-10)*目标技能等级*(645.36+(目标技能等级-101)*17.6)
  elseif 等级 > 110 and 等级 <= 120 then
    vv = (目标技能等级-10)*目标技能等级*(824.94+(目标技能等级-111)*20.65)
  elseif 等级 > 120 and 等级 <= 130 then
    vv = (目标技能等级-10)*目标技能等级*(1035.17+(目标技能等级-121)*24)
  elseif 等级 > 130 and 等级 <= 140 then
    vv = (目标技能等级-10)*目标技能等级*(1278.45+(目标技能等级-131)*27.5)
  elseif 等级 > 140 and 等级 <= 150 then
    vv = (目标技能等级-10)*目标技能等级*(1557.17+(目标技能等级-141)*31.3)
  elseif 等级 > 150 and 等级 <= 155 then
    vv = (目标技能等级-10)*目标技能等级*(1932.32+(目标技能等级-151)*92.6)
  elseif 等级 > 155 and 等级 <= 160 then
    vv = (目标技能等级-10)*目标技能等级*(2459.17+(目标技能等级-156)*156.3)
  elseif 等级 > 160 and 等级 <= 170 then
    vv = (目标技能等级-10)*目标技能等级*(3231.07+(目标技能等级-161)*144)
  elseif 等级 > 170 and 等级 <= 175 then
    vv = (目标技能等级-10)*目标技能等级*(4731.98+(目标技能等级-171)*205.3)
  elseif 等级 > 175 and 等级 <= 180 then
    vv = (目标技能等级-10)*目标技能等级*(5825.51+(目标技能等级-176)*283)
  elseif 等级 > 180 then
      local 临时等级 = 目标技能等级 -1
      vv = (临时等级-10)*临时等级*(5825.51+(临时等级-176)*283)*1.2
  end
   if  类型==1 then
    return {经验=math.floor(cc),金钱=math.floor(vv)}
  else
    return {经验=math.floor(cc*5),金钱=math.floor(vv*5)}--{经验=floor(技能消耗.经验[等级]*5),金钱=floor(技能消耗.金钱[等级]*3)}
  end

end



local function 绑定等级物品()
	local n = {}
	n[1] = {"红缨枪","曲尖枪","锯齿矛","乌金三叉戟","火焰枪","墨杆金钩","玄铁矛","金蛇信","丈八点钢矛","暗夜","梨花","霹雳","刑天之逆","五虎断魂","飞龙在天","天龙破城","弑皇"}
	n[2] = {"青铜斧","开山斧","双面斧","双弦钺","精钢禅钺","黄金钺","乌金鬼头镰","狂魔镰","恶龙之齿","破魄","肃魂","无敌","五丁开山","元神禁锢","护法灭魔","碧血干戚","裂天"}
	n[3] = {"青铜短剑","铁齿剑","吴越剑","青锋剑","龙泉剑","黄金剑","游龙剑","北斗七星剑","碧玉剑","鱼肠","倚天","湛卢","魏武青虹","灵犀神剑","四法青云","霜冷九州","擒龙"}
	n[4] = {"双短剑","镔铁双剑","龙凤双剑","竹节双剑","狼牙双剑","鱼骨双剑","赤焰双剑","墨玉双剑","梅花双剑","阴阳","月光双剑","灵蛇","金龙双剪","连理双树","祖龙对剑","紫电青霜","浮犀"}
	n[5] = {"五色缎带","幻彩银纱","金丝彩带","无极丝","天蚕丝带","云龙绸带","七彩罗刹","缚神绫","九天仙绫","彩虹","流云","碧波","秋水落霞","晃金仙绳","此最相思","揽月摘星","九霄"}
	n[6] = {"铁爪","天狼爪","幽冥鬼爪","青龙牙","勾魂爪","玄冰刺","青刚刺","华光刺","龙鳞刺","撕天","毒牙","胭脂","九阴勾魂","雪蚕之刺","贵霜之牙","忘川三途","离钩"}
	n[7] = {"折扇","铁骨扇","精钢扇","铁面扇","百折扇","劈水扇","神火扇","阴风扇","风云雷电","太极","玉龙","秋风","画龙点睛","秋水人家","逍遥江湖","浩气长舒","星瀚"}
	n[8] = {"细木棒","金丝魔棒","玉如意","点金棒","云龙棒","幽路引魂","满天星","水晶棒","日月光华","沧海","红莲","盘龙","降魔玉杵","青藤玉树","墨玉骷髅","丝萝乔木","醍醐"}
	n[9] = {"松木锤","镔铁锤","八棱金瓜","狼牙锤","烈焰锤","破甲战锤","震天锤","巨灵神锤","天崩地裂","八卦","鬼牙","雷神","混元金锤","九瓣莲花","鬼王蚀日","狂澜碎岳","碎寂"}
	n[10] = {"牛皮鞭","牛筋鞭","乌龙鞭","钢结鞭","蛇骨鞭","玉竹金铃","青藤柳叶鞭","雷鸣嗜血鞭","混元金钩","龙筋","百花","吹雪","游龙惊鸿","仙人指路","血之刺藤","牧云清歌","霜陨"}
	n[11] = {"黄铜圈","精钢日月圈","离情环","金刺轮","风火圈","赤炎环","蛇形月","子母双月","斜月狼牙","如意","乾坤","月光双环","别情离恨","金玉双环","九天金线","无关风月","朝夕"}
	n[12] = {"柳叶刀","苗刀","夜魔弯刀","金背大砍刀","雁翅刀","破天宝刀","狼牙刀","龙鳞宝刀","黑炎魔刀","冷月","屠龙","血刃","偃月青龙","晓风残月","斩妖泣血","业火三灾","鸣鸿"}
	n[13] = {"曲柳杖","红木杖","白椴杖","墨铁拐","玄铁牛角杖","鹰眼法杖","腾云杖","引魂杖","碧玺杖","业焰","玉辉","鹿鸣","庄周梦蝶","凤翼流珠","雪蟒霜寒","碧海潮生","弦月"}
	n[14] = {"硬木弓","铁胆弓","紫檀弓","宝雕长弓","錾金宝弓","玉腰弯弓","连珠神弓","游鱼戏珠","灵犀望月","非攻","幽篁","百鬼","冥火薄天","龙鸣寒水","太极流光","九霄风雷","若木"}
	n[15] = {"琉璃珠","水晶珠","珍宝珠","翡翠珠","莲华珠","夜灵珠","如意宝珠","沧海明珠","无量玉璧","离火","飞星","月华","回风舞雪","紫金葫芦","裂云啸日","云雷万里","赤明"}
	n[16] = {"钝铁重剑","桃印铁刃","赭石巨剑","壁玉长铗","青铜古剑","金错巨刃","惊涛雪","醉浮生","沉戟天戊","鸦九","昆吾","弦歌","墨骨枯麟","腾蛇郁刃","秋水澄流","百辟镇魂","长息"}
	n[18] = {"素纸灯","竹骨灯","红灯笼","鲤鱼灯","芙蓉花灯","如意宫灯","玲珑盏","玉兔盏","冰心盏","蟠龙","云鹤","风荷","金风玉露","凰火燎原","月露清愁","夭桃秾李","荒尘"}
	n[17] = {"油纸伞","红罗伞","紫竹伞","锦绣椎","幽兰帐","琳琅盖","孔雀羽","金刚伞","落梅伞","鬼骨","云梦","枕霞","碧火琉璃","雪羽穿云","月影星痕","浮生归梦","晴雪"}
	n[19] = {{"方巾","簪子"},{"玉钗","布帽"},{"面具","梅花簪子"},{"纶巾","珍珠头带"},{"缨络丝带","凤头钗"},{"羊角盔","媚狐头饰"},{"水晶帽","玉女发冠"},{"乾坤帽","魔女发冠"},{"黑魔冠","七彩花环"},{"白玉龙冠","凤翅金翎"},{"水晶夔帽","寒雉霜蚕"},{"翡翠曜冠","曜月嵌星"},{"金丝黑玉冠","郁金流苏簪"},{"白玉琉璃冠","玉翼附蝉翎"},{"兽鬼珐琅面","鸾羽九凤冠"},{"紫金磐龙冠","金珰紫焰冠"},{"浑天玄火盔","乾元鸣凤冕"}}
	n[20] = {"护身符","五色飞石","珍珠链",{"骷髅吊坠","苍魂珠"},{"江湖夜雨","九宫坠"},{"荧光坠子","高速之星"},{"风月宝链","八卦坠"},{"碧水青龙","鬼牙攫魂"},{"万里卷云","疾风之铃"},"七彩玲珑","黄玉琉佩","鸾飞凤舞","衔珠金凤佩","七璜珠玉佩","鎏金点翠佩","紫金碧玺佩","落霞陨星坠"}
	n[21] = {{"布裙","布衣"},{"皮衣","丝绸长裙"},{"五彩裙","鳞甲"},{"龙鳞羽衣","锁子甲"},{"天香披肩","紧身衣"},{"金缕羽衣","钢甲"},{"霓裳羽衣","夜魔披风"},{"流云素裙","龙骨甲"},{"七宝天衣","死亡斗篷"},{"飞天羽衣","神谕披风"},{"穰花翠裙","珊瑚玉衣"},{"金蚕丝裙","金蚕披风"},{"紫香金乌裙","乾坤护心甲"},{"碧霞彩云衣","蝉翼金丝甲"},{"金丝蝉翼衫","金丝鱼鳞甲"},{"五彩凤翅衣","紫金磐龙甲"},{"鎏金浣月衣","混元一气甲"}}
	n[22] = {"腰带","缎带","银腰带",{"水晶腰带","玉树腰带"},{"琥珀腰链","白面狼牙"},{"乱牙咬","魔童大牙"},{"攫魂铃","双魂引"},{"兽王腰带","百窜云"},{"八卦锻带","圣王坠"},"幻彩玉带","珠翠玉环","金蟾含珠","乾坤紫玉带","琉璃寒玉带","蝉翼鱼佩带","磐龙凤翔带","紫霄云芒带"}
	n[23] = {"布鞋","牛皮靴","马靴","侠客履","神行靴","绿靴","追星踏月","九州履","万里追云履","踏雪无痕","平步青云","追云逐电","乾坤天罡履","七星逐月靴","碧霞流云履","金丝逐日履","辟尘分光履"}
	n[24] = {"竹编护腕","皮腕","针腕","骨镯","青铜护腕","玛瑙护腕","琉璃护腕","镂空银镯","笼玉镯","嵌宝金腕","玳瑁护腕","七星宝腕","缚龙筋","凤翎护腕","织锦彩带","冰蚕丝带"}
	n[25] = {"竹编脖环","钢圈","荆棘环","骨环","青铜颈环","玛瑙石环","琉璃环","九曲环","笼玉环","嵌宝金环","玳瑁环","七星宝环","缚龙圈","鸾尾环","织锦颈圈","冰蚕丝圈"}
	n[26] = {"竹藤甲","皮甲","刺甲","骨排甲","青铜披甲","玛瑙软甲","琉璃罩甲","连环铠甲","笼玉甲","嵌宝金甲","玳瑁衣","七星宝甲","缚龙甲","凤凰彩衣","织锦软褡","冰蚕织甲"}
	return n
end

local 杀星出现计时 = 0
local tp
local fsb = require("script/资源类/FSB")
local function 音效类_(文件号,资源包,子类)
	if 文件号 ~= nil and 文件号 ~= 0 and tp.系统设置.声音设置[4] then
		fsb(tp.资源:读数据(资源包,文件号)):播放(false)
	end
end



function 场景类_场景:初始化()


	self.资源 = require("script/资源类/加载类")(self)
	self.资源:打开()
	local 资源 = self.资源
	fsb(nil,nil,self)
	-- 初始化缓存数据
	self.资源缓存 = {} -- 已加载的was资源将保存在这里，避免重复读取
	-- UI
	self._滑块 =  require("script/系统类/滑块")
	self._自适应 = require("script/系统类/自适应")
	self._按钮 = require("script/系统类/按钮")
	self._小型选项栏 = require("script/系统类/小型选项栏")

	local bqs = {0x4D3D1188,0x6E7A8E8F,0x403105F2,0xD3C23894,0xEDD63AB1,0xC8AA7848,0xA5D718B1,
               0xE0C6F0D3,0x572F2A4D,0xA1E13E27,0xB2F4A198,0xEDEBCFCF,0x3B3D19C0,0x9EEC6DE4,
               0x1B1B8326,0x525FCCF9,0xAD9E8BAD,0xE9A1E271,0x1C7C95C4,0x1500E768,0x30615DBC,
               0x3694C64F,0xFD438646,0x4FAD347C,0x743AF90F,0x853F3BC9,0xD6436048,0x74E0F5FA,
               0x8E0063E2,0x5BA9CF5E,0xE8E08FA9,0x888536BF,0xBEDE7D41,0xF06B6B9E,0x58FAA400,
               0x270D5C71,0xACE9C474,0xBE3150EE,0x11C5EA40,0x73F3BF9D,0xCCD6B7E8,0x66D0E07C,
               0x9A8BFB91,0xCA47B474,0x590CAA9B,0x4E20C2E6,0x44B657A9,0x978F8F8A,0x522BC68F,
               0xA8A9B15D,0xE53DE56A,0xE88B5354,0x0417C932,0xC699AB3E,0x19CA9706,0xFCD58523,
               0xCD8F0AD6,0x978B9123,0x0E658C4C,0x12BE1C3E,0x85AC8CCB,0x707ABF50,0x58C9FAB0,
               0xAA7B3B42,0xF2FBDA6E,0xFC4215EC,0xD086F684,0xFCCAA9B5,0xE5FF2DE2,0x87621B9F,
               0xCDC95381,0x396C4E03,0xB06B70C0,0xADE1576E,0xFB472367,0xEDA67286,0x15CA26D9,
               0xDC9C1E87,0xB5786848,0xC2A7A47D,0x7EEB3422,0x8F20BE2E,0xA1E7B566,0x11729962,
               0xEF498C25,0xF95512DC,0xF5509B1C,0x7F869E1E,0x107CF5F3,0xF45DCF6A,0x99AFED62,
               0xC8BBEEA3,0x225ECF82,0xD5C14B62,0xA8BC861D,0x7229A70C,0x4FF6E07A,0xDF1F56AC,
               0x488EBBD6,0x4806AE3B,0x09574327,0x7A9F28C7,0xB7E060C1,0x5887677B,0x1C0BCE22,
               0xAAFBD630,0xE4994B6A,0xACA32B8F,0xED5B5996,0x65D48DBF,0x91EAD158,0x50BF3749,
               0x383F3815,0x445A8BA0,0xD6252D94,0x247121AF,0x64A8BD13,0x79C2D9F2,0x57648A83,
               0x2DF12D10,0xD753949E}
	self.包子表情动画 = {}
	for i=0,120 do
	    self.包子表情动画[i] = 资源:载入('登陆资源.wdf',"网易WDF动画",bqs[i+1])
	end

  for i=121,190 do
         local 编号 =tostring(i-120)
         local 编码 = "0x000000"
         if #编号==1 then
              编码=编码..编号
         else
              编码=编码.."0"..编号
         end
         self.包子表情动画[i] = 资源:载入('靓号.wdf',"网易WDF动画",tonumber(编码))
  end
	self._丰富文本 = require("script/系统类/丰富文本")
	self._列表 = require("script/系统类/列表")
	-- 系统
	self._物品格子 = require("script/显示类/物品_格子")
	self._技能格子 = require("script/显示类/技能_格子")
	-- 内存
	self._物品 = require("script/显示类/物品")
	self._技能 = require("script/显示类/技能")
	self._宝宝库 = require("script/数据中心/宝宝库")
	self._宝宝 = require("script/属性控制/宝宝")
	self._队伍 = require("script/属性控制/队伍")
  self._多开队伍 = require("script/属性控制/多开队伍")
	local wz = require("gge文字类")
	self.文字类=wz
	self.字体表 = {
		普通字体 = wz.创建(nil,14,false,false,false),
		普通字体_ = wz.创建(nil,13,false,false,false),
		普通字体__ = wz.创建(nil,13,false,false,false),
		普通字体___ = wz.创建(nil,14,false,false,false),
        普通字体____ = wz.创建(nil,12,false,false,false),
		描边字体 = wz.创建(nil,16,false,true,false),
        描边字体_ = wz.创建(nil,14,false,true,false),
        描边字体__ = wz.创建(nil,12,false,true,true),
		描边字体12 = wz.创建(nil,12,false,true,false),
		道具字体 = wz.创建(nil,21,true,false,true),

        人物字体 = wz.创建(nil,16,false,false,false),
        人物字体_ = wz.创建(nil,16,false,false,true),
		提示字体 = wz.创建(nil,18,false,true,false),
		时间字体 = wz.创建(nil,16,false,true,false),
		商场数量字体 = wz.创建(nil,14,false,true,false),
		冷却字体 = wz.创建("wdf/font/hkyt1.ttf",30,true,false,true),
        赞助字体 = wz.创建("wdf/font/hkyt1.ttf",18,false,true,true),
        外部文字 =wz.创建(nil,14,false,false,false),
        下拉字体 = wz.创建("wdf/font/hkyt备用.TTF",14,false,true,true),
        下拉字体_ = wz.创建("wdf/font/hkyt备用.TTF",13,false,true,true),
        排行字体 = wz.创建("wdf/font/hyf2gjm.ttf",16,false,false,true),
        排行字体1 = wz.创建("wdf/font/hyf2gjm.ttf",14,false,false,true),
        签到字体 = wz.创建("wdf/font/hkyt1.ttf",14,false,true,true),
        标题字体 = wz.创建("wdf/font/hyf2gjm.ttf",16,false,false,true),
        自动栏字体 = wz.创建("wdf/font/hkyt.ttf",12.5,false,false,true),

        九黎连击 = wz.创建("wdf/font/ljzt.ttf",46,false,false,true),
        技能提示 = wz.创建("wdf/font/hyf2gjm.ttf",18,false,true,true),






	}
	--加载字体表后 69M
	--人物字体 = wz.创建("wdf/font/hkyt1.ttf",16,false,false,true),
	摊位文字=wz.创建(nil,14,false,false,false)
	摊位文字:置颜色(0xFF0084FF)
	名称字体=wz.创建(nil,16,false,false,false)
	--wz=nil

	self.字体表.道具字体:置字间距(3.8)
	self.字体表.描边字体:置颜色(4294967280):置阴影颜色(ARGB(170,0,0,0))
    self.字体表.描边字体_:置颜色(4294967280):置阴影颜色(ARGB(170,0,0,0))
	self.字体表.描边字体12:置颜色(4294967280):置阴影颜色(ARGB(170,0,0,0))
	self.字体表.时间字体:置描边颜色(-16777216)
	self.字体表.时间字体:置颜色(0xFFEEE8AA)
	self.字体表.提示字体:置颜色(4278255360)
    self.字体表.普通字体__:置颜色(0XFF000000)
	self.字体表.普通字体___:置颜色(0XFF000000)
    self.字体表.普通字体____:置颜色(0XFF000000)
    self.字体表.冷却字体:置描边颜色(-16777216)

    self.字体表.技能提示:置颜色(4294967280):置阴影颜色(ARGB(255,0,0,0))

   self.字体表.九黎连击:置颜色(4294967280):置阴影颜色(ARGB(170,0,0,0))
	-- 测试


	local fc = self._自适应.创建()
	fc:加载(self)
	self.提示框 = self._自适应.创建(6,1,1,1,3,9)
  self.提示框1 = self._自适应.创建(124,1,1,1,3,9)


	-- local fc = self._队伍()
	-- fc:置根(self)

	-- 初始化时间
	self.当前地图 = 0
	-- 初始化队伍打开
	self.队伍 = {}
	self.多角色 = {}
	self.称谓 = {"梦幻测试"}
	self.当前称谓 = "无称谓"
	-- 初始化阵型
	self.阵型 = 1
	self.阵型表 = {[1]={"无阵型",true,0},[2]={"天覆阵",false,0},[3]={"地载阵",false,0},[4]={"风扬阵",false,0},[5]={"云垂阵",false,0},[6]={"龙飞阵",false,0},[7]={"虎翼阵",false,0},[8]={"鸟翔阵",false,0},[9]={"蛇蟠阵",false,0},[10]={"鹰啸阵",false,0},[11]={"雷绝阵",false,0}}
	self.地图 = nil
	-- 初始化宠物
	self.宠物 = {模型="生肖猪",名称="生肖猪",等级=1,最大等级=40,耐力=5,最大耐力=5,经验=1,最大经验=10,领养次数=0}
	-- 初始化游戏组件
	self.道具列表 = {}
	self.任务列表 = {}
	self.人物仓库 = {}
  self.战斗道具 = {}
--	self.召唤兽仓库 = {}
	self.道具仓库 = {}
	self.辅助技能 = {}
	self.房屋数据 = {}
	self.金钱 = 10000
	self.储备 = 0
	self.积分 = 3000
	self.存银 = 0
	self.摄妖香开启 = false
	self.摄妖香剩余功效时辰 = 0
	self.队伍数据={}
	self.战斗文字 = {{},{},{},{},{},{},{}}
	for n=1,10 do
		self.战斗文字[1][n] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xC52B2DE4)--伤害字
		self.战斗文字[1][n].当前帧 = n-1
		self.战斗文字[1][n]:更新纹理()
		self.战斗文字[2][n] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xC52B2DE3)--加血字
		self.战斗文字[2][n].当前帧 = n-1
		self.战斗文字[2][n]:更新纹理()
        self.战斗文字[3][n] =资源:载入('登陆资源.wdf',"网易WDF动画",0x3CF8F9FE)--大 外红内白字
        self.战斗文字[3][n].当前帧 = n-1
        self.战斗文字[3][n]:更新纹理()
		self.战斗文字[4][n] =资源:载入('登陆资源.wdf',"网易WDF动画",0x0512F7DA)--中 外红内白字
		self.战斗文字[4][n].当前帧 = n-1
		self.战斗文字[4][n]:更新纹理()
		self.战斗文字[5][n] =资源:载入('登陆资源.wdf',"网易WDF动画",0x4EE0010A)--大 外红内白字
		self.战斗文字[5][n].当前帧 = n-1
		self.战斗文字[5][n]:更新纹理()
	end
  for n=1,2 do
    self.战斗文字[6][n] = 资源:载入('护盾括号.wdf',"网易WDF动画",0x009DDAAB)--括号
    self.战斗文字[6][n].当前帧 = n-1
    self.战斗文字[6][n]:更新纹理()
    self.战斗文字[7][n] = 资源:载入('护盾括号.wdf',"网易WDF动画",0x0065CCAB)--暴击的括号
    self.战斗文字[7][n].当前帧 = n-1
    self.战斗文字[7][n]:更新纹理()
  end



	self.底图 = 读配置("./config.ini","mhxy","底图") +0
	local 底图资源 = 0x1BDDA833
	local 地图包 = "登陆资源.wdf"
	if self.底图 == 1 then
		底图资源 = 0x1BDDA833
		地图包 = "登陆资源.wdf"
  elseif self.底图 == 2 then
    底图资源 = 0x10000081
    地图包 = "房屋图标.wdf"
  elseif self.底图 == 3 then
    底图资源 = 0x10000082
    地图包 = "房屋图标.wdf"
  elseif self.底图 == 4 then
    底图资源 = 0x10000083
    地图包 = "房屋图标.wdf"
  elseif self.底图 == 5 then
    底图资源 = 0x10000084
    地图包 = "房屋图标.wdf"
  elseif self.底图 == 6 then
    底图资源 = 0x10000085
    地图包 = "房屋图标.wdf"
  elseif self.底图 == 7 then
    底图资源 = 0x10000086
    地图包 = "房屋图标.wdf"

	end



  观察={}

  self.专用 = 资源:载入(wdf配置.."/pic/专用.png","图片")
  self.绿装底图 = 资源:载入('zbpjsjxt.wdf',"网易WDF动画",0X00000038)
  self.蓝装底图 = 资源:载入('zbpjsjxt.wdf',"网易WDF动画",0X00000037)
  self.橙装底图 = 资源:载入('zbpjsjxt.wdf',"网易WDF动画",0X00000035)
  self.红装底图 = 资源:载入('zbpjsjxt.wdf',"网易WDF动画",0X00000036)
  self.加锁图标 = 资源:载入('新界面.wdf',"网易WDF动画",0X85655274)
	self.外部聊天框    = 资源:载入('登陆资源.wdf',"网易WDF动画",0x1BDDA833)
	self.外部聊天框:置区域(0,0,360,1000)--可以充填
	self.物品格子焦点_ = 资源:载入('登陆资源.wdf',"网易WDF动画",0x6F88F494)
	self.物品格子确定_ = 资源:载入('登陆资源.wdf',"网易WDF动画",0x10921CA7)
	self.物品格子禁止_ = 资源:载入('登陆资源.wdf',"网易WDF动画",0x4138B067)
	self.队伍格子焦点_ = 资源:载入('登陆资源.wdf',"网易WDF动画",0x1ADE7867)
	self.队伍格子确定_ = 资源:载入('登陆资源.wdf',"网易WDF动画",0xC540D7A7)
    self.底图背景 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xEA6D0A4D).精灵
    self.物品界面背景_ = 资源:载入('登陆资源.wdf',"网易WDF动画",0xF70725E9).精灵
	self.物品格子背景_ = 资源:载入('登陆资源.wdf',"网易WDF动画",0xB17505CF).精灵
	self.竖排花纹背景_ = 资源:载入('房屋图标.wdf',"网易WDF动画",0xabcd0204).精灵
	self.竖排花纹背景1_ = 资源:载入('登陆资源.wdf',"网易WDF动画",0xADC83326).精灵
	self.横排花纹背景_ = 资源:载入('房屋图标.wdf',"网易WDF动画",0xabcd0203).精灵
	self.宽竖排花纹背景_ = 资源:载入('登陆资源.wdf',"网易WDF动画",0x2D0F136C).精灵
    self.宠物头像背景_ = 资源:载入('登陆资源.wdf',"网易WDF动画",0x363AAF1B).精灵
    self.人物头像背景_ = 资源:载入('登陆资源.wdf',"网易WDF动画",0x360B8373).精灵
    self.窗口标题背景_ = {[1]=资源:载入('窗口文字.wdf',"网易WDF动画",0x00000001),
					      [2]=资源:载入('窗口文字.wdf',"网易WDF动画",0x00000002),
					      [3]=资源:载入('窗口文字.wdf',"网易WDF动画",0x00000003),
					      [4]=资源:载入('窗口文字.wdf',"网易WDF动画",0x00000004),
					      [5]=资源:载入('窗口文字.wdf',"网易WDF动画",0x00000005),
					      [6]=资源:载入('窗口文字.wdf',"网易WDF动画",0x00000006),
					      [7]=资源:载入('窗口文字.wdf',"网易WDF动画",0x00000007),
					      [8]=资源:载入('窗口文字.wdf',"网易WDF动画",0x00000008),
					      [9]=资源:载入('窗口文字.wdf',"网易WDF动画",0x00000009),
					      [10]=资源:载入('窗口文字.wdf',"网易WDF动画",0x00000010),
					     }

	小摊位=资源:载入('登陆资源.wdf',"网易WDF动画",0xBD80E0DB)
    中摊位=资源:载入('登陆资源.wdf',"网易WDF动画",0x6D33D98E)
    大摊位=资源:载入('登陆资源.wdf',"网易WDF动画",0x74786102)


	self.经验背景_ = self._自适应.创建(7,1,186,22,1,3)
	self.活跃背景_ = self._自适应.创建(7,1,50,22,1,3)
	self.影子 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xDCE4B562)
	self.底图 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xA393A808)
	self.传送点 =  资源:载入('登陆资源.wdf',"网易WDF动画",0x7F4CBC8C)
	-- 天气
	self.画线 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xA1442425)
	self.任务图标 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x953624BC)
	self.战斗图标 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x3D3AA29E)


--	require("script/数据中心/场景NPC")
--	self.假人库 = require("script/全局/假人控制")(self)
	self.打造物品 = 绑定等级物品()
	图像类 = require("gge图像类1")

	self.窗口 = {
		小地图 = require("script/功能界面/小地图").创建(self),      ----1
		对话栏 = require("script/初系统/对话栏").创建(self),    ----2
		文本栏 = require("script/显示类/文本栏").创建(self),         ----3
		队伍申请表 = require("script/场景类/队伍申请列表类").创建(self), ----4
		人物状态栏 = require("script/场景类/人物状态栏").创建(self), ----5
		人物称谓栏 = require("script/场景类/人物称谓栏").创建(self), ----6
		召唤兽属性栏 = require("script/场景类/召唤兽属性栏").创建(self),----7
		召唤兽资质栏 = require("script/场景类/召唤兽资质栏").创建(self),----8
		道具行囊 = require("script/场景类/道具行囊").创建(self), ----9
		新道具行囊 = require("script/场景类/新道具行囊").创建(self), ----10
		队伍栏 = require("script/场景类/队伍栏").创建(self), ----11
		队伍阵型栏 = require("script/场景类/队伍阵型栏").创建(self),----12
    成就系统栏 = require("script/场景类/成就系统栏").创建(self),----13
	 	宠物状态栏 = require("script/场景类/宠物状态栏").创建(self),----14
		宠物领养栏 =  require("script/场景类/宠物领养栏").创建(self),----15
		宠物炼妖栏 =  require("script/场景类/宠物炼妖栏").创建(self),----16
    宠物洗练栏 =  require("script/场景类/宠物洗练栏").创建(self),----17
    宠物打书内丹栏 =  require("script/场景类/宠物打书内丹栏").创建(self),----18
    宠物合宠栏 =  require("script/场景类/宠物合宠栏").创建(self),----19
		任务栏 = require("script/场景类/任务栏").创建(self),----20
		打造 = require("script/场景类/打造").创建(self),----21
		商店 = require("script/场景类/商店").创建(self),----22
		跑商商店 = require("script/场景类/跑商商店").创建(self),----23
		召唤兽染色 = require("script/场景类/召唤兽染色").创建(self),----24
		召唤兽饰品染色 = require("script/场景类/召唤兽饰品染色").创建(self),----25
		武器染色 = require("script/场景类/武器染色").创建(self),----26
		出售 =  require("script/场景类/出售").创建(self),----27
		技能学习 =  require("script/场景类/技能学习").创建(self),----28
		染色 = require("script/场景类/染色").创建(self),----29
		飞行符 = require("script/场景类/飞行符").创建(self),----30
		钓鱼 = require("script/场景类/钓鱼").创建(self),----31
		系统设置 = require("script/初系统/设置").创建(self),----32
		仓库类 = require("script/场景类/仓库类").创建(self),----33
		好友列表 = require("script/功能界面/好友列表").创建(self),----34
		自由技能栏 = require("script/场景类/自由技能栏").创建(self),----35
		奇经八脉 = require("script/场景类/奇经八脉").创建(self),----36
		合成 = require("script/场景类/合成").创建(self),----37
		召唤兽查看栏 = require("script/场景类/召唤兽查看栏").创建(self),----38
		角色查看 = require("script/功能界面/角色查看").创建(self),----39
		灵饰 = require("script/场景类/灵饰").创建(self),----40
		法宝 = require("script/场景类/法宝").创建(self),----41
		法宝方案2 = require("script/场景类/法宝方案2").创建(self),----42
    法宝方案3 = require("script/场景类/法宝方案3").创建(self),----43
		锦衣 = require("script/场景类/锦衣").创建(self),----44
		组合输入框 = require("script/场景类/组合输入框").创建(self),----45
		任务追踪栏 = require("script/场景类/任务追踪栏").创建(self),----46 没ID加的
		生死劫 = require("script/场景类/生死劫").创建(self),----47
		快捷技能选择栏 = require("script/场景类/快捷技能选择栏").创建(self),----48
		表情窗口 = require("script/功能界面/表情窗口").创建(self),----49
		时辰 = require("script/功能界面/时辰").创建(self), -----无ID
		人物框 = require("script/系统类/人物框").创建(self), -----无ID
		底图框 = require("script/功能界面/底图框").创建(self),-----无ID
		消息框 = require("script/功能界面/聊天框").创建(self),-----无ID
		快捷技能栏 = require("script/系统类/快捷技能栏").创建(self),-----无ID
		给予 = require("script/功能界面/给予类").创建(self),----50
		交易 = require("script/功能界面/交易类").创建(self),----51
		摊位出售 = require("script/功能界面/摊位出售类").创建(self),----52
		摊位购买 = require("script/功能界面/摊位购买类").创建(self),----53
		新摊位购买 = require("script/功能界面/新摊位购买类").创建(self),----54
		合成旗 = require("script/功能界面/合成旗类").创建(self),----55
		排行榜 = require("script/功能界面/排行榜类").创建(self),----56
		好友消息 = require("script/功能界面/好友消息类").创建(self),----57
		好友查看 = require("script/功能界面/好友查看类").创建(self),----58
		八卦阵升级界面 = require("script/新界面/八卦阵升级界面").创建(self),
	  世界地图分类小地图 = require("script/功能界面/世界地图分类小地图").创建(self),----59
		世界大地图= require("script/功能界面/世界大地图").创建(self),----60
		世界大地图分类a= require("script/功能界面/世界大地图分类a").创建(self),----61
		世界大地图分类b= require("script/功能界面/世界大地图分类b").创建(self),----62
		世界大地图分类c= require("script/功能界面/世界大地图分类c").创建(self),----63
		世界大地图分类d= require("script/功能界面/世界大地图分类d").创建(self),----64
		小地图NPC= require("script/功能界面/小地图NPC").创建(self),----65
		仙玉商城类 = require("script/积分商店/仙玉商城类").创建(self),----66
		会员福利 = require("Script/功能界面/会员福利").创建(self),----67
		攻略查看 = require("Script/功能界面/攻略查看").创建(self),----68
		回收系统 = require("Script/功能界面/回收系统").创建(self),----69
		梦幻指引 = require("script/场景类/梦幻指引").创建(self),----70
		更多属性 = require("script/功能界面/更多属性").创建(self),----71
		装备开运 = require("script/场景类/装备开运").创建(self),----72
		功德录备份 = require("script/新界面/功德录备份").创建(self),----73
		签到界面 = require("script/新界面/签到界面").创建(self),----74
		坐骑属性栏 = require("script/功能界面/坐骑属性栏").创建(self),----75
		坐骑资质栏 = require("script/功能界面/坐骑资质栏").创建(self),----76
		坐骑技能栏 = require("script/功能界面/坐骑技能栏").创建(self),----77
		鉴定 = require("script/场景类/鉴定").创建(self),----78
		附魔 = require("script/场景类/附魔").创建(self),----79
		帮派查看 = require("script/功能界面/帮派查看类").创建(self),----80
		帮派申请 = require("script/功能界面/帮派申请类").创建(self),----81
		帮派点修 = require("script/场景类/帮派点修").创建(self),----82
		帮派技能学习 = require("script/场景类/帮派技能学习").创建(self),----83
    符石合成 = require("script/新界面/符石合成").创建(self),----84
--		坐骑染色 = require("script/场景类/坐骑染色").创建(self),----85
	--	坐骑饰品染色 = require("script/场景类/坐骑饰品染色").创建(self),----86
		法宝合成 = require("script/场景类/法宝合成").创建(self),----87
		附魔宝珠 = require("script/场景类/附魔宝珠").创建(self),----88
		碎星锤 = require("script/场景类/碎星锤").创建(self),----89
		神秘宝箱 = require("script/场景类/神秘宝箱类").创建(self),----90
		抽奖系统 = require("script/场景类/抽奖系统").创建(self),----91
		炼丹炉 = require("script/功能界面/炼丹炉").创建(self),----92   无ID加的
		--孩子技能学习 = require("script/场景类/孩子技能学习").创建(self),
		--活跃商城 = require("script/功能界面/活跃商城").创建(self),
		灵箓 = require("script/场景类/灵箓").创建(self),----93
		房屋拜访 = require("script/功能界面/房屋拜访类").创建(self),----94
		商店召唤兽  = require("script/功能界面/商店召唤兽").创建(self),----95
		商店变异召唤兽  = require("script/功能界面/商店变异召唤兽").创建(self),----96
		剑会天下 = require("script/场景类/剑会天下").创建(self),----97
		剑会匹配 = require("script/场景类/剑会匹配").创建(self),----98
		幻化界面 = require("script/老摩托/幻化界面").创建(self),----99
		元身打造 = require("script/老摩托/元身打造").创建(self),----100
		传音飞鸽 = require("script/老摩托/传音飞鸽").创建(self),----101
		传音打开 = require("script/老摩托/传音打开").创建(self),----102
		超级传送 = require("script/老摩托/超级传送").创建(self),----103
    钓鱼积分商店 = require("script/积分商店/钓鱼积分商店").创建(self),----104
    人物界面 = require("script/功能界面/人物界面类").创建(self),----105
--  图鉴系统 = require("script/功能界面/图鉴系统").创建(self),
    好友观察 = require("script/显示类/好友观察").创建(self),----106
		成就提示 = require("script/老摩托/成就提示").创建(self),----107
    铃铛界面 = require("Script/功能界面/铃铛界面").创建(self),----108
--  交易中心 = require("Script/功能界面/交易中心").创建(self),
    自动抓鬼 = require("Script/功能界面/自动抓鬼").创建(self),----109
    自选系统 = require("Script/功能界面/自选系统").创建(self),----110
    每日活动 = require("script/积分商店/每日活动").创建(self),----111
    每日查看 = require("script/积分商店/每日查看").创建(self),----112
    藏宝阁类 = require("script/藏宝阁/藏宝阁类").创建(self),----113
    藏宝阁出售 = require("script/藏宝阁/藏宝阁出售").创建(self),----114
    藏宝阁出售寄存 = require("script/藏宝阁/藏宝阁出售寄存").创建(self),----115
    藏宝阁购买寄存= require("script/藏宝阁/藏宝阁购买寄存").创建(self),----116
    藏宝阁上架货币= require("script/藏宝阁/藏宝阁上架货币").创建(self),----117
    多开系统 = require("script/功能界面/多开系统").创建(self),----118
    多开创建 = require("script/功能界面/多开创建").创建(self),----119
    多角色状态栏 = require("script/多角色操作/多角色状态栏").创建(self),----120
    多角色奇经八脉 = require("script/多角色操作/多角色奇经八脉").创建(self),----121
    多角色道具行囊 = require("script/多角色操作/多角色道具行囊").创建(self),----122
    多角色仓库类 = require("script/多角色操作/多角色仓库类").创建(self),----123
    多角色回收系统 = require("script/多角色操作/多角色回收系统").创建(self),----124
    多角色召唤兽属性栏 = require("script/多角色操作/多角色召唤兽属性栏").创建(self),----125
    多角色召唤兽资质栏 = require("script/多角色操作/多角色召唤兽资质栏").创建(self),----126
    符石镶嵌 = require("script/新界面/符石镶嵌").创建(self),----127
    角色转换 = require("script/新界面/角色转换").创建(self),----128
    物品加锁 = require("script/新界面/物品加锁").创建(self),----129
    物品密码 = require("script/新界面/物品密码").创建(self),----130
    物品密码修改 = require("script/新界面/物品密码修改").创建(self),----131
    物品解锁 = require("script/新界面/物品解锁").创建(self),----132
    彩虹争霸赛 = require("script/新界面/彩虹争霸赛").创建(self),----133
    师门选择= require("script/新界面/师门选择").创建(self),----134
    长安保卫战 = require("script/新界面/长安保卫战").创建(self),----135
    BOOS挑战  = require("script/新界面/BOOS挑战").创建(self),----136
    战斗排行框 = require("script/新界面/战斗排行框").创建(self), ---无ID
    仙缘商店 = require("script/新界面/仙缘商店").创建(self),----137
    神器获得 = require("script/神器类/神器获得").创建(self),----138
    合成灵犀玉 = require("script/神器类/合成灵犀玉").创建(self),----139
    神器更换五行 = require("script/神器类/神器更换五行").创建(self),----140
    神器查看 = require("script/神器类/神器查看").创建(self),----141
    修复神器 = require("script/神器类/修复神器").创建(self),----142
    邀请组队 = require("script/新界面/邀请组队").创建(self),----143
    靓号设定 = require("script/新界面/靓号设定").创建(self),----144
    CDK充值 = require("script/新界面/CDK充值").创建(self),----145
   -- self.灵宝栏 = require("script/战斗类/战斗灵宝类").创建(根)  ---灵宝 146
    家具制作类 = require("script/积分商店/家具制作类").创建(self),----146
    好友查找 = require("script/功能界面/好友查找类").创建(self),----147
    文韵商店 = require("script/新界面/文韵商店").创建(self),----148
    超级赐福 = require("script/新界面/超级赐福").创建(self),----149
    制作仙露 = require("script/场景类/制作仙露").创建(self),----150
    超级兽决获得 = require("script/新界面/超级兽决获得").创建(self),----151
    自选灵饰系统 = require("Script/功能界面/自选灵饰系统").创建(self),----152
    共享仓库 = require("Script/新界面/共享仓库").创建(self),----153
    嘉年抽奖 = require("script/场景类/嘉年抽奖").创建(self),----154



	}
	-- if jcsj<os.time()-8 then
	-- 	错误关闭数=100
	-- 	引擎.关闭()
	-- 	更新函数,渲染函数 = nil,nil
	-- 	tp=nil
	-- 	引擎.场景 =nil
	-- 	引擎=nil
	-- 	jcsjj=true
	-- 	return 0
	-- end
	--=========08开始

	require("script/全局/变量2")
	-- 加载头文件
	ffi = require("ffi")
	f函数=require("ffi函数2")
	f函数.修改窗口图标("001.ico")
	资源char = ffi.new('char[10485760]')
	资源p = tonumber(ffi.cast("intptr_t",资源char))
--	music = require("Glow/WDF类")(系统参数.目录.."WDF/music.wdf",资源p,10485760)
	FMOD类2	= require("FMOD类5")
	FMOD类3  = require("FMOD类5")
	客户端=require("script/网络/hp").创建()

	--=========08结束
	self.窗口_ = {}
	-- 初始化标题

	self.缓冲 = require("script/初系统/缓冲").创建(self)
	self.标题 = require("script/初系统/标题").创建(self)
	self.注册 = require("script/初系统/注册").创建(self)
	self.分区 = require("script/初系统/分区").创建(self)
	self.登陆 = require("script/初系统/登陆").创建(self)
	self.创建 = require("script/初系统/创建").创建(self)
	self.读取 = require("script/初系统/选择角色").创建(self)
	self.退出 = require("script/初系统/退出").创建(self)
	-- 初始化鼠标
	self.鼠标 = require("script/显示类/鼠标").创建(self)
	self.提示 = require("script/显示类/提示类").创建(self)
  self.常规提示 = require("script/显示类/常规提示").创建(self)
	self.喊话 = require("script/显示类/喊话").创建(self)
	-- 角色坐标
	self.角色坐标 = 生成XY()
	-- 初始化进程
	self.进程 = 0
	-- 系统设置
	self.系统设置 = {
		声音设置 = {100,100,true,true},
		战斗设置 = {"一级药",30,30,true,true}
	}
	local a = {wdf配置.."/Audio/song.mp3",wdf配置.."/Audio/song.mp3"}
	self.音乐 = self.资源:载入(a[引擎.取随机整数(1,2)],"音乐",nil)
	self.音乐:播放(读配置("./config.ini","mhxy","音乐播放") or true)
	self.音乐:置音量(0)
	self.音量 = 0
	-- self.底图 = 读配置("./config.ini","mhxy","底图") + 0
	--self.渐变音量 = 40
	self.战斗中 = false
	self.音乐开启 = true
	self.音效开启 = true
	self.场景特效 = false
	self.战斗显示蓝条 = 读配置("./config.ini","mhxy","战斗显示蓝条")
	if self.战斗显示蓝条 == "true" then
		self.战斗显示蓝条 = true
	elseif self.战斗显示蓝条 == "false" then
		self.战斗显示蓝条 = false
	elseif self.战斗显示蓝条 == "空" then
		self.战斗显示蓝条 = false
	end
	self.人物选中  = false
	self.选中UI  = false
	self.隐藏UI = false
	self.第二场景开启 = false
	self.下一次确定 = false
	self.按钮焦点  = false
	self.禁止通行 = false
	self.消息栏焦点 = false
	self.快捷技能显示 = true
	self.按下中 = false
	self.第一窗口移动中 = false
	self.第二窗口移动中 = false
	self.第二次删除 = 0
	self.梦幻指引 = {}
	self.坐骑列表 = {}
	-- self.临时Npc = {}
	系统参数.音量=self.音量
	--self.选中窗口 = 0
	self.Npc任务事件 = nil -- 寄存押镖、送信之类的
	-- 初始化运行时间
	self.运行时间 = 0
	--self.音乐:置音量(80)
	self.恢复UI = false
	self.战斗音效序列={}
	tp = self

end

function 取随机数(a,b)
    return 引擎.取随机整数(a,b)
end

function 场景类_场景:初始化设置()
	-- 初始化队伍
	self.系统设置 = {
		声音设置 = {140,140}
	}
	-- 初始化时间
	self.当前地图 = 0
	-- 初始化队伍
	self.队伍 = {}
	self.称谓 = {"梦幻测试"}
	self.当前称谓 = "无称谓"
	-- 初始化阵型
	self.阵型 = 1
	self.阵型表 = {[1]={"无阵型",true,0},[2]={"天覆阵",false,0},[3]={"地载阵",false,0},[4]={"风扬阵",false,0},[5]={"云垂阵",false,0},[6]={"龙飞阵",false,0},[7]={"虎翼阵",false,0},[8]={"鸟翔阵",false,0},[9]={"蛇蟠阵",false,0},[10]={"鹰啸阵",false,0},[11]={"雷绝阵",false,0}}
	self.地图 = nil
	-- 初始化宠物
	self.宠物 = {模型="生肖猪",名称="生肖猪",等级=1,最大等级=40,耐力=5,最大耐力=5,经验=1,最大经验=10}
	-- 初始化游戏组件
	self.道具列表 = {}
	self.任务列表 = {}
	self.人物仓库 = {}
--	self.召唤兽仓库 = {}
	self.道具仓库 = {}
	self.辅助技能 = {}
	self.全局Npc = {}
	self.金钱 = 10000
	self.储备 = 0
	self.积分 = 0
	self.存银 = 0
	self.摄妖香开启 = false
	self.摄妖香剩余功效时辰 = 3
	self.临时野怪 = nil
	self.角色坐标 = 生成XY()

end

function 场景类_场景:关闭窗口()
	for i,v in pairs(self.窗口_) do
		if v.可视 then
			if v.ID ~= 3 then
				if v.ID == 4 or v.ID == 7 then
					v:打开()
				else
					v.可视 = false
				end
			end
		end
	end
	self.选中窗口 = 0
	self.选中UI  = false
end

function 场景类_场景:取药品(等级)
	if 等级 == 1 then
		return {"佛手","旋复花","紫丹罗","四叶花","白玉骨头","灵脂","鬼切草","天青地白","曼佗罗花"}
	elseif 等级 == 2 then
		return {"丁香水","月星子","紫石英","天不老","地狱灵芝","仙狐涎","麝香","血珊瑚","餐风饮露","白露为霜","鹿茸","血色茶花","天龙水","孔雀红","六道轮回","熊胆","凤凰尾","硫磺草","龙之心屑","火凤之睛"}
	elseif 等级 == 3 then
		return {"金创药","金香玉","风水混元丹","定神香","蛇蝎美人","千年保心丹","小还丹","九转回魂丹","佛光舍利子","五龙丹"}
	end
end

function 场景类_场景:取进制等级(等级)
	local dj = 0
	if 等级 > 0 and 等级 < 10 then
		dj = 0
	elseif 等级 >= 10 and 等级 < 20 then
		dj = 10
	elseif 等级 >= 20 and 等级 < 30 then
		dj = 20
	elseif 等级 >= 30 and 等级 < 40 then
		dj = 30
	elseif 等级 >= 40 and 等级 < 50 then
		dj = 40
	elseif 等级 >= 50 and 等级 < 60 then
		dj = 50
	elseif 等级 >= 60 and 等级 < 70 then
		dj = 60
	elseif 等级 >= 70 and 等级 < 80 then
		dj = 70
	elseif 等级 >= 80 and 等级 < 90 then
		dj = 80
	elseif 等级 >= 90 and 等级 < 100 then
		dj = 90
	elseif 等级 >= 100 and 等级 < 110 then
		dj = 100
	elseif 等级 >= 110 and 等级 < 120 then
		dj = 110
	elseif 等级 >= 120 and 等级 < 130 then
		dj = 120
	elseif 等级 >= 130 and 等级 < 140 then
		dj = 130
	elseif 等级 >= 140 and 等级 < 150 then
		dj = 140
	elseif 等级 >= 150 and 等级 < 160 then
		dj = 150
	elseif 等级 >= 160 and 等级 < 170 then
		dj = 160
	elseif 等级 >= 170 and 等级 < 185 then
		dj = 170
	end
	return dj
end

function 场景类_场景:可通行()
	return not 人物点击 and not self.人物选中 and not self.选中UI and
  not self.按钮焦点 and not self.消息栏焦点 and self.场景.抓取物品 == nil and
  not self.禁止通行 and not self.下一次确定 and
  not self.按下中 and not self.第一窗口移动中
  and not self.第二窗口移动中
end

function 场景类_场景:载入特效(特效,zl,ns)

	local a = 引擎.特效库(特效)
	if a[2]==nil and a[1]==nil then
	    tp.窗口.消息框:添加文本("请截图给管理员,谢谢[ "..特效.." ]特效没技能素材","系统")
	end
	return self.资源:载入(a[2],"网易WDF动画",a[1],zl,nil,ns,false)
end

function 场景类_场景:可操作()
	return not self.消息栏焦点 and not self.选中UI
end

function UI排序(a,b)
	if a.窗口时间 ==nil or b.窗口时间 ==nil then
	 a.窗口时间 = 1
	 b.窗口时间 =1
	 end
 	return a.窗口时间 < b.窗口时间
end

function 场景类_场景:取鼠标所在窗口(x,y)
	if not self.隐藏UI and not self.战斗中 then
		for n=#self.窗口_, 1,-1 do
	     if self.窗口_[n]:检查点(x,y)  then
	        	self.选中UI = true
				  return n
	     end
		end
	end
	return 0
end

local jz = 0

function 场景类_场景:显示(dt,x,y)
	if 客户端参数.分钟~=os.date("%M", os.time()) and os.date("%S", os.time())=="00" then
	   整分处理(os.date("%M", os.time()))
	end
	if 检测开启 == 1 then
		if math.random(1, 1000) <= 10 then
			检测WPE(动态加密文本)
		    检测WPE2(动态加密文本)
		    检测WPE3(动态加密文本)
	     	内存优化(动态加密文本)
	 	end
	end

	全局时辰刷新()

  --   for k, v in pairs(全局资源缓存) do
  --    if v.time and os.time() >  v.time then
  --       全局资源缓存弱[k] = 全局资源缓存[k]
  --       全局资源缓存弱[k].time=os.time()+180
  --       全局资源缓存[k] = nil
  --     end
  -- end
  -- for k, v in pairs(全局资源缓存弱) do
  --    if v.time and os.time() >  v.time then
  --       全局资源缓存弱[k] = nil
  --     end
  -- end

  for k, v in pairs(全局资源缓存) do
    if v.time and os.time() > v.time  then --超时就转成弱缓存
        全局资源缓存弱[k] = 全局资源缓存[k]
        全局资源缓存[k] = nil
    end
  end


	for i=0,190 do
		self.包子表情动画[i]:更新(dt)
	end
	 系统参数.时间=os.time()
	self.传送点:更新(dt)
	self.任务图标:更新(dt)
	self.战斗图标:更新(dt)
	if self.隐藏UI then
		self.选中UI = false
	end
	if self.进程 == 1 or self.进程 == 2 or self.进程 == 3 or self.进程 == 5 or self.进程 == 6 or self.进程 == 7 or self.进程 == 8 or self.进程 == 9 or self.进程2 == 1 then
		if self.进程 ~= 2 and self.进程 ~= 3 then
			self.标题:显示(dt,x,y)
		end
		if self.进程 == 2 then
			self.读取:显示(dt,x,y)
		elseif self.进程 == 3 then
			self.创建:显示(dt,x,y)
		elseif self.进程 == 5 then
			self.注册:显示(dt,x,y)
		elseif self.进程 == 7 then
			self.登陆:显示(dt,x,y)
		elseif self.进程 == 8 then
			self.分区:显示(dt,x,y)
		elseif self.进程 == 9 then
			self.退出:显示(dt,x,y)
		end
		if  self.进程2 == 1 then
			self.退出:显示(dt,x,y)
		end
	elseif self.进程 == 0 then
		self.缓冲:显示(dt,x,y)
	elseif self.进程 == 4 then
		self.场景:显示(dt,x,y)
		self.喊话:显示()
		if self.场景.过度精灵 ~= nil then
			self.场景.过度时间 = self.场景.过度时间 - 0.55
			if self.场景.过度时间 <= 0 then
				self.场景.过度进度 = self.场景.过度进度 - (self.场景.过度减少 or 20)
				self.场景.过度时间 = 0
				if self.场景.过度进度 <= 0 then
					self.场景.过度进度 = 0
				end
			end
			if self.场景.过度进度 <= 240 then
				if self.恢复UI then
					self.隐藏UI = false
					self.恢复UI = false
				end
			end
			self.场景.过度精灵:置颜色(ARGB(self.场景.过度进度,255,255,255))
			self.场景.过度精灵:显示()
			if self.场景.过度进度 <= 0 then
				self.场景.过度精灵:释放()
				self.场景.过度精灵 = nil
				self.场景.过度减少 = nil
			end
		end
		if not self.隐藏UI then
			self.队伍格子焦点_:更新(dt)
			self.物品格子焦点_:更新(dt)
			self.窗口.时辰:显示(dt,x,y)
			self.窗口.人物框:显示(dt,x,y)
			self.窗口.底图框:显示(dt,x,y)
			self.窗口.快捷技能栏:显示(dt,x,y)
			if self.战斗中 then
				self.窗口.消息框:显示(dt,x,y)
         if not self.窗口.战斗排行框.隐藏  then
          self.窗口.战斗排行框:显示(dt,x,y)
        end


				--[[for n=1,#self.场景.战斗.窗口_ do
					if not self.隐藏UI then
						self.场景.战斗.窗口_[n]:显示(dt,x,y)
						if self.按钮焦点 then
							self.场景.战斗.窗口_[n].焦点 = true
						end
					end
				end --]]

			else
				游戏传音:显示(dt,x,y)
				self.窗口.消息框:显示(dt,x,y)
				self.窗口.任务追踪栏:显示(dt,x,y)
				table.sort(self.窗口_,UI排序)
				for n=1,#self.窗口_ do
					if self.窗口_[n].可视 then
  						self.窗口_[n]:显示(dt,x,y)
  						self.窗口_[n].焦点 = self.窗口_[n].焦点 or self.按钮焦点
  						if self.窗口_[self.选中窗口] ~= nil and self.窗口_[self.选中窗口].ID == self.窗口_[n].ID and not self.按下中 then
    							self.窗口_[n].鼠标 = true
    							if 引擎.鼠标弹起(1) and self.窗口_[n].右键关闭==nil and self.抓取物品 == nil and not self.禁止关闭 and not self.消息栏焦点 and not self.窗口_[n].焦点1 then
      								self.窗口_[n]:打开()
      								if self.窗口_[n].注释 == "炼丹炉" then
      									请求服务(99)
      								end
    							end
  						else
                 -- print(self.窗口_[n].鼠标)
    							if self.第一窗口移动中 == false then
    								  self.窗口_[n].鼠标 = false
    							end
  						end
          else
              self.窗口_[n].鼠标 = false
					end
				end
				if 引擎.鼠标按下(0) and self.选中窗口 ~= 0  and self.窗口_[self.选中窗口]~=nil and self.窗口_[self.选中窗口].可移动 and not self.消息栏焦点 then
					 self.窗口_[self.选中窗口]:初始移动(x,y)

				elseif 引擎.鼠标弹起(0)  or self.隐藏UI or self.消息栏焦点 then
  					self.移动窗口 = false
  					self.第一窗口移动中 = false
				end
				if self.移动窗口 and not self.隐藏UI and not self.消息栏焦点 and self.窗口_[#self.窗口_] then
					self.第一窗口移动中 = true
					self.窗口_[#self.窗口_]:开始移动(x,y)
				end
				for n=1,#self.窗口_ do
  					if self.窗口_[n] and not self.窗口_[n].可视 then
  						  table.remove(self.窗口_,n)
  					end
				end
			end
		end
		----------------------摩托修改点击背包 鼠标箭头显示在哪里
		-- if self.场景.抓取物品 ~= nil then
		-- 	self.场景.抓取物品.小模型:显示(x - 30,y - 30)
		-- end


		if self.场景.抓取物品 ~= nil then

			 self.场景.抓取物品.小模型:显示(x - 45,y - 40)



			if not self.窗口.道具行囊.可视  and not self.窗口.新道具行囊.可视 and not self.窗口.多角色道具行囊.可视 and not self.窗口.修复神器.可视 and not self.窗口.法宝.可视 then
				self.场景.抓取物品 = nil
				self.场景.抓取物品ID = nil
				self.场景.抓取物品注释 = nil
			end
			if 引擎.鼠标弹起(右键) then
				if 新道具行囊 then
  					if self.窗口.新道具行囊.可视  then
    						self.窗口.新道具行囊:整体资源刷新()
    					  self.窗口.新道具行囊:清除抓取道具()
  					end
				else
					  if self.窗口.道具行囊.可视  then
  					 	self.窗口.道具行囊:整体资源刷新()
  						self.窗口.道具行囊:清除抓取道具()
					  end
				end

				if self.窗口.多角色道具行囊.可视  then
					self.窗口.多角色道具行囊:整体资源刷新()
					self.窗口.多角色道具行囊:清除抓取道具()
				end
				if self.窗口.法宝.可视  then
					self.窗口.法宝:刷新法宝显示()
				end
        if self.窗口.修复神器.可视  then
           self.场景.抓取物品 = nil
           self.场景.抓取物品ID = nil
           self.场景.抓取物品注释 = nil
        end
				if (self.窗口.道具行囊.可视 or self.窗口.新道具行囊.可视 or self.窗口.多角色道具行囊.可视 or self.窗口.法宝.可视 or self.窗口.修复神器.可视) and self.窗口.文本栏.可视 then
					self.窗口.文本栏.可视 = false
				end
			end
		end

	end
  if self.常规提示.可视 then
      self.常规提示:显示()
  end


	if self.第二场景开启 then
		self.隐藏UI = true
		self.第二场景:显示(dt,x,y)
	end


	if #self.提示.寄存内容 > 0 then
  		if self.提示.寄存内容.开启提示 then
          if self.提示.寄存内容.提示坐标[4]+12>=400 then
              self.提示框1:置宽高(self.提示.寄存内容.提示坐标[3]+15,self.提示.寄存内容.提示坐标[4]+12)
              self.提示框1:显示(self.提示.寄存内容.提示坐标[1],self.提示.寄存内容.提示坐标[2])
          else
              self.提示框:置宽高(self.提示.寄存内容.提示坐标[3]+15,self.提示.寄存内容.提示坐标[4]+12)
              self.提示框:显示(self.提示.寄存内容.提示坐标[1],self.提示.寄存内容.提示坐标[2])
          end
          if self.提示.寄存内容.装备底图 then
              self.提示.寄存内容.装备底图:置宽高(self.提示.寄存内容.提示坐标[3]+15,self.提示.寄存内容.提示坐标[4]+12)
              self.提示.寄存内容.装备底图:显示(self.提示.寄存内容.提示坐标[1],self.提示.寄存内容.提示坐标[2])
          end
  		end
  		for i=1,#self.提示.寄存内容 do
    			if self.提示.寄存内容[i].内容 ~= nil then
    			    self.提示.寄存内容[i].内容:显示(self.提示.寄存内容[i].x,self.提示.寄存内容[i].y)
    			else
      				if self.提示.寄存内容[i].文字 ~= nil then
      				 	self.提示.寄存内容[i].文字:置颜色(self.提示.寄存内容[i].颜色):显示(self.提示.寄存内容[i].坐标[1],self.提示.寄存内容[i].坐标[2],self.提示.寄存内容[i].文本)
      				end
    			end
  		end

		self.提示:清空寄存()
	end
	if self.选中假人 and not tp.战斗中 then
		self.鼠标.置鼠标("事件")
	end

	self.提示:显示(dt,x,y)
	self.鼠标:更新(dt,x,y)
	self.鼠标:显示(dt,x,y)
	self.选中UI = false
	if self.下一次确定 then
		self.选中UI = true
	end
	if self.选项栏选中 then
		self.第二次删除 = self.第二次删除 + 1
		if self.第二次删除 == 2 then
			self.第二次删除 = 0
			self.选项栏选中 = false
		end
	end
	self.禁止通行 = false
	self.按钮焦点 = false
	self.禁止关闭 = false
	self.消息栏焦点 = false
	-- if self.进程 == 1 or self.进程 == 2 or self.进程 == 3 or self.进程 == 5 or self.进程 == 6 or self.进程 == 7 or self.进程 == 8 or self.进程 == 9 then
	-- 	if self.渐变音量 < self.系统设置.声音设置[1] then
	-- 		self.渐变音量 = self.渐变音量 + 2
	-- 		self.音乐:置音量(self.渐变音量)
	-- 		全局游戏音量=math.ceil(读配置("./config.ini","mhxy","音量")) or 50
	-- 	end
	-- else
	if self.进程 == 4 then
		if not self.隐藏UI then
  			if self.窗口.文本栏.可视 or self.窗口.对话栏.可视  then
  				self.消息栏焦点 = true
  			end
  			if not self.战斗中 then
  				  self.选中窗口 = self:取鼠标所在窗口(x,y)
  			else
  				战斗类.选中窗口 = 战斗类:取鼠标所在窗口(x,y)
  			end
		end
	end

	if 坐标显示 then
		self.字体表.普通字体:显示(0,100,"鼠标："..鼠标.x..","..鼠标.y)
		self.字体表.普通字体:显示(0,120,"角色坐标:"..math.floor(self.角色坐标.x)..","..math.floor(self.角色坐标.y))
		self.字体表.普通字体:显示(0,140,"地图："..tp.当前地图)
 	end


end

function 场景类_场景:取模型(ID)
	local 角色信息 = {}
	角色信息[1] = "飞燕女"
	角色信息[2] = "英女侠"
	角色信息[3] = "巫蛮儿"
	角色信息[4] = "逍遥生"
	角色信息[5] = "剑侠客"
	角色信息[6] = "狐美人"
	角色信息[7] = "骨精灵"
	角色信息[8] = "杀破狼"
	角色信息[9] = "巨魔王"
	角色信息[10] = "虎头怪"
	角色信息[11] = "舞天姬"
	角色信息[12] = "玄彩娥"
	角色信息[13] = "羽灵神"
	角色信息[14] = "神天兵"
	角色信息[15] = "龙太子"
	角色信息[16] = "桃夭夭"
	角色信息[17] = "偃无师"
	角色信息[18] = "鬼潇潇"
  角色信息[19] = "影精灵"
	return 角色信息[ID]
end

function 场景类_场景:队伍角色(模型)
	local 角色信息 = {
		飞燕女 = {模型="飞燕女",ID=1,染色方案=3,性别="女",种族="人",门派={"大唐官府","女儿村","方寸山","神木林"},武器={"双剑","环圈"}},
		英女侠 = {模型="英女侠",ID=2,染色方案=4,性别="女",种族="人",门派={"大唐官府","女儿村","方寸山","神木林"},武器={"双剑","鞭"}},
		巫蛮儿 = {模型="巫蛮儿",ID=3,染色方案=13,性别="女",种族="人",门派={"大唐官府","女儿村","方寸山","神木林"},武器={"宝珠","法杖"}},
		逍遥生 = {模型="逍遥生",ID=4,染色方案=1,性别="男",种族="人",门派={"大唐官府","化生寺","方寸山","神木林"},武器={"扇","剑"}},
		剑侠客 = {模型="剑侠客",ID=5,染色方案=2,性别="男",种族="人",门派={"大唐官府","化生寺","方寸山","神木林"},武器={"刀","剑"}},
		狐美人 = {模型="狐美人",ID=6,染色方案=7,性别="女",种族="魔",门派={"盘丝洞","阴曹地府","魔王寨","无底洞"},武器={"爪刺","鞭"}},
		骨精灵 = {模型="骨精灵",ID=7,染色方案=8,性别="女",种族="魔",门派={"盘丝洞","阴曹地府","魔王寨","无底洞"},武器={"魔棒","爪刺"}},
		杀破狼 = {模型="杀破狼",ID=8,染色方案=15,性别="男",种族="魔",门派={"狮驼岭","阴曹地府","魔王寨","无底洞"},武器={"宝珠","弓弩"}},
		巨魔王 = {模型="巨魔王",ID=9,染色方案=5,性别="男",种族="魔",门派={"狮驼岭","阴曹地府","魔王寨","无底洞"},武器={"刀","斧钺"}},
		虎头怪 = {模型="虎头怪",ID=10,染色方案=6,性别="男",种族="魔",门派={"狮驼岭","阴曹地府","魔王寨","无底洞"},武器={"斧钺","锤子"}},
		舞天姬 = {模型="舞天姬",ID=11,染色方案=11,性别="女",种族="仙",门派={"天宫","普陀山","龙宫","凌波城"},武器={"飘带","环圈"}},
		玄彩娥 = {模型="玄彩娥",ID=12,染色方案=12,性别="女",种族="仙",门派={"天宫","普陀山","龙宫","凌波城"},武器={"飘带","魔棒"}},
		羽灵神 = {模型="羽灵神",ID=13,染色方案=17,性别="男",种族="仙",门派={"天宫","普陀山","龙宫","凌波城"},武器={"法杖","弓弩"}},
		神天兵 = {模型="神天兵",ID=14,染色方案=9,性别="男",种族="仙",门派={"天宫","五庄观","龙宫","凌波城"},武器={"锤","枪矛"}},
		龙太子 = {模型="龙太子",ID=15,染色方案=10,性别="男",种族="仙",门派={"天宫","五庄观","龙宫","凌波城"},武器={"扇","枪矛"}},
		桃夭夭 = {模型="桃夭夭",ID=16,染色方案=18,性别="女",种族="仙",门派={"天宫","普陀山","龙宫","凌波城"},武器={"灯笼"}},
		偃无师 = {模型="偃无师",ID=17,染色方案=14,性别="男",种族="人",门派={"大唐官府","化生寺","方寸山","神木林"},武器={"剑","巨剑"}},
		鬼潇潇 = {模型="鬼潇潇",ID=18,染色方案=16,性别="女",种族="魔",门派={"盘丝洞","阴曹地府","魔王寨","无底洞"},武器={"爪刺","伞"}},
    影精灵 = {模型="影精灵",ID=18,染色方案=16,性别="女",种族="魔",门派={"九黎城"},武器={"魔棒","爪刺","双斧"}},
	}

	return 角色信息[模型]
end

function 场景类_场景:取初始属性(种族)
	local 属性 = {
		人 = {10,10,10,10,10},
		魔 = {12,11,11,8,8},
		仙 = {12,5,11,12,10},
	}
	return 属性[种族]
end


function 场景类_场景:取属性(种族,五维,技能)
	local 属性={}
	local 力量 = 五维[3]
	local 体力 = 五维[1]
	local 魔力 = 五维[2]
	local 耐力 = 五维[4]
	local 敏捷 = 五维[5]
	技能 = 技能 or {0,0,0,0}
	if 种族 =="人" or 种族 == 1 then
		属性={
					命中=math.ceil(力量*2+30),
					伤害=math.ceil(力量*0.67+39),
					防御=math.ceil(耐力*1.5),
					速度=math.ceil(敏捷),
					灵力=math.ceil(体力*0.3+魔力*0.7+耐力*0.2+力量*0.4),
					躲避=math.ceil(敏捷+10),
					气血=math.ceil((体力*5+100)*(1+技能[1]/100)+技能[3]*4),
					法力=math.ceil((魔力*3+80)*(1+技能[2]/100)),
		}
	elseif 种族 =="魔" or 种族 == 2 then
		属性={
					命中=math.ceil(力量*2.3+29),
					伤害=math.ceil(力量*0.77+39),
					防御=math.ceil(耐力*214/153),
					速度=math.ceil(敏捷),
					灵力=math.ceil(体力*0.3+魔力*0.7+耐力*0.2+力量*0.4-0.3),
					躲避=math.ceil(敏捷+10),
					气血=math.ceil((体力*6+100)*(1+技能[1]/100)+技能[3]*4),
					法力=math.ceil((魔力*2.5+80)*(1+技能[2]/100)),
		}
	elseif 种族 =="仙" or 种族 == 3 then
		属性={
					命中=math.ceil(力量*1.7+30),
					伤害=math.ceil(力量*0.57+39),
					防御=math.ceil(耐力*1.6),
					速度=math.ceil(敏捷),
					灵力=math.ceil(体力*0.3+魔力*0.7+耐力*0.2+力量*0.4-0.3),
					躲避=math.ceil(敏捷+10),
					气血=math.ceil((体力*4.5+100)*(1+技能[1]/100)+技能[3]*4),
					法力=math.ceil((魔力*3.5+80)*(1+技能[2]/100)),
		}
	end
	return 属性
end

function 场景类_场景:取经验(id,lv)
	local exp={}
	if id==1 then
		exp={
			40,110,237,450,779,1252,1898,2745,3822,5159,6784,8726,11013,13674,16739,20236,24194,28641,33606,39119,45208,
			51902,55229,67218,75899,85300,95450,106377,118110,130679,144112,158438,173685,189882,207059,225244,244466,264753,
			286134,308639,332296,357134,383181,410466,439019,468868,500042,532569,566478,601799,638560,676790,716517,757770,
			800579,844972,890978,938625,987942,1038959,1091704,1146206,1202493,1260594,1320539,1382356,1446074,1511721,1579326,
			1648919,1720528,1794182,1869909,1947738,2027699,2109820,2194130,2280657,2369431,2460479,2553832,2649518,2747565,
			2848003,2950859,3056164,3163946,3274233,3387055,3502439,3620416,3741014,3864261,3990187,4118819,4250188,4384322,
			4521249,4660999,4803599,4998571,5199419,5406260,5619213,5838397,6063933,6295941,6534544,6779867,7032035,7291172,
			7557407,7830869,8111686,8399990,8695912,8999586,9311145,9630726,9958463,10294496,10638964,10992005,11353761,11724374,
			12103988,12492748,12890799,13298287,13715362,14142172,14578867,15025600,15482522,15949788,16427552,16915970,17415202,
			17925402,18446732,18979354,19523428,20079116,20646584,21225998,43635044,44842648,46075148,47332886,48616200,74888148,
			76891401,78934581,81018219,83142835,85308969,87977421,89767944,92061870,146148764,150094780,154147340,158309318,
			162583669,166973428,171481711,176111717,180866734,185780135,240602904,533679362,819407100,1118169947, 1430306664,
			1756161225,2096082853
		}
	else
		exp={
			50,200,450,800,1250,1800,2450,3250,4050,5000,6050,7200,8450,9800,11250,12800,14450,16200,18050,20000,22050,24200,
			26450,28800,31250,33800,36450,39200,42050,45000,48050,51200,54450,57800,61250,64800,68450,72200,76050,80000,84050,
			88200,92450,96800,101250,105800,110450,115200,120050,125000,130050,135200,140450,145800,151250,156800,162450,
			168200,174050,180000,186050,192200,198450,204800,211250,217800,224450,231200,238050,245000,252050,259200,266450,
			273800,281250,288800,296450,304200,312050,320000,328050,336200,344450,352800,361250,369800,378450,387200,396050,
			405000,414050,423200,432450,441800,451250,460800,470450,480200,490050,500000,510050,520200,530450,540800,551250,
			561800,572450,583200,594050,605000,616050,627200,638450,649800,661250,672800,684450,696200,708050,720000,732050,
			744200,756450,768800,781250,793800,806450,819200,832050,845000,858050,871200,884450,897800,911250,924800,938450,
			952200,966050,980000,994050,1008200,1022450,1036800,1051250,1065800,1080450,1095200,1110050,1125000,1140050,1155200,
			1170450,1185800,1201250,1216800,1232450,1248200,1264050,1280000,1300000,1340000,1380000,1420000,1460000,1500000,1540000,
			1580000,1700000,1780000,1820000,1940000,2400000,2880000,3220000,4020000,4220000,4420000,4620000,5220000,5820000,6220000,
			7020000,8020000,9020000
		}
	end
	return exp[lv+1]
end

function 场景类_场景:取称谓说明(称谓)
	local n = {}
	n["梦幻测试"] = "欢迎测试梦幻西游(本称谓为纪念称谓)#91"
	n["梦幻新秀"] = "欢迎测试梦幻西游(本称谓为纪念称谓)#91"
	n["内测用户"] = "欢迎测试梦幻西游(本称谓为纪念称谓)#91"
	n["无称谓"] = "对不起!你目前无称谓哦,请继续加油.#9"
	n["帮众"] = "帮派证明身份的基础标识.#9"
	n["堂主"] = "作为一帮堂主的身份标识.#9"
	n["长老"] = "作为一帮长老的身份标识.#9"
	n["护法"] = "作为一帮护法的身份标识.#9"
	n["帮主"] = "作为一帮帮主的身份标识.#9"
  n["武神坛冠军"] = "限时称号，某种实力的象征."
	n["武神坛亚军"] = "限时称号，某种实力的象征."
	n["武神坛季军"] = "限时称号，某种实力的象征."
  n["大唐官府首席大弟子"] = "实力的象征\n#Y+10伤害#R+10灵力\n#G+10速度#L+10防御\n#P+100气血"
  n["神木林首席大弟子"] = "实力的象征\n#Y+10伤害#R+10灵力\n#G+10速度#L+10防御\n#P+100气血"
  n["方寸山首席大弟子"] = "实力的象征\n#Y+10伤害#R+10灵力\n#G+10速度#L+10防御\n#P+100气血"
  n["化生寺首席大弟子"] = "实力的象征\n#Y+10伤害#R+10灵力\n#G+10速度#L+10防御\n#P+100气血"
  n["女儿村首席大弟子"] = "实力的象征\n#Y+10伤害#R+10灵力\n#G+10速度#L+10防御\n#P+100气血"
  n["天宫首席大弟子"] = "实力的象征\n#Y+10伤害#R+10灵力\n#G+10速度#L+10防御\n#P+100气血"
  n["普陀山首席大弟子"] = "实力的象征\n#Y+10伤害#R+10灵力\n#G+10速度#L+10防御\n#P+100气血"
  n["五庄观首席大弟子"] = "实力的象征\n#Y+10伤害#R+10灵力\n#G+10速度#L+10防御\n#P+100气血"
  n["凌波城首席大弟子"] = "实力的象征\n#Y+10伤害#R+10灵力\n#G+10速度#L+10防御\n#P+100气血"
  n["龙宫首席大弟子"] = "实力的象征\n#Y+10伤害#R+10灵力\n#G+10速度#L+10防御\n#P+100气血"
  n["魔王寨首席大弟子"] = "实力的象征\n#Y+10伤害#R+10灵力\n#G+10速度#L+10防御\n#P+100气血"
  n["狮驼岭首席大弟子"] = "实力的象征\n#Y+10伤害#R+10灵力\n#G+10速度#L+10防御\n#P+100气血"
  n["盘丝洞首席大弟子"] = "实力的象征\n#Y+10伤害#R+10灵力\n#G+10速度#L+10防御\n#P+100气血"
  n["无底洞首席大弟子"] = "实力的象征\n#Y+10伤害#R+10灵力\n#G+10速度#L+10防御\n#P+100气血"
  n["阴曹地府首席大弟子"] = "实力的象征\n#Y+10伤害#R+10灵力\n#G+10速度#L+10防御\n#P+100气血"
  n["大海龟杀手"] = "+10点血量"
  n["荒漠屠夫"] = "+10点伤害"
  n["僵尸道长"] = "+10点灵力"
  n["快递小哥"] = "+10点速度"
  n["摸金校尉"] = "+10点防御"
  n["当代清官"] = "+5点伤害和灵力"
  n["首席小弟子"] = "#Y+2伤害#R+2灵力\n#G+2速度#L+2防御\n#P+10气血"
  n["英雄大会冠军"] = "限时称号，实力的象征\n#Y+200伤害#R+200灵力\n#G+200速度#L+200防御\n#P+500气血"
  n["英雄大会亚军"] = "限时称号，实力的象征\n#Y+150伤害#R+150灵力\n#G+150速度#L+150防御\n#P+300气血"
  n["英雄大会季军"] = "限时称号，实力的象征\n#Y+100伤害#R+100灵力\n#G+100速度#L+100防御\n#P+200气血"
  n["英雄大会精英"] = "限时称号，积极参与活动\n#Y+50伤害#R+50灵力\n#G+50速度#L+50防御\n#P+100气血"
  n["大罗金仙"] = "5大基础属性+50"
  n["先天圣人"] = "5大基础属性+150"
  n["千亿称号[血]"] = "最大气血+2000"
  n["千亿称号[伤]"] = "伤害+1000"
  n["千亿称号[法]"] = "灵力+800"
  n["千亿称号[防]"] = "防御+800"
  n["千亿称号[速]"] = "速度+600"
  n["绝世英豪"] = "实力的象征,该称谓增加全属性#P5%"
  n["横扫天下"] = "实力的象征,该称谓增加全属性#P10%"
  n["独孤求败"] = "实力的象征,该称谓增加全属性#P20%"
  n["合格菜商"] = "GM认证出菜人员，可以交易，有问题一切以聊天截图，后台记录进行判定处理！"
  n["彩虹霸主"] = "限时称号，积极参与活动\n#Y+200伤害#R+150法伤\n#G+100速度"
  n["帮战之星"] = "限时称号，积极参与活动\n#Y+350气血#R+150防御\n#G+100法防"
  if string.find(称谓,"镇妖塔") ~= nil then
        local 临时称谓=分割文本(称谓,"镇妖塔")
        if 临时称谓~=nil and  临时称谓[2]~=nil then
            local 临时层数 = 分割文本(临时称谓[2],"层")
            if 临时层数~=nil and  临时层数[1]~=nil and tonumber(临时层数[1])~=nil and tonumber(临时层数[1])>0 then
               local 临时倍数 = math.floor(tonumber(临时层数[1])/10)
               local 气血=  300*临时倍数
               local 伤害 = 50*临时倍数
               local 防御 = 50*临时倍数
               local 灵力 = 40*临时倍数
               local 速度=20*临时倍数
              return  "#L/实力的象征:\n#P/+"..伤害.."伤害 +"..灵力.."灵力\n#P/+"..速度.."速度 +"..防御.."防御\n#P/+"..气血.."气血"
            end
        else
        	 return  "实力的象征,该称谓增加属性.#9"
        end
  end

	if n[称谓]==nil and n[string.sub(称谓,-4)] == nil then
	    n[称谓]="暂时没有该称谓的记载!.#9"
	elseif n[string.sub(称谓,-4)] ~= nil then
		return n[string.sub(称谓,-4)]
	end
	if 称谓==nil or 称谓=="" then
	   return  "对不起!你目前无称谓哦,请继续加油.#9"
	end
	return n[称谓]
end

function 场景类_场景:取武器附加名称(子类,级别限制,名称)
	if 子类 == 1 then
		if 级别限制 < 21 then
			return "红缨枪"
		elseif 级别限制 > 20 and 级别限制 < 51 then
			return "乌金三叉戟"
		elseif 级别限制 > 59 and 级别限制 < 90 then
			return "玄铁矛"
		end
	elseif 子类 == 2 then
		if 级别限制 < 21 then
			return "青铜斧"
		elseif 级别限制 > 20 and 级别限制 < 51 then
			return "双弦钺"
		elseif 级别限制 > 59 and 级别限制 < 90 then
			return "乌金鬼头镰"
		end
	elseif 子类 == 3 then
		if 级别限制 < 21 then
			return "青铜短剑"
		elseif 级别限制 > 20 and 级别限制 < 51 then
			return "青锋剑"
		elseif 级别限制 > 59 and 级别限制 < 90 then
			return "游龙剑"
		end
	elseif 子类 == 4 then
		if 级别限制 < 21 then
			return "双短剑"
		elseif 级别限制 > 20 and 级别限制 < 51 then
			return "竹节双剑"
		elseif 级别限制 > 59 and 级别限制 < 90 then
			return "赤焰双剑"
		end
	elseif 子类 == 5 then
		if 级别限制 < 21 then
			return "五色缎带"
		elseif 级别限制 > 20 and 级别限制 < 51 then
			return "无极丝"
		elseif 级别限制 > 59 and 级别限制 < 90 then
			return "七彩罗刹"
		end
	elseif 子类 == 6 then
		if 级别限制 < 21 then
			return "铁爪"
		elseif 级别限制 > 20 and 级别限制 < 51 then
			return "青龙牙"
		elseif 级别限制 > 59 and 级别限制 < 90 then
			return "青刚刺"
		end
	elseif 子类 == 7 then
		if 级别限制 < 21 then
			return "折扇"
		elseif 级别限制 > 20 and 级别限制 < 51 then
			return "铁面扇"
		elseif 级别限制 > 59 and 级别限制 < 90 then
			return "神火扇"
		end
	elseif 子类 == 8 then
		if 级别限制 < 21 then
			return "细木棒"
		elseif 级别限制 > 20 and 级别限制 < 51 then
			return "点金棒"
		elseif 级别限制 > 59 and 级别限制 < 90 then
			return "满天星"
		end
	elseif 子类 == 9 then
		if 级别限制 < 21 then
			return "松木锤"
		elseif 级别限制 > 20 and 级别限制 < 51 then
			return "狼牙锤"
		elseif 级别限制 > 59 and 级别限制 < 90 then
			return "震天锤"
		end
	elseif 子类 == 10 then
		if 级别限制 < 21 then
			return "牛皮鞭"
		elseif 级别限制 > 20 and 级别限制 < 51 then
			return "钢结鞭"
		elseif 级别限制 > 59 and 级别限制 < 90 then
			return "青藤柳叶鞭"
		end
	elseif 子类 == 11 then
		if 级别限制 < 21 then
			return "黄铜圈"
		elseif 级别限制 > 20 and 级别限制 < 51 then
			return "金刺轮"
		elseif 级别限制 > 59 and 级别限制 < 90 then
			return "蛇形月"
		end
	elseif 子类 == 12 then
		if 级别限制 < 21 then
			return "柳叶刀"
		elseif 级别限制 > 20 and 级别限制 < 51 then
			return "金背大砍刀"
		elseif 级别限制 > 59 and 级别限制 < 90 then
			return "狼牙刀"
		end
	elseif 子类 == 13 then
		if 级别限制 < 21 then
			return "曲柳杖"
		elseif 级别限制 > 20 and 级别限制 < 51 then
			return "墨铁拐"
		elseif 级别限制 > 59 and 级别限制 < 90 then
			return "腾云杖"
		end
	elseif 子类 == 14 then
		if 级别限制 < 21 then
			return "硬木弓"
		elseif 级别限制 > 20 and 级别限制 < 51 then
			return "宝雕长弓"
		elseif 级别限制 > 59 and 级别限制 < 90 then
			return "连珠神弓"
		end
	elseif 子类 == 15 then
		if 级别限制 < 21 then
			return "琉璃珠"
		elseif 级别限制 > 20 and 级别限制 < 51 then
			return "翡翠珠"
		elseif 级别限制 > 59 and 级别限制 < 90 then
			return "如意宝珠"
		end
	elseif 子类 == 16 then
		if 级别限制 < 21 then
			return "钝铁重剑"
		elseif 级别限制 > 20 and 级别限制 < 51 then
			return "壁玉长铗"
		elseif 级别限制 > 59 and 级别限制 < 90 then
			return "惊涛雪"
		end
	elseif 子类 == 17 then
		if 级别限制 < 21 then
			return "红罗伞"
		elseif 级别限制 > 20 and 级别限制 < 51 then
			return "琳琅盖"
		elseif 级别限制 > 59 and 级别限制 < 90 then
			return "金刚伞"
		end
	elseif 子类 == 18 then
		if 级别限制 < 21 then
			return "素纸灯"
		elseif 级别限制 > 20 and 级别限制 < 51 then
			return "如意宫灯"
		elseif 级别限制 > 59 and 级别限制 < 90 then
			return "玉兔盏"
		end
	end
	return 名称
end

function 场景类_场景:取武器子类(子类)
	local n = {"枪矛","斧钺","剑","双短剑","飘带","爪刺","扇","魔棒","锤","鞭","环圈","刀","法杖","弓弩","宝珠","巨剑","伞","灯笼","头盔","发钗","项链","女衣","男衣","腰带","鞋子","双斧"}
	return n[子类]
end

function 场景类_场景:获取宝宝(模型,名称,类型,属性,等级,染色方案,技能组,资质组,成长,参战等级,属性表)
	local n = self._宝宝()
	local mx = 模型 == "小毛头" or 模型 == "小丫丫"
	if mx then
		类型 = "孩子"
	end
	n:置新对象(模型,名称,类型,属性,等级,染色方案,技能组,资质组,成长,参战等级,属性表)
	if not mx then
		if #self.队伍[1].宝宝列表 < 10 then
			table.insert(self.队伍[1].宝宝列表, n)
		else
			self.窗口.消息框:添加文本(self.队伍[1].名称.."携带的召唤兽已到上限无法再获得召唤兽，请放生一只召唤兽")
		end
	else
		if #self.队伍[1].子女列表 < 10 then
			table.insert(self.队伍[1].子女列表, n)
		else
			self.窗口.消息框:添加文本(self.队伍[1].名称.."你携带的孩子已经太多了，不能再获得孩子了")
		end
	end
end

function 场景类_场景:取门派技能(门派)
	local n = {}
	if 门派 == "大唐官府" then
		return {"为官之道","无双一击","神兵鉴赏","疾风步","十方无敌","紫薇之术","文韬武略"}
	elseif 门派 == "方寸山" then
		return {"黄庭经","磐龙灭法","霹雳咒","符之术","归元心法","神道无念","斜月步"}
	elseif 门派 == "化生寺" then
		return {"小乘佛法","金刚伏魔","诵经","佛光普照","大慈大悲","歧黄之术","渡世步"}
	elseif 门派 == "女儿村" then
		return {"毒经","倾国倾城","沉鱼落雁","闭月羞花","香飘兰麝","玉质冰肌","清歌妙舞"}
	elseif 门派 == "阴曹地府" then
		return {"灵通术","六道轮回","幽冥术","拘魂诀","九幽阴魂","尸腐恶","无常步"}
	elseif 门派 == "魔王寨" then
		return {"牛逼神功","震天诀","火云术","火牛阵","牛虱阵","回身击","裂石步"}
	elseif 门派 == "狮驼岭" then
		return {"魔兽神功","生死搏","训兽诀","阴阳二气诀","狂兽诀","大鹏展翅","魔兽反噬"}
	elseif 门派 == "盘丝洞" then
		return {"蛛丝阵法","迷情大法","秋波暗送","天外魔音","盘丝大法","盘丝步","姊妹相随"}
	elseif 门派 == "天宫" then
		return {"天罡气","傲世诀","清明自在","宁气诀","乾坤塔","混天术","云霄步"}
	elseif 门派 == "五庄观" then
		return {"周易学","潇湘仙雨","乾坤袖","修仙术","混元道果","明性修身","七星遁"}
	elseif 门派 == "龙宫" then
		return {"九龙诀","破浪诀","呼风唤雨","龙腾术","逆鳞术","游龙术","龙附术"}
	elseif 门派 == "普陀山" then
		return {"灵性","护法金刚","观音咒","五行学说","金刚经","五行扭转","莲花宝座"}
	elseif 门派 == "神木林" then
		return {"瞬息万变","万灵诸念","巫咒","万物轮转","天人庇护","神木恩泽","驭灵咒"}
	elseif 门派 == "凌波城" then
		return {"天地无极","九转玄功","武神显圣","啸傲","气吞山河","诛魔","法天象地"}
	elseif 门派 == "无底洞" then
		return  {"枯骨心法","阴风绝章","鬼蛊灵蕴","燃灯灵宝","地冥妙法","混元神功","秘影迷踪"}
  elseif 门派 == "九黎城" then   ---九黎
    return  {"魂枫战舞","兵铸乾坤","燃铁飞花","战火雄魂","魔神降世","风行九黎"}

	end
end

function 场景类_场景:取门派主技能(门派)
	if 门派 == 1 then
		a = {"催眠符","落雷符","追魂符","五雷咒","定身符","定身符"}
	elseif 门派 == 2 then
		a = {"红袖添香","楚楚可怜","满天花雨","雨落寒沙","子母神针","莲步轻舞","如花解语"}
	elseif 门派 == 3 then
		a = {"落叶萧萧","冰川怒","血雨","雾杀","星月之惠","蜜润"}
	elseif 门派 == 4 then
		a = {"唧唧歪歪","谆谆教诲","韦陀护法","金刚护体","达摩护体","一苇渡江","金刚护法","我佛慈悲","推拿","解毒","活血","推气过宫","妙手回春","救死扶伤"}
	elseif 门派 == 5 then
		a = {"杀气决","后发制人","横扫千军","破釜沉舟"}
	elseif 门派 == 6 then
		a = {"还阳术","阎罗令","判官令"}
	elseif 门派 == 7 then
		a = {"勾魂","摄魄","含情脉脉"}
	elseif 门派 == 8 then
		a = {"移魂化骨","夺魄令","煞气决","惊魂掌","摧心术","夺命咒","地涌金莲"}
	elseif 门派 == 9 then
		a = {"三昧真火","飞砂走石","牛劲"}
	elseif 门派 == 10 then
		a = {"连环击","鹰击","狮搏","象形","变身"}
	elseif 门派 == 11 then
		a = {"五雷轰顶","天雷斩","百万神兵","天神护体","天神护法","雷霆万钧"}
	elseif 门派 == 12 then
		a = {"普渡众生","紧箍咒","杨柳甘露","日光华","靛沧海","巨岩破","苍茫树","地裂火","颠倒五行","灵动九天"}
	elseif 门派 == 13 then
		a = {"不动如山","碎星诀","裂石","浪涌","断岳势","天崩地裂","翻江搅海","惊涛怒"}
	elseif 门派 == 14 then
		a = {"烟雨剑法","飘渺式","日月乾坤","炼气化神","生命之泉","三花聚顶"}
	elseif 门派 == 15 then
		a = {"龙卷雨击","龙腾","龙吟","逆鳞","乘风破浪","双龙戏珠"}
	end
	return a
end

function 场景类_场景:取辅助技能()
	return {"强身术","冥想","暗器技巧","打造技巧","裁缝技巧","炼金术","中药医理","烹饪技巧","逃离技巧","追捕技巧","养生之道","健身术","淬灵之术"}
end

function 场景类_场景:取师傅门派(ID,名称)
	local 师门 = nil
	if 名称 == "程咬金" then
		师门 = "大唐官府"
	elseif 名称 == "地藏王" then
		师门 = "阴曹地府"
	elseif 名称 == "二郎神" then
		师门 = "凌波城"
	elseif 名称 == "大大王" then
		师门 = "狮驼岭"
	elseif 名称 == "空度禅师" then
		师门 = "化生寺"
	elseif 名称 == "巫奎虎" then
		师门 = "神木林"
	elseif 名称 == "地涌夫人" then
		师门 = "无底洞"
	elseif 名称 == "菩提祖师" then
		师门 = "方寸山"
	elseif 名称 == "孙婆婆" then
		师门 = "女儿村"
	elseif 名称 == "白晶晶" then
		师门 = "盘丝洞"
	elseif 名称 == "李靖" then
		师门 = "天宫"
	elseif 名称 == "观音姐姐" then
		师门 = "普陀山"
	elseif 名称 == "镇元子" then
		师门 = "五庄观"
	elseif 名称 == "东海龙王" then
		师门 = "龙宫"
	elseif 名称 == "牛魔王" then
		师门 = "魔王寨"
  elseif 名称 == "刑天" then
    师门 = "九黎城"
	end
	return 师门
end

function 场景类_场景:取师门地图(师门)
	local 地图
	if 师门 == "化生寺" then
		地图 = 1002
	elseif 师门 == "方寸山" then
		地图 = 1135
	elseif 师门 == "女儿村" then
		地图 = 1142
	elseif 师门 == "神木林" then
		地图 = 1138
	elseif 师门 == "大唐官府" then
		地图 = 1198
	elseif 师门 == "阴曹地府" then
		地图 = 1122
	elseif 师门 == "盘丝洞" then
		地图 = 1513
	elseif 师门 == "无底洞" then
		地图 = 1139
	elseif 师门 == "魔王寨" then
		地图 = 1512
	elseif 师门 == "狮驼岭" then
		地图 = 1131
	elseif 师门 == "天宫" then
		地图 = 1111
	elseif 师门 == "普陀山" then
		地图 = 1140
	elseif 师门 == "凌波城" then
		地图 = 1150
	elseif 师门 == "五庄观" then
		地图 = 1146
	elseif 师门 == "龙宫" then
		地图 = 1116

  elseif 师门 == "九黎城" then
    地图 = 2008
	end
	return 地图
end

function 场景类_场景:取坐标师傅(ID,名称)
	local 师门 = nil
	if ID == 1043 and 名称 == "空度禅师" then
		师门 = "化生寺"
	elseif ID == 1054 and 名称 == "程咬金" then
		师门 = "大唐官府"
	elseif ID == 1117 and 名称 == "东海龙王" then
		师门 = "龙宫"
	elseif ID == 1137 and 名称 == "菩提祖师" then
		师门 = "方寸山"
	elseif ID == 1124 and 名称 == "地藏王" then
		师门 = "阴曹地府"
	elseif ID == 1112 and 名称 == "李靖" then
		师门 = "天宫"
	elseif ID == 1145 and 名称 == "牛魔王" then
		师门 = "魔王寨"
	elseif ID == 1141 and 名称 == "观音姐姐" then
		师门 = "普陀山"
	elseif ID == 1147 and 名称 == "镇元子" then
		师门 = "五庄观"
	elseif ID == 1134 and 名称 == "大大王" then
		师门 = "狮驼岭"
	elseif ID == 1144 and 名称 == "白晶晶" then
		师门 = "盘丝洞"
	elseif ID == 1150 and 名称 == "二郎神" then
		师门 = "凌波城"
	elseif ID == 1154 and 名称 == "巫奎虎" then
		师门 = "神木林"
	elseif ID == 1156 and 名称 == "地涌夫人" then
		师门 = "无底洞"
	elseif ID == 1143 and 名称 == "孙婆婆" then
		师门 = "女儿村"
  elseif ID == 2008 and 名称 == "刑天" then
    师门 = "九黎城"


	end
	return 师门
end

function 场景类_场景:刷新队伍()
	if self.窗口.召唤兽属性栏.可视 then
		for s=1,7 do
			if self.队伍[1].宝宝列表[s] ~= nil then
				self.队伍[1].宝宝列表[s].潜力 = self.队伍[1].宝宝列表[s].潜力 + (self.窗口.召唤兽属性栏.临时潜力[s].体质 + self.窗口.召唤兽属性栏.临时潜力[s].魔力 + self.窗口.召唤兽属性栏.临时潜力[s].力量 + self.窗口.召唤兽属性栏.临时潜力[s].耐力 + self.窗口.召唤兽属性栏.临时潜力[s].敏捷)
			end
			self.窗口.召唤兽属性栏.临时潜力[s] = {体质=0,魔力=0,力量=0,耐力=0,敏捷=0}
			self.窗口.召唤兽属性栏.预览属性[s] = {气血=0,魔法=0,伤害=0,速度=0,灵力=0,防御=0}
		end
	end
	if self.窗口.人物状态栏.可视 then
		self.队伍[1].潜力 = self.队伍[1].潜力 + (self.窗口.人物状态栏.临时潜力.体质 + self.窗口.人物状态栏.临时潜力.魔力 + self.窗口.人物状态栏.临时潜力.力量 + self.窗口.人物状态栏.临时潜力.耐力 + self.窗口.人物状态栏.临时潜力.敏捷)
		self.窗口.人物状态栏.临时潜力 = {体质=0,魔力=0,力量=0,耐力=0,敏捷=0}
		self.窗口.人物状态栏.预览属性 = {气血=0,魔法=0,命中=0,伤害=0,速度=0,灵力=0,防御=0,法伤=0,躲避=0}
	end
	self.窗口.人物状态栏:刷新()
	self.窗口.召唤兽属性栏:刷新()
	self.窗口.道具行囊:刷新()
end

function 场景类_场景:增加经验(exp,id,ts)
	if id == nil then
		for i=1,#self.队伍 do
			self.队伍[i].当前经验 = self.队伍[i].当前经验 + exp
			if self.队伍[i].参战宝宝.名称 ~= nil then
				self.队伍[i].参战宝宝.当前经验 = self.队伍[i].参战宝宝.当前经验 + exp
			end
		end
	else
		self.队伍[id].当前经验 = self.队伍[id].当前经验 + exp
		if self.队伍[id].参战宝宝.名称 ~= nil then
			self.队伍[id].参战宝宝.当前经验 = self.队伍[id].参战宝宝.当前经验 + exp
		end
	end
	if ts then
		self.常规提示:打开("#Y/你获得了#G/"..exp.."#Y/点经验")
	end
end

function 场景类_场景:平均等级()
	local dj = 0
	for i=1,#self.队伍 do
		dj = dj + self.队伍[i].等级
	end
	return math.floor(dj/#self.队伍)
end

function 场景类_场景:指定等级物品(lv,id)
	local wps = self.打造物品[id]
	local random = 引擎.取随机整数
	local ids = math.floor(lv/10+1)
	if id <= 18 and lv >= 90 and lv <= 140 then
		if ids <= 12 then
			ids = random(10,12)
		else
		    ids = random(13,15)
		end
	end
	wps = wps[ids]
	if type(wps) == "table" then
		wps = wps[random(1,2)]
	end
	return wps
end


function 场景类_场景:播放特效(地图,模型,名称,特效,帧率)
	if self.当前地图 == 地图 then
		for i=1,#self.场景.假人 do
			if self.场景.假人[i].模型 == 模型 and self.场景.假人[i].名称 == 名称 then
				self.场景.假人[i].特效 = self:载入特效(特效)
				self.场景.假人[i].帧率 = 帧率
				local mc = 引擎.取音效(特效)
				if mc ~= nil then
					音效类_(mc.文件,mc.资源)
				end
				break
			end
		end
	end
end

function 场景类_场景:可坐骑(人物,坐骑)
	if 坐骑 == "宝贝葫芦" then
		return true
	elseif 坐骑 == "神气小龟" then
		if 人物.模型 ~= "偃无师" and 人物.模型 ~= "鬼潇潇" and 人物.模型 ~= "桃夭夭" then
			return true
		end
	elseif (坐骑 == "汗血宝马" or 坐骑 == "汉血宝马" or 坐骑 == "欢喜羊羊") and 人物.种族 == "人" and 人物.模型 ~= "偃无师" then
		return true
	elseif (坐骑 == "魔力斗兽" or 坐骑 == "披甲战狼") and 人物.种族 == "魔" and 人物.模型 ~= "鬼潇潇" then
		return true
	elseif (坐骑 == "闲云野鹤" or 坐骑 == "云魅仙鹿") and 人物.种族 == "仙" and 人物.模型 ~= "桃夭夭" then
		return true
	end
	return false
end

function 场景类_场景:取y偏移(头像)
	if 头像 == "杀破狼" then
		return 35
	elseif 头像 == "巫蛮儿" then
		return 19
	elseif 头像 == "羽灵神" then
		return 25
	elseif 头像 == "吸血鬼" then
		return 25
	elseif 头像 == "鬼潇潇" then
		return 1
	elseif 头像 == "桃夭夭" then
		return 58
	elseif 头像 == "偃无师" then
		return 33
	elseif 头像 == "曼珠沙华" or 头像 == "狂豹人形" then
		return 303
	elseif 头像 == "鲛人" then
		return 27
	elseif 头像 == "犀牛将军_人" then
		return 32
	elseif 头像 == "野猪精" then
		return 25
	elseif 头像 == "修罗傀儡妖" or 头像 == "金身罗汉" then
		return 235
	elseif 头像 == "猫灵人形" then
		return 275
	elseif 头像 == "蔓藤妖花"  or 头像 == "修罗傀儡鬼"then
		return 260
	elseif 头像 == "混沌兽" then
		return 350
	elseif 头像 == "蜃气妖" then
		return 215
	elseif 头像 == "泡泡"   then
		return 20
	elseif 头像 == "福星" or 头像 == "长眉灵猴" or 头像 == "巨力神猿" then
		return 28
	elseif 头像 == "葫芦宝贝" then
		return 336
	elseif 头像 == "蝎子精" then
		return 236
	elseif 头像 == "猫灵兽形" or 头像 == "猫灵" then
		return 377
	elseif 头像 == "狂豹兽形" then
		return 363
  elseif 头像 == "灵鹤" then
    return 50
	elseif 头像 == "物件_打铁炉" then
		return -63
	elseif 头像 == "银两" or 头像 == "食物" or 头像 == "口粮" or 头像 == "摄妖香" or 头像 == "药品" then
		return -20
	--===========================
	end
	return 0
end

function 引擎.取物品功效(物品,品质,食材)
	local pg = {}
	if 物品 == "四叶花" then
		pg.气血 = 40
	elseif 物品 == "七叶莲" then
		pg.气血 = 60
	elseif 物品 == "天青地白" then
		pg.气血 = 80
	elseif 物品 == "紫丹罗" or 物品 == "佛手" or 物品 == "旋复花" then
		pg.魔法 = 20
	elseif 物品 == "百色花" or 物品 == "香叶" or 物品 == "龙须草" then
		pg.魔法 = 30
	elseif 物品 == "灵脂" or 物品 == "白玉骨头" then
		pg.魔法 = 40
	elseif 物品 == "曼佗罗花" then
		pg.魔法 = 50
	elseif 物品 == "天不老" or 物品 == "紫石英" then
		pg.气血 = 100
	elseif 物品 == "鹿茸" or 物品 == "血色茶花" then
		pg.气血 = 150
	elseif 物品 == "六道轮回" or 物品 == "熊胆"  then
		pg.气血 = 200
	elseif 物品 == "凤凰尾" or 物品 == "硫磺草" then
		pg.气血 = 250
	elseif 物品 == "龙之心屑" or 物品 == "火凤之睛" then
		pg.气血 = 300
	elseif 物品 == "丁香水" or 物品 == "月星子" then
		pg.魔法 = 100
	elseif 物品 == "仙狐涎" or 物品 == "地狱灵芝" or 物品 == "麝香" or 物品 == "血珊瑚" then
		pg.魔法 = 150
	elseif 物品 == "餐风饮露" or 物品 == "白露为霜" then
		pg.魔法 = 200
	elseif 物品 == "孔雀红" or 物品 == "天龙水" then
		pg.魔法 = 250
	elseif 物品 == "金创药" then
		pg.气血 = 500
	elseif 物品 == "金香玉" then
		pg.气血 = 1500
	elseif 物品 == "小还丹" then
		pg.气血 = 1200
	elseif 物品 == "千年保心丹" then
		pg.气血 = 1000
	elseif 物品 == "风水混元丹" then
		pg.魔法 = 400
	elseif 物品 == "定神香" then
		pg.魔法 = 550
	elseif 物品 == "蛇蝎美人" then
		pg.魔法 = 650
	elseif 物品 == "九转回魂丹" then
		pg.气血 = 600
		pg.复活 = 0
	elseif 物品 == "佛光舍利子" then
		pg.气血 = 300
		pg.复活 = 0
	elseif 物品 == "五龙丹" then
		pg.气血 = 300
		pg.功效 = "解除封类异常状态"
	elseif 物品 == "月饼" then
		pg.功效 = "增加两点潜力点"
  elseif 物品 == "潜能果" then
    pg.功效 = "治疗肾虚，你懂得！！！！"
	elseif 物品 == "元宵" then
		pg.功效 = "增加资质与成长"
		if 食材 ~= nil then
			if 食材 == "芝麻沁香" then
				pg.功效 = "召唤兽使用,提高攻击资质"
			elseif 食材 == "桂花酒酿" then
				pg.功效 = "召唤兽使用,提高防御资质"
			elseif 食材 == "细磨豆沙" then
				pg.功效 = "召唤兽使用,提高速度资质"
			elseif 食材 == "蜜糖腰果" then
				pg.功效 = "召唤兽使用,提高躲避资质"
			elseif 食材 == "山楂拔丝" then
				pg.功效 = "召唤兽使用,提高体力资质"
			elseif 食材 == "滑玉莲蓉" then
				pg.功效 = "召唤兽使用,提高法力资质"
			end
		end
	elseif 物品 == "包子" then
		pg.气血 = 100
	elseif 物品 == "秘制红罗羹" then
		pg.功效 = "增加100次储备气血"
	elseif 物品 == "秘制绿罗羹" then
		pg.功效 = "增加100次储备魔法"
  elseif 物品 == "超级红罗羹" then
    pg.功效 = "增加2000次储备气血"
  elseif 物品 == "超级绿罗羹" then
    pg.功效 = "增加2000次储备魔法"


	end
	return pg
end




return 场景类_场景