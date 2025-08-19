-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2022-03-01 14:10:16
-- @最后修改来自: baidwwy
-- @Last Modified time: 2025-05-29 14:58:10

local 帮战活动类 = class()
local function 积分排序(a,b) return a.积分>b.积分 end

function 帮战活动类:初始化()
	self.入场开关=false
	self.活动开关=false
	self.宝箱开关=false
	self.入场时间=6000
	self.活动时间=5400
	self.活动计时=0
	self.入场帮派={}
	self.获胜帮派 = 0


end

function 帮战活动类:活动开启()
	if self.活动开关 or self.入场开关 or self.宝箱开关 then
		return "活动已经开启"
	else
		self.入场开关 = true
		self.活动开关 = false
	    self.宝箱开关 = false
		self.活动计时 = os.time()
		self.入场帮派={}
		self.获胜帮派 = 0
		self:入场倒计时()
		发送公告("#S帮派大乱斗活动#G开始进场了,请所有帮派玩家去长安城找到#R帮派竞赛主持人#G进场！#Y10分钟后将开始比赛！")
	end
end

function 帮战活动类:入场倒计时()
	local 任务id = "5594_"..os.time()..取随机数(88,99999999)
	任务数据[任务id]={
		id = 任务id,
		起始=os.time(),
    	结束=self.入场时间,
    	类型=5594,
    	名称="帮派竞赛主持人",
        模型="男人_将军",
        方向=0,
        x=162,
        y=71,
        地图编号=1001,
        地图名称=取地图名称(1001),
	}
	 地图处理类:添加单位(任务id)
end

function 帮战活动类:开启比赛()
	self.入场开关 = false
	self.活动开关 = true
	self.宝箱开关 = false
	local 任务id = "5595_"..os.time()..取随机数(88,99999999)
	任务数据[任务id]={
		id = 任务id,
		起始=os.time(),
    	结束=self.活动时间,
    	类型=5595,
    	称谓="传送员",
	    名称="传送侍卫",
        模型="男人_马副将",
        方向=0,
        x=29,
        y=19,
        地图编号=6020,
        地图名称=取地图名称(6020),
	}
	 地图处理类:添加单位(任务id)
	发送公告("#S帮派大乱斗活动#G正式开打,#R胜利场数最多得帮派#G将获得本次大乱斗胜利,#Y活动时间持续1小时！")
end

function 帮战活动类:结束比赛()
	self.入场开关 = false
	self.活动开关 = false
    self.宝箱开关 = false
    for n, v in pairs(战斗准备类.战斗盒子) do
	   if 战斗准备类.战斗盒子[n].战斗类型==200006 then
	      战斗准备类.战斗盒子[n]:结束战斗处理(0,0,1)
	   end
	end
	地图处理类:清除地图玩家(6010,1001,200,110)
	地图处理类:清除地图玩家(6011,1001,200,110)
	地图处理类:清除地图玩家(6020,1001,200,110)
	发送公告("#S帮派大乱斗活动#G圆满结束了，请期待下次开启")
end


function 帮战活动类:进入杀戮场景(id)
	if 玩家数据[id].队伍 ~= 0 and not 玩家数据[id].队长 then
		常规提示(id,"你不是队长无法进入")
	    return
	end
	local 临时yx=地图处理类.地图坐标[6010]:取随机点()
    地图处理类:跳转地图(id,6010,临时yx.x,临时yx.y)
    常规提示(id,"#Y/进入帮战杀戮战场")
end

function 帮战活动类:进入比赛场景(id)
	if 玩家数据[id].队伍 ~= 0 and not 玩家数据[id].队长 then
		常规提示(id,"你不是队长无法进入")
	    return
	elseif not 玩家数据[id].角色.数据.帮派数据 or not 玩家数据[id].角色.数据.帮派数据.编号 or 玩家数据[id].角色.数据.帮派数据.编号<=0 then
		常规提示(id,"你还没有帮派呢")
	    return
	end
	local 帮派id = 玩家数据[id].角色.数据.帮派数据.编号
	if not 帮派数据[帮派id] then 常规提示(id,"#Y/未找到帮派!") return  end
	if 玩家数据[id].队伍 and 玩家数据[id].队伍~=0 then
        for i=2,#队伍数据[玩家数据[id].队伍].成员数据 do
             local 临时id = 队伍数据[玩家数据[id].队伍].成员数据[i]
             if not 玩家数据[临时id] then
                  常规提示(id,"#Y/未找到玩家!")
                  return
             elseif not 玩家数据[临时id].角色.数据.帮派数据 or 玩家数据[临时id].角色.数据.帮派数据.编号~=帮派id then
					常规提示(id,"你的队友还没有帮派,或你们不是一个帮派的")
				    return
             end
       end
    end
	if self.入场帮派[帮派id] == nil then
		self.入场帮派[帮派id] = {积分=0}
	end
	local 临时yx=地图处理类.地图坐标[6020]:取随机点()
	玩家数据[id].角色.数据.当前称谓 = 帮派数据[帮派id].帮派名称.."的成员"
    地图处理类:跳转地图(id,6020,临时yx.x,临时yx.y)
    常规提示(id,"#Y/进入帮战准备地图")
