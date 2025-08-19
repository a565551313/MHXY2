
local 加锁处理类 = class()
local ski = 取法术技能
local typ = type
function 加锁处理类:初始化()


  self.加锁处理= {}
end

function 加锁处理类:加载数据(账号,数字id)
	self.数字id = 数字id
	self.账号 = 账号
	if f函数.文件是否存在([[data/]]..self.账号..[[/]]..self.数字id..[[/加锁处理.txt]])==false then
		写出文件([[data/]]..self.账号..[[/]]..self.数字id..[[/加锁处理.txt]],table.tostring({}))
	end
	self.加锁处理=table.loadstring(读入文件([[data/]]..self.账号..[[/]]..self.数字id..[[/加锁处理.txt]]))
	if self.加锁处理.强行解锁~=nil and self.加锁处理.强行解锁~="" and self.加锁处理.强行解锁 + 1296000 <= os.time() then
		self.加锁处理.强行解锁=nil
		self.加锁处理.道具密码=nil
		常规提示(self.数字id,"你强行解锁已经成功了,系统已给你密码清除了!")
		self:数据保存()
	end
end

function 加锁处理类:取存档数据()
	return self.加锁处理
end

function 加锁处理类:强行清除物品密码(连接id,id,数据)
	if self.加锁处理.道具密码==nil then
		常规提示(id,"请先设置加锁密码,才能进行强行删除密码!")
		return
	elseif self.加锁处理.强行解锁~=nil and self.加锁处理.强行解锁~="" then
		if self.加锁处理.强行解锁 + 1296000 <= os.time() then
			self.加锁处理.强行解锁=nil
			self.加锁处理.道具密码=nil
			常规提示(id,"你强行解锁已经成功了,系统已给你密码清除了!")
			self:数据保存()
			return
		else
			常规提示(id,"你已经申请过强行删除密码了,请耐心等待!上次申请时间是:"..时间转换(self.加锁处理.强行解锁+0))
			return
		end
	end
	local x数额 = 100
	if 玩家数据[id].角色.数据.等级 <10 then
	    x数额 = 10
	end
	if not 玩家数据[id].角色:扣除体力(x数额,"强行解除密码") then
		常规提示(id,"强行解除密码需要"..x数额.."点体力哦!")
	    return
	end
	self.加锁处理.强行解锁 = os.time()
	常规提示(id,"强行删除密码成功！请等待15天后系统自动为你解除密码,如果中途解锁密码则自动解除!"..时间转换(self.加锁处理.强行解锁).."后自动删除!")
	self:数据保存()
end

function 加锁处理类:物品密码设置(连接id,id,数据)
	if 玩家数据[id].加锁处理.加锁处理.道具密码~=nil then
		常规提示(id,"你已经设置过加锁密码了,请在解锁界面点击修改密码!")
		return
	elseif 数据.密码==nil or 数据.密码=="" then
		常规提示(id,"你设置过加锁密码异常!")
		return
	end
	self.加锁处理.道具密码=数据.密码
    self:数据保存()
	常规提示(id,"密码设置成功!请你记住设置的加锁密码!" ..数据.密码)
end
function 加锁处理类:修改物品密码(连接id,id,数据)
	if 玩家数据[id].加锁处理.加锁处理.道具密码==nil then
		常规提示(id,"请先设置加锁密码,才能进行加锁!")
		return
	elseif 数据.密码==nil or 数据.密码=="" or 数据.新密码==nil or 数据.新密码=="" then
		常规提示(id,"你设置过加锁密码异常!")
		return
	elseif 玩家数据[id].加锁处理.加锁处理.道具密码~=数据.密码 then
		常规提示(id,"对不起！你输入的原密码有误!")
		return
	elseif 玩家数据[id].加锁处理.加锁处理.道具密码==数据.新密码 or 数据.密码==数据.新密码 then
		常规提示(id,"你设置的密码和旧密码未有任何改变!")
		return
	end
	if not 玩家数据[id].角色:扣除体力(20,"修改密码") then
		常规提示(id,"修改密码需要20点体力哦!")
	    return
	end
	if self.加锁处理.强行解锁~=nil and self.加锁处理.强行解锁~="" then self.加锁处理.强行解锁=nil 常规提示(id,"你强行解锁已经撤销了!") end
	self.加锁处理.道具密码=数据.新密码
	玩家数据[id].物品锁时间.时间 = os.time()
	玩家数据[id].物品锁时间.开关 = false
    self:数据保存()
	常规提示(id,"密码修改成功!请你记住设置的加锁密码!" ..self.加锁处理.道具密码)
