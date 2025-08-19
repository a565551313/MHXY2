local 英雄大会 = class()

function 英雄大会:初始化()
	     self.开关 = false
	     self.时间 = os.time()
	     self.报名 = {}
	     self.积分 = {}
	     self.时间间隔 ={}
	     self.队伍编号=0
	     self.失败={}

end

function 英雄大会:活动定时器()
	if self.开关 then
		if not self.准备 and not self.开始 and os.time()-self.时间>=600 then
           self:开启入场()
		elseif self.准备 and not self.开始 and os.time()-self.时间>=300 then
           self:比武开始()
    elseif self.开始 and os.time()-self.时间>=3600 then
           self:结束活动()
        end
	end
end

function 英雄大会:开启活动()
	      英雄排名={第一名={},第二名={},第三名={}}
        self.报名={}
        self.积分 = {}
        self.失败={}
        self.时间间隔 ={}
        self.开关 = true
        self.准备 = false
        self.时间 = os.time()
        self.队伍编号=0
        发送公告("#G(英雄大会)#P已经开启，请到长安城的比武大会主持人处报名参赛！10分钟后入场")
	      广播消息({内容=format("#G(英雄大会)#P已经开启，请到长安城的比武大会主持人处报名参赛！10分钟后入场"),频道="hd"})
end
function 英雄大会:开启入场()
	      self.准备 = true
	      self.时间 = os.time()
        发送公告("#G(英雄大会)#P已经开启入场，请报名的玩家到长安城的比武大会主持人处进场！5分钟后开始比赛")
	      广播消息({内容=format("#G(英雄大会)#P已经开启入场，请报名的玩家到长安城的比武大会主持人处进场！5分钟后开始比赛"),频道="hd"})
end
function 英雄大会:比武开始()
	      self.准备 = false
	      self.开始 = true
	      self.时间 = os.time()
	      发送公告("#G(英雄大会)#P比武已经开始！60分钟后结束比赛")
	      广播消息({内容=format("#G(英雄大会)#P比武已经开始！60分钟后结束比赛"),频道="hd"})
end