end

function 帮战活动类:进入战斗(进攻id,防守id)
	if not self.活动开关 then
    	常规提示(进攻id,"#Y/当前为帮派竞赛准备时间，无法进行切磋。")
    	return
    elseif not 玩家数据[进攻id] or not 玩家数据[防守id] then
           常规提示(进攻id,"#Y/未找到玩家!")
           return
    elseif 玩家数据[进攻id].角色.数据.帮派数据==nil or 玩家数据[进攻id].角色.数据.帮派数据.编号==nil or 玩家数据[进攻id].角色.数据.帮派数据.编号<=0 then
		常规提示(进攻id,"你还没有帮派呢")
	    return
    elseif 玩家数据[防守id].角色.数据.帮派数据==nil or 玩家数据[防守id].角色.数据.帮派数据.编号==nil or 玩家数据[防守id].角色.数据.帮派数据.编号<=0 then
		常规提示(进攻id,"对方还没有帮派呢")
	    return
	elseif (玩家数据[进攻id].战斗 and 玩家数据[进攻id].战斗~=0) or 玩家数据[进攻id].角色.数据.战斗开关 then
			常规提示(进攻id,"无法重复进入战斗")
	    	return
	elseif (玩家数据[防守id].战斗 and 玩家数据[防守id].战斗~=0) or 玩家数据[防守id].角色.数据.战斗开关 then
			常规提示(进攻id,"对方正在战斗")
	    	return
	end
	local 帮派id = 玩家数据[进攻id].角色.数据.帮派数据.编号
	local 帮派id1 = 玩家数据[防守id].角色.数据.帮派数据.编号
	if 玩家数据[进攻id].队伍~=nil and 玩家数据[进攻id].队伍~=0 then
        for i=1,#队伍数据[玩家数据[进攻id].队伍].成员数据 do
             local 临时id = 队伍数据[玩家数据[进攻id].队伍].成员数据[i]
             if not 玩家数据[临时id] then
                  常规提示(进攻id,"#Y/未找到玩家!")
                  return
             elseif (玩家数据[临时id].战斗 and 玩家数据[临时id].战斗~=0) or 玩家数据[临时id].角色.数据.战斗开关 then
                 	常规提示(进攻id,"#Y/无法重复进入战斗!")
                  	return
             elseif not 玩家数据[临时id].角色.数据.帮派数据 or 玩家数据[临时id].角色.数据.帮派数据.编号~=帮派id then
					常规提示(进攻id,"你的队友还没有帮派,或你们不是一个帮派的")
				    return
             end
       end
    end
    if  玩家数据[防守id].队伍~=nil and 玩家数据[防守id].队伍~=0 then
        for i=1,#队伍数据[玩家数据[防守id].队伍].成员数据 do
             local 临时id = 队伍数据[玩家数据[防守id].队伍].成员数据[i]
              if not 玩家数据[临时id] then
                  常规提示(进攻id,"#Y/未找到玩家!")
                  return
             elseif (玩家数据[临时id].战斗 and 玩家数据[临时id].战斗~=0) or 玩家数据[临时id].角色.数据.战斗开关 then
	                常规提示(进攻id,"#Y/对方正在战斗中!")
	                return
             elseif not 玩家数据[临时id].角色.数据.帮派数据 or 玩家数据[临时id].角色.数据.帮派数据.编号~=帮派id1 then
					常规提示(进攻id,"对方不是一个帮派的")
				    return
             end
        end
    end
	if self.入场帮派[帮派id] == nil then
	   self.入场帮派[帮派id] = {积分=0}
	end
	if self.入场帮派[帮派id1] == nil then
	   self.入场帮派[帮派id1] = {积分=0}
	end
	战斗准备类:创建玩家战斗(进攻id, 200006, 防守id, 1501)
end


function 帮战活动类:战斗胜利(id,失败id)
	local 帮派id = 玩家数据[id].角色.数据.帮派数据.编号
	self.入场帮派[帮派id].积分 = self.入场帮派[帮派id].积分 + 1

end
function 帮战活动类:战斗失败(失败id)
		if 玩家数据[失败id].队伍~=0 and 玩家数据[失败id].队长 then
			  local 临时yx=地图处理类.地图坐标[6020]:取随机点()
	          地图处理类:跳转地图(失败id,6020,临时yx.x,临时yx.y)
	     elseif not 玩家数据[失败id].队伍 or 玩家数据[失败id].队伍==0 then
	     	  local 临时yx=地图处理类.地图坐标[6020]:取随机点()
	     	  地图处理类:跳转地图(失败id,6020,临时yx.x,临时yx.y)
		end
end



