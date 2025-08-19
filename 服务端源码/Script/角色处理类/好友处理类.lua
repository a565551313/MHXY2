-- @Author: ASUS
-- @Date:   2021-11-20 10:52:13
-- @Last Modified by:   ASUS
-- @Last Modified time: 2025-04-19 00:38:17
local 好友处理类 = class()


function 好友处理类:初始化()
	self.数据={好友={},黑名单={},分组={[1]={名称="自定义分组1",好友={}}},留言信息={}}
	self.当前聊天={}
	self.在线好友={}
	self.临时好友={}

end

function 好友处理类:加载数据(账号,id)
	    self.玩家id = tonumber(id)
		if f函数.文件是否存在([[data/]]..账号..[[/]]..id..[[/好友数据.txt]])==false then
			self.数据 ={好友={},黑名单={},分组={[1]={名称="自定义分组1",好友={}}},留言信息={}}
    		写出文件([[data/]]..账号..[[/]]..id..[[/好友数据.txt]],table.tostring(self.数据))
    	else
    	   self.数据=table.loadstring(读入文件([[data/]]..账号..[[/]]..id..[[/好友数据.txt]]))
    	end
    	if not self.数据 or not self.数据.好友 or not self.数据.黑名单 or not self.数据.分组 or not self.数据.留言信息  then
    		self.数据 ={好友={},黑名单={},分组={[1]={名称="自定义分组1",好友={}}},留言信息={}}
    	end


end




function 好友处理类:修改分组名称(编号,名称)
	if not self.数据.分组[编号] or 名称==nil or 名称=="" then
		  常规提示(self.玩家id,"#Y/数据错误请重新打开")
		  return
	elseif  判断特殊字符(名称) then
		 常规提示(self.玩家id,"#Y/名称不能有特殊字符")
		 return
	elseif  string.len(名称)>18 then
		常规提示(self.玩家id,"#Y/名称太长了")
		 return
	 end
	 self.数据.分组[编号].名称=tostring(名称)
	 self:更新数据()
end

function 好友处理类:创建新分组()
	if #self.数据.分组>=10 then
		return
	 end
	 local 编号= #self.数据.分组+1
	 self.数据.分组[编号]={名称="自定义分组"..编号,好友={}}
	 self:更新数据()
end




function 好友处理类:获取数据()
	 if self:查看消息()==false then
       --玩家数据[内容.数字id].角色:取好友数据(内容.数字id,玩家数据[内容.数字id].连接id,50)
        for i,v in pairs(self.临时好友) do
        	if v then
	        	if 玩家数据[i] and 玩家数据[i].角色 and self.临时好友[i] then
	        		v.在线=true
	        	else
	        	    v.在线=false
	        	end
	        end
        end
        self.在线好友={}
    	for k,v in pairs(self.数据.好友) do
    		if v then
	    		if v and 玩家数据[k] and 玩家数据[k].角色 then
	    			self.在线好友[k]=true
	    		else
		    		if self.在线好友[k] then
		    		  self.在线好友[k]=nil
		    		end
	    		end
    	   end
    	end


       发送数据(玩家数据[self.玩家id].连接id,50,{在线=self.在线好友,临时=self.临时好友,好友=self.数据.好友,黑名单=self.数据.黑名单,分组=self.数据.分组})
    end
end

function 好友处理类:更新数据(是否)
	 for i,v in pairs(self.临时好友) do
	 	if v then
	        if 玩家数据[i] and 玩家数据[i].角色 and self.临时好友[i] then
	        	v.在线=true
	        else
	        	 v.在线=false
	        end
	    end
     end
     self.在线好友={}
     for k,v in pairs(self.数据.好友) do
     	if v then
	         if  玩家数据[k] and 玩家数据[k].角色 and not 是否 then
	    		   self.在线好友[k]=true
	    	 else
	    	 	if self.在线好友[k] then
	    		   self.在线好友[k]=nil
	    		end
	    	end
    	end
     end

	发送数据(玩家数据[self.玩家id].连接id,51,{在线=self.在线好友,临时=self.临时好友,好友=self.数据.好友,黑名单=self.数据.黑名单,分组=self.数据.分组})
end


