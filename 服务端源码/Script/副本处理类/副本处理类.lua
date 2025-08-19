-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2022-10-17 20:18:32
-- @最后修改来自: baidwwy
-- @Last Modified time: 2025-06-20 10:46:48
local 副本处理类 = class()

function 副本处理类:初始化()
	self.副本盒子={}
	self.玩家副本={}


end

function 副本处理类:更新(dt)
  for n, v in pairs(self.副本盒子) do
    if self.副本盒子[n]~=nil then self.副本盒子[n]:更新(n) end
    if self.副本盒子[n]~=nil and (os.time() - self.副本盒子[n].开始时间) > 10800 then
    	self:超时关闭副本(self.副本盒子[n].副本名,self.副本盒子[n].副本ID)
    	return
    end
    if self.副本盒子[n]~=nil and self.副本盒子[n].结束时间 and (os.time() - self.副本盒子[n].结束时间) > 300 then
    	self:超时关闭副本(self.副本盒子[n].副本名,self.副本盒子[n].副本ID)
    	return
    end
  end
end


function 副本处理类:显示()

end

function 副本处理类:保存玩家副本ID(玩家id,副本id,副本名)
	if self.玩家副本[玩家id] == nil then
		self.玩家副本[玩家id]={}
		self.玩家副本[玩家id].副本={}
	end
	self.玩家副本[玩家id].副本[副本名]=副本id
end

function 副本处理类:加载副本(副本名,副本ID,队长id)
	    if  self[副本名]~=nil then
			self.副本盒子[副本ID]=self[副本名].创建(副本ID,队长id)
			local 队伍id=玩家数据[队长id].队伍
			for n=1,#队伍数据[队伍id].成员数据 do
				local 临时id=队伍数据[队伍id].成员数据[n]
				if 副本数据[副本名] then
					副本数据[副本名].进行中[临时id]=true
				end
				self.副本盒子[副本ID]:添加玩家(临时id)
				self:保存玩家副本ID(临时id,副本ID,副本名)
			    玩家数据[临时id].角色:添加任务(副本ID)
			    常规提示(临时id,"#Y恭喜你开启了#R"..副本名.."#Y副本，赶快进入副本体验曲折离奇故事情节吧！#3")
			 end
		else
		    常规提示(队长id,"#Y/副本脚本异常，开启失败")
		end
end

function 副本处理类:触发事件(任务id,事件名,参数)
	self.副本盒子[任务id]:触发事件(事件名,参数)
end

function 副本处理类:结束副本(副本名,副本ID,队长id)
  local 队伍id=玩家数据[队长id].队伍
  for n=1,#队伍数据[队伍id].成员数据 do

	  	local 临时id=队伍数据[队伍id].成员数据[n]
	  	self.玩家副本[临时id].副本[副本名]=nil
	  	self.副本盒子[副本ID]:完成副本(临时id)
	  	--清理副本任务
	  	玩家数据[临时id].角色:取消任务(副本ID)

  end
  self.副本盒子[副本ID]=nil
end

function 副本处理类:超时关闭副本(副本名,副本ID)
	local 副本玩家 = self.副本盒子[副本ID].副本玩家
	for i=1,#副本玩家 do
		if 玩家数据[副本玩家[i]]~=nil and 玩家数据[副本玩家[i]].角色~=nil then
	  		self.玩家副本[副本玩家[i]].副本[副本名]=nil
	  		self.副本盒子[副本ID]:完成副本(副本玩家[i])
		  	--清理副本任务
	  		玩家数据[副本玩家[i]].角色:取消任务(副本ID)
		end
	end
	self.副本盒子[副本ID]=nil
end

function 副本处理类:取副本任务说明(玩家id,任务id)
	if self.副本盒子[任务id] ~= nil then
		return self.副本盒子[任务id]:取任务说明(玩家id,任务id)
	else
		玩家数据[玩家id].角色:取消任务(副本ID)
		local 名称="副本任务"
		local 说明="已完成"
		local 备注=""
		return {名称,说明,备注}
	end
end