end

function 加锁处理类:数据保存()
	写出文件([[data/]]..self.账号..[[/]]..self.数字id..[[/加锁处理.txt]],table.tostring(self.加锁处理))
end

function 加锁处理类:物品密码解锁(连接id,id,数据)
	if self.加锁处理.道具密码==nil then
		常规提示(id,"请先设置加锁密码,才能进行加锁!")
		发送数据(玩家数据[id].连接id,3707,{})
		return
	elseif 数据.密码==nil or 数据.密码=="" then
		常规提示(id,"你设置过加锁密码异常!")
		return
	elseif self.加锁处理.道具密码~=数据.密码 then
		常规提示(id,"你输入的密码不正确,请核对后输入!")
		return
	end
	if self.加锁处理.强行解锁~=nil and self.加锁处理.强行解锁~="" then self.加锁处理.强行解锁=nil self:数据保存() 常规提示(id,"你强行解锁已经撤销了!") end
	玩家数据[id].物品锁时间.时间 = os.time()
	玩家数据[id].物品锁时间.开关 = true
	常规提示(id,"解锁成功!")
end

function 加锁处理类:物品加锁(连接id,id,数据)--玩家数据[数字id].物品锁时间={时间=os.time(),开关=false}
	if self.加锁处理.道具密码==nil then
		常规提示(id,"请先设置加锁密码,才能进行加锁!")
		发送数据(玩家数据[id].连接id,3707,{})
		return
	end
	if 数据.主类==nil then return end

	if 数据.操作=="全面解锁" or 数据.操作=="解锁" then
		if not 玩家数据[id].物品锁时间.开关 or (os.time()-玩家数据[id].物品锁时间.时间>1800) then
			常规提示(id,"请先密码解锁,才能进行解锁操作!")
			发送数据(玩家数据[id].连接id,3708,{})
			return
		end
	end


	if 数据.主类=="物品" then
	    if 数据.分类==nil or 数据.操作==nil then return end
	    if 数据.分类=="道具" then
			if 数据.操作=="加锁" or 数据.操作=="解锁" and 数据.道具 and 玩家数据[id].角色.数据.道具[数据.道具] then
		        local 道具id =玩家数据[id].角色.数据.道具[数据.道具]
		        if not 玩家数据[id].道具.数据[道具id]  or string.find(玩家数据[id].道具.数据[道具id].名称, "会员卡") then return end
		        if 数据.操作=="加锁" and not 玩家数据[id].道具.数据[道具id].加锁 then
		          玩家数据[id].道具.数据[道具id].加锁=true
		          常规提示(id,"加锁成功!")
		        elseif 数据.操作=="解锁" and 玩家数据[id].道具.数据[道具id].加锁 then
		          玩家数据[id].道具.数据[道具id].加锁=nil
		          常规提示(id,"解锁成功!")
		        end
		    elseif 数据.操作=="全面加锁" or 数据.操作=="全面解锁" then
		        if 数据.操作=="全面加锁" then
		        	for k,v in pairs(玩家数据[id].角色.数据.道具) do
		        		if 玩家数据[id].道具.数据[v]  then
		        			玩家数据[id].道具.数据[v].加锁=true
						end
		        	end
					常规提示(id,"全面加锁成功!")
		        elseif 数据.操作=="全面解锁" then
					for k,v in pairs(玩家数据[id].角色.数据.道具) do
		        		if 玩家数据[id].道具.数据[v] and not string.find(玩家数据[id].道具.数据[v].名称, "会员卡") then
		        			玩家数据[id].道具.数据[v].加锁=nil
						end
		        	end
					常规提示(id,"全面解锁成功!")
		        end
			end
		    玩家数据[id].道具:索要道具(连接id,id)
	    elseif 数据.分类=="行囊" then
			if 数据.操作=="加锁" or 数据.操作=="解锁" and 数据.道具 and 玩家数据[id].角色.数据.行囊[数据.道具] then
		        local 道具id = 玩家数据[id].角色.数据.行囊[数据.道具]
		        if not 玩家数据[id].道具.数据[道具id] or string.find(玩家数据[id].道具.数据[道具id].名称, "会员卡") then return end
		        if 数据.操作=="加锁" and not 玩家数据[id].道具.数据[道具id].加锁 then
		          玩家数据[id].道具.数据[道具id].加锁=true
		          常规提示(id,"加锁成功!")
		        elseif 数据.操作=="解锁" and 玩家数据[id].道具.数据[道具id].加锁 then
		          玩家数据[id].道具.数据[道具id].加锁=nil
		          常规提示(id,"解锁成功!")
		        end
		     elseif 数据.操作=="全面加锁" or 数据.操作=="全面解锁" then
		        if 数据.操作=="全面加锁" then
					for k,v in pairs(玩家数据[id].角色.数据.行囊) do
		        		if 玩家数据[id].道具.数据[v] then
		        			玩家数据[id].道具.数据[v].加锁=true
						end
		        	end
					常规提示(id,"全面加锁成功!")
		        elseif 数据.操作=="全面解锁" then
		        	for k,v in pairs(玩家数据[id].角色.数据.行囊) do
		        		if 玩家数据[id].道具.数据[v] and not string.find(玩家数据[id].道具.数据[v].名称, "会员卡") then
		        			玩家数据[id].道具.数据[v].加锁=nil
						end
		        	end
					常规提示(id,"全面解锁成功!")
		        end
			end
			玩家数据[id].道具:索要行囊(连接id,id)
	    elseif 数据.分类=="法宝" then
			if 数据.操作=="加锁" or 数据.操作=="解锁" and 数据.道具 and 玩家数据[id].角色.数据.法宝[数据.道具] then
		        local 道具id = 玩家数据[id].角色.数据.法宝[数据.道具]
		        if not 玩家数据[id].道具.数据[道具id] then return end
		        if 数据.操作=="加锁" and not 玩家数据[id].道具.数据[道具id].加锁 then
		          玩家数据[id].道具.数据[道具id].加锁=true
		          常规提示(id,"加锁成功!")
		        elseif 数据.操作=="解锁" and 玩家数据[id].道具.数据[道具id].加锁 then
		          玩家数据[id].道具.数据[道具id].加锁=nil
		          常规提示(id,"解锁成功!")
		        end
		      elseif 数据.操作=="全面加锁" or 数据.操作=="全面解锁" then
		        if 数据.操作=="全面加锁" then
		        	for k,v in pairs(玩家数据[id].角色.数据.法宝) do
		        		if 玩家数据[id].道具.数据[v] then
		        			玩家数据[id].道具.数据[v].加锁=true
						end
		        	end

					常规提示(id,"全面加锁成功!")
		        elseif 数据.操作=="全面解锁" then
					for k,v in pairs(玩家数据[id].角色.数据.法宝) do
		        		if 玩家数据[id].道具.数据[v] then
		        			玩家数据[id].道具.数据[v].加锁=nil
						end
		        	end
					常规提示(id,"全面解锁成功!")
		        end
			end
			玩家数据[id].道具:索要法宝(连接id,id)
	    elseif 数据.分类=="锦衣" then
			if 数据.操作=="加锁" or 数据.操作=="解锁" and 数据.道具 and 玩家数据[id].角色.数据.锦衣数据[数据.道具] then
		        local 道具id = 玩家数据[id].角色.数据.锦衣[数据.道具]
		        if not 玩家数据[id].道具.数据[道具id] then return end
		        if 数据.操作=="加锁" and not 玩家数据[id].道具.数据[道具id].加锁 then
		          玩家数据[id].道具.数据[道具id].加锁=true
		          常规提示(id,"加锁成功!")
		        elseif 数据.操作=="解锁" and 玩家数据[id].道具.数据[道具id].加锁 then
		          玩家数据[id].道具.数据[道具id].加锁=nil
		          常规提示(id,"解锁成功!")
		        end
		    elseif 数据.操作=="全面加锁" or 数据.操作=="全面解锁" then
		        if 数据.操作=="全面加锁" then
					for k,v in pairs(玩家数据[id].角色.数据.锦衣) do
		        		if 玩家数据[id].道具.数据[v] then
		        			玩家数据[id].道具.数据[v].加锁=true
						end
		        	end
					常规提示(id,"全面加锁成功!")
		        elseif 数据.操作=="全面解锁" then
					for k,v in pairs(玩家数据[id].角色.数据.锦衣) do
		        		if 玩家数据[id].道具.数据[v] then
		        			玩家数据[id].道具.数据[v].加锁=nil
						end
		        	end
					常规提示(id,"全面解锁成功!")
		        end
			end
			玩家数据[id].道具:索要锦衣(连接id,id)
	    end
	elseif 数据.主类=="装备" then
	    if 数据.操作=="加锁" or 数据.操作=="解锁" and 数据.道具 and 玩家数据[id].角色.数据.装备[数据.道具] then
	      local 道具id = 玩家数据[id].角色.数据.装备[数据.道具]
	      if not 玩家数据[id].道具.数据[道具id] then return end
	      if 数据.操作=="加锁" and not 玩家数据[id].道具.数据[道具id].加锁 then
	        玩家数据[id].道具.数据[道具id].加锁=true
	        常规提示(id,"加锁成功!")
	      elseif 数据.操作=="解锁" and 玩家数据[id].道具.数据[道具id].加锁 then
	        玩家数据[id].道具.数据[道具id].加锁=nil
	        常规提示(id,"解锁成功!")
	      end
	    elseif 数据.操作=="全面加锁" or 数据.操作=="全面解锁" then
	      if 数据.操作=="全面加锁" then
	        for k,v in pairs(玩家数据[id].角色.数据.装备) do
		        if 玩家数据[id].道具.数据[v] then
		        	玩家数据[id].道具.数据[v].加锁=true
				end
		     end
	        常规提示(id,"全面加锁成功!")
	      elseif 数据.操作=="全面解锁" then
	        for k,v in pairs(玩家数据[id].角色.数据.装备) do
		        if 玩家数据[id].道具.数据[v] then
		        	玩家数据[id].道具.数据[v].加锁=nil
				end
		     end
	        常规提示(id,"全面解锁成功!")
	      end
	    end
	    发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
	elseif 数据.主类=="灵饰" then
	    if 数据.操作=="加锁" or 数据.操作=="解锁" and 数据.道具 and 玩家数据[id].角色.数据.灵饰[数据.道具] then
			local 道具id = 玩家数据[id].角色.数据.灵饰[数据.道具]
			if not 玩家数据[id].道具.数据[道具id] then return end
			if 数据.操作=="加锁" and not 玩家数据[id].道具.数据[道具id].加锁 then
				玩家数据[id].道具.数据[道具id].加锁=true
				常规提示(id,"加锁成功!")
			elseif 数据.操作=="解锁" and 玩家数据[id].道具.数据[道具id].加锁 then
				玩家数据[id].道具.数据[道具id].加锁=nil
				常规提示(id,"解锁成功!")
			end
	    elseif 数据.操作=="全面加锁" or 数据.操作=="全面解锁" then
			if 数据.操作=="全面加锁" then
		      	for k,v in pairs(玩家数据[id].角色.数据.灵饰) do
			        if 玩家数据[id].道具.数据[v] then
			        	玩家数据[id].道具.数据[v].加锁=true
					end
			    end
		        常规提示(id,"全面加锁成功!")
			elseif 数据.操作=="全面解锁" then
		        for k,v in pairs(玩家数据[id].角色.数据.灵饰) do
			        if 玩家数据[id].道具.数据[v] then
			        	玩家数据[id].道具.数据[v].加锁=nil
					end
			    end
		        常规提示(id,"全面解锁成功!")
			end
	    end
	    发送数据(玩家数据[id].连接id,3506,玩家数据[id].角色:取灵饰数据())
	elseif 数据.主类=="宝宝" then--#玩家数据[id].召唤兽.数据
		if 数据.操作=="加锁" or 数据.操作=="解锁" and 数据.道具 and 玩家数据[id].召唤兽.数据[数据.道具] then
			if not 玩家数据[id].召唤兽.数据[数据.道具] then return end
			if 数据.操作=="加锁" and not 玩家数据[id].召唤兽.数据[数据.道具].加锁 then
		        玩家数据[id].召唤兽.数据[数据.道具].加锁=true
		        常规提示(id,"加锁成功!")
			elseif 数据.操作=="解锁" and 玩家数据[id].召唤兽.数据[数据.道具].加锁 then
		        玩家数据[id].召唤兽.数据[数据.道具].加锁=nil
		        常规提示(id,"解锁成功!")
			end
		elseif 数据.操作=="全面加锁" or 数据.操作=="全面解锁" then
			if 数据.操作=="全面加锁" then
		        for n=1,#玩家数据[id].召唤兽.数据 do
					if 玩家数据[id].召唤兽.数据[n] then
			            玩家数据[id].召唤兽.数据[n].加锁=true
					end
		        end
		        常规提示(id,"全面加锁成功!")
			elseif 数据.操作=="全面解锁" then
		        for n=1,#玩家数据[id].召唤兽.数据 do
					if 玩家数据[id].召唤兽.数据[n] then
			            玩家数据[id].召唤兽.数据[n].加锁=nil
					end
		        end
				常规提示(id,"全面解锁成功!")
			end
		end
		发送数据(玩家数据[id].连接id,16,玩家数据[id].召唤兽.数据)
	end
	发送数据(连接id,3706,{})
end


function 加锁处理类:更新(dt) end
function 加锁处理类:显示(x,y) end
return 加锁处理类