function 好友处理类:添加好友度(好友id,数额)

	if not 数额 then 数额 = 0 end
	if self.数据.好友[好友id] then
		if not self.数据.好友[好友id].关系 then self.数据.好友[好友id].关系 ="普通朋友" end
		if not self.数据.好友[好友id].好友度 then  self.数据.好友[好友id].好友度=0 end
		self.数据.好友[好友id].好友度=self.数据.好友[好友id].好友度+数额
	    if self.数据.好友[好友id].好友度>=100 then
		        self.数据.好友[好友id].关系="亲密好友"
		elseif self.数据.好友[好友id].好友度>=500 then
		       self.数据.好友[好友id].关系="无话不谈"
		elseif self.数据.好友[好友id].好友度>=1000 then
		       self.数据.好友[好友id].关系="亦师亦友"
		elseif self.数据.好友[好友id].好友度>=3000 then
		       self.数据.好友[好友id].关系="亲密无间"
		elseif self.数据.好友[好友id].好友度>=5000 then
		       self.数据.好友[好友id].关系="同甘共苦"
		elseif self.数据.好友[好友id].好友度>=7500 then
		       self.数据.好友[好友id].关系="生死与共"
		elseif self.数据.好友[好友id].好友度>=10000 then
		       self.数据.好友[好友id].关系="不分彼此"
		end
	end
end