function 副本处理类:副本传送(队长id,类型)
	if self.玩家副本[队长id] and self.玩家副本[队长id].副本 and self.玩家副本[队长id].副本[类型]~=nil then
		local 副本id=self.玩家副本[队长id].副本[类型]
		local 任务类型=self.副本盒子[副本id].任务类型
		--判断是否可以传入副本
		if 玩家数据[队长id].队伍==0 or 玩家数据[队长id].队长==false  then
			常规提示(队长id,"#Y/该任务必须组队完成且由队长领取")
			return
		elseif 取队伍人数(队长id)<3 then
			常规提示(队长id,"#Y此副本要求队伍人数不低于5人")
			return
		end
		if 玩家数据[队长id].角色:取任务(任务类型)==0 then
			常规提示(队长id,"#Y/你尚未开启此副本")
			return
		elseif not 取队员任务一致(队长id,任务类型,1) then
				return
		end
		--第一次进副本的时候更新进程
		if self.副本盒子[副本id].进程==0 then
			self.副本盒子[副本id]:设置副本进程(1)
		end
		self.副本盒子[副本id]:副本传送(队长id)
	end
end

function 副本处理类:刷新玩家任务追踪(副本玩家)
	for i=1,#副本玩家 do
		if 玩家数据[副本玩家[i]]~=nil and 玩家数据[副本玩家[i]].角色~=nil then
			玩家数据[副本玩家[i]].角色:刷新任务跟踪()
		end
	end
end

function 副本处理类:地图单位对话(连接id,玩家id,标识)
	if 玩家数据[玩家id].队伍~=0 and 玩家数据[玩家id].队长 then
		local 类型=任务数据[标识].类型
		local 副本id=任务数据[标识].真实副本id
		self.副本盒子[副本id]:NPC对话(连接id,玩家id,任务数据[标识].模型,任务数据[标识].名称,类型,标识)
	end
end

function 副本处理类:发送对话信息(连接id,玩家id,对话数据,多重对话)
	if 玩家数据[玩家id].地图单位~=nil then
  	玩家数据[玩家id].地图单位.对话={模型=对话数据.模型,名称=对话数据.名称}
    end
  	玩家数据[玩家id].最后对话={模型=对话数据.模型,名称=对话数据.名称}
  	if 多重对话 then
  		发送数据(连接id,1502,对话数据)
  	else
  		发送数据(连接id,1501,对话数据)
  	end
end

function 副本处理类:发送全队对话信息(玩家id,对话数据)
    if 玩家数据[玩家id].队伍 ~= 0 then
    	local 队伍id=玩家数据[玩家id].队伍
      	for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			发送数据(玩家数据[临时id].连接id,1502,对话数据)
		end
    else
    	self:发送对话信息(玩家数据[玩家id].连接id,玩家id,对话数据,true)
    end
end

function 副本处理类:删除NPC(地图编号,NPC类型,副本id)
  for i,v in pairs(地图处理类.地图单位[地图编号]) do
	  if 任务数据[地图处理类.地图单位[地图编号][i].id].副本id == 副本id and 任务数据[地图处理类.地图单位[地图编号][i].id].类型== NPC类型 then
	  	地图处理类:删除单位(地图编号,i)
	  end
  end
end

function 副本处理类:对话处理(地图编号,名称,事件,玩家id)
	--这里没办法，得按照地图编号区分副本
	local 任务类型=0
	if 地图编号 == 7001 or 地图编号 ==7002 or 地图编号 == 7003 or 地图编号 == 7004 then
		任务类型=7001
	end
	if 任务类型==0 then
		常规提示(玩家id,"#Y/NPC对话配置异常")
		return
	end
  	local 任务id=玩家数据[玩家id].角色:取任务(任务类型)
  	if not 任务id or 任务id==0 then
		常规提示(玩家id,"#Y/你没有该副本的任务存在")
		return
  	end
	self.副本盒子[任务id]:对话处理(地图编号,名称,事件,玩家id)
end

function 副本处理类:播放剧情动画(队长id,动画id)
	local 队伍id=玩家数据[队长id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
	   local 临时id=队伍数据[队伍id].成员数据[n]
	   播放引擎动画(临时id,动画id)
	end
end

return 副本处理类