function 英雄大会:结束活动()
	      英雄排名={第一名={},第二名={},第三名={}}
	      self.开关 = false
	      self.开始 = false
	      self.单人 ={}
	      self.组队 ={}
	      for n, v in pairs(战斗准备类.战斗盒子) do
	        if 战斗准备类.战斗盒子[n].战斗类型==200004 then
	          战斗准备类.战斗盒子[n]:结束战斗处理(0,0,1)
	        end
	      end
         for k,v in pairs(self.报名) do
         	英雄排名[k]={领取=false}
         	if self.积分[k]~=nil and self.积分[k]>0 then
	         	 if v.组队 then
    	         	 	local 队伍 = v.队伍编号
    	         	 	local 执行 = true
    	         	 	for i=1,#self.组队 do
    	         	 		if self.组队[i].编号 == 队伍 then
    	         	 			执行 = false
    	         	 		end
    	         	 	end
    	         	 	if 执行 then
    		         	 	self.组队[#self.组队+1] = {积分=self.积分[k],成员=v.成员,编号=队伍}
    		         	end
	            else
	             	self.单人[#self.单人+1]={id=k,积分= self.积分[k]}
	           end
	         end
         end
          table.sort(self.组队,function(a,b) return a.积分>b.积分 end )
          table.sort(self.单人,function(a,b) return a.积分>b.积分 end )
          if self.单人[1]~=nil then
          	 if 英雄排名.第一名[self.单人[1].id] ==nil then
          	 	英雄排名.第一名[self.单人[1].id] ={领取=false,积分=self.积分[self.单人[1].id],名称=self.报名[self.单人[1].id].名称}
          	 	if 玩家数据[self.单人[1].id]~=nil then
          	 		添加最后对话(self.单人[1].id,"你获得了本次英雄大会的第一名")
          	 	end
          	 end
          end
          if self.单人[2]~=nil then
          	 if 英雄排名.第二名[self.单人[2].id] ==nil then
          	 	英雄排名.第二名[self.单人[2].id] ={领取=false,积分=self.积分[self.单人[2].id],名称=self.报名[self.单人[2].id].名称}
          	 	if 玩家数据[self.单人[2].id]~=nil then
          	 		添加最后对话(self.单人[2].id,"你获得了本次英雄大会的第二名")
          	 	end
          	 end
          end
          if self.单人[3]~=nil then
          	 if 英雄排名.第三名[self.单人[3].id] ==nil then
          	 	英雄排名.第三名[self.单人[3].id] ={领取=false,积分=self.积分[self.单人[3].id],名称=self.报名[self.单人[3].id].名称}
          	 	if 玩家数据[self.单人[3].id]~=nil then
          	 		添加最后对话(self.单人[3].id,"你获得了本次英雄大会的第三名")
          	 	end
          	 end
          end
          if self.组队[1]~=nil then
          	 for k,v in pairs(self.组队[1].成员) do
          	 	if 英雄排名.第一名[k] ==nil and self.组队[1].成员[k] then
          	 	   英雄排名.第一名[k] ={领取=false,积分=self.积分[k],名称=self.报名[k].名称}
          	 	   if 玩家数据[k]~=nil then
	          	 	  添加最后对话(k,"你获得了本次英雄大会的第一名")
	          	   end
          	    end
          	 end
          end
          if self.组队[2]~=nil then
          	 for k,v in pairs(self.组队[2].成员) do
          	 	if 英雄排名.第二名[k] ==nil and self.组队[2].成员[k] then
          	 	   英雄排名.第二名[k] ={领取=false,积分=self.积分[k],名称=self.报名[k].名称}
          	 	   if 玩家数据[k]~=nil then
	          	 	  添加最后对话(k,"你获得了本次英雄大会的第二名")
	          	   end
          	    end
          	 end
          end
          if self.组队[3]~=nil then
          	 for k,v in pairs(self.组队[3].成员) do
          	 	if 英雄排名.第三名[k] ==nil and self.组队[3].成员[k] then
          	 	   英雄排名.第三名[k] ={领取=false,积分=self.积分[k],名称=self.报名[k].名称}
          	 	   if 玩家数据[k]~=nil then
	          	 	  添加最后对话(k,"你获得了本次英雄大会的第三名")
	          	   end
          	    end
          	 end
          end
         local 名次名单 ="第一名:"
         for k,v in pairs(英雄排名.第一名) do
             名次名单 = 名次名单..v.名称.." "
         end
         名次名单 = 名次名单.."第二名:"
         for k,v in pairs(英雄排名.第二名) do
             名次名单 = 名次名单..v.名称.." "
         end
         名次名单 = 名次名单.."第三名:"
         for k,v in pairs(英雄排名.第三名) do
             名次名单 = 名次名单..v.名称.." "
         end
         地图处理类:清除地图玩家(6003,1001,191,104)
	       地图处理类:清除地图玩家(6004,1001,191,104)
         发送公告("#G(英雄大会)#P已经关闭，请玩家注意下次开启时间！本次排名#Y/"..名次名单)
	       广播消息({内容=format("#G(英雄大会)#P已经关闭，请玩家注意下次开启时间！本次排名#Y/"..名次名单),频道="hd"})
end
function 英雄大会:玩家组队报名(id,参数)
	     if self.报名[id] and not 参数 then
	     	添加最后对话(id,"#Y/你已经报名,请勿重复报名")
	     	return
	     end
	     if 玩家数据[id].队伍~=0 and 玩家数据[id].队长 then
	     	    if 参数~=nil and self.报名[id] and not self.报名[id].组队 then
			     	self.报名[id] = nil
			    end
	     		local 是否报名 = true
	     		for i=1,#队伍数据[玩家数据[id].队伍].成员数据 do
	     			local 临时id = 队伍数据[玩家数据[id].队伍].成员数据[i]
	     			if self.报名[临时id] then
	     			   是否报名 = false
	     			   添加最后对话(id,"#Y/玩家#R/"..玩家数据[临时id].角色.数据.名称.."#Y/已经报名,请勿重复报名")
	     			   return
	     			end
	     		end
	     		if 是否报名 then
		     	   self.队伍编号=self.队伍编号+1
		     	   local 成员id={}
			       for i=1,#队伍数据[玩家数据[id].队伍].成员数据 do
			     		local 临时id = 队伍数据[玩家数据[id].队伍].成员数据[i]
			     		self.报名[临时id] = {组队=true,名称=玩家数据[临时id].角色.数据.名称,队伍编号=self.队伍编号,成员={}}
			     		成员id[临时id]=true
			       end
			       for i=1,#队伍数据[玩家数据[id].队伍].成员数据 do
			     		local 临时id = 队伍数据[玩家数据[id].队伍].成员数据[i]
			     		self.报名[临时id].成员 = 成员id
			     		常规提示(临时id,"#Y/已报名英雄大会,请注意入场时间,活动未结束时不要退出组队")
			       end
			    end
		  else
		  	   常规提示(id,"#Y/组队并且是队长才可以报名")
	     end
end


function 英雄大会:玩家单人报名(id,参数)
		 if self.报名[id] and not 参数 then
		    添加最后对话(id,"#Y/你已经报名,请勿重复报名")
		    return
		 end
		 if 玩家数据[id].队伍~=0 then
		    添加最后对话(id,"#Y/单人模式报名无法组队")
		    return
		 end
		 if 参数~=nil and self.报名[id] then
		 	if self.报名[id].组队 then
		 		for k,v in pairs(self.报名[id].成员) do
		 			if id~=k then
		 				   self.报名[k].成员[id]=false
              添加最后对话(k,"#Y/玩家#R/"..玩家数据[id].角色.数据.名称.."#Y/已退出多人模式,请重新寻找队友")
		 			end
		 		end
            end
		 end
		 self.报名[id] = {组队=false,名称=玩家数据[id].角色.数据.名称}
		 常规提示(id,"#Y/已报名英雄大会,请注意入场时间")
end

function 英雄大会:队伍添加报名(id)
	     if 玩家数据[id].队伍~=0 and 玩家数据[id].队长 and self.报名[id] and self.报名[id].组队 then
	     	for i=1,#队伍数据[玩家数据[id].队伍].成员数据 do
	     		local 临时id = 队伍数据[玩家数据[id].队伍].成员数据[i]
	     		if self.报名[临时id] and self.报名[临时id].组队 and self.报名[临时id].队伍编号~= self.报名[id].队伍编号 then
	     			添加最后对话(id,"#Y/玩家#R/"..玩家数据[临时id].角色.数据.名称.."#Y/已经在其他组报名,无法继续添加")
	     			return
	     		end
            end
	     	local 已有成员 = 0
	     	for k,v in pairs(self.报名[id].成员) do
	     		if self.报名[id].成员[k] then
	     		   已有成员 = 已有成员 + 1
	     		end
	     	end
	     	if 已有成员<5 then
	     		local 队伍编号= self.报名[id].队伍编号
	     		local 成员id ={}
	     		for i=1,#队伍数据[玩家数据[id].队伍].成员数据 do
			     	local 临时id = 队伍数据[玩家数据[id].队伍].成员数据[i]
			     	if self.报名[临时id]==nil then
			     	   self.报名[临时id] = {组队=true,名称=玩家数据[临时id].角色.数据.名称,队伍编号=队伍编号}
			     	   常规提示(临时id,"#Y/已报名英雄大会,请注意入场时间,活动未结束时不要退出组队")
			     	else
                        if not self.报名[临时id].组队 then
                           self.报名[临时id] = {组队=true,队伍编号=队伍编号}
			     	       常规提示(临时id,"#Y/单人模式以改成组队模式,请注意入场时间,活动未结束时不要退出组队")
                        end
                    end
                    self.报名[临时id].成员 ={}
                    成员id[临时id] =true
                end
                for i=1,#队伍数据[玩家数据[id].队伍].成员数据 do
			     	local 临时id = 队伍数据[玩家数据[id].队伍].成员数据[i]
                    self.报名[临时id].成员 =成员id
                end
                常规提示(id,"#Y/新队友已添加完成")
	     	else
	     		常规提示(id,"#Y/比武成员数已达最大")
	     	end
         else
             常规提示(id,"#Y/你没达到条件无法添加比武成员")
         end
end

function 英雄大会:是否同组(id,id1)
	     if not self.报名[id] then
	     	常规提示(id,"#Y/你还没有报名")
	     	return false
	     end
	     if self.报名[id].组队 then
		     if id1~=nil then
		        if self.报名[id].成员[id1] then
			     	   return true
			     else
	                return false
			     end
			  else
			  	 if 玩家数据[id].队伍~=0 then
    			  	 	local 找到=true
    			  	 	local 队伍id = 玩家数据[id].队伍
    			  	 	for i=1,#队伍数据[队伍id].成员数据 do
      			  	 		local 临时id = 队伍数据[队伍id].成员数据[i]
      			  	 		if not self.报名[id].成员[临时id] then
      			  	 			找到=false
                    end
    			  	 	end
                return 找到
			  	 else
			  	     return false
			  	 end
			  end
		 else
		     return false
		 end
		 return false
end


function 英雄大会:添加积分(id)
     if self.积分[id] ==nil then
        self.积分[id] = 0
     end
       self.积分[id] = self.积分[id] + 1
       self.时间间隔[id] = os.time()+20
       常规提示(id,"#Y/你获得了英雄大会#R/1#Y/点胜利积分")
end

function 英雄大会:扣除积分(id)
  if self.积分[id] ==nil then
     self.积分[id] = 0
  end
  if self.失败[id] == nil then
     self.失败[id] = 0
  end
  if self.积分[id]>0 then
    self.积分[id] = self.积分[id] -1
    常规提示(id,"#Y/你被扣除了#R/1#Y/点英雄大会积分")
  else
      self.失败[id] = self.失败[id] + 1
      if self.失败[id]>=3 then
           self.失败[id] = 3
           常规提示(id,"#Y/你已失败3次")
      else
      	常规提示(id,"#Y/你当前失败#R/"..self.失败[id].."#Y/次,失败三次将自动退出")
      end
  end




end


function 英雄大会:战斗胜利(id,失败id)
	     if 玩家数据[id].队伍~=0 and  玩家数据[id].队长  then
  	     	for i=1,#队伍数据[玩家数据[id].队伍].成员数据 do
  	     		  self:添加积分(队伍数据[玩家数据[id].队伍].成员数据[i])
  	     	end
	     elseif not 玩家数据[id].队伍 or 玩家数据[id].队伍==0 then
	         self:添加积分(id)
	     end
       if 玩家数据[失败id].队伍~=0 and  玩家数据[失败id].队长 then
            local 队伍id = 玩家数据[失败id].队伍
            for n=1,#队伍数据[队伍id].成员数据 do
                  local 队员id=队伍数据[队伍id].成员数据[n]
                  self:扣除积分(队员id)
            end
       elseif not 玩家数据[失败id].队伍 or 玩家数据[失败id].队伍==0 then
           self:扣除积分(失败id)
       end
end


function 英雄大会:战斗失败(失败id)
          if 玩家数据[失败id].队伍~=0 and not 玩家数据[失败id].队长 then
              return
          end
          if self.失败[失败id] and self.失败[失败id]>=3 then
              地图处理类:跳转地图(失败id,1001,191,104)
          else
               local 地图编号 = 玩家数据[失败id].角色.数据.地图数据.编号
               local xy=地图处理类.地图坐标[地图编号]:取随机点()
               地图处理类:跳转地图(失败id,地图编号,xy.x,xy.y)
          end
end





function 英雄大会:进入战斗(进攻id,防守id)
          if not self.开关 or not self.开始 then
              常规提示(进攻id,"#Y/当前为英雄比武大会准备时间!")
          elseif not 玩家数据[进攻id] or not 玩家数据[防守id] then
                  常规提示(进攻id,"#Y/未找到玩家!")
          elseif (玩家数据[进攻id].战斗 and 玩家数据[进攻id].战斗~=0) or 玩家数据[进攻id].角色.数据.战斗开关 then
                      常规提示(进攻id,"#Y/无法重复进入战斗!")
          elseif (玩家数据[防守id].战斗 and 玩家数据[防守id].战斗~=0) or 玩家数据[防守id].角色.数据.战斗开关 then
                      常规提示(进攻id,"#Y/对方正在战斗!")
          elseif self.时间间隔[进攻id] and os.time()<self.时间间隔[进攻id] then
                    常规提示(进攻id,"#Y/你刚刚胜利休息一会! #R/"..(self.时间间隔[进攻id]-os.time()).."#Y/秒后在继续战斗")
          elseif self.失败[进攻id] and self.失败[进攻id]>=3 then
                        常规提示(进攻id,"#Y/你已失败3次无法继续战斗!")
          elseif self.失败[防守id] and self.失败[防守id]>=3 then
                      常规提示(进攻id,"#Y/对方失败3次无法继续战斗!")
          else
              if 玩家数据[进攻id].角色.数据.地图数据.编号 == 玩家数据[防守id].角色.数据.地图数据.编号 then
                    if 玩家数据[进攻id].队伍~=nil and 玩家数据[进攻id].队伍~=0 then
                        for i=1,#队伍数据[玩家数据[进攻id].队伍].成员数据 do
                            local 临时id = 队伍数据[玩家数据[进攻id].队伍].成员数据[i]
                            if not 玩家数据[临时id] then
                                常规提示(进攻id,"#Y/未找到玩家!")
                                return
                            elseif not self:是否同组(进攻id,临时id) then
                                 常规提示(进攻id,"#Y/你的队伍中有不同组队的队员!")
                                 return
                            elseif (玩家数据[临时id].战斗 and 玩家数据[临时id].战斗~=0) or 玩家数据[临时id].角色.数据.战斗开关 then
                                    常规提示(进攻id,"#Y/无法重复进入战斗!")
                                    return
                            elseif self.失败[临时id] and self.失败[临时id]>=3 then
                                    常规提示(进攻id,"#Y/你已失败3次无法继续战斗!")
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
                            elseif not self:是否同组(防守id,临时id) then
                                 常规提示(防守id,"#Y/你的队伍中有不同组队的队员!")
                                 return
                            elseif (玩家数据[临时id].战斗 and 玩家数据[临时id].战斗~=0) or 玩家数据[临时id].角色.数据.战斗开关 then
                                    常规提示(进攻id,"#Y/对方正在战斗!")
                                    return
                            elseif self.失败[临时id] and self.失败[临时id]>=3 then
                                    常规提示(进攻id,"#Y/对方失败3次无法继续战斗!")
                                    return
                            end
                        end
                    end
                    战斗准备类:创建玩家战斗(进攻id, 200004, 防守id, 1501)
              else
                 常规提示(进攻id,"#Y/你距离对方太远了!")
              end
          end

end










return 英雄大会