-- @Author: 作者QQ381990860
-- @Date:   2024-03-23 15:11:00
-- @Last Modified by:   作者QQ381990860
-- @Last Modified time: 2025-05-26 14:13:15
--======================================================================--
local 共享货币类 = class()

function 共享货币类:初始化()
  self.账号=""
  self.仙玉=0
  self.点卡=0
  self.充值当前=0
  self.充值累计=0
  self.使用玩家={}
  self.日志记录=""
  self.充值日志=""
end

function 共享货币类:加载数据(账号)
      self.账号=账号
      self.点卡 = tonumber(f函数.读配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","点数"))
      self.仙玉 = tonumber(f函数.读配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","仙玉"))
      self.充值当前 = tonumber(f函数.读配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","充值当前"))
      self.充值累计 = tonumber(f函数.读配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","充值累计"))
      if f函数.文件是否存在([[data/]]..账号..[[/消费记录]])==false then
          lfs.mkdir([[data/]]..账号..[[/消费记录]])
      end
      if f函数.文件是否存在([[data/]]..账号..[[/充值记录]])==false then
           lfs.mkdir([[data/]]..账号..[[/充值记录]])
      end
      local 临时编号 = f函数.读配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","充值编号")
      if not 临时编号 or 临时编号=="空" or 临时编号=="" then
          f函数.写配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","充值编号","1")
      end
      local 临时编号1 = f函数.读配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","日志编号")
      if not 临时编号1 or self.临时编号1=="空" or self.临时编号1=="" then
          f函数.写配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","日志编号","1")
      end
      self.充值编号 = tonumber(f函数.读配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","充值编号"))
      self.日志编号 = tonumber(f函数.读配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","日志编号"))
      self.充值日志=""
      if not f函数.文件是否存在([[data/]]..账号..[[/充值记录/]]..取年月日1(os.time())..[[1.txt]]) then
           self.充值编号 = 1
           f函数.写配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","充值编号","1")
      end
      if f函数.文件是否存在([[data/]]..账号..[[/充值记录/]]..取年月日1(os.time())..self.充值编号..[[.txt]]) then
            self.充值日志 = 读入文件([[data\]]..账号..[[\充值记录\]]..取年月日1(os.time())..self.充值编号..[[.txt]])
      end
      self.日志记录=""
      if not f函数.文件是否存在([[data/]]..账号..[[/消费记录/]]..取年月日1(os.time())..[[1.txt]]) then
         self.日志编号 = 1
         f函数.写配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","日志编号","1")
      end
      if f函数.文件是否存在([[data/]]..账号..[[/消费记录/]]..取年月日1(os.time())..self.日志编号..[[.txt]]) then
            self.日志记录 = 读入文件([[data\]]..账号..[[\消费记录\]]..取年月日1(os.time())..self.日志编号..[[.txt]])
      end


      if self.点卡==nil or self.点卡=="" or self.点卡=="空" then
          self.点卡=0
      end
      if self.仙玉==nil or self.仙玉=="" or self.仙玉=="空" then
          self.仙玉=0
      end
      if self.充值当前==nil or self.充值当前=="" or self.充值当前=="空" then
          self.充值当前=0
      end
      if self.充值累计==nil or self.充值累计=="" or self.充值累计=="空" then
          self.充值累计=0
      end


end



function 共享货币类:保存数据()
      if  self.账号==nil or self.账号==""  then
         return false
      end
      f函数.写配置(程序目录..[[data\]]..self.账号..[[\账号信息.txt]],"账号配置","点数",self.点卡)
      f函数.写配置(程序目录..[[data\]]..self.账号..[[\账号信息.txt]],"账号配置","仙玉",self.仙玉)
      f函数.写配置(程序目录..[[data\]]..self.账号..[[\账号信息.txt]],"账号配置","充值累计",self.充值累计)
      f函数.写配置(程序目录..[[data\]]..self.账号..[[\账号信息.txt]],"账号配置","充值当前",self.充值当前)
      写出文件([[data\]]..self.账号..[[\消费记录\]]..取年月日1(os.time())..self.日志编号..[[.txt]],self.日志记录)
      写出文件([[data\]]..self.账号..[[\充值记录\]]..取年月日1(os.time())..self.充值编号..[[.txt]],self.充值日志)
      if #self.日志记录>=10240 then
          self.日志编号= self.日志编号 + 1
          f函数.写配置(程序目录..[[data\]]..self.账号..[[\账号信息.txt]],"账号配置","日志编号",self.日志编号)
          self.日志记录=""
      end
      if #self.充值日志>=10240 then
          self.充值编号= self.充值编号 + 1
          f函数.写配置(程序目录..[[data\]]..self.账号..[[\账号信息.txt]],"账号配置","充值编号",self.充值编号)
          self.充值日志=""
      end
end



function 共享货币类:加入玩家(id,离开)
     if 离开 then
        self.使用玩家[id]=nil
     else
        self.使用玩家[id]=true
     end
end




function 共享货币类:添加仙玉(数额,id,事件)
    if not 数额 or not self.账号 or self.账号=="" then
       return false
    end
    数额 = tonumber(数额)
    if not 数额  or 数额<1 or 数额~=math.floor(数额) or isNaN(数额) then
        return
    end
    if 数额>0 then
        local 之前=self.仙玉
        self.仙玉=self.仙玉+数额
        local 内容 = ""
        if id and  玩家数据[id] then
            内容 = string.format("。以下为添加仙玉信息：添加数额为%s点,添加前数额为%s点,添加后数额为%s点。角色ID为%s,名称为%s",数额,之前,self.仙玉,id,玩家数据[id].角色.数据.名称)
            常规提示(id,"#Y获得了#R"..数额.."#Y点仙玉")
        else
            内容 = string.format("。以下为添加仙玉信息：添加数额为%s点,添加前数额为%s点,添加后数额为%s点。玩家未在线,添加ID为%s",数额,之前,self.仙玉,id)
        end
        self:添加日志(事件,内容)
    end
end


function 共享货币类:扣除仙玉(数额,事件,id)
   if not 数额 or not self.账号 or self.账号=="" then
      if id and  玩家数据[id] then
        常规提示(id,"#Y你没有那么多的仙玉")
      end
      return false
  end
  数额 = tonumber(数额)
  if not 数额  or 数额<1 or 数额~=math.floor(数额) or isNaN(数额) then
      return
  end
  if self.仙玉>=数额 then
      local 之前=self.仙玉
      self.仙玉=self.仙玉-数额
      local 内容 = ""
      if id and  玩家数据[id] then
            内容 = string.format("。以下为扣除仙玉信息：扣除数额为%s点,扣除前数额为%s点,扣除后数额为%s点。角色ID为%s,名称为%s",数额,之前,self.仙玉,id,玩家数据[id].角色.数据.名称)
            常规提示(id,"#Y你失去了#R"..数额.."#Y点仙玉")
      else
            内容 = string.format("。以下为扣除仙玉信息：扣除数额为%s点,扣除前数额为%s点,扣除后数额为%s点。玩家未在线,添加ID为%s",数额,之前,self.仙玉,id)
      end
      self:添加日志(事件,内容)
      return true
  else
      if id and  玩家数据[id] then
        常规提示(id,"#Y你没有那么多的仙玉")
      end
      return false
  end
end


function 共享货币类:添加点卡(数额,id,事件)
     if not 数额 or not self.账号 or self.账号=="" then
         return false
      end
      数额 = tonumber(数额)
      if not 数额  or 数额<1 or 数额~=math.floor(数额) or isNaN(数额) then
          return
      end
      if 数额>0 then
          local 之前=self.点卡
          self.点卡=self.点卡+数额
          local 内容 = ""
          if id and  玩家数据[id] then
              内容 = string.format("。以下为添加点卡信息：添加数额为%s点,添加前数额为%s点,添加后数额为%s点。角色ID为%s,名称为%s",数额,之前,self.点卡,id,玩家数据[id].角色.数据.名称)
              常规提示(id,"#Y获得了#R"..数额.."#Y点卡")
          else
              内容 = string.format("。以下为添加点卡信息：添加数额为%s点,添加前数额为%s点,添加后数额为%s点。玩家未在线,添加ID为%s",数额,之前,self.点卡,id)
          end
          self:添加日志(事件,内容)
      end
end

function 共享货币类:添加日志(事件,内容)
      if self.账号==nil or self.账号==""  then
         return false
      end
      self.日志记录=self.日志记录.."\n"..时间转换(os.time())..事件..内容
       if #self.日志记录>=10240 then
          if not f函数.文件是否存在([[data/]]..self.账号..[[/消费记录/]]..取年月日1(os.time())..[[1.txt]]) then
              self.日志编号 = 1
          end
          写出文件([[data\]]..self.账号..[[\消费记录\]]..取年月日1(os.time())..self.日志编号..[[.txt]],self.日志记录)
          self.日志编号= self.日志编号 + 1
          f函数.写配置(程序目录..[[data\]]..self.账号..[[\账号信息.txt]],"账号配置","日志编号",self.日志编号)
          self.日志记录=""
      end
end


function 共享货币类:充值记录(内容)
      if self.账号==nil or self.账号==""  then
         return false
      end
      self.充值日志=self.充值日志.."\n"..时间转换(os.time())..内容
      if #self.充值日志>=10240 then
          if not f函数.文件是否存在([[data/]]..self.账号..[[/充值记录/]]..取年月日1(os.time())..[[1.txt]]) then
              self.充值编号 = 1
          end
          写出文件([[data\]]..self.账号..[[\充值记录\]]..取年月日1(os.time())..self.充值编号..[[.txt]],self.充值日志)
          self.充值编号= self.充值编号 + 1
          f函数.写配置(程序目录..[[data\]]..self.账号..[[\账号信息.txt]],"账号配置","充值编号",self.充值编号)
          self.充值日志=""
      end
end

function 共享货币类:扣除点卡(数额,id,事件)
    if not 数额 or not self.账号 or self.账号=="" then
        if id and  玩家数据[id] then
          常规提示(id,"#Y你没有那么多的点卡")
        end
        return false
    end
    数额 = tonumber(数额)
    if not 数额  or 数额<1 or 数额~=math.floor(数额) or isNaN(数额) then
        return
    end
    if self.点卡>=数额 then
          local 之前=self.点卡
          self.点卡=self.点卡-数额
          -- if 事件~="兑换货币" and 事件~="提现处理" then
          --     添加每日数据(数额,id,"每日消费")
          -- end
          local 内容 = ""
          if id and  玩家数据[id] then
              内容 = string.format("。以下为扣除点卡信息：扣除数额为%s点,扣除前数额为%s点,扣除后数额为%s点。角色ID为%s,名称为%s",数额,之前,self.点卡,id,玩家数据[id].角色.数据.名称)
              常规提示(id,"#Y/你失去了#R/"..数额.."#Y/点卡")
          else
              内容 = string.format("。以下为扣除点卡信息：扣除数额为%s点,扣除前数额为%s点,扣除后数额为%s点。玩家未在线,添加ID为%s",数额,之前,self.点卡,id)
          end
          self:添加日志(事件,内容)
          return true
    else
        if id and  玩家数据[id] then
          常规提示(id,"#Y你没有那么多的点卡")
        end
        return false
    end
end


function 共享货币类:添加累充(数额,id,事件)
  if not 数额 or not self.账号 or self.账号=="" then
    return false
  end
  数额 = tonumber(数额)
  if not 数额  or 数额<1 or 数额~=math.floor(数额) or isNaN(数额) then
      return
  end
  local 之前当前 = self.充值当前
  local 之前累计 = self.充值累计
  self.充值当前=self.充值当前+数额
  self.充值累计=self.充值累计+数额
--  添加每日数据(数额,id,"每日充值")
  local 内容 = ""
  if id and  玩家数据[id] then
      内容 = string.format("。以下为添加累充信息：添加数额为%s点,添加前当前%s点,累计%s点,添加后当前%s点,累计%s,点角色ID为%s,名称为%s",数额,之前当前,之前累计,self.充值当前,self.充值累计,id,玩家数据[id].角色.数据.名称)
      常规提示(id,"#Y获得了#R"..数额.."#Y累充积分")
  else
      内容 = string.format("。以下为添加累充信息：添加数额为%s点,添加前当前%s点,累计%s点,添加后当前%s点,累计%s,添加ID为%s",数额,之前当前,之前累计,self.充值当前,self.充值累计,id)
  end
  self:添加日志(事件,内容)
end


function 共享货币类:扣除累充(数额,id,事件)
  if not 数额 or not self.账号 or self.账号=="" then
      if id and  玩家数据[id] then
          常规提示(id,"Y你没有那么多的累充积分")
      end
      return false
  end
  数额 = tonumber(数额)
  if not 数额  or 数额<1 or 数额~=math.floor(数额) or isNaN(数额) then
      return
  end
  if self.充值当前>=数额 then
      local 之前=self.充值当前
      self.充值当前 = self.充值当前 - 数额
      local 内容 = ""
      if id and 玩家数据[id] then
          内容 = string.format("。以下为扣除累充信息：扣除数额为%s点,扣除前数额为%s点,扣除后数额为%s点。角色ID为%s,名称为%s",数额,之前,self.充值当前,id,玩家数据[id].角色.数据.名称)
          常规提示(id,"#Y/你失去了#R/"..数额.."#Y/累充积分")
      else
          内容 = string.format("。以下为扣除累充信息：扣除数额为%s点,扣除前数额为%s点,扣除后数额为%s点。玩家未在线,添加ID为%s",数额,之前,self.充值当前,id)
      end
      self:添加日志(事件,内容)
      return true
  else
      if 玩家数据[id] then
        常规提示(id,"#Y你没有那么多的累充积分")
      end
      return false
  end
end



return 共享货币类