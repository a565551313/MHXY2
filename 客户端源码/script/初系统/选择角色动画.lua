
local 人物动画类 = class()
local 临时资源
local 临时资源包
function 人物动画类:初始化(类型,根,模型,武器,染色,方案,锦衣,光环,足迹)
  local q = 引擎.取模型(模型)
  local z = 引擎.取头像(模型)

  if 类型==1 then --进入游戏时的选择角色
    self.选择人物头像 = 根.资源:载入(z[7],"网易WDF动画",z[5])
    self.动作="静立"
    if not 武器 or  not 武器.名称 or  武器.名称=="" then
        self[self.动作] = 根.资源:载入(q[3],"网易WDF动画",q[1])
        if 方案~=0 then
          self[self.动作]:置染色(方案,染色[1],染色[2],染色[3],0)
        end
    else
      self.武器={}
      self.动作="静立"
      local ssss = 武器.子类
      local sss
      if 武器.名称 == "龙鸣寒水" or 武器.名称 == "非攻" then
        ssss = "弓弩1"
      else
        ssss = tp:取武器子类(武器.子类)
      end
      q = 引擎.取模型(模型,ssss)
          if ssss == "弓弩1" then
            sss = "弓弩"
          else
            sss = ssss
          end
          self[self.动作] = 根.资源:载入(q[3],"网易WDF动画",q[1])
          if 方案~=0 then
            self[self.动作]:置染色(方案,染色[1],染色[2],染色[3],0)
          end
      local m = tp:取武器附加名称(武器.子类,武器.级别限制,武器.名称)
      local x = 引擎.取模型(m.."_"..模型,nil)
      self.武器[self.动作] = 根.资源:载入(x[3],"网易WDF动画",x[1])
      if 锦衣 == nil then
          self.武器[self.动作]:置差异(self.武器[self.动作].帧数-self[self.动作].帧数)
      end
      if 武器.染色方案~=0 and 武器.染色组~=nil and 武器.染色组~=0  and #武器.染色组>0 then
          self.武器[self.动作]:置染色(武器.染色方案,武器.染色组[1],武器.染色组[2],武器.染色组[3])
      end
    end
    if 光环 ~= nil then
      local gh = 引擎.取光环(光环.名称)
      self.光环=tp.资源:载入(gh[4],"网易WDF动画",gh[1])
    end
    if 足迹 ~= nil then
      local gh = 引擎.取足迹(足迹.名称)
      self.足迹=tp.资源:载入(gh[4],"网易WDF动画",gh[1])
    end
  end
end


function 人物动画类:点击事件()
  if self[self.动作]:是否选中(鼠标.x,鼠标.y) and 引擎.鼠标弹起(左键) then
    return true
  elseif self.武器~=nil and self.武器[self.动作]:是否选中(鼠标.x,鼠标.y) and 引擎.鼠标弹起(左键) then
    return true
  else
    return false
  end
end

function 人物动画类:更新(dt)
  self[self.动作]:更新(dt)
  if self.武器~=nil then
    self.武器[self.动作]:更新(dt)
  end
  if self.身体~=nil then
    self.身体:更新(dt)
  end
  if self.光环~=nil then
    self.光环:更新(dt)
  end
  if self.足迹~=nil then
    self.足迹:更新(dt)
  end
end

function 人物动画类:显示(x,y)
  if self.身体~=nil then
    self.身体:显示(x,y)
  end
  if self.光环~=nil then
    self.光环:显示(x,y)
  end
  if self.足迹~=nil then
    self.足迹:显示(x,y)
  end
  self[self.动作]:显示(x,y)
  if self.武器~=nil then
    self.武器[self.动作]:显示(x,y)
  end

end

return 人物动画类