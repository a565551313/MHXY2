
local 战斗单位类 = class()


local FSB = require("script/资源类/FSB")
local 阵法位置 = require("script/战斗类/战斗位置")



function 战斗单位类:初始化()
          self.编号 = 0
          self.位置 = 0
          self.战意 = 0
          self.风灵 = 0
          self.剑意 = 0
          self.符咒 = 0
          self.气血 = 0
          self.队伍 = 0
          self.魔法 = 0
          self.愤怒 = 0
          self.高度 = 0
          self.敌我 = 2
          self.方向 = 0
          self.名称 = ""
          self.数据 = {}
          self.动画 = {}
          self.灵药红 = 0
          self.灵药蓝 = 0
          self.灵药黄 = 0
          self.攻击帧 = 0
          self.终极帧 = 0
          self.类型 = "bb"
          self.动作 = "待战"
          self.模型 = "未知"
          self.最大气血 = 0
          self.气血上限 = 0
          self.最大魔法 = 0
          self.超级战意 = 0
          self.雷法崩裂 = 0
          self.雷法震煞 = 0
          self.雷法坤伏 = 0
          self.雷法翻天 = 0
          self.雷法倒海 = 0
          self.五行珠金 = 0
          self.五行珠木 = 0
          self.五行珠水 = 0
          self.五行珠火 = 0
          self.五行珠土 = 0
          self.影子数量 = 0
          self.攻击延迟 = 0
          self.初始方向 = 0
          self.逃跑方向 = 0
          self.逃跑坐标 = 0
          self.躲避参数 = 0
          self.躲避坐标 = 0
          self.色相变身 = 0
          self.提示时间 = 0
          self.经脉流派 = ""
          self.人参娃娃 = {}
          self.奇经特效 = {}
          self.技能冷却 = {}
          self.主动技能 = {}
          self.特技技能 = {}
          self.移动坐标 = {}
          self.攻击特效 = {}
          self.法术特效 = {}
          self.状态特效 = {}
          self.影子显示 = {}
          self.x,self.y = 0,0
          self.门派 = "无门派"
          self.影子开关 = false
          self.掉血开关 = false
          self.捕捉开关 = false
          self.是否显示 = false
          self.技能提示 = false
          self.逃跑开关 = false
          self.鼠标跟随 = false
          self.飞镖开关 = false
          self.法术开关 = false
          self.弓弩开关 = false
          self.附加阵法 = "普通"
          self.初始xy = {x=0,y=0}
          self.显示xy = {x=0,y=0}
          self.名称颜色=0xFF70FC70
          self.法术坐标 = {x=0,y=0}
          self.反震误差 = {x=0,y=0}
          self.抖动数据={开关=false,进程=0,x=0,y=0}
          self.伤害图片 = tp.战斗文字[1]
          self.回复图片 = tp.战斗文字[2]
          self.回血图片 = tp.战斗文字[3]
          self.暴击图片 = tp.战斗文字[4]
          self.括号图片 = tp.战斗文字[6]
          self.暴击括号图片 = tp.战斗文字[7]
end


--number
local function 取攻击帧(模型,zl)
  local 攻击帧,攻击延迟,终结帧 = 2,1.25,nil
  if zl and type(zl) == "number" then
    zl = tp:取武器子类(zl)
  end
  if 模型 == "偃无师" or 模型 == "桃夭夭"  then
      攻击帧 = -1
      攻击延迟 = 1.35
  elseif 模型 == "鬼潇潇" or 模型 == "龙太子" or 模型 == "剑侠客" or 模型 == "真陀护法" then
          攻击帧 = 1
          攻击延迟 = 1.3
  elseif 模型 == "玄彩娥" or 模型 == "舞天姬" or 模型 == "进阶毗舍童子"or 模型 == "羊头怪" or 模型 == "锦毛貂精" then
          攻击帧 = -1
          攻击延迟 = 1.15
  elseif 模型 == "虎头怪" or 模型 == "神天兵" or 模型 == "巨魔王" or 模型 == "杀破狼" or 模型 == "持国巡守" or
         模型 == "雷鸟人" or 模型 == "金饶僧" or 模型 == "葫芦宝贝" or 模型 == "幽灵"  or 模型 == "凤凰" or
         模型 == "野鬼" or 模型 == "帮派妖兽" or 模型 == "修罗傀儡鬼" or 模型 == "踏云兽" or 模型 == "巴蛇" or 模型 == "黑熊"  then
          攻击帧 = 1
          攻击延迟 = 1.2
          if zl == "弓弩" or zl == "弓弩1"  then
              攻击延迟 = 0.88
          end
  elseif 模型 == "海星" or 模型 == "牛头" or 模型 == "芙蓉仙子" or 模型 == "犀牛将军兽形" or 模型 == "进阶芙蓉仙子"
   or 模型 == "进阶星灵仙子" or 模型 == "进阶千年蛇魅" or 模型 == "进阶百足将军" or 模型 == "灵鹤" or 模型 == "进阶灵符女娲"
   or 模型 == "进阶净瓶女娲" or 模型 == "进阶灵鹤" or 模型 == "进阶鬼将" or 模型 == "进阶琴仙" or 模型 == "狂豹人形"
   or 模型 == "修罗傀儡妖" or 模型 == "真陀护法" or 模型 == "进阶猫灵兽形" or 模型 == "进阶真陀护法" or 模型 == "超级孔雀" or 模型 == "超级白泽"
   or 模型 == "超级人参娃娃" or 模型 == "进阶小毛头" or 模型 == "进阶小仙灵" or 模型 == "超级泡泡" or 模型 == "进阶超级泡泡"  then
        攻击帧 = 2
  elseif 模型 == "进阶凤凰" or 模型 == "进阶碧水夜叉" or 模型 == "进阶锦毛貂精" or 模型 == "灵符女娲" or 模型 == "夜罗刹" or 模型 == "进阶雾中仙"
   or 模型 == "毗舍童子" or 模型 == "进阶金身罗汉" or 模型 == "超级大鹏" or 模型 == "超级赤焰兽"  or 模型 == "大大王" then
        攻击帧 = 3
  elseif 模型 == "强盗" or 模型 == "山贼" or 模型 == "鼠先锋" or 模型 == "增长巡守" or
         模型 == "灵灯侍者" or 模型 == "般若天女" or 模型 == "进阶雨师" or 模型 == "进阶如意仙子" or
         模型 == "野猪精" or 模型 == "超级玉兔" or 模型 == "幽莹娃娃" or 模型 == "黑熊精" or
         模型 == "蚌精"  or 模型 == "机关鸟" or 模型 == "连弩车" or 模型 == "蜃气妖" or 模型 == "蛤蟆精" or
         模型 == "虾兵" or 模型 == "蟹将" or 模型 == "兔子怪" or 模型 == "蜘蛛精" or 模型 == "花妖" or
         模型 == "狐狸精" or 模型 == "哮天犬" or 模型 == "混沌兽" or 模型 == "蝴蝶仙子" or
         模型 == "狼" or 模型 == "老虎" then
        攻击帧 = 2
        攻击延迟 = 1.12
 elseif 模型 == "野猪" or  模型 == "树妖" or 模型 == "黑熊" or 模型 == "白熊"  or 模型 == "超级神猴" or 模型 == "超级小白龙" or 模型 == "超级神羊"  then
    攻击帧 = 1
  elseif 模型 == "羊头怪" or 模型 == "海毛虫" or 模型 == "花妖" or 模型 == "飞天" or 模型 == "超级神鼠" or 模型 == "进阶阴阳伞" or 模型 == "画魂" or 模型 == "长眉灵猴" or 模型 == "进阶巨力神猿"
  or 模型 == "芙蓉仙子" then
    攻击帧 = -1
  elseif 模型 == "机关人人形" or 模型 == "机关兽" then
    攻击帧 = 2
    攻击延迟 = 1.25
  elseif 模型 == "泡泡" then
    攻击帧 = 2
    攻击延迟 = 2.1
  elseif 模型 == "混沌兽"  then
    攻击延迟 = 1.35
  elseif 模型 == "狂豹人形"  then
    攻击帧 = 1
    攻击延迟 = 1.4
  elseif 模型 == "海毛虫" then
    攻击延迟 = 1.35
  elseif 模型 == "大海龟"or 模型 == "骷髅怪" or 模型 == "金身罗汉" or 模型 == "修罗傀儡妖" or 模型 == "曼珠沙华" or 模型 == "幽萤娃娃" then
    攻击帧 = 1
    攻击延迟 = 1.2
  elseif 模型 == "画魂" or 模型 == "羽灵神"  then
    攻击帧 = 1
    攻击延迟 = 1.1
  elseif 模型 == "天兵"or 模型 == "巨力神猿"   then
    攻击帧 = 1
    攻击延迟 = 1.25
  elseif 模型 == "地狱战神" or 模型 == "风伯" or 模型 == "芙蓉仙子" or 模型 == "镜妖"  or 模型 == "千年蛇魅"or 模型 == "小龙女"  then
    攻击帧 = 1
    攻击延迟 = 1.25
  elseif 模型 == "芙蓉仙子" then
    攻击帧 = 1
    攻击延迟 = 1.1
  elseif 模型 == "百足将军"  or 模型 == "天将" or 模型 == "碧水夜叉" or 模型 == "马面" or 模型 == "灵鹤" then
    攻击帧 = 3
    攻击延迟 = 1.23
  elseif 模型 == "鬼将"  or  模型 == "大力金刚"then
    攻击帧 = 4
    攻击延迟 = 1.3
    终结帧 = 1
  elseif 模型 == "赌徒" then
    攻击帧 = 4
    攻击延迟 = 1.1
  elseif 模型 == "牛妖"  then
    攻击帧 = 3
    攻击延迟 = 1.26
  elseif 模型 == "古代瑞兽"  then
    攻击帧 = 3--4
    攻击延迟 = 1.2
  elseif 模型 == "知了王" then
    攻击帧 = 6
    攻击延迟 = 1.32
  elseif 模型 == "黑山老妖" then
    攻击帧 = 6
    攻击延迟 = 1.2
  elseif 模型 == "炎魔神" then
    攻击帧 = 4
    攻击延迟 = 1.2
  elseif 模型 == "长眉灵猴"  then
    攻击帧 = -1
    攻击延迟 = 1.23
  elseif 模型 == "骨精灵" or 模型 == "狐美人"  or 模型 == "逍遥生" or 模型 == "巫蛮儿" or 模型 == "英女侠" or 模型 == "飞燕女" then
           攻击帧 = 1
          if zl == "魔棒"  then
            攻击帧 = -1
          elseif zl == "宝珠" then
            攻击帧 = 2
          elseif 模型 == "英女侠"  then
            攻击帧 = 1
          elseif 模型 == "飞燕女" and zl == "双短剑"  then
            攻击帧 = 1
          elseif 模型 == "飞燕女" and zl == "环圈"  then
            攻击帧 = 3

          elseif 模型 == "逍遥生" and (zl == "扇")  then
            攻击帧 = 1
          elseif 模型 == "逍遥生" and (zl == "剑")  then
            攻击帧 = -1
            终结帧 = 1
          elseif 模型 == "巫蛮儿" and (zl == "法杖")  then
            攻击帧 =1
          elseif 模型 == "狐美人" and zl == "爪刺" then
            攻击帧 = 1
          elseif 模型 == "狐美人" and zl == "鞭" then
            攻击帧 = 1
          end
        攻击延迟 = 1.25
  end
  return 攻击帧,攻击延迟,终极帧
end



function 战斗单位类:更改模型(模型,类型)
      self.动画=战斗动画类()
      self.动画:创建动画(模型,类型,0,nil,false,nil,nil)
      -- self.躲避动画=战斗动画类()
      -- self.躲避动画:创建动画(模型,1,0,nil,false,nil,nil)
      -- self.躲避动画:置颜色(ARGB(165,255,255,255),"待战")
      self.模型=模型
      self.是否变身=true
      self.攻击帧,self.攻击延迟,self.终极帧 = 取攻击帧(self.模型,self.武器子类)
      self.高度 = self.动画.动画["待战"].信息组[0][3]
      if self.高度 > 120 then
            self.高度 = 120
      elseif self.高度 < 60 then
              self.高度 = 60
      elseif self.高度 < 85 then
            self.高度 = 85
      end
      if self.位置 == 2 then
        self.高度 = self.高度 + 20
      else
        self.高度 = self.高度 + 20
      end
      self.动画:置方向(self.方向,self.动作)
end






function 战斗单位类:创建单位(数据,队伍id,编号)
          self.编号 = 编号
          self.数据 = 数据
          self.动画 = 战斗动画类()
          self.动画:创建动画(数据.模型,数据.类型,数据.染色方案,数据.染色组,数据.变异,数据.武器,数据.变身数据,数据.显示饰品,数据.锦衣数据,数据.武器染色方案,数据.武器染色组,数据.饰品染色方案,数据.饰品染色组,数据.副武器)
          self.动作="待战"
          self.名称 = 数据.名称
          self.主动技能={}
          self.特技技能={}
          self.战意=0-----------------------特效状态
          self.风灵=0
          self.剑意=0
          self.超级战意= 0
          self.灵药红= 0
          self.灵药蓝= 0
          self.灵药黄= 0
          self.符咒= 0
          self.雷法崩裂= 0
          self.雷法震煞= 0
          self.雷法坤伏= 0
          self.雷法翻天= 0
          self.雷法倒海= 0
          self.五行珠金= 0
          self.五行珠木= 0
          self.五行珠水= 0
          self.五行珠火= 0
          self.五行珠土= 0
          self.人参娃娃= {}
          self:加载数据(数据)
          self.奇经特效={}
          self.经脉流派= 数据.经脉流派
          self.技能冷却=数据.技能冷却 or {}
          self.气血=数据.气血
          self.队伍=数据.队伍
          self.最大气血=数据.最大气血
          self.气血上限=数据.气血上限
          self.魔法=数据.魔法
          self.愤怒=数据.愤怒
          self.最大魔法=数据.最大魔法
          self.模型=数据.模型
          self.类型=数据.类型
          self.染色方案=数据.染色方案
          self.染色组=数据.染色组
          self.变异=数据.变异
          self.武器=数据.武器
          self.变身数据=数据.变身数据
          self.显示饰品=数据.显示饰品
          self.锦衣数据=数据.锦衣数据
          self.副武器=数据.副武器
          self.移动坐标={}
          self.攻击特效={}
          self.法术特效={}
          self.状态特效= {}
          self.掉血开关=false
          self.捕捉开关=false
          self.是否显示=true
          self.附加阵法 = 数据.附加阵法  or "普通"
          self.位置 = 数据.位置
          self.门派 = 数据.门派
          self.超级进化=nil
          self.影子显示={}
          self.影子开关=false
          self.影子数量=0
          if 数据.武器~=nil then
            self.武器子类=数据.武器.子类
         	end
          self.名称颜色=0xFF70FC70
          local 临时模型 = 数据.模型
          if 数据.变身数据~=nil then
          临时模型=数据.变身数据
          end
          self.攻击帧,self.攻击延迟,self.终极帧 = 取攻击帧(临时模型,self.武器子类)
          self.高度 = self.动画.动画["待战"].信息组[0][3]
          if not self.高度 then
              self.高度 = 80
          end
        	if self.高度 > 140 then
        		  self.高度 = 140
        	elseif self.高度 < 80 then
        		  self.高度 = 80
        	end
          if 数据.队伍==战斗类.队伍id then
              self.敌我=1
              self.初始方向=2
              self.逃跑方向=0
              self.逃跑坐标=3
              self.躲避参数=8
              self.躲避坐标=2.5
              self.反震误差={x=50,y=10}
          else
              self.敌我=2
              self.初始方向=0
              self.逃跑方向=2
              self.逃跑坐标=-3
              self.躲避参数=-8
              self.躲避坐标=-2.5
              self.反震误差={x=-50,y=-10}
         	end
          local 战斗位置=阵法位置[self.附加阵法][self.敌我][self.位置]
          local 偏移={x=0,y=0}
          if self.位置<=5 or self.位置>14 then
              if self.敌我==1 then
                  偏移={x=40,y=35}
              else
                  偏移={x=-40,y=-10}
              end
          end
          self.初始xy = {x=战斗位置.x+偏移.x+全局游戏宽度/2,y=战斗位置.y+偏移.y+全局游戏高度/2}
          self.显示xy = {x=self.初始xy.x,y=self.初始xy.y}
          self.x,self.y = self.显示xy.x,self.显示xy.y
          self.方向 = self.初始方向
          self.动画:置方向(self.方向,self.动作)
          self.色相变身=0
          self.技能提示 = false
          self.提示时间 = 0
          self.抖动数据={开关=false,进程=0,x=0,y=0}
          self.法术坐标 = {x = 0,y = 0}
          self.逃跑开关=false
          self.逃跑特效=tp:载入特效("逃跑",self:取txz("逃跑"))
          self.喊话=require("script/显示类/喊话").创建(tp)
          self.鼠标跟随=false
          self.飞镖开关=false
          self.法术开关 = false
          self.弓弩开关=false
          self:加载奇经特效()
