--======================================================================--

--======================================================================--
local 角色处理类 = class()

local jnzb = require("Script/角色处理类/技能类")
local 变身卡扩展处理类 = require("Script/数据中心/变身卡扩展处理类")--超级变身卡

local floor = math.floor
local ceil = math.ceil
local insert = table.insert
local remove = table.remove
local tp
local 属性类型={"体质","魔力","力量","耐力","敏捷"}
local 可入门派={
  仙={天宫=1,龙宫=1,女={普陀山=1,},男={五庄观=1},凌波城=1,花果山=1}
  ,魔={魔王寨=1,阴曹地府=1,女={盘丝洞=1,},男={狮驼岭=1},无底洞=1,女魃墓=1}
  ,人={大唐官府=1,方寸山=1,女={女儿村=1,},男={化生寺=1},神木林=1,天机城=1}
}
  
 


function 角色处理类:初始化(id,ip)
  self.连接id=id
  self.连接ip=ip
  self.数据={}
    -- 初始化超级变身卡扩展处理
 self.变身卡扩展处理 = nil  -- 将在使用变身卡时初始化
end








function 角色处理类:GM添加经验(数额,类型,提示)
    if not 数额 or not tonumber(数额) or tonumber(数额)<1 or tonumber(数额)~=math.floor(数额) then
         数额 = 0
    else
        数额=math.floor(数额+0)
    end
 local 倍率=1
 local 之前银子=self.数据.当前经验
 local 经验=math.floor(数额*倍率)
 self.数据.当前经验=self.数据.当前经验+经验
 发送数据(玩家数据[self.数据.数字id].连接id,33,玩家数据[self.数据.数字id].角色:取总数据())
 发送数据(玩家数据[self.数据.数字id].连接id,38,{内容="你获得了"..经验.."点经验",频道="xt"})
 if 提示~=nil then
      常规提示(self.数字id,"#Y/GM给你添加了了"..经验.."点经验")
     end
self:日志记录(format("事件:获得经验,类型%s,数额%s,倍率%s,获得前%s,获得后%s",类型,数额,倍率,之前银子,self.数据.当前经验))
 if 经验数据.排行[self.数据.数字id]==nil then
   经验数据.排行[self.数据.数字id]={id=self.数据.数字id,名称=self.数据.名称,经验=经验,门派=self.数据.门派,等级=self.数据.等级}
  else
   经验数据.排行[self.数据.数字id].经验=经验数据.排行[self.数据.数字id].经验+经验
   经验数据.排行[self.数据.数字id].等级=self.数据.等级
   经验数据.排行[self.数据.数字id].门派=self.数据.门派
   end
 end

function 角色处理类:添加称谓(称谓)
  for i,v in ipairs(self.数据.称谓) do
      if v==称谓 then
          return
      end
  end

  if string.find(称谓, "英雄大会")~=nil then
     self.数据.英雄称谓时间 = os.time()
  end

  if string.find(称谓, "镇妖塔")~=nil then
     self.数据.镇妖塔称谓时间 = os.time()
  end
   if 称谓=="彩虹霸主" then
     self.数据.彩虹称谓时间 = os.time()
  end
  if 称谓=="帮战之星" then
     self.数据.帮战称谓时间 = os.time()
  end
  table.insert(self.数据.称谓,称谓)
  self:更新称谓(称谓)
  发送数据(玩家数据[self.数据.数字id].连接id,7,"#y/恭喜你获得了一个新的称谓。")
end

function 角色处理类:删除称谓(称谓)
  if 称谓 then
      local 查找当前 = ""
      if type(称谓)=="string" then
            for i,v in ipairs(self.数据.称谓) do
                if v==称谓 then
                   table.remove(self.数据.称谓,i)
                end
            end
            if string.find(称谓, "英雄大会")~=nil then
               self.数据.英雄称谓时间 = nil
            end
            if string.find(称谓, "镇妖塔")~=nil then
               self.数据.镇妖塔称谓时间 = nil
            end
            if 称谓=="彩虹霸主" then
               self.数据.彩虹称谓时间 = nil
            end
            if 称谓=="帮战之星" then
               self.数据.帮战称谓时间 = nil
            end


            查找当前=称谓
      elseif type(称谓)=="table" then
              local 临时称谓 ={}
              for i,v in ipairs(称谓) do
                  临时称谓[v]=true
                   if string.find(v, "英雄大会")~=nil then
                     self.数据.英雄称谓时间 = nil
                  end
                  if string.find(v, "镇妖塔")~=nil then
                     self.数据.镇妖塔称谓时间 = nil
                  end
                  if v=="彩虹霸主" then
                     self.数据.彩虹称谓时间 = nil
                  end
                  if v=="帮战之星" then
                     self.数据.帮战称谓时间 = nil
                  end
                  if self.数据.当前称谓==v then
                      查找当前=v
                  end
              end
              local 剩余称谓 ={}
              for i,v in ipairs(self.数据.称谓) do
                  if not 临时称谓[v] then
                     table.insert(剩余称谓, v)
                  end
              end
              self.数据.称谓 = 剩余称谓
      end
      if self.数据.当前称谓~="" and self.数据.当前称谓 == 查找当前 then
            self:更新称谓()
      else
            发送数据(玩家数据[self.数据.数字id].连接id,69,{项目 = "2",称谓=self.数据.称谓,当前称谓 = self.数据.当前称谓})
      end
      发送数据(玩家数据[self.数据.数字id].连接id,7,"#y/你的称谓已经被系统删除。")
  end
end

function 角色处理类:批量删除称谓(称谓)
        local 临时称谓 ={}
        for i,v in ipairs(self.数据.称谓) do
             if not string.find(v, 称谓) then
                table.insert(临时称谓, v)
             end
        end
        if 称谓=="英雄大会" then
               self.数据.英雄称谓时间 = nil
        end
        if 称谓=="镇妖塔" then
               self.数据.镇妖塔称谓时间 = nil
        end
        self.数据.称谓 =临时称谓
        if string.find(self.数据.当前称谓, 称谓) then
            self:更新称谓()
        else
              发送数据(玩家数据[self.数据.数字id].连接id,69,{项目 = "2",称谓=self.数据.称谓,当前称谓 = self.数据.当前称谓})
        end
        发送数据(玩家数据[self.数据.数字id].连接id,7,"#y/你的称谓已经被系统删除。")

end






-- function 角色处理类:更新称谓(id,称谓)
--   for i=1,#self.数据.称谓 do
--       if self.数据.称谓[i] == 称谓 then
--   		    self.数据.当前称谓 = 称谓
--           地图处理类:更新称谓(id,i)
--       end
--   end
--   发送数据(玩家数据[id].连接id,69,{项目 = "2",称谓=self.数据.称谓,当前称谓 = self.数据.当前称谓})
-- end

function 角色处理类:更新称谓(称谓)
  if 称谓 then
      if type(称谓)=="string" then
          for i=1,#self.数据.称谓 do
              if self.数据.称谓[i] == 称谓 then
                  self.数据.当前称谓 = 称谓
              end
          end
          if self.数据.当前称谓~=称谓 then
              self.数据.当前称谓=""
          end
      elseif type(称谓)=="number" then
            if  self.数据.称谓[math.ceil(称谓)] then
                self.数据.当前称谓=self.数据.称谓[math.ceil(称谓)]
            else
                 self.数据.当前称谓= ""
            end
      else
         self.数据.当前称谓=""
      end
  else
      self.数据.当前称谓=""
  end
  self:刷新信息()
  地图处理类:更新称谓(self.数据.数字id,self.数据.当前称谓)
  发送数据(玩家数据[self.数据.数字id].连接id,69,{项目 = "2",称谓=self.数据.称谓,当前称谓 = self.数据.当前称谓})
  发送数据(玩家数据[self.数据.数字id].连接id,33,self:取总数据())
end