function 好友处理类:更新消息(数据)
	if  type(数据)~="table" then return end
	if 数据.内容 and type(数据.内容)~="table" then
		数据.内容 ={[1]=数据.内容}
	end
	数据.id=tonumber(数据.id)
	if self.正在聊天 and self.正在聊天==数据.id and self.当前聊天[数据.id] then
		self.当前聊天[数据.id].记录[#self.当前聊天[数据.id].记录+1]={时间=数据.时间,id=数据.id,内容=数据.内容}
		发送数据(玩家数据[self.玩家id].连接id,54,{数据=self.当前聊天[数据.id]})
	else
	    self.数据.留言信息[#self.数据.留言信息+1]=数据
	    发送数据(玩家数据[self.玩家id].连接id,56,"1")
	end

end



function 好友处理类:发送消息(发送id,内容)
		if self.数据.黑名单[发送id] then
		   常规提示(self.玩家id,"#Y/对方在你的屏蔽名单中")
		   return
	    end
	    local 临时内容 = 内容
	    if 内容 and type(内容)~="table" then
			临时内容 ={[1]=内容}
		end
		for i=1,#临时内容 do
			if  string.find(临时内容[i],"/[^/]*/")~=nil or string.find(临时内容[i], "/$")~=nil then
				__gge.print(false,6,时间转换(os.time()).."玩家id:"..self.玩家id.."发送id:"..发送id.." 发送的内容存在转义字符")
				常规提示(self.玩家id,"#Y/发送的内容有敏感字符")
		  	 	return
			end
		end


		local 内容数据={
		    	id=tonumber(self.玩家id),
		    	名称=玩家数据[self.玩家id].角色.数据.名称,
		    	模型=玩家数据[self.玩家id].角色.数据.模型,
		    	等级=玩家数据[self.玩家id].角色.数据.等级,
		    	账号=玩家数据[self.玩家id].账号,
		    	时间= os.time(),
		    	内容=临时内容
		    }
		    if not self.当前聊天[发送id] then
		    	 self.当前聊天[发送id]=内容数据
		    	 self.当前聊天[发送id].记录={}
		    	 self.当前聊天[发送id].好友度=0
		    end
		    if self.数据.好友[发送id] then
		    	self.当前聊天[发送id].好友度 = self.数据.好友[发送id].好友度
		    	self.当前聊天[发送id].是否好友=true
		    end

	     if 玩家数据[发送id] and 玩家数据[发送id].角色 then
	     	if 玩家数据[发送id].好友.数据.黑名单[self.玩家id] then
	     	   常规提示(self.玩家id,"#Y/对方不想理你,并鄙视的看着你")
			   return
	     	else
	     		self.当前聊天[发送id].记录[#self.当前聊天[发送id].记录+1]={时间=内容数据.时间,id=self.玩家id,内容=内容}
	     		玩家数据[发送id].好友:更新消息(内容数据)
	     	 end
	     else
	     	local 好友数据={}
		    if self.数据.好友[发送id] then
		    	好友数据=table.loadstring(读入文件([[data/]]..self.数据.好友[发送id].账号..[[/]]..发送id..[[/好友数据.txt]]))
		    	if 好友数据.黑名单[self.玩家id] then
		    		常规提示(self.玩家id,"#Y/对方不想理你,并鄙视的看着你")
			       return
		    	else
			    	好友数据.留言信息[#好友数据.留言信息+1]=内容数据
			  		写出文件([[data/]]..self.数据.好友[发送id].账号..[[/]]..发送id..[[/好友数据.txt]],table.tostring(好友数据))
			  	end
		    elseif self.临时好友[发送id] then
		    	好友数据=table.loadstring(读入文件([[data/]]..self.临时好友[发送id].账号..[[/]]..发送id..[[/好友数据.txt]]))
		    	if 好友数据.黑名单[self.玩家id] then
		    		常规提示(self.玩家id,"#Y/对方不想理你,并鄙视的看着你")
			       return
		    	else
			    	好友数据.留言信息[#好友数据.留言信息+1]=内容数据
			    	写出文件([[data/]]..self.临时好友[发送id].账号..[[/]]..发送id..[[/好友数据.txt]],table.tostring(好友数据))
			    end
		    else
		        常规提示(self.玩家id,"#Y/对方不在线")
			   return
		    end
		     self.当前聊天[发送id].记录[#self.当前聊天[发送id].记录+1]={时间=内容数据.时间,id=self.玩家id,内容=内容}
	     end
	     发送数据(玩家数据[self.玩家id].连接id,54,{数据=self.当前聊天[发送id]})
end

function 好友处理类:查看消息()
		if #self.数据.留言信息>0 then
		    local 查看id = tonumber(self.数据.留言信息[1].id)
		    if  查看id~=nil and 查看id~=0 then
			    if not self.当前聊天[查看id] then
			    	self.当前聊天[查看id] = DeepCopy(self.数据.留言信息[1])
			    	self.当前聊天[查看id].记录={}
			    	self.当前聊天[查看id].好友度=  0
			    end
			    if self.数据.留言信息[1].好友度 then
			    	self.当前聊天[查看id].好友度=self.数据.留言信息[1].好友度
			    end
			    self.当前聊天[查看id].是否好友=nil
			    if self.数据.好友[查看id] then
			    	self.当前聊天[查看id].好友度=self.数据.好友[查看id].好友度
			    	self.当前聊天[查看id].是否好友=true
			    end
			    self.当前聊天[查看id].记录[#self.当前聊天[查看id].记录+1]={时间=self.数据.留言信息[1].时间,id=查看id,内容=self.数据.留言信息[1].内容}

			    发送数据(玩家数据[self.玩家id].连接id,54,{数据=self.当前聊天[查看id]})
			    table.remove(self.数据.留言信息,1)
			    if #self.数据.留言信息==0 then
				   发送数据(玩家数据[self.玩家id].连接id,57,"1")
			    end
			    return true
			else
				return false
			end
	  else
		    发送数据(玩家数据[self.玩家id].连接id,57,"1")
		    return false
	  end
end

function 好友处理类:获取消息(数据)
	    local 获取id = tonumber(数据.数字ID)
		if self.数据.黑名单[获取id] or 获取id==nil or 获取id==0 then
		   常规提示(self.玩家id,"#Y/对方在你的屏蔽名单中")
		   return
	    end
	    if self:查看消息()==false then
		    if not self.当前聊天[获取id] then
				  self.当前聊天[获取id]={}
				  local 内容数据={
					    	id=获取id,
					    	名称=数据.名称,
					    	模型=数据.模型,
					    	等级=数据.等级,
					    	账号=数据.账号,

					    }
				  self.当前聊天[获取id]=内容数据
				  self.当前聊天[获取id].记录={}
				  self.当前聊天[获取id].好友度=0
			  end
			  self.当前聊天[获取id].是否好友=nil
			  if self.数据.好友[获取id] then
			    	self.当前聊天[获取id].好友度=self.数据.好友[获取id].好友度
			    	self.当前聊天[获取id].是否好友=true
			  end
			  发送数据(玩家数据[self.玩家id].连接id,54,{数据=self.当前聊天[获取id]})
	    end
end

function 好友处理类:删除好友(添加id)
		local 类型=""
		if self.数据.好友[添加id] then
		     类型="好友"
		elseif self.临时好友[添加id] then
		     类型="临时"
		elseif self.数据.黑名单[添加id] then
		     类型="黑名单"
		end
		if 类型=="好友" then
			常规提示(self.玩家id,"#Y/你与好友#R/"..self.数据.好友[添加id].名称.."#Y/断绝了关系")
		    self.数据.好友[添加id]=false
		    for i=1,#self.数据.分组 do
		    	if self.数据.分组[i].好友[添加id] then
				   self.数据.分组[i].好友[添加id]=nil
				end
		    end
		elseif 类型=="临时" then
				常规提示(self.玩家id,"#Y/你与临时好友#R/"..self.临时好友[添加id].名称.."#Y/断绝了关系")
		    	self.临时好友[添加id]=nil
		elseif 类型=="黑名单" then
				常规提示(self.玩家id,"#Y/你删除了屏蔽名单#R/"..self.数据.黑名单[添加id].名称)
				self.数据.黑名单[添加id]=nil
				if self.数据.好友[添加id]==false then
				   self.数据.好友[添加id]=nil
				   for i=1,#self.数据.分组 do
				       if self.数据.分组[i].好友[添加id]==false then
						  self.数据.分组[i].好友[添加id]=nil
					   end
				   end
				elseif self.临时好友[添加id]==false then
					   self.临时好友[添加id]=nil
				end

		end
	 self:更新数据()
end

--------------------------------------------------------------------
function 好友处理类:添加临时(添加id,是否)
		if not 添加id or 添加id==0  then
	    	return
		elseif not 玩家数据[添加id] then
			常规提示(self.玩家id,"#Y这个角色并不存在或当前没有在线")
			return
	    elseif 玩家数据[添加id].好友.数据.黑名单[self.玩家id] then
	    	常规提示(self.玩家id,"#Y/你在对方的黑名单中，无法添加")
			return
	    elseif self.数据.好友[添加id] then
	    	常规提示(self.玩家id,"#Y/你们已经是好友了")
			return
		elseif self.临时好友[添加id] then
	    	常规提示(self.玩家id,"#Y/不用重复添加")
			return
		 elseif self.数据.黑名单[添加id] then
	    	常规提示(self.玩家id,"#Y/对方在你的屏蔽名单中")
			return
	    end
	    self.临时好友[添加id]={}
	    self.临时好友[添加id].名称=玩家数据[添加id].角色.数据.名称
	    self.临时好友[添加id].等级=玩家数据[添加id].角色.数据.等级
	    self.临时好友[添加id].模型=玩家数据[添加id].角色.数据.模型
	    self.临时好友[添加id].门派=玩家数据[添加id].角色.数据.门派
	    self.临时好友[添加id].帮派=玩家数据[添加id].角色.数据.帮派
	    self.临时好友[添加id].性别=玩家数据[添加id].角色.数据.性别
        self.临时好友[添加id].种族=玩家数据[添加id].角色.数据.种族
	    self.临时好友[添加id].称谓=玩家数据[添加id].角色.数据.当前称谓
	    self.临时好友[添加id].数字ID=添加id
	    self.临时好友[添加id].关系="陌生人"
	    self.临时好友[添加id].好友度=0
	    self.临时好友[添加id].曾用名="无"
	    self.临时好友[添加id].账号=玩家数据[添加id].账号
	    if 是否 then
	    	常规提示(self.玩家id,"#Y/玩家#R/"..玩家数据[添加id].角色.数据.名称.."#Y/添加你为临时好友")
	    else
	    	玩家数据[添加id].好友:添加临时(self.玩家id,1)
	    	常规提示(self.玩家id,"#Y/你添加了#R/"..玩家数据[添加id].角色.数据.名称.."#Y/为临时好友")
	    end
	    self:更新数据()
end

function 好友处理类:添加好友(添加id,分组,是否)


	    if not 添加id  or 添加id==0  then
	    	return
		elseif not 玩家数据[添加id] then
			常规提示(self.玩家id,"#Y这个角色并不存在或当前没有在线")
			return
	    elseif 玩家数据[添加id].好友.数据.黑名单[self.玩家id] then
	    	常规提示(self.玩家id,"#Y/你在对方的黑名单中，无法添加")
			return
	    elseif self.数据.好友[添加id] then
	    	常规提示(self.玩家id,"#Y/你们已经是好友了")
			return
		elseif self.数据.黑名单[添加id] then
	    	常规提示(self.玩家id,"#Y/对方在你的屏蔽名单中")
			return
	    end
	    self.数据.好友[添加id]={}
	    self.数据.好友[添加id].名称=玩家数据[添加id].角色.数据.名称
	    self.数据.好友[添加id].模型=玩家数据[添加id].角色.数据.模型
	    self.数据.好友[添加id].门派=玩家数据[添加id].角色.数据.门派
	    self.数据.好友[添加id].帮派=玩家数据[添加id].角色.数据.帮派
	    self.数据.好友[添加id].等级=玩家数据[添加id].角色.数据.等级
	    self.数据.好友[添加id].性别=玩家数据[添加id].角色.数据.性别
        self.数据.好友[添加id].种族=玩家数据[添加id].角色.数据.种族
	    self.数据.好友[添加id].称号=玩家数据[添加id].角色.数据.当前称谓
	    self.数据.好友[添加id].数字ID=添加id
	    self.数据.好友[添加id].关系="普通朋友"
	    self.数据.好友[添加id].曾用名="无"
	    self.数据.好友[添加id].好友度=0
	    self.数据.好友[添加id].账号=玩家数据[添加id].账号

	    if self.临时好友[添加id] then
	    	self.临时好友[添加id] = nil
	    end
	    if 分组 and self.数据.分组[分组] then
	    	self.数据.分组[分组].好友[添加id] =true
	    else
	        self.数据.分组[1].好友[添加id] =true
	    end
	    if 是否 then
	    	常规提示(self.玩家id,"#Y/玩家:#R/"..玩家数据[添加id].角色.数据.名称.."#Y/添加你为好友")
	    else
	    	玩家数据[添加id].好友:添加好友(self.玩家id,1,1)
	    	常规提示(self.玩家id,"#Y/你添加了#R/"..玩家数据[添加id].角色.数据.名称.."#Y/为好友")
	    end

	    self:更新数据()
end


function 好友处理类:更换分组(添加id,分组)

	     if not 分组 or not self.数据.分组[分组] then
			return
	    elseif self.数据.分组[分组].好友[添加id] then
			return
	    end
	    local  原组 = 0
	    for i=1,#self.数据.分组 do
	    	if  self.数据.分组[i].好友[添加id] then
		    	原组=i
		    	break
		    end
	    end

	    if 原组~=0 then
	    	self.数据.分组[原组].好友[添加id] = nil
	    	self.数据.分组[分组].好友[添加id] =true
	    else
	        if self.临时好友[添加id] then
	        	 self.数据.好友[添加id] = DeepCopy(self.临时好友[添加id])
	        	 self.数据.好友[添加id].好友度 = 0
	        	 self.数据.好友[添加id].关系="普通朋友"
	        	 self.数据.分组[分组].好友[添加id] =true
	        	 常规提示(self.玩家id,"#Y/你添加了#R/"..self.数据.好友[添加id].名称.."#Y/为好友")
	        	 if 玩家数据[添加id] and 玩家数据[添加id].角色 and not 玩家数据[添加id].好友.数据.黑名单[self.玩家id] then
	        	 	玩家数据[添加id].好友:添加好友(self.玩家id,1,1)
	        	 end
	        end
	    end
	    self:更新数据()
end


----------------------------------------------------------------------------------
function 好友处理类:加入黑名单(添加id,数据)
	     if not tonumber(添加id) or 添加id==0 then return  end
	     添加id=tonumber(添加id)
		 local 加入数据
		 local 类型=""
		 if self.数据.好友[添加id] then
		    	类型="好友"
		 elseif self.临时好友[添加id] then
		    	类型="临时"
		 else
		        类型="陌生人"
		 end
		 if 类型=="好友" then
		 	加入数据= DeepCopy(self.数据.好友[添加id])
		 	self.数据.好友[添加id]=false
		 	for i=1,#self.数据.分组 do
		 		if self.数据.分组[i].好友[添加id] then
				   self.数据.分组[i].好友[添加id]=false
				   break
				end
		    end
		 elseif 类型=="临时" then
		 	 加入数据= DeepCopy(self.临时好友[添加id])
		 	 self.临时好友[添加id]=false
		 else
		     if 数据 and type(数据)=="table" and  数据.数字ID and 数据.账号 then
		     	加入数据=DeepCopy(数据)
		     elseif 玩家数据[添加id] and 玩家数据[添加id].账号 then
		     	  加入数据={
		     	   		名称=玩家数据[添加id].角色.数据.名称,
					    模型=玩家数据[添加id].角色.数据.模型,
					    门派=玩家数据[添加id].角色.数据.门派,
					    帮派=玩家数据[添加id].角色.数据.帮派,
					    等级=玩家数据[添加id].角色.数据.等级,
					    性别=玩家数据[添加id].角色.数据.性别,
					    种族=玩家数据[添加id].角色.数据.种族,
					    称号=玩家数据[添加id].角色.数据.当前称谓,
					    账号=玩家数据[添加id].账号,
					    数字ID=添加id,
					    关系="陌生人",
					    曾用名="无"
		     	}
		     else
		     	 加入数据=nil
		     end
		 end






		 if 加入数据 then
		 	 self.数据.黑名单[添加id] = 加入数据
		 	 self.数据.黑名单[添加id].关系="陌生人"
		 	 常规提示(self.玩家id,"#Y/你把玩家#R/"..self.数据.黑名单[添加id].名称.."#Y/加入了屏蔽名单")
		 end
		 self:更新数据()

end

function 好友处理类:拉出黑名单(添加id)
		if self.数据.黑名单[添加id] then
			local 类型=""
		    if self.数据.好友[添加id]==false then
		    	类型="好友"
		    elseif self.临时好友[添加id]==false  then
		    	类型="临时"
		    else
		        类型="陌生人"
		    end
		    if 类型=="好友" then
		    	self.数据.好友[添加id]=DeepCopy(self.数据.黑名单[添加id])
		    	self:添加好友度(添加id,0)
		    	local 判断分组 = true
		    	for i=1,#self.数据.分组 do
		    		if self.数据.分组[i].好友[添加id]==false then
					    判断分组 =false
					    self.数据.分组[i].好友[添加id]=true
					    break
					end
			    end
			    if 判断分组 then
			    	 self.数据.分组[1].好友[添加id]=true
			    end
		    else
		    	self.临时好友[添加id]=DeepCopy(self.数据.黑名单[添加id])
		    end
		    常规提示(self.玩家id,"#Y/你把玩家#R/"..self.数据.黑名单[添加id].名称.."#Y/从屏蔽名单中删除了")
		    self.数据.黑名单[添加id]=nil


		 end
self:更新数据()
end

function 好友处理类:查找角色(名称,id)
  local 数据组={}
  if id~=nil and id~="" then id=tonumber(id) end
  for i, v in pairs(玩家数据) do
    if (名称~=nil and 玩家数据[i].角色.数据.名称==名称) or i==id then
      数据组.名称=玩家数据[i].角色.数据.名称
      数据组.模型=玩家数据[i].角色.数据.模型
      数据组.门派=玩家数据[i].角色.数据.门派
      数据组.帮派=玩家数据[i].角色.数据.帮派
      数据组.等级=玩家数据[i].角色.数据.等级
      数据组.性别=玩家数据[i].角色.数据.性别
      数据组.种族=玩家数据[i].角色.数据.种族
      数据组.称号=玩家数据[i].角色.数据.当前称谓
      数据组.账号=玩家数据[i].账号
      数据组.数字ID=i
      数据组.关系="陌生人"
      数据组.曾用名="无"
    end
  end
  return 数据组
end




function 好友处理类:存档()
	if not self.数据 then return  end
		for k,v in pairs(self.数据.好友) do
	         if 玩家数据[k] and 玩家数据[k].角色 then
	    		玩家数据[k].好友:更新数据(1)
	    	 end
	     end
	     if not self.玩家id then  __gge.print(false,6,时间转换(os.time()).."好友处理:玩家id为空") return end
	     if not 玩家数据[self.玩家id] then  __gge.print(false,6,时间转换(os.time()).."好友处理:玩家数据为空,玩家id:"..self.玩家id) return end
	     if not 玩家数据[self.玩家id].账号 then  __gge.print(false,6,时间转换(os.time()).."好友处理:玩家账号为空,玩家id:"..self.玩家id) return end

		--写出文件([[data/]]..玩家数据[self.玩家id].账号..[[/]]..self.玩家id.."/消息记录/"..取年月日时分(os.time())..".txt",table.tostring(self.当前聊天))
		写出文件([[data/]]..玩家数据[self.玩家id].账号..[[/]]..self.玩家id.."/消息记录/"..os.time()..".txt",table.tostring(self.当前聊天))
        写出文件([[data/]]..玩家数据[self.玩家id].账号..[[/]]..self.玩家id..[[/好友数据.txt]],table.tostring(self.数据))
end







return 好友处理类