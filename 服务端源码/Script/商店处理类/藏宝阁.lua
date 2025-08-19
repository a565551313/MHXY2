
local 藏宝阁处理类 = class()
function 藏宝阁处理类:初始化()
  self.装备商城={}
  self.灵饰商城={}
  self.宝宝商城={}
  self.银两商城={}
  self.道具商城={}
  self.角色商城={}
  self.下架数据=0
end

function 藏宝阁处理类:加载数据()
__gge.print(true,10,"藏宝阁数据加载开始\n")

  self.装备商城={}
  self.灵饰商城={}
  self.宝宝商城={}
  self.银两商城={}
  self.道具商城={}
  self.角色商城={}
  self.下架数据 = 0


  local 取出数据 = 取文件的所有名 (程序目录..[[\藏宝阁\装备商城\]])
  for i=1,#取出数据 do
     local 读入数据 = table.loadstring(读入文件([[藏宝阁\装备商城\]]..取出数据[i]..[[.txt]]))
    if 读入数据 and 读入数据.出售~=nil then
        for n, v in pairs(读入数据.出售) do
           if os.time()>=读入数据.出售[n].时间 and 读入数据.出售[n].上架 then
            self:下架商品处理(取出数据[i],"装备商城",读入数据.出售[n].数据.识别码)
            self.下架数据 = self.下架数据 + 1
           end
          if 读入数据.出售[n].上架 and 读入数据.出售[n].数据~=nil then
              local 写入数据 ={}
              写入数据.名称 = 读入数据.出售[n].数据.名称
              写入数据.数量 = 读入数据.出售[n].数据.级别限制
              写入数据.价格 = 读入数据.出售[n].价格
              写入数据.类型 = "装备"
              写入数据.时间 = 读入数据.出售[n].时间
              写入数据.编号 = 读入数据.出售[n].数据.识别码
              写入数据.玩家id = 取出数据[i]
            self.装备商城[#self.装备商城+1]=写入数据
          end
        end
    end
  end
  __gge.print(true,10,"装备商城加载了")
  __gge.print(false,11,#self.装备商城)
  __gge.print(false,10,"件装备数据,下架商品"..self.下架数据.."件\n")

  取出数据={}
  self.下架数据 = 0
    取出数据 = 取文件的所有名 (程序目录..[[\藏宝阁\灵饰商城\]])
  for i=1,#取出数据 do
     local 读入数据 =table.loadstring(读入文件([[藏宝阁\灵饰商城\]]..取出数据[i]..[[.txt]]))
    if 读入数据 and 读入数据.出售~=nil then
        for n, v in pairs(读入数据.出售) do
          if os.time()>=读入数据.出售[n].时间 and 读入数据.出售[n].上架 then
            self:下架商品处理(取出数据[i],"灵饰商城",读入数据.出售[n].数据.识别码)
            self.下架数据 = self.下架数据 + 1
          end
          if 读入数据.出售[n].上架 and 读入数据.出售[n].数据~=nil then
            local 写入数据 ={}
            写入数据.名称 = 读入数据.出售[n].数据.名称
            写入数据.数量 = 读入数据.出售[n].数据.级别限制
            写入数据.价格 = 读入数据.出售[n].价格
            写入数据.类型 = "灵饰"
            写入数据.时间 = 读入数据.出售[n].时间
            写入数据.编号 = 读入数据.出售[n].数据.识别码
            写入数据.玩家id = 取出数据[i]
            self.灵饰商城[#self.灵饰商城+1]=写入数据

          end
        end
    end
  end
 __gge.print(true,10,"灵饰商城加载了")
 __gge.print(false,11,#self.灵饰商城)
 __gge.print(false,10,"件灵饰数据,下架商品"..self.下架数据.."件\n")

  取出数据={}
  self.下架数据 = 0
  取出数据 = 取文件的所有名 (程序目录..[[\藏宝阁\宝宝商城\]])
  for i=1,#取出数据 do
     local 读入数据 =table.loadstring(读入文件([[藏宝阁\宝宝商城\]]..取出数据[i]..[[.txt]]))
    if 读入数据 and 读入数据.出售~=nil then
        for n, v in pairs(读入数据.出售) do
            if os.time()>=读入数据.出售[n].时间 and 读入数据.出售[n].上架  then
              self:下架商品处理(取出数据[i],"宝宝商城",读入数据.出售[n].数据.识别码)
              self.下架数据 = self.下架数据 + 1
            end
          if 读入数据.出售[n].上架 and 读入数据.出售[n].数据~=nil then
            local 写入数据 ={}
            写入数据.名称 = 读入数据.出售[n].数据.名称
            写入数据.数量 = 读入数据.出售[n].数据.级别
            写入数据.类型 = 读入数据.出售[n].数据.种类
            写入数据.模型 = 读入数据.出售[n].数据.模型
            写入数据.价格 = 读入数据.出售[n].价格
            写入数据.时间 = 读入数据.出售[n].时间
            写入数据.编号 = 读入数据.出售[n].数据.识别码
            写入数据.玩家id = 取出数据[i]
            self.宝宝商城[#self.宝宝商城+1]=写入数据

          end
        end
    end
  end
 __gge.print(true,10,"宝宝商城加载了")
 __gge.print(false,11,#self.宝宝商城)
 __gge.print(false,10,"个宝宝数据,下架商品"..self.下架数据.."件\n")

取出数据={}
self.下架数据 = 0
    取出数据 = 取文件的所有名 (程序目录..[[\藏宝阁\银两商城\]])
  for i=1,#取出数据 do
     local 读入数据 =table.loadstring(读入文件([[藏宝阁\银两商城\]]..取出数据[i]..[[.txt]]))
    if 读入数据 and 读入数据.出售~=nil then
        for n, v in pairs(读入数据.出售) do
          if os.time()>=读入数据.出售[n].时间 and 读入数据.出售[n].上架  then
              self:下架商品处理(取出数据[i],"银两商城",读入数据.出售[n].数据.识别码)
              self.下架数据 = self.下架数据 + 1
          end
          if 读入数据.出售[n].上架 and 读入数据.出售[n].数据~=nil then
            local 写入数据 ={}
            写入数据.名称 = 读入数据.出售[n].数据.名称
            写入数据.数量 = 读入数据.出售[n].数据.数额
            写入数据.类型 = 读入数据.出售[n].数据.名称
            写入数据.价格 = 读入数据.出售[n].价格
            写入数据.时间 = 读入数据.出售[n].时间
            写入数据.编号 = 读入数据.出售[n].数据.识别码
            写入数据.玩家id = 取出数据[i]
            self.银两商城[#self.银两商城+1]=写入数据

          end
        end
    end
  end
 __gge.print(true,10,"银两商城加载了")
 __gge.print(false,11,#self.银两商城)
 __gge.print(false,10,"个银子数据,下架商品"..self.下架数据.."件\n")

  取出数据={}
  self.下架数据 = 0
    取出数据 = 取文件的所有名 (程序目录..[[\藏宝阁\道具商城\]])
  for i=1,#取出数据 do
     local 读入数据 =table.loadstring(读入文件([[藏宝阁\道具商城\]]..取出数据[i]..[[.txt]]))
    if 读入数据 and 读入数据.出售~=nil then
        for n, v in pairs(读入数据.出售) do
          if os.time()>=读入数据.出售[n].时间 and 读入数据.出售[n].上架 then
              self:下架商品处理(取出数据[i],"道具商城",读入数据.出售[n].数据.识别码)
              self.下架数据 = self.下架数据 + 1
          end
          if 读入数据.出售[n].上架 and 读入数据.出售[n].数据~=nil then
            local 写入数据 ={}
            写入数据.名称 = 读入数据.出售[n].数据.名称
            写入数据.数量 = 1
            if 读入数据.出售[n].数据.数量 ~= nil then
               写入数据.数量 = 读入数据.出售[n].数据.数量
            end
            写入数据.类型 = 读入数据.出售[n].价格
            写入数据.价格 = 读入数据.出售[n].价格*写入数据.数量
            写入数据.时间 = 读入数据.出售[n].时间
            写入数据.编号 = 读入数据.出售[n].数据.识别码
            写入数据.玩家id = 取出数据[i]
            self.道具商城[#self.道具商城+1]=写入数据

          end
        end
    end
  end
 __gge.print(true,10,"道具商城加载了")
 __gge.print(false,11,#self.道具商城)
 __gge.print(false,10,"个道具数据,下架商品"..self.下架数据.."件\n")


  取出数据={}
  self.下架数据 = 0
    取出数据 = 取文件的所有名 (程序目录..[[\藏宝阁\角色商城\]])
  for i=1,#取出数据 do
     local 读入数据 =table.loadstring(读入文件([[藏宝阁\角色商城\]]..取出数据[i]..[[.txt]]))
    if 读入数据 and 读入数据.出售~=nil then
        for n, v in pairs(读入数据.出售) do
          if os.time()>=读入数据.出售[n].时间 and 读入数据.出售[n].上架 then
              self:下架商品处理(取出数据[i],"角色商城",读入数据.出售[n].数据.识别码)
              self.下架数据 = self.下架数据 + 1
          end
          if 读入数据.出售[n].上架 and 读入数据.出售[n].数据~=nil then
            local 写入数据 ={}
            写入数据.名称 = 读入数据.出售[n].数据.名称
            写入数据.数量 = 读入数据.出售[n].数据.级别
            写入数据.类型 = 读入数据.出售[n].数据.门派
            写入数据.模型 = 读入数据.出售[n].数据.模型
            写入数据.价格 = 读入数据.出售[n].价格
            写入数据.时间 = 读入数据.出售[n].时间
            写入数据.编号 = 读入数据.出售[n].数据.识别码
            写入数据.玩家id = 取出数据[i]
            self.角色商城[#self.角色商城+1]=写入数据

          end
        end
    end
  end
 __gge.print(true,10,"角色商城加载了")
 __gge.print(false,11,#self.角色商城)
 __gge.print(false,10,"个角色数据,下架商品"..self.下架数据.."件\n")
 if f函数.文件是否存在([[藏宝阁/交易记录]])==false then
     lfs.mkdir([[藏宝阁/交易记录]])
 end
  collectgarbage("collect")
  __gge.print(true,10,"藏宝阁数据加载完成,缓存清理完成\n")



end

function 藏宝阁处理类:藏宝阁数据处理(数据)
local id = 数据.数字id+0
local 文本 = 数据.文本
if 玩家数据[id].摊位数据~=nil then 常规提示(id,"#Y摆摊情况下无法进行此操作") return end
if 玩家数据[id].交易信息~=nil or 交易数据[id]~=nil then 常规提示(id,"#Y/交易中无法使用改功能") return end

if not 共享货币[玩家数据[id].账号]  then 常规提示(id,"#Y/数据错误") return end
if 文本 =="打开" then
  self:获取藏宝阁数据(id)
elseif  文本 =="更新" then
  self:更新藏宝阁数据(id,数据.类型)
elseif  文本 =="上架商品" then
  self:上架商品处理(id,数据.类型+0,数据.编号,数据.价格+0)
elseif  文本 =="购买商品" then
  self:购买商品处理(id,数据.类型,数据.编号,数据.购买id+0)
elseif  文本 =="下架商品" then
  self:下架商品处理(id,数据.类型,数据.编号,1)
  self:更新藏宝阁数据(id,数据.类型)
  if 数据.类型 == "宝宝商城" then
      self:获取上架召唤兽(id,3711,4)
  else
      self:获取上架商品(id,3711,3)
  end
elseif  文本 =="上架寄存商品" then
  self:上架寄存商品(id,数据.类型,数据.编号,数据.价格+0)
  if 数据.类型 == "宝宝商城" then
      self:获取上架召唤兽(id,3711,4)
  else
      self:获取上架商品(id,3711,3)
  end
elseif  文本 =="取回商品" then
  self:取回寄存商品(id,数据.类型,数据.编号,数据.类别)

elseif  文本 =="上架购买商品" then
  self:上架购买商品(id,数据.类型,数据.编号,数据.价格+0)
  if 数据.类型 == "宝宝商城" then
      self:获取购买召唤兽(id,3712,4)
  else
      self:获取购买商品(id,3712,3)
  end
elseif  文本 =="上架货币" then
  self:藏宝阁上架货币(id,数据.数量+0,数据.价格+0,数据.类型)
elseif  文本 =="查看商品" then
  self:查看商品处理(id,数据.类型,数据.编号,数据.购买id+0,数据.显示编号+0)
elseif  文本 =="藏宝阁提现" then
  self:藏宝阁提现(id,数据.数量+0,数据.类型)


end


end


function 藏宝阁处理类:藏宝阁提现(id,数量,类型)
 if 服务端参数.是否提现  then
  if 数量>=1000 then
           if 共享货币[玩家数据[id].账号]:扣除点卡(数量,id,"提现处理") then
                local 创建名称 = 玩家数据[id].角色.数据.名称..取年月日(os.time()).."提现"
                if f函数.文件是否存在([[藏宝阁\提现数据\]]..创建名称..[[.txt]])==false then
                  local 提现输出= 时间转换(os.time()).."账号:"..玩家数据[id].账号.." ID:"..id.." 提现: "..数量.." 数量的点卡"
                  写出文件([[藏宝阁\提现数据\]]..创建名称..[[.txt]],提现输出)
                else
                  local 提现输出=读入文件([[藏宝阁\提现数据\]]..创建名称..[[.txt]])
                  提现输出 = 提现输出.."\n"..时间转换(os.time()).."账号:"..玩家数据[id].账号.." ID:"..id.." 提现: "..数量.." 数量的点卡"
                  写出文件([[藏宝阁\提现数据\]]..创建名称..[[.txt]],提现输出)
                end
                常规提示(id,"提现成功等待工作人员帮你转账")
                self:更新藏宝阁数据(id,类型)
                发送公告("玩家#G/"..玩家数据[id].角色.数据.名称.."#Y/刚刚提现了点卡#G/"..数量.."#Y/点,群主要上吊了")
            end
        else
             常规提示(id,"本服暂时无法提现,如需提现请联系群主")
        end
  else
       常规提示(id,"1000点都不到你想屁吃")
  end

end




function 藏宝阁处理类:查看商品处理(id,类型,编号,购买id,显示编号)
          local 临时编号 = self:查找物品编号(购买id,类型,编号,1)
    if 临时编号 and 临时编号~=0 then
        local 读入数据 = table.loadstring(读入文件([[藏宝阁\]]..类型..[[\]]..购买id..[[.txt]]))
      if 读入数据 and 读入数据.出售 and 读入数据.出售[临时编号] and 读入数据.出售[临时编号].上架 then
          local 物品数据 = 读入数据.出售[临时编号].数据
          if 类型 == "角色商城"  then

          elseif 类型 == "宝宝商城" then
              发送数据(玩家数据[id].连接id,92.1,物品数据)
          else
              local 发送物品={}
              发送物品.道具 = DeepCopy(物品数据)
              发送物品.编号 = 显示编号
              发送数据(玩家数据[id].连接id,3714,发送物品)
          end
        else
           常规提示(id,"查看失败,该商品已下架")
           self:更新藏宝阁数据(id,类型)
        end
    else
        常规提示(id,"查看失败,未找到该商品")
        self:更新藏宝阁数据(id,类型)
    end

end








function 藏宝阁处理类:取回寄存商品(id,类型,编号,类别)
  if not 类型 or not 类别 then return end
  if 类型 =="宝宝商城" then
      if 玩家数据[id].召唤兽:是否携带上限() then
        常规提示(id,"取回失败,你携带的召唤兽已达上限")
        return
      end
  elseif 类型 ~="角色商城" and 类型 ~="银两商城" then
      local 道具格子=玩家数据[id].角色:取道具格子()
      if 道具格子==0 then
        常规提示(id,"您的道具栏物品已经满啦")
        return
      end
  end
  local 临时编号=0
  if 类别=="上架" then
      临时编号 = self:查找物品编号(id,类型,编号,1)
  else
      临时编号 = self:查找物品编号(id,类型,编号,2)
  end
  if  临时编号~=0 then
       local 读入数据 = table.loadstring(读入文件([[藏宝阁\]]..类型..[[\]]..id..[[.txt]]))
       local 物品数据
       if 类别=="上架" then
          if not 读入数据 or not 读入数据.出售 or not 读入数据.出售[临时编号] or 读入数据.出售[临时编号].上架 then
              常规提示(id,"商品上架中无法取回")
              return
          end
          物品数据 = 读入数据.出售[临时编号].数据
          table.remove(读入数据.出售,临时编号)
       else
          物品数据= 读入数据.购买[临时编号]
          table.remove(读入数据.购买,临时编号)
       end
       写出文件([[藏宝阁\]]..类型..[[\]]..id..[[.txt]],table.tostring(读入数据))
       if not 物品数据 then return end

      if 类型 =="角色商城" then
        物品数据.识别码 = nil



      elseif 类型 =="宝宝商城" then
        物品数据.识别码 = nil
        table.insert(玩家数据[id].召唤兽.数据,物品数据)
        写出文件([[data\]]..玩家数据[id].账号..[[\]]..id..[[\召唤兽.txt]],table.tostring(玩家数据[id].召唤兽.数据))
        玩家数据[id].召唤兽:加载数据(玩家数据[id].账号,id)
      elseif 类型 =="银两商城" then
          if 物品数据.名称 =="银子" then
              物品数据.数额 = tonumber(物品数据.数额)
              if 物品数据.数额 ==math.floor(物品数据.数额 ) and not isNaN(物品数据.数额) then
                  玩家数据[id].角色.数据.银子= 玩家数据[id].角色.数据.银子 + 物品数据.数额
                  常规提示(id,"你获得了"..物品数据.数额.."两银子")
              end
          else
              if 共享货币[玩家数据[id].账号] then
                  共享货币[玩家数据[id].账号]:添加仙玉(物品数据.数额+0,id,"藏宝阁取出")
              end
          end
      else
          local 道具格子=玩家数据[id].角色:取道具格子()
          local 道具编号=玩家数据[id].道具:取新编号()
          物品数据.识别码 =取唯一识别码(id)
          玩家数据[id].道具.数据[道具编号]=DeepCopy(物品数据)
          if 物品数据.数量~=nil then
            玩家数据[id].道具.数据[道具编号].数量=物品数据.数量
          end
          玩家数据[id].角色.数据.道具[道具格子]=道具编号
          道具刷新(id)
      end

     常规提示(id,"取回商品成功品")
      if 类别=="上架" then
        if 类型 == "宝宝商城" then
              self:获取上架召唤兽(id,3711,4)
          else
              self:获取上架商品(id,3711,3)
          end
      else
          if 类型 == "宝宝商城" then
              self:获取购买召唤兽(id,3712,4)
          else
              self:获取购买商品(id,3712,3)
          end
      end

  else
     常规提示(id,"未找到该商品")
  end
end


function 藏宝阁处理类:上架购买商品(id,类型,编号,价格)
  if not 类型 then return end
  local 临时编号 = self:查找物品编号(id,类型,编号,2)
 if 临时编号 and 临时编号~=0 then
    local 读入数据 =table.loadstring(读入文件([[藏宝阁/]]..类型..[[/]]..id..[[.txt]]))
    local 物品数据=读入数据.购买[临时编号]
    table.remove(读入数据.购买,临时编号)
    local 上架道具={数据=物品数据,价格=价格,上架=true,时间=os.time()+604800,账号=玩家数据[id].账号}
    table.insert(读入数据.出售,上架道具)
    写出文件([[藏宝阁/]]..类型..[[/]]..id..[[.txt]],table.tostring(读入数据))
    local 写入数据 ={}
    if 类型== "道具商城" then
           写入数据.数量 = 1
            if 上架道具.数据.数量 ~= nil then
               写入数据.数量 = 上架道具.数据.数量
            end
            写入数据.类型 = 上架道具.价格
            写入数据.价格 = 上架道具.价格*写入数据.数量
    elseif 类型== "装备商城" or 类型== "灵饰商城"  then
             写入数据.数量 = 上架道具.数据.级别限制
             写入数据.价格 = 上架道具.价格
          if 类型== "装备商城" then
              写入数据.类型 = "装备"
          else
              写入数据.类型 = "灵饰"
          end

    elseif 类型== "角色商城" or 类型== "宝宝商城"  then
              写入数据.数量 = 上架道具.数据.级别
              写入数据.模型 = 上架道具.数据.模型
              写入数据.价格 = 上架道具.价格

              if 类型== "角色商城" then
                 写入数据.类型 = 上架道具.数据.门派
              else
                 写入数据.类型 = 上架道具.数据.种类
              end
    elseif 类型== "银两商城"  then
        写入数据.数量 = 上架道具.数据.数额
        写入数据.价格 = 上架道具.价格
        写入数据.类型 = 上架道具.数据.名称
    end
      写入数据.名称 = 上架道具.数据.名称
      写入数据.时间 = 上架道具.时间
      写入数据.编号 = 上架道具.数据.识别码
      写入数据.玩家id = id
     table.insert(self[类型], 写入数据)
     self:更新藏宝阁数据(id,类型)
     常规提示(id,"商品上架成功")
else
    常规提示(id,"上架失败,未找到该商品")
end


end


function 藏宝阁处理类:上架寄存商品(id,类型,编号,价格)
  if not 类型 then return end
  local 临时编号 = self:查找物品编号(id,类型,编号,1)
 if 临时编号 and 临时编号~=0 then
      local 读入数据 =table.loadstring(读入文件([[藏宝阁/]]..类型..[[/]]..id..[[.txt]]))
      读入数据.出售[临时编号].上架 = true
      读入数据.出售[临时编号].时间 = os.time()+604800
      读入数据.出售[临时编号].价格 = 价格
      写出文件([[藏宝阁/]]..类型..[[/]]..id..[[.txt]],table.tostring(读入数据))
      local 上架道具=读入数据.出售[临时编号]
      local 物品数据={}
      if 类型== "道具商城" then
           物品数据.数量 = 1
            if 上架道具.数据.数量 ~= nil then
               物品数据.数量 = 上架道具.数据.数量
            end
            物品数据.类型 = 上架道具.价格
            物品数据.价格 = 上架道具.价格*物品数据.数量
       elseif 类型== "装备商城" or 类型== "灵饰商城"  then
             物品数据.数量 = 上架道具.数据.级别限制
             物品数据.价格 = 上架道具.价格
          if 类型== "装备商城" then
              物品数据.类型 = "装备"
          else
              物品数据.类型 = "灵饰"
          end

      elseif 类型== "角色商城" or 类型== "宝宝商城"  then
              物品数据.数量 = 上架道具.数据.级别
              物品数据.模型 = 上架道具.数据.模型
              物品数据.价格 = 上架道具.价格

              if 类型== "角色商城" then
                 物品数据.类型 = 上架道具.数据.门派
              else
                 物品数据.类型 = 上架道具.数据.种类
              end
      elseif 类型== "银两商城"  then
        物品数据.数量 = 上架道具.数据.数额
        物品数据.价格 = 上架道具.价格
        物品数据.类型 = 上架道具.数据.名称
      end
      物品数据.名称 = 上架道具.数据.名称
      物品数据.编号 = 上架道具.数据.识别码
      物品数据.时间 = 上架道具.时间
      物品数据.玩家id = id
      table.insert(self[类型], 物品数据)
      self:更新藏宝阁数据(id,类型)
      常规提示(id,"商品上架成功")
else
    常规提示(id,"上架失败,未找到该商品")
end


end


function 藏宝阁处理类:更新藏宝阁数据(id,物品类型)
  self.发送数据={数据=self[物品类型],类型=物品类型,点卡=共享货币[玩家数据[id].账号].点卡}
  发送数据(玩家数据[id].连接id,3705,self.发送数据)
end

function 藏宝阁处理类:查找物品编号(id,物品类型,编号,类型)
      local 读入数据 ={}
      if 类型~=3 then
          物品数据 =table.loadstring(读入文件([[藏宝阁\]]..物品类型..[[\]]..id..[[.txt]]))
          if 物品数据 and 物品数据.出售~=nil then
              if 类型 == 1 then
                   for n, v in pairs(物品数据.出售) do
                      if 物品数据.出售[n].数据.识别码 == 编号 then
                         return  n
                      end
                  end
              else
                   for n, v in pairs(物品数据.购买) do
                      if 物品数据.购买[n].识别码 == 编号 then
                         return  n
                      end
                  end
              end
          end
    else
           for n, v in pairs(self[物品类型]) do
              if self[物品类型][n].编号 == 编号 then
                 return  n
              end
            end
    end
   return 0
end


function 藏宝阁处理类:购买商品处理(id,类型,编号,购买id)
  if id == 购买id then
    常规提示(id,"购买失败不可以购买自己上架的商品")
    return
  end

  if 类型 == "角色商城" or not 类型 then
    return
  end
  local 临时编号 = self:查找物品编号(购买id,类型,编号,1)
  if 临时编号 and 临时编号~=0 then
          local 读入数据 = table.loadstring(读入文件([[藏宝阁\]]..类型..[[\]]..购买id..[[.txt]]))
          local 购买数据 = table.loadstring(读入文件([[藏宝阁\]]..类型..[[\]]..id..[[.txt]]))
          if 读入数据 and 读入数据.出售 and  读入数据.出售[临时编号] and 读入数据.出售[临时编号].上架 then
              local 物品数据 = 读入数据.出售[临时编号].数据
              local 出售账号 = 读入数据.出售[临时编号].账号
              local 出售价格 = 读入数据.出售[临时编号].价格
              if 物品数据.数量~=nil and 物品数据.数量>=1 then
                  出售价格 = 出售价格 * 物品数据.数量
              end
              if not tonumber(出售价格) or tonumber(出售价格) <1 or tonumber(出售价格) ~=math.floor(出售价格) then
                 常规提示(id,"购买失败该物品数据问题")
                  return
              end
              if 共享货币[玩家数据[id].账号]:扣除点卡(出售价格,id,"藏宝阁购买") then
                    table.insert(购买数据.购买,物品数据)
                    写出文件([[藏宝阁\]]..类型..[[\]]..id..[[.txt]],table.tostring(购买数据))
                    table.remove(读入数据.出售,临时编号)
                    写出文件([[藏宝阁\]]..类型..[[\]]..购买id..[[.txt]],table.tostring(读入数据))
                    local 物品编号 = self:查找物品编号(购买id,类型,编号,3)
                    table.remove(self[类型],物品编号)
                    常规提示(id,"成功购买商品,快打开我的物品看看吧")
                    if 共享货币[出售账号] then
                        共享货币[出售账号]:添加点卡(math.floor(出售价格*0.95),购买id,"藏宝阁出售")
                        -- if 玩家数据[购买id] then
                        --     共享货币[出售账号]:添加点卡(math.floor(出售价格*0.95),购买id,"藏宝阁出售")
                        --     常规提示(购买id,"藏宝阁数据更新#R"..物品数据.名称.."#Y已售出")
                        --     self:更新藏宝阁数据(购买id,类型)
                        -- else
                        --     共享货币[出售账号].点卡=共享货币[出售账号].点卡+math.floor(出售价格*0.95)
                        --     local 日志内容 = string.format("。以下为具体添加信息：添加数额为%s,添加后的点卡数量为%s，本次触发事件[%s]#分割符\n",math.floor(出售价格*0.95),共享货币[出售账号].点卡,"藏宝阁出售")
                        --     共享货币[出售账号]:添加日志("藏宝阁出售",日志内容)
                        --     共享货币[出售账号]:保存数据()
                        -- end
                    else
                        local 出售点卡 = f函数.读配置(程序目录..[[data\]]..出售账号..[[\账号信息.txt]],"账号配置","点数")+0
                        出售点卡 = 出售点卡 + math.floor(出售价格*0.95)
                        f函数.写配置(程序目录..[[data\]]..出售账号..[[\账号信息.txt]],"账号配置","点数",出售点卡)
                    end
                    local 交易记录 = ""
                    if f函数.文件是否存在([[藏宝阁\交易记录\]]..取年月日1(os.time())..[[.txt]]) then
                        交易记录 = 读入文件([[藏宝阁\交易记录\]]..取年月日1(os.time())..[[.txt]])
                    end
                    交易记录=交易记录.."\n"..时间转换(os.time())..format("玩家:%s,ID:%s,账号:%s,在%s购买了ID:%s的商品:%s",玩家数据[id].角色.数据.名称,id,玩家数据[id].账号,类型,购买id,物品数据.名称)
                    写出文件([[藏宝阁\交易记录]]..取年月日1(os.time())..[[.txt]],交易记录)
              else
                   常规提示(id,"你的点卡余额不足，无法购买")
              end
          else
              常规提示(id,"购买失败,该商品已下架")
          end
  else
      常规提示(id,"购买失败,未找到该商品")
  end
  self:更新藏宝阁数据(id,类型)
end


function 藏宝阁处理类:下架商品处理(id,物品类型,出售编号,提示)
  id = id + 0
  local 临时编号 = self:查找物品编号(id,物品类型,出售编号,3)
  if 临时编号~=0 then
    table.remove(self[物品类型],临时编号)
  end
  临时编号 = self:查找物品编号(id,物品类型,出售编号,1)
  if 临时编号~=0 then
    local 读入数据 =table.loadstring(读入文件([[藏宝阁\]]..物品类型..[[\]]..id..[[.txt]]))
    读入数据.出售[临时编号].上架 = false
    写出文件([[藏宝阁\]]..物品类型..[[\]]..id..[[.txt]],table.tostring(读入数据))
  end
  if 提示~=nil and 玩家数据[id]~=nil then
      常规提示(id,"商品已下架")
  end


end






function 藏宝阁处理类:上架商品处理(id,类型,编号,价格)

  if 玩家数据[id].角色.数据.银子<=100000 then
     常规提示(id,"上架藏宝阁需要缴纳10万银子的保管费,你的银子不够")
      return
   end
   if not 价格 or not tonumber(价格) or tonumber(价格)<1 or tonumber(价格)~=math.floor(价格) then
        常规提示(id,"输入的价格有误!")
        return
   end
    价格=math.floor(价格+0)

    if 类型 == 1 then
        local 道具id = 玩家数据[id].角色.数据.道具[编号]
        if 玩家数据[id].道具.数据[道具id] == nil then
          常规提示(id,"你没有这个道具")
          return
        end
       if  玩家数据[id].道具.数据[道具id].加锁~=nil  and  玩家数据[id].道具.数据[道具id].加锁 then
        常规提示(id,"这个道具已上锁,请解锁后在操作")
          return
        end

        if  玩家数据[id].道具.数据[道具id].专用~=nil  or  (玩家数据[id].道具.数据[道具id].不可交易~=nil and 玩家数据[id].道具.数据[道具id].不可交易) then
          常规提示(id,"这个道具无法交易")
          return
        end

        if  玩家数据[id].道具.数据[道具id].名称=="帮派银票"  or  玩家数据[id].道具.数据[道具id].总类=="帮派银票"  or  玩家数据[id].道具.数据[道具id].总类=="跑商商品" then
          常规提示(id,"这个道具无法交易")
          return
        end

        self:上架道具处理(id,道具id,编号,价格)

    else
      local 宝宝编号=玩家数据[id].召唤兽:取编号(编号)
      if 玩家数据[id].召唤兽.数据[宝宝编号]==nil then
        常规提示(id,"你没有这样的召唤兽")
        return
      end
      if 玩家数据[id].召唤兽.数据[宝宝编号].参战信息~=nil then
        常规提示(id,"请先取消召唤兽的参战状态")
       return
      end
      if  玩家数据[id].召唤兽.数据[宝宝编号].加锁~=nil  and  玩家数据[id].召唤兽.数据[宝宝编号].加锁 then
         常规提示(id,"这个召唤兽已上锁,请解锁后在操作")
          return
      end
      if  玩家数据[id].召唤兽.数据[宝宝编号].专用~=nil   or  (玩家数据[id].召唤兽.数据[宝宝编号].不可交易~=nil and 玩家数据[id].召唤兽.数据[宝宝编号].不可交易) then
         常规提示(id,"这个召唤兽无法交易")
          return
      end

       self:上架召唤兽处理(id,宝宝编号,价格)

    end

end



function 藏宝阁处理类:藏宝阁上架货币(id,数额,价格,类型)
          if not 类型 then return end
            价格=tonumber(价格)
          if not 价格  or 价格<1 or 价格~=math.floor(价格) or isNaN(价格) then
              常规提示(id,"输入的价格有误!")
              return
          end
          数额=tonumber(数额)
          if not 数额  or 数额<1 or 数额~=math.floor(数额) or isNaN(数额) then
              常规提示(id,"输入的数额有误!")
              return
          end
          local 临时编号 =0
          if 类型 == "银子" then
              临时编号=玩家数据[id].角色.数据.银子
              数额 = 数额 + 100000
          else
              临时编号= 共享货币[玩家数据[id].账号].仙玉
              if 玩家数据[id].角色.数据.银子<=100000 then
               常规提示(id,"上架藏宝阁需要缴纳10万银子的保管费,你的银子不够")
                return
              end
          end
          if 临时编号<数额 then
            常规提示(id,"你的货币余额不足")
            return
          end
          local 商城类型 = "银两商城"
          if 类型 == "银子" then
              玩家数据[id].角色.数据.银子 = 玩家数据[id].角色.数据.银子 - 数额
              常规提示(id,"你失去了"..数额.."两银子")
              数额 = 数额 - 100000
          else
              共享货币[玩家数据[id].账号]:扣除仙玉(数额,"藏宝阁上架",id)
              玩家数据[id].角色.数据.银子=玩家数据[id].角色.数据.银子-100000
              常规提示(id,"你失去了100000两银子")
          end
          local 上架数据={}
          上架数据.名称=类型
          上架数据.数额=数额
          上架数据.类型=类型
          上架数据.识别码=取唯一识别码(id)
          local 上架道具 ={数据=上架数据,价格=价格,上架=true,时间=os.time()+604800,账号=玩家数据[id].账号}
          local 读入数据 =table.loadstring(读入文件([[藏宝阁\]]..商城类型..[[\]]..id..[[.txt]]))
          table.insert(读入数据.出售,上架道具)
          写出文件([[藏宝阁\]]..商城类型..[[\]]..id..[[.txt]],table.tostring(读入数据))
          local 添加数据={}
          添加数据.名称 = 上架道具.数据.名称
          添加数据.数量 = 上架道具.数据.数额
          添加数据.类型 = 上架道具.数据.类型
          添加数据.编号 = 上架道具.数据.识别码
          添加数据.价格 = 上架道具.价格
          添加数据.时间 = 上架道具.时间
          添加数据.玩家id = id
          table.insert(self[商城类型],添加数据)
          self:更新藏宝阁数据(id,商城类型)
          常规提示(id,"商品上架成功")

end







function 藏宝阁处理类:上架道具处理(id,编号,道具id,价格)
        local 道具数据= 玩家数据[id].道具.数据[编号]
        local 商城类型 = "道具商城"
        if 道具数据.总类 == 2 and  道具数据.分类>=1 and 道具数据.分类<=6  then
          商城类型= "装备商城"
        end
        if  道具数据.总类 == 2 and  道具数据.灵饰  then
           商城类型= "灵饰商城"
        end
        道具数据.识别码=取唯一识别码(id)
        local 上架道具 = {数据=道具数据,价格=价格,上架=true,时间=os.time()+604800,账号=玩家数据[id].账号}
        local 读入数据 = table.loadstring(读入文件([[藏宝阁\]]..商城类型..[[\]]..id..[[.txt]]))
        table.insert(读入数据.出售,上架道具)
        写出文件([[藏宝阁\]]..商城类型..[[\]]..id..[[.txt]],table.tostring(读入数据))
        玩家数据[id].道具.数据[编号]=nil
        玩家数据[id].角色.数据.道具[道具id]=nil
        local 添加数据={}
        if 商城类型== "道具商城" then
             添加数据.数量 = 1
            if 上架道具.数据.数量 ~= nil then
               添加数据.数量 = 上架道具.数据.数量
            end
              添加数据.类型 = 上架道具.价格
              添加数据.价格 = 上架道具.价格*添加数据.数量
        else
              添加数据.数量 = 上架道具.数据.级别限制
              添加数据.价格 = 上架道具.价格
               if 商城类型== "装备商城" then
                 添加数据.类型 = "装备"
               else
                 添加数据.类型 = "灵饰"
               end
        end
        添加数据.名称 = 上架道具.数据.名称
        添加数据.编号 = 上架道具.数据.识别码
        添加数据.时间 = 上架道具.时间
        添加数据.玩家id = id
        table.insert(self[商城类型],添加数据)
        玩家数据[id].角色.数据.银子 = 玩家数据[id].角色.数据.银子 -100000
        常规提示(id,"你失去了100000两银子")
        道具刷新(id)
        self:获取玩家道具(id,3703,3)
        self:更新藏宝阁数据(id,商城类型)
        常规提示(id,"商品上架成功")
end



function 藏宝阁处理类:上架召唤兽处理(id,编号,价格)
        local 商城类型= "宝宝商城"
        local 宝宝数据 = 玩家数据[id].召唤兽.数据[编号]
        宝宝数据.识别码=取唯一识别码(id)
        local 上架道具={数据=宝宝数据,价格=价格,上架=true,时间=os.time()+604800,账号=玩家数据[id].账号}
        local 读入数据 =table.loadstring(读入文件([[藏宝阁\]]..商城类型..[[\]]..id..[[.txt]]))

        if 读入数据.出售 ~=nil and  #读入数据.出售 >= 15  then
            常规提示(id,"每个玩家最多寄存15个召唤兽请取出多余召唤兽后在上架")
            return
        end
        table.insert(读入数据.出售,上架道具)
        写出文件([[藏宝阁\]]..商城类型..[[\]]..id..[[.txt]],table.tostring(读入数据))
        table.remove(玩家数据[id].召唤兽.数据,编号)
        local 添加数据={}
        添加数据.名称 = 上架道具.数据.名称
        添加数据.数量 = 上架道具.数据.级别
        添加数据.类型 = 上架道具.数据.种类
        添加数据.模型 = 上架道具.数据.模型
        添加数据.编号 = 上架道具.数据.识别码
        添加数据.价格 = 上架道具.价格
        添加数据.时间 = 上架道具.时间
        添加数据.玩家id = id
        table.insert(self[商城类型],添加数据)
        self:获取玩家召唤兽(id,3703,4)
        self:更新藏宝阁数据(id,商城类型)
        玩家数据[id].角色.数据.银子 = 玩家数据[id].角色.数据.银子 -100000
        常规提示(id,"你失去了100000两银子")
        常规提示(id,"商品上架成功")
end




function 藏宝阁处理类:获取玩家道具(id,序号,类型)
        local 发送内容 ={}
        发送内容.数据={}
        local 开始id = 1
        local 结束id = 20
        for i = 1 ,5 do
            for n=开始id,结束id do
                if 玩家数据[id].角色.数据.道具[n]~=nil and 玩家数据[id].道具.数据[玩家数据[id].角色.数据.道具[n]]~=nil then
                  发送内容.数据[n]=DeepCopy(玩家数据[id].道具.数据[玩家数据[id].角色.数据.道具[n]])
                end
            end
            发送内容.开始 = 开始id
            发送内容.结束 = 结束id
            发送内容.类型 = 1
            if 开始id <= 20 then
                发送内容.类型 = 1
            else
                发送内容.类型 = 3
            end
            if 类型~=nil then
                发送内容.类型 = 类型
            end
            发送数据(玩家数据[id].连接id,序号,发送内容)
            发送内容.数据={}
            开始id = 开始id + 20
            结束id = 结束id + 20
        end
end




function 藏宝阁处理类:获取玩家召唤兽(id,序号,类型)
        local 发送内容 ={}
        发送内容.数据 = 玩家数据[id].召唤兽.数据
        发送内容.类型 = 2
        if 类型~=nil then
            发送内容.类型 = 类型
        end
        发送数据(玩家数据[id].连接id,序号,发送内容)

end



function 藏宝阁处理类:获取购买召唤兽(id,序号,类型)
        local 发送内容 ={}
        发送内容.数据 = {}
        local 读入数据 =table.loadstring(读入文件([[藏宝阁\宝宝商城\]]..id..[[.txt]]))
        if 读入数据 and 读入数据.购买~=nil then
           for n, v in pairs(读入数据.购买) do
            发送内容.数据[#发送内容.数据+1] = DeepCopy(读入数据.购买[n])
          end
        end
        发送内容.类型 = 2
        if 类型~=nil then
            发送内容.类型 = 类型
        end
        发送数据(玩家数据[id].连接id,序号,发送内容)

end

function 藏宝阁处理类:获取购买商品(id,序号,类型)
          local 物品数据 ={}
          local 购买数据 ={}
          local 读入数据 =table.loadstring(读入文件([[藏宝阁\装备商城\]]..id..[[.txt]]))
          if 读入数据 and 读入数据.购买~=nil then
              for n, v in pairs(读入数据.购买) do
                  物品数据[#物品数据+1] = 读入数据.购买[n]
                  购买数据[#购买数据+1] ="装备商城"
              end
          end
          读入数据 =table.loadstring(读入文件([[藏宝阁\灵饰商城\]]..id..[[.txt]]))
          if 读入数据 and 读入数据.购买~=nil then
              for n, v in pairs(读入数据.购买) do
                物品数据[#物品数据+1] = 读入数据.购买[n]
                购买数据[#购买数据+1] ="灵饰商城"
              end
          end
          读入数据 =table.loadstring(读入文件([[藏宝阁\道具商城\]]..id..[[.txt]]))
          if 读入数据 and 读入数据.购买~=nil then
              for n, v in pairs(读入数据.购买) do
                物品数据[#物品数据+1] = 读入数据.购买[n]
                购买数据[#购买数据+1] ="道具商城"
              end
          end
          读入数据 =table.loadstring(读入文件([[藏宝阁\银两商城\]]..id..[[.txt]]))
          if 读入数据 and 读入数据.购买~=nil then
              for n, v in pairs(读入数据.购买) do
                物品数据[#物品数据+1] = 读入数据.购买[n]
                购买数据[#购买数据+1] ="银两商城"
              end
          end


          local 发送内容 ={}
          发送内容.数据 = {}
          发送内容.额外数据 = {}

          local 开始id = 1
          local 结束id = 20
          for i = 1 ,5 do
              for n=开始id,结束id do
                 if 物品数据[n]~=nil then
                    发送内容.数据[n]=DeepCopy(物品数据[n])
                    发送内容.额外数据[n] = {商城类型= 购买数据[n]}
                 end
              end
              发送内容.开始 = 开始id
              发送内容.结束 = 结束id
              发送内容.类型 = 1
              if 开始id <= 20 then
                  发送内容.类型 = 1
              else
                 发送内容.类型 = 3
              end
              if 类型~=nil then
                  发送内容.类型 = 类型
              end
              发送数据(玩家数据[id].连接id,序号,发送内容)
              发送内容.数据={}
              发送内容.额外数据 = {}
              开始id = 开始id + 20
              结束id = 结束id + 20
          end
end



function 藏宝阁处理类:获取上架召唤兽(id,序号,类型)
          local 发送内容 ={}
          发送内容.数据 = {}
          发送内容.额外数据 = {}
          local 读入数据 =table.loadstring(读入文件([[藏宝阁\宝宝商城\]]..id..[[.txt]]))
          if 读入数据 and 读入数据.出售~=nil then
             for n, v in pairs(读入数据.出售) do
              发送内容.数据[#发送内容.数据+1] = DeepCopy(读入数据.出售[n].数据)
              发送内容.额外数据[#发送内容.额外数据+1] = {价格=读入数据.出售[n].价格,上架=读入数据.出售[n].上架}
            end
          end
          发送内容.类型 = 2
          if 类型~=nil then
              发送内容.类型 = 类型
          end
          发送数据(玩家数据[id].连接id,序号,发送内容)

end

function 藏宝阁处理类:获取上架商品(id,序号,类型)
          local 物品数据 ={}
          local 上架道具 ={}
          local 读入数据 =table.loadstring(读入文件([[藏宝阁\装备商城\]]..id..[[.txt]]))
          if 读入数据 and 读入数据.出售~=nil then
              for n, v in pairs(读入数据.出售) do
                  物品数据[#物品数据+1] = 读入数据.出售[n]
                  上架道具[#上架道具+1] ="装备商城"
              end
          end
          读入数据 =table.loadstring(读入文件([[藏宝阁\灵饰商城\]]..id..[[.txt]]))
          if 读入数据 and 读入数据.出售~=nil then
              for n, v in pairs(读入数据.出售) do
                物品数据[#物品数据+1] = 读入数据.出售[n]
                上架道具[#上架道具+1] ="灵饰商城"
              end
          end
          读入数据 =table.loadstring(读入文件([[藏宝阁\道具商城\]]..id..[[.txt]]))
          if 读入数据 and 读入数据.出售~=nil then
              for n, v in pairs(读入数据.出售) do
                物品数据[#物品数据+1] = 读入数据.出售[n]
                上架道具[#上架道具+1] ="道具商城"
              end
          end
          读入数据 =table.loadstring(读入文件([[藏宝阁\银两商城\]]..id..[[.txt]]))
          if 读入数据 and 读入数据.出售~=nil then
              for n, v in pairs(读入数据.出售) do
                物品数据[#物品数据+1] = 读入数据.出售[n]
                上架道具[#上架道具+1] ="银两商城"
              end
          end
          local 发送内容 ={}
          发送内容.数据 = {}
          发送内容.额外数据 = {}
          local 开始id = 1
          local 结束id = 20
          for i = 1 ,5 do
              for n=开始id,结束id do
                 if 物品数据[n]~=nil then
                    发送内容.数据[n]=DeepCopy(物品数据[n].数据)
                    发送内容.额外数据[n] = {价格=物品数据[n].价格,上架=物品数据[n].上架,商城类型= 上架道具[n]}
                 end
              end
              发送内容.开始 = 开始id
              发送内容.结束 = 结束id
              发送内容.类型 = 1
              if 开始id <= 20 then
                  发送内容.类型 = 1
              else
                  发送内容.类型 = 3
              end
              if 类型~=nil then
                  发送内容.类型 = 类型
              end
              发送数据(玩家数据[id].连接id,序号,发送内容)
              发送内容.数据={}
              发送内容.额外数据 = {}
              开始id = 开始id + 20
              结束id = 结束id + 20
          end
end




function 藏宝阁处理类:获取藏宝阁数据(id)
        local function 安全写入文件(路径, 内容)
            local 成功, 错误信息 = pcall(function()
                写出文件(路径, 内容)
            end)
            if not 成功 then
                __gge.print(true, 10, "写出内容失败,请检查写出路径:" .. 路径 .. " 错误:" .. tostring(错误信息))
            end
            return 成功
        end
        
                if f函数.文件是否存在([[藏宝阁\装备商城\]]..id..[[.txt]])==false then
            安全写入文件([[藏宝阁\装备商城\]]..id..[[.txt]], table.tostring({出售={},购买={}}))
        end
        if f函数.文件是否存在([[藏宝阁\灵饰商城\]]..id..[[.txt]])==false then
            安全写入文件([[藏宝阁\灵饰商城\]]..id..[[.txt]], table.tostring({出售={},购买={}}))
        end
        if f函数.文件是否存在([[藏宝阁\宝宝商城\]]..id..[[.txt]])==false then
            安全写入文件([[藏宝阁\宝宝商城\]]..id..[[.txt]], table.tostring({出售={},购买={}}))
        end
        if f函数.文件是否存在([[藏宝阁\道具商城\]]..id..[[.txt]])==false then
            安全写入文件([[藏宝阁\道具商城\]]..id..[[.txt]], table.tostring({出售={},购买={}}))
        end
        if f函数.文件是否存在([[藏宝阁\银两商城\]]..id..[[.txt]])==false then
            安全写入文件([[藏宝阁\银两商城\]]..id..[[.txt]], table.tostring({出售={},购买={}}))
        end
        if f函数.文件是否存在([[藏宝阁\角色商城\]]..id..[[.txt]])==false then
            安全写入文件([[藏宝阁\角色商城\]]..id..[[.txt]], table.tostring({出售={},购买={}}))
        end
        local 发送内容 = {数据=self.装备商城,点卡=共享货币[玩家数据[id].账号].点卡}
        发送数据(玩家数据[id].连接id,3704,发送内容)
end




return 藏宝阁处理类