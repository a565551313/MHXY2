
local 每日活动类 = class()
function 每日活动类:初始化()
  self.玩家id = 0
  self.连接id = 0
  self.领取数据={}
  self.写入数据={}
  self.活动分类={"每日消费","每日充值","神秘礼包","超值抢购"}
  for i=1,#self.活动分类 do
      self[self.活动分类[i]] = {文本文件={},消费说明={},需求积分={},物品数量={},物品={}}
  end

end




function 每日活动类:加载数据(账号,玩家id)
  self.玩家id =玩家id
  self.连接id=玩家数据[玩家id].连接id
  local 需要写出 = false
  if f函数.文件是否存在([[每日活动/领取数据/]]..账号..".txt")==false then
      for i=1,#self.活动分类 do
        self.领取数据[self.活动分类[i]] ={数额=0,到期时间=os.time()+86400}
      end
      需要写出 = true
  else
       self.领取数据=table.loadstring(读入文件([[每日活动/领取数据/]]..账号..".txt"))
  end
  for i=1,#self.活动分类 do
      if os.time() > self.领取数据[self.活动分类[i]].到期时间 then
        self.领取数据[self.活动分类[i]] ={数额=0,到期时间=os.time()+86400}
      end
      self[self.活动分类[i]] = {文本文件={},消费说明={},需求积分={},物品数量={},物品={}}
      self[self.活动分类[i]].文本文件 = 取文件的所有名 (程序目录..[[\每日活动\]]..self.活动分类[i]..[[\]])
      for n=1,#self[self.活动分类[i]].文本文件 do
        self[self.活动分类[i]].消费说明[n] = f函数.读配置(程序目录..[[每日活动\]]..self.活动分类[i]..[[\]]..self[self.活动分类[i]].文本文件[n]..".txt","兑换配置","消费说明")
        self[self.活动分类[i]].需求积分[n] = tonumber(f函数.读配置(程序目录..[[每日活动\]]..self.活动分类[i]..[[\]]..self[self.活动分类[i]].文本文件[n]..".txt","兑换配置","需求积分"))
        self[self.活动分类[i]].物品数量[n] = tonumber(f函数.读配置(程序目录..[[每日活动\]]..self.活动分类[i]..[[\]]..self[self.活动分类[i]].文本文件[n]..".txt","兑换配置","物品数量"))
        self[self.活动分类[i]].物品[n]={}
        for k=1,self[self.活动分类[i]].物品数量[n]  do
            self[self.活动分类[i]].物品[n][k]={}
            self[self.活动分类[i]].物品[n][k].名称 = f函数.读配置(程序目录..[[每日活动\]]..self.活动分类[i]..[[\]]..self[self.活动分类[i]].文本文件[n]..".txt","兑换配置","物品"..k)
            self[self.活动分类[i]].物品[n][k].数量=tonumber(f函数.读配置(程序目录..[[每日活动\]]..self.活动分类[i]..[[\]]..self[self.活动分类[i]].文本文件[n]..".txt","兑换配置","数量"..k))
        end
         if self.领取数据[self.活动分类[i]][n] ==nil then
            self.领取数据[self.活动分类[i]][n] =false
            需要写出 = true
        end
      end
  end
 if 需要写出 then
    写出文件([[每日活动/领取数据/]]..账号..".txt",table.tostring(self.领取数据))
    self.领取数据=table.loadstring(读入文件([[每日活动/领取数据/]]..账号..".txt"))
  end
end