end

function 战斗单位类:加载数据(数据)
          if 数据.主动技能~= nil then
              self.主动技能=数据.主动技能
          end
          if 数据.特技技能~= nil then
             self.特技技能=数据.特技技能
          end
          if 数据.战意~= nil then
              self.战意=数据.战意
          end
          if 数据.风灵~= nil then
              self.风灵=数据.风灵
          end
          if 数据.剑意~= nil then
            self.剑意=数据.剑意
          end
          if 数据.超级战意~= nil then
            self.超级战意= 数据.超级战意
          end
          if 数据.灵药~= nil then
            self.灵药红= 数据.灵药.红
            self.灵药蓝= 数据.灵药.蓝
            self.灵药黄= 数据.灵药.黄
          end
          if 数据.符咒~= nil then
            self.符咒= 数据.符咒
          end
          if 数据.雷法~= nil then
            self.雷法崩裂= 数据.雷法.雷法崩裂
            self.雷法震煞= 数据.雷法.雷法震煞
            self.雷法坤伏= 数据.雷法.雷法坤伏
            self.雷法翻天= 数据.雷法.雷法翻天
            self.雷法倒海= 数据.雷法.雷法倒海
          end
          if 数据.五行珠~= nil then
            self.五行珠金= 数据.五行珠.金
            self.五行珠木= 数据.五行珠.木
            self.五行珠水= 数据.五行珠.水
            self.五行珠火= 数据.五行珠.火
            self.五行珠土= 数据.五行珠.土
          end
          if 数据.人参娃娃~= nil then
            self.人参娃娃= 数据.人参娃娃
          end
end


function 战斗单位类:加载奇经特效()
        if self.门派 and self.门派~="无" then
              if  self.门派=="凌波城" then
                  self.奇经特效.战意={}
                  for i = 1, 3 do
                      local 状态参数 = self:状态前置("战意"..i)
                      self.奇经特效.战意[i] = tp:载入特效("状态_战意"..i,self:取txz("战意"..i))
                      self.奇经特效.战意[i].cp = 状态参数.cp
                      self.奇经特效.战意[i].py = 状态参数.py
                  end
                if self.经脉流派 =="灵霄斗士"  then
                    self.奇经特效.超级战意={}
                    for i = 1, 3 do
                        local 状态参数 = self:状态前置("超级战意"..i)
                        self.奇经特效.超级战意[i] = tp:载入特效("状态_超级战意"..i,self:取txz("超级战意"..i))
                        self.奇经特效.超级战意[i].cp = 状态参数.cp
                        self.奇经特效.超级战意[i].py = 状态参数.py
                    end
                end

            elseif self.门派=="神木林"  then
                  if self.经脉流派 =="灵木药宗"  then
                        local 状态参数 = self:状态前置("灵药红")
                        self.奇经特效.灵药红 = tp:载入特效("状态_灵药红",self:取txz("灵药红"))
                        self.奇经特效.灵药红.cp = 状态参数.cp
                        self.奇经特效.灵药红.py = 状态参数.py
                        local 状态参数1 = self:状态前置("灵药蓝")
                        self.奇经特效.灵药蓝 = tp:载入特效("状态_灵药蓝",self:取txz("灵药蓝"))
                        self.奇经特效.灵药蓝.cp = 状态参数1.cp
                        self.奇经特效.灵药蓝.py = 状态参数1.py
                        local 状态参数2 = self:状态前置("灵药黄")
                        self.奇经特效.灵药黄 = tp:载入特效("状态_灵药黄",self:取txz("灵药黄"))
                        self.奇经特效.灵药黄.cp = 状态参数2.cp
                        self.奇经特效.灵药黄.py = 状态参数2.py
                  else
                        local 状态参数 = self:状态前置("风灵")
                        self.奇经特效.风灵 = tp:载入特效("状态_风灵",self:取txz("风灵"))
                        self.奇经特效.风灵.cp = 状态参数.cp
                        self.奇经特效.风灵.py = 状态参数.py
                  end

            elseif self.门派=="方寸山"  and self.经脉流派 =="五雷正宗"  then
                    self.奇经特效.符咒={}
                    for i = 1, 5 do
                        local 状态参数 = self:状态前置("符咒"..i)
                        self.奇经特效.符咒[i] =  tp:载入特效("状态_符咒"..i,self:取txz("符咒"..i))
                        self.奇经特效.符咒[i].cp = 状态参数.cp
                        self.奇经特效.符咒[i].py = 状态参数.py
                    end
                    local 状态参数 = self:状态前置("雷法崩裂")
                    self.奇经特效.雷法崩裂 = tp:载入特效("状态_雷法崩裂",self:取txz("雷法崩裂"))
                    self.奇经特效.雷法崩裂.cp = 状态参数.cp
                    self.奇经特效.雷法崩裂.py = 状态参数.py
                    local 状态参数1 = self:状态前置("雷法震煞")
                    self.奇经特效.雷法震煞 = tp:载入特效("状态_雷法震煞",self:取txz("雷法震煞"))
                    self.奇经特效.雷法震煞.cp = 状态参数1.cp
                    self.奇经特效.雷法震煞.py = 状态参数1.py
                    local 状态参数2 = self:状态前置("雷法坤伏")
                    self.奇经特效.雷法坤伏 = tp:载入特效("状态_雷法坤伏",self:取txz("雷法坤伏"))
                    self.奇经特效.雷法坤伏.cp = 状态参数2.cp
                    self.奇经特效.雷法坤伏.py = 状态参数2.py
                    local 状态参数3 = self:状态前置("雷法翻天")
                    self.奇经特效.雷法翻天 = tp:载入特效("状态_雷法翻天",self:取txz("雷法翻天"))
                    self.奇经特效.雷法翻天.cp = 状态参数3.cp
                    self.奇经特效.雷法翻天.py = 状态参数3.py
                    local 状态参数4 = self:状态前置("雷法倒海")
                    self.奇经特效.雷法倒海 = tp:载入特效("状态_雷法倒海",self:取txz("雷法倒海"))
                    self.奇经特效.雷法倒海.cp = 状态参数4.cp
                    self.奇经特效.雷法倒海.py = 状态参数4.py
            elseif self.门派=="普陀山" and self.经脉流派 =="落伽神女"  then
                    local 状态参数 = self:状态前置("五行珠金")
                    self.奇经特效.五行珠金 = tp:载入特效("状态_五行珠金",self:取txz("五行珠金"))
                    self.奇经特效.五行珠金.cp = 状态参数.cp
                    self.奇经特效.五行珠金.py = 状态参数.py
                    local 状态参数1 = self:状态前置("五行珠木")
                    self.奇经特效.五行珠木 = tp:载入特效("状态_五行珠木",self:取txz("五行珠木"))
                    self.奇经特效.五行珠木.cp = 状态参数1.cp
                    self.奇经特效.五行珠木.py = 状态参数1.py
                    local 状态参数2 = self:状态前置("五行珠水")
                    self.奇经特效.五行珠水 = tp:载入特效("状态_五行珠水",self:取txz("五行珠水"))
                    self.奇经特效.五行珠水.cp = 状态参数2.cp
                    self.奇经特效.五行珠水.py = 状态参数2.py
                    local 状态参数3 = self:状态前置("五行珠火")
                    self.奇经特效.五行珠火 = tp:载入特效("状态_五行珠火",self:取txz("五行珠火"))
                    self.奇经特效.五行珠火.cp = 状态参数3.cp
                    self.奇经特效.五行珠火.py = 状态参数3.py
                    local 状态参数4 = self:状态前置("五行珠土")
                    self.奇经特效.五行珠土 = tp:载入特效("状态_五行珠土",self:取txz("五行珠土"))
                    self.奇经特效.五行珠土.cp = 状态参数4.cp
                    self.奇经特效.五行珠土.py = 状态参数4.py
            elseif self.门派=="五庄观" and self.经脉流派 =="万寿真仙"  then
                      self.奇经特效.人参娃娃={}
                      for i = 1, 3 do
                          local 状态参数 = self:状态前置("人参娃娃"..i)
                          self.奇经特效.人参娃娃[i] =tp:载入特效("状态_人参娃娃"..i,self:取txz("人参娃娃"..i))
                          self.奇经特效.人参娃娃[i].cp = 状态参数.cp
                          self.奇经特效.人参娃娃[i].py = 状态参数.py
                      end
            elseif self.门派=="大唐官府"and self.经脉流派 =="无双战神"  then
                      local 状态参数 = self:状态前置("剑意")
                      self.奇经特效.剑意= tp:载入特效("状态_剑意",self:取txz("剑意"))
                      self.奇经特效.剑意.cp = 状态参数.cp
                      self.奇经特效.剑意.py = 状态参数.py
            end
        end


      if self.数据.超级进化 then
          local 临时名称 = self.数据.超级进化
          if self.数据.超级进化=="奔雷咒" or self.数据.超级进化=="泰山压顶"  or self.数据.超级进化=="水漫金山" or self.数据.超级进化=="地狱烈火" or self.数据.超级进化=="壁垒击破" then
              临时名称="超级"..self.数据.超级进化
          else
              local 临时进化 = 分割文本(self.数据.超级进化,"高级")
              临时名称="超级"..临时进化[2]
          end
          local  临时资源=引擎.取技能(临时名称)
          if 战斗类.回合数<=1 then
              self.超级进化={图像=tp.资源:载入(临时资源[6],"网易WDF动画",临时资源[7]),回合=2}
          else
              self.超级进化={图像=tp.资源:载入(临时资源[6],"网易WDF动画",临时资源[7]),回合=战斗类.回合数+1}
          end
      end



end



function 战斗单位类:设置鼠标跟随(特效)
  if 1==1 then return  end
  if self.鼠标跟随 then
    self.鼠标跟随=false
  else
    self.鼠标跟随=true
  end
end

function 战斗单位类:法术延时()
    if not self.抖动延时 then
          if self.受击名称 then
            if self.受击名称 == '判官令' or self.受击名称 == '三昧真火' or self.受击名称 == '苍茫树'
              or self.受击名称 == '雨落寒沙' or self.受击名称 == '子母神针' or self.受击名称 == '阎罗令' or
              self.受击名称 == '毁灭之光' or self.受击名称 == '天降灵葫' then
              self.抖动延时 = 30
            elseif self.受击名称 == '奔雷咒' or self.受击名称 == '超级奔雷咒' or self.受击名称 == '凋零之歌' or
              self.受击名称 == '碎甲术' or self.受击名称 == '八凶法阵'  then
              self.抖动延时 = 40
            elseif self.受击名称 == '地狱烈火' or self.受击名称 == '超级地狱烈火'or  self.受击名称 == '龙吟' or
              self.受击名称 == '唧唧歪歪'or self.受击名称 == '谆谆教诲' or self.受击名称 == '太极生化'
              or self.受击名称 == '五行错位' or self.受击名称 == '三星灭魔' or self.受击名称 == '雷浪穿云' then
              self.抖动延时 = 50
            elseif self.受击名称 == '流沙轻音' then
              self.抖动延时 = 105
            elseif self.受击名称 == '上古灵符(怒雷)'or self.受击名称 == '上古灵符(流沙)'
              or self.受击名称 == '上古灵符(心火)' or self.受击名称 == '腾雷' or self.受击名称 == '凋零之歌'
              or  self.受击名称 == '刀光剑影' or self.受击名称 == '叱咤风云' then
              self.抖动延时 = 80
            elseif self.受击名称 == '龙卷雨击' then
              self.抖动延时 = 90

            else
                self.抖动延时 = 20
            end
        end
    end
end









function 战斗单位类:取txz(特效)

  self.受击名称 = 特效

  local txz = 0
	if 特效 == "唧唧歪歪" or 特效 == "谆谆教诲"  then
		txz = 1.15
	elseif 特效 == "横扫千军" or 特效 == "浪涌" or 特效 == "神来气旺" or 特效 == "哼哼哈兮"or 特效 == "水击三千"  then
		txz = 1.05
	elseif 特效 == "反震" or 特效 == "防御" then
		txz = 1.6
	elseif 特效 == "捕捉开始"or 特效 == "暴击" then
		txz = 1.5
  elseif 特效 == "暴击" then
    txz = 1.5
	elseif 特效 == "龙卷雨击1" or 特效 == "地裂火"  then
		txz = 1.15
	elseif 特效 == "龙卷雨击2" then
		txz = 1.5
	elseif 特效 == "龙卷雨击3" then
		txz = 1.0
	elseif 特效 == "龙卷雨击4" then
		txz = 1.15
	elseif 特效 == "龙吟" then
		txz = 1.45
  elseif 特效 == "蝼蚁蚀天" then
    txz = 1.15
	elseif 特效 == "龙腾" or 特效 == "亢龙归海" then
		txz = 1.75
	elseif 特效 == "连环击" or 特效 == "最佳搭档" or 特效 == "困兽之斗"  then
		txz = 2.4
	elseif 特效 == "宠物_静" then
		local mt = ptmx(tp.宠物.模型)
		return tp.资源:载入(mt[3],"网易WDF动画",mt[1])
	elseif 特效 == "宠物_走" then
		local mt = ptmx(tp.宠物.模型)
		return tp.资源:载入(mt[3],"网易WDF动画",mt[2])
	elseif 特效 == "天雷斩" or 特效 == "风雷斩" then
		txz = 1.6
	-- elseif 特效 == "地狱烈火" or 特效 == "超级地狱烈火" then
	-- 	txz = 1.6
 --  elseif 特效 == "水漫金山"  or 特效 == "超级水漫金山" then
 --    txz = 2.4
	elseif 特效 == "鹰击" or 特效 == "上古灵符" or 特效 == "鹰击长空" then
		txz = 1.48
	elseif 特效 == "五雷轰顶" then
		txz = 1
	elseif 特效 == "天罗地网" then
		txz = 0.85
	elseif 特效 == "狮搏" or 特效 == "幼狮之搏"  then
		txz = 1.4
	elseif 特效 == "被击中" then
    txz = 1.28
  elseif 特效 == "飞砂走石" or 特效 == "秘传飞砂走石" or 特效 == "二龙戏珠" then
		txz = 1.28
	elseif 特效 == "翻江搅海" then
		txz = 3
	elseif 特效 == "尘土刃" then
		txz = 1.5
	-- elseif 特效 == "泰山压顶1" then
	-- 	txz = 1.25
	-- elseif 特效 == "泰山压顶2" then
	-- 	txz = 1.4


	elseif 特效 == "归元咒" or 特效 == "乾天罡气" or 特效 == "巨岩破" or 特效 == "推拿" or 特效 == "活血" or 特效 == "推气过宫" then
		txz = 0.95
	elseif 特效 == "惊心一剑" or 特效 == "牛刀小试" or 特效 == "力劈华山" then
		txz = 1.05

  elseif 特效 == "怒哮"  then
    txz = 0.1


	else
		txz = 1.15
	end
	return txz