function 帮战活动类:刷出宝箱处理()
	     self.入场开关 = false
		 self.活动开关 =false
		 self.宝箱开关 = true
		 local 任务id = "5597_"..os.time()..取随机数(88,99999999)
			任务数据[任务id]={
				id = 任务id,
				起始=os.time(),
		    	结束=1800,
		    	类型=5597,
		    	称谓="传送员",
			    名称="传送侍卫",
		        模型="男人_马副将",
		        方向=1,
		        x=138,
		        y=9,
		        地图编号=6010,
		        地图名称=取地图名称(6010),
			}
		 地图处理类:添加单位(任务id)
	     for n, v in pairs(战斗准备类.战斗盒子) do
		     if 战斗准备类.战斗盒子[n].战斗类型==200006 then
			    战斗准备类.战斗盒子[n]:结束战斗处理(0,0,1)
			end
		 end
		 for n, v in pairs(玩家数据) do
		    玩家数据[n].拾取帮战宝箱=0
		 end
	     local 奖励表 = {}
		 for k,v in pairs(self.入场帮派) do
			 奖励表[#奖励表+1] = {帮派id=k,积分=v.积分}
		 end
		 table.sort(奖励表,积分排序)
		if #奖励表>0 then
			self.获胜帮派= 0
			if 奖励表[1].积分>0 then
				self.获胜帮派 = 奖励表[1].帮派id
			end
			local 获胜玩家={}
			for n, v in pairs(地图处理类.地图玩家[6010]) do
				if 玩家数据[n]~=nil and 玩家数据[n].角色.数据.帮派数据.编号==self.获胜帮派 then
					获胜玩家[#获胜玩家+1]={编号=n}
				end
			end
			for n, v in pairs(地图处理类.地图玩家[6020]) do
				if 玩家数据[n]~=nil and 玩家数据[n].角色.数据.帮派数据.编号==self.获胜帮派 then
					获胜玩家[#获胜玩家+1]={编号=n}
				end
			end
			获胜玩家=删除重复(获胜玩家)
			if  #获胜玩家>=1 then
					for i=1,#获胜玩家 do
						if 玩家数据[获胜玩家[i].编号]~=nil then
							if 玩家数据[获胜玩家[i].编号].战斗~=0 then
								玩家数据[获胜玩家[i].编号].战斗=0
						    end
							-- if 玩家数据[获胜玩家[i].编号].队伍~=0 then
						 --       队伍处理类:退出队伍(获胜玩家[i].编号)
							-- end
							local 临时yx=地图处理类.地图坐标[6011]:取随机点()
						    地图处理类:跳转地图(获胜玩家[i].编号,6011,临时yx.x,临时yx.y)
						end
					end
			end
			if 自定义数据.帮战宝箱刷出数量==nil or 自定义数据.帮战宝箱刷出数量[1]==nil then 自定义数据.帮战宝箱刷出数量={1} end
			local 刷出数量=取随机数(自定义数据.帮战宝箱刷出数量[1],自定义数据.帮战宝箱刷出数量[#自定义数据.帮战宝箱刷出数量])
		    for i=1,刷出数量 do
		           	    local 临时yx=地图处理类.地图坐标[6011]:取随机点()
						local 任务id = "5596_"..os.time()..取随机数(88,99999999)
						任务数据[任务id]={
							id = 任务id,
							起始=os.time(),
					    	结束=1800,
					    	类型=5596,
						    名称="帮派宝箱",
					        模型="宝箱",
					        x=临时yx.x,
					        y=临时yx.y,
					        行走开关=true,
					        地图编号=6011,
					        地图名称=取地图名称(6011),
						}
						 地图处理类:添加单位(任务id)
			end

			if self.获胜帮派~=0 and 帮派数据[self.获胜帮派]~=nil and 帮派数据[self.获胜帮派].帮派名称~=nil then
				 帮派数据[self.获胜帮派].帮战胜利=os.time()+72000
		         发送公告("#S帮派大乱斗活动#G结束了,#G当前获胜帮派是#R"..帮派数据[self.获胜帮派].帮派名称..",#G胜利帮派成员20小时内可到帮派总管处领取限时称号")
		    end
	   else
	     发送公告("#G此次帮派活动没有帮派获得第一")
	  end
end



function 帮战活动类:开启福利宝箱(id,任务id)
    if 任务数据[任务id]==nil then
      常规提示(id,"#Y这个宝箱已经被其他玩家开启过了")
    return
  end
    local 获得物品={}
    for i=1,#自定义数据.帮战宝箱 do
        if 取随机数()<=自定义数据.帮战宝箱[i].概率 then
           获得物品[#获得物品+1]=自定义数据.帮战宝箱[i]
         end
    end
    获得物品=删除重复(获得物品)
     if 获得物品~=nil then
        local 取编号=取随机数(1,#获得物品)
        if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
           玩家数据[id].道具:自定义给予道具(id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
           广播消息({内容=format("#S(帮派宝箱)#G玩家#R"..玩家数据[id].角色.数据.名称.."#G在开启帮派宝箱是获得了#S"..获得物品[取编号].名称),频道="xt"})
         end
     end

  地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].编号)
  任务数据[任务id]=nil
end



return 帮战活动类