function 每日活动类:重新加载数据()
      self.领取数据=table.loadstring(读入文件([[每日活动/领取数据/]]..玩家数据[self.玩家id].账号..".txt"))
      local 需要写出 = false
      for i=1,#self.活动分类 do
          if os.time() > self.领取数据[self.活动分类[i]].到期时间 then
             self.领取数据[self.活动分类[i]] ={数额=0,到期时间=os.time()+86400}
             需要写出 = true
          end
          self[self.活动分类[i]] = {文本文件={},消费说明={},需求积分={},物品数量={},物品={}}
          self[self.活动分类[i]].文本文件 = 取文件的所有名 (程序目录..[[\每日活动\]]..self.活动分类[i]..[[\]])
          for n=1,#self[self.活动分类[i]].文本文件 do
            self[self.活动分类[i]].消费说明[n] = f函数.读配置(程序目录..[[每日活动\]]..self.活动分类[i]..[[\]]..self[self.活动分类[i]].文本文件[n]..".txt","兑换配置","消费说明")
            self[self.活动分类[i]].需求积分[n] = tonumber(f函数.读配置(程序目录..[[每日活动\]]..self.活动分类[i]..[[\]]..self[self.活动分类[i]].文本文件[n]..".txt","兑换配置","需求积分"))
            self[self.活动分类[i]].物品数量[n] = tonumber(f函数.读配置(程序目录..[[每日活动\]]..self.活动分类[i]..[[\]]..self[self.活动分类[i]].文本文件[n]..".txt","兑换配置","物品数量"))
            self[self.活动分类[i]].物品[n]={}
            for k=1,self[self.活动分类[i]].物品数量[n]  do
                self[self.活动分类[i]].物品[n][k]={}
                self[self.活动分类[i]].物品[n][k].名称 = f函数.读配置(程序目录..[[每日活动\]]..self.活动分类[i]..[[\]]..self[self.活动分类[i]].文本文件[n]..".txt","兑换配置","物品"..k)
                self[self.活动分类[i]].物品[n][k].数量=tonumber(f函数.读配置(程序目录..[[每日活动\]]..self.活动分类[i]..[[\]]..self[self.活动分类[i]].文本文件[n]..".txt","兑换配置","数量"..k))
            end
             if self.领取数据[self.活动分类[i]][n] ==nil then
                self.领取数据[self.活动分类[i]][n] =false
                需要写出 = true
            end
          end
      end
      if 需要写出 then
        写出文件([[每日活动/领取数据/]]..玩家数据[self.玩家id].账号..".txt",table.tostring(self.领取数据))
        self.领取数据=table.loadstring(读入文件([[每日活动/领取数据/]]..玩家数据[self.玩家id].账号..".txt"))
      end
end




function 每日活动类:数据处理(内容)
  self.写入数据 ={}
  if 内容.文本 =="打开" then
    self:获取每日数据("每日消费")
  elseif 内容.文本 =="每日消费" or 内容.文本 =="每日充值" or 内容.文本 =="神秘礼包" or 内容.文本 =="超值抢购" then
    self:获取每日数据(内容.文本)
  elseif 内容.文本 =="每日领取"  then
    self:每日领取处理(内容.标题,内容.编号)
  else
   self:每日查看处理(内容)
  end



end

