
-- function 孩子处理类:新增孩子(id,模型)
--   local ls = self:孩子信息(模型)
--  	local cs = self:取初始属性(ls.种族)
-- 	self.数据[#self.数据+1]={
-- 	    等级 = 0,
-- 	    名称 = ls.模型,
-- 	    性别 = ls.性别,
-- 	    模型 = ls.模型,
-- 	    种族 = ls.种族,
-- 	    编号=#self.数据,
-- 	    门派 = "无门派",
--   	}



-- 	self:刷新信息(#self.数据,1)
-- end

-- function 孩子处理类:取属性(种族,五维)
--   local 属性={}
--   local 力量 = 五维[3]
--   local 体质 = 五维[1]
--   local 魔力 = 五维[2]
--   local 耐力 = 五维[4]
--   local 敏捷 = 五维[5]
--   if 种族 =="人" or 种族 == 1 then
--     属性={
--       命中=ceil(力量*2+30),
--       伤害=ceil(力量*0.67+39),
--       防御=ceil(耐力*1.5),
--       速度=ceil(敏捷),
--       灵力=ceil(体质*0.3+魔力*0.7+耐力*0.2+力量*0.4),
--       躲避=ceil(敏捷+10),
--       气血=ceil(体质*5+100),
--       法力=ceil(魔力*3+80),
--     }
--   elseif 种族 =="魔" or 种族 == 2 then
--     属性={
--       命中=ceil(力量*2.3+29),
--       伤害=ceil(力量*0.77+39),
--       防御=ceil(耐力*214/153),
--       速度=ceil(敏捷),
--       灵力=ceil(体质*0.3+魔力*0.7+耐力*0.2+力量*0.4-0.3),
--       躲避=ceil(敏捷+10),
--       气血=ceil(体质*6+100),
--       法力=ceil(魔力*2.5+80),
--     }
--   elseif 种族 =="仙" or 种族 == 3 then
--     属性={
--       命中=ceil(力量*1.7+30),
--       伤害=ceil(力量*0.57+39),
--       防御=ceil(耐力*1.6),
--       速度=ceil(敏捷),
--       灵力=ceil(体质*0.3+魔力*0.7+耐力*0.2+力量*0.4-0.3),
--       躲避=ceil(敏捷+10),
--       气血=ceil(体质*4.5+100),
--       法力=ceil(魔力*3.5+80),
--     }
--   end
--   return 属性
-- end


-- function 孩子处理类:取指定数据(编号)
--   return self.数据[编号]
-- end

-- function 孩子处理类:取总数据(编号)
--   local 存档数据={}
--   if self.数据[编号].气血 > self.数据[编号].最大气血 then
--     self.数据[编号].气血 = self.数据[编号].最大气血
--   end
--   for i,v in pairs(self.数据[编号]) do
--     存档数据[i] = self.数据[编号][i]
--   end
--   存档数据.装备=self:取装备数据(编号)
--   存档数据.灵饰={}
--   存档数据.锦衣={}
--   return 存档数据
-- end
local 孩子处理类 = class()
local 资质范围={"攻击资质","防御资质","体力资质","法力资质","速度资质","躲闪资质",}
local 属性范围={"体质","魔力","力量","耐力","敏捷"}
local bbs = 取宝宝
local rand   = 取随机小数
local cfs    = 删除重复
local ceil  = math.ceil
local insert = table.insert
local floor = math.floor
local 五行_ = {"金","木","水","火","土"}
function 孩子处理类:初始化(id)
  -- self.数据={}
end

function 孩子处理类:数据处理(id,内容)
  if 玩家数据[id].摊位数据~=nil then
    常规提示(id,"#Y/摆摊状态下禁止此种行为")
    return
  end
  if 内容.序列==1 then
    self:放生处理(id,内容.参数)
  elseif 内容.序列==2 then
    self:培养处理(id,内容.参数)
  elseif 内容.序列==3 then
    self:孩子拜师(id,内容.参数,内容.门派)
  elseif 内容.序列==4 then
    self:学习技能(id,内容)



  end
end
function 孩子处理类:学习技能(id,内容)
	local 道具 = 玩家数据[id].角色.数据.道具[内容.道具]
	if 玩家数据[id].道具.数据[道具]==nil or 玩家数据[id].角色.数据.道具[内容.道具]==nil then
		return
	end
	if 玩家数据[id].道具.数据[道具].名称=="黄帝内经" then
	   if self.数据[内容.位置].心态技能[1]==nil then
	   	  self.数据[内容.位置].心态技能[1]="治疗"
	   elseif self.数据[内容.位置].心态技能[2]==nil then
	   	  self.数据[内容.位置].心态技能[2]="治疗"
	   elseif self.数据[内容.位置].心态技能[1]~=nil  and self.数据[内容.位置].心态技能[2]~=nil then
	   	  self.数据[内容.位置].心态技能[取随机数(1,2)]="治疗"
	   end
	end
	if 玩家数据[id].道具.数据[道具].名称=="蚩尤武诀" then
	   if self.数据[内容.位置].心态技能[1]==nil then
	   	  self.数据[内容.位置].心态技能[1]="蚩尤之搏"
	   elseif self.数据[内容.位置].心态技能[2]==nil then
	   	  self.数据[内容.位置].心态技能[2]="蚩尤之搏"
	   elseif self.数据[内容.位置].心态技能[1]~=nil  and self.数据[内容.位置].心态技能[2]~=nil then
	   	  self.数据[内容.位置].心态技能[取随机数(1,2)]="蚩尤之搏"
	   end
	end
	if 玩家数据[id].道具.数据[道具].名称=="魔兽要诀" or 玩家数据[id].道具.数据[道具].名称=="高级魔兽要诀" then
	   if #self.数据[内容.位置].宝宝技能<1 then
	   	   self.数据[内容.位置].宝宝技能[1]=玩家数据[id].道具.数据[道具].附带技能
	   elseif #self.数据[内容.位置].宝宝技能>=6 then
	   	  self.数据[内容.位置].宝宝技能[1]=玩家数据[id].道具.数据[道具].附带技能
	   elseif #self.数据[内容.位置].宝宝技能<6 then
	   	  if 取随机数()<=5 then
	   	  	 self.数据[内容.位置].宝宝技能[#self.数据[内容.位置].宝宝技能+1]=玩家数据[id].道具.数据[道具].附带技能
	   	  else
			 self.数据[内容.位置].宝宝技能[取随机数(1,#self.数据[内容.位置].宝宝技能)]=玩家数据[id].道具.数据[道具].附带技能
	   	  end
	   end
	end
	self:刷新信息(内容.位置)
	玩家数据[id].角色.数据.道具[内容.道具]=nil
	玩家数据[id].道具.数据[道具]=nil
	道具刷新(id)
	发送数据(玩家数据[id].连接id,125,{道具=玩家数据[id].道具:索要道具1(id),孩子=玩家数据[id].孩子.数据[内容.位置],位置=内容.位置})



end



function 孩子处理类:培养处理(id,内容)
	if 取银子(id)<1000000 then
		常规提示(id,"#Y/您的钱不够了")
		return
	end
	if 玩家数据[self.数字id].角色.数据.当前经验<1000000 then
		常规提示(id,"#Y/您的经验不够了")
		return
	end
	玩家数据[self.数字id].角色:扣除银子(1000000,"培养孩子-领取",1)
	玩家数据[self.数字id].角色.数据.当前经验=玩家数据[self.数字id].角色.数据.当前经验-1000000
	self:添加经验(id,内容,1000000)


end



function 孩子处理类:加载数据(账号,数字id)
  self.数字id=数字id

 if f函数.文件是否存在([[data/]]..账号..[[/]]..数字id..[[/孩子.txt]])==false then  --未创建存档
 	写出文件([[data/]]..账号..[[/]]..数字id.."/孩子.txt",table.tostring({}))
 end
  self.数据=table.loadstring(读入文件([[data/]]..账号..[[/]]..数字id..[[/孩子.txt]]))

end
function 孩子处理类:孩子信息(模型)
  local 角色信息 = {
    小毛头 = {模型="小毛头",性别="男",种族="人",技能={},宝宝技能={},门派技能={},心态技能={},六艺技能={},攻击资质=1600,防御资质=1500,体力资质=6000,法力资质=4000,速度资质=1500,躲闪资质=1400},
    小丫丫 = {模型="小丫丫",性别="女",种族="人",技能={},宝宝技能={},门派技能={},心态技能={},六艺技能={},攻击资质=1600,防御资质=1500,体力资质=6000,法力资质=4000,速度资质=1500,躲闪资质=1400},
    小魔头 = {模型="小魔头",性别="男",种族="魔",技能={},宝宝技能={},门派技能={},心态技能={},六艺技能={},攻击资质=1600,防御资质=1500,体力资质=6000,法力资质=4000,速度资质=1500,躲闪资质=1400},
    小精灵 = {模型="小精灵",性别="女",种族="魔",技能={},宝宝技能={},门派技能={},心态技能={},六艺技能={},攻击资质=1600,防御资质=1500,体力资质=6000,法力资质=4000,速度资质=1500,躲闪资质=1400},
    小神灵 = {模型="小神灵",性别="男",种族="仙",技能={},宝宝技能={},门派技能={},心态技能={},六艺技能={},攻击资质=1600,防御资质=1500,体力资质=6000,法力资质=4000,速度资质=1500,躲闪资质=1400},
    小仙女 = {模型="小仙女",性别="女",种族="仙",技能={},宝宝技能={},门派技能={},心态技能={},六艺技能={},攻击资质=1600,防御资质=1500,体力资质=6000,法力资质=4000,速度资质=1500,躲闪资质=1400},
  }
  return 角色信息[模型]
end

--"还魂咒","治疗","蚩尤之搏","仙人指路","四面埋伏","赴汤蹈火","开门见山","赴汤蹈火","张弛有道","峰回路转"

function 孩子处理类:孩子拜师(id,编号,门派)
	if self.数据[编号].门派~="无" then
		常规提示(id,"#Y/请不要开玩笑")
		return
	end
	self.数据[编号].门派=门派
	if self.数据[编号].门派=="龙宫" then
	   self.数据[编号].门派技能={"龙卷雨击","龙腾"}
	end
	if self.数据[编号].门派=="五庄观" then
	   self.数据[编号].门派技能={"烟雨剑法","炼气化神"}
	end
	if self.数据[编号].门派=="魔王寨" then
	   self.数据[编号].门派技能={"三昧真火","飞砂走石"}
	end
	if self.数据[编号].门派=="大唐官府" then
	   self.数据[编号].门派技能={"杀气诀","后发制人"}
	end
	if self.数据[编号].门派=="方寸山" then
	   self.数据[编号].门派技能={"五雷咒","定身符"}
	end
	if self.数据[编号].门派=="女儿村" then
	   self.数据[编号].门派技能={"百毒不侵","楚楚可怜"}
	end
	if self.数据[编号].门派=="化生寺" then
	   self.数据[编号].门派技能={"金刚护体","活血"}
	end
	if self.数据[编号].门派=="天宫" then
	   self.数据[编号].门派技能={"天雷斩","五雷轰顶"}
	end
	if self.数据[编号].门派=="普陀山" then
	   self.数据[编号].门派技能={"杨柳甘露","日光华"}
	end
	if self.数据[编号].门派=="狮陀岭" then
	   self.数据[编号].门派技能={"极度疯狂","威慑"}
	end
	if self.数据[编号].门派=="盘丝洞" then
	   self.数据[编号].门派技能={"姐妹同心","勾魂"}
	end
	if self.数据[编号].门派=="阴曹地府" then
	   self.数据[编号].门派技能={"修罗隐身"}
	end
	if self.数据[编号].门派=="神木林" then
	   self.数据[编号].门派技能={"雾杀","蜜润"}
	end
	if self.数据[编号].门派=="凌波城" then
	   self.数据[编号].门派技能={"裂石","不动如山"}
	end
	if self.数据[编号].门派=="无底洞" then
	   self.数据[编号].门派技能={"金身舍利","地涌金莲"}
	end
    self:刷新信息(编号)

	常规提示(id,"#Y/成功")
end
function 孩子处理类:添加孩子(造型,成长,悟性)
  if #self.数据>= 6 then
    发送数据(玩家数据[self.数字id].连接id,7,"孩子数量上限")
    return
  end
  if 造型==nil then
  	 local 范围 = {"小毛头","小丫丫","小魔头","小精灵","小神灵","小仙女"}
  	 造型=范围[取随机数(1,#范围)]
  end
	for i=1,#self.数据 do
		if self.数据[i].模型==造型 then
			self:添加孩子(nil,成长,悟性)
			return
		end
	end


    local ls = self:孩子信息(造型)
    self.数据[#self.数据+1]={
      模型 = ls.模型,
      性别=ls.性别,
      种族=ls.种族,
      种类="孩子",
      门派="无",
      名称 = 造型,
      参战等级 = 0,
      等级 = 0,
      潜力 = 0,
      装备 = {},
      染色组 = {},
      装备属性 = {
        气血 = 0,
        魔法 = 0,
        命中 = 0,
        伤害 = 0,
        防御 = 0,
        速度 = 0,
        躲避 = 0,
        灵力 = 0,
        体质 = 0,
        魔力 = 0,
        力量 = 0,
        耐力 = 0,
        敏捷 = 0,
      },
      悟性 = 0,
      当前经验 = 0,
      寿命=5000,
      五行 = 五行_[取随机数(1,5)],
      力量 = 20,
      敏捷 = 20,
      耐力 = 20,
      魔力 = 20,
      体质 = 20,
      技能=ls.技能,
      宝宝技能=ls.宝宝技能,
      心态技能=ls.心态技能,
      门派技能=ls.门派技能,
      六艺技能=ls.六艺技能,
      认证码=self.数字id..os.time()..取随机数(1,999),
      攻击资质=ls.攻击资质,
      防御资质=ls.防御资质,
      体力资质=ls.体力资质,
      法力资质=ls.法力资质,
      速度资质=ls.速度资质,
      躲闪资质=ls.躲闪资质,
      成长=成长,
      当前经验=0,
      最大经验=40,
    }

  self:刷新信息(#self.数据,"1")
  发送数据(玩家数据[self.数字id].连接id,17.2,self.数据)
end

function 孩子处理类:放生处理(id,序号)
  local 临时编号=序号
  if 临时编号==0 then
    常规提示(id,"你没有这个孩子")
    return
  elseif self:是否有装备(临时编号) then
    常规提示(id,"请先卸下孩子所穿戴的装备")
    return
  elseif self.数据[序号]==nil then
    常规提示(id,"你没有这个孩子")
    return
  else--先判断是否有bb装备
    --       self.数据[临时编号]=nil
    table.remove(self.数据,临时编号) --先抹去参战信息
    常规提示(id,"你的这个孩子从你的眼前消失了~~")
  end
  发送数据(玩家数据[self.数字id].连接id,17.2,self.数据)
end
function 孩子处理类:取强化技能等级(名称)
  if 玩家数据[self.数字id].角色.数据.强化技能 == nil then
    return 0
  end
  for n=1,#玩家数据[self.数字id].角色.数据.强化技能 do
    if 玩家数据[self.数字id].角色.数据.强化技能[n].名称==名称 then return 玩家数据[self.数字id].角色.数据.强化技能[n].等级 end
  end
  return 0
end

function 孩子处理类:刷新信息(编号,是否)
  self.数据[编号].最大气血 = ceil(self.数据[编号].等级*self.数据[编号].体力资质/1000+(self.数据[编号].体质)*self.数据[编号].成长*6) + self.数据[编号].装备属性.气血
  self.数据[编号].最大魔法 = ceil(self.数据[编号].等级*self.数据[编号].法力资质/500+(self.数据[编号].魔力)*self.数据[编号].成长*3) + self.数据[编号].装备属性.魔法
  self.数据[编号].伤害 = ceil(self.数据[编号].等级*self.数据[编号].攻击资质*(self.数据[编号].成长+1.4)/750+(self.数据[编号].力量)*self.数据[编号].成长 + self.数据[编号].装备属性.命中/4+(self.数据[编号].体质) + self.数据[编号].装备属性.伤害)
  self.数据[编号].防御 = ceil(self.数据[编号].等级*self.数据[编号].防御资质*(self.数据[编号].成长+1.4)/1143+(self.数据[编号].耐力)*(self.数据[编号].成长-1/253)*253/190)+ self.数据[编号].装备属性.防御
  self.数据[编号].速度 = ceil(self.数据[编号].速度资质 * (self.数据[编号].敏捷)/1000)  + self.数据[编号].装备属性.速度
  self.数据[编号].灵力 = ceil(self.数据[编号].等级*(self.数据[编号].法力资质+1666)/3333+(self.数据[编号].魔力)*self.数据[编号].成长+(self.数据[编号].力量)*0.4+(self.数据[编号].体质)*0.3+(self.数据[编号].耐力)*0.2) + self.数据[编号].装备属性.灵力
  if  self.数据[编号].等级 <= 185 then
    self.数据[编号].最大经验 = 升级消耗.宠物[self.数据[编号].等级+1]
  end


  self.数据[编号].技能={}
  for i=1,#self.数据[编号].门派技能 do
       insert(self.数据[编号].技能,self.数据[编号].门派技能[i])
  end
  for i=1,#self.数据[编号].心态技能 do
       insert(self.数据[编号].技能,self.数据[编号].心态技能[i])
  end
  for i=1,#self.数据[编号].六艺技能 do
       insert(self.数据[编号].技能,self.数据[编号].六艺技能[i])
       if self.数据[编号].六艺技能[i]=="赴汤蹈火" or self.数据[编号].六艺技能[i]=="千锤百炼" then
       	  self.数据[编号].最大气血=self.数据[编号].最大气血+540
       end
       if self.数据[编号].六艺技能[i]=="开门见山" then
       	  self.数据[编号].最大气血=self.数据[编号].最大气血+380
       end
       if self.数据[编号].六艺技能[i]=="千锤百炼" then
          self.数据[编号].防御=self.数据[编号].防御+306
       end
  end
  for i=1,#self.数据[编号].宝宝技能 do
       insert(self.数据[编号].技能,self.数据[编号].宝宝技能[i])
  end

self.数据[编号].法伤 = self.数据[编号].灵力
self.数据[编号].法防 =self.数据[编号].灵力*0.7



  if 是否 == "1" then
    self.数据[编号].气血 = self.数据[编号].最大气血
    self.数据[编号].魔法 = self.数据[编号].最大魔法
  end
  if self.数据[编号].气血 > self.数据[编号].最大气血 then
    self.数据[编号].气血 = self.数据[编号].最大气血
  end
  if self.数据[编号].魔法 > self.数据[编号].最大魔法 then
    self.数据[编号].魔法 = self.数据[编号].最大魔法
  end




  if self:取指定技能(编号,"高级隐身") then
    self.数据[编号].伤害=self.数据[编号].伤害-math.floor(self.数据[编号].伤害*0.2)
  elseif self:取指定技能(编号,"隐身") then
    self.数据[编号].伤害=self.数据[编号].伤害-math.floor(self.数据[编号].伤害*0.2)
  end
  if self:取指定技能(编号,"高级强力") then
    self.数据[编号].伤害=self.数据[编号].伤害+math.floor(self.数据[编号].等级*0.715)
  elseif self:取指定技能(编号,"强力") then
    self.数据[编号].伤害=self.数据[编号].伤害+math.floor(self.数据[编号].等级*0.52)
  end
  if self:取指定技能(编号,"高级防御") then
    self.数据[编号].防御=self.数据[编号].防御+math.floor(self.数据[编号].等级*0.8)
  elseif self:取指定技能(编号,"防御") then
    self.数据[编号].防御=self.数据[编号].防御+math.floor(self.数据[编号].等级*0.6)
  end
  if self:取指定技能(编号,"高级敏捷") then
    self.数据[编号].速度=self.数据[编号].速度+math.floor(self.数据[编号].速度*0.1)
  elseif self:取指定技能(编号,"敏捷") then
    self.数据[编号].速度=self.数据[编号].速度+math.floor(self.数据[编号].速度*0.2)
  end
  if self:取指定技能(编号,"迟钝") then
    self.数据[编号].速度=self.数据[编号].速度-math.floor(self.数据[编号].速度*0.2)
  end
  发送数据(玩家数据[self.数字id].连接id,17.2,self.数据)
end

function 孩子处理类:取数据()
  return self.数据
end
function 孩子处理类:穿戴装备(装备,格子,编号)
  if 装备.气血 ~= nil then
    self.数据[编号].装备属性.气血 = self.数据[编号].装备属性.气血 + (装备.气血 or 0)
  end
  if 装备.魔法 ~= nil then
    self.数据[编号].装备属性.魔法 = self.数据[编号].装备属性.魔法 + (装备.魔法 or 0)
  end
  if 装备.命中 ~= nil then
    self.数据[编号].装备属性.命中 = self.数据[编号].装备属性.命中 + (装备.命中 or 0)
  end
  if 装备.伤害 ~= nil then
    self.数据[编号].装备属性.伤害 = self.数据[编号].装备属性.伤害 + (装备.伤害 or 0)
  end
  if 装备.防御 ~= nil then
    self.数据[编号].装备属性.防御 = self.数据[编号].装备属性.防御 + (装备.防御 or 0)
  end
  if 装备.速度 ~= nil then
    self.数据[编号].装备属性.速度 = self.数据[编号].装备属性.速度 + (装备.速度 or 0)
  end
  if 装备.躲避 ~= nil then
    self.数据[编号].装备属性.躲避 = self.数据[编号].装备属性.躲避 + (装备.躲避 or 0)
  end
  if 装备.灵力 ~= nil then
    self.数据[编号].装备属性.灵力 = self.数据[编号].装备属性.灵力 + (装备.灵力 or 0)
  end
  if 装备.体质 ~= nil then
    self.数据[编号].装备属性.体质 = self.数据[编号].装备属性.体质 + (装备.体质 or 0)
    self.数据[编号].装备属性.气血 = self.数据[编号].装备属性.气血 + (装备.体质 or 0)*5
  end
  if 装备.魔力 ~= nil then
    self.数据[编号].装备属性.魔力 = self.数据[编号].装备属性.魔力 + (装备.魔力 or 0)
    self.数据[编号].装备属性.魔法 = self.数据[编号].装备属性.魔法 + (装备.魔力 or 0)*5
    self.数据[编号].装备属性.灵力 = self.数据[编号].装备属性.灵力 + floor(((装备.魔力 or 0)*1.5))
  end
  if 装备.力量 ~= nil then
    self.数据[编号].装备属性.力量 = self.数据[编号].装备属性.力量 + (装备.力量 or 0)
    self.数据[编号].装备属性.伤害 = self.数据[编号].装备属性.伤害 + floor(((装备.力量 or 0)*3.5))
  end
  if 装备.耐力 ~= nil then
    self.数据[编号].装备属性.耐力 = self.数据[编号].装备属性.耐力 + (装备.耐力 or 0)
    self.数据[编号].装备属性.防御 = self.数据[编号].装备属性.防御 + floor(((装备.耐力 or 0)*2.3))
  end
  if 装备.敏捷 ~= nil then
    self.数据[编号].装备属性.敏捷 = self.数据[编号].装备属性.敏捷 + (装备.敏捷 or 0)
    self.数据[编号].装备属性.速度 = self.数据[编号].装备属性.速度 + floor(((装备.敏捷 or 0)*2.3))
  end
  self.数据[编号].装备[格子] = 装备
  if 装备.套装效果 ~= nil then
    local sl = {}
    local ab = true
    self.数据[编号].套装 = self.数据[编号].套装 or {}
    for i=1,#self.数据[编号].套装 do
      if self.数据[编号].套装[i][1] == 装备.套装效果[1] and self.数据[编号].套装[i][2] == 装备.套装效果[2] then
        local abc = false
        local abd = true
        for s=1,#self.数据[编号].套装[i][4] do
          if self.数据[编号].套装[i][4][s] == 格子 then
              abd = false
              break
          end
        end
        if abd then
          insert(self.数据[编号].套装[i][4],格子)
          abc = true
        end
        if abc then
          self.数据[编号].套装[i][3] = (self.数据[编号].套装[i][3] or 0) + 1
        end
        ab = false
        break
      end
    end
    if ab then
      insert(self.数据[编号].套装,{装备.套装效果[1],装备.套装效果[2],1,{格子}})
    end
  end
  self:刷新信息(编号)
end

function 孩子处理类:卸下装备(装备,格子,编号)
  if 装备.气血 ~= nil then
    self.数据[编号].装备属性.气血 = self.数据[编号].装备属性.气血 - (装备.气血 or 0)
  end
  if 装备.魔法 ~= nil then
    self.数据[编号].装备属性.魔法 = self.数据[编号].装备属性.魔法 - (装备.魔法 or 0)
  end
  if 装备.命中 ~= nil then
    self.数据[编号].装备属性.命中 = self.数据[编号].装备属性.命中 - (装备.命中 or 0)
  end
  if 装备.伤害 ~= nil then
    self.数据[编号].装备属性.伤害 = self.数据[编号].装备属性.伤害 - (装备.伤害 or 0)
  end
  if 装备.防御 ~= nil then
    self.数据[编号].装备属性.防御 = self.数据[编号].装备属性.防御 - (装备.防御 or 0)
  end
  if 装备.速度 ~= nil then
    self.数据[编号].装备属性.速度 = self.数据[编号].装备属性.速度 - (装备.速度 or 0)
  end
  if 装备.躲避 ~= nil then
    self.数据[编号].装备属性.躲避 = self.数据[编号].装备属性.躲避 - (装备.躲避 or 0)
  end
  if 装备.灵力 ~= nil then
    self.数据[编号].装备属性.灵力 = self.数据[编号].装备属性.灵力 - (装备.灵力 or 0)
  end
  if 装备.体质 ~= nil then
    self.数据[编号].装备属性.体质 = self.数据[编号].装备属性.体质 - (装备.体质 or 0)
    self.数据[编号].装备属性.气血 = self.数据[编号].装备属性.气血 - (装备.体质 or 0)*5
  end
  if 装备.魔力 ~= nil then
    self.数据[编号].装备属性.魔力 = self.数据[编号].装备属性.魔力 - (装备.魔力 or 0)
    self.数据[编号].装备属性.魔法 = self.数据[编号].装备属性.魔法 - (装备.魔力 or 0)*5
    self.数据[编号].装备属性.灵力 = self.数据[编号].装备属性.灵力 - floor(((装备.魔力 or 0)*1.5))
  end
  if 装备.力量 ~= nil then
    self.数据[编号].装备属性.力量 = self.数据[编号].装备属性.力量 - (装备.力量 or 0)
    self.数据[编号].装备属性.伤害 = self.数据[编号].装备属性.伤害 - floor(((装备.力量 or 0)*3.5))
  end
  if 装备.耐力 ~= nil then
    self.数据[编号].装备属性.耐力 = self.数据[编号].装备属性.耐力 - (装备.耐力 or 0)
    self.数据[编号].装备属性.防御 = self.数据[编号].装备属性.防御 - floor(((装备.耐力 or 0)*2.3))
  end
  if 装备.敏捷 ~= nil then
    self.数据[编号].装备属性.敏捷 = self.数据[编号].装备属性.敏捷 - (装备.敏捷 or 0)
    self.数据[编号].装备属性.速度 = self.数据[编号].装备属性.速度 - floor(((装备.敏捷 or 0)*2.3))
  end
  self:刷新信息(编号)
end
function 孩子处理类:取指定技能(编号,名称)
  for n=1,#self.数据[编号].技能 do
    if self.数据[编号].技能[n]==名称 then
      return true
    end
  end
  return false
end
function 孩子处理类:取存档数据(编号)
  if 编号 ~= nil then
    return self.数据[编号]
  end
  return self.数据
end

function 孩子处理类:获取指定数据(编号)
      local 返回数据 = {}
      for k,v in pairs(self.数据[编号]) do
          返回数据[k]=v
      end
      return 返回数据
end
function 孩子处理类:是否有装备(编号)
  if self.数据[编号]==nil then
    return false
  end
  for n=1,3 do
    if  self.数据[编号].装备[n]~=nil then
      return true
    end
  end
  return false
end

function 孩子处理类:耐久处理(id,认证码)
  local 编号 = self:取编号(认证码)
  if self:是否有装备(编号) then
    for n=1,3 do
      if self.数据[编号].装备[n]~=nil and self.数据[编号].装备[n].耐久~=nil then
        self.数据[编号].装备[n].耐久 = self.数据[编号].装备[n].耐久 - 0.0125
        if self.数据[编号].装备[n].耐久 <= 0 then
            self.数据[编号].装备[n].耐久 = 0
            发送数据(玩家数据[id].连接id,7,"#y/你的#r/"..self.数据[编号].装备[n].名称.."#y/因耐久度过低已无法使用")
        end
      end
    end
  end
end

function 孩子处理类:取编号(认证码)
  for n=1,#self.数据 do
    if self.数据[n].认证码==认证码 then
      return n
    end
  end
  return 0
end

function 孩子处理类:升级(编号,id)
  self.数据[编号].等级 = self.数据[编号].等级 + 1
  self.数据[编号].体质 = self.数据[编号].体质 + 1
  self.数据[编号].魔力 = self.数据[编号].魔力 + 1
  self.数据[编号].力量 = self.数据[编号].力量 + 1
  self.数据[编号].耐力 = self.数据[编号].耐力 + 1
  self.数据[编号].敏捷 = self.数据[编号].敏捷 + 1
  self.数据[编号].潜力 = self.数据[编号].潜力 + 5
  self.数据[编号].当前经验 = self.数据[编号].当前经验 - self.数据[编号].最大经验
  if self.数据[编号].成长方向~=nil then
  	 while(self.数据[编号].潜力>0) do
  	 	 self.数据[编号].潜力=self.数据[编号].潜力-1
  	 	 self.数据[编号][self.数据[编号].成长方向]=self.数据[编号][self.数据[编号].成长方向]+1
  	 end
  end
  self:刷新信息(编号,"1")
end
function 孩子处理类:添加经验(id,编号,数额)
  if self.数据[编号].等级>180 then --
    return
  end
  if self.数据[编号].等级>=玩家数据[id].角色.数据.等级+10 then
    发送数据(玩家数据[id].连接id,38,{内容="你的召唤兽当前等级已经超过人物等级+10，目前已经无法再获得更多的经验了。"})
    return
  end
  local 实际数额=数额
  self.数据[编号].当前经验=self.数据[编号].当前经验+实际数额
  发送数据(玩家数据[id].连接id,27,{文本="#W/你的"..self.数据[编号].名称.."#W/获得了"..实际数额.."点经验",频道="xt"})
  while(self.数据[编号].当前经验>=self.数据[编号].最大经验) do
    if self.数据[编号].等级>=玩家数据[id].角色.数据.等级+10 then
      break
    end
    self:升级(编号,id)
    发送数据(玩家数据[id].连接id,27,{文本="#W/你的#R/"..self.数据[编号].名称.."#W/等级提升到了#R/"..self.数据[编号].等级.."#W/级",频道="xt"})
  end
  发送数据(玩家数据[id].连接id,17.2,self.数据)

end


return 孩子处理类