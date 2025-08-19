
local 道具处理类 = class()
local 书铁范围 = {"枪矛","斧钺","剑","双短剑","飘带","爪刺","扇","魔棒","锤","鞭","环圈","刀","法杖","弓弩","宝珠","巨剑","伞","灯笼","头盔","发钗","项链","女衣","男衣","腰带","鞋子"}
local 图策范围={"项圈","护腕","铠甲"}
local qz=math.floor
local floor=math.floor
local remove = table.remove
local 已存在=false
 local NPC商业栏 = require("script/对话处理类/商业对话")()
function 道具处理类:初始化(id)
  self.玩家id=id
  self.数据={}
  self.阵法名称={
    [3]="普通",
    [4]="风扬阵",
    [5]="虎翼阵",
    [6]="天覆阵",
    [7]="云垂阵",
    [8]="鸟翔阵",
    [9]="地载阵",
    [10]="龙飞阵",
    [11]="蛇蟠阵",
    [12]="鹰啸阵",
    [13]="雷绝阵",
    [18]="八卦阵",
  }

  self.一级家具={"黑麻垂曼帘","桦木圆桌","桦木立柜","草编地毯","漆花竹凳","榛木床","印花屏风",
                   "文竹","君子兰","蝴蝶兰","水仙","仙人掌","银烛台","玉瓷画瓶","踏春图","漆花地板"}
  self.二级家具={"白鹤展翅帘","蓝绸绣花帘","红木八仙桌","嵌玉虎纹桌","双鱼吉庆柜","彩绘立柜","兽皮地毯",
                  "麻布地毯","桦木靠背椅","月牙凳","八卦镇邪榻","神仙帐","狮子图屏风","花鸟图屏风","天山云雪",
                  "龟鹤延年灯","长信宫灯","雕花马桶","彩绘花瓶","夕阳山水图","猛虎坐山图","桦木地板"}


  self.额外符石={一级未激活符石=1,二级未激活符石=1,三级未激活符石=1,符石卷轴=1}
  self.新三符石={太极符石=1,阴仪符石=1,阳仪符石=1,太阴符石=1,少阴符石=1,少阳符石=1,太阳符石=1}

  self.额外叠加 = {
            包子=1,月饼=1,鹿茸=1,熊胆=1,香叶=1,佛手=1,灵脂=1,麝香=1,修炼果=1,女儿红=1,金创药=1,易经丹=1,天不老=1,紫石英=1,凤凰尾=1,硫磺草=1,四叶花=1,七叶莲=1,丁香水=1,
            月星子=1,仙狐涎=1,血珊瑚=1,天龙水=1,孔雀红=1,旋复花=1,龙须草=1,百色花=1,鬼切草=1,六道轮回=1,餐风饮露=1,血色茶花=1,白露为霜=1,
            白玉骨头=1, 火凤之睛=1,天青地白=1,曼陀罗花=1,地狱灵芝=1,龙之心屑=1,秘制红罗羹=1,秘制绿罗羹=1,超级红罗羹=1,超级绿罗羹=1,超级修炼果=1
          }


end

function 道具处理类:数据处理(连接id,序号,数字id,数据)


  if 玩家数据[数字id].摊位数据~=nil then
    if 序号~=3699 and 序号~=3700 and 序号~=3720 and 序号~=3721 and 序号~=3722 and 序号~=3723 and 序号~=3724 then
      常规提示(数字id,"#Y/摆摊状态下禁止此种行为")
      return
    end
  end
  if 序号==3699 then
     self:索要道具(连接id,数字id)
  elseif 序号==3700 then
    self:索要行囊(连接id,数字id)
  elseif 序号==3701 then
    self:道具格子互换(连接id,数字id,数据)
  elseif 序号==3701.1 then
    self:道具格子互换1(连接id,数字id,数据)
  elseif 序号==3702 then
    self:丢弃道具(连接id,数字id,数据)
  elseif 序号==3703 then
    self:佩戴装备(连接id,数字id,数据)
  elseif 序号==3704 then
    self:卸下装备(连接id,数字id,数据)
  elseif 序号==3705 then
    self:使用道具(连接id,数字id,数据)
  elseif 序号==3706 then
    self:飞行符传送(连接id,数字id,数据)
  elseif 序号==3707 then
    发送数据(连接id,14,玩家数据[数字id].道具:索要道具1(数字id))
  elseif 序号==3708 then
    self:佩戴bb装备(连接id,数字id,数据)
  elseif 序号==3709 then
    self:卸下bb装备(连接id,数字id,数据)
  elseif 序号==3710 then
    self:染色处理(连接id,数字id,数据)
  elseif 序号==3711 then
    玩家数据[数字id].角色:学习门派技能(连接id,数字id,数据.序列)
  elseif 序号==3711.1 then
    玩家数据[数字id].角色:学习十次门派技能(连接id,数字id,数据.序列)
  elseif 序号==3711.2 then
    玩家数据[数字id].角色:一键学习门派技能(连接id,数字id,数据.序列,数据.目标等级)
  elseif 序号==3711.3 then
    玩家数据[数字id].角色:一键全学门派技能(连接id,数字id,数据.目标等级)
  elseif 序号==3711.4 then
    玩家数据[数字id].角色:突破学习门派技能(连接id,数字id,数据.序列,数据.学习次数)

  elseif 序号==3712 then
    玩家数据[数字id].角色:学习生活技能(连接id,数字id,数据.序列)
  elseif 序号==3712.1 then
   玩家数据[数字id].角色:学习强化技能(连接id,数字id,数据.序列)
   elseif 序号==3712.2 then
   玩家数据[数字id].角色:学习强化技能(连接id,数字id,数据.序列,10)
  elseif 序号==3713 then
    self:烹饪处理(连接id,数字id,数据)
  elseif 序号==3714 then
    self:炼药处理(连接id,数字id,数据)
  elseif 序号==3715 then
    self:给予处理(连接id,数字id,数据)
  elseif 序号==3716 then --请求给予
    self:发起给予处理(连接id,数字id,tonumber(数据.id))

   -- self:给予处理(连接id,数字id,数据)
  elseif 序号==3717 then
   self:设置交易数据(连接id,数字id,数据)
  elseif 序号==3718 then
   self:发起交易处理(连接id,数字id,tonumber(数据.id))
  elseif 序号==3719 then
   self:取消交易(数字id)
  elseif 序号==3720 then --自己创建、索要摊位
    self:索要摊位数据(连接id,数字id,3515)
  elseif 序号==3721 then --更改招牌
    self:更改摊位招牌(连接id,数字id,数据.名称)
  elseif 序号==3722 then --上架
    self:摊位上架商品(连接id,数字id,数据)
  elseif 序号==3723 then --下架
    self:摊位下架商品(连接id,数字id,数据)
  elseif 序号==3724 then --收摊
    self:收摊处理(连接id,数字id)
  elseif 序号==3725 then --索取其他玩家摊位
    self:索要其他玩家摊位(连接id,数字id,tonumber(数据.id),3521)
  elseif 序号==3726 then --购买摊位商品
   self:购买摊位商品(连接id,数字id,数据)
  elseif 序号==3727 then --购买摊位商品
   self:快捷加血(连接id,数字id,数据.类型)
  elseif 序号==3728 then --购买摊位商品
   self:快捷加蓝(连接id,数字id,数据.类型)
  elseif 序号==3729 then --购买摊位商品
        self:交换法宝(连接id,数字id,数据.序列,数据.序列1)
  elseif 序号==3729.1 then --购买摊位商品
        self:交换灵宝(连接id,数字id,数据.序列,数据.序列1)

  elseif 序号==3730 then
        self:背包替换法宝(连接id,数字id,数据.序列,数据.序列1)
  elseif 序号==3730.1 then
        self:背包替换灵宝(连接id,数字id,数据.序列,数据.序列1)

  elseif 序号==3731 then
        self:背包交换法宝(连接id,数字id,数据.序列,数据.序列1)
  elseif 序号==3731.1 then
        self:背包交换灵宝(连接id,数字id,数据.序列,数据.序列1)

  elseif 序号==3732 then
   self:索要法宝(连接id,数字id)
  elseif 序号==3733 then
   self:修炼法宝(连接id,数字id,数据.序列)
  elseif 序号==3733.1 then
   self:修炼灵宝(连接id,数字id,数据.序列)

  elseif 序号==3734 then
   self:卸下法宝(连接id,数字id,数据.序列)
   elseif 序号==3734.1 then
   self:卸下灵宝(连接id,数字id,数据.序列)
  elseif 序号==3735 then
   self:替换法宝(连接id,数字id,数据.序列,数据.序列1)
  elseif 序号==3735.1 then
   self:替换灵宝(连接id,数字id,数据.序列,数据.序列1)


  elseif 序号==3736 then
   self:使用法宝(连接id,数字id,数据.序列)
  elseif 序号==3737 then
   self:使用合成旗(连接id,数字id,数据.序列)
  elseif 序号==3738 then
   self:完成交易处理(数字id)
  elseif 序号 == 3739 then
    self:补充法宝灵气(连接id,数字id,数据.序列)
  elseif 序号 == 3739.1 then
    self:补充灵宝灵气(连接id,数字id,数据.序列)
  elseif 序号 == 3740 then
    self:自选礼包处理(数字id,数据)
  elseif 序号 == 3741 then


     self:拆分处理(连接id,数字id,数据)


  elseif 序号 == 3742 then
      NPC商业栏:治疗召唤兽忠诚(玩家数据[数字id].连接id,数字id)
  elseif 序号 == 3743 then
    self:帮派点修处理(连接id,数字id,数据)
  elseif 序号 == 3744 then
    玩家数据[数字id].角色:帮派学习生活技能(连接id,数字id,数据.序列)
  elseif 序号 == 3745 then
    self:武器染色处理(连接id,数字id,数据)
  elseif 序号==3746 then
    if 玩家数据[数字id].角色.数据.门派=="无门派" or 玩家数据[数字id].角色.数据.门派==nil then
        常规提示(数字id,"#Y你当前没有门派无法打开经脉系统！")
        return
    end
    发送数据(玩家数据[数字id].连接id,77,玩家数据[数字id].角色.数据)
  elseif 序号==3747 then
     self:制作仙露丸子处理(连接id,数字id)
  elseif 序号==3748 then
      玩家数据[数字id].神器:佩戴神器(连接id,数字id)

  elseif 序号==3749 then
--    self:坐骑染色处理(连接id,数字id,数据)
  elseif 序号==3750 then
    self:穿戴饰品(连接id,数字id,数据)



  elseif 序号==3751 then
    玩家数据[数字id].加锁处理:物品加锁(连接id,数字id,数据)
  elseif 序号==3752 then
    玩家数据[数字id].加锁处理:物品密码设置(连接id,数字id,数据)
  elseif 序号==3753 then
    玩家数据[数字id].加锁处理:物品密码解锁(连接id,数字id,数据)
  elseif 序号==3754 then
    玩家数据[数字id].加锁处理:修改物品密码(连接id,数字id,数据)
  elseif 序号==3755 then
    玩家数据[数字id].加锁处理:强行清除物品密码(连接id,数字id,数据)





  elseif 序号==3756 then
   self:卸下饰品(连接id,数字id,数据)


 elseif 序号==3757 then

    self:清空包裹(连接id,数字id)


  elseif 序号==3758 then
    -- 处理背包扩展请求
    if 数据.类型 == "扩展背包" then
      玩家数据[数字id].角色:扩展背包处理(数字id)
      -- 刷新客户端道具数据
      玩家数据[数字id].道具:索要道具(连接id,数字id)
    end
  elseif 序号==3759 then
        self:自动回收(数字id)
        常规提示(数字id,"#Y/回收完毕！")

  elseif 序号==3760 then
      发送数据(连接id,14.1,玩家数据[数字id].道具:索要道具1(数字id))

  elseif 序号==3767 then
    发送数据(玩家数据[数字id].连接id,3548,{道具=self:索要道具1(数字id)})
  elseif 序号==3768 then
    self:装备点化套装(连接id,数字id,数据)
  elseif 序号==3860 then -- 仓库购买费用这边提示修改
    local 对话=[[增加物品仓库数量需要支付20点仙玉，每增加一间仓库将额外消耗（已增加仓库数量*20）点仙玉。本次增加仓库需要消耗#R]]..((#玩家数据[数字id].道具仓库.数据-3)*20+20).."#W点仙玉，你是否需要进行购买仓库操作？"
    发送数据(玩家数据[数字id].连接id,1501,{名称=玩家数据[数字id].角色.数据.名称,模型=玩家数据[数字id].角色.数据.模型,对话=对话,选项={"确定购买仓库","让我再想想"}})
  elseif 序号==3861 then

    self:自选灵饰礼包处理(数字id,数据)
  elseif 序号==3803 then


  elseif 序号==3789 then
    self:制作家具图纸(数字id,数据.参数)


  --整理背包
  elseif 序号==3790 then
    self:整理背包(数字id,数据.类型)
  elseif 序号==3791 then

  elseif 序号==3773 then
     self:灵犀之屑合成(连接id,数字id,数据)--3811

  elseif 序号==3774 then  ----------抽奖
       self:镶嵌灵犀玉(数字id,数据) --3813
  elseif 序号==3775 then

  elseif 序号==3776 then
      玩家数据[数字id].角色:更改角色名字(数字id,数据)
  elseif 序号==3777 then
    --玩家数据[数字id].角色:安全码验证(数字id,数据)
  elseif 序号==3778 then
    --玩家数据[数字id].角色:更改帐号密码(数字id,数据)
  elseif 序号==3800 then
    if 数据.类型=="道具" then
        玩家数据[数字id].符石镶嵌=玩家数据[数字id].角色.数据.道具[数据.装备]
    else
        玩家数据[数字id].符石镶嵌=玩家数据[数字id].角色.数据.行囊[数据.装备]
    end
    发送数据(玩家数据[数字id].连接id,3550,{装备=self.数据[玩家数据[数字id].符石镶嵌]})
  elseif 序号==3801 then
      self:装备镶嵌符石(数字id,数据.内容)
  elseif 序号==3802 then
      self:翻转星石对话(数字id)
  elseif 序号==3804 then
      self:合成符石(连接id,数字id,数据)
  elseif 序号==3805 then
      发送数据(玩家数据[数字id].连接id,3552,{道具=玩家数据[数字id].道具:索要道具1(数字id)})
  elseif 序号==3810 then
      self:炼化铃铛(玩家数据[数字id].连接id,数字id,数据)
  elseif 序号==3811 then
      self:领取铃铛奖励(玩家数据[数字id].连接id,数字id,数据)
  end
end


function 道具处理类:制作仙露丸子处理(连接id,id)
        local 丸子数量 = self:获取道具数量(id,"仙露小丸子")
        local 神兽数量 = self:获取道具数量(id,"神兽涎")
        if 丸子数量<10 or 神兽数量<1  then
            常规提示(id,"你没有那么多的材料")
            return
        elseif 玩家数据[id].角色.数据.体力<100 then
            常规提示(id,"你没有那么多的体力")
            return
        end
        if self:消耗背包道具(id,"仙露小丸子",10) and  self:消耗背包道具(id,"神兽涎",1)  then
            玩家数据[id].角色.数据.体力=玩家数据[id].角色.数据.体力-100
            if 取随机数()<=70 then
                 self:给予道具(id,"仙露丸子",1)
                 常规提示(id,"你获得了#R1#Y个#G仙露丸子")
            else
                常规提示(id,"制作失败了")
            end
            发送数据(连接id,160,{体力=玩家数据[id].角色.数据.体力,道具=self:索要道具2(id)})
        end
end
function 道具处理类:索要灵犀玉(id)
  self.发送数据={道具={}}
  for k,v in pairs(玩家数据[id].角色.数据.道具) do
      if self.数据[v] and self.数据[v].名称=="灵犀玉" then
          self.发送数据.道具[k]=DeepCopy(self.数据[v])
      end
  end
  return self.发送数据
end




function 道具处理类:镶嵌灵犀玉(数字id,数据) --保存镶嵌结果
  -- table.print(数据)
  local id = 数字id + 0
  local 镶嵌部件 = 数据.部件
  local 灵犀玉数据=数据.灵犀玉
  local 客户端属性=数据.客户端属性
  local sqsj = 玩家数据[id].神器.数据.神器解锁[镶嵌部件]
  -- table.print(客户端属性)
  -- print("=====================")
  for k,v in pairs(玩家数据[id].角色.数据.道具) do
     if self.数据[v]~=nil and self.数据[v].名称 == "灵犀玉" then
          for n=1,4 do --循环镶嵌的部位
            if 灵犀玉数据[n]~=nil and self.数据[v].识别码==灵犀玉数据[n].识别码 then --判断物品是否相同，并删除该物品
                sqsj.镶嵌灵犀玉[n].子类 = self.数据[v].子类
                sqsj.镶嵌灵犀玉[n].特性 = self.数据[v].特性
                玩家数据[id].角色.数据.道具[k] = nil
                self.数据[v]=nil
            break
          end
        end
     end
  end

  local 灵犀玉 = self:索要灵犀玉(id)
  道具刷新(id)
  玩家数据[id].神器:计算灵犀玉属性(玩家数据[id].连接id,id,镶嵌部件,灵犀玉)
end

function 道具处理类:灵犀之屑合成(连接id,id,内容)
  local 数量=内容.数量
  if 数量>self:获取道具数量(id,"灵犀之屑") then
    常规提示(id,"#Y/灵犀之屑数量不足！")
    return
  end
  --接下来要写扣除灵犀玉
  if 玩家数据[id].道具:消耗背包道具(id,"灵犀之屑",数量) then--self:扣除灵犀之屑(id,数量) then
    local go = self:取灵犀之屑成功率(数量)
    if go then
      玩家数据[id].道具:给予道具(id,"未鉴定的灵犀玉")
        常规提示(id,"#Y/你获得了#R/1#Y/个未鉴定的灵犀玉")
    end
    发送数据(连接id,6219,{是否成功=go,剩余灵犀玉=self:获取道具数量(id,"灵犀之屑")})
  end
  道具刷新(id)
end



function 道具处理类:取灵犀之屑成功率(数量)
  数量 = 数量 + 0
  local 成功率 =  2
  if 数量==2 then
     成功率 = 4
  elseif 数量==3 then
         成功率 = 8
  elseif 数量==4 then
         成功率 = 16
  elseif 数量==5 then
         成功率 = 25
  elseif 数量==6 then
         成功率 = 36
  elseif 数量==7 then
         成功率 = 49
  elseif 数量==8 then
         成功率 = 64
  elseif 数量==9 then
         成功率 = 81
  elseif 数量==10 then
         成功率 = 90
  end
  if 取随机数(1,100) <= 成功率 then
    return true
  end
  return false
end




function 道具处理类:消耗背包道具(id,名称,数量)
  if not 数量 then 数量=1 end
  local 扣除数量 = 数量
  local 扣除数据={}
  local 已扣除=0
  for k,v in pairs(玩家数据[id].角色.数据.道具) do
      if self.数据[v] and self.数据[v].名称==名称 and 已扣除<扣除数量 and not self.数据[v].加锁 then
         if not self.数据[v].数量 then
            已扣除=已扣除+1
            扣除数据[#扣除数据+1]={格子=k,id=v,数量=1}
         else
            if self.数据[v].数量>=扣除数量-已扣除 then
                扣除数据[#扣除数据+1]={格子=k,id=v,数量=扣除数量-已扣除}
                已扣除=已扣除+(扣除数量-已扣除)
            else
                已扣除=已扣除+self.数据[v].数量
                扣除数据[#扣除数据+1]={格子=k,id=v,数量=self.数据[v].数量}
            end
         end
      end
  end
  if 已扣除<扣除数量 then
      常规提示(id,"你没有那么多的"..名称)
      if 玩家数据[id].战斗~=0 then
          发送数据(玩家数据[id].连接id, 38, {内容 = "你没有那么多的"..名称})
      end
      return false
  else
      for n=1,#扣除数据 do
          if self.数据[扣除数据[n].id] then
              self:删除道具(玩家数据[id].连接id,id,"道具",扣除数据[n].id,扣除数据[n].格子,扣除数据[n].数量)
          end
      end
      道具刷新(id)
    return true
  end
  return false
end


function 道具处理类:扣除背包道具(id,名称)
         local 扣除数量 = 0
         local 扣除数据={}
         for k,v in pairs(玩家数据[id].角色.数据.道具) do
             if self.数据[v] and self.数据[v].名称==名称 and not self.数据[v].加锁 then
               if not self.数据[v].数量 then
                   扣除数量=扣除数量 + 1
                   扣除数据[#扣除数据+1]={格子=k,id=v,数量=1}
               else
                    扣除数量 = 扣除数量 + self.数据[v].数量
                    扣除数据[#扣除数据+1]={格子=k,id=v,数量=self.数据[v].数量}
               end
            end
        end
        if 扣除数量>0 then
           for n=1,#扣除数据 do
              if self.数据[扣除数据[n].id] then
                  self:删除道具(玩家数据[id].连接id,id,"道具",扣除数据[n].id,扣除数据[n].格子,扣除数据[n].数量)
              end
          end
          道具刷新(id)
        end
        return 扣除数量
end


function 道具处理类:获取道具数量(id,道具名)
  local 道具数量=0
  for k,v in pairs(玩家数据[id].角色.数据.道具) do
      if self.数据[v] and self.数据[v].名称==道具名 then
          if self.数据[v].数量==nil then
              道具数量=道具数量+1
          else
            道具数量=道具数量+self.数据[v].数量
          end
      end
  end
  return 道具数量
end

-- function 道具处理类:扣除道具数量(id,道具名,数量,参数一名称,参数一,参数二名称,参数二)
--   local 扣除数据={}
--   local 已扣除=0
--   for n=1,20 do
--     if 玩家数据[id].角色.数据.道具[n]~=nil and self.数据[玩家数据[id].角色.数据.道具[n]]~=nil and self.数据[玩家数据[id].角色.数据.道具[n]].名称==道具名 then
--       if 参数一名称 ~=nil and 参数一~=nil then
--         if self.数据[玩家数据[id].角色.数据.道具[n]][参数一名称] ~= nil and self.数据[玩家数据[id].角色.数据.道具[n]][参数一名称]==参数一 then
--           if 参数二名称 ~=nil and 参数二~=nil then
--             if self.数据[玩家数据[id].角色.数据.道具[n]][参数二名称] ~= nil and self.数据[玩家数据[id].角色.数据.道具[n]][参数二名称]==参数二 then
--               if self.数据[玩家数据[id].角色.数据.道具[n]].数量 == nil then
--                 self.数据[玩家数据[id].角色.数据.道具[n]].数量 = 1
--               end
--               if self.数据[玩家数据[id].角色.数据.道具[n]].数量>=数量-已扣除 then
--                 扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.数据.道具[n],数量=数量-已扣除}
--                 已扣除=已扣除+(数量-已扣除)
--               else
--                 已扣除=已扣除+self.数据[玩家数据[id].角色.数据.道具[n]].数量
--                 扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.数据.道具[n],数量=self.数据[玩家数据[id].角色.数据.道具[n]].数量}
--               end
--             end
--           else
--             if self.数据[玩家数据[id].角色.数据.道具[n]].数量 == nil then
--               self.数据[玩家数据[id].角色.数据.道具[n]].数量 = 1
--             end
--             if self.数据[玩家数据[id].角色.数据.道具[n]].数量>=数量-已扣除 then
--               扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.数据.道具[n],数量=数量-已扣除}
--               已扣除=已扣除+(数量-已扣除)
--             else
--               已扣除=已扣除+self.数据[玩家数据[id].角色.数据.道具[n]].数量
--               扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.数据.道具[n],数量=self.数据[玩家数据[id].角色.数据.道具[n]].数量}
--             end
--           end
--         end
--       else
--         if self.数据[玩家数据[id].角色.数据.道具[n]].数量 == nil then
--           self.数据[玩家数据[id].角色.数据.道具[n]].数量 = 1
--         end
--         if self.数据[玩家数据[id].角色.数据.道具[n]].数量>=数量-已扣除 then
--           扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.数据.道具[n],数量=数量-已扣除}
--           已扣除=已扣除+(数量-已扣除)
--         else
--           已扣除=已扣除+self.数据[玩家数据[id].角色.数据.道具[n]].数量
--           扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.数据.道具[n],数量=self.数据[玩家数据[id].角色.数据.道具[n]].数量}
--         end
--       end
--     end
--   end
--   if 已扣除<数量 then
--     常规提示(id,"你没有那么多的#R"..道具名.."#Y，请检查包裹并将道具放到道具栏第一页.")
--     return false
--   else
--     for n=1,#扣除数据 do
--       self.数据[扣除数据[n].id].数量=self.数据[扣除数据[n].id].数量-扣除数据[n].数量
--       if self.数据[扣除数据[n].id].数量<=0 then
--         self.数据[扣除数据[n].id]=nil
--         玩家数据[id].角色.数据.道具[扣除数据[n].格子]=nil
--       end
--     end
--     return true
--   end
-- end


-- function 道具处理类:拆分处理(连接id,id,数据)
--    if not 数据.数量 or not tonumber(数据.数量) then
--       常规提示(id,"#Y/输入正确的拆分数量")
--       return
--     end
--     local 拆分数量 = tonumber(数据.数量)
--     拆分数量=math.floor(拆分数量)
--     if  拆分数量<1 or 拆分数量~=tonumber(数据.数量) then
--       常规提示(id,"#Y/输入正确的拆分数量")
--       return
--     end
--     if not 数据.类型 or not 数据.物品 then return end
--     if 数据.类型~="道具" then 常规提示(id,"#Y/只有道具行囊才可以拆分物品") return end
--     local 格子 = 玩家数据[id].角色:取道具格子()
--     local 道具id = 玩家数据[id].角色.数据[数据.类型][数据.物品]
--     if 格子==0 or not 道具id or 道具id==0 then
--           常规提示(id,"#Y/你身上的包裹没有足够的空间")
--           return
--     elseif self.数据[道具id]==nil or not self.数据[道具id].数量 then
--           常规提示(id,"#Y/数据错误")
--           return
--     elseif self.数据[道具id].数量 >999 then
--             self.数据[道具id]=nil
--             self:刷新道具行囊(id,数据.类型)
--             return
--     elseif self.数据[道具id].数量<2 then
--               常规提示(id,"#Y/你的道具数量不足")
--               return
--     elseif self.数据[道具id].数量 - 拆分数量<1 then
--             常规提示(id,"#Y/你的道具数量不足")
--             return
--     else
--           local 剩余数量 = self.数据[道具id].数量 - 拆分数量
--           self.数据[道具id].数量  =  math.floor(剩余数量)
--           if  self.数据[道具id].数量<1 or math.floor(self.数据[道具id].数量)~=self.数据[道具id].数量 then
--               self:删除同类物品(self.数据[道具id].识别码)
--               self:刷新道具行囊(id,数据.类型)
--               常规提示(id,"#Y/数据错误,已删除道具")
--               return
--           end
--           local 拆分数据 = DeepCopy(self.数据[道具id])
--           local 道具编号 = self:取新编号()
--           self.数据[道具编号] = 拆分数据
--           self.数据[道具编号].数量 = 拆分数量
--           self.数据[道具编号].识别码 =取唯一识别码(id)
--           玩家数据[id].角色.数据[数据.类型][格子]=道具编号
--           玩家数据[id].角色:日志记录("拆分道具"..self.数据[道具id].名称..",拆分数量"..数据.数量)
--           self:刷新道具行囊(id,数据.类型)
--     end
-- end

function 道具处理类:道具拆分(id,内容)
        if not 内容.编号 or not tonumber(内容.编号)  then 常规提示(id,"#Y/你没有该道具") return end
        if not 内容.类型 or 内容.类型~="道具" then 常规提示(id,"#Y/只有道具包裹才可以拆分物品") return end
        local 格子id = tonumber(内容.编号)
        local 道具id = 玩家数据[id].角色.数据.道具[格子id]
        if not 道具id or 道具id==0 or not self.数据[道具id] or  self.数据[道具id]==0 then
            常规提示(id,"#Y/你没有该道具")
            return
        elseif not self.数据[道具id].数量 or not tonumber(self.数据[道具id].数量) or self.数据[道具id].数量~=math.floor(self.数据[道具id].数量) then
            常规提示(id,"#Y/数据错误")
            return
        elseif not self.数据[道具id].识别码 or not string.find(self.数据[道具id].识别码,玩家数据[id].角色.数据.数字id) then
            self.数据[道具id]=nil
            常规提示(id,"#Y/数据错误,已删除道具")
            道具刷新(id)
            return
        elseif self.数据[道具id].数量 >999 then
            self.数据[道具id]=nil
            常规提示(id,"#Y/数据错误,已删除道具")
            道具刷新(id)
            return
        elseif self.数据[道具id].数量<2 then
              常规提示(id,"#Y/你的道具数量不足,无法拆分")
              return
        end
        local 格子 = 玩家数据[id].角色:取道具格子()
        if not 格子 or 格子==0 then
          常规提示(id,"#Y/你身上的包裹没有足够的空间")
          return
        end
        玩家数据[id].拆分道具={
           格子id = 格子id,
           道具id =道具id,
           数量 = self.数据[道具id].数量,
           识别码 = self.数据[道具id].识别码,
           名称 = self.数据[道具id].名称
          }
         发送数据(玩家数据[id].连接id,132,{操作="拆分物品",说明="请输入 "..self.数据[道具id].名称.." 分离的数量",回调={[1]=self.数据[道具id].数量}})


end


function 道具处理类:拆分处理(连接id,id,数据)
          if not 玩家数据[id].拆分道具 then return end
          if 玩家数据[id].角色.数据.道具[玩家数据[id].拆分道具.格子id]~=玩家数据[id].拆分道具.道具id then
              玩家数据[id].拆分道具 = nil
              常规提示(id,"#Y/请不要移动拆分的道具")
              return
          end
          if not 数据.数量 or not tonumber(数据.数量) or math.floor(数据.数量)~= tonumber(数据.数量) or isNaN(tonumber(数据.数量)) then
              玩家数据[id].拆分道具 = nil
              常规提示(id,"#Y/输入正确的拆分数量")
              return
          end
          local 拆分数量 = math.floor(数据.数量+0)
          if 拆分数量<1 then
              玩家数据[id].拆分道具 = nil
              常规提示(id,"#Y/输入正确的拆分数量")
              return
          elseif math.floor(玩家数据[id].拆分道具.数量 - 拆分数量)<1 then
                  玩家数据[id].拆分道具 = nil
                  常规提示(id,"#Y/你的道具数量不足")
                  return
          end
          local 格子 = 玩家数据[id].角色:取道具格子()
          if not 格子 or 格子==0 then
            玩家数据[id].拆分道具 = nil
            常规提示(id,"#Y/你身上的包裹没有足够的空间")
            return
          end
          local 道具id = 玩家数据[id].拆分道具.道具id
          if not 道具id or 道具id==0 or not self.数据[道具id] or  self.数据[道具id]==0 then
              玩家数据[id].拆分道具 = nil
              常规提示(id,"#Y/你没有该道具")
              return
          elseif self.数据[道具id].名称~=玩家数据[id].拆分道具.名称 then
                玩家数据[id].拆分道具 = nil
                常规提示(id,"#Y/数据错误")
                return
          elseif self.数据[道具id].识别码~=玩家数据[id].拆分道具.识别码 then
                玩家数据[id].拆分道具 = nil
                常规提示(id,"#Y/数据错误")
                return
          elseif self.数据[道具id].数量~=玩家数据[id].拆分道具.数量 then
                玩家数据[id].拆分道具 = nil
                常规提示(id,"#Y/数据错误")
                return
          else
                local 剩余数量 = math.floor(玩家数据[id].拆分道具.数量  - 拆分数量)
                if 剩余数量<1 then
                    玩家数据[id].拆分道具 = nil
                    self:删除同类物品(self.数据[道具id].识别码)
                    道具刷新(id)
                    常规提示(id,"#Y/数据错误,已删除道具")
                    return
                end
                local 拆分数据 = DeepCopy(self.数据[道具id])
                local 道具编号 = self:取新编号()
                self.数据[道具编号] = 拆分数据
                self.数据[道具编号].数量 = 拆分数量
                self.数据[道具编号].识别码 =取唯一识别码(id)
                self.数据[道具id].数量 = 剩余数量
                if self.数据[道具id].数量 + self.数据[道具编号].数量==玩家数据[id].拆分道具.数量 then
                    玩家数据[id].角色.数据.道具[格子]=道具编号
                    玩家数据[id].角色:日志记录("拆分道具"..self.数据[道具id].名称..",拆分数量"..数据.数量)
                else
                     玩家数据[id].角色:日志记录("拆分道具"..self.数据[道具id].名称..",拆分数量"..数据.数量..",拆分数量错误")
                     self:删除同类物品(self.数据[道具id].识别码)
                     self:删除同类物品(self.数据[道具编号].识别码)
                end
                道具刷新(id)
          end
          玩家数据[id].拆分道具 = nil
end



function 道具处理类:自选灵饰礼包处理(id,数据)
        if  玩家数据[id].自选礼包数据 == nil then
          return
        end
        if  玩家数据[id].自选礼包数据.级别 ~= 数据.等级  then
           return
        end
        if self.数据[玩家数据[id].自选礼包数据.道具id] ==nil then
          return
        end
        if self.数据[玩家数据[id].自选礼包数据.道具id].名称~=玩家数据[id].自选礼包数据.名称 then
          return
        end
        if 玩家数据[id].自选礼包数据.部位==nil then
          return
        end
        local 道具格子 = 玩家数据[id].角色:取道具格子()

         if 道具格子==0 then
            常规提示(id,"你的背包已满！")
            玩家数据[id].自选礼包数据 = nil
             return
         end

         local 临时等级=玩家数据[id].自选礼包数据.级别
         local 临时类型=玩家数据[id].自选礼包数据.部位
         local 道具 = 物品类()
         道具:置对象(制造装备[临时类型][临时等级])
         道具.级别限制 = 临时等级
         道具.幻化等级 =0
         道具.幻化属性={附加={},基础={}}
         道具.识别码=取唯一识别码(id)
           local  确定基础 = false
           if 数据.基础~=nil and 数据.基础~="" then
              for i=1,#灵饰属性[临时类型].主属性 do
                  if 灵饰属性[临时类型].主属性[i]==数据.基础 then
                    确定基础 = true
                  end
              end
          end
          if 确定基础 then
               local 临时数值 = math.floor((灵饰属性.基础[数据.基础][临时等级].b+临时等级/10)*1.1)
               道具.幻化属性.基础={类型=数据.基础,数值=临时数值,强化=0}
          else
              local 临时属性=灵饰属性[临时类型].主属性[取随机数(1,#灵饰属性[临时类型].主属性)]
              local 临时数值=灵饰属性.基础[临时属性][临时等级].b+临时等级/10
              local 临时下限=灵饰属性.基础[临时属性][临时等级].a+临时等级/20
              local 临时数值=math.floor(取随机数(临时下限,临时数值))
              临时数值=math.floor(临时数值*1.1)
              道具.幻化属性.基础={类型=临时属性,数值=临时数值,强化=0}
          end
          for i=1,4 do
              local 确定附加 =false
              if 数据["属性"..i]~=nil and  数据["属性"..i]~="" then
                  for n=1,#灵饰属性[临时类型].副属性 do
                      if 灵饰属性[临时类型].副属性[n]==数据["属性"..i] then
                        确定附加 =true
                      end
                  end
              end
              if 确定附加 then
                  local 临时数值=math.floor(灵饰属性.基础[数据["属性"..i]][临时等级].b+临时等级/10)
                  道具.幻化属性.附加[i]={类型= 数据["属性"..i],数值=临时数值,强化=0}
              else
                  local 临时属性=灵饰属性[临时类型].副属性[取随机数(1,#灵饰属性[临时类型].副属性)]
                  local 临时数值=灵饰属性.基础[临时属性][临时等级].b+临时等级/10
                  local 临时下限=灵饰属性.基础[临时属性][临时等级].a+临时等级/20
                  临时数值=math.floor(取随机数(临时下限,临时数值))
                  道具.幻化属性.附加[i]={类型=临时属性,数值=临时数值,强化=0}

              end
          end

     道具.制造者 = "强化自选礼包"
     道具.灵饰=true
     if 数据.特效~=nil and 数据.特效~="" then
      道具.特效 = 数据.特效
    else
        道具.特效 = "无级别限制"
    end
    道具.专用=id
    道具.不可交易=true


    local 装备格子=self:取新编号()
    self.数据[装备格子]=道具
    self.数据[装备格子].五行=取五行()
    self.数据[装备格子].耐久度=500
    self.数据[装备格子].部位类型=临时类型
    self.数据[装备格子].鉴定=false
    self.数据[装备格子].识别码=取唯一识别码(id)
    玩家数据[id].角色.数据.道具[道具格子]=装备格子
    常规提示(id,"#Y/你得到了#R/"..self.数据[装备格子].名称)

self.数据[玩家数据[id].自选礼包数据.道具id].数量 =self.数据[玩家数据[id].自选礼包数据.道具id].数量 -1
if self.数据[玩家数据[id].自选礼包数据.道具id].数量 <= 0 then
  self.数据[玩家数据[id].自选礼包数据.道具id]=nil
end
玩家数据[id].自选礼包数据 = nil
道具刷新(id)
end






function 道具处理类:自选礼包处理(id,数据)
if  玩家数据[id].自选礼包数据 == nil then
  return
end
if  玩家数据[id].自选礼包数据.级别 ~= 数据.等级  then
   return
end
if self.数据[玩家数据[id].自选礼包数据.道具id] ==nil then
  return
end
if self.数据[玩家数据[id].自选礼包数据.道具id].名称~=玩家数据[id].自选礼包数据.名称 then
  return
end

 if 玩家数据[id].角色:取道具格子()==0 then
    常规提示(id,"你的背包已满！")
    玩家数据[id].自选礼包数据 = nil
     return
 end

    local 等级=玩家数据[id].自选礼包数据.级别/10
    等级=math.floor(等级)
    local 模型=玩家数据[id].角色.数据.模型
    local  临时id = ""
    local 当前部位=""

    if 玩家数据[id].自选礼包数据.部位~=nil then
            if  玩家数据[id].自选礼包数据.部位=="武器" then
                 local 武器序列=角色武器类型[模型][取随机数(1,#角色武器类型[模型])]
                 local 武器名称=玩家数据[id].装备.打造物品[武器序列][等级+1]
                 临时id=玩家数据[id].装备:生成指定装备(id,武器名称,等级*10,武器序列)--武器
                 self.数据[临时id].命中 = math.floor(等级*53.6+15)
                 self.数据[临时id].伤害 = math.floor(等级*46.8+14)
                 当前部位="武器"
            elseif 玩家数据[id].自选礼包数据.部位=="衣服"  then
                  local 衣服类型=2
                  if 玩家数据[id].角色.数据.性别=="女" then
                    衣服类型=1
                  end
                  local 衣服序列=21
                  local 衣服名称= 玩家数据[id].装备.打造物品[衣服序列][等级+1][衣服类型]
                  临时id=玩家数据[id].装备:生成指定装备(id,衣服名称,等级*10,衣服序列)--衣服
                  self.数据[临时id].防御 = math.floor(等级*26.5+13)
                  当前部位="衣服"
            elseif 玩家数据[id].自选礼包数据.部位=="头盔" then
               local 头盔类型=1
                if 玩家数据[id].角色.数据.性别=="女" then
                  头盔类型=2
                end
                local 头盔序列=19
                local 头盔名称= 玩家数据[id].装备.打造物品[头盔序列][等级+1][头盔类型]
                临时id=玩家数据[id].装备:生成指定装备(id,头盔名称,等级*10,头盔序列)--头盔
                self.数据[临时id].防御 = math.floor(等级*11.7)
                self.数据[临时id].魔法 = math.floor(等级*18.5+8)
                 当前部位="头盔"
            elseif 玩家数据[id].自选礼包数据.部位=="项链" then

                local 项链序列=20
                local 项链名称= 玩家数据[id].装备.打造物品[项链序列][等级+1][取随机数(1,2)]
                if type(玩家数据[id].装备.打造物品[项链序列][等级+1])=="table" then
                  项链名称= 玩家数据[id].装备.打造物品[项链序列][等级+1][取随机数(1,2)]
                else
                  项链名称= 玩家数据[id].装备.打造物品[项链序列][等级+1]
                end
                临时id=玩家数据[id].装备:生成指定装备(id,项链名称,等级*10,项链序列)--项链
                self.数据[临时id].灵力 = math.floor(等级*24.5+7)
                当前部位="项链"
            elseif 玩家数据[id].自选礼包数据.部位=="腰带" then
                local 腰带序列=22
                local 腰带名称= 玩家数据[id].装备.打造物品[腰带序列][等级+1][取随机数(1,2)]
                if type(玩家数据[id].装备.打造物品[腰带序列][等级+1])=="table" then
                  腰带名称= 玩家数据[id].装备.打造物品[腰带序列][等级+1][取随机数(1,2)]
                else
                  腰带名称= 玩家数据[id].装备.打造物品[腰带序列][等级+1]
                end
               临时id=玩家数据[id].装备:生成指定装备(id,腰带名称,等级*10,腰带序列)--腰带
               self.数据[临时id].防御 = math.floor(等级*11.7)
               self.数据[临时id].气血 = math.floor(等级*48.5+17)
               当前部位="腰带"
            elseif 玩家数据[id].自选礼包数据.部位=="鞋子" then
              local 鞋子序列=23
              local 鞋子名称= 玩家数据[id].装备.打造物品[鞋子序列][等级+1]
              临时id=玩家数据[id].装备:生成指定装备(id,鞋子名称,等级*10,鞋子序列)--鞋子
              self.数据[临时id].防御 = math.floor(等级*11.7)
              self.数据[临时id].敏捷 = math.floor(等级*8+7)
              当前部位="鞋子"
          end
    else
            local  随机几率 =取随机数(1,56)
            if  随机几率<= 10 then
                 local 武器序列=角色武器类型[模型][取随机数(1,#角色武器类型[模型])]
                 local 武器名称=玩家数据[id].装备.打造物品[武器序列][等级+1]
                 临时id=玩家数据[id].装备:生成指定装备(id,武器名称,等级*10,武器序列)--武器
                 当前部位="武器"
            elseif 随机几率> 10 and 随机几率<= 20 then
                  local 衣服类型=2
                  if 玩家数据[id].角色.数据.性别=="女" then
                    衣服类型=1
                  end
                  local 衣服序列=21
                  local 衣服名称= 玩家数据[id].装备.打造物品[衣服序列][等级+1][衣服类型]
                  临时id=玩家数据[id].装备:生成指定装备(id,衣服名称,等级*10,衣服序列)--衣服
                  当前部位="衣服"
            elseif 随机几率> 20 and 随机几率<= 30 then
               local 头盔类型=1
                if 玩家数据[id].角色.数据.性别=="女" then
                  头盔类型=2
                end
                local 头盔序列=19
                local 头盔名称= 玩家数据[id].装备.打造物品[头盔序列][等级+1][头盔类型]
                临时id=玩家数据[id].装备:生成指定装备(id,头盔名称,等级*10,头盔序列)--头盔
                当前部位="头盔"
            elseif 随机几率> 30 and 随机几率<= 40 then

                local 项链序列=20
                local 项链名称= 玩家数据[id].装备.打造物品[项链序列][等级+1][取随机数(1,2)]
                if type(玩家数据[id].装备.打造物品[项链序列][等级+1])=="table" then
                  项链名称= 玩家数据[id].装备.打造物品[项链序列][等级+1][取随机数(1,2)]
                else
                  项链名称= 玩家数据[id].装备.打造物品[项链序列][等级+1]
                end
                临时id=玩家数据[id].装备:生成指定装备(id,项链名称,等级*10,项链序列)--项链
                当前部位="项链"
            elseif 随机几率> 40 and 随机几率<= 46 then
                local 腰带序列=22
                local 腰带名称= 玩家数据[id].装备.打造物品[腰带序列][等级+1][取随机数(1,2)]
                if type(玩家数据[id].装备.打造物品[腰带序列][等级+1])=="table" then
                  腰带名称= 玩家数据[id].装备.打造物品[腰带序列][等级+1][取随机数(1,2)]
                else
                  腰带名称= 玩家数据[id].装备.打造物品[腰带序列][等级+1]
                end
               临时id=玩家数据[id].装备:生成指定装备(id,腰带名称,等级*10,腰带序列)--腰带
               当前部位="腰带"
            elseif 随机几率> 46 and 随机几率<= 56 then
              local 鞋子序列=23
              local 鞋子名称= 玩家数据[id].装备.打造物品[鞋子序列][等级+1]
              临时id=玩家数据[id].装备:生成指定装备(id,鞋子名称,等级*10,鞋子序列)--鞋子
              当前部位="鞋子"
          end

    end
    local 临时双加 = {"体质","力量","耐力","魔力","敏捷"}
    if  当前部位=="鞋子" then
        临时双加 = {"体质","力量","耐力","魔力"}
    end
    for i=1,#临时双加 do
       if self.数据[临时id][临时双加[i]]~=nil then
          self.数据[临时id][临时双加[i]]=nil
       end
    end
    if 当前部位=="武器" or 当前部位=="衣服" then
       if 数据.双加1~=nil and 数据.双加1~="" then
          if  玩家数据[id].自选礼包数据.部位~=nil then
             self.数据[临时id][数据.双加1]=math.floor(等级*4)
          else
             self.数据[临时id][数据.双加1]=math.floor(取随机数(等级*1.5,等级*4))
          end
       end
       if 数据.双加2~=nil and 数据.双加2~=""  then
          if  玩家数据[id].自选礼包数据.部位~=nil then
              self.数据[临时id][数据.双加2]=math.floor(等级*4)
          else
              self.数据[临时id][数据.双加2]=math.floor(取随机数(等级*1.5,等级*4))
          end
       end
    end



if 数据.特技~= nil then
  self.数据[临时id].特技 = 数据.特技
end

if 数据.特效~= nil then
  self.数据[临时id].特效 = 数据.特效
end
self.数据[临时id].专用=id
self.数据[临时id].不可交易=true
self.数据[临时id].识别码=取唯一识别码(id)
if  玩家数据[id].自选礼包数据.部位~=nil then
    self.数据[临时id].制造者="强化自选礼包"
else
    self.数据[临时id].制造者="随机自选礼包"
end

self.数据[玩家数据[id].自选礼包数据.道具id].数量 =self.数据[玩家数据[id].自选礼包数据.道具id].数量 -1
if self.数据[玩家数据[id].自选礼包数据.道具id].数量 <= 0 then
  self.数据[玩家数据[id].自选礼包数据.道具id]=nil
end
玩家数据[id].自选礼包数据 = nil
道具刷新(id)
end





function 道具处理类:自动回收(id)
        if 自动回收[id] == nil then
            自动回收[id] = {兽决=0,高级兽决=0,二级药=0,五宝=0,宝石=0,超级金柳露=0,环装=0,暗器=0,书铁=0,修练果=0,强化石=0,月华露=0,清灵净瓶=0,九转金丹=0,低级内丹=0,高级内丹=0}
        end
        local 添加银子 = 0
        for k,v in pairs(玩家数据[id].角色.数据.道具) do
            if self.数据[v] and not self.数据[v].加锁 then
                if self.数据[v].名称 == "魔兽要诀" and  自动回收[id].兽决 == 1 then
                      添加银子 =添加银子 + 自定义回收价格.兽决
                      self.数据[v]=nil
                      玩家数据[id].角色.数据.道具[k]=nil
                elseif self.数据[v].名称 == "高级魔兽要诀" and 自动回收[id].高级兽决 == 1 then
                        添加银子 =添加银子 + 自定义回收价格.高级兽决
                        self.数据[v]=nil
                        玩家数据[id].角色.数据.道具[k]=nil
                elseif (self.数据[v].名称 == "孔雀红" or self.数据[v].名称 == "鹿茸"
                      or self.数据[v].名称 == "仙狐涎" or self.数据[v].名称 == "地狱灵芝"
                      or self.数据[v].名称 == "六道轮回" or self.数据[v].名称 == "凤凰尾"
                      or self.数据[v].名称 == "火凤之睛" or self.数据[v].名称 == "龙之心屑"
                      or self.数据[v].名称 == "紫石英" or self.数据[v].名称 == "白露为霜"
                      or self.数据[v].名称 == "天不老" or self.数据[v].名称 == "血色茶花"
                      or self.数据[v].名称 == "熊胆" or self.数据[v].名称 == "硫磺草"
                      or self.数据[v].名称 == "丁香水" or self.数据[v].名称 == "月星子"
                      or self.数据[v].名称 == "麝香" or self.数据[v].名称 == "血珊瑚"
                      or self.数据[v].名称 == "餐风饮露" or self.数据[v].名称 == "天龙水")
                      and 自动回收[id].二级药 == 1 then
                        local 临时银子 = 自定义回收价格.二级药
                        if self.数据[v].数量 ~= nil and self.数据[v].数量>0 then
                                临时银子 = self.数据[v].数量 * 自定义回收价格.二级药
                        end
                        添加银子 =添加银子 + 临时银子
                        self.数据[v]=nil
                        玩家数据[id].角色.数据.道具[k]=nil

                elseif (self.数据[v].名称 == "金刚石" or self.数据[v].名称 == "定魂珠"
                      or self.数据[v].名称 == "夜光珠" or self.数据[v].名称 == "避水珠"
                      or self.数据[v].名称 == "龙鳞") and 自动回收[id].五宝 == 1 then
                            local 临时银子 = 自定义回收价格.五宝
                            if self.数据[v].数量 ~= nil and self.数据[v].数量>0 then
                                临时银子 = self.数据[v].数量 * 自定义回收价格.五宝
                            end
                            添加银子 =添加银子 + 临时银子
                            self.数据[v]=nil
                            玩家数据[id].角色.数据.道具[k]=nil
                elseif (self.数据[v].名称 == "红玛瑙" or self.数据[v].名称 == "太阳石"
                      or self.数据[v].名称 == "舍利子" or self.数据[v].名称 == "黑宝石"
                      or self.数据[v].名称 == "月亮石" or self.数据[v].名称 == "星辉石"
                      or self.数据[v].名称 == "光芒石") and 自动回收[id].宝石 == 1 then
                          添加银子 =添加银子 + self.数据[v].级别限制*自定义回收价格.宝石
                          self.数据[v]=nil
                          玩家数据[id].角色.数据.道具[k]=nil
                elseif (self.数据[v].名称 == "制造指南书" or self.数据[v].名称 == "百炼精铁"
                    or self.数据[v].名称 == "灵饰指南书" or self.数据[v].名称 == "元灵晶石")
                    and 自动回收[id].书铁 == 1 then
                          添加银子 =添加银子 +self.数据[v].子类*自定义回收价格.书铁
                          self.数据[v]=nil
                          玩家数据[id].角色.数据.道具[k]=nil
                elseif self.数据[v].名称 == "超级金柳露" and 自动回收[id].超级金柳露 == 1 then
                          local 临时银子 = 自定义回收价格.超级金柳露
                          if self.数据[v].数量 ~= nil and self.数据[v].数量>0 then
                            临时银子 = self.数据[v].数量 * 自定义回收价格.超级金柳露
                          end
                          添加银子 =添加银子 + 临时银子
                          self.数据[v]=nil
                          玩家数据[id].角色.数据.道具[k]=nil
                 elseif (self.数据[v].名称 == "飞刀" or self.数据[v].名称 == "顺逆神针"
                    or self.数据[v].名称 == "飞蝗石" or self.数据[v].名称 == "铁蒺藜"
                    or self.数据[v].名称 == "无影神针" or self.数据[v].名称 == "孔雀翎"
                    or self.数据[v].名称 == "含沙射影" or self.数据[v].名称 == "回龙摄魂标"
                    or self.数据[v].名称 == "寸阴若梦" or self.数据[v].名称 == "魔睛子")
                    and 自动回收[id].暗器 == 1 then
                      添加银子 =添加银子 +自定义回收价格.暗器
                      self.数据[v]=nil
                      玩家数据[id].角色.数据.道具[k]=nil

                 elseif self.数据[v].名称 == "修炼果" and 自动回收[id].修练果 == 1  then
                          local 临时银子 = 自定义回收价格.修练果
                          if self.数据[v].数量 ~= nil and self.数据[v].数量>0 then
                            临时银子 = self.数据[v].数量 * 自定义回收价格.修练果
                          end
                          添加银子 =添加银子 + 临时银子
                          self.数据[v]=nil
                          玩家数据[id].角色.数据.道具[k]=nil

                 elseif (self.数据[v].名称 == "青龙石" or self.数据[v].名称 == "玄武石"
                    or self.数据[v].名称 == "朱雀石" or self.数据[v].名称 == "白虎石")
                    and 自动回收[id].强化石 == 1  then
                          local 临时银子 = 自定义回收价格.强化石
                          if self.数据[v].数量 ~= nil and self.数据[v].数量>0 then
                            临时银子 = self.数据[v].数量 * 自定义回收价格.强化石
                          end
                          添加银子 =添加银子 + 临时银子
                          self.数据[v]=nil
                          玩家数据[id].角色.数据.道具[k]=nil
                elseif self.数据[v].名称 == "月华露" and 自动回收[id].月华露 == 1  then
                          local 临时银子 = 自定义回收价格.月华露
                          local 临时数额 = 自定义回收价格.月华露
                           if self.数据[v].数量 ~= nil and self.数据[v].数量>0 then
                              临时银子 = self.数据[v].数量 * 自定义回收价格.月华露
                          end
                          if self.数据[v].阶品 ~= nil and self.数据[v].阶品>0 then
                              临时数额 = self.数据[v].阶品 * 临时银子
                          end
                          添加银子 =添加银子 + 临时数额
                          self.数据[v]=nil
                          玩家数据[id].角色.数据.道具[k]=nil

                  elseif (self.数据[v].名称 == "清灵净瓶" or self.数据[v].名称 == "初级清灵仙露") and 自动回收[id].清灵净瓶 == 1 then
                            local 临时银子 = 自定义回收价格.清灵净瓶
                            if self.数据[v].数量 ~= nil and self.数据[v].数量>0 then
                               临时银子 = self.数据[v].数量 * 自定义回收价格.清灵净瓶
                            end
                            添加银子 =添加银子 + 临时银子
                            self.数据[v]=nil
                            玩家数据[id].角色.数据.道具[k]=nil

                  elseif (self.数据[v].名称 == "中级清灵仙露" or self.数据[v].名称 == "高级清灵仙露") and 自动回收[id].清灵净瓶 == 1 then
                          local 临时银子 = 自定义回收价格.清灵净瓶
                          local 临时数额 = 自定义回收价格.清灵净瓶
                          if self.数据[v].数量 ~= nil and self.数据[v].数量>0 then
                             临时银子 = self.数据[v].数量 * 自定义回收价格.清灵净瓶
                          end
                           if self.数据[v].灵气 ~= nil and self.数据[v].灵气>0 then
                             临时数额 = self.数据[v].灵气 * 临时银子
                          end
                           添加银子 =添加银子 + 临时数额
                          self.数据[v]=nil
                          玩家数据[id].角色.数据.道具[k]=nil
                  elseif  self.数据[v].名称 == "九转金丹" and 自动回收[id].九转金丹 == 1 then
                          local 临时银子 = 自定义回收价格.九转金丹
                          local 临时数额 = 自定义回收价格.九转金丹
                           if self.数据[v].数量 ~= nil and self.数据[v].数量>0 then
                             临时银子 = self.数据[v].数量 * 自定义回收价格.九转金丹
                          end
                          if self.数据[v].阶品 ~= nil and self.数据[v].阶品>0 then
                            临时数额 = self.数据[v].阶品 * 临时银子
                          end
                          添加银子 =添加银子 + 临时数额
                          self.数据[v]=nil
                          玩家数据[id].角色.数据.道具[k]=nil
                  elseif self.数据[v].名称 == "召唤兽内丹" and 自动回收[id].低级内丹 == 1 then
                            添加银子 =添加银子 +自定义回收价格.低级内丹
                            self.数据[v]=nil
                            玩家数据[id].角色.数据.道具[k]=nil
                  elseif self.数据[v].名称 == "高级召唤兽内丹" and 自动回收[id].高级内丹 == 1 then
                              添加银子 =添加银子 +自定义回收价格.高级内丹
                              self.数据[v]=nil
                              玩家数据[id].角色.数据.道具[k]=nil
                  end

                  if self.数据[v] and self.数据[v].总类 == 2 and not self.数据[v].锦衣
                    and self.数据[v].级别限制 > 50 and self.数据[v].级别限制 <= 80 and 自动回收[id].环装 == 1 then
                      local 临时银子 = 自定义回收价格.环装
                      if self.数据[v].级别限制== 60 then
                          临时银子 = 自定义回收价格.环装
                      elseif self.数据[v].级别限制== 70 then
                              临时银子 = 自定义回收价格.环装*2
                      elseif self.数据[v].级别限制== 80 then
                              临时银子 = 自定义回收价格.环装*3
                      end
                      添加银子 =添加银子 +临时银子
                      self.数据[v]=nil
                      玩家数据[id].角色.数据.道具[k]=nil
                  end
            end
        end
        if 添加银子>0 then
          玩家数据[id].角色:添加银子(添加银子,"自动回收",1)
          道具刷新(id)
        end
end





function 道具处理类:一键回收(id)

           local 添加货币={点卡=0,仙玉=0,银子=0,银两=0,储备=0,经验=0}
           for k,v in pairs(玩家数据[id].角色.数据.道具) do
                if self.数据[v] and not self.数据[v].加锁 and self.数据[v].名称~="帮派银票" and self.数据[v].名称~="心魔宝珠" and
                  self.数据[v].名称~="神秘钥匙" and not string.find(self.数据[v].名称, "会员卡") then
                      local 名称 =  self.数据[v].名称
                      local 给予类型 =""
                      local 给予数额 = 0
                      if 自定义数据.一键回收配置[名称] and 自定义数据.一键回收配置[名称].货币 and 自定义数据.一键回收配置[名称].数量 then
                              给予类型 = 自定义数据.一键回收配置[名称].货币
                              if (名称=="钟灵石" or 名称=="钨金" or 名称=="珍珠" or 名称=="战魂" or 名称=="天眼珠" or 名称=="炼妖石"
                                or 名称=="精魄灵石" or 名称=="附魔宝珠" or 名称=="超级附魔宝珠" or 名称=="上古锻造图策" or 名称 == "红玛瑙"
                                or 名称 == "太阳石" or 名称 == "舍利子" or 名称 == "黑宝石" or 名称 == "月亮石" or 名称 == "星辉石"
                                or 名称 == "光芒石") and self.数据[v].级别限制 then
                                  给予数额=self.数据[v].级别限制*自定义数据.一键回收配置[名称].数量
                              elseif (名称=="制造指南书" or 名称=="灵饰指南书" or 名称=="元灵晶石" or 名称=="灵宝图鉴" or 名称=="神兵图鉴"
                                      or 名称=="灵饰图鉴" or 名称=="百炼精铁" or 名称=="灵犀玉") and self.数据[v].子类 then
                                      给予数额=self.数据[v].子类*自定义数据.一键回收配置[名称].数量
                              elseif (名称=="强化符" or 名称=="归墟之证" or 名称=="设计图" or 名称=="怪物卡片") and self.数据[v].等级 then
                                        给予数额=self.数据[v].等级*自定义数据.一键回收配置[名称].数量
                              elseif string.find(名称, "符石") ~= nil and  名称~="符石卷轴" and self.数据[v].级别 then
                                    给予数额=self.数据[v].级别*自定义数据.一键回收配置[名称].数量
                              elseif (名称=="烤肉" or 名称=="烤鸭" or 名称=="小还丹" or 名称=="金香玉" or 名称=="定神香" or 名称=="五龙丹" or 名称=="珍露酒"
                                        or 名称=="虎骨酒" or 名称=="豆斋果" or 名称=="佛跳墙" or 名称=="桂花丸" or 名称=="臭豆腐" or 名称=="长寿面" or 名称=="梅花酒"
                                        or 名称=="百味酒" or 名称=="蛇胆酒" or 名称=="月华露" or 名称=="醉生梦死" or 名称=="翡翠豆腐" or 名称=="蛇蝎美人"
                                        or 名称=="九转金丹" or 名称=="风水混元丹" or 名称=="十香返生丸" or 名称=="千年保心丹" or 名称=="九转回魂丹"
                                        or 名称=="佛光舍利子") and self.数据[v].阶品 then
                                        给予数额=self.数据[v].阶品*自定义数据.一键回收配置[名称].数量
                              else
                                  给予数额=自定义数据.一键回收配置[名称].数量
                              end
                      elseif not 自定义数据.一键回收配置[名称]  then
                              if (名称 == "金刚石" or 名称 == "定魂珠" or 名称 == "夜光珠" or 名称 == "避水珠"or 名称 == "龙鳞")
                                  and 自定义数据.一键回收配置.五宝  and 自定义数据.一键回收配置.五宝.货币 and 自定义数据.一键回收配置.五宝.数量 then
                                    给予类型 = 自定义数据.一键回收配置.五宝.货币
                                    给予数额 = 自定义数据.一键回收配置.五宝.数量
                              elseif (名称 == "红玛瑙" or 名称 == "太阳石" or 名称 == "舍利子" or 名称 == "黑宝石" or 名称 == "月亮石"
                                      or 名称 == "星辉石" or 名称 == "光芒石") and self.数据[v].级别限制 and 自定义数据.一键回收配置.宝石
                                      and 自定义数据.一键回收配置.宝石.货币 and 自定义数据.一键回收配置.宝石.数量 then
                                        给予类型 = 自定义数据.一键回收配置.宝石.货币
                                        给予数额 = self.数据[v].级别限制*自定义数据.一键回收配置.宝石.数量
                              elseif (名称 == "飞刀" or 名称 == "顺逆神针" or 名称 == "飞蝗石" or 名称 == "铁蒺藜" or 名称 == "无影神针"
                                      or 名称 == "孔雀翎" or 名称 == "含沙射影" or 名称 == "回龙摄魂标" or 名称 == "寸阴若梦" or 名称 == "魔睛子")
                                      and 自定义数据.一键回收配置.暗器 and 自定义数据.一键回收配置.暗器.货币 and 自定义数据.一键回收配置.暗器.数量 then
                                        给予类型 = 自定义数据.一键回收配置.暗器.货币
                                        给予数额 = 自定义数据.一键回收配置.暗器.数量

                              elseif (名称=="烤肉" or 名称=="烤鸭" or 名称=="珍露酒" or 名称=="虎骨酒" or 名称=="豆斋果" or 名称=="佛跳墙"
                                      or 名称=="桂花丸" or 名称=="臭豆腐" or 名称=="长寿面" or 名称=="梅花酒" or 名称=="百味酒" or 名称=="蛇胆酒"
                                      or 名称=="醉生梦死" or 名称=="翡翠豆腐") and self.数据[v].阶品 and 自定义数据.一键回收配置.烹饪
                                      and 自定义数据.一键回收配置.烹饪.货币 and 自定义数据.一键回收配置.烹饪.数量  then
                                        给予类型 = 自定义数据.一键回收配置.烹饪.货币
                                        给予数额 = self.数据[v].阶品*自定义数据.一键回收配置.烹饪.数量
                              elseif (名称 == "青龙石" or 名称 == "玄武石" or 名称 == "朱雀石" or 名称 == "白虎石") and 自定义数据.一键回收配置.强化石
                                      and 自定义数据.一键回收配置.强化石.货币 and 自定义数据.一键回收配置.强化石.数量  then
                                        给予类型 = 自定义数据.一键回收配置.强化石.货币
                                        给予数额 = 自定义数据.一键回收配置.强化石.数量
                              elseif (名称 == "孔雀红" or 名称 == "鹿茸" or 名称 == "仙狐涎" or 名称 == "地狱灵芝" or 名称 == "六道轮回" or 名称 == "凤凰尾"
                                      or 名称 == "火凤之睛" or 名称 == "龙之心屑" or 名称 == "紫石英" or 名称 == "白露为霜" or 名称 == "天不老" or 名称 == "血色茶花"
                                      or 名称 == "熊胆" or 名称 == "硫磺草" or 名称 == "丁香水"  or 名称 == "月星子" or 名称 == "麝香" or 名称 == "血珊瑚"
                                      or 名称 == "餐风饮露" or 名称 == "天龙水") and 自定义数据.一键回收配置.二级药 and 自定义数据.一键回收配置.二级药.货币
                                      and 自定义数据.一键回收配置.二级药.数量  then
                                        给予类型 = 自定义数据.一键回收配置.二级药.货币
                                        给予数额 = 自定义数据.一键回收配置.二级药.数量
                              elseif (名称=="小还丹" or 名称=="金香玉" or 名称=="定神香" or 名称=="五龙丹" or 名称=="蛇蝎美人" or 名称=="风水混元丹"
                                      or 名称=="十香返生丸" or 名称=="千年保心丹" or 名称=="九转回魂丹" or 名称=="佛光舍利子") and self.数据[v].阶品
                                      and 自定义数据.一键回收配置.三级药 and 自定义数据.一键回收配置.三级药.货币 and 自定义数据.一键回收配置.三级药.数量  then
                                        给予类型 = 自定义数据.一键回收配置.三级药.货币
                                        给予数额 = self.数据[v].阶品*自定义数据.一键回收配置.三级药.数量
                              elseif self.数据[v].总类 == 2 and not self.数据[v].锦衣 and self.数据[v].级别限制  then
                                      local 装备配置 = 自定义数据.一键回收配置[self.数据[v].级别限制.."级装备"]
                                      local 宠物配置 = 自定义数据.一键回收配置[self.数据[v].级别限制.."级宠物装备"]
                                      local 灵饰配置 = 自定义数据.一键回收配置[self.数据[v].级别限制.."级灵饰"]
                                      if self.数据[v].分类>=1 and self.数据[v].分类<=6 and 装备配置 and 装备配置.货币 and 装备配置.数量 then
                                            给予类型 = 装备配置.货币
                                            给予数额 = self.数据[v].级别限制*装备配置.数量
                                      elseif self.数据[v].分类>=7 and self.数据[v].分类<=9 and 宠物配置 and 宠物配置.货币 and 宠物配置.数量 then
                                              给予类型 = 宠物配置.货币
                                              给予数额 = self.数据[v].级别限制*宠物配置.数量
                                      elseif self.数据[v].灵饰 and 灵饰配置 and 灵饰配置.货币 and 灵饰配置.数量 then
                                              给予类型 = 灵饰配置.货币
                                              给予数额 = self.数据[v].级别限制*灵饰配置.数量
                                      end
                              end
                      end
                      if 给予类型~="" and 给予数额~=0 and 添加货币[给予类型] then
                          if self.数据[v].可叠加 and self.数据[v].数量 and type(self.数据[v].数量)=="number" then
                              给予数额=给予数额*self.数据[v].数量
                          end
                          self.数据[v]=nil
                          玩家数据[id].角色.数据.道具[k]=nil
                          添加货币[给予类型]=添加货币[给予类型]+给予数额
                      end


                end
            end
            if 添加货币.点卡>0 then
                共享货币[玩家数据[id].账号]:添加点卡(math.floor(添加货币.点卡),id,"一键回收")
            end
            if 添加货币.仙玉>0 then
                共享货币[玩家数据[id].账号]:添加仙玉(math.floor(添加货币.仙玉),id,"一键回收")
            end
            if 添加货币.银子>0 or 添加货币.银两>0 then
                local 临时数额 = 添加货币.银子+添加货币.银两
                玩家数据[id].角色:添加银子(临时数额,"一键回收",1)
            end
            if  添加货币.储备>0 then
                   玩家数据[id].角色:添加储备(添加货币.储备,"一键回收",1)
            end
            if  添加货币.经验>0 then
                玩家数据[id].角色.数据.当前经验 = 玩家数据[id].角色.数据.当前经验+添加货币.经验
                常规提示(id,"#Y你获得了#R"..添加货币.经验.."#Y点经验")
            end
            道具刷新(id)

end







function 道具处理类:领取铃铛奖励(连接id,数字id,数据)
  if 铃铛记录[数字id] == nil then
    常规提示(数字id,"该奖励已经被领取，请勿重复领取")
  end
  local 选中=数据.选中+0
  local 选中道具=铃铛记录[数字id][选中]
  玩家数据[数字id].道具:给予道具(数字id,选中道具.名称,选中道具.数量 or 1,选中道具.阶品)
  铃铛记录[数字id]=nil
  常规提示(数字id,"恭喜你获得了#R"..选中道具.名称)
  if 选中道具.名称 == "高级魔兽要诀" or 选中道具.名称 == "特赦令牌" or 选中道具.名称 == "高级召唤兽内丹" or 选中道具.名称 == "九转金丹" or 选中道具.名称 == "神兜兜" then
	广播消息({内容=format("#S(降妖伏魔)#Y恭喜玩家#R/%s#Y鸿运当头，在炼化铃铛时获得了珍贵的#G/%s#Y".."#"..取随机数(1,110),玩家数据[数字id].角色.数据.名称,选中道具.名称),频道="xt"})
  end
end

function 道具处理类:炼化铃铛(连接id,数字id,数据)
  local 道具id = 数据.铃铛+0
  local 铃铛数量 = self.数据[道具id].数量
  local 铃铛炼化数 = 数据.类型+0
  if 铃铛数量 < 铃铛炼化数 then
    常规提示(数字id,"你没有那么多铃铛！")
    return
  end
  self.数据[道具id].数量=self.数据[道具id].数量-铃铛炼化数
  local 临时数量=self.数据[道具id].数量
  if self.数据[道具id].数量 <= 0 then
    self.数据[道具id] = nil
  end
  道具刷新(数字id)
  self:刷新铃铛奖励(数字id,数据.类型+0)
  发送数据(连接id,3901,{物品id=道具id,铃铛个数=临时数量,奖励数据=铃铛记录[数字id]})
end

function 道具处理类:刷新铃铛奖励(数字id,铃铛数量)
  local x临时物品 = {}
  local id=数字id+0
  if 铃铛数量==nil then
    铃铛记录[id]=x临时物品
    return
  end

  for i=1,10 do
    x临时物品[#x临时物品+1]=铃铛奖励生成(id,"魔兽要诀",1)
    x临时物品[#x临时物品+1]=铃铛奖励生成(id,"藏宝图",1)
    x临时物品[#x临时物品+1]=铃铛奖励生成(id,"青龙石",铃铛数量*3)
    x临时物品[#x临时物品+1]=铃铛奖励生成(id,"玄武石",铃铛数量*3)
    x临时物品[#x临时物品+1]=铃铛奖励生成(id,"朱雀石",铃铛数量*3)
    x临时物品[#x临时物品+1]=铃铛奖励生成(id,"白虎石",铃铛数量*3)
    x临时物品[#x临时物品+1]=铃铛奖励生成(id,"金银锦盒",铃铛数量*5)
  end
  if 铃铛数量>=2 then
    for i=1,10 do
      x临时物品[#x临时物品+1]=铃铛奖励生成(id,"彩果",铃铛数量)
      x临时物品[#x临时物品+1]=铃铛奖励生成(id,"金柳露",铃铛数量*2)
    end
    for i=1,5 do
      x临时物品[#x临时物品+1]=铃铛奖励生成(id,"召唤兽内丹",1)
      x临时物品[#x临时物品+1]=铃铛奖励生成(id,"超级金柳露",math.floor(铃铛数量/2))
    end
  end
  if 铃铛数量>=3 then
    for i=1,5 do
      x临时物品[#x临时物品+1]=铃铛奖励生成(id,"神兜兜",math.floor(铃铛数量/2))
      x临时物品[#x临时物品+1]=铃铛奖励生成(id,"召唤兽内丹",1)
      x临时物品[#x临时物品+1]=铃铛奖励生成(id,"超级金柳露",铃铛数量)
    end
    for i=1,10 do
      x临时物品[#x临时物品+1]=铃铛奖励生成(id,"九转金丹",铃铛数量*50)
      x临时物品[#x临时物品+1]=铃铛奖励生成(id,"修炼果",1)
    end
  end
  if 铃铛数量>=4 then
    for i=1,3 do
      x临时物品[#x临时物品+1]=铃铛奖励生成(id,"高级魔兽要诀",1)
      x临时物品[#x临时物品+1]=铃铛奖励生成(id,"特赦令牌",1)
    end
  end
  if 铃铛数量>=5 then
    for i=1,3 do
      x临时物品[#x临时物品+1]=铃铛奖励生成(id,"高级召唤兽内丹",1)
    end
  end
  随机排序(x临时物品)
  铃铛记录[id]=x临时物品
end

function 道具处理类:装备翻转星石(数字id)
  local id = 数字id + 0

    local 装备道具 = self.数据[玩家数据[id].符石镶嵌]

    if 装备道具==nil then
    常规提示(id,"你没有这样的装备！")
    return
  elseif 装备道具.总类~=2 or 装备道具.灵饰 or 装备道具.分类==9 or 装备道具.分类==8 or 装备道具.分类==7 then
    常规提示(id,"我这里目前只能点化人物装备的星位，其它的我可没那么大的能耐。")
    return
  elseif not 装备道具.星位组 or 装备道具.星位==nil or 装备道具.星位[6]==nil then
    常规提示(id,"装备数据错误，请重新打开界面！")
    return
  end
  for n=1,6 do
    if 玩家数据[id].角色.数据.装备[n] == 玩家数据[id].符石镶嵌 then
         常规提示(id,"穿戴上的装备不能进行翻转")
         return
    end
  end
  if 玩家数据[id].角色:扣除体力(100,nil,1) then
    if 装备道具.星位组 and 装备道具.星位~=nil and 装备道具.星位[6]~=nil then
      if 装备道具.星位[6].阴阳 ==1 then
        装备道具.星位[6].阴阳 = 2
        装备道具.星位[6].颜色 = 取星位颜色(装备道具.分类)[2]
      else
        装备道具.星位[6].阴阳 = 1
        装备道具.星位[6].颜色 = 取星位颜色(装备道具.分类)[1]
      end
      装备道具.星位[6].相互 = nil
      local 等级计算 = 0
      for n=1,5 do
        if  装备道具.星位~=nil and 装备道具.星位[n]~=nil then
          等级计算 = 等级计算 + 装备道具.星位[n].符石等级
        end
      end
      if 等级计算~=0 then
        if 等级计算%2==0 then
          --偶数 反面
          if 装备道具.星位[6].阴阳==2 then
            装备道具.星位[6].相互={}
            装备道具.星位[6].相互[取星位相互(装备道具.分类)]=2
          end
        else
          if 装备道具.星位[6].阴阳==1 then
            装备道具.星位[6].相互={}
            装备道具.星位[6].相互[取星位相互(装备道具.分类)]=2
          end
        end
      end
    end
    常规提示(id,"翻转星位成功。")
    道具刷新(id)
    玩家数据[id].角色:刷新信息()
    -- 发送数据(玩家数据[id].连接id,777,玩家数据[id].角色:取套装数据())
    发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
    发送数据(玩家数据[id].连接id,3550,{装备=装备道具})
  else
    常规提示(id,"体力不足，无法翻转")
  end
end

function 道具处理类:翻转星石对话(id,道具id)
  local 装备道具 = self.数据[玩家数据[id].符石镶嵌]
    if 装备道具==nil then
    常规提示(id,"你没有这样的装备！")
    return
  elseif 装备道具.总类~=2 or 装备道具.灵饰 or 装备道具.分类==9 or 装备道具.分类==8 or 装备道具.分类==7 then
    常规提示(id,"我这里目前只能点化人物装备的星位，其它的我可没那么大的能耐。")
    return
  elseif not 装备道具.星位组 or 装备道具.星位==nil or 装备道具.星位[6]==nil then
    常规提示(id,"装备数据错误，请重新打开界面！")
    return
  end
  local 对话="#W/确定要将星石翻转吗？翻转星石不会引起星石自身属性变化，请放心操作。"
  local xx={"消耗100体力进行翻转","取消"}
    玩家数据[id].最后对话={}
  玩家数据[id].最后对话.名称="翻转星石"
  玩家数据[id].最后对话.模型=玩家数据[id].角色.模型
  发送数据(玩家数据[id].连接id,1501,{名称="翻转星石",模型=玩家数据[id].角色.模型,对话=对话,选项=xx})
end

function 道具处理类:合成符石(连接id,数字id,数据)
    local id = 数字id
    local 物品 = 数据.材料
    local 卷轴 = 0
    local 卷轴道具 = 0
    local 符石 = {}
    local 符石道具 = {}
    local f1,f2,f3=0,0,0
    local 道具格子 = 玩家数据[id].角色:取道具格子()
    if 道具格子 == 0 then
        常规提示(id,"你的道具栏已经满了,保留至少一格以上的位置进行合成哦")
        return
    end
    if 玩家数据[id].角色.数据.体力<40 then
      常规提示(id,"合成符石至少需要40点体力哦。")
      return
    end
    for k,v in pairs(物品) do
        local 道具id = 玩家数据[id].角色.数据.道具[v]
        if 道具id and self.数据[道具id] and self.数据[道具id].总类 == 889 and self.数据[道具id].分类 == 2 then
            if self.数据[道具id].子类==6 then
                  卷轴 = 道具id
                  卷轴道具 = v
            else
                  符石[#符石+1] = 道具id
                  符石道具[#符石道具+1] = v
                  if self.数据[道具id].子类==1 then
                     f1=f1+1
                  elseif self.数据[道具id].子类==2 then
                     f2=f2+1
                  elseif self.数据[道具id].子类==3 then
                     f3=f3+1
                  end
            end
        else
            常规提示(id,"少侠，给的物品不对哦。")
            return
        end
    end
    local 是否合成 = false
    if 卷轴~=0 then
       if f1>=3 then
          是否合成 = 1
       elseif f2>=3 then
          是否合成 = 2
       elseif f3==2 then
            是否合成 = 3
       elseif f3>=3 then
            是否合成 = 4
       else
          常规提示(id,"请仔细查看放入的材料是否正确。")
          return
       end
    else
        常规提示(id,"未找到符石卷轴。")
        return
    end
    玩家数据[id].角色:扣除体力(40,nil,1)
    local 成功率 = 0
    local 给予名称 = ""
    local 概率范围 = 取随机数(1,100)
    if 是否合成 == 1 then
        成功率 = 60
        给予名称 = "二级未激活符石"
    elseif 是否合成 == 2 then
          成功率 = 40
          给予名称 = "三级未激活符石"
    elseif 是否合成 == 3 then
            成功率 = 10
            给予名称 = 新三级符石[取随机数(1,#新三级符石)]
    elseif 是否合成 == 4 then
            成功率 = 20
            给予名称 = "未激活的星石"
    end
    if 成功率~=0 and 给予名称~="" then
        if 概率范围 <= 成功率 then
            for i=1,#符石 do
                if self.数据[符石[i]].数量 ==nil then
                    self.数据[符石[i]] = nil
                    玩家数据[id].角色.数据.道具[符石道具[i]] = nil
                else
                    self.数据[符石[i]].数量 = self.数据[符石[i]].数量 - 1
                    if  self.数据[符石[i]].数量 < 1 then
                        self.数据[符石[i]] = nil
                        玩家数据[id].角色.数据.道具[符石道具[i]] = nil
                    end
                end
            end
            self.数据[卷轴].数量 = self.数据[卷轴].数量-1
            if self.数据[卷轴].数量 < 1 then
                self.数据[卷轴] = nil
                玩家数据[id].角色.数据.道具[卷轴道具] = nil
            end
            self:给予道具(id,给予名称)
            常规提示(id,"合成成功")
        else
            self.数据[卷轴].数量 = self.数据[卷轴].数量-1
            if self.数据[卷轴].数量 < 1 then
              self.数据[卷轴] = nil
            end
            local 随机扣除=符石[取随机数(1,#符石)]
            if self.数据[随机扣除].数量 ==nil then
                  self.数据[随机扣除] = nil
            else
                self.数据[随机扣除].数量 = self.数据[随机扣除].数量 - 1
                if self.数据[随机扣除].数量 < 1 then
                   self.数据[随机扣除] = nil
                end
            end
            道具刷新(id)
            常规提示(id,"合成失败，你因此损失了一个符石卷轴和一块符石")
        end
    end

end

function 道具处理类:装备镶嵌符石(数字id,数据)
  local id = 数字id + 0
    local 装备道具 = self.数据[玩家数据[id].符石镶嵌]
  local 符石操作序列 = 数据
  local 星石操作 = nil
  --判断装备是否可以镶嵌
  for n=1,6 do
    if 玩家数据[id].角色.数据.装备[n] == 玩家数据[id].符石镶嵌 then
         常规提示(id,"穿戴上的装备不能进行镶嵌")
         return
    end
  end
  if 装备道具==nil then
    常规提示(id,"你没有这样的装备！")
    return
  elseif 装备道具.总类~=2 or 装备道具.灵饰 or 装备道具.分类==9 or 装备道具.分类==8 or 装备道具.分类==7 then
    常规提示(id,"我这里目前只能点化人物装备的星位，其它的我可没那么大的能耐。")
    return
  end
  --
    if not 判断是否为空表(符石操作序列) then
      local 重复 = false
      for k,v in pairs(符石操作序列) do
      if 重复 then
        break
      end
          if v.方式=="镶嵌" then
            local 临时数据 = nil
            if v.背包类型=="道具" then
                临时数据=玩家数据[数字id].角色.数据.道具[v.物品id]
            else
                临时数据=玩家数据[数字id].角色.数据.行囊[v.物品id]
            end
            if self.数据[临时数据]==nil then
                常规提示(id,"道具数据异常，请重新打开界面进行操作。")
                return
            end
            if k<=5 and (self.数据[临时数据].总类~=889 or self.数据[临时数据].分类~=88) then
          常规提示(id,"镶嵌需要符石，请给予我符石道具。")
          return
        elseif k==6 and (self.数据[临时数据].总类~=889 or self.数据[临时数据].分类~=91) then
              常规提示(id,"镶嵌需要星石，请给予我星石道具。")
          return
            end
            for n,i in pairs(符石操作序列) do
          if k~=n and i.方式=="镶嵌" and v.背包类型==i.背包类型 and v.物品id==i.物品id then
            重复=true
            break
          end
            end
          end
      end
      if not 重复 then
      if 装备道具.星位==nil then
        装备道具.星位={组合="",部位="无",门派="无"}
      end
      for k,v in pairs(符石操作序列) do
        if v.方式=="扣除" then
          装备道具.星位[k]=nil
        elseif v.方式=="镶嵌" then
          local 临时数据 = nil
          if v.背包类型=="道具" then
            临时数据=玩家数据[数字id].角色.数据.道具[v.物品id]
          else
            临时数据=玩家数据[数字id].角色.数据.行囊[v.物品id]
          end
          if k==6 then
              装备道具.星位[k] = {}
              装备道具.星位[k].名称 = self.数据[临时数据].名称
              装备道具.星位[k].颜色 = 取星位颜色(self.数据[临时数据].子类)[2]
              装备道具.星位[k].阴阳 = 2
              local 临时属性 = 取星位属性(self.数据[临时数据].子类)
              装备道具.星位[k].符石属性={}
              装备道具.星位[k].符石属性[临时属性.名称]=临时属性.属性值
          else
              装备道具.星位[k]={颜色=self.数据[临时数据].颜色,名称=self.数据[临时数据].名称,符石属性=self.数据[临时数据].符石属性,符石等级=self.数据[临时数据].子类}
          end
           self.数据[临时数据]=nil
        end
      end
      if 装备道具.星位组 and 装备道具.星位~=nil and 装备道具.星位[6]~=nil then
        装备道具.星位[6].相互 = nil
        local 等级计算 = 0
        for n=1,5 do
          if  装备道具.星位~=nil and 装备道具.星位[n]~=nil then
            等级计算 = 等级计算 + (装备道具.星位[n].符石等级 or 0)
          end
        end
        if 等级计算~=0 then
          if 等级计算%2==0 then
            --偶数 反面
            if 装备道具.星位[6].阴阳==2 then
              装备道具.星位[6].相互={}
              装备道具.星位[6].相互[取星位相互(装备道具.分类)]=2
            end
          else
            if 装备道具.星位[6].阴阳==1 then
              装备道具.星位[6].相互={}
              装备道具.星位[6].相互[取星位相互(装备道具.分类)]=2
            end
          end
        end
      end
          常规提示(id,"镶嵌成功。")
          local 星位数据=取星位组合(装备道具.星位)
      if 星位数据 ~=nil then
        装备道具.星位.组合=星位数据.组合
        装备道具.星位.部位=星位数据.部位
        装备道具.星位.门派=星位数据.门派
        装备道具.星位.组合等级=星位数据.等级
        常规提示(id,"#Y你的这件装备似乎开启了神秘的力量")
      else
        装备道具.星位.组合=nil
        装备道具.星位.部位=nil
        装备道具.星位.门派=nil
        装备道具.星位.组合等级=nil
      end
      if 符石操作序列[6]~=nil then
        星石操作=true
      end
          道具刷新(id)
          玩家数据[id].角色:刷新信息()
      -- 发送数据(玩家数据[id].连接id,777,玩家数据[id].角色:取套装数据())
      -- 发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
          发送数据(玩家数据[id].连接id,3550,{装备=装备道具,星石操作=星石操作})
    else
      常规提示(id,"道具数据异常，请重新打开界面进行操作。")
      return
    end
    else
    常规提示(id,"道具数据异常，请重新打开界面进行操作。")
    return
    end
end





function 道具处理类:恢复物品(id)
  local 丢失道具 = {}
  for k,v in pairs(self.数据) do
      local 页数,格子=玩家数据[id].道具仓库:取存入格子()
      if 页数~=0 and 格子~=0 and 格子<=20 then
          local 物品id=k
          local 是否可用=true
          for a,b in pairs(玩家数据[id].角色.数据.道具) do
            if b == 物品id then
              是否可用=false
            end
          end
          for a,b in pairs(玩家数据[id].角色.数据.行囊) do
            if b == 物品id then
              是否可用=false
            end
          end
          for a,b in pairs(玩家数据[id].角色.数据.法宝) do
            if b == 物品id then
              是否可用=false
            end
          end
          for a,b in pairs(玩家数据[id].角色.数据.装备) do
            if b == 物品id then
              是否可用=false
            end
          end
          for a,b in pairs(玩家数据[id].角色.数据.灵饰) do
            if b == 物品id then
              是否可用=false
            end
          end
           for a,b in pairs(玩家数据[id].角色.数据.锦衣) do
            if b == 物品id then
              是否可用=false
            end
          end
          if 是否可用 then
              local 物品数据 = DeepCopy(self.数据[物品id])
              物品数据.识别码=取唯一识别码(id)
              if 物品数据.可叠加 and not 物品数据.数量 then
                  物品数据.数量=1
              end
              玩家数据[id].道具仓库.数据[页数][格子]=物品数据
              self.数据[物品id]=nil
              发送数据(玩家数据[id].连接id,38,{内容="#Y物品:#R" ..物品数据.名称.. "#Y已存入道具仓库#R"..页数.."#Y号仓库第#R"..格子.."#Y格",频道="xt"})
              玩家数据[id].角色:日志记录("[恢复物品]名称:"..物品数据.名称.."识别码:"..物品数据.识别码..",存放位置仓库第"..页数.."页,第"..格子.."格")
          end
      end
  end
   常规提示(id,"物品恢复完成,请注意查看聊天栏信息")
end


function 道具处理类:取恢复物品数量(id)
  local 数量=0
  for k,v in pairs(self.数据) do
      local 物品id=k
      local 是否可用=true
      for a,b in pairs(玩家数据[id].角色.数据.道具) do
        if b == 物品id then
          是否可用=false
        end
      end
      for a,b in pairs(玩家数据[id].角色.数据.行囊) do
        if b == 物品id then
          是否可用=false
        end
      end
      for a,b in pairs(玩家数据[id].角色.数据.法宝) do
        if b == 物品id then
          是否可用=false
        end
      end
      for a,b in pairs(玩家数据[id].角色.数据.装备) do
        if b == 物品id then
          是否可用=false
        end
      end
      for a,b in pairs(玩家数据[id].角色.数据.灵饰) do
        if b == 物品id then
          是否可用=false
        end
      end
       for a,b in pairs(玩家数据[id].角色.数据.锦衣) do
        if b == 物品id then
          是否可用=false
        end
      end
      if 是否可用 then
          数量=数量+1
      end
  end
  return 数量
end


function 道具处理类:整理背包(数字id,类型,多角色)
    local id = 数字id
    local 类型 = 类型
     local function 简易排序(a,b)
        return a.序号<b.序号
      end
    if 玩家数据[id].整理背包 ~= nil then
        if os.time()-玩家数据[id].整理背包 <= 10 then
            常规提示(id,"不要频繁点击整理请"..(10-(os.time()-玩家数据[id].整理背包)).."秒后再尝试！",多角色)
            return
        end
    end
    玩家数据[id].整理背包=os.time()
    if 类型 == "道具" then
          local data = {}
          for k,v in pairs(玩家数据[id].角色.数据.道具) do
            local 字符编码=string.byte(string.sub(self.数据[v].名称,1,2))
            if #self.数据[v].名称< 3 then
              字符编码=字符编码+string.byte(string.sub(self.数据[v].名称,1,2))
            else
               字符编码=字符编码+string.byte(string.sub(self.数据[v].名称,3,4))
            end
            if 自定义数据.背包整理配置 and 自定义数据.背包整理配置[self.数据[v].名称] then
                  字符编码=自定义数据.背包整理配置[self.数据[v].名称]
            else
                  字符编码=字符编码+#self.数据[v].名称+1000
                  if self.数据[v].总类==nil or type(self.数据[v].总类)~="number" then
                      字符编码=字符编码..9
                  else
                      字符编码=字符编码..self.数据[v].总类
                  end
                  if self.数据[v].分类==nil or type(self.数据[v].分类)~="number" then
                      字符编码=字符编码..9
                  else
                      字符编码=字符编码..self.数据[v].分类
                  end
                  if self.数据[v].子类==nil or type(self.数据[v].子类)~="number" then
                      字符编码=字符编码..9
                  else
                      字符编码=字符编码..self.数据[v].子类
                  end
            end
            字符编码=字符编码+0
            if string.find(self.数据[v].名称,"会员卡") then
                字符编码=0
            end
            data[#data+1]={内容=v,序号=字符编码}
            if self.数据[v]~=nil and self.数据[v].可叠加 and self.数据[v].数量~=nil and self.数据[v].数量<=999 then
                for i,n in pairs(玩家数据[id].角色.数据.道具) do
                  if k~=i and self.数据[n] and self.数据[n].可叠加 and self.数据[n].名称==self.数据[v].名称 and self.数据[n].数量  then
                       if self.数据[v].数量+self.数据[n].数量<=999 then
                             if self.数据[n].名称~= "元宵" and self.数据[n].名称~= "鸿蒙原石" and self.数据[n].名称~= "太初原石" then
                                if self.数据[v].阶品==nil then
                                    self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                                    玩家数据[id].角色.数据.道具[i]=nil
                                    self.数据[n]=nil
                                else
                                    if self.数据[v].阶品==self.数据[n].阶品 then
                                        self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                                        玩家数据[id].角色.数据.道具[i]=nil
                                        self.数据[n]=nil
                                    end
                                end
                              elseif self.数据[n].名称== "鸿蒙原石" and self.数据[v].附带词条 == self.数据[n].附带词条 and self.数据[v].数额 == self.数据[n].数额  then
                                    self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                                    玩家数据[id].角色.数据.道具[i]=nil
                                    self.数据[n]=nil
                              elseif self.数据[n].名称== "太初原石" and self.数据[v].附带词条 == self.数据[n].附带词条 then
                                    self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                                    玩家数据[id].角色.数据.道具[i]=nil
                                    self.数据[n]=nil
                              elseif self.数据[n].名称== "元宵" and self.数据[v].食材 == self.数据[n].食材 then
                                  self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                                  玩家数据[id].角色.数据.道具[i]=nil
                                  self.数据[n]=nil
                              end
                         end
                  end
              end
            end
          end
          table.sort(data,简易排序)
          local tabdata={}
          for k,v in pairs(data) do
            tabdata[#tabdata+1]=v.内容
          end
          玩家数据[id].角色.数据.道具=tabdata

        道具刷新(id,多角色)
        常规提示(id,"整理成功",多角色)
    elseif 类型 == "行囊" then
          local data = {}
          for k,v in pairs(玩家数据[id].角色.数据.行囊) do
            local 字符编码=string.byte(string.sub(self.数据[v].名称,1,2))
            if #self.数据[v].名称< 3 then
              字符编码=字符编码+string.byte(string.sub(self.数据[v].名称,1,2))
            else
               字符编码=字符编码+string.byte(string.sub(self.数据[v].名称,3,4))
            end
            if 自定义数据.背包整理配置 and 自定义数据.背包整理配置[self.数据[v].名称] then
                字符编码=自定义数据.背包整理配置[self.数据[v].名称]
            else
                字符编码=字符编码+#self.数据[v].名称+1000
                if self.数据[v].总类==nil or type(self.数据[v].总类)~="number" then
                  字符编码=字符编码..9
                else
                  字符编码=字符编码..self.数据[v].总类
                end
                if self.数据[v].分类==nil or type(self.数据[v].分类)~="number" then
                  字符编码=字符编码..9
                else
                  字符编码=字符编码..self.数据[v].分类
                end
                if self.数据[v].子类==nil or type(self.数据[v].子类)~="number" then
                  字符编码=字符编码..9
                else
                  字符编码=字符编码..self.数据[v].子类
                end
            end
            字符编码=字符编码+0
            data[#data+1]={内容=v,序号=字符编码}
            if self.数据[v]~=nil and self.数据[v].可叠加 and self.数据[v].数量~=nil and self.数据[v].数量<=999 then
              for i,n in pairs(玩家数据[id].角色.数据.行囊) do
                if k~=i and self.数据[n].可叠加 and self.数据[n].名称==self.数据[v].名称 and self.数据[n].数量~=nil   then
                 if self.数据[v].数量+self.数据[n].数量<=999 then
                       if self.数据[n].名称~= "元宵" and self.数据[n].名称~= "鸿蒙原石" and self.数据[n].名称~= "太初原石" then
                          if self.数据[v].阶品==nil then
                              self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                              玩家数据[id].角色.数据.行囊[i]=nil
                              self.数据[n]=nil
                          else
                              if  self.数据[v].阶品==self.数据[n].阶品 then
                                  self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                                  玩家数据[id].角色.数据.行囊[i]=nil
                                  self.数据[n]=nil
                              end
                          end
                        elseif self.数据[n].名称== "鸿蒙原石"  and self.数据[v].附带词条 == self.数据[n].附带词条 and self.数据[v].数额 == self.数据[n].数额  then
                            self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                            玩家数据[id].角色.数据.行囊[i]=nil
                            self.数据[n]=nil
                        elseif self.数据[n].名称== "太初原石" and self.数据[v].附带词条 == self.数据[n].附带词条 then
                            self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                            玩家数据[id].角色.数据.行囊[i]=nil
                            self.数据[n]=nil
                        elseif self.数据[n].名称== "元宵" and self.数据[v].食材 == self.数据[n].食材 then
                            self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                            玩家数据[id].角色.数据.行囊[i]=nil
                            self.数据[n]=nil
                        end
                   end
                end
              end
            end
          end
          table.sort(data,简易排序)
          local tabdata={}
          for k,v in pairs(data) do
            tabdata[#tabdata+1]=v.内容
          end
          玩家数据[id].角色.数据.行囊=tabdata
        道具刷新(id)
        常规提示(id,"整理成功",多角色)
    else
      常规提示(id,"数据异常,刷新失败",多角色)
    end
end




function 道具处理类:删除陨铁()
  for n, v in pairs(self.数据) do
      if self.数据[n].名称 == "陨铁" then
      self.数据[n]=nil
      return
    end
  end
end

function 道具处理类:判断是否有陨铁()
  for n, v in pairs(self.数据) do
      if self.数据[n].名称 == "陨铁" then
      return true
    end
  end
  return false
end

function 道具处理类:判断是否有天眼通符()
  for n, v in pairs(self.数据) do
      if self.数据[n].名称 == "天眼通符" then
      return true
    end
  end
  return false
end


function 道具处理类:删除强化石(数据)
  local 青龙石数量 = 数据.青龙石
  local 白虎石数量 = 数据.白虎石
  local 朱雀石数量 = 数据.朱雀石
  local 玄武石数量 = 数据.玄武石

  if 数据.青龙石 ~= 0 then
    for n, v in pairs(self.数据) do
        if self.数据[n].名称 == "青龙石" then
        if self.数据[n].数量 > 青龙石数量 then
          self.数据[n].数量 = self.数据[n].数量 - 青龙石数量
          break
        elseif self.数据[n].数量 <= 青龙石数量 then
          青龙石数量 = 青龙石数量 - self.数据[n].数量
          self.数据[n] = nil
          if 青龙石数量 == 0 then
            break
          end
        end
      end
    end
  end

  if 数据.白虎石 ~= 0 then
    for n, v in pairs(self.数据) do
        if self.数据[n].名称 == "白虎石" then
        if self.数据[n].数量 > 白虎石数量 then
          self.数据[n].数量 = self.数据[n].数量 - 白虎石数量
          break
        elseif self.数据[n].数量 <= 白虎石数量 then
          白虎石数量 = 白虎石数量 - self.数据[n].数量
          self.数据[n] = nil
          if 白虎石数量 == 0 then
            break
          end
        end
      end
    end
  end

  if 数据.朱雀石 ~= 0 then
    for n, v in pairs(self.数据) do
        if self.数据[n].名称 == "朱雀石" then
        if self.数据[n].数量 > 朱雀石数量 then
          self.数据[n].数量 = self.数据[n].数量 - 朱雀石数量
          break
        elseif self.数据[n].数量 <= 朱雀石数量 then
          朱雀石数量 = 朱雀石数量 - self.数据[n].数量
          self.数据[n] = nil
          if 朱雀石数量 == 0 then
            break
          end
        end
      end
    end
  end

  if 数据.玄武石 ~= 0 then
    for n, v in pairs(self.数据) do
        if self.数据[n].名称 == "玄武石" then
        if self.数据[n].数量 > 玄武石数量 then
          self.数据[n].数量 = self.数据[n].数量 - 玄武石数量
          break
        elseif self.数据[n].数量 <= 玄武石数量 then
          玄武石数量 = 玄武石数量 - self.数据[n].数量
          self.数据[n] = nil
          if 玄武石数量 == 0 then
            break
          end
        end
      end
    end
  end
end

function 道具处理类:判断强化石(数据)
  local 青龙石数量 = 0
  local 白虎石数量 = 0
  local 朱雀石数量 = 0
  local 玄武石数量 = 0
  local 判断 = nil
  if 数据.青龙石 ~= 0 then
    for n, v in pairs(self.数据) do
        if self.数据[n].名称 == "青龙石" then
        青龙石数量 = 青龙石数量 + self.数据[n].数量
      end
    end
    if 青龙石数量 < 数据.青龙石 then
      判断 = false
    else
      判断 = true
    end
  end

  if 数据.白虎石 ~= 0 then
    for n, v in pairs(self.数据) do
        if self.数据[n].名称 == "白虎石" then
        白虎石数量 = 白虎石数量 + self.数据[n].数量
      end
    end
    if 白虎石数量 < 数据.白虎石 then
      判断 = false
    else
      判断 = true
    end
  end

  if 数据.朱雀石 ~= 0 then
    for n, v in pairs(self.数据) do
        if self.数据[n].名称 == "朱雀石" then
        朱雀石数量 = 朱雀石数量 + self.数据[n].数量
      end
    end
    if 朱雀石数量 < 数据.朱雀石 then
      判断 = false
    else
      判断 = true
    end
  end

  if 数据.玄武石 ~= 0 then
    for n, v in pairs(self.数据) do
        if self.数据[n].名称 == "玄武石" then
        玄武石数量 = 玄武石数量 + self.数据[n].数量
      end
    end
    if 玄武石数量 < 数据.玄武石 then
      判断 = false
    else
      判断 = true
    end
  end

  return 判断
end

function 道具处理类:装备点化套装(连接id,数字id,数据)
  local 强化石 = {"青龙石","朱雀石","玄武石","白虎石"}
  local 套装类型 = 数据.套装
  local 宝珠id = 数据.宝珠数据
  local id = 数字id
  local 装备编号 = 玩家数据[id].角色.数据.道具[数据.装备]
  if not 装备编号 or 装备编号 ==0 then return end
  if not self.数据[装备编号] or self.数据[装备编号]==0 then return end
  if not 套装类型  then return end
  local 装备等级 = self.数据[装备编号].级别限制
  local 消耗石头 = self.数据[装备编号].分类
  if 消耗石头 ==3 or 消耗石头>=7 then 常规提示(id,"该物品无法附魔") return end
  local 强化石数据 = {青龙石=0,朱雀石=0,玄武石=0,白虎石=0}
  if 消耗石头 == 5 or 消耗石头 == 6 then
     消耗石头 = 3
  end
  强化石数据[强化石[消耗石头]] = math.floor(装备等级/10)
  if 数据.装备 == nil or 数据.套装==0 or 数据.套装==nil then
    常规提示(id,"道具数据异常，请重新打开界面进行操作。")
    return
  end
  if self.数据[宝珠id] == nil then
    常规提示(id,"道具数据异常，请重新打开界面进行操作。")
    return
  end
  if self.数据[宝珠id].名称~="附魔宝珠" and self.数据[宝珠id].名称~="超级附魔宝珠" then
    常规提示(id,"道具数据异常，请重新打开界面进行操作。")
    return
  end
  if 玩家数据[id].角色.数据.当前经验 < 装备等级*3000 then
    常规提示(id,"您的经验不足，无法进行点化。")
    return
  end
  if 玩家数据[id].角色.数据.银子 < 装备等级*5000 then
    常规提示(id,"您的银子不足，无法进行点化。")
    return
  end
  if self.数据[宝珠id].级别限制<self.数据[装备编号].级别限制 then
     常规提示(id,"你的附魔宝珠等级不够。")
    return
  end
  if self:判断强化石(强化石数据) == false then
    常规提示(id,"您的"..强化石[消耗石头].."不足，无法进行点化。")
    return
  end
  if (self.数据[装备编号].祈福值==nil or self.数据[装备编号].祈福值==0 or self.数据[装备编号].祈福值 < 30) and self.数据[宝珠id].名称~="超级附魔宝珠" then
      self.数据[宝珠id] = nil
      发送数据(连接id,3549)
       self:删除强化石(强化石数据)
      if 套装类型 == 1 then
        local 随机动物套 = 取所有动物套[取随机数(1,#取所有动物套)]
        self.数据[装备编号].套装效果={"变身术之",随机动物套}
      elseif 套装类型 == 2 then
        local 套装类型="追加法术"
        local 套装效果={
            追加法术={"横扫千军","善恶有报","惊心一剑","壁垒击破","满天花雨","浪涌","唧唧歪歪","五雷咒","龙卷雨击",
            "剑荡四方","裂石","烟雨剑法","天雷斩","力劈华山","夜舞倾城","上古灵符","叱咤风云","天降灵葫","月光","八凶法阵",
            "死亡召唤","天罗地网","夺命咒","落叶萧萧","落雷符","雨落寒沙","子母神针","苍茫树","飞砂走石","阎罗令","水攻","烈火","落岩",
            "雷击","泰山压顶","水漫金山","地狱烈火","奔雷咒"}
        }
          self.数据[装备编号].套装效果={套装类型,套装效果[套装类型][取随机数(1,#套装效果[套装类型])]}
      elseif 套装类型 == 4 then
          local 套装类型="附加状态"
          local 套装效果={
              附加状态={"金刚护法","金刚护体","生命之泉","炼气化神","普渡众生","定心术","碎星诀","变身","凝神术","逆鳞","不动如山","法术防御","明光宝烛","天神护体","移魂化骨","蜜润","杀气诀","韦陀护法","一苇渡江","天神护法","乘风破浪","魔息术","盘丝阵","炎护"}
          }
            self.数据[装备编号].套装效果={套装类型,套装效果[套装类型][取随机数(1,#套装效果[套装类型])]}
        end
      if self.数据[装备编号].祈福值 == nil then
        self.数据[装备编号].祈福值 = 0
      end
      self.数据[装备编号].祈福值 = self.数据[装备编号].祈福值 + 1
      玩家数据[id].角色:扣除经验(装备等级*3000,"点化套装",1)
      玩家数据[id].角色:扣除银子(装备等级*5000,"点化套装",1)
      道具刷新(id)
  else
    local 套装类型名称 = "变身术"
    local 选项 = {}
    if 套装类型 == 1 then
      for n=1,#取所有动物套 do
        table.insert(选项,取所有动物套[n])
      end
    elseif 套装类型 == 2 then
      套装类型名称 = "追加法术"
      追加法术={"横扫千军","善恶有报","惊心一剑","壁垒击破","满天花雨","浪涌","唧唧歪歪","谆谆教诲","五雷咒",
      "龙卷雨击","剑荡四方","裂石","烟雨剑法","天雷斩","力劈华山","夜舞倾城","上古灵符","叱咤风云","天降灵葫",
      "月光","八凶法阵","死亡召唤","天罗地网","夺命咒","落叶萧萧","落雷符","雨落寒沙","子母神针","苍茫树","飞砂走石","阎罗令",
      "水攻","烈火","落岩","雷击","泰山压顶","水漫金山","地狱烈火","奔雷咒"}
        for n=1,#追加法术 do
        table.insert(选项,追加法术[n])
      end
    elseif 套装类型 == 4 then
      套装类型名称 = "附加状态"
      附加状态={"金刚护法","金刚护体","生命之泉","炼气化神","普渡众生","定心术","碎星诀","变身","凝神术","逆鳞","不动如山","法术防御","明光宝烛","天神护体","移魂化骨","蜜润","杀气诀","韦陀护法","一苇渡江","天神护法","乘风破浪","魔息术","盘丝阵","炎护"}
        for n=1,#附加状态 do
        table.insert(选项,附加状态[n])
      end
    end
    table.insert(选项,"我暂时先不点化了")
    local 对话="装备祈福值已满，您可以选择一个自己想要的套装效果进行祈福：（正在点化：#Z/"..套装类型名称.."#W/）"
    玩家数据[数字id].点化套装数据 = 数据
    发送数据(玩家数据[数字id].连接id,1501,{名称="点化装备套装",模型=玩家数据[数字id].角色.数据.模型,对话=对话,选项=选项})
  end
end


function 道具处理类:一键回收跑商物品(连接id,id)  ---摩托修改 原吊游的商品-----
        for k,v in pairs(玩家数据[id].角色.数据.道具) do
            if self.数据[v] and (self.数据[v].名称=="商品棉布" or self.数据[v].名称=="商品佛珠" or self.数据[v].名称=="商品扇子" or self.数据[v].名称=="商品武器" or self.数据[v].名称=="商品纸钱"
                or self.数据[v].名称=="商品帽子" or self.数据[v].名称=="商品木材" or self.数据[v].名称=="商品人参" or self.数据[v].名称=="商品夜明珠" or self.数据[v].名称=="商品盐"
                or self.数据[v].名称=="商品鹿茸" or self.数据[v].名称=="商品铃铛" or self.数据[v].名称=="商品首饰" or self.数据[v].名称=="商品蜡烛" or self.数据[v].名称=="商品面粉"
                or self.数据[v].名称=="商品香油" or self.数据[v].名称=="商品珍珠" or self.数据[v].名称=="商品酒" or self.数据[v].名称=="商品符" or self.数据[v].名称=="商品麻线") then
                self.数据[v]=nil
                玩家数据[id].角色.数据.道具[k]=nil
            end
        end
        发送数据(玩家数据[id].连接id,3800)
        发送数据(玩家数据[id].连接id,3699)
end







function 道具处理类:摊位下架商品(连接id,id,数据)
  if 玩家数据[id].摊位数据==nil then return end
  if  数据.道具~=nil then --下架道具
    玩家数据[id].摊位数据.道具[数据.道具+0]=nil
    常规提示(id,"#Y/下架物品成功！")
  end
  if 数据.bb~=nil then
    local 编号=数据.bb+0
    玩家数据[id].摊位数据.bb[编号]=nil
    常规提示(id,"#Y/下架召唤兽成功！")
  end
  if 数据.打造~=nil then
    local 编号 = 数据.等级+0
   if 数据.打造=="打造技巧" then
      玩家数据[id].摊位数据.打造.打造技巧[编号] = nil
    elseif 数据.打造=="裁缝技巧"  then
      玩家数据[id].摊位数据.打造.裁缝技巧[编号] = nil
    elseif 数据.打造=="炼金术"  then
      玩家数据[id].摊位数据.打造.炼金术[编号] = nil
    elseif 数据.打造=="淬灵之术"  then
      玩家数据[id].摊位数据.打造.淬灵之术[编号] = nil
    end
  常规提示(id,"#Y/下架打造成功！")
  end
  玩家数据[id].摊位数据.更新=os.time()
  self:索要摊位数据(连接id,id,3517)
end





function 道具处理类:法宝合成(连接id,id,数据)
  local 道具id = 分割文本(数据.序列,",")
  local 临时id = {}
  local 找到内丹 = false
  local 合成费用 = 2000000
  local 合成体力 = 100

  if 玩家数据[id].角色.数据.完成法宝任务==nil then
     玩家数据[id].角色.数据.完成法宝任务 = 0
  end
  if 玩家数据[id].角色.数据.完成法宝任务 >=1 then
     常规提示(id,"少侠您已经完成了法宝合成,点我完成法宝任务吧#86")
     return
  end

  if 取银子(id) < 合成费用 then
      常规提示(id,"你银子不够200万")
      return
  end
  if 玩家数据[id].角色.数据.体力 < 合成体力 then
      常规提示(id,"你体力不够100点")
      return
  end
  for i=1,5 do
    道具id[i] = 道具id[i]+0
    临时id[i]=玩家数据[id].角色.数据.道具[道具id[i]]
    if self.数据[临时id[i]]~=nil and 道具id[i]~= 0 then
        if self.数据[临时id[i]].名称=="内丹" then
            找到内丹=true
        end
    end
  end
  if 找到内丹 then
      玩家数据[id].角色:扣除银子(合成费用,"法宝合成",1)
      玩家数据[id].角色.数据.体力=玩家数据[id].角色.数据.体力-合成体力
      for i=1,5 do
        道具id[i] = 道具id[i]+0
        临时id[i]=玩家数据[id].角色.数据.道具[道具id[i]]
        if self.数据[临时id[i]]~=nil and 道具id[i]~= 0 then
            self.数据[临时id[i]]=nil
        end
      end
      玩家数据[id].角色.数据.完成法宝任务 = 1
      常规提示(id,"恭喜少侠完成了法宝合成，请在此点击我选择完成法宝任务领取法宝哦")
      道具刷新(id)
  else
      常规提示(id,"缺少内丹材料，无法合成！")
      return
  end
end



function 道具处理类:武器染色处理(连接id,id,数据)
    if not 共享货币[玩家数据[id].账号] then return end
    local 道具id = 玩家数据[id].角色.数据.装备[3]
    if 共享货币[玩家数据[id].账号]:扣除仙玉(1000,"武器染色",id) then
        if not self.数据[道具id].染色组 then
            self.数据[道具id].染色组={}
        end
        self.数据[道具id].染色方案=数据.序列
        self.数据[道具id].染色组[1]=数据.序列1
        self.数据[道具id].染色组[2]=数据.序列2
        道具刷新(id)
        常规提示(id,"恭喜你，武器染色成功！快去看看武器的新造型吧！")
        发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
        发送数据(玩家数据[id].连接id,3504)
        地图处理类:更新武器(id,self.数据[玩家数据[id].角色.数据.装备[3]])
    end
end






function 道具处理类:坐骑染色处理(连接id,id,数据)
    local 编号 = 0
    for i=1,#玩家数据[id].角色.数据.坐骑列表 do
        if 玩家数据[id].角色.数据.坐骑列表[i].认证码 == 数据.序列 then
              编号 =i
        end
    end
    if 编号==0 then
        常规提示(id,"你没有该坐骑!")
        return
    end


    if 玩家数据[id].道具:消耗背包道具(id,"彩果",20) then
          if 玩家数据[id].角色.数据.坐骑列表[编号].染色方案==nil then
              玩家数据[id].角色.数据.坐骑列表[编号].染色方案=0
          end
          if 玩家数据[id].角色.数据.坐骑.染色方案==nil then
              玩家数据[id].角色.数据.坐骑.染色方案=0
          end
          玩家数据[id].角色.数据.坐骑列表[编号].染色方案=数据.序列1
          玩家数据[id].角色.数据.坐骑列表[编号].染色组={}
          玩家数据[id].角色.数据.坐骑列表[编号].染色组[1]=数据.序列2
          玩家数据[id].角色.数据.坐骑列表[编号].染色组[2]=数据.序列3
          玩家数据[id].角色.数据.坐骑列表[编号].染色组[3]=数据.序列4
          玩家数据[id].角色.数据.坐骑.染色方案=数据.序列1
          玩家数据[id].角色.数据.坐骑.染色组={}
          玩家数据[id].角色.数据.坐骑.染色组[1]=数据.序列2
          玩家数据[id].角色.数据.坐骑.染色组[2]=数据.序列3
          玩家数据[id].角色.数据.坐骑.染色组[3]=数据.序列4
          常规提示(id,"恭喜你！坐骑染色成功，快去看看你的坐骑的新颜色吧！")
          发送数据(玩家数据[id].连接id,60,玩家数据[id].角色.数据.坐骑)
          发送数据(玩家数据[id].连接id,61,玩家数据[id].角色.数据.坐骑列表)
          道具刷新(id)
          地图处理类:更新坐骑(id,玩家数据[id].角色.数据.坐骑)
    else
      常规提示(id,"坐骑染色需要#R20个#Y彩果,你没有那么多!")
    end
end

function 道具处理类:坐骑饰品染色处理(连接id,id,数据)
        local 编号 = 0
        for i=1,#玩家数据[id].角色.数据.坐骑列表 do
            if 玩家数据[id].角色.数据.坐骑列表[i].认证码 == 数据.序列 then
                  编号 =i
            end
        end
        if 编号==0 then
            常规提示(id,"你没有该坐骑!")
            return
        end
        if not 玩家数据[id].角色.数据.坐骑列表[编号].饰品 or not 玩家数据[id].角色.数据.坐骑列表[编号].饰品物件 then
            常规提示(id,"少侠是来寻我开心的么？你要染色的坐骑饰品呢!")
            return
        end
        if 玩家数据[id].道具:消耗背包道具(id,"彩果",20) then
            if 玩家数据[id].角色.数据.坐骑列表[编号].饰品物件.染色方案==nil then
                玩家数据[id].角色.数据.坐骑列表[编号].饰品物件.染色方案=0
            end
            if 玩家数据[id].角色.数据.坐骑.饰品物件.染色方案==nil then
                玩家数据[id].角色.数据.坐骑.饰品物件.染色方案=0
            end
            玩家数据[id].角色.数据.坐骑列表[编号].饰品物件.染色方案=数据.序列1
            玩家数据[id].角色.数据.坐骑列表[编号].饰品物件.染色组={}
            玩家数据[id].角色.数据.坐骑列表[编号].饰品物件.染色组[1]=数据.序列2
            玩家数据[id].角色.数据.坐骑列表[编号].饰品物件.染色组[2]=数据.序列3
            玩家数据[id].角色.数据.坐骑列表[编号].饰品物件.染色组[3]=数据.序列4
            玩家数据[id].角色.数据.坐骑.饰品物件.染色方案=数据.序列1
            玩家数据[id].角色.数据.坐骑.饰品物件.染色组={}
            玩家数据[id].角色.数据.坐骑.饰品物件.染色组[1]=数据.序列2
            玩家数据[id].角色.数据.坐骑.饰品物件.染色组[2]=数据.序列3
            玩家数据[id].角色.数据.坐骑.饰品物件.染色组[3]=数据.序列4
            常规提示(id,"恭喜你！坐骑饰品染色成功，快去看看你的坐骑的新颜色吧！")
            发送数据(玩家数据[id].连接id,60,玩家数据[id].角色.数据.坐骑)
            发送数据(玩家数据[id].连接id,61,玩家数据[id].角色.数据.坐骑列表)
            道具刷新(id)
            地图处理类:更新坐骑(id,玩家数据[id].角色.数据.坐骑)
        else
            常规提示(id,"坐骑饰品染色需要#R20个#Y彩果,你没有那么多!")
        end
end

function 道具处理类:给予暗器(id,等级)
  local 名称="飞刀"
  if 等级==1 then
    名称="飞刀"
  elseif 等级==10 then
    名称="顺逆神针"
  elseif 等级==2 then
    名称="飞蝗石"
  elseif 等级==3 then
    名称="铁蒺藜"
  elseif 等级==4 then
    名称="无影神针"
  elseif 等级==5 then
    名称="孔雀翎"
  elseif 等级==6 then
    名称="含沙射影"
  elseif 等级==7 then
    名称="回龙摄魂标"
  elseif 等级==8 then
    名称="寸阴若梦"
  elseif 等级==9 then
    名称="魔睛子"
  end
  常规提示(id,"#Y你获得了#R"..名称)
  self:给予道具(id,名称)
end


function 道具处理类:使用法宝(连接id,id,编号)
  local 道具id=玩家数据[id].角色.数据.法宝[编号]
  if 道具id==nil or self.数据[道具id]==nil then
    常规提示(id,"#Y你没有这件法宝")
    self:索要法宝(连接id,id)
    return
  end
  local 名称=self.数据[道具id].名称
  if 名称=="五色旗盒" then
    if self.数据[道具id].魔法<=0 then
      常规提示(id,"#Y你的法宝灵气不足")
      return
    elseif 玩家数据[id].角色.数据.等级<30 then
      常规提示(id,"#Y你的等级不足以使用此法宝")
      return
    end
    local aa ="请选择你要进行的操作："
    local xx={"合成导标旗","补充合成旗"}
    发送数据(连接id,1501,{名称="五色旗盒",对话=aa,选项=xx})
    玩家数据[id].最后操作="合成旗1"
    玩家数据[id].法宝id=编号
    return
  elseif 名称=="月光宝盒" then
    if self.数据[道具id].魔法<=0 then
      常规提示(id,"#Y你的法宝灵气不足")
      return
    end
    if 玩家数据[id].角色.数据.等级<30 then
      常规提示(id,"#Y你的等级不足以使用此法宝")
      return
    end
    local aa ="请选择你要进行的操作："
    local xx={"送我过去","在这里定标"}
    发送数据(连接id,1501,{名称="月光宝盒",对话=aa,选项=xx})
    玩家数据[id].最后操作="月光宝盒"
    玩家数据[id].法宝id=编号
    return
  end
  常规提示(id,"#Y此类型法宝当前不可用")
  return
end


function 道具处理类:佩戴法宝(连接id,id,类型,编号,多角色)
  if 玩家数据[id].角色.数据.法宝[编号] == nil then
    if 多角色~=nil then
        发送数据(玩家数据[多角色].连接id,6010,{角色=id,道具=self:索要法宝(玩家数据[id].连接id,id,多角色)})
    else
       self:索要法宝(连接id,id)
    end
    return
  end
  local 道具id=玩家数据[id].角色.数据.法宝[编号]
  if 道具id == nil or self.数据[道具id] == nil then
    if 多角色~=nil then
      发送数据(玩家数据[多角色].连接id,6010,{角色=id,道具=self:索要法宝(玩家数据[id].连接id,id,多角色)})
    else
       self:索要法宝(连接id,id)
    end
    return
  end
  if not self.数据[道具id].特技 then
    self.数据[道具id]=nil
    常规提示(id,"#Y该法宝数据问题已删除法宝",多角色)
    if 多角色~=nil then
      发送数据(玩家数据[多角色].连接id,6010,{角色=id,道具=self:索要法宝(玩家数据[id].连接id,id,多角色)})
    else
       self:索要法宝(连接id,id)
    end
    return
  end

  if 玩家数据[id].角色.数据.等级<self.数据[道具id].特技 then
      常规提示(id,"#Y你当前的等级无法佩戴此类型的法宝",多角色)
      return
  end
  local 名称=self.数据[道具id].名称
  local 门派=玩家数据[id].角色.数据.门派
  if self:取法宝门派(名称) ~= "无门派" and 门派 ~= self:取法宝门派(名称) then --测试
    常规提示(id,"#Y你无法佩戴这个门派的法宝",多角色)
    self:索要法宝(连接id,id)
    return
  end

 local 数量 = 0
  for n=1,4 do
      if 玩家数据[id].角色.数据.法宝佩戴[n] ~= nil and self.数据[玩家数据[id].角色.数据.法宝佩戴[n]]~=nil then
          if self.数据[玩家数据[id].角色.数据.法宝佩戴[n]].分类 == self.数据[道具id].分类 then
              数量=数量+1
          end
          -- if self.数据[玩家数据[id].角色.数据.法宝佩戴[n]].名称 == 名称 then
          --   名称数量=名称数量+1
          -- end
      end
  end
  if 数量>=2 then
      常规提示(id,"#Y此类型法宝只能同时佩戴两件",多角色)
      return
  end




  玩家数据[id].角色.数据.法宝[编号]=nil
  local 佩戴格子=0
  for n=1,4 do
    if 玩家数据[id].角色.数据.法宝佩戴[n]==nil then 佩戴格子=n end
  end
  if 佩戴格子==0 then
     玩家数据[id].角色.数据.法宝[编号]=玩家数据[id].角色.数据.法宝佩戴[4]
     佩戴格子=4
  end
  玩家数据[id].角色.数据.法宝佩戴[佩戴格子]=道具id
  if 多角色~=nil then
      发送数据(玩家数据[多角色].连接id,6010,{角色=id,道具=self:索要法宝(玩家数据[id].连接id,id,多角色)})
  else
      self:索要法宝(连接id,id)
  end

end


function 道具处理类:替换法宝(连接id,id,编号,编号1,多角色)
  local 道具id=玩家数据[id].角色.数据.法宝[编号]
   if 道具id==nil or self.数据[道具id]==nil then
      常规提示(id,"#Y你没有这件法宝",多角色)
      self:索要法宝(连接id,id)
      return
  end
  if not self.数据[道具id].特技 then
    self.数据[道具id]=nil
    常规提示(id,"#Y该法宝数据问题已删除法宝",多角色)
    self:索要法宝(连接id,id)
    return
  end
  if 玩家数据[id].角色.数据.等级<self.数据[道具id].特技 then
      常规提示(id,"#Y你当前的等级无法佩戴此类型的法宝",多角色)
      return
  end
  local 名称=self.数据[道具id].名称
  local 门派=玩家数据[id].角色.数据.门派
  if self:取法宝门派(名称) ~= "无门派" and 门派 ~= self:取法宝门派(名称) then --测试
    常规提示(id,"#Y你无法佩戴这个门派的法宝",多角色)
    self:索要法宝(连接id,id)
    return
  end

  local 数量 = 0
  for n=1,4 do
      if 玩家数据[id].角色.数据.法宝佩戴[n] ~= nil and self.数据[玩家数据[id].角色.数据.法宝佩戴[n]]~=nil then
          if self.数据[玩家数据[id].角色.数据.法宝佩戴[n]].分类 == self.数据[道具id].分类 then
              数量=数量+1
          end
          -- if self.数据[玩家数据[id].角色.数据.法宝佩戴[n]].名称 == 名称 then
          --   名称数量=名称数量+1
          -- end
      end
  end
  if 数量>=2 then
      常规提示(id,"#Y此类型法宝只能同时佩戴两件",多角色)
      return
  end


  if 玩家数据[id].角色.数据.法宝佩戴[编号1]==nil then
      玩家数据[id].角色.数据.法宝佩戴[编号1]=玩家数据[id].角色.数据.法宝[编号]
      玩家数据[id].角色.数据.法宝[编号]=nil
  else
      local 临时编号=玩家数据[id].角色.数据.法宝[编号]
      玩家数据[id].角色.数据.法宝[编号]=玩家数据[id].角色.数据.法宝佩戴[编号1]
      玩家数据[id].角色.数据.法宝佩戴[编号1]=临时编号
  end
  if 多角色~=nil then
    发送数据(玩家数据[多角色].连接id,6010,{角色=id,道具=self:索要法宝(玩家数据[id].连接id,id,多角色)})
  else
     self:索要法宝(连接id,id)
  end

end

function 道具处理类:替换灵宝(连接id,id,编号,编号1)

  local 道具id=玩家数据[id].角色.数据.灵宝[编号]
   if 道具id==nil or self.数据[道具id]==nil then
      常规提示(id,"#Y你没有这件灵宝")
      self:索要法宝(连接id,id)
      return
  end
 local 名称=self.数据[道具id].名称
 if self.数据[道具id].特技~="通用灵宝" and self.数据[道具id].特技~=玩家数据[id].角色.数据.门派 then
    常规提示(id,"#Y你无法佩戴这个门派灵宝")
    return

 end

 if  玩家数据[id].角色.数据.等级 <109 then
     常规提示(id,"#Y你的等级不够109级无法使用灵宝")
     return
 end
  for n=1,2 do
      if 玩家数据[id].角色.数据.灵宝佩戴[n] ~= nil and self.数据[玩家数据[id].角色.数据.灵宝佩戴[n]]~=nil then
          if self.数据[玩家数据[id].角色.数据.灵宝佩戴[n]].名称 == 名称 then
            常规提示(id,"#Y此类型灵宝只能同时佩戴两件")
            return
          end
      end
  end

  if 玩家数据[id].角色.数据.灵宝佩戴[编号1]==nil then
    玩家数据[id].角色.数据.灵宝佩戴[编号1]=玩家数据[id].角色.数据.灵宝[编号]
    玩家数据[id].角色.数据.灵宝[编号]=nil
  else
    local 临时编号=玩家数据[id].角色.数据.灵宝[编号]
    玩家数据[id].角色.数据.灵宝[编号]=玩家数据[id].角色.数据.灵宝佩戴[编号1]
    玩家数据[id].角色.数据.灵宝佩戴[编号1]=临时编号
  end

  self:索要法宝(连接id,id)


end


function 道具处理类:背包替换法宝(连接id,id,编号,编号1)
  local 道具id=玩家数据[id].角色.数据.法宝[编号1]
  if 道具id==nil or self.数据[道具id]==nil then
      常规提示(id,"#Y你没有这件法宝")
      self:索要法宝(连接id,id)
      return
  end
   if not self.数据[道具id].特技 then
      self.数据[道具id]=nil
      常规提示(id,"#Y该法宝数据问题已删除法宝")
      self:索要法宝(连接id,id)
    return
  end
  if 玩家数据[id].角色.数据.等级<self.数据[道具id].特技 then
      常规提示(id,"#Y你当前的等级无法佩戴此类型的法宝")
      return
  end
  local 名称=self.数据[道具id].名称
  local 门派=玩家数据[id].角色.数据.门派
  if self:取法宝门派(名称) ~= "无门派" and 门派 ~= self:取法宝门派(名称) then --测试
    常规提示(id,"#Y你无法佩戴这个门派的法宝")
    self:索要法宝(连接id,id)
    return
  end

  local 数量 = 0
  for n=1,4 do
      if 玩家数据[id].角色.数据.法宝佩戴[n] ~= nil and self.数据[玩家数据[id].角色.数据.法宝佩戴[n]]~=nil then
          if self.数据[玩家数据[id].角色.数据.法宝佩戴[n]].分类 == self.数据[道具id].分类 then
              数量=数量+1
          end
          -- if self.数据[玩家数据[id].角色.数据.法宝佩戴[n]].名称 == 名称 then
          --   名称数量=名称数量+1
          -- end
      end
  end
  if 数量>=2 then
      常规提示(id,"#Y此类型法宝只能同时佩戴两件")
      return
  end

  if 玩家数据[id].角色.数据.法宝[编号1]==nil then
    玩家数据[id].角色.数据.法宝[编号1]=玩家数据[id].角色.数据.法宝佩戴[编号]
    玩家数据[id].角色.数据.法宝佩戴[编号]=nil
  else
    local 临时编号=玩家数据[id].角色.数据.法宝佩戴[编号]
    玩家数据[id].角色.数据.法宝佩戴[编号]=玩家数据[id].角色.数据.法宝[编号1]
    玩家数据[id].角色.数据.法宝[编号1]=临时编号
  end
  self:索要法宝(连接id,id)
end

function 道具处理类:背包替换灵宝(连接id,id,编号,编号1)
  local 道具id=玩家数据[id].角色.数据.灵宝[编号1]
  if 道具id==nil or self.数据[道具id]==nil then
      常规提示(id,"#Y你没有这件灵宝")
      self:索要法宝(连接id,id)
      return
  end

 local 名称=self.数据[道具id].名称
 if self.数据[道具id].特技~="通用灵宝" and self.数据[道具id].特技~=玩家数据[id].角色.数据.门派 then
    常规提示(id,"#Y你无法佩戴这个门派灵宝")
    return

 end
 if  玩家数据[id].角色.数据.等级 <109 then
     常规提示(id,"#Y你的等级不够109级无法使用灵宝")
     return
 end

  for n=1,2 do
      if 玩家数据[id].角色.数据.灵宝佩戴[n] ~= nil and self.数据[玩家数据[id].角色.数据.灵宝佩戴[n]]~=nil then
          if self.数据[玩家数据[id].角色.数据.灵宝佩戴[n]].名称 == 名称 then
            常规提示(id,"#Y此类型灵宝只能同时佩戴两件")
            return
          end
      end
  end

  if 玩家数据[id].角色.数据.灵宝[编号1]==nil then
    玩家数据[id].角色.数据.灵宝[编号1]=玩家数据[id].角色.数据.灵宝佩戴[编号]
    玩家数据[id].角色.数据.灵宝佩戴[编号]=nil
  else
    local 临时编号=玩家数据[id].角色.数据.灵宝佩戴[编号]
    玩家数据[id].角色.数据.灵宝佩戴[编号]=玩家数据[id].角色.数据.灵宝[编号1]
    玩家数据[id].角色.数据.灵宝[编号1]=临时编号
  end
  self:索要法宝(连接id,id)
end

function 道具处理类:背包交换法宝(连接id,id,编号,编号1)
      if 玩家数据[id].角色.数据.法宝[编号1]~=nil then
          local 临时法宝=玩家数据[id].角色.数据.法宝[编号]
          玩家数据[id].角色.数据.法宝[编号]=玩家数据[id].角色.数据.法宝[编号1]
          玩家数据[id].角色.数据.法宝[编号1]=临时法宝
      else
          玩家数据[id].角色.数据.法宝[编号1]=玩家数据[id].角色.数据.法宝[编号]
          玩家数据[id].角色.数据.法宝[编号]=nil
      end
      self:索要法宝(连接id,id)
end
function 道具处理类:背包交换灵宝(连接id,id,编号,编号1)

  if 玩家数据[id].角色.数据.灵宝[编号1]~=nil then
      local 临时灵宝=玩家数据[id].角色.数据.灵宝[编号]
      玩家数据[id].角色.数据.灵宝[编号]=玩家数据[id].角色.数据.灵宝[编号1]
      玩家数据[id].角色.数据.灵宝[编号1]=临时灵宝
  else
      玩家数据[id].角色.数据.灵宝[编号1]=玩家数据[id].角色.数据.灵宝[编号]
      玩家数据[id].角色.数据.灵宝[编号]=nil
  end
  self:索要法宝(连接id,id)
end


function 道具处理类:交换法宝(连接id,id,编号,编号1)

  if 玩家数据[id].角色.数据.法宝佩戴[编号1]==nil then
      玩家数据[id].角色.数据.法宝佩戴[编号1]=玩家数据[id].角色.数据.法宝佩戴[编号]
      玩家数据[id].角色.数据.法宝佩戴[编号]=nil
  else
        local 临时法宝=玩家数据[id].角色.数据.法宝佩戴[编号]
        玩家数据[id].角色.数据.法宝佩戴[编号]=玩家数据[id].角色.数据.法宝佩戴[编号1]
        玩家数据[id].角色.数据.法宝佩戴[编号1]=临时法宝
  end
    self:索要法宝(连接id,id)
end



function 道具处理类:交换灵宝(连接id,id,编号,编号1)
  if 玩家数据[id].角色.数据.灵宝佩戴[编号1]==nil then
      玩家数据[id].角色.数据.灵宝佩戴[编号1]=玩家数据[id].角色.数据.灵宝佩戴[编号]
      玩家数据[id].角色.数据.灵宝佩戴[编号]=nil
    else
      local 临时灵宝=玩家数据[id].角色.数据.灵宝佩戴[编号]
      玩家数据[id].角色.数据.灵宝佩戴[编号]=玩家数据[id].角色.数据.灵宝佩戴[编号1]
      玩家数据[id].角色.数据.灵宝佩戴[编号1]=临时灵宝
    end
  self:索要法宝(连接id,id)
end




function 道具处理类:卸下法宝(连接id,id,编号,多角色)
  local 格子=玩家数据[id].角色:取法宝格子()
  if 格子==0 then
    常规提示(id,"#Y你的法宝栏已经满了",多角色)
    return false
  end
  玩家数据[id].角色.数据.法宝[格子]=玩家数据[id].角色.数据.法宝佩戴[编号]
  玩家数据[id].角色.数据.法宝佩戴[编号]=nil
  if 多角色~=nil then
     发送数据(玩家数据[多角色].连接id,6010,{角色=id,道具=self:索要法宝(玩家数据[id].连接id,id,多角色)})
  else
     self:索要法宝(连接id,id)
  end
   return true
end

function 道具处理类:卸下灵宝(连接id,id,编号)
  local 格子=玩家数据[id].角色:取灵宝格子()
  if 格子==0 then
    常规提示(id,"#Y你的灵宝栏已经满了")
    return false
  end
  玩家数据[id].角色.数据.灵宝[格子]=玩家数据[id].角色.数据.灵宝佩戴[编号]
  玩家数据[id].角色.数据.灵宝佩戴[编号]=nil
    self:索要法宝(连接id,id)
   return true
end
function 道具处理类:修炼法宝(连接id,id,编号,多角色)
  local 道具id=玩家数据[id].角色.数据.法宝[编号]
  if 道具id==nil or self.数据[道具id]==nil then
    常规提示(id,"#Y你没有这件法宝",多角色)
    if 多角色~=nil then
       道具刷新(id,多角色)
    else
       self:索要法宝(连接id,id)
    end

    return
  end
  local 上限=9
  if self.数据[道具id].分类==2 then
    上限=12
  elseif self.数据[道具id].分类==3 then
    上限=15
  elseif self.数据[道具id].分类==4 then
    上限=18
  end
  if self.数据[道具id].气血==上限 then
    常规提示(id,"#Y你的这件法宝已经满层了，无法再进行修炼",多角色)
    return
  end
  if not self.数据[道具id].升级经验  then
      self.数据[道具id]=nil
      常规提示(id,"#Y你的法宝数据问题,已回收",多角色)
      if 多角色~=nil then
         道具刷新(id,多角色)
      else
         self:索要法宝(连接id,id)
      end
   return
 end
  local 消耗经验=math.floor(self.数据[道具id].升级经验)
  -- if 消耗经验>10000000 then
  --   消耗经验=10000000
  -- end
  if 玩家数据[id].角色.数据.当前经验<消耗经验 then
    常规提示(id,"#Y本次修炼需要消耗#R"..消耗经验.."#Y点人物经验，您似乎没有那么多的经验哟",多角色)
    return
  end
  玩家数据[id].角色.数据.当前经验=玩家数据[id].角色.数据.当前经验-消耗经验
  玩家数据[id].角色:日志记录("修炼法宝["..self.数据[道具id].名称.."]消耗"..消耗经验.."点经验,剩余经验"..玩家数据[id].角色.数据.当前经验)
  常规提示(id,"#Y修炼成功,你消耗了#R"..消耗经验.."#Y了点人物经验",多角色)
  self.数据[道具id].当前经验=self.数据[道具id].当前经验+消耗经验
  if self.数据[道具id].当前经验>=self.数据[道具id].升级经验 then
    self.数据[道具id].气血=self.数据[道具id].气血+1
    self.数据[道具id].当前经验=self.数据[道具id].当前经验-self.数据[道具id].升级经验
    self.数据[道具id].魔法=取灵气上限(self.数据[道具id].分类)
    if self.数据[道具id].气血<上限 then
      self.数据[道具id].升级经验=法宝经验[self.数据[道具id].分类][self.数据[道具id].气血+1]
    end
    常规提示(id,"#Y你的法宝#R"..self.数据[道具id].名称.."#Y境界提升了",多角色)
  end
  if 多角色~=nil then
       发送数据(玩家数据[多角色].连接id,6002,{角色=id,角色属性=玩家数据[id].角色:取总数据()})
       发送数据(玩家数据[多角色].连接id,6011,{角色=id,id=编号,当前经验=self.数据[道具id].当前经验,升级经验=self.数据[道具id].升级经验,境界=self.数据[道具id].气血,灵气=self.数据[道具id].魔法})
    else
      发送数据(连接id,31,玩家数据[id].角色:取总数据())
      发送数据(连接id,3528,{id=编号,当前经验=self.数据[道具id].当前经验,升级经验=self.数据[道具id].升级经验,境界=self.数据[道具id].气血,灵气=self.数据[道具id].魔法})
    end
end
function 道具处理类:修炼灵宝(连接id,id,编号)
  local 道具id=玩家数据[id].角色.数据.灵宝[编号]
  if 道具id==nil or self.数据[道具id]==nil then
    常规提示(id,"#Y你没有这件法宝")
    -- if 多角色~=nil then
    --    道具刷新(id,多角色)
    -- else
       self:索要法宝(连接id,id)
    --end

    return
  end
  local 上限=9
  if self.数据[道具id].分类==2 then
    上限=12
  elseif self.数据[道具id].分类==3 then
    上限=15
  elseif self.数据[道具id].分类==4 then
    上限=18
  end
  if self.数据[道具id].气血==上限 then
    常规提示(id,"#Y你的这件灵宝已经满层了，无法再进行修炼")
    return
  end
  local 消耗经验=math.floor(self.数据[道具id].升级经验)
  -- if 消耗经验>10000000 then
  --   消耗经验=10000000
  -- end
  if 玩家数据[id].角色.数据.当前经验<消耗经验 then
    常规提示(id,"#Y本次修炼需要消耗#R"..消耗经验.."#Y点人物经验，您似乎没有那么多的经验哟",多角色)
    return
  end
  玩家数据[id].角色.数据.当前经验=玩家数据[id].角色.数据.当前经验-消耗经验
  玩家数据[id].角色:日志记录("修炼灵宝["..self.数据[道具id].名称.."]消耗"..消耗经验.."点经验,剩余经验"..玩家数据[id].角色.数据.当前经验)
  常规提示(id,"#Y修炼成功,你消耗了#R"..消耗经验.."#Y了点人物经验")
  self.数据[道具id].当前经验=self.数据[道具id].当前经验+消耗经验
  if self.数据[道具id].当前经验>=self.数据[道具id].升级经验 then
    self.数据[道具id].气血=self.数据[道具id].气血+1
    self.数据[道具id].当前经验=self.数据[道具id].当前经验-self.数据[道具id].升级经验
    self.数据[道具id].魔法=取灵气上限(self.数据[道具id].分类)
    if self.数据[道具id].气血<上限 then
      self.数据[道具id].升级经验=法宝经验[self.数据[道具id].分类][self.数据[道具id].气血+1]
    end
    常规提示(id,"#Y你的灵宝#R"..self.数据[道具id].名称.."#Y境界提升了",多角色)
  end
  -- if 多角色~=nil then
  --      发送数据(玩家数据[多角色].连接id,6002,{角色=id,角色属性=玩家数据[id].角色:取总数据()})
  --      发送数据(玩家数据[多角色].连接id,6011,{角色=id,id=编号,当前经验=self.数据[道具id].当前经验,升级经验=self.数据[道具id].升级经验,境界=self.数据[道具id].气血,灵气=self.数据[道具id].魔法})
  --   else
      发送数据(连接id,31,玩家数据[id].角色:取总数据())
      发送数据(连接id,3528,{id=编号,当前经验=self.数据[道具id].当前经验,升级经验=self.数据[道具id].升级经验,境界=self.数据[道具id].气血,灵气=self.数据[道具id].魔法})
    --end
end



function 道具处理类:取法宝门派(名称)

    if 名称=="天师符" or 名称=="救命毫毛" then --
        return "方寸山"
    elseif 名称=="织女扇"  then      --or 名称=="曼陀罗"
        return "女儿村"
    elseif 名称=="雷兽" or 名称=="伏魔天书" then--
        return "天宫"
    elseif  名称=="迷魂灯" then            --名称=="忘情" or
        return "盘丝洞"
    elseif  名称=="宝烛" then             --名称=="幽灵珠" or 名称=="金蟾" or
        return "无底洞"
    elseif 名称=="七杀" or 名称=="干将莫邪" then---
        return "大唐官府"
    elseif 名称=="罗汉珠" or 名称=="慈悲" then--
        return "化生寺"
    elseif 名称 == "分水" or 名称=="镇海珠" then--
        return "龙宫"
    elseif 名称 == "赤焰" or 名称 == "五火神焰印"  then--
        return "魔王寨"
    elseif 名称=="金刚杵" or 名称=="普渡" then--
        return "普陀山"
    elseif 名称=="兽王令" or 名称=="失心钹" then--
        return "狮驼岭"
    elseif 名称=="摄魂" or 名称=="九幽" then--
        return "阴曹地府"
    elseif 名称 == "天煞"  then          --or 名称 == "斩魔"
        return "凌波城"
    elseif 名称=="定风珠" or 名称=="奇门五行令" then--
        return "五庄观"
    elseif 名称 == "月影" then           --or 名称 == "神木宝鼎"
        return "神木林"
    elseif 名称 == "驭魔笼" or 名称=="铸兵锤" then     ---九黎法宝
          return "九黎城"
    -- elseif 名称=="琉璃灯" or 名称=="金箍棒" then
    --     return "花果山"
    end
    return "无门派"
end


function 道具处理类:快捷加血(连接id,id,类型)
  if 玩家数据[id].战斗~=0 then return  end
  local 数值=0
  local 编号=0
  if 类型==1 then
    数值=玩家数据[id].角色.数据.气血上限-玩家数据[id].角色.数据.气血
  else
    编号=玩家数据[id].召唤兽:取编号(玩家数据[id].角色.数据.参战宝宝.认证码)
    数值=玩家数据[id].召唤兽.数据[编号].最大气血-玩家数据[id].召唤兽.数据[编号].气血
  end
  if 数值==0 then
    return
  end
  local 恢复=self:快捷加血1(id,数值)
  if 恢复==0 then
    return
  end
  self:加血处理(连接id,id,恢复,编号)
  道具刷新(id)
end



function 道具处理类:快捷加血1(id,数值)
  local 道具={"包子","四叶花"}
  local 恢复=0
  local 道具删除={}
  for k,v in pairs(玩家数据[id].角色.数据.道具) do
    if  self.数据[v] then
        local 符合=false
        for i=1,#道具 do
          if self.数据[v].名称==道具[i] then
              符合=true
          end
        end
      if 符合 then
        if 恢复<数值 and self:取加血道具1(self.数据[v].名称,v)*self.数据[v].数量>=数值 then --
              local 扣除数量=0
              for i=1,self.数据[v].数量 do
                  if 恢复<数值 then
                      恢复=恢复+self:取加血道具1(self.数据[v].名称,v)
                      扣除数量=扣除数量+1
                  end
              end
              道具删除[#道具删除+1]={格子=n,id=v,数量=扣除数量}
        elseif 恢复<数值 then
              恢复= self:取加血道具1(self.数据[v].名称,v)*self.数据[v].数量
              道具删除[#道具删除+1]={格子=k,id=v,数量=self.数据[v].数量}
        end
      end
    end
  end
  if 恢复~=0 then
      for k,v in pairs(道具删除) do
          self.数据[v.id].数量=self.数据[v.id].数量-v.数量
          if self.数据[v.id].数量<=0 then
              self.数据[v.id]=nil
              玩家数据[id].角色.数据.道具[v.格子]=nil
          end
      end
  end
  if 恢复>数值 then 恢复=数值 end
  return 恢复
end

function 道具处理类:快捷加蓝(连接id,id,类型)
  if 玩家数据[id].战斗~=0 then return  end
  local 数值=0
  local 编号=0
  if 类型==1 then
      数值=玩家数据[id].角色.数据.最大魔法-玩家数据[id].角色.数据.魔法
  else
      编号=玩家数据[id].召唤兽:取编号(玩家数据[id].角色.数据.参战宝宝.认证码)
      数值=玩家数据[id].召唤兽.数据[编号].最大魔法-玩家数据[id].召唤兽.数据[编号].魔法
  end
  if 数值==0 then
    return
  end
  local 恢复=self:快捷加蓝1(id,数值)
  if 恢复==0 then
    return
  end
  self:加魔处理(连接id,id,恢复,编号)
  道具刷新(id)
end

function 道具处理类:快捷加蓝1(id,数值)
 local 道具={"鬼切草","佛手","紫丹罗"}
 local 恢复=0
 local 道具删除={}
 for k,v in pairs(玩家数据[id].角色.数据.道具) do
      if self.数据[v] then
          local 符合=false
          for i=1,#道具 do
              if self.数据[v].名称==道具[i] then
                  符合=true
              end
          end
          if 符合 then
              if 恢复<数值 and self:取加魔道具1(self.数据[v].名称,v)*self.数据[v].数量>=数值 then --
                    local 扣除数量=0
                    for i=1,self.数据[v].数量 do
                        if 恢复<数值 then
                            恢复=恢复+self:取加魔道具1(self.数据[v].名称,v)
                            扣除数量=扣除数量+1
                        end
                    end
                    道具删除[#道具删除+1]={格子=k,id=v,数量=扣除数量}
              elseif 恢复<数值 then
                    恢复= self:取加魔道具1(self.数据[v].名称,v)*self.数据[v].数量
                    道具删除[#道具删除+1]={格子=k,id=v,数量=self.数据[v].数量}
              end
          end
      end
 end
  if 恢复~=0 then
     for k,v in pairs(道具删除) do
          self.数据[v.id].数量=self.数据[v.id].数量-v.数量
          if self.数据[v.id].数量<=0 then
              self.数据[v.id]=nil
              玩家数据[id].角色.数据.道具[v.格子]=nil
          end
      end
  end
  if 恢复>数值 then 恢复=数值 end
  return 恢复
end



function 道具处理类:摊位上架商品(连接id,id,数据)
  if 玩家数据[id].摊位数据==nil then return end
  if 数据==nil then
    常规提示(id,"#Y/摊位数据异常！")
    return
  end
  local 价格 = 1
  if 数据.价格=="" or 数据.价格==nil then
      价格 = 1
  else
      价格=tonumber(数据.价格)
  end
  if not 价格 or 价格<1 or 价格~=math.floor(价格) then
     常规提示(id,"#Y/输入的价格有误！")
    return
  end
  if 数据.道具~=nil  then --上架道具
    local 编号=玩家数据[id].角色.数据.道具[数据.道具+0]
    if self.数据[编号].不可交易 then
      常规提示(id,"#Y/该物品不可转移给他人")
      return
    elseif self.数据[编号].加锁 then
      常规提示(id,"#Y/该物品未解锁无法交易")
      return
    elseif self.数据[编号].数量 and self.数据[编号].数量>999 then
        常规提示(id,"#Y/该物品不可转移给他人")
        return
    end
    玩家数据[id].摊位数据.道具[数据.道具+0]=DeepCopy(self.数据[编号])
    玩家数据[id].摊位数据.道具[数据.道具+0].价格=价格
    玩家数据[id].摊位数据.道具[数据.道具+0].道具编号 = 编号
    玩家数据[id].摊位数据.道具[数据.道具+0].背包编号 = 数据.道具
    常规提示(id,"#Y/上架物品成功！")
  end
  if 数据.bb~=nil  then
    local 编号=数据.bb+0
    if 玩家数据[id].召唤兽.数据[编号].不可交易 then
        常规提示(id,"#Y/该召唤兽不可转移给他人")
       return
    elseif 玩家数据[id].召唤兽.数据[编号].加锁 then
        常规提示(id,"#Y/该召唤兽未解锁无法交易")
        return
    elseif 玩家数据[id].召唤兽.数据[编号].参战信息~=nil then
        常规提示(id,"请先取消召唤兽的参战状态")
        return
    elseif 玩家数据[id].召唤兽.数据[编号].统御 ~= nil then
          常规提示(id,"#Y/已被坐骑统御的召唤兽无法转移给他人")
          return
    end
     玩家数据[id].摊位数据.bb[编号]=DeepCopy(玩家数据[id].召唤兽.数据[编号])
     玩家数据[id].摊位数据.bb[编号].价格=价格
     常规提示(id,"#Y/上架召唤兽成功！")

  end

  if 数据.打造~=nil then
    for i=1,16 do
       if 数据.打造.打造技巧[i]~=nil and math.floor(数据.打造.打造技巧[i])==tonumber(数据.打造.打造技巧[i]) then
            玩家数据[id].摊位数据.打造.打造技巧[i] = tonumber(数据.打造.打造技巧[i])
       end
       if 数据.打造.裁缝技巧[i]~=nil and math.floor(数据.打造.裁缝技巧[i])==tonumber(数据.打造.裁缝技巧[i]) then
            玩家数据[id].摊位数据.打造.裁缝技巧[i] = tonumber(数据.打造.裁缝技巧[i])
       end
       if 数据.打造.炼金术[i]~=nil and math.floor(数据.打造.炼金术[i])==tonumber(数据.打造.炼金术[i]) then
            玩家数据[id].摊位数据.打造.炼金术[i] = tonumber(数据.打造.炼金术[i])
       end
       if 数据.打造.淬灵之术[i]~=nil and math.floor(数据.打造.淬灵之术[i])==tonumber(数据.打造.淬灵之术[i]) then
          玩家数据[id].摊位数据.打造.淬灵之术[i] = tonumber(数据.打造.淬灵之术[i])
       end
    end
    常规提示(id,"#Y/上架打造成功！")
  end

  玩家数据[id].摊位数据.更新=os.time()
  self:索要摊位数据(连接id,id,3517)
end





function 道具处理类:收摊处理(连接id,id)
  玩家数据[id].摊位数据=nil
  常规提示(id,"#Y/收摊回家玩老婆去咯！")
  发送数据(连接id,3518)
  地图处理类:取消玩家摊位(id)
end


function 道具处理类:自动合成宝石(id,名称,道具id,包裹类型,编号,多角色)
      if self.数据[道具id].加锁 then
          常规提示(id,"加锁道具无法合成！",多角色)
          return
      end
      local 合成格子=0
      local 合成id=0
      for k,v in pairs(玩家数据[id].角色.数据[包裹类型]) do
          if self.数据[v] and k~=编号 and self.数据[v].名称==名称 and self.数据[v].级别限制==self.数据[道具id].级别限制 and not self.数据[v].加锁  then
              合成格子=k
              合成id=v
          end
      end
      if 合成格子~=0 then
          local 几率=玩家数据[id].装备:取宝石合成几率(id,self.数据[道具id].级别限制)
          if 玩家数据[id].角色.数据.体力 < self.数据[道具id].级别限制*10 then
              常规提示(id,"你没有这么多的体力！",多角色)
              return
          end
          玩家数据[id].角色.数据.体力=玩家数据[id].角色.数据.体力-self.数据[道具id].级别限制*10
          体活刷新(id)
          if 几率 then
             self.数据[道具id].级别限制=self.数据[道具id].级别限制+1

             常规提示(id,"你合成了一个#R"..self.数据[道具id].级别限制.."#Y级的"..名称,多角色)
          else
              常规提示(id,"合成失败，你因此损失了一颗#R"..名称,多角色)
          end
          玩家数据[id].角色.数据[包裹类型][合成格子]=nil
          self.数据[合成id]=nil
          道具刷新(id,多角色)
      else
          常规提示(id,"未找到可合成的宝石",多角色)
      end


 end

function 道具处理类:自动合成星辉石(id,名称,道具id,包裹类型,编号,多角色)
          if self.数据[道具id].加锁 then
              常规提示(id,"加锁道具无法合成！",多角色)
              return
          end
          local 合成道具 = {}
          for k,v in pairs(玩家数据[id].角色.数据[包裹类型]) do
              if self.数据[v] and k~=编号 and self.数据[v].名称==名称 and self.数据[v].级别限制==self.数据[道具id].级别限制 and not self.数据[v].加锁 and (not 合成道具[1] or 合成道具[1].格子~=k)  then
                  table.insert(合成道具,{格子=k,道具id=v})
              end
          end
          if 合成道具[1] and 合成道具[2] then
              if 玩家数据[id].角色.数据.体力 < self.数据[道具id].级别限制*10 then
                  常规提示(id,"你没有这么多的体力！",多角色)
                  return
              end
              玩家数据[id].角色.数据.体力=玩家数据[id].角色.数据.体力-self.数据[道具id].级别限制*10
              体活刷新(id)
              local 几率=玩家数据[id].装备:取宝石合成几率(id,self.数据[道具id].级别限制)
              if 几率 then
                 self.数据[道具id].级别限制=self.数据[道具id].级别限制+1
                 常规提示(id,"你合成了一个#R"..self.数据[道具id].级别限制.."#Y级的星辉石",多角色)
                 玩家数据[id].角色.数据[包裹类型][合成道具[1].格子]=nil
                 self.数据[合成道具[1].道具id]=nil
                 玩家数据[id].角色.数据[包裹类型][合成道具[2].格子]=nil
                 self.数据[合成道具[2].道具id]=nil
              else
                  常规提示(id,"合成失败，你因此损失了一颗#R"..名称,多角色)
                  玩家数据[id].角色.数据[包裹类型][合成道具[1].格子]=nil
                  self.数据[合成道具[1].道具id]=nil
              end
              道具刷新(id,多角色)
          else
              常规提示(id,"未找到可合成的宝石",多角色)
          end
 end



function 道具处理类:自动合成钟灵石(id,名称,道具id,包裹类型,编号,多角色)
      if self.数据[道具id].加锁 then
          常规提示(id,"加锁道具无法合成！",多角色)
          return
      end
      local 合成格子=0
      local 合成id=0
      for k,v in pairs(玩家数据[id].角色.数据[包裹类型]) do
          if self.数据[v] and k~=编号 and self.数据[v].名称==名称 and self.数据[v].级别限制==self.数据[道具id].级别限制 and self.数据[v].附加特性==self.数据[道具id].附加特性 and not self.数据[v].加锁  then
              合成格子=k
              合成id=v
          end
      end
      if 合成格子~=0 then
          if 玩家数据[id].角色.数据.体力 < self.数据[道具id].级别限制*10 then
              常规提示(id,"你没有这么多的体力！",多角色)
              return
          end
          玩家数据[id].角色.数据.体力=玩家数据[id].角色.数据.体力-self.数据[道具id].级别限制*10
          体活刷新(id)
          if 取随机数() <= (76-5*self.数据[道具id].级别限制) then
             self.数据[道具id].级别限制=self.数据[道具id].级别限制+1
             常规提示(id,"你合成了一个#R"..self.数据[道具id].级别限制.."#Y级的"..名称,多角色)
          else
              常规提示(id,"合成失败，你因此损失了一颗#R"..名称,多角色)
          end
          玩家数据[id].角色.数据[包裹类型][合成格子]=nil
          self.数据[合成id]=nil
          道具刷新(id,多角色)
      else
          常规提示(id,"未找到可合成的宝石",多角色)
      end


end

function 道具处理类:自动合成精魄灵石(id,名称,道具id,包裹类型,编号,多角色)
      if self.数据[道具id].加锁 then
          常规提示(id,"加锁道具无法合成！",多角色)
          return
      end
      local 合成格子=0
      local 合成id=0
      for k,v in pairs(玩家数据[id].角色.数据[包裹类型]) do
          if self.数据[v] and k~=编号 and self.数据[v].名称==名称 and self.数据[v].级别限制==self.数据[道具id].级别限制 and self.数据[v].子类==self.数据[道具id].子类 and self.数据[v].属性==self.数据[道具id].属性 and not self.数据[v].加锁  then
              合成格子=k
              合成id=v
          end
      end
      if 合成格子~=0 then
          if 玩家数据[id].角色.数据.体力 < self.数据[道具id].级别限制*10 then
              常规提示(id,"你没有这么多的体力！",多角色)
              return
          end
          玩家数据[id].角色.数据.体力=玩家数据[id].角色.数据.体力-self.数据[道具id].级别限制*10
          体活刷新(id)
          local 几率=玩家数据[id].装备:取宝石合成几率(id,self.数据[道具id].级别限制)
          if 几率 then
             self.数据[道具id].级别限制=self.数据[道具id].级别限制+1
             常规提示(id,"你合成了一个#R"..self.数据[道具id].级别限制.."#Y级的"..名称,多角色)
          else
              常规提示(id,"合成失败，你因此损失了一颗#R"..名称,多角色)
          end
          玩家数据[id].角色.数据[包裹类型][合成格子]=nil
          self.数据[合成id]=nil
          道具刷新(id,多角色)
      else
          常规提示(id,"未找到可合成的宝石",多角色)
      end


 end

function 道具处理类:更改摊位招牌(连接id,id,名称)
  if 玩家数据[id].摊位数据==nil then return end
  if os.time()-玩家数据[id].摊位数据.更新<=5 then
    常规提示(id,"#Y/请不要频繁更换招牌")
    return
  end
  if not 名称 or 名称=="" or 判断特殊字符(名称) then
       常规提示(id,"#Y名字不能含有敏感字符")
      return
  end
  名称=敏感字判断(名称)
  常规提示(id,"#Y/更新招牌成功")
  玩家数据[id].摊位数据.更新=os.time()
  玩家数据[id].摊位数据.名称=名称
  发送数据(连接id,3516,名称)
  地图处理类:设置玩家摊位(id,名称)
end



function 道具处理类:购买摊位商品(连接id,id,数据)
  local 对方id=玩家数据[id].摊位id
  if 假人摆摊 and 摆摊假人类 and 摆摊假人类:购买摊位商品(id,对方id,数据) then
      return
  end
  if 对方id==nil or 玩家数据[对方id]==nil or 玩家数据[对方id].摊位数据==nil then
     常规提示(id,"#Y/这个摊位并不存在")
     return
  end

  if 玩家数据[id].摊位查看<玩家数据[对方id].摊位数据.更新 then
    常规提示(id,"#Y/这个摊位的数据已经发生了变化，请重新打开该摊位")
    return
  end
  --数据转移
  local 名称=玩家数据[对方id].角色.数据.名称
  local 名称1=玩家数据[id].角色.数据.名称
  local 账号=玩家数据[对方id].账号
  local 账号1=玩家数据[id].账号
  if 数据.道具~=nil then --购买道具
    if 玩家数据[对方id].摊位数据.道具[数据.道具]==nil then
      常规提示(id,"#Y/这个商品并不存在")
      return
    end
   local 对方道具id = 玩家数据[对方id].角色.数据.道具[数据.道具]

   if 对方道具id~=玩家数据[对方id].摊位数据.道具[数据.道具].道具编号 then
      常规提示(id,"#Y/这个商品并不存在")
      return
   end

   local 购买数量=1
     if not 数据.数量 or not tonumber(数据.数量) or tonumber(数据.数量)<1 or math.floor(数据.数量)~=tonumber(数据.数量) then
        购买数量 = 1
     else
         购买数量 = math.floor(数据.数量+0)
     end

    if 玩家数据[对方id].道具.数据[对方道具id] == nil then
         常规提示(id,"#Y/这个商品并不存在")
        return
    end
    if 玩家数据[对方id].摊位数据.道具[数据.道具].名称~=玩家数据[对方id].道具.数据[对方道具id].名称 then
       常规提示(id,"#Y/这个商品并不存在")
        return
    end
    if 购买数量>999 then
        共享货币[玩家数据[id].账号]:充值记录("刷物品被进封")
       封禁账号(id,"1")
       print("#Y玩家id"..id.."刷物品被封禁")
       return
    end
    if 购买数量<=1 then
       购买数量 = 1
    end
    if 玩家数据[对方id].摊位数据.道具[数据.道具].数量==nil then
       玩家数据[对方id].摊位数据.道具[数据.道具].数量 = 1
    end
    if 玩家数据[对方id].道具.数据[对方道具id].数量==nil then
       购买数量=1
    else
        if 购买数量 > 玩家数据[对方id].道具.数据[对方道具id].数量 then
           购买数量 = math.floor(玩家数据[对方id].道具.数据[对方道具id].数量)
        end
    end
    local 购买价格=玩家数据[对方id].摊位数据.道具[数据.道具].价格 * 购买数量
    if 玩家数据[id].角色.数据.银子 < 购买价格 or math.floor(购买价格)~=购买价格 or 购买价格<1 then
      常规提示(id,"#Y/你没有那么多的银子")
      return
    end

    local 临时格子=玩家数据[id].角色:取道具格子()
    if 临时格子==0 then
      常规提示(id,"#Y/请先整理下包裹吧！")
      return
    end

      玩家数据[id].角色:扣除银子(购买价格,"摊位购买",1)
      玩家数据[对方id].角色:添加银子(购买价格,"摊位出售",1)
      local 道具名称=玩家数据[对方id].道具.数据[对方道具id].名称
      local 道具识别码= self:改变道具归属(对方id,id,对方道具id,临时格子,nil,购买数量,数据.道具)

      玩家数据[id].角色:日志记录(format("[摊位系统-购买]购买道具[%s][%s]，花费%s两银子,出售者信息：[%s][%s][%s]",道具名称,道具识别码,购买价格,账号,对方id,名称))
      玩家数据[对方id].角色:日志记录(format("[摊位系统-出售]出售道具[%s][%s]，花费%s两银子,购买者信息：[%s][%s][%s]",道具名称,道具识别码,购买价格,账号1,id,名称1))
      常规提示(对方id,"#W/出售#R/"..道具名称.."#W/成功！")
      常规提示(id,"#W/购买#R/"..道具名称.."#W/成功！")
      if  not 玩家数据[对方id].道具.数据[对方道具id] then
          玩家数据[对方id].摊位数据.道具[数据.道具] = nil
          玩家数据[对方id].道具:删除同类物品(道具识别码)
      else
         if 玩家数据[对方id].摊位数据.道具[数据.道具].数量==nil then
              玩家数据[对方id].摊位数据.道具[数据.道具] = nil
              玩家数据[对方id].道具:删除同类物品(道具识别码)
          else
              玩家数据[对方id].摊位数据.道具[数据.道具].数量=玩家数据[对方id].摊位数据.道具[数据.道具].数量-购买数量
              if 玩家数据[对方id].摊位数据.道具[数据.道具].数量<=0 then
                 玩家数据[对方id].摊位数据.道具[数据.道具] = nil
                 玩家数据[对方id].道具:删除同类物品(道具识别码)
              end
          end
      end


    道具刷新(id)
    道具刷新(对方id)
  end

  if 数据.bb~=nil then--宠物
    if 玩家数据[对方id].摊位数据.bb[数据.bb]==nil then
      常规提示(id,"#Y/这只召唤兽不存在")
      return
    -- elseif 玩家数据[对方id].召唤兽.数据[数据.bb]==nil then
    --   常规提示(id,"#Y/这只召唤兽不存在")
    --   return
    elseif 玩家数据[id].召唤兽:是否携带上限() then
      常规提示(id,"#Y/你当前可携带的召唤兽数量已达上限！")
      return
    end
    local 出售价格=玩家数据[对方id].摊位数据.bb[数据.bb].价格
    if 玩家数据[id].角色.数据.银子<出售价格 or math.floor(出售价格)~=出售价格 or 出售价格<1  then
      常规提示(id,"#Y/你没有那么多的银子")
      return
    end

     local 认证码 = 玩家数据[对方id].摊位数据.bb[数据.bb].认证码
    local 取编号=玩家数据[对方id].召唤兽:取编号(认证码)
     if 取编号==0 or 玩家数据[对方id].召唤兽.数据[取编号]==nil then
        常规提示(id,"#Y/对方摊位数据错误请联系管理员！")
        return
    end

    local 道具名称=玩家数据[对方id].召唤兽.数据[取编号].名称
    local 道具等级=玩家数据[对方id].召唤兽.数据[取编号].等级
    local 道具模型=玩家数据[对方id].召唤兽.数据[取编号].模型
    local 道具技能=#玩家数据[对方id].召唤兽.数据[取编号].技能
    local 道具识别码=玩家数据[对方id].召唤兽.数据[取编号].认证码
    玩家数据[id].角色:扣除银子(出售价格,"摊位购买",1)
    玩家数据[对方id].角色:添加银子(出售价格,"摊位出售",1)
    玩家数据[对方id].角色:日志记录(format("[摊位系统-出售]出售召唤兽[%s][%s][%s][%s][%s]，花费%s两银子,购买者信息：[%s][%s][%s]",道具名称,道具模型,道具等级,道具技能,道具识别码,出售价格,账号1,id,名称1))
    常规提示(对方id,"#W/出售#R/"..道具名称.."#W/成功！")
    常规提示(id,"#W/购买#R/"..道具名称.."#W/成功！")
    玩家数据[id].召唤兽.数据[#玩家数据[id].召唤兽.数据+1]=DeepCopy(玩家数据[对方id].召唤兽.数据[取编号])
    玩家数据[id].召唤兽.数据[#玩家数据[id].召唤兽.数据].认证码 = 取唯一识别码(id)
    local 新道具识别码=玩家数据[id].召唤兽.数据[#玩家数据[id].召唤兽.数据].认证码
    玩家数据[id].角色:日志记录(format("[摊位系统-购买]购买召唤兽[%s][%s][%s][%s][%s]，花费%s两银子,出售者信息：[%s][%s][%s]",道具名称,道具模型,道具等级,道具技能,新道具识别码,出售价格,账号,对方id,名称))
    --玩家数据[对方id].摊位数据.bb[数据.bb]=nil
    table.remove(玩家数据[对方id].召唤兽.数据,取编号)
   -- table.remove(玩家数据[对方id].摊位数据.bb,数据.bb)
    玩家数据[对方id].摊位数据.bb[数据.bb]=nil
    if 玩家数据[id].召唤兽.数据[#玩家数据[id].召唤兽.数据].参战信息~=nil then
      玩家数据[id].召唤兽.数据[#玩家数据[id].召唤兽.数据].参战信息=nil
      玩家数据[对方id].角色.数据.参战信息=nil
      玩家数据[对方id].角色.数据.参战宝宝={}
      发送数据(玩家数据[对方id].连接id,18,玩家数据[对方id].角色.数据.参战宝宝)
    end
   -- 玩家数据[id].召唤兽:图鉴属性()
    发送数据(玩家数据[id].连接id,3512,玩家数据[id].召唤兽.数据)
    发送数据(玩家数据[对方id].连接id,3512,玩家数据[对方id].召唤兽.数据)

  end
  if 数据.打造~=nil then
    local 编号 = 数据.数量 + 0
    if 玩家数据[对方id].摊位数据.打造[数据.打造]==nil then
      常规提示(id,"#Y/你购买的打造不存在")
      return
    end
    local 费用 = 玩家数据[对方id].摊位数据.打造[数据.打造][编号] + 0
     if 玩家数据[id].角色.数据.银子 < 费用 or math.floor(费用)~=费用 or 费用<1  then
        常规提示(id,"#Y/你没有那么多的银子")
        return
      end
      local 临时格子=玩家数据[id].角色:取道具格子()
      if 临时格子==0 then
        常规提示(id,"#Y/请先整理下包裹吧！")
        return
      end
     -- 玩家数据[id].角色:扣除银子(费用,"摊位购买",1)
     if 玩家数据[id].角色:取任务(5)~=0 then
         常规提示(id,"#Y/你已经领取了一个打造任务，赶快去完成吧")
         return
      end

      -- local x临时数据 = 玩家数据[id].道具:索要道具1(id)
      -- x临时数据.当前打开方式 = "强化打造"
      -- 发送数据(玩家数据[id].连接id,14,x临时数据)
      -- 玩家数据[id].打造方式=2
      -- x临时数据={}
        玩家数据[id].给予数据={类型=1,id=0,事件="购买打造处理"}
        发送数据(玩家数据[id].连接id,3507,{道具=玩家数据[id].道具:索要道具1(id),名称=玩家数据[对方id].角色.数据.名称,类型="玩家",等级=玩家数据[对方id].角色.数据.等级})



      玩家数据[id].摊位购买打造 = {对方id = 对方id ,对方名称 =玩家数据[对方id].角色.数据.名称, 费用 = 费用,打造技能= 数据.打造,熟练度 =玩家数据[对方id].角色.数据.打造熟练度[数据.打造],等级 = 编号*10 }

  end
  玩家数据[对方id].摊位数据.更新=os.time()
  玩家数据[id].摊位查看=os.time()
  self:索要其他玩家摊位(连接id,id,对方id,3522)
  self:索要摊位数据(玩家数据[对方id].连接id,对方id,3517)
end





function 道具处理类:索要其他玩家摊位(连接id,id,对方id,序号)
          if 假人摆摊 and 摆摊假人类 and 摆摊假人类:索要摊位(id,对方id,序号) then
              return
          end
          if 玩家数据[对方id]==nil or 玩家数据[对方id].摊位数据==nil then
            常规提示(id,"#Y/这个摊位并不存在")
             玩家数据[id].摊位购买打造 = nil
            return
          end
          玩家数据[id].摊位查看=os.time()
          玩家数据[id].摊位id=对方id
          发送数据(玩家数据[id].连接id,3520,玩家数据[id].角色.数据.银子)
          发送数据(玩家数据[id].连接id,序号,{打造=玩家数据[对方id].摊位数据.打造,bb=玩家数据[对方id].摊位数据.bb,物品=玩家数据[对方id].摊位数据.道具,id=对方id,摊主名称=玩家数据[对方id].角色.数据.名称,名称=玩家数据[对方id].摊位数据.名称,熟练度=玩家数据[对方id].角色.数据.打造熟练度})
end





function 道具处理类:索要摊位数据(连接id,id,序号)
  if 玩家数据[id].摊位数据==nil then --新建摊位
      if 玩家数据[id].队伍~=0 then
          常规提示(id,"#Y/组队状态下无法摆摊")
          return
      else
          local 地图=玩家数据[id].角色.数据.地图数据.编号
          if 地图~=1001 and 地图~=1501 and 地图~=1070 and 地图~=1092 and 地图~=1208 and 地图~=1226 and 地图~=1040 then
            常规提示(id,"#Y/该场景无法摆摊")
            return
          elseif 玩家数据[id].角色.数据.等级<30 then
            常规提示(id,"#Y/只有等级达到30级的玩家才可使用摆摊功能")
            return
          end
      end
      玩家数据[id].摊位数据={道具={},bb={},打造 = {打造技巧={},裁缝技巧={},炼金术={},淬灵之术={}},id=id,名称="杂货摊位",摊主=玩家数据[id].角色.数据.名称,更新=os.time()-10}
      地图处理类:设置玩家摊位(id,"杂货摊位")
  end
  发送数据(玩家数据[id].连接id,3512,玩家数据[id].召唤兽.数据)
  发送数据(玩家数据[id].连接id,3513,玩家数据[id].道具:索要道具2(id))
  发送数据(玩家数据[id].连接id,3537,{辅助技能 = 玩家数据[id].角色.数据.辅助技能})
  --道具刷新(id)
  local bb={}
  for k,v in pairs(玩家数据[id].摊位数据.bb) do
      bb[k]=v.价格
  end
  local 道具={}
  for k,v in pairs(玩家数据[id].摊位数据.道具) do
      道具[k]=v.价格
  end
  local 打造 = {打造技巧={},裁缝技巧={},炼金术={},淬灵之术={}}
  for k,v in pairs(玩家数据[id].摊位数据.打造) do
      for z,n in pairs(v) do
          打造[k][z]=n
      end
  end
  发送数据(连接id,序号,{打造=打造,bb=bb,物品=道具,id=id,摊主名称=玩家数据[id].角色.数据.名称,名称=玩家数据[id].摊位数据.名称})
end



function 道具处理类:取消交易(id)
  if 玩家数据[id].交易信息~=nil then
    if 玩家数据[玩家数据[id].交易信息.id]~=nil then
      发送数据(玩家数据[玩家数据[id].交易信息.id].连接id,3511)
      常规提示(玩家数据[id].交易信息.id,"#Y/对方取消了交易")
      玩家数据[玩家数据[id].交易信息.id].交易信息=nil
    end
    交易数据[玩家数据[id].交易信息.编号]=nil
    玩家数据[id].交易信息=nil
  end
end

function 道具处理类:取指定道具(编号)
  return DeepCopy(self.数据[编号])
end

function 道具处理类:发起交易处理(连接id,id,id1)
  if 玩家数据[id1]==nil then
    常规提示(id,"#Y/对方并不在线")
    return
  elseif 地图处理类:比较距离(id,id1,5000)==false then
    常规提示(id,"#Y/你们的距离太远了")
    return
  elseif 玩家数据[id1].交易信息~=nil or 玩家数据[id1].摊位数据~=nil then
    常规提示(id,"#Y/对方正忙，请稍后再试")
    return
  elseif 玩家数据[id].交易信息~=nil then
    常规提示(id,"#Y/你上次的交易还没有结束哟~")
    return
  elseif 玩家数据[id].交易信息~=nil then
    常规提示(id,"#Y/你上次的交易还没有结束哟~")
    return
  elseif 玩家数据[id1].禁止交易 then
    常规提示(id,"#Y/对方没有打开交易开关")
    return
  elseif 玩家数据[id].角色.数据.等级<30 then
    常规提示(id,"#Y/等级小于30级不可交易")
    return
  end
  交易数据[id]={[id]={},[id1]={}}
  常规提示(id,"你正在和"..玩家数据[id1].角色.数据.名称.."进行交易")
  常规提示(id1,"你正在和"..玩家数据[id].角色.数据.名称.."进行交易")
  发送数据(玩家数据[id].连接id,3512,玩家数据[id].召唤兽.数据)
  发送数据(玩家数据[id1].连接id,3512,玩家数据[id1].召唤兽.数据)
  发送数据(玩家数据[id].连接id,3513,玩家数据[id].道具:索要道具2(id))
  发送数据(玩家数据[id1].连接id,3513,玩家数据[id1].道具:索要道具2(id1))
  发送数据(玩家数据[id].连接id,3514,{名称=玩家数据[id1].角色.数据.名称,等级=玩家数据[id1].角色.数据.等级})
  发送数据(玩家数据[id1].连接id,3514,{名称=玩家数据[id].角色.数据.名称,等级=玩家数据[id].角色.数据.等级})
  玩家数据[id1].交易信息={编号=id,id=id}
  玩家数据[id].交易信息={编号=id,id=id1}
end

function 道具处理类:完成交易处理(id)
   if 玩家数据[id]==nil or 玩家数据[id].交易信息 == nil or 玩家数据[id].交易信息.编号==nil or 玩家数据[id].交易信息.id==nil then
      常规提示(id,"#Y/交易信息错误，本次交易取消")
      发送数据(玩家数据[id].连接id,3511)
      玩家数据[id].交易信息=nil
      交易数据[id]=nil
      return
  end
  local 交易id=玩家数据[id].交易信息.编号
  local id1=玩家数据[id].交易信息.id
  if 交易数据[交易id][id].锁定 == nil or 交易数据[交易id][id].锁定 == false then
      常规提示(id,"#Y/请先锁定交易")
      return
  elseif 交易数据[交易id][id].锁定 and (交易数据[交易id][id1].锁定 == nil or 交易数据[交易id][id1].锁定 == false ) then
      常规提示(id,"#Y/请耐心等待对方锁定交易状态")
      return
  end
  if 交易数据[交易id][id].确定 == nil or 交易数据[交易id][id].确定 == false then
     交易数据[交易id][id].确定 = true
  end
  if 交易数据[交易id][id1].确定 == nil or 交易数据[交易id][id1].确定 == false then
      常规提示(id,"#Y/你已确定交易,请等待对方确定交易")
      常规提示(id1,"#Y/对方已确定交易,完成交易请确定")
      return
  end
  local 取消交易 =false
  local 提示 ="#Y数据错误"
  local 提示1 ="#Y数据错误"
  local 操作id=id
  local 对象id=id1
  if 玩家数据[操作id].交易信息.编号~=玩家数据[对象id].交易信息.编号  then
        取消交易 =true
  end
  if 交易数据[交易id][操作id].确定  and 交易数据[交易id][对象id].确定 then
    if 玩家数据[操作id].战斗~=0 or 玩家数据[对象id].战斗~=0 then
        取消交易 =true
        提示 ="#Y战斗中无法使用此功能"
        提示1 ="#Y战斗中无法使用此功能"
    elseif 玩家数据[操作id].摊位数据~=nil or 玩家数据[对象id].摊位数据~=nil then
        取消交易 =true
        提示 ="#Y摆摊状态下无法使用此功能"
        提示1 ="#Y摆摊状态下无法使用此功能"
    elseif 地图处理类:比较距离(操作id,对象id,5000)==false then
        取消交易 =true
        提示 ="#Y你们的距离太远了"
        提示1 ="#Y你们的距离太远了"
    end
    local 银子=tonumber(交易数据[交易id][操作id].银子)
    local 银子1=tonumber(交易数据[交易id][对象id].银子)
    if not 银子 or 玩家数据[操作id].角色.数据.银子<银子 or math.floor(银子)~=银子 or isNaN(银子) then
        取消交易 =true
        提示 ="#Y你没有那么多的银子"
        提示1 ="#Y对方没有那么多的银子"
    elseif not 银子1 or 玩家数据[对象id].角色.数据.银子<银子1 or math.floor(银子1)~=银子1 or isNaN(银子1) then
        取消交易 =true
        提示 ="#Y对方没有那么多的银子"
        提示1 ="#Y你没有那么多的银子"
    end
    for k,v in pairs(交易数据[交易id][操作id].道具) do
         local 道具id=v.编号
         local 道具id1=玩家数据[操作id].角色.数据.道具[v.格子]
         if 道具id~=道具id1 or not 玩家数据[操作id].道具.数据[道具id] or not 玩家数据[操作id].道具.数据[道具id1] or 玩家数据[操作id].道具.数据[道具id1].识别码~=v.认证码 then
            取消交易 =true
            提示 ="#Y你此次交易的道具数据与锁定前的数据不匹配，本次交易取消"
            提示1 ="#Y对方此次交易的道具数据与锁定前的数据不匹配，本次交易取消"
          elseif 玩家数据[操作id].道具.数据[道具id1].不可交易 or 玩家数据[操作id].道具.数据[道具id1].名称=="帮派银票" or 玩家数据[操作id].道具.数据[道具id1].总类=="帮派银票" or 玩家数据[操作id].道具.数据[道具id1].总类=="跑商商品" then
              取消交易 =true
              提示 ="#Y该道具不可交易给他人，本次交易取消"
              提示1 ="#Y对方此次交易存在无法交易的道具，本次交易取消"
          elseif 玩家数据[操作id].道具.数据[道具id1].数量 and  玩家数据[操作id].道具.数据[道具id1].数量>999 then
              取消交易 =true
              提示 ="#Y该道具不可交易给他人，本次交易取消"
              提示1 ="#Y对方此次交易存在无法交易的道具，本次交易取消"
          end
    end
     for k,v in pairs(交易数据[交易id][对象id].道具) do
         local 道具id=v.编号
         local 道具id1=玩家数据[对象id].角色.数据.道具[v.格子]
         if 道具id~=道具id1 or not 玩家数据[对象id].道具.数据[道具id] or not 玩家数据[对象id].道具.数据[道具id1] or 玩家数据[对象id].道具.数据[道具id1].识别码~=v.认证码 then
            取消交易 =true
            提示1 ="#Y你此次交易的道具数据与锁定前的数据不匹配，本次交易取消"
            提示 ="#Y对方此次交易的道具数据与锁定前的数据不匹配，本次交易取消"
          elseif 玩家数据[对象id].道具.数据[道具id1].不可交易 or 玩家数据[对象id].道具.数据[道具id1].名称=="帮派银票" or 玩家数据[对象id].道具.数据[道具id1].总类=="帮派银票" or 玩家数据[对象id].道具.数据[道具id1].总类=="跑商商品" then
              取消交易 =true
              提示1 ="#Y该道具不可交易给他人，本次交易取消"
              提示 ="#Y对方此次交易存在无法交易的道具，本次交易取消"
          elseif 玩家数据[对象id].道具.数据[道具id1].数量 and  玩家数据[对象id].道具.数据[道具id1].数量>999 then
              取消交易 =true
              提示 ="#Y对方此次交易存在无法交易的道具，本次交易取消"
              提示1 ="#Y该道具不可交易给他人，本次交易取消"
          end
    end
    for k,v in pairs(交易数据[交易id][操作id].bb) do
        local 认证码=玩家数据[操作id].召唤兽.数据[v.编号].认证码
        if 认证码~=v.认证码 then
            取消交易 =true
            提示 ="#Y你此次交易的召唤兽数据与锁定前的数据不匹配，本次交易取消"
            提示1 ="#Y对方此次交易的召唤兽数据与锁定前的数据不匹配，本次交易取消"
        elseif 玩家数据[操作id].召唤兽.数据[v.编号].不可交易 then
                取消交易 =true
                提示 ="#Y该召唤兽不可交易给他人，本次交易取消"
                提示1 ="#Y对方此次交易存在无法交易的召唤兽，本次交易取消"
        elseif 玩家数据[操作id].召唤兽.数据[v.编号].统御 then
                取消交易 =true
                提示 ="#Y已被统御的召唤兽无法进行交易，本次交易取消"
                提示1 ="#Y对方此次交易存在无法交易的召唤兽，本次交易取消"
        elseif 玩家数据[操作id].召唤兽.数据[v.编号].参战信息 then
                取消交易 =true
                提示 ="#Y请先取消该召唤兽参战状态，本次交易取消"
                提示1 ="#Y对方尚未取消召唤兽参战状态，本次交易取消"
        end
    end
    for k,v in pairs(交易数据[交易id][对象id].bb) do
        local 认证码=玩家数据[对象id].召唤兽.数据[v.编号].认证码
        if 认证码~=v.认证码 then
            取消交易 =true
            提示1 ="#Y你此次交易的召唤兽数据与锁定前的数据不匹配，本次交易取消"
            提示 ="#Y对方此次交易的召唤兽数据与锁定前的数据不匹配，本次交易取消"
        elseif 玩家数据[对象id].召唤兽.数据[v.编号].不可交易 then
                取消交易 =true
                提示1 ="#Y该召唤兽不可交易给他人，本次交易取消"
                提示 ="#Y对方此次交易存在无法交易的召唤兽，本次交易取消"
        elseif 玩家数据[对象id].召唤兽.数据[v.编号].统御 then
                取消交易 =true
                提示1 ="#Y已被统御的召唤兽无法进行交易，本次交易取消"
                提示 ="#Y对方此次交易存在无法交易的召唤兽，本次交易取消"
        elseif 玩家数据[对象id].召唤兽.数据[v.编号].参战信息 then
                取消交易 =true
                提示1 ="#Y请先取消该召唤兽参战状态，本次交易取消"
                提示 ="#Y对方尚未取消召唤兽参战状态，本次交易取消"
        end
    end
    local 道具数量=玩家数据[操作id].角色:取道具格子2()
    local 道具数量1=玩家数据[对象id].角色:取道具格子2()
    if 道具数量<#交易数据[交易id][对象id].道具 then
        取消交易 =true
        提示 ="#Y你身上的空间不够"
        提示1 ="#Y对方身上的空间不够"
    elseif 道具数量1<#交易数据[交易id][操作id].道具 then
        取消交易 =true
        提示1 ="#Y你身上的空间不够"
        提示 ="#Y对方身上的空间不够"
    end
    if #玩家数据[操作id].召唤兽.数据+#交易数据[交易id][对象id].bb>玩家数据[操作id].角色.数据.携带宠物 then
        取消交易 =true
        提示 ="#Y你可携带的召唤兽数量已达上限"
        提示1 ="#Y对方可携带的召唤兽数量已达上限"
    elseif #玩家数据[对象id].召唤兽.数据+#交易数据[交易id][操作id].bb>玩家数据[对象id].角色.数据.携带宠物 then
        取消交易 =true
        提示1 ="#Y你可携带的召唤兽数量已达上限"
        提示 ="#Y对方可携带的召唤兽数量已达上限"
    end

    if 取消交易 then
        常规提示(id,提示)
        常规提示(id1,提示1)
        发送数据(玩家数据[id].连接id,3511)
        发送数据(玩家数据[id1].连接id,3511)
        玩家数据[id1].交易信息=nil
        玩家数据[id].交易信息=nil
        交易数据[交易id]=nil
        return
    end
    local 账号=玩家数据[操作id].账号
    local 账号1=玩家数据[对象id].账号
    local 名称=玩家数据[操作id].角色.数据.名称
    local 名称1=玩家数据[对象id].角色.数据.名称
    if 交易数据[交易id][操作id].银子>0 then
      local 交易银子 = math.floor(交易数据[交易id][操作id].银子)
      local 之前银子=玩家数据[操作id].角色.数据.银子
      玩家数据[操作id].角色.数据.银子 =玩家数据[操作id].角色.数据.银子 -  交易银子
      玩家数据[操作id].角色:日志记录(format("[交易系统-扣除银子]给了[%s][%s][%s]银子,银子数额%s,之前数额%s,余额%s",账号1,对象id,名称1,交易银子,之前银子,玩家数据[操作id].角色.数据.银子))
      local 之前银子=玩家数据[对象id].角色.数据.银子
      玩家数据[对象id].角色.数据.银子 =玩家数据[对象id].角色.数据.银子 +  交易银子
      玩家数据[对象id].角色:日志记录(format("[交易系统-获得银子]获得[%s][%s][%s]银子,银子数额%s,之前数额%s,余额%s",账号,操作id,名称,交易银子,之前银子,玩家数据[对象id].角色.数据.银子))
      常规提示(对象id,format("#Y%s给了你#R%s#Y两银子",名称,交易银子))
      常规提示(操作id,format("#Y你给了%s#R%s#Y两银子",名称1,交易银子))
    end

    if 交易数据[交易id][对象id].银子>0 then
      local 交易银子 = math.floor(交易数据[交易id][对象id].银子)
      local 之前银子= 玩家数据[对象id].角色.数据.银子
      玩家数据[对象id].角色.数据.银子 =玩家数据[对象id].角色.数据.银子 -  交易银子
      玩家数据[对象id].角色:日志记录(format("[交易系统-扣除银子]给了[%s][%s][%s]银子,银子数额%s,之前数额%s,余额%s",账号,操作id,名称,交易银子,之前银子,玩家数据[对象id].角色.数据.银子))
      local 之前银子=玩家数据[操作id].角色.数据.银子
      玩家数据[操作id].角色.数据.银子 =玩家数据[操作id].角色.数据.银子 +  交易银子
      玩家数据[操作id].角色:日志记录(format("[交易系统-获得银子]获得[%s][%s][%s]银子,银子数额%s,之前数额%s,余额%s",账号1,对象id,名称1,交易银子,之前银子,玩家数据[操作id].角色.数据.银子))
      常规提示(操作id,format("#Y%s给了你#R%s#Y两银子",名称1,交易银子))
      常规提示(对象id,format("#Y你给了%s#R%s#Y两银子",名称,交易银子))
    end

    local 删除道具={}
    for k,v in pairs(交易数据[交易id][操作id].道具) do
        local 新格子=玩家数据[对象id].角色:取道具格子()
        local 道具名称 = 玩家数据[操作id].道具.数据[v.编号].名称
        local 数量 = 玩家数据[操作id].道具.数据[v.编号].数量
        删除道具[#删除道具+1]=self:改变道具归属(操作id,对象id,v.编号,新格子,"交易处理",数量,v.格子)
        常规提示(对象id,format("#Y%s给了你#R%s",名称,道具名称))
        常规提示(操作id,format("#Y你给了%s#R%s",名称1,道具名称))
    end
    for k,v in pairs(删除道具) do
        玩家数据[操作id].道具:删除同类物品(v)
    end

    local 删除道具1={}
    for k,v in pairs(交易数据[交易id][对象id].道具) do
        local 新格子=玩家数据[操作id].角色:取道具格子()
        local 道具名称 = 玩家数据[对象id].道具.数据[v.编号].名称
        local 数量 = 玩家数据[对象id].道具.数据[v.编号].数量
        删除道具1[#删除道具1+1]=self:改变道具归属(对象id,操作id,v.编号,新格子,"交易处理",数量,v.格子)
        常规提示(操作id,format("#Y/%s给了你#R%s",名称1,道具名称))
        常规提示(对象id,format("#Y/你给了%s#R%s",名称,道具名称))
    end
    for k,v in pairs(删除道具1) do
        玩家数据[对象id].道具:删除同类物品(v)
    end
    local 操作=false
    for k,v in pairs(交易数据[交易id][操作id].bb) do
        local bb名称 = 玩家数据[操作id].召唤兽.数据[v.编号].名称
        local bb模型 = 玩家数据[操作id].召唤兽.数据[v.编号].模型
        local bb种类 = 玩家数据[操作id].召唤兽.数据[v.编号].种类
        local bb等级 = 玩家数据[操作id].召唤兽.数据[v.编号].等级
        玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据+1]=DeepCopy(玩家数据[操作id].召唤兽.数据[v.编号])
        玩家数据[操作id].召唤兽.数据[v.编号]=nil
        local bb认证码=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].认证码
        玩家数据[操作id].角色:日志记录(format("[交易系统-扣除bb]给了[%s][%s][%s]bb,名称为%s、模型为%s、种类为%s、等级为%s、认证码为%s",账号1,对象id,名称1,bb名称,bb模型,bb种类,bb等级,bb认证码))
        玩家数据[对象id].角色:日志记录(format("[交易系统-获得bb]获得[%s][%s][%s]bb,名称为%s、模型为%s、种类为%s、等级为%s、认证码为%s",账号,操作id,名称,bb名称,bb模型,bb种类,bb等级,bb认证码))
        操作=true
        常规提示(对象id,format("#Y/%s给了你#R%s",名称,bb名称))
        常规提示(操作id,format("#Y/你给了%s#R%s",名称1,bb名称))
    end
     local 临时bb={}
    if 操作 then
        for n,v in pairs(玩家数据[操作id].召唤兽.数据) do
          if 玩家数据[操作id].召唤兽.数据[n]~=nil then
              临时bb[#临时bb+1]=玩家数据[操作id].召唤兽.数据[n]
          end
        end
        玩家数据[操作id].召唤兽.数据={}
        玩家数据[操作id].召唤兽.数据=临时bb
        发送数据(玩家数据[操作id].连接id,3512,玩家数据[操作id].召唤兽.数据)
        发送数据(玩家数据[对象id].连接id,3512,玩家数据[操作id].召唤兽.数据)
    end

    local 操作1=false
    for k,v in pairs(交易数据[交易id][对象id].bb) do
        local bb名称 = 玩家数据[对象id].召唤兽.数据[v.编号].名称
        local bb模型 = 玩家数据[对象id].召唤兽.数据[v.编号].模型
        local bb种类 = 玩家数据[对象id].召唤兽.数据[v.编号].种类
        local bb等级 = 玩家数据[对象id].召唤兽.数据[v.编号].等级
        玩家数据[操作id].召唤兽.数据[#玩家数据[操作id].召唤兽.数据+1]=DeepCopy(玩家数据[对象id].召唤兽.数据[v.编号])
        玩家数据[对象id].召唤兽.数据[v.编号]=nil
        local bb认证码=玩家数据[操作id].召唤兽.数据[#玩家数据[操作id].召唤兽.数据].认证码
        玩家数据[对象id].角色:日志记录(format("[交易系统-扣除bb]给了[%s][%s][%s]bb,名称为%s、模型为%s、种类为%s、等级为%s、认证码为%s",账号1,对象id,名称1,bb名称,bb模型,bb种类,bb等级,bb认证码))
        玩家数据[操作id].角色:日志记录(format("[交易系统-获得bb]获得[%s][%s][%s]bb,名称为%s、模型为%s、种类为%s、等级为%s、认证码为%s",账号,操作id,名称,bb名称,bb模型,bb种类,bb等级,bb认证码))
        操作1=true
        常规提示(操作id,format("#Y/%s给了你#R%s",名称,bb名称))
        常规提示(对象id,format("#Y/你给了%s#R%s",名称1,bb名称))
    end
    local 临时bb1={}
    if 操作1 then
        for n,v in pairs(玩家数据[对象id].召唤兽.数据) do
          if 玩家数据[对象id].召唤兽.数据[n]~=nil then
              临时bb1[#临时bb1+1]=玩家数据[对象id].召唤兽.数据[n]
          end
        end
        玩家数据[对象id].召唤兽.数据={}
        玩家数据[对象id].召唤兽.数据=临时bb1
        发送数据(玩家数据[对象id].连接id,3512,玩家数据[操作id].召唤兽.数据)
        发送数据(玩家数据[操作id].连接id,3512,玩家数据[操作id].召唤兽.数据)
    end
    发送数据(玩家数据[操作id].连接id,3511,玩家数据[操作id].召唤兽.数据)
    发送数据(玩家数据[对象id].连接id,3511,玩家数据[对象id].召唤兽.数据)
    道具刷新(操作id)
    道具刷新(id1)
    交易数据[交易id]=nil
    玩家数据[操作id].交易信息=nil
    玩家数据[对象id].交易信息=nil
  end
end






function 道具处理类:设置交易数据(连接id,id,数据)
  if 玩家数据[id].交易信息 == nil then
      常规提示(id,"#Y/交易信息错误，本次交易取消")
      发送数据(玩家数据[id].连接id,3511)
      玩家数据[id].交易信息=nil
      交易数据[id]=nil
      return
  end
  local 交易id=玩家数据[id].交易信息.编号
  local 对方id=玩家数据[id].交易信息.id
  if not 数据.道具 or not 数据.bb then
        常规提示(对方id,"#Y/交易信息错误，本次交易取消")
        常规提示(交易id,"#Y/交易信息错误，本次交易取消")
        发送数据(玩家数据[对方id].连接id,3511)
        发送数据(玩家数据[交易id].连接id,3511)
        玩家数据[对方id].交易信息=nil
        玩家数据[交易id].交易信息=nil
        交易数据[交易id]=nil
        return
  end
  local 道具数据={}
  local bb数据={}
  local 银子数据=0
  if 数据.银子=="" or 数据.银子==nil then
      银子数据=0
  else
      银子数据=tonumber(数据.银子)
  end
   if not 银子数据 or 银子数据<0 or 银子数据~=math.floor(银子数据) or isNaN(银子数据) then
        常规提示(对方id,"#Y/交易信息错误，本次交易取消")
        常规提示(交易id,"#Y/交易信息错误，本次交易取消")
        发送数据(玩家数据[对方id].连接id,3511)
        发送数据(玩家数据[交易id].连接id,3511)
        玩家数据[对方id].交易信息=nil
        玩家数据[交易id].交易信息=nil
        交易数据[交易id]=nil
        return
  end
  交易数据[交易id][id].道具={}
  交易数据[交易id][id].bb={}
  交易数据[交易id][id].银子=银子数据
  for k,v in pairs(数据.道具) do
      local 道具id =玩家数据[id].角色.数据.道具[v]
      if 道具id and 玩家数据[id].道具.数据[道具id] then
        道具数据[#道具数据+1]=self:取指定道具(道具id)
        交易数据[交易id][id].道具[#交易数据[交易id][id].道具+1]={认证码=道具数据[#道具数据].识别码,格子=v,编号=道具id}
      end
  end
  for k,v in pairs(数据.bb) do
      if 玩家数据[id].召唤兽.数据[v] then
          bb数据[#bb数据+1]=DeepCopy(玩家数据[id].召唤兽.数据[v])
          交易数据[交易id][id].bb[#交易数据[交易id][id].bb+1]={认证码=bb数据[#bb数据].认证码,编号=v}
      end
  end
   if 交易数据[交易id][id].锁定 then
      交易数据[交易id][id].锁定=false
      常规提示(id,"#Y/你取消了锁定状态")
      常规提示(对方id,"#Y/对方取消了锁定状态")
   else
       交易数据[交易id][id].锁定=true
       常规提示(id,"#Y/你已经锁定了交易状态，对方锁定交易状态后点击确定即可完成交易")
       常规提示(对方id,"#Y/对方已经锁定了交易状态，等你锁定交易状态后点击确定即可完成交易")
   end
  发送数据(连接id,3508,{锁定=交易数据[交易id][id].锁定})
  发送数据(玩家数据[对方id].连接id,3510,{bb=bb数据,道具=道具数据,银子=银子数据,锁定=交易数据[交易id][id].锁定})
end

function 道具处理类:系统给予处理(连接id,id,数据)
  local 事件=玩家数据[id].给予数据.事件
  if not 数据.格子 or type(数据.格子)~="table" then return end
  if 数据.格子[1] and (not tonumber(数据.格子[1]) or tonumber(数据.格子[1])==0) then return end
  if 数据.格子[2] and (not tonumber(数据.格子[2]) or tonumber(数据.格子[2])==0) then return end
  if 数据.格子[3] and (not tonumber(数据.格子[3]) or tonumber(数据.格子[3])==0) then return end
  if 事件=="装备回收" then
    if not 共享货币[玩家数据[id].账号] then
        添加最后对话(id,"数据错误")
        道具刷新(id)
        return
    end
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 道具id1=玩家数据[id].角色.数据.道具[数据.格子[2]]
    local 道具id2=玩家数据[id].角色.数据.道具[数据.格子[3]]

    if self.数据[道具id]~= nil then
      if self.数据[道具id].总类~=2  then
        添加最后对话(id,"我拿这个玩意用来干啥？")
        道具刷新(id)
        return
      end
      if self.数据[道具id].级别限制<110 then
        添加最后对话(id,"我不需要这种级别的装备")
        return
      end
      local 仙玉数量 = 0
      if self.数据[道具id].级别限制==110 then
        仙玉数量 = 20
      elseif self.数据[道具id].级别限制==120  then
        仙玉数量 = 30
      elseif self.数据[道具id].级别限制==130  then
        仙玉数量 = 40
      elseif self.数据[道具id].级别限制==140  then
        仙玉数量 = 60
      elseif self.数据[道具id].级别限制==150  then
        仙玉数量 = 80
      elseif self.数据[道具id].级别限制==160  then
        仙玉数量 = 100
      end
      共享货币[玩家数据[id].账号]:添加仙玉(仙玉数量,id,"回收装备")
      self.数据[道具id] = nil
      玩家数据[id].角色.数据.道具[数据.格子[1]] = nil
    end

    if self.数据[道具id1]~= nil then
      if self.数据[道具id1].总类~=2  then
        添加最后对话(id,"我拿这个玩意用来干啥？")
        道具刷新(id)
        return
      end
      if self.数据[道具id1].级别限制<110 then
        添加最后对话(id,"我不需要这种级别的装备")
        return
      end
      local 仙玉数量 = 0
      if self.数据[道具id1].级别限制==110 then
        仙玉数量 = 20
      elseif self.数据[道具id1].级别限制==120  then
        仙玉数量 = 30
      elseif self.数据[道具id1].级别限制==130  then
        仙玉数量 = 40
      elseif self.数据[道具id1].级别限制==140  then
        仙玉数量 = 60
      elseif self.数据[道具id1].级别限制==150  then
        仙玉数量 = 80
      elseif self.数据[道具id1].级别限制==160  then
        仙玉数量 = 100
      end
      共享货币[玩家数据[id].账号]:添加仙玉(仙玉数量,id,"回收装备")
      self.数据[道具id1] = nil
      玩家数据[id].角色.数据.道具[数据.格子[2]] = nil
    end

    if self.数据[道具id2]~= nil then
      if self.数据[道具id2].总类~=2  then
        添加最后对话(id,"我拿这个玩意用来干啥？")
        道具刷新(id)
        return
      end
      if self.数据[道具id2].级别限制<110 then
        添加最后对话(id,"我不需要这种级别的装备")
        return
      end
      local 仙玉数量 = 0
      if self.数据[道具id2].级别限制==110 then
        仙玉数量 = 20
      elseif self.数据[道具id2].级别限制==120  then
        仙玉数量 = 30
      elseif self.数据[道具id2].级别限制==130  then
        仙玉数量 = 40
      elseif self.数据[道具id2].级别限制==140  then
        仙玉数量 = 60
      elseif self.数据[道具id2].级别限制==150  then
        仙玉数量 = 80
      elseif self.数据[道具id2].级别限制==160  then
        仙玉数量 = 100
      end
      共享货币[玩家数据[id].账号]:添加仙玉(仙玉数量,id,"回收装备")
      self.数据[道具id2] = nil
      玩家数据[id].角色.数据.道具[数据.格子[3]] = nil
    end

    道具刷新(id)
  elseif 事件=="更换法宝五行" then
    local 道具id=玩家数据[id].角色.数据.法宝[数据.格子[1]]
    if self.数据[道具id] == nil then
      道具刷新(id)
      return
    end
    if self.数据[道具id].总类~=1000 then
      添加最后对话(id,"只有法宝才可以更换五行哟，你这个是什么玩意？")
      return
    end


    if 玩家数据[id].角色:自定义扣除货币(自定义数据.更改法宝五行.货币类型,自定义数据.更改法宝五行.数量,"更换法宝五行",1) then
       self.数据[道具id].五行=取五行()
       常规提示(id,"#Y你所选的这个法宝五行已经更换为【"..self.数据[道具id].五行.."】")
       道具刷新(id)
    end



  elseif 事件=="更改装备五行" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    if self.数据[道具id] == nil then
        道具刷新(id)
        return
    end
    if self.数据[道具id].总类~=2 or self.数据[道具id].灵饰 or self.数据[道具id].分类>6 then
      添加最后对话(id,"我这里目前只能更换装备五行，其它的我可没那么大的能耐。")
      return
    end
    if 玩家数据[id].角色:自定义扣除货币(自定义数据.更改装备五行.货币类型,自定义数据.更改装备五行.数量,"更改装备五行",1) then
      self.数据[道具id].五行=取五行()
      常规提示(id,"#Y你所选的这个装备五行已经更换为【"..self.数据[道具id].五行.."】")
      道具刷新(id)
    end

    elseif 事件=="炼制灵犀之屑" then
        local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
        local 道具id1=玩家数据[id].角色.数据.道具[数据.格子[2]]
        local 道具id2=玩家数据[id].角色.数据.道具[数据.格子[3]]
        if self.数据[道具id] == nil and self.数据[道具id1] == nil and self.数据[道具id2] == nil  then
          添加最后对话(id,"炼制灵犀之屑需要，150级-160级的“人物装备”，#W即可兑换到对应数量的灵犀之屑")
          return
        end
      local 给与数量 = 0
      if self.数据[道具id]~=nil and self.数据[道具id].总类==2 and self.数据[道具id].分类<=6 and self.数据[道具id].级别限制>=150  then
          if self.数据[道具id].级别限制==150 then
             给与数量 = 给与数量 + 10
          elseif self.数据[道具id].级别限制==160 then
              给与数量 = 给与数量 + 15
          end
          玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
          self.数据[道具id]=nil
      end
      if self.数据[道具id1]~=nil and self.数据[道具id1].总类==2 and self.数据[道具id1].分类<=6 and self.数据[道具id1].级别限制>=150  then
          if self.数据[道具id1].级别限制==150 then
             给与数量 = 给与数量 + 10
          elseif self.数据[道具id1].级别限制==160 then
              给与数量 = 给与数量 + 15
          end
          玩家数据[id].角色.数据.道具[数据.格子[2]]=nil
          self.数据[道具id1]=nil
      end
      if self.数据[道具id2]~=nil and self.数据[道具id2].总类==2 and self.数据[道具id2].分类<=6 and self.数据[道具id2].级别限制>=150  then
          if self.数据[道具id2].级别限制==150 then
             给与数量 = 给与数量 + 10
          elseif self.数据[道具id2].级别限制==160 then
              给与数量 = 给与数量 + 15
          end
          玩家数据[id].角色.数据.道具[数据.格子[3]]=nil
          self.数据[道具id2]=nil
      end

       if  给与数量 > 0 then
           玩家数据[id].道具:给予道具(id,"灵犀之屑",给与数量)
           常规提示(id,"#Y/你获得了#R/"..给与数量.."#Y/个灵犀之屑")
        else
           常规提示(id,"#Y/破烂玩意谁要啊")
        end
        道具刷新(id)
   elseif 事件=="新春活动任务" then
      if 玩家数据[id].队伍==nil or 玩家数据[id].队伍==0 then 常规提示(id,"#Y/请组队前来") return end
      local 任务id=玩家数据[id].角色:取任务(212)
      --print(任务id,任务数据[任务id])
      if 任务id==0 or 任务数据[任务id]==nil then
        常规提示(id,"#Y/你没有这样的任务")
        return
      end

      local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
      if 道具id==0 or self.数据[道具id]==nil then
        常规提示(id,"#Y/你没有这样的道具")
         道具刷新(id)
        return
      end
      if self.数据[道具id].名称~=任务数据[任务id].物品  then
        添加最后对话(id,"我拿这个玩意用来干啥？")
        return
      end

     if self.数据[道具id].数量~=nil and self.数据[道具id].数量>0 then
        self.数据[道具id].数量=self.数据[道具id].数量-1
        if self.数据[道具id].数量<=0 then
          self.数据[道具id]=nil
          玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
        end
      else
        self.数据[道具id]=nil
        玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
      end
      任务处理类:完成春节任务(id)
      道具刷新(id)




 elseif 事件=="购买打造处理" then
       if 数据.格子[1] == nil or 数据.格子[2]== nil then return end
        local 临时内容={}
        临时内容.类型="打造"
        if 玩家数据[id].摊位购买打造 and  玩家数据[id].摊位购买打造.打造技能=="淬灵之术" then
           临时内容.分类 = "强化灵饰淬灵"
        else
           临时内容.分类 = "强化人物装备"
        end
        临时内容.序列 = 数据.格子[1]
        临时内容.序列1 = 数据.格子[2]
        玩家数据[id].装备:数据处理(玩家数据[id].连接id,4501,id,临时内容)
  elseif 事件=="打造任务提交" then
          local 道具格子 =玩家数据[id].角色:取道具格子()
          if 道具格子==0 then
                      常规提示(id,"#Y/你身上没有足够的空间")
          else
                玩家数据[id].装备:打造任务处理(连接id,4501,id,数据)
          end
  elseif 事件=="兽决兑换兽决" then
          local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
          local 道具id1=玩家数据[id].角色.数据.道具[数据.格子[2]]
          if self.数据[道具id]== nil or self.数据[道具id1]== nil then
            道具刷新(id)
            return
          end
          if self.数据[道具id].名称~= "高级魔兽要诀" or self.数据[道具id1].名称~= "高级魔兽要诀"  then
             添加最后对话(id,"我拿这个玩意用来干啥？")
             道具刷新(id)
            return
          end
            self:给予道具(id,"高级魔兽要诀")
            常规提示(id,"#Y/你获得了#R/高级魔兽要诀")
            self.数据[道具id] = nil
            玩家数据[id].角色.数据.道具[数据.格子[1]] = nil
            self.数据[道具id1] = nil
            玩家数据[id].角色.数据.道具[数据.格子[2]] = nil
            道具刷新(id)
  elseif 事件=="特殊兑换碎片" then
            if not 自定义数据.兽决兑换配置 then return end
            local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
            local 道具id1=玩家数据[id].角色.数据.道具[数据.格子[2]]
            local 道具id2=玩家数据[id].角色.数据.道具[数据.格子[3]]

            local 物品数量 = 0
            if self.数据[道具id] and self.数据[道具id].名称=="特殊魔兽要诀" then
                物品数量=物品数量+1
                self.数据[道具id] = nil
                玩家数据[id].角色.数据.道具[数据.格子[1]] = nil
            end
            if self.数据[道具id1] and self.数据[道具id1].名称=="特殊魔兽要诀" then
                物品数量=物品数量+1
                self.数据[道具id1] = nil
                玩家数据[id].角色.数据.道具[数据.格子[2]] = nil
            end
            if self.数据[道具id2] and self.数据[道具id2].名称=="特殊魔兽要诀" then
                物品数量=物品数量+1
                self.数据[道具id2] = nil
                玩家数据[id].角色.数据.道具[数据.格子[3]] = nil
            end
            if  物品数量~= 0 then
                 local 给予数量 = 物品数量*自定义数据.兽决兑换配置.特殊
                self:给予道具(id,"特殊兽决碎片",给予数量)
                常规提示(id,"#Y你获得了#R"..给予数量.."#Y个#R特殊兽决碎片")
           end
            道具刷新(id)

  elseif 事件=="超级兑换碎片" then
            if not 自定义数据.兽决兑换配置 then return end
            local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
            local 道具id1=玩家数据[id].角色.数据.道具[数据.格子[2]]
            local 道具id2=玩家数据[id].角色.数据.道具[数据.格子[3]]

            local 物品数量 = 0
            if self.数据[道具id] and self.数据[道具id].名称=="超级魔兽要诀" then
                物品数量=物品数量+1
                self.数据[道具id] = nil
                玩家数据[id].角色.数据.道具[数据.格子[1]] = nil
            end
            if self.数据[道具id1] and self.数据[道具id1].名称=="超级魔兽要诀" then
                物品数量=物品数量+1
                self.数据[道具id1] = nil
                玩家数据[id].角色.数据.道具[数据.格子[2]] = nil
            end
            if self.数据[道具id2] and self.数据[道具id2].名称=="超级魔兽要诀" then
                物品数量=物品数量+1
                self.数据[道具id2] = nil
                玩家数据[id].角色.数据.道具[数据.格子[3]] = nil
            end
            if  物品数量~= 0 then
                 local 给予数量 = 物品数量*自定义数据.兽决兑换配置.超级
                self:给予道具(id,"超级兽决碎片",给予数量)
                常规提示(id,"#Y你获得了#R"..给予数量.."#Y个#R超级兽决碎片")
           end
            道具刷新(id)
  elseif 事件=="灵兜兜兑换神兽" then
            if not 自定义数据.灵兜兜兑换 or type(自定义数据.灵兜兜兑换) ~= "table" then
                  error("灵兜兜兑换配置错误")
                  道具刷新(id)
                  return
            elseif not 自定义数据.灵兜兜兑换.数量 or type(自定义数据.灵兜兜兑换.数量) ~= "number" then
                      道具刷新(id)
                      return
            elseif not 自定义数据.灵兜兜兑换.名称 or type(自定义数据.灵兜兜兑换.名称) ~= "string"  then
                      道具刷新(id)
                      return
            end
            local 兜兜列表 = {}
            for i = 1, 3 do
                local 格子 = 数据.格子[i]
                if 格子 and 格子~=0 then
                    local 道具 = self.数据[玩家数据[id].角色.数据.道具[格子]]
                    if 道具 and 道具~=0 and 道具.名称 == "灵兜兜" and 道具.数量 and 道具.数量 > 0 then
                        table.insert(兜兜列表, {
                            格子 = 格子,
                            道具id = 玩家数据[id].角色.数据.道具[格子]
                        })
                    end
                end
            end
            if #兜兜列表 == 0 then
                添加最后对话(id, "请放入灵兜兜进行兑换")
                道具刷新(id)
                return
            end
            local 总数量 = 0
            for _, v in ipairs(兜兜列表) do
                总数量 = 总数量 + self.数据[v.道具id].数量
            end
            if 总数量 < 自定义数据.灵兜兜兑换.数量 then
                添加最后对话(id, string.format("灵兜兜数量不足，需要%d个当前%d个", 自定义数据.灵兜兜兑换.数量, 总数量))
                道具刷新(id)
                return
            end
            local 剩余扣除 = 自定义数据.灵兜兜兑换.数量
            for _, v in ipairs(兜兜列表) do
                if 剩余扣除 <= 0 then break end
                local 可扣除 = math.min(self.数据[v.道具id].数量, 剩余扣除)
                self.数据[v.道具id].数量 = self.数据[v.道具id].数量 - 可扣除
                剩余扣除 = 剩余扣除 - 可扣除
                if self.数据[v.道具id].数量 <= 0 then
                    self.数据[v.道具id] = nil
                    玩家数据[id].角色.数据.道具[v.格子] = nil
                end
            end
            self:给予道具(id, 自定义数据.灵兜兜兑换.名称, 1)
            常规提示(id, string.format("#Y成功消耗%d个灵兜兜兑换#R%s", 自定义数据.灵兜兜兑换.数量, 自定义数据.灵兜兜兑换.名称))
            道具刷新(id)

  elseif 事件=="神兽兑换一" or 事件=="神兽兑换二" or 事件=="神兽兑换三" then
      if not 自定义数据[事件] or type(自定义数据[事件]) ~= "table" then
          error("神兽"..事件.."配置错误")
          道具刷新(id)
          return
      elseif not 自定义数据[事件].数量 or type(自定义数据[事件].数量) ~= "number" then
          道具刷新(id)
          return
      elseif not 自定义数据[事件].所需 or type(自定义数据[事件].所需) ~= "string" then
          道具刷新(id)
          return
      elseif not 自定义数据[事件].名称 or type(自定义数据[事件].名称) ~= "string" then
          道具刷新(id)
          return
      end
      local 礼包列表 = {}
      for i = 1, 3 do
          local 格子 = 数据.格子[i]
          if 格子 and 格子~=0 then
              local 道具 = self.数据[玩家数据[id].角色.数据.道具[格子]]
              if 道具 and 道具~=0 and 道具.名称 == 自定义数据[事件].所需 and 道具.数量 and 道具.数量 > 0 then
                  table.insert(礼包列表, {
                      格子 = 格子,
                      道具id = 玩家数据[id].角色.数据.道具[格子]
                  })
              end
          end
      end
      if #礼包列表 == 0 then
          添加最后对话(id, "请放入"..自定义数据[事件].所需.."进行兑换")
          道具刷新(id)
          return
      end
      local 总数量 = 0
      for _, v in ipairs(礼包列表) do
          总数量 = 总数量 + self.数据[v.道具id].数量
      end
      if 总数量 < 自定义数据[事件].数量 then
          添加最后对话(id, string.format("%s数量不足，需要%d个当前%d个", 自定义数据[事件].所需,自定义数据[事件].数量, 总数量))
          道具刷新(id)
          return
      end
      local 剩余扣除 = 自定义数据[事件].数量
      for _, v in ipairs(礼包列表) do
          if 剩余扣除 <= 0 then break end
          local 可扣除 = math.min(self.数据[v.道具id].数量, 剩余扣除)
          self.数据[v.道具id].数量 = self.数据[v.道具id].数量 - 可扣除
          剩余扣除 = 剩余扣除 - 可扣除
          if self.数据[v.道具id].数量 <= 0 then
              self.数据[v.道具id] = nil
              玩家数据[id].角色.数据.道具[v.格子] = nil
          end
      end
      self:给予道具(id, 自定义数据[事件].名称, 1)
      常规提示(id, string.format("#Y成功消耗%d个%s兑换#R%s", 自定义数据[事件].数量,自定义数据[事件].所需,自定义数据[事件].名称))
      道具刷新(id)


elseif 事件=="低内丹兑换低内丹" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 道具id1=玩家数据[id].角色.数据.道具[数据.格子[2]]
    local 道具id2=玩家数据[id].角色.数据.道具[数据.格子[3]]
    if self.数据[道具id]== nil or self.数据[道具id1]== nil or self.数据[道具id2]== nil then
      道具刷新(id)
      return
    end
    if self.数据[道具id].名称~= "召唤兽内丹" or self.数据[道具id1].名称~= "召唤兽内丹" or self.数据[道具id2].名称~= "召唤兽内丹"  then
       添加最后对话(id,"我拿这个玩意用来干啥？")
       道具刷新(id)
      return
    end
      self:给予道具(id,"召唤兽内丹")
      常规提示(id,"#Y/你获得了#R/召唤兽内丹")
      self.数据[道具id] = nil
      玩家数据[id].角色.数据.道具[数据.格子[1]] = nil
      self.数据[道具id1] = nil
      玩家数据[id].角色.数据.道具[数据.格子[2]] = nil
      self.数据[道具id2] = nil
      玩家数据[id].角色.数据.道具[数据.格子[3]] = nil
      道具刷新(id)
  elseif 事件=="高内丹兑换高内丹" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 道具id1=玩家数据[id].角色.数据.道具[数据.格子[2]]
    local 道具id2=玩家数据[id].角色.数据.道具[数据.格子[3]]
    if self.数据[道具id]== nil or self.数据[道具id1]== nil or self.数据[道具id2]== nil then
      道具刷新(id)
      return
    end
    if self.数据[道具id].名称~= "高级召唤兽内丹" or self.数据[道具id1].名称~= "高级召唤兽内丹" or self.数据[道具id2].名称~= "高级召唤兽内丹"  then
       添加最后对话(id,"我拿这个玩意用来干啥？")
       道具刷新(id)
      return
    end
      self:给予道具(id,"高级召唤兽内丹")
      常规提示(id,"#Y/你获得了#R/高级召唤兽内丹")
      self.数据[道具id] = nil
      玩家数据[id].角色.数据.道具[数据.格子[1]] = nil
      self.数据[道具id1] = nil
      玩家数据[id].角色.数据.道具[数据.格子[2]] = nil
      self.数据[道具id2] = nil
      玩家数据[id].角色.数据.道具[数据.格子[3]] = nil
      道具刷新(id)
   elseif 事件=="188个神兜兜" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 道具id1=玩家数据[id].角色.数据.道具[数据.格子[2]]
    local 道具id2=玩家数据[id].角色.数据.道具[数据.格子[3]]
    if  道具id==nil or 道具id1==nil or 道具id2==nil then
       添加最后对话(id,"我放入的物品呢？？？")
       道具刷新(id)
       return
     end
    if  self.数据[道具id]==nil or self.数据[道具id1]==nil or self.数据[道具id2]==nil then
       添加最后对话(id,"我放入的物品呢？？？")
       道具刷新(id)
      return
     end



    if self.数据[道具id].名称 ~= "神兜兜" then
         添加最后对话(id,"请依次放入神兜兜后特殊魔兽要诀")
         道具刷新(id)
        return
      end
      if self.数据[道具id].数量==nil then
        添加最后对话(id,"数据错误")
        return
      end

      if self.数据[道具id1].名称 ~= "特殊魔兽要诀" or self.数据[道具id2].名称 ~= "特殊魔兽要诀" then
         添加最后对话(id,"请依次放入神兜兜后特殊魔兽要诀")
         道具刷新(id)
        return
      end

      if self.数据[道具id].数量 < 188 then
         添加最后对话(id,"神兜兜数量不足无法兑换")
        return
      end

      local 选项={}
       for n=1,#玩家数据[id].召唤兽.数据 do
          if 玩家数据[id].召唤兽.数据[n].种类=="神兽" and 玩家数据[id].召唤兽.数据[n].天生技能~=nil and 玩家数据[id].召唤兽.数据[n].天生技能[1]~=nil  then
              选项[#选项+1]=format("%s,等级:%s",玩家数据[id].召唤兽.数据[n].名称,玩家数据[id].召唤兽.数据[n].等级)
          end
         end
         if #选项 < 1 then
          添加最后对话(id,"你没有可以选择的神兽")
          玩家数据[id].神兽天生操作 = nil
          return
        end
     发送数据(玩家数据[id].连接id,1501,{名称="袁天罡",模型="袁天罡",对话="请选择更换技能的召唤兽",选项=选项})
      local 玩家道具ID = {[1]=道具id,[2]=道具id1,[3]=道具id2}
      玩家数据[id].神兽天生操作 = {道具id =玩家道具ID,神兽 = 1,数量 = 188}
      道具刷新(id)

    elseif 事件=="888个神兜兜" then
       local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 道具id1=玩家数据[id].角色.数据.道具[数据.格子[2]]
    local 道具id2=玩家数据[id].角色.数据.道具[数据.格子[3]]
    if  道具id==nil or 道具id1==nil or 道具id2==nil then
       添加最后对话(id,"我放入的物品呢？？？")
       道具刷新(id)
       return
     end
    if  self.数据[道具id]==nil or self.数据[道具id1]==nil or self.数据[道具id2]==nil then
       添加最后对话(id,"我放入的物品呢？？？")
       道具刷新(id)
      return
     end



    if self.数据[道具id].名称 ~= "神兜兜" then
         添加最后对话(id,"请依次放入神兜兜后特殊魔兽要诀")
         道具刷新(id)
        return
      end
      if self.数据[道具id].数量==nil then
        添加最后对话(id,"数据错误")
        return
      end

      if self.数据[道具id1].名称 ~= "特殊魔兽要诀" or self.数据[道具id2].名称 ~= "特殊魔兽要诀" then
         添加最后对话(id,"请依次放入神兜兜后特殊魔兽要诀")
         道具刷新(id)
        return
      end

      if self.数据[道具id].数量 < 188 then
         添加最后对话(id,"神兜兜数量不足无法兑换")
        return
      end

      local 选项={}
       for n=1,#玩家数据[id].召唤兽.数据 do
          if 玩家数据[id].召唤兽.数据[n].种类=="神兽" and 玩家数据[id].召唤兽.数据[n].天生技能~=nil and 玩家数据[id].召唤兽.数据[n].天生技能[1]~=nil and #玩家数据[id].召唤兽.数据[n].天生技能<=4 then
              选项[#选项+1]=format("%s,等级:%s",玩家数据[id].召唤兽.数据[n].名称,玩家数据[id].召唤兽.数据[n].等级)
          end
         end
         if #选项 < 1 then
          添加最后对话(id,"你没有可以选择的神兽")
          玩家数据[id].神兽天生操作 = nil
          return
        end
        发送数据(玩家数据[id].连接id,1501,{名称="袁天罡",模型="袁天罡",对话="请选择更换技能的召唤兽",选项=选项})


      local 玩家道具ID = {[1]=道具id,[2]=道具id1,[3]=道具id2}
      玩家数据[id].神兽天生操作 = {道具id =玩家道具ID,神兽 = 2,数量 = 888}
      道具刷新(id)
   elseif 事件=="神兽成长资质提升" then

     if 自定义数据.神兽提升资质==nil then
        玩家数据[id].神兽成长提升 =nil
        添加最后对话(id,"数据错误")
        道具刷新(id)
        return
      end
      if 自定义数据.神兽提升数据==nil then
        玩家数据[id].神兽成长提升 =nil
        添加最后对话(id,"数据错误")
        道具刷新(id)
        return
      end

      if 玩家数据[id].神兽成长提升 ==nil then
        玩家数据[id].神兽成长提升 =nil
        添加最后对话(id,"数据错误")
       道具刷新(id)
        return
      end

      if 玩家数据[id].神兽成长提升.扣除编号 ==nil or 玩家数据[id].神兽成长提升.认证码==nil then
        玩家数据[id].神兽成长提升 =nil
        添加最后对话(id,"数据错误")
        道具刷新(id)
        return
      end

      if 自定义数据.神兽提升数据[玩家数据[id].神兽成长提升.扣除编号] ==nil then
        玩家数据[id].神兽成长提升 =nil
        添加最后对话(id,"数据错误")
        道具刷新(id)
        return
      end

      if 自定义数据.神兽提升数据[玩家数据[id].神兽成长提升.扣除编号].物品数量 ==nil or 自定义数据.神兽提升数据[玩家数据[id].神兽成长提升.扣除编号].货币类型 ==nil or 自定义数据.神兽提升数据[玩家数据[id].神兽成长提升.扣除编号].数量 ==nil then
        玩家数据[id].神兽成长提升 =nil
        添加最后对话(id,"数据错误")
        道具刷新(id)
        return
      end

    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    if  道具id==nil then
       玩家数据[id].神兽成长提升 =nil
       添加最后对话(id,"我放入的物品呢？？？")
       道具刷新(id)
       return
     end
    if  self.数据[道具id]==nil  then
       玩家数据[id].神兽成长提升 =nil
       添加最后对话(id,"我放入的物品呢？？？")
       道具刷新(id)
      return
     end

    if self.数据[道具id].名称 ~= "神兜兜" then
        玩家数据[id].神兽成长提升 =nil
         添加最后对话(id,"请放入神兜兜")
         道具刷新(id)
        return
      end
      if self.数据[道具id].数量==nil then
        玩家数据[id].神兽成长提升 =nil
        添加最后对话(id,"数据错误")
        return
      end
      if self.数据[道具id].数量<自定义数据.神兽提升数据[玩家数据[id].神兽成长提升.扣除编号].物品数量 then
        玩家数据[id].神兽成长提升 =nil
        添加最后对话(id,"神兜兜数量不足无法兑换")
        return
      end
      local 取编号 = 玩家数据[id].召唤兽:取编号(玩家数据[id].神兽成长提升.认证码)
         if 取编号 == 0 or 玩家数据[id].召唤兽.数据[取编号]==nil  then
             玩家数据[id].神兽成长提升 =nil
             添加最后对话(id,"神兜兜数量不足无法兑换")
             return
          end
          local 取出名字 = "超级泡泡"
          local 升级名字 =  取二代神兽()
          if 玩家数据[id].神兽成长提升.扣除编号 == 2 then
             取出名字 =  取二代神兽()
             升级名字 =  取三代神兽()
          elseif 玩家数据[id].神兽成长提升.扣除编号 == 3 then
             取出名字 =  取三代神兽()
             升级名字 =  取四代神兽()
          end
          local 取出成长 = 玩家数据[id].召唤兽:置神兽对象(取出名字,取出名字)
          if 玩家数据[id].召唤兽.数据[取编号].成长<取出成长.成长 then
            玩家数据[id].神兽成长提升 =nil
             添加最后对话(id,"数据错误")
             return
          end

      if 玩家数据[id].角色:自定义扣除货币(自定义数据.神兽提升数据[玩家数据[id].神兽成长提升.扣除编号].货币类型,自定义数据.神兽提升数据[玩家数据[id].神兽成长提升.扣除编号].数量,"提升资质",1) then
         local 取出升级 = 玩家数据[id].召唤兽:置神兽对象(升级名字,升级名字)
         玩家数据[id].召唤兽.数据[取编号].攻击资质 = 取出升级.攻击资质
         玩家数据[id].召唤兽.数据[取编号].防御资质 = 取出升级.防御资质
         玩家数据[id].召唤兽.数据[取编号].体力资质 = 取出升级.体力资质
         玩家数据[id].召唤兽.数据[取编号].法力资质 = 取出升级.法力资质
         玩家数据[id].召唤兽.数据[取编号].速度资质 = 取出升级.速度资质
         玩家数据[id].召唤兽.数据[取编号].躲闪资质 = 取出升级.躲闪资质
         玩家数据[id].召唤兽.数据[取编号].成长 = 取出升级.成长
         玩家数据[id].召唤兽:刷新信息(取编号)
         常规提示(id,"恭喜你，该召唤兽资质成长增加了")
         self.数据[道具id].数量=self.数据[道具id].数量-自定义数据.神兽提升数据[玩家数据[id].神兽成长提升.扣除编号].物品数量
         if self.数据[道具id].数量<=0 then
             self.数据[道具id]=nil
             玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
          end
          道具刷新(id)
      else
          常规提示(id,"未达到更换条件")
      end
     玩家数据[id].神兽成长提升 =nil



  elseif 事件=="侠义任务物品" then
    local 任务id=玩家数据[id].角色:取任务(346)
    if 任务id==0 or 任务数据[任务id]==nil then
      常规提示(id,"#Y/你没有这样的任务")
      return
    end
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    if self.数据[道具id] == nil then
      常规提示(id,"#Y/请检查你给予的物品是否存在")
      道具刷新(id)
      return
    end
    local 名称=self.数据[道具id].名称
    local 所需物品=任务数据[任务id].物品
    if 名称=="魔兽要诀" or 名称=="召唤兽内丹" then
      名称=self.数据[道具id].附带技能
    elseif 名称 == "怪物卡片" then
      名称 = self.数据[道具id].造型
    elseif 名称 == "鬼谷子" then
      名称 = self.数据[道具id].子类
    end
    if 名称~=所需物品 then
      常规提示(id,"#Y/对方需要的不是这种物品")
      道具刷新(id)
      return
    end
    if 名称==所需物品 then
      if 所需物品=="青龙石" or 所需物品=="白虎石" or 所需物品=="朱雀石" or 所需物品=="玄武石" then
        if self.数据[道具id].数量<10 then
          常规提示(id,"#Y/你给予的物品不满足条件，强化石需要数量为10个")
          道具刷新(id)
          return
        end
      end
      if self.数据[道具id]~=nil and self.数据[道具id].数量~=nil and self.数据[道具id].数量 >1 then
        if 所需物品=="青龙石" or 所需物品=="白虎石" or 所需物品=="朱雀石" or 所需物品=="玄武石" then
          self.数据[道具id].数量 = self.数据[道具id].数量 - 10
        else
          self.数据[道具id].数量 = self.数据[道具id].数量 - 1
        end
        任务处理类:完成侠义任务(任务id,id)
        道具刷新(id)
      else
        self.数据[道具id]=nil
        玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
        任务处理类:完成侠义任务(任务id,id)
        道具刷新(id)
      end
    end

  elseif 事件=="给予银票" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    if 活动次数查询(id,"跑商")==false then
    return
    end
     if self.数据[道具id] == nil then
      常规提示(id,"#Y/请检查你给予的物品是否存在")
      道具刷新(id)
      return
    end
    if self.数据[道具id].名称 ~= "帮派银票" then
        常规提示(id,"#Y/对方需要的不是这种物品")
        return
    end
    if self.数据[道具id].初始金额 < self.数据[道具id].完成金额 then
        常规提示(id,"#Y/还没赚够足够的银票，你这是糊弄我呢？")
        return
    end
      if os.time() - 玩家数据[id].角色.数据.跑商时间 <= 15 or 玩家数据[id].角色.数据.跑商时间==nil then
        __S服务:输出("玩家"..id.." 疑似重复刷跑商任务!")
        写配置("./ip封禁.ini","ip",玩家数据[id].ip,1)
        写配置("./ip封禁.ini","ip",玩家数据[id].ip.." 疑似重复刷跑商任务,玩家ID:"..id,1)
        发送数据(玩家数据[id].连接id,998,"请注意你的角色异常！已经对你进行封IP")
        --__S服务:断开连接(玩家数据[id].连接id)
        return
      elseif os.time() - 玩家数据[id].角色.数据.跑商时间 <= 30 then
        常规提示(id,"#Y/我这里正在忙着整理商品，请你稍后再来！(30秒内仅可上交一次)")
        return
      end
    玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
    玩家数据[id].角色.数据.跑商=nil
    玩家数据[id].角色.数据.跑商时间=nil
    local 帮派编号 = 玩家数据[id].角色.数据.帮派数据.编号
    帮派数据[帮派编号].成员数据[id].跑商 = 帮派数据[帮派编号].成员数据[id].跑商 + 1
        添加活动次数(id,"跑商")
        玩家数据[id].道具:一键回收跑商物品(玩家数据[id].连接id,id)
        玩家数据[id].角色:添加银子(100000,"帮派跑商",1)
        玩家数据[id].角色:添加经验(100000,"帮派跑商",1)
        if 取随机数(1,100)<=90 then
        玩家数据[id].道具:给予道具(id,"金柳露",取随机数(1,5))
        常规提示(id,"#Y你获得了金柳露")
        else
        玩家数据[id].道具:给予道具(id,"超级金柳露",取随机数(1,5))
        常规提示(id,"#Y你获得了超级金柳露")
        end
        if 取随机数(1,100)<=1 then
          local 名称="110级书铁"
          self:给予书铁(id,{11,11})
          常规提示(id,"#Y/你获得了#R110级书铁")
          广播消息({内容=format("#S(跑商活动)#R/%s#Y在跑商活动中如有神助，妙笔生花，获得了#G/%s",玩家数据[id].角色.数据.名称,名称),频道="xt"})
        end
        帮派数据[帮派编号].成员数据[id].帮贡.当前 = 帮派数据[帮派编号].成员数据[id].帮贡.当前 + 50
        帮派数据[帮派编号].成员数据[id].帮贡.上限 = 帮派数据[帮派编号].成员数据[id].帮贡.上限 + 50
        玩家数据[id].角色.数据.帮贡 = 帮派数据[帮派编号].成员数据[id].帮贡.当前
        帮派数据[帮派编号].繁荣度 = 帮派数据[帮派编号].繁荣度 + 80
        帮派数据[帮派编号].繁荣度 = 帮派数据[帮派编号].人气度 + 40
        帮派数据[帮派编号].帮派资金.当前 = 帮派数据[帮派编号].帮派资金.当前 + self.数据[道具id].初始金额
    if 帮派数据[帮派编号].帮派资金.当前 > 帮派数据[帮派编号].帮派资金.上限 then
        帮派数据[帮派编号].帮派资金.当前 = 帮派数据[帮派编号].帮派资金.上限
    end
    广播帮派消息({内容="[帮派总管]#R/"..玩家数据[id].角色.数据.名称.."#Y/完成跑商任务，帮派资金增加了#R/"..self.数据[道具id].初始金额.."#Y/两。",频道="bp"},帮派编号)
    常规提示(id,"#Y/感谢少侠为帮派的发展做出的贡献！")
    道具刷新(id)
  elseif 事件=="给予金银锦盒" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
     if self.数据[道具id] == nil then
      常规提示(id,"#Y/请检查你给予的物品是否存在")
      道具刷新(id)
      return
    end
    if self.数据[道具id].名称 ~= "金银锦盒" then
        常规提示(id,"#Y/对方需要的不是这种物品")
        return
    end
    local 增加帮派资金=self.数据[道具id].数量*50000
    local 增加帮贡=self.数据[道具id].数量*5
    帮派数据[玩家数据[id].角色.数据.帮派数据.编号].成员数据[id].帮贡.当前=帮派数据[玩家数据[id].角色.数据.帮派数据.编号].成员数据[id].帮贡.当前+增加帮贡
    帮派数据[玩家数据[id].角色.数据.帮派数据.编号].成员数据[id].帮贡.上限=帮派数据[玩家数据[id].角色.数据.帮派数据.编号].成员数据[id].帮贡.上限+增加帮贡
    帮派数据[玩家数据[id].角色.数据.帮派数据.编号].帮派资金.当前=帮派数据[玩家数据[id].角色.数据.帮派数据.编号].帮派资金.当前+增加帮派资金
    玩家数据[id].角色.数据.帮贡 = 帮派数据[玩家数据[id].角色.数据.帮派数据.编号].成员数据[id].帮贡.当前
    self.数据[道具id]=nil
    玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
    道具刷新(id)
    常规提示(id,"#Y/成功为帮派增加了#R/"..增加帮派资金.."#Y/两银子。获得了#R/"..增加帮贡.."#Y/点帮贡")
    广播帮派消息({内容="[金库总管]#G/"..玩家数据[id].角色.数据.名称.."#Y/上交金银锦盒为帮派增加了帮派资金#R/"..增加帮派资金.."#Y/两银子。#93",频道="bp"},玩家数据[id].角色.数据.帮派数据.编号)



  elseif 事件=="上交魔兽残卷" then
    if 玩家数据[id].角色.数据.魔兽残卷 == nil then
      玩家数据[id].角色.数据.魔兽残卷 = 0
    end
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
     if self.数据[道具id] == nil then
      常规提示(id,"#Y/请检查你给予的物品是否存在")
      道具刷新(id)
      return
    end
    if self.数据[道具id].名称~="魔兽残卷" then
      常规提示(id,"#Y/你确定给我的是魔兽残卷么")
      return
    else
      local 欠缺 = 300 - 玩家数据[id].角色.数据.魔兽残卷
      if self.数据[道具id].数量 < 欠缺 then
        玩家数据[id].角色.数据.魔兽残卷 = 玩家数据[id].角色.数据.魔兽残卷 + self.数据[道具id].数量
        self.数据[道具id]=nil
        玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
        道具刷新(id)
        常规提示(id,"#Y/上交魔兽残卷成功")
      else
        self.数据[道具id].数量 = self.数据[道具id].数量 - 欠缺
        玩家数据[id].角色.数据.魔兽残卷 = 0
        local 名称="特殊魔兽要诀"
        local 技能=取特殊要诀()
        玩家数据[id].道具:给予道具(id,名称,nil,技能)
        玩家数据[id].角色.数据.千亿兽决 = 1
        常规提示(id,"#Y/你获得了"..名称)
        广播消息({内容=format("#S(魔兽残卷)#R/%s#Y累计收集了300份#R魔兽残卷#Y,受到#R唐王#Y大加赞赏,特赐下#G/特殊魔兽要诀-%s#Y以示褒奖！".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,技能),频道="xt"})
      end
    end


 elseif 事件 == "铸斧还原武器" then
        local 道具id = 玩家数据[id].角色.数据.道具[数据.格子[1]]
        if not 道具id or 道具id==0 or self.数据[道具id] == nil then
            常规提示(id,"#Y请检查你给予的物品是否存在")
            道具刷新(id)
            return
        end
        if not string.find(self.数据[道具id].名称, "(乾)") and not string.find(self.数据[道具id].名称, "(坤)") then
            道具刷新(id)
            常规提示(id,"#Y你交给我的是什么鬼东西？！")
            return
        end
        if  not self.数据[道具id].原始数据 then
            self.数据[道具id]=nil
            常规提示(id,"#Y装备数据错误,系统已回收！")
            道具刷新(id)
            return
        end
        if string.find(self.数据[道具id].名称, "(乾)") and self.数据[道具id].分类 ~= 3 and  self.数据[道具id].子类 ~= 26 then
              self.数据[道具id]=nil
              常规提示(id,"#Y装备数据错误,系统已回收！")
              道具刷新(id)
              return
         elseif string.find(self.数据[道具id].名称, "(坤)") and self.数据[道具id].分类 ~= 4 and not self.数据[道具id].性别限制  then

                self.数据[道具id]=nil
                常规提示(id,"#Y装备数据错误,系统已回收！")
                道具刷新(id)
              return
          end
          if  self.数据[道具id].分类==4  and self.数据[道具id].装备境界 and self.数据[道具id].装备境界.词条 then
                 if self.数据[道具id].装备境界.词条[1] then
                    local 临时词条 = self.数据[道具id].装备境界.词条[1].类型
                    local 临时数额 = self.数据[道具id].装备境界.词条[1].数额
                     self:给予道具(id,"鸿蒙原石",1,{类型=临时词条,数额=临时数额})
                     self.数据[道具id].装备境界.词条[1]=nil
                     常规提示(id,"#Y/你获得了#R"..临时词条.."#Y词条数额为#G"..临时数额.."#Y的#R鸿蒙原石#Y1个")
                 end
                 if self.数据[道具id].装备境界.词条[2] then
                     local 临时词条 = self.数据[道具id].装备境界.词条[2].类型
                    local 临时数额 = self.数据[道具id].装备境界.词条[2].数额*2
                     self:给予道具(id,"鸿蒙原石",1,{类型=临时词条,数额=临时数额})
                     self.数据[道具id].装备境界.词条[2]=nil
                     常规提示(id,"#Y/你获得了#R"..临时词条.."#Y词条数额为#G"..临时数额.."#Y的#R鸿蒙原石#Y1个")
                 end
                 if self.数据[道具id].装备境界.词条[3] then
                    local 临时词条 = self.数据[道具id].装备境界.词条[3].类型
                    local 临时数额 = self.数据[道具id].装备境界.词条[3].数额*2
                     self:给予道具(id,"鸿蒙原石",1,{类型=临时词条,数额=临时数额})
                     self.数据[道具id].装备境界.词条[3]=nil
                     常规提示(id,"#Y/你获得了#R"..临时词条.."#Y词条数额为#G"..临时数额.."#Y的#R鸿蒙原石#Y1个")
                 end
                 self.数据[道具id].装备境界.词条共鸣=false
          end
          self.数据[道具id].名称=self.数据[道具id].原始数据.名称
          self.数据[道具id].分类=self.数据[道具id].原始数据.分类
          self.数据[道具id].子类=self.数据[道具id].原始数据.子类
          self.数据[道具id].角色限制=self.数据[道具id].原始数据.角色限制
          self.数据[道具id].性别限制=nil
          添加最后对话(id,"你将武器#R"..self.数据[道具id].原始数据.名称.."#W还原成了#R"..self.数据[道具id].名称)
          self.数据[道具id].原始数据=nil
          道具刷新(id)
  elseif 事件 == "武器转换铸斧(乾)" or 事件 == "武器转换铸斧(坤)" then
        local 道具id = 玩家数据[id].角色.数据.道具[数据.格子[1]]
        if not 道具id or 道具id==0 or self.数据[道具id] == nil then
              常规提示(id,"#Y请检查你给予的物品是否存在")
              道具刷新(id)
              return
        end
        if string.find(self.数据[道具id].名称, "(乾)") or  string.find(self.数据[道具id].名称, "(坤)") then
            道具刷新(id)
            常规提示(id,"#Y你交给我的是什么鬼东西？！")
            return
        end
        if self.数据[道具id].总类 ~= 2 or self.数据[道具id].分类 ~= 3 then
                道具刷新(id)
                常规提示(id,"#Y你交给我的是什么鬼东西？！")
                return
        end
        if not self.数据[道具id].鉴定 then
            道具刷新(id)
            常规提示(id,"#Y未鉴定装备无法转换")
            return
        end
        local 斧头名称={"顽石双斧","镔铁双斧","黑曜双斧","枭首双斧","破军双斧","隳城双戚","飞头蛮","竹叶青","鲛煞",
                        "啖月","义战","恶来","烬世野火","九州海沸","八狱末劫","罗喉计都","非天"}
        if not self.数据[道具id].原始数据 then
            self.数据[道具id].原始数据={
            名称=self.数据[道具id].名称,
            角色限制=self.数据[道具id].角色限制,
            分类=self.数据[道具id].分类,
            子类=self.数据[道具id].子类,}
        end
        local 临时名称 =斧头名称[math.floor(self.数据[道具id].级别限制/10)+1]
        if  事件 == "武器转换铸斧(乾)" then
              self.数据[道具id].名称=临时名称.."(乾)"
              self.数据[道具id].子类=26
              self.数据[道具id].角色限制={"影精灵"}

        elseif 事件 == "武器转换铸斧(坤)" then
              self.数据[道具id].名称=临时名称.."(坤)"
              self.数据[道具id].分类=4
              self.数据[道具id].子类=1
              self.数据[道具id].性别限制="女"
              self.数据[道具id].角色限制={"影精灵"}
              if self.数据[道具id].装备境界 and self.数据[道具id].装备境界.词条 then
                 if self.数据[道具id].装备境界.词条[1] then
                    local 临时词条 = self.数据[道具id].装备境界.词条[1].类型
                    local 临时数额 = self.数据[道具id].装备境界.词条[1].数额
                     self:给予道具(id,"鸿蒙原石",1,{类型=临时词条,数额=临时数额})
                     self.数据[道具id].装备境界.词条[1]=nil
                     常规提示(id,"#Y/你获得了#R"..临时词条.."#Y词条数额为#G"..临时数额.."#Y的#R鸿蒙原石#Y1个")
                 end
                 if self.数据[道具id].装备境界.词条[2] then
                     local 临时词条 = self.数据[道具id].装备境界.词条[2].类型
                    local 临时数额 = self.数据[道具id].装备境界.词条[2].数额*2
                     self:给予道具(id,"鸿蒙原石",1,{类型=临时词条,数额=临时数额})
                     self.数据[道具id].装备境界.词条[2]=nil
                     常规提示(id,"#Y/你获得了#R"..临时词条.."#Y词条数额为#G"..临时数额.."#Y的#R鸿蒙原石#Y1个")
                 end
                 if self.数据[道具id].装备境界.词条[3] then
                    local 临时词条 = self.数据[道具id].装备境界.词条[3].类型
                    local 临时数额 = self.数据[道具id].装备境界.词条[3].数额*2
                     self:给予道具(id,"鸿蒙原石",1,{类型=临时词条,数额=临时数额})
                     self.数据[道具id].装备境界.词条[3]=nil
                     常规提示(id,"#Y/你获得了#R"..临时词条.."#Y词条数额为#G"..临时数额.."#Y的#R鸿蒙原石#Y1个")
                 end
                 self.数据[道具id].装备境界.词条共鸣=false
              end


        end
        添加最后对话(id,"你将武器#R"..self.数据[道具id].原始数据.名称.."#W转换成了#R"..self.数据[道具id].名称)
        道具刷新(id)

   elseif 事件=="上交熊胆" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称="熊胆"
     if self.数据[道具id] == nil then
      常规提示(id,"#Y/请检查你给予的物品是否存在")
      道具刷新(id)
      return
    end
    if self.数据[道具id].名称~=名称 then
      添加最后对话(id,"我需要的是#G/熊胆#W/，你给我的这个能当饭吃吗？#4")
      return
    end
   self.数据[道具id]=nil
   玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
   xsjc1(id,5)
   玩家数据[id].道具:给予道具(id,"烤鸭",1,nil,nil,"专用")
   常规提示(id,"#Y/你获得一只#G烤鸭")
   道具刷新(id)

    elseif 事件=="上交餐风饮露" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称="餐风饮露"
     if self.数据[道具id] == nil then
      常规提示(id,"#Y/请检查你给予的物品是否存在")
      道具刷新(id)
      return
    end
    if self.数据[道具id].名称~=名称 then
      添加最后对话(id,"我需要的是#G/餐风饮露#W/，你给我的这个能当饭吃吗？#4")
      return
    end
   self.数据[道具id]=nil
   玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
   xsjc2(id,12)
   玩家数据[id].道具:给予道具(id,"定神香",1,nil,nil,"专用")
   常规提示(id,"#Y/你获得一只#G定神香")
   道具刷新(id)

    elseif 事件=="上交特别的美味" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称="臭豆腐"
      if self.数据[道具id] == nil then
        常规提示(id,"#Y/请检查你给予的物品是否存在")
        道具刷新(id)
        return
      end
    if self.数据[道具id].名称~=名称 then
      添加最后对话(id,"我需要的是#G/特别的美味#W/，你给我的这个能当饭吃吗？#4")
      return
    end
   self.数据[道具id]=nil
   玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
   xsjc2(id,32)
   玩家数据[id].道具:给予道具(id,"避水珠",1,nil,nil,"专用")
   常规提示(id,"#Y/你获得一只#G避水珠")
   添加最后对话(id,"谢谢你,#G臭豆腐#真是美味至极啊!")
   道具刷新(id)

    elseif 事件=="上交佛光舍利子" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称="佛光舍利子"
     if self.数据[道具id] == nil then
        常规提示(id,"#Y/请检查你给予的物品是否存在")
        道具刷新(id)
        return
      end
    if self.数据[道具id].名称~=名称 then
      添加最后对话(id,"我需要的是#G/佛光舍利子#W/，你给我的这个能当饭吃吗？#4")
      return
    end
   self.数据[道具id]=nil
   玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
   xsjc2(id,16)
   添加最后对话(id,"玄奘法师是我从河里#G捡回来的孩子\n并非外面的八卦消息所传,他根本就#Y不可能是我的野种\n虽然我年轻的时候也#P风流倜傥#,#S玉树临风#,但那都是多少年前的事情了\n我看这孩子慧根深厚,与佛有缘,才把他#Y带回寺院的\n这里有他出生时留下的#R血书#,你拿给他看吧")
   道具刷新(id)

    elseif 事件=="上交吃的" then
      local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
      local 名称="烤鸭"
       if self.数据[道具id] == nil then
        常规提示(id,"#Y/请检查你给予的物品是否存在")
        道具刷新(id)
        return
      end
    if self.数据[道具id].名称~=名称 then
      添加最后对话(id,"我需要的是#G/有肉的东西#W/，你给我的这个能当饭吃吗？#4")
      return
    end
   self.数据[道具id]=nil
   玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
   xsjc2(id,37)
   添加最后对话(id,"谢谢你年轻人,我这就和你一起去见我媳妇\n真的有好多年都没见了,我以为他们都死了#15")
   道具刷新(id)

   elseif 事件=="上交火凤之睛" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称="火凤之睛"
      if self.数据[道具id] == nil then
        常规提示(id,"#Y/请检查你给予的物品是否存在")
        道具刷新(id)
        return
      end
    if self.数据[道具id].名称~=名称 then
      添加最后对话(id,"我要的不是这个!")
      return
    end
   self.数据[道具id]=nil
   玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
  if 玩家数据[id].角色:取任务(996) ~= 0 and 任务数据[玩家数据[id].角色:取任务(996)].进程 == 7 then
  任务数据[玩家数据[id].角色:取任务(996)].进程=8
  玩家数据[id].角色:刷新任务跟踪()
  end
   添加最后对话(id,"很好,现在你拿着仙露,回去找清风吧!")
   道具刷新(id)

    elseif 事件=="上交九转回魂丹" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称="九转回魂丹"
     if self.数据[道具id] == nil then
      常规提示(id,"#Y/请检查你给予的物品是否存在")
      道具刷新(id)
      return
    end
    if self.数据[道具id].名称~=名称 then
      添加最后对话(id,"我需要的是#G/九转回魂丹#W/，你给我的这个能当饭吃吗？#4")
      return
    end
   self.数据[道具id]=nil
   玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
   xsjc2(id,25)
   添加最后对话(id,"玄奘法师清醒了过来\n看着#R血书#的内容:\n(此儿讳陈光蕊,官除江洲令,妾名#Y殷温娇#,亦为相门女\n贼子#G刘洪杀夫霸妾#,冒官江州,妾恐贼加害此遗腹子\n忍痛弃之江中,若蒙善人#S拾养#,妾必感深嗯,街环以报)\n原来我身世中藏此#R深仇大恨#,#S父母之仇,不能报复#,玄奘又何以为人?\n我要拿起#Y屠刀#,还俗报仇!#4")
   道具刷新(id)

    elseif 事件=="上交定神香" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称="定神香"
     if self.数据[道具id] == nil then
        常规提示(id,"#Y/请检查你给予的物品是否存在")
        道具刷新(id)
        return
      end
    if self.数据[道具id].名称~=名称 then
      添加最后对话(id,"我需要的是#G/定神香#W/，你给我的这个能当饭吃吗？#4")
      return
    end
   self.数据[道具id]=nil
   玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
   xsjc2(id,13)
   添加最后对话(id,"少侠可还记得打伤我的#Y白琉璃?\n她盗取了化生寺的#G佛光舍利子\n还请少侠继续帮帮忙,去调查一下#S它的来历\n和它交手时,发现它并非妖物,而是有#Y通灵仙气#的东西\n你可以去#R天宫#打探一下")
   道具刷新(id)

    elseif 事件=="上交百色花" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称="百色花"
     if self.数据[道具id] == nil then
        常规提示(id,"#Y/请检查你给予的物品是否存在")
        道具刷新(id)
        return
     end
    if self.数据[道具id].名称~=名称 then
      添加最后对话(id,"我需要的是#G/百色花#W/，你给我的这个能当饭吃吗？#4")
      return
    end
   self.数据[道具id]=nil
   玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
   xsjc2(id,5)
   local 名称=self:给予书铁(id,{3,4})
   常规提示(id,"#Y你获得了#R"..名称[1])
   道具刷新(id)

    elseif 事件=="上交烤鸭" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称="烤鸭"
      if self.数据[道具id] == nil then
        常规提示(id,"#Y/请检查你给予的物品是否存在")
        道具刷新(id)
        return
      end
    if self.数据[道具id].名称~=名称 then
      添加最后对话(id,"我需要的是#G/烤鸭#W/，你给我的这个能当饭吃吗？#4")
      return
    end
   self.数据[道具id]=nil
   玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
   xsjc1(id,6)
   添加最后对话(id,"法事我会筹办的,你无需担心了\n你现在把我的#G安魂草#交给#Y老孙头\n让他安定心神不在被鬼魂骚扰")
   常规提示(id,"#Y/你获得一捆#G安魂草")
   道具刷新(id)
    elseif 事件=="上交地狱灵芝" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称="地狱灵芝"
      if self.数据[道具id] == nil then
        常规提示(id,"#Y/请检查你给予的物品是否存在")
        道具刷新(id)
        return
      end
    if self.数据[道具id].名称~=名称 then
      添加最后对话(id,"我需要的是#G/地狱灵芝#W/，你给我的这个能当饭吃吗？#4")
      return
    end
   self.数据[道具id]=nil
   玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
   xsjc1(id,11)
   任务处理类:设置新手指引任务(id)
   添加最后对话(id,"谢谢你治好了我的病,事情的#S来龙去脉#是这样的:\n多年前我和一个朋友遇到海啸,#Y我和他双双落入海里\n就在#R危难之际#我们的身边出现一块#G木板#,但这块木板#P只能够一个人浮起来\n我的那位朋友#C为了让我活下#来就把木板让给了我,最终我活了下来,#S我的朋友却死了\n不知为何他死后#Y化作厉鬼在海底沉船#兴风作浪\n要了不少无辜人的性命,我每年都会让#G道士去超度他\n可是都没用,他的#Z怨气太重了#,少侠既然可以搞到地狱灵芝,想必也有#G超凡本事\n今年的超度就麻烦少侠你了\n不管成功与否,到时候都可以到我这里#Y领取酬劳")
   道具刷新(id)
    elseif 事件=="上交枯萎的金莲" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称="枯萎的金莲"
      if self.数据[道具id].名称~=名称 then
        添加最后对话(id,"我需要的是#G/枯萎的金莲#W/，你给我的这个能当饭吃吗？#4")
        return
      end
     self.数据[道具id]=nil
     玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
     任务数据[玩家数据[id].角色:取任务(400)].进程=12
     道具刷新(id)
    玩家数据[id].角色:刷新任务跟踪()
    发送数据(玩家数据[id].连接id,3533.2)
    elseif 事件=="真是他妈太臭了" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称="丁香水"
    if self.数据[道具id].名称~=名称 then
      添加最后对话(id,"看来这个宝箱不需要这件物品#4")
      return
    end
   self.数据[道具id]=nil
   玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
   任务处理类:设置妖风支线(id)
   道具刷新(id)
     elseif 事件=="上交雪人物品" then
    local 任务id = 玩家数据[id].角色:取任务(7760)
    if 任务id == 0 then
      常规提示(id,"#Y/你好像没有这样的任务！")
      return
    elseif 任务数据[任务id].分类 ~= 2 then
      常规提示(id,"#Y/你的任务好像不是这类！")
      return
    else
      local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
        if self.数据[道具id] == nil then
          常规提示(id,"#Y/请检查你给予的物品是否存在")
          道具刷新(id)
          return
        end
      local 名称=self.数据[道具id].名称
      local 任务物品 =任务数据[任务id].物品
      if 名称 ~= 任务物品 then
        常规提示(id,"#Y/我要的不是这个物品哟！")
        return
      end
      if self.数据[道具id].数量 ~= nil then
        self.数据[道具id].数量 = self.数据[道具id].数量 - 1
      end
      if self.数据[道具id].数量 == nil or self.数据[道具id].数量 <= 0 then
        self.数据[道具id] = nil
        玩家数据[id].角色.数据.道具[数据.格子[1]] = nil
      end
      任务处理类:完成雪人任务(id)
    end
  elseif 事件=="上交雪人道具" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
       if self.数据[道具id] == nil then
        常规提示(id,"#Y/请检查你给予的物品是否存在")
        道具刷新(id)
        return
      end
    local 名称=self.数据[道具id].名称
    if 名称 ~= "雪人鼻子" and 名称 ~= "雪人帽子" and 名称 ~= "雪人眼睛" then
      常规提示(id,"#Y/你交给我的是神马东西！")
      return
    elseif 雪人活动[名称] >= 雪人活动.上限 then
      常规提示(id,"#Y/本轮活动该道具已经满了,等待下一轮再前来吧！")
      return
    else
      local 应扣数量 = 雪人活动.上限- 雪人活动[名称]
      if self.数据[道具id].数量 < 应扣数量 then
        应扣数量 = self.数据[道具id].数量
      end
      local 经验 = 10000*应扣数量
      local 银子 = 5000*应扣数量
      self.数据[道具id].数量 = self.数据[道具id].数量 - 应扣数量
      雪人活动[名称]=雪人活动[名称]+应扣数量
      if 玩家数据[id].角色.数据.春节雪人 == nil then
        玩家数据[id].角色.数据.春节雪人 = 应扣数量
      else
        玩家数据[id].角色.数据.春节雪人 = 玩家数据[id].角色.数据.春节雪人 + 应扣数量
      end
      玩家数据[id].角色:添加储备(银子,"雪人上交"..应扣数量,1)
      玩家数据[id].角色:添加经验(经验,"雪人上交"..应扣数量,1)
      常规提示(id,"#Y/你获得了"..应扣数量.."点雪人积分！")
      if self.数据[道具id].数量 <= 0 then
        self.数据[道具id] = nil
        玩家数据[id].角色.数据.道具[数据.格子[1]] = nil
      end
      道具刷新(id)
      for i,v in pairs(雪人活动) do
        if i~="上限" then
          if v < 雪人活动.上限 then
            return
          end
        end
      end
      for i,v in pairs(玩家数据) do
        if 玩家数据[i] ~= nil and 玩家数据[i].管理 == nil then
          玩家数据[i].道具:发放雪人奖励(i)
        end
      end
      for i,v in pairs(雪人活动) do
        if i~="上限" then
          雪人活动[i]=0
        end
      end
    end
  elseif 事件=="上交心魔宝珠" then
    if 玩家数据[id].角色.数据.等级>=175 then
      常规提示(id,"#Y/你已经脱离了新手阶段，无法获得此种奖励")
      return
    elseif 玩家数据[id].角色.数据.等级<1 then
      常规提示(id,"#Y/只有等级达到1级的玩家才可获得此种奖励")
      return
    elseif 心魔宝珠[id]~=nil and 心魔宝珠[id]>=20 then
      常规提示(id,"#Y/请明天再来上交心魔宝珠")
      return
    end
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
      if self.数据[道具id] == nil then
        常规提示(id,"#Y/请检查你给予的物品是否存在")
        道具刷新(id)
        return
      end
    local 名称="心魔宝珠"
    local 数量=50
    if self.数据[道具id].名称~=名称 then
      常规提示(id,"#Y/对方需要的不是这种物品")
      return
    end
    if 数量>1 and self.数据[道具id].数量<数量 then
      常规提示(id,"#Y/该物品的数量至少要50个才能一交")
      return
    end
    if 数量>1 then
      self.数据[道具id].数量=self.数据[道具id].数量-数量
    end
    if self.数据[道具id].数量==nil or self.数据[道具id].数量<=0 then
      self.数据[道具id]=nil
      玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
    end
    local 等级=取等级(id)
    local 经验=等级*150*4
    local 储备=等级*50*4
    玩家数据[id].角色:添加经验(经验,"心魔宝珠奖励")
    玩家数据[id].角色:添加银子(储备,"心魔宝珠奖励",1)
    local 名称=取宝石()
    玩家数据[id].道具:给予道具(id,名称,取随机数(3,5))
    常规提示(id,"#Y/你获得了"..名称)
    if 取随机数(1,100)<=30 then
    玩家数据[id].道具:给予书铁(id,{8,11},"精铁")
    常规提示(id,"#Y/你获得了#G80-110级#精铁奖励")
    广播消息({内容=format("#S(心魔宝珠)#R/%s#Y完成上交心魔宝珠运气包爆棚，#Y因此获得了#G80-110级精铁",玩家数据[id].角色.数据.名称),频道="xt"})
    end
    if 玩家数据[id].角色:取任务(402)~=0 and 任务数据[玩家数据[id].角色:取任务(402)].进程 == 4 then
    任务数据[玩家数据[id].角色:取任务(402)].进程=5
    玩家数据[id].角色:刷新任务跟踪()
    end
    if 心魔宝珠[id]==nil then
      心魔宝珠[id]=1
    else
      心魔宝珠[id]=心魔宝珠[id]+1
    end
    常规提示(id,format("#Y/你本日还可领取#R/%s#Y/次奖励",(20-心魔宝珠[id])))
    道具刷新(id)
 elseif 事件=="官职任务上交物品" then
    local 任务id=玩家数据[id].角色:取任务(110)
    if 任务id==0 or 任务数据[任务id]==nil then
      常规提示(id,"#Y/你没有这样的任务")
      return
    end
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称="？？？"
    if 任务数据[任务id].分类==3 then
      名称="情报"
    elseif 任务数据[任务id].分类==4 then
      名称=任务数据[任务id].物品
    end
     if self.数据[道具id] == nil then
        常规提示(id,"#Y/请检查你给予的物品是否存在")
        道具刷新(id)
        return
      end
    if self.数据[道具id].名称~=名称 then
      常规提示(id,"#Y/对方需要的不是这种物品")
      return
    end
    self.数据[道具id]=nil
    玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
    任务处理类:完成官职任务(id,任务数据[任务id].分类)
    道具刷新(id)
   elseif 事件=="节日活动上交物品" then
    local 任务id=玩家数据[id].角色:取任务(411)
    if 任务id==0 or 任务数据[任务id]==nil then
      常规提示(id,"#Y/你没有这样的任务")
      return
    end
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称="？？？"
    if 任务数据[任务id].分类==3 then
      名称="情报"
    elseif 任务数据[任务id].分类==4 then
      名称=任务数据[任务id].药品
    end
      if self.数据[道具id] == nil then
        常规提示(id,"#Y/请检查你给予的物品是否存在")
        道具刷新(id)
        return
      end
    if self.数据[道具id].名称~=名称 then
      常规提示(id,"#Y/对方需要的不是这种物品")
      return
    end
    if self.数据[道具id]~=nil and self.数据[道具id].数量~=nil and self.数据[道具id].数量 >1 then
      self.数据[道具id].数量 = self.数据[道具id].数量 - 1
      任务处理类:完成节日活动(id,任务数据[任务id].分类)
      道具刷新(id)
   else
    self.数据[道具id]=nil
    玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
    任务处理类:完成节日活动(id,任务数据[任务id].分类)
    道具刷新(id)
    end

  elseif 事件=="门派任务上交物品" then
    local 任务id=玩家数据[id].角色:取任务(111)
    if 任务id==0 or 任务数据[任务id]==nil then
      常规提示(id,"#Y/你没有这样的任务")
      return
    end
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称=任务数据[任务id].物品
       if self.数据[道具id] == nil then
          常规提示(id,"#Y/请检查你给予的物品是否存在")
          道具刷新(id)
          return
        end
    if self.数据[道具id].名称~=名称 then
      常规提示(id,"#Y/对方需要的不是这种物品")
      return
    end
    local 双倍
    if 任务数据[任务id].品质~=nil and self.数据[道具id].阶品>=任务数据[任务id].品质 then
      双倍=1
    end
    self.数据[道具id]=nil
    玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
    任务处理类:完成门派任务(id,4,双倍)
    道具刷新(id)

elseif 事件=="文韵任务上交物品" then---------远方文韵墨香
    local 任务id=玩家数据[id].角色:取任务(112)
    if 任务id==0 or 任务数据[任务id]==nil then
      常规提示(id,"#Y/你没有这样的任务")
      return
    end
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称=任务数据[任务id].物品

    if self.数据[道具id].名称~=名称 then
      常规提示(id,"#Y/对方需要的不是这种物品")
      return
    end
    local 双倍
    if 任务数据[任务id].品质~=nil and self.数据[道具id].阶品>=任务数据[任务id].品质 then
      双倍=1
    end
    self.数据[道具id]=nil
    玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
    任务处理类:完成文韵任务(id,4,双倍)
    道具刷新(id)

  elseif 事件=="青龙任务给予药品" then
    local 任务id=玩家数据[id].角色:取任务(301)
    if 任务id==0 or 任务数据[任务id]==nil then
      常规提示(id,"#Y/你没有这样的任务")
      return
    end
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称=任务数据[任务id].药品
    if self.数据[道具id] == nil then
        常规提示(id,"#Y/请检查你给予的物品是否存在")
        道具刷新(id)
        return
    end
    if self.数据[道具id].名称~=名称 then
      常规提示(id,"#Y/对方需要的不是这种物品")
      return
    end
    if self.数据[道具id]~=nil and self.数据[道具id].数量~=nil and self.数据[道具id].数量 >1 then
      self.数据[道具id].数量 = self.数据[道具id].数量 - 1
      任务处理类:完成青龙任务(任务id,id,2)
      道具刷新(id)
    else
      self.数据[道具id]=nil
      玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
      任务处理类:完成青龙任务(任务id,id,2)
      道具刷新(id)
    end
  elseif 事件=="青龙任务给予烹饪" then
    local 任务id=玩家数据[id].角色:取任务(301)
    if 任务id==0 or 任务数据[任务id]==nil then
      常规提示(id,"#Y/你没有这样的任务")
      return
    end
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称=任务数据[任务id].烹饪
     if self.数据[道具id] == nil then
        常规提示(id,"#Y/请检查你给予的物品是否存在")
        道具刷新(id)
        return
      end
    if self.数据[道具id].名称~=名称 then
      常规提示(id,"#Y/对方需要的不是这种物品")
      return
    end
    if self.数据[道具id]~=nil and self.数据[道具id].数量~=nil and self.数据[道具id].数量 >1 then
      self.数据[道具id].数量 = self.数据[道具id].数量 - 1
      任务处理类:完成青龙任务(任务id,id,3)
      道具刷新(id)
    else
      self.数据[道具id]=nil
      玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
      任务处理类:完成青龙任务(任务id,id,3)
      道具刷新(id)
    end
  elseif 事件=="玄武任务给予药品" then
    local 任务id=玩家数据[id].角色:取任务(302)
    if 任务id==0 or 任务数据[任务id]==nil then
      常规提示(id,"#Y/你没有这样的任务")
      return
    end
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称=任务数据[任务id].药品
    if 道具id==nil or self.数据[道具id]==nil or self.数据[道具id].名称==nil or self.数据[道具id].名称~=名称 then
      常规提示(id,"#Y/对方需要的不是这种物品")
      return
    end
    local id组 = 取id组(id)
    if self.数据[道具id]~=nil and self.数据[道具id].数量~=nil and self.数据[道具id].数量 >1 then
      self.数据[道具id].数量 = self.数据[道具id].数量 - 1
      任务处理类:完成玄武任务(任务id,id组,2)
      道具刷新(id)
    else
      self.数据[道具id]=nil
      玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
      任务处理类:完成玄武任务(任务id,id组,2)
      道具刷新(id)
    end
  elseif 事件=="玄武任务给予烹饪" then
    local 任务id=玩家数据[id].角色:取任务(302)
    if 任务id==0 or 任务数据[任务id]==nil then
      常规提示(id,"#Y/你没有这样的任务")
      return
    end
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称=任务数据[任务id].烹饪
    if 道具id==nil or self.数据[道具id]==nil or self.数据[道具id].名称~=名称 then
      常规提示(id,"#Y/对方需要的不是这种物品")
      return
    end
    local id组 = 取id组(id)
    if self.数据[道具id]~=nil and self.数据[道具id].数量~=nil and self.数据[道具id].数量 >1 then
      self.数据[道具id].数量 = self.数据[道具id].数量 - 1
      任务处理类:完成玄武任务(任务id,id组,3)
      道具刷新(id)
    else
      self.数据[道具id]=nil
      玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
      任务处理类:完成玄武任务(任务id,id组,3)
      道具刷新(id)
    end
  elseif 事件=="坐骑任务给予烹饪" then
    local 任务id=玩家数据[id].角色:取任务(307)
    if 任务id==0 or 任务数据[任务id]==nil then
      常规提示(id,"#Y/你没有这样的任务")
      return
    end
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称=任务数据[任务id].烹饪
    if 道具id==nil or self.数据[道具id]==nil or  self.数据[道具id].名称~=名称 then
      常规提示(id,"#Y/对方需要的不是这种物品")
      return
    end
    if self.数据[道具id]~=nil and self.数据[道具id].数量~=nil and self.数据[道具id].数量 >1 then
        self.数据[道具id].数量 = self.数据[道具id].数量 - 1
        任务数据[任务id].分类=3
        发送数据(玩家数据[id].连接id,1501,{名称="太白金星",模型="太白金星",对话=format("天宫的千里眼能眼观天下，他也许知道天马的消息！"),选项={"我这就去"}})
        道具刷新(id)
        玩家数据[id].角色:刷新任务跟踪()
    else
        self.数据[道具id]=nil
        玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
        任务数据[任务id].分类=3
        发送数据(玩家数据[id].连接id,1501,{名称="太白金星",模型="太白金星",对话=format("天宫的千里眼能眼观天下，他也许知道天马的消息！"),选项={"我这就去"}})
        道具刷新(id)
        玩家数据[id].角色:刷新任务跟踪()
    end
  elseif 事件=="坐骑任务给予药品" then
    local 任务id=玩家数据[id].角色:取任务(307)
    if 任务id==0 or 任务数据[任务id]==nil then
      常规提示(id,"#Y/你没有这样的任务")
      return
    end
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称=任务数据[任务id].药品
    if 道具id==nil or self.数据[道具id]==nil or self.数据[道具id].名称~=名称 then
      常规提示(id,"#Y/对方需要的不是这种物品")
      return
    end
    if self.数据[道具id]~=nil and self.数据[道具id].数量~=nil and self.数据[道具id].数量 >1 then
        self.数据[道具id].数量 = self.数据[道具id].数量 - 1
        任务数据[任务id].分类=12
        发送数据(玩家数据[id].连接id,1501,{名称="大大王",模型="大大王",对话=format("听说马儿跑了到建业一带，少侠可以去那里找找"),选项={"我这就去建业看看"}})
        道具刷新(id)
        玩家数据[id].角色:刷新任务跟踪()
    else
        self.数据[道具id]=nil
        玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
        任务数据[任务id].分类=12
        发送数据(玩家数据[id].连接id,1501,{名称="大大王",模型="大大王",对话=format("听说马儿跑了到建业一带，少侠可以去那里找找"),选项={"我这就去建业看看"}})
        道具刷新(id)
        玩家数据[id].角色:刷新任务跟踪()
    end


  elseif 事件=="法宝任务给予药品" then
    local 任务id=玩家数据[id].角色:取任务(308)
    if 任务id==0 or 任务数据[任务id]==nil then
      常规提示(id,"#Y/你没有这样的任务")
      return
    end
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称=任务数据[任务id].物品
    if 道具id==nil or self.数据[道具id]==nil or self.数据[道具id].名称~=名称 then
      常规提示(id,"#Y/对方需要的不是这种物品")
      return
    end
    if self.数据[道具id]~=nil and self.数据[道具id].数量~=nil and self.数据[道具id].数量 >1 then
        self.数据[道具id].数量 = self.数据[道具id].数量 - 1
    else
        self.数据[道具id]=nil
        玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
    end
    if 玩家数据[id].角色.法宝进程==1 then
        发送数据(玩家数据[id].连接id,1501,{名称="金童子",模型="男人_道童",对话=format("少侠已经集齐法宝合成的材料了，可以来天宫找我领取内丹任务进行法宝合成哦")})
    end
    任务处理类:完成法宝任务(任务id,id,2)
    道具刷新(id)
  elseif 事件=="法宝任务给予烹饪" then
    local 任务id=玩家数据[id].角色:取任务(308)
    if 任务id==0 or 任务数据[任务id]==nil then
      常规提示(id,"#Y/你没有这样的任务")
      return
    end
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称=任务数据[任务id].物品
    if 道具id==nil or self.数据[道具id]==nil or self.数据[道具id].名称~=名称 then
      常规提示(id,"#Y/对方需要的不是这种物品")
      return
    end
    if self.数据[道具id]~=nil and self.数据[道具id].数量~=nil and self.数据[道具id].数量 >1 then
        self.数据[道具id].数量 = self.数据[道具id].数量 - 1
    else
        self.数据[道具id]=nil
        玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
    end
    if 玩家数据[id].角色.法宝进程==1 then
        发送数据(玩家数据[id].连接id,1501,{名称="金童子",模型="男人_道童",对话=format("少侠已经集齐法宝合成的材料了，可以来天宫找我领取内丹任务进行法宝合成哦")})
    end
    任务处理类:完成法宝任务(任务id,id,3)
    道具刷新(id)


  elseif 事件=="门派任务上交乾坤袋" then
    local 任务id=玩家数据[id].角色:取任务(111)
    --print(任务id,任务数据[任务id])
    if 任务id==0 or 任务数据[任务id]==nil then
      常规提示(id,"#Y/你没有这样的任务")
      return
    end
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称="乾坤袋"
    if 道具id==nil or self.数据[道具id]==nil or  self.数据[道具id].名称~=名称 then
      常规提示(id,"#Y/对方需要的不是这种物品")
      return
    elseif 任务数据[任务id].乾坤袋==nil then
      常规提示(id,"#Y/你似乎还没有完成这个任务哟~")
      return
    end
    self.数据[道具id]=nil
    玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
    任务处理类:完成门派任务(id,7,双倍)
    道具刷新(id)
elseif 事件=="文韵任务上交乾坤袋" then---------远方文韵墨香
    local 任务id=玩家数据[id].角色:取任务(112)
    --print(任务id,任务数据[任务id])
    if 任务id==0 or 任务数据[任务id]==nil then
      常规提示(id,"#Y/你没有这样的任务")
      return
    end
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称="乾坤袋"
    if self.数据[道具id].名称~=名称 then
      常规提示(id,"#Y/对方需要的不是这种物品")
      return
    elseif 任务数据[任务id].乾坤袋==nil then
      常规提示(id,"#Y/你似乎还没有完成这个任务哟~")
      return
    end
    self.数据[道具id]=nil
    玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
    任务处理类:完成文韵任务(id,7,双倍)
    道具刷新(id)
  elseif 事件=="进阶变身卡" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    local 名称="怪物卡片"

    if 道具id==nil or self.数据[道具id]==nil or  self.数据[道具id].名称~=名称 then
      添加最后对话(id,"我需要的是怪物卡片，你给我的这个能当饭吃吗？")
      return
     end
    if string.find(self.数据[道具id].造型,"进阶")~= nil then
      添加最后对话(id,"已经是进阶卡了,你还兑换个毛线啊！")
      return
    elseif self.数据[道具id].等级<=4 then
      添加最后对话(id,"变身卡等级低于5级没有进阶造型！")
      return
    elseif 玩家数据[id].角色.数据.银子<500000 then
      添加最后对话(id,format("本次点化需要消耗#Y%s#W两银子，你似乎手头有点紧哟？",500000))
      return
    elseif 变身卡数据["进阶"..self.数据[道具id].造型]==nil then
      添加最后对话(id,"没有该卡片的进阶数据")
      return
    end
    玩家数据[id].道具:给予道具(id,"怪物卡片",变身卡数据["进阶"..self.数据[道具id].造型].等级,"进阶"..self.数据[道具id].造型)
    常规提示(id,"#Y你获得了#R进阶变身卡")
    玩家数据[id].角色:扣除银子(500000,"进阶变身卡",1)
    self.数据[道具id]=nil
    玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
    道具刷新(id)




  elseif 事件=="点化装备" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    if 道具id==nil or self.数据[道具id]==nil or  self.数据[道具id].总类~=2 or self.数据[道具id].灵饰 or self.数据[道具id].分类==9 then
      添加最后对话(id,"我这里目前只能点化人物装备，其它的我可没那么大的能耐。")
      return
    end
    local 银子=self.数据[道具id].级别限制*5000
    if 玩家数据[id].角色.数据.银子<银子 then
      添加最后对话(id,format("本次点化需要消耗#Y%s#W两银子，你似乎手头有点紧哟？",银子))
      return
    end
    玩家数据[id].角色:扣除银子(银子,"点化装备",1)
    local 套装类型={"附加状态","追加法术"}
    套装类型=套装类型[取随机数(1,#套装类型)]
    local 套装效果={
    附加状态={
      "金刚护法","金刚护体","生命之泉","炼气化神","普渡众生","定心术","碎星诀","变身","凝神术","逆鳞","不动如山","法术防御","明光宝烛","天神护体","移魂化骨","蜜润","杀气诀","韦陀护法","一苇渡江","天神护法","乘风破浪","魔息术","盘丝阵","炎护"}
      ,追加法术={"横扫千军","善恶有报","惊心一剑","壁垒击破","满天花雨","浪涌","唧唧歪歪","五雷咒",
      "龙卷雨击","剑荡四方","裂石","烟雨剑法","天雷斩","力劈华山","夜舞倾城","上古灵符","叱咤风云","天降灵葫",
      "月光","八凶法阵","死亡召唤","天罗地网","夺命咒","落叶萧萧","落雷符","雨落寒沙","苍茫树","飞砂走石",
      "阎罗令","水攻","烈火","落岩","雷击","泰山压顶","水漫金山","地狱烈火","奔雷咒"} --
    }
    self.数据[道具id].套装效果={套装类型,套装效果[套装类型][取随机数(1,#套装效果[套装类型])]}
    玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(14))
    玩家数据[id].角色:刷新任务跟踪()
    添加最后对话(id,format("点化装备成功,您本次点化后的套装效果为#Y%s：%s",self.数据[道具id].套装效果[1],self.数据[道具id].套装效果[2]),{"继续点化","告辞"})



  elseif 事件=="合成旗4" then --补充
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    if 道具id==nil or self.数据[道具id]==nil or self.数据[道具id].总类~=11 or  self.数据[道具id].分类~=2 then
      常规提示(id,"#Y我只可以为合成旗补充次数哟。")
      return
    end
    if self.数据[道具id].次数>=140 then
      常规提示(id,"#Y你的这个合成旗次数已经满了")
      return
    end
    local 编号=玩家数据[id].法宝id
    if 玩家数据[id].角色.数据.法宝[编号]==nil or self.数据[玩家数据[id].角色.数据.法宝[编号]]==nil or self.数据[玩家数据[id].角色.数据.法宝[编号]].名称~="五色旗盒" then
      常规提示(id,"#Y你没有这样的法宝")
      return
    end
    local 灵气=140-self.数据[道具id].次数
    灵气=math.floor(灵气/5)
    if 灵气<1 then 灵气=1 end
    if 灵气>self.数据[玩家数据[id].角色.数据.法宝[编号]].魔法 then
      常规提示(id,"#Y本次补充需要消耗#R"..灵气.."#Y点法宝灵气，你的法宝没有那么多的灵气")
      return
    end
    self.数据[玩家数据[id].角色.数据.法宝[编号]].魔法=self.数据[玩家数据[id].角色.数据.法宝[编号]].魔法-灵气
    self.数据[道具id].次数=140
    发送数据(连接id,38,{内容="你的法宝#R/五色旗盒#W/灵气减少了"..灵气.."点"})
    常规提示(id,"#Y补充成功！你的这个合成旗可使用次数已经恢复到140次了")
    道具刷新(id)
  elseif 事件=="合成旗" then
    -- table.print(数据.格子)
    local 道具id={}
    for n=1,#数据.格子 do
      if 数据.格子[n]~=nil  then
        道具id[n]=数据.格子[n]
        local 临时id=玩家数据[id].角色.数据.道具[数据.格子[n]]
        if self.数据[临时id].总类~=11 and self.数据[临时id].分类~=1 then
          常规提示(id,"#Y只有导标旗才可以合成哟")
          return
        end
      end
    end
    if 玩家数据[id].合成旗序列==nil then
      玩家数据[id].合成旗序列={}
      for n=1,#道具id do
        local 临时id=玩家数据[id].角色.数据.道具[道具id[n]]
        for i=1,#道具id do
          local 临时id1=玩家数据[id].角色.数据.道具[道具id[i]]
          if i~=n and 临时id1==临时id then
            常规提示(id,"#Y合成的导标旗中存在重复导标旗")
            return
          elseif i~=n and self.数据[临时id].地图~=self.数据[临时id1].地图 then
            常规提示(id,"#Y合成的导标旗定标场景必须为同一个")
            return
          end
        end
      end
    else
      for n=1,#道具id do
        local 临时id=玩家数据[id].角色.数据.道具[道具id[n]]
        if 玩家数据[id].合成旗序列.地图~=nil and 玩家数据[id].合成旗序列.地图~=self.数据[临时id].地图 then
          常规提示(id,"#Y只有#R"..取地图名称(玩家数据[id].合成旗序列.地图).."#Y的导标旗才可合成")
          return
        end
        for i=1,#道具id do
          local 临时id1=玩家数据[id].角色.数据.道具[道具id[i]]
          if i~=n and 临时id1==临时id then
            常规提示(id,"#Y合成的导标旗中存在重复导标旗")
            return
          end
        end
        for i=1,#玩家数据[id].合成旗序列 do
          local 临时id1=玩家数据[id].角色.数据.道具[玩家数据[id].合成旗序列[i]]
          if  临时id1==临时id then
            常规提示(id,"#Y合成的导标旗中存在重复导标旗")
            return
          end
        end
      end
    end
    local 编号=玩家数据[id].法宝id
    if 玩家数据[id].角色.数据.法宝[编号]==nil or self.数据[玩家数据[id].角色.数据.法宝[编号]]==nil or self.数据[玩家数据[id].角色.数据.法宝[编号]].名称~="五色旗盒" then
      常规提示(id,"#Y你没有这样的法宝")
      return
    end
    local 上限=7
    if self.数据[玩家数据[id].角色.数据.法宝[编号]].气血<=0 then
      上限=3
    elseif self.数据[玩家数据[id].角色.数据.法宝[编号]].气血<=2 then
      上限=4
    elseif self.数据[玩家数据[id].角色.数据.法宝[编号]].气血<=5 then
      上限=5
    elseif self.数据[玩家数据[id].角色.数据.法宝[编号]].气血<=8 then
      上限=6
    elseif self.数据[玩家数据[id].角色.数据.法宝[编号]].气血<=9 then
      上限=7
    end
    for n=1,#道具id do
      if #玩家数据[id].合成旗序列<上限 then
        if 玩家数据[id].合成旗序列.地图==nil then
          玩家数据[id].合成旗序列.地图=self.数据[玩家数据[id].角色.数据.道具[道具id[n]]].地图
        end
        玩家数据[id].合成旗序列[#玩家数据[id].合成旗序列+1]=道具id[n]
      end
    end
    if #玩家数据[id].合成旗序列==上限 then
      local aa ="请选择超级合成旗的颜色："
      local xx={"绿色合成旗","蓝色合成旗","红色合成旗","白色合成旗","黄色合成旗",}
      发送数据(连接id,1501,{名称="五色旗盒",对话=aa,选项=xx})
      玩家数据[id].最后操作="合成旗3"
    else
      玩家数据[id].给予数据={类型=1,id=0,事件="合成旗"}
      发送数据(连接id,3507,{道具=玩家数据[id].道具:索要道具1(id),名称="五色旗盒",类型="法宝",等级="无"})
      玩家数据[id].最后操作="合成旗2"
      常规提示(id,format("#Y你已提交%s个导标旗，还需要提交%s个导标旗",#玩家数据[id].合成旗序列,上限-#玩家数据[id].合成旗序列))
    end
  elseif 事件=="装备出售" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    if self.数据[道具id] == nil then
      return
    end
    if self.数据[道具id].总类~=2 or self.数据[道具id].灵饰 or self.数据[道具id].分类==9 then
      添加最后对话(id,"我这里只收购人物装备哟，其它的破铜烂铁我可是不收滴哟。")
      return
    end
    玩家数据[id].出售装备=数据.格子[1]
    玩家数据[id].最后操作="出售装备"
    添加最后对话(id,format("你的这件#Y%s#W我将以#R%s#W两银子进行收购，请确认是否出售该装备？",self.数据[道具id].名称,self:取装备价格(道具id)),{"确认出售","我不卖了"})

  elseif 事件=="装备鉴定" then
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    if self.数据[道具id] == nil then
      return
    end
    if self.数据[道具id].总类~=2 or self.数据[道具id].灵饰 or self.数据[道具id].分类==9 then
      添加最后对话(id,"我这里只收购人物装备哟，其它的破铜烂铁我可是不收滴哟。")
      return
    end
    玩家数据[id].鉴定装备=数据.格子[1]
    玩家数据[id].最后操作="鉴定装备"
    添加最后对话(id,format("你的这件#Y%s#W我将以#R%s#W两银子进行鉴定，请确认是否鉴定该装备？",self.数据[道具id].名称,self:取装备价格(道具id)),{"确认鉴定","我不鉴定了"})
  elseif 事件=="法宝补充灵气" then
    local 道具id=玩家数据[id].角色.数据.法宝[数据.格子[1]]
    if self.数据[道具id].总类~=1000 then
      添加最后对话(id,"只有法宝才可以补充灵气哟，你这个是什么玩意？")
      return
    end
    local 价格=2000000
    if 玩家数据[id].角色.数据.银子<价格 then
      添加最后对话(id,"本次补充法宝灵气需要消耗"..价格.."两银子，你身上没有那么多的现金哟。")
      return
    end
    玩家数据[id].角色:扣除银子(价格,"补充法宝扣除，法宝名称为"..self.数据[道具id].名称,1)
    self.数据[道具id].魔法=取灵气上限(self.数据[道具id].分类)
    添加最后对话(id,"补充法宝灵气成功！")
  elseif 事件=="宠修物品" then
    local 任务id=玩家数据[id].角色:取任务(13)
    if 任务id==0 then
      添加最后对话(id,"你没有这个任务！")
      return
    end
    local 道具id=玩家数据[id].角色.数据.道具[数据.格子[1]]
    if 道具id==nil or self.数据[道具id]==nil or  self.数据[道具id].名称~=任务数据[任务id].物品  then
      添加最后对话(id,"我拿这个玩意用来干啥？")
      return
    end
    if self.数据[道具id].数量~=nil and self.数据[道具id].数量>0 then
      self.数据[道具id].数量=self.数据[道具id].数量-1
      if self.数据[道具id].数量<=0 then
        self.数据[道具id]=nil
        玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
      end
    else
      self.数据[道具id]=nil
      玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
    end
    道具刷新(id)
    任务处理类:完成宠修任务(id,任务id)
  elseif 事件=="枪矛" or 事件=="斧钺" or 事件=="剑" or 事件=="双短剑" or 事件=="飘带" or 事件=="爪刺" or 事件=="扇" or 事件=="魔棒" or 事件=="锤" or 事件=="鞭" or 事件=="环圈" or 事件=="刀" or 事件=="法杖" or 事件=="弓弩" or 事件=="宝珠" or 事件=="巨剑" or 事件=="伞" or 事件=="灯笼" or 事件=="头盔" or 事件=="发钗" or 事件=="女衣" or 事件=="男衣" then
    if not 数据.格子[1] or 数据.格子[1]==0 then return end
    local 道具id = 玩家数据[id].角色.数据.道具[数据.格子[1]]
    if not 道具id or not self.数据[道具id] or self.数据[道具id].总类~=2 then
        添加最后对话(id,"只有装备才能进行转换")
        return
    end
    if 玩家数据[id].账号==nil or id==nil then
        return
    end
    if 共享货币[玩家数据[id].账号].仙玉< 1000  then
       常规提示(id,"装备转换造型需要1000仙玉，少侠的仙玉不够哦！")
       return
    else
          local 子类=self:取武器类型(事件)
          local 等级=self.数据[道具id].级别限制
          玩家数据[id].角色:转换武器操作(id,self.数据[道具id],子类)
    end

  elseif 事件=="道观建设" then
    if not 数据.格子[1] or 数据.格子[1]==0 then return end
    local 道具id = 玩家数据[id].角色.数据.道具[数据.格子[1]]
    if not 道具id or not self.数据[道具id] or self.数据[道具id].总类~=21 then
      添加最后对话(id,"只能上交木材")
      return
    end
    local 任务id=玩家数据[id].角色:取任务(130)
    local 副本id=任务数据[任务id].副本id
    local 增加进度=self.数据[道具id].数量*1
    副本数据.车迟斗法.进行[副本id].车迟木材=副本数据.车迟斗法.进行[副本id].车迟木材+增加进度
    for n=1,#队伍数据[玩家数据[id].队伍].成员数据 do
        if 副本数据.车迟斗法.进行[副本id].车迟木材>= 5 then --
            地图处理类:当前消息广播1(6021,"#Y当前道观建设已满，速去找有个和尚")
            副本数据.车迟斗法.进行[副本id].进程=2
            玩家数据[队伍数据[玩家数据[id].队伍].成员数据[n]].角色:刷新任务跟踪()
        end
      玩家数据[队伍数据[玩家数据[id].队伍].成员数据[n]].角色:刷新任务跟踪()
    end
    常规提示(id,"#Y你上交了#R"..self.数据[道具id].数量.."#Y个木材，为道观增加了#R"..增加进度.."#Y建设度。")
    self.数据[道具id]=nil
    玩家数据[id].角色.数据.道具[数据.格子[1]]=nil
    道具刷新(id)
    任务处理类:设置车迟斗法副本(副本id)
    end
end


function 道具处理类:出售装备(连接id,id)
  if 玩家数据[id].出售装备==nil or 玩家数据[id].角色.数据.道具[玩家数据[id].出售装备]==nil then
    添加最后对话(id,"该装备不存在！")
    return
  end
  local 道具id=玩家数据[id].角色.数据.道具[玩家数据[id].出售装备]
  if self.数据[道具id].总类~=2 or self.数据[道具id].灵饰 or self.数据[道具id].分类==9 then
    添加最后对话(id,"该物品无法被我收购")
    return
  end
  local 银子=self:取装备价格(道具id)
  玩家数据[id].角色:添加银子(银子,format("出售装备:%s,%s",self.数据[道具id].名称,self.数据[道具id].识别码),1)
  self.数据[道具id]=nil
  玩家数据[id].角色.数据.道具[玩家数据[id].出售装备]=nil
  玩家数据[id].出售装备=nil
  添加最后对话(id,"出售装备成功，你获得了"..银子.."两银子")
  道具刷新(id)
  return
end

function 道具处理类:取装备价格(道具id)
  local 等级=self.数据[道具id].级别限制
  local 价格=150
  if  等级 ==10 then
    价格=1
  elseif 等级<10 then
    价格=1
  elseif  等级<=20 then
    价格=1
  elseif 等级<=30 then
   价格=1
  elseif 等级<=40 then
   价格=1
  else
   价格=100
  end
  if self.数据[道具id].专用~=nil then
    价格=1
    等级=1
  end
  return 价格*等级
end

function 道具处理类:生成合成旗(连接id,id,名称)
  if 玩家数据[id].合成旗序列==nil or #玩家数据[id].合成旗序列<=0 then
    常规提示(id,"#Y未找到已提交的导标旗，请重新使用法宝进行合成")
    玩家数据[id].合成旗序列=nil
    return
  end
  local 编号=玩家数据[id].法宝id
  if 玩家数据[id].角色.数据.法宝[编号]==nil or self.数据[玩家数据[id].角色.数据.法宝[编号]]==nil or self.数据[玩家数据[id].角色.数据.法宝[编号]].名称~="五色旗盒" then
    常规提示(id,"#Y你没有这样的法宝")
    return
  elseif self.数据[玩家数据[id].角色.数据.法宝[编号]].魔法<=0 then
    常规提示(id,"#Y你的法宝灵气不足")
    return
  end
  self.数据[玩家数据[id].角色.数据.法宝[编号]].魔法=self.数据[玩家数据[id].角色.数据.法宝[编号]].魔法-1
  local 次数=0
  for n=1,#玩家数据[id].合成旗序列 do
    local 临时id=玩家数据[id].角色.数据.道具[玩家数据[id].合成旗序列[n]]
    if 临时id==nil or self.数据[临时id]==nil or self.数据[临时id].总类~=11 or self.数据[临时id].分类~=1 or self.数据[临时id].地图~=玩家数据[id].合成旗序列.地图 or self.数据[临时id].次数==nil then
      常规提示(id,"#Y你的旗子没有定点，合成失败")
      玩家数据[id].合成旗序列=nil
      return
    end
    次数=次数+self.数据[临时id].次数
  end
  local 临时id=玩家数据[id].角色.数据.道具[玩家数据[id].合成旗序列[1]]
  self.数据[临时id].名称=名称
  self.数据[临时id].分类=2
  self.数据[临时id].次数=次数
  self.数据[临时id].xy={}
  for n=1,#玩家数据[id].合成旗序列 do
    local 临时id1=玩家数据[id].角色.数据.道具[玩家数据[id].合成旗序列[n]]
    self.数据[临时id].xy[n]={x=self.数据[临时id1].x,y=self.数据[临时id1].y}
    if n~=1 then
      玩家数据[id].角色.数据.道具[玩家数据[id].合成旗序列[n]]=nil
      self.数据[临时id1]=nil
    end
  end
  玩家数据[id].合成旗序列=nil
  玩家数据[id].法宝id=nil
  玩家数据[id].最后操作=nil
  发送数据(连接id,38,{内容="你的法宝#R/五色旗盒#W/灵气减少了1点"})
  常规提示(id,"#Y您获得了#R"..名称)
  道具刷新(id)
end

function 道具处理类:删除同类物品(识别码)
    for k,v in pairs(self.数据) do
          if v.识别码==识别码 then
                self.数据[k]=nil
          end
    end
end


function 道具处理类:改变道具归属(id,id1,道具id,对方格子,类型,数量,格子,包裹类型)
            if not 数量 then 数量 = 玩家数据[id].道具.数据[道具id].数量 end
            local 名称 = 玩家数据[id].道具.数据[道具id].名称
            local 新识别码 = 取唯一识别码(id1)
            local 老识别码 = 玩家数据[id].道具.数据[道具id].识别码
            local 道具物品 = 玩家数据[id].道具:取指定道具(道具id)
            local 新道具id=玩家数据[id1].道具:取新编号()
            玩家数据[id1].道具.数据[新道具id]=道具物品
            玩家数据[id1].道具.数据[新道具id].识别码 = 新识别码
            玩家数据[id1].角色.数据.道具[对方格子]=新道具id
            if 玩家数据[id1].道具.数据[新道具id].数量 then
                玩家数据[id1].道具.数据[新道具id].数量 = math.floor(数量)
            end
            if 数量 and 玩家数据[id].道具.数据[道具id].数量 then
                玩家数据[id].道具.数据[道具id].数量 = math.floor(玩家数据[id].道具.数据[道具id].数量-数量)
                if 玩家数据[id].道具.数据[道具id].数量<1 then
                    玩家数据[id].道具.数据[道具id]=nil
                    if 格子 then
                         if 包裹类型 then
                            玩家数据[id].角色.数据[包裹类型][格子]=nil
                         else
                             玩家数据[id].角色.数据.道具[格子]=nil
                         end
                    end
                end
            else
                玩家数据[id].道具.数据[道具id]=nil
                if 格子 then
                    if 包裹类型 then
                        玩家数据[id].角色.数据[包裹类型][格子]=nil
                    else
                        玩家数据[id].角色.数据.道具[格子]=nil
                    end
                end

            end
          if 类型 then
              玩家数据[id].角色:日志记录("给予["..类型.."]玩家:"..玩家数据[id1].角色.数据.名称.."ID("..玩家数据[id1].角色.数据.数字id..") 账号:"..玩家数据[id1].账号.." 物品:"..名称.."老识别码:"..老识别码.." 新识别码:"..新识别码)
              玩家数据[id1].角色:日志记录("接受["..类型.."]玩家:"..玩家数据[id1].角色.数据.名称.."ID("..玩家数据[id].角色.数据.数字id..") 账号:"..玩家数据[id].账号.." 物品:"..名称.."老识别码:"..老识别码.." 新识别码:"..新识别码)
          end
          return 老识别码





end


function 道具处理类:发起给予处理(连接id,id,id1)
        if not id1 or not 玩家数据[id1] then
            常规提示(id,"#Y/对方并不在线")
            return
        elseif 地图处理类:比较距离(id,id1,2000)==false then
            常规提示(id,"#Y/你们的距离太远了")
            return
        elseif 玩家数据[id1].交易信息~=nil or 玩家数据[id1].摊位数据~=nil then
            常规提示(id,"#Y/对方正忙，请稍后再试")
            return
        elseif not 玩家数据[id1].角色.数据.接受给予 then
            常规提示(id,"#Y/对方不接受任何方式给予物品")
            return
        end
        玩家数据[id].给予数据={类型=2,id=id1}
        发送数据(连接id,3507,{道具=self:索要道具1(id),名称=玩家数据[id1].角色.数据.名称,类型="玩家",等级=玩家数据[id1].角色.数据.等级})
end



function 道具处理类:给予处理(连接id,id,数据)
  if 玩家数据[id].给予数据==nil  then
    return
  elseif 玩家数据[id].给予数据.类型==1 then --npc给予
    self:系统给予处理(连接id,id,数据)
    return
  end
  local 对方id=玩家数据[id].给予数据.id
  if 玩家数据[对方id]==nil then
    常规提示(id,"#Y/对方并不在线")
    return
  end
  if 地图处理类:比较距离(id,对方id,2000)==false then
    常规提示(id,"#Y/你们的距离太远了")
    return
  end
  if 玩家数据[对方id].摊位数据 ~= nil then
    常规提示(id,"#Y/对方正在摆摊无法给予物品")
    return
  end
  if not 玩家数据[对方id].角色.数据.接受给予 then
    常规提示(id,"#Y/对方不接受任何方式给予物品")
    return
  end

  -- 给予银子
  local 银子=0
  local 名称=玩家数据[id].角色.数据.名称
  local 名称1=玩家数据[对方id].角色.数据.名称
  if 数据.银子=="" or 数据.银子==nil then
      银子=0
  else
      银子=tonumber(数据.银子)
  end
  if not 银子 or 银子<0 or 银子~=math.floor(银子) or isNaN(银子) then
    return
  end
  if 玩家数据[id].角色.数据.银子<银子 then
    常规提示(id,"#Y/你没有那么多的银子")
    return
  end
  -- print(银子,数据.银子)
  if 银子>0 then
    local 之前银子=玩家数据[id].角色.数据.银子
    玩家数据[id].角色.数据.银子=玩家数据[id].角色.数据.银子-银子
    玩家数据[id].角色:日志记录(format("[给予系统-发起]接受账号为[%s][%s][%s]角色%s两银子，初始银子为%s，余额为%s两银子",玩家数据[对方id].账号,对方id,玩家数据[对方id].角色.数据.名称,银子,之前银子,玩家数据[id].角色.数据.银子))
    local 之前银子=玩家数据[对方id].角色.数据.银子
    玩家数据[对方id].角色.数据.银子=玩家数据[对方id].角色.数据.银子+银子
    玩家数据[对方id].角色:日志记录(format("[给予系统-接受]发起账号为[%s][%s][%s]角色%s两银子，初始银子为%s，余额为%s两银子",玩家数据[id].账号,id,玩家数据[id].角色.数据.名称,银子,之前银子,玩家数据[对方id].角色.数据.银子))
    常规提示(id,format("#Y/你给了%s#G%s#Y两银子",名称1,银子))
    常规提示(对方id,format("#Y/%s给了你#G%s#Y两银子",名称,银子))
  end
  local  删除道具={}
  for n=1,3 do
    if 数据.格子[n]~=nil then
      local 格子=数据.格子[n]
      if 格子~=nil then
        local 道具id=玩家数据[id].角色.数据.道具[数据.格子[n]]
        if 道具id~=nil and 玩家数据[id].道具.数据[道具id]~=nil then
          if 玩家数据[id].道具.数据[道具id].绑定 or 玩家数据[id].道具.数据[道具id].不可交易 then
            常规提示(id,"#Y/该物品无法交易或给予给他人")
          elseif 玩家数据[id].道具.数据[道具id].名称 =="帮派银票" or 玩家数据[id].道具.数据[道具id].总类 =="帮派银票" then
            常规提示(id,"#Y/该物品无法交易或给予给他人")
          elseif 玩家数据[id].道具.数据[道具id].总类=="跑商商品" then
            常规提示(id,"#Y/该物品无法交易或给予给他人")
          elseif 玩家数据[id].道具.数据[道具id].数量 and 玩家数据[id].道具.数据[道具id].数量>999 then
            常规提示(id,"#Y/该物品不可转移给他人")
          else
              local 对方格子=玩家数据[对方id].角色:取道具格子()
              if 对方格子==0 then
                  常规提示(id,"#Y/对方身上没有足够的空间")
              else
                    local  道具名称 = 玩家数据[id].道具.数据[道具id].名称
                    local  数量 = 玩家数据[id].道具.数据[道具id].数量
                    删除道具[#删除道具+1]=self:改变道具归属(id,对方id,道具id,对方格子,"给予处理",数量,数据.格子[n])
                    常规提示(id,"#Y/你给了"..玩家数据[对方id].角色.数据.名称.."#R"..道具名称)
                    常规提示(对方id,"#Y/"..玩家数据[id].角色.数据.名称.."给了你#R"..道具名称)
              end
          end
        end
      end
    end
  end
  for k,v in pairs(删除道具) do
      玩家数据[id].道具:删除同类物品(v)
  end





  道具刷新(id)
  道具刷新(对方id)
  玩家数据[id].给予数据=nil
end

function 道具处理类:开启宝藏山小宝箱(id,任务id)
  if 任务数据[任务id]==nil then
    常规提示(id,"#Y这个宝箱已经被其他玩家开启过了")
    return
  elseif 活动次数查询(id,"宝藏山小宝箱")==false then
    return
  elseif 宝藏山数据[id].小宝箱>10 then
    常规提示(id,"#Y你在本次活动中开启的小宝箱数量已达10个，无法再开启更多的小宝箱了")
    return
  end
  地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].编号)
  任务数据[任务id]=nil
  宝藏山数据[id].小宝箱=宝藏山数据[id].小宝箱+1
  宝藏山数据.小宝箱=宝藏山数据.小宝箱-1
  地图处理类:当前消息广播1(5001,format("#G当前场景内小宝箱剩余数量为：#R%s#G个",宝藏山数据.小宝箱))
  常规提示(id,"#Y你在本次活动中还可以开启#R"..(10-宝藏山数据[id].小宝箱).."个小宝箱")
  添加活动次数(id,"宝藏山小宝箱")

  if 取随机数()<=80 then
     local 获得物品={}
     for i=1,#自定义数据.宝藏山小宝箱 do
         if 取随机数()<=自定义数据.宝藏山小宝箱[i].概率 then
            获得物品[#获得物品+1]=自定义数据.宝藏山小宝箱[i]
         end
     end
     获得物品=删除重复(获得物品)
     if 获得物品~=nil then
        local 取编号=取随机数(1,#获得物品)
        if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
           玩家数据[id].道具:自定义给予道具(id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
           广播消息({内容=format("#S(宝藏山)#R/%s#Y在宝藏山四处搜寻宝箱，皇天不负有心人，终于发现了一个小宝箱，打开一瞧，里面的宝藏居然是#G/%s#Y",玩家数据[id].角色.数据.名称,获得物品[取编号].名称),频道="xt"})
        end
     end
  else
       local 等级=玩家数据[id].角色.数据.等级
       local 经验=(等级*150*2)
       经验=取随机数(经验,经验*2)
       玩家数据[id].角色:添加经验(经验,"宝藏山小箱子",1)
  end




end

function 道具处理类:开启宝藏山大宝箱(id,任务id)
  if 任务数据[任务id]==nil then
    常规提示(id,"#Y这个宝箱已经被其他玩家开启过了")
    return
  elseif 活动次数查询(id,"宝藏山大宝箱")==false then
    return
  elseif 宝藏山数据[id].大宝箱>5 then
    常规提示(id,"#Y你在本次活动中开启的大宝箱数量已达5个，无法再开启更多的大宝箱了")
    return
  end
  地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].编号)
  任务数据[任务id]=nil
  宝藏山数据[id].大宝箱=宝藏山数据[id].大宝箱+1
  宝藏山数据.大宝箱=宝藏山数据.大宝箱-1
  地图处理类:当前消息广播1(5001,format("#G当前场景内大宝箱剩余数量为：#R%s#G个",宝藏山数据.大宝箱))
  常规提示(id,"#Y你在本次活动中还可以开启#R"..(5-宝藏山数据[id].大宝箱).."个大宝箱")
  添加活动次数(id,"宝藏山大宝箱")
  local 银子=取随机数(30000,50000)
  玩家数据[id].角色:添加银子(银子,"宝藏山大箱子",1)
  local 奖励参数=取随机数(1,200)
  if 取随机数()<=80 then
     local 获得物品={}
     for i=1,#自定义数据.宝藏山大箱子 do
         if 取随机数()<=自定义数据.宝藏山大箱子[i].概率 then
            获得物品[#获得物品+1]=自定义数据.宝藏山大箱子[i]
         end
     end
     获得物品=删除重复(获得物品)
     if 获得物品~=nil then
        local 取编号=取随机数(1,#获得物品)
        if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
           玩家数据[id].道具:自定义给予道具(id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
           广播消息({内容=format("#S(宝藏山)#R/%s#Y在宝藏山四处搜寻宝箱，皇天不负有心人，终于发现了一个大宝箱，打开一瞧，里面的宝藏居然是#G/%s#Y",玩家数据[id].角色.数据.名称,获得物品[取编号].名称),频道="xt"})
        end
     end
  else
     local 等级=玩家数据[id].角色.数据.等级
     local 经验=(等级*300*2)
     玩家数据[id].角色:添加经验(经验,"宝藏山大箱子",1)
  end

end

function 道具处理类:鉴定装备(连接id,id)
  if 玩家数据[id].鉴定装备==nil or 玩家数据[id].角色.数据.道具[玩家数据[id].鉴定装备]==nil then
    添加最后对话(id,"该装备不存在！")
    return
  end
  local 道具id=玩家数据[id].角色.数据.道具[玩家数据[id].鉴定装备]
  if self.数据[道具id].总类~=2 or self.数据[道具id].灵饰 or self.数据[道具id].分类==9 then
    添加最后对话(id,"该物品我无法鉴定")
    return
    elseif self.数据[道具id].鉴定==true or self.数据[道具id].鉴定==nil then
    添加最后对话(id,"该装备已经鉴定过了")
    return
    elseif self.数据[道具id].级别限制>30 then
    添加最后对话(id,"等级大于30级的装备需要用图鉴鉴定了!")
    return
  end
  local 银子=self:取装备价格(道具id)
  玩家数据[id].角色:扣除银子(银子,"鉴定装备",1)
  self.数据[道具id].鉴定 = true
  self.数据[道具id].耐久 = 500
      道具刷新(id)
      常规提示(id,"#Y/恭喜你，装备鉴定成功!")
    end

function 道具处理类:开启福利宝箱(id,任务id)
    if 任务数据[任务id]==nil then
      常规提示(id,"#Y这个宝箱已经被其他玩家开启过了")
    return
  end
      local 奖励参数=取随机数()
      if 奖励参数<=80 then
        local 名称="5W银子"
        玩家数据[id].角色:添加银子(50000,"福利宝箱",1)
        常规提示(id,"#Y/你获得了"..名称)
        --广播消息({内容=format("#S(福利宝箱)#R/%s#Y少侠开启福利宝箱时，里面居然藏着美味的海鲜，少侠口水直流，猛得咬下去，居然硌掉了大门牙，拿出来一看居然是#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,名称),频道="xt"})
      elseif 奖励参数<=90 then
        local 名称="魔兽要诀"
        玩家数据[id].道具:给予道具(id,名称)
        常规提示(id,"#Y/你获得了"..名称)
        --广播消息({内容=format("#S(福利宝箱)#R/%s#Y少侠开启福利宝箱时，里面居然藏着美味的海鲜，少侠口水直流，猛得咬下去，居然硌掉了大门牙，拿出来一看居然是#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,名称),频道="xt"})
     else
        local 名称="50W银子"
        玩家数据[id].角色:添加银子(500000,"福利宝箱",1)
        常规提示(id,"#Y/你获得了"..名称)
        --广播消息({内容=format("#S(福利宝箱)#R/%s#Y少侠开启福利宝箱时，里面居然藏着美味的海鲜，少侠口水直流，猛得咬下去，居然硌掉了大门牙，拿出来一看居然是#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,名称),频道="xt"})
      end
  地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].编号)
  任务数据[任务id]=nil
end

--   if 任务数据[任务id]==nil then
--     常规提示(id,"#Y这个宝箱已经被其他玩家开启过了")
--     return
--   end
--   地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].编号)
--   任务数据[任务id]=nil
--   local 奖励参数=取随机数()
--   if 奖励参数<=40 then
--     local 名称="2W银子"
--     玩家数据[id].角色:添加银子(20000,"福利宝箱",1)
--     广播消息({内容=format("#S(福利宝箱)#R/%s#Y福来缘深，拾取福利宝箱获得#G/%s#Y",玩家数据[id].角色.数据.名称,名称),频道="xt"})
--   elseif 奖励参数<=50 then
--     local 名称="10点仙玉"
--     添加仙玉(10,玩家数据[id].账号,id,"福利宝箱")
--     常规提示(id,"#Y你获得了#R"..名称)
--     广播消息({内容=format("#S(福利宝箱)#R/%s#Y福来缘深，拾取福利宝箱获得#G/%s#Y",玩家数据[id].角色.数据.名称,名称),频道="xt"})
--   elseif 奖励参数<=55 then
--     local 物品表={"金香玉","小还丹","千年保心丹","风水混元丹","定神香","蛇蝎美人","九转回魂丹","佛光舍利子","十香返生丸","五龙丹"}
--     local 临时物品=物品表[取随机数(1,#物品表)]
--     local 临时品质=100
--     常规提示(id,"#W/你获得了#R/"..临时物品)
--     self:给予道具(id,临时物品,1,临时品质)
--     广播消息({内容=format("#S(福利宝箱)#R/%s#Y福来缘深，拾取福利宝箱获得#G/%s#Y",玩家数据[id].角色.数据.名称,临时物品),频道="xt"})
--   else
--     local 名称="3W经验"
--     玩家数据[id].角色:添加经验(30000,"福利宝箱",1)
--     广播消息({内容=format("#S(福利宝箱)#R/%s#Y福来缘深，拾取福利宝箱获得#G/%s#Y",玩家数据[id].角色.数据.名称,名称),频道="xt"})
--   end
-- end

function 道具处理类:开启车迟福利宝箱(id,任务id)
  if 任务数据[任务id]==nil then
    常规提示(id,"#Y这个宝箱已经被其他玩家开启过了")
    return
  end
  地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].编号)
  任务数据[任务id]=nil
  local 获得物品={}
  for i=1,#自定义数据.车迟福利宝箱 do
      if 取随机数()<=自定义数据.车迟福利宝箱[i].概率 then
         获得物品[#获得物品+1]=自定义数据.车迟福利宝箱[i]
      end
  end
  获得物品=删除重复(获得物品)
  if 获得物品~=nil then
     local 取编号=取随机数(1,#获得物品)
     if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
        玩家数据[id].道具:自定义给予道具(id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
         广播消息({内容=format("#S(副本-车迟斗法)#R/%s#Y在#R车迟斗法#Y副本中表现卓越，因此获得了三清奖励的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,获得物品[取编号].名称),频道="xt"})
     end
  end

end

function 道具处理类:开启车迟胜利宝箱(id,任务id)
  if 任务数据[任务id]==nil then
    常规提示(id,"#Y这个宝箱已经被其他玩家开启过了")
    return
  end
  地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].编号)
  任务数据[任务id]=nil
  local 银子=取随机数(100000,500000)
  玩家数据[id].角色:添加银子(银子,"车迟斗法绑定宝箱",1)
  local 获得物品={}
  for i=1,#自定义数据.车迟胜利宝箱 do
      if 取随机数()<=自定义数据.车迟胜利宝箱[i].概率 then
         获得物品[#获得物品+1]=自定义数据.车迟胜利宝箱[i]
      end
  end
  获得物品=删除重复(获得物品)
  if 获得物品~=nil then
     local 取编号=取随机数(1,#获得物品)
     if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
        玩家数据[id].道具:自定义给予道具(id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
         广播消息({内容=format("#S(副本-车迟斗法)#R/%s#Y在#R车迟斗法#Y副本中表现卓越，因此获得了三清奖励的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,获得物品[取编号].名称),频道="xt"})
     end
  end


end

function 道具处理类:发放在线奖励(id)
玩家数据[id].道具:给予书铁(id,{7,8},"指南书")
玩家数据[id].道具:给予书铁(id,{7,8},"精铁")
玩家数据[id].角色:添加经验(500000,"测试奖励")
玩家数据[id].角色:添加银子(300000,"测试奖励",1)
玩家数据[id].道具:给予道具(id,"彩果",取随机数(1,5))
玩家数据[id].道具:给予道具(id,"神兜兜",取随机数(1,5))
   广播消息({内容=format("#S(在线奖励)#R/%s#Y本日在线因此获得了游戏管理员赠送的#G/%s#Y",玩家数据[id].角色.数据.名称,"70-80级书铁"),频道="xt"})
end

function 道具处理类:迷宫奖励(id)
  if 迷宫数据[id]~=nil  then
    添加最后对话(id,"你不是已经领取过奖励了吗？")
    return
  elseif 活动次数查询(id,"幻域迷宫")==false then
    return
  end
  迷宫数据[id]=true
  local 等级=玩家数据[id].角色.数据.等级
  local 经验=等级*1000*2
  local 银子=等级*1000*2
  添加活动次数(id,"幻域迷宫")

  玩家数据[id].角色:添加经验(经验,"幻域迷宫")
  玩家数据[id].角色:添加银子(银子,"幻域迷宫",1)
   local 获得物品={}
    for i=1,#自定义数据.迷宫奖励 do
        if 取随机数()<=自定义数据.迷宫奖励[i].概率 then
           获得物品[#获得物品+1]=自定义数据.迷宫奖励[i]
        end
    end
    获得物品=删除重复(获得物品)
    if 获得物品~=nil then
       local 取编号=取随机数(1,#获得物品)
       if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
          玩家数据[id].道具:自定义给予道具(id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
         广播消息({内容=format("#S(幻域迷宫)#R/%s#Y成功通过了所有迷宫，因此获得了迷宫守卫奖励的#G/%s#Y",玩家数据[id].角色.数据.名称,获得物品[取编号].名称),频道="xt"})
       end
    end

  if 迷宫数据.奖励<5 then
     迷宫数据.奖励=迷宫数据.奖励+1
     local 获得物品={}
      for i=1,#自定义数据.迷宫前五 do
          if 取随机数()<=自定义数据.迷宫前五[i].概率 then
             获得物品[#获得物品+1]=自定义数据.迷宫前五[i]
          end
      end
      获得物品=删除重复(获得物品)
      if 获得物品~=nil then
         local 取编号=取随机数(1,#获得物品)
         if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
            玩家数据[id].道具:自定义给予道具(id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
            广播消息({内容=format("#S(幻域迷宫)#R/%s#Y以惊人的速度率先通过了所有迷宫，获得了迷宫守卫额外奖励的#G/%s#Y",玩家数据[id].角色.数据.名称,获得物品[取编号].名称),频道="xt"})
         end
      end
  end
  道具刷新(id)
end
function 道具处理类:高级藏宝图处理(id)
    local 奖励参数=取随机数(1,100)
    if 奖励参数<=60 then
        local 获得物品={}
        for i=1,#自定义数据.高级藏宝图 do
            if 取随机数()<=自定义数据.高级藏宝图[i].概率 then
               获得物品[#获得物品+1]=自定义数据.高级藏宝图[i]
            end
        end
        获得物品=删除重复(获得物品)
        if 获得物品~=nil then
           local 取编号=取随机数(1,#获得物品)
           if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
              玩家数据[id].道具:自定义给予道具(id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
              if 获得物品[取编号].名称=="特殊魔兽要诀" or 获得物品[取编号].名称=="高级魔兽要诀" or 获得物品[取编号].名称=="制造指南书" or 获得物品[取编号].名称=="灵饰指南书" or 获得物品[取编号].名称=="神兜兜" then
                广播消息({内容=format("#S(高级藏宝图)#R/#Y据说#R%s#Y拿着高级藏宝图到野外挖到了一个#G/%s",玩家数据[id].角色.数据.名称,获得物品[取编号].名称),频道="xt"})
              end
           end
        end
    elseif 奖励参数<=65 then
          战斗准备类:创建战斗(id+0,100221)
          广播消息({内容=format("#S(高级藏宝图)#R/#Y据说#R%s#Y拿着高级藏宝图到野外挖到了一窝155级以上嗷嗷待哺的#G/宝宝",玩家数据[id].角色.数据.名称),频道="xt"})
    elseif 奖励参数<=75 then
          战斗准备类:创建战斗(id+0,100005)
          广播消息({内容=format("#S(高级藏宝图)#R/#Y据说#R%s#Y拿着高级藏宝图到野外挖到了一窝95级以上嗷嗷待哺的#G/宝宝",玩家数据[id].角色.数据.名称),频道="xt"})
    elseif 奖励参数<=80 then
        常规提示(id,"#Y/你一锄头挖下去，似乎触碰到了一个奇形怪状的物体")
        任务处理类:设置封妖任务(id)
    else
        常规提示(id,"#Y/你一锄头挖下去，似乎触碰到了一个奇形怪状的物体")
        任务处理类:开启妖王(id)

    end

    if 成就数据[id].挖宝==nil then
    成就数据[id].挖宝=0
    end
    if 成就数据[id].挖宝<1000 then
    成就数据[id].挖宝=成就数据[id].挖宝+1
    end
    if 成就数据[id].挖宝 == 1 then
    local 成就提示 = "再世镖王"
    local 成就提示1 = "完成1次了挖宝"
    发送数据(玩家数据[id].连接id,149,{内容=成就提示,内容1=成就提示1})
    elseif 成就数据[id].挖宝==1000 then
    local 成就提示 = "再世镖王"
    local 成就提示1 = "完成1000次了挖宝"
    成就数据[id].成就点 = 成就数据[id].成就点 + 1
    玩家数据[id].角色.数据.成就积分 = 玩家数据[id].角色.数据.成就积分 + 1
    常规提示(id,"#Y/恭喜你获得了1点成就")
    发送数据(玩家数据[id].连接id,149,{内容=成就提示,内容1=成就提示1})
    玩家数据[id].角色:添加称谓("快递小哥")
    end
    end
function 道具处理类:玲珑宝图处理(id)
    local 奖励参数=取随机数(1,100)
    if 奖励参数<=98 then
        local 获得物品={}
        for i=1,#自定义数据.玲珑宝图 do
            if 取随机数()<=自定义数据.玲珑宝图[i].概率 then
               获得物品[#获得物品+1]=自定义数据.玲珑宝图[i]
            end
        end
        获得物品=删除重复(获得物品)
        if 获得物品~=nil then
           local 取编号=取随机数(1,#获得物品)
           if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
              玩家数据[id].道具:自定义给予道具(id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
              广播消息({内容=format("#S(玲珑宝图)#R/#Y据说#R%s#Y拿着玲珑宝图到野外挖到了一个#G/%s",玩家数据[id].角色.数据.名称,获得物品[取编号].名称),频道="xt"})
           end
        end
    else
      战斗准备类:创建战斗(id+0,100225,0)
      广播消息({内容=format("#S(玲珑宝图)#R/#Y据说#R%s#Y拿着玲珑宝图到野外挖到了一窝#G/神兽",玩家数据[id].角色.数据.名称),频道="xt"})
    end

    if 成就数据[id].挖宝==nil then
    成就数据[id].挖宝=0
    end
    if 成就数据[id].挖宝<1000 then
    成就数据[id].挖宝=成就数据[id].挖宝+1
    end
    if 成就数据[id].挖宝 == 1 then
    local 成就提示 = "再世镖王"
    local 成就提示1 = "完成1次了挖宝"
    发送数据(玩家数据[id].连接id,149,{内容=成就提示,内容1=成就提示1})
    elseif 成就数据[id].挖宝==1000 then
    local 成就提示 = "再世镖王"
    local 成就提示1 = "完成1000次了挖宝"
    成就数据[id].成就点 = 成就数据[id].成就点 + 1
    玩家数据[id].角色.数据.成就积分 = 玩家数据[id].角色.数据.成就积分 + 1
    常规提示(id,"#Y/恭喜你获得了1点成就")
    发送数据(玩家数据[id].连接id,149,{内容=成就提示,内容1=成就提示1})
    玩家数据[id].角色:添加称谓("快递小哥")
    end
 end




function 道具处理类:低级藏宝图处理(id)
  local 奖励参数=取随机数(1,100)
  if 奖励参数<=40 then
     local 获得物品={}
     for i=1,#自定义数据.低级藏宝图 do
         if 取随机数()<=自定义数据.低级藏宝图[i].概率 then
            获得物品[#获得物品+1]=自定义数据.低级藏宝图[i]
         end
      end
      获得物品=删除重复(获得物品)
      if 获得物品~=nil then
          local 取编号=取随机数(1,#获得物品)
          if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
              玩家数据[id].道具:自定义给予道具(id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
              if 获得物品[取编号].名称=="制造指南书" or 获得物品[取编号].名称=="灵饰指南书" then
                 广播消息({内容=format("#S(低级藏宝图)#R/#Y据说#R%s#Y拿着低级藏宝图到野外挖到了一个#G/%s",玩家数据[id].角色.数据.名称,获得物品[取编号].名称),频道="xt"})
              end
          end
      end
  elseif 奖励参数<=50 then
    local 名称="60-80级装备"
    self:取随机装备(id,取随机数(6,8))
    常规提示(id,"#Y/你得到了60-80级装备")
    广播消息({内容=format("#S(低级藏宝图)#R/#Y据说#R%s#Y拿着低级藏宝图到野外挖到了一个#G/%s",玩家数据[id].角色.数据.名称,名称),频道="xt"})
  elseif 奖励参数<=60 then
      玩家数据[id].角色:添加银子(取随机数(5000,10000),"挖宝",1)
  elseif 奖励参数<=70 then
      战斗准备类:创建战斗(id+0,100003)
      常规提示(id,"#Y/你一锄头挖下去，似乎触碰到了一个奇形怪状的物体")
  elseif 奖励参数<=85 then
      常规提示(id,"#Y/你一锄头挖下去挖出了一团瘴气，等你醒来的时候已经身受重伤了")
      玩家数据[id].角色.数据.气血=math.floor(玩家数据[id].角色.数据.气血*0.5)
      发送数据(玩家数据[id].连接id,5506,{玩家数据[id].角色:取气血数据()})
  else
      常规提示(id,"#Y/你一锄头挖下去，似乎触碰到了一个奇形怪状的物体")
      任务处理类:设置封妖任务(id)
  end
      if 成就数据[id].挖宝==nil then
    成就数据[id].挖宝=0
    end
    if 成就数据[id].挖宝<1001 then
    成就数据[id].挖宝=成就数据[id].挖宝+1
    end
    if 成就数据[id].挖宝 == 1 then
    local 成就提示 = "再世镖王"
    local 成就提示1 = "完成1次了挖宝"
    发送数据(玩家数据[id].连接id,149,{内容=成就提示,内容1=成就提示1})
    elseif 成就数据[id].挖宝==1000 then
    local 成就提示 = "再世镖王"
    local 成就提示1 = "完成1000次了挖宝"
    成就数据[id].成就点 = 成就数据[id].成就点 + 1
    玩家数据[id].角色.数据.成就积分 = 玩家数据[id].角色.数据.成就积分 + 1
    常规提示(id,"#Y/恭喜你获得了1点成就")
    发送数据(玩家数据[id].连接id,149,{内容=成就提示,内容1=成就提示1})
    玩家数据[id].角色:添加称谓("快递小哥")
    end
end


function 道具处理类:完成宝图遇怪(id)
  local 奖励参数=取随机数(1,100)
  if 奖励参数<=50 then
    local 名称=取宝石()
    self:给予道具(id,名称,取随机数(1,2))
    发送数据(玩家数据[id].连接id,38,{内容="你得到了#R/"..名称})
    else
    self:取随机装备(id,取随机数(1,3))
    发送数据(玩家数据[id].连接id,38,{内容="你得到了#R10-30级装备"})
  end
  local 临时经验=取等级(id)*5*2
  玩家数据[id].角色:添加经验(临时经验,"挖图遇怪",1)
end

function 道具处理类:取五宝()
  return 五宝名称[取随机数(1,5)]
end




function 道具处理类:取灵犀玉特性() --61个
    local 特性_ = {"蔓延","无","无","无","无","无","无","天平","无",
    "无","无","无","相生","无","无","无","无","相克","无","无","无",
    "无","金耀","无","无","无","木耀","无","无","无","无","水耀","无",
    "无","无","火耀","无","无","无","土耀","无","利金","无","无","无",
    "利木","无","无","无","利水","无","无","无","利火","无","无","无",
    "利土","无","无","无"}
    return 特性_[取随机数(1,#特性_)]
end

function 道具处理类:取高级灵犀玉特性() --61个
    local 特性_ = {"蔓延","天平","相生","相克","金耀","木耀","水耀","火耀",
    "土耀","金耀","木耀","水耀","火耀","土耀","利金","利木","利水","利火",
    "利土","利金","利木","利水","利火","利土"}
    return 特性_[取随机数(1,#特性_)]
end






function 道具处理类:烹饪处理(连接id,数字id,数据,多角色)
  local 临时等级=玩家数据[数字id].角色:取生活技能等级("烹饪技巧")
  local 临时消耗=math.floor(临时等级)+10
  if 玩家数据[数字id].角色.数据.活力<临时消耗 then
    常规提示(数字id,"本次操作需要消耗"..临时消耗.."点活力",多角色)
    return
  end
  local 物品表={}
  玩家数据[数字id].角色.数据.活力= 玩家数据[数字id].角色.数据.活力-临时消耗
  体活刷新(数字id)
  if 临时等级<=4 then
   物品表={"包子"}
  elseif 临时等级<=9 then
   物品表={"包子","包子","佛跳墙","包子"}
  elseif 临时等级<=14 then
   物品表={"包子","包子","佛跳墙","包子","烤鸭"}
  elseif 临时等级<=19 then
   物品表={"包子","珍露酒","佛跳墙","烤鸭","佛跳墙","佛跳墙","包子","烤鸭"}
  elseif 临时等级<=24 then
   物品表={"包子","珍露酒","佛跳墙","佛跳墙","佛跳墙","烤鸭","包子","烤鸭","虎骨酒","佛跳墙","佛跳墙","包子","女儿红"}
  elseif 临时等级<=29 then
   物品表={"包子","珍露酒","豆斋果","佛跳墙","烤鸭","包子","佛跳墙","佛跳墙","烤鸭","虎骨酒","烤鸭","包子","女儿红"}
 elseif 临时等级<=34 then
   物品表={"包子","佛跳墙","佛跳墙","佛跳墙","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
  elseif 临时等级<=39 then
   物品表={"烤肉","桂花丸","佛跳墙","佛跳墙","佛跳墙","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
  elseif 临时等级<=44 then
   物品表={"烤肉","翡翠豆腐","桂花丸","佛跳墙","佛跳墙","佛跳墙","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
  elseif 临时等级<=49 then
   物品表={"烤肉","长寿面","翡翠豆腐","桂花丸","佛跳墙","佛跳墙","佛跳墙","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
  elseif 临时等级<=54 then
   物品表={"烤肉","梅花酒","长寿面","翡翠豆腐","桂花丸","佛跳墙","佛跳墙","佛跳墙","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
  elseif 临时等级<=59 then
   物品表={"烤肉","百味酒","梅花酒","长寿面","翡翠豆腐","桂花丸","佛跳墙","佛跳墙","佛跳墙","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
  elseif 临时等级<=64 then
   物品表={"烤肉","蛇胆酒","百味酒","梅花酒","长寿面","翡翠豆腐","桂花丸","佛跳墙","佛跳墙","佛跳墙","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
  else
   物品表={"烤肉","醉生梦死","蛇胆酒","百味酒","梅花酒","长寿面","翡翠豆腐","桂花丸","佛跳墙","佛跳墙","佛跳墙","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
  end
  local 临时物品=物品表[取随机数(1,#物品表)]
  local 临时品质=0
  if 临时物品~="包子" then
    临时品质=取随机数(math.floor(临时等级*0.5),临时等级)
  end
  常规提示(数字id,"#W/经过一阵忙碌，你烹制出了#R/"..临时物品,多角色)
  self:给予道具(数字id,临时物品,1,临时品质)
  道具刷新(数字id,多角色)
end

function 道具处理类:炼药处理(连接id,数字id,数据,多角色)
  local 临时等级=玩家数据[数字id].角色:取生活技能等级("中药医理")
  local 临时消耗=math.floor(临时等级)+10
  if 玩家数据[数字id].角色.数据.活力<临时消耗 then
   常规提示(数字id,"本次操作需要消耗"..临时消耗.."点活力",多角色)
   return
  elseif 临时等级<10 then
   常规提示(数字id,"您的中药医理技能尚未达到10级，无法进行炼药操作",多角色)
   return
  elseif 玩家数据[数字id].角色.数据.银子<5000 then
    常规提示(数字id,"炼药需要消耗5000两银子",多角色)
    return
  end
  玩家数据[数字id].角色:扣除银子(5000,"炼药消耗",1)
  玩家数据[数字id].角色.数据.活力= 玩家数据[数字id].角色.数据.活力-临时消耗
  体活刷新(数字id)
  local 物品表={}
  物品表={"金创药","金创药","金创药","金香玉","金创药","金创药","小还丹","金创药","金创药","千年保心丹","金创药","金创药","风水混元丹","金创药","金创药","定神香","金创药","金创药","蛇蝎美人","金创药","金创药","九转回魂丹","金创药","金创药","佛光舍利子","金创药","金创药","十香返生丸","金创药","金创药","金创药","金创药","五龙丹"}
  local 临时物品=物品表[取随机数(1,#物品表)]
  local 临时品质=0
  临时品质=取随机数(math.floor(临时等级*0.5),临时等级)
  常规提示(数字id,"#W/恭喜你成功炼制出了#R/"..临时物品,多角色)
  self:给予道具(数字id,临时物品,1,临时品质)
  道具刷新(数字id,多角色)
end

function 道具处理类:染色处理(连接id,id,数据)
  local 彩果数量=10
  for n=1,#数据 do
      彩果数量=彩果数量+数据[n]
  end
  if self:消耗背包道具(id,"彩果",彩果数量) then
      常规提示(id,"染色成功！")
      玩家数据[id].角色.数据.染色组=数据
      发送数据(连接id,30,数据)
      道具刷新(id)
      地图处理类:更改染色(id,数据,玩家数据[id].角色.数据.染色方案)
  else
      常规提示(id,"你没有那么多的彩果")

  end
end


function 道具处理类:神秘宝箱处理(连接id,id,数据)
  if 神秘宝箱[id]==nil or not 共享货币[玩家数据[id].账号] then
    常规提示(id,"数据异常！")
    return
  end
  local 序号=神秘宝箱[id].中奖
  local 名称=神秘宝箱[id][序号].名称

if 神秘宝箱[id].抽奖类型 == "自定义抽奖" then
    if 玩家数据[id].角色.数据.抽奖>=1 then
      玩家数据[id].道具:自定义给予道具(id,自定义数据.抽奖配置[序号].名称,自定义数据.抽奖配置[序号].数量,自定义数据.抽奖配置[序号].参数)
      广播消息({内容=format("#S(幸运大转盘)#R/%s#Y在武神坛使者处获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,自定义数据.抽奖配置[序号].名称),频道="xt"})
      玩家数据[id].角色.数据.抽奖 = 玩家数据[id].角色.数据.抽奖 - 1
    end
else
    if 名称=="红玛瑙" or 名称=="太阳石" or 名称=="舍利子" or 名称=="黑宝石" or 名称=="月亮石" or 名称=="光芒石" then
      玩家数据[id].道具:给予道具(id,名称,取随机数(12,15))
      常规提示(id,"#Y你获得了#R"..名称)
      广播消息({内容=format("#S(幸运大转盘)#R/%s#Y在武神坛使者处获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,"12-15级宝石"),频道="xt"})
    elseif 名称=="星辉石" then
      玩家数据[id].道具:给予道具(id,名称,取随机数(5,8))
      常规提示(id,"#Y你获得了#R"..名称)
      广播消息({内容=format("#S(幸运大转盘)#R/%s#Y在武神坛使者处获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,"5-8级星辉石"),频道="xt"})
    elseif 名称=="金砖" then
        玩家数据[id].角色:添加银子(100000000,"神秘宝箱",1)
        广播消息({内容=format("#S(幸运大转盘)#R/%s#Y在武神坛使者处获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,"1亿银子"),频道="xt"})
    elseif 名称=="仙丹" then
        玩家数据[id].角色:添加经验(100000000,"神秘宝箱",1)
        广播消息({内容=format("#S(幸运大转盘)#R/%s#Y在武神坛使者处获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,"1亿经验"),频道="xt"})
     elseif 名称=="仙玉锦囊" then
        共享货币[玩家数据[id].账号]:添加仙玉(100000,id,"神秘宝箱")
        广播消息({内容=format("#S(幸运大转盘)#R/%s#Y在武神坛使者处获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,"10万仙玉"),频道="xt"})
    elseif 名称=="150精铁" then
      玩家数据[id].道具:给予书铁(id,{15,15},2)
      常规提示(id,"#Y你获得了#R"..名称)
      广播消息({内容=format("#S(幸运大转盘)#R/%s#Y在武神坛使者处获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,名称),频道="xt"})
    elseif 名称=="160精铁" then
      玩家数据[id].道具:给予书铁(id,{16,16},2)
      常规提示(id,"#Y你获得了#R"..名称)
      广播消息({内容=format("#S(幸运大转盘)#R/%s#Y在武神坛使者处获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,名称),频道="xt"})
     elseif 名称=="150指南" then
      玩家数据[id].道具:给予书铁(id,{15,15},1)
      常规提示(id,"#Y你获得了#R"..名称)
      广播消息({内容=format("#S(幸运大转盘)#R/%s#Y在武神坛使者处获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,名称),频道="xt"})
    elseif 名称=="160指南" then
      玩家数据[id].道具:给予书铁(id,{16,16},1)
      常规提示(id,"#Y你获得了#R"..名称)
      广播消息({内容=format("#S(幸运大转盘)#R/%s#Y在武神坛使者处获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,名称),频道="xt"})
    elseif 名称=="120自选" then
      local 物品名称="120级随机自选包"
      玩家数据[id].道具:给予道具(id,物品名称,1)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(幸运大转盘)#R/%s#Y在武神坛使者处获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,物品名称),频道="xt"})

    elseif 名称=="130自选" then
      local 物品名称="130级随机自选包"
      玩家数据[id].道具:给予道具(id,物品名称,1)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(幸运大转盘)#R/%s#Y在武神坛使者处获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,物品名称),频道="xt"})

    elseif 名称=="要诀" then
      local 物品名称="特殊魔兽要诀"
      玩家数据[id].道具:给予道具(id,物品名称)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(幸运大转盘)#R/%s#Y在武神坛使者处获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,物品名称),频道="xt"})
    elseif 名称=="高内丹" then
      local 物品名称="高级召唤兽内丹"
      玩家数据[id].道具:给予道具(id,物品名称)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(幸运大转盘)#R/%s#Y在武神坛使者处获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,物品名称),频道="xt"})
   elseif 名称=="内丹" then
      local 物品名称="召唤兽内丹"
      玩家数据[id].道具:给予道具(id,物品名称)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(幸运大转盘)#R/%s#Y在武神坛使者处获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,物品名称),频道="xt"})
    end
end
  神秘宝箱[id]=nil
end






function 道具处理类:卸下bb装备(连接id,id,数据,多角色)
  local 角色=数据.角色
  local 类型=数据.类型
  local 道具=数据.道具
  local bb=数据.编号
  local 道具格子=玩家数据[id].角色:取道具格子1(类型)
  if 道具格子==0 then
    常规提示(id,"您的道具栏物品已经满啦",多角色)
    return
  elseif 玩家数据[id].召唤兽.数据[bb]==nil then
     常规提示(id,"你没有这个宝宝",多角色)
    return
   elseif 玩家数据[id].召唤兽.数据[bb].装备[道具]==nil then
     常规提示(id,"没有该装备无法取掉",多角色)
    return
  else
      local 临时id=self:取新编号()
      self.数据[临时id]=玩家数据[id].召唤兽.数据[bb].装备[道具]
      玩家数据[id].召唤兽:卸下装备(玩家数据[id].召唤兽.数据[bb].装备[道具],道具,bb)
      玩家数据[id].角色.数据[类型][道具格子]=临时id
      玩家数据[id].召唤兽.数据[bb].装备[道具]=nil
      道具刷新(id,多角色)
      if 多角色~=nil then
         发送数据(玩家数据[多角色].连接id,6008,{角色=id,召唤兽=玩家数据[id].召唤兽.数据})
         发送数据(玩家数据[多角色].连接id,6015,{角色=id})
      else
          发送数据(连接id,20,玩家数据[id].召唤兽:取存档数据(bb))
          发送数据(连接id,28)
      end


  end
end

function 道具处理类:佩戴bb装备(连接id,id,数据,多角色)
  local 角色=数据.角色
  local 类型=数据.类型
  local 道具=数据.道具
  local 道具id=玩家数据[id].角色.数据[类型][道具]
  local bb=数据.编号
  if self.数据[道具id]==nil then
    常规提示(id,"没有该装备无法穿戴",多角色)
    return
  elseif self.数据[道具id].分类<=6 then
    常规提示(id,"该装备无法穿戴",多角色)
    return
 elseif 玩家数据[id].召唤兽.数据[bb]==nil then
     常规提示(id,"你没有这个宝宝",多角色)
    return
  else
       if self:召唤兽可装备(self.数据[道具id],self.数据[道具id].分类-6,玩家数据[id].召唤兽.数据[bb].等级,id,多角色) then
          local 装备格子=self.数据[道具id].分类 - 6
          if 玩家数据[id].召唤兽.数据[bb].装备[装备格子] ~= nil then
               local 临时道具=玩家数据[id].召唤兽.数据[bb].装备[装备格子]
               玩家数据[id].召唤兽:卸下装备(玩家数据[id].召唤兽.数据[bb].装备[装备格子],装备格子,bb)
               玩家数据[id].召唤兽.数据[bb].装备[装备格子] =nil
               玩家数据[id].召唤兽:穿戴装备(self.数据[道具id],装备格子,bb)
               self.数据[道具id] = 临时道具
               玩家数据[id].角色.数据[类型][道具]=道具id
          else
               玩家数据[id].召唤兽:穿戴装备(self.数据[道具id],装备格子,bb)
               self.数据[道具id]=nil
               玩家数据[id].角色.数据[类型][道具]=nil
          end
          道具刷新(id,多角色)
           if 多角色~=nil then
               发送数据(玩家数据[多角色].连接id,6008,{角色=id,召唤兽=玩家数据[id].召唤兽.数据})
               发送数据(玩家数据[多角色].连接id,6015,{角色=id})
            else
                发送数据(连接id,20,玩家数据[id].召唤兽:取存档数据(bb))
                发送数据(连接id,28)
            end

        end
  end

end

function 道具处理类:穿戴饰品(连接id,id,数据,多角色)
  local 角色=数据.角色
  local 类型=数据.类型
  local 道具=数据.道具
  local 道具id=玩家数据[id].角色.数据[类型][道具]
  local 坐骑=数据.编号
  if self.数据[道具id].总类=="坐骑饰品" and self.数据[道具id].子类==玩家数据[id].角色.数据.坐骑列表[坐骑].模型 then
    local 物品=取物品数据(self.数据[道具id].名称)
    if 玩家数据[id].角色.数据.坐骑列表[坐骑].饰品==nil then
        玩家数据[id].角色.数据.坐骑列表[坐骑].饰品=self.数据[道具id].名称
        玩家数据[id].角色.数据.坐骑列表[坐骑].饰品物件=self.数据[道具id]
        玩家数据[id].角色.数据.坐骑列表[坐骑].饰品id = 玩家数据[id].角色.数据[类型][道具]
        玩家数据[id].角色.数据[类型][道具]=nil
    else
        local 道具id1=玩家数据[id].角色.数据.坐骑列表[坐骑].饰品id
        玩家数据[id].角色.数据.坐骑列表[坐骑].饰品=self.数据[道具id].名称
        玩家数据[id].角色.数据.坐骑列表[坐骑].饰品物件=self.数据[道具id]
        玩家数据[id].角色.数据.坐骑列表[坐骑].饰品id = 玩家数据[id].角色.数据[类型][道具]
        玩家数据[id].角色.数据[类型][道具]=nil
        玩家数据[id].角色.数据[类型][道具]=道具id1
    end
    if 多角色~=nil then
      发送数据(玩家数据[多角色].连接id,6002,{角色=id,角色属性=玩家数据[id].角色:取总数据()})
      发送数据(玩家数据[多角色].连接id,6016,{角色=id,坐骑=玩家数据[id].角色.数据.坐骑})
      发送数据(玩家数据[多角色].连接id,6017,{角色=id})
    else
      发送数据(玩家数据[id].连接id,60,玩家数据[id].角色.数据.坐骑)
       发送数据(玩家数据[id].连接id,61,玩家数据[id].角色.数据.坐骑列表)
       发送数据(连接id,3531)
    end
    地图处理类:更新坐骑(id,玩家数据[id].角色.数据.坐骑)
    地图处理类:更新坐骑(id,玩家数据[id].角色.数据.坐骑列表)
    道具刷新(id,多角色)
  else
    常规提示(id,"#Y/该饰品不适合该坐骑哦",多角色)
  end
end

function 道具处理类:卸下饰品(连接id,id,数据,多角色)

  local 道具格子=玩家数据[id].角色:取道具格子()
  local 坐骑 = 数据.编号
  if 道具格子==0 then
    常规提示(id,"您的道具栏物品已经满啦",多角色)
    return
  else
    local 临时id=self:取新编号()
    self.数据[临时id]=玩家数据[id].角色.数据.坐骑列表[坐骑].饰品物件
    玩家数据[id].角色.数据.道具[道具格子]=临时id
    玩家数据[id].角色.数据.坐骑列表[坐骑].饰品=nil
    玩家数据[id].角色.数据.坐骑列表[坐骑].饰品物件=nil
    if 多角色~=nil then
      发送数据(玩家数据[多角色].连接id,6002,{角色=id,角色属性=玩家数据[id].角色:取总数据()})
      发送数据(玩家数据[多角色].连接id,6016,{角色=id,坐骑=玩家数据[id].角色.数据.坐骑})
      发送数据(玩家数据[多角色].连接id,6017,{角色=id})
    else
      发送数据(玩家数据[id].连接id,60,玩家数据[id].角色.数据.坐骑)
       发送数据(玩家数据[id].连接id,61,玩家数据[id].角色.数据.坐骑列表)
       发送数据(连接id,3531)
    end
    地图处理类:更新坐骑(id,玩家数据[id].角色.数据.坐骑)
    地图处理类:更新坐骑(id,玩家数据[id].角色.数据.坐骑列表)
    道具刷新(id,多角色)
  end
end

function 道具处理类:召唤兽可装备(i1,i2,等级,id,多角色)
  if i1 ~= nil and i1.分类 - 6 == i2 then
    if (i1.级别限制 == 0 or (i1.第二特效~=nil and i1.第二特效 == "无级别限制") or 等级 >= i1.级别限制)  then
      return true
    else
      if i1.级别限制 > 等级 then
        常规提示(id,"#Y/你的召唤兽等级不足哦",多角色)
      end
    end
  end
  return false
end

-- function 道具处理类:取随机装备(id,等级,返回,是否无级别)
--   -- print(id,等级,返回)
--   local 临时格子=玩家数据[id].角色:取道具格子()
--   if 临时格子==0 then 常规提示(id,"#Y/你身上的空间不够，无法获得装备") return end
--   local 临时等级=等级
--   --local 临时种类=取随机数(1,#书铁范围)
--   local 临时参数=取随机数(1,#书铁范围)
--   local 临时序列=临时参数
--   if 临时序列==25 then
--     临时序列=23
--   elseif 临时序列==24 then
--     临时序列=22
--   elseif 临时序列==23 or 临时序列==22 then
--     临时序列=21
--   elseif 临时序列==21 then
--     临时序列=20
--   elseif 临时序列==20 or 临时序列==19 then
--     临时序列=19
--   end


--      if 临时序列<=18 and 临时等级>=9 then --是武器 10-12是普通光武
--         if 临时等级<=11 then
--           临时等级=取随机数(9,11)
--         elseif 临时等级<=14 then
--           临时等级=取随机数(12,14)
--         end
--         临时等级=临时等级+1
--       else
--         临时等级=临时等级+1
--       end

--   local 临时类型=玩家数据[id].装备.打造物品[临时序列][临时等级]
--   if type(临时类型)=="table" then
--     if 临时参数 ==23 then
--      临时类型=临时类型[2]
--     elseif 临时参数 ==22 then
--      临时类型=临时类型[1]
--     elseif 临时参数 ==20 then
--      临时类型=临时类型[2]
--     elseif 临时参数 ==19 then
--      临时类型=临时类型[1]
--     else
--       临时类型=临时类型[取随机数(1,2)]
--     end
--   end
--   local 道具 = 物品类()
--   道具:置对象(临时类型)
--   local dz = 玩家数据[id].装备:打造公式(等级*10,临时序列)
--   if dz[1] ~= nil then
--     道具.命中 = dz[1]
--   end
--   if dz[2] ~= nil then
--     道具.伤害 = dz[2]
--   end
--   if dz[3] ~= nil then
--     道具.防御 = dz[3]
--   end
--   if dz[4] ~= nil then
--     道具.魔法 = dz[4]
--   end
--   if dz[5] ~= nil then
--     道具.灵力 = dz[5]
--   end
--   if dz[6] ~= nil then
--     道具.气血 = dz[6]
--   end
--   if dz[7] ~= nil then
--     道具.敏捷 = dz[7]
--   end
--   if dz[8] ~= nil then
--     道具.体质 = dz[8]
--   end
--   if dz[9] ~= nil then
--     道具.力量 = dz[9]
--   end
--   if dz[10] ~= nil then
--     道具.耐力 = dz[10]
--   end
--   if dz[11] ~= nil then
--     道具.魔力 = dz[11]
--   end


--   if 是否无级别 ~= nil then
--     道具.特效 = "无级别限制"
--    else
--      if dz[12] ~= nil then
--       local 通用特效 = {"无级别限制","神佑","珍宝","必中","神农","简易","绝杀","专注","精致","再生","易修理","超级简易"}
--       if 道具.分类 == 5 then
--         table.insert(通用特效,"愤怒")
--         table.insert(通用特效,"暴怒")
--       end
--       道具.特效 = 通用特效[取随机数(1,#通用特效)]
--     end
--  end

--   if dz[13] ~= nil then
--     local 通用特技 = {"修罗咒","天衣无缝","气疗术","心疗术","命疗术","凝气诀","凝神诀","气归术","命归术","四海升平","回魂咒",
--     "起死回生","水清诀","冰清诀","玉清诀","晶清诀","弱点击破","冥王暴杀","放下屠刀","河东狮吼","碎甲术","破甲术",
--     "破血狂攻","罗汉金钟","慈航普渡","太极护法","光辉之甲","圣灵之甲","野兽之力","魔兽之印","流云诀","啸风诀",
--     "笑里藏刀","绝幻魔音","凝滞术","停陷术","破碎无双","琴音三叠","菩提心佑","先发制人","身似菩提"}
--     道具.特技 = 通用特技[取随机数(1,#通用特技)]
--   end
--   local 道具id=self:取新编号()
--   self.数据[道具id]=道具
--   self.数据[道具id].级别限制=等级*10
--   self.数据[道具id].鉴定=false
--   self.数据[道具id].五行=取五行()
--   self.数据[道具id].耐久=500
--   self.数据[道具id].开运孔数 = {当前=0,上限=0}
--   if self.数据[道具id].级别限制<=40 then
--     self.数据[道具id].开运孔数 = {当前=0,上限=2}
--   elseif self.数据[道具id].级别限制>40 and self.数据[道具id].级别限制<=80 then
--     self.数据[道具id].开运孔数 = {当前=0,上限=3}
--   elseif self.数据[道具id].级别限制>80 and self.数据[道具id].级别限制<=120 then
--     self.数据[道具id].开运孔数 = {当前=0,上限=4}
--   elseif self.数据[道具id].级别限制>120 and self.数据[道具id].级别限制<=160 then
--     self.数据[道具id].开运孔数 = {当前=0,上限=5}
--   elseif self.数据[道具id].级别限制>160 and self.数据[道具id].级别限制<=180 then
--     self.数据[道具id].开运孔数 = {当前=0,上限=6}
--   end
--   self.数据[道具id].符石={}
--   self.数据[道具id].星位={}
--   self.数据[道具id].符石组合 = {符石组合 = {},门派条件 ={},部位条件={},效果说明={}}
--   self.数据[道具id].熔炼效果={}
--   self.数据[道具id].识别码=取唯一识别码(id)
--   玩家数据[id].角色.数据.道具[临时格子]=道具id
--   if 返回 then
--     return self.数据[道具id].名称
--   else
--     发送数据(玩家数据[id].连接id,38,{内容="你得到了#R/"..self.数据[道具id].名称})
--   end
--   道具刷新(id)
-- end


function 道具处理类:取随机装备(id,等级,无级别)
  -- print(id,等级,返回)
  local 临时格子=玩家数据[id].角色:取道具格子()
  if 临时格子==0 then 常规提示(id,"#Y/你身上的空间不够，无法获得装备") return end
  local 临时等级=等级
  local 临时参数=取随机数(1,#书铁范围)
  local 临时序列=临时参数
  if 临时序列==25 then
    临时序列=23
  elseif 临时序列==24 then
    临时序列=22
  elseif 临时序列==23 or 临时序列==22 then
    临时序列=21
  elseif 临时序列==21 then
    临时序列=20
  elseif 临时序列==20 or 临时序列==19 then
    临时序列=19
  end

  if 临时序列<=18 and 临时等级>=9 then --是武器 10-12是普通光武
      if 临时等级<=11 then
          临时等级=取随机数(9,11)
      elseif 临时等级<=14 then
          临时等级=取随机数(12,14)
      end
      临时等级=临时等级+1
  else
      临时等级=临时等级+1
  end
  local 临时类型=玩家数据[id].装备.打造物品[临时序列][临时等级]
  if type(临时类型)=="table" then
    if 临时参数 ==23 then
     临时类型=临时类型[2]
    elseif 临时参数 ==22 then
     临时类型=临时类型[1]
    elseif 临时参数 ==20 then
     临时类型=临时类型[2]
    elseif 临时参数 ==19 then
     临时类型=临时类型[1]
    else
      临时类型=临时类型[取随机数(1,2)]
    end
  end

  local 道具id = 玩家数据[id].装备:生成指定装备(id,临时类型,等级*10,临时序列)
  if 无级别 then
      self.数据[道具id].特效="无级别限制"
  end
  玩家数据[id].角色.数据.道具[临时格子]=道具id
  发送数据(玩家数据[id].连接id,38,{内容="你得到了#R/"..self.数据[道具id].名称})
  道具刷新(id)
end




function 道具处理类:取随机装备1(id,等级,名称)
  local 临时格子=玩家数据[id].角色:取道具格子()
  if 临时格子==0 then return end
  local 道具 = 物品类()
  道具:置对象(名称)
  道具.级别限制 = 等级*10
  local 道具id=self:取新编号()
  self.数据[道具id]=道具
  self.数据[道具id].级别限制=等级*10
  self.数据[道具id].鉴定=false
  self.数据[道具id].识别码=取唯一识别码(id)
  玩家数据[id].角色.数据.道具[临时格子]=道具id
end





function 道具处理类:给予书铁(id,等级,类型)
  if 类型==nil then  --随机获取
    self.临时随机=取随机数()
    --   print(self.临时随机,11)
    if self.临时随机<=50 then
      self.书铁名称="制造指南书"
    else
      self.书铁名称="百炼精铁"
    end
    local 书铁等级=math.floor(取随机数(等级[1],等级[2]))
    local 书铁种类=取随机数(1,#书铁范围)
    书铁等级=书铁等级*10
    self:给予道具(id,self.书铁名称,书铁等级,书铁种类)
    return {self.书铁名称,书铁等级,书铁种类}
  elseif 类型=="指南书" or 类型 == 1 then
    self.书铁名称="制造指南书"
    local 书铁等级=math.floor(取随机数(等级[1],等级[2]))
    local 书铁种类=取随机数(1,#书铁范围)
    书铁等级=书铁等级*10
    self:给予道具(id,self.书铁名称,书铁等级,书铁种类)
    return {self.书铁名称,书铁等级,书铁种类}
  elseif 类型=="精铁" or 类型 == 2  then
    self.书铁名称="百炼精铁"
    local 书铁等级=math.floor(取随机数(等级[1],等级[2]))
    local 书铁种类=取随机数(1,#书铁范围)
    书铁等级=书铁等级*10
    self:给予道具(id,self.书铁名称,书铁等级,书铁种类)
    return {self.书铁名称,书铁等级,书铁种类}
  end
end

function 道具处理类:取武器子类(子类)
	local n = {"枪矛","斧钺","剑","双短剑","飘带","爪刺","扇","魔棒","锤","鞭","环圈","刀","法杖","弓弩","宝珠","巨剑","伞","灯笼","头盔","发钗","项链","女衣","男衣","腰带","鞋子"}
	return n[子类]
end

function 道具处理类:取武器类型(子类)
  local n = {"枪矛","斧钺","剑","双短剑","飘带","爪刺","扇","魔棒","锤","鞭","环圈","刀","法杖","弓弩","宝珠","巨剑","伞","灯笼","头盔","发钗","项链","女衣","男衣","腰带","鞋子"}
  for i=1,#n do
    if n[i]==子类 then
        return i
    end
  end
end





function 道具处理类:使用合成旗(连接id,id,序列)
         if not 序列 or 序列==0
            or not 玩家数据[id].道具操作
            or not 玩家数据[id].道具操作.类型
            or not 玩家数据[id].道具操作.编号
            or not 玩家数据[id].道具操作.id then
            玩家数据[id].最后操作 = nil
            return
          end
          if 玩家数据[id].道具操作.类型~="道具" then
              玩家数据[id].最后操作 = nil
              return
          end
          local 格子 = 玩家数据[id].道具操作.编号
          local 道具id = 玩家数据[id].道具操作.id
          if not 道具id or 道具id ==0 or not self.数据[道具id] or self.数据[道具id]==0 then
              玩家数据[id].最后操作 = nil
              return
          end
          if self.数据[道具id].总类~=11 or  self.数据[道具id].分类~=2 then
              玩家数据[id].最后操作 = nil
              常规提示(id,"#Y你没有这样的道具")
              return
          end
          if 玩家数据[id].角色.数据.道具[格子]~=道具id then
             玩家数据[id].最后操作 = nil
              return
          end
          if not self.数据[道具id].次数 then
              玩家数据[id].最后操作 = nil
              return
          end
          if not self.数据[道具id].地图
             or not self.数据[道具id].xy
             or not self.数据[道具id].xy[序列]
             or not self.数据[道具id].xy[序列].x
             or not self.数据[道具id].xy[序列].y then
              常规提示(id,"#Y错误的坐标选择点")
              return
          end
          if self:取飞行限制(id)==false and 玩家数据[id].最后操作=="合成旗" then
              self.数据[道具id].次数=self.数据[道具id].次数-1
              地图处理类:跳转地图(id,self.数据[道具id].地图,self.数据[道具id].xy[序列].x,self.数据[道具id].xy[序列].y)
              if self.数据[道具id].次数<=0 then
                  常规提示(id,format("#Y你的%s已经用完了",self.数据[道具id].名称))
                  self.数据[道具id]=nil
                  玩家数据[id].角色.数据.道具[格子] = nil
              else
                  常规提示(id,format("#Y你的%s还可以使用%s次",self.数据[道具id].名称,self.数据[道具id].次数))
              end
              道具刷新(id)

          end
          玩家数据[id].最后操作 = nil
end

function 道具处理类:飞行符传送(连接id,id,内容)
    if not 玩家数据[id].道具操作
      or not 玩家数据[id].道具操作.类型
      or not 玩家数据[id].道具操作.编号
      or not 玩家数据[id].道具操作.id then
      玩家数据[id].最后操作 = nil
      return
    end
    if 玩家数据[id].道具操作.类型~="道具" then
        玩家数据[id].最后操作 = nil
        return
    end
    local 格子 = 玩家数据[id].道具操作.编号
    local 道具id = 玩家数据[id].道具操作.id
    if not 道具id or 道具id ==0 or not self.数据[道具id] or self.数据[道具id]==0 then
        玩家数据[id].最后操作 = nil
      return
    end
    if 玩家数据[id].角色.数据.道具[格子]~=道具id then
       玩家数据[id].最后操作 = nil
        return
    end
    if not self.数据[道具id].数量 then
        玩家数据[id].最后操作 = nil
        return
    end
    if self:取飞行限制(id)==false and 玩家数据[id].最后操作=="飞行符" then
            self.数据[道具id].数量= self.数据[道具id].数量 - 1
            if self.数据[道具id].数量 <=0 then
                 self.数据[道具id]=nil
                 玩家数据[id].角色.数据.道具[格子]=nil
            end
            道具刷新(id)
            local 序列=内容.序列
            if not 飞行符传送[序列] then return end
            地图处理类:跳转地图(id,飞行符传送[序列][1],飞行符传送[序列][2],飞行符传送[序列][3])
    end
    玩家数据[id].最后操作 = nil
end

function 道具处理类:取加血道具(名称)
  local 临时名称={"包子","烤鸭","翡翠豆腐","烤肉","臭豆腐","金创药","小还丹","千年保心丹","金香玉","包子","天不老","紫石英","血色茶花","熊胆","鹿茸","六道轮回","凤凰尾","硫磺草","龙之心屑","火凤之睛","四叶花","天青地白","七叶莲","人参","山药","八角莲叶"}
  for n=1,#临时名称 do
    if 临时名称[n]==名称 then
      return true
    end
  end
  return false
end

function 道具处理类:取寿命道具(名称)
  local 临时名称={"桂花丸","长寿面","豆斋果"}
  for n=1,#临时名称 do
    if 临时名称[n]==名称 then
      return true
    end
  end
  return false
end

function 道具处理类:取寿命道具1(名称,道具id)
  local 品质=self.数据[道具id].阶品
  local 数值=0
  local 中毒=0
  if 名称=="桂花丸" then
    数值=品质*0.5
  elseif 名称=="豆斋果" then
    数值=品质*3
    中毒=3
  elseif 名称=="长寿面" then
    数值=品质*2+50
    中毒=3
  end
  return {数值=qz(数值),中毒=中毒}
end

function 道具处理类:取加魔道具(名称)
  local 临时名称={"翡翠豆腐","佛跳墙","蛇蝎美人","风水混元丹","定神香","十香返生丸","丁香水","月星子","仙狐涎","地狱灵芝","麝香","血珊瑚","餐风饮露","白露为霜","天龙水","孔雀红","紫丹罗","佛手","旋复花","龙须草","百色花","香叶","白玉骨头","鬼切草","灵脂","曼陀罗花"}
  for n=1,#临时名称 do
    if 临时名称[n]==名称 then
      return true
    end
  end
  return false
end

function 道具处理类:取加血道具1(名称,道具id)
  local 品质=self.数据[道具id].阶品
  local 数值=0
  if 名称=="包子" then
   数值=100
  elseif 名称=="烤鸭" then
   数值=品质*10+100
  elseif 名称=="烤肉" then
   数值=品质*10
  elseif 名称=="臭豆腐" then
   数值=品质*20+200
  elseif 名称=="翡翠豆腐" then
   数值=品质*15+150
  elseif 名称=="金创药" then
   数值=400
  elseif 名称=="小还丹" then
   数值=品质*8+100
  elseif 名称=="金香玉" then
   数值=品质*12+150
  elseif 名称=="千年保心丹" then
   数值=品质*4+200
  elseif 名称=="五龙丹" then
   数值=品质*3
  elseif 名称=="佛光舍利子" then
   数值=300
  elseif 名称=="九转回魂丹" then
   数值=品质*5+100
  elseif 名称=="天不老" or 名称=="紫石英" then
   数值=100
  elseif 名称=="血色茶花" or 名称=="鹿茸" then
   数值= 150
  elseif 名称=="六道轮回" or 名称=="熊胆" then
   数值= 200
  elseif 名称=="凤凰尾" or 名称=="硫磺草" then
   数值= 250
  elseif 名称=="龙之心屑" or 名称=="火凤之睛" then
   数值= 300
  elseif 名称=="四叶花" then
   数值= 40
  elseif 名称=="天青地白" then
   数值= 80
  elseif 名称=="七叶莲" then
   数值= 60
  elseif 名称=="人参" then
  数值= 80
  elseif 名称=="山药" then
  数值= 40
  elseif 名称=="八角莲叶" then
  数值= 60
  end
  return qz(数值)
end

function 道具处理类:取加伤道具1(名称,道具id)
  local 品质=self.数据[道具id].阶品
  local 数值=0
  if 名称=="水黄莲" then
   数值=20
  elseif 名称=="草果" then
   数值=10
     elseif 名称=="九香虫" then
   数值=15
     elseif 名称=="人参" then
   数值=20
     elseif 名称=="山药" then
   数值=10
     elseif 名称=="八角莲叶" then
   数值=15
     elseif 名称=="小还丹" then
   数值=品质+80
     elseif 名称=="千年保心丹" then
   数值=品质*4+100
     elseif 名称=="九转回魂丹" then
   数值=品质*5+100
     elseif 名称=="佛光舍利子" then
   数值=品质*3
  end
  return qz(数值)
end

function 道具处理类:取加魔道具1(名称,道具id)
  local 品质=self.数据[道具id].阶品
  local 数值=0
  if 名称=="佛跳墙" or 名称=="翡翠豆腐" then
   数值=品质*10+100
  elseif 名称=="定神香"  then
   数值=品质*5+50
  elseif 名称=="风水混元丹"  then
   数值=品质*3+50
  elseif 名称=="蛇蝎美人"  then
   数值=品质*5+100
  elseif 名称=="十香返生丸"  then
   数值=品质*3+50
  elseif 名称=="女儿红" or 名称=="虎骨酒"  then
   数值=20
  elseif 名称=="珍露酒"  then
   数值=品质*0.4+10
  elseif 名称=="梅花酒"  then
   数值=品质*0.6
  elseif 名称=="百味酒"  then
   数值=品质*0.7
  elseif 名称=="蛇胆酒"  then
   数值=品质*1
  elseif 名称=="醉生梦死"  then
   数值=品质*1
  elseif 名称=="丁香水" or 名称=="月星子"  then
   数值=75
  elseif 名称=="仙狐涎" or 名称=="地狱灵芝" or 名称=="麝香" or 名称=="血珊瑚" or 名称=="餐风饮露" or 名称=="白露为霜"  then
   数值=100
  elseif 名称=="天龙水" or 名称=="孔雀红"  then
   数值=150
  elseif 名称=="紫丹罗" or 名称=="佛手" or 名称=="旋复花"     then
   数值=20
  elseif 名称=="龙须草" or 名称=="百色花" or 名称=="香叶"  then
   数值=30
  elseif 名称=="白玉骨头" or 名称=="鬼切草" or 名称=="灵脂"  then
   数值=40
  elseif 名称=="曼陀罗花"  then
   数值=50
  end
  return qz(数值)
end

function 道具处理类:清空包裹(连接id,id,多角色)
  for k,v in pairs(玩家数据[id].角色.数据.道具) do
      if self.数据[v] and self.数据[v].名称 ~= "帮派银票" and not string.find(self.数据[v].名称,"会员卡") and  not self.数据[v].加锁 then
          self.数据[v]=nil
          玩家数据[id].角色.数据.道具[k]=nil
      end
  end
  道具刷新(id,多角色)
end







function 道具处理类:升级强化技能(id,技能)
  if 玩家数据[id].角色.数据.强化技能 ==nil then
    return false
  end
  local 技能编号 = 0
  for i=1,#玩家数据[id].角色.数据.强化技能 do
    if 玩家数据[id].角色.数据.强化技能[i].名称 == 技能 then
       技能编号 = i
    end
  end

  if 技能编号~= 0 then
     if 玩家数据[id].角色.数据.强化技能[技能编号].等级>=180 then
        玩家数据[id].角色.数据.强化技能[技能编号].等级=180
        常规提示(id,"技能已达到上限")
        return false
    end
    玩家数据[id].角色.数据.强化技能[技能编号].等级= 玩家数据[id].角色.数据.强化技能[技能编号].等级+1
    发送数据(玩家数据[id].连接id,34.1,{序列=技能编号,等级=玩家数据[id].角色.数据.强化技能[技能编号].等级})
    玩家数据[id].角色:刷新信息()
    发送数据(玩家数据[id].连接id,31,玩家数据[id].角色:取总数据())
     常规提示(id,"#Y/你的#R/"..玩家数据[id].角色.数据.强化技能[技能编号].名称.."#Y/提升了一级")
    return true
  else
      常规提示(id,"你没有这样的技能")
      return false
  end


end





function 道具处理类:使用道具(连接id,id,内容)
  玩家数据[id].自选礼包数据=nil
  玩家数据[id].内丹自选礼包=nil
  玩家数据[id].神兽自选礼包=nil
  if not 共享货币[玩家数据[id].账号] then
      常规提示(id,"数据错误")
     return
  end
  local 包裹类型=内容.类型
  local 道具格子=内容.编号
  local 删除数量=1
  local 加血对象=0
  if 内容.窗口=="召唤兽" then
    if 玩家数据[id].召唤兽.数据[内容.序列]==nil then
      常规提示(id,"该召唤兽不存在")
      return
    else
      加血对象=内容.序列
    end
  end
  if 包裹类型~="道具" then
    -- if 包裹类型=="法宝" then
    --   self:佩戴法宝(连接id,id,包裹类型,道具格子)
    --   return
    -- end
    常规提示(id,"只有道具栏的物品才可以使用")
    return
  elseif 道具格子==nil then
    return
  end
  local 道具id=玩家数据[id].角色.数据[包裹类型][道具格子]
  if 道具id==nil or 道具id==0 or self.数据[道具id]==nil then
      玩家数据[id].角色.数据[包裹类型][道具格子]=nil
      道具刷新(id)
      return
  elseif self.数据[道具id].数量 and self.数据[道具id].数量<1 then
      self.数据[道具id]=nil
      玩家数据[id].角色.数据[包裹类型][道具格子]=nil
      道具刷新(id)
      return
  elseif self.数据[道具id].数量 and self.数据[道具id].数量>999 then
      self.数据[道具id]=nil
      玩家数据[id].角色.数据[包裹类型][道具格子]=nil
      道具刷新(id)
      return
   elseif self.数据[道具id].数量 and (not tonumber(self.数据[道具id].数量)
        or self.数据[道具id].数量~=math.floor(self.数据[道具id].数量)
        or isNaN(tonumber(self.数据[道具id].数量))) then
      self.数据[道具id]=nil
      玩家数据[id].角色.数据[包裹类型][道具格子]=nil
      道具刷新(id)
      return
  elseif not self.数据[道具id].识别码 or not string.find(self.数据[道具id].识别码,玩家数据[id].角色.数据.数字id) then
       self.数据[道具id]=nil
       玩家数据[id].角色.数据[包裹类型][道具格子]=nil
       道具刷新(id)
      return
  end
  local 名称=self.数据[道具id].名称
  local 道具使用=false
  if self:取加血道具(名称) then
      if 加血对象==0 and 玩家数据[id].角色.数据.气血>=玩家数据[id].角色.数据.气血上限 and 玩家数据[id].角色.数据.气血上限>=玩家数据[id].角色.数据.最大气血 then
         常规提示(id,"您的气血已满，无法使用该物品")
         return
      elseif 加血对象~=0 and 玩家数据[id].召唤兽.数据[加血对象].气血>=玩家数据[id].召唤兽.数据[加血对象].最大气血 then
          常规提示(id,"您的这只召唤兽气血已满，无法使用该物品")
          return
      end
      道具使用=true
      local 加血数值=self:取加血道具1(名称,道具id)
      local 加伤数值=self:取加伤道具1(名称,道具id)
      local 加魔数值=self:取加魔道具1(名称,道具id)
      if 名称=="翡翠豆腐" then
          self:加血处理(连接id,id,加血数值,加血对象)
          self:加魔处理(连接id,id,加魔数值,加血对象)
      elseif 名称=="草果" or 名称=="九香虫" or 名称=="水黄莲" then
          self:加伤势处理(连接id,id,加伤数值,加血对象)
  	  elseif 名称=="小还丹" or 名称=="千年保心丹" or 名称=="九转回魂丹" or 名称=="佛光舍利子" or 名称=="山药" or 名称=="八角莲叶" or 名称=="人参" or 名称=="草果" or 名称=="九香虫" or 名称=="水黄莲" then
      	  --伤势需要在加血前面
      	  self:加伤势处理(连接id,id,加伤数值,加血对象)
      	  self:加血处理(连接id,id,加血数值,加血对象)
      else
          self:加血处理(连接id,id,加血数值,加血对象)
      end
  elseif self:取加魔道具(名称) then
          if 加血对象==0 and 玩家数据[id].角色.数据.魔法>=玩家数据[id].角色.数据.最大魔法  then
           常规提示(id,"您的魔法已满，无法使用该物品")
           return
          elseif 加血对象~=0 and 玩家数据[id].召唤兽.数据[加血对象].魔法>=玩家数据[id].召唤兽.数据[加血对象].最大魔法 then
            常规提示(id,"您的这只召唤兽魔法已满，无法使用该物品")
            return
          end
          道具使用=true
          local 加血数值=self:取加血道具1(名称,道具id)
          local 加魔数值=self:取加魔道具1(名称,道具id)
          if 名称=="翡翠豆腐" then
              self:加血处理(连接id,id,加血数值,加血对象)
              self:加魔处理(连接id,id,加魔数值,加血对象)
          else
              self:加魔处理(连接id,id,加魔数值,加血对象)
          end
  elseif self:取寿命道具(名称) then
          if 加血对象==0 then
              常规提示(id,"该物品只能对召唤兽使用")
              return
          elseif 玩家数据[id].召唤兽.数据[加血对象].神兽 then
              常规提示(id,"神兽无法使用此物品")
              return
          else
              local 加血数值=self:取寿命道具1(名称,道具id)
              玩家数据[id].召唤兽:加寿命处理(加血对象,加血数值.数值,加血数值.中毒,连接id,id)
              道具使用=true
          end
  elseif  名称=="红玛瑙" or 名称=="太阳石" or 名称=="月亮石" or 名称=="舍利子" or 名称=="黑宝石" or 名称=="光芒石" or 名称=="神秘石" then
        self:自动合成宝石(id,名称,道具id,包裹类型,内容.编号)
        return
  elseif  名称=="进化丹" or 名称=="魔化丹" or 名称=="造灵丹" or 名称=="觉醒丹" then
        常规提示(id,"请打开召唤兽属性页面使用"..名称)
        return
  elseif 名称=="星辉石" then
        self:自动合成星辉石(id,名称,道具id,包裹类型,内容.编号)
        return
  elseif 名称=="钟灵石" then
        self:自动合成钟灵石(id,名称,道具id,包裹类型,内容.编号)
        return

  elseif 名称=="精魄灵石" then
        self:自动合成精魄灵石(id,名称,道具id,包裹类型,内容.编号)
        return

  elseif 名称=="鬼谷子" then  --
    if 玩家数据[id].角色.数据.阵法[self.数据[道具id].子类]==nil then
     玩家数据[id].角色.数据.阵法[self.数据[道具id].子类]=1
     常规提示(id,"恭喜你学会了如何使用#R/"..self.数据[道具id].子类)
     道具使用=true
    else
     常规提示(id,"你已经学过如何使用这个阵型了，请勿重复学习")
     return
    end
-- 在道具处理类中修正八卦阵书的使用
elseif 名称 == "八卦阵书" then
  if not 玩家数据[id].角色.数据.高级阵法 or not 玩家数据[id].角色.数据.高级阵法.八卦阵 then
      -- 根据高级阵法配置初始化八卦阵数据，保持与配置格式一致
      if not 玩家数据[id].角色.数据.高级阵法 then
          玩家数据[id].角色.数据.高级阵法 = {}
      end
      
      -- 初始化八卦阵数据，使用默认配置
      玩家数据[id].角色.数据.高级阵法.八卦阵 = {
          [1] = {类型 = "等级", 数值 = 1},
          [2] = {类型 = "伤害", 数值 = 15},
          [3] = {类型 = "法伤", 数值 = 15},
          [4] = {类型 = "固伤", 数值 = 15},
          [5] = {类型 = "召唤兽伤害", 数值 = 15},
          [6] = {类型 = "防御", 数值 = 15},
          [7] = {类型 = "法防", 数值 = 15},
          [8] = {类型 = "速度", 数值 = 15}
      }
      
      -- 同时存入到普通阵法列表中，确保系统能识别
      if not 玩家数据[id].角色.数据.阵法 then
          玩家数据[id].角色.数据.阵法 = {}
      end
      玩家数据[id].角色.数据.阵法.八卦阵 = 1
      
      常规提示(id, "#Y/恭喜你学会了最强阵法#G/八卦阵#Y/！")
      道具使用 = true
  else
      常规提示(id, "你早已学会八卦阵")
      return
  end
  -- 阵眼道具处理
  elseif 名称 == "天阵眼" then
      if not 玩家数据[id].角色.数据.高级阵法 or not 玩家数据[id].角色.数据.高级阵法.八卦阵 then
          常规提示(id, "你尚未学会八卦阵，无法使用阵眼")
          return
      end
      local 成功, 消息 = 玩家数据[id].角色:高级阵法升级处理(连接id, id, "八卦阵", "伤害", 1)
      if 成功 then
          常规提示(id, 消息)
          道具使用 = true
      else
          常规提示(id, 消息)
          return
      end
  elseif 名称 == "地阵眼" then
      if not 玩家数据[id].角色.数据.高级阵法 or not 玩家数据[id].角色.数据.高级阵法.八卦阵 then
          常规提示(id, "你尚未学会八卦阵，无法使用阵眼")
          return
      end
      local 成功, 消息 = 玩家数据[id].角色:高级阵法升级处理(连接id, id, "八卦阵", "防御", 1)
      if 成功 then
          常规提示(id, 消息)
          道具使用 = true
      else
          常规提示(id, 消息)
          return
      end
  elseif 名称 == "风阵眼" then
      if not 玩家数据[id].角色.数据.高级阵法 or not 玩家数据[id].角色.数据.高级阵法.八卦阵 then
          常规提示(id, "你尚未学会八卦阵，无法使用阵眼")
          return
      end
      local 成功, 消息 = 玩家数据[id].角色:高级阵法升级处理(连接id, id, "八卦阵", "速度", 1)
      if 成功 then
          常规提示(id, 消息)
          道具使用 = true
      else
          常规提示(id, 消息)
          return
      end
  elseif 名称 == "云阵眼" then
      if not 玩家数据[id].角色.数据.高级阵法 or not 玩家数据[id].角色.数据.高级阵法.八卦阵 then
          常规提示(id, "你尚未学会八卦阵，无法使用阵眼")
          return
      end
      local 成功, 消息 = 玩家数据[id].角色:高级阵法升级处理(连接id, id, "八卦阵", "法伤", 1)
      if 成功 then
          常规提示(id, 消息)
          道具使用 = true
      else
          常规提示(id, 消息)
          return
      end
  elseif 名称 == "雷阵眼" then
      if not 玩家数据[id].角色.数据.高级阵法 or not 玩家数据[id].角色.数据.高级阵法.八卦阵 then
          常规提示(id, "你尚未学会八卦阵，无法使用阵眼")
          return
      end
      -- 雷阵眼可以升级固伤或召唤兽伤害，这里默认升级固伤
      local 成功, 消息 = 玩家数据[id].角色:高级阵法升级处理(连接id, id, "八卦阵", "固伤", 1)
      if 成功 then
          常规提示(id, 消息)
          道具使用 = true
      else
          常规提示(id, 消息)
          return
      end
  elseif self.数据[道具id].总类==11 and self.数据[道具id].分类==2 then  --合成旗
    发送数据(玩家数据[id].连接id,3529,{地图=self.数据[道具id].地图,xy=self.数据[道具id].xy})
    玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
    玩家数据[id].最后操作="合成旗"
    return
  elseif 名称=="摄妖香" then  --
    if 玩家数据[id].角色:取任务(9)~=0 then
      玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(9))
    end
    任务处理类:添加摄妖香(id)
    常规提示(id,"#Y/你使用了摄妖香")
    道具使用=true
  elseif 名称=="传音纸鹤" then  --
    玩家数据[id].角色.数据.传音纸鹤=玩家数据[id].角色.数据.传音纸鹤+1
    常规提示(id,"#Y/你增加了一次纸鹤发言次数。")
    道具使用=true

 elseif 名称=="双倍掉宝符" then
        if 玩家数据[id].角色:取任务(7757)~=nil and 任务数据[玩家数据[id].角色:取任务(7757)]~=nil then
          任务数据[玩家数据[id].角色:取任务(7757)].结束=任务数据[玩家数据[id].角色:取任务(7757)].结束+3600
          玩家数据[id].角色:刷新任务跟踪()
        else
            任务处理类:添加双倍银子(id)
        end
        if 玩家数据[id].角色.数据.多角色操作 and 玩家数据[id].队伍 and 玩家数据[id].队伍~=0 then
              for i=2,#队伍数据[玩家数据[id].队伍].成员数据 do
                    local 临时id = 队伍数据[玩家数据[id].队伍].成员数据[i]
                    if 玩家数据[临时id] and 玩家数据[临时id].子角色操作 and 玩家数据[临时id].子角色操作==id  then
                        if 玩家数据[临时id].道具:消耗背包道具(临时id,名称,1) then
                            if 玩家数据[临时id].角色:取任务(7757)~=nil and 任务数据[玩家数据[临时id].角色:取任务(7757)]~=nil then
                                任务数据[玩家数据[临时id].角色:取任务(7757)].结束=任务数据[玩家数据[临时id].角色:取任务(7757)].结束+3600
                            else
                                   任务处理类:添加双倍银子(临时id)
                            end
                        else
                            常规提示(id,"#Y/未找到#R"..玩家数据[临时id].角色.数据.名称.."#Y的"..名称)
                        end
                    end
              end
        end
        常规提示(id,"#Y/你使用了双倍掉宝符")
        道具使用=true
 elseif 名称=="2倍经验丹" then
    if 玩家数据[id].角色:取任务(2)~=0 then
        常规提示(id,"#Y/你有#G双倍时间#R不能重复使用该物品")
    else
        if 玩家数据[id].角色:取任务(7755)~=nil and 任务数据[玩家数据[id].角色:取任务(7755)]~=nil then
          任务数据[玩家数据[id].角色:取任务(7755)].结束=任务数据[玩家数据[id].角色:取任务(7755)].结束+3600
          玩家数据[id].角色:刷新任务跟踪()
        else
            任务处理类:添加一倍经验(id)
        end
        if 玩家数据[id].角色.数据.多角色操作 and 玩家数据[id].队伍 and 玩家数据[id].队伍~=0 then
              for i=2,#队伍数据[玩家数据[id].队伍].成员数据 do
                    local 临时id = 队伍数据[玩家数据[id].队伍].成员数据[i]
                    if 玩家数据[临时id] and 玩家数据[临时id].子角色操作 and 玩家数据[临时id].子角色操作==id then
                        if 玩家数据[临时id].角色:取任务(2)~=0 then
                            常规提示(id,"#Y/玩家#R"..玩家数据[临时id].角色.数据.名称.."#Y有双倍时间#R不能重复使用该物品")
                        else
                            if 玩家数据[临时id].道具:消耗背包道具(临时id,名称,1) then
                                if 玩家数据[临时id].角色:取任务(7755)~=nil and 任务数据[玩家数据[临时id].角色:取任务(7755)]~=nil then
                                    任务数据[玩家数据[临时id].角色:取任务(7755)].结束=任务数据[玩家数据[临时id].角色:取任务(7755)].结束+3600
                                else
                                       任务处理类:添加一倍经验(临时id)
                                end
                            else
                                常规提示(id,"#Y/未找到#R"..玩家数据[临时id].角色.数据.名称.."#Y的"..名称)
                            end
                        end
                    end
              end
        end
        常规提示(id,"#Y/你使用了2倍经验丹")
        道具使用=true
  end
  elseif 名称=="3倍经验丹" then
    if 玩家数据[id].角色:取任务(3)~=0 then
        常规提示(id,"#Y/你有#G精练时间#R不能重复使用该物品")
    else
        if 玩家数据[id].角色:取任务(7756)~=nil and 任务数据[玩家数据[id].角色:取任务(7756)]~=nil then
          任务数据[玩家数据[id].角色:取任务(7756)].结束=任务数据[玩家数据[id].角色:取任务(7756)].结束+3600
          玩家数据[id].角色:刷新任务跟踪()
        else
            任务处理类:添加双倍经验(id)
        end
        if 玩家数据[id].角色.数据.多角色操作 and 玩家数据[id].队伍 and 玩家数据[id].队伍~=0 then
              for i=2,#队伍数据[玩家数据[id].队伍].成员数据 do
                    local 临时id = 队伍数据[玩家数据[id].队伍].成员数据[i]
                    if 玩家数据[临时id] and 玩家数据[临时id].子角色操作 and 玩家数据[临时id].子角色操作==id then
                          if 玩家数据[临时id].角色:取任务(3)~=0 then
                              常规提示(id,"#Y/玩家#R"..玩家数据[临时id].角色.数据.名称.."#Y有精练时间#R不能重复使用该物品")
                          else
                              if 玩家数据[临时id].道具:消耗背包道具(临时id,名称,1) then
                                  if 玩家数据[临时id].角色:取任务(7756)~=nil and 任务数据[玩家数据[临时id].角色:取任务(7756)]~=nil then
                                      任务数据[玩家数据[临时id].角色:取任务(7756)].结束=任务数据[玩家数据[临时id].角色:取任务(7756)].结束+3600
                                  else
                                         任务处理类:添加双倍经验(临时id)
                                  end
                              else
                                  常规提示(id,"#Y/未找到#R"..玩家数据[临时id].角色.数据.名称.."#Y的"..名称)
                              end
                          end
                    end
              end
        end
        常规提示(id,"#Y/你使用了3倍经验丹")
        道具使用=true
    end
  elseif 名称=="洞冥草" then
    if 玩家数据[id].角色:取任务(9)~=0 then
      玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(9))
      常规提示(id,"#Y/你解除了摄妖香的效果")
      道具使用=true
    end
 elseif 名称=="功德录" then
      玩家数据[id].角色.数据.功德录.激活=true
      常规提示(id,"#Y恭喜少侠开启功德录。")
      道具使用=true
  elseif 名称=="三界悬赏令" then
    if 玩家数据[id].角色:取任务(209)~=0 then
      常规提示(id,"#Y/你已经有个悬赏任务在进行了")
    else
      任务处理类:添加三界悬赏任务(id)
      常规提示(id,"#Y/你获得了三界悬赏任务")
      道具使用=true
    end
  elseif 名称=="贼王的线索" then
    if 玩家数据[id].角色:取任务(350)~=0 then
      常规提示(id,"#Y/你已经有个贼王任务在进行了")
    else
      任务处理类:添加贼王的线索任务(id)
      常规提示(id,"#Y/你获得了贼王的线索任务")
      道具使用=true
    end
  elseif 名称=="摇钱树苗" then
    if 玩家数据[id].角色:取任务(22)~=0 then
      常规提示(id,"#Y/你之前已经种下一棵摇钱树苗了")
    elseif 地图处理类.遇怪地图[玩家数据[id].角色.数据.地图数据.编号]==nil  then
      常规提示(id,"#Y/本场景无法种植树苗")
    else
      local x=玩家数据[id].角色.数据.地图数据.x
      local y=玩家数据[id].角色.数据.地图数据.y
      local 通过=true
      for n, v in pairs(任务数据) do
        if 任务数据[n].类型==22 then
          if 取两点距离({x=任务数据[n].x,y=任务数据[n].y},{x=x,y=y})<=200 then
            通过=false
          end
        end
      end
      if 通过==false then
        常规提示(id,"#Y/这个区域已经有一颗摇钱树了，请换个地方再试试")
      else
        任务处理类:添加摇钱树任务(id)
        常规提示(id,"#Y/你种下了一颗摇钱树")
        道具使用=true
      end
    end

  -- elseif 名称=="仙玉锦囊" then
  --   添加仙玉(100,id,"使用仙玉锦囊")
  --   self.数据[道具id].可叠加=true
  --   道具使用=true
elseif 名称 == "长安战报" then
     长安保卫战:获取玩家数据(id)
     return
elseif string.find(名称, "点仙玉") then
        local 取出=分割文本(名称,"点")
        if 取出 and 取出[1] and tonumber(取出[1]) then
            共享货币[玩家数据[id].账号]:添加仙玉(tonumber(取出[1]),id,"使用道具")
            道具使用=true
        end
elseif string.find(名称, "点卡") then
        local 取出=分割文本(名称,"点卡")
        if 取出 and 取出[1] and tonumber(取出[1]) then
            共享货币[玩家数据[id].账号]:添加点卡(tonumber(取出[1]),id,"使用道具")
            道具使用=true
        end


elseif 名称 == "随机强化丹" then
  local 强化技能 = {"人物伤害","人物防御","人物气血","人物法术","人物速度","人物固伤","人物治疗","宠物伤害","宠物防御","宠物气血","宠物灵力","宠物速度"}
  if self:升级强化技能(id,强化技能[取随机数(1,#强化技能)]) then
     道具使用=true
  end
 elseif 名称 == "强化升级丹" then
   if self:升级强化技能(id,self.数据[道具id].阶品) then
      道具使用=true
   end


elseif  名称=="金刚石" or 名称=="定魂珠" or 名称=="夜光珠" or 名称=="避水珠" or 名称=="龙鳞" then
      if 包裹类型~="道具" then
         常规提示(id,"#Y/只有在背包中才可以使用")
        return
      end
      local 寻找格子={}
      for n,v in pairs(玩家数据[id].角色.数据.道具) do
          if n~=nil and self.数据[v]~=nil then
            local 寻找名称=self.数据[v].名称
            if 寻找名称=="龙鳞" then
              寻找格子[#寻找格子+1]=v
            elseif 寻找名称=="避水珠" then
              寻找格子[#寻找格子+1]=v
            elseif 寻找名称=="定魂珠" then
              寻找格子[#寻找格子+1]=v
            elseif 寻找名称=="夜光珠" then
              寻找格子[#寻找格子+1]=v
            elseif 寻找名称=="金刚石" then
              寻找格子[#寻找格子+1]=v
            end
          end
        end
        if #寻找格子<5 then
          常规提示(id,"合成高级藏宝图需要金刚石,定魂珠,夜光珠,避水珠,龙鳞缺一不可")
        else
          for n=1,#寻找格子 do
                 self.数据[寻找格子[n]].数量=self.数据[寻找格子[n]].数量 - 1
                if self.数据[寻找格子[n]].数量 <=0 then
                  self.数据[寻找格子[n]]=nil
              end
          end
          self:给予道具(id,"高级藏宝图")
          常规提示(id,"#Y/你获得了#R/高级藏宝图")
          道具刷新(id)
       end
  return


  elseif 名称=="特赦令牌" then
    local 名称="高级藏宝图"
    玩家数据[id].道具:给予道具(id,"高级藏宝图")
    常规提示(id,"你兑换了："..名称)
    self.数据[道具id].可叠加=true
    道具使用=true
  elseif 名称=="秘制红罗羹" then
    if 玩家数据[id].角色:取任务(10)~=0 then
      --玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(9))
      local 任务id=玩家数据[id].角色:取任务(10)
      任务数据[任务id].气血=任务数据[任务id].气血+100
      常规提示(id,"#Y/你使用了秘制红罗羹")
      道具使用=true
      玩家数据[id].角色:刷新任务跟踪()
    else
      任务处理类:添加罗羹(id,100,0)
      常规提示(id,"#Y/你使用了秘制红罗羹")
      道具使用=true
    end
 elseif 名称=="秘制绿罗羹" then  --
    if 玩家数据[id].角色:取任务(10)~=0 then
      --玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(9))
      local 任务id=玩家数据[id].角色:取任务(10)
      任务数据[任务id].魔法=任务数据[任务id].魔法+100
      常规提示(id,"#Y/你使用了秘制绿罗羹")
      道具使用=true
      玩家数据[id].角色:刷新任务跟踪()
    else
      任务处理类:添加罗羹(id,0,100)
      常规提示(id,"#Y/你使用了秘制绿罗羹")
      道具使用=true
    end
   elseif 名称=="超级红罗羹" then
    if 玩家数据[id].角色:取任务(10)~=0 then
      --玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(9))
      local 任务id=玩家数据[id].角色:取任务(10)
      任务数据[任务id].气血=任务数据[任务id].气血+2000
      常规提示(id,"#Y/你使用了超级红罗羹")
      道具使用=true
      玩家数据[id].角色:刷新任务跟踪()
    else
      任务处理类:添加罗羹(id,2000,0)
      常规提示(id,"#Y/你使用了超级红罗羹")
      道具使用=true
    end
 elseif 名称=="超级绿罗羹" then  --
    if 玩家数据[id].角色:取任务(10)~=0 then
      --玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(9))
      local 任务id=玩家数据[id].角色:取任务(10)
      任务数据[任务id].魔法=任务数据[任务id].魔法+2000
      常规提示(id,"#Y/你使用了超级绿罗羹")
      道具使用=true
      玩家数据[id].角色:刷新任务跟踪()
    else
      任务处理类:添加罗羹(id,0,2000)
      常规提示(id,"#Y/你使用了超级绿罗羹")
      道具使用=true
    end

  elseif 名称=="白色导标旗" or 名称=="黄色导标旗" or 名称=="蓝色导标旗" or 名称=="绿色导标旗" or 名称=="红色导标旗"  then
    if self.数据[道具id].地图==nil then --定标
      local 地图=玩家数据[id].角色.数据.地图数据.编号
      if 地图~=1001 and 地图~=1070 and 地图~=1208 and 地图~=1092 then
        常规提示(id,"只有长安城、长寿村、傲来国、朱紫国这四个城市才可以定标哟！")
        return
      end
      local 等级=玩家数据[id].角色:取剧情技能等级("奇门遁甲")
      if 地图==1070 and 等级<1 then
        常规提示(id,"本场景定标需要您的奇门遁甲技能等级达到1级")
        return
      elseif 地图==1092 and 等级<2 then
        常规提示(id,"本场景定标需要您的奇门遁甲技能等级达到2级")
        return
      elseif 地图==1001 and 等级<1 then
        常规提示(id,"本场景定标需要您的奇门遁甲技能等级达到3级")
        return
      elseif 地图==1208 and 等级<2 then
        常规提示(id,"本场景定标需要您的奇门遁甲技能等级达到4级")
        return
      end
      self.数据[道具id].地图=玩家数据[id].角色.数据.地图数据.编号
      self.数据[道具id].x=math.floor(玩家数据[id].角色.数据.地图数据.x/20)
      self.数据[道具id].y=math.floor(玩家数据[id].角色.数据.地图数据.y/20)
      self.数据[道具id].次数=20
      道具刷新(id)
      常规提示(id,"定标成功！")
      return
    else
      发送数据(玩家数据[id].连接id,1501,{选项={"请送我过去","我再想想"},对话=format("请确认是否要传送至#G/%s(%s,%s)#W/处",取地图名称(self.数据[道具id].地图),self.数据[道具id].x,self.数据[道具id].y)})
      玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
      玩家数据[id].最后操作="导标旗"
      return
    end


  elseif string.find(名称, "会员卡")~=nil then
      if self.数据[道具id].限时 and os.time()>= self.数据[道具id].限时 then
           if 玩家数据[id].角色.数据.月卡==nil then
              玩家数据[id].角色.数据.月卡={购买时间=0,到期时间=0,当前领取=0,开通=false}
           end
           玩家数据[id].角色.数据.月卡.开通=false
           添加最后对话(id,"道具体验时间已到期,系统自动回收。")
           道具使用=true
       else
             if not 玩家数据[id].角色.数据.月卡.开通 then
                  玩家数据[id].角色.数据.月卡.到期时间 = os.time()+86400
                  玩家数据[id].角色.数据.月卡.购买时间=os.time()
                  玩家数据[id].角色.数据.月卡.开通=true
             end
             local  对话内容 = "尊贵的会员玩家，你可以每天在我这边领取一次福利，达到相应等级也可以获取相应福利!#Y每日领取福利:(#R"..自定义数据.月卡数据.显示物品.."#Y/)。自动抓鬼剩余次数: #G[#P"..玩家数据[id].角色.数据.自动抓鬼.."#G]"
             local  对话选项 ={"领取每日福利","领取等级福利","打开随身仓库","打开共享仓库","场景传送","超级传送",
                                "自动抓鬼","自动鬼王","靓号设置","门派转换","转换装备","转换武器","八卦炼丹",
                                "送我回家","送我回帮","会员地图","一键附魔","一键回收","我再想想"
                              }

             local 对话模型=玩家数据[id].角色.数据.模型
             local 对话名称=玩家数据[id].角色.数据.名称
            发送数据(玩家数据[id].连接id,1501,{模型=对话模型,名称=对话名称,选项=对话选项,对话=对话内容})
            玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}

           -- 常规提示(id,"#G尊贵的会员！您获取100%经验加成和30%金币加成！！")
            道具刷新(id)
            return
       end



  elseif 名称=="飞行符" then
        if self:取飞行限制(id)==false then
            玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
            玩家数据[id].最后操作="飞行符"
            发送数据(连接id,13)
            return
        end
   elseif 名称=="陨铁" then
    玩家数据[id].最后操作="幻化装备"
    发送数据(连接id,136,玩家数据[id].道具:索要道具1(id))
    return
  elseif 名称=="神兵图鉴" or 名称=="灵宝图鉴" or 名称=="灵饰图鉴" or 名称=="仙灵丹" or 名称=="特效点化石" or 名称=="无级别点化石"
    or 名称=="灵饰点化石" or 名称=="特技点化石"  or 名称=="灵饰洗炼石" or 名称=="鸿蒙灵宝"   or 名称=="鸿蒙仙宝" or 名称=="鸿蒙神宝"
    or 名称=="太初灵石" or 名称=="太初仙石" or 名称=="太初神石" or 名称=="鸿蒙原石" or 名称=="太初原石" then
    玩家数据[id].提取词条=nil
    玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id,道具=玩家数据[id].道具:索要道具1(id)}
    发送数据(连接id,64,玩家数据[id].道具操作)
    return
  elseif 名称=="附魔宝珠" or 名称=="超级附魔宝珠" then
    发送数据(玩家数据[id].连接id,3548,{道具=self:索要道具1(id),宝珠数据 = 道具id})
    return
  elseif 名称=="碎星锤" or 名称 == "超级碎星锤" then
    玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id,道具=玩家数据[id].道具:索要道具1(id)}
    发送数据(连接id,84.1,玩家数据[id].道具操作)
    return
  elseif 名称=="灵箓" then
    玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id,道具=玩家数据[id].道具:索要道具1(id)}
    发送数据(连接id,84.2,玩家数据[id].道具操作)
    return
    elseif 名称=="甲鱼" or 名称=="草鱼" then
    玩家数据[id].角色.数据.钓鱼积分=玩家数据[id].角色.数据.钓鱼积分+10
    常规提示(id,"#Y获得钓鱼积分10点#72")
    道具使用 = true
    elseif 名称=="娃娃鱼"  then
    玩家数据[id].角色.数据.钓鱼积分=玩家数据[id].角色.数据.钓鱼积分+20
    常规提示(id,"#Y获得钓鱼积分20点#72")
    道具使用 = true
    elseif 名称=="大闸蟹" then
    玩家数据[id].角色.数据.钓鱼积分=玩家数据[id].角色.数据.钓鱼积分+15
    常规提示(id,"#Y获得钓鱼积分15点#72")
    道具使用 = true
  elseif 名称=="鱼竿" then
     if 玩家数据[id].队伍~=0 and 玩家数据[id].队长==false then
       常规提示(id,"#y/请联系队长使用")
       return
     end
     if 玩家数据[id].角色.数据.地图数据.编号~=1092 then
         常规提示(id,"#y/请前往傲来国垂钓")
      return
    end
       if math.floor(玩家数据[id].角色.数据.地图数据.x/20)<117 or math.floor(玩家数据[id].角色.数据.地图数据.x/20)>166 or math.floor(玩家数据[id].角色.数据.地图数据.y/20)<141 or math.floor(玩家数据[id].角色.数据.地图数据.y/20)>144 then
         常规提示(id,"#y/这里不是钓鱼的位置，渔夫的边上垂钓")
          return
        end
      if 玩家数据[id].队伍~=0 then
        local llheg
         for n=1,#队伍数据[玩家数据[id].队伍].成员数据 do
            ll=队伍数据[玩家数据[id].队伍].成员数据[n]
          end
             发送数据(玩家数据[ll].连接id,143)  -- 211
             发送数据(玩家数据[id].连接id,143)
        return
      else
        发送数据(连接id,143)    --他这个脚本是复制风云里面的 拿过来没有修改  我刚才修改了 就可以使用了
        return
      end

     elseif 名称=="房屋地契" then
            if not 玩家数据[id].房屋.是否创建 then
               玩家数据[id].房屋:加载房屋(self.数据[道具id])
               玩家数据[id].房屋.是否创建=true
               玩家数据[id].房屋:存档()
               常规提示(id,"#Y/你获得了#R/"..self.数据[道具id].房屋规模.."#Y/房产")
               道具使用=true
            else
              常规提示(id,"#Y/你已经有一栋房子了")
            return
          end

      elseif 名称=="归墟之证" then
            if self.数据[道具id].等级 and self.数据[道具id].类型 and 归墟活动:开启任务(id,self.数据[道具id].类型,self.数据[道具id].等级) then
                道具使用=true
            else
                 常规提示(id,"#Y/该道具无法使用")
                return
            end
      elseif 名称=="设计图" then
         local  对话内容 = "#W/你要制造#Y/"..self.数据[道具id].类型.."#W/么？,需消耗体力#Y/"..家具消耗[self.数据[道具id].类型].体力
         local  对话选项 = {"现在就制造","什么也不做"}
         local 对话模型=玩家数据[id].角色.数据.模型
         local 对话名称=玩家数据[id].角色.数据.名称
         发送数据(玩家数据[id].连接id,1501,{模型=对话模型,名称=对话名称,选项=对话选项,对话=对话内容})
         玩家数据[id].制作家具 ={格子=道具格子,道具id=道具id,名称=self.数据[道具id].类型}
        return

    elseif 名称=="坐骑蛋"  then
        if 玩家数据[id].角色.数据.坐骑列表 and #玩家数据[id].角色.数据.坐骑列表>=7 then
          常规提示(id,"#Y/携带坐骑数量已上限.")
          return
        end
        if self.数据[道具id].数量 < 99 then
          常规提示(id,"必须集齐99个才可以使用哟")
          return
        end
        local zqsQ = 全局坐骑资料:取坐骑库(玩家数据[id].角色.数据)
        全局坐骑资料:获取坐骑(id,zqsQ)
        发送数据(玩家数据[id].连接id,61,玩家数据[id].角色.数据.坐骑列表)
        常规提示(id,"#Y/恭喜你获得了["..zqsQ.."]坐骑!")
        广播消息({内容=format("#S(坐骑蛋)#R/%s#Y集齐了99个坐骑蛋，悄悄#R%s#Y，获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,"打开后",zqsQ),频道="xt"})
        删除数量=99
        道具使用=true
  elseif 名称=="破碎的鸿蒙灵宝" then
        local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          if self.数据[道具id].数量 < 99 then
            常规提示(id,"必须集齐99个才可以使用哟")
            return
          end
           self:给予道具(id,"鸿蒙灵宝")
            常规提示(id,"你获得了#R鸿蒙灵宝")
          广播消息({内容=format("#S(装备境界)#R/%s#Y集齐了99个破碎的鸿蒙灵宝，悄悄#R%s#Y，获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,"打开后","鸿蒙灵宝"),频道="xt"})
          删除数量=99
          道具使用=true
  elseif 名称=="破碎的鸿蒙仙宝" then
        local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          if self.数据[道具id].数量 < 99 then
            常规提示(id,"必须集齐99个才可以使用哟")
            return
          end
           self:给予道具(id,"鸿蒙仙宝")
           常规提示(id,"你获得了#R鸿蒙仙宝")
          广播消息({内容=format("#S(装备境界)#R/%s#Y集齐了99个破碎的鸿蒙仙宝，悄悄#R%s#Y，获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,"打开后","鸿蒙仙宝"),频道="xt"})
          删除数量=99
          道具使用=true
  elseif 名称=="破碎的鸿蒙神宝" then
        local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          if self.数据[道具id].数量 < 99 then
            常规提示(id,"必须集齐99个才可以使用哟")
            return
          end
           self:给予道具(id,"鸿蒙神宝")
           常规提示(id,"你获得了#R鸿蒙神宝")
          广播消息({内容=format("#S(装备境界)#R/%s#Y集齐了99个破碎的鸿蒙神宝，悄悄#R%s#Y，获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,"打开后","鸿蒙神宝"),频道="xt"})
          删除数量=99
          道具使用=true
  elseif 名称=="破碎的太初灵石" then
        local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          if self.数据[道具id].数量 < 99 then
            常规提示(id,"必须集齐99个才可以使用哟")
            return
          end
           self:给予道具(id,"太初灵石")
           常规提示(id,"你获得了#R太初灵石")
          广播消息({内容=format("#S(神话装备)#R/%s#Y集齐了99个破碎的太初灵石，悄悄#R%s#Y，获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,"打开后","太初灵石"),频道="xt"})
          删除数量=99
          道具使用=true
  elseif 名称=="破碎的太初仙石" then
        local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          if self.数据[道具id].数量 < 99 then
            常规提示(id,"必须集齐99个才可以使用哟")
            return
          end
           self:给予道具(id,"太初仙石")
           常规提示(id,"你获得了#R太初仙石")
          广播消息({内容=format("#S(神话装备)#R/%s#Y集齐了99个破碎的太初仙石，悄悄#R%s#Y，获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,"打开后","太初仙石"),频道="xt"})
          删除数量=99
          道具使用=true
  elseif 名称=="破碎的太初神石" then
        local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          if self.数据[道具id].数量 < 99 then
            常规提示(id,"必须集齐99个才可以使用哟")
            return
          end
          self:给予道具(id,"太初神石")
          常规提示(id,"你获得了#R太初神石")
          广播消息({内容=format("#S(神话装备)#R/%s#Y集齐了99个破碎的太初神石，悄悄#R%s#Y，获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,"打开后","太初神石"),频道="xt"})
          删除数量=99
          道具使用=true
  elseif 名称=="锦衣碎片" then
        local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          if self.数据[道具id].数量 < 99 then
            常规提示(id,"必须集齐99个才可以使用哟")
            return
          end
          local 给与名称 ={"青春","素颜","绝色","春秋","星河","白峨","糖果","青涩","傲然","牛仔","试剑","骨龙战骑","斗战神","斗战胜佛"}
          local 获得名称=给与名称[取随机数(1,#给与名称)]
          self:给予锦衣(id,获得名称)
           广播消息({内容=format("#S(锦衣碎片)#R/%s#Y集齐了99个锦衣碎片，悄悄#R%s#Y，获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,"打开后",获得名称),频道="xt"})
          删除数量=99
          道具使用=true

  elseif 名称=="特殊兽决碎片" then
        local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          if self.数据[道具id].数量 < 99 then
            常规提示(id,"必须集齐99个才可以使用哟")
            return
          end
          self:给予道具(id,"特殊兽决礼包")
          广播消息({内容=format("#S(特殊兽决碎片)#R/%s#Y集齐了99个特殊兽决碎片，悄悄#R%s#Y，获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,"打开后","特殊兽决礼包"),频道="xt"})
          删除数量=99
          道具使用=true
  elseif 名称=="超级兽决碎片" then
        local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          if self.数据[道具id].数量 < 99 then
            常规提示(id,"必须集齐99个才可以使用哟")
            return
          end
          self:给予道具(id,"超级兽决礼包")
          广播消息({内容=format("#S(超级兽决碎片)#R/%s#Y集齐了99个超级兽决碎片，悄悄#R%s#Y，获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,"打开后","超级兽决礼包"),频道="xt"})
          删除数量=99
          道具使用=true

  elseif 名称=="新春红包" then
        local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          if self.数据[道具id].数量 < 99 then
            常规提示(id,"必须集齐99个才可以使用哟")
            return
          end
          self:给予道具(id,"新春礼包")
          广播消息({内容=format("#S(新春礼包)#R/%s#Y集齐了99个新春红包，悄悄#R%s#Y，获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,"打开后","新春礼包"),频道="xt"})
          删除数量=99
          道具使用=true
   elseif 名称=="副本重置丹" then
      if 玩家数据[id].角色:取任务(7001)~=0 then
          常规提示(id,"你的一斛珠还未完成")
          return
      elseif 玩家数据[id].角色:取任务(130)~=0 then
          常规提示(id,"你的车迟斗法还未完成")
          return
      elseif 玩家数据[id].角色:取任务(150)~=0 then
          常规提示(id,"你的水陆大会还未完成")
          return
      elseif 玩家数据[id].角色:取任务(191)~=0 then
          常规提示(id,"你的齐天大圣还未完成")
          return
      elseif 玩家数据[id].角色:取任务(180)~=0 then
          常规提示(id,"你的大闹天宫还未完成")
          return
      elseif 玩家数据[id].角色:取任务(120)~=0 then
          常规提示(id,"你的乌鸡国还未完成")
          return
      elseif 玩家数据[id].角色:取任务(160)~=0 then
          常规提示(id,"你的通天河还未完成")
          return
      end
      for k,v in pairs(副本数据) do
          v.完成[id]=os.time()-90000
      end
      常规提示(id,"#Y/你的所有副本已重置")
      道具使用=true


   elseif 名称=="低级胚子礼包" then
     if 玩家数据[id].召唤兽:是否携带上限() then
           常规提示(id,"#Y/你的召唤兽已满无法携带更多")
      else
          local 礼包数据 = {}
          if 自定义数据.低级胚子礼包 and type(自定义数据.低级胚子礼包)=="table" then
              for k,v in pairs(自定义数据.低级胚子礼包) do
                  if type(v)=="table" then
                        礼包数据[k]=v
                  end
              end
          end
          local 模型组 = {}
          if 礼包数据.模型 and type(礼包数据.模型)=="table" then
              for k,v in pairs(礼包数据.模型) do
                  if type(v)=="string" then
                      table.insert(模型组, v)
                  end
              end
          end
          for k,v in pairs(礼包数据) do
              if k~="模型" and k~="技能" and type(v)=="table" then
                  table.insert(模型组, k)
              end
          end
          if not 模型组 or not 模型组[1] then
              模型组 = {"老虎","白熊"}
          end
          local 类型 = 模型组[取随机数(1,#模型组)]
          local 技能组 ={"连击","驱鬼","幸运","强力","迟钝","防御","反击","夜战"}
          if 礼包数据[类型] then
              技能组=DeepCopy(礼包数据[类型])
          elseif 礼包数据.技能 then
              技能组 = DeepCopy(礼包数据.技能)
          end
          for k,v in pairs(技能组) do
              if type(v)~="string" then
                  技能组={"连击","驱鬼","幸运","强力","迟钝","防御","反击","夜战"}
                  break
              end
          end
          local 宠物名称 = #技能组.."技能"..类型
          玩家数据[id].召唤兽:添加召唤兽(类型,宠物名称,"宝宝",nil,30,技能组)
          常规提示(id,"#Y/你获得了一只#R/"..类型)
          道具使用=true
      end
elseif 名称=="中级胚子礼包" then
     if 玩家数据[id].召唤兽:是否携带上限() then
           常规提示(id,"#Y/你的召唤兽已满无法携带更多")
      else
          local 礼包数据 = {}
          if 自定义数据.中级胚子礼包 and type(自定义数据.中级胚子礼包)=="table" then
              for k,v in pairs(自定义数据.中级胚子礼包) do
                  if type(v)=="table" then
                        礼包数据[k]=v
                  end
              end
          end
          local 模型组 = {}
          if 礼包数据.模型 and type(礼包数据.模型)=="table" then
              for k,v in pairs(礼包数据.模型) do
                  if type(v)=="string" then
                      table.insert(模型组, v)
                  end
              end
          end
          for k,v in pairs(礼包数据) do
              if k~="模型" and k~="技能" and type(v)=="table" then
                  table.insert(模型组, k)
              end
          end
          if not 模型组 or not 模型组[1] then
              模型组 = {"老虎","白熊"}
          end
          local 类型 = 模型组[取随机数(1,#模型组)]
          local 技能组 ={"连击","驱鬼","幸运","强力","迟钝","防御","反击","反震","弱点雷","弱点土","吸血","夜战"}
          if 礼包数据[类型] then
              技能组=DeepCopy(礼包数据[类型])
          elseif 礼包数据.技能 then
              技能组 = DeepCopy(礼包数据.技能)
          end
          for k,v in pairs(技能组) do
              if type(v)~="string" then
                  技能组={"连击","驱鬼","幸运","强力","迟钝","防御","反击","反震","弱点雷","弱点土","吸血","夜战"}
                  break
              end
          end
          local 宠物名称 = #技能组.."技能"..类型
          玩家数据[id].召唤兽:添加召唤兽(类型,宠物名称,"宝宝",nil,30,技能组)
          常规提示(id,"#Y/你获得了一只#R/"..类型)
          道具使用=true


      end
  elseif 名称=="高级胚子礼包" then
     if 玩家数据[id].召唤兽:是否携带上限() then
           常规提示(id,"#Y/你的召唤兽已满无法携带更多")
      else
          local 礼包数据 = {}
          if 自定义数据.高级胚子礼包 and type(自定义数据.高级胚子礼包)=="table" then
              for k,v in pairs(自定义数据.高级胚子礼包) do
                  if type(v)=="table" then
                        礼包数据[k]=v
                  end
              end
          end
          local 模型组 = {}
          if 礼包数据.模型 and type(礼包数据.模型)=="table" then
              for k,v in pairs(礼包数据.模型) do
                  if type(v)=="string" then
                      table.insert(模型组, v)
                  end
              end
          end
          for k,v in pairs(礼包数据) do
              if k~="模型" and k~="技能" and type(v)=="table" then
                  table.insert(模型组, k)
              end
          end
          if not 模型组 or not 模型组[1] then
              模型组 = {"老虎","白熊"}
          end
          local 类型 = 模型组[取随机数(1,#模型组)]
          local 技能组 ={"连击","驱鬼","幸运","强力","迟钝","防御","反击","反震","弱点雷","弱点土","吸血","夜战","隐身","感知","再生","冥思"}
          if 礼包数据[类型] then
              技能组=DeepCopy(礼包数据[类型])
          elseif 礼包数据.技能 then
              技能组 = DeepCopy(礼包数据.技能)
          end
          for k,v in pairs(技能组) do
              if type(v)~="string" then
                  技能组={"连击","驱鬼","幸运","强力","迟钝","防御","反击","反震","弱点雷","弱点土","吸血","夜战","隐身","感知","再生","冥思"}
                  break
              end
          end
          local 宠物名称 = #技能组.."技能"..类型
          玩家数据[id].召唤兽:添加召唤兽(类型,宠物名称,"宝宝",nil,30,技能组)
          常规提示(id,"#Y/你获得了一只#R/"..类型)
          道具使用=true
      end
   elseif 名称=="一代神兽礼包" then
      if 玩家数据[id].召唤兽:是否携带上限() then
           常规提示(id,"#Y/你的召唤兽已满无法携带更多")
      else
          local 类型 = 取一代神兽()
          玩家数据[id].召唤兽:添加召唤兽(类型,类型,"神兽")
          常规提示(id,"#Y/你获得了一只#R/"..类型)
          道具使用=true
      end
   elseif 名称=="二代神兽礼包" then
    if 玩家数据[id].召唤兽:是否携带上限() then
         常规提示(id,"#Y/你的召唤兽已满无法携带更多")
    else
        local 类型 = 取二代神兽()
        玩家数据[id].召唤兽:添加召唤兽(类型,类型,"神兽")
        常规提示(id,"#Y/你获得了一只#R/"..类型)
        道具使用=true
    end
  elseif 名称=="三代神兽礼包" then
    if 玩家数据[id].召唤兽:是否携带上限() then
         常规提示(id,"#Y/你的召唤兽已满无法携带更多")
    else
        local 类型 = 取三代神兽()
        玩家数据[id].召唤兽:添加召唤兽(类型,类型,"神兽")
        常规提示(id,"#Y/你获得了一只#R/"..类型)
        道具使用=true
    end
 elseif 名称=="四代神兽礼包" then
    if 玩家数据[id].召唤兽:是否携带上限() then
         常规提示(id,"#Y/你的召唤兽已满无法携带更多")
    else
        local 类型 = 取四代神兽()
        玩家数据[id].召唤兽:添加召唤兽(类型,类型,"神兽")
        常规提示(id,"#Y/你获得了一只#R/"..类型)
        道具使用=true
    end
   elseif 名称=="一代物理礼包" then
      if 玩家数据[id].召唤兽:是否携带上限() then
           常规提示(id,"#Y/你的召唤兽已满无法携带更多")
      else
          local 类型 = 取一代神兽()
          玩家数据[id].召唤兽:添加召唤兽(类型,类型,"神兽","(物理型)")
          常规提示(id,"#Y/你获得了一只#R/"..类型)
          道具使用=true
      end
   elseif 名称=="二代物理礼包" then
    if 玩家数据[id].召唤兽:是否携带上限() then
         常规提示(id,"#Y/你的召唤兽已满无法携带更多")
    else
        local 类型 = 取二代神兽()
        玩家数据[id].召唤兽:添加召唤兽(类型,类型,"神兽","(物理型)")
        常规提示(id,"#Y/你获得了一只#R/"..类型)
        道具使用=true
    end
  elseif 名称=="三代物理礼包" then
    if 玩家数据[id].召唤兽:是否携带上限() then
         常规提示(id,"#Y/你的召唤兽已满无法携带更多")
    else
        local 类型 = 取三代神兽()
        玩家数据[id].召唤兽:添加召唤兽(类型,类型,"神兽","(物理型)")
        常规提示(id,"#Y/你获得了一只#R/"..类型)
        道具使用=true
    end
 elseif 名称=="四代物理礼包" then
    if 玩家数据[id].召唤兽:是否携带上限() then
         常规提示(id,"#Y/你的召唤兽已满无法携带更多")
    else
        local 类型 = 取四代神兽()
        玩家数据[id].召唤兽:添加召唤兽(类型,类型,"神兽","(物理型)")
        常规提示(id,"#Y/你获得了一只#R/"..类型)
        道具使用=true
    end
  elseif 名称=="一代法术礼包" then
      if 玩家数据[id].召唤兽:是否携带上限() then
           常规提示(id,"#Y/你的召唤兽已满无法携带更多")
      else
          local 类型 = 取一代神兽()
          玩家数据[id].召唤兽:添加召唤兽(类型,类型,"神兽","(法术型)")
          常规提示(id,"#Y/你获得了一只#R/"..类型)
          道具使用=true
      end
   elseif 名称=="二代法术礼包" then
    if 玩家数据[id].召唤兽:是否携带上限() then
         常规提示(id,"#Y/你的召唤兽已满无法携带更多")
    else
        local 类型 = 取二代神兽()
        玩家数据[id].召唤兽:添加召唤兽(类型,类型,"神兽","(法术型)")
        常规提示(id,"#Y/你获得了一只#R/"..类型)
        道具使用=true
    end
  elseif 名称=="三代法术礼包" then
    if 玩家数据[id].召唤兽:是否携带上限() then
         常规提示(id,"#Y/你的召唤兽已满无法携带更多")
    else
        local 类型 = 取三代神兽()
        玩家数据[id].召唤兽:添加召唤兽(类型,类型,"神兽","(法术型)")
        常规提示(id,"#Y/你获得了一只#R/"..类型)
        道具使用=true
    end
 elseif 名称=="四代法术礼包" then
    if 玩家数据[id].召唤兽:是否携带上限() then
         常规提示(id,"#Y/你的召唤兽已满无法携带更多")
    else
        local 类型 = 取四代神兽()
        玩家数据[id].召唤兽:添加召唤兽(类型,类型,"神兽","(法术型)")
        常规提示(id,"#Y/你获得了一只#R/"..类型)
        道具使用=true
    end
 elseif 名称=="一代神兽自选礼包" then
        if 玩家数据[id].召唤兽:是否携带上限() then
             常规提示(id,"#Y/你的召唤兽已满无法携带更多")
        else
            local 对话="#W/请选择你需要的物理还是法术的一代神兽"
            local xx={"一代神兽(物理型)","一代神兽(法术型)"}
            玩家数据[id].神兽自选礼包={事件="一代神兽",道具id=道具id,道具格子=道具格子,包裹类型=包裹类型}
            发送数据(玩家数据[id].连接id,1501,{名称="一代神兽自选礼包",模型=玩家数据[id].角色.模型,对话=对话,选项=xx})
        end
        return
 elseif 名称=="二代神兽自选礼包" then
        if 玩家数据[id].召唤兽:是否携带上限() then
             常规提示(id,"#Y/你的召唤兽已满无法携带更多")
        else
            local 对话="#W/请选择你需要的物理还是法术的二代神兽"
            local xx={"二代神兽(物理型)","二代神兽(法术型)"}
            玩家数据[id].神兽自选礼包={事件="二代神兽",道具id=道具id,道具格子=道具格子,包裹类型=包裹类型}
            发送数据(玩家数据[id].连接id,1501,{名称="二代神兽自选礼包",模型=玩家数据[id].角色.模型,对话=对话,选项=xx})
        end
        return
 elseif 名称=="三代神兽自选礼包" then
        if 玩家数据[id].召唤兽:是否携带上限() then
             常规提示(id,"#Y/你的召唤兽已满无法携带更多")
        else
            local 对话="#W/请选择你需要的物理还是法术的三代神兽"
            local xx={"三代神兽(物理型)","三代神兽(法术型)"}
            玩家数据[id].神兽自选礼包={事件="三代神兽",道具id=道具id,道具格子=道具格子,包裹类型=包裹类型}
            发送数据(玩家数据[id].连接id,1501,{名称="三代神兽自选礼包",模型=玩家数据[id].角色.模型,对话=对话,选项=xx})
        end
        return
 elseif 名称=="四代神兽自选礼包" then
        if 玩家数据[id].召唤兽:是否携带上限() then
             常规提示(id,"#Y/你的召唤兽已满无法携带更多")
        else
            local 对话="#W/请选择你需要的物理还是法术的四代神兽"
            local xx={"四代神兽(物理型)","四代神兽(法术型)"}
            玩家数据[id].神兽自选礼包={事件="四代神兽",道具id=道具id,道具格子=道具格子,包裹类型=包裹类型}
            发送数据(玩家数据[id].连接id,1501,{名称="四代神兽自选礼包",模型=玩家数据[id].角色.模型,对话=对话,选项=xx})
        end
        return
 elseif 名称=="绝世英豪&礼包" then
         玩家数据[id].角色:添加称谓("绝世英豪")
         道具使用=true
 elseif 名称=="横扫天下&礼包" then
         玩家数据[id].角色:添加称谓("横扫天下")
         道具使用=true
 elseif 名称=="独孤求败&礼包" then
         玩家数据[id].角色:添加称谓("独孤求败")
         道具使用=true
  elseif 名称=="小型奖券" then
         玩家数据[id].角色.数据.抽奖=玩家数据[id].角色.数据.抽奖+1
         常规提示(id,"#Y/你获得了#R/1#Y/次抽奖,剩余抽奖次数#R/"..玩家数据[id].角色.数据.抽奖)
         道具使用=true
  elseif 名称 == "中型奖券" then
         玩家数据[id].角色.数据.抽奖=玩家数据[id].角色.数据.抽奖+10
         常规提示(id,"#Y/你获得了#R/10#Y/次抽奖,剩余抽奖次数#R/"..玩家数据[id].角色.数据.抽奖)
         道具使用=true
  elseif 名称 == "大型奖券" then
         玩家数据[id].角色.数据.抽奖=玩家数据[id].角色.数据.抽奖+50
         常规提示(id,"#Y/你获得了#R/50#Y/次抽奖,剩余抽奖次数#R/"..玩家数据[id].角色.数据.抽奖)
         道具使用=true

  elseif 名称=="一级仙缘" then
    if 玩家数据[id].角色:取任务(375)~=0 then
      常规提示(id,"#Y/你已经有个一级仙缘在进行了")
    else
      任务处理类:添加一级仙缘任务(id)
      常规提示(id,"#Y/你获得了一级仙缘任务")
      道具使用=true
    end
          elseif 名称=="二级仙缘" then
    if 玩家数据[id].角色:取任务(376)~=0 then
      常规提示(id,"#Y/你已经有个一级仙缘在进行了")
    else
      任务处理类:添加二级仙缘任务(id)
      常规提示(id,"#Y/你获得了二级仙缘任务")
      道具使用=true
    end
          elseif 名称=="三级仙缘" then
    if 玩家数据[id].角色:取任务(377)~=0 then
      常规提示(id,"#Y/你已经有个一级仙缘在进行了")
    else
      任务处理类:添加三级仙缘任务(id)
      常规提示(id,"#Y/你获得了三级仙缘任务")
      道具使用=true
    end
          elseif 名称=="四级仙缘" then
    if 玩家数据[id].角色:取任务(378)~=0 then
      常规提示(id,"#Y/你已经有个四级仙缘在进行了")
    else
      任务处理类:添加四级仙缘任务(id)
      常规提示(id,"#Y/你获得了四级仙缘任务")
      道具使用=true
    end
          elseif 名称=="五级仙缘" then
    if 玩家数据[id].角色:取任务(379)~=0 then
      常规提示(id,"#Y/你已经有个五级仙缘在进行了")
    else
      任务处理类:添加五级仙缘任务(id)
      常规提示(id,"#Y/你获得了五级仙缘任务")
      道具使用=true
    end
          elseif 名称=="六级仙缘" then
    if 玩家数据[id].角色:取任务(380)~=0 then
      常规提示(id,"#Y/你已经有个六级仙缘在进行了")
    else
      任务处理类:添加六级仙缘任务(id)
      常规提示(id,"#Y/你获得了六级仙缘任务")
      道具使用=true
    end
          elseif 名称=="七级仙缘" then
    if 玩家数据[id].角色:取任务(381)~=0 then
      常规提示(id,"#Y/你已经有个七级仙缘在进行了")
    else
      任务处理类:添加七级仙缘任务(id)
      常规提示(id,"#Y/你获得了七级仙缘任务")
      道具使用=true
    end
          elseif 名称=="八级仙缘" then
    if 玩家数据[id].角色:取任务(382)~=0 then
      常规提示(id,"#Y/你已经有个八级仙缘在进行了")
    else
      任务处理类:添加八级仙缘任务(id)
      常规提示(id,"#Y/你获得了八级仙缘任务")
      道具使用=true
    end
          elseif 名称=="九级仙缘" then
    if 玩家数据[id].角色:取任务(383)~=0 then
      常规提示(id,"#Y/你已经有个九级仙缘在进行了")
    else
      任务处理类:添加九级仙缘任务(id)
      常规提示(id,"#Y/你获得了九级仙缘任务")
      道具使用=true
    end
   elseif 名称=="十级仙缘" then
    if 玩家数据[id].角色:取任务(384)~=0 then
      常规提示(id,"#Y/你已经有个一级仙缘在进行了")
    else
      任务处理类:添加十级仙缘任务(id)
      常规提示(id,"#Y/你获得了十级仙缘任务")
      道具使用=true
    end
---------------------------------------------------------------------------------------------------------
  elseif 名称 == "寻龙盘(小)" then
         if 玩家数据[id].角色.数据.打造加成==nil or 玩家数据[id].角色.数据.打造加成.赐福==nil or 玩家数据[id].角色.数据.打造加成.赐福>=90 then
            常规提示(id,"#Y/改加成已达最大无法继续增加")
          else
             玩家数据[id].角色.数据.打造加成.赐福=玩家数据[id].角色.数据.打造加成.赐福+1
             常规提示(id,"#Y/你获得了#R/1%#Y/额外赐福几率,额外赐福几率为:#R/"..玩家数据[id].角色.数据.打造加成.赐福.."%")
             道具使用=true
          end
  elseif 名称 == "寻仙盘(小)" then
         if 玩家数据[id].角色.数据.打造加成==nil or 玩家数据[id].角色.数据.打造加成.双加==nil or 玩家数据[id].角色.数据.打造加成.双加>=75 then
            常规提示(id,"#Y/改加成已达最大无法继续增加")
          else
             玩家数据[id].角色.数据.打造加成.双加=玩家数据[id].角色.数据.打造加成.双加+1
             常规提示(id,"#Y/你获得了#R/1%#Y/额外双加几率,额外双加几率为:#R/"..玩家数据[id].角色.数据.打造加成.双加.."%")
             道具使用=true
          end
  elseif 名称 == "寻宝盘(小)" then
         if 玩家数据[id].角色.数据.打造加成==nil or 玩家数据[id].角色.数据.打造加成.特技==nil or 玩家数据[id].角色.数据.打造加成.特技>=75 then
            常规提示(id,"#Y/改加成已达最大无法继续增加")
          else
             玩家数据[id].角色.数据.打造加成.特技=玩家数据[id].角色.数据.打造加成.特技+1
             常规提示(id,"#Y/你获得了#R/1%#Y/额外特技几率,额外特技几率为:#R/"..玩家数据[id].角色.数据.打造加成.特技.."%")
             道具使用=true
          end
  elseif 名称 == "寻灵盘(小)" then
         if 玩家数据[id].角色.数据.打造加成==nil or 玩家数据[id].角色.数据.打造加成.特效==nil or 玩家数据[id].角色.数据.打造加成.特效>=75 then
            常规提示(id,"#Y/改加成已达最大无法继续增加")
          else
             玩家数据[id].角色.数据.打造加成.特效=玩家数据[id].角色.数据.打造加成.特效+1
             常规提示(id,"#Y/你获得了#R/1%#Y/额外特效几率,额外特效几率为:#R/"..玩家数据[id].角色.数据.打造加成.特效.."%")
             道具使用=true
          end
-----------------------------------------------------------------------------------------------------
  elseif 名称 == "寻龙盘(中)" then
         if 玩家数据[id].角色.数据.打造加成==nil or 玩家数据[id].角色.数据.打造加成.赐福==nil or 玩家数据[id].角色.数据.打造加成.赐福+5>90 then
            常规提示(id,"#Y/改加成已达最大无法继续增加")
          else
             玩家数据[id].角色.数据.打造加成.赐福=玩家数据[id].角色.数据.打造加成.赐福+5
             常规提示(id,"#Y/你获得了#R/5%#Y/额外赐福几率,额外赐福几率为:#R/"..玩家数据[id].角色.数据.打造加成.赐福.."%")
             道具使用=true
          end
  elseif 名称 == "寻仙盘(中)" then
         if 玩家数据[id].角色.数据.打造加成==nil or 玩家数据[id].角色.数据.打造加成.双加==nil or 玩家数据[id].角色.数据.打造加成.双加+5>75 then
            常规提示(id,"#Y/改加成已达最大无法继续增加")
          else
             玩家数据[id].角色.数据.打造加成.双加=玩家数据[id].角色.数据.打造加成.双加+5
             常规提示(id,"#Y/你获得了#R/5%#Y/额外双加几率,额外双加几率为:#R/"..玩家数据[id].角色.数据.打造加成.双加.."%")
             道具使用=true
          end
  elseif 名称 == "寻宝盘(中)" then
         if 玩家数据[id].角色.数据.打造加成==nil or 玩家数据[id].角色.数据.打造加成.特技==nil or 玩家数据[id].角色.数据.打造加成.特技+5>75 then
            常规提示(id,"#Y/改加成已达最大无法继续增加")
          else
             玩家数据[id].角色.数据.打造加成.特技=玩家数据[id].角色.数据.打造加成.特技+5
             常规提示(id,"#Y/你获得了#R/5%#Y/额外特技几率,额外特技几率为:#R/"..玩家数据[id].角色.数据.打造加成.特技.."%")
             道具使用=true
          end
  elseif 名称 == "寻灵盘(中)" then
         if 玩家数据[id].角色.数据.打造加成==nil or 玩家数据[id].角色.数据.打造加成.特效==nil or 玩家数据[id].角色.数据.打造加成.特效+5>75 then
            常规提示(id,"#Y/改加成已达最大无法继续增加")
          else
             玩家数据[id].角色.数据.打造加成.特效=玩家数据[id].角色.数据.打造加成.特效+5
             常规提示(id,"#Y/你获得了#R/5%#Y/额外特效几率,额外特效几率为:#R/"..玩家数据[id].角色.数据.打造加成.特效.."%")
             道具使用=true
          end
  ----------------------------------------------------------------------------------------------------------------------------
   elseif 名称 == "寻龙盘(大)" then
         if 玩家数据[id].角色.数据.打造加成==nil or 玩家数据[id].角色.数据.打造加成.赐福==nil or 玩家数据[id].角色.数据.打造加成.赐福+10>90 then
            常规提示(id,"#Y/改加成已达最大无法继续增加")
          else
             玩家数据[id].角色.数据.打造加成.赐福=玩家数据[id].角色.数据.打造加成.赐福+10
             常规提示(id,"#Y/你获得了#R/10%#Y/额外赐福几率,额外赐福几率为:#R/"..玩家数据[id].角色.数据.打造加成.赐福.."%")
             道具使用=true
          end
  elseif 名称 == "寻仙盘(大)" then
         if 玩家数据[id].角色.数据.打造加成==nil or 玩家数据[id].角色.数据.打造加成.双加==nil or 玩家数据[id].角色.数据.打造加成.双加+10>75 then
            常规提示(id,"#Y/改加成已达最大无法继续增加")
          else
             玩家数据[id].角色.数据.打造加成.双加=玩家数据[id].角色.数据.打造加成.双加+10
             常规提示(id,"#Y/你获得了#R/10%#Y/额外双加几率,额外双加几率为:#R/"..玩家数据[id].角色.数据.打造加成.双加.."%")
             道具使用=true
          end
  elseif 名称 == "寻宝盘(大)" then
         if 玩家数据[id].角色.数据.打造加成==nil or 玩家数据[id].角色.数据.打造加成.特技==nil or 玩家数据[id].角色.数据.打造加成.特技+10>75 then
            常规提示(id,"#Y/改加成已达最大无法继续增加")
          else
             玩家数据[id].角色.数据.打造加成.特技=玩家数据[id].角色.数据.打造加成.特技+10
             常规提示(id,"#Y/你获得了#R/10%#Y/额外特技几率,额外特技几率为:#R/"..玩家数据[id].角色.数据.打造加成.特技.."%")
             道具使用=true
          end
  elseif 名称 == "寻灵盘(大)" then
         if 玩家数据[id].角色.数据.打造加成==nil or 玩家数据[id].角色.数据.打造加成.特效==nil or 玩家数据[id].角色.数据.打造加成.特效+10>75 then
            常规提示(id,"#Y/改加成已达最大无法继续增加")
          else
             玩家数据[id].角色.数据.打造加成.特效=玩家数据[id].角色.数据.打造加成.特效+10
             常规提示(id,"#Y/你获得了#R/10%#Y/额外特效几率,额外特效几率为:#R/"..玩家数据[id].角色.数据.打造加成.特效.."%")
             道具使用=true
          end

  elseif string.find(名称,"级全套礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子2()
          if 临时格子<6 then
              常规提示(id,"你的背包格子不够！")
              return
          end
          local 取出=分割文本(名称,"级")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/10) * 10
              礼包奖励类:全套装备(id,给予等级,"无级别限制",nil,1)
              道具使用=true
          end
  elseif string.find(名称,"级随机礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子2()
          if 临时格子<=0 then
              常规提示(id,"你的背包已满！")
              return
          end
          local 取出=分割文本(名称,"级")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/10)
              self:取随机装备(id,给予等级,true)
              道具使用=true
          end
  elseif string.find(名称,"级灵饰礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子2()
          if 临时格子<=5 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
          end
          local 取出=分割文本(名称,"级")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/20) * 20
              if 给予等级<60 then 给予等级 = 60 end
              礼包奖励类:全套灵饰(id,给予等级,"无级别限制")
              道具使用=true
          end
  elseif string.find(名称,"级武器礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          local 取出=分割文本(名称,"级")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/10)
              local 模型=玩家数据[id].角色.数据.模型
              local 武器序列=角色武器类型[模型][取随机数(1,2)]
              local 武器名称=玩家数据[id].装备.打造物品[武器序列][给予等级+1]
              local 临时id=玩家数据[id].装备:生成指定装备(id,武器名称,给予等级* 10,武器序列)
              self.数据[临时id].特效="无级别限制"
              道具使用=true
          end
  elseif string.find(名称,"级衣服礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          local 取出=分割文本(名称,"级")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/10)
              local 衣服类型=2
              if 玩家数据[id].角色.数据.性别=="女" then
                衣服类型=1
              end
              local 衣服序列=21
              local 衣服名称= 玩家数据[id].装备.打造物品[衣服序列][给予等级+1][衣服类型]
              local 临时id=玩家数据[id].装备:生成指定装备(id,衣服名称,给予等级* 10,衣服序列)
              self.数据[临时id].特效="无级别限制"
              道具使用=true
          end
  elseif string.find(名称,"级帽子礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          local 取出=分割文本(名称,"级")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/10)
              local 头盔类型=1
              if 玩家数据[id].角色.数据.性别=="女" then
                头盔类型=2
              end
              local 头盔序列=19
              local 头盔名称= 玩家数据[id].装备.打造物品[头盔序列][给予等级+1][头盔类型]
              local 临时id=玩家数据[id].装备:生成指定装备(id,头盔名称,给予等级* 10,头盔序列)
              self.数据[临时id].特效="无级别限制"
              道具使用=true
          end
  elseif string.find(名称,"级项链礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          local 取出=分割文本(名称,"级")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/10)
              local 项链序列=20
              local 项链名称= 玩家数据[id].装备.打造物品[项链序列][给予等级+1]
              local 临时id=玩家数据[id].装备:生成指定装备(id,项链名称,给予等级* 10,项链序列)
              self.数据[临时id].特效="无级别限制"
              道具使用=true
          end
  elseif string.find(名称,"级腰带礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          local 取出=分割文本(名称,"级")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/10)
              local 腰带序列=22
              local 腰带名称= 玩家数据[id].装备.打造物品[腰带序列][给予等级+1]
              local 临时id=玩家数据[id].装备:生成指定装备(id,腰带名称,给予等级* 10,腰带序列)
              self.数据[临时id].特效="无级别限制"
              道具使用=true
          end
  elseif string.find(名称,"级鞋子礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          local 取出=分割文本(名称,"级")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/10)
              local 鞋子序列=23
              local 鞋子名称= 玩家数据[id].装备.打造物品[鞋子序列][给予等级+1]
              local 临时id=玩家数据[id].装备:生成指定装备(id,鞋子名称,给予等级* 10,鞋子序列)
              self.数据[临时id].特效="无级别限制"
              道具使用=true
          end
		  
elseif string.find(名称, "级GM令牌") then
    local 特权等级 = 玩家数据[id].角色.数据.GM等级
    local 取出 = 分割文本(名称, "级")
	local 令牌等级 = tonumber(取出[1])
    
    -- 检查是否已达到等级上限
    if 特权等级 >= 7 then
        常规提示(id, "GM特权已达到上限")
        return
    -- 检查当前等级是否高于或等于令牌等级
    elseif 特权等级 >= 令牌等级 then
        常规提示(id, "你的GM等级大于或等于令牌等级，无法使用。")
        return
    -- 检查是否是当前等级+1的令牌
    elseif 令牌等级 ~= 特权等级 + 1 then
        常规提示(id, "只能使用您当前GM等级+1的GM令牌")
        return
    else
        -- 满足所有条件，提升GM等级
        玩家数据[id].角色.数据.GM等级 = 特权等级 + 1
        道具使用 = true
		特权等级 = 玩家数据[id].角色.数据.GM等级
		常规提示(id, "恭喜你的GM等级升到了"..特权等级.."级")
    end
  elseif string.find(名称,"级随机自选包") then
          local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          local 取出=分割文本(名称,"级")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/10)*10
              发送数据(玩家数据[id].连接id,102,{级别=给予等级})
              玩家数据[id].自选礼包数据={级别=给予等级,道具id = 道具id,名称=名称}
          end
          return
  elseif string.find(名称,"自选武器礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          local 取出=分割文本(名称,"自选")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/10)*10
              发送数据(玩家数据[id].连接id,102,{级别=给予等级,部位="武器"})
              玩家数据[id].自选礼包数据={级别=给予等级,道具id = 道具id,名称=名称,部位="武器"}
          end
          return
  elseif string.find(名称,"自选衣服礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          local 取出=分割文本(名称,"自选")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/10)*10
              发送数据(玩家数据[id].连接id,102,{级别=给予等级,部位="衣服"})
              玩家数据[id].自选礼包数据={级别=给予等级,道具id = 道具id,名称=名称,部位="衣服"}
          end
          return
  elseif string.find(名称,"自选头盔礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          local 取出=分割文本(名称,"自选")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/10)*10
              发送数据(玩家数据[id].连接id,102,{级别=给予等级,部位="头盔"})
              玩家数据[id].自选礼包数据={级别=给予等级,道具id = 道具id,名称=名称,部位="头盔"}
          end
          return
  elseif string.find(名称,"自选项链礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          local 取出=分割文本(名称,"自选")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/10)*10
              发送数据(玩家数据[id].连接id,102,{级别=给予等级,部位="项链"})
              玩家数据[id].自选礼包数据={级别=给予等级,道具id = 道具id,名称=名称,部位="项链"}
          end
          return
  elseif string.find(名称,"自选腰带礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          local 取出=分割文本(名称,"自选")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/10)*10
              发送数据(玩家数据[id].连接id,102,{级别=给予等级,部位="腰带"})
              玩家数据[id].自选礼包数据={级别=给予等级,道具id = 道具id,名称=名称,部位="腰带"}
          end
          return
  elseif string.find(名称,"自选鞋子礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          local 取出=分割文本(名称,"自选")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/10)*10
              发送数据(玩家数据[id].连接id,102,{级别=给予等级,部位="鞋子"})
              玩家数据[id].自选礼包数据={级别=给予等级,道具id = 道具id,名称=名称,部位="鞋子"}
          end
          return
-------------------------------------灵饰自选礼包
  elseif string.find(名称,"手镯自选礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          local 取出=分割文本(名称,"手镯自选")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/20) * 20
              if 给予等级<60 then 给予等级 = 60 end
              发送数据(玩家数据[id].连接id,102.1,{级别=给予等级,部位="手镯"})
              玩家数据[id].自选礼包数据={级别=给予等级,道具id = 道具id,名称=名称,部位="手镯"}
          end
          return
  elseif string.find(名称,"佩饰自选礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          local 取出=分割文本(名称,"佩饰自选")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/20) * 20
              if 给予等级<60 then 给予等级 = 60 end
              发送数据(玩家数据[id].连接id,102.1,{级别=给予等级,部位="佩饰"})
              玩家数据[id].自选礼包数据={级别=给予等级,道具id = 道具id,名称=名称,部位="佩饰"}
          end
          return
  elseif string.find(名称,"戒指自选礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          local 取出=分割文本(名称,"戒指自选")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/20) * 20
              if 给予等级<60 then 给予等级 = 60 end
              发送数据(玩家数据[id].连接id,102.1,{级别=给予等级,部位="戒指"})
              玩家数据[id].自选礼包数据={级别=给予等级,道具id = 道具id,名称=名称,部位="戒指"}
          end
          return
  elseif string.find(名称,"耳饰自选礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子()
          if 临时格子==0 then
             常规提示(id,"你的背包已满！")
            return
          end
          local 取出=分割文本(名称,"耳饰自选")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              local 给予等级 = math.floor(取出[1]/20) * 20
              if 给予等级<60 then 给予等级 = 60 end
              发送数据(玩家数据[id].连接id,102.1,{级别=给予等级,部位="耳饰"})
              玩家数据[id].自选礼包数据={级别=给予等级,道具id = 道具id,名称=名称,部位="耳饰"}
          end
          return


---------------------------------------
elseif 名称=="内丹自选礼包" then
    if 内容.窗口~="召唤兽" or 玩家数据[id].召唤兽.数据[内容.序列]==nil then
        常规提示(id,"请先选中一只召唤兽")
        return
    end

    local 对话="#W/选择你需要改变或添加内丹的格子,使用该礼包可以直接让选择的内丹技能使该格子成为满级内丹层数"
    local xx={}

    for i=1,玩家数据[id].召唤兽.数据[内容.序列].内丹.内丹上限 do
        if 玩家数据[id].召唤兽.数据[内容.序列].内丹数据[i]~=nil and 玩家数据[id].召唤兽.数据[内容.序列].内丹数据[i].技能~=nil then
            if 玩家数据[id].召唤兽.数据[内容.序列].内丹数据[i].等级<5 then
               xx[#xx+1]="将"..玩家数据[id].召唤兽.数据[内容.序列].内丹数据[i].技能.."升到满层"
            end
            xx[#xx+1]="更换内丹"..玩家数据[id].召唤兽.数据[内容.序列].内丹数据[i].技能
        else
           xx[#xx+1]="选择内丹格子"..i
        end
    end
    xx[#xx+1]="我在考虑考虑"
    玩家数据[id].内丹自选礼包={认证码=玩家数据[id].召唤兽.数据[内容.序列].认证码,道具id=道具id,道具格子=道具格子,包裹类型=包裹类型}
    发送数据(玩家数据[id].连接id,1501,{名称="内丹自选礼包",模型=玩家数据[id].角色.模型,对话=对话,选项=xx})

    return

elseif 名称=="强身传承礼包" then
    if 玩家数据[id].角色:取生活技能等级("强身术")>=160 then
      常规提示(id,"该技能已无法在学习！")
      return
    else
      local 技能编号 = 0
      for i=1,#玩家数据[id].角色.数据.辅助技能 do
          if 玩家数据[id].角色.数据.辅助技能[i].名称=="强身术" then
             技能编号=i
          end
      end
      if 技能编号~=0 then
         玩家数据[id].角色.数据.辅助技能[技能编号].等级 = 160
         道具使用=true
         常规提示(id,"你的强身术提升到了160级")
      else
       常规提示(id,"数据错误！")
       return
      end
    end
elseif 名称=="强壮传承礼包" then
    if 玩家数据[id].角色:取生活技能等级("强壮")>=160 then
      常规提示(id,"该技能已无法在学习！")
      return
    else
      local 技能编号 = 0
      for i=1,#玩家数据[id].角色.数据.辅助技能 do
          if 玩家数据[id].角色.数据.辅助技能[i].名称=="强壮" then
             技能编号=i
          end
      end
      if 技能编号~=0 then
         玩家数据[id].角色.数据.辅助技能[技能编号].等级 = 160
         道具使用=true
         常规提示(id,"你的强壮提升到了160级")
      else
       常规提示(id,"数据错误！")
       return
      end
    end

elseif 名称=="冥想传承礼包" then
    if 玩家数据[id].角色:取生活技能等级("冥想")>=160 then
      常规提示(id,"该技能已无法在学习！")
      return
    else
      local 技能编号 = 0
      for i=1,#玩家数据[id].角色.数据.辅助技能 do
          if 玩家数据[id].角色.数据.辅助技能[i].名称=="冥想" then
             技能编号=i
          end
      end
      if 技能编号~=0 then
         玩家数据[id].角色.数据.辅助技能[技能编号].等级 = 160
         道具使用=true
         常规提示(id,"你的冥想提升到了160级")
      else
       常规提示(id,"数据错误！")
       return
      end
    end

elseif 名称=="健身传承礼包" then
    if 玩家数据[id].角色:取生活技能等级("健身术")>=160 then
      常规提示(id,"该技能已无法在学习！")
      return
    else
      local 技能编号 = 0
      for i=1,#玩家数据[id].角色.数据.辅助技能 do
          if 玩家数据[id].角色.数据.辅助技能[i].名称=="健身术" then
             技能编号=i
          end
      end
      if 技能编号~=0 then
         玩家数据[id].角色.数据.辅助技能[技能编号].等级 = 160
         道具使用=true
         常规提示(id,"你的健身术提升到了160级")
      else
       常规提示(id,"数据错误！")
       return
      end
    end
elseif 名称=="养生传承礼包" then
    if 玩家数据[id].角色:取生活技能等级("养生之道")>=160 then
      常规提示(id,"该技能已无法在学习！")
      return
    else
      local 技能编号 = 0
      for i=1,#玩家数据[id].角色.数据.辅助技能 do
          if 玩家数据[id].角色.数据.辅助技能[i].名称=="养生之道" then
             技能编号=i
          end
      end
      if 技能编号~=0 then
         玩家数据[id].角色.数据.辅助技能[技能编号].等级 = 160
         道具使用=true
         常规提示(id,"你的养生之道提升到了160级")
      else
       常规提示(id,"数据错误！")
       return
      end
    end


elseif 名称=="打造传承礼包" then
    if 玩家数据[id].角色:取生活技能等级("打造技巧")>=160 then
      常规提示(id,"该技能已无法在学习！")
      return
    else
      local 技能编号 = 0
      for i=1,#玩家数据[id].角色.数据.辅助技能 do
          if 玩家数据[id].角色.数据.辅助技能[i].名称=="打造技巧" then
             技能编号=i
          end
      end
      if 技能编号~=0 then
         玩家数据[id].角色.数据.辅助技能[技能编号].等级 = 160
         道具使用=true
         常规提示(id,"你的打造技巧提升到了160级")
      else
       常规提示(id,"数据错误！")
       return
      end
    end
elseif 名称=="炼金传承礼包" then
    if 玩家数据[id].角色:取生活技能等级("炼金术")>=160 then
      常规提示(id,"该技能已无法在学习！")
      return
    else
      local 技能编号 = 0
      for i=1,#玩家数据[id].角色.数据.辅助技能 do
          if 玩家数据[id].角色.数据.辅助技能[i].名称=="炼金术" then
             技能编号=i
          end
      end
      if 技能编号~=0 then
         玩家数据[id].角色.数据.辅助技能[技能编号].等级 = 160
         道具使用=true
         常规提示(id,"你的炼金术提升到了160级")
      else
       常规提示(id,"数据错误！")
       return
      end
    end
elseif 名称=="裁缝传承礼包" then
    if 玩家数据[id].角色:取生活技能等级("裁缝技巧")>=160 then
      常规提示(id,"该技能已无法在学习！")
      return
    else
      local 技能编号 = 0
      for i=1,#玩家数据[id].角色.数据.辅助技能 do
          if 玩家数据[id].角色.数据.辅助技能[i].名称=="裁缝技巧" then
             技能编号=i
          end
      end
      if 技能编号~=0 then
         玩家数据[id].角色.数据.辅助技能[技能编号].等级 = 160
         道具使用=true
         常规提示(id,"你的裁缝技巧提升到了160级")
      else
       常规提示(id,"数据错误！")
       return
      end
    end
elseif 名称=="淬灵传承礼包" then
    if 玩家数据[id].角色:取生活技能等级("淬灵之术")>=160 then
      常规提示(id,"该技能已无法在学习！")
      return
    else
      local 技能编号 = 0
      for i=1,#玩家数据[id].角色.数据.辅助技能 do
          if 玩家数据[id].角色.数据.辅助技能[i].名称=="淬灵之术" then
             技能编号=i
          end
      end
      if 技能编号~=0 then
         玩家数据[id].角色.数据.辅助技能[技能编号].等级 = 160
         道具使用=true
         常规提示(id,"你的淬灵之术提升到了160级")
      else
       常规提示(id,"数据错误！")
       return
      end
    end

elseif 名称=="铃铛盲盒" then
    local 中奖编号 = 0
        local 获得物品={}
        local 可以获得={}
        local 计算概率 ={}
        for i=1,#自定义数据.盲盒配置 do
          计算概率[i]={概率=自定义数据.盲盒配置[i].概率}
        end
        计算概率=删除重复(计算概率)
        table.sort(计算概率,function(a,b) return a.概率>b.概率 end )
        local 获得概率 = 取随机数(1,计算概率[1].概率)
        for i=1,#自定义数据.盲盒配置 do
          if 自定义数据.盲盒配置[i].概率>0 and 获得概率<=自定义数据.盲盒配置[i].概率 then
             获得物品[#获得物品+1]={物品=自定义数据.盲盒配置[i],编号=i}
          end
          if 自定义数据.盲盒配置[i].概率>0 then
             可以获得[#可以获得+1] ={物品=自定义数据.盲盒配置[i],编号=i}
          end
        end
          获得物品=删除重复(获得物品)
          可以获得=删除重复(可以获得)
          if 获得物品~=nil then
              local 取编号=取随机数(1,#获得物品)
              if 获得物品[取编号]~=nil and 获得物品[取编号].物品~=nil and 获得物品[取编号].编号~=nil then
                 中奖编号 = 获得物品[取编号].编号
              end
          end
          if  中奖编号==0 then
               local 可以编号=可以获得[取随机数(1,#可以获得)].编号
               玩家数据[id].抽中编号 = 可以编号
          else
              玩家数据[id].抽中编号=中奖编号
          end
        if 自定义数据.盲盒配置~=nil and 自定义数据.盲盒配置[玩家数据[id].抽中编号]~=nil then
           玩家数据[id].道具:自定义给予道具(id,自定义数据.盲盒配置[玩家数据[id].抽中编号].名称,自定义数据.盲盒配置[玩家数据[id].抽中编号].数量,自定义数据.盲盒配置[玩家数据[id].抽中编号].参数)
        end
        玩家数据[id].抽中编号=nil
        道具使用=true
elseif 名称=="地宫礼包" then
        local 中奖编号 = 0
        local 获得物品={}
        local 可以获得={}
        local 计算概率 ={}
        for i=1,#自定义数据.地宫礼包 do
          计算概率[i]={概率=自定义数据.地宫礼包[i].概率}
        end
        计算概率=删除重复(计算概率)
        table.sort(计算概率,function(a,b) return a.概率>b.概率 end )
        local 获得概率 = 取随机数(1,计算概率[1].概率)
        for i=1,#自定义数据.地宫礼包 do
          if 自定义数据.地宫礼包[i].概率>0 and 获得概率<=自定义数据.地宫礼包[i].概率 then
             获得物品[#获得物品+1]={物品=自定义数据.地宫礼包[i],编号=i}
          end
          if 自定义数据.地宫礼包[i].概率>0 then
             可以获得[#可以获得+1] ={物品=自定义数据.地宫礼包[i],编号=i}
          end
        end
          获得物品=删除重复(获得物品)
          可以获得=删除重复(可以获得)
          if 获得物品~=nil then
              local 取编号=取随机数(1,#获得物品)
              if 获得物品[取编号]~=nil and 获得物品[取编号].物品~=nil and 获得物品[取编号].编号~=nil then
                 中奖编号 = 获得物品[取编号].编号
              end
          end
          if  中奖编号==0 then
               local 可以编号=可以获得[取随机数(1,#可以获得)].编号
               玩家数据[id].地宫编号 = 可以编号
          else
              玩家数据[id].地宫编号=中奖编号
          end
        if 自定义数据.地宫礼包~=nil and 自定义数据.地宫礼包[玩家数据[id].地宫编号]~=nil then
           玩家数据[id].道具:自定义给予道具(id,自定义数据.地宫礼包[玩家数据[id].地宫编号].名称,自定义数据.地宫礼包[玩家数据[id].地宫编号].数量,自定义数据.地宫礼包[玩家数据[id].地宫编号].参数)
        end
        玩家数据[id].地宫编号=nil
        道具使用=true
  elseif 名称=="宠物特惠礼包" or 名称=="书铁打造礼包" or 名称=="高级书铁打造礼包"
    or 名称=="灵饰打造礼包" or 名称=="高级灵饰打造礼包" or 名称=="高级宝石礼包"
    or 名称=="特殊兽决礼包" or 名称=="超级兽决礼包" or 名称=="新春礼包" then
            local 临时格子=玩家数据[id].角色:取道具格子()
            if 临时格子==0 then
               常规提示(id,"你的背包已满！")
              return
            end
           local 获得物品={}
           for i=1,#自定义数据[名称] do
               if 取随机数()<=自定义数据[名称][i].概率 then
                  获得物品[#获得物品+1]=自定义数据[名称][i]
               end
           end
           获得物品=删除重复(获得物品)
           if 获得物品~=nil then
              local 取编号=取随机数(1,#获得物品)
              if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
                 玩家数据[id].道具:自定义给予道具(id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
              end
           end
           道具使用=true

  elseif 名称=="神兜兜幸运礼包" then
         local 临时格子=玩家数据[id].角色:取道具格子()
        if 临时格子==0 then
           常规提示(id,"你的背包已满！")
          return
        end
         local 数量 = 取随机数(1,6)
         self:给予道具(id,"神兜兜",数量)
         常规提示(id,"你获得了#G/"..数量.."#Y/个#R/神兜兜")
         道具使用=true
  elseif 名称=="强化丹幸运礼包" then
         local 临时格子=玩家数据[id].角色:取道具格子()
        if 临时格子==0 then
           常规提示(id,"你的背包已满！")
          return
        end
         local 数量 = 取随机数(1,5)
         local 强化技能 = {"人物伤害","人物防御","人物气血","人物法术","人物速度","人物固伤","人物治疗","宠物伤害","宠物防御","宠物气血","宠物灵力","宠物速度"}
         local 临时参数 = 强化技能[取随机数(1,#强化技能)]
         self:给予道具(id,"强化升级丹",数量,临时参数)
         常规提示(id,"你获得了#G/"..数量.."#Y/个#G/"..临时参数.."#R/强化升级丹")
         道具使用=true
  elseif 名称=="四打神匠礼包" then
          local 临时格子=玩家数据[id].角色:取道具格子2()
          if 临时格子<=4 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
          end
           self:给予道具(id,"打造传承礼包")
           self:给予道具(id,"炼金传承礼包")
           self:给予道具(id,"裁缝传承礼包")
           self:给予道具(id,"淬灵传承礼包")
           常规提示(id,"你获得了4个传承礼包")
           道具使用=true



  elseif 名称=="种族坐骑礼包" then
    if 玩家数据[id].角色:增加种族坐骑(id) then
      道具使用=true
    end

  elseif 名称=="祥瑞坐骑礼包" then
    if 玩家数据[id].角色:增加祥瑞坐骑(id) then
      道具使用=true
    end




  elseif 名称=="神秘钥匙" then
    local 临时格子=玩家数据[id].角色:取道具格子2()
    if 临时格子<=5 then
      常规提示(id,"您的道具栏物品已经满啦")
      return 0
    end
    if 玩家数据[id].角色.数据.等级<109 then
      常规提示(id,"现在不能开启礼包,你等级未达到109级")
      return 0
    end
    玩家数据[id].道具:给予书铁(id,{14,14},"指南书")
    玩家数据[id].道具:给予书铁(id,{14,14},"精铁")
    道具使用=true


  elseif string.find(名称,"级宝石礼包") and 名称~="高级宝石礼包"  then
          local 临时格子=玩家数据[id].角色:取道具格子2()
          if 临时格子<=6 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
          end
          local 取出=分割文本(名称,"级")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              self:给予道具(id,"太阳石",tonumber(取出[1]))
              self:给予道具(id,"光芒石",tonumber(取出[1]))
              self:给予道具(id,"红玛瑙",tonumber(取出[1]))
              self:给予道具(id,"月亮石",tonumber(取出[1]))
              self:给予道具(id,"黑宝石",tonumber(取出[1]))
              self:给予道具(id,"舍利子",tonumber(取出[1]))
              道具使用=true
          end
  elseif string.find(名称,"级星辉礼包") then
          local 临时格子=玩家数据[id].角色:取道具格子2()
          if 临时格子<=6 then
            常规提示(id,"您的道具栏物品已经满啦")
            return 0
          end
          local 取出=分割文本(名称,"级")
          if 取出 and 取出[1] and tonumber(取出[1]) then
              self:给予道具(id,"星辉石",tonumber(取出[1]))
              道具使用=true
          end




  elseif 名称=="元宵" then
    self:元宵使用(连接id,id,内容)
    return
  elseif 名称=="炼兽真经" then
    self:炼兽真经使用(连接id,id,内容)
    return
  elseif 名称=="易经丹" then
    self:易经丹使用(连接id,id,内容)
    return
  elseif 名称=="清灵净瓶" then
    self:清灵净瓶处理(连接id,id,内容)
    return
  elseif 名称=="初级清灵仙露" or 名称=="中级清灵仙露" or 名称=="高级清灵仙露" or 名称=="超级清灵仙露" or 名称=="终级清灵仙露" then
    self:清灵仙露处理(连接id,id,内容)
    return
  elseif 名称=="玉葫灵髓" then
    self:玉葫灵髓使用(连接id,id,内容)
    return

  elseif 名称=="一级未激活符石" or 名称=="二级未激活符石" or 名称=="三级未激活符石"   then
    self:激活符石对话(id,道具id)
    return
  elseif 名称=="未激活的星石" then
    self:激活符石对话(id,道具id)
    return
  elseif 名称=="空白强化符" then
    if 玩家数据[id].角色.数据.师门技能 ~= nil then
        for n=1,#玩家数据[id].角色.数据.师门技能 do
            for i=1,#玩家数据[id].角色.数据.师门技能[n].包含技能 do
                local 技能数据 = 玩家数据[id].角色.数据.师门技能[n].包含技能[i]
                if 技能数据.名称 == "嗜血" or 技能数据.名称 == "轻如鸿毛" or 技能数据.名称 == "拈花妙指" or 技能数据.名称 == "盘丝舞"
                  or 技能数据.名称 == "一气化三清" or 技能数据.名称 == "浩然正气" or 技能数据.名称 == "龙附"  or 技能数据.名称 == "神兵护法"
                  or 技能数据.名称 == "魔王护持" or 技能数据.名称 == "莲华妙法" or 技能数据.名称 == "神力无穷" or 技能数据.名称 == "尸气漫天"
                  or 技能数据.名称 == "神木呓语" or 技能数据.名称 == "穿云破空" or 技能数据.名称 == "元阳护体" then
                    if 技能数据.等级 >=35 then
                        if 玩家数据[id].角色.数据.活力 >= 技能数据.等级 then
                              玩家数据[id].角色.数据.活力 = 玩家数据[id].角色.数据.活力 - 技能数据.等级
                              self:给予道具(id,"强化符",1,技能数据.等级,技能数据.名称)
                              道具使用 = true
                        else
                            常规提示(id,"#Y/你当前活力不足,无法使用该物品")
                            return
                        end
                    else
                        常规提示(id,"#Y/你还没学会制作强化符,无法使用该物品")
                        return
                    end
                end
            end
        end
    else
        常规提示(id,"#Y/你还没门派,无法使用该物品")
    end
  elseif 名称=="月饼" then
   if 玩家数据[id].角色.数据.月饼==nil then
      玩家数据[id].角色.数据.月饼 = 0
    end

    if 玩家数据[id].角色.数据.月饼>=服务端参数.月饼数量 then
      常规提示(id,"#Y/你食用月饼已达上限")
       return
    end
    玩家数据[id].角色.数据.月饼 = 玩家数据[id].角色.数据.月饼 + 1
    玩家数据[id].角色.数据.潜力 = 玩家数据[id].角色.数据.潜力 + 2
    道具使用=true
    常规提示(id,"#Y/你食用了一个月饼获得了#R/2#Y/点潜能,角色还可使用月饼#R/"..(服务端参数.月饼数量-玩家数据[id].角色.数据.月饼).."#Y/个")
  elseif 名称=="未鉴定的灵犀玉" then
    玩家数据[id].道具:给予道具(id,"灵犀玉")
    常规提示(id,"#Y/你获得了#R/1#Y/个灵犀玉")
    道具使用=true
   elseif 名称=="灵犀之屑" then
      发送数据(连接id,6218,self:获取道具数量(id,"灵犀之屑"))
    return
  elseif 名称=="强化符" then
    玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id,道具=玩家数据[id].道具:索要道具1(id)}
    发送数据(连接id,65,玩家数据[id].道具操作)
    return
  elseif 名称=="天眼通符" then
    if 玩家数据[id].角色:取任务(8)~=0 then
      地图处理类:跳转地图(id,任务数据[玩家数据[id].角色:取任务(8)].地图编号,任务数据[玩家数据[id].角色:取任务(8)].x,任务数据[玩家数据[id].角色:取任务(8)].y)
      任务数据[玩家数据[id].角色:取任务(8)].显示x= 任务数据[玩家数据[id].角色:取任务(8)].x
      任务数据[玩家数据[id].角色:取任务(8)].显示y= 任务数据[玩家数据[id].角色:取任务(8)].y
      道具使用=true
      常规提示(id,"#Y/你使用了天眼通符")
      玩家数据[id].角色:刷新任务跟踪()
    end
  elseif 名称=="海马" then
        if  玩家数据[id].角色.数据.体力 >= 玩家数据[id].角色.数据.最大体力 and 玩家数据[id].角色.数据.活力 >= 玩家数据[id].角色.数据.最大活力 then
           常规提示(id,"#Y/你的体力和活力已满，无法使用")
           return
        end
        玩家数据[id].角色.数据.体力 = 玩家数据[id].角色.数据.体力 + 150
        玩家数据[id].角色.数据.活力 = 玩家数据[id].角色.数据.活力 + 150
        if 玩家数据[id].角色.数据.体力 > 玩家数据[id].角色.数据.最大体力 then
            玩家数据[id].角色.数据.体力 = 玩家数据[id].角色.数据.最大体力
        end
        if 玩家数据[id].角色.数据.活力 > 玩家数据[id].角色.数据.最大活力 then
            玩家数据[id].角色.数据.活力 = 玩家数据[id].角色.数据.最大活力
        end
        体活刷新(id)
        常规提示(id,"#Y/你使用海马增加了150点体力和活力")
        道具使用 = true
  elseif 名称=="怪物卡片" then
    local 剧情等级=玩家数据[id].角色:取剧情技能等级("变化之术")
    if 剧情等级 <= 3 then
        if 剧情等级 + 1 <self.数据[道具id].等级 then
          常规提示(id,"#Y/你的变化之术等级太低了")
          return
        end
    elseif 剧情等级 == 4 then
        if 剧情等级 + 2 <self.数据[道具id].等级 then
          常规提示(id,"#Y/你的变化之术等级太低了")
          return
        end
    elseif 剧情等级 >= 5 then
        if 剧情等级 + 10 <self.数据[道具id].等级 then
          常规提示(id,"#Y/你的变化之术等级太低了")
          return
        end
    end
    if 玩家数据[id].角色:取任务(1)~=0 then
      任务数据[玩家数据[id].角色:取任务(1)]=nil
      玩家数据[id].角色:取消任务(1)
    end
    玩家数据[id].角色.数据.变身数据=self.数据[道具id].造型
    玩家数据[id].角色.数据.变异=false
    if 取随机数()<=5 then
        玩家数据[id].角色.数据.变异=true
        常规提示(id,"恭喜你！卡片产生了变异效果")
    end
        -- 应用变身卡扩展效果：超级变身卡
    -- 初始化或使用变身卡扩展处理
    if not 玩家数据[id].角色.变身卡扩展处理 then
        local 变身卡扩展处理类 = require("Script/数据中心/变身卡扩展处理类")
        玩家数据[id].角色.变身卡扩展处理 = 变身卡扩展处理类:new(id)
    end
    
    玩家数据[id].角色.变身卡扩展处理:应用变身卡扩展效果(self.数据[道具id].造型)
    常规提示(id,"#G变身卡扩展效果已激活！")
    道具使用=true
    玩家数据[id].角色:刷新信息()
    发送数据(连接id,37,{变身数据=玩家数据[id].角色.数据.变身数据,变异=玩家数据[id].角色.数据.变异})
    常规提示(id,"你使用了怪物卡片")
    发送数据(连接id,5506,{玩家数据[id].角色:取气血数据()})
    发送数据(玩家数据[id].连接id,12)
    任务处理类:添加变身(id,剧情等级)
    地图处理类:更改模型(id,{[1]=玩家数据[id].角色.数据.变身数据,[2]=玩家数据[id].角色.数据.变异},1)
  elseif 名称=="藏宝图" or 名称=="高级藏宝图" or 名称=="玲珑宝图" then
    if 取队长权限(id)==false then
      常规提示(id,"#Y/你不是队长，无法使用此道具！")
      return
    elseif self.数据[道具id].地图编号~=玩家数据[id].角色.数据.地图数据.编号 then
      常规提示(id,"#Y/这里没有宝藏哟！")
      return
    elseif math.abs(self.数据[道具id].x-玩家数据[id].角色.数据.地图数据.x/20)>2 and math.abs(self.数据[道具id].y-玩家数据[id].角色.数据.地图数据.y/20)>2 then
      常规提示(id,"#Y/这里没有宝藏哟！")
      return
    end
    道具使用=true
    if 名称=="玲珑宝图" then
       self:玲珑宝图处理(id)
   elseif 名称=="高级藏宝图" then
      self:高级藏宝图处理(id)
    else
      self:低级藏宝图处理(id)
    end
  elseif 名称=="九转金丹" then
    if 玩家数据[id].角色.数据.修炼[玩家数据[id].角色.数据.修炼.当前][1]>=玩家数据[id].角色.数据.修炼[玩家数据[id].角色.数据.修炼.当前][3] then
      常规提示(id,"#Y/你的此项修炼已经达上限")
      return
    end
    玩家数据[id].角色:添加人物修炼经验(id,math.floor(self.数据[道具id].阶品*0.5))
    道具使用=true
  elseif 名称=="修炼果" or 名称=="超级修炼果" then
    if 玩家数据[id].角色.数据.bb修炼[玩家数据[id].角色.数据.bb修炼.当前][1]>=玩家数据[id].角色.数据.bb修炼[玩家数据[id].角色.数据.bb修炼.当前][3] then
      常规提示(id,"#Y/你的此项修炼已经达上限")
      return
    end
    local 添加数额= 150
    if 名称=="超级修炼果" then
       添加数额= 1500
    end
    玩家数据[id].角色:添加bb修炼经验(id,添加数额)
    道具使用=true
  elseif 名称=="帮派银票" then
    常规提示(id,"#Y你拥有的银票，存有#R"..self.数据[道具id].初始金额.."#Y两银子#G\n#Y你需要赚到#R"..self.数据[道具id].完成金额.."#Y才可以完成任务")
    return
  elseif 名称=="月华露" then
    if 内容.窗口~="召唤兽" or 玩家数据[id].召唤兽.数据[内容.序列]==nil then
      常规提示(id,"请先选中一只召唤兽")
      return
    end
      if 玩家数据[id].召唤兽.数据[内容.序列].等级 >= 185  then
      常规提示(id,"该召唤兽已满级，无法使用该道具")
      return
    end
    if 玩家数据[id].召唤兽.数据[内容.序列].等级 >= 玩家数据[id].角色.数据.等级 + 10  then
      常规提示(id,"该召唤兽已超过人物等级10级，无法使用该道具")
      return
    end
      local 临时等级=玩家数据[id].召唤兽.数据[内容.序列].等级
      if 临时等级==0 then
        临时等级=1
      end
      玩家数据[id].召唤兽:添加经验(连接id,id,内容.序列,self.数据[道具id].阶品*50*临时等级,true)

      道具使用=true

  elseif 名称=="钟馗令牌" then
       玩家数据[id].角色.数据.自动抓鬼 = 玩家数据[id].角色.数据.自动抓鬼+ 50
       常规提示(id,"#Y/你获得了#R/50#Y/次自动抓鬼")
       道具使用=true

   elseif 名称=="宠物饰品通用丹" then
          if 内容.窗口~="召唤兽" or 玩家数据[id].召唤兽.数据[内容.序列]==nil then
            常规提示(id,"请先选中一只召唤兽")
            return
          -- elseif 玩家数据[id].召唤兽.数据[内容.序列].种类=="神兽" then
          -- 常规提示(id,"神兽不能使用")
          -- return
          elseif 玩家数据[id].召唤兽.数据[内容.序列].饰品=="宠物饰品通用丹" then
                常规提示(id,"已经携带过饰品了!")
                return
          elseif 玩家数据[id].召唤兽.数据[内容.序列].等级>=0 then
                 玩家数据[id].召唤兽.数据[内容.序列].饰品=self.数据[道具id].名称
                 玩家数据[id].召唤兽:刷新信息(内容.序列)
                 常规提示(id,"佩戴召唤兽饰品成功！")
                 道具使用=true
         end
      elseif 名称=="解封丹" then
          if 内容.窗口~="召唤兽" or 玩家数据[id].召唤兽.数据[内容.序列]==nil then
            常规提示(id,"请先选中一只召唤兽")
            return
           elseif 玩家数据[id].召唤兽.数据[内容.序列].种类=="神兽" then
           常规提示(id,"神兽不能使用此物品,需要神兽饰品丹")
           return
           elseif 玩家数据[id].召唤兽.数据[内容.序列].内丹.内丹上限== 6 then
           常规提示(id,"这只召唤兽没有可解锁的内丹格子")
           return
           elseif 取随机数()<=38 then
           玩家数据[id].召唤兽.数据[内容.序列].内丹.内丹上限 = 玩家数据[id].召唤兽.数据[内容.序列].内丹.内丹上限 + 1
           玩家数据[id].召唤兽.数据[内容.序列].内丹.可用内丹 = 玩家数据[id].召唤兽.数据[内容.序列].内丹.可用内丹 + 1
           玩家数据[id].召唤兽:刷新信息(内容.序列)
           常规提示(id,"解封召唤兽内丹格子成功！")
           发送数据(连接id,16,玩家数据[id].召唤兽.数据)
           道具使用=true
           else
           常规提示(id,"解封召唤兽内丹格子失败！")
           道具使用=true
         end
 elseif 名称=="普通宝宝饰品丹" then
          if 内容.窗口~="召唤兽" or 玩家数据[id].召唤兽.数据[内容.序列]==nil then
            常规提示(id,"请先选中一只召唤兽")
            return
           elseif 玩家数据[id].召唤兽.数据[内容.序列].种类=="神兽" then
           常规提示(id,"神兽不能使用此物品,需要神兽饰品丹")
           return
          elseif 玩家数据[id].召唤兽.数据[内容.序列].饰品=="普通宝宝饰品丹" then
          常规提示(id,"已经携带过饰品了!")
          return
          elseif 玩家数据[id].召唤兽.数据[内容.序列].等级>=0 then
           玩家数据[id].召唤兽.数据[内容.序列].饰品=self.数据[道具id].名称
           玩家数据[id].召唤兽:刷新信息(内容.序列)
           常规提示(id,"佩戴召唤兽饰品成功！")
           道具使用=true
         end

  elseif 名称=="神兽宝宝饰品丹" then
          if 内容.窗口~="召唤兽" or 玩家数据[id].召唤兽.数据[内容.序列]==nil then
            常规提示(id,"请先选中一只召唤兽")
            return
           elseif 玩家数据[id].召唤兽.数据[内容.序列].种类=="宝宝" or  玩家数据[id].召唤兽.数据[内容.序列].种类=="变异"or  玩家数据[id].召唤兽.数据[内容.序列].种类=="野怪" or  玩家数据[id].召唤兽.数据[内容.序列].种类=="孩子" then
           常规提示(id,"此物品只能用于神兽")
           return
          elseif 玩家数据[id].召唤兽.数据[内容.序列].饰品=="神兽宝宝饰品丹" then
          常规提示(id,"已经携带过饰品了!")
          return
          elseif 玩家数据[id].召唤兽.数据[内容.序列].等级>=0 then
           玩家数据[id].召唤兽.数据[内容.序列].饰品=self.数据[道具id].名称
           玩家数据[id].召唤兽:刷新信息(内容.序列)
           常规提示(id,"佩戴召唤兽饰品成功！")
           道具使用=true
         end

  elseif 名称=="坐骑内丹" then
    if 内容.窗口~="坐骑" or 玩家数据[id].角色.数据.坐骑列表[内容.序列]==nil then
      常规提示(id,"请先选中一只坐骑")
      return
    else
      local 数量 = 取随机数(1,3)
      local 坐骑技能 = {}
      local ms = {"反震","吸血","反击","连击","飞行","感知","再生","冥思","慧根","必杀","幸运","神迹","招架","永恒","偷袭","毒","驱鬼","鬼魂术","魔之心","神佑复生","精神集中","法术连击","法术暴击","法术波动","土属性吸收","火属性吸收","水属性吸收"}
      for i=1,数量 do
        local 随机技能 = 取随机数(1,#ms)
          table.insert(坐骑技能,ms[随机技能])
          table.remove(ms,随机技能)
      end
      玩家数据[id].角色.数据.坐骑列表[内容.序列].技能 = 坐骑技能
      玩家数据[id].角色.数据.坐骑列表[内容.序列].技能等级={}
      玩家数据[id].角色.数据.坐骑列表[内容.序列].技能点 = math.ceil(玩家数据[id].角色.数据.坐骑列表[内容.序列].等级/20)
      常规提示(id,"你的坐骑重新领悟了技能，并且技能点已经重置")
      发送数据(玩家数据[id].连接id,61.1,{编号=内容.序列,数据=玩家数据[id].角色.数据.坐骑列表[内容.序列]})
      道具使用=true
    end
  elseif 名称=="翡翠琵琶" then
    -- if 玩家数据[id].角色.数据.炼丹灵气 == nil then
    --   玩家数据[id].角色.数据.炼丹灵气 = 5000
    -- else
    --   玩家数据[id].角色.数据.炼丹灵气 = 玩家数据[id].角色.数据.炼丹灵气 + 5000
    -- end
    -- 常规提示(id,"你使用了翡翠琵琶,当前可用炼丹灵气为#R".. 玩家数据[id].角色.数据.炼丹灵气 .."#Y点")
    -- 道具使用=true
  elseif 名称=="镇妖拘魂铃" then
    self:刷新铃铛奖励(id)
    发送数据(连接id,3900,{物品id=道具id,铃铛个数=self.数据[道具id].数量,奖励数据=铃铛记录[id]})
	  return
  elseif 名称=="金砂丹" or 名称=="银砂丹" or 名称 == "铜砂丹" then
    local 获得物品={}
    local 取编号=取随机数(1,#获得物品)
    if 名称=="金砂丹" then
      玩家数据[id].角色:自定义银子添加("金砂锦盒",1)
        local 获得物品={}
        for i=1,#自定义数据.金砂锦盒 do
          if 取随机数()<=自定义数据.金砂锦盒[i].概率 then
             获得物品[#获得物品+1]=自定义数据.金砂锦盒[i]
          end
        end
        获得物品=删除重复(获得物品)
        if 获得物品~=nil then
            if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
                玩家数据[id].道具:自定义给予道具(id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
               广播消息({内容=format("#S(金砂丹锦盒)#R/%s#Y打开金砂丹锦盒获得了#G%s#Y奖励",玩家数据[id].角色.数据.名称,获得物品[取编号].名称),频道="xt"})
            end
          end
    elseif 名称=="银砂丹" then
        玩家数据[id].角色:自定义银子添加("银砂锦盒",1)
        local 获得物品={}
        for i=1,#自定义数据.银砂锦盒 do
          if 取随机数()<=自定义数据.银砂锦盒[i].概率 then
             获得物品[#获得物品+1]=自定义数据.银砂锦盒[i]
          end
        end
        获得物品=删除重复(获得物品)
        if 获得物品~=nil then
            if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
                玩家数据[id].道具:自定义给予道具(id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
               广播消息({内容=format("#S(银砂丹锦盒)#R/%s#Y打开银砂丹锦盒获得了#G%s#Y奖励",玩家数据[id].角色.数据.名称,获得物品[取编号].名称),频道="xt"})
            end
          end
    elseif 名称=="铜砂丹" then
         玩家数据[id].角色:自定义银子添加("铜砂锦盒",1)
        local 获得物品={}
        for i=1,#自定义数据.铜砂锦盒 do
          if 取随机数()<=自定义数据.铜砂锦盒[i].概率 then
             获得物品[#获得物品+1]=自定义数据.铜砂锦盒[i]
          end
        end
        获得物品=删除重复(获得物品)
        if 获得物品~=nil then
            if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
                玩家数据[id].道具:自定义给予道具(id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
               广播消息({内容=format("#S(铜砂丹锦盒)#R/%s#Y打开铜砂丹锦盒获得了#G%s#Y奖励",玩家数据[id].角色.数据.名称,获得物品[取编号].名称),频道="xt"})
            end
          end
       end

    道具使用=true

  elseif self.数据[道具id].总类 == 200 then
        if 玩家数据[id].房屋.是否创建  then
            if 玩家数据[id].角色.数据.地图数据.编号  ==  玩家数据[id].房屋.房屋ID then
               local 编号 = #玩家数据[id].房屋.室内装饰 + 1
                玩家数据[id].房屋.室内装饰[编号] = {x=0,y=0,名称=名称,方向=1,编号=编号}
               发送数据(玩家数据[id].连接id,1027,{玩家数据[id].房屋.室内装饰[编号]})
               道具使用=true
             elseif 玩家数据[id].角色.数据.地图数据.编号  ==  玩家数据[id].房屋.阁楼ID  then
                    local 编号 = #玩家数据[id].房屋.阁楼装饰 + 1
                    玩家数据[id].房屋.阁楼装饰[编号] = {x=0,y=0,名称=名称,方向=1,编号=编号}
                    发送数据(玩家数据[id].连接id,1027,{玩家数据[id].房屋.阁楼装饰[编号]})
                    道具使用=true
            else
              常规提示(id,"这不是你的房子或者不是室内")
              return
            end
        else
            常规提示(id,"你还没有房子")
            return
        end

    elseif 名称=="如意符" then
          local 所在地图 = 玩家数据[id].角色.数据.地图数据.编号
          if 玩家数据[id].房屋.是否创建  then
             if 所在地图 == 玩家数据[id].房屋.房屋ID or 所在地图 == 玩家数据[id].房屋.阁楼ID or 所在地图== 玩家数据[id].房屋.庭院ID or 所在地图 == 玩家数据[id].房屋.牧场ID then
                发送数据(玩家数据[id].连接id,1028)
                道具使用=true
             else
              常规提示(id,"这不是你的房子")
              return
            end
          else
              常规提示(id,"你还没有房子")
              return
          end
    elseif self.数据[道具id].总类 == 202 then
      if 玩家数据[id].房屋.是否创建  then
        if 玩家数据[id].角色.数据.地图数据.编号  ==  玩家数据[id].房屋.庭院ID then
           local 编号 = #玩家数据[id].房屋.庭院装饰 + 1
           玩家数据[id].房屋.庭院装饰[编号] = {x=0,y=0,名称=名称,方向=1,编号=编号}
           发送数据(玩家数据[id].连接id,1027,{玩家数据[id].房屋.庭院装饰[编号]})
           道具使用=true
         elseif 玩家数据[id].角色.数据.地图数据.编号  ==  玩家数据[id].房屋.牧场ID  then
                local 编号 = #玩家数据[id].房屋.牧场装饰 + 1
                玩家数据[id].房屋.牧场装饰[编号] = {x=0,y=0,名称=名称,方向=1,编号=编号}
              发送数据(玩家数据[id].连接id,1027,{玩家数据[id].房屋.牧场装饰[编号]})
              道具使用=true
        else
          常规提示(id,"这不是你的房子或者不是庭院和牧场")
          return
        end
      else
          常规提示(id,"你还没有房子")
          return
      end

    elseif 名称=="一级法宝碎片"  then
        local 临时格子=玩家数据[id].角色:取道具格子()
        if 临时格子==0 then
           常规提示(id,"你的背包已满！")
          return
        end
        if self.数据[道具id].数量 < 99 then
          常规提示(id,"必须集齐99个才可以使用哟")
          return
        end
        local 给与名称 ={"碧玉葫芦","五色旗盒","飞剑","拭剑石","金甲仙衣","惊魂铃","嗜血幡","风袋","九黎战鼓","盘龙壁","神行飞剑","汇灵盏","天师符","织女扇"}
        local 获得名称=给与名称[取随机数(1,#给与名称)]
        self:给予法宝(id,获得名称)
        删除数量=99
        道具使用=true
   elseif 名称=="二级法宝碎片"  then
        local 临时格子=玩家数据[id].角色:取道具格子()
        if 临时格子==0 then
           常规提示(id,"你的背包已满！")
          return
        end
        if self.数据[道具id].数量 < 99 then
          常规提示(id,"必须集齐99个才可以使用哟")
          return
        end
        local 给与名称 ={"发瘟匣","五彩娃娃","金刚杵","兽王令","摄魂","附灵玉"}
        local 获得名称=给与名称[取随机数(1,#给与名称)]
        self:给予法宝(id,获得名称)
        删除数量=99
        道具使用=true
   elseif 名称=="三级法宝碎片"  then
        local 临时格子=玩家数据[id].角色:取道具格子()
        if 临时格子==0 then
           常规提示(id,"你的背包已满！")
          return
        end
        if self.数据[道具id].数量 < 99 then
          常规提示(id,"必须集齐99个才可以使用哟")
          return
        end
        local 给与名称 ={"失心钹","五火神焰印","九幽","普渡","月光宝盒","混元伞","苍白纸人","聚宝盆","乾坤玄火塔","无尘扇","干将莫邪","慈悲","救命毫毛","伏魔天书","镇海珠","奇门五行令","月影"}
        local 获得名称=给与名称[取随机数(1,#给与名称)]
        self:给予法宝(id,获得名称)
        删除数量=99
        道具使用=true

  elseif 名称=="神兜兜"  then
    if 玩家数据[id].角色.数据.顶书概率==nil then
       玩家数据[id].角色.数据.顶书概率 = 0
    end

    if 玩家数据[id].角色.数据.顶书概率<50 then
      玩家数据[id].角色.数据.顶书概率 = 玩家数据[id].角色.数据.顶书概率 +1
      道具使用=true
      常规提示(id,"#Y/你的召唤兽增加新技能额外几率增加了#R/1%#Y/，当前额外几率#R/"..玩家数据[id].角色.数据.顶书概率.."#Y/%（召唤兽24技能以内生效）")
    else
      常规提示(id,"#Y/你的召唤兽增加新技能额外几率已达上限，洗练过召唤兽后继续使用")
       return
     end
   elseif self.数据[道具id].总类 == 144 then
          玩家数据[id].角色.数据.发言特效 = 名称
          道具使用=true


      -- if self.数据[道具id].数量 < 99 then
      --   常规提示(id,"必须集齐99个才可以使用哟")
      --   return
      -- elseif #玩家数据[id].召唤兽.数据 >= 14 then
      --   常规提示(id,"你身上没有足够的位置携带神兽了。")
      --   return
      -- end
      -- local 模型库 = {"超级土地公公","超级六耳猕猴","超级神鸡","超级玉兔","超级神猴","超级神马","超级神羊","超级筋斗云","超级神蛇","超级神狗","飞天","超级神鼠","超级神猪","超级小白龙","超级猪小戒"}
      -- local 模型 = 模型库[取随机数(1,#模型库)]
      -- local 物法 = "法系"
      -- if 取随机数()<=50 then
      --   物法 = nil
      -- end
      -- 玩家数据[id].召唤兽:添加召唤兽(模型,nil,nil,true,0,物法)
      -- 删除数量=99

      -- 常规提示(id,"#Y/你获得了一个新的召唤兽"..模型)
    end
  if 道具使用 then
    self:删除道具(连接id,id,包裹类型,道具id,道具格子,删除数量)
    道具刷新(id)
  else
  	常规提示(id,"您无法使用这样的道具")
  end
end


 function 道具处理类:删除道具(连接id,id,包裹类型,道具id,道具格子,删除数量)
          if 删除数量==nil then 删除数量=1 end
          local 识别码 =self.数据[道具id].识别码
          if self.数据[道具id].数量 then
              self.数据[道具id].数量=self.数据[道具id].数量-删除数量
              if self.数据[道具id].数量<=0 then
                  self.数据[道具id]=nil
                  玩家数据[id].角色.数据[包裹类型][道具格子]=nil
                  self:删除同类物品(识别码)
              end
          else
              if self.数据[道具id].名称=="怪物卡片" then
                   self.数据[道具id].次数=self.数据[道具id].次数-1
                    if self.数据[道具id].次数<=0 then
                        self.数据[道具id]=nil
                        玩家数据[id].角色.数据[包裹类型][道具格子]=nil
                        self:删除同类物品(识别码)
                    end
              else
                  self.数据[道具id]=nil
                  玩家数据[id].角色.数据[包裹类型][道具格子]=nil
                  self:删除同类物品(识别码)
              end
          end
end



function 道具处理类:激活符石对话(id,道具id)
  if self.数据[道具id]~=nil and  (self.数据[道具id].名称=="一级未激活符石" or self.数据[道具id].名称=="二级未激活符石" or self.数据[道具id].名称=="三级未激活符石") then
      玩家数据[id].激活符石 = 道具id
      if self.数据[道具id].名称=="一级未激活符石" then
          self.数据[道具id].级别=1
      elseif self.数据[道具id].名称=="二级未激活符石" then
           self.数据[道具id].级别=2
      elseif self.数据[道具id].名称=="三级未激活符石" then
           self.数据[道具id].级别=3
      end
      local 消耗数据 = 激活符石消耗(self.数据[道具id].级别)
      local 对话="#W/你现在要消耗"..消耗数据.体力.."点体力"..消耗数据.经验.."点经验来激活这块符石么。#Y/(激活后为专用，无法转移给他人。)"
      local xx={"确定","取消"}
        玩家数据[id].最后对话={}
      玩家数据[id].最后对话.名称="激活符石"
      玩家数据[id].最后对话.模型=玩家数据[id].角色.模型
      发送数据(玩家数据[id].连接id,1501,{名称="激活符石",模型=玩家数据[id].角色.模型,对话=对话,选项=xx})
  elseif self.数据[道具id]~=nil and self.数据[道具id].名称=="未激活的星石" then
    玩家数据[id].激活符石 = 道具id
    local 消耗数据 = 激活符石消耗(4)
    local 对话="#W/你现在要消耗"..消耗数据.体力.."点体力"..消耗数据.经验.."点经验来激活这块符石么。#Y/(激活后为专用，无法转移给他人。)"
    local xx={"确定","取消"}
      玩家数据[id].最后对话={}
    玩家数据[id].最后对话.名称="激活符石"
    玩家数据[id].最后对话.模型=玩家数据[id].角色.模型
    发送数据(玩家数据[id].连接id,1501,{名称="激活符石",模型=玩家数据[id].角色.模型,对话=对话,选项=xx})
  end
end



function 道具处理类:激活符石(id)
  local 道具id = 玩家数据[id].激活符石
  if self.数据[道具id]~=nil and  (self.数据[道具id].名称=="一级未激活符石" or self.数据[道具id].名称=="二级未激活符石" or self.数据[道具id].名称=="三级未激活符石") then
      if not  self.数据[道具id].级别 then return end
    local 消耗数据 = 激活符石消耗(self.数据[道具id].级别)
    if 玩家数据[id].角色.数据.体力 < 消耗数据.体力 then
      常规提示(id,"体力不足，无法激活符石。")
        return
    end
    if 玩家数据[id].角色:扣除经验(消耗数据.经验,nil,1) then
        玩家数据[id].角色:扣除体力(消耗数据.体力,nil,1)
           if self.数据[道具id].名称=="一级未激活符石" then
                  self:给予道具(id,一级符石[取随机数(1,#一级符石)],1)
           elseif self.数据[道具id].名称=="二级未激活符石" then
                    self:给予道具(id,二级符石[取随机数(1,#二级符石)],2)
           elseif self.数据[道具id].名称=="三级未激活符石" then
                    self:给予道具(id,三级符石[取随机数(1,#三级符石)],3)
           else
                 self:给予道具(id,一级符石[取随机数(1,#一级符石)],1)
           end
          self.数据[道具id].数量 = self.数据[道具id].数量 - 1
          if self.数据[道具id].数量<=0 then
            self.数据[道具id]=nil
          end
          添加最后对话(id,"你消耗了"..消耗数据.体力.."体力"..消耗数据.经验.."经验,将符石成功激活.这块符石可以镶嵌在已经开运过的装备上#50。")
          道具刷新(id)
      return
    else
      常规提示(id,"经验不足，无法激活符石。")
        return
    end
  elseif self.数据[道具id]~=nil and  self.数据[道具id].名称=="未激活的星石" then
    local 消耗数据 = 激活符石消耗(4)
    if 玩家数据[id].角色.数据.体力 < 消耗数据.体力 then
      常规提示(id,"体力不足，无法激活符石。")
        return
    end
    if 玩家数据[id].角色:扣除经验(消耗数据.经验,nil,1) then
      玩家数据[id].角色:扣除体力(消耗数据.体力,nil,1)
      self.数据[道具id].分类 = 91
      self.数据[道具id].不可交易 = true
      if self.数据[道具id].子类 == 1 then
        self.数据[道具id].名称 = "云荒"
      elseif self.数据[道具id].子类 == 2 then
        self.数据[道具id].名称 = "暮霭"
      elseif self.数据[道具id].子类 == 3 then
        self.数据[道具id].名称 = "落日"
      elseif self.数据[道具id].子类 == 4 then
        self.数据[道具id].名称 = "晓天"
      elseif self.数据[道具id].子类 == 5 then
        self.数据[道具id].名称 = "林海"
      elseif self.数据[道具id].子类 == 6 then
        self.数据[道具id].名称 = "流霞"
      else
        self.数据[道具id].名称 = "云荒"
      end
      添加最后对话(id,"你消耗了"..消耗数据.体力.."体力"..消耗数据.经验.."经验,将"..self.数据[道具id].名称.."成功激活.这块符石可以镶嵌在已经开运过的装备上#50。")
      道具刷新(id)
      return
    else
      常规提示(id,"经验不足，无法激活符石。")
        return
    end
  end
end

function 道具处理类:元宵使用(连接id,id,内容)
  local  临时id = 玩家数据[id].角色.数据.道具[内容.编号]

  if 内容.窗口~="召唤兽" or 玩家数据[id].召唤兽.数据[内容.序列]==nil then
      常规提示(id,"请先选中一只召唤兽")
      return
  elseif 玩家数据[id].道具.数据[临时id] == nil or 玩家数据[id].道具.数据[临时id].名称 ~= "元宵" then
      常规提示(id,"你的召唤兽无法使用该道具")
      return
  end
  if 玩家数据[id].召唤兽.数据[内容.序列].种类=="变异" then
    常规提示(id,"该类型召唤兽无法使用")
    return
  end

  local 食材 = 玩家数据[id].道具.数据[临时id].食材
   local 资质 = "攻击资质"
    if 食材 == "桂花酒酿" then
      资质 = "防御资质"
      if 玩家数据[id].召唤兽.数据[内容.序列].防御资质 >= 1700 then
        常规提示(id,"该召唤兽防御资质已达到最大,无法继续使用")
        return
      end
    elseif 食材 == "细磨豆沙" then
      资质 = "速度资质"
      if 玩家数据[id].召唤兽.数据[内容.序列].速度资质 >= 1550 then
        常规提示(id,"该召唤兽速度资质已达到最大,无法继续使用")
        return
      end
    elseif 食材 == "蜜糖腰果" then
      资质 = "躲闪资质"
       if 玩家数据[id].召唤兽.数据[内容.序列].躲闪资质 >= 1500 then
        常规提示(id,"该召唤兽躲闪资质已达到最大,无法继续使用")
        return
      end
    elseif 食材 == "山楂拔丝" then
      资质 = "体力资质"
      if 玩家数据[id].召唤兽.数据[内容.序列].体力资质 >= 4500 then
        常规提示(id,"该召唤兽体力资质已达到最大,无法继续使用")
        return
      end
    elseif 食材 == "滑玉莲蓉" then
      资质 = "法力资质"
      if 玩家数据[id].召唤兽.数据[内容.序列].法力资质 >= 3000 then
        常规提示(id,"该召唤兽法力资质已达到最大,无法继续使用")
        return
      end
    elseif 食材 == "芝麻沁香" then
      资质 = "攻击资质"
      if 玩家数据[id].召唤兽.数据[内容.序列].攻击资质 >= 1700 then
        常规提示(id,"该召唤兽攻击资质已达到最大,无法继续使用")
        return
      end
    else
      常规提示(id,"数据错误")
        return
    end
    local 上限 = 玩家数据[id].召唤兽.数据[内容.序列][资质] *0.003
    local 下限 = 玩家数据[id].召唤兽.数据[内容.序列][资质] *0.001
    local 增加数值 = math.floor(取随机数(下限,上限))
    玩家数据[id].召唤兽.数据[内容.序列][资质] = 玩家数据[id].召唤兽.数据[内容.序列][资质] + 增加数值
      if 玩家数据[id].召唤兽.数据[内容.序列].防御资质 >= 1700 then
         玩家数据[id].召唤兽.数据[内容.序列].防御资质 = 1700
      end
      if 玩家数据[id].召唤兽.数据[内容.序列].速度资质 >= 1550 then
        玩家数据[id].召唤兽.数据[内容.序列].速度资质 = 1550
      end
      if 玩家数据[id].召唤兽.数据[内容.序列].躲闪资质 >= 1500 then
        玩家数据[id].召唤兽.数据[内容.序列].躲闪资质 = 1500
      end
      if 玩家数据[id].召唤兽.数据[内容.序列].体力资质 >= 4500 then
        玩家数据[id].召唤兽.数据[内容.序列].体力资质 = 4500
      end
      if 玩家数据[id].召唤兽.数据[内容.序列].法力资质 >= 3000 then
        玩家数据[id].召唤兽.数据[内容.序列].法力资质 = 3000
      end
      if 玩家数据[id].召唤兽.数据[内容.序列].攻击资质 >= 1700 then
        玩家数据[id].召唤兽.数据[内容.序列].攻击资质 = 1700
      end

       玩家数据[id].道具.数据[临时id].数量 = 玩家数据[id].道具.数据[临时id].数量 - 1
      if 玩家数据[id].道具.数据[临时id].数量 <= 0 then
        玩家数据[id].道具.数据[临时id] = nil
        玩家数据[id].角色.数据.道具[内容.编号] = nil
     end
     常规提示(id,"恭喜你的召唤兽#R"..资质.."#W提升了#R"..增加数值.."#W点")
     玩家数据[id].召唤兽:刷新信息(内容.序列)
     道具刷新(id)



end



function 道具处理类:炼兽真经使用(连接id,id,内容)
  local 临时id = 玩家数据[id].角色.数据.道具[内容.编号]
  if 内容.窗口~="召唤兽" or 玩家数据[id].召唤兽.数据[内容.序列]==nil then
    常规提示(id,"请先选中一只召唤兽")
    return
  elseif 玩家数据[id].道具.数据[临时id] == nil or 玩家数据[id].道具.数据[临时id].名称 ~= "炼兽真经" then
    常规提示(id,"你的召唤兽无法使用该道具")
    return
  end
  if 玩家数据[id].召唤兽.数据[内容.序列].种类=="变异" then
    常规提示(id,"该类型召唤兽无法使用")
    return
  end

  if 玩家数据[id].召唤兽.数据[内容.序列].成长>=1.45 then
    常规提示(id,"该召唤兽成长已经够高了,已经无法再使用炼兽真经")
    return
  end

   local 增加数值 = math.floor(取随机数(1,20))/10000
    玩家数据[id].召唤兽.数据[内容.序列].成长 = 玩家数据[id].召唤兽.数据[内容.序列].成长 + 增加数值
   if 玩家数据[id].召唤兽.数据[内容.序列].成长>=1.45 then
      玩家数据[id].召唤兽.数据[内容.序列].成长=1.45
      常规提示(id,"#Y使用炼兽真经召唤兽成长最多只能到1.45")
    end

  if 玩家数据[id].道具.数据[临时id].数量 == nil then
    玩家数据[id].道具.数据[临时id].数量 = 1
  end
  玩家数据[id].道具.数据[临时id].数量=玩家数据[id].道具.数据[临时id].数量-1
  if 玩家数据[id].道具.数据[临时id].数量 <= 0 then
    玩家数据[id].道具.数据[临时id] = nil
    玩家数据[id].角色.数据.道具[内容.编号] = nil
  end
  常规提示(id,"恭喜你的召唤兽#R成长#W提升了#R"..增加数值.."#W点")
  玩家数据[id].召唤兽:刷新信息(内容.序列)
  道具刷新(id)
end



function 道具处理类:易经丹使用(连接id,id,内容)
  local 临时id = 玩家数据[id].角色.数据.道具[内容.编号]
  if 内容.窗口~="召唤兽" or 玩家数据[id].召唤兽.数据[内容.序列]==nil then
      常规提示(id,"请先选中一只召唤兽")
      return
  end
  if 玩家数据[id].召唤兽.数据[内容.序列].种类 == "野怪" then
      常规提示(id,"该物品不能对野怪使用")
      return
  end
  if 玩家数据[id].召唤兽.数据[内容.序列].灵性 < 50 and (玩家数据[id].召唤兽.数据[内容.序列].参战等级 >= 0 or 玩家数据[id].召唤兽.数据[内容.序列].种类 == "神兽") then
      玩家数据[id].召唤兽.数据[内容.序列].灵性 = 玩家数据[id].召唤兽.数据[内容.序列].灵性 + 10
      常规提示(id,"你的召唤兽"..玩家数据[id].召唤兽.数据[内容.序列].名称.."服用了一个易经丹,神清气爽,仙气缭绕,修为增加！")
      if 玩家数据[id].召唤兽.数据[内容.序列].灵性 >= 50 then
          常规提示(id,"你的召唤兽"..玩家数据[id].召唤兽.数据[内容.序列].模型.."已经达到了进阶的条件,可以进阶改变造型了")
      end
      if 玩家数据[id].道具.数据[临时id].数量==nil then
         玩家数据[id].道具.数据[临时id] = nil
         玩家数据[id].角色.数据.道具[内容.编号] = nil
      else
          玩家数据[id].道具.数据[临时id].数量 = 玩家数据[id].道具.数据[临时id].数量 - 1
          if 玩家数据[id].道具.数据[临时id].数量<=0 then
             玩家数据[id].道具.数据[临时id] = nil
             玩家数据[id].角色.数据.道具[内容.编号] = nil
          end
      end
      道具刷新(id)
  elseif 玩家数据[id].召唤兽.数据[内容.序列].灵性 > 79 then
      local 随机特性={"复仇","自恋","灵刃","灵法","预知","灵动","瞬击","瞬法","抗法","抗物","阳护","识物","护佑","洞察","弑神","御风","顺势","怒吼","乖巧","力破","识药","争锋","灵断"}
      local a =随机特性[取随机数(1,#随机特性)]
      玩家数据[id].召唤兽.数据[内容.序列].特性 = a
      玩家数据[id].召唤兽.数据[内容.序列].特性几率 = 取随机数(1,5)
      常规提示(id,"你的召唤兽#R/"..玩家数据[id].召唤兽.数据[内容.序列].名称.."#Y/领悟了#R/"..a)
      if 玩家数据[id].道具.数据[临时id].数量==nil then
         玩家数据[id].道具.数据[临时id] = nil
         玩家数据[id].角色.数据.道具[内容.编号] = nil
      else
          玩家数据[id].道具.数据[临时id].数量 = 玩家数据[id].道具.数据[临时id].数量 - 1
          if 玩家数据[id].道具.数据[临时id].数量<=0 then
             玩家数据[id].道具.数据[临时id] = nil
             玩家数据[id].角色.数据.道具[内容.编号] = nil
          end
      end
      玩家数据[id].召唤兽:刷新信息(内容.序列)
      道具刷新(id)
  else
      常规提示(id,"召唤兽灵性没有达到80,无法使用该物品，请用清灵净瓶提升灵性！")
      玩家数据[id].召唤兽:刷新信息(内容.序列)
  end
end

function 道具处理类:清灵净瓶处理(连接id,id,内容)
  local 临时id = 玩家数据[id].角色.数据.道具[内容.编号]
  local 道具格子=玩家数据[id].角色:取道具格子()
  if 道具格子==0 then
    常规提示(id,"您的道具栏物品已经满啦")
    return
  end
  if 玩家数据[id].道具.数据[临时id].数量==nil then
         玩家数据[id].道具.数据[临时id] = nil
         玩家数据[id].角色.数据.道具[内容.编号] = nil
  else
         玩家数据[id].道具.数据[临时id].数量 = 玩家数据[id].道具.数据[临时id].数量 - 1
      if 玩家数据[id].道具.数据[临时id].数量<=0 then
         玩家数据[id].道具.数据[临时id] = nil
         玩家数据[id].角色.数据.道具[内容.编号] = nil
      end
  end
  local 随机瓶子={"高级清灵仙露","中级清灵仙露","初级清灵仙露"}
  local a =随机瓶子[取随机数(1,#随机瓶子)]
  self:给予道具(id,a)
  道具刷新(id)
end

function 道具处理类:清灵仙露处理(连接id,id,内容)
  local 临时id = 玩家数据[id].角色.数据.道具[内容.编号]
  if 内容.窗口~="召唤兽" or 玩家数据[id].召唤兽.数据[内容.序列]==nil then
      常规提示(id,"请先选中一只召唤兽")
      return
  end
  if 玩家数据[id].召唤兽.数据[内容.序列].种类 == "野怪" then
      常规提示(id,"该物品不能对野怪使用")
      return
  end
  local 道具名称 = 玩家数据[id].道具.数据[临时id].名称

   if 道具名称 ~= "高级清灵仙露" and 道具名称 ~= "中级清灵仙露" and 道具名称 ~= "初级清灵仙露" and 道具名称 ~= "超级清灵仙露" and 道具名称~="终级清灵仙露"  then
        常规提示(id,"抱歉,请正确使用清灵仙露!")
        return
    end

    if 玩家数据[id].召唤兽.数据[内容.序列].灵性 >= 100 then
        常规提示(id,"该召唤兽已无法再使用清灵仙露")
        return
    end



  if 玩家数据[id].召唤兽.数据[内容.序列].灵性 >= 50 and 玩家数据[id].召唤兽.数据[内容.序列].仙露上限 >0 then

      local 临时灵性 = 0
      local 当前灵性 = math.floor(玩家数据[id].道具.数据[临时id].灵气)
      if not 当前灵性 or 当前灵性<=1 then
         当前灵性=1
      end
      if  道具名称 == "终级清灵仙露" then
              临时灵性= 110-玩家数据[id].召唤兽.数据[内容.序列].灵性
      elseif  道具名称 == "超级清灵仙露" then
               临时灵性 = 99-玩家数据[id].召唤兽.数据[内容.序列].灵性
      elseif 道具名称 == "初级清灵仙露" then
                临时灵性=取随机数(当前灵性-1,当前灵性)
      elseif 道具名称 == "中级清灵仙露" then
                临时灵性=取随机数(当前灵性-2,当前灵性+2)
      elseif 道具名称 == "高级清灵仙露" then
              if 当前灵性>=8 then
                  临时灵性=取随机数(当前灵性-1,当前灵性+4)
              else
                  临时灵性=取随机数(当前灵性-1,当前灵性+3)
              end
      end
      if 玩家数据[id].召唤兽.数据[内容.序列].灵性 + 临时灵性>=110 then
          临时灵性 = 110-玩家数据[id].召唤兽.数据[内容.序列].灵性
      end
      玩家数据[id].召唤兽.数据[内容.序列].潜力 = 玩家数据[id].召唤兽.数据[内容.序列].潜力 + 临时灵性*2
      玩家数据[id].召唤兽.数据[内容.序列].灵性 = 玩家数据[id].召唤兽.数据[内容.序列].灵性 + 临时灵性
      常规提示(id,"你的召唤兽"..玩家数据[id].召唤兽.数据[内容.序列].名称.."增加了#R"..临时灵性.."#Y点灵性，当前灵力为#R"..玩家数据[id].召唤兽.数据[内容.序列].灵性.."#Y点")
      if 玩家数据[id].召唤兽.数据[内容.序列].灵性 >= 110 then
        玩家数据[id].召唤兽.数据[内容.序列].灵性  = 110
        玩家数据[id].召唤兽.数据[内容.序列].进阶属性={}
        玩家数据[id].召唤兽.数据[内容.序列].进阶属性.力量 = 110
        玩家数据[id].召唤兽.数据[内容.序列].进阶属性.魔力 = 110
        玩家数据[id].召唤兽.数据[内容.序列].进阶属性.体质 = 110
        玩家数据[id].召唤兽.数据[内容.序列].进阶属性.敏捷 = 110
        玩家数据[id].召唤兽.数据[内容.序列].进阶属性.耐力 = 110
        常规提示(id,"你的召唤兽"..玩家数据[id].召唤兽.数据[内容.序列].名称.."的进阶属性增加了")
      end
      if 玩家数据[id].道具.数据[临时id].数量==nil then
         玩家数据[id].道具.数据[临时id] = nil
         玩家数据[id].角色.数据.道具[内容.编号] = nil
      else
          玩家数据[id].道具.数据[临时id].数量 = 玩家数据[id].道具.数据[临时id].数量 - 1
          if 玩家数据[id].道具.数据[临时id].数量<=0 then
             玩家数据[id].道具.数据[临时id] = nil
             玩家数据[id].角色.数据.道具[内容.编号] = nil
          end
      end
      玩家数据[id].召唤兽.数据[内容.序列].仙露上限 = 玩家数据[id].召唤兽.数据[内容.序列].仙露上限 - 1
      常规提示(id,"你的召唤兽可以继续服用"..玩家数据[id].召唤兽.数据[内容.序列].仙露上限.."个清灵仙露")
      玩家数据[id].召唤兽:刷新信息(内容.序列)
      道具刷新(id)
  else
      if 玩家数据[id].召唤兽.数据[内容.序列].仙露上限 == 0 then
          常规提示(id,"该召唤兽已使用8瓶清灵仙露!")
      else
          常规提示(id,"你的召唤兽灵性必须达到50以上才能使用清灵仙露!")
      end
      玩家数据[id].召唤兽:刷新信息(内容.序列)
  end
end

function 道具处理类:玉葫灵髓使用(连接id,id,内容)
  local 临时id = 玩家数据[id].角色.数据.道具[内容.编号]
  if 内容.窗口~="召唤兽" or 玩家数据[id].召唤兽.数据[内容.序列]==nil then
      常规提示(id,"请先选中一只召唤兽")
      return
  end
  if 玩家数据[id].召唤兽.数据[内容.序列].种类 == "野怪" then
      常规提示(id,"该物品不能对野怪使用")
      return
  end
  if 玩家数据[id].召唤兽.数据[内容.序列].灵性 > 50 and (玩家数据[id].召唤兽.数据[内容.序列].参战等级 >= 0 or 玩家数据[id].召唤兽.数据[内容.序列].种类 == "神兽") then
      常规提示(id,"该召唤兽被重置了属性点！")
      玩家数据[id].召唤兽.数据[内容.序列].灵性 = 50
      玩家数据[id].召唤兽.数据[内容.序列].进阶属性={}
      玩家数据[id].召唤兽.数据[内容.序列].进阶属性.力量 = 0
      玩家数据[id].召唤兽.数据[内容.序列].进阶属性.魔力 = 0
      玩家数据[id].召唤兽.数据[内容.序列].进阶属性.体质 = 0
      玩家数据[id].召唤兽.数据[内容.序列].进阶属性.敏捷 = 0
      玩家数据[id].召唤兽.数据[内容.序列].进阶属性.耐力 = 0
      玩家数据[id].召唤兽.数据[内容.序列].加点记录={力量= 0,魔力= 0,体质= 0,敏捷= 0,耐力= 0}
      玩家数据[id].召唤兽.数据[内容.序列].潜力 = 玩家数据[id].召唤兽.数据[内容.序列].等级*5+玩家数据[id].召唤兽.数据[内容.序列].灵性*2
      玩家数据[id].召唤兽.数据[内容.序列].特性 = "无"
      玩家数据[id].召唤兽.数据[内容.序列].仙露上限 = 8
      玩家数据[id].召唤兽:刷新信息(内容.序列)
      常规提示(id,"你的召唤兽#R/"..玩家数据[id].召唤兽.数据[内容.序列].名称.."#Y/服用一个玉葫灵髓后,灵性已回归原始！")
      if 玩家数据[id].道具.数据[临时id].数量==nil then
         玩家数据[id].道具.数据[临时id] = nil
         玩家数据[id].角色.数据.道具[内容.编号] = nil
      else
          玩家数据[id].道具.数据[临时id].数量 = 玩家数据[id].道具.数据[临时id].数量 - 1
          if 玩家数据[id].道具.数据[临时id].数量<=0 then
             玩家数据[id].道具.数据[临时id] = nil
             玩家数据[id].角色.数据.道具[内容.编号] = nil
          end
      end
      玩家数据[id].召唤兽:刷新信息(内容.序列)
      道具刷新(id)
  else
      常规提示(id,"召唤兽的灵性必须大于50才能使用玉葫灵髓")
      玩家数据[id].召唤兽:刷新信息(内容.序列)
  end
end



function 道具处理类:加血处理(连接id,id,加血数值,加血对象,动画)
  if 动画==nil then
    动画="加血"
  end
  if 加血对象==0 then
    玩家数据[id].角色.数据.气血=玩家数据[id].角色.数据.气血+加血数值
    if 玩家数据[id].角色.数据.气血>玩家数据[id].角色.数据.气血上限 then
      玩家数据[id].角色.数据.气血=玩家数据[id].角色.数据.气血上限
    end
    发送数据(连接id,36,{动画=动画})
    发送数据(连接id,5506,{玩家数据[id].角色:取气血数据()})
    地图处理类:加入动画(id,玩家数据[id].角色.数据.地图数据.编号,玩家数据[id].角色.数据.地图数据.x,玩家数据[id].角色.数据.地图数据.y,动画)
  else
    玩家数据[id].召唤兽:加血处理(加血对象,加血数值,连接id,id)
  end
end

function 道具处理类:加伤势处理(连接id,id,加血数值,加血对象,动画)
  if 动画==nil then
    动画="加血"
  end
  if 加血对象==0 then
    玩家数据[id].角色.数据.气血上限=玩家数据[id].角色.数据.气血上限+加血数值
    if 玩家数据[id].角色.数据.气血上限>玩家数据[id].角色.数据.最大气血 then
      玩家数据[id].角色.数据.气血上限=玩家数据[id].角色.数据.最大气血
    end
    发送数据(连接id,36,{动画=动画})
    发送数据(连接id,5506,{玩家数据[id].角色:取气血数据()})
    地图处理类:加入动画(id,玩家数据[id].角色.数据.地图数据.编号,玩家数据[id].角色.数据.地图数据.x,玩家数据[id].角色.数据.地图数据.y,动画)
  else
	return
  end
end

function 道具处理类:加魔处理(连接id,id,加血数值,加血对象)
  if 加血对象==0 then
    玩家数据[id].角色.数据.魔法=玩家数据[id].角色.数据.魔法+加血数值
    if 玩家数据[id].角色.数据.魔法>玩家数据[id].角色.数据.最大魔法 then
      玩家数据[id].角色.数据.魔法=玩家数据[id].角色.数据.最大魔法
    end
    发送数据(连接id,36,{动画="加蓝"})
    发送数据(连接id,5506,{玩家数据[id].角色:取气血数据()})
    地图处理类:加入动画(id,玩家数据[id].角色.数据.地图数据.编号,玩家数据[id].角色.数据.地图数据.x,玩家数据[id].角色.数据.地图数据.y,"加蓝")
  else
    玩家数据[id].召唤兽:加蓝处理(加血对象,加血数值,连接id,id)
  end
end

function 道具处理类:取飞行限制(id)
  local 地图=玩家数据[id].角色.数据.地图数据.编号
  if 玩家数据[id].队伍~=0 and 玩家数据[id].队长==false then
      常规提示(id,"只有队长才可以使用飞行道具")
      return true
  elseif self:取禁止飞行(id) then
    常规提示(id,"#Y/您当前无法使用飞行道具")
    return true
  elseif 玩家数据[id].角色.数据.等级<10 then
    常规提示(id,"#Y/您当前等级太低了无法使用飞行道具")
    return true
  elseif 玩家数据[id].队伍~=0 and 玩家数据[id].队长 then
    local 队伍id=玩家数据[id].队伍
    for n=1,#队伍数据[队伍id].成员数据 do
      if self:取禁止飞行(队伍数据[队伍id].成员数据[n]) then
        常规提示(id,format("#G/%s当前不能使用飞行道具",玩家数据[队伍数据[队伍id].成员数据[n]].角色.数据.名称))
        return true
      end
    end
  end
  return false
end

function 道具处理类:取禁止飞行(id)
  if 玩家数据[id].摊位数据~=nil then return true end
  local 任务id=玩家数据[id].角色:取任务(110)
  local 地图=玩家数据[id].角色.数据.地图数据.编号
  if 任务id~=0 and 任务数据[任务id].分类==2 then return true  end
  if 玩家数据[id].角色:取任务(208)~=0 or 玩家数据[id].角色:取任务(300)~=0 or 玩家数据[id].角色.数据.跑商 or 地图==6009 or 地图==6010 or (地图>=6012 and 地图<=6019) then return true end
  return false
 end



function 道具处理类:给予随机法宝(id)
  local 参数=取随机数()
  local 名称=""
  local 等级=0
  if 参数<=30 then
   名称={"碧玉葫芦","五色旗盒","飞剑","拭剑石","金甲仙衣","惊魂铃","嗜血幡","风袋","九黎战鼓","盘龙壁","神行飞剑","汇灵盏","天师符","织女扇"}
   等级=1
  elseif 参数<=65 then
   名称={"发瘟匣","五彩娃娃","金刚杵","兽王令","摄魂","附灵玉"}
   等级=2
  else
   名称={"失心钹","五火神焰印","九幽","普渡","月光宝盒","混元伞","苍白纸人","聚宝盆","乾坤玄火塔","无尘扇","干将莫邪","慈悲","救命毫毛","伏魔天书","镇海珠","奇门五行令","月影"}
   等级=3
  end
  名称=名称[取随机数(1,#名称)]
  self:给予法宝(id,名称)
end

function 道具处理类:给予随机一级法宝(id)
  local 名称=""
  local 等级=0
  名称={"定风珠","雷兽","迷魂灯","幽灵珠","缚妖索","碧玉葫芦","五色旗盒","飞剑","拭剑石","金甲仙衣","惊魂铃","嗜血幡","风袋","九黎战鼓","盘龙壁","神行飞剑","汇灵盏","天师符","织女扇","清心咒"}
  等级=1
  名称=名称[取随机数(1,#名称)]
  self:给予法宝(id,名称)
end
function 道具处理类:给予随机全法宝(id)
  local 名称=""
  local 等级=0
  名称={"碧玉葫芦","五色旗盒","飞剑","拭剑石","金甲仙衣","惊魂铃","嗜血幡","风袋","九黎战鼓","盘龙壁","神行飞剑","汇灵盏","天师符","织女扇","发瘟匣","五彩娃娃","金刚杵","兽王令","摄魂","附灵玉","失心钹","五火神焰印","九幽","普渡","月光宝盒","混元伞","苍白纸人","聚宝盆","乾坤玄火塔","无尘扇","干将莫邪","慈悲","救命毫毛","伏魔天书","镇海珠","奇门五行令","月影","流影云笛","宿幕星河","蟠龙玉璧","落星飞鸿","归元圣印","千斗金樽"}
  等级=1
  名称=名称[取随机数(1,#名称)]
  self:给予法宝(id,名称)
end

function 道具处理类:给予法宝(id,名称)
  local 识别码=取唯一识别码(id)
  local 道具格子=玩家数据[id].角色:取道具格子()
  if 道具格子==0 then
    常规提示(id,"您的道具栏已经满啦")
    return
  end
  道具id=self:取新编号()
  self.数据[道具id]=物品类()
  self.数据[道具id]:置对象(名称)
  self.数据[道具id].识别码=识别码
  玩家数据[id].角色.数据.道具[道具格子]=道具id
  local 道具 = 取物品数据(名称)
  self.数据[道具id].总类=1000
  self.数据[道具id].分类 = 道具[3]
  self.数据[道具id].使用 = 道具[5]
  self.数据[道具id].特技 = 道具[6]
  self.数据[道具id].气血 = 0
  self.数据[道具id].魔法 = 取灵气上限(道具[3])
  self.数据[道具id].角色限制 = 道具[7] or 0
  self.数据[道具id].五行 = 取五行()
  self.数据[道具id].伤害 = 道具[8] or 0
  self.数据[道具id].当前经验=0
  self.数据[道具id].升级经验=法宝经验[self.数据[道具id].分类][1]
  玩家数据[id].角色:日志记录(format("获得新法宝：名称%s,识别码%s",名称,识别码))
  常规提示(id,"#Y你获得了新的法宝#R"..名称)
end

function 道具处理类:给予灵宝(id,名称)
  local 识别码=取唯一识别码(id)
  local 道具格子=玩家数据[id].角色:取道具格子()
  if 道具格子==0 then
    常规提示(id,"您的道具栏已经满啦")
    return
  end
  道具id=self:取新编号()
  self.数据[道具id]=物品类()
  self.数据[道具id]:置对象(名称)
  self.数据[道具id].识别码=识别码
  玩家数据[id].角色.数据.道具[道具格子]=道具id
  local 道具 = 取物品数据(名称)
  self.数据[道具id].总类=1005
  self.数据[道具id].分类 = 道具[3]
  self.数据[道具id].使用 = 道具[5]
  self.数据[道具id].特技 = 道具[6]
  self.数据[道具id].气血 = 0
  self.数据[道具id].魔法 = 取灵气上限(道具[3])
  self.数据[道具id].角色限制 = 道具[7] or 0
  self.数据[道具id].五行 = 取五行()
  self.数据[道具id].伤害 = 道具[8] or 0
  self.数据[道具id].当前经验=0
  self.数据[道具id].升级经验=法宝经验[self.数据[道具id].分类][1]
  玩家数据[id].角色:日志记录(format("获得新灵宝：名称%s,识别码%s",名称,识别码))
  常规提示(id,"#Y你获得了新的法宝#R"..名称)
end


function 道具处理类:自定义给予道具(id,名称,数量,参数)

  if 名称=="钨金" or 名称=="附魔宝珠" or 名称=="超级附魔宝珠" or 名称=="炼妖石" or 名称=="天眼珠" or 名称=="上古锻造图策" then
     self:给予道具(id,名称,数量,参数)
     if 玩家数据[id].抽中编号~=nil then
         广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,名称),频道="xt"})
     elseif 玩家数据[id].地宫编号~=nil then
          广播消息({内容=format("#S(地宫礼包)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,名称),频道="xt"})
     elseif 玩家数据[id].抽中嘉年华~=nil then
          广播消息({内容=format("#S(嘉年华)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,名称),频道="xt"})
     end
   elseif  名称=="珍珠" or 名称=="战魂" then
     local 给予等级 = 数量[取随机数(1,#数量)]
     self:给予道具(id,名称,给予等级,参数)
     if 玩家数据[id].抽中编号~=nil then
         广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/级的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,给予等级,名称),频道="xt"})
      elseif 玩家数据[id].地宫编号~=nil then
         广播消息({内容=format("#S(地宫礼包)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/级的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,给予等级,名称),频道="xt"})
      elseif 玩家数据[id].抽中嘉年华~=nil then
         广播消息({内容=format("#S(嘉年华)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/级的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,给予等级,名称),频道="xt"})

     end
   elseif 名称=="制造指南书" or 名称=="百炼精铁" then
      local 给予等级 = 取随机数(数量[1],数量[#数量])*10
      if 参数==nil then
        if 取随机数()<=50 then
           参数= 取随机数(1,18)
        else
           参数= 取随机数(19,#书铁范围)
        end
      end

      self:给予道具(id,名称,给予等级,参数)
      if 玩家数据[id].抽中编号~=nil then
         广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/级的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,给予等级,名称),频道="xt"})
      elseif 玩家数据[id].地宫编号~=nil then
         广播消息({内容=format("#S(地宫礼包)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/级的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,给予等级,名称),频道="xt"})
      elseif 玩家数据[id].抽中嘉年华~=nil then
         广播消息({内容=format("#S(嘉年华)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/级的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,给予等级,名称),频道="xt"})

      end
   elseif  名称=="灵饰指南书" or 名称=="元灵晶石" then
      if 参数==nil then
         local 临时范围 = {"手镯","佩饰","戒指","耳饰"}
         参数= 临时范围[取随机数(1,4)]
      end
      self:给予道具(id,名称,数量,参数)
      if 玩家数据[id].抽中编号~=nil then
         广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了制作#G/%s#Y/的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,参数,名称),频道="xt"})
      elseif 玩家数据[id].地宫编号~=nil then
         广播消息({内容=format("#S(地宫礼包)#Y/恭喜玩家#R/%s#Y获得了制作#G/%s#Y/的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,参数,名称),频道="xt"})
      elseif 玩家数据[id].抽中嘉年华~=nil then
         广播消息({内容=format("#S(嘉年华)#Y/恭喜玩家#R/%s#Y获得了制作#G/%s#Y/的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,参数,名称),频道="xt"})

      end
   elseif 名称=="魔兽要诀" or 名称=="高级魔兽要诀"or 名称=="超级魔兽要诀" or 名称=="特殊魔兽要诀" or 名称=="召唤兽内丹" or 名称=="高级召唤兽内丹" or 名称=="点化石" then
         if 参数 ==nil then
           if 名称=="召唤兽内丹" then
              参数=取内丹()
           elseif 名称=="高级召唤兽内丹" then
                  参数=取内丹("高级")
           elseif 名称=="魔兽要诀" then
                  参数=取低级要诀()
           elseif 名称=="高级魔兽要诀" then
                  参数=取高级要诀()
           elseif 名称=="特殊魔兽要诀" then
                  参数=取特殊要诀()
           elseif 名称=="超级魔兽要诀" then
                  参数=取超级要诀()
           elseif 名称=="点化石" then
                  local 生成几率 = 取随机数()
                  if 生成几率<= 5 then
                     参数=取特殊要诀()
                  elseif 生成几率<= 35 and 生成几率>=6 then
                         参数=取高级要诀()
                  else
                       参数=取低级要诀()
                  end
           end
        end
           local 给予数量 = 取随机数(数量[1],数量[#数量])
           for i=1,给予数量 do
              self:给予道具(id,名称,1,参数)
           end
      if 玩家数据[id].抽中编号~=nil then
         广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了携带技能为#G/%s#Y/的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,参数,名称),频道="xt"})
       elseif 玩家数据[id].地宫编号~=nil then
         广播消息({内容=format("#S(地宫礼包)#Y/恭喜玩家#R/%s#Y获得了携带技能为#G/%s#Y/的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,参数,名称),频道="xt"})
       elseif 玩家数据[id].抽中嘉年华~=nil then
         广播消息({内容=format("#S(嘉年华)#Y/恭喜玩家#R/%s#Y获得了携带技能为#G/%s#Y/的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,参数,名称),频道="xt"})


      end
    elseif 名称=="鬼谷子"  then
           local 给予数量 = 取随机数(数量[1],数量[#数量])
           for i=1,给予数量 do
              self:给予道具(id,名称,1,参数)
           end
          if 玩家数据[id].抽中编号~=nil then
             广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,参数),频道="xt"})
           elseif 玩家数据[id].地宫编号~=nil then
             广播消息({内容=format("#S(地宫礼包)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,参数),频道="xt"})
           elseif 玩家数据[id].抽中嘉年华~=nil then
             广播消息({内容=format("#S(嘉年华)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,参数),频道="xt"})

          end
  elseif 名称=="初级清灵仙露"  or 名称=="中级清灵仙露"  or 名称=="高级清灵仙露"  or 名称=="超级清灵仙露"  or 名称=="终级清灵仙露" then
           local 给予数量 = 取随机数(数量[1],数量[#数量])
           for i=1,给予数量 do
              self:给予道具(id,名称,1,参数)
           end
   elseif 名称=="宝石" then
          local 宝石名称 = {"红玛瑙","太阳石","舍利子","黑宝石","月亮石","光芒石","星辉石"}
          local 给予名称 = 宝石名称[取随机数(1,#宝石名称)]
          local 给予数量 = 取随机数(数量[1],数量[#数量])
          self:给予道具(id,给予名称,给予数量,参数)
   elseif 名称=="五宝" then
          local 给予名称 = self:取五宝()
          local 给予数量 = 取随机数(数量[1],数量[#数量])
          self:给予道具(id,给予名称,给予数量,参数)
    elseif 名称=="强化石" then
          local 给予名称 = 取强化石()
          local 给予数量 = 取随机数(数量[1],数量[#数量])
          self:给予道具(id,给予名称,给予数量,参数)
  else
        local 是否广播 =true
        local 给予数量 = 取随机数(数量[1],数量[#数量])
        self:给予道具(id,名称,给予数量,参数)
        if 名称 =="红玛瑙" or  名称 =="太阳石" or  名称 =="舍利子" or  名称 =="黑宝石" or  名称 =="月亮石" or  名称 =="光芒石" or  名称 =="星辉石" then
           if 玩家数据[id].抽中编号~=nil then
             广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/级的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,给予数量,名称),频道="xt"})
          elseif 玩家数据[id].地宫编号~=nil  then
             广播消息({内容=format("#S(地宫礼包)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/级的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,给予数量,名称),频道="xt"})
          elseif 玩家数据[id].抽中嘉年华~=nil  then
             广播消息({内容=format("#S(嘉年华)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/级的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,给予数量,名称),频道="xt"})

          end
          是否广播 =false
        end
        if 玩家数据[id].抽中编号~=nil and 是否广播 then
            广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/个#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,给予数量,名称),频道="xt"})
        elseif 玩家数据[id].地宫编号~=nil and 是否广播 then
           广播消息({内容=format("#S(地宫礼包)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/个#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,给予数量,名称),频道="xt"})
        elseif 玩家数据[id].抽中嘉年华~=nil and 是否广播 then
           广播消息({内容=format("#S(嘉年华)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/个#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.数据.名称,给予数量,名称),频道="xt"})

        end


  end
  常规提示(id,"#Y你获得了#R"..名称)
end


function 道具处理类:制作家具图纸(id,参数)

 if 玩家数据[id].角色.数据.活力<家具消耗[参数].活力 then
    常规提示(id,"#Y少侠,当前活力不够，图纸制造失败")
  return
end
 if 玩家数据[id].角色.数据.银子<家具消耗[参数].银子 then
   常规提示(id,"#Y少侠,当前银子不够，图纸制造失败")

  return
end

  local  判断=false
  for i=1,#self.一级家具 do
      if 参数==self.一级家具[i] then

          判断=true
          break
      end
  end
  for i=1,#self.二级家具 do
      if 参数==self.二级家具[i] then
          判断=true
          break
      end
  end
  if 判断 then
     玩家数据[id].角色.数据.活力=玩家数据[id].角色.数据.活力-家具消耗[参数].活力
     玩家数据[id].角色.数据.银子=玩家数据[id].角色.数据.银子-家具消耗[参数].银子
     体活刷新(id)
    if 取随机数()<=8 then
      self:给予道具(id,"设计图",1,参数)
      self:给予道具(id,"设计图",1,参数)
      常规提示(id,"#Y设计成功了，你获得两张家具图纸")
    else
      常规提示(id,"#Y这次设计不够理想，图纸制造失败")
    end
  end

end






function 道具处理类:给予道具(id,名称,数量,参数,附加,专用)
          local 重置id=false
          local 物品数量 = 1
          if 数量 and type(数量)=="number" then  物品数量 = tonumber(数量) end
          for k,v in pairs(玩家数据[id].角色.数据.道具) do
              if not 重置id and self.数据[v] and self.数据[v].名称==名称 and self.数据[v].可叠加 and self.数据[v].数量 and type(self.数据[v].数量)=="number" then
                    if self.数据[v].数量+物品数量<=999  then
                        if self.额外叠加[self.数据[v].名称] then
                              self.数据[v].数量=self.数据[v].数量+物品数量
                              重置id=true
                        elseif self.数据[v].名称 == "元宵" then
                             if  self.数据[v].食材==参数 then
                                self.数据[v].数量=self.数据[v].数量+物品数量
                                重置id=true
                              end
                        elseif self.数据[v].名称 == "鸿蒙原石" then
                                if 参数 and type(参数)=="table" and  self.数据[v].附带词条==参数.类型 and self.数据[v].数额==参数.数额 then
                                        self.数据[v].数量=self.数据[v].数量+物品数量
                                        重置id=true
                                end
                        elseif  self.数据[v].名称 == "太初原石" then
                                if 参数 and type(参数)=="table" and  self.数据[v].附带词条==参数.类型  then
                                        self.数据[v].数量=self.数据[v].数量+物品数量
                                        重置id=true
                                end
                        else
                              if not self.数据[v].阶品 then
                                    self.数据[v].数量=self.数据[v].数量+物品数量
                                    重置id=true
                              elseif self.数据[v].阶品==参数 then
                                    self.数据[v].数量=self.数据[v].数量+物品数量
                                    重置id=true
                              end
                        end
                        self.数据[v].可叠加=true
                    end
              end
          end
        if not 重置id then
            local 道具格子=玩家数据[id].角色:取道具格子()
            if not 道具格子 or  道具格子==0 then
                常规提示(id,"您的道具栏物品已经满啦")
            else
                  local 道具id=self:取新编号()
                  self.数据[道具id]=物品类()
                  self.数据[道具id]:置对象(名称)
                  self.数据[道具id].识别码=取唯一识别码(id)
                  玩家数据[id].角色.数据.道具[道具格子]=道具id
                  self:给予数据设置(id,道具id,名称,数量,参数,附加,专用)
            end
        end
        道具刷新(id)
end


function 道具处理类:给予数据设置(id,道具id,名称,数量,参数,附加,专用)

            if 名称=="鬼谷子" then
                  if  参数 == nil or 参数==""  then
                     self.数据[道具id].子类= self.阵法名称[取随机数(4,13)]
                  else
                     self.数据[道具id].子类 = 参数
                  end
                  self.数据[道具id].可叠加 = false
                elseif 名称=="八卦阵书" then
                  if  参数 == nil or 参数==""  then
                     self.数据[道具id].子类= "八卦阵"
                  else
                     self.数据[道具id].子类 = 参数
                  end
                  self.数据[道具id].可叠加 = false				  
            elseif 名称=="点化石" then
                  if 参数 == nil or 参数==""  then
                      local 生成几率 = 取随机数()
                      if  生成几率<= 5 then
                        self.数据[道具id].附带技能=取特殊要诀()
                      elseif  生成几率<= 35 and 生成几率>=6 then
                        self.数据[道具id].附带技能=取高级要诀()
                      else
                        self.数据[道具id].附带技能=取低级要诀()
                      end
                  else
                     self.数据[道具id].附带技能=参数
                  end
                  self.数据[道具id].可叠加 = false

            elseif 名称=="精魄灵石" then
                 self.数据[道具id].可叠加=false
                  if 数量==nil or 数量=="" then
                     self.数据[道具id].级别限制=1
                  else
                     self.数据[道具id].级别限制=tonumber(数量) or 1
                  end
                  if 参数==nil then
                    local 给与属性={"伤害","灵力","速度","气血","防御"}
                    self.数据[道具id].属性 =给与属性[取随机数(1,#给与属性)]
                  else
                    self.数据[道具id].属性 =参数
                  end
                  if self.数据[道具id].属性 =="伤害" or self.数据[道具id].属性 =="灵力" then
                     self.数据[道具id].子类 = 1
                  elseif self.数据[道具id].属性 =="速度"  then
                       self.数据[道具id].子类 = 2
                  else
                       self.数据[道具id].子类 = 3
                  end

            elseif 名称=="钟灵石" then
                local 幻化类型 = {"心源","固若金汤","锐不可当","通真达灵","气血方刚","健步如飞","心无旁骛","回春之术","风雨不动","气壮山河"}
                if 参数 ~= nil then
                  self.数据[道具id].附加特性 = 参数
                else
                  self.数据[道具id].附加特性 = 幻化类型[取随机数(1,#幻化类型)]
                end
                if 数量 ~= nil then
                  self.数据[道具id].级别限制 = tonumber(数量) or 1
                else
                  self.数据[道具id].级别限制 = 1
                end

            elseif 名称=="特赦令牌" then
                   self.数据[道具id].可叠加=true

            elseif 名称=="天眼通符" then
                  self.数据[道具id].总类=4
                  self.数据[道具id].分类=2
                  self.数据[道具id].子类=0
                  self.数据[道具id].可叠加 = true
            elseif 名称=="钨金" or 名称=="附魔宝珠"  or 名称=="超级附魔宝珠"  then
                  if  数量==nil then
                     self.数据[道具id].级别限制=10
                  else
                     self.数据[道具id].级别限制= tonumber(数量[取随机数(1,#数量)]) or 1
                  end
                  self.数据[道具id].可叠加 = false
            elseif 名称=="制造指南书" then
                  self.数据[道具id].子类=数量
                  self.数据[道具id].特效=参数
                  self.数据[道具id].可叠加 = false
            elseif 名称=="灵饰指南书" then
                  self.数据[道具id].子类=数量[取随机数(1,#数量)]*10
                  if 参数 == nil or 参数==""  then
                    self.数据[道具id].特效=随机灵饰[取随机数(1,#随机灵饰)]
                  else
                    self.数据[道具id].特效=参数
                  end
                  self.数据[道具id].可叠加 = false
            elseif 名称=="元灵晶石" then
                  self.数据[道具id].子类=数量[取随机数(1,#数量)]*10
                  self.数据[道具id].可叠加 = false
            elseif 名称=="灵宝图鉴" or 名称=="神兵图鉴"  or 名称=="灵饰图鉴"  then
                  self.数据[道具id].可叠加=false
                  self.数据[道具id].子类=参数
            elseif 名称=="强化符" then
                  self.数据[道具id].等级=参数
                  self.数据[道具id].类型=附加
                  self.数据[道具id].可叠加 = false
            elseif self.数据[道具id].总类==2000 then
                  self.数据[道具id].耐久=100
            elseif 名称=="百炼精铁" then
                  self.数据[道具id].子类=数量
                  self.数据[道具id].可叠加=false
            elseif 名称=="初级清灵仙露" then
                  self.数据[道具id].灵气=取随机数(1,4)
                  self.数据[道具id].可叠加 = false
            elseif 名称=="中级清灵仙露" then
                  self.数据[道具id].灵气=取随机数(2,6)
                  self.数据[道具id].可叠加 = false
            elseif 名称=="高级清灵仙露" then
                  self.数据[道具id].灵气=取随机数(4,8)
                  self.数据[道具id].可叠加 = false
            elseif 名称=="超级清灵仙露" then
                  self.数据[道具id].灵气=50
                  self.数据[道具id].可叠加 = false
            elseif 名称=="终级清灵仙露" then
                  self.数据[道具id].灵气=110
                  self.数据[道具id].可叠加 = false
            elseif 名称=="召唤兽内丹" then
                  if 参数==nil or 参数==""  then
                   self.数据[道具id].附带技能=取内丹()
                  else
                    self.数据[道具id].附带技能=参数
                  end
                  self.数据[道具id].可叠加 = false
            elseif 名称=="高级召唤兽内丹" then
                  if 参数==nil or 参数==""  then
                   self.数据[道具id].附带技能=取内丹("高级")
                  else
                    self.数据[道具id].附带技能=参数
                  end
                  self.数据[道具id].可叠加 = false
            elseif 名称=="魔兽要诀" then
                  if 参数==nil or 参数==""  then
                    self.数据[道具id].附带技能=取低级要诀()
                  else
                    self.数据[道具id].附带技能=参数
                  end
                  self.数据[道具id].可叠加 = false
            elseif 名称=="高级魔兽要诀" then
                 if 参数==nil or 参数==""  then
                   self.数据[道具id].附带技能=取高级要诀()
                  else
                   self.数据[道具id].附带技能=参数
                  end
                  self.数据[道具id].可叠加 = false
            elseif 名称=="特殊魔兽要诀" then
                 if 参数==nil or 参数==""  then
                   self.数据[道具id].附带技能=取特殊要诀()
                  else
                   self.数据[道具id].附带技能=参数
                  end
                  self.数据[道具id].可叠加 = false
            elseif 名称=="超级魔兽要诀" then
                 if 参数==nil or 参数==""  then
                   self.数据[道具id].附带技能=取超级要诀()
                  else
                   self.数据[道具id].附带技能=参数
                  end
                  self.数据[道具id].可叠加 = false
            elseif 名称=="帮派银票" then
                  self.数据[道具id].初始金额=52000
                  self.数据[道具id].完成金额=180000
                  self.数据[道具id].专用="专用"
                  self.数据[道具id].可叠加 = false
            elseif 名称=="月华露" or 名称=="九转金丹" or 名称=="修炼果" or 名称=="超级修炼果"  then
                  if  参数 ==nil or 参数=="" then 参数 = 50 end
                  self.数据[道具id].阶品=tonumber(参数) or 50
                  self.数据[道具id].可叠加 = true
            elseif 名称=="强化升级丹" then
                    if 参数 ==nil  or 参数==""  then
                      local 强化技能 = {"人物伤害","人物防御","人物气血","人物法术","人物速度","人物固伤","人物治疗","宠物伤害","宠物防御","宠物气血","宠物灵力","宠物速度"}
                      self.数据[道具id].阶品=强化技能[取随机数(1,#强化技能)]
                    else
                       self.数据[道具id].阶品=参数
                    end
                    self.数据[道具id].可叠加 = true
            elseif  名称 == "金柳露"      or  名称=="圣兽丹" or  名称=="吸附石" or 名称=="金刚石" or 名称=="定魂珠" or 名称=="夜光珠" or 名称=="避水珠" or 名称=="龙鳞"
                or  名称=="超级金柳露"      or  名称=="神兜兜"  or  名称=="彩果" or 名称=="分解符"  or 名称=="三界悬赏令" or 名称=="青龙石" or 名称=="白虎石" or 名称=="朱雀石"
                or 名称=="玄武石"           or 名称=="炼兽真经"  or 名称=="金银锦盒" or 名称=="2倍经验丹" or 名称=="3倍经验丹" or 名称=="铃铛忙盒"  or 名称 == "雪人鼻子" or 名称 == "雪人帽子" or 名称 == "雪人眼睛"
                or 名称=="随机强化丹" or 名称=="小型奖券" or 名称=="中型奖券" or 名称=="大型奖券" or 名称=="寻龙盘(小)" or 名称=="寻仙盘(小)"
                or 名称=="寻宝盘(小)" or 名称=="寻灵盘(小)" or 名称=="寻龙盘(中)" or 名称=="寻仙盘(中)" or 名称=="寻宝盘(中)" or 名称=="寻灵盘(中)"
                or 名称=="寻龙盘(大)" or 名称=="寻仙盘(大)" or 名称=="寻宝盘(大)" or 名称=="寻灵盘(大)" or 名称=="仙灵丹" or 名称=="特效点化石" or 名称=="特技点化石" or 名称=="无级别点化石"
                or 名称=="灵饰点化石" or 名称=="铃铛盲盒"  or 名称=="一级法宝碎片"  or 名称=="二级法宝碎片"  or 名称=="三级法宝碎片"  or 名称=="避火诀" or 名称=="神兽破封石" or 名称=="功德残卷"
                or 名称=="一级仙缘"   or 名称=="二级仙缘" or 名称=="三级仙缘" or 名称=="四级仙缘" or 名称=="五级仙缘" or 名称=="六级仙缘" or 名称=="七级仙缘"
                or 名称=="八级仙缘"   or 名称=="九级仙缘" or 名称=="十级仙缘" or 名称=="灵犀之屑" or 名称=="未鉴定的灵犀玉" or 名称=="月饼" or 名称=="解封丹" or 名称=="钟馗令牌" or 名称=="副本重置丹"
                or 名称=="双倍掉宝符" or 名称=="坐骑蛋"   or 名称=="锦衣碎片" or 名称=="仙露丸子" or 名称=="仙露小丸子" or 名称=="神兽涎" or 名称=="灵饰洗炼石"
                or 名称=="特殊兽决碎片" or 名称=="超级兽决碎片"  or 名称=="鸿蒙灵宝" or 名称=="鸿蒙仙宝" or 名称=="鸿蒙神宝" or 名称=="破碎的鸿蒙灵宝"
                or 名称=="破碎的鸿蒙仙宝" or 名称=="破碎的鸿蒙神宝" or 名称=="太初灵石" or 名称=="太初仙石" or 名称=="太初神石" or 名称=="破碎的太初灵石"
                or 名称=="破碎的太初仙石" or 名称=="破碎的太初神石" or string.find(名称, "礼包") or string.find(名称, "自选包") then

                self.数据[道具id].可叠加 = true
            elseif 名称=="鸿蒙原石" or 名称=="太初原石" then
                   self.数据[道具id].可叠加 = true
                  if 参数==nil or 参数=="" or type(参数)~="table" then
                      local 临时列表 = {}
                      for k,v in pairs(境界属性) do
                              table.insert(临时列表, k)
                      end
                      self.数据[道具id].附带词条=临时列表[取随机数(1,#临时列表)]
                      self.数据[道具id].数额=境界属性[ self.数据[道具id].附带词条].优秀[1]
                  else
                        self.数据[道具id].附带词条=参数.类型
                        self.数据[道具id].数额=参数.数额
                  end
            elseif 名称=="灵犀玉" then
                  self.数据[道具id].可叠加 = false
                  if 数量 ==nil then
                     self.数据[道具id].子类 = 取随机数(1,3)
                  else
                     self.数据[道具id].子类 = 数量
                  end
                 if 参数==nil then
                    self.数据[道具id].特性 = self:取灵犀玉特性()
                    if 取随机数()<=50 and self.数据[道具id].子类==3 then
                       self.数据[道具id].特性 = self:取高级灵犀玉特性()
                    end
                 else
                     self.数据[道具id].特性 = 参数
                 end
            elseif 名称=="房屋地契" then
                        self.数据[道具id].可叠加 = false
                       if 数量==nil then
                          self.数据[道具id].地契编号=取唯一识别码(id)
                       else
                           self.数据[道具id].地契编号=数量
                       end
                       if 参数==nil then
                          self.数据[道具id].庭院规模="初级"
                          self.数据[道具id].房屋规模="初级"
                          self.数据[道具id].房屋样式="复古"
                       else
                          self.数据[道具id].庭院规模=参数.庭院规模
                          self.数据[道具id].房屋规模=参数.房屋规模
                          self.数据[道具id].房屋样式=参数.房屋样式
                       end

              elseif 名称=="归墟之证" then
                        self.数据[道具id].可叠加 = false
                       if 数量==nil then
                            self.数据[道具id].等级=取随机数(1,5)
                       else
                           self.数据[道具id].等级=tonumber(数量) or 1
                       end
                       local  任务类型 ={"抓鬼任务","鬼王任务","皇宫飞贼","雁塔地宫"}
                       local 类型 = ""
                       for i,v in ipairs(任务类型) do
                            if 参数==v then
                                类型 = v
                            end
                       end
                       if 类型~="" then
                            self.数据[道具id].类型 = 参数
                       else
                            self.数据[道具id].类型 =任务类型[取随机数(1,#任务类型)]
                       end
              elseif 名称=="设计图" then

                        self.数据[道具id].可叠加 = false
                        if  参数~=nil then
                             self.数据[道具id].类型 = 参数
                        else
                             self.数据[道具id].类型 = "黑麻垂曼帘"
                        end
                        local 道具级别=1
                        for i=1,#self.二级家具 do
                          if self.数据[道具id].类型==self.二级家具[i] then
                              道具级别=2
                              break
                           end
                        end
                        self.数据[道具id].等级=道具级别



              elseif 名称 == "功德录"  then
                    self.数据[道具id].可叠加 = false
              elseif 名称=="元宵" then
                   local 食材 = {"芝麻沁香","桂花酒酿","细磨豆沙","蜜糖腰果","蜜糖腰果","蜜糖腰果","山楂拔丝","滑玉莲蓉"}
                    if 参数==nil or 参数=="" then
                      self.数据[道具id].食材 = 食材[取随机数(1,#食材)]
                    else
                     self.数据[道具id].食材=参数
                    end
                    self.数据[道具id].可叠加 = true
              elseif 名称=="清灵净瓶" then
                    self.数据[道具id].可叠加 = true
              elseif 名称=="藏宝图" or 名称=="高级藏宝图" or 名称=="玲珑宝图"  then
                      local 随机地图={1501,1506,1092,1091,1110,1142,1514,1174,1173,1146,1208}
                      local 临时地图=随机地图[取随机数(1,#随机地图)]
                      self.数据[道具id].地图名称=取地图名称(临时地图)
                      self.数据[道具id].地图编号=临时地图
                      local xy=地图处理类.地图坐标[临时地图]:取随机点()
                      self.数据[道具id].x=xy.x
                      self.数据[道具id].y=xy.y
                      self.数据[道具id].可叠加 = false

              elseif 名称=="炼妖石" or 名称=="上古锻造图策" then
                     self.数据[道具id].级别限制=数量[取随机数(1,#数量)]
                    if 参数 == nil or 参数==""  then
                      self.数据[道具id].种类=图策范围[取随机数(1,#图策范围)]
                    else
                      self.数据[道具id].种类=参数
                    end
                    self.数据[道具id].可叠加 = false
              elseif 名称=="天眼珠" then
                    self.数据[道具id].级别限制=数量[取随机数(1,#数量)]
                     if 参数 == nil or 参数==""  then
                         self.数据[道具id].灵气=取随机数(20,80)
                      else
                         self.数据[道具id].灵气=tonumber(参数) or 0
                      end
                   self.数据[道具id].分类=11
                   self.数据[道具id].可叠加 = false
              elseif 名称=="珍珠" then
                    self.数据[道具id].级别限制 = tonumber(数量) or 1
                     self.数据[道具id].可叠加 = false
              elseif 名称=="战魂" then
                    self.数据[道具id].级别限制=tonumber(数量) or 1
                     self.数据[道具id].可叠加 = false
              elseif 名称~=nil and string.find(名称, "符石") ~= nil and  not self.额外符石[名称] and not self.新三符石[名称] then
                    local xlshi = 取物品数据(名称)
                    if xlshi==nil or xlshi=={} and (xlshi~=nil or xlshi~={} and #xlshi < 18)then
                      return
                    end
                    self.数据[道具id].级别 = 数量
                    self.数据[道具id].耐久度 = 150
                    self.数据[道具id].颜色= xlshi[20]--颜色
                    self.数据[道具id].符石属性 = xlshi[21]
                    self.数据[道具id].分类= 88
                    self.数据[道具id].不可交易= true
                    self.数据[道具id].可叠加= false
              elseif self.新三符石[名称]  then
                    local xlshi = 取物品数据(名称)
                    if xlshi==nil or xlshi=={} and (xlshi~=nil or xlshi~={} and #xlshi < 18)then
                      return
                    end
                    self.数据[道具id].级别 = 3
                    self.数据[道具id].耐久度 = 150
                    self.数据[道具id].颜色= xlshi[20]--颜色
                    self.数据[道具id].符石属性 = xlshi[21]
                    self.数据[道具id].分类= 88
                    self.数据[道具id].可叠加= false
              elseif 名称=="一级未激活符石" then
                     self.数据[道具id].级别=1
                     self.数据[道具id].可叠加=true
              elseif 名称=="二级未激活符石"  then
                    self.数据[道具id].级别=2
                    self.数据[道具id].可叠加=true
              elseif 名称=="三级未激活符石" then
                    self.数据[道具id].级别=3
                    self.数据[道具id].可叠加=true

              elseif 名称=="未激活的星石" then
                    if 参数==nil or 参数=="" then
                      self.数据[道具id].子类 = 取随机数(1,6)
                    else
                      if 参数 == "头盔" then
                        self.数据[道具id].子类 = 1
                      elseif 参数 == "饰物" then
                        self.数据[道具id].子类 = 2
                      elseif 参数 == "武器" then
                        self.数据[道具id].子类 = 3
                      elseif 参数 == "衣甲" then
                        self.数据[道具id].子类 = 4
                      elseif 参数 == "腰带" then
                        self.数据[道具id].子类 = 5
                      elseif 参数 == "靴子" then
                        self.数据[道具id].子类 = 6
                      else
                        self.数据[道具id].子类 = 取随机数(1,6)
                      end
                    end
                     self.数据[道具id].可叠加 = false
              elseif 名称=="符石卷轴" then
                    self.数据[道具id].可叠加=true
              elseif 名称=="怪物卡片" then
                    local 变身等级 = tonumber(数量)
                    if 变身等级==nil or 变身等级<=0 then
                       变身等级 =取随机数(1,3)
                    end
                    if 变身等级>=9 then 变身等级=9 end
                    if 参数==nil or 参数==""  then
                       self.数据[道具id].等级=变身等级
                       self.数据[道具id].造型=变身卡范围[变身等级][取随机数(1,#变身卡范围[变身等级])]
                    else
                      if 变身卡数据[参数]==nil then
                         self.数据[道具id].等级=变身等级
                         self.数据[道具id].造型=变身卡范围[变身等级][取随机数(1,#变身卡范围[变身等级])]
                      else
                          self.数据[道具id].等级=变身卡数据[参数].等级
                          self.数据[道具id].造型=参数
                      end
                    end
                    --超级变身卡新加
                    self.数据[道具id].类型=变身卡数据[self.数据[道具id].造型].类型
                    self.数据[道具id].单独=变身卡数据[self.数据[道具id].造型].单独
                    self.数据[道具id].正负=变身卡数据[self.数据[道具id].造型].正负
                    self.数据[道具id].技能=变身卡数据[self.数据[道具id].造型].技能
                    self.数据[道具id].属性=变身卡数据[self.数据[道具id].造型].属性
                    self.数据[道具id].货币加成=变身卡数据[self.数据[道具id].造型].货币加成
                    self.数据[道具id].经验加成=变身卡数据[self.数据[道具id].造型].经验加成
                    self.数据[道具id].多属性=变身卡数据[self.数据[道具id].造型].多属性
                    self.数据[道具id].次数=self.数据[道具id].等级+(变身卡数据[self.数据[道具id].造型].附加.次数 or 0)
                    self.数据[道具id].可叠加 = false
              elseif 名称=="限时会员卡" then
                     self.数据[道具id].限时 = os.time()+3600*24*3   -----会员限时时间

              elseif 名称=="白银会员卡" then
                     self.数据[道具id].限时 = os.time()+3600*24*7   -----会员限时时间

              elseif 名称=="黄金会员卡" then
                     self.数据[道具id].限时 = os.time()+3600*24*30   -----会员限时时间

              elseif 名称=="钻石会员卡" then
                     self.数据[道具id].限时 = os.time()+3600*24*182
              elseif 名称=="金创药" or 名称=="小还丹" or 名称=="千年保心丹" or 名称=="金香玉" or 名称=="风水混元丹"
                or 名称=="蛇蝎美人" or 名称=="定神香" or 名称=="佛光舍利子" or 名称=="九转回魂丹" or 名称=="五龙丹"
                or 名称=="十香返生丸"
                then
                    if 参数==nil or 参数=="" then 参数 = 10 end
                    self.数据[道具id].阶品=tonumber(参数) or 10
                    self.数据[道具id].可叠加 = true
              elseif self.数据[道具id].总类==5 and  self.数据[道具id].分类==4 then
                  self.数据[道具id].级别限制=tonumber(数量) or 1
                  self.数据[道具id].可叠加 = false
              elseif self.数据[道具id].总类==5 and  self.数据[道具id].分类==6 then
                  self.数据[道具id].级别限制=tonumber(数量) or 1
                  self.数据[道具id].可叠加 = false
              elseif self.数据[道具id].总类==1 and self.数据[道具id].子类==1 and self.数据[道具id].分类==4 then
                  if 参数==nil or 参数=="" then 参数 = 10 end
                  self.数据[道具id].阶品=tonumber(参数) or 10
                  self.数据[道具id].可叠加 = true
              elseif self.数据[道具id].总类==144 then
                  self.数据[道具id].可叠加 = true
              end
              if string.find(名称, "会员卡")~=nil then
                   self.数据[道具id].专用=id
                   self.数据[道具id].不可交易=true
                   self.数据[道具id].可叠加 = false
                   self.数据[道具id].加锁=true
                   if not self.数据[道具id].限时 then
                      self.数据[道具id].限时 = os.time()+3600*24*365
                   end
              elseif 名称=="心魔宝珠" or 名称=="神秘钥匙" then
                    self.数据[道具id].不可交易=true
              end
              if self.数据[道具id].总类==1001 then
                    self.数据[道具id].不可交易=true
                    self.数据[道具id].专用="专用"
              end
              if 专用~=nil then
                    self.数据[道具id].专用=id
                    self.数据[道具id].不可交易=true
              end
              if self.数据[道具id].可叠加 then
                  self.数据[道具id].数量= tonumber(数量) or 1
              end






end



function 道具处理类:卸下灵饰(连接id,id,道具格子,数据,多角色)
--  玩家数据[id].角色:卸下灵饰(self.数据[玩家数据[id].角色.数据.灵饰[数据.道具]])
  local  道具id =玩家数据[id].角色.数据.灵饰[数据.道具]
  if not 道具id or 道具id == 0 then return end
  if not self.数据[道具id] then 玩家数据[id].角色.数据.灵饰[数据.道具]=nil return end
  self.数据[道具id].灵饰套装=0
  玩家数据[id].角色.数据[数据.类型][道具格子]=道具id
  玩家数据[id].角色.数据.灵饰[数据.道具]=nil
  玩家数据[id].角色:刷新信息("6")
  if 多角色~=nil then
     道具刷新(id,多角色)
     发送数据(玩家数据[多角色].连接id,6012,{角色=id})
     发送数据(玩家数据[多角色].连接id,6013,{角色=id})
  else
    self:刷新道具行囊(id,数据.类型)
    发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
    发送数据(玩家数据[id].连接id,3506,玩家数据[id].角色:取灵饰数据())
    发送数据(连接id,5506,{玩家数据[id].角色:取气血数据()})
    发送数据(玩家数据[id].连接id,12)
   end
end


function 道具处理类:卸下锦衣(连接id,id,道具格子,数据,多角色)
        local  道具id =玩家数据[id].角色.数据.锦衣[数据.道具]
        if not 道具id or 道具id == 0 then return end
        if not self.数据[道具id] then 玩家数据[id].角色.数据.锦衣[数据.道具]=nil return end
        玩家数据[id].角色.数据[数据.类型][道具格子]=道具id
        玩家数据[id].角色.数据.锦衣[数据.道具]=nil
        if self.数据[道具id].分类==15 then
            玩家数据[id].角色.数据.穿戴锦衣=nil
        elseif self.数据[道具id].分类==16 then
            玩家数据[id].角色.数据.穿戴足印=nil
        elseif self.数据[道具id].分类==17 then
            玩家数据[id].角色.数据.穿戴足迹=nil
        end
        玩家数据[id].角色:刷新信息()
        if 多角色~=nil then
             道具刷新(id,多角色)
             发送数据(玩家数据[多角色].连接id,6014,{角色=id})
        else
          self:刷新道具行囊(id,数据.类型)
          -- 发送数据(玩家数据[id].连接id,3699)
          -- 道具刷新(id)
          发送数据(玩家数据[id].连接id,3530,玩家数据[id].角色:取锦衣数据())
          发送数据(玩家数据[id].连接id,12)
        end
        地图处理类:更新锦衣(id,玩家数据[id].角色:取锦衣数据())
end





function 道具处理类:卸下装备(连接id,id,数据,多角色)
  if not 数据.类型 then 数据.类型="道具" end
  if  not 数据.道具 or 数据.道具==0 then return end
  local 道具格子=玩家数据[id].角色:取道具格子1(数据.类型)
  if 道具格子==0 then
    常规提示(id,"您的道具栏物品已经满啦",多角色)
    return 0
  end
  if 数据.灵饰 then
    self:卸下灵饰(连接id,id,道具格子,数据,多角色)
    return
  end
  if 数据.锦衣 then
    self:卸下锦衣(连接id,id,道具格子,数据,多角色)
    return
  end
  local 道具id=玩家数据[id].角色.数据.装备[数据.道具]
  if not 道具id or 道具id == 0 then return end
  if not self.数据[道具id] then 玩家数据[id].角色.数据.装备[数据.道具]=nil return end
  玩家数据[id].角色:卸下装备(self.数据[道具id],self.数据[道具id].分类,id)
  玩家数据[id].角色.数据.装备[数据.道具]=nil
  玩家数据[id].角色.数据[数据.类型][道具格子]=道具id
  if 多角色~=nil then
     道具刷新(id,多角色)
     发送数据(玩家数据[多角色].连接id,6012,{角色=id})
  else
     self:刷新道具行囊(id,数据.类型)
     发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
  end

  玩家数据[id].角色:刷新信息("6")
  -- 发送数据(玩家数据[id].连接id,3699)
  -- 道具刷新(id)
  if 数据.道具==3 then
    if not 多角色 then
       发送数据(玩家数据[id].连接id,3505)
    end
    地图处理类:更新武器(id)
  elseif 数据.道具==4  and 玩家数据[id].角色.数据.模型=="影精灵" then
        if not 多角色 then
            发送数据(玩家数据[id].连接id,3505)
        end
        地图处理类:更新副武器(id)
  end
  if not 多角色 then
    发送数据(玩家数据[id].连接id,12)
  end
end

function 道具处理类:佩戴灵饰(连接id,id,道具id,数据,多角色)
      if not self.数据[道具id].鉴定 or not self.数据[道具id].子类 then
          常规提示(id,"#Y/这个灵饰还没鉴定",多角色)
          return
      elseif not self.数据[道具id].特效 and self.数据[道具id].级别限制>玩家数据[id].角色.数据.等级 then
          常规提示(id,"#Y/你当前的等级不足以佩戴这样的灵饰",多角色)
          return
      elseif self.数据[道具id].特效~="无级别限制" then
            if  self.数据[道具id].特效=="简易" and  self.数据[道具id].级别限制> 玩家数据[id].角色.数据.等级+5 then
                常规提示(id,"#Y/你当前的等级不足以佩戴这样的灵饰",多角色)
               return
            elseif self.数据[道具id].特效=="超级简易" and  self.数据[道具id].级别限制> 玩家数据[id].角色.数据.等级+15 then
                  常规提示(id,"#Y/你当前的等级不足以佩戴这样的灵饰",多角色)
                return
            end
      end
      self.数据[道具id].灵饰套装=0
      if 玩家数据[id].角色.数据.灵饰[self.数据[道具id].子类]==nil then
          玩家数据[id].角色.数据.灵饰[self.数据[道具id].子类]=道具id
          玩家数据[id].角色.数据[数据.类型][数据.道具]=nil
      else
          local 道具id1=玩家数据[id].角色.数据.灵饰[self.数据[道具id].子类]
          self.数据[道具id1].灵饰套装=0
          玩家数据[id].角色.数据.灵饰[self.数据[道具id].子类]=道具id
          玩家数据[id].角色.数据[数据.类型][数据.道具]=道具id1
      end
      玩家数据[id].角色:刷新信息("6")
       if 多角色~=nil then
           道具刷新(id,多角色)
           发送数据(玩家数据[多角色].连接id,6012,{角色=id})
           发送数据(玩家数据[多角色].连接id,6013,{角色=id})
      else
          self:刷新道具行囊(id,数据.类型)
          发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
          发送数据(玩家数据[id].连接id,3506,玩家数据[id].角色:取灵饰数据())
          发送数据(连接id,5506,{玩家数据[id].角色:取气血数据()})
          发送数据(玩家数据[id].连接id,12)
       end


end


function 道具处理类:给予锦衣(id,名称)
  local 格子=玩家数据[id].角色:取道具格子()
  if 格子==0 then
    常规提示(id,"你的背包已满")
    return
  end
  local 识别码=取唯一识别码(id)
  道具id=self:取新编号()
  self.数据[道具id]=物品类()
  self.数据[道具id]:置对象(名称)
  self.数据[道具id].识别码=识别码
  local 道具 = 取物品数据(名称)
  self.数据[道具id].总类=道具[2]
  self.数据[道具id].分类=道具[3]
  self.数据[道具id].锦衣 = true
  if 名称=="青春" or 名称=="素颜" or 名称=="绝色" or 名称=="春秋" or  名称=="夏蚕"
  or 名称=="星河" or 名称=="白峨" or 名称=="糖果" or 名称=="青涩" or 名称=="傲然"
  or 名称=="牛仔" or  名称=="试剑" or  名称=="骨龙战骑"  or  名称=="水嘟嘟·钻白"
  or 名称=="斗战神" or 名称=="斗战胜佛"  or 名称=="八部天龙马·玄" or  名称=="龙凰·桃" or  名称=="龙凰·皑" then
   self.数据[道具id].战斗锦衣 = true
  end
  玩家数据[id].角色.数据.道具[格子]=道具id
  常规提示(id,"#Y/你获得了#R/"..名称)
  道具刷新(id)
end






function 道具处理类:佩戴锦衣(连接id,id,道具id,数据,多角色)
  if not self.数据[道具id].子类 then
          常规提示(id,"#Y/这个锦衣还没鉴定",多角色)
          return
  end
  if 玩家数据[id].角色.数据.锦衣[self.数据[道具id].子类]==nil then
      玩家数据[id].角色.数据.锦衣[self.数据[道具id].子类]=道具id
      玩家数据[id].角色.数据[数据.类型][数据.道具]=nil
  else
      local 道具id1=玩家数据[id].角色.数据.锦衣[self.数据[道具id].子类]
      玩家数据[id].角色.数据.锦衣[self.数据[道具id].子类]=道具id
      玩家数据[id].角色.数据[数据.类型][数据.道具]=道具id1
  end
  -- 玩家数据[id].角色:穿戴锦衣(self.数据[道具id],self.数据[道具id].分类,id)
  if self.数据[道具id].分类 == 15 then
      玩家数据[id].角色.数据.穿戴锦衣=self.数据[道具id].名称
  elseif self.数据[道具id].分类 == 16 then
      玩家数据[id].角色.数据.穿戴足印=self.数据[道具id].名称
  elseif self.数据[道具id].分类 == 17 then
      玩家数据[id].角色.数据.穿戴足迹=self.数据[道具id].名称
  end
  玩家数据[id].角色:刷新信息()
   if 多角色~=nil then
     发送数据(玩家数据[多角色].连接id,6014,{角色=id})
  else
     self:刷新道具行囊(id,数据.类型)
     发送数据(玩家数据[id].连接id,3530,玩家数据[id].角色:取锦衣数据())
     发送数据(玩家数据[id].连接id,12)
  end
  地图处理类:更新锦衣(id,玩家数据[id].角色:取锦衣数据())
  道具刷新(id,多角色)

end

function 道具处理类:佩戴装备(连接id,id,数据,多角色)
  if not 数据.类型 then 数据.类型="道具" end
  if not 数据.道具 or 数据.道具==0 then return end
  local 道具id=玩家数据[id].角色.数据[数据.类型][数据.道具]
  local 装备条件
  if 道具id==0 or 道具id==nil or self.数据[道具id] == nil or self.数据[道具id]==0 then
      装备条件 =false
  elseif self.数据[道具id].灵饰 then
          self:佩戴灵饰(连接id,id,道具id,数据,多角色)
         return
  elseif self.数据[道具id].锦衣 then
          self:佩戴锦衣(连接id,id,道具id,数据,多角色)
          return
  elseif not self.数据[道具id].分类  or self.数据[道具id].耐久 == nil or self.数据[道具id].耐久 <= 0  then
        装备条件 =false
  else
	   装备条件=self:可装备(self.数据[道具id],self.数据[道具id].分类,数据.角色,id)
  end
  if 装备条件~=true then
      常规提示(id,"#Y你当前的角色无法装备此装备",多角色)
      return 0
  else
  --检查是否有装备已经佩戴
    if 玩家数据[id].角色.数据.装备[self.数据[道具id].分类]~=nil then
      local 道具id1=玩家数据[id].角色.数据.装备[self.数据[道具id].分类]
      玩家数据[id].角色:卸下装备(self.数据[道具id1],self.数据[道具id1].分类,id)
      玩家数据[id].角色.数据.装备[self.数据[道具id].分类]= 道具id
      玩家数据[id].角色:穿戴装备(self.数据[道具id],self.数据[道具id].分类,id)
      玩家数据[id].角色.数据[数据.类型][数据.道具]=道具id1
    else
      玩家数据[id].角色.数据.装备[self.数据[道具id].分类]= 道具id
      玩家数据[id].角色:穿戴装备(self.数据[道具id],self.数据[道具id].分类,id)
      玩家数据[id].角色.数据[数据.类型][数据.道具]=nil
    end
  end
  if 多角色~=nil then
     道具刷新(id,多角色)
     发送数据(玩家数据[多角色].连接id,6012,{角色=id})
  else
    self:刷新道具行囊(id,数据.类型)
    发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
  end
  玩家数据[id].角色:刷新信息("6")
  if self.数据[道具id].分类==3 and 玩家数据[id].角色.数据.装备[3] ~= nil then
    if not 多角色 then
      发送数据(玩家数据[id].连接id,3504)
    end
    地图处理类:更新武器(id,self.数据[玩家数据[id].角色.数据.装备[3]])
  elseif self.数据[道具id].分类==4 and 玩家数据[id].角色.数据.装备[4] ~= nil and 玩家数据[id].角色.数据.模型=="影精灵" then
          if not 多角色 then
            发送数据(玩家数据[id].连接id,3504)
          end
          地图处理类:更新副武器(id,self.数据[玩家数据[id].角色.数据.装备[4]])

  end
  if not 多角色 then
     发送数据(玩家数据[id].连接id,12)
  end
end

function 道具处理类:可装备(i1,i2,类型,id)
	if i2 > 6 and 类型 == "主角" then
		return "#Y/该装备与你的种族不符"
	elseif i2 < 6 and 类型 == "召唤兽" then
		return "#Y/召唤兽不能穿戴该装备"
	end
	if i1.总类 ~= 2 then
		return "#Y/这个物品不可以装备"
	end
  if i1.专用~=nil and i1.专用~=id then
   return "#Y/你无法佩戴他人的专用装备"
  end
    if i1.限时 ~= nil and i1.限时 < os.time() then
      常规提示(id,"#Y该装备的使用时限到了无法在使用了")
    return "#Y/该装备的使用时限到了无法在使用了"
  end
  if i1.鉴定==false then
      return "#Y/该装备未鉴定，无法佩戴"
  end
  if i1.耐久==nil then
      i1.耐久=500
  end
  if i1.耐久<=0 and i1.耐久~=nil then
      return "#Y/该装备耐久不足，无法穿戴"
  end
  if i1.修理失败~=nil and i1.修理失败==3 and i1.耐久<=0 then
      return "#Y/该装备因修理失败过度，而无法使用！"
  end
	if i1 ~= nil and i1.分类 == i2 then
		if i2 == 1 or i2 == 4 then
        if i2 == 4 and string.find(i1.名称,"(坤)") and i1.角色限制 and i1.角色限制[1] ~= 玩家数据[id].角色.数据.模型  then
            return "#Y/该装备您无法使用呀"
        end
			if i1.性别限制 ~= 0 and i1.性别限制 == 玩家数据[id].角色.数据.性别 then
					if (i1.级别限制 == 0 or i1.特效 == "无级别限制" or 玩家数据[id].角色.数据.等级 >= i1.级别限制 or i1.第二特效 == "无级别限制") then
						  return true
          elseif (i1.特效 == "简易" or i1.第二特效 == "简易") and 玩家数据[id].角色.数据.等级+5 >= i1.级别限制 then
              return true
          elseif (i1.特效 == "超级简易" or i1.第二特效 == "超级简易") and 玩家数据[id].角色.数据.等级+15 >= i1.级别限制 then
              return true
					else
    					if 玩家数据[id].角色.数据.等级 < i1.级别限制 then
    						 return "#Y/你的等级不够呀"
    					end
				end
			else
				return "#Y/该装备您无法使用呀"
			end
		elseif i2 == 2 or i2 == 5 or i2 == 6 then
			if (i1.级别限制 == 0 or i1.特效 == "无级别限制" or 玩家数据[id].角色.数据.等级 >= i1.级别限制 or i1.第二特效 == "无级别限制") then
				return true
       elseif (i1.特效 == "简易" or i1.第二特效 == "简易") and 玩家数据[id].角色.数据.等级+5 >= i1.级别限制 then
         return true
      elseif (i1.特效 == "超级简易" or i1.第二特效 == "超级简易") and 玩家数据[id].角色.数据.等级+15 >= i1.级别限制 then
         return true
			else
				if i1.级别限制 > tonumber(玩家数据[id].角色.数据.等级) then
					return "#Y/你的等级不够呀"
				end
			end
		elseif i2 == 3 then
			 local 角色限制 = false
        if i1.角色限制 and i1.角色限制[1] then
            for k,v in pairs(i1.角色限制) do
                if v==玩家数据[id].角色.数据.模型 then
                    角色限制 = true
                    break
                end
            end
        end
      if i1.角色限制 ~= 0 and 角色限制 then
          if (i1.级别限制 == 0 or i1.特效 == "无级别限制" or 玩家数据[id].角色.数据.等级 >= i1.级别限制 or i1.第二特效 == "无级别限制") then
            return true
          elseif (i1.特效 == "简易" or i1.第二特效 == "简易") and 玩家数据[id].角色.数据.等级+5 >= i1.级别限制 then
            return true
          elseif (i1.特效 == "超级简易" or i1.第二特效 == "超级简易") and 玩家数据[id].角色.数据.等级+15 >= i1.级别限制 then
            return true
          else
              if 玩家数据[id].角色.数据.等级 < i1.级别限制 then
                return "#Y/你的等级不够呀"
              end
         end
			else
				return "#Y/该装备您无法使用呀"
			end
		end
	end
	return false
end

function 道具处理类:加载数据(账号,数字id)
        self.数字id=数字id
        self.数据=table.loadstring(读入文件([[data/]]..账号..[[/]]..数字id..[[/道具.txt]]))
        local 删除格子={}
        local 识别码={}
        local 会员卡=false
        for n, v in pairs(self.数据) do
              if type(v)~="table" then
                  删除格子[n]=true
              end
              if not 删除格子[n] then
                  if not v.名称 then
                      删除格子[n]=true
                  end
                  if not v.识别码 then
                        删除格子[n]=true
                  end

                  if v.数量 and tonumber(v.数量) and (v.数量>999 or v.数量<1 or v.数量~=math.floor(v.数量)) then
                      删除格子[n]=true
                  end
                  if v.名称 and string.find(v.名称, "会员卡")~=nil then
                      if not v.限时 then
                          v.限时=os.time()+3600*24*7
                      elseif v.限时 and os.time()>= v.限时 then
                           会员卡=true
                      end
                      if not 会员卡 then
                          if 玩家数据[self.数字id].角色.数据.月卡==nil then
                               玩家数据[self.数字id].角色.数据.月卡={购买时间=0,到期时间=0,当前领取=0,开通=false}
                          end
                          玩家数据[self.数字id].角色.数据.月卡.到期时间 = os.time()+86400
                          玩家数据[self.数字id].角色.数据.月卡.购买时间=os.time()
                          玩家数据[self.数字id].角色.数据.月卡.开通=true
                          self.数据[n].加锁=true
                          会员卡 = true
                      else
                          删除格子[n]=true
                      end
                  elseif  v.名称=="长安战报" then
                        删除格子[n]=true
                  end
                  if  self.数据[n] and (not v.识别码 or not string.find(v.识别码,数字id)) then
                        删除格子[n]=true
                  end
                   if  self.数据[n] and v.总类==2 and v.分类==3 and v.角色限制 then
                      if v.子类==6  and not v.角色限制[4] then
                            v.角色限制[4]="影精灵"
                      elseif v.子类==8 and not v.角色限制[3] then
                            v.角色限制[3]="影精灵"
                      end
                   end

                  if self.数据[n]~=nil and not 玩家数据[self.数字id].角色.数据.跑商  and v.名称=="帮派银票"  then
                      删除格子[n]=true
                  end
                  if not 删除格子[n] and 识别码[v.识别码] then
                        删除格子[n]=true
                  elseif v.识别码 then
                        识别码[v.识别码]=true
                  end
              end
        end



        for k,v in pairs(删除格子) do
            self.数据[k]=nil
            local 查找数据 ={"道具","行囊","法宝","灵宝","法宝佩戴","灵宝佩戴","装备","灵饰","锦衣"}
            for i,n in ipairs(查找数据) do
                if 玩家数据[self.数字id].角色.数据[n] then
                  for z,x in pairs(玩家数据[self.数字id].角色.数据[n]) do
                      if x==k then
                          玩家数据[self.数字id].角色.数据[n][z]=nil
                      end
                  end
                end
            end
        end


end

function 道具处理类:取新编号()
      local  序号 = 0
      for k,v in pairs(self.数据) do
           if 序号 < k then
              序号=k
           end
      end
      local 编号 = 0
      for i=1,序号 do
            if self.数据[i]==nil then
              编号 = i
              break
          end
      end
      if 编号==0 then
         编号=序号+1
      end
    return 编号
end


--function 道具处理类:更新(dt) end

-- function 道具处理类:丢弃道具(连接id,id,数据)

--         if not 数据.类型 or not 数据.物品 or not tonumber(数据.物品) then return end
--          local 丢弃类型=数据.类型
--          if 丢弃类型~="道具" then 常规提示(id,"#Y只有道具行囊才可以丢弃道具") return end
--          local 物品格子= tonumber(数据.物品)
--          local 道具id = 玩家数据[id].角色.数据[丢弃类型][物品格子]
--          if not 道具id or 道具id==0 or not self.数据[道具id] or  self.数据[道具id]==0 then return end
--         if self.数据[道具id].名称=="帮派银票"  then
--             常规提示(id,"#Y该物品无法丢弃")
--             self:刷新道具行囊(id,数据.类型)
--             return
--         end
--         if self.数据[道具id].总类=="跑商商品" then
--             常规提示(id,"#Y该物品无法丢弃")
--             self:刷新道具行囊(id,数据.类型)
--             return
--         end
--         if  self.数据[道具id].加锁~=nil then
--             常规提示(id,"#Y加锁物品无法丢弃")
--             self:刷新道具行囊(id,数据.类型)
--             return
--         end
--         if  string.find(self.数据[道具id].名称,"会员卡")~=nil then
--             常规提示(id,"#Y该物品无法丢弃")
--             self:刷新道具行囊(id,数据.类型)
--             return
--         end

--         if self.数据[道具id].识别码 or not string.find(self.数据[道具id].识别码,数字id)) then
--             self.数据[道具id]=nil
--             玩家数据[id].角色.数据[丢弃类型][物品格子]=nil
--         else
--               local 识别码 = self.数据[道具id].识别码
--               玩家数据[id].角色:日志记录("丢弃道具["..self.数据[道具id].名称.."],道具识别码为"..识别码)
--               self.数据[道具id]=nil
--               玩家数据[id].角色.数据[丢弃类型][物品格子]=nil
--               self:删除同类物品(识别码)
--         end

--         if 丢弃类型=="法宝" then
--             self:索要法宝(连接id,id)
--         else
--             self:刷新道具行囊(id,数据.类型)
--         end




-- end


function 道具处理类:丢弃道具(连接id,id,数据)
        if not 数据.类型 or not 数据.物品 or not tonumber(数据.物品) then return end
         if 数据.类型~="道具" then 常规提示(id,"#Y只有道具包裹才可以丢弃道具") return end
         local 物品格子= tonumber(数据.物品)
         if not 物品格子 or 物品格子==0 then return end
         local 道具id = 玩家数据[id].角色.数据.道具[物品格子]
         if not 道具id or 道具id==0 or not self.数据[道具id] or  self.数据[道具id]==0 then return end
        if self.数据[道具id].名称=="帮派银票"  then
            常规提示(id,"#Y该物品无法丢弃")
            self:刷新道具行囊(id,数据.类型)
            return
        end
        if self.数据[道具id].总类=="跑商商品" then
            常规提示(id,"#Y该物品无法丢弃")
            self:刷新道具行囊(id,数据.类型)
            return
        end
        if  self.数据[道具id].加锁~=nil then
            常规提示(id,"#Y加锁物品无法丢弃")
            self:刷新道具行囊(id,数据.类型)
            return
        end
        if  string.find(self.数据[道具id].名称,"会员卡")~=nil then
            常规提示(id,"#Y该物品无法丢弃")
            self:刷新道具行囊(id,数据.类型)
            return
        end
        if self.数据[道具id].数量 and tonumber(self.数据[道具id].数量) and self.数据[道具id].数量~=math.floor(self.数据[道具id].数量) then
                __gge.print(false,6,时间转换(os.time()).."账号:")
                __gge.print(false,11,玩家数据[id].账号)
                __gge.print(false,6,"ID:")
                __gge.print(false,11,id)
                __gge.print(false,6,"名称:")
                __gge.print(false,11,玩家数据[id].角色.数据.名称)
                __gge.print(false,10," 丢弃刷出物品被封禁")
              共享货币[玩家数据[id].账号]:充值记录("丢弃刷出物品被封禁")
              封禁账号(id,"1")
             return
        end


        if  not self.数据[道具id].识别码 then
            self.数据[道具id]=nil
            玩家数据[id].角色.数据.道具[物品格子]=nil
        else
              local 识别码 = self.数据[道具id].识别码
              玩家数据[id].角色:日志记录("丢弃道具["..self.数据[道具id].名称.."],道具识别码为"..识别码)
              self.数据[道具id]=nil
              玩家数据[id].角色.数据.道具[物品格子]=nil
              self:删除同类物品(识别码)
        end
        道具刷新(id)




end



function 道具处理类:刷新道具行囊(id,数据)
    if 数据=="道具" then
        self:索要道具(玩家数据[id].连接id,id)
    else
        self:索要行囊(玩家数据[id].连接id,id)
    end
    道具刷新(id)
end

-- function 道具处理类:道具格子互换(连接id,id,数据,多角色)
--   if 数据.放置id == nil or 数据.抓取id == nil or 数据.放置类型 == nil or 数据.抓取类型 == nil then
--     return
--   end
--   if 数据.放置类型==数据.抓取类型 and 数据.放置id==数据.抓取id then
--     道具刷新(id,多角色)
--     return
--   end
--   if 玩家数据[id].角色.数据[数据.抓取类型] == nil or 玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id] == nil or self.数据[玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]] == nil then
--       道具刷新(id,多角色)
--       return
--   end
--   -- if 数据.放置类型~=数据.抓取类型 and self.数据[玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]].总类==1000 then
--   --   if self.数据[玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]].分类~=1 then
--   --     常规提示(id,"#Y只有一级法宝才可以移动")
--   --     return
--   --   end
--   -- end
--   if 数据.放置类型~=数据.抓取类型 and 数据.抓取类型=="法宝"  and 玩家数据[id].角色.数据[数据.放置类型][数据.放置id] ~= nil and  self.数据[玩家数据[id].角色.数据[数据.放置类型][数据.放置id]].总类~= 1000 then
--       常规提示(id,"#Y法宝栏只可以放入法宝哟",多角色)
--       return
--   end
--    if 数据.放置类型~=数据.抓取类型 and 数据.抓取类型=="灵宝"  and 玩家数据[id].角色.数据[数据.放置类型][数据.放置id] ~= nil and  self.数据[玩家数据[id].角色.数据[数据.放置类型][数据.放置id]].总类~= 1005 then
--       常规提示(id,"#Y法宝栏只可以放入法宝哟",多角色)
--       return
--   end
--   if 数据.放置类型~=数据.抓取类型 and 玩家数据[id].角色.数据[数据.放置类型][数据.放置id] ~= nil and  (self.数据[玩家数据[id].角色.数据[数据.放置类型][数据.放置id]].总类== "帮派银票" or string.find(self.数据[玩家数据[id].角色.数据[数据.放置类型][数据.放置id]].名称,"会员卡")~=nil or  self.数据[玩家数据[id].角色.数据[数据.放置类型][数据.放置id]].总类== "跑商商品") then
--       常规提示(id,"#Y该物品无法放入行囊",多角色)
--       return
--   end
--   if 数据.放置类型~=数据.抓取类型 and 玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id] ~= nil and  (self.数据[玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]].总类== "帮派银票" or  self.数据[玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]].总类== "跑商商品") then
--       常规提示(id,"#Y该物品无法放入道具",多角色)
--       return
--   end
--   if 数据.放置类型=="行囊" and self.数据[玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]].名称=="帮派银票" then
--       常规提示(id,"#Y帮派银票无法放入行囊",多角色)
--       return
--   end
--   if 数据.放置类型=="法宝" and self.数据[玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]].总类~=1000 then
--     常规提示(id,"#Y法宝栏只可以放入法宝哟",多角色)
--     return
--   end
--   if 数据.放置类型=="灵宝" and self.数据[玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]].总类~=1005 then
--     常规提示(id,"#Y法宝栏只可以放入法宝哟",多角色)
--     return
--   end
--   if 玩家数据[id].角色.数据[数据.放置类型][数据.放置id]==nil then --没有道具
--     玩家数据[id].角色.数据[数据.放置类型][数据.放置id]=玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]
--     玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]=nil
--   else
--     self.允许互换=true
--     local 放置id=玩家数据[id].角色.数据[数据.放置类型][数据.放置id]
--     local 抓取id=玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]
--     if 放置id~=nil and 抓取id~=nil and self.数据[抓取id].数量~=nil and self.数据[放置id].数量~=nil and self.数据[放置id].名称==self.数据[抓取id].名称 then
--       if self.数据[抓取id].数量<999 and self.数据[放置id].数量<999 then
--         if self.数据[抓取id].阶品~= nil and self.数据[放置id].阶品~=nil and self.数据[抓取id].阶品~=self.数据[放置id].阶品 then
--           常规提示(id,"#Y不同阶品的物品，无法叠加",多角色)
--           道具刷新(id,多角色)
--           return
--         elseif self.数据[抓取id].食材~= nil and self.数据[放置id].食材~=nil and self.数据[抓取id].食材~=self.数据[放置id].食材 then
--           常规提示(id,"#Y不同食材的元宵，无法叠加",多角色)
--           道具刷新(id,多角色)
--           return
--         elseif self.数据[抓取id].名称== "藏宝图" and self.数据[放置id].名称=="藏宝图" then
--           常规提示(id,"#Y藏宝图，无法叠加",多角色)
--           道具刷新(id,多角色)
--           return
--         elseif self.数据[抓取id].名称== "高级藏宝图" and self.数据[放置id].名称=="高级藏宝图" then
--           常规提示(id,"#Y藏宝图，无法叠加",多角色)
--           道具刷新(id,多角色)
--           return
--         end
--         if self.数据[抓取id].数量+self.数据[放置id].数量<=999 then
--           self.数据[放置id].数量=self.数据[放置id].数量+self.数据[抓取id].数量
--           self.数据[抓取id]=nil
--           玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]=nil
--           self.允许互换=false
--         else
--           local 临时数量=self.数据[放置id].数量+self.数据[抓取id].数量-999
--           self.数据[放置id].数量=999
--           self.数据[抓取id].数量=临时数量
--           self.允许互换=false
--         end
--       end
--     end
--     if self.允许互换 then
--       玩家数据[id].角色.数据[数据.放置类型][数据.放置id]=玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]
--       玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]=放置id
--     end
--   end
--   if not 多角色 then
--       if 数据.放置类型=="道具" then
--         self:索要道具(连接id,id)
--       elseif 数据.放置类型=="法宝" then
--         self:索要法宝(连接id,id)
--       else
--         self:索要行囊(连接id,id)
--       end
--   end

--   道具刷新(id,多角色)
-- end



-- function 道具处理类:道具格子互换1(连接id,id,数据,多角色)
--   local 放置id = 玩家数据[id].角色:取道具格子1(数据.放置类型)
--   if 放置id  == 0 then
--     常规提示(id,"#Y"..数据.放置类型.."已满！",多角色)
--     道具刷新(id,多角色)
--     return
--   end
--   if 数据.放置类型==数据.抓取类型 then
--     道具刷新(id,多角色)
--     return
--   end
--   if 玩家数据[id].角色.数据[数据.抓取类型] == nil or 玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id] == nil or self.数据[玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]] == nil then
--     道具刷新(id,多角色)
--     return
--   end
--   if self.数据[玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]].总类==1000 and 数据.放置类型~=数据.抓取类型 then
--     -- if self.数据[玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]].分类~=1 then
--     --   发送数据(连接id,3699)
--     --   常规提示(id,"#Y只有一级法宝才可以移动")
--     --   return
--     -- end
--   end
--   if 数据.放置类型~="道具" and 数据.放置类型~="行囊" and 数据.放置类型~="法宝" and 数据.放置类型~="灵宝" then
--     道具刷新(id,多角色)
--     return
--   end
--   if 数据.抓取类型~="道具" and 数据.抓取类型~="行囊" and 数据.抓取类型~="法宝" and 数据.抓取类型~="灵宝" then
--     道具刷新(id,多角色)
--     return
--   end
--   if 数据.放置类型=="法宝" and self.数据[玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]].总类~=1000 then
--     道具刷新(id,多角色)
--     常规提示(id,"#Y法宝栏只可以放入法宝哟",多角色)
--     return
--   end
--    if 数据.放置类型=="灵宝" and self.数据[玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]].总类~=1005 then
--     道具刷新(id,多角色)
--     常规提示(id,"#Y法宝栏只可以放入法宝哟",多角色)
--     return
--   end
--   if 数据.放置类型=="行囊" and (self.数据[玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]].总类=="帮派银票" or string.find(self.数据[玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]].名称,"会员卡")~=nil or  self.数据[玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]].总类== "跑商商品") then
--     道具刷新(id,多角色)
--     常规提示(id,"#Y帮派银票以及跑商物品无法放入行囊",多角色)
--     return
--   end
--   if 放置id~=0 then --没有道具
--     玩家数据[id].角色.数据[数据.放置类型][放置id]=玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]
--     玩家数据[id].角色.数据[数据.抓取类型][数据.抓取id]=nil
--     if not 多角色 then
--        if 数据.放置类型=="道具" then
--           self:索要道具(连接id,id)
--        elseif 数据.放置类型=="法宝" or 数据.放置类型=="灵宝" then
--           self:索要法宝(连接id,id)
--        else
--           self:索要行囊(连接id,id)
--        end
--     end
--     道具刷新(id,多角色)
--   end
-- end








function 道具处理类:道具格子互换(连接id,id,数据,多角色)
          local 放置包裹 =数据.放置类型
          local 抓取包裹 = 数据.抓取类型
           if 放置包裹~=抓取包裹 then
            道具刷新(id,多角色)
            return
          end
          if 放置包裹~="道具" and 放置包裹~="行囊" and 放置包裹~="法宝" and 放置包裹~="灵宝" then
            道具刷新(id,多角色)
            return
          end
          if 抓取包裹~="道具" and 抓取包裹~="行囊" and 抓取包裹~="法宝" and 抓取包裹~="灵宝" then
            道具刷新(id,多角色)
            return
          end
          local 放置id = tonumber(数据.放置id)
          local 抓取id = tonumber(数据.抓取id)
          if not 放置id or 放置id==0 or not 抓取id or 抓取id==0 then
              道具刷新(id,多角色)
              return
          end
          if 放置包裹==抓取包裹 and 放置id == 抓取id then
              道具刷新(id,多角色)
              return
          end

          if not 玩家数据[id].角色.数据[抓取包裹]  then
              道具刷新(id,多角色)
              return
          end
          local 抓取道具 =玩家数据[id].角色.数据[抓取包裹][抓取id]
          if not 抓取道具 or 抓取道具==0 or not self.数据[抓取道具] or self.数据[抓取道具]==0 then
               道具刷新(id,多角色)
              return
          end
          if not 玩家数据[id].角色.数据[放置包裹][放置id] then
                玩家数据[id].角色.数据[放置包裹][放置id] = 玩家数据[id].角色.数据[抓取包裹][抓取id]
                玩家数据[id].角色.数据[抓取包裹][抓取id] = nil
          else
              local 放置道具 = 玩家数据[id].角色.数据[放置包裹][放置id]
              if not self.数据[放置道具] then
                  玩家数据[id].角色.数据[放置包裹][放置id] = 玩家数据[id].角色.数据[抓取包裹][抓取id]
                  玩家数据[id].角色.数据[抓取包裹][抓取id] = nil
              else
                    local 计算叠加 = false
                    if self.数据[抓取道具].名称 ==  self.数据[放置道具].名称 and self.数据[放置道具].可叠加 and self.数据[放置道具].数量 and tonumber(self.数据[放置道具].数量)
                       and self.数据[抓取道具].数量 and tonumber(self.数据[抓取道具].数量) and self.数据[放置道具].数量<999 then
                           if self.额外叠加[self.数据[放置道具].名称] then
                                    计算叠加 = true
                            elseif self.数据[放置道具].名称 == "元宵" then
                                  if self.数据[抓取道具].食材== self.数据[放置道具].食材 then
                                     计算叠加 = true
                                  end
                            elseif self.数据[放置道具].名称 == "鸿蒙原石" then
                                  if self.数据[抓取道具].附带词条== self.数据[放置道具].附带词条 and self.数据[抓取道具].数额== self.数据[放置道具].数额 then
                                     计算叠加 = true
                                  end
                            elseif self.数据[放置道具].名称 == "太初原石" then
                                  if self.数据[抓取道具].附带词条== self.数据[放置道具].附带词条 then
                                     计算叠加 = true
                                  end
                            else
                                  if not self.数据[放置道具].阶品 then
                                          计算叠加 = true
                                  elseif self.数据[抓取道具].阶品==self.数据[放置道具].阶品 then
                                          计算叠加 = true
                                  end
                            end
                    end

                    if 计算叠加 then
                         if self.数据[放置道具].数量+self.数据[抓取道具].数量<=999 then
                              local 识别码 = self.数据[抓取道具].识别码
                              self.数据[放置道具].数量=self.数据[放置道具].数量+self.数据[抓取道具].数量
                              self.数据[抓取道具]=nil
                              self:删除同类物品(识别码)
                              玩家数据[id].角色.数据[抓取包裹][抓取id] =nil
                         else
                              local 临时数量 = self.数据[放置道具].数量 + self.数据[抓取道具].数量 - 999
                              self.数据[放置道具].数量 = 999
                              self.数据[抓取道具].数量 = 临时数量
                          end
                    else
                        玩家数据[id].角色.数据[抓取包裹][抓取id] = 放置道具
                        玩家数据[id].角色.数据[放置包裹][放置id] = 抓取道具
                    end

              end

          end

          if not 多角色 then
              if 放置包裹=="道具" then
                self:索要道具(连接id,id)
              elseif 放置包裹=="法宝" then
                self:索要法宝(连接id,id)
              else
                self:索要行囊(连接id,id)
              end
          end
          道具刷新(id,多角色)


end








function 道具处理类:道具格子互换1(连接id,id,数据,多角色)
          local 放置包裹 = 数据.放置类型
          local 抓取包裹 = 数据.抓取类型
          if 放置包裹==抓取包裹 then
            道具刷新(id,多角色)
            return
          end
          if 放置包裹~="道具" and 放置包裹~="行囊" and 放置包裹~="法宝" and 放置包裹~="灵宝" then
            道具刷新(id,多角色)
            return
          end
          if 抓取包裹~="道具" and 抓取包裹~="行囊" and 抓取包裹~="法宝" and 抓取包裹~="灵宝" then
            道具刷新(id,多角色)
            return
          end
          local 抓取id = tonumber(数据.抓取id)
          if not 抓取id or 抓取id ==0 then
             道具刷新(id,多角色)
            return
          end
          local 放置id = 玩家数据[id].角色:取道具格子1(放置包裹)
          if not 放置id or 放置id  == 0 then
              常规提示(id,"#Y"..放置包裹.."包裹已满！",多角色)
              道具刷新(id,多角色)
              return
          end
          if not 玩家数据[id].角色.数据[抓取包裹]  then
            道具刷新(id,多角色)
            return
          end
          local 抓取编号 = 玩家数据[id].角色.数据[抓取包裹][抓取id]
          if not 抓取编号 or 抓取编号==0 or not self.数据[抓取编号] or  self.数据[抓取编号] ==0 then
            道具刷新(id,多角色)
            return
          end
          if 放置包裹=="法宝" and  self.数据[抓取编号].总类~=1000 then
            道具刷新(id,多角色)
            常规提示(id,"#Y法宝栏只可以放入法宝哟",多角色)
            return
          end
         if 放置包裹=="灵宝" and self.数据[抓取编号].总类~=1005 then
            道具刷新(id,多角色)
            常规提示(id,"#Y法宝栏只可以放入法宝哟",多角色)
            return
          end
          if 放置包裹~="道具" and (self.数据[抓取编号].总类=="帮派银票" or string.find(self.数据[抓取编号].名称,"会员卡")~=nil or  self.数据[抓取编号].总类== "跑商商品") then
            道具刷新(id,多角色)
            常规提示(id,"#Y帮派银票以及跑商物品无法放入该行囊",多角色)
            return
          end
        if 放置id and 放置id~=0 then --没有道具
              玩家数据[id].角色.数据[放置包裹][放置id]=玩家数据[id].角色.数据[抓取包裹][抓取id]
              玩家数据[id].角色.数据[抓取包裹][抓取id]=nil
              if not 多角色 then
                 if 放置包裹=="道具" then
                    self:索要道具(连接id,id)
                 elseif 放置包裹=="法宝" or 放置包裹=="灵宝" then
                    self:索要法宝(连接id,id)
                 else
                    self:索要行囊(连接id,id)
                 end
              end
              道具刷新(id,多角色)
        end
end





function 道具处理类:索要法宝(连接id,id,多角色)
    self.发送数据={法宝={},佩戴={},灵宝={},灵宝佩戴={},神器佩戴=false,神器数据={}}
    local  唯一编号 = {}
    for k,v in pairs(玩家数据[id].角色.数据.法宝) do
        if self.数据[v] and not 唯一编号[v] then
            self.发送数据.法宝[k]=DeepCopy(self.数据[v])
            唯一编号[v]=true
        else
            玩家数据[id].角色.数据.法宝[k]=nil
        end
    end
    for k,v in pairs(玩家数据[id].角色.数据.法宝佩戴) do
        if self.数据[v] and not 唯一编号[v] then
            self.发送数据.佩戴[k]=DeepCopy(self.数据[v])
            唯一编号[v]=true
        else
            玩家数据[id].角色.数据.法宝佩戴[k]=nil
        end
    end
    for k,v in pairs(玩家数据[id].角色.数据.灵宝) do
        if self.数据[v] and not 唯一编号[v] then
            self.发送数据.灵宝[k]=DeepCopy(self.数据[v])
            唯一编号[v]=true
        else
            玩家数据[id].角色.数据.灵宝[k]=nil
        end
    end
    for k,v in pairs(玩家数据[id].角色.数据.灵宝佩戴) do
        if self.数据[v] and not 唯一编号[v] then
            self.发送数据.灵宝佩戴[k]=DeepCopy(self.数据[v])
            唯一编号[v]=true
        else
            玩家数据[id].角色.数据.灵宝佩戴[k]=nil
        end
    end
    if 玩家数据[id].神器 and 玩家数据[id].神器.数据 and 玩家数据[id].神器.数据.神器技能 and 玩家数据[id].角色.数据.门派~="无门派" then
        self.发送数据.神器数据 = DeepCopy(玩家数据[id].神器.数据)
        self.发送数据.神器佩戴 = 玩家数据[id].角色.数据.神器佩戴
    end
    if 多角色~=nil then
       return self.发送数据
    else
        发送数据(连接id,3527,self.发送数据)
    end

end

function 道具处理类:索要道具(连接id,id)
  self.发送数据={道具={}}
  local  唯一编号 = {}
  for k,v in pairs(玩家数据[id].角色.数据.道具) do
      if self.数据[v] and not 唯一编号[v] then
          self.发送数据.道具[k]=DeepCopy(self.数据[v])
          唯一编号[v]=true
      else
          玩家数据[id].角色.数据.道具[k]=nil
      end
  end
  self.发送数据.体力=玩家数据[id].角色.数据.体力
  self.发送数据.银子=玩家数据[id].角色.数据.银子
  self.发送数据.储备=玩家数据[id].角色.数据.储备
  self.发送数据.存银=玩家数据[id].角色.数据.存银
  self.发送数据.总格 = 40 + (玩家数据[id].角色.数据.扩展背包 or 0)
  发送数据(连接id,3501,self.发送数据)
end

function 道具处理类:索要道具1(id)
  self.发送数据={道具={}}
  local  唯一编号 = {}
  for k,v in pairs(玩家数据[id].角色.数据.道具) do
      if self.数据[v] and not 唯一编号[v] then
          self.发送数据.道具[k]=DeepCopy(self.数据[v])
          唯一编号[v]=true
      else
          玩家数据[id].角色.数据.道具[k]=nil
      end
  end
  self.发送数据.体力=玩家数据[id].角色.数据.体力
  self.发送数据.银子=玩家数据[id].角色.数据.银子
  self.发送数据.储备=玩家数据[id].角色.数据.储备
  self.发送数据.存银=玩家数据[id].角色.数据.存银
  return self.发送数据
end

function 道具处理类:索要道具2(id)
  self.发送数据={道具={}}
  local  唯一编号 = {}
  for k,v in pairs(玩家数据[id].角色.数据.道具) do
      if self.数据[v] and not 唯一编号[v] then
          self.发送数据.道具[k]=DeepCopy(self.数据[v])
          唯一编号[v]=true
      else
          玩家数据[id].角色.数据.道具[k]=nil
      end
  end
  return self.发送数据
end

function 道具处理类:索要道具3(id)
  self.发送数据 = {道具={}}
   local  唯一编号 = {}
  for k,v in pairs(玩家数据[id].角色.数据.道具) do
      if self.数据[v] and not 唯一编号[v] then
          self.发送数据.道具[k]=DeepCopy(self.数据[v])
          唯一编号[v]=true
      else
          玩家数据[id].角色.数据.道具[k]=nil
      end
  end
  self.发送数据.体力=玩家数据[id].角色.数据.体力
  self.发送数据.银子=玩家数据[id].角色.数据.银子
  self.发送数据.储备=玩家数据[id].角色.数据.储备
  self.发送数据.存银=玩家数据[id].角色.数据.存银

  return self.发送数据
end



function 道具处理类:索要道具4(id,类型)
  self.发送数据={道具={}}
  local  唯一编号 = {}
  for k,v in pairs(玩家数据[id].角色.数据[类型]) do
      if self.数据[v] and not 唯一编号[v] then
          self.发送数据.道具[k]=DeepCopy(self.数据[v])
           唯一编号[v]=true
      else
          玩家数据[id].角色.数据[类型][k]=nil
      end
  end
  self.发送数据.数据类型=类型
  return self.发送数据
end


function 道具处理类:重置法宝回合(id)
      for k,v in pairs(玩家数据[id].角色.数据.法宝) do
          if self.数据[v] then
               self.数据[v].回合=nil
          else
              玩家数据[id].角色.数据.法宝[k]=nil
          end
      end
end

function 道具处理类:索要法宝2(id,回合)
  self.发送数据={道具={}}
  local  唯一编号 = {}
  for k,v in pairs(玩家数据[id].角色.数据.法宝) do
      if self.数据[v] and not 唯一编号[v] then
          self.发送数据.道具[k]=DeepCopy(self.数据[v])
          唯一编号[v]=true
          if self.数据[v].回合 then
              if self.数据[v].回合<=回合 then
                  self.发送数据.道具[k].回合=nil
              else
                  self.发送数据.道具[k].回合=self.发送数据.道具[k].回合-回合
              end
          end
      else
          玩家数据[id].角色.数据.法宝[k]=nil
      end
  end
  self.发送数据.银子=玩家数据[id].角色.数据.银子
  self.发送数据.储备=玩家数据[id].角色.数据.储备
  self.发送数据.存银=玩家数据[id].角色.数据.存银
  return self.发送数据
end


function 道具处理类:索要法宝1(id,回合)
  self.发送数据={道具={}}
   local  唯一编号 = {}
  for k,v in pairs(玩家数据[id].角色.数据.法宝) do
      if self.数据[v] and not 唯一编号[v] then
          self.发送数据.道具[k]=DeepCopy(self.数据[v])
          唯一编号[v]=true
          if self.数据[v].回合 then
              if self.数据[v].回合<=回合 then
                  self.发送数据.道具[k].回合=nil
              else
                  self.发送数据.道具[k].回合=self.发送数据.道具[k].回合-回合
              end
          end
      else
          玩家数据[id].角色.数据.法宝[k]=nil
      end
  end
  return self.发送数据
end

function 道具处理类:索要行囊(连接id,id)
 self.发送数据={道具={}}
  local  唯一编号 = {}
   for k,v in pairs(玩家数据[id].角色.数据.行囊) do
      if self.数据[v] and not 唯一编号[v] then
          self.发送数据.道具[k]=DeepCopy(self.数据[v])
            唯一编号[v]=true
      else
          玩家数据[id].角色.数据.行囊[k]=nil
      end
  end
  self.发送数据.银子=玩家数据[id].角色.数据.银子
  self.发送数据.储备=玩家数据[id].角色.数据.储备
  self.发送数据.存银=玩家数据[id].角色.数据.存银
  发送数据(连接id,3502,self.发送数据)
end


function 道具处理类:帮派点修处理(连接id,数字id,数据)
    local 消耗银子 = 0
    local 帮派编号 = 玩家数据[数字id].角色.数据.帮派数据.编号
    local 帮派资材 = 帮派数据[帮派编号].帮派资材.当前
    local 帮贡 = 玩家数据[数字id].角色.数据.帮贡
    local 帮贡上限 = 帮派数据[帮派编号].成员数据[数字id].帮贡.上限
    local 帮贡当前 = 帮派数据[帮派编号].成员数据[数字id].帮贡.当前
    if 数据.修炼项目 == "攻击修炼" or 数据.修炼项目 == "法术修炼" or 数据.修炼项目 == "猎术修炼" then
        消耗银子 = 30000
    else
        消耗银子 = 20000
    end
    if 数据.修炼项目 == nil then
      常规提示(数字id,"#Y/请选择你要提升的修炼")
      return
    end
    if 玩家数据[数字id].角色.数据.修炼[数据.修炼项目][1]>=玩家数据[数字id].角色.数据.修炼[数据.修炼项目][3] then
      常规提示(数字id,"#Y/你的此项修炼已经达上限")
      return
    end
    if 取银子(数字id)+取储备(数字id) < 消耗银子 then
        常规提示(数字id,"#Y/你的当前的银子不够修炼哦")
        return
    end
    if 帮贡 < 5 then
        常规提示(数字id,"#Y/当前帮贡不足5点，无法进行帮派点修")
        return
    end
    if 帮贡当前 < 5 then
        常规提示(数字id,"#Y/当前帮贡不足5点，无法进行帮派点修")
        return
    end
      if 帮派资材 < 5 then
        常规提示(数字id,"#Y/贵帮当前的资材不足5点，无法进行帮派点修")
        return
      end
    -- 扣除帮贡(数字id,15)
    帮派数据[帮派编号].帮派资材.当前 = 帮派数据[帮派编号].帮派资材.当前 -5
    帮派数据[帮派编号].成员数据[数字id].帮贡.当前 = 帮派数据[帮派编号].成员数据[数字id].帮贡.当前 -5
    玩家数据[数字id].角色.数据.帮贡 =帮派数据[帮派编号].成员数据[数字id].帮贡.当前
    玩家数据[数字id].角色:扣除储备和银子(消耗银子,"帮派点修")
    玩家数据[数字id].角色:帮派添加人物修炼经验(数字id,10,数据.修炼项目)
end


function 道具处理类:补充法宝灵气(连接id,id,编号)
  local 道具id=玩家数据[id].角色.数据.法宝[编号]
  if 道具id==nil or self.数据[道具id]==nil then
    常规提示(id,"#Y你没有这件法宝")
    self:索要法宝(连接id,id)
    return
  end
  local 临时数据={}
  临时数据.模型=玩家数据[id].角色.数据.模型
  临时数据.名称="法宝灵气补充"
  临时数据.对话="#Y将根据你选择的法宝来进行补充灵气，1级法宝50W，2级法宝100W，3级法宝200W的银子，你选择的法宝是："
  临时数据.选项={}
  玩家数据[id].角色.补充法宝 = self.数据[道具id]
  table.insert(临时数据.选项,self.数据[道具id].分类.."级法宝")
  table.insert(临时数据.选项,"先不补充了")
  发送数据(连接id,1501,临时数据)
  玩家数据[id].补充灵气id = 道具id
end
function 道具处理类:补充灵宝灵气(连接id,id,编号)
  local 道具id=玩家数据[id].角色.数据.灵宝[编号]
  if 道具id==nil or self.数据[道具id]==nil then
    常规提示(id,"#Y你没有这件灵宝")
    self:索要法宝(连接id,id)
    return
  end
  self.数据[道具id].魔法=取灵气上限(1)
  self:索要法宝(连接id,id)
end

function 道具处理类:首席争霸奖励(id,门派)
  -- if 首席争霸数据[门派]==nil then
  --   常规提示(id,"你没有这样的奖励可以领取")
  --   return 0
  -- elseif 首席争霸数据[门派][id]==nil then
  --   常规提示(id,"你没有这样的奖励可以领取")
  --   return 0
  -- elseif 首席争霸数据[门派][id].奖励==false then
  --   常规提示(id,"你没有这样的奖励可以领取")
  --   return 0
  -- else
  --   local 等级=玩家数据[id].角色.数据.等级
  --   首席争霸数据[门派][id].奖励=false
  --   self.经验奖励=math.floor(等级*等级*等级)
  --   self.银子奖励=100000
  --   if 首席争霸[门派]~=nil and 首席争霸[门派].id==id then
  --   玩家数据[id].角色:添加经验(self.经验奖励,"首席争霸赛奖励")
  --   玩家数据[id].角色:添加银子(self.银子奖励,"首席争霸赛奖励",1)

  --   else
  --   玩家数据[id].角色:添加经验(self.经验奖励,"首席争霸赛奖励")
  --   玩家数据[id].角色:添加银子(self.银子奖励,"首席争霸赛奖励",1)

  --   end
  -- end
end





function 道具处理类:发放雪人奖励(id)
--  任务处理类:全服蚩尤(self.任务id,id组)
  local 名称="1千储备"
  玩家数据[id].角色:添加储备(1000,"雪人奖励",1)
  if 取随机数() <= 10 then
    广播消息({内容=format("#S(雪人奖励)#Y#R/%s#Y获得雪人赠送的#G/%s#Y",玩家数据[id].角色.数据.名称,名称),频道="xt"})
  end
end

function 道具处理类:雪人积分兑换(id)
  if 玩家数据[id].角色.数据.春节雪人==nil then
    常规提示(id,"你还没有获得雪人积分。")
    return
  elseif 玩家数据[id].角色.数据.春节雪人<500 then
    常规提示(id,"本次操作需要消耗500点雪人积分。")
    return
  end
  玩家数据[id].角色.数据.春节雪人 = 玩家数据[id].角色.数据.春节雪人 - 500
end




return 道具处理类