function 每日活动类:每日查看处理(内容)
   if not 共享货币[玩家数据[self.玩家id].账号] then
      常规提示(self.玩家id,"#Y/数据错误")
      return
  end

  if 内容.文本=="查看会员" or 内容.文本=="购买月卡" or 内容.文本=="领取奖励" then
     if 玩家数据[self.玩家id].角色.数据.月卡.到期时间 < os.time() then
          玩家数据[self.玩家id].角色.数据.月卡.开通 = false
      end
      self.写入数据=自定义数据.月卡数据
      self.写入数据.标题 = "查看会员"

    if  内容.文本=="购买月卡"  then
      -- if self.写入数据.月卡货币 == "仙玉" then
      --   if 玩家数据[self.玩家id].角色:扣除仙玉(self.写入数据.月卡价格,"购买月卡",self.玩家id) then
      --   else
      --     return
      --   end
      -- else
      --    if 扣除点卡(self.写入数据.月卡价格,self.玩家id,"购买月卡") then
      --   else
      --      return
      --   end
      -- end

      -- if 玩家数据[self.玩家id].角色.数据.月卡.到期时间 <=os.time() then
      --    玩家数据[self.玩家id].角色.数据.月卡.到期时间 = os.time()+2592000
      -- else
      --   玩家数据[self.玩家id].角色.数据.月卡.到期时间 = 玩家数据[self.玩家id].角色.数据.月卡.到期时间 + 2592000
      -- end
      --   玩家数据[self.玩家id].角色.数据.月卡.购买时间=os.time()
      --   玩家数据[self.玩家id].角色.数据.月卡.开通=true
        常规提示(self.玩家id,"#Y/无需购买")
    elseif 内容.文本=="领取奖励" then
        if 玩家数据[self.玩家id].角色.数据.月卡.开通== false then
          常规提示(self.玩家id,"#Y/你还未开通月卡，请开通月卡后在操作")
          return
        end
        if 玩家数据[self.玩家id].角色.数据.月卡.当前领取 == os.date("%j") then
          常规提示(self.玩家id,"#Y/你今日奖励已领取")
          return
        end
        if self.写入数据.经验>0 then
          玩家数据[self.玩家id].角色.数据.当前经验 = 玩家数据[self.玩家id].角色.数据.当前经验 + self.写入数据.经验
          常规提示(self.玩家id,"#Y/你获得了#R/"..self.写入数据.经验.."#Y/点经验")
        end
        if self.写入数据.储备>0 then
          玩家数据[self.玩家id].角色.数据.储备 = 玩家数据[self.玩家id].角色.数据.储备 + self.写入数据.储备
          常规提示(self.玩家id,"#Y/你获得了#R/"..self.写入数据.储备.."#Y/两储备")
        end
        if self.写入数据.银子>0 then
          玩家数据[self.玩家id].角色.数据.银子 = 玩家数据[self.玩家id].角色.数据.银子 + self.写入数据.银子
          常规提示(self.玩家id,"#Y/你获得了#R/"..self.写入数据.银子.."#Y/两银子")
        end
        if self.写入数据.抓鬼>0 then
          玩家数据[self.玩家id].角色.数据.自动抓鬼 = 玩家数据[self.玩家id].角色.数据.自动抓鬼 + self.写入数据.抓鬼
          常规提示(self.玩家id,"#Y/你获得了#R/"..self.写入数据.抓鬼.."#Y/次抓鬼")
        end
        if self.写入数据.仙玉>0 then
            共享货币[玩家数据[self.玩家id].账号]:添加仙玉(self.写入数据.仙玉,self.玩家id,"月卡领取")
        end
        if self.写入数据.点卡>0 then
            共享货币[玩家数据[self.玩家id].账号]:添加点卡(self.写入数据.点卡,self.玩家id,"月卡领取")
        end
        if self.写入数据.物品数量>0 then
          for i=1,self.写入数据.物品数量 do
              local 物品名称 = self.写入数据.物品[i].名称
              local 数量 = tonumber(self.写入数据.物品[i].数量)
               仙玉商城类:仙玉商城商品处理(self.玩家id,物品名称,数量)
               常规提示(self.玩家id,"#Y/你获得了#R/"..数量.."#Y/个#R/"..物品名称)
            end
        end
        玩家数据[self.玩家id].角色.数据.月卡.当前领取 = os.date("%j")
        if 玩家数据[self.玩家id].角色.数据.等级>=0 then
         广播消息({内容=format("#S/(%s会员卡）#Y玩家#R/%s#Y/领取了会员每日福利，获得了#S/%s#Y/！！",服务端参数.名称,玩家数据[self.玩家id].角色.数据.名称,自定义数据.月卡数据.显示物品),频道="xt"})
        end
    end
    if self.写入数据.月卡货币 == "仙玉" then
       self.写入数据.玩家货币 = 共享货币[玩家数据[self.玩家id].账号].仙玉
    else
       self.写入数据.玩家货币 = 共享货币[玩家数据[self.玩家id].账号].点卡
    end
    self.写入数据.月卡 =玩家数据[self.玩家id].角色.数据.月卡
  elseif 内容.文本=="查看兑换" or 内容.文本=="兑换货币"  then
    self.写入数据.标题 = "查看兑换"
    self.写入数据.配置数量 = tonumber(f函数.读配置(程序目录..[[每日活动\兑换配置.txt]],"比例配置","配置数量"))
    self.写入数据.配置数据={}
    for i=1,self.写入数据.配置数量 do
      self.写入数据.配置数据[i]={}
      self.写入数据.配置数据[i].比例 = tonumber(f函数.读配置(程序目录..[[每日活动\兑换配置.txt]],"比例配置","比例"..i))
      self.写入数据.配置数据[i].需求 = f函数.读配置(程序目录..[[每日活动\兑换配置.txt]],"比例配置","需求"..i)
      self.写入数据.配置数据[i].给予 = f函数.读配置(程序目录..[[每日活动\兑换配置.txt]],"比例配置","给予"..i)
      self.写入数据.配置数据[i].最低 = tonumber(f函数.读配置(程序目录..[[每日活动\兑换配置.txt]],"比例配置","最低"..i))
    end
      if 内容.文本=="兑换货币" then
        local 编号 =tonumber(内容.编号)
        local 数额 =tonumber(内容.数额)
        if  编号==nil or 编号=="" or 编号<=0 then
          return
        end
        if  数额==nil or 数额=="" or 数额<=0 then
          return
        end
        if self.写入数据.配置数据[编号] == nil then
          常规提示(self.玩家id,"#Y/数据错误")
          return
        end
        local 添加数额 = 数额 * self.写入数据.配置数据[编号].比例
        if 添加数额<self.写入数据.配置数据[编号].最低 then
          常规提示(self.玩家id,"#Y/你兑换的太少了")
          return
        end
        添加数额=math.floor(添加数额)
        if self.写入数据.配置数据[编号].需求=="仙玉" then
            if 共享货币[玩家数据[self.玩家id].账号]:扣除仙玉(数额,"兑换货币",self.玩家id) then
                 if self.写入数据.配置数据[编号].给予 == "经验" then
                    玩家数据[self.玩家id].角色.数据.当前经验 = 玩家数据[self.玩家id].角色.数据.当前经验 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/点经验")
                 elseif self.写入数据.配置数据[编号].给予 == "储备" then
                    玩家数据[self.玩家id].角色.数据.储备 = 玩家数据[self.玩家id].角色.数据.储备 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/两储备")
                 elseif self.写入数据.配置数据[编号].给予 == "银子" then
                    玩家数据[self.玩家id].角色.数据.银子 = 玩家数据[self.玩家id].角色.数据.银子 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/两银子")
                 elseif self.写入数据.配置数据[编号].给予 == "抽奖" then
                    玩家数据[self.玩家id].角色.数据.抽奖 = 玩家数据[self.玩家id].角色.数据.抽奖 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/次抽奖")
                 elseif self.写入数据.配置数据[编号].给予 == "抓鬼" then
                    玩家数据[self.玩家id].角色.数据.自动抓鬼 = 玩家数据[self.玩家id].角色.数据.自动抓鬼 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/次自动抓鬼")
                 elseif self.写入数据.配置数据[编号].给予 == "仙玉" then
                    共享货币[玩家数据[self.玩家id].账号]:添加仙玉(添加数额,self.玩家id,"兑换货币")
                 elseif self.写入数据.配置数据[编号].给予 == "点卡" then
                    共享货币[玩家数据[self.玩家id].账号]:添加点卡(添加数额,self.玩家id,"兑换货币")
                 elseif self.写入数据.配置数据[编号].给予 == "活跃积分" then
                    玩家数据[self.玩家id].角色:添加活跃积分(添加数额,"兑换货币",1)
                 elseif self.写入数据.配置数据[编号].给予 == "比武积分" then
                    玩家数据[self.玩家id].角色:添加比武积分(添加数额,"兑换货币",1)
                 end
            else
                return
            end
        elseif self.写入数据.配置数据[编号].需求 =="点卡" then
            if 共享货币[玩家数据[self.玩家id].账号]:扣除点卡(数额,self.玩家id,"兑换货币") then
              if self.写入数据.配置数据[编号].给予 == "经验" then
                    玩家数据[self.玩家id].角色.数据.当前经验 = 玩家数据[self.玩家id].角色.数据.当前经验 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/点经验")
                 elseif self.写入数据.配置数据[编号].给予 == "储备" then
                    玩家数据[self.玩家id].角色.数据.储备 = 玩家数据[self.玩家id].角色.数据.储备 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/两储备")
                 elseif self.写入数据.配置数据[编号].给予 == "银子" then
                    玩家数据[self.玩家id].角色.数据.银子 = 玩家数据[self.玩家id].角色.数据.银子 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/两银子")
                elseif self.写入数据.配置数据[编号].给予 == "抽奖" then
                    玩家数据[self.玩家id].角色.数据.抽奖 = 玩家数据[self.玩家id].角色.数据.抽奖 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/次抽奖")
                 elseif self.写入数据.配置数据[编号].给予 == "抓鬼" then
                    玩家数据[self.玩家id].角色.数据.自动抓鬼 = 玩家数据[self.玩家id].角色.数据.自动抓鬼 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/次自动抓鬼")
                 elseif self.写入数据.配置数据[编号].给予 == "仙玉" then
                    共享货币[玩家数据[self.玩家id].账号]:添加仙玉(添加数额,self.玩家id,"兑换货币")
                 elseif self.写入数据.配置数据[编号].给予 == "点卡" then
                    共享货币[玩家数据[self.玩家id].账号]:添加点卡(添加数额,self.玩家id,"兑换货币")
                 elseif self.写入数据.配置数据[编号].给予 == "活跃积分" then
                    玩家数据[self.玩家id].角色:添加活跃积分(添加数额,"兑换货币",1)
                 elseif self.写入数据.配置数据[编号].给予 == "比武积分" then
                    玩家数据[self.玩家id].角色:添加比武积分(添加数额,"兑换货币",1)
                 end
            else
             return
            end
        elseif self.写入数据.配置数据[编号].需求 =="银子" then
           if 玩家数据[self.玩家id].角色:扣除银子(数额,"兑换货币",1) then
               if self.写入数据.配置数据[编号].给予 == "经验" then
                    玩家数据[self.玩家id].角色.数据.当前经验 = 玩家数据[self.玩家id].角色.数据.当前经验 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/点经验")
                 elseif self.写入数据.配置数据[编号].给予 == "储备" then
                    玩家数据[self.玩家id].角色.数据.储备 = 玩家数据[self.玩家id].角色.数据.储备 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/两储备")
                 elseif self.写入数据.配置数据[编号].给予 == "银子" then
                    玩家数据[self.玩家id].角色.数据.银子 = 玩家数据[self.玩家id].角色.数据.银子 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/两银子")
                 elseif self.写入数据.配置数据[编号].给予 == "抽奖" then
                    玩家数据[self.玩家id].角色.数据.抽奖 = 玩家数据[self.玩家id].角色.数据.抽奖 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/次抽奖")
                 elseif self.写入数据.配置数据[编号].给予 == "抓鬼" then
                    玩家数据[self.玩家id].角色.数据.自动抓鬼 = 玩家数据[self.玩家id].角色.数据.自动抓鬼 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/次自动抓鬼")
                 elseif self.写入数据.配置数据[编号].给予 == "仙玉" then
                    共享货币[玩家数据[self.玩家id].账号]:添加仙玉(添加数额,self.玩家id,"兑换货币")
                 elseif self.写入数据.配置数据[编号].给予 == "点卡" then
                    共享货币[玩家数据[self.玩家id].账号]:添加点卡(添加数额,self.玩家id,"兑换货币")
                 elseif self.写入数据.配置数据[编号].给予 == "活跃积分" then
                    玩家数据[self.玩家id].角色:添加活跃积分(添加数额,"兑换货币",1)
                 elseif self.写入数据.配置数据[编号].给予 == "比武积分" then
                    玩家数据[self.玩家id].角色:添加比武积分(添加数额,"兑换货币",1)
                 end
           else
            常规提示(self.玩家id,"#Y/你的银子不够")
             return
           end
        elseif self.写入数据.配置数据[编号].需求 =="累充积分" then
            if 共享货币[玩家数据[self.玩家id].账号]:扣除累充(数额,self.玩家id,"兑换货币") then
               if self.写入数据.配置数据[编号].给予 == "经验" then
                    玩家数据[self.玩家id].角色.数据.当前经验 = 玩家数据[self.玩家id].角色.数据.当前经验 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/点经验")
                 elseif self.写入数据.配置数据[编号].给予 == "储备" then
                    玩家数据[self.玩家id].角色.数据.储备 = 玩家数据[self.玩家id].角色.数据.储备 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/两储备")
                 elseif self.写入数据.配置数据[编号].给予 == "银子" then
                    玩家数据[self.玩家id].角色.数据.银子 = 玩家数据[self.玩家id].角色.数据.银子 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/两银子")
                elseif self.写入数据.配置数据[编号].给予 == "抽奖" then
                    玩家数据[self.玩家id].角色.数据.抽奖 = 玩家数据[self.玩家id].角色.数据.抽奖 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/次抽奖")
                 elseif self.写入数据.配置数据[编号].给予 == "抓鬼" then
                    玩家数据[self.玩家id].角色.数据.自动抓鬼 = 玩家数据[self.玩家id].角色.数据.自动抓鬼 + 添加数额
                    常规提示(self.玩家id,"#Y/你获得了#R/"..添加数额.."#Y/次自动抓鬼")
                 elseif self.写入数据.配置数据[编号].给予 == "仙玉" then
                    共享货币[玩家数据[self.玩家id].账号]:添加仙玉(添加数额,self.玩家id,"兑换货币")
                 elseif self.写入数据.配置数据[编号].给予 == "点卡" then
                    共享货币[玩家数据[self.玩家id].账号]:添加点卡(添加数额,self.玩家id,"兑换货币")
                 elseif self.写入数据.配置数据[编号].给予 == "活跃积分" then
                    玩家数据[self.玩家id].角色:添加活跃积分(添加数额,"兑换货币",1)
                 elseif self.写入数据.配置数据[编号].给予 == "比武积分" then
                    玩家数据[self.玩家id].角色:添加比武积分(添加数额,"兑换货币",1)
                 end
            else
             return
            end
        end
      end
  end

  发送数据(self.连接id,104,self.写入数据)