end

function 战斗单位类:添加攻击特效(名称,加速)
  local 临时音乐=引擎.取音效(名称)
  if 游戏音效>0 and 临时音乐~=nil then
    self:音效类(临时音乐.文件,临时音乐.资源,'1')
  end
  local 名称1=名称
  if 名称1=="干将莫邪" or 名称1=="金甲仙衣" or 名称1=="降魔斗篷" then
      if self.敌我==1 then
        名称1=名称1.."_我方"
      else
        名称1=名称1.."_敌方"
      end
  end
  if not self:无需特效(名称) then
      self.攻击特效[#self.攻击特效+1]=tp:载入特效(名称1,self:取txz(名称))
      self.攻击特效[#self.攻击特效].附加x=2
      self.攻击特效[#self.攻击特效].附加y=-31
      if 名称=="三荒尽灭" then
         self.攻击特效[#self.攻击特效].附加x=0
         self.攻击特效[#self.攻击特效].附加y=30
      end
      --   if 名称=="被击中" then
      --   self.攻击特效[#self.攻击特效].加速=0.03
      --   elseif 名称=="法暴" then
      --   self.攻击特效[#self.攻击特效].加速=0.03
      --   elseif 名称=="鹰击" then
      --   self.攻击特效[#self.攻击特效].加速=0.03
      -- end
  end

end

function 战斗单位类:添加法术特效(名称,加速)-----  施法特效 除全屏特效
    local 临时音乐=引擎.取音效(名称)
      if 游戏音效>0 and 临时音乐~=nil then
    self:音效类无叠加(临时音乐.文件,临时音乐.资源,'1')
  end
  if tp==nil then return  end
  local 名称1=名称
  if 名称1=="干将莫邪" or 名称1=="断穹巨剑" or 名称1=="风舞心经" then
    if self.敌我==1 then
      名称1=名称1.."_我方"
    else
      名称1=名称1.."_敌方"
    end
    end
  if not self:无需特效(名称) then
    self.法术特效[#self.法术特效+1]=tp:载入特效(名称1,self:取txz(名称))
    self.法术特效[#self.法术特效].附加y=0
    self.法术特效[#self.法术特效].附加x=0
    if 名称=="生命之泉" or 名称=="炼气化神" then
      self.法术特效[#self.法术特效].附加y=-75
    elseif 名称=="雷击" then
      self.法术特效[#self.法术特效].附加x=2
      self.法术特效[#self.法术特效].附加y=-31
    elseif 名称=="龙腾" or 名称=="亢龙归海"
      or 名称=="法暴" or 名称=="月光" then
      self.法术特效[#self.法术特效].加速=0.04
    elseif 名称=="渡劫金身" or 名称=="诸天看护"
      or 名称=="菩提心佑" or 名称=="食指大动" then
      self.法术特效[#self.法术特效].加速=0.05
    elseif 名称=="清心咒" then
      self.法术特效[#self.法术特效].附加y=-185
      self.法术特效[#self.法术特效].附加x=-125
    elseif 名称=="保护" then
      self.法术特效[#self.法术特效].附加y=-100
    elseif 名称=="勾魂" or 名称=="摄魄" then
      self.法术特效[#self.法术特效].附加x=2
      self.法术特效[#self.法术特效].附加y=-31
    elseif 名称=="金刚护体" or 名称=="金刚护法"
      or 名称=="唧唧歪歪" or 名称=="谆谆教诲"
      or 名称=="韦陀护法" or 名称=="推拿"
      or 名称=="活血" or 名称=="推气过宫" then
      self.法术特效[#self.法术特效].附加x=2
      self.法术特效[#self.法术特效].附加y=-31
    elseif 名称=="七宝玲珑灯" then
      self.法术特效[#self.法术特效].附加y=-25
    elseif 名称=="紧箍咒" then
      self.法术特效[#self.法术特效].附加y=-self.高度/2-4
    elseif 名称=="幽冥鬼眼" or 名称=="天眼神通" or 名称=="耳目一新" or 名称=="碎星诀" or 名称=="夺命咒" or 名称=="判官令" or 名称=="雾杀" then
      self.法术特效[#self.法术特效].附加x=2
      self.法术特效[#self.法术特效].附加y=-31
    elseif 名称=="变身" or 名称=="魔王回首" or 名称=="牛劲" or 名称=="定心术" or 名称=="极度疯狂" then
      self.法术特效[#self.法术特效].附加x=2
      self.法术特效[#self.法术特效].附加y=-31
    elseif 名称=="反间之计" then
      self.法术特效[#self.法术特效].附加x=2
      self.法术特效[#self.法术特效].附加y=-31
    elseif 名称=="失魂符" or 名称=="离魂符" or 名称=="定身符" or 名称=="催眠符" or 名称=="失心符"
      or 名称=="失忆符" or 名称=="落魄符" or 名称=="追魂符" or 名称=="归元咒" or 名称=="凝神术" or 名称=="乾天罡气" then
      self.法术特效[#self.法术特效].附加x=2
      self.法术特效[#self.法术特效].附加y=-31
     elseif 名称 == "真阳令旗" then
      self.法术特效[#self.法术特效].附加x=-50
      self.法术特效[#self.法术特效].附加y=-80
    elseif 名称=="无" then
      self.法术特效[#self.法术特效].附加y=-999
    end
  end
end

function 战斗单位类:加载特效(名称)
  local txt=self:取txz(名称)
  local cp = tp:载入特效(名称,txz,不显示)
  cp:置提速(txz)
  return cp
 --return tp:载入特效(名称,self:取txz(名称))
end

function 战斗单位类:换方向(方向)

  if self.影子开关 and self.影子显示 then
        for k,v in pairs(self.影子显示) do
            if v.动画 and v.动画[self.动作] then
                v.动画[self.动作]:置方向(方向)
                v.动画[self.动作]:换帧更新()
            end
            if v.武器 and v.武器[self.动作] then
                v.武器[self.动作]:置方向(方向)
                v.武器[self.动作]:换帧更新()
            end
             if v.副武器 and v.副武器[self.动作] then
                v.副武器[self.动作]:置方向(方向)
                v.副武器[self.动作]:换帧更新()
            end
        end
  else
        self.动画:置方向(方向,self.动作)

  end
end

function 战斗单位类:取当前帧()

  if self.影子开关 and self.影子显示 and self.影子显示[1] and self.影子显示[1].动画 and self.影子显示[1].动画[self.动作] then
        return self.影子显示[1].动画[self.动作]:取当前帧()
  else
        return self.动画:取当前帧(self.动作)
  end
end



function 战斗单位类:取结束帧()
  if self.影子开关 and self.影子显示 and self.影子显示[1] and self.影子显示[1].动画 and self.影子显示[1].动画[self.动作] then
        return self.影子显示[1].动画[self.动作]:取结束帧()
  else
        return self.动画:取结束帧(self.动作)
  end
end

function 战斗单位类:取开始帧()

   if self.影子开关 and self.影子显示 and self.影子显示[1] and self.影子显示[1].动画 and self.影子显示[1].动画[self.动作] then
        return self.影子显示[1].动画[self.动作]:取开始帧()
  else
        return self.动画:取开始帧(self.动作)
  end

end






function 战斗单位类:取间隔()

     if self.影子开关 and self.影子显示 and self.影子显示[1] and self.影子显示[1].动画 and self.影子显示[1].动画[self.动作] then
        return self.影子显示[1].动画[self.动作]:取间隔()
     else
          return self.动画.动画[self.动作]:取间隔()
     end
end

function 战斗单位类:取中间()
   if self.影子开关 and self.影子显示 and self.影子显示[1] and self.影子显示[1].动画 and self.影子显示[1].动画[self.动作] then
        return self.影子显示[1].动画[self.动作]:取中间()
    else
        return self.动画.动画[self.动作]:取中间()
    end

end


function 战斗单位类:置帧率(动作,帧率)
   if self.影子开关 and self.影子显示 then
        for k,v in pairs(self.影子显示) do
            if v.动画 and v.动画[动作] then
                v.动画[动作].帧率=帧率
            end
            if v.武器 and v.武器[动作] then
                v.武器[动作].帧率=帧率
            end
             if v.副武器 and v.副武器[动作] then
                v.副武器[动作].帧率=帧率
            end
        end
    else
          self.动画:置帧率(动作,帧率)
    end
end




function 战斗单位类:状态前置(特效)
  if 特效 ~= nil then
    local cp = true
    local py={0,0}
    -- 调整偏移值
    if 特效 == "红灯" or 特效 == "蓝灯" or  特效 == "炼气化神" or 特效=="捕捉成功" then
      py = {0,-75}
    elseif 特效 == "不灭" then
      py = {0,-110}
    elseif 特效 == "断线木偶" then
      py = {0,-75}
    elseif 特效 == "无魂傀儡" then
      py = {0,-75}
    elseif 特效 == "法术防御" then
      py = {0,-30}
    elseif  特效 == "冰川怒伤" or  特效 == "冰川怒" or  特效 == "雷浪穿云" or 特效 == "诸天看护" or 特效 == "镇妖" or 特效 == "失忆符" or 特效 == "催眠符" or 特效 == "落魄符" or 特效 == "追魂符" or 特效 == "含情脉脉" or 特效 == "离魂符"  or 特效 == "失心符" or 特效 == "失魂符" or 特效 == "碎甲符" or 特效 == "一笑倾城" or 特效 == "象形" or 特效 == "似玉生香" or 特效 == "乘风破浪" or 特效 == "一苇渡江" or 特效 == "逆鳞" or 特效 == "夺魄令" or 特效 == "百万神兵" or 特效 == "护法紫丝" then
      cp = false
    elseif 特效 == "红袖添香" then
      py = {1,30}
      cp=false
    elseif 特效 == "天罗地网" or 特效 == "乾坤玄火塔" or 特效 == "苍白纸人" or 特效 == "干将莫邪" or 特效 == "莲步轻舞" or 特效 == "如花解语" or 特效 == "北冥之渊" or 特效 == "无畏布施" then
      py = {1,3}
      cp = false
    elseif 特效 == "炎护" or 特效=="魔王回首" then
      py = {2,-31}
    elseif 特效 == "定身符" then
      py = {5,2}
      cp = false
    elseif 特效 == "娉婷袅娜" then
      cp = false
    elseif 特效 == "混元伞" or 特效=="盾气"or 特效=="护盾" or 特效=="五彩娃娃" then
      if self.敌我==1 then
        cp = false
      else
        cp = true
      end
    elseif 特效=="金刚护体" then
      cp=true
    elseif 特效 == "变身" or 特效=="杀气诀" or 特效=="同舟共济" or 特效=="幻镜术" then
      py = {2,-31}
    elseif 特效 == "定心术" or 特效=="幽冥鬼眼" or 特效=="天眼神通" or 特效=="耳目一新" or 特效=="牛劲" or 特效=="极度疯狂" then
      py = {2,-31}
    elseif 特效 == "紧箍咒" then
      py = {2,-self.高度/2-4}
    elseif 特效 == "普渡众生" or 特效 == "生命之泉" or 特效 == "天神护体" or 特效 == "碎甲刃" or 特效=="爪印" or 特效=="明光宝烛" then
      py = {2,-75}
    elseif 特效 == "其疾如风" or 特效 == "披坚执锐" or 特效 == "顺势而为" or 特效 == "分身术" or 特效 == "凝神术" or 特效 == "飞花摘叶" or 特效 == "碎玉弄影" or 特效 == "其疾如风" or 特效 == "不动如山 "
      or 特效 == "侵掠如火" or 特效 == "错乱" or 特效 == "魔音摄魂" or 特效 == "落花成泥" or 特效 == "迷瘴" or 特效 == "莲心剑意"
      or 特效 == "横扫千军"  or 特效 == "轰鸣" or 特效 == "太极护法" or 特效 == "罗汉金钟" or 特效=="后发制人"  or 特效=="四面埋伏"
      or 特效=="安神诀"  or 特效=="血雨" or 特效=="威慑" or 特效=="乾坤妙法" or 特效=="破釜沉舟"  then
      cp=false
    elseif 特效 == "死亡召唤" or 特效 == "法术防御" then
      cp=false
    elseif 特效=="风灵"  or 特效=="蜜润" or 特效=="雾杀" or 特效=="剑意" then
      py = {0,-75}
    elseif 特效=="战意1" or 特效=="战意2" or  特效=="战意3" then
      py = {0,-75}
    elseif 特效=="超级战意1" or 特效=="超级战意2"then
      py = {-100,-180}
    elseif 特效=="超级战意3" then
      py = {0,-80}
    elseif 特效 == "灵药红"  then
      py = {-25,-90}
    elseif  特效 == "灵药蓝" then
      py = {-5,-90}
     elseif  特效 == "灵药黄" then
      py = {15,-90}
   elseif 特效=="符咒1" then
      py = {-10,-120}
   elseif 特效=="符咒2" then
      py = {-25,-120}
   elseif  特效=="符咒3" then
      py = {-30,-120}
   elseif  特效=="符咒4" then
      py = {-40,-120}
    elseif 特效=="符咒5" then
      py = {-50,-120}

   elseif 特效=="五行珠金"then
      py = {-12,-135}
    elseif  特效=="五行珠木"  then
      py = {3,-125}
   elseif   特效=="五行珠水" then
      py = {-2,-108}
   elseif  特效=="五行珠火" then
      py = {-21,-107}
  elseif   特效=="五行珠土" then
      py = {-27,-125}

   elseif 特效=="人参娃娃1" or 特效=="人参娃娃2" or  特效=="人参娃娃3"  then
      py = {0,-180}
   elseif 特效 == "雷法崩裂" then
     py = {-40,5}
   elseif 特效 == "雷法震煞" then
     py = {-15,5}
   elseif  特效 == "雷法坤伏" then
     py = {10,5}
   elseif  特效 == "雷法翻天" or 特效 == "雷法倒海" then
     py = {35,5}
   elseif  特效 == "神焰" then
     py = {-180,-185}
   elseif  特效 == "宁心道符" then  -----------特效坐标
     py = {0,-30}





    end
    return {cp=cp,py=py}
  end
end

function 战斗单位类:增加状态(名称,数据)
  if 名称~=nil and tp~=nil then

    if 名称=="护体灵盾" then 名称 = "护盾" end
    local 状态参数=self:状态前置(名称)
    self.状态特效[名称]=状态参数
    if 数据 then
        self.状态特效[名称].回合 = 数据.回合
        self.状态特效[名称].护盾值 = 数据.护盾值
    end
    local 名称1=名称
    if 名称1=="干将莫邪" or 名称1=="苍白纸人" or 名称1=="混元伞"  or 名称1=="五彩娃娃" or 名称1=="金刚护体" or 名称1=="盾气" or 名称1=="护盾" then
      if self.敌我==1 then
        名称1=名称1.."_我方"
      else
        名称1=名称1.."_敌方"
      end
    end
    if not self:透明状态("状态_"..名称1) and not self:无需状态特效(名称1) then
        self.状态特效[名称].动画=tp:载入特效("状态_"..名称1,self:取txz(名称))

       --  if 名称=="自矜"  then
       --  self.状态特效[名称].加速=0.03
       -- end
     end
  end
end



function 战斗单位类:取消状态(名称)


    if 名称 then
        if 名称=="护体灵盾" then 名称 = "护盾" end
        if self.状态特效[名称] then
            self.状态特效[名称].动画 = nil
            self.状态特效[名称] = nil
        else
            local 名称1 = 名称
            if 名称1=="干将莫邪" or 名称1=="苍白纸人" or 名称1=="混元伞"  or 名称1=="五彩娃娃" or 名称1=="金刚护体" or 名称1=="盾气" or 名称1=="护盾" then
              if self.敌我==1 then
                名称1=名称1.."_我方"
              else
                名称1=名称1.."_敌方"
              end
            end
            if self.状态特效[名称1] then
                self.状态特效[名称1].动画 = nil
                self.状态特效[名称1] = nil
            end
        end
        if 名称=="修罗隐身" or 名称=="楚楚可怜"  or 名称=="金刚护法" or 名称=="分身术" then
              self:取消变相()
        end
    end
end





function 战斗单位类:透明状态(效果)
  local xxg = false
  if 效果=="状态_金刚护法" or 效果=="状态_反间之计" or 效果=="状态_修罗隐身" or 效果=="状态_知己知彼" then
    xxg = true
  end
  return xxg
end

function 战斗单位类:无需状态特效(效果)
  local xxg = false
  if  效果=="蜜润" or 效果=="腾挪劲" or  效果=="碎甲术" or
      效果=="惊魂铃" or 效果=="鬼泣" or 效果=="发瘟匣"or 效果=="七宝玲珑灯" or
      效果=="破甲术" or 效果=="不灭1" or 效果=="利刃" or 效果=="流云诀" or
      效果=="啸风诀" or 效果=="魂飞魄散" or 效果=="凝滞术" or 效果=="停陷术" or
      效果=="光辉之甲" or 效果=="圣灵之甲" or 效果=="理直气壮" or 效果=="修罗隐身" or
      效果=="河东狮吼" or 效果=="放下屠刀" or 效果=="翩鸿一击" or 效果=="长驱直入" or
      效果 == "野兽之力" or 效果 == "魔兽之印" or 效果=="炽火流离"  or 效果=="催化"
      or 效果=="天眼神通" or 效果=="耳目一新" or 效果=="噬毒" or 效果=="电光火石"
      or 效果=="潜龙在渊" or 效果=="魍魉追魂" or 效果=="燃血术" or 效果=="百草诀"
      or 效果=="六道无量" or 效果=="轮回" or 效果=="风舞心经" or 效果=="青狮獠牙"
      or 效果=="冥火炼炉" or 效果=="缚仙蛛丝" or 效果=="煞魂冥灯" or 效果=="九霄龙锥"
      or 效果=="寒霜盾戟" or 效果=="静心禅珠"  or 效果=="真阳令旗" or 效果=="乾坤金卷"
      or 效果=="乾坤木卷" or 效果=="乾坤水卷" or 效果=="乾坤火卷" or 效果=="护体灵盾"
      or 效果=="惊兽云尺"  or 效果=="锢魂命谱" or 效果=="战神宝典"or 效果=="定神仙琴"
      or 效果=="炎魂"

      then
    xxg = true
  end
  return xxg
end

function 战斗单位类:无需特效(效果)
  local xxg = false
  if    效果=="法术防御" or 效果=="死亡召唤" or 效果=="炽火流离" then
    xxg = true
  end
  return xxg
end

function 战斗单位类:换动作(动作,复原,更新)

      self.攻击偏移={x=0,y=0}
      if self.动作 == "挨打" and 动作 == "挨打" and 复原 == nil then
        return
      end
      local 临时模型=self.模型
      if self.数据.变身数据 ~= nil then
        临时模型=self.数据.变身数据
      end
      if 动作=="暴击" or 动作=="攻击" then
          self.攻击帧,self.攻击延迟,self.终极帧 = 取攻击帧(临时模型,self.武器子类)
      elseif 动作=="待战" or 复原 then
            self.是否显示 = true
      end
      self.动作=动作
      self.动作复原=复原
      self.停止更新=更新
      self:换方向(self.方向)
      if (self.数据.类型=="角色" or self.数据.类型=="系统角色" or self.数据.类型=="系统PK角色") and self.是否变身~=true and self.数据.变身数据==nil then
        if self.数据.武器~=nil and tp~=nil then
          if self.数据.武器.名称 == "龙鸣寒水" or self.数据.武器.名称 == "非攻" then
            local wq = "弓弩1"
            临时模型=临时模型.."_"..wq
          else
            local wq = tp:取武器子类(self.数据.武器.子类)
            临时模型=临时模型.."_"..wq
          end
        end
      end
      if 动作=="暴击" then
         动作=取无修改音效(临时模型)
      end
      local 临时音乐=引擎.取音效(临时模型)
      if 游戏音效>0 and 临时音乐~=nil and 临时音乐[动作]~=nil and 动作~="挨打" and 动作~="死亡" then
        self:音效类(临时音乐[动作],临时音乐.资源,动作)
      end
end


function 取无修改音效(模型)
  if 模型=="超级泡泡" or 模型=="超级玉兔" or 模型=="超级海豚" or 模型=="超级灵狐" or 模型=="超级神兔" or 模型=="蚩尤" or 模型=="进阶蚩尤"
    or 模型=="小毛头" or 模型=="小仙灵" or 模型=="进阶小毛头" or 模型=="进阶小仙灵" then
    return "暴击"
  else
    return "攻击"
  end
end


function 战斗单位类:音效类(文件号,资源包,子类)
  if 文件号 ~= nil and 文件号 ~= 0 and  游戏音效>0 and tp~=nil and tp.音效开启 then
    --储存音效进一个变量 好做退出战斗时候 停止操作
    tp.战斗音效序列[#tp.战斗音效序列+1]=FSB(tp.资源:读数据(资源包,文件号))
    tp.战斗音效序列[#tp.战斗音效序列]:播放(false):置音量(游戏音效)
  end
end

function 战斗单位类:音效类无叠加(文件号,资源包,子类)
  if 文件号 ~= nil and 文件号 ~= 0 and  游戏音效>0 and tp~=nil and tp.音效开启 and (not tp.战斗音效序列[文件号] or not tp.战斗音效序列[文件号]:是否播放()) then
    tp.战斗音效序列[文件号]=FSB(tp.资源:读数据(资源包,文件号))
    tp.战斗音效序列[文件号]:播放(false):置音量(游戏音效)

  end
end

function 战斗单位类:设置弓弩(xy,方向)
  self.弓弩动画=tp:载入特效("远程攻击",self:取txz("远程攻击"))
  self.弓弩xy={x=xy.x,y=xy.y}
  self.弓弩动画:置方向(方向)
  self.弓弩开关=true
end


function 战斗单位类:设置飞镖(xy,方向,伤害,死亡)
  self.飞镖数据={x=xy.x,y=xy.y,伤害=伤害,死亡=死亡}
  self.飞镖动画=tp:载入特效("飞镖",self:取txz("飞镖"))
  self.飞镖动画:置颜色(ARGB(255,255,255,250))
  self.飞镖xy={x=xy.x,y=xy.y}
  self.飞镖动画:置方向(方向)
  self.飞镖开关=true
end





function 战斗单位类:开启击退(死亡)

    self.击退开关=true
    self.偏移类型=1
    self.停止偏移=40
    self.死亡参数=死亡
    self.击退坐标={}
    self.击退坐标.x,self.击退坐标.y=self.显示xy.x,self.显示xy.y
    if self.敌我==2 then
        self.偏移坐标=-1
        if self.死亡参数~=0 then
            self.偏移坐标=-0.6
        end
    else
        self.偏移坐标=1
        if self.死亡参数~=0 then
          self.偏移坐标=0.6
        end
    end
end

function 战斗单位类:击退处理()
        if self.偏移类型==1 then
            self.显示xy.x,self.显示xy.y=self.显示xy.x+self.偏移坐标,self.显示xy.y+self.偏移坐标
            if(取两点距离(生成XY(self.击退坐标.x,self.击退坐标.y),生成XY(self.显示xy.x,self.显示xy.y))>self.停止偏移)then
                self.偏移类型=2
                if self.死亡参数==1  then
                    self:死亡处理()
                    self.显示xy.x,self.显示xy.y=self.击退坐标.x,self.击退坐标.y
                    self.偏移类型=0
                    self.击退开关=false
                    self.偏移类型=0
                else
                    if self.敌我==2 then
                        self.偏移坐标=-1
                        if self.死亡参数~=0 then
                          self.偏移坐标=-2.5
                        end
                    else
                        self.偏移坐标=1
                        if self.死亡参数~=0 then
                          self.偏移坐标=2.5
                        end
                    end
                    self.偏移类型=2
                end
            end
        elseif self.偏移类型==2 then
                self.显示xy.x,self.显示xy.y=self.显示xy.x-self.偏移坐标,self.显示xy.y-self.偏移坐标
                if(取两点距离(生成XY(self.击退坐标.x,self.击退坐标.y),生成XY(self.显示xy.x,self.显示xy.y))<=10)then
                    self.显示xy.x,self.显示xy.y=self.击退坐标.x,self.击退坐标.y
                    self.偏移类型=0
                    self.击退开关=false
                    self.动画.按帧更新=false
                    self.显示xy.x,self.显示xy.y=self.击退坐标.x,self.击退坐标.y
                    if self.死亡参数==2  then
                        self:死亡处理()
                    else
                        self.动作="待战"
                        self:换动作(self.动作,nil,nil)
                    end
                end
        end
end






function 战斗单位类:设置死亡(死亡)
  self.死亡参数=死亡
  self:死亡处理()
end



function 战斗单位类:死亡处理()
  self:置帧率(self.动作,0.11)
  self.击退开关=false
  if self.死亡参数==1 then
      self.击飞开关=true
      self.击飞数据={}
      self.击飞方向=0
      self.击飞流程=1
      self.击飞时间=os.clock()

      if self.敌我==2 then
          self.击飞数据[1]={x=20,y=3,终止=全局游戏高度+100}
          self.击飞数据[2]={x=20,y=1,终止=全局游戏宽度+100}
      else
          self.击飞数据[1]={x=-20,y=-3,终止=全局游戏高度+100}
          self.击飞数据[2]={x=-20,y=-1,终止=全局游戏宽度+100}
      end
      local 临时音乐=引擎.取音效("击飞")
      if 游戏音效>0 and 临时音乐~=nil then
          self:音效类无叠加(临时音乐.文件,临时音乐.资源,'1')
      end
  elseif self.死亡参数==2 then
      self.动作="死亡"
      --self:播放音效("倒地")
      local 临时模型=self.数据.模型
      local 临时音乐=引擎.取音效(临时模型)
      if 游戏音效>0 and 临时音乐~=nil and 临时音乐[self.动作]~=nil then
        self:音效类(临时音乐[self.动作],临时音乐.资源,self.动作)
      end
      self:换方向(self.方向)
      self.倒地开关=true
      self.停止更新=true
  end
end


function 战斗单位类:击飞处理()

    if self.击飞流程==1 then
        self.显示xy.x,self.显示xy.y=self.显示xy.x-self.击飞数据[self.击飞流程].x,self.显示xy.y-self.击飞数据[self.击飞流程].y
        if os.clock() - self.击飞时间>=0.005 then
          self.方向=self.方向-1
          if self.方向<0 then self.方向=3 end
          self.击飞时间=os.clock()
          self:换方向(self.方向)
        end
        if(取两点距离(生成XY(self.初始xy.x,self.初始xy.y),生成XY(self.显示xy.x,self.显示xy.y))>全局游戏高度-100)then
          self.击飞流程=2
        end
  elseif self.击飞流程==2 then
          self.显示xy.x,self.显示xy.y=self.显示xy.x+self.击飞数据[self.击飞流程].x,self.显示xy.y+self.击飞数据[self.击飞流程].y
          if os.clock()-self.击飞时间>=0.005 then
            self.方向=self.方向-1
            if self.方向<0 then self.方向=3 end
            self.击飞时间=os.clock()
            self:换方向(self.方向)
          end
          if(取两点距离(生成XY(self.初始xy.x,self.初始xy.y),生成XY(self.显示xy.x,self.显示xy.y))>1100)then
              self.击飞流程=0
              self.击飞开关=false
              self.是否显示=false
          end
  end
end




function 战斗单位类:返回事件()
  -- print(取两点距离(生成XY(self.显示xy.x,self.显示xy.y),生成XY(self.移动坐标.x,self.移动坐标.y)))
  if not self.移动速度 then
       self.移动速度=12
  end

  if 取两点距离(生成XY(self.显示xy.x,self.显示xy.y),生成XY(self.移动坐标.x,self.移动坐标.y))>=self.移动速度 then
    --local Speed=12
      self.移动距离=取移动坐标(生成XY(self.显示xy.x,self.显示xy.y),生成XY(self.移动坐标.x,self.移动坐标.y),self.移动速度)
      if self.动作~="返回" then
          self:换动作("返回")
          self.角度=取两点角度(生成XY(self.显示xy.x,self.显示xy.y),生成XY(self.移动距离.x,self.移动距离.y))
          self:换方向(角度算四方向(self.角度))
      end
      self.显示xy.x,self.显示xy.y=self.移动距离.x,self.移动距离.y
  else
      self:置帧率("攻击",0.11)
      self:置帧率("暴击",0.11)
      self.返回开关=false
      self.击退开关=false
      self:换动作("待战")
      self:换方向(self.初始方向)
      self.显示xy.x,self.显示xy.y=self.初始xy.x,self.初始xy.y
  end
end

function 战斗单位类:移动事件()

    if 取两点距离(生成XY(self.显示xy.x,self.显示xy.y),生成XY(self.移动坐标.x,self.移动坐标.y))>=self.移动速度 then
      --local Speed=12
        self.移动距离=取移动坐标(生成XY(self.显示xy.x,self.显示xy.y),生成XY(self.移动坐标.x,self.移动坐标.y),self.移动速度)
        if self.动作~="跑去" then
          self:换动作("跑去")
          self.角度=取两点角度(生成XY(self.显示xy.x,self.显示xy.y),生成XY(self.移动距离.x,self.移动距离.y))
          self.方向=角度算四方向(self.角度)
          self.动画:置方向(角度算四方向(self.角度),self.动作)
        end
        self.显示xy.x,self.显示xy.y=self.移动距离.x,self.移动距离.y
    else
        self.角度=取两点角度(生成XY(self.显示xy.x,self.显示xy.y),生成XY(self.移动坐标.x,self.移动坐标.y))
        self.方向=角度算四方向(self.角度)
        self.动画:置方向(角度算四方向(self.角度),self.动作)
        self.移动开关=false
    end
end



function 战斗单位类:开启躲避()
  self.躲避类型=1
  self.停止躲避=75
  self.躲避开关=true
  self.躲避数量=0
  self.躲避xy={}
  self.躲避xy.x,self.躲避xy.y=self.显示xy.x,self.显示xy.y
end

function 战斗单位类:躲避事件()
  if self.躲避类型==1 then
    self.显示xy.x,self.显示xy.y=self.显示xy.x+self.躲避坐标,self.显示xy.y+self.躲避坐标
    self.躲避数量=math.floor(取两点距离(生成XY(self.初始xy.x,self.初始xy.y),生成XY(self.显示xy.x,self.显示xy.y))/15)
    if(取两点距离(生成XY(self.初始xy.x,self.初始xy.y),生成XY(self.显示xy.x,self.显示xy.y))>=self.停止躲避)then
      self.躲避类型=2
    end
  elseif self.躲避类型==2 then
    self.显示xy.x,self.显示xy.y=self.显示xy.x-self.躲避坐标,self.显示xy.y-self.躲避坐标
    self.躲避数量=math.floor(取两点距离(生成XY(self.初始xy.x,self.初始xy.y),生成XY(self.显示xy.x,self.显示xy.y))/15)
    if(取两点距离(生成XY(self.初始xy.x,self.初始xy.y),生成XY(self.显示xy.x,self.显示xy.y))<=5)then
      self.显示xy.x,self.显示xy.y=self.初始xy.x,self.初始xy.y
      self.躲避类型=0
      self.躲避开关=false
      self.掉血开关=false
      self.击退开关=false
    end
  end
  self:躲避处理()
end

function 战斗单位类:躲避处理()
  for n=1,self.躲避数量 do
    self.动画:显示(self.躲避xy.x+self.躲避参数*n,self.躲避xy.y+self.躲避参数*n,self.动作)
  end
end

function 战斗单位类:是否选中(x,y)
  return self.动画.动画[self.动作]:是否选中(x,y)
end

function 战斗单位类:置高亮()
  self.动画.动画[self.动作]:置高亮()
  if self.动画.武器~=nil and self.动画.武器[self.动作]~=nil then
    self.动画.武器[self.动作]:置高亮()
  end
  self.名称颜色=红色
end

function 战斗单位类:取消高亮()
  self.动画.动画[self.动作]:取消高亮()
  if self.动画.武器~=nil and self.动画.武器[self.动作]~=nil  then
    self.动画.武器[self.动作]:取消高亮()
  end
  self.名称颜色=0xFF70FC70
end

function 战斗单位类:取状态()
    if not self.是否显示 then return true  end
    if self.移动开关 or self.击退开关 or self.倒地开关 or self.返回开关
        or self.躲避开关 or self.飞镖开关 or self.弓弩开关 or self.掉血开关
        or self.影子返回 or self.影子移动  then --or self.击飞开关
        return false
    else
        return true
    end
end




--执行流程结束也要判断法术特效是否结束
function 战斗单位类:取法术状态()
  if #self.法术特效 > 0 then
    return false
  else
    return true
  end
end

function 战斗单位类:法术抖动()
        if self.法术开关 then
              self:法术延时()
              self.抖动偏移=self.抖动偏移 or 生成XY(0,0)
              if self.抖动延时 then
                  if self.抖动延时<0 then
                      if self.法术计时%3 == 0 then--抖动频率
                          if self.抖动偏移 and self.抖动偏移.x==0 and self.抖动偏移.y==0 then
                              if self.击退角度 == nil then
                                 self.抖动偏移=生成XY(-2,-2)
                              else
                                  self.抖动偏移=弧度算挨打偏移坐标(self.击退角度,2)
                              end
                          else
                              self.抖动偏移=生成XY(0,0)
                          end
                          self.法术坐标 = {x = self.抖动偏移.x,y = self.抖动偏移.y}--抖动坐标范围
                      end
                      self.法术计时 = self.法术计时 + 1
                  else
                      self.抖动延时 = self.抖动延时 - 1
                  end
              end
        end
end

function 战斗单位类:开始抖动()
          self.法术开关=true

end

function 战斗单位类:停止抖动()
  self.法术开关=false
  self.方向=self.初始方向
end



function 战斗单位类:更新(dt)
  if self.鼠标跟随 then
    self.显示xy.x,self.显示xy.y=鼠标.x,鼠标.y
  end
  if self.显示xy==nil then
    self.显示xy={}
    self.显示xy.x,self.显示xy.y=鼠标.x,鼠标.y
  end
  self.x,self.y=self.显示xy.x,self.显示xy.y

  if not self.抖动数据 or not self.抖动数据.开关
    or not self.抖动数据.x or not self.抖动数据.y then
      self.抖动数据 = {开关=false,进程=0,x=0,y=0}
  end
  if not self.法术坐标 or not self.法术坐标.x or not self.法术坐标.y then
       self.法术坐标 = {x=0,y=0}
  end

  if self.动作=="待战" or self.动作=="倒地" then
      if self.状态特效.疯狂 or self.状态特效.反间之计 or self.状态特效.错乱 or self.状态特效.落魄符 or self.状态特效.发瘟匣 then
          if self.抖动数据.开关==false then
                self.抖动数据.开关=true
                self.抖动数据.进程=1
                self.抖动数据.x,self.抖动数据.y=-0.2,-0.2
          else
              self.抖动数据.进程=self.抖动数据.进程+1
              if self.抖动数据.进程<=5 then
                  self.抖动数据.x,self.抖动数据.y=self.抖动数据.进程-self.抖动数据.进程*2,self.抖动数据.进程-self.抖动数据.进程*2
              else
                  self.抖动数据.x,self.抖动数据.y=self.抖动数据.x+0.2,self.抖动数据.y+0.2
                  if self.抖动数据.进程>=12 then
                    self.抖动数据.进程=0
                  end
              end
          end
      elseif self.抖动数据.开关 then
            self.抖动数据.进程=0
            self.抖动数据.x,self.抖动数据.y=0,0
            self.抖动数据.开关=false
      end
  end
   if self.停止更新 and self:取当前帧()>=self:取结束帧() then
      if self.动作=="死亡" and self.倒地开关 then
          self.倒地开关=false
          self.停止更新=true
      end
  else
      if self.影子开关 and self.影子显示 then
            for k,v in pairs(self.影子显示) do
                if v.动画 and v.动画[self.动作] then
                    v.动画[self.动作]:更新(dt)
                end
                if v.武器 and v.武器[self.动作] then
                    v.武器[self.动作]:更新(dt)
                end
                 if v.副武器 and v.副武器[self.动作] then
                    v.副武器[self.动作]:更新(dt)
                end
            end
      end
      self.动画:更新(dt,self.动作)
  end
  if self.法术开关 then
      self:法术抖动()
  else
      self.法术计时 = 0
      self.抖动延时 = nil
      self.受击名称 = nil
      self.法术坐标 = {x =0,y =0}
  end

  if self.移动开关 then
      self:移动事件()
  end



  if self.击退开关 then
     self:击退处理()
  -- else
  --   self.方向=self.初始方向+0
  end
  if self.影子移动 then
      self:影子移动处理()
  end
  if self.影子返回 then
      self:影子返回事件()
  end


  if self.弓弩开关 then
    self.弓弩动画:更新(dt)
    self.弓弩xy=取移动坐标(self.弓弩xy,self.显示xy,15)  --这个10 是速度  越大就越快
    if 取两点距离(self.弓弩xy,self.显示xy)<=20 then
      -- self:换动作("挨打",nil,true)
      self.弓弩开关=false
      self.弓弩动画=nil
    end
  end
  if self.飞镖开关 then
    self.飞镖动画:更新(dt)
    self.飞镖xy=取移动坐标(self.飞镖xy,self.显示xy,12)
    self.飞镖动画:显示(self.飞镖xy.x,self.飞镖xy.y)
    if 取两点距离(self.飞镖xy,self.显示xy)<=20 then
      self:设置掉血(self.飞镖数据.伤害,1)
      self:换动作("挨打")
      self:开启击退(self.飞镖数据.死亡)
      self.飞镖开关=nil
      self.飞镖动画=nil
    end
  end

  if self.返回开关 then self:返回事件() end
  if self.击飞开关 then self:击飞处理() end
  if self.躲避开关 then self:躲避事件() end
  if self.动作复原 and  self:取当前帧()==self:取结束帧() then
      self:换动作("待战")

  end

  if self.抓捕开关 then
        if self.捕捉暂停~=nil and 时间-self.捕捉暂停>=2 then
            self.捕捉暂停=nil
            self.抓捕动画:置方向(0)
            if self.抓捕成功 then
                战斗类.战斗单位[self.抓捕编号]:设置抓捕路径({x=self.显示xy.x,y=self.显示xy.y},self.抓捕成功)
                战斗类.战斗单位[self.抓捕编号]:增加状态("捕捉成功")
            end
        end
        self.抓捕动画:更新(dt)
        if self.抓捕流程==1 then
            self.抓捕xy=取移动坐标(self.抓捕xy,self.抓捕目标,3)
            if 取两点距离(self.抓捕xy,self.抓捕目标)<=40 then
                战斗类.战斗单位[self.抓捕编号]:添加攻击特效("捕捉开始")
                self.抓捕流程=2
                self.捕捉暂停=时间
            end
        elseif self.抓捕流程==2 and self.捕捉暂停==nil then
              self.抓捕xy=取移动坐标(self.抓捕xy,生成XY(self.显示xy.x,self.显示xy.y),3)
              if 取两点距离(self.抓捕xy,self.显示xy)<=10 then
                  self.抓捕动画=nil
                  self.抓捕开关=false
                  if self.抓捕成功 then
                      tp.常规提示:打开("#Y/你成功捕获了#R/"..self.抓捕单位)
                  end
              end
        end
  end
  if self.抓捕移动~=nil then
        self.显示xy=取移动坐标(self.显示xy,self.抓捕移动,3)
        if 取两点距离(self.抓捕移动,self.显示xy)<=30 then
          self.是否显示=false
          self.显示xy.x,self.显示xy.y=1500,1500
          self.抓捕移动=nil
        end
  end






end


function 战斗单位类:关闭影子()
        self.影子开关=false
        self.影子数量=0
        for k,v in pairs(self.影子显示) do
            v.显示=false
            v.移动开关=true
            v.方向=self.初始方向
            v.动作=nil
            local 显示表={"待战","跑去","攻击","暴击","挨打","返回"}
            for z,n in pairs(显示表) do
                  if v.动画 and v.动画[n] then
                      v.动画[n]:置方向(self.初始方向)
                  end
                  if v.武器 and v.武器[n] then
                      v.武器[n]:置方向(self.初始方向)
                  end
                  if v.副武器 and v.副武器[n] then
                      v.副武器[n]:置方向(self.初始方向)
                  end
            end
        end
end




function 战斗单位类:开启影子(数量)
        self.影子开关=true
        self.影子数量=数量 or 0
end

function 战斗单位类:影子移动处理()
          if self.影子开关 and self.影子显示 and self.影子数量 and  self.影子数量>0 then
              if self.动作~="跑去" then
                  self:换动作("跑去")
              end
              for k,v in pairs(self.影子显示) do
                  if v.显示 then
                      if 取两点距离(生成XY(v.显示xy.x,v.显示xy.y),生成XY(v.移动坐标.x,v.移动坐标.y))>=v.移动速度  then
                            self.影子移动=true
                           local 移动距离=取移动坐标(生成XY(v.显示xy.x,v.显示xy.y),生成XY(v.移动坐标.x,v.移动坐标.y),v.移动速度)
                            if not v.动作 or v.动作~="跑去" then
                                v.动作="跑去"
                                local 角度=取两点角度(生成XY(v.显示xy.x,v.显示xy.y),生成XY(移动距离.x,移动距离.y))
                                if v.动画 and v.动画[v.动作] then
                                    v.动画[v.动作]:置方向(角度算四方向(角度))
                                end
                                if v.武器 and v.武器[v.动作] then
                                    v.武器[v.动作]:置方向(角度算四方向(角度))
                                end
                                if v.副武器 and v.副武器[v.动作] then
                                    v.副武器[v.动作]:置方向(角度算四方向(角度))
                                end
                            end
                            v.显示xy.x,v.显示xy.y=移动距离.x,移动距离.y
                      else
                           local 角度=取两点角度(生成XY(v.显示xy.x,v.显示xy.y),生成XY(v.移动坐标.x,v.移动坐标.y))
                            v.动作="待战"
                            if v.动画 and v.动画[v.动作] then
                                v.动画[v.动作]:置方向(角度算四方向(角度))
                            end
                            if v.武器 and v.武器[v.动作] then
                                 v.武器[v.动作]:置方向(角度算四方向(角度))
                            end
                            if v.副武器 and v.副武器[v.动作] then
                                v.副武器[v.动作]:置方向(角度算四方向(角度))
                            end

                           v.移动开关=false
                      end
                  end
              end
              local 数量=0
              for k,v in pairs(self.影子显示) do
                  if not v.移动开关 and v.动作=="待战" then
                      数量=数量+1
                  end
              end
              if 数量==self.影子数量 then
                  if self.动作~="待战" then
                      self:换动作("待战")
                  end
                   self.影子移动=false
              end

          else
              self.影子移动=false

          end
end
function 战斗单位类:影子返回事件()
        if self.影子开关 and self.影子显示 and self.影子数量 and  self.影子数量>0 then
                if self.动作~="返回" then
                    self:换动作("返回")
                end
                for k,v in pairs(self.影子显示) do
                    if v.显示 then
                        if not v.移动速度 then
                            v.移动速度=12
                        end
                        if 取两点距离(生成XY(v.显示xy.x,v.显示xy.y),生成XY(self.初始xy.x,self.初始xy.y))>=v.移动速度 then
                            v.开始返回=true
                            local 移动距离=取移动坐标(生成XY(v.显示xy.x,v.显示xy.y),生成XY(self.初始xy.x,self.初始xy.y),v.移动速度)
                            if v.动作~="返回" then
                                  v.动作="返回"
                                  local 角度=取两点角度(生成XY(v.显示xy.x,v.显示xy.y),生成XY(移动距离.x,移动距离.y))
                                  if v.动画 and v.动画[v.动作] then
                                      v.动画[v.动作]:置方向(角度算四方向(角度))
                                  end
                                  if v.武器 and v.武器[v.动作] then
                                        v.武器[v.动作]:置方向(角度算四方向(角度))
                                  end
                                  if v.副武器 and v.副武器[v.动作] then
                                        v.副武器[v.动作]:置方向(角度算四方向(角度))
                                  end
                            end
                            v.显示xy.x,v.显示xy.y=移动距离.x,移动距离.y
                        else
                                v.动作="待战"
                                if v.动画 and v.动画[v.动作] then
                                        v.动画[v.动作]:置方向(self.初始方向)
                                end
                                if v.武器 and v.武器[v.动作] then
                                        v.武器[v.动作]:置方向(self.初始方向)
                                end
                                if v.副武器 and v.副武器[v.动作] then
                                        v.副武器[v.动作]:置方向(self.初始方向)
                                end
                                v.开始返回=false
                                v.显示xy.x,v.显示xy.y=self.初始xy.x,self.初始xy.y
                        end
                    end
                end
                local 数量=0
                for k,v in pairs(self.影子显示) do
                      if not v.开始返回 and v.动作=="待战" then
                          数量=数量+1
                      end
                end
                if 数量==self.影子数量 then
                    if self.动作~="待战" then
                          self:换动作("待战")
                    end
                      self.影子返回=false
                      self.击退开关=false
                end
      else
                self.影子返回=false
                self.击退开关=false
      end
end







function 战斗单位类:设置影子动画(移动表,编号)
          if not self.影子显示 then self.影子显示={} end
          if not self.影子显示[编号] then
              self.影子显示[编号]={}
              self.影子显示[编号].动画={}
              local 模型=self.数据.模型
              if self.变身数据~=nil  then
                  模型=self.变身数据
              end
              local 资源 = 引擎.取战斗模型(模型)
              if  (self.类型=="角色" or self.类型=="系统角色" or self.类型=="系统PK角色") and not self.是否变身 and not self.变身数据  then
                    local 显示武器 = false
                    local m
                    if self.武器 ~= nil and self.武器.名称~=nil then
                        if self.武器.名称 == "龙鸣寒水" or self.武器.名称 == "非攻" then
                          m = "弓弩1"
                        else
                          m = tp:取武器子类(self.武器.子类)
                        end
                        资源 = 引擎.取战斗模型(模型,m)
                    end
                    self.影子显示[编号].动画.待战 = tp.资源:载入(资源[10],"网易WDF动画",资源[6])
                    self.影子显示[编号].动画.跑去 = tp.资源:载入(资源[10],"网易WDF动画",资源[8])
                    self.影子显示[编号].动画.攻击 = tp.资源:载入(资源[10],"网易WDF动画",资源[1])
                    self.影子显示[编号].动画.暴击 = tp.资源:载入(资源[10],"网易WDF动画",资源[1])
                    self.影子显示[编号].动画.挨打 = tp.资源:载入(资源[10],"网易WDF动画",资源[9])
                    self.影子显示[编号].动画.返回 = tp.资源:载入(资源[10],"网易WDF动画",资源[8])

                    if self.锦衣数据 ~= nil and self.锦衣数据[1]~= nil and self.锦衣数据[1].名称 ~= nil and 屏蔽锦衣效果==false then
                        if self.锦衣数据[1].战斗锦衣 then
                            资源 = 引擎.取战斗锦衣素材(self.锦衣数据[1].名称,模型)
                            self.影子显示[编号].动画.待战 = tp.资源:载入(资源[5],"网易WDF动画",资源[3])
                            self.影子显示[编号].动画.跑去 = tp.资源:载入(资源[5],"网易WDF动画",资源[4])
                            self.影子显示[编号].动画.返回 = tp.资源:载入(资源[5],"网易WDF动画",资源[4])
                            self.影子显示[编号].动画.攻击 = tp.资源:载入(资源[5],"网易WDF动画",资源[1])
                            self.影子显示[编号].动画.暴击 = tp.资源:载入(资源[5],"网易WDF动画",资源[1])
                            self.影子显示[编号].动画.挨打 = tp.资源:载入(资源[5],"网易WDF动画",资源[3])
                            显示武器 = true
                        else
                              if 新加战斗锦衣[self.锦衣数据[1].名称]~=nil  then
                                 local 类型 = 取角色锦衣武器类型(模型,m)
                                 资源 = 引擎.取武器锦衣素材(self.锦衣数据[1].名称,模型,类型)
                                 self.影子显示[编号].动画.待战 = tp.资源:载入(资源[5],"网易WDF动画",资源[3])
                                 self.影子显示[编号].动画.跑去 = tp.资源:载入(资源[5],"网易WDF动画",资源[4])
                                 self.影子显示[编号].动画.返回 = tp.资源:载入(资源[5],"网易WDF动画",资源[4])
                                 self.影子显示[编号].动画.攻击 = tp.资源:载入(资源[5],"网易WDF动画",资源[1])
                                 self.影子显示[编号].动画.暴击 = tp.资源:载入(资源[5],"网易WDF动画",资源[1])
                                 self.影子显示[编号].动画.挨打 = tp.资源:载入(资源[5],"网易WDF动画",资源[3])
                                 显示武器 = false
                              end
                        end
                    end
                    if self.武器 ~= nil and self.武器.名称~=nil then
                          self.影子显示[编号].武器={}
                          local m1 = tp:取武器附加名称(self.武器.子类,self.武器.级别限制,self.武器.名称)
                          资源 = 引擎.取战斗模型(m1.."_"..模型)
                          if 资源[10] ~= nil then
                              self.影子显示[编号].武器.待战 = tp.资源:载入(资源[10],"网易WDF动画",资源[6])
                              self.影子显示[编号].武器.跑去 = tp.资源:载入(资源[10],"网易WDF动画",资源[8])
                              self.影子显示[编号].武器.攻击 = tp.资源:载入(资源[10],"网易WDF动画",资源[1])
                              self.影子显示[编号].武器.暴击 = tp.资源:载入(资源[10],"网易WDF动画",资源[2])
                              self.影子显示[编号].武器.挨打 = tp.资源:载入(资源[10],"网易WDF动画",资源[9])
                              self.影子显示[编号].武器.返回 = tp.资源:载入(资源[10],"网易WDF动画",资源[8])

                          end
                    end
                    if self.副武器~=nil and self.副武器.名称 then
                       self.影子显示[编号].副武器={}
                        资源 = 引擎.取战斗模型(self.副武器.名称.."_"..模型)
                        if 资源[10] ~= nil then
                            self.影子显示[编号].副武器.待战 = tp.资源:载入(资源[10],"网易WDF动画",资源[6])
                            self.影子显示[编号].副武器.跑去 = tp.资源:载入(资源[10],"网易WDF动画",资源[8])
                            self.影子显示[编号].副武器.攻击 = tp.资源:载入(资源[10],"网易WDF动画",资源[1])
                            self.影子显示[编号].副武器.暴击 = tp.资源:载入(资源[10],"网易WDF动画",资源[2])
                            self.影子显示[编号].副武器.挨打 = tp.资源:载入(资源[10],"网易WDF动画",资源[9])
                            self.影子显示[编号].副武器.返回 = tp.资源:载入(资源[10],"网易WDF动画",资源[8])
                        end
                    end
                    if 显示武器 then
                        self.影子显示[编号].武器 = nil
                        self.影子显示[编号].副武器 = nil
                    end
              else
                      self.影子显示[编号].动画.待战 = tp.资源:载入(资源[10],"网易WDF动画",资源[6])
                      self.影子显示[编号].动画.跑去 = tp.资源:载入(资源[10],"网易WDF动画",资源[8])
                      self.影子显示[编号].动画.攻击 = tp.资源:载入(资源[10],"网易WDF动画",资源[1])
                      self.影子显示[编号].动画.暴击 = tp.资源:载入(资源[10],"网易WDF动画",资源[1])
                      self.影子显示[编号].动画.返回 = tp.资源:载入(资源[10],"网易WDF动画",资源[8])
                      self.影子显示[编号].动画.挨打 = tp.资源:载入(资源[10],"网易WDF动画",资源[9])
                      if self.显示饰品~=nil  then
                        self.影子显示[编号].武器={}
                         资源 = 引擎.取战斗模型(模型.."_饰品")  ---这里显示宠物饰品的
                          if 资源[10] ~= nil then
                              self.影子显示[编号].武器.待战 = tp.资源:载入(资源[10],"网易WDF动画",资源[6])
                              self.影子显示[编号].武器.跑去 = tp.资源:载入(资源[10],"网易WDF动画",资源[8])
                              self.影子显示[编号].武器.攻击 = tp.资源:载入(资源[10],"网易WDF动画",资源[1])
                              self.影子显示[编号].武器.暴击 = tp.资源:载入(资源[10],"网易WDF动画",资源[2])
                              self.影子显示[编号].武器.返回 = tp.资源:载入(资源[10],"网易WDF动画",资源[8])
                              self.影子显示[编号].武器.挨打 = tp.资源:载入(资源[10],"网易WDF动画",资源[9])
                          end
                      end
              end
          end
          local 显示表={"待战","跑去","攻击","暴击","挨打","返回"}
          for k,v in pairs(显示表) do
              if self.影子显示[编号].动画 and self.影子显示[编号].动画[v] then
                  self.影子显示[编号].动画[v]:置方向(self.方向)
                     --self.影子显示[编号].动画[v]:置颜色(0xFFFF0000)
                     self.影子显示[编号].动画[v]:置颜色(ARGB(100,255,80,255))

              end
              if self.影子显示[编号].武器 and self.影子显示[编号].武器[v] then
                  self.影子显示[编号].武器[v]:置方向(self.方向)
                  --self.影子显示[编号].武器[v]:置染色(66,1,0,0,150)
                  self.影子显示[编号].武器[v]:置颜色(ARGB(100,255,80,255))
              end
              if self.影子显示[编号].副武器 and self.影子显示[编号].副武器[v] then
                  self.影子显示[编号].副武器[v]:置方向(self.方向)
                  --self.影子显示[编号].副武器[v]:置染色(66,1,0,0,150)
                  self.影子显示[编号].副武器[v]:置颜色(ARGB(100,255,80,255))
              end
          end



          self.影子显示[编号].显示=true
          self.影子显示[编号].显示xy={x=self.显示xy.x,y=self.显示xy.y}
          self.影子显示[编号].移动坐标=移动表.移动坐标
          self.影子显示[编号].移动速度=移动表.移动速度
          self.影子显示[编号].移动开关=true
          self.影子显示[编号].方向=self.方向
          self.影子显示[编号].时间= os.time()
end







function 战斗单位类:设置抓捕路径(目标,成功)
     self:换动作("跑去")
     self.抓捕移动=目标
end

function 战斗单位类:设置抓捕动画(目标,模型,成功,名称,目标名称)
        self.抓捕资源=引擎.取模型(模型)
        self.抓捕动画=tp.资源:载入(self.抓捕资源[3],"网易WDF动画",self.抓捕资源[2])
        self.抓捕动画:置方向(2)
        self.抓捕动画:取消高亮()
        self.抓捕流程=1
        self.抓捕成功=成功
        self.抓捕目标={x=战斗类.战斗单位[目标].显示xy.x,y=战斗类.战斗单位[目标].显示xy.y}
        self.抓捕xy={x=self.显示xy.x,y=self.显示xy.y}
        self.抓捕开关=true
        self.抓捕编号=目标
        self.抓捕名称=名称
        self.抓捕单位=目标名称
end

function 战斗单位类:取消变相(dt,x,y)
  self.动画.动画["待战"]:取消高亮()
  --self.动画.动画[self.动作]:置颜色()
  if self.动画.武器~= nil and self.动画.武器["待战"]~= nil then
    self.动画.武器["待战"]:取消高亮()
    --self.动画.武器[self.动作]:置颜色()
  end
end

function 战斗单位类:显示(dt,x,y)

  if not self.是否显示 then return  end
  for i, v in pairs(self.状态特效) do
    if type(v)=="table" then
      --if v.cp then
        if v.cp==false and v.动画~=nil then
          v.动画:更新(dt*1.5)
          v.动画:显示(self.显示xy.x+self.抖动数据.x+v.py[1]+ self.法术坐标.x,self.显示xy.y+self.抖动数据.y+v.py[2]+ self.法术坐标.y)
        end
    end
  end

  if self.状态特效["修罗隐身"]~=nil or self.状态特效["楚楚可怜"]~=nil  then
    self.动画.动画["待战"]:置颜色(1694498815)
    if self.动画.武器 ~= nil and self.动画.武器["待战"]~=nil then
       self.动画.武器["待战"]:置颜色(1694498815)
    end
  end
  if self.状态特效["金刚护法"]~=nil and self.状态特效["修罗隐身"]==nil  then
    self.色相变身 = self.色相变身 + 1
    if self.色相变身 >= 15 then
      self.动画.动画["待战"]:取消高亮()
      if self.动画.武器~= nil and self.动画.武器["待战"]~=nil then
        self.动画.武器["待战"]:取消高亮()
      end
      if self.色相变身 >= 30 then
        self.色相变身 = 0
      end
    else
      self.动画.动画["待战"]:置高亮模式(-10855936)
      if self.动画.武器 ~= nil and self.动画.武器["待战"]~=nil then
        self.动画.武器["待战"]:置高亮模式(-10855936)
      end
    end
  end
  local 浮空偏移 ={x=0,y=0}
  if self.状态特效 and self.状态特效.浮空 then
      浮空偏移 ={x=-12,y=-90}
  end

  local 显示坐标 ={x=0,y=0}

 if not self.移动开关 and self.动作=="攻击" or self.动作=="暴击" and self.攻击偏移 and self.攻击偏移.x~=0 then
        显示坐标.x=self.抖动数据.x + self.法术坐标.x+self.攻击偏移 .x
        显示坐标.y=self.抖动数据.y + self.法术坐标.y+self.攻击偏移 .y
  else
        显示坐标.x=self.抖动数据.x + self.法术坐标.x+ 浮空偏移.x
        显示坐标.y=self.抖动数据.y + self.法术坐标.y+ 浮空偏移.y
  end



  if self.逃跑开关 then
     self.动作="返回"
  end

  if self.飞镖开关 then
    self.飞镖动画:显示(self.飞镖xy.x+浮空偏移.x,self.飞镖xy.y+浮空偏移.y)
  end
  if self.躲避开关 then

  else
      if self.状态特效 and self.状态特效.浮空 then
          self.状态特效.浮空.动画:更新(dt*1.5)
          self.状态特效.浮空.动画:显示(self.显示xy.x+self.抖动数据.x+self.状态特效.浮空.py[1],self.显示xy.y+self.抖动数据.y+self.状态特效.浮空.py[2])
      end

      if self.影子开关 and self.影子显示 then
              for k,v in pairs(self.影子显示) do
                 if v.显示 then
                      if v.动画 and v.动画[self.动作] then
                          v.动画[self.动作]:显示(v.显示xy.x+显示坐标.x,v.显示xy.y+显示坐标.y)
                      end
                      if v.武器 and v.武器[self.动作] then
                          v.武器[self.动作]:显示(v.显示xy.x+显示坐标.x,v.显示xy.y+显示坐标.y)
                      end
                       if v.副武器 and v.副武器[self.动作] then
                          v.副武器[self.动作]:显示(v.显示xy.x+显示坐标.x,v.显示xy.y+显示坐标.y)
                      end
                  end

              end
      else

          self.动画:显示(self.显示xy.x+显示坐标.x,self.显示xy.y+显示坐标.y,self.动作)
      end
  end

   if self.超级进化~= nil then
     if self.超级进化.图像~=nil and self.超级进化.回合~=nil and self.超级进化.回合>=战斗类.回合数  then

        self.超级进化.图像:显示(math.floor(self.显示xy.x+显示坐标.x - 24),math.floor(self.显示xy.y+显示坐标.y -self.高度-40))

     else
        self.超级进化=nil
     end
   end


  --zt:置颜色(self.名称颜色)
  --zt:置阴影颜色(-1275068416)
  if self.抓捕开关 then
      self.抓捕动画:显示(self.抓捕xy.x + 浮空偏移.x,self.抓捕xy.y + 浮空偏移.y)
      名称显示(self.抓捕名称,self.抓捕xy)
      tp.影子:显示(self.抓捕xy.x,self.抓捕xy.y)
  end






  if self.门派 and self.门派~="无" and self.门派~="无门派" then
      if self.门派=="凌波城" then
            if self.战意 and self.奇经特效.战意  then
                for i = 1, 3 do
                  if (i ==3 and self.战意>i) or self.战意==i then
                        self.奇经特效.战意[i]:更新(dt*1.5)
                        self.奇经特效.战意[i]:显示(self.显示xy.x+显示坐标.x+self.奇经特效.战意[i].py[1],self.显示xy.y+显示坐标.y+self.奇经特效.战意[i].py[2])
                  end
                end
                if self.战意>0 then
                    self.状态特效.战意 = self.战意
                else
                    self.状态特效.战意 = nil
                end
            end
            if self.超级战意 and self.奇经特效.超级战意  then
                for i = 1, 3 do
                    if (i ==3 and self.超级战意>i) or self.超级战意==i then
                        self.奇经特效.超级战意[i]:更新(dt*1.5)
                        self.奇经特效.超级战意[i]:显示(self.显示xy.x+显示坐标.x+self.奇经特效.超级战意[i].py[1],self.显示xy.y+显示坐标.y+self.奇经特效.超级战意[i].py[2])
                    end
                end
                if self.超级战意>0 then
                    self.状态特效.超级战意 = self.超级战意
                else
                    self.状态特效.超级战意 = nil
                end
            end
          elseif self.门派=="神木林"  then
                if self.经脉流派 =="灵木药宗"  then
                      if self.灵药红 and self.灵药红>0 and self.奇经特效.灵药红 then
                          self.奇经特效.灵药红:更新(dt*1.5)
                          self.奇经特效.灵药红:显示(self.显示xy.x+显示坐标.x+self.奇经特效.灵药红.py[1],self.显示xy.y+显示坐标.y+self.奇经特效.灵药红.py[2])
                          self.状态特效.灵药红 = self.灵药红
                      else
                          self.状态特效.灵药红 = nil
                      end
                      if self.灵药蓝 and self.灵药蓝>0 and self.奇经特效.灵药蓝 then
                         self.奇经特效.灵药蓝:更新(dt*1.5)
                         self.奇经特效.灵药蓝:显示(self.显示xy.x+显示坐标.x+self.奇经特效.灵药蓝.py[1],self.显示xy.y+显示坐标.y+self.奇经特效.灵药蓝.py[2])
                         self.状态特效.灵药蓝 = self.灵药蓝
                      else
                          self.状态特效.灵药蓝 = nil
                      end
                      if self.灵药黄 and self.灵药黄>0 and self.奇经特效.灵药黄 then
                          self.奇经特效.灵药黄:更新(dt*1.5)
                          self.奇经特效.灵药黄:显示(self.显示xy.x+显示坐标.x+self.奇经特效.灵药黄.py[1],self.显示xy.y+显示坐标.y+self.奇经特效.灵药黄.py[2])
                          self.状态特效.灵药黄 = self.灵药黄
                      else
                          self.状态特效.灵药黄 = nil
                      end
                else
                    if self.风灵  and self.风灵>0  and  self.奇经特效.风灵 then
                          self.奇经特效.风灵:更新(dt*1.5)
                          self.奇经特效.风灵:显示(self.显示xy.x+显示坐标.x+self.奇经特效.风灵.py[1],self.显示xy.y+显示坐标.y+self.奇经特效.风灵.py[2])
                          self.状态特效.风灵 = self.风灵
                    else
                          self.状态特效.风灵 = nil
                    end
                end

          elseif self.门派=="方寸山"  and self.经脉流派 =="五雷正宗" then
                  if self.符咒 and self.符咒>0 and self.奇经特效.符咒 then

                      for i = 1, 5 do
                          if (i ==5 and self.符咒>i) or self.符咒==i then
                              self.奇经特效.符咒[i]:更新(dt*1.5)
                              self.奇经特效.符咒[i]:显示(self.显示xy.x+显示坐标.x+self.奇经特效.符咒[i].py[1],self.显示xy.y+显示坐标.y+self.奇经特效.符咒[i].py[2])
                          end
                      end
                      self.状态特效.符咒 = self.符咒
                  else
                      self.状态特效.符咒 = nil
                  end
                  if self.雷法崩裂 and self.雷法崩裂>0 and self.奇经特效.雷法崩裂 then
                      self.奇经特效.雷法崩裂:更新(dt*1.5)
                      self.奇经特效.雷法崩裂:显示(self.显示xy.x+显示坐标.x+self.奇经特效.雷法崩裂.py[1],self.显示xy.y+显示坐标.y+self.奇经特效.雷法崩裂.py[2])
                      self.状态特效.雷法崩裂 = self.雷法崩裂
                  else
                      self.状态特效.雷法崩裂 = nil
                  end
                  if self.雷法震煞 and self.雷法震煞>0 and self.奇经特效.雷法震煞 then
                      self.奇经特效.雷法震煞:更新(dt*1.5)
                      self.奇经特效.雷法震煞:显示(self.显示xy.x+显示坐标.x+self.奇经特效.雷法震煞.py[1],self.显示xy.y+显示坐标.y+self.奇经特效.雷法震煞.py[2])
                      self.状态特效.雷法震煞 = self.雷法震煞
                  else
                      self.状态特效.雷法震煞 = nil
                  end
                  if self.雷法坤伏 and self.雷法坤伏>0 and self.奇经特效.雷法坤伏 then
                      self.奇经特效.雷法坤伏:更新(dt*1.5)
                      self.奇经特效.雷法坤伏:显示(self.显示xy.x+显示坐标.x+self.奇经特效.雷法坤伏.py[1],self.显示xy.y+显示坐标.y+self.奇经特效.雷法坤伏.py[2])
                      self.状态特效.雷法坤伏 = self.雷法坤伏
                  else
                      self.状态特效.雷法坤伏 = nil
                  end
                  if self.雷法翻天 and self.雷法翻天>0 and self.奇经特效.雷法翻天 then
                      self.奇经特效.雷法翻天:更新(dt*1.5)
                      self.奇经特效.雷法翻天:显示(self.显示xy.x+显示坐标.x+self.奇经特效.雷法翻天.py[1],self.显示xy.y+显示坐标.y+self.奇经特效.雷法翻天.py[2])
                      self.状态特效.雷法翻天 = self.雷法翻天
                  else
                      self.状态特效.雷法翻天 = nil
                  end
                  if self.雷法倒海 and self.雷法倒海>0 and self.奇经特效.雷法倒海 then
                      self.奇经特效.雷法倒海:更新(dt*1.5)
                      self.奇经特效.雷法倒海:显示(self.显示xy.x+显示坐标.x+self.奇经特效.雷法倒海.py[1],self.显示xy.y+显示坐标.y+self.奇经特效.雷法倒海.py[2])
                      self.状态特效.雷法倒海 = self.雷法倒海
                  else
                      self.状态特效.雷法倒海 = nil
                  end
          elseif self.门派=="普陀山" and self.经脉流派 =="落伽神女"  then
                  if self.五行珠金 and self.五行珠金>0 and self.奇经特效.五行珠金 then
                      self.奇经特效.五行珠金:更新(dt*1.5)
                      self.奇经特效.五行珠金:显示(self.显示xy.x+显示坐标.x+self.奇经特效.五行珠金.py[1],self.显示xy.y+显示坐标.y+self.奇经特效.五行珠金.py[2])
                      self.状态特效.五行珠金 = self.五行珠金
                  else
                      self.状态特效.五行珠金 = nil
                  end
                  if self.五行珠木 and self.五行珠木>0 and self.奇经特效.五行珠木 then
                      self.奇经特效.五行珠木:更新(dt*1.5)
                      self.奇经特效.五行珠木:显示(self.显示xy.x+显示坐标.x+self.奇经特效.五行珠木.py[1],self.显示xy.y+显示坐标.y+self.奇经特效.五行珠木.py[2])
                      self.状态特效.五行珠木 = self.五行珠木
                  else
                      self.状态特效.五行珠木 = nil
                  end
                  if self.五行珠水 and self.五行珠水>0 and self.奇经特效.五行珠水 then
                      self.奇经特效.五行珠水:更新(dt*1.5)
                      self.奇经特效.五行珠水:显示(self.显示xy.x+显示坐标.x+self.奇经特效.五行珠水.py[1],self.显示xy.y+显示坐标.y+self.奇经特效.五行珠水.py[2])
                      self.状态特效.五行珠水 = self.五行珠水
                  else
                      self.状态特效.五行珠水 = nil
                  end
                  if self.五行珠火 and self.五行珠火>0 and self.奇经特效.五行珠火 then
                      self.奇经特效.五行珠火:更新(dt*1.5)
                      self.奇经特效.五行珠火:显示(self.显示xy.x+显示坐标.x+self.奇经特效.五行珠火.py[1],self.显示xy.y+显示坐标.y+self.奇经特效.五行珠火.py[2])
                      self.状态特效.五行珠火 = self.五行珠火
                  else
                      self.状态特效.五行珠火 = nil
                  end
                  if self.五行珠土 and self.五行珠土>0 and self.奇经特效.五行珠土 then
                      self.奇经特效.五行珠土:更新(dt*1.5)
                      self.奇经特效.五行珠土:显示(self.显示xy.x+显示坐标.x+self.奇经特效.五行珠土.py[1],self.显示xy.y+显示坐标.y+self.奇经特效.五行珠土.py[2])
                      self.状态特效.五行珠土 = self.五行珠土
                  else
                      self.状态特效.五行珠土 = nil
                  end
          elseif self.门派=="五庄观" and self.经脉流派 =="万寿真仙" and  self.人参娃娃 and self.奇经特效.人参娃娃  then
                  if self.人参娃娃.回合 and self.人参娃娃.回合>0 and self.人参娃娃.层数 then
                      for i = 1, 3 do
                          if (i ==3 and self.人参娃娃.层数>i) or self.人参娃娃.层数==i then
                              self.奇经特效.人参娃娃[i]:更新(dt*1.5)
                              self.奇经特效.人参娃娃[i]:显示(self.显示xy.x+显示坐标.x+self.奇经特效.人参娃娃[i].py[1],self.显示xy.y+显示坐标.y+self.奇经特效.人参娃娃[i].py[2])
                          end
                      end
                      self.状态特效.人参娃娃 = self.人参娃娃
                  else
                      self.状态特效.人参娃娃 = nil
                  end
          elseif self.门派=="大唐官府"and self.经脉流派 =="无双战神" and self.剑意  and  self.奇经特效.剑意 then
                  if self.剑意>0 then
                      self.奇经特效.剑意:更新(dt*1.5)
                      self.奇经特效.剑意:显示(self.显示xy.x+显示坐标.x+self.奇经特效.剑意.py[1],self.显示xy.y+显示坐标.y+self.奇经特效.剑意.py[2])
                      self.状态特效.剑意 = self.剑意
                  else
                      self.状态特效.剑意 = nil
                  end
          end
      end
      for i, v in pairs(self.状态特效) do
          if  i~="浮空" and type(v)=="table" then
              if v.cp and v.动画 then
                  if v.加速 == nil  then
                     v.动画:更新(dt*1.5)
                  else
                    v.动画:更新(v.加速)
                  end
                  v.动画:显示(self.显示xy.x+显示坐标.x+v.py[1],self.显示xy.y+显示坐标.y+v.py[2])
              end
          end
      end

  if not self.移动开关 and not self.影子开关 and self.动作=="攻击" or self.动作=="暴击" and self.攻击偏移 and self.攻击偏移.x~=0 then
      名称显示(self.名称,{x=self.显示xy.x+self.抖动数据.x+ self.法术坐标.x+ self.攻击偏移.x,y=self.显示xy.y+self.抖动数据.y+ self.法术坐标.y+ self.攻击偏移.y},self.名称颜色)
  else
      名称显示(self.名称,{x=self.显示xy.x+self.抖动数据.x+ self.法术坐标.x,y=self.显示xy.y+self.抖动数据.y+ self.法术坐标.y},self.名称颜色)
  end

  for n=1,#self.攻击特效 do
      if self.攻击特效[n]~=nil then
          if self.攻击特效[n].加速==nil then
              self.攻击特效[n]:更新(dt*1.3)
          else
              self.攻击特效[n]:更新(self.攻击特效[n].加速)
          end
          if self.攻击特效[n].附加x and self.攻击特效[n].附加y then
              self.攻击特效[n]:显示(self.显示xy.x+显示坐标.x+self.攻击特效[n].附加x,self.显示xy.y+显示坐标.y+self.攻击特效[n].附加y)
          else
              self.攻击特效[n]:显示(self.显示xy.x+显示坐标.x,self.显示xy.y+显示坐标.y)
          end
          if self.攻击特效[n].当前帧>=self.攻击特效[n].结束帧 then
              self.攻击特效[n]=nil
          end
      end
 	 end
  for n=1,#self.法术特效 do
      if  self.法术特效[n]~=nil then
          if self.法术特效[n].加速==nil then
             self.法术特效[n]:更新(dt)
          else
            self.法术特效[n]:更新(self.法术特效[n].加速)
          end
          if self.法术特效[n].附加x and self.法术特效[n].附加y then
              self.法术特效[n]:显示(self.显示xy.x+显示坐标.x+self.法术特效[n].附加x,self.显示xy.y+显示坐标.y+self.法术特效[n].附加y)
          else
               self.法术特效[n]:显示(self.显示xy.x+显示坐标.x,self.显示xy.y+显示坐标.y)
          end
          -- if 战斗类.掉血流程 and #self.法术特效==n and self.法术特效[n].当前帧==math.ceil(self.法术特效[n].结束帧/1.5) then
          --     战斗类.掉血流程 = nil
          -- end
          if self.法术特效[n].当前帧>=self.法术特效[n].结束帧 then
              self.法术特效[n]=nil
          end
      end
   end
  if self.逃跑开关 then
      self.逃跑特效:更新(dt)
      self.逃跑特效:显示(self.显示xy.x+self.抖动数据.x,self.显示xy.y+self.抖动数据.y)
  end
end



function 战斗单位类:血条显示(x,y)
  if self.是否显示==false then return  end
  if self.敌我==1 then
      战斗类.血条背景:显示(math.floor(self.显示xy.x+self.抖动数据.x+ self.法术坐标.x - 23),math.floor(self.显示xy.y +self.抖动数据.y+ self.法术坐标.y -self.高度+5))
      local 气血上限长度 = (self.气血上限/self.最大气血) *36
      local 魔法上限长度 = (self.魔法/self.最大魔法) *36
  	  引擎.画矩形(math.floor(self.显示xy.x +self.抖动数据.x+ self.法术坐标.x -22),math.floor(self.显示xy.y+self.抖动数据.y+ self.法术坐标.y -self.高度 + 6),math.floor(self.显示xy.x +self.抖动数据.x+ self.法术坐标.x -22+气血上限长度),math.floor(self.显示xy.y+self.抖动数据.y+ self.法术坐标.y -self.高度 + 6 +4),-1189208494)
      战斗类.血条栏:置区域(0,0,(self.气血 / self.最大气血) * 36,4)
      战斗类.血条栏:显示(math.floor(self.显示xy.x +self.抖动数据.x+ self.法术坐标.x -22),math.floor(self.显示xy.y+self.抖动数据.y+ self.法术坐标.y -self.高度 + 6))
      if tp.战斗显示蓝条==true then
          战斗类.血条背景:显示(math.floor(self.显示xy.x+self.抖动数据.x+ self.法术坐标.x - 23),math.floor(self.显示xy.y +self.抖动数据.y+ self.法术坐标.y -self.高度+11))
          引擎.画矩形(math.floor(self.显示xy.x +self.抖动数据.x+ self.法术坐标.x -22),math.floor(self.显示xy.y+self.抖动数据.y+ self.法术坐标.y -self.高度 + 12),math.floor(self.显示xy.x +self.抖动数据.x+ self.法术坐标.x -22+魔法上限长度),math.floor(self.显示xy.y+self.抖动数据.y+ self.法术坐标.y -self.高度 + 12 +4),0xFF0000FF)
         if self.愤怒 and self.类型=="角色" then
            local 愤怒上限长度 = (self.愤怒/150) *36
            战斗类.血条背景:显示(math.floor(self.显示xy.x+self.抖动数据.x+ self.法术坐标.x - 23),math.floor(self.显示xy.y +self.抖动数据.y+ self.法术坐标.y -self.高度+17))
            引擎.画矩形(math.floor(self.显示xy.x +self.抖动数据.x+ self.法术坐标.x -22),math.floor(self.显示xy.y+self.抖动数据.y+ self.法术坐标.y -self.高度 + 18),math.floor(self.显示xy.x +self.抖动数据.x+ self.法术坐标.x -22+愤怒上限长度),math.floor(self.显示xy.y+self.抖动数据.y+ self.法术坐标.y -self.高度 + 12 +8),0xFFFF9932)
          end
      end
  end
  if self.技能提示 then
      self:提示显示()
  end
  if self.喊话 then
      self.喊话:显示(self.显示xy.x,self.显示xy.y)
  end
end

function 战斗单位类:设置伤势(数额,类型)
  if 数额==nil or 类型==nil then
    return
  end
  if self.数据.类型~="角色" then
    return
  end
  if 类型==1 then
    self.气血上限=self.气血上限-数额
    if self.气血上限 < 1 then
     self.气血上限=1
    end
  elseif 类型==2 then
    self.气血上限=self.气血上限+数额
    if self.气血上限>self.最大气血 then
     self.气血上限=self.最大气血
    end
  end
  if tp.队伍[1].数字id == self.数据.id then
    if self.数据.类型 == "角色" then
      tp.队伍[1].气血=self.气血
      tp.队伍[1].气血上限=self.气血上限
      tp.队伍[1].最大气血=self.最大气血
    elseif self.数据.类型 == "bb"  then
      tp.队伍[1].参战宝宝.气血=self.气血
      tp.队伍[1].参战宝宝.最大气血=self.最大气血
    end
  end
end
function 战斗单位类:设置掉血(数额,类型,护盾值)

      local 播放声音=true
      数额 = tonumber(数额) or 1
      self.伤害数额=math.floor(数额)
      self.伤害总数=string.len(tostring(self.伤害数额))
      self.伤害序列={}
      self.弹跳次数=25
      self.弹跳间隔=4
      self.伤害类型=类型
      self.掉血开关=true
      self.加血顺序=0
      if 类型==1 or 类型==3 or 类型==4 then
        self.气血=self.气血-self.伤害数额
        if self.气血<=0 then
            self.气血=0
            if self.数据.类型 == "角色"  then
              self.气血上限=0
            end
        end

      else
          self.气血=self.气血+self.伤害数额
          if self.气血>self.最大气血 then
            self.气血=self.最大气血
          end
          播放声音=false
      end
      for n=1,self.伤害总数 do
          self.伤害序列[n]={}
          self.伤害序列[n].数字=string.sub(self.伤害数额,n,n)
          self.伤害序列[n].高度=0
          self.伤害序列[n].x=self.显示xy.x
          self.伤害序列[n].y=self.显示xy.y
      end
      self.护盾开关=false
      if 护盾值 then
          护盾值 = tonumber(护盾值) or 1
          self.护盾伤害=math.floor(护盾值)
          self.护盾总数=string.len(tostring(self.护盾伤害))
          for n=self.伤害总数+1,self.伤害总数+self.护盾总数 do
            self.伤害序列[n]={}
            self.伤害序列[n].数字=string.sub(self.护盾伤害,n-self.伤害总数,n-self.伤害总数)
            self.伤害序列[n].高度=0
            self.伤害序列[n].x=self.显示xy.x+9
            self.伤害序列[n].y=self.显示xy.y
          end
          self.护盾开关=true
          self.括号上限=self.伤害总数+1
          self.括号下限=self.伤害总数+self.护盾总数
      else
          self.护盾开关=false
      end
      self.弹跳顺序=1
      if 播放声音==true then
          local 动作="挨打"
          local 临时模型=self.数据.模型
          local 临时音乐=引擎.取音效(临时模型)
          if 游戏音效>0 and 临时音乐~=nil and 临时音乐[动作]~=nil then
            self:音效类无叠加(临时音乐[动作],临时音乐.资源,动作)
          end
      end
      if tp.队伍[1].数字id == self.数据.id then
          if self.数据.类型 == "角色"  then
            tp.队伍[1].气血=self.气血
            tp.队伍[1].气血上限=self.气血上限
            tp.队伍[1].最大气血=self.最大气血
          elseif self.数据.类型 == "bb" then
            tp.队伍[1].参战宝宝.气血=self.气血
            tp.队伍[1].参战宝宝.最大气血=self.最大气血
          end
      end
end



function 战斗单位类:加血显示()
  if self.伤害数额 == 0 then
    self.掉血开关=false
    self.击退开关=false
    return
  end
  for n=1,self.伤害总数 do
    self.加血顺序=self.加血顺序+1
    if n==self.弹跳顺序 then
      self.伤害序列[n].高度=self.伤害序列[n].高度+self.弹跳间隔
      if(self.伤害序列[n].高度>=self.弹跳次数) then
        self.弹跳顺序=self.弹跳顺序+1
      end
    elseif self.伤害序列[n].高度>0 then
      self.伤害序列[n].高度=self.伤害序列[n].高度-5
    end
    if(self.敌我==2) then
        if self.伤害序列[n] and self.伤害序列[n].数字 and tonumber(self.伤害序列[n].数字) and self.回复图片[self.伤害序列[n].数字+1] then
            self.回复图片[self.伤害序列[n].数字+1]:显示(self.伤害序列[n].x+n*11-11-#self.伤害序列*6.7,self.伤害序列[n].y-30-self.伤害序列[n].高度)
        end
    else
        if self.伤害序列[n] and  self.伤害序列[n].数字 and tonumber(self.伤害序列[n].数字) and self.回复图片[self.伤害序列[n].数字+1] then
            self.回复图片[self.伤害序列[n].数字+1]:显示(self.伤害序列[n].x+n*11-11-#self.伤害序列*6.7,self.伤害序列[n].y-35-self.伤害序列[n].高度)
        end
    end
    if(self.加血顺序>=#self.伤害序列*60)then
        self.掉血开关=false
        self.击退开关=false
    end
  end
end

function 战斗单位类:掉血显示()
  if self.伤害数额 == 0 then
      self.掉血开关=false
      self.击退开关=false
      return
  end
  for n=1,#self.伤害序列 do
    self.加血顺序=self.加血顺序+1
    if n==self.弹跳顺序 then
        self.伤害序列[n].高度=self.伤害序列[n].高度+self.弹跳间隔
        if(self.伤害序列[n].高度>=self.弹跳次数) then
          self.弹跳顺序=self.弹跳顺序+1
        end
    elseif self.伤害序列[n].高度>0 then
          self.伤害序列[n].高度=self.伤害序列[n].高度-5
    end
    if(self.敌我==2)then
          if self.护盾开关 and n==self.括号上限 then
              self.括号图片[1]:显示(self.伤害序列[n].x+n*11-17-#self.伤害序列*6.7,self.伤害序列[n].y-35-self.伤害序列[n].高度)
          elseif self.护盾开关 and n==self.括号下限 then
                  self.括号图片[2]:显示(self.伤害序列[n].x+n*11-#self.伤害序列*6.7,self.伤害序列[n].y-35-self.伤害序列[n].高度)
          elseif self.伤害序列[n] and self.伤害序列[n].数字 and tonumber(self.伤害序列[n].数字) and self.伤害图片[self.伤害序列[n].数字+1] then
                  self.伤害图片[self.伤害序列[n].数字+1]:显示(self.伤害序列[n].x+n*11-11-#self.伤害序列*6.7,self.伤害序列[n].y-30-self.伤害序列[n].高度)
          end
    else
          if self.护盾开关 and n==self.括号上限 then
               self.括号图片[1]:显示(self.伤害序列[n].x+n*11-17-#self.伤害序列*6.7,self.伤害序列[n].y-40-self.伤害序列[n].高度)
          elseif self.护盾开关 and n==self.括号下限 then
                  self.括号图片[2]:显示(self.伤害序列[n].x+n*11-#self.伤害序列*6.7,self.伤害序列[n].y-40-self.伤害序列[n].高度)
          elseif self.伤害序列[n] and self.伤害序列[n].数字 and tonumber(self.伤害序列[n].数字) and self.伤害图片[self.伤害序列[n].数字+1] then
                  self.伤害图片[self.伤害序列[n].数字+1]:显示(self.伤害序列[n].x+n*11-11-#self.伤害序列*6.7,self.伤害序列[n].y-35-self.伤害序列[n].高度)
          end
    end
  end
  if(self.加血顺序>=#self.伤害序列*60)then
      self.掉血开关=false
      self.击退开关=false
  end
end


function 战斗单位类:暴击显示()
      if self.伤害数额 == 0 then
          self.掉血开关=false
          self.击退开关=false
          return
      end
      for n=1,#self.伤害序列 do
          self.加血顺序=self.加血顺序+1
          if n==self.弹跳顺序 then
            self.伤害序列[n].高度=self.伤害序列[n].高度+self.弹跳间隔
            if(self.伤害序列[n].高度>=self.弹跳次数+5) then
              self.弹跳顺序=self.弹跳顺序+1
            end
          elseif self.伤害序列[n].高度>0 then
            self.伤害序列[n].高度=self.伤害序列[n].高度-5
          end
          if(self.敌我==2)then
              if self.护盾开关 and n==self.括号上限 then
                  self.暴击括号图片[1]:显示(self.伤害序列[n].x+n*14-20-#self.伤害序列*8.2,self.伤害序列[n].y-30-self.伤害序列[n].高度)
              elseif self.护盾开关 and n==self.括号下限 then
                      self.暴击括号图片[2]:显示(self.伤害序列[n].x+n*14-#self.伤害序列*8.2,self.伤害序列[n].y-30-self.伤害序列[n].高度)
              elseif self.伤害序列[n] and  self.伤害序列[n].数字 and tonumber(self.伤害序列[n].数字) and self.暴击图片[self.伤害序列[n].数字+1] then
                      self.暴击图片[self.伤害序列[n].数字+1]:显示(self.伤害序列[n].x+n*14-14-#self.伤害序列*8.2,self.伤害序列[n].y-30-self.伤害序列[n].高度)
              end
          else
              if self.护盾开关 and n==self.括号上限 then
                  self.暴击括号图片[1]:显示(self.伤害序列[n].x+n*14-17-#self.伤害序列*8.2,self.伤害序列[n].y-35-self.伤害序列[n].高度)
              elseif self.护盾开关 and n==self.括号下限 then
                      self.暴击括号图片[2]:显示(self.伤害序列[n].x+n*14-#self.伤害序列*8.2,self.伤害序列[n].y-35-self.伤害序列[n].高度)
              elseif self.伤害序列[n] and self.伤害序列[n].数字 and tonumber(self.伤害序列[n].数字) and self.暴击图片[self.伤害序列[n].数字+1] then
                       self.暴击图片[self.伤害序列[n].数字+1]:显示(self.伤害序列[n].x+n*14-14-#self.伤害序列*8.2,self.伤害序列[n].y-35-self.伤害序列[n].高度)
              end
         end
      end
      if(self.加血顺序>=#self.伤害序列*65)then
          self.掉血开关=false
          self.击退开关=false
      end
end

function 战斗单位类:回血暴击()
      if self.伤害数额 == 0 then
          self.掉血开关=false
          self.击退开关=false
          return
      end
      for n=1,#self.伤害序列 do
        self.加血顺序=self.加血顺序+1
        if n==self.弹跳顺序 then
          self.伤害序列[n].高度=self.伤害序列[n].高度+self.弹跳间隔
          if(self.伤害序列[n].高度>=self.弹跳次数+5) then
            self.弹跳顺序=self.弹跳顺序+1
          end
        elseif self.伤害序列[n].高度>0 then
          self.伤害序列[n].高度=self.伤害序列[n].高度-5
        end
        if(self.敌我==2)then
            if self.伤害序列[n] and self.伤害序列[n].数字 and tonumber(self.伤害序列[n].数字) and self.回复图片[self.伤害序列[n].数字+1] then
                self.回血图片[self.伤害序列[n].数字+1]:显示(self.伤害序列[n].x+n*14-14-#self.伤害序列*8.2,self.伤害序列[n].y-30-self.伤害序列[n].高度)
            end
        else
            if self.伤害序列[n] and self.伤害序列[n].数字 and tonumber(self.伤害序列[n].数字) and self.回复图片[self.伤害序列[n].数字+1] then
                self.回血图片[self.伤害序列[n].数字+1]:显示(self.伤害序列[n].x+n*14-14-#self.伤害序列*8.2,self.伤害序列[n].y-35-self.伤害序列[n].高度)
            end
        end
      end
      if(self.加血顺序>=#self.伤害序列*65)then
          self.掉血开关=false
          self.击退开关=false
      end
end




function 战斗单位类:提示显示()
          if os.clock()<=self.提示时间 then
              local x = math.floor(self.显示xy.x+self.抖动数据.x+ self.法术坐标.x - 10 - self.提示宽度/2)
              local y = 0
              if self.敌我 == 1 then
                  y =  math.floor(self.显示xy.y +self.抖动数据.y + self.法术坐标.y - self.高度 - 20)
              else
                  y =  math.floor(self.显示xy.y +self.抖动数据.y + self.法术坐标.y - self.高度)
              end
              tp.字体表.技能提示:显示(x,y,self.提示文本)
          else
            self.技能提示 = false
          end
end



function 战斗单位类:提示技能(提示)
      if 提示 and 提示.允许 then
          self.提示时间= os.clock()+1.5
          self.技能提示=true
          self.提示文本 = ""
          if 提示.类型 and type(提示.类型)=="string" then
              self.提示文本 = self.提示文本 .."【"..提示.类型.."】"
          end
          if 提示.名称 and type(提示.名称)=="string" then
              self.提示文本 = self.提示文本 ..提示.名称
          end
          self.提示宽度 = tp.字体表.技能提示:取宽度(self.提示文本)
      end
end




function 战斗单位类:卸载()
  if self.影子显示 then
    for k,v in pairs(self.影子显示) do
            local 显示表={"待战","跑去","攻击","暴击","返回"}
            for z,n in pairs(显示表) do
                  if v.动画 and v.动画[n] then
                      v.动画[n]:释放()
                  end
                  if v.武器 and v.武器[n] then
                       v.武器[n]:释放()
                  end
                  if v.副武器 and v.副武器[n] then
                      v.副武器[n]:释放()
                  end
            end
        end
  end
  for k,v in pairs(self.攻击特效) do
       v:释放()
  end
  for k,v in pairs(self.法术特效) do
       v:释放()
  end
  for k,v in pairs(self.状态特效) do
      if v.动画 and type(v)=="table" then
          v.动画:释放()
      end
  end
  self.动画:卸载()
  self.影子显示={}
  self.攻击特效={}
  self.状态特效={}
  self.动画=nil
  递归清空(self)




end










return 战斗单位类