function 角色处理类:创建角色(id,账号,模型,名称,ip,染色ID)
  local ms = 模型
  local ls = self:队伍角色(ms)
  local cs = self:取初始属性(ls.种族)
  服务端参数.角色id=服务端参数.角色id+1
  f函数.写配置(程序目录.."配置文件.ini","主要配置","id",服务端参数.角色id)
  名称数据[#名称数据+1]={名称=tostring(名称),id=服务端参数.角色id,账号=账号}
  self.数据 = {
    等级 = 10,
    名称 = tostring(名称),
    性别 = ls.性别,
    模型 = ls.模型,
    种族 = ls.种族,
    ID = 服务端参数.角色id,
    数字id=服务端参数.角色id,
    靓号="("..服务端参数.角色id..")",
    称谓 = {
    服务端参数.名称,
    "初露锋芒",
    },
    当前称谓=服务端参数.名称,
    帮派 = "无帮派",
    门派 = "无门派",
    人气 = 600,
    门贡 = 0,
    帮贡 = 0,
    体质 = cs[1]+10,
    魔力 = cs[2]+10,
    力量 = cs[3]+10,
    耐力 = cs[4]+10,
    敏捷 = cs[5]+10,
    加点记录 = {体质=0,魔力=0,力量=0,耐力=0,敏捷=0},
    潜力 = 55,
    愤怒 = 0,
    活力 = 10,
    体力 = 10,
    修炼 = {攻击修炼={0,0,0},法术修炼={0,0,0},防御修炼={0,0,0},抗法修炼={0,0,0},猎术修炼={0,0,0},当前="攻击修炼"},
    bb修炼 =   {攻击控制力={0,0,0},法术控制力={0,0,0},防御控制力={0,0,0},抗法控制力={0,0,0},当前="攻击控制力"},
    最大体力 = 100,
    最大活力 = 100,
    当前经验 = 0,
    最大经验 = 0,
    参战宝宝 = {},
    可选门派 = ls.门派,
    道具 = {},
    行囊 = {},
    装备 = {},
    灵饰 = {},
    锦衣 = {},
    法宝 = {},
    灵宝 = {},
    扩展背包 = 0,
    任务 = {},
    变身 = {},
    法宝佩戴={},
    灵宝佩戴={},
    道具仓库 = {},
    剧情技能 = {},
    师门技能 = {},
    技能保留 = {},
    人物技能 = {},
    特殊技能 = {},
    辅助技能 = {},
    强化技能 = {},
    快捷技能 = {},
    坐骑列表={},
    染色方案 = ls.染色方案,
    染色组 = {[1]=math.ceil(染色ID),[2]=math.ceil(染色ID),[3]=math.ceil(染色ID)} or {0,0,0},
    装备属性 = {气血=0,魔法=0,命中=0,伤害=0,防御=0,速度=0,躲避=0,灵力=0,体质=0,魔力=0,力量=0,耐力=0,敏捷=0,
               气血回复效果=0,抗法术暴击等级=0,格挡值=0,法术防御=0,抗物理暴击等级=0,封印命中等级=0,穿刺等级=0,
                抵抗封印等级=0,固定伤害=0,法术伤害=0,法术暴击等级=0,物理暴击等级=0,狂暴等级=0,法术伤害结果=0,
                治疗能力=0},

    战斗赐福 ={伤害结果=0,法伤结果=0,物伤结果=0,固伤结果=0,治疗结果=0,伤害减免=0,物伤减免=0,法伤减免=0,固伤减免=0,技能连击=0},
    神器属性 = {速度=0,法术防御=0,防御=0,气血=0,伤害=0,法术伤害=0,固定伤害=0,治疗能力=0,法术暴击等级=0,物理暴击等级=0,封印命中等级=0,抵抗封印等级=0},  ---神器
    神话词条 = {},
    奇经八脉 = {},
    经脉流派 = "无",
    乾元丹 = {乾元丹=0,附加乾元丹=0,剩余乾元丹=0,可换乾元丹=1},
    打造加成 = {赐福=0,双加=0,特效=0,特技=0},
    月饼 = 0,
    在线时间={小时=0,分=0,秒=0,累积=0,计算分=0,活力=0,体力=0},
    剧情点=200,
    官职点=0,
    官职次数=0,
    节日活动次数=0,
    师门次数=0,
    文韵次数=0,
    五宝数据={夜光珠=0,龙鳞=0,定魂珠=0,避水珠=0,金刚石=0},
    神器佩戴=false,
    飞升=false,
    渡劫=false,
    化圣=false,
--    好友数据={好友={},临时={},最近={},黑名单={}},
    出生奖励=true,

    账号=账号,
    ip=ip,
    储备=0,
    银子=0,
    存银=0,
    抽奖=0,
	GM币=0,
    活跃积分=0,
    钓鱼积分=0,
    出师数量=0,
    妖魔积分=0,
    文韵积分=0,
    镇妖积分=0,
    成就积分=0,
    活跃积分=0,
    自动抓鬼=0,
    传音纸鹤=0,
    仙缘积分=0,
    神器积分=0,  ----神器
    携带宠物 = 3,
    发言特效 = "",
    江湖次数=0,
    新手奖励 = {},
    点化=false,
    阵法={普通=1},
    出生日期=os.time(),
    造型=ls.模型,
    地图数据={编号=1501,x=700,y=200},--{编号=1501,x=420,y=60}
    武器数据={名称="",子类="",等级=0},
    宠物 = {模型="生肖猪",名称="生肖猪",等级=1,最大等级=120,耐力=5,最大耐力=5,经验=1,最大经验=10,领养次数=0},
    打造加成 = {赐福=0,双加=0,特效=0,特技=0},
    比武积分={当前积分=0,总积分=0},
    打造熟练度 = {打造技巧=0,裁缝技巧=0,炼金术=0,淬灵之术=0},
    帮派数据 = {编号=0,权限=0},
    帮派加成 = {气血=0,魔法=0,命中=0,伤害=0,防御=0,速度=0,法伤=0,法防=0,开关=false,时间=0},
    月卡={购买时间=0,到期时间=0,当前领取=0,开通=false},
    飞行=false,
    功德录 = {激活=false,九珠副={[1]={类型="伤害",数值=20},[2]={类型="气血",数值=98},[3]={类型="防御",数值=20},[4]={类型="速度",数值=20},[5]={类型="法术伤害",数值=20},[6]={类型="法术防御",数值=20}}},
    自动指令={下达=false,类型="攻击",目标=0,敌我=0,参数="",附加=""},
	高级阵法 = {八卦阵={[1]={类型="等级",数值=1},[2]={类型="伤害",数值=15},[3]={类型="法伤",数值=15},[4]={类型="固伤",数值=15},[5]={类型="召唤兽伤害",数值=15},[6]={类型="防御",数值=15},[7]={类型="法防",数值=15},[8]={类型="速度",数值=15}}},
    GM等级=0

  }

  -- if f函数.读配置(程序目录.."自定义配置.ini","出生自带","银子") ~= nil and tonumber(f函数.读配置(程序目录.."自定义配置.ini","出生自带","银子")) ~= nil then
  --   self.数据.银子=tonumber(f函数.读配置(程序目录.."自定义配置.ini","出生自带","银子"))
  -- end
  -- if f函数.读配置(程序目录.."自定义配置.ini","出生自带","经验") ~= nil and tonumber(f函数.读配置(程序目录.."自定义配置.ini","出生自带","经验")) ~= nil then
  --   self.数据.当前经验=tonumber(f函数.读配置(程序目录.."自定义配置.ini","出生自带","经验"))
  -- end
  -- if f函数.读配置(程序目录.."自定义配置.ini","出生自带","储备") ~= nil and tonumber(f函数.读配置(程序目录.."自定义配置.ini","出生自带","储备")) ~= nil then
  --   self.数据.储备=tonumber(f函数.读配置(程序目录.."自定义配置.ini","出生自带","储备"))
  -- end


  for n=1,#灵饰战斗属性 do
    self.数据[灵饰战斗属性[n]]=0
  end


  local fz = {"强身术","冥想","强壮","暗器技巧","中药医理","烹饪技巧","打造技巧","裁缝技巧","炼金术","淬灵之术","养生之道","健身术"}
  for i=1,#fz do
    local 辅助技能 = jnzb()
    辅助技能:置对象(fz[i])
    辅助技能.等级 = 0
    insert(self.数据.辅助技能,辅助技能)
  end
   local qh = {"人物伤害","人物防御","人物气血","人物法术","人物速度","人物固伤","人物治疗","宠物伤害","宠物防御","宠物气血","宠物灵力","宠物速度"}
   for i=1,#qh do
    local 强化技能 = jnzb()
    强化技能:置对象(qh[i])
    强化技能.等级 = 0
    insert(self.数据.强化技能,强化技能)
  end
  self:刷新信息("1")
  lfs.mkdir([[data/]]..账号..[[/]]..self.数据.数字id)
  lfs.mkdir([[data/]]..账号..[[/]]..self.数据.数字id..[[/日志记录]])
  lfs.mkdir([[data/]]..账号..[[/]]..self.数据.数字id..[[/消息记录]])


  写出文件([[data/]]..账号..[[/]]..self.数据.数字id..[[/道具.txt]],"do local ret={} return ret end")
  写出文件([[data/]]..账号..[[/]]..self.数据.数字id..[[/召唤兽.txt]],"do local ret={} return ret end")
  if f函数.文件是否存在([[data/]]..账号..[[/信息.txt]])==false then
    self.写入信息={[1]=self.数据.数字id}
    写出文件([[data/]]..账号..[[/信息.txt]],table.tostring(self.写入信息))
  else
    self.写入信息=table.loadstring(读入文件([[data/]]..账号..[[/信息.txt]]))
    self.写入信息[#self.写入信息+1]=self.数据.数字id
    写出文件([[data/]]..账号..[[/信息.txt]],table.tostring(self.写入信息))
    self.角色信息=nil
  end
local 任务id=取唯一识别码(999)
self.数据.任务[#self.数据.任务+1]=任务id
任务数据[任务id]={
id=任务id,
起始=os.time(),
玩家id=self.数据.数字id,
名称="",
模型="",
等级=0,
x=0,
y=0,
地图编号=0,
地图名称="无",
进程=1,
类型=999
 -- id=任务id,
 -- 起始=os.time(),
 -- 结束=0,
 -- 玩家id=self.数据.数字id,
 -- 队伍组={},
 -- 进程=1,
 -- 地图编号 =1501,
 -- 名称="老孙头",
 -- 类型=998,
}

-- 添加新手任务
local 新手任务id=取唯一识别码(66)
self.数据.任务[#self.数据.任务+1]=新手任务id
任务数据[新手任务id]={
id=新手任务id,
起始=os.time(),
玩家id=self.数据.数字id,
数量=10,
类型=66
}
  self.写入信息=nil
  self:存档()
end

function 角色处理类:增加在线时间()
  self.数据.在线时间.累积=self.数据.在线时间.累积+1
  self.数据.在线时间.秒=self.数据.在线时间.秒+1
  if self.数据.在线时间.秒>=60 then
    self.数据.在线时间.秒=0
    self.数据.在线时间.分=self.数据.在线时间.分+1
    if self.数据.在线时间.计算分==nil then
      self.数据.在线时间.计算分=0
    end
    self.数据.在线时间.计算分=self.数据.在线时间.计算分+1
    if self.数据.在线时间.计算分>=5 then--math.floor(self.数据.在线时间.分/5)==self.数据.在线时间.分/5
      self.数据.活力=self.数据.活力+math.floor(self.数据.最大活力*0.02)
      self.数据.体力=self.数据.体力+math.floor(self.数据.最大体力*0.02)
      if self.数据.活力>self.数据.最大活力 then self.数据.活力=self.数据.最大活力 end
      if self.数据.体力>self.数据.最大体力 then self.数据.体力=self.数据.最大体力 end
      if self.数据.在线时间.活力==nil then self.数据.在线时间.活力=self.数据.活力 end
      if self.数据.在线时间.体力==nil then self.数据.在线时间.体力=self.数据.体力 end
      if self.数据.在线时间.活力~=self.数据.最大活力 or self.数据.在线时间.体力~=self.数据.最大体力 then
        体活刷新(self.数据.数字id)
      end
      self.数据.在线时间.活力=self.数据.活力
      self.数据.在线时间.体力=self.数据.体力
      self.数据.在线时间.计算分=0
    end
    if self.数据.在线时间.分>=60 then
      self.数据.在线时间.分=0
      self.数据.在线时间.小时=self.数据.在线时间.小时+1
      self.数据.人气=self.数据.人气+1
      if self.数据.人气>800 then self.数据.人气=800 end
    end
  end
end



function 角色处理类:完成入圣()
  if self.数据.化圣 then return  end
  self:添加称谓(self.数据.数字id,"超凡入圣")
  self.数据.修炼.攻击修炼[3]=35
  self.数据.修炼.防御修炼[3]=35
  self.数据.修炼.法术修炼[3]=35
  self.数据.修炼.猎术修炼[3]=35
  self.数据.修炼.抗法修炼[3]=35
  self.数据.bb修炼.攻击控制力[3]=30
  self.数据.bb修炼.法术控制力[3]=30
  self.数据.bb修炼.防御控制力[3]=30
  self.数据.bb修炼.抗法控制力[3]=30
  常规提示(self.数据.数字id,"#Y你的角色修炼等级上限已经提升至35级")
  常规提示(self.数据.数字id,"#Y你的宠物修炼等级上限已经提升至30级")
  self.数据.化圣=true
end

function 角色处理类:完成渡劫()
  if self.数据.渡劫 then return  end
  local 称谓="三界帝贤"
  if self.数据.种族=="魔" then
    称谓="混世帝魔"
  elseif self.数据.种族=="仙" then
    称谓="太上帝仙"
  end
  self:添加称谓(self.数据.数字id,称谓)
  self.数据.修炼.攻击修炼[3]=30
  self.数据.修炼.防御修炼[3]=30
  self.数据.修炼.法术修炼[3]=30
  self.数据.修炼.猎术修炼[3]=30
  self.数据.修炼.抗法修炼[3]=30
  常规提示(self.数据.数字id,"#Y你的角色等级上限已提升至175级")
  常规提示(self.数据.数字id,"#Y你的角色修炼等级上限已经提升至30级")
  self.数据.渡劫=true
end



function 角色处理类:完成飞升()
  if self.数据.飞升 then return  end

  self.数据.等级=self.数据.等级-15
  local 称谓="极乐天人"
  if self.数据.种族=="魔" then
    称谓="至尊魔君"
  elseif self.数据.种族=="仙" then
    称谓="无上金仙"
  end
  self:添加称谓(self.数据.数字id,称谓)
  self.数据.修炼.攻击修炼[3]=25
  self.数据.修炼.防御修炼[3]=25
  self.数据.修炼.法术修炼[3]=25
  self.数据.修炼.猎术修炼[3]=25
  self.数据.修炼.抗法修炼[3]=25
  self.数据.bb修炼.攻击控制力[3]=25
  self.数据.bb修炼.法术控制力[3]=25
  self.数据.bb修炼.防御控制力[3]=25
  self.数据.bb修炼.抗法控制力[3]=25
  常规提示(self.数据.数字id,"#Y你的角色等级上限已提升至155级")
  常规提示(self.数据.数字id,"#Y你的角色等级下降了15级")
  常规提示(self.数据.数字id,"#Y你的修炼等级上限已经提升至25级")
  常规提示(self.数据.数字id,"#Y你额外获得了100点属性点")
  玩家数据[self.数据.数字id].召唤兽:飞升降级(self.数据.数字id)
  self.数据.潜力 = (self.数据.等级*5)+105
  self.数据.加点记录 = {体质=0,魔力=0,力量=0,耐力=0,敏捷=0}
  self.数据.飞升=true
  self:添加飞升技能()
  self:刷新信息("1")
  常规提示(self.数据.数字id,"#Y请到NPC处重置你的属性点")
end




function 角色处理类:添加飞升技能()
  local 技能=self:取飞升技能(self.数据.门派)
  for k,v in pairs(技能) do
     if v.id and v.名称 and self.数据.师门技能[v.id].等级 >= 120  then
          self:学会技能(v.id,v.名称)
     end
  end
end

function 角色处理类:取飞升技能(门派)
  if 门派 == "大唐官府" then
      return{{id=5,名称="破釜沉舟"},{id=7,名称="安神诀"}}
  elseif 门派 == "方寸山" then
        return{{id=2,名称="碎甲符"},{id=6,名称="分身术"}}
  elseif 门派 == "化生寺" then
        return{{id=2,名称="佛法无边"},{id=6,名称="舍身取义"}}
  elseif 门派 == "女儿村" then
        return{{id=2,名称="一笑倾城"},{id=7,名称="飞花摘叶"}}
  elseif 门派 == "阴曹地府" then
        return{{id=3,名称="黄泉之息"},{id=4,名称="还阳术"}}
  elseif 门派 == "魔王寨" then
         return{{id=3,名称="火甲术"},{id=5,名称="摇头摆尾"},{id=5,名称="无敌牛妖"}}
  elseif 门派 == "狮驼岭" then
         return{{id=2,名称="天魔解体"},{id=4,名称="魔息术"}}
  elseif 门派 == "盘丝洞" then
        return{{id=2,名称="魔音摄魂"},{id=2,名称="瘴气"},{id=6,名称="幻镜术"}}
  elseif 门派 == "天宫" then
        return{{id=1,名称="雷霆万钧"},{id=6,名称="金刚镯"}}
  elseif 门派 == "五庄观" then
        return{{id=3,名称="乾坤妙法"},{id=3,名称="天地同寿"}}
  elseif 门派 == "龙宫" then
        return{{id=1,名称="二龙戏珠"},{id=2,名称="神龙摆尾"}}
  elseif 门派 == "普陀山" then
        return{{id=5,名称="灵动九天"},{id=6,名称="颠倒五行"}}
  elseif 门派 == "神木林" then
        return{{id=3,名称="血雨"},{id=7,名称="蜜润"}}
  elseif 门派 == "凌波城" then
        return{{id=3,名称="镇魂诀"},{id=6,名称="腾雷"}}
  elseif 门派 == "无底洞" then
        return{{id=2,名称="摧心术"},{id=4,名称="金身舍利"}}
  elseif 门派 == "女魃墓" then
        return{{id=4,名称="唤魔·毒魅"},{id=4,名称="唤灵·焚魂"}}
  elseif 门派 == "天机城" then
        return{{id=2,名称="攻守易位"},{id=5,名称="匠心·削铁"}}
  elseif 门派 == "花果山" then
        return{{id=1,名称="威震凌霄"},{id=1,名称="气慑天军"}}
  elseif 门派 == "九黎城" then
        return{{id=4,名称="铁火双扬"}}
  end
  return {}
end



function 角色处理类:取化圣技能(门派)
  local n = {}
  if 门派 == "大唐官府" then
    return {"风林火山"}
  elseif 门派 == "方寸山" then
    return {"否极泰来"}
  elseif 门派 == "化生寺" then
    return {"醍醐灌顶"}
  elseif 门派 == "女儿村" then
    return {"月下霓裳"}
  elseif 门派 == "阴曹地府" then
    return {"无间地狱"}
  elseif 门派 == "魔王寨" then
    return {"魔火焚世"}
  elseif 门派 == "狮驼岭" then
    return {"疯狂鹰击"}
  elseif 门派 == "盘丝洞" then
    return {"媚眼如丝"}
  elseif 门派 == "天宫" then
    return {"鸣雷诀"}
  elseif 门派 == "五庄观" then
    return {"同伤式"}
  elseif 门派 == "龙宫" then
    return {"龙战于野"}
  elseif 门派 == "普陀山" then
    return {"清静菩提"}
  elseif 门派 == "神木林" then
    return {"花语歌谣"}
  elseif 门派 == "凌波城" then
    return {"无双战魂"}
  elseif 门派 == "无底洞" then
    return  {"净土灵华"}
  elseif 门派 == "九黎城" then
    return  {}
  -- elseif 门派 == "女魃墓" then
  --   return {"天魔觉醒"}
  -- elseif 门派 == "天机城" then
  --   return {"攻守易位","匠心·削铁"}
  -- elseif 门派 == "花果山" then
  --   return {"气慑天军","威震凌霄"}
  end
  return {}
end






function 角色处理类:增加种族坐骑(id)
  local zqsQ = 全局坐骑资料:取坐骑库(玩家数据[id].角色.数据)
  if 玩家数据[id].角色.数据.坐骑列表~= nil and #玩家数据[id].角色.数据.坐骑列表>=7 then
    常规提示(id,"#Y/对不起你换取的["..zqsQ.."]坐骑失败!携带坐骑数量已上限.")
    return false
  else
    常规提示(id,"#Y/恭喜你换取了["..zqsQ.."]坐骑!")
    全局坐骑资料:获取坐骑(id,zqsQ)
    发送数据(玩家数据[id].连接id,61,玩家数据[id].角色.数据.坐骑列表)
    return true
  end
end

function 角色处理类:增加祥瑞坐骑(id)
  local zqsQ = 全局坐骑资料:取坐骑库1(玩家数据[id].角色.数据)
  if 玩家数据[id].角色.数据.坐骑列表~= nil and #玩家数据[id].角色.数据.坐骑列表>=7 then
    常规提示(id,"#Y/对不起你换取的["..zqsQ.."]坐骑失败!携带坐骑数量已上限.")
    return false
  else
    常规提示(id,"#Y/恭喜你换取了["..zqsQ.."]坐骑!")
     全局坐骑资料:获取坐骑(id,zqsQ)
    发送数据(玩家数据[id].连接id,61,玩家数据[id].角色.数据.坐骑列表)
    return true
  end
end


function 角色处理类:给予坐骑(id,名称)
    全局坐骑资料:获取坐骑(id,名称)
    发送数据(玩家数据[id].连接id,61,玩家数据[id].角色.数据.坐骑列表)
end



function 角色处理类:门派任务(id,门派)
 任务处理类:添加门派任务(id,门派)
end
function 角色处理类:文韵任务(id,门派)--------远方文韵墨香
 任务处理类:添加文韵任务(id,门派)
end
function 角色处理类:取门派传送选项()
  local xx={}
  if self.数据.种族=="仙" then
    xx={"凌波城","天宫","龙宫"}
    if self.数据.性别=="男" then
      xx[#xx+1]="五庄观"
    else
      xx[#xx+1]="普陀山"
    end
  elseif self.数据.种族=="魔" then
    xx={"无底洞","魔王寨","阴曹地府"}
    if self.数据.性别=="男" then
      xx[#xx+1]="狮驼岭"
    else
      xx[#xx+1]="盘丝洞"
    end
  elseif self.数据.种族=="人" then
    xx={"神木林","大唐官府","方寸山"}
    if self.数据.性别=="男" then
      xx[#xx+1]="化生寺"
    else
      xx[#xx+1]="女儿村"
    end
  end
  return xx
end


function 角色处理类:更改角色名字(id,数据)

  if  数据.文本 == ""  or 数据.文本 == nil or string.find(数据.文本, "#") ~= nil or string.find(数据.文本,"/")~= nil
      or string.find(数据.文本, "@") ~= nil or string.find(数据.文本,"*")~= nil
      or string.find(数据.文本, " ") ~= nil or string.find(数据.文本,"~")~= nil
      or string.find(数据.文本, "GM") ~= nil or string.find(数据.文本,"gm")~= nil
      or string.find(数据.文本, "  ") ~= nil or string.find(数据.文本,"充值")~= nil
      or string.find(数据.文本, "游戏管理员") ~= nil or string.find(数据.文本,"·")~= nil
      or string.find(数据.文本,"小风")~= nil  or string.find(数据.文本,"群")~= nil
       or string.find(数据.文本,"裙")~= nil or string.find(数据.文本,"q")~= nil
       or string.find(数据.文本,"Q")~= nil or 判断特殊字符(数据.文本) or not 共享货币[玩家数据[id].账号]
     then
      常规提示(id,"#Y名字不能含有敏感字符")
      return
      end

      if 敏感字判断(数据.文本,true) then
           常规提示(id,"#Y名字不能含有敏感字符")
         return
      end
    数据.文本=tostring(数据.文本)
    for n=1,#名称数据 do
        if 名称数据[n].名称==数据.文本 then
            常规提示(id,"#Y该名字已存在，请少侠换一个名称。")
            return 0
        end
    end
     if string.len(数据.文本)>=16 then
        常规提示(id,"#Y这个名称太长了请换个名字")
          return 0
      end
 if 共享货币[玩家数据[id].账号]:扣除仙玉(5000,"人物改名",self.数据.数字id) then
      local 原名称 = self.数据.名称
      for n=1,#名称数据 do
        if 名称数据[n].名称==原名称 then
          名称数据[n].名称=tostring(数据.文本)
        end
      end
      self.数据.名称=tostring(数据.文本)
      写出文件([[tysj/名称数据.txt]],table.tostring(名称数据))
      常规提示(id,"#Y/恭喜你，改名成功！")
      发送数据(玩家数据[self.数据.数字id].连接id,33,玩家数据[self.数据.数字id].角色:取总数据())
        if self.数据.帮派数据 ==nil then
           self.数据.帮派数据 = {编号=0,权限=0}
        end
        if self.数据.帮派数据.编号 ~=nil and self.数据.帮派数据.编号>0 then
          local 帮派编号 = self.数据.帮派数据.编号
          local id2=self.数据.ID
          帮派数据[帮派编号].成员数据[id2].名称 =self.数据.名称
       end
 end
  -- 广播消息({内容=format("#S"..self.数据.id.."#G改名字了,改为"..数据文本)
end


function 角色处理类:扣除经验1(数额,类型,提示)
  self.数据.当前经验=self.数据.当前经验-数额
  发送数据(玩家数据[self.数据.数字id].连接id,33,玩家数据[self.数据.数字id].角色:取总数据())
  发送数据(玩家数据[self.数据.数字id].连接id,38,{内容="你消耗了"..数额.."点经验",频道="xt"})
  --self:日志记录(format("事件:消耗经验,类型%s,数额%s,获得前%s,获得后%s",类型,数额,之前银子,self.当前经验))
end
function 角色处理类:安全码验证(id,数据)
  if  数据.文本~= f函数.读配置(程序目录..[[data\]]..玩家数据[id].账号..[[\账号信息.txt]],"账号配置","安全码") then
      常规提示(id,"#Y/安全码输入错误，请重新输入！")
      return
  else
      发送数据(玩家数据[self.数据.数字id].连接id,142.2)
  end
end
function 角色处理类:更改帐号密码(id,数据)

  local 新密码 = 数据.文本

  f函数.写配置(程序目录..[[data\]]..玩家数据[id].账号..[[\账号信息.txt]],"账号配置","密码",新密码)
  常规提示(id,"#Y/恭喜你，密码修改成功，请下线重新登录")
      发送数据(玩家数据[id].连接id,998,"修改密码成功，请重新登陆！")
      --__S服务:断开连接(玩家数据[id].连接id)
      玩家数据[id].连接id=id
      系统处理类:断开游戏(id)
       -- __N连接数 = __N连接数-1
      __gge.print(false,10,"玩家账号  "..self.数据.账号.."名称  "..self.数据.名称.."修改密码为  "..新密码.."  修改成功\n")

end

function 角色处理类:添加经验(数额,类型,提示)
  if not 数额 or not tonumber(数额) or tonumber(数额)<1 or tonumber(数额)~=math.floor(数额) then
       数额 = 0
  else
      数额=math.floor(数额+0)
  end
  local 倍率=服务端参数.经验获得率
  if 类型=="神秘宝箱"  or  类型=="四墓灵鼠" then
      倍率=1
  end
  local 之前银子=self.数据.当前经验
  if 类型=="野外" or 类型=="抓鬼奖励" or 类型=="鬼王奖励"  or 类型=="官职" or 类型=="封妖战斗" or 类型=="种族" or 类型=="门派闯关" or 类型=="初出江湖" or 类型=="悬赏任务" then
      if self:取任务(2)~=0 then
        倍率=倍率+1
      end
      if self:取任务(3)~=0 then
        倍率=倍率+1
      end
  end

  if self:取任务(7755)~=0 then
    倍率=倍率+1
  end
  if self:取任务(7756)~=0 then
    倍率=倍率+1
  end
  local 经验=math.floor(qz(数额*倍率))
  ----离线储备
  if self:取任务(410)~=0 then  --如果角色 有离线经验
    local 储备金=0
    local 任务id=self:取任务(410)
    if 任务数据[任务id].离线储备-经验<0 then --当前获取的经验会消耗离线储备获取值 并且进行消耗 直到离线储备消耗完毕为止
      储备金=任务数据[任务id].离线储备
      任务数据[任务id].离线储备=0
    else
      任务数据[任务id].离线储备=任务数据[任务id].离线储备-经验
      储备金=经验
    end
    if 任务数据[任务id].离线储备<=0 then
      self:取消任务(任务id)
      任务数据[任务id] = nil
    end
    self:添加储备(储备金,"离线储备获取",1)
    self:刷新任务跟踪()
  end
  ----离线储备
  ----离线经验
  if self:取任务(409)~=0 then  --如果角色 有离线经验
    local 任务id=self:取任务(409)
    if 任务数据[任务id].离线经验-经验<0 then --当前获取的经验会消耗离线经验获取值 并且进行消耗 直到离线经验消耗完毕为止
      经验=经验*2-(经验-任务数据[任务id].离线经验)
      任务数据[任务id].离线经验=0
    else
      任务数据[任务id].离线经验=任务数据[任务id].离线经验-经验
      经验=经验*2
    end
    if 任务数据[任务id].离线经验<=0 then
      self:取消任务(任务id)
      任务数据[任务id] = nil
    end
    self:刷新任务跟踪()
  end
  ----
    -- 应用变身卡经验加成
  if self.变身卡扩展处理 then
      经验 = self.变身卡扩展处理:计算经验加成后数值("人物经验", 经验)
  end
  --超级变身卡
  self.数据.当前经验=self.数据.当前经验+经验
  发送数据(玩家数据[self.数据.数字id].连接id,33,玩家数据[self.数据.数字id].角色:取总数据())
  发送数据(玩家数据[self.数据.数字id].连接id,38,{内容="#Y你获得了#R"..经验.."#Y点经验",频道="xt"})

  if 提示~=nil then
    常规提示(self.数据.数字id,"#Y你获得了#R"..经验.."#Y点经验")
  end
  self:日志记录(format("事件:获得经验,类型%s,数额%s,倍率%s,获得前%s,获得后%s",类型,数额,倍率,之前银子,self.数据.当前经验))
  if 经验数据.排行[self.数据.数字id]==nil then
    经验数据.排行[self.数据.数字id]={id=self.数据.数字id,名称=self.数据.名称,经验=经验,门派=self.数据.门派,等级=self.数据.等级,账号=self.数据.账号}
  else
    经验数据.排行[self.数据.数字id].经验=经验数据.排行[self.数据.数字id].经验+经验
    经验数据.排行[self.数据.数字id].等级=self.数据.等级
  end
end

function 角色处理类:取剧情技能等级(名称)
  local 等级=0
  for n=1,#self.数据.剧情技能 do
    if self.数据.剧情技能[n].名称==名称 then
      等级=self.数据.剧情技能[n].等级
    end
  end
  return 等级
end

function 角色处理类:添加剧情点1()
self.数据.剧情点 = self.数据.剧情点 + 1
end
function 角色处理类:添加剧情点5()
self.数据.剧情点 = self.数据.剧情点 + 5
end
function 角色处理类:添加剧情点3()
self.数据.剧情点 = self.数据.剧情点 + 3
end
function 角色处理类:添加剧情点20()
self.数据.剧情点 = self.数据.剧情点 + 20
end

function 角色处理类:页面技能使用技能(内容)

  local 名称=内容.名称
  local 类型=内容.类型+0
  local 等级=0
  local id=self.数据.数字id
  if 名称=="飞行技能" then
     系统处理类:飞行处理(self.数据.数字id)
     return
 end
  if 类型==1 then -- 师门技能
      for n=1,#self.数据.师门技能 do
        for i=1,#self.数据.师门技能[n].包含技能 do
            if self.数据.师门技能[n].包含技能[i].名称==名称 and self.数据.师门技能[n].包含技能[i].学会 then
                等级=self.数据.师门技能[n].等级
            end
        end
      end
  elseif 类型==3 then -- 剧情技能
        for n=1,#self.数据.剧情技能 do
            if self.数据.剧情技能[n].名称==名称 then
                等级=self.数据.剧情技能[n].等级
            end
        end
  end
  if 等级==0 then
    return
  end
  local jns=取法术技能(名称)
  if 类型==1 and 玩家数据[id].战斗==0 then
    if 名称~="筋斗云" and jns~=nil and type(jns)=="table" and jns[3]==0 then
      if 玩家数据[id].角色.数据.气血<10 or 玩家数据[id].角色.数据.魔法<10 then
        常规提示(id,"您的气血魔法不足！")
        return
      elseif 玩家数据[id].队伍~=0 then
        常规提示(id,"组队状态下无法使用此功能！")
        return
      elseif 玩家数据[id].角色:取任务(300)~=0 then
        常规提示(id,"押镖任务中你飞个毛#24不怕天蓬元帅一耙子给你拍下来?#113")
        return
      elseif 玩家数据[id].角色.数据.地图数据.编号>=6010 and 玩家数据[id].角色.数据.地图数据.编号<=6019 then
        常规提示(id,"该地图无法传送")
        return
      end
      玩家数据[id].角色.数据.气血=玩家数据[id].角色.数据.气血-10
      玩家数据[id].角色.数据.魔法=玩家数据[id].角色.数据.魔法-10
      发送数据(玩家数据[id].连接id,5506,{玩家数据[id].角色:取气血数据()})
      if 等级>=玩家数据[id].角色.数据.等级-5 then
        地图处理类:门派传送(id,玩家数据[id].角色.数据.门派)
      elseif 等级>=取随机数(1,玩家数据[id].角色.数据.等级-5) then
        地图处理类:门派传送(id,玩家数据[id].角色.数据.门派)
      else
        常规提示(id,"使用技能失败！")
        return
      end
    elseif 名称=="兵器谱" or 名称=="堪察令" then
        道具刷新(id)
        发送数据(玩家数据[id].连接id,64,{等级=等级,名称=名称,道具=玩家数据[id].道具:索要道具1(id)})
    elseif 名称=="元阳护体" or 名称=="穿云破空" or 名称=="神木呓语" or 名称=="嗜血" or 名称=="莲华妙法" or 名称=="轻如鸿毛" or 名称=="拈花妙指" or 名称=="盘丝舞" or 名称=="一气化三清" or 名称=="浩然正气" or 名称=="龙附" or 名称=="神兵护法" or 名称=="魔王护持" or 名称=="神力无穷" or 名称=="尸气漫天" then
        道具刷新(id)
        发送数据(玩家数据[id].连接id,65,{等级=等级,名称=名称,道具=玩家数据[id].道具:索要道具1(id)})
    end
  elseif 类型==3 and 玩家数据[id].战斗==0 then
    if 名称=="仙灵店铺" then
      local 发送商品={}
       if 等级==1 then
        发送商品=商店处理类.一级仙灵店铺
      elseif 等级==2 then
        发送商品=商店处理类.二级仙灵店铺
      elseif 等级==3 then
        发送商品=商店处理类.三级仙灵店铺
      elseif 等级==4 then
        发送商品=商店处理类.四级仙灵店铺
      elseif 等级==5 then
        发送商品=商店处理类.五级仙灵店铺
      end
      玩家数据[id].商品列表=发送商品
      发送数据(玩家数据[id].连接id,9,{商品=发送商品,银子=玩家数据[id].角色.数据.银子,名称="仙灵店铺"})
    elseif 名称=="调息" then
      if 玩家数据[id].角色.数据.调息间隔~=nil and os.time()-玩家数据[id].角色.数据.调息间隔<=180 then
        常规提示(id,"#Y/此技能使用的间隔时间为3分钟")
        return
      else
        玩家数据[id].角色.数据.调息间隔=os.time()
        玩家数据[id].道具:加血处理(玩家数据[id].连接id,id,等级*60,0,"推拿")
      end
    elseif 名称=="打坐" then
      if 玩家数据[id].角色.数据.打坐间隔~=nil and os.time()-玩家数据[id].角色.数据.打坐间隔<=180 then
        常规提示(id,"#Y/此技能使用的间隔时间为3分钟")
        return
      else
        玩家数据[id].角色.数据.打坐间隔=os.time()
        玩家数据[id].道具:加魔处理(玩家数据[id].连接id,id,等级*30,0,"推拿")
      end
    -- elseif 名称=="翱翔" then
    --   系统处理类:飞行处理(self.数据.数字id)




    end
  end
end


function 角色处理类:使用快捷技能(序列)
  if self.数据.快捷技能[序列]==nil then
    return
  end
  local 名称=self.数据.快捷技能[序列].名称
  local 类型=self.数据.快捷技能[序列].类型
  local 等级=0
  local id=self.数据.数字id

  if 名称=="飞行技能" then
     系统处理类:飞行处理(self.数据.数字id)
     return
 end

  if 类型==1 then -- 师门技能
    for n=1,#self.数据.师门技能 do
      for i=1,#self.数据.师门技能[n].包含技能 do
        if self.数据.师门技能[n].包含技能[i].名称==名称 and self.数据.师门技能[n].包含技能[i].学会 then
          等级=self.数据.师门技能[n].等级
        end
      end
    end
  elseif 类型==3 then -- 剧情技能
    for n=1,#self.数据.剧情技能 do
      if self.数据.剧情技能[n].名称==名称 then
        等级=self.数据.剧情技能[n].等级
      end
    end
  end
  if 等级==0 then
    return
  end
  local jns=取法术技能(名称)
  if 类型==1 and 玩家数据[id].战斗==0 then
    if 名称~="筋斗云" and jns~=nil and type(jns)=="table" and jns[3]==0 then
      if 玩家数据[id].角色.数据.气血<10 or 玩家数据[id].角色.数据.魔法<10 then
        常规提示(id,"您的气血魔法不足！")
        return
      elseif 玩家数据[id].队伍~=0 then
        常规提示(id,"组队状态下无法使用此功能！")
        return
      elseif 玩家数据[id].角色:取任务(300)~=0 then
        常规提示(id,"押镖任务中你飞个毛#24不怕天蓬元帅一耙子给你拍下来?#113")
        return
      elseif 玩家数据[id].角色.数据.地图数据.编号>=6010 and 玩家数据[id].角色.数据.地图数据.编号<=6019 then
        常规提示(id,"该地图无法传送")
        return
      end
      玩家数据[id].角色.数据.气血=玩家数据[id].角色.数据.气血-10
      玩家数据[id].角色.数据.魔法=玩家数据[id].角色.数据.魔法-10
      发送数据(玩家数据[id].连接id,5506,{玩家数据[id].角色:取气血数据()})
      if 等级>=玩家数据[id].角色.数据.等级-5 then
        地图处理类:门派传送(id,玩家数据[id].角色.数据.门派)
      elseif 等级>=取随机数(1,玩家数据[id].角色.数据.等级-5) then
        地图处理类:门派传送(id,玩家数据[id].角色.数据.门派)
      else
        常规提示(id,"使用技能失败！")
        return
      end
    elseif 名称=="兵器谱" or 名称=="堪察令" then
        道具刷新(id)
        发送数据(玩家数据[id].连接id,64,{等级=等级,名称=名称,道具=玩家数据[id].道具:索要道具1(id)})
    elseif 名称=="元阳护体" or 名称=="穿云破空" or 名称=="神木呓语" or 名称=="嗜血" or 名称=="莲华妙法" or 名称=="轻如鸿毛" or 名称=="拈花妙指" or 名称=="盘丝舞" or 名称=="一气化三清" or 名称=="浩然正气" or 名称=="龙附" or 名称=="神兵护法" or 名称=="魔王护持" or 名称=="神力无穷" or 名称=="尸气漫天" then
        道具刷新(id)
        发送数据(玩家数据[id].连接id,65,{等级=等级,名称=名称,道具=玩家数据[id].道具:索要道具1(id)})
    end
  elseif 类型==3 and 玩家数据[id].战斗==0 then
    if 名称=="仙灵店铺" then
      local 发送商品={}
      if 等级==1 then
        发送商品=商店处理类.一级仙灵店铺
      elseif 等级==2 then
        发送商品=商店处理类.二级仙灵店铺
      elseif 等级==3 then
        发送商品=商店处理类.三级仙灵店铺
      elseif 等级==4 then
        发送商品=商店处理类.四级仙灵店铺
      elseif 等级==5 then
        发送商品=商店处理类.五级仙灵店铺
      end
      玩家数据[id].商品列表=发送商品
      发送数据(玩家数据[id].连接id,9,{商品=发送商品,银子=玩家数据[id].角色.数据.银子,名称="仙灵店铺"})
    elseif 名称=="调息" then
      if 玩家数据[id].角色.数据.调息间隔~=nil and os.time()-玩家数据[id].角色.数据.调息间隔<=180 then
        常规提示(id,"#Y/此技能使用的间隔时间为3分钟")
        return
      else
        玩家数据[id].角色.数据.调息间隔=os.time()
        玩家数据[id].道具:加血处理(玩家数据[id].连接id,id,等级*60,0,"推拿")
      end
    elseif 名称=="打坐" then
      if 玩家数据[id].角色.数据.打坐间隔~=nil and os.time()-玩家数据[id].角色.数据.打坐间隔<=180 then
        常规提示(id,"#Y/此技能使用的间隔时间为3分钟")
        return
      else
        玩家数据[id].角色.数据.打坐间隔=os.time()
        玩家数据[id].道具:加魔处理(玩家数据[id].连接id,id,等级*30,0,"推拿")
      end

    end
  end
end

function 角色处理类:设置快捷技能(数据)
  local 名称=数据.名称
  local 类型=数据.类型
  local 找到=false
  if 类型==1 then -- 师门技能
    for n=1,#self.数据.师门技能 do
      for i=1,#self.数据.师门技能[n].包含技能 do
        if self.数据.师门技能[n].包含技能[i].名称==名称 and self.数据.师门技能[n].包含技能[i].学会 then
          找到=true
        end
      end
    end
    if 找到==false then
      return
    end
  elseif 类型==3 then -- 剧情技能
    for n=1,#self.数据.剧情技能 do
      if self.数据.剧情技能[n].名称==名称 then
        找到=true
      end
    end
    if 找到==false then
      return
    end
   elseif 类型==4 then
      if 名称=="飞行技能" then
          找到=true
      end
     if 找到==false then
         return
     end
  end
  for n, v in pairs(self.数据.快捷技能) do
    if self.数据.快捷技能[n].名称==数据.名称 then
      self.数据.快捷技能[n]=nil
    end
  end
  if 数据.位置   then
      self.数据.快捷技能[数据.位置]={名称=数据.名称,类型=数据.类型}
  end
  发送数据(玩家数据[self.数据.数字id].连接id,42,self.数据.快捷技能)
end

function 角色处理类:取快捷技能(id)
  local x数据 = {}
  for n, v in pairs(self.数据.快捷技能) do
    if self.数据.快捷技能[n].名称~=nil then
      x数据[n]={名称=self.数据.快捷技能[n].名称,类型=self.数据.快捷技能[n].类型}
    end
  end
  发送数据(玩家数据[id].连接id,42,x数据)
end

function 角色处理类:添加属性点(数据,id,多角色)
  local 属性总和=0
  local 监控开关 = false
  for n=1,#属性类型 do
    if 数据[属性类型[n]]<0 or 数据[属性类型[n]]>self.数据.潜力 then
      监控开关 = true
    end
    属性总和=属性总和+数据[属性类型[n]]
  end
  if 监控开关 then
    -- __S服务:输出("玩家"..self.数据.数字id.." 非法修改数据警告!属性修改")
    -- 写配置("./ip封禁.ini","ip",玩家数据[self.数据.数字id].ip,1)
    -- 写配置("./ip封禁.ini","ip",玩家数据[self.数据.数字id].ip.." 非法修改数据警告!修改人物属性,玩家ID:"..self.数据.数字id,1)
    -- 发送数据(玩家数据[self.数据.数字id].连接id,998,"请注意你的角色异常！已经对你进行封IP")
    -- __S服务:断开连接(玩家数据[self.数据.数字id].连接id)
    return 0
  end
  if 属性总和==0 then
    常规提示(self.数据.数字id,"您到底是要添加哪种属性点呢？",多角色)
    return 0
  elseif self.数据.潜力<属性总和 then
    常规提示(self.数据.数字id,"你没有那么多可分配的属性点！",多角色)
    return 0
  else
    for n=1,#属性类型 do
      --self.数据[属性类型[n]]=self.数据[属性类型[n]]+数据[属性类型[n]]
      self.数据.加点记录[属性类型[n]] =self.数据.加点记录[属性类型[n]]+数据[属性类型[n]]
    end
    self.数据.潜力=self.数据.潜力-属性总和
    self:刷新信息()
  end
end

function 角色处理类:快捷门派传送(id)
      local 临时数据={}
      临时数据.模型="男人_镖头"
      临时数据.名称="新手门派传送人"
      临时数据.对话="独自一人行走江湖可谓是凶多吉少，请少侠先加入一个门派吧。我可以帮你快速地传送到你想要去的门派哟。请选择你要进行传送的门派："
      临时数据.选项={"方寸山","女儿村","神木林","化生寺","大唐官府","盘丝洞","阴曹地府","无底洞","魔王寨","狮驼岭","天宫","普陀山","凌波城","五庄观","龙宫"}
      发送数据(id,1501,临时数据)
end

function 角色处理类:升级处理(id,系统,多角色)

if  多角色==nil then
  if self.数据.等级>=10 and self.数据.门派=="无门派" then
    --local 内容 = self.数据.造型
    发送数据(id,155,参数,内容)
    --系统处理类:师门选择传送(id,参数,内容)
   -- local 临时数据={}
   -- 临时数据.模型="男人_镖头"
   -- 临时数据.名称="新手门派传送人"
   -- 临时数据.对话="独自一人行走江湖可谓是凶多吉少，请少侠先加入一个门派吧。我可以帮你快速地传送到你想要去的门派哟。请选择你要进行传送的门派："
   -- 临时数据.选项={"方寸山","女儿村","神木林","化生寺","大唐官府","盘丝洞","阴曹地府","无底洞","魔王寨","狮驼岭","天宫","普陀山","凌波城","五庄观","龙宫"}
   -- 发送数据(id,1501,临时数据)
    return 0
  elseif self.数据.等级==69 and self.数据.当前经验>=self.数据.最大经验 and 系统==nil then
     local 临时数据={}
    临时数据.模型=self.数据.模型
    临时数据.名称=self.数据.名称
    临时数据.对话="是否确定将等级提升至70级吗?"
    临时数据.选项={"我已确认将等级提升至70","我先清理下包裹"}
    发送数据(id,1501,临时数据)
    return
  elseif self.数据.等级==109 and self.数据.当前经验>=self.数据.最大经验 and 系统==nil then
    local 临时数据={}
    临时数据.模型=self.数据.模型
    临时数据.名称=self.数据.名称
    临时数据.对话="是否确定将等级提升至110级吗?"
    临时数据.选项={"我已确认将等级提升至110","我先清理下包裹"}
    发送数据(id,1501,临时数据)
    return
  elseif self.数据.等级==129 and self.数据.当前经验>=self.数据.最大经验 and 系统==nil then
    local 临时数据={}
    临时数据.模型=self.数据.模型
    临时数据.名称=self.数据.名称
    临时数据.对话="是否确定将等级提升至130级吗?"
    临时数据.选项={"我已确认将等级提升至130","我先清理下包裹"}
    发送数据(id,1501,临时数据)
    return
  end
else
    if 玩家数据[多角色].升级角色==nil then return end
    if self.数据.等级>=10 and self.数据.门派=="无门派" then
       常规提示(self.数据.数字id,"提升到10级需要切换角色操作",多角色)
      return
    elseif self.数据.等级==69 and self.数据.当前经验>=self.数据.最大经验 and 系统==nil then
       local 临时数据={}
      临时数据.模型=self.数据.模型
      临时数据.名称=self.数据.名称
      临时数据.对话="是否确定将该角色等级提升至70级吗?"
      临时数据.选项={"我已确认将该角色等级提升至70","我先清理下包裹"}
      发送数据(玩家数据[多角色].连接id,1501,临时数据)
      return
    elseif self.数据.等级==109 and self.数据.当前经验>=self.数据.最大经验 and 系统==nil then
      local 临时数据={}
      临时数据.模型=self.数据.模型
      临时数据.名称=self.数据.名称
      临时数据.对话="是否确定将该角色等级提升至110级吗?"
      临时数据.选项={"我已确认将该角色等级提升至110","我先清理下包裹"}
      发送数据(玩家数据[多角色].连接id,1501,临时数据)
      return
    elseif self.数据.等级==129 and self.数据.当前经验>=self.数据.最大经验 and 系统==nil then
      local 临时数据={}
      临时数据.模型=self.数据.模型
      临时数据.名称=self.数据.名称
      临时数据.对话="是否确定将该角色等级提升至130级吗?"
      临时数据.选项={"我已确认将该角色等级提升至130","我先清理下包裹"}
      发送数据(玩家数据[多角色].连接id,1501,临时数据)
      return
    end

end

  if self:等级上限(id) then
    if self.数据.当前经验<self.数据.最大经验 then
      常规提示(self.数据.数字id,"你没有那么多的经验",多角色)
      return 0
    end
    self.数据.等级=self.数据.等级+1
    self.数据.体质 = self.数据.体质 + 1
    self.数据.魔力 = self.数据.魔力 + 1
    self.数据.力量 = self.数据.力量 + 1
    self.数据.耐力 = self.数据.耐力 + 1
    self.数据.敏捷 = self.数据.敏捷 + 1
    self.数据.潜力 = self.数据.潜力 + 5
    self.数据.最大体力 = self.数据.最大体力 + 10
    self.数据.最大活力 = self.数据.最大活力 + 10
    self.数据.当前经验 = self.数据.当前经验 - self.数据.最大经验
    self:刷新信息("1")
    if not 多角色 then
        发送数据(id,10,self:取总数据())
        发送数据(id,11)
    end
    地图处理类:加入动画(self.数据.数字id,self.数据.地图数据.编号,self.数据.地图数据.x,self.数据.地图数据.y,"升级")
  end


  if self.数据.帮派数据.编号 ~=nil and self.数据.帮派数据.编号>0 then
      local 帮派编号 = self.数据.帮派数据.编号
      local id2=self.数据.ID
      帮派数据[帮派编号].成员数据[id2].等级 =self.数据.等级
  end

  if self.数据.飞升 then
      self.数据.修炼.攻击修炼[3]=25
      self.数据.修炼.防御修炼[3]=25
      self.数据.修炼.法术修炼[3]=25
      self.数据.修炼.抗法修炼[3]=25
      self.数据.修炼.猎术修炼[3]=25
      self.数据.bb修炼.攻击控制力[3]=25
      self.数据.bb修炼.防御控制力[3]=25
      self.数据.bb修炼.法术控制力[3]=25
      self.数据.bb修炼.抗法控制力[3]=25
  else
      local 修炼上限=(self.数据.等级-20)/5
      if 修炼上限 <=0 then
          修炼上限=0
      elseif 修炼上限>=20 then
            修炼上限=20
      end
      self.数据.修炼.攻击修炼[3]=math.floor(修炼上限)
      self.数据.修炼.防御修炼[3]=math.floor(修炼上限)
      self.数据.修炼.法术修炼[3]=math.floor(修炼上限)
      self.数据.修炼.抗法修炼[3]=math.floor(修炼上限)
      self.数据.修炼.猎术修炼[3]=math.floor(修炼上限)
      self.数据.bb修炼.攻击控制力[3]=math.floor(修炼上限)
      self.数据.bb修炼.防御控制力[3]=math.floor(修炼上限)
      self.数据.bb修炼.法术控制力[3]=math.floor(修炼上限)
      self.数据.bb修炼.抗法控制力[3]=math.floor(修炼上限)
  end
  if self.数据.渡劫 then
      self.数据.修炼.攻击修炼[3]=30
      self.数据.修炼.防御修炼[3]=30
      self.数据.修炼.法术修炼[3]=30
      self.数据.修炼.抗法修炼[3]=30
      self.数据.修炼.猎术修炼[3]=30
  end
  if self.数据.化圣 then
      self.数据.修炼.攻击修炼[3]=35
      self.数据.修炼.防御修炼[3]=35
      self.数据.修炼.法术修炼[3]=35
      self.数据.修炼.抗法修炼[3]=35
      self.数据.修炼.猎术修炼[3]=35
      self.数据.bb修炼.攻击控制力[3]=30
      self.数据.bb修炼.防御控制力[3]=30
      self.数据.bb修炼.法术控制力[3]=30
      self.数据.bb修炼.抗法控制力[3]=30
  end
  self.数据.乾元丹.可换乾元丹=玩家数据[self.数据.数字id].经脉:乾元丹数量(self.数据.等级)





end

function 角色处理类:取气血数据()
  if self.数据.气血上限 > self.数据.最大气血 then
    self.数据.气血上限 = self.数据.最大气血
  end
  if self.数据.气血 > self.数据.气血上限 then
    self.数据.气血 = self.数据.气血上限
  end
 return {气血=self.数据.气血,气血上限=self.数据.气血上限,最大气血=self.数据.最大气血,魔法=self.数据.魔法,最大魔法=self.数据.最大魔法,愤怒=self.数据.愤怒}
end

function 角色处理类:等级上限(id)
if self.数据.等级>=服务端参数.等级上限 then
    常规提示(self.数据.数字id,"当前服务器的最高等级为#R"..服务端参数.等级上限.."#Y级")
    return false
  end
  self.初始上限=145
  if self.数据.飞升 then
    self.初始上限=155
  end
  if self.数据.渡劫 then
    self.初始上限=175
  end
  if self.初始上限<=self.数据.等级 then
    常规提示(self.数据.数字id,"您的等级已经到达了上限！")
    return false
  else
    return true
  end
end





function 角色处理类:添加人物修炼经验(id,数值)

  if self.数据.修炼[self.数据.修炼.当前][1]>=self.数据.修炼[self.数据.修炼.当前][3] then
    常规提示(id,"你的改项修炼已达到上限了!")
    return
  end
  self.数据.修炼[self.数据.修炼.当前][2]=self.数据.修炼[self.数据.修炼.当前][2]+数值
  常规提示(id,format("你的人物%s经验增加了%s点",self.数据.修炼.当前,数值))
  local 等级 = self.数据.修炼[self.数据.修炼.当前][1]
  local 上限 = self.数据.修炼[self.数据.修炼.当前][3]
  local 经验 = self.数据.修炼[self.数据.修炼.当前][2]
  if 修炼经验[等级] and 经验>修炼经验[等级] and 等级<上限 then
      for i=等级,上限 do
          if 修炼经验[i] and 经验>=修炼经验[i] and 等级<上限  then
               经验 = math.floor(经验 - 修炼经验[i])
               等级 = 等级 + 1
          else
              break
          end
      end
      if 等级~=self.数据.修炼[self.数据.修炼.当前][1] then
          self.数据.修炼[self.数据.修炼.当前][2] = 经验
          self.数据.修炼[self.数据.修炼.当前][1] = 等级
          常规提示(id,format("你的人物%s等级提升至%s级",self.数据.修炼.当前,self.数据.修炼[self.数据.修炼.当前][1]))
      end
  end
  刷新修炼数据(id)
end



function 角色处理类:帮派添加人物修炼经验(id,数值,类型)
  if self.数据.修炼[类型][1]>=self.数据.修炼[self.数据.修炼.当前][3]then
    常规提示(id,"你的改项修炼已达到上限了!")
    return
  end
  self.数据.修炼[类型][2]=self.数据.修炼[类型][2]+数值
  常规提示(id,format("你的人物%s经验增加了%s点",类型,数值))
  if self.数据.修炼[类型][2]>= 修炼经验[self.数据.修炼[类型][1]] and self.数据.修炼[类型][1]<self.数据.修炼[类型][3] then
        self.数据.修炼[类型][2]=math.floor(self.数据.修炼[类型][2]-修炼经验[self.数据.修炼[类型][1]])
        self.数据.修炼[类型][1]=self.数据.修炼[类型][1]+1
        常规提示(id,format("你的人物%s等级提升至%s级",类型,self.数据.修炼[类型][1]))
  end
  刷新修炼数据(id)
end

function 角色处理类:添加bb修炼经验(id,数值)
  if self.数据.bb修炼[self.数据.bb修炼.当前][1]>=self.数据.bb修炼[self.数据.bb修炼.当前][3] then
    常规提示(id,"你的改项修炼已达到上限了!")
    return
  end
  self.数据.bb修炼[self.数据.bb修炼.当前][2]=self.数据.bb修炼[self.数据.bb修炼.当前][2]+数值
  常规提示(id,format("你的召唤兽%s经验增加了%s点",self.数据.bb修炼.当前,数值))
  local 等级 = self.数据.bb修炼[self.数据.bb修炼.当前][1]
  local 上限 = self.数据.bb修炼[self.数据.bb修炼.当前][3]
  local 经验 = self.数据.bb修炼[self.数据.bb修炼.当前][2]
  if 修炼经验[等级] and 经验>修炼经验[等级] and 等级<上限 then
      for i=等级,上限 do
          if 修炼经验[i] and 经验>=修炼经验[i] and 等级<上限 then
               经验 = math.floor(经验 - 修炼经验[i])
               等级 = 等级 + 1
          else
              break
          end
      end
      if 等级~=self.数据.bb修炼[self.数据.bb修炼.当前][1] then
          self.数据.bb修炼[self.数据.bb修炼.当前][2] = 经验
          self.数据.bb修炼[self.数据.bb修炼.当前][1] = 等级
          常规提示(id,format("你的召唤兽%s等级提升至%s级",self.数据.bb修炼.当前,self.数据.bb修炼[self.数据.bb修炼.当前][1]))
      end
  end
  刷新修炼数据(id)
end






function 角色处理类:添加法宝灵气(id,类型,下限,上限)
  for n=1,4 do
    local 符合=false
    if 玩家数据[id].角色.数据.法宝佩戴[n]~=nil then
      local 道具id=玩家数据[id].角色.数据.法宝佩戴[n]
      if 玩家数据[id].道具.数据[道具id]~=nil then
        local 名称=玩家数据[id].道具.数据[道具id].名称
        local 境界=玩家数据[id].道具.数据[道具id].气血
        local 灵气=玩家数据[id].道具.数据[道具id].魔法
        local 五行=玩家数据[id].道具.数据[道具id].五行
        local 等级=0
        if 境界<=5 then
          等级=30
        elseif 境界<=10 then
          等级=60
        else
          等级=100
        end
        if 下限<=等级 and 等级<=上限 then
          if 灵气>=取灵气上限(玩家数据[id].道具.数据[道具id].分类) then
            发送数据(玩家数据[id].连接id,38,{内容="你的法宝灵气已满，无法再增加灵气了"})
          else
            玩家数据[id].道具.数据[道具id].魔法=玩家数据[id].道具.数据[道具id].魔法+1
            发送数据(玩家数据[id].连接id,38,{内容="你的法宝灵气灵气增加了1点"})
          end
        end
      end
    end
  end

end


function 角色处理类:取法宝格子()
  for n=1,20 do
    if self.数据.法宝[n]==nil then
      return n
    end
  end
  return 0
end
function 角色处理类:取灵宝格子()
  for n=1,20 do
    if self.数据.灵宝[n]==nil then
      return n
    end
  end
  return 0
end




function 角色处理类:取道具格子()
  local 总格 = 40 + (self.数据.扩展背包 or 0)
  for n=1,总格 do
    if self.数据.道具[n]==nil then
       return n
    end
  end
  return 0
end

function 角色处理类:取道具格子2()
  local 总格 = 40 + (self.数据.扩展背包 or 0)
  local 数量=0
  for n=1,总格 do
    if self.数据.道具[n]==nil then
      数量=数量+1
    end
  end
  return 数量
end

function 角色处理类:取道具格子1(类型)
  local num=40 + (self.数据.扩展背包 or 0)
  if 类型~="道具" then num=20 end
  for n=1,num do
    if self.数据[类型][n]==nil then
      return n
    end
  end
  return 0
end

function 角色处理类:帮派学习生活技能(连接id,id,编号)
        if self.数据.辅助技能[编号]==0 or  self.数据.辅助技能[编号]==nil then
          常规提示(id,"你没有这样的技能")
          return
        end
        if self.数据.辅助技能[编号].等级>=160 then
          常规提示(id,"你这个技能已经升到满级了")
          return
        end
        local 临时消耗=角色取技能消耗(self.数据.辅助技能[编号].等级+1,1)
        if self.数据.辅助技能[编号].名称 == "强壮" then
            临时消耗=角色取技能消耗(self.数据.辅助技能[编号].等级+1,2)
        end
        if self.数据.当前经验<临时消耗.经验 then
          常规提示(id,"你没有那么多的经验")
          return
        end
        local 消耗银两 = 0
        local 消耗储备 = 0
        if self.数据.储备>=临时消耗.金钱 then
                消耗储备=临时消耗.金钱
        elseif self.数据.储备+self.数据.银子>=临时消耗.金钱 then
              消耗储备=self.数据.储备
              消耗银两=临时消耗.金钱-self.数据.储备
        end
        if self.数据.储备<消耗储备 then
              常规提示(id,"你没有那么多的储备",多角色)
              return
        elseif self.数据.银子<消耗银两  then
              常规提示(id,"你没有那么多的银两",多角色)
              return
        end
        if 消耗银两<=0 and 消耗储备<=0 then
            常规提示(id,"你没有那么多的银子",多角色)
            return
        end
        local 帮派编号 = 玩家数据[id].角色.数据.帮派数据.编号
        if not 帮派编号 or 帮派编号<=0 or not 帮派数据[帮派编号] then
            常规提示(id,"你还未入帮")
            return
        end
        local 等级上限 = 帮派数据[帮派编号].技能数据[self.数据.辅助技能[编号].名称].当前
        if self.数据.辅助技能[编号].等级 >= 等级上限  then
            常规提示(id,"你当前生活技能等级已达帮派所研究的等级上限")
            return
        end
        local 当前帮贡 = tonumber(帮派数据[帮派编号].成员数据[id].帮贡.当前)
        local 学习消耗 = (self.数据.辅助技能[编号].等级+1)*5 -200
        if self.数据.辅助技能[编号].等级<=40 or 学习消耗<=0 then
           学习消耗 = 0
        end
        if 当前帮贡<学习消耗 then
            常规提示(id,"你没有那么多的帮贡哦")
            return
        end
        self.数据.储备=self.数据.储备-消耗储备
        self.数据.银子=self.数据.银子-消耗银两
        self.数据.当前经验=self.数据.当前经验-临时消耗.经验
        self.数据.辅助技能[编号].等级=self.数据.辅助技能[编号].等级+1
        local 发送内容= ""
        local 日志数据= "学习生活技能["..self.数据.辅助技能[编号].名称.."]"
        if 消耗储备>0 and 消耗银两<=0 then
                  发送内容="消耗了"..消耗储备.."两储备\n消耗了"..临时消耗.经验.."点经验"
                  日志数据=日志数据.."消耗"..消耗储备.."储备、消耗"..临时消耗.经验.."经验"
        elseif 消耗储备>0 and 消耗银两>0 then
                发送内容="消耗了"..消耗储备.."两储备\n消耗了"..消耗银两.."两银子\n消耗了"..临时消耗.经验.."点经验"
                日志数据=日志数据.."消耗"..消耗储备.."储备、银子"..消耗银两.."银子、消耗"..临时消耗.经验.."经验"
        else
              发送内容="消耗了"..消耗银两.."两银子\n消耗了"..临时消耗.经验.."点经验"
              日志数据=日志数据.."消耗"..消耗银两.."银子、消耗"..临时消耗.经验.."经验"
        end
        if 学习消耗>0 then
            帮派数据[帮派编号].成员数据[id].帮贡.当前=帮派数据[帮派编号].成员数据[id].帮贡.当前 - 学习消耗
            self.数据.帮贡 = 帮派数据[帮派编号].成员数据[id].帮贡.当前
            发送内容=发送内容.."\n消耗了"..学习消耗.."点帮贡"
            日志数据=日志数据.."、消耗"..学习消耗.."帮贡"
        end
        发送数据(连接id,38,{内容=发送内容})
        self:日志记录(日志数据)
        self:银子记录()
        self:刷新信息()
        刷新货币(连接id,id)
        发送数据(连接id,34,{序列=编号,等级=self.数据.辅助技能[编号].等级})
        发送数据(连接id,31,玩家数据[id].角色:取总数据())
end


function 角色处理类:学习生活技能(连接id, id, 编号, 多角色, 学习次数)
    -- 处理学习次数默认值：为空或非法时默认1次
    学习次数 = 学习次数 or 1
    if type(学习次数) ~= "number" or 学习次数 < 1 then
        学习次数 = 1
    end

    -- 循环执行指定次数的技能学习
    for 次 = 1, 学习次数 do
        -- 1. 检查技能是否存在
        if self.数据.辅助技能[编号] == 0 then
            常规提示(id, "你没有这样的技能", 多角色)
            return
        end
        local 技能数据 = self.数据.辅助技能[编号]

        -- 2. 检查是否已达满级（160级上限）
        if 技能数据.等级 >= 160 then
            常规提示(id, "你要学习的技能已经满级了哦!", 多角色)
            return
        end

        -- 3. 计算当前等级升级消耗（特殊处理“强壮”技能）
        local 临时消耗
        if 技能数据.名称 == "强壮" then
            临时消耗 = 角色取技能消耗(技能数据.等级 + 1, 2)
        else
            临时消耗 = 角色取技能消耗(技能数据.等级 + 1, 1)
        end

        -- 4. 检查经验是否充足
        if self.数据.当前经验 < 临时消耗.经验 then
            常规提示(id, "经验不足，无法继续学习", 多角色)
            return
        end

        -- 5. 计算银两和储备消耗（优先用储备，不足部分用银子）
        local 消耗银两 = 0
        local 消耗储备 = 0
        if self.数据.储备 >= 临时消耗.金钱 then
            消耗储备 = 临时消耗.金钱  -- 全额用储备
        elseif self.数据.储备 + self.数据.银子 >= 临时消耗.金钱 then
            消耗储备 = self.数据.储备  -- 储备用完，剩余用银子
            消耗银两 = 临时消耗.金钱 - self.数据.储备
        else
            -- 储备+银子仍不足
            常规提示(id, "银两和储备不足，无法继续学习", 多角色)
            return
        end

        -- 6. 校验银两和储备是否足够（二次确认）
        if self.数据.储备 < 消耗储备 then
            常规提示(id, "你没有那么多的储备", 多角色)
            return
        elseif self.数据.银子 < 消耗银两 then
            常规提示(id, "你没有那么多的银两", 多角色)
            return
        end
        if 消耗银两 <= 0 and 消耗储备 <= 0 then
            常规提示(id, "你没有那么多的银子", 多角色)
            return
        end

        -- 7. 等级≥40时校验帮派和帮贡
        local 帮派编号 = 玩家数据[id].角色.数据.帮派数据.编号
        local 消耗帮贡 = 0
        if 技能数据.等级 >= 40 then
            -- 检查是否加入帮派
            if not 帮派编号 or 帮派编号 <= 0 or not 帮派数据[帮派编号] then
                常规提示(id, "你必须先加入一个帮派才可继续学习此技能", 多角色)
                return
            end
            -- 检查帮派技能等级上限
            local 等级上限 = 帮派数据[帮派编号].技能数据[技能数据.名称].当前
            if 技能数据.等级 >= 等级上限 then
                常规提示(id, "你当前生活技能等级已达帮派所研究的等级上限", 多角色)
                return
            end
            -- 计算并检查帮贡
            消耗帮贡 = (技能数据.等级 + 1) * 5 - 200
            local 当前帮贡 = tonumber(帮派数据[帮派编号].成员数据[id].帮贡.当前)
            if 当前帮贡 < 消耗帮贡 then
                常规提示(id, "你没那么多帮贡!需要"..消耗帮贡.."点帮贡", 多角色)
                return
            end
        end

        -- 8. 扣除资源
        self.数据.储备 = self.数据.储备 - 消耗储备
        self.数据.银子 = self.数据.银子 - 消耗银两
        self.数据.当前经验 = self.数据.当前经验 - 临时消耗.经验
        -- 扣除帮贡（若有）
        if 消耗帮贡 > 0 then
            帮派数据[帮派编号].成员数据[id].帮贡.当前 = 帮派数据[帮派编号].成员数据[id].帮贡.当前 - 消耗帮贡
            self.数据.帮贡 = 帮派数据[帮派编号].成员数据[id].帮贡.当前  -- 同步帮贡数据
        end

        -- 9. 提升技能等级
        技能数据.等级 = 技能数据.等级 + 1

        -- 10. 构建单次消耗提示内容
        local 发送内容 = ""
        local 日志数据 = "第"..次.."次学习生活技能["..技能数据.名称.."]"
        if 消耗储备 > 0 and 消耗银两 <= 0 then
            发送内容 = "第"..次.."次消耗："..消耗储备.."两储备\n"..临时消耗.经验.."点经验"
            日志数据 = 日志数据.."消耗"..消耗储备.."储备、"..临时消耗.经验.."经验"
        elseif 消耗储备 > 0 and 消耗银两 > 0 then
            发送内容 = "第"..次.."次消耗："..消耗储备.."两储备\n"..消耗银两.."两银子\n"..临时消耗.经验.."点经验"
            日志数据 = 日志数据.."消耗"..消耗储备.."储备、"..消耗银两.."银子、"..临时消耗.经验.."经验"
        else
            发送内容 = "第"..次.."次消耗："..消耗银两.."两银子\n"..临时消耗.经验.."点经验"
            日志数据 = 日志数据.."消耗"..消耗银两.."银子、"..临时消耗.经验.."经验"
        end
        if 消耗帮贡 > 0 then
            发送内容 = 发送内容.."\n消耗"..消耗帮贡.."点帮贡"
            日志数据 = 日志数据.."、"..消耗帮贡.."帮贡"
        end

        -- 11. 发送单次消耗提示和日志记录
        发送数据(连接id, 38, {内容 = 发送内容})
        self:日志记录(日志数据)
        self:银子记录()
        self:刷新信息()

        -- 12. 同步数据到客户端（非多角色场景。）
        if 多角色 == nil then
            刷新货币(连接id, id)
            发送数据(连接id, 34, {序列 = 编号, 等级 = 技能数据.等级})
        end
    end

    -- 所有次数完成后发送最终数据和提示
    if 多角色 == nil then
        发送数据(连接id, 31, 玩家数据[id].角色:取总数据())
    end
    常规提示(id, "已完成"..学习次数.."次生活技能学习", 多角色)
end


function 角色处理类:高级阵法升级处理(连接id,id,名称,类型,次数)
  if not self.数据.高级阵法[名称] then
      return false, "未知的高级阵法"
  end

  if not self.数据.高级阵法 or not self.数据.高级阵法[名称] then
      return false, "你尚未学会该阵法"
  end

  -- 检查属性类型是否在高级阵法配置中
  local 属性有效 = false
  local 目标序号 = nil
  for 序号, 属性配置 in pairs(self.数据.高级阵法[名称]) do
      if 属性配置.类型 == 类型 then
          属性有效 = true
          目标序号 = 序号
          break
      end
  end

  if not 属性有效 then
      return false, "无效的属性类型"
  end

  local 当前数值 = self.数据.高级阵法[名称][目标序号].数值
  local 当前等级 = math.floor((当前数值 - 15) / 5) + 1  -- 计算当前等级

  if 当前等级 >= 4 then
      return false, 类型.."属性已达到最高等级"
  end

  -- 获取升级消耗
  local 消耗配置 = 高级阵法升级消耗[名称][当前等级]
  local 需要阵眼 = 阵眼对应表[类型]

  if not 消耗配置 or not 需要阵眼 then
      return false, "升级配置错误"
  end

  -- 检查消耗
  if 玩家数据[id].道具:获取道具数量(id, 需要阵眼) < 消耗配置.阵眼 then
      return false, 需要阵眼.."数量不足"
  end
  if 共享货币[玩家数据[id].账号].仙玉 < 消耗配置.仙玉 then
      return false, "仙玉不足"
  end
  if self.数据.银子 < 消耗配置.银两 then
      return false, "银两不足"
  end

  -- 扣除消耗
  --玩家数据[id].道具:删除道具(连接id,id, "道具",需要阵眼, 消耗配置.阵眼)
  玩家数据[id].道具:消耗背包道具(self.数据.数字id, 需要阵眼, 消耗配置.阵眼)
  共享货币[玩家数据[id].账号]:扣除仙玉(消耗配置.仙玉, id, 名称.."升级")
  self:扣除银子(消耗配置.银两, 名称.."升级")

  -- 升级指定属性
  self.数据.高级阵法[名称][目标序号].数值 = 当前数值 + 5

  常规提示(id, "#Y/你的#G/"..名称.."#Y/的#R/"..类型.."#Y/提升到了#R/"..self.数据.高级阵法[名称][目标序号].数值.."%#Y/！")
  return true, "升级成功"
end
function 角色处理类:检查阵法等级(阵法名称)
  if not self.数据[阵法名称] or not self.数据[阵法名称].属性加成 then
      return 1
  end

  local 属性加成 = self.数据[阵法名称].属性加成
  local 所有属性值 = {}

  -- 收集所有属性值（排除等级属性）
  for _, 属性配置 in pairs(self.数据.高级阵法[阵法名称]) do
      if 属性配置.类型 ~= "等级" then
          table.insert(所有属性值, 属性加成[属性配置.类型] or 15)
      end
  end

  -- 检查所有属性是否都达到某个等级要求
  local 等级要求 = {
      [1] = 15,  -- 1级：所有属性15%
      [2] = 20,  -- 2级：所有属性20%
      [3] = 25,  -- 3级：所有属性25%
      [4] = 30   -- 4级：所有属性30%
  }

  for 等级 = 4, 1, -1 do
      local 达到等级 = true
      for _, 属性值 in ipairs(所有属性值) do
          if 属性值 < 等级要求[等级] then
              达到等级 = false
              break
          end
      end
      if 达到等级 then
          return 等级
      end
  end

  return 1
end
-- 添加数据完整性检查
function 角色处理类:检查八卦阵数据完整性()
  if self.数据.高级阵法 and self.数据.高级阵法.八卦阵 then
      -- 检查八卦阵数据结构是否完整，按照高级阵法配置格式
      local 需要补充 = false

      -- 检查是否缺少必要的属性配置
      for 序号, 属性配置 in pairs(self.数据.高级阵法.八卦阵) do
          if not self.数据.高级阵法.八卦阵[序号] then
              self.数据.高级阵法.八卦阵[序号] = {
                  类型 = 属性配置.类型,
                  数值 = 属性配置.数值
              }
              需要补充 = true
          elseif not self.数据.高级阵法.八卦阵[序号].类型 or not self.数据.高级阵法.八卦阵[序号].数值 then
              -- 如果数据结构不完整，重新初始化
              self.数据.高级阵法.八卦阵[序号] = {
                  类型 = 属性配置.类型,
                  数值 = 属性配置.数值
              }
              需要补充 = true
          end
      end

      -- 如果补充了数据，记录日志
      if 需要补充 then
          self:记录操作日志("检查八卦阵数据完整性", "数据补充", {
              玩家id = self.数据.id,
              补充说明 = "补充了缺失的八卦阵属性配置"
          })
      end
  end
end

-- 读取八卦阵伤害属性的函数
function 角色处理类:读取八卦阵伤害()
    if not self.数据.高级阵法 or not self.数据.高级阵法.八卦阵 then
        return 0
    end

    -- 方法1：通过序号读取（推荐）
    if self.数据.高级阵法.八卦阵[2] and self.数据.高级阵法.八卦阵[2].类型 == "伤害" then
        return self.数据.高级阵法.八卦阵[2].数值
    end

    -- 方法2：遍历查找伤害属性
    for 序号, 属性配置 in pairs(self.数据.高级阵法.八卦阵) do
        if 属性配置.类型 == "伤害" then
            return 属性配置.数值
        end
    end

    return 0
end

-- 读取八卦阵所有属性的函数
function 角色处理类:读取八卦阵所有属性()
    if not self.数据.高级阵法 or not self.数据.高级阵法.八卦阵 then
        return {}
    end

    local 属性数据 = {}
    for 序号, 属性配置 in pairs(self.数据.高级阵法.八卦阵) do
        属性数据[属性配置.类型] = 属性配置.数值
    end

    return 属性数据
end

-- 读取八卦阵特定属性的函数
function 角色处理类:读取八卦阵属性(属性类型)
    if not self.数据.高级阵法 or not self.数据.高级阵法.八卦阵 then
        return 0
    end

    for 序号, 属性配置 in pairs(self.数据.高级阵法.八卦阵) do
        if 属性配置.类型 == 属性类型 then
            return 属性配置.数值
        end
    end

    return 0
end
function 角色处理类:学习强化技能(连接id, id, 编号, 学习次数,多角色)
    -- 处理学习次数默认值：为空或非法时默认1次
    学习次数 = 学习次数 or 1
    if type(学习次数) ~= "number" or 学习次数 < 1 then
        学习次数 = 1
    end

    -- 循环执行指定次数的技能强化
    for 次 = 1, 学习次数 do
        -- 1. 检查技能是否存在
        if self.数据.强化技能[编号] == nil then
            常规提示(id, "你没有这样的技能",多角色)
            return
        end
        local 技能数据 = self.数据.强化技能[编号]

        -- 2. 检查技能是否已达上限
        if 技能数据.等级 >= 180 then
            技能数据.等级 = 180  -- 强制修正上限
            常规提示(id, "技能已达到上限，停止学习",多角色)
            return
        end

        -- 3. 计算当前升级所需消耗
        local 目标等级 = 技能数据.等级 + 1
        local 临时消耗 = 角色取技能消耗(目标等级, 2)

        -- 4. 检查经验是否充足
        if self.数据.当前经验 < 临时消耗.经验 then
            常规提示(id, "经验不足，无法继续学习",多角色)
            return
        end

        -- 5. 检查银子是否充足
        if self.数据.银子 < 临时消耗.金钱 then
            常规提示(id, "银子不足，无法继续学习",多角色)
            return
        end

        -- 6. 等级≥50时检查强化升级丹
        local 道具id = 0
        if 技能数据.等级 >= 50 then
            -- 查找对应阶品的强化升级丹
            for k, v in pairs(self.数据.道具) do
                local 道具数据 = 玩家数据[self.数据.数字id].道具.数据[v]
                if 道具数据 and 道具数据.名称 == "强化升级丹" and 道具数据.阶品 == 技能数据.名称 then
                    道具id = v
                    break  -- 找到第一个符合条件的道具
                end
            end
            -- 未找到道具则中断
            if 道具id == 0 then
                常规提示(self.数据.数字id, "未找到#G/"..技能数据.名称.."#Y/的#R/强化升级丹#Y/，无法提升技能",多角色)
                return
            end
        end

        -- 7. 扣除道具（等级≥50时）
        if 技能数据.等级 >= 50 then
            local 道具数据 = 玩家数据[self.数据.数字id].道具.数据[道具id]
            道具数据.数量 = 道具数据.数量 - 1
            if 道具数据.数量 <= 0 then
                玩家数据[self.数据.数字id].道具.数据[道具id] = nil  -- 数量为0时移除道具
            end
            道具刷新(self.数据.数字id)  -- 刷新道具显示
        end

        -- 8. 扣除银子和经验
        self.数据.银子 = self.数据.银子 - 临时消耗.金钱
        self.数据.当前经验 = self.数据.当前经验 - 临时消耗.经验

        -- 9. 发送单次消耗提示
        发送数据(连接id, 38, {内容 = "第"..次.."次学习消耗："..临时消耗.金钱.."点银两\n"..临时消耗.经验.."点经验"})

        -- 10. 记录日志和银子变动
        self:日志记录("第"..次.."次学习强化技能["..技能数据.名称.."]消耗"..临时消耗.金钱.."两银子"..临时消耗.经验.."点经验")
        self:银子记录()

        -- 11. 提升技能等级
        技能数据.等级 = 目标等级
        发送数据(连接id, 34.1, {序列 = 编号, 等级 = 技能数据.等级})

        -- 12. 若为宠物类技能，刷新召唤兽数据（替换表包含逻辑）
        local 宠物技能列表 = {"宠物伤害", "宠物防御", "宠物气血", "宠物灵力", "宠物速度"}
        local 是宠物技能 = false
        -- 遍历列表判断当前技能是否为宠物技能
        for i = 1, #宠物技能列表 do
            if 宠物技能列表[i] == 技能数据.名称 then
                是宠物技能 = true
                break  -- 找到匹配项后跳出循环
            end
        end
        -- 若为宠物技能，执行刷新操作
        if 是宠物技能 then
            for i = 1, #玩家数据[self.数据.数字id].召唤兽.数据 do
                if 玩家数据[self.数据.数字id].召唤兽.数据[i] ~= nil then
                    玩家数据[self.数据.数字id].召唤兽:刷新信息(i)
                end
            end
            发送数据(连接id, 16, 玩家数据[id].召唤兽.数据)
        end
    end

    -- 所有次数完成后刷新信息
    self:刷新信息()
    发送数据(连接id, 31, 玩家数据[id].角色:取总数据())
    常规提示(id, "已完成"..学习次数.."次技能强化学习",多角色)
end



function 角色处理类:学习剧情技能(id,名称,消耗,上限)
        if self.数据.剧情点<消耗 then
          常规提示(id,"你的剧情点不够哟")
          return
        end
        local 编号=0
        for n=1,#self.数据.剧情技能 do
          if self.数据.剧情技能[n].名称==名称 then
            编号=n
          end
        end
        if 编号~=0 then
            if self.数据.剧情技能[编号].等级>=上限 then
                常规提示(id,"你的这项技能等级已达上限")
                return
            end
        else
            self.数据.剧情技能[#self.数据.剧情技能+1]={名称=名称,等级=0}
            编号=#self.数据.剧情技能
        end
        self.数据.剧情点=self.数据.剧情点-消耗
        self.数据.剧情技能[编号].等级=self.数据.剧情技能[编号].等级+1
        常规提示(id,"#Y/你的剧情点减少了"..消耗.."点")
        常规提示(id,"你的"..名称.."等级提升至"..self.数据.剧情技能[编号].等级.."级")
end
function 角色处理类:取门派基础技能(id,门派)
  local 门派基础技能 = ""
  if 门派 == "大唐官府" then
    门派基础技能 = "为官之道"
  elseif 门派 == "方寸山" then
    门派基础技能 = "黄庭经"
  elseif 门派 == "化生寺" then
    门派基础技能 = "小乘佛法"
  elseif 门派 == "女儿村" then
    门派基础技能 = "毒经"
  elseif 门派 == "阴曹地府" then
    门派基础技能 = "灵通术"
  elseif 门派 == "魔王寨" then
    门派基础技能 = "牛逼神功"
  elseif 门派 == "狮驼岭" then
    门派基础技能 = "魔兽神功"
  elseif 门派 == "盘丝洞" then
    门派基础技能 = "蛛丝阵法"
  elseif 门派 == "天宫" then
    门派基础技能 = "天罡气"
  elseif 门派 == "五庄观" then
    门派基础技能 = "周易学"
  elseif 门派 == "龙宫" then
    门派基础技能 = "九龙诀"
  elseif 门派 == "普陀山" then
    门派基础技能 = "金刚经"
  elseif 门派 == "神木林" then
    门派基础技能 = "瞬息万变"
  elseif 门派 == "凌波城" then
    门派基础技能 = "天地无极"
  elseif 门派 == "无底洞" then
    门派基础技能 = "枯骨心法"
  elseif 门派 == "女魃墓" then
    门派基础技能 = "天火献誓"
  elseif 门派 == "天机城" then
    门派基础技能 = "神工无形"
  elseif 门派 == "花果山" then
    门派基础技能 = "神通广大"

  elseif 门派 == "九黎城" then
    门派基础技能 = "九黎战歌"

  end
  for i=1,#self.数据.师门技能 do
      if self.数据.师门技能[i].名称 == 门派基础技能 then
        return {编号=i,基础技能=self.数据.师门技能[i].名称}
      end
  end
end
function 角色处理类:学习门派技能(连接id,id,编号,多角色)
        if self.数据.师门技能[编号]==nil then
          常规提示(id,"你没有这样的技能",多角色)
          return
        elseif self.数据.师门技能[编号].等级>=self.数据.等级+10 then
          常规提示(id,"门派技能不能超过角色等级+10",多角色)
          return
        elseif self.数据.师门技能[编号].等级>=180 then
          常规提示(id,"该技能已满级无法继续学习",多角色)
          return
        end
        -- 新增：判空保护
        local 基础技能信息 = self:取门派基础技能(id,self.数据.门派)
        if not 基础技能信息 or not 基础技能信息.编号 or not 基础技能信息.基础技能 or not self.数据.师门技能[基础技能信息.编号] or self.数据.师门技能[基础技能信息.编号].等级 == nil then
            常规提示(id,"门派基础技能数据异常，请 relog 或联系GM",多角色)
            return
        end
        if self.数据.师门技能[编号].等级>=self.数据.师门技能[基础技能信息.编号].等级 and 编号 ~= 基础技能信息.编号 then
          常规提示(id,"请先提升门派基础技能"..基础技能信息.基础技能,多角色)
          return
        else
              --计算消耗的经验 金钱
              if not self.数据.技能保留 then self.数据.技能保留 = {} end
              local 临时消耗={经验=技能消耗.经验[self.数据.师门技能[编号].等级+1],金钱=技能消耗.金钱[self.数据.师门技能[编号].等级+1]}
              if self.数据.当前经验<临时消耗.经验 then
                  常规提示(id,"你没有那么多的经验",多角色)
                  return
              end
              local 消耗银两 = 0
              local 消耗储备 = 0
              local 消耗存银 = 0
              if self.数据.储备>=临时消耗.金钱 then
                  消耗储备=临时消耗.金钱
              elseif self.数据.储备+self.数据.银子>=临时消耗.金钱 then
                      消耗储备=self.数据.储备
                      消耗银两=临时消耗.金钱-self.数据.储备
              elseif self.数据.储备+self.数据.银子+self.数据.存银>=临时消耗.金钱 then
                      消耗储备=self.数据.储备
                      消耗银两=self.数据.银子
                      消耗存银=临时消耗.金钱-self.数据.储备-self.数据.银子
              end
              if self.数据.储备<消耗储备 then
                  常规提示(id,"你没有那么多的储备",多角色)
                  return
              elseif self.数据.银子<消耗银两  then
                  常规提示(id,"你没有那么多的银两",多角色)
                  return
              elseif self.数据.存银<消耗存银 then
                  常规提示(id,"你没有那么多的存银",多角色)
                  return
              end
              if 消耗银两<=0 and 消耗储备<=0 and 消耗存银<=0 then
                  常规提示(id,"你没有那么多的银子",多角色)
                  return
              end

              self.数据.储备=self.数据.储备-消耗储备
              self.数据.银子=self.数据.银子-消耗银两
              self.数据.存银=self.数据.存银-消耗存银
              self.数据.当前经验=self.数据.当前经验-临时消耗.经验
              self.数据.师门技能[编号].等级=self.数据.师门技能[编号].等级+1
              self.数据.技能保留[编号] = self.数据.师门技能[编号].等级
              self:升级技能(self.数据.师门技能[编号])
              local 发送内容= ""
              local 日志数据= "学习师门技能["..self.数据.师门技能[编号].名称.."]"
              if 消耗储备>0 and 消耗银两<=0 and 消耗存银<=0  then
                  发送内容="消耗了"..消耗储备.."两储备\n消耗了"..临时消耗.经验.."点经验"
                  日志数据=日志数据.."消耗"..消耗储备.."储备、消耗"..临时消耗.经验.."经验"
              elseif 消耗银两>0 and 消耗储备<=0 and 消耗存银<=0  then
                      发送内容="消耗了"..消耗银两.."两银子\n消耗了"..临时消耗.经验.."点经验"
                      日志数据=日志数据.."消耗"..消耗银两.."银子、消耗"..临时消耗.经验.."经验"
              elseif 消耗储备>0 and 消耗银两>0 and 消耗存银<=0  then
                      发送内容="消耗了"..消耗储备.."两储备\n消耗了"..消耗银两.."两银子\n消耗了"..临时消耗.经验.."点经验"
                      日志数据=日志数据.."消耗"..消耗储备.."储备、银子"..消耗银两.."银子、消耗"..临时消耗.经验.."经验"
              elseif 消耗存银>0 and 消耗储备>0 and 消耗银两<=0 then
                      发送内容="消耗了"..消耗储备.."两储备\n消耗了"..消耗存银.."两存银\n消耗了"..临时消耗.经验.."点经验"
                      日志数据=日志数据.."消耗"..消耗储备.."储备、消耗"..消耗存银.."存银、消耗"..临时消耗.经验.."点经验"
              elseif 消耗存银>0 and 消耗银两>0 and 消耗储备<=0  then
                      发送内容="消耗了"..消耗银两.."两银子\n消耗了"..消耗存银.."两存银\n消耗了"..临时消耗.经验.."点经验"
                      日志数据=日志数据.."消耗"..消耗银两.."银子、消耗"..消耗存银.."存银、消耗"..临时消耗.经验.."经验"
              elseif 消耗存银>0 and 消耗储备>0 and 消耗银两>0 then
                        发送内容="消耗了"..消耗储备.."两储备\n消耗了"..消耗银两.."两银子\n消耗了"..消耗存银.."两存银\n消耗了"..临时消耗.经验.."点经验"
                        日志数据=日志数据.."消耗"..消耗储备.."储备、消耗"..消耗银两.."银子、消耗"..消耗存银.."存银、消耗"..临时消耗.经验.."经验"
              else
                    发送内容="消耗了"..消耗存银.."两存银\n消耗了"..临时消耗.经验.."点经验"
                    日志数据=日志数据.."消耗"..消耗存银.."存银、消耗"..临时消耗.经验.."经验"
              end

              if 多角色~=nil then
                  发送数据(玩家数据[多角色].连接id,38,{内容=发送内容})
              else
                  发送数据(玩家数据[self.数据.数字id].连接id,38,{内容=发送内容})
              end
              self:日志记录(日志数据)
              self:银子记录()
              if 多角色==nil then
                  self:刷新信息("2")
                  发送数据(连接id,31,玩家数据[id].角色:取总数据())
                  刷新货币(连接id,id)
              end
        end
end

function 角色处理类:学习十次门派技能(连接id,id,编号)
          if self.数据.师门技能[编号]==nil then
            常规提示(id,"你没有这样的技能")
            return
          elseif self.数据.师门技能[编号].等级+10>self.数据.等级+10 then
            常规提示(id,"门派技能不能超过角色等级+10")
            return
          elseif self.数据.师门技能[编号].等级+10>self.数据.师门技能[self:取门派基础技能(id,self.数据.门派).编号].等级 and 编号 ~= self:取门派基础技能(id,self.数据.门派).编号 then
            常规提示(id,"请先提升门派基础技能"..self:取门派基础技能(id,self.数据.门派).基础技能)
            return
          elseif self.数据.师门技能[编号].等级>=170 then
            常规提示(id,"170以上无法使用十次学习")
            return
          else
            --计算消耗的经验 金钱
              if not self.数据.技能保留 then self.数据.技能保留 = {} end
              local 临时消耗={经验=0,金钱=0}
              for i=1,10 do
                  临时消耗.经验 = 临时消耗.经验 + 技能消耗.经验[self.数据.师门技能[编号].等级+i]
                  临时消耗.金钱 = 临时消耗.金钱 + 技能消耗.金钱[self.数据.师门技能[编号].等级+i]
              end
              if self.数据.当前经验<临时消耗.经验 then
                  常规提示(id,"你没有那么多的经验")
                  return
              end
              local 消耗银两 = 0
              local 消耗储备 = 0
              local 消耗存银 = 0
              if self.数据.储备>=临时消耗.金钱 then
                  消耗储备=临时消耗.金钱
              elseif self.数据.储备+self.数据.银子>=临时消耗.金钱 then
                      消耗储备=self.数据.储备
                      消耗银两=临时消耗.金钱-self.数据.储备
              elseif self.数据.储备+self.数据.银子+self.数据.存银>=临时消耗.金钱 then
                      消耗储备=self.数据.储备
                      消耗银两=self.数据.银子
                      消耗存银=临时消耗.金钱-self.数据.储备-self.数据.银子
              end
              if self.数据.储备<消耗储备 then
                  常规提示(id,"你没有那么多的储备")
                  return
              elseif self.数据.银子<消耗银两  then
                  常规提示(id,"你没有那么多的银两")
                  return
              elseif self.数据.存银<消耗存银 then
                  常规提示(id,"你没有那么多的存银")
                  return
              end
              if 消耗银两<=0 and 消耗储备<=0 and 消耗存银<=0 then
                  常规提示(id,"你没有那么多的银子")
                  return
              end
              self.数据.储备=self.数据.储备-消耗储备
              self.数据.银子=self.数据.银子-消耗银两
              self.数据.存银=self.数据.存银-消耗存银
              self.数据.当前经验=self.数据.当前经验-临时消耗.经验
              self.数据.师门技能[编号].等级=self.数据.师门技能[编号].等级+10
              self.数据.技能保留[编号] = self.数据.师门技能[编号].等级
              self:升级技能(self.数据.师门技能[编号])
              local 发送内容= ""
              local 日志数据= "学习师门技能["..self.数据.师门技能[编号].名称.."]"
              if 消耗储备>0 and 消耗银两<=0 and 消耗存银<=0  then
                  发送内容="消耗了"..消耗储备.."两储备\n消耗了"..临时消耗.经验.."点经验"
                  日志数据=日志数据.."消耗"..消耗储备.."储备、消耗"..临时消耗.经验.."经验"
              elseif 消耗银两>0 and 消耗储备<=0 and 消耗存银<=0  then
                      发送内容="消耗了"..消耗银两.."两银子\n消耗了"..临时消耗.经验.."点经验"
                      日志数据=日志数据.."消耗"..消耗银两.."银子、消耗"..临时消耗.经验.."经验"
              elseif 消耗储备>0 and 消耗银两>0 and 消耗存银<=0  then
                      发送内容="消耗了"..消耗储备.."两储备\n消耗了"..消耗银两.."两银子\n消耗了"..临时消耗.经验.."点经验"
                      日志数据=日志数据.."消耗"..消耗储备.."储备、银子"..消耗银两.."银子、消耗"..临时消耗.经验.."经验"
              elseif 消耗存银>0 and 消耗储备>0 and 消耗银两<=0 then
                      发送内容="消耗了"..消耗储备.."两储备\n消耗了"..消耗存银.."两存银\n消耗了"..临时消耗.经验.."点经验"
                      日志数据=日志数据.."消耗"..消耗储备.."储备、消耗"..消耗存银.."存银、消耗"..临时消耗.经验.."点经验"
              elseif 消耗存银>0 and 消耗银两>0 and 消耗储备<=0  then
                      发送内容="消耗了"..消耗银两.."两银子\n消耗了"..消耗存银.."两存银\n消耗了"..临时消耗.经验.."点经验"
                      日志数据=日志数据.."消耗"..消耗银两.."银子、消耗"..消耗存银.."存银、消耗"..临时消耗.经验.."经验"
              elseif 消耗存银>0 and 消耗储备>0 and 消耗银两>0 then
                        发送内容="消耗了"..消耗储备.."两储备\n消耗了"..消耗银两.."两银子\n消耗了"..消耗存银.."两存银\n消耗了"..临时消耗.经验.."点经验"
                        日志数据=日志数据.."消耗"..消耗储备.."储备、消耗"..消耗银两.."银子、消耗"..消耗存银.."存银、消耗"..临时消耗.经验.."经验"
              else
                    发送内容="消耗了"..消耗存银.."两存银\n消耗了"..临时消耗.经验.."点经验"
                    日志数据=日志数据.."消耗"..消耗存银.."存银、消耗"..临时消耗.经验.."经验"
              end
              发送数据(玩家数据[self.数据.数字id].连接id,38,{内容=发送内容})
              self:日志记录(日志数据)
              self:银子记录()
              self:刷新信息("2")
              发送数据(连接id,31,玩家数据[id].角色:取总数据())
              刷新货币(连接id,id)
          end
end

function 角色处理类:银子记录()
        self:日志记录("[银子记录]"..self.数据.当前经验.."点经验、"..self.数据.储备.."点储备、"..self.数据.银子.."两银子、"..self.数据.存银.."两存银")
end



function 角色处理类:自定义银子添加(类型,倍数)
  if 倍数==nil then
     倍数 = 1
  end
  if not 玩家数据[self.数据.数字id] then
          __gge.print(true,12,"活动添加银子:玩家数据错误\n")
  elseif not 自定义银子[类型] then
        __gge.print(true,12,"活动添加银子:"..类型.."未定义,文件地址:爆率文件\n")
  else
     local 获得数额 = self.数据.等级
     if 自定义银子[类型].银子 then
         if type(自定义银子[类型].银子)~="number" then
                __gge.print(true,12,"活动添加银子:"..类型.."[银子],值类型错误\n")
         elseif  自定义银子[类型].银子 >0  then
                 self:添加银子(math.floor(获得数额*自定义银子[类型].银子*倍数),类型,1)
         end
     end
     if 自定义银子[类型].固定银子 then
         if type(自定义银子[类型].固定银子)~="number" then
                __gge.print(true,12,"活动添加银子:"..类型.."[固定银子],值类型错误\n")
         elseif  自定义银子[类型].固定银子 >0  then
                 self:添加银子(math.floor(自定义银子[类型].固定银子),类型,1)
         end
     end
     if 自定义银子[类型].经验 then
         if type(自定义银子[类型].经验)~="number" then
                __gge.print(true,12,"活动添加银子:"..类型.."[经验],值类型错误\n")
         elseif  自定义银子[类型].经验 >0  then
                 self:添加经验(math.floor(获得数额*自定义银子[类型].经验*倍数),类型,1)
                 if self.数据.参战信息~=nil then
                   玩家数据[self.数据.数字id].召唤兽:获得经验(self.数据.参战宝宝.认证码,math.floor(获得数额*自定义银子[类型].经验*倍数*0.35),self.数据.数字id,类型)
                end
         end
     end
     if 自定义银子[类型].固定经验 then
         if type(自定义银子[类型].固定经验)~="number" then
                __gge.print(true,12,"活动添加银子:"..类型.."[固定经验],值类型错误\n")
         elseif  自定义银子[类型].固定经验 >0  then
                 self:添加经验(math.floor(自定义银子[类型].固定经验),类型,1)
                if self.数据.参战信息~=nil then
                   玩家数据[self.数据.数字id].召唤兽:获得经验(self.数据.参战宝宝.认证码,math.floor(自定义银子[类型].固定经验*0.35),self.数据.数字id,类型)
                end
         end
     end

    ----------------------------------------------------------------------------------
     if 自定义银子[类型].储备 then
         if type(自定义银子[类型].储备)~="number" then
                __gge.print(true,12,"活动添加银子:"..类型.."[储备],值类型错误\n")
         elseif 自定义银子[类型].储备 >0  then
                 self:添加储备(math.floor(获得数额*自定义银子[类型].储备*倍数),类型,1)
         end
     end
     if 自定义银子[类型].固定储备 then
         if type(自定义银子[类型].固定储备)~="number" then
                __gge.print(true,12,"活动添加银子:"..类型.."[固定储备],值类型错误\n")
         elseif 自定义银子[类型].固定储备 >0  then
                self:添加储备(math.floor(自定义银子[类型].固定储备),类型,1)
         end
     end


---------------------------------------------------------------------------

     if 自定义银子[类型].仙玉 then
          if type(自定义银子[类型].仙玉)~="number" then
                __gge.print(true,12,"活动添加银子:"..类型.."[仙玉],值类型错误\n")
          elseif not 共享货币[玩家数据[self.数据.数字id].账号] then
                  __gge.print(true,12,"活动添加银子:"..类型.."[仙玉],仙玉货币问题,玩家id"..self.数据.数字id.."\n")
          elseif 自定义银子[类型].仙玉 >0  then
                 共享货币[玩家数据[self.数据.数字id].账号]:添加仙玉(math.floor(获得数额*自定义银子[类型].仙玉*倍数),self.数据.数字id,类型)
          end
     end


      if 自定义银子[类型].固定仙玉 then
          if type(自定义银子[类型].固定仙玉)~="number" then
                __gge.print(true,12,"活动添加银子:"..类型.."[固定仙玉],值类型错误\n")
          elseif not 共享货币[玩家数据[self.数据.数字id].账号] then
                  __gge.print(true,12,"活动添加银子:"..类型.."[固定仙玉],仙玉货币问题,玩家id"..self.数据.数字id.."\n")
          elseif 自定义银子[类型].固定仙玉 >0  then
                共享货币[玩家数据[self.数据.数字id].账号]:添加仙玉(math.floor(自定义银子[类型].固定仙玉),self.数据.数字id,类型)
          end
      end


----------------------------------------------------------------------------------------
      if 自定义银子[类型].点卡 then
          if type(自定义银子[类型].点卡)~="number" then
                __gge.print(true,12,"活动添加银子:"..类型.."[点卡],值类型错误\n")
          elseif not 共享货币[玩家数据[self.数据.数字id].账号] then
                  __gge.print(true,12,"活动添加银子:"..类型.."[点卡],仙玉货币问题,玩家id"..self.数据.数字id.."\n")
          elseif 自定义银子[类型].点卡 >0  then
                 共享货币[玩家数据[self.数据.数字id].账号]:添加点卡(math.floor(获得数额*自定义银子[类型].点卡*倍数),self.数据.数字id,类型)
          end
     end
     if 自定义银子[类型].固定点卡 then
          if type(自定义银子[类型].固定点卡)~="number" then
                __gge.print(true,12,"活动添加银子:"..类型.."[固定点卡],值类型错误\n")
          elseif not 共享货币[玩家数据[self.数据.数字id].账号] then
                  __gge.print(true,12,"活动添加银子:"..类型.."[固定点卡],仙玉货币问题,玩家id"..self.数据.数字id.."\n")
          elseif 自定义银子[类型].固定点卡 >0  then
                 共享货币[玩家数据[self.数据.数字id].账号]:添加点卡(math.floor(自定义银子[类型].固定点卡),self.数据.数字id,类型)
          end
     end

  end
end


function 角色处理类:自定义扣除货币(类型,数额,事件,提示)
         数额=math.ceil(数额)
         if 类型=="银子" or 类型== "银两" then
             if self:扣除银子(数额,事件,提示) then
                return true
             else
                 return false
             end
         elseif 类型=="储备" then
             if self.数据.储备>= 数额 then
                self.数据.储备 = self.数据.储备 - 数额
                if 提示~=nil then
                   常规提示(self.数据.数字id,"#Y你失去了#R"..数额.."#Y点储备金")
                end
                return true
             else
                 return false
             end
         elseif 类型=="经验" then
               if self:扣除经验(数额,事件,提示) then
                  return true
               else
                   return false
               end
        elseif 类型=="仙玉" then
               if 共享货币[玩家数据[self.数据.数字id].账号] and 共享货币[玩家数据[self.数据.数字id].账号]:扣除仙玉(数额,事件,self.数据.数字id) then
                    return true
               else
                   return false
               end
        elseif 类型=="点卡" then
               if 共享货币[玩家数据[self.数据.数字id].账号] and 共享货币[玩家数据[self.数据.数字id].账号]:扣除点卡(数额,self.数据.数字id,事件) then
                  return true
               else
                  return false
               end
         end
      return false
end

function 角色处理类:添加银子(数额,说明,提示)
  if not self.数据.银子 or self.数据.银子<0 or self.数据.银子~=math.floor(self.数据.银子) or isNaN(self.数据.银子) then
          self:日志记录(format("事件:添加银子,类型%s,数额%s,获得前%s,银子数据问题已清0",说明,数额,self.数据.银子))
          self.数据.银子=0
  end
  数额 = tonumber(数额)
  if not 数额  or 数额<1 or 数额~=math.floor(数额) or isNaN(数额) then
      return
  end
  local 之前银子=self.数据.银子
  local 倍率=1
  if 说明=="抓鬼奖励" or 说明=="封妖战斗" or 类型=="官职" or 类型=="封妖战斗" or 类型=="种族" or 类型=="门派闯关" or 类型=="初出江湖" or 类型=="悬赏任务"  then
    if self:取任务(2)~=0 then
      倍率=倍率+1
    end
    if self:取任务(3)~=0 then
      倍率=倍率+1
    end
    if self:取任务(7757)~=0 then
         倍率=倍率+1
    end
  end

  数额=数额*倍率
   -- 应用变身卡货币加成
  if self.变身卡扩展处理 then
      数额 = self.变身卡扩展处理:计算货币加成后数值("银子", 数额)
  end
--超级变身卡
  self.数据.银子=self.数据.银子+qz(数额) --+VIP加成
  if 提示~=nil then
      常规提示(self.数据.数字id,"#Y你获得了#R"..数额.."#Y两银子")
      发送数据(玩家数据[self.数据.数字id].连接id,38,{内容="#Y你获得了#R"..数额.."#Y两银子",频道="xt"})
  end
  self:日志记录(format("事件:获得银子,类型%s,数额%s,倍率%s,获得前%s,获得后%s",说明,数额,倍率,之前银子,self.数据.银子))
end

function 角色处理类:添加活跃积分(数额,说明,提示)
  数额 = tonumber(数额)
  if not 数额  or 数额<1 or 数额~=math.floor(数额) or isNaN(数额) then
      return
  end
  if self.数据.活跃积分==nil then
     self.数据.活跃积分=0
  end
  local 之前银子=self.数据.活跃积分
  self.数据.活跃积分=self.数据.活跃积分 + 数额 --+VIP加成
  if 活跃数据[self.数据.数字id]==nil then
     活跃数据[self.数据.数字id]={活跃度=0}
  end
  活跃数据[self.数据.数字id].活跃度 = 活跃数据[self.数据.数字id].活跃度 + 数额
  if 提示~=nil then
      常规提示(self.数据.数字id,"#Y你获得了#R"..数额.."#Y点活跃积分")
  end
  self:日志记录(format("事件:获得活跃积分,类型%s,数额%s,倍率%s,获得前%s,获得后%s",说明,数额,倍率,之前银子,self.数据.活跃积分))
end


function 角色处理类:添加比武积分(数额,说明,提示)
  数额 = tonumber(数额)
  if not 数额  or 数额<1 or 数额~=math.floor(数额) or isNaN(数额) then
      return
  end
  local 之前银子=self.数据.比武积分.当前积分
  self.数据.比武积分.当前积分=self.数据.比武积分.当前积分 + 数额 --+VIP加成
  self.数据.比武积分.总积分 = self.数据.比武积分.总积分 + 数额
  if 提示~=nil then
      常规提示(self.数据.数字id,"#Y你获得了#R"..数额.."#Y点比武积分")
  end
  self:日志记录(format("事件:获得比武积分,类型%s,数额%s,获得前%s,获得后%s",说明,数额,之前银子,self.数据.比武积分.当前积分))
end

function 角色处理类:添加GM币(数额,说明,提示)
  数额 = tonumber(数额)
  if not 数额  or 数额<1 or 数额~=math.floor(数额) or isNaN(数额) then
      return
  end
  local 之前银子=self.数据.GM币.当前积分
  self.数据.GM币.当前积分=self.数据.GM币.当前积分 + 数额
  self.数据.GM币.总积分 = self.数据.GM币.总积分 + 数额
  if 提示~=nil then
      常规提示(self.数据.数字id,"#Y你获得了#R"..数额.."#Y个GM币")
  end
  self:日志记录(format("事件:获得GM币,类型%s,数额%s,获得前%s,获得后%s",说明,数额,之前银子,self.数据.GM币.当前积分))
end



function 角色处理类:添加储备(数额,说明,提示)
  if not self.数据.储备 or self.数据.储备<0 or self.数据.储备~=math.floor(self.数据.储备) or isNaN(self.数据.储备) then
          self:日志记录(format("事件:添加储备,类型%s,数额%s,获得前%s,储备数据问题已清0",说明,数额,self.数据.储备))
          self.数据.储备=0
  end
  数额 = tonumber(数额)
  if not 数额  or 数额<1 or 数额~=math.floor(数额) or isNaN(数额) then
      return
  end
  local 之前银子=self.数据.储备
  self.数据.储备=self.数据.储备+数额
  local 倍率=1
  if 提示~=nil then
    常规提示(self.数据.数字id,"#Y你获得了#R"..数额.."#Y点储备金")
    发送数据(玩家数据[self.数据.数字id].连接id,38,{内容="#Y你获得了#R"..数额.."#Y点储备金",频道="xt"})
  end
  self:日志记录(format("事件:获得储备,类型%s,数额%s,倍率%s,获得前%s,获得后%s",说明,数额,倍率,之前银子,self.数据.储备))
end

function 角色处理类:添加存银(数额,说明,提示)
    if not self.数据.存银 or self.数据.存银<0 or self.数据.存银~=math.floor(self.数据.存银) or isNaN(self.数据.存银) then
          self:日志记录(format("事件:添加存银,类型%s,数额%s,获得前%s,存银数据问题已清0",说明,数额,self.数据.存银))
          self.数据.存银=0
   end
  数额 = tonumber(数额)
  if not 数额  or 数额<1 or 数额~=math.floor(数额) or isNaN(数额) then
       return
  end
  local 之前银子=self.数据.存银
  self.数据.存银=self.数据.存银+数额
  local 倍率=1
  if 提示~=nil then
    常规提示(self.数据.数字id,"你存入了"..数额.."点银子")
  end
  self:日志记录(format("事件:存入存银,类型%s,数额%s,倍率%s,获得前%s,获得后%s",说明,数额,倍率,之前银子,self.数据.存银))
end



function 角色处理类:扣除银子(数额,说明,提示)
      if not self.数据.银子 or self.数据.银子<0 or self.数据.银子~=math.floor(self.数据.银子) or isNaN(self.数据.银子) then
          self:日志记录(format("事件:扣除银子,类型%s,数额%s,获得前%s,银子数据问题已清0",说明,数额,self.数据.银子))
          self.数据.银子=0
      end
  数额 = tonumber(数额)
  if not 数额  or 数额<1 or 数额~=math.floor(数额) or isNaN(数额) then
       return false
  end
  local 之前银子=self.数据.银子
  local 倍率=1
  -- if 储备==0 and 存银==0 then
    if self.数据.银子>=数额 then
      self.数据.银子=self.数据.银子-数额
      if 提示~=nil then
        常规提示(self.数据.数字id,"#Y/你失去了#R/"..数额.."#Y/两银子")
      end
      self:日志记录(format("事件:扣除银子,类型%s,数额%s,倍率%s,获得前%s,获得后%s",说明,数额,倍率,之前银子,self.数据.银子))
      return true
    end
  刷新货币(玩家数据[self.数据.数字id].连接id,self.数据.数字id)
  return false
end

--该方法优先扣除储备
function 角色处理类:扣除储备和银子(金额,说明)
    if not self.数据.银子 or self.数据.银子<0 or self.数据.银子~=math.floor(self.数据.银子) or isNaN(self.数据.银子) then
          self:日志记录(format("事件:扣除银子储备,类型%s,数额%s,获得前%s,银子数据问题已清0",说明,金额,self.数据.银子))
          self.数据.银子=0
    end
    if not self.数据.储备 or self.数据.储备<0 or self.数据.储备~=math.floor(self.数据.储备) or isNaN(self.数据.储备) then
          self:日志记录(format("事件:扣除银子储备,类型%s,数额%s,获得前%s,储备数据问题已清0",说明,金额,self.数据.储备))
          self.数据.储备=0
    end
    金额 = tonumber(金额)
    if not 金额  or 金额<1 or 金额~=math.floor(金额) or isNaN(金额) then
       return false
    end

    if self.数据.储备>=金额 then
        self.数据.储备=self.数据.储备-金额
        self:日志记录(说明.."消耗"..self.数据.储备.."点储备")
        self:银子记录()
  	    刷新货币(玩家数据[self.数据.数字id].连接id,self.数据.数字id)
  	    return true
    elseif self.数据.储备+self.数据.银子>=金额 then
          金额=金额-self.数据.储备
          self:日志记录(说明.."消耗"..self.数据.储备.."点储备、"..金额.."两银子")
          self:银子记录()
          self.数据.银子=self.数据.银子-金额
          self.数据.储备=0
    	    刷新货币(玩家数据[self.数据.数字id].连接id,self.数据.数字id)
    	    return true
    else
        常规提示(id,"你没有那么多的银子")
        return false
    end
    return false
end

function 角色处理类:扣除钓鱼积分(数额,储备,存银,说明,提示)
  数额=数额+0
  local 之前银子=self.数据.钓鱼积分
  local 倍率=1
  if 储备==0 and 存银==0 then
    if self.数据.钓鱼积分>=数额 then
      self.数据.钓鱼积分=self.数据.钓鱼积分-数额
      if 提示~=nil and 说明~="商店购买" then
        常规提示(self.数据.数字id,"你失去了"..数额.."积分")
      end
      self:日志记录(format("事件:扣除钓鱼积分,类型%s,数额%s,倍率%s,获得前%s,获得后%s",说明,数额,倍率,之前银子,self.数据.钓鱼积分))

      return true

    end
  end
end
function 角色处理类:扣除经验(数额,说明,提示)
  if not 数额 or not tonumber(数额) or tonumber(数额)<1 or tonumber(数额)~=math.floor(数额) then
       数额 = 0
  else
      数额=math.floor(数额+0)
  end
  if self.数据.当前经验 >= 数额 then
    self.数据.当前经验 = self.数据.当前经验 - 数额
    if 提示~=nil then
      常规提示(self.数据.数字id,"你失去了"..数额.."点经验")
    end
    return true
  else
    return false
  end
end

function 角色处理类:扣除积分(数额,说明,提示)
  if not 数额 or not tonumber(数额) or tonumber(数额)<1 or tonumber(数额)~=math.floor(数额) then
       数额 = 0
  else
      数额=math.floor(数额+0)
  end
  local 之前积分=self.数据.比武积分.当前积分
  if self.数据.比武积分.当前积分>=数额 then
    self.数据.比武积分.当前积分=self.数据.比武积分.当前积分-数额
    if 提示~=nil and 说明~="商店购买" then
      常规提示(self.数据.数字id,"你失去了"..数额.."点比武积分")
    end
    self:日志记录(format("事件:扣除积分,类型%s,数额%s,倍率%s,获得前%s,获得后%s",说明,数额,倍率,之前积分,self.数据.比武积分.当前积分))
    return true
  else
      return false
  end
end





function 角色处理类:取消任务(id)
    local 任务id=0
    if self.数据.任务 ==nil then self.数据.任务={} return end
    for n, v in pairs(self.数据.任务) do
      if v==id then
          任务id=n
          break
      end
    end
    if 任务id~=0 then
        self.数据.任务[任务id]=nil
    end
    self:刷新任务跟踪()
end

function 角色处理类:获取任务信息(连接id)
  local 任务信息={}
   if self.数据.任务 ==nil then return 0 end
  for n, v in pairs(self.数据.任务) do
    if 任务数据[v]~=nil  then
      任务信息[#任务信息+1]=任务处理类:取任务说明(self.数据.数字id,v)
    else
      self.数据.任务[n]=nil
    end
  end
  发送数据(连接id,40,任务信息)
end



function 角色处理类:取任务(id)
  local 任务id=0
  if self.数据.任务 ==nil then return 0 end
  for n, v in pairs(self.数据.任务) do
    if 任务数据[v]~=nil and 任务数据[v].类型==id then
      任务id=v
    end
  end
  return 任务id
end

function 角色处理类:添加任务(id,队伍,提示,对话)
  for n, v in pairs(self.数据.任务) do
    if v==id then
       return
    end
  end
  local 任务id=0
  for n, v in pairs(self.数据.任务) do
    if v==nil then
       任务id=n
    end
  end
  if 任务id~=0 then
     self.数据.任务[任务id] = id
  else
     self.数据.任务[#self.数据.任务+1]=id
  end
  --发送数据(玩家数据[self.数据.数字id].连接id,46,任务处理类:取任务说明(self.数据.数字id,id))
  self:刷新任务跟踪()
  发送数据(玩家数据[self.数据.数字id].连接id,39)
  if 提示 then
       常规提示(self.数据.数字id,提示)
  end
  if 对话 then
     发送数据(玩家数据[self.数据.数字id].连接id,1501,{名称=对话.名称,模型=对话.模型,对话==对话.内容})
  end
  if 队伍 and 玩家数据[self.数据.数字id].队伍
     and 玩家数据[self.数据.数字id].队伍~=0
     and 玩家数据[self.数据.数字id].队长 then
      if 任务数据[id] then
         任务数据[id].队伍组 = DeepCopy(队伍数据[玩家数据[self.数据.数字id].队伍].成员数据)
      end
      for i,v in ipairs(队伍数据[玩家数据[self.数据.数字id].队伍].成员数据) do
          if v~=self.数据.数字id and 玩家数据[v] then
              玩家数据[v].角色:添加任务(id,nil,提示,对话)
          end
      end
  end


end

function 角色处理类:刷新任务跟踪()
  发送数据(玩家数据[self.数据.数字id].连接id,47)
  local 任务发送={}
  for n, v in pairs(self.数据.任务) do
    if v~=nil and 任务数据[v]~=nil then
      任务发送[#任务发送+1]=任务处理类:取任务说明(self.数据.数字id,v)
      任务发送[#任务发送][3]=任务数据[v].起始
    elseif 任务数据[v] == nil then
      self.数据.任务[n]=nil
    end
  end
  table.sort(任务发送,function(a,b) return a[3]>b[3] end )
  for n=1,#任务发送 do
    发送数据(玩家数据[self.数据.数字id].连接id,46,任务发送[n])
  end
end





function 角色处理类:完成法宝任务()
  名称={"定风珠","雷兽","迷魂灯","幽灵珠","缚妖索","碧玉葫芦","五色旗盒","飞剑","拭剑石","金甲仙衣","惊魂铃","嗜血幡","风袋","九黎战鼓","盘龙壁","神行飞剑","汇灵盏","天师符","织女扇","清心咒"}
  return 名称[取随机数(1,#名称)]
end
function 角色处理类:取随机法宝()
  local 名称={"碧玉葫芦","五色旗盒","飞剑","拭剑石","金甲仙衣","惊魂铃","嗜血幡","风袋","清心咒","九黎战鼓","盘龙壁","神行飞剑","汇灵盏","发瘟匣","断线木偶","五彩娃娃","鬼泣","月光宝盒","混元伞","无魂傀儡","苍白纸人","聚宝盆","乾坤玄火塔","无尘扇","无字经"}
  if self.数据.门派=="大唐官府" then
   名称={"七杀","干将莫邪","碧玉葫芦","五色旗盒","飞剑","拭剑石","金甲仙衣","惊魂铃","嗜血幡","风袋","清心咒","九黎战鼓","盘龙壁","神行飞剑","汇灵盏","发瘟匣","断线木偶","五彩娃娃","鬼泣","月光宝盒","混元伞","无魂傀儡","苍白纸人","聚宝盆","乾坤玄火塔","无尘扇","无字经"}
  elseif self.数据.门派=="化生寺" then
   名称={"慈悲","碧玉葫芦","五色旗盒","飞剑","拭剑石","金甲仙衣","惊魂铃","嗜血幡","风袋","清心咒","九黎战鼓","盘龙壁","神行飞剑","汇灵盏","发瘟匣","断线木偶","五彩娃娃","鬼泣","月光宝盒","混元伞","无魂傀儡","苍白纸人","聚宝盆","乾坤玄火塔","无尘扇","无字经"}
  elseif self.数据.门派=="方寸山" then
   名称={"救命毫毛","碧玉葫芦","五色旗盒","飞剑","拭剑石","金甲仙衣","惊魂铃","嗜血幡","风袋","清心咒","九黎战鼓","盘龙壁","神行飞剑","汇灵盏","发瘟匣","断线木偶","五彩娃娃","鬼泣","月光宝盒","混元伞","无魂傀儡","苍白纸人","聚宝盆","乾坤玄火塔","无尘扇","无字经"}
  elseif self.数据.门派=="天宫" then
   名称={"伏魔天书","碧玉葫芦","五色旗盒","飞剑","拭剑石","金甲仙衣","惊魂铃","嗜血幡","风袋","清心咒","九黎战鼓","盘龙壁","神行飞剑","汇灵盏","发瘟匣","断线木偶","五彩娃娃","鬼泣","月光宝盒","混元伞","无魂傀儡","苍白纸人","聚宝盆","乾坤玄火塔","无尘扇","无字经"}
  elseif self.数据.门派=="普陀山" then
   名称={"金刚杵","普渡","碧玉葫芦","五色旗盒","飞剑","拭剑石","金甲仙衣","惊魂铃","嗜血幡","风袋","清心咒","九黎战鼓","盘龙壁","神行飞剑","汇灵盏","发瘟匣","断线木偶","五彩娃娃","鬼泣","月光宝盒","混元伞","无魂傀儡","苍白纸人","聚宝盆","乾坤玄火塔","无尘扇","无字经"}
  elseif self.数据.门派=="龙宫" then
   名称={"镇海珠","碧玉葫芦","五色旗盒","飞剑","拭剑石","金甲仙衣","惊魂铃","嗜血幡","风袋","清心咒","九黎战鼓","盘龙壁","神行飞剑","汇灵盏","发瘟匣","断线木偶","五彩娃娃","鬼泣","月光宝盒","混元伞","无魂傀儡","苍白纸人","聚宝盆","乾坤玄火塔","无尘扇","无字经"}
  elseif self.数据.门派=="五庄观" then
   名称={"奇门五行令","碧玉葫芦","五色旗盒","飞剑","拭剑石","金甲仙衣","惊魂铃","嗜血幡","风袋","清心咒","九黎战鼓","盘龙壁","神行飞剑","汇灵盏","发瘟匣","断线木偶","五彩娃娃","鬼泣","月光宝盒","混元伞","无魂傀儡","苍白纸人","聚宝盆","乾坤玄火塔","无尘扇","无字经"}
  elseif self.数据.门派=="狮驼岭" then
   名称={"兽王令","失心钹","碧玉葫芦","五色旗盒","飞剑","拭剑石","金甲仙衣","惊魂铃","嗜血幡","风袋","清心咒","九黎战鼓","盘龙壁","神行飞剑","汇灵盏","发瘟匣","断线木偶","五彩娃娃","鬼泣","月光宝盒","混元伞","无魂傀儡","苍白纸人","聚宝盆","乾坤玄火塔","无尘扇","无字经"}
  elseif self.数据.门派=="魔王寨" then
   名称={"五火神焰印","碧玉葫芦","五色旗盒","飞剑","拭剑石","金甲仙衣","惊魂铃","嗜血幡","风袋","清心咒","九黎战鼓","盘龙壁","神行飞剑","汇灵盏","发瘟匣","断线木偶","五彩娃娃","鬼泣","月光宝盒","混元伞","无魂傀儡","苍白纸人","聚宝盆","乾坤玄火塔","无尘扇","无字经"}
  elseif self.数据.门派=="阴曹地府" then
   名称={"九幽","碧玉葫芦","五色旗盒","飞剑","拭剑石","金甲仙衣","惊魂铃","嗜血幡","风袋","清心咒","九黎战鼓","盘龙壁","神行飞剑","汇灵盏","发瘟匣","断线木偶","五彩娃娃","鬼泣","月光宝盒","混元伞","无魂傀儡","苍白纸人","聚宝盆","乾坤玄火塔","无尘扇","无字经"}
  end
  return 名称[取随机数(1,#名称)]
end





function 角色处理类:删除角色(id,数据)
--     local 删除= 数据.文本+0
--     local 玩家=self.数据.数字id
--   if 玩家 ~= 删除 then
-- -- 常规提示(id,"本门派不收你这样的弟子"..玩家..删除)
--      发送数据(玩家数据[id].连接id,7,"/#Y/咋的少侠？你还想删了他人的角色吗#55")
--   else
--       -- local 写入信息=table.loadstring(读入文件(self.数据.账号..[[/信息.txt]]))

--   local 写入信息=table.loadstring(读入文件([[data/]]..self.数据.账号..[[/信息.txt]]))
-- 	 for i,v in ipairs(写入信息) do
-- 		if v == 删除 then
-- 			table.remove(写入信息,i)
-- 		end
-- 	end

--        -- 写出文件([[data/]]..self.数据.账号..[[/]]..self.数据.数字id..
--       写出文件([[data/]]..self.数据.账号..[[/信息.txt]],table.tostring(写入信息))
--      --   -- __C客户信息[玩家数据[数字id].连接id]=nil

--        发送数据(玩家数据[id].连接id,998,"你已经与这个世界隔离了,88了您")
--        --__S服务:断开连接(玩家数据[id].连接id)
-- 		玩家数据[id].连接id=id
--              系统处理类:断开游戏(id)
--         __N连接数 = __N连接数-1

--   end
 end

function 角色处理类:加载数据(账号,id)
  self.数据=table.loadstring(读入文件([[data/]]..账号..[[/]]..id..[[/角色.txt]]))
  self.数据.数字id=id
  if self.数据.变身数据~=nil and (self:取任务(1)==0 or 任务数据[self:取任务(1)]==nil) then
      self:取消任务(self:取任务(1))
      -- 清除变身卡扩展效果：超级变身卡
      if self.变身卡扩展处理 then
          self.变身卡扩展处理:清除变身卡扩展效果()
      end
      self.数据.变身数据=nil
      if self.数据.变异~=nil then
        self.数据.变异=nil
      end
  end
  for n, v in pairs(self.数据.任务) do
    if 任务数据[v]==nil  then
      self.数据.任务[n]=nil
    end
  end
  if self.数据.接受给予 == nil then
    self.数据.接受给予 = true
  end
  if self.数据.账号 ~= 账号 then
     self.数据.账号=账号
  end
  if not self.数据.月卡 then
      self.数据.月卡={购买时间=0,到期时间=0,当前领取=0,开通=false}
  else
      self.数据.月卡.开通=false
  end
  if not self.数据.清理数据 then
      self.数据.清理数据=0
  end
  if f函数.文件是否存在([[data/]]..账号..[[/]]..id..[[/消息记录]])==false then
        lfs.mkdir([[data/]]..账号..[[/]]..id..[[/消息记录]])
  end
  self.日志内容="日志创建"
  if not f函数.文件是否存在([[data/]]..self.数据.账号..[[/]]..self.数据.数字id..[[/日志记录/]]..取年月日1(os.time())..[[1.txt]]) then
      self.数据.日志编号=1
  end
  if f函数.文件是否存在([[data/]]..账号..[[/]]..id..[[/日志记录/]]..取年月日1(os.time())..self.数据.日志编号..[[.txt]]) then
      self.日志内容 = 读入文件([[data/]]..账号..[[/]]..id..[[/日志记录/]]..取年月日1(os.time())..self.数据.日志编号..[[.txt]])
  end
  if tonumber(self.数据.清理数据) ~=tonumber(os.date("%d", os.time())) then
      local 日志数量 = 取文件的所有名(程序目录..[[/data/]]..账号..[[/]]..id..[[/日志记录]])

      for i=1,#日志数量 do
            if string.find(日志数量[i],"年") then
                local 年份 = 分割文本(日志数量[i],"年")
                local 月份 = 分割文本(年份[2],"月")
                local 日份 = 分割文本(月份[2],"日")
                local 时间戳 = os.time({day=日份[1], month=月份[1], year=年份[1], hour=0, minute=0, second=0})
                if os.time() - 时间戳 >= 5184000  then
                    os.remove(程序目录..[[\data\]]..账号..[[\]]..id..[[\日志记录\]]..日志数量[i]..[[.txt]])
                end
            end
      end

      local 消息数量 = 取文件的所有名(程序目录..[[/data/]]..账号..[[/]]..id..[[/消息记录]])
      for i=1,#消息数量 do
          if tonumber(消息数量[i]) and os.time()-tonumber(消息数量[i])>=5184000  then
              os.remove(程序目录..[[\data\]]..账号..[[\]]..id..[[\消息记录\]]..消息数量[i]..[[.txt]])
          end
      end
      self.数据.清理数据=os.date("%d", os.time())
  end
  if self.数据.GM等级 == nil then
    self.数据.GM等级 = 0
  end
  local gm_just_set = false
  if self.数据.GM等级 == nil then
    self.数据.GM等级 = 0
    gm_just_set = true
  end
  if gm_just_set then
    self:存档()
  end
end

function 角色处理类:取地图数据()
  local 要求数据={
    x=self.数据.地图数据.x
    ,y=self.数据.地图数据.y
    ,名称=self.数据.名称
    ,模型=self.数据.模型
    ,id=self.数据.数字id
    ,武器=nil
    ,副武器=nil
    ,染色=nil
    ,称谓=nil
    ,当前称谓 = self.数据.当前称谓
    ,队长=玩家数据[self.数据.数字id].队长
    ,染色组=self.数据.染色组
    ,染色方案=self.数据.染色方案
    ,变身数据=self.数据.变身数据
    ,变异=self.数据.变异
    ,战斗开关=self.战斗开关
    ,坐骑=self.数据.坐骑
    ,锦衣={}
    ,pk开关=self.数据.PK开关
    ,强p开关=self.数据.强P开关
    ,飞行 =self.数据.飞行
    ,月卡 =self.数据.月卡
    ,离线摆摊 =self.数据.离线摆摊
  }
  if self.数据.装备[3]~=nil then
    要求数据.武器=DeepCopy(玩家数据[self.数据.数字id].道具.数据[self.数据.装备[3]])
  end
  if self.数据.装备[4]~=nil and self.数据.模型=="影精灵" and  string.find(玩家数据[self.数据.数字id].道具.数据[self.数据.装备[4]].名称,"(坤)") then
      要求数据.副武器=DeepCopy(玩家数据[self.数据.数字id].道具.数据[self.数据.装备[4]])
  end
  if self.数据.锦衣[1]~=nil then
    要求数据.锦衣[1]=DeepCopy(玩家数据[self.数据.数字id].道具.数据[self.数据.锦衣[1]])
  end
  if self.数据.锦衣[2]~=nil then
    要求数据.锦衣[2]=DeepCopy(玩家数据[self.数据.数字id].道具.数据[self.数据.锦衣[2]])
  end
  if self.数据.锦衣[3]~=nil then
    要求数据.锦衣[3]=DeepCopy(玩家数据[self.数据.数字id].道具.数据[self.数据.锦衣[3]])
  end
  if self.数据.锦衣[4]~=nil then
    要求数据.锦衣[4]=DeepCopy(玩家数据[self.数据.数字id].道具.数据[self.数据.锦衣[4]])
  end
  if 玩家数据[self.数据.数字id].摊位数据~=nil then
    要求数据.摊位名称=玩家数据[self.数据.数字id].摊位数据.名称
  end
  return 要求数据
end

function 角色处理类:取队伍信息()
  local 发送数据={
    模型=self.数据.模型,
    染色=self.染色,
    等级=self.数据.等级,
    名称=self.数据.名称,
    门派=self.数据.门派,
    染色组=self.数据.染色组,
    染色方案=self.数据.染色方案,
    当前称谓 = self.数据.当前称谓,
    id=self.数据.数字id,
    变身数据=self.数据.变身数据,
    变异=self.数据.变异,
    坐骑=self.数据.坐骑,
    装备={},
    锦衣={},
    阵法=self.数据.阵法,
    高级阵法=self.数据.高级阵法,
    八卦阵=self.数据.高级阵法.八卦阵,
  }
  if self.数据.装备[3]~=nil then
     发送数据.装备[3]=DeepCopy(玩家数据[self.数据.数字id].道具.数据[self.数据.装备[3]])
  end
  if self.数据.装备[4]~=nil and self.数据.模型=="影精灵" and  string.find(玩家数据[self.数据.数字id].道具.数据[self.数据.装备[4]].名称,"(坤)") then
     发送数据.装备[4]=DeepCopy(玩家数据[self.数据.数字id].道具.数据[self.数据.装备[4]])
  end
  if self.数据.锦衣[1]~=nil then
    发送数据.锦衣[1]=DeepCopy(玩家数据[self.数据.数字id].道具.数据[self.数据.锦衣[1]])
  end
  if self.数据.锦衣[2]~=nil then
    发送数据.锦衣[2]=DeepCopy(玩家数据[self.数据.数字id].道具.数据[self.数据.锦衣[2]])
  end
  if self.数据.锦衣[3]~=nil then
    发送数据.锦衣[3]=DeepCopy(玩家数据[self.数据.数字id].道具.数据[self.数据.锦衣[3]])
  end
  if self.数据.锦衣[4]~=nil then
    发送数据.锦衣[4]=DeepCopy(玩家数据[self.数据.数字id].道具.数据[self.数据.锦衣[4]])
  end
  return 发送数据
end

function 角色处理类:取总数据()
  local 存档数据={}
  if self.数据.气血上限 == nil then
    self.数据.气血上限 = self.数据.最大气血
  end
  if self.数据.气血上限 > self.数据.最大气血 then
    self.数据.气血上限 = self.数据.最大气血
  end
  if self.数据.气血 > self.数据.气血上限 then
     self.数据.气血 = self.数据.气血上限
 end

  for i,v in pairs(self.数据) do
     存档数据[i] = self.数据[i]
  end
  存档数据.装备=self:取装备数据()
  存档数据.灵饰=self:取灵饰数据()
  存档数据.锦衣=self:取锦衣数据()
  存档数据.法宝=self:取法宝数据()
  存档数据.灵宝=self:取灵宝数据()
  存档数据.法宝佩戴=self:取佩戴法宝数据()
  存档数据.灵宝佩戴=self:取佩戴灵宝数据()
  if 玩家数据[self.数据.数字id].神器 and 玩家数据[self.数据.数字id].神器.数据 and 玩家数据[self.数据.数字id].神器.数据.神器技能 and self.数据.门派~="无门派" then
      存档数据.神器数据 = DeepCopy(玩家数据[self.数据.数字id].神器.数据)
  else
      self.数据.神器佩戴 =false
      存档数据.神器佩戴 =false
  end
  if self.数据.气血上限 > self.数据.最大气血 then
    self.数据.气血上限 = self.数据.最大气血
  end
  if self.数据.气血 > self.数据.气血上限 then
    self.数据.气血 = self.数据.气血上限
  end
  return 存档数据
end




function 角色处理类:存档()

  if not self.数据.数字id then return end
  if not self.数据.日志编号 then
      self.数据.日志编号=1
  end
  写出文件([[data/]]..self.数据.账号..[[/]]..self.数据.数字id..[[/日志记录/]]..取年月日1(os.time())..self.数据.日志编号..[[.txt]],self.日志内容)
  写出文件([[data/]]..self.数据.账号..[[/]]..self.数据.数字id.."/角色.txt",table.tostring(self.数据))
  if 玩家数据[self.数据.数字id]==nil then
    写出文件([[data/]]..self.数据.账号..[[/]]..self.数据.数字id.."/道具.txt",table.tostring({}))
    写出文件([[data/]]..self.数据.账号..[[/]]..self.数据.数字id.."/召唤兽.txt",table.tostring({}))
    写出文件([[data/]]..self.数据.账号..[[/]]..self.数据.数字id.."/召唤兽仓库.txt",table.tostring({[1]={}}))
    写出文件([[data/]]..self.数据.账号..[[/]]..self.数据.数字id.."/道具仓库.txt",table.tostring({[1]={},[2]={},[3]={}}))
    写出文件([[data/]]..self.数据.账号..[[/]]..self.数据.数字id.."/神器.txt",table.tostring({}))    --神器
    写出文件([[data/]]..self.数据.账号..[[/]]..self.数据.数字id.."/房屋数据.txt",table.tostring({是否创建=false}))
    写出文件([[data/]]..self.数据.账号..[[/]]..self.数据.数字id.."/好友数据.txt",table.tostring({好友={},黑名单={},分组={[1]={名称="自定义分组1",好友={}}},留言信息={}}))
  else
    写出文件([[data/]]..self.数据.账号..[[/]]..self.数据.数字id.."/道具.txt",table.tostring(玩家数据[self.数据.数字id].道具.数据))
    写出文件([[data/]]..self.数据.账号..[[/]]..self.数据.数字id.."/召唤兽.txt",table.tostring(玩家数据[self.数据.数字id].召唤兽:取存档数据()))
    写出文件([[data/]]..self.数据.账号..[[/]]..self.数据.数字id.."/召唤兽仓库.txt",table.tostring(玩家数据[self.数据.数字id].召唤兽仓库.数据))
    写出文件([[data/]]..self.数据.账号..[[/]]..self.数据.数字id.."/道具仓库.txt",table.tostring(玩家数据[self.数据.数字id].道具仓库.数据))
    写出文件([[data/]]..self.数据.账号..[[/]]..self.数据.数字id.."/神器.txt",table.tostring(玩家数据[self.数据.数字id].神器.数据))   ---神器
    玩家数据[self.数据.数字id].房屋:存档()
    玩家数据[self.数据.数字id].好友:存档()
  end
end










function 角色处理类:加入门派(id,门派)
  if 门派~="九黎城" and 可入门派[self.数据.种族][门派]==nil and 可入门派[self.数据.种族][self.数据.性别][门派]==nil and (f函数.读配置(程序目录.."配置文件.ini","主要配置","门派限制") == nil or f函数.读配置(程序目录.."配置文件.ini","主要配置","门派限制") == "" or f函数.读配置(程序目录.."配置文件.ini","主要配置","门派限制") == 1 or f函数.读配置(程序目录.."配置文件.ini","主要配置","门派限制") == "1") then
      常规提示(id,"本门派不收你这样的弟子")
      return
  elseif self.数据.门派~="无门派"then
      常规提示(id,"#Y你已经投入其它门派")
      return
 elseif 门派~="九黎城" and self.数据.模型=="影精灵" then
      常规提示(id,"#Y该角色无法拜入其他门派")
      return
  end
  self.数据.门派=门派
  玩家数据[self.数据.数字id].经脉.门派 = 门派
  local 加载流派 = 玩家数据[self.数据.数字id].经脉:取经脉流派()
   self.数据.奇经八脉= 加载流派
  local 已有流派= {}
  for i,v in pairs(加载流派) do
    已有流派[#已有流派+1] = i
  end
  self.数据.经脉流派 = 已有流派[1] ------------三经脉重做
  玩家数据[self.数据.数字id].经脉:加载数据(self.数据.数字id)
  常规提示(id,"你成为了#R/"..门派.."#Y/弟子")
  self.数据.师门技能={}
  if not self.数据.技能保留 then self.数据.技能保留 = {} end
  if self.数据.门派 ~= "无门派" and self.数据.师门技能[1] == nil then
    local 列表 = self:取门派技能(self.数据.门派)
    for n=1,#列表 do
        self.数据.师门技能[n] = jnzb()
        self.数据.师门技能[n]:置对象(列表[n])
        self.数据.师门技能[n].包含技能 = {}
        self.数据.师门技能[n].等级= 1
        if self.数据.技能保留[n] then
             self.数据.师门技能[n].等级=self.数据.技能保留[n]
        end
        local w = self:取包含技能(self.数据.师门技能[n].名称)
        for s=1,#w do
          self.数据.师门技能[n].包含技能[s] = jnzb()
          self.数据.师门技能[n].包含技能[s]:置对象(w[s])
          self.数据.师门技能[n].包含技能[s].等级= self.数据.师门技能[n].等级
        end
        self:升级技能(self.数据.师门技能[n])
    end
  end

      if self.数据.帮派数据.编号 ~=nil and  self.数据.帮派数据.编号>0 then
          local 帮派编号 = self.数据.帮派数据.编号
          local id2=self.数据.ID
         帮派数据[帮派编号].成员数据[id2].门派 =self.数据.门派
       end
  --加入奖励

  self:刷新信息("2")
  if 玩家数据[self.数据.数字id].神器 and 玩家数据[self.数据.数字id].神器.数据 and 玩家数据[self.数据.数字id].神器.数据.神器技能 and self.数据.门派~="无门派" then
      玩家数据[self.数据.数字id].神器:转换神器(self.数据.数字id)   ----神器
  end
  if self.数据.等级<=50 then
    礼包奖励类:设置拜师奖励(self.数据.数字id)
  end
end









function 角色处理类:穿戴装备(装备,格子,id)
      if 装备.星位~=nil and 装备.星位.组合~=nil and 装备.星位.组合等级~=nil then
          装备符石处理:穿戴装备符文组合(self.数据.数字id,装备,格子)
      end
end
function 角色处理类:卸下装备(装备,格子,id)
    if 装备.星位~=nil and 装备.星位.组合~=nil and 装备.星位.组合等级~=nil  then
        装备符石处理:卸下装备符文组合(self.数据.数字id,装备,格子)
    end
end
function 角色处理类:判断是否穿戴装备()
          for n, v in pairs(self.数据.装备) do
              if self.数据.装备[n]~=nil then
                  常规提示(self.数据.数字id,"#Y请先卸下人物装备")
                  return false
              end
          end
          for n, v in pairs(self.数据.灵饰) do
              if self.数据.灵饰[n]~=nil then
                  常规提示(self.数据.数字id,"#Y请先卸下灵饰")
                  return false
              end
          end
          for n, v in pairs(self.数据.锦衣) do
              if self.数据.锦衣[n]~=nil then
                  常规提示(self.数据.数字id,"#Y请先卸下锦衣")
                  return false
              end
          end
          for n, v in pairs(self.数据.法宝佩戴) do
              if self.数据.法宝佩戴[n]~=nil then
                  常规提示(self.数据.数字id,"#Y请先卸下法宝")
                  return false
              end
          end
          for n, v in pairs(self.数据.灵宝佩戴) do
              if self.数据.灵宝佩戴[n]~=nil then
                  常规提示(self.数据.数字id,"#Y请先卸下灵宝")
                  return false
              end
          end
          if self.数据.神器佩戴 then
                常规提示(self.数据.数字id,"#Y请先卸下神器")
                return false
          end
         return true
end



function 角色处理类:洗点操作(id)
    if not self:判断是否穿戴装备() then return  end
    local 银子=2000000
    if self.数据.银子<银子 then
      常规提示(self.数据.数字id,"#Y你身上没有那么多的银子")
      return
    end
    self:扣除银子(银子,"人物洗点",1)

    self:洗点处理()
    self:刷新信息("1")
    添加最后对话(id,"你的人物属性点重置成功！")
end

function 角色处理类:洗点处理()
    self.数据.加点记录 = {体质=0,魔力=0,力量=0,耐力=0,敏捷=0}
    if  self.数据.飞升 then
        self.数据.潜力 = self.数据.等级*5+105
    else
        self.数据.潜力 = self.数据.等级*5+5
    end

    if self.数据.五虎上将 ~= nil then
      if self.数据.五虎上将 == 1 then
        self.数据.潜力 = self.数据.潜力 + 10
      elseif self.数据.五虎上将 == 2 then
        self.数据.潜力 = self.数据.潜力 + 30
      elseif self.数据.五虎上将 == 3 then
        self.数据.潜力 = self.数据.潜力 + 60
      elseif self.数据.五虎上将 >= 4 then
        self.数据.潜力 = self.数据.潜力 + 100
      elseif self.数据.五虎上将 >= 5 then
        self.数据.潜力 = self.数据.潜力 + 150
      end
    end
    if self.数据.潜能果 ~= nil then
        self.数据.潜力 = self.数据.潜力 + self.数据.潜能果
    end
    if self.数据.月饼 ~= nil then
        self.数据.潜力 = self.数据.潜力 + self.数据.月饼*2
    end
    self.数据.神器属性 = {速度=0,法术防御=0,防御=0,气血=0,伤害=0,法术伤害=0,固定伤害=0,治疗能力=0,法术暴击等级=0,物理暴击等级=0,封印命中等级=0,抵抗封印等级=0}  ---神器

end



function 角色处理类:退出门派(id)
  if not self:判断是否穿戴装备() then return  end
  if self.数据.银子 < 5000000 then
      常规提示(self.数据.数字id,"#Y你身上没有那么多的银子")
      return
  end
  self:批量删除称谓("首席大弟子")
  self:扣除银子(5000000,"退出门派",1)
  self.数据.门派="无门派"
  if not self.数据.技能保留 then
      self.数据.技能保留 = {}
       for k,v in pairs(self.数据.师门技能) do
             self.数据.技能保留[k] = v.等级
       end
  end
  for  k,v in pairs(self.数据.技能保留) do
        if v> 180 then
             v = 180
        elseif v > self.数据.等级+10 then
              if self.数据.飞升 and v > 154 and self.数据.等级<=144 then
                  v = 154
              else
                  v = self.数据.等级+10
              end
        elseif v < 1 then
                v = 1
        end
  end
  self.数据.师门技能={}
  self.数据.奇经八脉={}
  self.数据.经脉流派 = "无" ------------三经脉重做
  玩家数据[self.数据.数字id].奇经八脉 ={}
  玩家数据[self.数据.数字id].经脉.门派 ="无"
  玩家数据[self.数据.数字id].经脉.当前经脉 ="无"
  玩家数据[self.数据.数字id].经脉.已学经脉 ={}
  self.数据.乾元丹.剩余乾元丹=self.数据.乾元丹.剩余乾元丹+self.数据.乾元丹.乾元丹
  self.数据.乾元丹.乾元丹=0
  玩家数据[self.数据.数字id].经脉.乾元丹 = self.数据.乾元丹
  self.数据.快捷技能={}
  self.数据.人物技能={}
  if self.数据.自动指令~=nil then
     self.数据.自动指令={下达=false,类型="攻击",目标=0,敌我=0,参数="",附加=""}
  end
  self:刷新信息("1")
  发送数据(玩家数据[self.数据.数字id].连接id,42,self.数据.快捷技能)
  添加最后对话(self.数据.数字id,"你已经退出门派了，成为了无门派人士！")
  广播消息({内容=format("#G%s#R背信弃义,背叛了门派,现昭告天下,有钱你就了不起啊、了不起啊!#"..取随机数(1,110),self.数据.名称),频道="xt"})
        if self.数据.帮派数据.编号 ~=nil and  self.数据.帮派数据.编号>0 then
          local 帮派编号 = self.数据.帮派数据.编号
          local id2=self.数据.ID
         帮派数据[帮派编号].成员数据[id2].门派 =self.数据.门派
       end
end




function 角色处理类:门派转换(id,内容)
      if not self:判断是否穿戴装备() then return  end
      if self.数据.门派=="九黎城" or self.数据.原始模型 then
          常规提示(self.数据.数字id,"#Y你当前状态无法更换造型,请退出九黎城或换回原型")
          return
      end

      local 目标角色=内容.角色
      local 目标门派=内容.门派
      local 支付方式=内容.支付方式
      local 性别 = "男"
      local 种族 = "人"
      if 目标角色=="飞燕女" or 目标角色=="英女侠" or 目标角色=="巫蛮儿" or 目标角色=="狐美人" or 目标角色=="骨精灵" or 目标角色=="鬼潇潇" or 目标角色=="舞天姬" or 目标角色=="玄彩娥" or 目标角色=="桃夭夭" then
         性别="女"
         if 目标角色=="狐美人" or 目标角色=="骨精灵" or 目标角色=="鬼潇潇" then
            种族 = "魔"
         elseif 目标角色=="舞天姬" or 目标角色=="玄彩娥" or 目标角色=="桃夭夭" then
            种族 = "仙"
         end
      elseif 目标角色=="杀破狼" or 目标角色=="巨魔王" or 目标角色=="虎头怪" then
            种族 = "魔"
      elseif 目标角色=="羽灵神" or 目标角色=="神天兵" or 目标角色=="龙太子" then
            种族 = "仙"
      end

      if 可入门派[种族][目标门派] == nil and 可入门派[种族][性别][目标门派] == nil then
          常规提示(self.数据.数字id, "本门派不收你这样的弟子")
          return
      end

      local 需求经验 = 0
      local 需求银子 = 0
      if self.数据.转门派~=nil then
          if 支付方式=="经验银子"  then
              if self.数据.模型~=目标角色 then
                 需求经验= 600000000
                 需求银子 = 20000000
              else
                 需求经验= 300000000
                 需求银子 = 5000000
              end
          else
             if self.数据.模型~=目标角色 then
                 需求银子 = 40000000
              else
                 需求银子 = 15000000
              end
          end
      end
      if 玩家数据[self.数据.数字id].转换门派模式 then
         需求经验 = 0
      end

      if 需求经验>0 and self.数据.当前经验< 需求经验   then
          常规提示(self.数据.数字id, "你的经验不够")
          return
      end
      if 需求银子>0 and self.数据.银子< 需求银子  then
          常规提示(self.数据.数字id, "你的银子不够")
          return
      end

      if 需求经验>0  then
         self:扣除经验(需求经验,"转换门派",1)
      end
      if 需求银子>0 then
         self:扣除银子(需求银子,0,0,"转换门派",1)
      end
      self.数据.转门派 = true
      if self.数据.模型~=目标角色 then
          local ls = self:队伍角色(目标角色)
          self.数据.性别 = 性别
          self.数据.模型 = 目标角色
          self.数据.造型 = 目标角色
          self.数据.种族 = 种族
          self.数据.染色方案 = ls.染色方案
          self.数据.可持有武器 = ls.武器
      end
      self.数据.快捷技能 = {}
      发送数据(玩家数据[self.数据.数字id].连接id, 42, self.数据.快捷技能)
      self.数据.门派 = 目标门派
      if not self.数据.技能保留 then
          self.数据.技能保留 = {}
           for k,v in pairs(self.数据.师门技能) do
                 self.数据.技能保留[k] = v.等级
           end
      end
      for  k,v in pairs(self.数据.技能保留) do
            if v> 180 then
                 v = 180
            elseif v > self.数据.等级+10 then
                  if self.数据.飞升 and v > 154 and self.数据.等级<=144 then
                      v = 154
                  else
                      v = self.数据.等级+10
                  end
            elseif v < 1 then
                    v = 1
            end
      end
      self.数据.师门技能={}
      self.数据.人物技能 = {}
      self.数据.奇经八脉={}
      self.数据.经脉流派 = "无" ------------三经脉重做
      玩家数据[self.数据.数字id].奇经八脉 ={}
      玩家数据[self.数据.数字id].经脉.门派 ="无"
      玩家数据[self.数据.数字id].经脉.当前经脉 ="无"
      玩家数据[self.数据.数字id].经脉.已学经脉 ={}
      self.数据.乾元丹.剩余乾元丹=self.数据.乾元丹.剩余乾元丹+self.数据.乾元丹.乾元丹
      self.数据.乾元丹.乾元丹=0
      玩家数据[self.数据.数字id].经脉.乾元丹 = self.数据.乾元丹
      if self.数据.门派 ~= "无门派" then
          玩家数据[self.数据.数字id].经脉.门派 = self.数据.门派
          local 加载流派 = 玩家数据[self.数据.数字id].经脉:取经脉流派()
          self.数据.奇经八脉= 加载流派
          local 已有流派= {}
          for i,v in pairs(加载流派) do
              已有流派[#已有流派+1] = i
          end
          self.数据.经脉流派 = 已有流派[1] ------------三经脉重做
          玩家数据[self.数据.数字id].经脉:加载数据(self.数据.数字id)
      end
      if self.数据.门派 ~= "无门派" and self.数据.师门技能[1] == nil then
          local 列表 = self:取门派技能(self.数据.门派)
          for n=1,#列表 do
              self.数据.师门技能[n] = jnzb()
              self.数据.师门技能[n]:置对象(列表[n])
              self.数据.师门技能[n].包含技能 = {}
              self.数据.师门技能[n].等级= 1
              if self.数据.技能保留[n] then
                  self.数据.师门技能[n].等级=self.数据.技能保留[n]
              end
              local w = self:取包含技能(self.数据.师门技能[n].名称)
              for s=1,#w do
                self.数据.师门技能[n].包含技能[s] = jnzb()
                self.数据.师门技能[n].包含技能[s]:置对象(w[s])
                self.数据.师门技能[n].包含技能[s].等级= self.数据.师门技能[n].等级
              end
             self:升级技能(self.数据.师门技能[n])
          end
      end
      self:洗点处理()
      if self.数据.自动指令~=nil then
          self.数据.自动指令={下达=false,类型="攻击",目标=0,敌我=0,参数="",附加=""}
      end
      self:刷新信息("2")
      常规提示(self.数据.数字id, "转换门派成功，请重新上线！")
      玩家数据[self.数据.数字id].转换门派模式 = nil
      if 玩家数据[self.数据.数字id].神器 and 玩家数据[self.数据.数字id].神器.数据 and 玩家数据[self.数据.数字id].神器.数据.神器技能 and self.数据.门派~="无门派" then
          玩家数据[self.数据.数字id].神器:转换神器(self.数据.数字id)   ----神器
      end
end



function 角色处理类:转换武器操作(id,装备,子类)
  if 玩家数据[id].账号==nil or id==nil or 装备==nil or not 共享货币[玩家数据[id].账号] then
      print("报错了")
      return
  end

  if 共享货币[玩家数据[id].账号].仙玉< 1000  then
   常规提示(id,"装备转换造型需要1000仙玉，少侠的仙玉不够哦！")
    return
  end
  if 装备.原始数据 then
      常规提示(id,"该装备无法转换,请换回原始造型后在来操作")
      return
  end

  local 等级=math.floor(装备.级别限制/10)
  local 装备名称=""
  if 装备.分类==3 and 子类<19 then
    装备名称=玩家数据[id].装备.打造物品[子类][等级+1]
    if 等级>=9 and 等级<12 then
      装备名称=玩家数据[id].装备.打造物品[子类][取随机数(10,12)]
    elseif 等级>=12 and 等级<15 then
      装备名称=玩家数据[id].装备.打造物品[子类][取随机数(13,15)]
    end
  elseif 装备.分类==4 and (子类==22 or 子类==23) then
    local 衣服类型=2
    if 子类==22 then
      衣服类型=1
    end
    子类=21
    装备名称 = 玩家数据[id].装备.打造物品[子类][等级+1][衣服类型]
  elseif 装备.分类==1 and (子类==19 or 子类==20) then
    local 头盔类型=1
    if 子类==20 then
      头盔类型=2
    end
    子类=19
    装备名称 = 玩家数据[id].装备.打造物品[子类][等级+1][头盔类型]
  else
    常规提示(id,"请选择正确的转换造型")
    return
  end
  共享货币[玩家数据[id].账号]:扣除仙玉(1000,"转换武器",id)

  装备.子类=子类
  装备.名称=装备名称
  if 装备.性别限制 ~= nil and 取物品数据(装备.名称) ~= nil and 取物品数据(装备.名称)[6] ~= nil then
    装备.性别限制 = 取物品数据(装备.名称)[6]
  end
  if 装备.角色限制 ~= nil and 取物品数据(装备.名称) ~= nil and 取物品数据(装备.名称)[7] ~= nil then
    装备.角色限制 = 取物品数据(装备.名称)[7]
  end
  道具刷新(id)
  常规提示(id,"装备造型转换成功！")
end







function 角色处理类:取灵饰数据()
  local 返回数据={}
  for n, v in pairs(self.数据.灵饰) do
    if 玩家数据[self.数据.数字id].道具.数据[v] then
      返回数据[n]=DeepCopy(玩家数据[self.数据.数字id].道具.数据[v])
    end
  end
  return 返回数据
end

function 角色处理类:取锦衣数据()
  local 返回数据={}
  for n, v in pairs(self.数据.锦衣) do
    if 玩家数据[self.数据.数字id].道具.数据[v] then
        返回数据[n]=DeepCopy(玩家数据[self.数据.数字id].道具.数据[v])
    end
  end
  return 返回数据
end



function 角色处理类:取装备数据()
      local 返回数据={}
      for n, v in pairs(self.数据.装备) do
        if 玩家数据[self.数据.数字id].道具.数据[v] then
            返回数据[n]=DeepCopy(玩家数据[self.数据.数字id].道具.数据[v])
        end
      end
      return 返回数据
end


function 角色处理类:取法宝数据()
      local 返回数据={}
      for n, v in pairs(self.数据.法宝) do
        if 玩家数据[self.数据.数字id].道具.数据[v] then
          返回数据[n]=DeepCopy(玩家数据[self.数据.数字id].道具.数据[v])
        end
      end
      return 返回数据
end


function 角色处理类:取灵宝数据()
      local 返回数据={}
      for n, v in pairs(self.数据.灵宝) do
          if 玩家数据[self.数据.数字id].道具.数据[v] then
              返回数据[n]=DeepCopy(玩家数据[self.数据.数字id].道具.数据[v])
          end
      end
      return 返回数据
end


function 角色处理类:取佩戴法宝数据()
      local 返回数据={}
      for n, v in pairs(self.数据.法宝佩戴) do
        if 玩家数据[self.数据.数字id].道具.数据[v] then
          返回数据[n]=DeepCopy(玩家数据[self.数据.数字id].道具.数据[v])
        end
      end
      return 返回数据
end


function 角色处理类:取佩戴灵宝数据()
      local 返回数据={}
      for n, v in pairs(self.数据.灵宝佩戴) do
          if 玩家数据[self.数据.数字id].道具.数据[v] then
              返回数据[n]=DeepCopy(玩家数据[self.数据.数字id].道具.数据[v])
          end
      end
      return 返回数据
end






function 角色处理类:死亡处理()
  local 倍率 = f函数.读配置(程序目录.."配置文件.ini","主要配置","经验")
  local 经验=math.floor(self.数据.当前经验 * 0.05 * 倍率)
  local 银子=math.floor(self.数据.银子 * 0.08)
    self:扣除经验(经验,"死亡",1)
   -- self:扣除银子(银子,"死亡",1)
  if self.数据.银子>= 银子 then
    self.数据.银子=self.数据.银子-银子
  发送数据(玩家数据[self.数据.数字id].连接id,38,{内容="#Y/你因为死亡损失了" ..银子.. "两银子,损失了"..经验.."点经验",频道="xt"})
    常规提示(self.数据.数字id,"#Y/你因为死亡损失了" ..银子.. "两银子"..经验.."点经验")
  end
end



function 角色处理类:取生活技能等级(名称)
  for n=1,#self.数据.辅助技能 do
    if self.数据.辅助技能[n].名称==名称 then return self.数据.辅助技能[n].等级 end
  end
  return 0
end

function 角色处理类:取强化技能等级(名称)
  if self.数据.强化技能 == nil then
    return 0
  end
  for n=1,#self.数据.强化技能 do
    if self.数据.强化技能[n].名称==名称 then return self.数据.强化技能[n].等级 end
  end
end




function 角色处理类:刷新信息(是否,体质,魔力)

   self.数据.体质 = 0
   self.数据.魔力 = 0
   self.数据.力量 = 0
   self.数据.耐力 = 0
   self.数据.敏捷 = 0
   self:取装备属性()
   self:取属性()


  self.数据.命中=self.数据.命中 + self.数据.装备属性.命中
  self.数据.伤害=self.数据.伤害 + self.数据.装备属性.伤害 + math.floor(self.数据.装备属性.命中/3)
  self.数据.防御=self.数据.防御 + self.数据.装备属性.防御

  self.数据.灵力=self.数据.灵力 + self.数据.装备属性.灵力
  self.数据.速度=self.数据.速度 + self.数据.装备属性.速度
  self.数据.躲避=self.数据.躲避 + self.数据.装备属性.躲避
  self.数据.最大气血 = self.数据.最大气血  + self.数据.装备属性.气血 + (self:取生活技能等级("强壮")*10)
  self.数据.最大魔法 = self.数据.最大魔法 + self.数据.装备属性.魔法





  self.数据.心源=0
  self.数据.通真达灵=0
  if self.数据.灵饰套装~=nil then
      if  self.数据.灵饰套装.气血方刚~=nil and  self.数据.灵饰套装.气血方刚>0 then
           if self.数据.灵饰套装.气血方刚>=2 and self.数据.灵饰套装.气血方刚<4 then
              self.数据.最大气血 = self.数据.最大气血 * 1.06
           elseif self.数据.灵饰套装.气血方刚>=4 then
              self.数据.最大气血 = self.数据.最大气血 * 1.12
           end
      end
      if  self.数据.灵饰套装.心源~=nil and  self.数据.灵饰套装.心源>0 then
           if self.数据.灵饰套装.心源>=2 and self.数据.灵饰套装.心源<4 then
              self.数据.心源 = 5
           elseif self.数据.灵饰套装.心源>=4 then
              self.数据.心源 =10
           end
      end
       if  self.数据.灵饰套装.通真达灵~=nil and  self.数据.灵饰套装.通真达灵>0 then
           if self.数据.灵饰套装.通真达灵>=2 and self.数据.灵饰套装.通真达灵<4 then
              self.数据.通真达灵 = 5
           elseif self.数据.灵饰套装.通真达灵>=4 then
              self.数据.通真达灵 =10
           end
      end
   end


  self.数据.最大气血=math.floor(self.数据.最大气血*(1+self:取生活技能等级("强身术")*0.01))
  self.数据.最大魔法=math.floor(self.数据.最大魔法*(1+self:取生活技能等级("冥想")*0.02))
  self.数据.最大活力=10+self.数据.等级*5+self:取生活技能等级("养生之道")*5
  self.数据.最大体力=10+self.数据.等级*5+self:取生活技能等级("健身术")*5


  if self.数据.坐骑~= nil then
         self.数据.最大气血=self.数据.最大气血 + math.floor(self.数据.坐骑.体质*0.5)
         self.数据.最大魔法=self.数据.最大魔法 + math.floor(self.数据.坐骑.魔力*2)
         self.数据.伤害=self.数据.伤害 + math.floor(self.数据.坐骑.力量*0.2)
         self.数据.防御=self.数据.防御 + math.floor(self.数据.坐骑.耐力*0.3)
         self.数据.速度=self.数据.速度 + math.floor(self.数据.坐骑.敏捷*0.2)
         self.数据.灵力=self.数据.灵力 + math.floor(self.数据.坐骑.魔力*0.1)
  end


  if self.数据.符石技能.扣除防御~=nil then
      self.数据.防御 = qz(self.数据.防御 * (100 - self.数据.符石技能.扣除防御 * 5)/100)
  end





  if self.数据.变身数据~=nil then
    if 变身卡数据[self.数据.变身数据]~=nil and 变身卡数据[self.数据.变身数据].属性~=0 then
      if 变身卡数据[self.数据.变身数据].单独~=nil and 变身卡数据[self.数据.变身数据].单独==1 then
        if 变身卡数据[self.数据.变身数据].类型=="气血" then
          if 变身卡数据[self.数据.变身数据].正负==1 then
            self.数据.最大气血=self.数据.最大气血+变身卡数据[self.数据.变身数据].属性
          else
            self.数据.最大气血=self.数据.最大气血-变身卡数据[self.数据.变身数据].属性
          end
        else
          if 变身卡数据[self.数据.变身数据].正负==1 then
            self.数据[变身卡数据[self.数据.变身数据].类型]=self.数据[变身卡数据[self.数据.变身数据].类型]+变身卡数据[self.数据.变身数据].属性
          else
            self.数据[变身卡数据[self.数据.变身数据].类型]=self.数据[变身卡数据[self.数据.变身数据].类型]-变身卡数据[self.数据.变身数据].属性
          end
        end
      else
        if 变身卡数据[self.数据.变身数据].类型=="气血" then
          if 变身卡数据[self.数据.变身数据].正负==1 then
            self.数据.最大气血=self.数据.最大气血+math.floor(self.数据.最大气血*(变身卡数据[self.数据.变身数据].属性/100))
          else
            self.数据.最大气血=self.数据.最大气血-math.floor(self.数据.最大气血*(变身卡数据[self.数据.变身数据].属性/100))
          end
        else
          if 变身卡数据[self.数据.变身数据].正负==1 then
            self.数据[变身卡数据[self.数据.变身数据].类型]=self.数据[变身卡数据[self.数据.变身数据].类型]+math.floor(self.数据[变身卡数据[self.数据.变身数据].类型]*(变身卡数据[self.数据.变身数据].属性/100))
          else
            self.数据[变身卡数据[self.数据.变身数据].类型]=self.数据[变身卡数据[self.数据.变身数据].类型]-math.floor(self.数据[变身卡数据[self.数据.变身数据].类型]*(变身卡数据[self.数据.变身数据].属性/100))
          end
        end
      end
    end
  end


  for n=1,#灵饰战斗属性 do
      self.数据[灵饰战斗属性[n]]=0
  end
  for n=1,#灵饰战斗属性 do
      self.数据[灵饰战斗属性[n]]=self.数据.装备属性[灵饰战斗属性[n]]
  end



  if 玩家数据[self.数据.数字id]~=nil and 玩家数据[self.数据.数字id].经脉~=nil  then
       if self.数据.门派 =="女儿村" and 玩家数据[self.数据.数字id].经脉:取经脉是否有("花舞") then
              local 当前玩家速度 = self.数据.速度
              self.数据.速度 = self.数据.速度 + self.数据.速度*0.04 + 20
              if  self.数据.当前经脉 == "绝代妖娆" then
                  self.数据.速度 = self.数据.速度 + 当前玩家速度*0.02
              end
       elseif self.数据.门派 =="天宫" and 玩家数据[self.数据.数字id].经脉:取经脉是否有("驭意") then
                self.数据.速度 = self.数据.速度 + self.数据.魔力*0.05
                self.数据.法术伤害 = self.数据.法术伤害 + self.数据.魔力*0.1
                self.数据.法术防御 = self.数据.法术防御 - self.数据.魔力*0.24
       elseif self.数据.门派 =="普陀山" and 玩家数据[self.数据.数字id].经脉:取经脉是否有("抖擞") then
                self.数据.伤害 = self.数据.伤害 + self.数据.力量*0.1+40
       elseif self.数据.门派 =="五庄观" and 玩家数据[self.数据.数字id].经脉:取经脉是否有("神附") then
                self.数据.伤害 = self.数据.伤害 + self.数据.力量*0.08
       elseif self.数据.门派 =="凌波城" and 玩家数据[self.数据.数字id].经脉:取经脉是否有("海沸") then
                self.数据.伤害 = self.数据.伤害 + self.数据.力量*0.1+40
       end
       if self.数据.门派 =="五庄观" and 玩家数据[self.数据.数字id].经脉:取经脉是否有("纳气") then
            self.数据.伤害 = self.数据.伤害 + self.数据.力量*0.1+40
       end
  end
  self.数据.法伤= math.floor(self.数据.灵力  +  self.数据.法术伤害+self.数据.武器伤害*0.4)
  self.数据.法防=math.floor(self.数据.灵力 * 0.7 +  self.数据.法术防御)
  if self.数据.锦衣[1]~=nil then
       self.数据.最大气血=self.数据.最大气血*1.1
       self.数据.最大魔法=self.数据.最大魔法*1.1
       self.数据.伤害= self.数据.伤害*1.05
       self.数据.法伤= self.数据.法伤*1.05
  end
  if self.数据.锦衣[2]~=nil then
       self.数据.防御= self.数据.防御*1.05
       self.数据.法防= self.数据.法防*1.05
  end
  if self.数据.锦衣[3]~=nil then
      self.数据.速度= self.数据.速度*1.08
  end
   for i,v in pairs(self.数据.称谓) do
        if v == "绝世英豪" then
                    self.数据.最大气血 = self.数据.最大气血 * 1.05
                    self.数据.伤害 = self.数据.伤害*1.05
                    self.数据.防御 = self.数据.防御*1.05
                    self.数据.速度 = self.数据.速度*1.05
                    self.数据.法伤 = self.数据.法伤*1.05
                    self.数据.法防 = self.数据.法防*1.05
        elseif v == "横扫天下" then
                    self.数据.最大气血 = self.数据.最大气血 * 1.1
                    self.数据.伤害 = self.数据.伤害*1.1
                    self.数据.防御 = self.数据.防御*1.1
                    self.数据.速度 = self.数据.速度*1.1
                    self.数据.法伤 = self.数据.法伤*1.1
                    self.数据.法防 = self.数据.法防*1.1
        elseif v == "独孤求败" then
                    self.数据.最大气血 = self.数据.最大气血 * 1.2
                    self.数据.伤害 = self.数据.伤害*1.2
                    self.数据.防御 = self.数据.防御*1.2
                    self.数据.速度 = self.数据.速度*1.2
                    self.数据.法伤 = self.数据.法伤*1.2
                    self.数据.法防 = self.数据.法防*1.2
        end
  end


   self.数据.最大气血=math.floor(self.数据.最大气血+self:取强化技能等级("人物气血")*10)
   self.数据.最大魔法=math.floor(self.数据.最大魔法)
   self.数据.命中=math.floor(self.数据.命中)
   self.数据.伤害=math.floor(self.数据.伤害+self:取强化技能等级("人物伤害")*6)
   self.数据.防御=math.floor(self.数据.防御+self:取强化技能等级("人物防御")*3)
   self.数据.灵力=math.floor(self.数据.灵力)
   self.数据.躲避=math.floor(self.数据.躲避)
   self.数据.速度=math.floor(self.数据.速度+self:取强化技能等级("人物速度")*3)
   self.数据.法伤=math.floor(self.数据.法伤+self:取强化技能等级("人物法术")*8)
   
   -- 应用变身卡扩展效果----超级变身卡新加
   if self.变身卡扩展处理 then
       self.数据.命中 = self.数据.命中 + self.变身卡扩展处理:获取多属性加成值("命中")
       self.数据.伤害 = self.数据.伤害 + self.变身卡扩展处理:获取多属性加成值("伤害")
       self.数据.防御 = self.数据.防御 + self.变身卡扩展处理:获取多属性加成值("防御")
       self.数据.速度 = self.数据.速度 + self.变身卡扩展处理:获取多属性加成值("速度")
       self.数据.法伤 = self.数据.法伤 + self.变身卡扩展处理:获取多属性加成值("法伤")
       self.数据.法防 = self.数据.法防 + self.变身卡扩展处理:获取多属性加成值("法防")
   end
   self.数据.法防=math.floor(self.数据.法防+self:取强化技能等级("人物法术")*4)
   self.数据.固定伤害=math.floor(self.数据.固定伤害+self:取强化技能等级("人物固伤")*6)
   self.数据.治疗能力=math.floor(self.数据.治疗能力+self:取强化技能等级("人物治疗")*3)
  if self.数据.气血上限 == nil then
     self.数据.气血上限 = self.数据.最大气血
  end
  if self.数据.气血==nil then
     self.数据.气血= self.数据.最大气血
  end
  if self.数据.魔法==nil then
     self.数据.魔法= self.数据.最大魔法
  end

  if 是否 == "1" then
      self.数据.气血 = self.数据.最大气血
      self.数据.气血上限 = self.数据.最大气血
      self.数据.魔法 = self.数据.最大魔法
  end
  if 体质 ~= nil and 体质 > 0  then
      self.数据.气血 = self.数据.最大气血
      self.数据.气血上限 = self.数据.最大气血
  end

  if 魔力 ~= nil and 魔力 > 0  then
      self.数据.魔法 = self.数据.最大魔法
  end

  if self.数据.气血上限 > self.数据.最大气血 then
	self.数据.气血上限 = self.数据.最大气血
  end
  if self.数据.气血 > self.数据.气血上限 then
    self.数据.气血 = self.数据.气血上限
  end
  if self.数据.魔法 > self.数据.最大魔法 then
    self.数据.魔法 = self.数据.最大魔法
  end
  if self.数据.愤怒 > 150 then
    self.数据.愤怒 = 150
  end
  if self.数据.活力 > self.数据.最大活力 then
    self.数据.活力 = self.数据.最大活力
  end
  if self.数据.体力 > self.数据.最大体力 then
    self.数据.体力 = self.数据.最大体力
  end
  if self.数据.等级 <= 174 then
     self.数据.最大经验 = 升级消耗.角色[self.数据.等级+1]
  end


  if self.数据.门派 ~= "无门派" and self.数据.门派 ~= "无" and self.数据.门派 ~= "" and  self.数据.师门技能[1] == nil then
      local 列表 = self:取门派技能(self.数据.门派)
      if 列表~=nil and #列表~=0 then
          for n=1,#列表 do
              self.数据.师门技能[n] = jnzb()
              self.数据.师门技能[n]:置对象(列表[n])
              self.数据.师门技能[n].包含技能 = {}
              self.数据.师门技能[n].等级=1
              local w = self:取包含技能(self.数据.师门技能[n].名称)
              for s=1,#w do
                  self.数据.师门技能[n].包含技能[s] = jnzb()
                  self.数据.师门技能[n].包含技能[s]:置对象(w[s])
                  self.数据.师门技能[n].包含技能[s].等级=1
              end
          end
      end
  end
  if self.数据.门派 ~= "无门派" and  self.数据.师门技能[1] ~= nil and 是否 == "2"  then
      for n=1,#self.数据.师门技能 do
        if self.数据.师门技能[n].包含技能~=nil then
            for l=1,#self.数据.师门技能[n].包含技能 do
                if self:有无技能(self.数据.师门技能[n].包含技能[l].名称) then
                  self.数据.师门技能[n].包含技能[l].学会 = true
                end
            end
        end
      end
  end
  if 是否 == "2" or 是否 == "6" then
      发送数据(玩家数据[self.数据.数字id].连接id,5506,{玩家数据[self.数据.数字id].角色:取气血数据()})
  end
end


function 角色处理类:取装备属性()
  self.数据.武器伤害 = 0
  self.数据.装备属性 ={气血=0,魔法=0,命中=0,伤害=0,防御=0,速度=0,躲避=0,灵力=0,体质=0,魔力=0,力量=0,耐力=0,敏捷=0,
               气血回复效果=0,抗法术暴击等级=0,格挡值=0,法术防御=0,抗物理暴击等级=0,封印命中等级=0,穿刺等级=0,
                抵抗封印等级=0,固定伤害=0,法术伤害=0,法术暴击等级=0,物理暴击等级=0,狂暴等级=0,法术伤害结果=0,
                治疗能力=0}
  self.数据.战斗赐福 ={伤害结果=0,法伤结果=0,物伤结果=0,固伤结果=0,治疗结果=0,伤害减免=0,物伤减免=0,法伤减免=0,固伤减免=0,技能连击=0}
  self.数据.神话词条 = {}
  self.数据.动物套属性={名称="无",件数=0}
  self.数据.符石技能 = {}
  self.数据.特殊技能={}
  local 符石组合 = {}
  local 动物套 = {}

  for n, v in pairs(self.数据.装备) do
        if 玩家数据[self.数据.数字id].道具.数据[v]~=nil then
            local 装备 =玩家数据[self.数据.数字id].道具.数据[v]
            if n==1 then
                if 装备.伤害~=nil then
                   self.数据.武器伤害 = self.数据.武器伤害 + 装备.伤害
                end
                if 装备.命中~=nil then
                   self.数据.武器伤害 = self.数据.武器伤害 + math.floor(装备.命中*0.3)
                end
            elseif n==3 then
                  self.数据.武器伤害=self.数据.武器伤害+math.floor(装备.伤害+装备.命中*0.3)
            end
            if 装备.星位~=nil then
                for a=1,6 do
                    if 装备.星位[a]~= nil and 装备.星位[a].符石属性~=nil then
                        for k,v in pairs(装备.星位[a].符石属性) do
                            if self.数据.装备属性~=nil and self.数据.装备属性[k]~=nil then
                                self.数据.装备属性[k] = self.数据.装备属性[k] + v
                            end
                        end
                    end
                end
                if 装备.星位[6]~= nil then
                    if 装备.星位[6].相互~=nil then
                        for k,v in pairs(装备.星位[6].相互) do
                            self.数据.装备属性[k] = self.数据.装备属性[k] + v
                        end
                     end
                end
                 if 装备.星位.组合~=nil then
                      if (装备.星位.门派==nil or 装备.星位.门派==self.数据.门派) and
                          (装备.星位.部位==nil or 装备.星位.部位==装备.分类) then
                          if 符石组合[装备.星位.组合]==nil then
                              符石组合[装备.星位.组合]={}
                              符石组合[装备.星位.组合][#符石组合[装备.星位.组合]+1]=装备.星位.组合等级
                          else
                              if 装备.星位.组合=="高山流水" or 装备.星位.组合=="天降大任"
                              or 装备.星位.组合=="柳暗花明" then
                                  for k,i in pairs(符石组合[装备.星位.组合]) do
                                      if 装备.星位.组合等级>i then
                                          i=装备.星位.组合等级
                                          break
                                      end
                                  end
                              else
                                  符石组合[装备.星位.组合][#符石组合[装备.星位.组合]+1]=装备.星位.组合等级
                                  if #符石组合[装备.星位.组合]>2 then
                                      table.sort(符石组合[装备.星位.组合])
                                      table.remove(符石组合[装备.星位.组合],1)
                                  end
                              end
                          end
                      end
                 end
            end
             if 装备.熔炼属性 ~= nil then
                  for i=1,#装备.熔炼属性 do
                      if 装备.熔炼属性[i]~=nil then
                         if self.数据.装备属性[装备.熔炼属性[i][1]]~=nil then
                            if 装备.熔炼属性[i][3] == "+" then
                               self.数据.装备属性[装备.熔炼属性[i][1]]=self.数据.装备属性[装备.熔炼属性[i][1]] + (装备.熔炼属性[i][2] or 0)
                            else
                               self.数据.装备属性[装备.熔炼属性[i][1]]=self.数据.装备属性[装备.熔炼属性[i][1]] - (装备.熔炼属性[i][2] or 0)
                            end
                         end
                      end
                  end
              end
              if 装备.临时附魔~=nil then
                  for k,z in pairs(装备.临时附魔) do
                      if type(z.时间) == "string" and tonumber(z.时间) == nil then
                        local 月份=分割文本(z.时间,"-")
                        if not 月份[2] then
                          月份=分割文本(z.时间,"/")
                        end
                        local 日份=分割文本(月份[2]," ")
                        local 时分=分割文本(日份[2],":")
                        local 时间戳 = os.time({day=日份[1], month=月份[1], year=2025, hour=时分[1], minute=0, second=0}) + 时分[2]*60
                        if z.数值 >0 and os.time() - 时间戳 >= 0 then
                            z.数值 = 0
                            z.时间 = 0
                            道具刷新(self.数据.数字id)
                            常规提示(self.数据.数字id,"#Y/你的"..装备.名称.."附魔特效消失了！")
                        end
                      end
                      if k~="愤怒" then
                         self.数据.装备属性[k]=self.数据.装备属性[k] + z.数值
                      end
                  end
              end

              if 装备.赐福~=nil then
                 if 装备.赐福.总类=="基础" then
                    self.数据.装备属性[装备.赐福.类型] =self.数据.装备属性[装备.赐福.类型] + 装备.赐福.数值
                 else
                    self.数据.战斗赐福[装备.赐福.类型] = self.数据.战斗赐福[装备.赐福.类型] + 装备.赐福.数值
                 end
              end
              if 装备.装备境界~=nil then
                  if 装备.装备境界.词条共鸣 and 装备.装备境界.词条[1] and 装备.装备境界.词条[2] and 装备.装备境界.词条[3] then
                     local 境界类型 = 境界属性[装备.装备境界.词条[1].类型].类型
                     local 临时数额 = math.floor((装备.装备境界.词条[1].数额+装备.装备境界.词条[2].数额+装备.装备境界.词条[3].数额)*1.25)
                     self.数据.装备属性[境界类型]= self.数据.装备属性[境界类型]+临时数额
                  else
                      if 装备.装备境界.词条[1] then
                          local 境界类型 = 境界属性[装备.装备境界.词条[1].类型].类型
                          self.数据.装备属性[境界类型]= self.数据.装备属性[境界类型]+装备.装备境界.词条[1].数额
                      end
                      if 装备.装备境界.词条[2] then
                          local 境界类型 = 境界属性[装备.装备境界.词条[2].类型].类型
                          self.数据.装备属性[境界类型]= self.数据.装备属性[境界类型]+装备.装备境界.词条[2].数额
                      end
                      if 装备.装备境界.词条[3] then
                          local 境界类型 = 境界属性[装备.装备境界.词条[3].类型].类型
                          self.数据.装备属性[境界类型]= self.数据.装备属性[境界类型]+装备.装备境界.词条[3].数额
                      end
                  end
                  if 装备.装备境界.神话词条 and 装备.装备境界.神话词条~="" then
                      if 境界属性[装备.装备境界.神话词条] then
                          self.数据.装备属性[境界属性[装备.装备境界.神话词条].类型]= self.数据.装备属性[境界属性[装备.装备境界.神话词条].类型]+境界属性[装备.装备境界.神话词条].神话[2]
                      elseif 神话属性[装备.装备境界.神话词条] then
                        if not self.数据.神话词条[装备.装备境界.神话词条] then
                             self.数据.神话词条[装备.装备境界.神话词条] = 1
                        else
                            self.数据.神话词条[装备.装备境界.神话词条]=self.数据.神话词条[装备.装备境界.神话词条]+1
                        end
                     end
                  end




              end

              for k,z in pairs(self.数据.装备属性) do
                 if 装备[k]~=nil and type(装备[k])== "number" and tonumber(装备[k])>0 then
                    self.数据.装备属性[k] = self.数据.装备属性[k] + tonumber(装备[k])
                 end
              end
              if 装备.特技 ~= nil then
                  self.数据.特殊技能[n] = jnzb()
                  self.数据.特殊技能[n]:置对象(装备.特技)
              end
               if 装备.套装效果~=nil and  n~=3 then
                  if 装备.套装效果[1]=="变身术之" then
                      if 判断是否为空表(动物套) then
                          动物套[#动物套+1]={装备.套装效果[2],数量=1}
                      else
                          local 新套装效果 = true
                          for i=1,#动物套 do
                              if 动物套[i][1] == 装备.套装效果[2] then
                                  动物套[i].数量=动物套[i].数量+1
                                  新套装效果=false
                              end
                          end
                          if 新套装效果 then
                              动物套[#动物套+1]={装备.套装效果[2],数量=1}
                          end
                      end
                  end
              end

          end
      end

      if not 判断是否为空表(符石组合) then
          self:符石组合刷新(符石组合)
      end
      if 判断是否为空表(动物套)~=nil then
          for i=1,#动物套 do
              if 动物套[i].数量>=3 then
                local 属性加成 = 取动物套加成(动物套[i][1],self.数据.等级)
                local 数值 = 0
                if 动物套[i].数量>=5 then
                      数值 = 数值 + 属性加成.属性 + 属性加成.件数[2]
                      self.数据.装备属性[属性加成.类型] = self.数据.装备属性[属性加成.类型] + 数值
                else
                      数值 = 数值 + 属性加成.属性 + 属性加成.件数[1]
                      self.数据.装备属性[属性加成.类型] = self.数据.装备属性[属性加成.类型] + 数值
                end
                self.数据.动物套属性.名称=动物套[i][1]
                self.数据.动物套属性.件数=动物套[i].数量
              end
          end
      end

      for i,v in pairs(self.数据.称谓) do
            if v == "大罗金仙" then
                  self.数据.装备属性.体质 =self.数据.装备属性.体质  + 50
                  self.数据.装备属性.魔力 =self.数据.装备属性.魔力  + 50
                  self.数据.装备属性.力量 =self.数据.装备属性.力量  + 50
                  self.数据.装备属性.耐力 =self.数据.装备属性.耐力  + 50
                  self.数据.装备属性.敏捷 =self.数据.装备属性.敏捷  + 50
            elseif  v == "先天圣人" then
                    self.数据.装备属性.体质 =self.数据.装备属性.体质  + 150
                    self.数据.装备属性.魔力 =self.数据.装备属性.魔力  + 150
                    self.数据.装备属性.力量 =self.数据.装备属性.力量  + 150
                    self.数据.装备属性.耐力 =self.数据.装备属性.耐力  + 150
                    self.数据.装备属性.敏捷 =self.数据.装备属性.敏捷  + 150
            elseif v == "大海龟杀手" then
                    self.数据.装备属性.气血 =  self.数据.装备属性.气血 + 10
            elseif v == "荒漠屠夫" then
                    self.数据.装备属性.伤害 = self.数据.装备属性.伤害 + 10
            elseif v == "僵尸道长" then
                    self.数据.装备属性.灵力 = self.数据.装备属性.灵力 + 10
            elseif v == "快递小哥" then
                    self.数据.装备属性.速度 = self.数据.装备属性.速度 + 10
            elseif v == "摸金校尉" then
                    self.数据.装备属性.防御 = self.数据.装备属性.防御 + 10
            elseif v == "当代清官" then
                    self.数据.装备属性.伤害 = self.数据.装备属性.伤害 + 5
                    self.数据.装备属性.灵力 = self.数据.装备属性.灵力 + 5
            elseif v == "首席小弟子" then
                    self.数据.装备属性.气血 =  self.数据.装备属性.气血 + 10
                    self.数据.装备属性.伤害 = self.数据.装备属性.伤害 + 2
                    self.数据.装备属性.防御 = self.数据.装备属性.防御 + 2
                    self.数据.装备属性.速度 = self.数据.装备属性.速度 + 2
                    self.数据.装备属性.灵力 = self.数据.装备属性.灵力 + 2
            elseif v == "千亿称号[血]" then
                    self.数据.装备属性.气血 =  self.数据.装备属性.气血 + 2000
            elseif v == "千亿称号[伤]" then
                    self.数据.装备属性.伤害 = self.数据.装备属性.伤害 + 1000
            elseif v == "千亿称号[法]" then
                    self.数据.装备属性.灵力 = self.数据.装备属性.灵力 + 800
            elseif v == "千亿称号[防]" then
                    self.数据.装备属性.防御 = self.数据.装备属性.防御 + 800
            elseif v == "千亿称号[速]" then
                    self.数据.装备属性.速度 = self.数据.装备属性.速度 + 600
             elseif v == "彩虹霸主" then
                   if self.数据.彩虹称谓时间==nil then
                         self:删除称谓("彩虹霸主")
                   else
                      if os.time()-self.数据.彩虹称谓时间>=576000 then
                           self:删除称谓("彩虹霸主")
                      end
                   end
            elseif v == "帮战之星" then
                   if self.数据.帮战称谓时间==nil then
                         self:删除称谓("帮战之星")
                   else
                      if os.time()-self.数据.帮战称谓时间>=576000 then
                           self:删除称谓("帮战之星")
                      end
                   end
            elseif string.find(v, "首席大弟子")~=nil then
                    self.数据.装备属性.气血 =  self.数据.装备属性.气血 + 100
                    self.数据.装备属性.伤害 = self.数据.装备属性.伤害 + 10
                    self.数据.装备属性.防御 = self.数据.装备属性.防御 + 10
                    self.数据.装备属性.速度 = self.数据.装备属性.速度 + 10
                    self.数据.装备属性.灵力 = self.数据.装备属性.灵力 + 10
            elseif string.find(v,"英雄大会")~=nil  then
                   if self.数据.英雄称谓时间==nil then
                         self:批量删除称谓("英雄大会")
                   else
                      if os.time()-self.数据.英雄称谓时间>=576000 then
                           self:批量删除称谓("英雄大会")
                      end
                   end
            elseif string.find(v,"镇妖塔")~=nil  then
                   if self.数据.镇妖塔称谓时间==nil then
                       self:批量删除称谓("镇妖塔")
                   else
                      if os.time()-self.数据.镇妖塔称谓时间>=576000 then
                         self:批量删除称谓("镇妖塔")
                      end
                   end
            end
      end
      for i,v in pairs(self.数据.称谓) do
            if string.find(v,"镇妖塔")~=nil  then
                local 临时称谓=分割文本(v,"镇妖塔")
                if 临时称谓~=nil and  临时称谓[2]~=nil then
                    local 临时层数 = 分割文本(临时称谓[2],"层")
                    if 临时层数~=nil and  临时层数[1]~=nil and tonumber(临时层数[1])~=nil and tonumber(临时层数[1])>0 then
                       local 临时倍数 = math.floor(tonumber(临时层数[1])/10)
                        self.数据.装备属性.气血=self.数据.装备属性.气血+300*临时倍数
                        self.数据.装备属性.伤害=self.数据.装备属性.伤害+50*临时倍数
                        self.数据.装备属性.防御=self.数据.装备属性.防御+50*临时倍数
                        self.数据.装备属性.灵力=self.数据.装备属性.灵力+40*临时倍数
                        self.数据.装备属性.速度=self.数据.装备属性.速度+20*临时倍数
                    end
                end
           elseif v == "英雄大会冠军" then
                   self.数据.装备属性.气血 = self.数据.装备属性.气血 + 500
                   self.数据.装备属性.伤害 = self.数据.装备属性.伤害 + 200
                   self.数据.装备属性.防御 = self.数据.装备属性.防御 + 200
                   self.数据.装备属性.速度 = self.数据.装备属性.速度 + 200
                   self.数据.装备属性.灵力 = self.数据.装备属性.灵力 + 200
           elseif v == "英雄大会亚军" then
                   self.数据.装备属性.气血 = self.数据.装备属性.气血 + 300
                   self.数据.装备属性.伤害 = self.数据.装备属性.伤害 + 150
                   self.数据.装备属性.防御 = self.数据.装备属性.防御 + 150
                   self.数据.装备属性.速度 = self.数据.装备属性.速度 + 150
                   self.数据.装备属性.灵力 = self.数据.装备属性.灵力 + 150
            elseif v == "英雄大会季军" then
                   self.数据.装备属性.气血 = self.数据.装备属性.气血 + 200
                   self.数据.装备属性.伤害 = self.数据.装备属性.伤害 + 100
                   self.数据.装备属性.防御 = self.数据.装备属性.防御 + 100
                   self.数据.装备属性.速度 = self.数据.装备属性.速度 + 100
                   self.数据.装备属性.灵力 = self.数据.装备属性.灵力 + 100
            elseif v == "英雄大会精英" then
                   self.数据.装备属性.气血 = self.数据.装备属性.气血 + 100
                   self.数据.装备属性.伤害 = self.数据.装备属性.伤害 + 50
                   self.数据.装备属性.防御 = self.数据.装备属性.防御 + 50
                   self.数据.装备属性.速度 = self.数据.装备属性.速度 + 50
                   self.数据.装备属性.灵力 = self.数据.装备属性.灵力 + 50
            elseif v == "彩虹霸主" then
                     self.数据.装备属性.伤害 = self.数据.装备属性.伤害 + 200
                     self.数据.装备属性.速度 = self.数据.装备属性.速度 + 100
                     self.数据.装备属性.法术伤害 = self.数据.装备属性.法术伤害 + 150
            elseif v == "帮战之星" then
                    self.数据.装备属性.气血 = self.数据.装备属性.气血 + 350
                    self.数据.装备属性.防御 = self.数据.装备属性.防御 + 150
                    self.数据.装备属性.法术防御 = self.数据.装备属性.法术防御 + 100


            end
      end



      if self.数据.五虎上将 ~= nil and self.数据.五虎上将 == 5 then
           self.数据.装备属性.气血 =  self.数据.装备属性.气血 + 200
      end
      if self.数据.结婚 ~= nil and (self.数据.结婚.老公 ~= nil or self.数据.结婚.老婆 ~= nil) then
          if self.数据.结婚.老婆 ~= nil and self.数据.当前称谓 == self.数据.结婚.老婆.."的相公" then
                self.数据.装备属性.灵力 = self.数据.装备属性.灵力 + 30
                self.数据.装备属性.伤害 = self.数据.装备属性.伤害 + 30
                self.数据.装备属性.防御 = self.数据.装备属性.防御 + 20
          elseif self.数据.结婚.老公 ~= nil  and self.数据.当前称谓 == self.数据.结婚.老公.."的娘子" then
                  self.数据.装备属性.灵力 = self.数据.装备属性.灵力 + 30
                  self.数据.装备属性.伤害 = self.数据.装备属性.伤害 + 30
                  self.数据.装备属性.防御 = self.数据.装备属性.防御 + 20
          end
     end


      if self.数据.功德录 and self.数据.功德录.激活 then
          for i=1,#self.数据.功德录.九珠副 do
             if self.数据.装备属性[self.数据.功德录.九珠副[i].类型] then
                self.数据.装备属性[self.数据.功德录.九珠副[i].类型] = self.数据.装备属性[self.数据.功德录.九珠副[i].类型] + self.数据.功德录.九珠副[i].数值
             end
          end
      end
      if self.数据.帮派加成~=nil and self.数据.帮派加成.开关 then
              if os.time()>=self.数据.帮派加成.时间  then
                  for n, v in pairs(帮派属性加成[1]) do
                      self.数据.帮派加成[n] = 0
                  end
                  self.数据.帮派加成.开关 = false
                  self.数据.帮派加成.时间 = 0
                  常规提示(self.数据.数字id,"你的帮派加成已到期")
              end
              self.数据.装备属性.气血 = self.数据.装备属性.气血 + self.数据.帮派加成.气血
              self.数据.装备属性.魔法 = self.数据.装备属性.魔法 + self.数据.帮派加成.魔法
              self.数据.装备属性.命中 = self.数据.装备属性.命中 + self.数据.帮派加成.命中
              self.数据.装备属性.伤害 = self.数据.装备属性.伤害 + self.数据.帮派加成.伤害
              self.数据.装备属性.防御 = self.数据.装备属性.防御 + self.数据.帮派加成.防御
              self.数据.装备属性.速度 = self.数据.装备属性.速度 + self.数据.帮派加成.速度
              self.数据.装备属性.法术伤害 = self.数据.装备属性.法术伤害 + self.数据.帮派加成.法伤
              self.数据.装备属性.法术防御 = self.数据.装备属性.法术防御 + self.数据.帮派加成.法防
      end
      for k,v in pairs(self.数据.加点记录) do
        if  self.数据.装备属性[k] then
            self.数据.装备属性[k]= self.数据.装备属性[k] + v
        end
      end


      if self.数据.神器佩戴 then --神器
        玩家数据[self.数据.数字id].神器:刷新神器属性(self.数据.数字id)
        if self.数据.神器属性 then
            for k,v in pairs(self.数据.神器属性) do
                if v>0 and self.数据.装备属性[k] then
                  self.数据.装备属性[k]=self.数据.装备属性[k]+v
                end
            end
        end
      end
      self:取技能加成()
      self:取灵饰属性()
      if 玩家数据[self.数据.数字id]~=nil and 玩家数据[self.数据.数字id].经脉~=nil  then
         玩家数据[self.数据.数字id].经脉:刷新经脉属性()
      end
end




function 角色处理类:取灵饰属性()
  self.数据.灵饰套装 = {}
  for k,v in pairs(self.数据.灵饰) do
    if self.数据.灵饰[k]~=nil and 玩家数据[self.数据.数字id].道具.数据[v]~=nil and 玩家数据[self.数据.数字id].道具.数据[v].耐久>0 then
       玩家数据[self.数据.数字id].道具.数据[v].灵饰套装 = 0
         local 道具数据 = 玩家数据[self.数据.数字id].道具.数据[v]
         self.数据.装备属性[道具数据.幻化属性.基础.类型] = self.数据.装备属性[道具数据.幻化属性.基础.类型]+道具数据.幻化属性.基础.数值
         for i=1,#道具数据.幻化属性.附加 do
           self.数据.装备属性[道具数据.幻化属性.附加[i].类型]=self.数据.装备属性[道具数据.幻化属性.附加[i].类型]+道具数据.幻化属性.附加[i].数值+道具数据.幻化属性.附加[i].强化
         end
         if 道具数据.附加特性~=nil and 道具数据.附加特性.幻化等级~=nil then
            if 道具数据.附加特性.幻化类型=="气血方刚" then
                  self.数据.装备属性.气血 = self.数据.装备属性.气血 + 道具数据.附加特性.幻化等级 * 14
            elseif 道具数据.附加特性.幻化类型=="通真达灵" then
                  self.数据.装备属性.法术防御 = self.数据.装备属性.法术防御 + 道具数据.附加特性.幻化等级*4
             elseif 道具数据.附加特性.幻化类型=="心源" then
                  self.数据.装备属性.防御 = self.数据.装备属性.防御 + 道具数据.附加特性.幻化等级*4

            elseif 道具数据.附加特性.幻化类型=="心无旁骛" then
                  self.数据.装备属性.抵抗封印等级 = self.数据.装备属性.抵抗封印等级 + 道具数据.附加特性.幻化等级*6

            elseif 道具数据.附加特性.幻化类型=="健步如飞" then
                  self.数据.装备属性.速度 = self.数据.装备属性.速度 + 道具数据.附加特性.幻化等级*3

            elseif 道具数据.附加特性.幻化类型=="回春之术" then
                self.数据.装备属性.治疗能力 = self.数据.装备属性.治疗能力 + 道具数据.附加特性.幻化等级*10

            elseif 道具数据.附加特性.幻化类型=="风雨不动" then
              self.数据.装备属性.抗法术暴击等级 = self.数据.装备属性.抗法术暴击等级 + 道具数据.附加特性.幻化等级*6

            elseif 道具数据.附加特性.幻化类型=="固若金汤" then
              self.数据.装备属性.抗物理暴击等级 = self.数据.装备属性.抗物理暴击等级 + 道具数据.附加特性.幻化等级*6
            elseif 道具数据.附加特性.幻化类型=="气壮山河" then
               self.数据.装备属性.气血回复效果 = self.数据.装备属性.气血回复效果 + 道具数据.附加特性.幻化等级 * 5
            elseif 道具数据.附加特性.幻化类型=="锐不可当" then
               self.数据.装备属性.固定伤害 = self.数据.装备属性.固定伤害 + 道具数据.附加特性.幻化等级*10
            end
            if  self.数据.灵饰套装[道具数据.附加特性.幻化类型]==nil then
                self.数据.灵饰套装[道具数据.附加特性.幻化类型] = 1
            else
                self.数据.灵饰套装[道具数据.附加特性.幻化类型] = self.数据.灵饰套装[道具数据.附加特性.幻化类型] + 1
            end
        end
    end

  end

   for k,v in pairs(self.数据.灵饰) do
      if 玩家数据[self.数据.数字id].道具.数据[v]~=nil and 玩家数据[self.数据.数字id].道具.数据[v].耐久>0 then
          if 玩家数据[self.数据.数字id].道具.数据[v].附加特性~=nil and 玩家数据[self.数据.数字id].道具.数据[v].附加特性.幻化等级~=nil then
             if self.数据.灵饰套装[玩家数据[self.数据.数字id].道具.数据[v].附加特性.幻化类型]~=nil then
                玩家数据[self.数据.数字id].道具.数据[v].灵饰套装 = self.数据.灵饰套装[玩家数据[self.数据.数字id].道具.数据[v].附加特性.幻化类型]
             end
          end
      end
   end

  for k,v in pairs( self.数据.灵饰套装) do
     if v>=2 and v<4 then
        if k =="心无旁骛" then
            self.数据.装备属性.抵抗封印等级 = self.数据.装备属性.抵抗封印等级 + 100
        elseif k =="健步如飞" then
             self.数据.装备属性.速度 = self.数据.装备属性.速度 + 50
        elseif k =="回春之术" then
               self.数据.装备属性.治疗能力 = self.数据.装备属性.治疗能力 + 100
        elseif k =="风雨不动" then
              self.数据.装备属性.抗法术暴击等级 = self.数据.装备属性.抗法术暴击等级 +100
        elseif k =="固若金汤" then
             self.数据.装备属性.抗物理暴击等级 = self.数据.装备属性.抗物理暴击等级 +100
        elseif k =="气壮山河" then
              self.数据.装备属性.气血回复效果 = self.数据.装备属性.气血回复效果 +80
        elseif k =="锐不可当" then
                self.数据.装备属性.固定伤害 = self.数据.装备属性.固定伤害  +100
        end
     elseif v>=4 then
        if k =="心无旁骛" then
            self.数据.装备属性.抵抗封印等级 = self.数据.装备属性.抵抗封印等级 + 300
        elseif k =="健步如飞" then
             self.数据.装备属性.速度 = self.数据.装备属性.速度 + 150
        elseif k =="回春之术" then
               self.数据.装备属性.治疗能力 = self.数据.装备属性.治疗能力 + 350
         elseif k =="风雨不动" then
              self.数据.装备属性.抗法术暴击等级 = self.数据.装备属性.抗法术暴击等级 +300
         elseif k =="固若金汤" then
             self.数据.装备属性.抗物理暴击等级 = self.数据.装备属性.抗物理暴击等级 +300
         elseif k =="气壮山河" then
              self.数据.装备属性.气血回复效果 = self.数据.装备属性.气血回复效果 +240
         elseif k =="锐不可当" then
                self.数据.装备属性.固定伤害 = self.数据.装备属性.固定伤害  +350
        end
     end
  end



end





function 角色处理类:符石组合刷新(符石组合)
    for k,v in pairs(符石组合) do
       if k=="无懈可击" then
              self.数据.装备属性.防御 = self.数据.装备属性.防御 + (#v*6)
        elseif k=="望穿秋水" then
              self.数据.装备属性.灵力 = self.数据.装备属性.灵力 + (#v*3)
        elseif k=="万里横行" then
              self.数据.装备属性.伤害 = self.数据.装备属性.伤害 + (#v*4)
        elseif k=="日落西山" then
              self.数据.装备属性.速度 = self.数据.装备属性.速度 + (#v*4)
        elseif k=="万丈霞光" then
            local 属性值 = 0
            local 参数表 = {[1]=3,[2]=5,[3]=8,[4]=10}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.万丈霞光 = 属性值
        elseif k == "真元护体" then
            local 属性值 = 0
            local 参数表 = {[1]=1,[2]=3,[3]=5}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.真元护体 = 属性值
        elseif k == "风卷残云" then
            local 属性值 = 0
            local 参数表 = {[1]=5,[2]=10,[3]=15,[4]=20}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.风卷残云 = 属性值
        elseif k == "无所畏惧" then
            local 属性值 = 0
            local 参数表 = {[1]=1,[2]=2,[3]=3,[4]=4}
            for i=1,#v do
             属性值 = 属性值 + 参数表[i]
            end
            self.数据.符石技能.无所畏惧 = 属性值
        elseif k == "柳暗花明" then
            local 属性值 = 0
            local 参数表 = {[1]=2,[2]=4,[3]=6,[4]=8}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.柳暗花明 = 属性值
        elseif k == "飞檐走壁" then
            local 属性值 = 0
            local 参数表 = {[1]=0,[2]=8,[3]=12,[4]=16}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.飞檐走壁 = 属性值
        elseif k == "点石成金" then
            local 属性值 = 0
            local 参数表 = {[1]=10,[2]=20,[3]=25,[4]=25}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.点石成金 = 属性值
        elseif k == "百步穿杨" then
            local 属性值 = 0
            local 参数表 = {[1]=25,[2]=45,[3]=75,[4]=100}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.百步穿杨 = 属性值
        elseif k == "雪照云光" then
            local 属性值 = 0
            local 参数表 = {[1]=2,[2]=4,[3]=6}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.雪照云光 = 属性值
        elseif k == "心灵手巧" then
            local 属性值 = 0
            local 参数表 = {[1]=5,[2]=8,[3]=10}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.心灵手巧 = 属性值
        elseif k == "隔山打牛" then
            local 属性值 = 0
            local 参数表 = {[1]=20,[2]=30,[3]=50,[4]=70}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.隔山打牛 = 属性值
        elseif k == "心随我动" then
            local 属性值 = 0
            local 参数表 = {[1]=25,[2]=45,[3]=70,[4]=90}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.心随我动 = 属性值
        elseif k == "云随风舞" then
            local 属性值 = 0
            local 参数表 = {[1]=20,[2]=40,[3]=70,[4]=80}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.云随风舞 = 属性值
        elseif k == "天降大任" then
            local 属性值 = 0
            local 参数表 = {[2]=5,[3]=10,[4]=15}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.天降大任 = 属性值
        elseif k == "高山流水" then
            local 属性值 = 0
            local 参数表 = {[2]=self.数据.等级/3+30,[3]=self.数据.等级/2+30,[4]=self.数据.等级+30}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.高山流水 = qz(属性值)
        elseif k == "百无禁忌" then
            local 属性值 = 0
            local 参数表 = {[2]=4,[3]=8,[4]=12}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.百无禁忌 = 属性值
        elseif k == "暗渡陈仓" then
            local 属性值 = 0
            for i=1,#v do
                属性值 = 属性值 + (#v*3)
            end
            self.数据.符石技能.暗渡陈仓 = 属性值
        elseif k == "化敌为友" then
                local 属性值 = 0
            for i=1,#v do
                属性值 = 属性值 + (#v*3)
            end
            self.数据.符石技能.化敌为友  = 属性值
        elseif k == "网罗乾坤" then
            local 属性值 = 0
            local 参数表 = {[1]=self.数据.等级/3,[2]=self.数据.等级*0.5,[3]=self.数据.等级}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.网罗乾坤 = 属性值
        elseif k == "石破天惊" then
            local 属性值 = 0
            local 参数表 = {[1]=self.数据.等级/3,[2]=self.数据.等级/2,[3]=self.数据.等级}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.石破天惊 = 属性值
        elseif k == "天雷地火" then
            local 属性值 = 0
            local 参数表 = {[1]=self.数据.等级/3,[2]=self.数据.等级/2,[3]=self.数据.等级}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.天雷地火 = 属性值
        elseif k == "凤舞九天" then
            local 属性值 = 0
            local 参数表 = {[1]=self.数据.等级/3,[2]=self.数据.等级/2,[3]=self.数据.等级}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.凤舞九天 = 属性值
        elseif k == "烟雨飘摇" then
            local 属性值 = 0
            local 参数表 = {[1]=self.数据.等级/3,[2]=self.数据.等级/2,[3]=self.数据.等级}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.烟雨飘摇 = 属性值
        elseif k == "索命无常" then
            local 属性值 = 0
            local 参数表 = {[1]=self.数据.等级/3,[2]=self.数据.等级/2,[3]=self.数据.等级}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.索命无常 = 属性值
        elseif k == "行云流水" then
            local 属性值 = 0
            local 参数表 = {[1]=self.数据.等级/3,[2]=self.数据.等级/2,[3]=self.数据.等级}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.行云流水 = 属性值
        elseif k == "福泽天下" then
            local 属性值 = 0
            local 参数表 = {[1]=self.数据.等级/3,[2]=self.数据.等级/2,[3]=self.数据.等级}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.福泽天下 = 属性值
        elseif k == "势如破竹" then
            local 属性值 = 0
            local 参数表 = {[1]=self.数据.等级/3,[2]=self.数据.等级/2,[3]=self.数据.等级}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.势如破竹 = 属性值
            self.数据.符石技能.扣除防御 = (self.数据.符石技能.扣除防御 or 0) + #v
        elseif k == "销魂噬骨" then
            local 属性值 = 0
            local 参数表 = {[1]=self.数据.等级/3,[2]=self.数据.等级/2,[3]=self.数据.等级}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.销魂噬骨 = 属性值
            -- self.数据.符石技能效果["扣除防御"] = (self.数据.符石技能效果["扣除防御"] or 0) + #v
        elseif k == "无心插柳" then
            local 属性值 = 0
            local 参数表 = {[1]=0.15,[2]=0.2,[3]=0.25}
            for i=1,#v do
                属性值 = 属性值 + 参数表[v[i]]
            end
            self.数据.符石技能.无心插柳 = 属性值
        elseif k == "降妖伏魔" then
            local 属性值 = 0
            local 参数表 = {[2]=8,[3]=15}
            for i=1,#v do
            属性数值 = 属性值 + 参数表[v[i]]
            end
          self.数据.符石技能.降妖伏魔 = 属性值
        end
    end
end


function 角色处理类:取技能加成() -- 升级获得技能
    if self.数据.门派 and self.数据.门派 ~= "无门派"  and self.数据.门派~="" and self.数据.门派~="无" then
        for k,v in pairs(self.数据.师门技能) do
            if v.名称~=nil then
                if not v.等级 then v.等级 = 1 end
                if v.名称 == "火云术" or v.名称 == "龙腾术" or v.名称 == "黄庭经" or v.名称 == "灵通术" or v.名称 == "观音咒" or v.名称 == "修仙术"
                  or v.名称 == "为官之道" or v.名称 == "清明自在" or v.名称 == "佛光普照" or v.名称 == "魔兽神功" or v.名称 == "姊妹相随"
                  or v.名称 == "九转玄功" or v.名称 == "神木恩泽" or v.名称 == "阴风绝章" or v.名称 == "倾国倾城" or v.名称 == "九黎战歌" then
                        self.数据.装备属性.气血 =self.数据.装备属性.气血 + math.floor(v.等级 * 6)

                elseif v.名称 == "霹雳咒" or v.名称 == "幽冥术" or v.名称 == "周易学" or v.名称 == "狂兽诀" or v.名称 == "傲世诀" or v.名称 == "驭灵咒"
                      or v.名称 == "歧黄之术" or v.名称 == "神兵鉴赏" or v.名称 == "呼风唤雨" or v.名称 == "牛逼神功" or v.名称 == "五行学说"
                      or v.名称 == "迷情大法" or v.名称 == "武神显圣" or v.名称 == "地冥妙法" or v.名称 == "沉鱼落雁" or v.名称 == "魔神降世" then
                        self.数据.装备属性.魔法 =self.数据.装备属性.魔法 + math.floor(v.等级 * 3)

                elseif v.名称 == "诵经" or v.名称 == "龙附术" or v.名称 == "符之术" or v.名称 == "拘魂诀" or v.名称 == "混天术" or v.名称 == "牛虱阵"
                      or v.名称 == "金刚经" or v.名称 == "乾坤袖" or v.名称 == "无双一击" or v.名称 == "秋波暗送" or  v.名称 == "法天象地"
                      or v.名称 == "瞬息万变" or v.名称 == "枯骨心法" or v.名称 == "闭月羞花" or v.名称 == "燃铁飞花" or v.名称 == "阴阳二气诀" then
                        self.数据.装备属性.命中 =self.数据.装备属性.命中 + math.floor(v.等级 * 3)
                        self.数据.武器伤害 = self.数据.武器伤害 + 1
                elseif v.名称 == "巫咒" or v.名称 == "毒经" or v.名称 == "天罡气" or v.名称 == "震天诀" or v.名称 == "生死搏"  or v.名称 == "破浪诀"
                      or v.名称 == "磐龙灭法" or v.名称 == "六道轮回" or v.名称 == "护法金刚" or v.名称 == "潇湘仙雨"  or v.名称 == "金刚伏魔"
                      or v.名称 == "十方无敌" or v.名称 == "盘丝大法" or v.名称 == "气吞山河"  or v.名称 == "混元神功" or v.名称 == "魂枫战舞" then
                        self.数据.装备属性.伤害 =self.数据.装备属性.伤害 + math.floor(v.等级 * 3)
                        self.数据.武器伤害 = self.数据.武器伤害 + 3
                elseif v.名称 == "诛魔" or v.名称 == "逆鳞术" or v.名称 == "尸腐恶" or v.名称 == "乾坤塔" or v.名称 == "回身击" or v.名称 == "归元心法"
                      or v.名称 == "大慈大悲" or v.名称 == "文韬武略" or v.名称 == "五行扭转" or v.名称 == "明性修身" or v.名称 == "魔兽反噬"
                      or v.名称 == "蛛丝阵法" or v.名称 == "万物轮转" or v.名称 == "燃灯灵宝" or v.名称 == "玉质冰肌" or v.名称 == "战火雄魂" then
                        self.数据.装备属性.防御 =self.数据.装备属性.防御 + math.floor(v.等级 * 1.5)

                elseif v.名称 == "啸傲" or v.名称 == "灵性" or v.名称 == "九龙诀" or v.名称 == "宁气诀" or v.名称 == "火牛阵" or v.名称 == "训兽诀"
                      or v.名称 == "小乘佛法" or v.名称 == "紫薇之术" or v.名称 == "神道无念" or v.名称 == "九幽阴魂" or v.名称 == "天外魔音"
                      or v.名称 == "万灵诸念" or v.名称 == "鬼蛊灵蕴" or v.名称 == "香飘兰麝" or v.名称 == "混元道果" or v.名称 == "兵铸乾坤" then
                        self.数据.装备属性.灵力 =self.数据.装备属性.灵力 + math.floor(v.等级 * 2.5)

                elseif v.名称 == "渡世步" or v.名称 == "疾风步" or v.名称 == "游龙术" or v.名称 == "斜月步" or v.名称 == "无常步" or v.名称 == "云霄步"
                      or v.名称 == "裂石步" or v.名称 == "七星遁" or v.名称 == "盘丝步" or v.名称 == "大鹏展翅" or v.名称 == "天地无极"
                      or v.名称 == "天人庇护" or v.名称 == "秘影迷踪" or v.名称 == "清歌妙舞" or v.名称 == "莲花宝座" or v.名称 == "风行九黎" then
                        self.数据.装备属性.速度 =self.数据.装备属性.速度 + math.floor(v.等级 * 2)
            -------------------------------------------------------------------------------------------------------
                --女魃墓
                elseif v.名称 == "天火献誓" then
                        self.数据.装备属性.气血 =self.数据.装备属性.气血 + math.floor(v.等级 *  6)
                elseif v.名称 == "天罚之焰" then
                        self.数据.装备属性.灵力 =self.数据.装备属性.灵力 + math.floor(v.等级 * 2.5)
                elseif v.名称 == "煌火无明"  then
                        self.数据.装备属性.伤害 =self.数据.装备属性.伤害 + math.floor(v.等级 * 3)
                elseif v.名称 == "化神以灵" then
                        self.数据.装备属性.魔法 =self.数据.装备属性.魔法 + math.floor(v.等级 * 3)
                elseif v.名称 == "弹指成烬" then
                        self.数据.装备属性.防御 =self.数据.装备属性.防御 + math.floor(v.等级 * 1.5)
                elseif v.名称 == "藻光灵狱" then
                        self.数据.装备属性.命中 =self.数据.装备属性.命中 + math.floor(v.等级 * 3)
                elseif v.名称 == "离魂" then
                        self.数据.装备属性.速度 =self.数据.装备属性.速度 + math.floor(v.等级 * 2)
                --天机城
                elseif v.名称 == "神工无形" then
                        self.数据.装备属性.命中 =self.数据.装备属性.命中 + math.floor(v.等级 * 3)
                elseif v.名称 == "攻玉以石" then
                         self.数据.装备属性.魔法 =self.数据.装备属性.魔法 + math.floor(v.等级 * 3)
                elseif v.名称 == "擎天之械" then
                        self.数据.装备属性.气血 =self.数据.装备属性.气血 + math.floor(v.等级 *  6)
                elseif v.名称 == "千机奇巧"  then
                        self.数据.装备属性.防御 =self.数据.装备属性.防御 + math.floor(v.等级 * 1.5)
                elseif v.名称 == "匠心不移" then
                        self.数据.装备属性.伤害 =self.数据.装备属性.伤害 + math.floor(v.等级 * 3)
                elseif v.名称 == "运思如电" then
                       self.数据.装备属性.速度 =self.数据.装备属性.速度 + math.floor(v.等级 * 2)
                elseif v.名称 == "探奥索隐" then
                        self.数据.装备属性.灵力 =self.数据.装备属性.灵力 + math.floor(v.等级 * 2.5)
                --花果山
                elseif v.名称 == "神通广大" then
                        self.数据.装备属性.气血 =self.数据.装备属性.气血 + math.floor(v.等级 *  6)
                elseif v.名称 == "如意金箍" then
                        self.数据.装备属性.伤害 =self.数据.装备属性.伤害 + math.floor(v.等级 * 3)
                elseif v.名称 == "齐天逞胜" then
                        self.数据.装备属性.魔法 =self.数据.装备属性.魔法 + math.floor(v.等级 * 3)
                elseif v.名称 == "金刚之躯" then
                        self.数据.装备属性.防御 =self.数据.装备属性.防御 + math.floor(v.等级 * 1.5)
                elseif v.名称 == "灵猴九窍" then
                        self.数据.装备属性.命中 =self.数据.装备属性.命中 + math.floor(v.等级 * 3)
                elseif v.名称 == "七十二变" then
                        self.数据.装备属性.灵力 =self.数据.装备属性.灵力 + math.floor(v.等级 * 2.5)
                elseif v.名称 == "腾云驾霧" then
                        self.数据.装备属性.速度 =self.数据.装备属性.速度 + math.floor(v.等级 * 2)
              ------------------------------------------------------------------------------------------------------



                end







        end
     end
  end




end





function 角色处理类:取门派技能(门派)
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
  elseif 门派 == "女魃墓" then
    return  {"天火献誓","天罚之焰","煌火无明","化神以灵","弹指成烬","藻光灵狱","离魂"}
  elseif 门派 == "天机城" then
    return  {"神工无形","攻玉以石","擎天之械","千机奇巧","匠心不移","运思如电","探奥索隐"}
  elseif 门派 == "花果山" then
    return  {"神通广大","如意金箍","齐天逞胜","金刚之躯","灵猴九窍","七十二变","腾云驾霧"}
  elseif 门派 == "九黎城" then
    return  {"九黎战歌","魂枫战舞","兵铸乾坤","燃铁飞花","战火雄魂","魔神降世","风行九黎"}
  end
  return n
end





function 角色处理类:取包含技能(名称)
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




function 角色处理类:取辅助技能()
  return {"强身术","冥想","暗器技巧","打造技巧","裁缝技巧","炼金术","中药医理","烹饪技巧","逃离技巧","追捕技巧","养生之道","健身术","淬灵之术"}
end

function 角色处理类:有无技能(名称)
  for n=1,#self.数据.人物技能 do
    if self.数据.人物技能[n].名称 == 名称 then
      return true
    end
  end
  return false
end

function 角色处理类:取模型(ID)
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
  return 角色信息[ID]
end

function 角色处理类:队伍角色(模型)
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
  }
  return 角色信息[模型]
end

function 角色处理类:取初始属性(种族)
  local 属性 = {
    人 = {10,10,10,10,10},
    魔 = {12,11,11,8,8},
    仙 = {12,5,11,12,10},
  }
  return 属性[种族]
end


-- function 角色处理类:取属性()
--   local cs = self:取初始属性(self.数据.种族)
--   if self.数据.门派 =="九黎城" then
--       cs = {12,11,11,8,8}
--   end
--   self.数据.体质 = cs[1] + self.数据.等级  + self.数据.装备属性.体质
--   self.数据.魔力 = cs[2] + self.数据.等级  + self.数据.装备属性.魔力
--   self.数据.力量 = cs[3] + self.数据.等级  + self.数据.装备属性.力量
--   self.数据.耐力 = cs[4] + self.数据.等级  + self.数据.装备属性.耐力
--   self.数据.敏捷 = cs[5] + self.数据.等级  + self.数据.装备属性.敏捷
--   if self.数据.种族 =="人" or self.数据.种族 == 1 then
--       self.数据.命中=ceil(self.数据.力量*2.01+30)
--       self.数据.伤害=ceil(self.数据.力量*0.67+39)
--       self.数据.防御=ceil(self.数据.耐力*1.5)
--       self.数据.速度=ceil(self.数据.敏捷)
--       self.数据.灵力=ceil(self.数据.体质*0.3+self.数据.魔力*0.7+self.数据.耐力*0.2+self.数据.力量*0.4)
--       self.数据.躲避=ceil(self.数据.敏捷+10)
--       self.数据.最大气血=ceil(self.数据.体质*5+100)   ---体*5
--       self.数据.最大魔法=ceil(self.数据.魔力*3+80)     --魔*3
--   elseif self.数据.种族 =="魔" or self.数据.种族 == 2 then
--       self.数据.命中=ceil(self.数据.力量*2.31+30)
--       self.数据.伤害=ceil(self.数据.力量*0.77+39)
--       self.数据.防御=ceil(self.数据.耐力*1.4)
--       self.数据.速度=ceil(self.数据.敏捷)
--       self.数据.灵力=ceil(self.数据.体质*0.3+self.数据.魔力*0.7+self.数据.耐力*0.2+self.数据.力量*0.4-0.3)
--       self.数据.躲避=ceil(self.数据.敏捷+10)
--       self.数据.最大气血=ceil(self.数据.体质*6+100)
--       self.数据.最大魔法=ceil(self.数据.魔力*2.5+80)
--   elseif self.数据.种族 =="仙" or self.数据.种族 == 3 then
--       self.数据.命中=ceil(self.数据.力量*1.71+30)
--       self.数据.伤害=ceil(self.数据.力量*0.57+39)
--       self.数据.防御=ceil(self.数据.耐力*1.6)
--       self.数据.速度=ceil(self.数据.敏捷)
--       self.数据.灵力=ceil(self.数据.体质*0.3+self.数据.魔力*0.7+self.数据.耐力*0.2+self.数据.力量*0.4-0.3)
--       self.数据.躲避=ceil(self.数据.敏捷+10)
--       self.数据.最大气血=ceil(self.数据.体质*4.5+100)
--       self.数据.最大魔法=ceil(self.数据.魔力*3.5+80)
--   end
--   if self.数据.门派 =="九黎城" then
--         self.数据.命中=ceil(self.数据.力量*2.3+29)
--         self.数据.伤害=ceil(self.数据.力量*0.77+39)
--         self.数据.防御=ceil(self.数据.耐力*1.4)
--         self.数据.速度=ceil(self.数据.敏捷)
--         self.数据.灵力=ceil(self.数据.体质*0.3+self.数据.魔力*0.7+self.数据.耐力*0.2+self.数据.力量*0.4-0.3)
--         self.数据.躲避=ceil(self.数据.敏捷+10)
--         self.数据.最大气血=ceil(self.数据.体质*6+100)
--         self.数据.最大魔法=ceil(self.数据.魔力*2.5+80)
--   end







-- end



-- function 角色处理类:取属性()
--   local cs = self:取初始属性(self.数据.种族)
--   if self.数据.门派 =="九黎城" then
--       cs = {12,11,11,8,8}
--   end
--   self.数据.体质 = cs[1] + self.数据.等级  + self.数据.装备属性.体质
--   self.数据.魔力 = cs[2] + self.数据.等级  + self.数据.装备属性.魔力
--   self.数据.力量 = cs[3] + self.数据.等级  + self.数据.装备属性.力量
--   self.数据.耐力 = cs[4] + self.数据.等级  + self.数据.装备属性.耐力
--   self.数据.敏捷 = cs[5] + self.数据.等级  + self.数据.装备属性.敏捷
--   if self.数据.种族 =="人" or self.数据.种族 == 1 then
--       self.数据.躲避=ceil(self.数据.敏捷+10)
--       self.数据.防御=ceil(self.数据.耐力*1.5)
--       self.数据.命中=ceil(self.数据.力量*2.01+30)
--       self.数据.伤害=ceil(self.数据.力量*0.67+39)
--       self.数据.最大气血=ceil(self.数据.体质*5+100)  ---0.056
--       self.数据.最大魔法=ceil(self.数据.魔力*3+80)     --魔*3
--       --self.数据.灵力=ceil(self.数据.魔力*0.7+self.数据.体质 * 0.28 + self.数据.耐力 * 0.3 + self.数据.力量*0.167)--0.2783326   ---0.153
--       --self.数据.灵力=ceil(self.数据.魔力*0.7+self.数据.体质 * 0.34 + self.数据.耐力 * 0.335 + self.数据.力量*0.279)--0.095

--     --self.数据.灵力=ceil(self.数据.魔力*0.7+self.数据.体质 * 0.28 + self.数据.耐力 * 0.3 + self.数据.力量*0.279)
--        self.数据.灵力=ceil(self.数据.魔力*0.7+self.数据.体质 * 0.25 + self.数据.耐力 * 0.3 + self.数据.力量*0.4)
--   elseif self.数据.种族 =="魔" or self.数据.种族 == 2 then
--       self.数据.躲避=ceil(self.数据.敏捷+10)
--       self.数据.防御=ceil(self.数据.耐力*1.4)
--       self.数据.命中=ceil(self.数据.力量*2.31+30)
--       self.数据.伤害=ceil(self.数据.力量*0.77+39)
--       self.数据.最大气血=ceil(self.数据.体质*6+100)--0.05
--       self.数据.最大魔法=ceil(self.数据.魔力*2.5+80)
--      -- self.数据.灵力=ceil(self.数据.魔力*0.7+self.数据.体质 * 0.32 + self.数据.耐力 * 0.28 + self.数据.力量*0.2)--0.354  ---0.1
--       --self.数据.灵力=ceil(self.数据.魔力*0.7+self.数据.体质 * 0.37 + self.数据.耐力 * 0.284 + self.数据.力量*0.3)
--       --self.数据.灵力=ceil(self.数据.魔力*0.7+(self.数据.最大气血-100) * 0.05 +  self.数据.防御 * 0.2 + self.数据.伤害/4)
--       self.数据.灵力=ceil(self.数据.魔力*0.7+self.数据.体质 * 0.4 + self.数据.耐力 * 0.25 + self.数据.力量*0.3)
--   elseif self.数据.种族 =="仙" or self.数据.种族 == 3 then
--       self.数据.躲避=ceil(self.数据.敏捷+10)
--       self.数据.防御=ceil(self.数据.耐力*1.6)
--       self.数据.命中=ceil(self.数据.力量*1.71+30)
--       self.数据.伤害=ceil(self.数据.力量*0.57+39)
--       self.数据.最大气血=ceil(self.数据.体质*4.5+100)--0.0665
--       self.数据.最大魔法=ceil(self.数据.魔力*3.5+80)
--      -- self.数据.灵力=ceil(self.数据.魔力*0.7+self.数据.体质 * 0.3 + self.数据.耐力 * 0.32 + self.数据.力量*0.143)---0.2242857114  --
--       --self.数据.灵力=ceil(self.数据.魔力*0.7+self.数据.体质 * 0.3 + self.数据.耐力 * 0.43 + self.数据.力量*0.224)
--      -- self.数据.灵力=ceil(self.数据.魔力*0.7+(self.数据.最大气血-100) * 0.0665 +  self.数据.防御 * 0.2 + self.数据.伤害/4)

--      self.数据.灵力=ceil(self.数据.魔力*0.7+self.数据.体质 * 0.3 + self.数据.耐力 * 0.4 + self.数据.力量*0.25)
--   end
--   if self.数据.门派 =="九黎城" then
--         self.数据.躲避=ceil(self.数据.敏捷+10)
--         self.数据.防御=ceil(self.数据.耐力*1.4)
--         self.数据.命中=ceil(self.数据.力量*2.31+30)
--         self.数据.伤害=ceil(self.数据.力量*0.77+39)
--         self.数据.最大气血=ceil(self.数据.体质*6+100)
--         self.数据.最大魔法=ceil(self.数据.魔力*2.5+80)
--         --self.数据.灵力=ceil(self.数据.魔力*0.7+self.数据.体质 * 0.32 + self.数据.耐力 * 0.28 + self.数据.力量*0.2)--0.354
--        -- self.数据.灵力=ceil(self.数据.魔力*0.7+self.数据.体质 * 0.32 + self.数据.耐力 * 0.28 + self.数据.力量*0.354)
--   end
--   self.数据.速度=ceil(self.数据.敏捷*0.7+self.数据.体质 * 0.1 +  self.数据.耐力 * 0.1 +  self.数据.力量 * 0.1)







--end



function 角色处理类:取属性()
  local cs = self:取初始属性(self.数据.种族)
  if self.数据.门派 =="九黎城" then
      cs = {12,11,11,8,8}
  end
  self.数据.体质 = cs[1] + self.数据.等级  + self.数据.装备属性.体质
  self.数据.魔力 = cs[2] + self.数据.等级  + self.数据.装备属性.魔力
  self.数据.力量 = cs[3] + self.数据.等级  + self.数据.装备属性.力量
  self.数据.耐力 = cs[4] + self.数据.等级  + self.数据.装备属性.耐力
  self.数据.敏捷 = cs[5] + self.数据.等级  + self.数据.装备属性.敏捷
  if self.数据.种族 =="人" or self.数据.种族 == 1 then
      self.数据.躲避=ceil(self.数据.敏捷+10)
      self.数据.防御=ceil(self.数据.耐力*1.5)
      self.数据.命中=ceil(self.数据.力量*2.01+30)
      self.数据.伤害=ceil(self.数据.力量*0.67+39)
      self.数据.最大气血=ceil(self.数据.体质*5+100)  ---0.056
      self.数据.最大魔法=ceil(self.数据.魔力*3+80)     --魔*3
      self.数据.灵力=ceil(self.数据.魔力*0.7+self.数据.体质 * 0.25 + self.数据.耐力 * 0.3 + self.数据.力量*0.4)
  elseif self.数据.种族 =="魔" or self.数据.种族 == 2 then
      self.数据.躲避=ceil(self.数据.敏捷+10)
      self.数据.防御=ceil(self.数据.耐力*1.4)
      self.数据.命中=ceil(self.数据.力量*2.31+30)
      self.数据.伤害=ceil(self.数据.力量*0.77+39)
      self.数据.最大气血=ceil(self.数据.体质*6+100)--0.05
      self.数据.最大魔法=ceil(self.数据.魔力*2.5+80)
      self.数据.灵力=ceil(self.数据.魔力*0.7+self.数据.体质 * 0.4 + self.数据.耐力 * 0.25 + self.数据.力量*0.3)
  elseif self.数据.种族 =="仙" or self.数据.种族 == 3 then
      self.数据.躲避=ceil(self.数据.敏捷+10)
      self.数据.防御=ceil(self.数据.耐力*1.6)
      self.数据.命中=ceil(self.数据.力量*1.71+30)
      self.数据.伤害=ceil(self.数据.力量*0.57+39)
      self.数据.最大气血=ceil(self.数据.体质*4.5+100)--0.0665
      self.数据.最大魔法=ceil(self.数据.魔力*3.5+80)
      self.数据.灵力=ceil(self.数据.魔力*0.7+self.数据.体质 * 0.3 + self.数据.耐力 * 0.4 + self.数据.力量*0.25)
  end




  if self.数据.门派 =="九黎城" then
        self.数据.躲避=ceil(self.数据.敏捷+10)
        self.数据.防御=ceil(self.数据.耐力*1.4)
        self.数据.命中=ceil(self.数据.力量*2.31+30)
        self.数据.伤害=ceil(self.数据.力量*0.77+39)
        self.数据.最大气血=ceil(self.数据.体质*6+100)--0.05
        self.数据.最大魔法=ceil(self.数据.魔力*2.5+80)
        self.数据.灵力=ceil(self.数据.魔力*0.7+self.数据.体质 * 0.4 + self.数据.耐力 * 0.25 + self.数据.力量*0.3)
  end
  self.数据.速度=ceil(self.数据.敏捷*0.7+self.数据.体质 * 0.1 +  self.数据.耐力 * 0.1 +  self.数据.力量 * 0.1)







end




function 角色处理类:日志记录(内容)
    if self.日志内容 == nil then
       self.日志内容="日志创建"
    end
    if not self.数据.日志编号 then
        self.数据.日志编号=1
    end
    self.日志内容=self.日志内容.."\n"..时间转换(os.time())..内容
    if #self.日志内容>=10240 then
        if not f函数.文件是否存在([[data/]]..self.数据.账号..[[/]]..self.数据.数字id..[[/日志记录/]]..取年月日1(os.time())..[[1.txt]]) then
            self.数据.日志编号=1
        end
        写出文件([[data/]]..self.数据.账号..[[/]]..self.数据.数字id..[[/日志记录/]]..取年月日1(os.time()).. self.数据.日志编号..[[.txt]],self.日志内容)
        self.数据.日志编号= self.数据.日志编号 + 1
        self.日志内容="日志创建"
    end
end
function 角色处理类:显示(x,y) end

function 角色处理类:学会技能(id,gz)
  if self.数据.师门技能[id] ~= nil then
        for s=1,#self.数据.师门技能[id].包含技能 do
            if self.数据.师门技能[id].包含技能[s].名称 == gz and not self:有无技能(gz) then
                  self.数据.师门技能[id].包含技能[s].学会 = true
                  self.数据.师门技能[id].包含技能[s].等级 = self.数据.师门技能[id].等级
                  insert(self.数据.人物技能,DeepCopy(self.数据.师门技能[id].包含技能[s]))
                  常规提示(self.数据.数字id,"恭喜你学会了新技能#R/"..self.数据.师门技能[id].包含技能[s].名称)
            elseif self.数据.师门技能[id].包含技能[s].名称 == gz then
                  self.数据.师门技能[id].包含技能[s].等级 = self.数据.师门技能[id].等级
            end
        end
  end
end


function 角色处理类:升级技能(jn) -- 升级获得技能
  -- 化生
  if jn.等级 == nil then
     jn.等级 = 1
  end
  if jn.名称 == "小乘佛法" and jn.等级 >= 10 then
            self:学会技能(1,"紫气东来")
  elseif jn.名称 == "金刚伏魔" and jn.等级 >= 120 and self.数据.飞升 then
            self:学会技能(2,"佛法无边")
  elseif jn.名称 == "诵经" and jn.等级 >= 10 then
          self:学会技能(3,"唧唧歪歪")
          self:学会技能(3,"谆谆教诲")
  elseif jn.名称 == "佛光普照" and jn.等级 >= 20 then
          self:学会技能(4,"韦陀护法")
          if jn.等级 >= 30 then
              self:学会技能(4,"金刚护法")
              self:学会技能(4,"达摩护体")
              self:学会技能(4,"一苇渡江")
          end
          if jn.等级 >= 35 then
              self:学会技能(4,"金刚护体")
              self:学会技能(4,"拈花妙指")
          end
  elseif jn.名称 == "大慈大悲" and jn.等级 >= 40 then
          self:学会技能(5,"我佛慈悲")
  elseif jn.名称 == "歧黄之术" and jn.等级 >= 10 then
          self:学会技能(6,"推拿")
          if jn.等级 >= 15 then
              self:学会技能(6,"解毒")
          end
          if jn.等级 >= 25 then
              self:学会技能(6,"活血")
          end
          if jn.等级 >= 35 then
              self:学会技能(6,"推气过宫")
          end
          if jn.等级 >= 40 then
              self:学会技能(6,"妙手回春")
          end
          if jn.等级 >= 50 then
              self:学会技能(6,"救死扶伤")
          end
          if jn.等级 >= 120 and self.数据.飞升 then
                self:学会技能(6,"舍身取义")
          end
  elseif jn.名称 == "渡世步" then
          self:学会技能(7,"佛门普渡")
  -- 大唐
  elseif jn.名称 == "为官之道" and jn.等级 >= 10 then
          self:学会技能(1,"杀气诀")
  elseif jn.名称 == "无双一击" and jn.等级 >= 25 then
          self:学会技能(2,"后发制人")
  elseif jn.名称 == "神兵鉴赏" and jn.等级 >= 10 then
          self:学会技能(3,"兵器谱")
  elseif jn.名称 == "疾风步" then
          self:学会技能(4,"千里神行")
  elseif jn.名称 == "十方无敌" and jn.等级 >= 30 then
          self:学会技能(5,"横扫千军")
          if jn.等级 >= 120 and self.数据.飞升 then
              self:学会技能(5,"破釜沉舟")
          end
  elseif jn.名称 == "紫薇之术" and jn.等级 >= 20 then
          self:学会技能(6,"斩龙诀")
  elseif jn.名称 == "文韬武略" and jn.等级 >= 20 then
          self:学会技能(7,"反间之计")
          if jn.等级 >= 35 then
            self:学会技能(7,"嗜血")
          end
          if jn.等级 >= 120 and self.数据.飞升 then
              self:学会技能(7,"安神诀")
          end

  -- 龙宫
  elseif jn.名称 == "九龙诀" and jn.等级 >= 10 then
          self:学会技能(1,"清心")
          self:学会技能(1,"解封")
          if jn.等级 >= 120 and self.数据.飞升  then
              self:学会技能(1,"二龙戏珠")
          end
  elseif jn.名称 == "破浪诀" and jn.等级 >= 120 and self.数据.飞升  then
          self:学会技能(2,"神龙摆尾")
  elseif jn.名称 == "呼风唤雨" and jn.等级 >= 15 then
          self:学会技能(3,"龙卷雨击")
  elseif jn.名称 == "龙附术" and jn.等级 >= 25 then
          if self.数据.等级>= 20 then
              self:学会技能(7,"龙啸九天")
          end
          if jn.等级 >= 30 then
              self:学会技能(7,"龙吟")
          end
          if jn.等级 >= 35 and self.数据.等级>=30 then
              self:学会技能(7,"龙附")
          end
  elseif jn.名称 == "龙腾术" and jn.等级 >= 50 then
          self:学会技能(4,"龙腾")
  elseif jn.名称 == "逆鳞术" and jn.等级 >= 30 then
          self:学会技能(5,"逆鳞")
  elseif jn.名称 == "游龙术" then
          self:学会技能(6,"水遁")
          if jn.等级 >= 20 then
              self:学会技能(6,"乘风破浪")
          end
  -- 方寸
  elseif jn.名称 == "黄庭经" and jn.等级 >= 10 then
          self:学会技能(1,"三星灭魔")
  elseif jn.名称 == "磐龙灭法" and jn.等级 >= 20 then
          self:学会技能(2,"落雷符")
          if jn.等级 >= 25 then
              self:学会技能(2,"离魂符")
              self:学会技能(2,"失魂符")
          end
          if jn.等级 >= 30 then
            self:学会技能(2,"定身符")
          end
          if jn.等级 >= 120 and self.数据.飞升 then
              self:学会技能(2,"碎甲符")
          end
  elseif jn.名称 == "霹雳咒" then
          self:学会技能(3,"五雷咒")
  elseif jn.名称 == "符之术" and jn.等级 >= 10 then
          self:学会技能(4,"兵解符")
          self:学会技能(4,"催眠符")
          if jn.等级 >= 15 then
              self:学会技能(4,"落魄符")
          end
          if jn.等级 >= 20 then
              self:学会技能(4,"失忆符")
          end
          if jn.等级 >= 21 then
              self:学会技能(4,"飞行符")
          end
          if jn.等级 >= 25 then
              self:学会技能(4,"追魂符")
          end
          if jn.等级 >= 40 then
              self:学会技能(4,"失心符")
          end
  elseif jn.名称 == "归元心法" then
          self:学会技能(5,"归元咒")
          if jn.等级 >= 100 then
              self:学会技能(5,"凝神术")
          end
  elseif jn.名称 == "神道无念" then
          self:学会技能(6,"乾天罡气")
          if jn.等级 >= 35 then
              self:学会技能(6,"神兵护法")
          end
          if jn.等级 >= 120 and self.数据.飞升 then
              self:学会技能(6,"分身术")
          end
  elseif jn.名称 == "斜月步" then
          self:学会技能(7,"乙木仙遁")
  -- 地府
  elseif jn.名称 == "灵通术" then
          self:学会技能(1,"堪察令")
          self:学会技能(1,"寡欲令")
   elseif jn.名称 == "六道轮回" and jn.等级 >= 50 then
          self:学会技能(2,"魂飞魄散")
  elseif jn.名称 == "幽冥术" and jn.等级 >= 25 then
          self:学会技能(3,"阎罗令")
          if jn.等级 >= 75 then
              self:学会技能(3,"锢魂术")
          end
          if jn.等级 >= 120 and self.数据.飞升 then
              self:学会技能(3,"黄泉之息")
          end
  elseif jn.名称 == "拘魂诀" and jn.等级 >= 20 then
          self:学会技能(4,"判官令")
          if jn.等级 >= 35 then
              self:学会技能(4,"尸气漫天")
          end
          if jn.等级 >= 120 and self.数据.飞升 then
              self:学会技能(4,"还阳术")
          end
  elseif jn.名称 == "九幽阴魂" and jn.等级 >= 25 then
          self:学会技能(5,"冤魂不散")
          if jn.等级 >= 30 then
              self:学会技能(5,"幽冥鬼眼")
          end
  elseif jn.名称 == "尸腐恶" and jn.等级 >= 20 then
          self:学会技能(6,"尸腐毒")
          self:学会技能(6,"修罗隐身")
  elseif jn.名称 == "无常步" then
          self:学会技能(7,"杳无音讯")
  -- 天宫
  elseif jn.名称 == "天罡气" and jn.等级 >= 10 then
          self:学会技能(1,"天神护体")
          self:学会技能(1,"天神护法")
          self:学会技能(1,"五雷轰顶")
          self:学会技能(1,"天诛地灭")
          self:学会技能(1,"浩然正气")
          if jn.等级 >= 120 and self.数据.飞升 then
              self:学会技能(1,"雷霆万钧")
          end
  elseif jn.名称 == "傲世诀" and jn.等级 >= 25 then
          self:学会技能(2,"天雷斩")
  elseif jn.名称 == "清明自在" and jn.等级 >= 35 then
          self:学会技能(3,"知己知彼")
  elseif jn.名称 == "宁气诀" and jn.等级 >= 20 then
          self:学会技能(4,"宁心")
  elseif jn.名称 == "乾坤塔" and jn.等级 >= 30 then
           self:学会技能(5,"镇妖")
           if jn.等级 >= 50 then
              self:学会技能(5,"错乱")
           end
  elseif jn.名称 == "混天术" and jn.等级 >= 40 then
          self:学会技能(6,"百万神兵")
          if jn.等级 >= 120 and self.数据.飞升 then
              self:学会技能(6,"金刚镯")
          end
  elseif jn.名称 == "云霄步" then
          self:学会技能(7,"腾云驾雾")
  -- 魔王
  elseif jn.名称 == "牛逼神功" then
          self:学会技能(1,"魔王护持")
  elseif jn.名称 == "震天诀" and jn.等级 >= 20 then
          self:学会技能(2,"踏山裂石")
  elseif jn.名称 == "火云术" and jn.等级 >= 20 then
          self:学会技能(3,"三昧真火")
          if jn.等级 >= 30 then
              self:学会技能(3,"飞砂走石")
          end
          if jn.等级>=120 and self.数据.飞升 then
              self:学会技能(3,"火甲术")
          end
  elseif jn.名称 == "火牛阵" and jn.等级 >= 30 then
          self:学会技能(4,"牛劲")
  elseif jn.名称 == "牛虱阵" and jn.等级 >= 25 then
          self:学会技能(5,"无敌牛虱")
          if jn.等级>=120 and self.数据.飞升 then
              self:学会技能(5,"摇头摆尾")
              self:学会技能(5,"无敌牛妖")
          end
  elseif jn.名称 == "回身击" and jn.等级 >= 30 then
          self:学会技能(6,"魔王回首")
  elseif jn.名称 == "裂石步" then
          self:学会技能(7,"牛屎遁")
  --普陀
  elseif jn.名称 == "灵性" then
          self:学会技能(1,"自在心法")

  elseif jn.名称 == "观音咒" and jn.等级 >= 20 then
          self:学会技能(3,"杨柳甘露")
          if jn.等级 >= 30 then
              self:学会技能(3,"紧箍咒")
          end
  elseif jn.名称 == "五行学说" and jn.等级 >= 10 then
          self:学会技能(4,"日光华")
          if jn.等级 >= 11 then
              self:学会技能(4,"靛沧海")
          end
          if jn.等级 >= 12 then
              self:学会技能(4,"巨岩破")
          end
          if jn.等级 >= 13 then
              self:学会技能(4,"苍茫树")
          end
          if jn.等级 >= 14 then
              self:学会技能(4,"地裂火")
          end
  elseif jn.名称 == "金刚经" and jn.等级 >= 15 then
          self:学会技能(5,"普渡众生")
          if jn.等级 >= 35 then
              self:学会技能(5,"莲华妙法")
          end
          if jn.等级 >= 120 and self.数据.飞升 then
              self:学会技能(5,"灵动九天")
          end
  elseif jn.名称 == "五行扭转" and jn.等级 >= 25 and self.数据.等级>=20 then
          self:学会技能(6,"五行错位")
          if jn.等级 >= 120 and self.数据.飞升 then
              self:学会技能(6,"颠倒五行")
          end
  elseif jn.名称 == "莲花宝座" then
          self:学会技能(7,"坐莲")
  -- 五庄观
  elseif jn.名称 == "周易学" then
          self:学会技能(1,"驱魔")
          self:学会技能(1,"驱尸")
  elseif jn.名称 == "潇湘仙雨" and jn.等级 >= 20 then
          self:学会技能(2,"飘渺式")
          if jn.等级 >= 25 then
            self:学会技能(2,"烟雨剑法")
          end
  elseif jn.名称 == "乾坤袖" and jn.等级 >= 20 then
          self:学会技能(3,"日月乾坤")
          if jn.等级 >= 120 and self.数据.飞升 then
             self:学会技能(3,"天地同寿")
             self:学会技能(3,"乾坤妙法")
          end
  elseif jn.名称 == "修仙术" and jn.等级 >= 30 then
          self:学会技能(4,"炼气化神")
          self:学会技能(4,"生命之泉")
          if jn.等级 >= 35 then
              self:学会技能(4,"一气化三清")
          end
  elseif jn.名称 == "混元道果" and jn.等级 >= 25 and self.数据.等级>=20  then
          self:学会技能(5,"太极生化")
  elseif jn.名称 == "明性修身" and jn.等级 >= 30 then
          self:学会技能(6,"三花聚顶")
  elseif jn.名称 == "七星遁" then
         self:学会技能(7,"斗转星移")
  -- 狮驼岭
  elseif jn.名称 == "魔兽神功" then
          self:学会技能(1,"变身")
          self:学会技能(1,"魔兽啸天")
  elseif jn.名称 == "生死搏" and jn.等级 >= 20 then
          self:学会技能(2,"象形")
          self:学会技能(2,"狮搏")
          if jn.等级 >= 30 then
            self:学会技能(2,"鹰击")
          end
          if jn.等级 >= 120 and self.数据.飞升 then
            self:学会技能(2,"天魔解体")
          end
  elseif jn.名称 == "训兽诀" and jn.等级 >= 15 then
          self:学会技能(3,"威慑")
  elseif jn.名称 == "阴阳二气诀" and jn.等级 >= 40 then
          self:学会技能(4,"定心术")
          if jn.等级 >= 120 and self.数据.飞升 then
              self:学会技能(4,"魔息术")
          end
  elseif jn.名称 == "狂兽诀" and jn.等级 >= 30 then
          self:学会技能(5,"连环击")
          if jn.等级 >= 35 then
            self:学会技能(5,"神力无穷")
          end
  elseif jn.名称 == "大鹏展翅" then
          self:学会技能(6,"振翅千里")
  elseif jn.名称 == "魔兽反噬" and jn.等级 >= 20 then
          self:学会技能(7,"极度疯狂")
  -- 盘丝洞
  elseif jn.名称 == "蛛丝阵法" then
          self:学会技能(1,"盘丝舞")
          self:学会技能(1,"夺命蛛丝")
  elseif jn.名称 == "迷情大法" and jn.等级 >= 20 then
          self:学会技能(2,"含情脉脉")
          if jn.等级 >= 120 and self.数据.飞升 then
             self:学会技能(2,"魔音摄魂")
             self:学会技能(2,"瘴气")
          end
  elseif jn.名称 == "秋波暗送" and jn.等级 >= 20 then
          self:学会技能(3,"勾魂")
          self:学会技能(3,"摄魄")
  elseif jn.名称 == "盘丝大法" and jn.等级 >= 20 then
          self:学会技能(5,"盘丝阵")
          self:学会技能(5,"复苏")
  elseif jn.名称 == "盘丝步" then
          self:学会技能(6,"天蚕丝")
          if jn.等级 >= 15 then
              self:学会技能(6,"天罗地网")
          end
          if jn.等级 >= 120 and self.数据.飞升 then
              self:学会技能(6,"幻镜术")
          end
  elseif jn.名称 == "姊妹相随" and jn.等级 >= 20 then
          self:学会技能(7,"姐妹同心")
  -- 凌波城
  elseif jn.名称 == "天地无极" then
          self:学会技能(1,"穿云破空")
  elseif jn.名称 == "九转玄功" and jn.等级 >= 25 then
          self:学会技能(2,"不动如山")
  elseif jn.名称 == "武神显圣" and jn.等级 >= 30 then
          self:学会技能(3,"碎星诀")
          if jn.等级 >= 120 and self.数据.飞升 then
            self:学会技能(3,"镇魂诀")
          end
  elseif jn.名称 == "啸傲" and jn.等级 >= 25 then
          self:学会技能(4,"指地成钢")
  elseif jn.名称 == "气吞山河" and jn.等级 >= 25 then
          self:学会技能(5,"裂石")
          self:学会技能(5,"浪涌")
          if jn.等级 >= 35 then
              self:学会技能(5,"断岳势")
              self:学会技能(5,"惊涛怒")
          end
          if jn.等级 >= 45 then
              self:学会技能(5,"天崩地裂")
              self:学会技能(5,"翻江搅海")
          end
  elseif jn.名称 == "诛魔" and jn.等级 >= 120 and self.数据.飞升 then
          self:学会技能(6,"腾雷")
  elseif jn.名称 == "法天象地" then
          self:学会技能(7,"纵地金光")
          if jn.等级 >= 30 then
              self:学会技能(7,"无穷妙道")
          end
  -- 神木林
  elseif jn.名称 == "瞬息万变"  then
          self:学会技能(1,"落叶萧萧")
  elseif jn.名称 == "万灵诸念" and jn.等级 >= 20 then
          self:学会技能(2,"荆棘舞")
          self:学会技能(2,"尘土刃")
          self:学会技能(2,"冰川怒")
  elseif jn.名称 == "巫咒" and jn.等级 >= 40 then
          self:学会技能(3,"雾杀")
          if jn.等级 >= 120 and self.数据.飞升 then
            self:学会技能(3,"血雨")
          end
  elseif jn.名称 == "万物轮转" and jn.等级 >= 40 then
           self:学会技能(4,"星月之惠")
  elseif jn.名称 == "天人庇护" then
          self:学会技能(5,"叶隐")
          if jn.等级 >= 50 then
            self:学会技能(5,"炎护")
          end
  elseif jn.名称 == "神木恩泽" and jn.等级 >= 35 and self.数据.等级>=30 then
          self:学会技能(6,"神木呓语")
  elseif jn.名称 == "驭灵咒" and jn.等级 >= 25 and self.数据.等级>=20 then
          self:学会技能(7,"蝼蚁蚀天")
          if jn.等级 >= 120 and self.数据.飞升 then
            self:学会技能(7,"蜜润")
          end
  -- 无底洞

  elseif jn.名称 == "枯骨心法"  then
          self:学会技能(1,"移魂化骨")
  elseif jn.名称 == "阴风绝章" and jn.等级 >= 25 then
          self:学会技能(2,"夺魄令")
          if jn.等级 >= 30 then
            self:学会技能(2,"煞气诀")
          end
          if jn.等级 >= 50 then
            self:学会技能(2,"惊魂掌")
          end
          if jn.等级 >= 120 and self.数据.飞升 then
              self:学会技能(2,"摧心术")
          end
  elseif jn.名称 == "鬼蛊灵蕴" and jn.等级 >= 35 then
          self:学会技能(3,"夺命咒")
  elseif jn.名称 == "燃灯灵宝" and jn.等级 >= 35 then
          self:学会技能(4,"明光宝烛")
          if jn.等级 >= 120 and self.数据.飞升 then
            self:学会技能(4,"金身舍利")
          end
  elseif jn.名称 == "地冥妙法" and jn.等级 >= 20 then
          self:学会技能(5,"地涌金莲")
          if jn.等级 >= 25 then
            self:学会技能(5,"万木凋枯")
          end
  elseif jn.名称 == "混元神功" and jn.等级 >= 25 then
          self:学会技能(6,"元阳护体")
  elseif jn.名称 == "秘影迷踪" then
          self:学会技能(7,"遁地术")
  -- 女儿


  elseif jn.名称 == "倾国倾城" and jn.等级 >= 10 then
          self:学会技能(2,"楚楚可怜")
          if jn.等级 >= 20 then
              self:学会技能(2,"红袖添香")
          end
          if jn.等级 >= 120 and self.数据.飞升 then
              self:学会技能(2,"一笑倾城")
          end
  elseif jn.名称 == "沉鱼落雁" and jn.等级 >= 20 then
          self:学会技能(3,"雨落寒沙")
          self:学会技能(3,"子母神针")
          if jn.等级 >= 25 then
              self:学会技能(3,"满天花雨")
              self:学会技能(3,"情天恨海")
          end
  elseif jn.名称 == "闭月羞花" and jn.等级 >= 20 then
          self:学会技能(4,"如花解语")
         if jn.等级 >= 25 then
              self:学会技能(4,"娉婷袅娜")
         end
         if jn.等级 >= 30 then
              self:学会技能(4,"莲步轻舞")
         end
         if jn.等级 >= 40 then
              self:学会技能(4,"似玉生香")
         end
  elseif jn.名称 == "香飘兰麝" and jn.等级 >= 35 and self.数据.等级>=30 then
          self:学会技能(5,"轻如鸿毛")
  elseif jn.名称 == "玉质冰肌" and jn.等级 >= 10 then
          self:学会技能(6,"百毒不侵")
  elseif jn.名称 == "清歌妙舞" then
          self:学会技能(7,"移形换影")
          if jn.等级 >= 120 and self.数据.飞升 then
            self:学会技能(7,"飞花摘叶")
          end
  --女魃墓
  elseif jn.名称 == "天罚之焰" and jn.等级 >= 10 then
          self:学会技能(2,"炽火流离")
          if jn.等级 >=25 then
            self:学会技能(2,"极天炼焰")
          end
  elseif jn.名称 == "煌火无明"  and jn.等级 >= 10 then
          self:学会技能(3,"诡蝠之刑")
          if jn.等级 >=15 then
              self:学会技能(3,"谜毒之缚")
          end
          if jn.等级 >=30 then
            self:学会技能(3,"怨怖之泣")
          end
          if jn.等级 >=40 then
            self:学会技能(3,"誓血之祭")
          end
  elseif jn.名称 == "化神以灵"  then
          self:学会技能(4,"唤灵·魂火")
          if jn.等级 >=20 then
              self:学会技能(4,"唤魔·堕羽")
          end
          if jn.等级 >= 120 and self.数据.飞升 then
              self:学会技能(4,"唤魔·毒魅")
              self:学会技能(4,"唤灵·焚魂")
          end
  elseif jn.名称 == "弹指成烬" and jn.等级 >= 25 then
          self:学会技能(5,"净世煌火")
          if jn.等级 >=35 then
              self:学会技能(5,"焚魔烈焰")
          end
  elseif jn.名称 == "藻光灵狱" and jn.等级 >= 35 then
          self:学会技能(6,"幽影灵魄")
  elseif jn.名称 == "离魂" then
          self:学会技能(7,"魂兮归来")

  --天机城
  elseif jn.名称 == "攻玉以石" and jn.等级 >= 25 then
          self:学会技能(2,"针锋相对")
          if jn.等级 >= 120 and self.数据.飞升 then
              self:学会技能(2,"攻守易位")
          end
  elseif jn.名称 == "擎天之械" and jn.等级 >= 25 then
          self:学会技能(3,"锋芒毕露")
  elseif jn.名称 == "千机奇巧"  then
          self:学会技能(4,"匠心·破击")
          if jn.等级 >=45 then
              self:学会技能(4,"诱袭")
          end
  elseif jn.名称 == "匠心不移" and jn.等级 >= 25 then
          self:学会技能(5,"匠心·蓄锐")
          if jn.等级 >=35 then
            self:学会技能(5,"匠心·固甲")
          end
          if jn.等级 >= 120 and self.数据.飞升 then
              self:学会技能(5,"匠心·削铁")
          end
  elseif jn.名称 == "运思如电" then
          self:学会技能(6,"天马行空")
  elseif jn.名称 == "探奥索隐" and jn.等级 >= 35 then
          self:学会技能(7,"鬼斧神工")
  --花果山
  elseif jn.名称 == "腾云驾霧" then
          self:学会技能(7,"筋斗云")
  elseif jn.名称 == "神通广大" and jn.等级 >= 120 and self.数据.飞升  then
          self:学会技能(1,"威震凌霄")
          self:学会技能(1,"气慑天军")
  elseif jn.名称 == "如意金箍" and jn.等级 >= 10 then
          self:学会技能(2,"当头一棒")
          self:学会技能(2,"神针撼海")
          self:学会技能(2,"杀威铁棒")
          self:学会技能(2,"泼天乱棒")
  elseif jn.名称 == "齐天逞胜" and jn.等级 >= 10 then
          self:学会技能(3,"九幽除名")
          self:学会技能(3,"云暗天昏")
          if jn.等级 >=15 then
              self:学会技能(3,"移星换斗")
              self:学会技能(3,"移星换斗")
          end
  elseif jn.名称 == "金刚之躯" and jn.等级 >= 10 then
          self:学会技能(4,"铜头铁臂")
          if jn.等级 >=35 then
            self:学会技能(4,"担山赶月")
          end
  elseif jn.名称 == "灵猴九窍" and jn.等级 >= 10 then
          self:学会技能(5,"无所遁形")
  elseif jn.名称 == "七十二变" and jn.等级 >= 10 then
          self:学会技能(6,"呼子唤孙")
          if jn.等级 >=45 then
            self:学会技能(6,"八戒上身")
          end
--九黎城
  elseif jn.名称 == "九黎战歌" then
          self:学会技能(1,"黎魂")
          self:学会技能(1,"战鼓")
          self:学会技能(1,"怒哮")
          self:学会技能(1,"炎魂")
  elseif jn.名称 == "魂枫战舞" then
          self:学会技能(2,"枫影二刃")
  elseif jn.名称 == "兵铸乾坤" and jn.等级 >= 30 then
          self:学会技能(3,"一斧开天")
  elseif jn.名称 == "燃铁飞花" and jn.等级 >= 30 then
          self:学会技能(4,"三荒尽灭")
          if jn.等级 >= 120 and self.数据.飞升 then
              self:学会技能(4,"铁火双扬")
          end
  elseif jn.名称 == "战火雄魂" and jn.等级 >= 30 then
          self:学会技能(5,"铁血生风")
  elseif jn.名称 == "魔神降世" and jn.等级 >= 30 then
          self:学会技能(6,"力劈苍穹")
  elseif jn.名称 == "风行九黎" then
          self:学会技能(7,"故壤归心")






  end

end






function 角色处理类:耐久处理(id,类型)
          local 数额 = 0
          local 装备 = {}
          if 类型 == 1 then
              装备 = {3}
              数额 = 0.025
              if self.数据.门派 == "大唐官府" then
                  数额 = 0.0125
              elseif self.数据.门派 == "九黎城" then
                    数额 = 0.00625
                    装备 = {3,4}
              end
          elseif 类型==2 then
                  数额 = 0.0125
                  if self.数据.门派 == "九黎城" then
                      装备={1,2,5,6}
                  else
                      装备={1,2,4,5,6}
                  end
          elseif 类型==3 then
                  装备 = {3}
                  数额 = 0.0125
          elseif 类型==4 then
                  数额 = 0.00625
                  装备={1,2,4,5,6}
          end
          for i,v in ipairs(装备) do
              if self.数据.装备[v] and 玩家数据[id].道具.数据[self.数据.装备[v]] then
                  local 永不磨损 = true
                  if 玩家数据[id].道具.数据[self.数据.装备[v]].特效=="永不磨损" or 玩家数据[id].道具.数据[self.数据.装备[v]].第二特效=="永不磨损" then
                     永不磨损 = false
                  end
                  if 永不磨损 and 玩家数据[id].道具.数据[self.数据.装备[v]].耐久>0 then
                      玩家数据[id].道具.数据[self.数据.装备[v]].耐久 = 玩家数据[id].道具.数据[self.数据.装备[v]].耐久 - 数额
                  end
                  if 玩家数据[id].道具.数据[self.数据.装备[v]].耐久<=0 then
                        玩家数据[id].道具.数据[self.数据.装备[v]].耐久=0
                        常规提示(id,"#Y/你的#R/"..玩家数据[id].道具.数据[self.数据.装备[v]].名称.."#Y/因耐久度过低已无法使用")
                        local 传入 = {类型="道具",道具=v}
                        玩家数据[id].道具:卸下装备(玩家数据[id].连接id,id,传入)
                  end
              end
          end
end



-- function 角色处理类:耐久处理(id,类型)
--   self.特效永不磨损 = false
--   if 类型==1 then
--     if self.数据.装备[3]~=nil and 玩家数据[id].道具.数据[self.数据.装备[3]]~=nil then
--     --   if 玩家数据[id].道具.数据[self.数据.装备[3]].符石~= nil then
--     --     for i=1,#玩家数据[id].道具.数据[self.数据.装备[3]].符石 do
--     --       if 玩家数据[id].道具.数据[self.数据.装备[3]].符石[i].耐久度 ~=nil then
--     --         if self.数据.门派 == "大唐官府" then
--     --             玩家数据[id].道具.数据[self.数据.装备[3]].符石[i].耐久度=玩家数据[id].道具.数据[self.数据.装备[3]].符石[i].耐久度-(0.0125/2)
--     --         else
--     --             玩家数据[id].道具.数据[self.数据.装备[3]].符石[i].耐久度=玩家数据[id].道具.数据[self.数据.装备[3]].符石[i].耐久度-0.0125
--     --         end
--     --         if 玩家数据[id].道具.数据[self.数据.装备[3]].符石[i].耐久度<=0 then
--     --           玩家数据[id].道具.数据[self.数据.装备[3]].符石[i].耐久度=0
--     --           发送数据(玩家数据[id].连接id,7,"#y/你的#r/"..玩家数据[id].道具.数据[self.数据.装备[3]].符石[i].名称.."#y/因耐久度过低已无法使用")
--     --         end
--     --       end
--     --     end
--     --   end
--       if(玩家数据[id].道具.数据[self.数据.装备[3]].特效~= nil and 玩家数据[id].道具.数据[self.数据.装备[3]].特效=="永不磨损") or (玩家数据[id].道具.数据[self.数据.装备[3]].第二特效~= nil and 玩家数据[id].道具.数据[self.数据.装备[3]].第二特效=="永不磨损") then
--           self.特效永不磨损 = true
--       end
--       if self.特效永不磨损 == false then
--         if self.数据.门派 == "大唐官府" and 玩家数据[id].道具.数据[self.数据.装备[3]].耐久~=0 then
--             玩家数据[id].道具.数据[self.数据.装备[3]].耐久=玩家数据[id].道具.数据[self.数据.装备[3]].耐久-(0.025/2)
--             if 玩家数据[id].道具.数据[self.数据.装备[3]].耐久<=0 then
--               玩家数据[id].道具.数据[self.数据.装备[3]].耐久=0
--               self:卸下装备(玩家数据[id].道具.数据[self.数据.装备[3]],self.数据.装备[3],id)
--               发送数据(玩家数据[id].连接id,7,"#y/你的#r/"..玩家数据[id].道具.数据[self.数据.装备[3]].名称.."#y/因耐久度过低已无法使用")
--             end
--         elseif 玩家数据[id].道具.数据[self.数据.装备[3]].耐久~=0 and self.数据.门派~="大唐官府" then
--             玩家数据[id].道具.数据[self.数据.装备[3]].耐久=玩家数据[id].道具.数据[self.数据.装备[3]].耐久-0.025
--             if 玩家数据[id].道具.数据[self.数据.装备[3]].耐久<=0 then
--               玩家数据[id].道具.数据[self.数据.装备[3]].耐久=0
--               self:卸下装备(玩家数据[id].道具.数据[self.数据.装备[3]],self.数据.装备[3],id)
--               发送数据(玩家数据[id].连接id,7,"#y/你的#r/"..玩家数据[id].道具.数据[self.数据.装备[3]].名称.."#y/因耐久度过低已无法使用")
--             end
--         end
--       end
--     end
--   elseif 类型==2 then
--     for n=1,6 do
--       if self.数据.装备[n]~=nil and 玩家数据[id].道具.数据[self.数据.装备[n]]~=nil then
--       --   if 玩家数据[id].道具.数据[self.数据.装备[n]].符石~= nil  then
--       --     for i=1,#玩家数据[id].道具.数据[self.数据.装备[n]].符石 do
--       --       if 玩家数据[id].道具.数据[self.数据.装备[n]].符石[i].耐久度 ~= nil then
--       --         if self.数据.门派 == "大唐官府" then
--       --             玩家数据[id].道具.数据[self.数据.装备[n]].符石[i].耐久度=玩家数据[id].道具.数据[self.数据.装备[n]].符石[i].耐久度-(0.0125/2)
--       --         else
--       --             玩家数据[id].道具.数据[self.数据.装备[n]].符石[i].耐久度=玩家数据[id].道具.数据[self.数据.装备[n]].符石[i].耐久度-0.0125
--       --         end
--       --         if 玩家数据[id].道具.数据[self.数据.装备[n]].符石[i].耐久度<=0 then
--       --           玩家数据[id].道具.数据[self.数据.装备[n]].符石[i].耐久度=0
--       --           发送数据(玩家数据[id].连接id,7,"#y/你的#r/"..玩家数据[id].道具.数据[self.数据.装备[n]].符石[i].名称.."#y/因耐久度过低已无法使用")
--       --         end
--       --       end
--       --     end
--       --   end
--         if (玩家数据[id].道具.数据[self.数据.装备[n]].特效~=nil  and  玩家数据[id].道具.数据[self.数据.装备[n]].特效 =="永不磨损") or (玩家数据[id].道具.数据[self.数据.装备[n]].第二特效~=nil  and  玩家数据[id].道具.数据[self.数据.装备[n]].第二特效 =="永不磨损")  then
--           self.特效永不磨损 = true
--         end
--         if self.特效永不磨损 == false then
--           if self.数据.门派 == "大唐官府" and 玩家数据[id].道具.数据[self.数据.装备[n]].耐久~=0 then
--               玩家数据[id].道具.数据[self.数据.装备[n]].耐久=玩家数据[id].道具.数据[self.数据.装备[n]].耐久-(0.0125/2)
--               if 玩家数据[id].道具.数据[self.数据.装备[n]].耐久<=0 then
--                 玩家数据[id].道具.数据[self.数据.装备[n]].耐久=0
--                 self:卸下装备(玩家数据[id].道具.数据[self.数据.装备[n]],self.数据.装备[n],id)
--                 发送数据(玩家数据[id].连接id,7,"#y/你的#r/"..玩家数据[id].道具.数据[self.数据.装备[n]].名称.."#y/因耐久度过低已无法使用")
--               end
--           elseif self.数据.门派 ~= "大唐官府" and 玩家数据[id].道具.数据[self.数据.装备[n]].耐久~=0 then
--               玩家数据[id].道具.数据[self.数据.装备[n]].耐久=玩家数据[id].道具.数据[self.数据.装备[n]].耐久-0.0125
--               if 玩家数据[id].道具.数据[self.数据.装备[n]].耐久<=0 then
--                 玩家数据[id].道具.数据[self.数据.装备[n]].耐久=0
--                 self:卸下装备(玩家数据[id].道具.数据[self.数据.装备[n]],self.数据.装备[n],id)
--                 发送数据(玩家数据[id].连接id,7,"#y/你的#r/"..玩家数据[id].道具.数据[self.数据.装备[n]].名称.."#y/因耐久度过低已无法使用")
--               end
--           end
--         end
--       end
--     end
--   end
-- end

-- 背包扩展处理，最大格为200，每次20格，价格只用银子，第1次100万，第二次200万，以此类推
function 角色处理类:扩展背包处理(id)
  local 当前扩展 = self.数据.扩展背包 or 0
  local 当前总格 = 40 + 当前扩展
  if 当前总格 >= 200 then
    常规提示(id, "#Y/背包已达最大容量200格，无法继续扩展！")
    return false
  end
  local 下次扩展 = 当前扩展 + 20
  if 40 + 下次扩展 > 200 then
    下次扩展 = 200 - 40
  end
  local 扩展次数 = math.floor(当前扩展 / 20) + 1
  local 价格 = 扩展次数 * 1000000
  if self.数据.银子 < 价格 then
    常规提示(id, "#Y/扩展背包需要"..价格.."银子，银子不足！")
    return false
  end
  self.数据.银子 = self.数据.银子 - 价格
  self.数据.扩展背包 = 下次扩展
  常规提示(id, "#Y/背包已扩展至"..(40+下次扩展).."格，消耗银子"..价格.."！")
  return true
end


function 角色处理类:坐骑刷新(编号)

  self.数据.坐骑列表[编号].最大气血 = ceil(self.数据.坐骑列表[编号].等级*self.数据.坐骑列表[编号].体力资质/1000+self.数据.坐骑列表[编号].体质*self.数据.坐骑列表[编号].成长*6)
  self.数据.坐骑列表[编号].最大魔法 = ceil(self.数据.坐骑列表[编号].等级*self.数据.坐骑列表[编号].法力资质/500+self.数据.坐骑列表[编号].魔力*self.数据.坐骑列表[编号].成长*3)
  self.数据.坐骑列表[编号].伤害 = ceil(self.数据.坐骑列表[编号].等级*self.数据.坐骑列表[编号].攻击资质*(self.数据.坐骑列表[编号].成长+1.4)/750+self.数据.坐骑列表[编号].力量*self.数据.坐骑列表[编号].成长)
  self.数据.坐骑列表[编号].防御 = ceil(self.数据.坐骑列表[编号].等级*self.数据.坐骑列表[编号].防御资质*(self.数据.坐骑列表[编号].成长+1.4)/1143+self.数据.坐骑列表[编号].耐力*(self.数据.坐骑列表[编号].成长-1/253)*253/190)
  self.数据.坐骑列表[编号].速度 = ceil(self.数据.坐骑列表[编号].速度资质 * self.数据.坐骑列表[编号].敏捷/1000)
  self.数据.坐骑列表[编号].灵力 = ceil(self.数据.坐骑列表[编号].等级*(self.数据.坐骑列表[编号].法力资质+1666)/3333+self.数据.坐骑列表[编号].魔力*0.7+self.数据.坐骑列表[编号].力量*0.4+self.数据.坐骑列表[编号].体质*0.3+self.数据.坐骑列表[编号].耐力*0.2)
  self.数据.坐骑列表[编号].气血 = self.数据.坐骑列表[编号].最大气血
  self.数据.坐骑列表[编号].魔法 = self.数据.坐骑列表[编号].最大魔法
  发送数据(玩家数据[self.数据.数字id].连接id,61.1,{编号=编号,数据=self.数据.坐骑列表[编号]})
  if self.数据.坐骑列表[编号].统御召唤兽 ~= nil and self.数据.坐骑列表[编号].统御召唤兽[1] ~= nil  then
    local 召唤兽编号 = self.数据.坐骑列表[编号].统御召唤兽[1]
    if  玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号]~=nil then
      if self.数据.坐骑列表[编号]~=nil and self.数据.坐骑列表[编号].忠诚>0 then
        玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号].统御属性.力量 =ceil(self.数据.坐骑列表[编号].力量*0.1)
        玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号].统御属性.魔力 =ceil(self.数据.坐骑列表[编号].魔力*0.1)
        玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号].统御属性.体质 =ceil(self.数据.坐骑列表[编号].体质*0.1)
        玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号].统御属性.敏捷 =ceil(self.数据.坐骑列表[编号].敏捷*0.1)
        玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号].统御属性.耐力 =ceil(self.数据.坐骑列表[编号].耐力*0.1)
      else
        玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号].统御属性.力量 =0
        玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号].统御属性.魔力 =0
        玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号].统御属性.体质 =0
        玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号].统御属性.敏捷 =0
        玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号].统御属性.耐力 =0
      end
     玩家数据[self.数据.数字id].召唤兽:刷新信息(召唤兽编号,"1")
     发送数据(玩家数据[self.数据.数字id].连接id,20,玩家数据[self.数据.数字id].召唤兽:取存档数据(召唤兽编号))
  end
  end
  if self.数据.坐骑列表[编号].统御召唤兽 ~= nil and self.数据.坐骑列表[编号].统御召唤兽[2] ~= nil then
    local 召唤兽编号1 = self.数据.坐骑列表[编号].统御召唤兽[2]
     if  玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号1]~=nil then
        if self.数据.坐骑列表[编号]~=nil and self.数据.坐骑列表[编号].忠诚>0 then
          玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号1].统御属性.力量 =ceil(self.数据.坐骑列表[编号].力量*0.1)
          玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号1].统御属性.魔力 =ceil(self.数据.坐骑列表[编号].魔力*0.1)
          玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号1].统御属性.体质 =ceil(self.数据.坐骑列表[编号].体质*0.1)
          玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号1].统御属性.敏捷 =ceil(self.数据.坐骑列表[编号].敏捷*0.1)
          玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号1].统御属性.耐力 =ceil(self.数据.坐骑列表[编号].耐力*0.1)
        else
          玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号1].统御属性.力量 =0
          玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号1].统御属性.魔力 =0
          玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号1].统御属性.体质 =0
          玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号1].统御属性.敏捷 =0
          玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号1].统御属性.耐力 =0
        end
        玩家数据[self.数据.数字id].召唤兽:刷新信息(召唤兽编号1,"1")
        发送数据(玩家数据[self.数据.数字id].连接id,20,玩家数据[self.数据.数字id].召唤兽:取存档数据(召唤兽编号1))
    end
  end
end

function 角色处理类:坐骑升级(编号)
    if self.数据.坐骑列表[编号].当前经验>=self.数据.坐骑列表[编号].最大经验 then
      self.数据.坐骑列表[编号].等级 = self.数据.坐骑列表[编号].等级 + 1
      if self.数据.坐骑列表[编号].等级 == 20 or self.数据.坐骑列表[编号].等级 == 40 or self.数据.坐骑列表[编号].等级 == 60 or self.数据.坐骑列表[编号].等级 == 80 or self.数据.坐骑列表[编号].等级 ==100 or self.数据.坐骑列表[编号].等级 ==120 or self.数据.坐骑列表[编号].等级 == 140 or self.数据.坐骑列表[编号].等级 == 160 or self.数据.坐骑列表[编号].等级 == 180 then
          self.数据.坐骑列表[编号].技能点 = self.数据.坐骑列表[编号].技能点 +1
      end
      self.数据.坐骑列表[编号].体质 = self.数据.坐骑列表[编号].体质 + 1
      self.数据.坐骑列表[编号].魔力 = self.数据.坐骑列表[编号].魔力 + 1
      self.数据.坐骑列表[编号].力量 = self.数据.坐骑列表[编号].力量 + 1
      self.数据.坐骑列表[编号].耐力 = self.数据.坐骑列表[编号].耐力 + 1
      self.数据.坐骑列表[编号].敏捷 = self.数据.坐骑列表[编号].敏捷 + 1
      self.数据.坐骑列表[编号].潜力 = self.数据.坐骑列表[编号].潜力 + 5
      self.数据.坐骑列表[编号].当前经验 = self.数据.坐骑列表[编号].当前经验 - self.数据.坐骑列表[编号].最大经验
      self.数据.坐骑列表[编号].最大经验 = 升级消耗.角色[self.数据.坐骑列表[编号].等级+1]
    end
end

function 角色处理类:坐骑洗点(编号)
  self.数据.坐骑列表[编号].潜力 = (self.数据.坐骑列表[编号].等级 + 1)*5
  self.数据.坐骑列表[编号].体质 = 10+ self.数据.坐骑列表[编号].等级
  self.数据.坐骑列表[编号].魔力 = 10+ self.数据.坐骑列表[编号].等级
  self.数据.坐骑列表[编号].力量 = 10+ self.数据.坐骑列表[编号].等级
  self.数据.坐骑列表[编号].耐力 = 10+ self.数据.坐骑列表[编号].等级
  self.数据.坐骑列表[编号].敏捷 = 10+ self.数据.坐骑列表[编号].等级
  self:坐骑刷新(编号)
end
function 角色处理类:坐骑加点(编号,加点内容)
  local 总点数 = 0
  local 检测是否合格 = true
  for k,v in pairs(加点内容) do
    if v<0 then
      检测是否合格=false
    end
    总点数=总点数+v
  end
  if 检测是否合格 then
    if 总点数<=0 then
      return
    elseif 总点数 > self.数据.坐骑列表[编号].潜力 then
      return
    else
      self.数据.坐骑列表[编号].体质 = self.数据.坐骑列表[编号].体质 + 加点内容.体质
      self.数据.坐骑列表[编号].魔力 = self.数据.坐骑列表[编号].魔力 + 加点内容.魔力
      self.数据.坐骑列表[编号].力量 = self.数据.坐骑列表[编号].力量 + 加点内容.力量
      self.数据.坐骑列表[编号].耐力 = self.数据.坐骑列表[编号].耐力 + 加点内容.耐力
      self.数据.坐骑列表[编号].敏捷 = self.数据.坐骑列表[编号].敏捷 + 加点内容.敏捷
      self.数据.坐骑列表[编号].潜力 = self.数据.坐骑列表[编号].潜力 - 总点数
      self:坐骑刷新(编号)
    end
  end
  -- table.print(加点内容)
  -- for i,v in pairs(加点内容) do
  --   总点数 = 总点数 + v
  -- end
  -- if 总点数<=0 then
  --   return
  -- elseif 总点数 > self.数据.坐骑列表[编号].潜力 then
  --   return
  -- else
  --   self.数据.坐骑列表[编号].体质 = self.数据.坐骑列表[编号].体质 + 加点内容.体质
  --   self.数据.坐骑列表[编号].魔力 = self.数据.坐骑列表[编号].魔力 + 加点内容.魔力
  --   self.数据.坐骑列表[编号].力量 = self.数据.坐骑列表[编号].力量 + 加点内容.力量
  --   self.数据.坐骑列表[编号].耐力 = self.数据.坐骑列表[编号].耐力 + 加点内容.耐力
  --   self.数据.坐骑列表[编号].敏捷 = self.数据.坐骑列表[编号].敏捷 + 加点内容.敏捷
  --   self.数据.坐骑列表[编号].潜力 = self.数据.坐骑列表[编号].潜力 - 总点数
  --   self:坐骑刷新(编号)
  -- end
end

function 角色处理类:坐骑喂养(编号,数额)
  self.数据.坐骑列表[编号].当前经验 = self.数据.坐骑列表[编号].当前经验 + 数额
  if self.数据.坐骑列表[编号].当前经验>=self.数据.坐骑列表[编号].最大经验 and self.数据.坐骑列表[编号].等级<self.数据.等级 then
     for i=self.数据.坐骑列表[编号].等级,self.数据.等级 do
         if self.数据.坐骑列表[编号].当前经验>=self.数据.坐骑列表[编号].最大经验 and self.数据.坐骑列表[编号].等级<self.数据.等级 then
              self:坐骑升级(编号)
              发送数据(玩家数据[self.数据.数字id].连接id,27,{文本="#W/你的坐骑#R/"..self.数据.坐骑列表[编号].名称.."#W/等级提升到了#R/"..self.数据.坐骑列表[编号].等级.."#W/级",频道="xt"})
         else
             break
         end
     end
  end

  self:坐骑刷新(编号)
end

function 角色处理类:坐骑放生(编号)
  if self.数据.坐骑列表[编号].统御召唤兽 ~= nil and (self.数据.坐骑列表[编号].统御召唤兽[1]~= nil or self.数据.坐骑列表[编号].统御召唤兽[2]~= nil) then
    常规提示(self.数据.数字id,"#Y该坐骑尚有统御的召唤兽未消除")
    return
  elseif self.数据.坐骑列表[编号].饰品~=nil or self.数据.坐骑列表[编号].饰品物件 ~= nil then
    常规提示(self.数据.数字id,"#Y请卸下该坐骑的饰品")
    return
  elseif self.数据.坐骑 ~= nil and self.数据.坐骑.认证码 == self.数据.坐骑列表[编号].认证码 then
    常规提示(self.数据.数字id,"#Y该坐骑正在骑乘中,请解除骑乘状态后再进行此操作！")
    return
  else
    for i=编号,#self.数据.坐骑列表 do
      if i~= 编号 and self.数据.坐骑列表[i].统御召唤兽 ~= nil then
        for n=1,#self.数据.坐骑列表[i].统御召唤兽 do
          local 召唤兽编号 = self.数据.坐骑列表[i].统御召唤兽[n]
          玩家数据[self.数据.数字id].召唤兽.数据[召唤兽编号].统御 = i-1
        end
      end
    end
    table.remove(self.数据.坐骑列表,编号)
    发送数据(玩家数据[self.数据.数字id].连接id,61,玩家数据[self.数据.数字id].角色.数据.坐骑列表)
    常规提示(id,"你的这个坐骑从你的眼前消失了~~")
  end
end
function 角色处理类:扣除体力(数额,说明,提示)
  数额=数额+0
  if self.数据.体力 >= 数额 then
    self.数据.体力 = self.数据.体力 - 数额
    if 提示~=nil then
      常规提示(self.数据.数字id,"你失去了"..数额.."点体力")
    end
    return true
  else
    return false
  end
end

function 角色处理类:扣除活力(数额,说明,提示)
  数额=数额+0
  if self.数据.活力 >= 数额 then
    self.数据.活力 = self.数据.活力 - 数额
    if 提示~=nil then
      常规提示(self.数据.数字id,"你失去了"..数额.."点活力")
    end
    return true
  else
    return false
  end
end


function 角色处理类:取玩家装备信息(id,对方id)
     if 玩家数据[id].摊位数据 ~= nil then
        常规提示(id,"#Y摆摊情况下无法进行此操作")
        return
      end
      if not 玩家数据[对方id] then return end
      self.发送信息={}
      self.发送信息.名称=玩家数据[对方id].角色.数据.名称
      self.发送信息.模型=玩家数据[对方id].角色.数据.模型
      self.发送信息.等级=玩家数据[对方id].角色.数据.等级
      self.发送信息.id=玩家数据[对方id].角色.数据.数字id
      self.发送信息.变身数据=玩家数据[对方id].角色.数据.变身数据
      self.发送信息.灵饰=玩家数据[对方id].角色:取灵饰数据()
      self.发送信息.锦衣 =玩家数据[对方id].角色:取锦衣数据()
      self.发送信息.装备=玩家数据[对方id].角色:取装备数据()
      发送数据(玩家数据[id].连接id,146,self.发送信息)
end


-- 一键学习门派技能：将单个技能升级到指定等级
function 角色处理类:一键学习门派技能(连接id,id,编号,目标等级)
    if self.数据.师门技能[编号]==nil then
        常规提示(id,"你没有这样的技能")
        return
    elseif 目标等级 > self.数据.等级+10 then
        常规提示(id,"门派技能不能超过角色等级+10")
        return
    elseif 目标等级 > 180 then
        常规提示(id,"技能等级不能超过180级")
        return
    elseif self.数据.师门技能[编号].等级 >= 目标等级 then
        常规提示(id,"技能等级已达到或超过目标等级")
        return
    end

    -- 获取基础技能信息
    local 基础技能信息 = self:取门派基础技能(id,self.数据.门派)
    if not 基础技能信息 or not 基础技能信息.编号 or not 基础技能信息.基础技能 or not self.数据.师门技能[基础技能信息.编号] or self.数据.师门技能[基础技能信息.编号].等级 == nil then
        常规提示(id,"门派基础技能数据异常，请 relog 或联系GM")
        return
    end
    if 目标等级 > self.数据.师门技能[基础技能信息.编号].等级 and 编号 ~= 基础技能信息.编号 then
        常规提示(id,"请先提升门派基础技能"..基础技能信息.基础技能)
        return
    end

    -- 计算总消耗
    if not self.数据.技能保留 then self.数据.技能保留 = {} end
    local 临时消耗={经验=0,金钱=0}
    local 当前等级 = self.数据.师门技能[编号].等级
    for i = 当前等级+1, 目标等级 do
        临时消耗.经验 = 临时消耗.经验 + 技能消耗.经验[i]
        临时消耗.金钱 = 临时消耗.金钱 + 技能消耗.金钱[i]
    end

    -- 检查经验是否足够
    if self.数据.当前经验 < 临时消耗.经验 then
        常规提示(id,"你没有那么多的经验")
        return
    end

    -- 计算银两消耗
    local 消耗银两 = 0
    local 消耗储备 = 0
    local 消耗存银 = 0
    if self.数据.储备>=临时消耗.金钱 then
        消耗储备=临时消耗.金钱
    elseif self.数据.储备+self.数据.银子>=临时消耗.金钱 then
        消耗储备=self.数据.储备
        消耗银两=临时消耗.金钱-self.数据.储备
    elseif self.数据.储备+self.数据.银子+self.数据.存银>=临时消耗.金钱 then
        消耗储备=self.数据.储备
        消耗银两=self.数据.银子
        消耗存银=临时消耗.金钱-self.数据.储备-self.数据.银子
    end

    -- 检查银两是否足够
    if self.数据.储备<消耗储备 then
        常规提示(id,"你没有那么多的储备")
        return
    elseif self.数据.银子<消耗银两 then
        常规提示(id,"你没有那么多的银两")
        return
    elseif self.数据.存银<消耗存银 then
        常规提示(id,"你没有那么多的存银")
        return
    end

    -- 执行升级
    self.数据.储备=self.数据.储备-消耗储备
    self.数据.银子=self.数据.银子-消耗银两
    self.数据.存银=self.数据.存银-消耗存银
    self.数据.当前经验=self.数据.当前经验-临时消耗.经验
    self.数据.师门技能[编号].等级=目标等级
    self.数据.技能保留[编号] = self.数据.师门技能[编号].等级
    self:升级技能(self.数据.师门技能[编号])

    -- 发送消息
    local 发送内容 = "一键学习["..self.数据.师门技能[编号].名称.."]到"..目标等级.."级\n"
    发送内容 = 发送内容.."消耗了"..临时消耗.经验.."点经验\n"
    if 消耗储备>0 then 发送内容 = 发送内容.."消耗了"..消耗储备.."两储备\n" end
    if 消耗银两>0 then 发送内容 = 发送内容.."消耗了"..消耗银两.."两银子\n" end
    if 消耗存银>0 then 发送内容 = 发送内容.."消耗了"..消耗存银.."两存银\n" end

    发送数据(玩家数据[self.数据.数字id].连接id,38,{内容=发送内容})
    self:日志记录("一键学习师门技能["..self.数据.师门技能[编号].名称.."]到"..目标等级.."级")
    self:银子记录()
    self:刷新信息("2")
    发送数据(连接id,31,玩家数据[id].角色:取总数据())
    刷新货币(连接id,id)
end

-- 一键全学门派技能：将所有师门技能升级到指定等级
function 角色处理类:一键全学门派技能(连接id,id,目标等级)
    if 目标等级 > self.数据.等级+10 then
        常规提示(id,"门派技能不能超过角色等级+10")
        return
    elseif 目标等级 > 180 then
        常规提示(id,"技能等级不能超过180级")
        return
    end

    -- 计算所有技能的总消耗
    if not self.数据.技能保留 then self.数据.技能保留 = {} end
    local 总消耗={经验=0,金钱=0}
    local 升级列表 = {}

    for 编号, 技能 in ipairs(self.数据.师门技能) do
        if 技能 and 技能.等级 and 技能.等级 < 目标等级 then
            local 单个技能消耗 = {经验=0,金钱=0}
            for i = 技能.等级+1, 目标等级 do
                单个技能消耗.经验 = 单个技能消耗.经验 + 技能消耗.经验[i]
                单个技能消耗.金钱 = 单个技能消耗.金钱 + 技能消耗.金钱[i]
            end
            总消耗.经验 = 总消耗.经验 + 单个技能消耗.经验
            总消耗.金钱 = 总消耗.金钱 + 单个技能消耗.金钱
            升级列表[编号] = {目标等级=目标等级, 消耗=单个技能消耗}
        end
    end

    if next(升级列表) == nil then
        常规提示(id,"所有技能等级已达到或超过目标等级")
        return
    end

    -- 检查经验是否足够
    if self.数据.当前经验 < 总消耗.经验 then
        常规提示(id,"你没有那么多的经验")
        return
    end

    -- 计算银两消耗
    local 消耗银两 = 0
    local 消耗储备 = 0
    local 消耗存银 = 0
    if self.数据.储备>=总消耗.金钱 then
        消耗储备=总消耗.金钱
    elseif self.数据.储备+self.数据.银子>=总消耗.金钱 then
        消耗储备=self.数据.储备
        消耗银两=总消耗.金钱-self.数据.储备
    elseif self.数据.储备+self.数据.银子+self.数据.存银>=总消耗.金钱 then
        消耗储备=self.数据.储备
        消耗银两=self.数据.银子
        消耗存银=总消耗.金钱-self.数据.储备-self.数据.银子
    end

    -- 检查银两是否足够
    if self.数据.储备<消耗储备 then
        常规提示(id,"你没有那么多的储备")
        return
    elseif self.数据.银子<消耗银两 then
        常规提示(id,"你没有那么多的银两")
        return
    elseif self.数据.存银<消耗存银 then
        常规提示(id,"你没有那么多的存银")
        return
    end

    -- 执行升级
    self.数据.储备=self.数据.储备-消耗储备
    self.数据.银子=self.数据.银子-消耗银两
    self.数据.存银=self.数据.存银-消耗存银
    self.数据.当前经验=self.数据.当前经验-总消耗.经验

    local 升级数量 = 0
    for 编号, 升级信息 in pairs(升级列表) do
        self.数据.师门技能[编号].等级 = 升级信息.目标等级
        self.数据.技能保留[编号] = self.数据.师门技能[编号].等级
        self:升级技能(self.数据.师门技能[编号])
        升级数量 = 升级数量 + 1
    end

    -- 发送消息
    local 发送内容 = "一键全学"..升级数量.."个师门技能到"..目标等级.."级\n"
    发送内容 = 发送内容.."消耗了"..总消耗.经验.."点经验\n"
    if 消耗储备>0 then 发送内容 = 发送内容.."消耗了"..消耗储备.."两储备\n" end
    if 消耗银两>0 then 发送内容 = 发送内容.."消耗了"..消耗银两.."两银子\n" end
    if 消耗存银>0 then 发送内容 = 发送内容.."消耗了"..消耗存银.."两存银\n" end

    发送数据(玩家数据[self.数据.数字id].连接id,38,{内容=发送内容})
    self:日志记录("一键全学师门技能到"..目标等级.."级，共"..升级数量.."个技能")
    self:银子记录()
    self:刷新信息("2")
    发送数据(连接id,31,玩家数据[id].角色:取总数据())
    刷新货币(连接id,id)
end

-- 突破学习门派技能：当技能≥角色等级+10时，每次升级1级，消耗增加5倍
function 角色处理类:突破学习门派技能(连接id,id,编号,学习次数)
    if self.数据.师门技能[编号]==nil then
        常规提示(id,"你没有这样的技能")
        return
    elseif self.数据.师门技能[编号].等级 < self.数据.等级+10 then
        常规提示(id,"技能等级需要达到角色等级+10才能突破学习")
        return
    elseif self.数据.师门技能[编号].等级 >= self.数据.等级+20 then
        常规提示(id,"突破门派技能不能超过角色等级+20")
        return
    elseif self.数据.师门技能[编号].等级 >= 180 then
        常规提示(id,"技能等级已达到最高等级180级")
        return
    end

    -- 计算突破学习的消耗（5倍消耗），每次只升级1级
    if not self.数据.技能保留 then self.数据.技能保留 = {} end
    local 当前等级 = self.数据.师门技能[编号].等级
    local 下一级 = 当前等级 + 1

    -- 获取下一级的基础消耗
    local 基础经验 = 技能消耗.经验[下一级] or 技能消耗.经验[180]
    local 基础金钱 = 技能消耗.金钱[下一级] or 技能消耗.金钱[180]

    -- 突破学习消耗为5倍
    local 临时消耗 = {
        经验 = 基础经验 * 5,
        金钱 = 基础金钱 * 5
    }

    -- 检查经验是否足够
    if self.数据.当前经验 < 临时消耗.经验 then
        常规提示(id,"你没有那么多的经验（突破学习需要5倍经验）")
        return
    end

    -- 计算银两消耗
    local 消耗银两 = 0
    local 消耗储备 = 0
    local 消耗存银 = 0
    if self.数据.储备>=临时消耗.金钱 then
        消耗储备=临时消耗.金钱
    elseif self.数据.储备+self.数据.银子>=临时消耗.金钱 then
        消耗储备=self.数据.储备
        消耗银两=临时消耗.金钱-self.数据.储备
    elseif self.数据.储备+self.数据.银子+self.数据.存银>=临时消耗.金钱 then
        消耗储备=self.数据.储备
        消耗银两=self.数据.银子
        消耗存银=临时消耗.金钱-self.数据.储备-self.数据.银子
    end

    -- 检查银两是否足够
    if self.数据.储备<消耗储备 then
        常规提示(id,"你没有那么多的储备（突破学习需要5倍银两）")
        return
    elseif self.数据.银子<消耗银两 then
        常规提示(id,"你没有那么多的银两（突破学习需要5倍银两）")
        return
    elseif self.数据.存银<消耗存银 then
        常规提示(id,"你没有那么多的存银（突破学习需要5倍银两）")
        return
    end

    -- 执行突破升级（每次只升级1级）
    self.数据.储备=self.数据.储备-消耗储备
    self.数据.银子=self.数据.银子-消耗银两
    self.数据.存银=self.数据.存银-消耗存银
    self.数据.当前经验=self.数据.当前经验-临时消耗.经验
    self.数据.师门技能[编号].等级=self.数据.师门技能[编号].等级+1  -- 每次只升级1级
    self.数据.技能保留[编号] = self.数据.师门技能[编号].等级
    self:升级技能(self.数据.师门技能[编号])

    -- 发送消息
    local 发送内容 = "突破学习["..self.数据.师门技能[编号].名称.."]升级1级\n"
    发送内容 = 发送内容.."从"..当前等级.."级升级到"..(当前等级+1).."级\n"
    发送内容 = 发送内容.."消耗了"..临时消耗.经验.."点经验（5倍消耗）\n"
    if 消耗储备>0 then 发送内容 = 发送内容.."消耗了"..消耗储备.."两储备（5倍消耗）\n" end
    if 消耗银两>0 then 发送内容 = 发送内容.."消耗了"..消耗银两.."两银子（5倍消耗）\n" end
    if 消耗存银>0 then 发送内容 = 发送内容.."消耗了"..消耗存银.."两存银（5倍消耗）\n" end

    发送数据(玩家数据[self.数据.数字id].连接id,38,{内容=发送内容})
    self:日志记录("突破学习师门技能["..self.数据.师门技能[编号].名称.."]从"..当前等级.."级升级到"..(当前等级+1).."级")
    self:银子记录()
    self:刷新信息("2")
    发送数据(连接id,31,玩家数据[id].角色:取总数据())
    刷新货币(连接id,id)
end

return 角色处理类