end







function 每日活动类:每日领取处理(文本,编号)
  编号 = tonumber(编号)
  if  编号==nil or 编号=="" or 编号<=0 then
    return
  end
  self:重新加载数据()
  if self.领取数据[文本]==nil or self.领取数据[文本][编号]==nil then
    常规提示(self.玩家id,"#Y/数据错误")
    return
  end

  if self.领取数据[文本][编号] then
    常规提示(self.玩家id,"#Y/该档次物品以领取或购买,同账号只可以购买一次")
    return
  end

  if 文本=="神秘礼包" then
      local 需求货币 =  f函数.读配置(程序目录..[[每日活动\神秘礼包\]]..self[文本].文本文件[编号]..".txt","兑换配置","需求货币")
      if 需求货币=="仙玉" then
          if 共享货币[玩家数据[self.玩家id].账号]:扣除仙玉(self[文本].需求积分[编号],"每日活动",self.玩家id) then
          else
              return
          end
      elseif 需求货币 =="点卡" then
          if 共享货币[玩家数据[self.玩家id].账号]:扣除点卡(self[文本].需求积分[编号],self.玩家id,"每日活动") then
          else
           return
          end
      elseif 需求货币 =="银子" then
         if 玩家数据[self.玩家id].角色:扣除银子(self[文本].需求积分[编号],"每日活动",1) then
         else
          常规提示(self.玩家id,"#Y/你的银子不够")
           return
         end
      elseif 需求货币 =="累充积分" then
          if 共享货币[玩家数据[self.玩家id].账号]:扣除累充(self[文本].需求积分[编号],self.玩家id,"每日活动") then
          else
           return
          end
      end
  elseif 文本=="超值抢购" then
     local 需求货币 =  f函数.读配置(程序目录..[[每日活动\超值抢购\]]..self[文本].文本文件[编号]..".txt","兑换配置","需求货币")
     if 需求货币=="仙玉" then
          if 共享货币[玩家数据[self.玩家id].账号]:扣除仙玉(self[文本].需求积分[编号],"每日活动",self.玩家id) then
          else
              return
          end
      elseif 需求货币 =="点卡" then
          if 共享货币[玩家数据[self.玩家id].账号]:扣除点卡(self[文本].需求积分[编号],self.玩家id,"每日活动") then
          else
           return
          end
      elseif 需求货币 =="银子" then
         if 玩家数据[self.玩家id].角色:扣除银子(self[文本].需求积分[编号],"每日活动",1) then
         else
           常规提示(self.玩家id,"#Y/你的银子不够")
           return
         end
      elseif 需求货币 =="累充积分" then
          if 共享货币[玩家数据[self.玩家id].账号]:扣除累充(self[文本].需求积分[编号],self.玩家id) then
          else
           return
          end
      end
  else
      if self.领取数据[文本].数额<self[文本].需求积分[编号] then
       常规提示(self.玩家id,"#Y/当前未达到领取条件")
        return
      end
  end

          for i=1,self[文本].物品数量[编号] do
            local 物品名称 = self[文本].物品[编号][i].名称
            local 数量 = tonumber(self[文本].物品[编号][i].数量)
             仙玉商城类:仙玉商城商品处理(self.玩家id,物品名称,数量)
             常规提示(self.玩家id,"#Y/你获得了#R/"..数量.."#Y/个#R/"..物品名称)
          end
        self.领取数据[文本][编号] = true
        写出文件([[每日活动/领取数据/]]..玩家数据[self.玩家id].账号..".txt",table.tostring(self.领取数据))
        self:获取每日数据(文本)
end



function 每日活动类:获取每日数据(文本)
  self:重新加载数据()
  self.写入数据 = self[文本]
  self.写入数据.标题 = 文本
  self.写入数据.是否领取 = self.领取数据
  发送数据(self.连接id,103,self.写入数据)
end







return 每日活动类