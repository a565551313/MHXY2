
local 共享仓库类 = class()

function 共享仓库类:初始化()
	self.账号=""
    self.数据 = {}
    self.召唤兽={}
    self.使用玩家={}
    self.整理时间= 0
end
function 共享仓库类:数据处理(内容)
	 local  id =内容.数字id
     if id==0 or id ==nil  or 玩家数据[id]==nil or (玩家数据[id]~=nil and 玩家数据[id].摆摊数据~=nil) then  return end
     发送数据(玩家数据[id].连接id,164)
     self:加入玩家(id)
	if 内容.文本=="打开仓库" then
		发送数据(玩家数据[id].连接id,3513,玩家数据[id].道具:索要道具4(id,"道具"))
		发送数据(玩家数据[id].连接id,162,{道具=self:索取仓库数据(1),仓库总数=#self.数据,召唤兽总数=#玩家数据[id].召唤兽仓库.数据})
   elseif 内容.文本=="获取道具" then
	    发送数据(玩家数据[id].连接id,3513,玩家数据[id].道具:索要道具4(id,内容.道具类型))
	    发送数据(玩家数据[id].连接id,164)
   elseif 内容.文本=="道具仓库" then
	    if 内容.序列>#self.数据 then
	      常规提示(id,"#Y/这已经是最后一页了")
	      return
	    elseif 内容.序列<1 then
	      return
	    end

	    发送数据(玩家数据[id].连接id,163,{道具=self:索取仓库数据(内容.序列),页数=内容.序列})
   elseif 内容.文本=="整理仓库" then
   	     -- self.整理数据={}
   	     -- if 内容.页数~=nil and 内容.页数>=1 and 内容.道具类型~=nil then
   	     -- 	 self:整理仓库(内容.页数,内容.道具类型,id)
   	     -- end
   	       if 内容.道具类型~=nil then
   	     	  self:整理仓库(内容.页数,内容.道具类型,id)
   	     end
     elseif 内容.文本=="存入仓库" then
     	    if 内容.页数~=nil and 内容.页数>=1 and 内容.类型~=nil and 内容.物品~=nil and
     	       玩家数据[id].角色.数据[内容.类型][内容.物品]~=nil and
     	       玩家数据[id].道具.数据[玩家数据[id].角色.数据[内容.类型][内容.物品]]~=nil then
               self:存入仓库(内容.页数,内容.类型,内容.物品,id)
            end
      elseif 内容.文本=="取出物品" then
     	    if 内容.页数~=nil and 内容.页数>=1 and 内容.类型~=nil and 内容.物品~=nil and
     	       self.数据[内容.页数]~=nil and self.数据[内容.页数][内容.物品]~=nil then
               self:取出仓库(内容.页数,内容.类型,内容.物品,id)
            end
       elseif 内容.文本=="打开召唤兽" then
            发送数据(玩家数据[id].连接id,165,{宝宝列表=玩家数据[id].召唤兽.数据,召唤兽仓库总数=#self.召唤兽,召唤兽仓库数据=self:索取召唤兽仓库数据(1)})
       elseif 内容.文本=="获取召唤兽" then
				if 内容.序列 > #self.召唤兽 then
					常规提示(id,"#Y/这已经是最后一页了")
					return
				elseif 内容.序列<1 then
					return
				end
				发送数据(玩家数据[id].连接id,163,{召唤兽仓库数据=self:索取召唤兽仓库数据(内容.序列),页数=内容.序列,宝宝列表=玩家数据[id].召唤兽.数据})
		elseif 内容.文本=="存入召唤兽" then
			self:存入召唤兽仓库(id,内容)
		elseif 内容.文本=="取出召唤兽" then
			self:取出召唤兽仓库(id,内容)
		elseif 内容.文本=="购买召唤兽仓库" then
			local 对话=[[增加召唤兽仓库数量需要支付40点仙玉，每增加一间仓库将额外消耗（已增加仓库数量*20）点仙玉。本次增加仓库需要消耗#R]]..((#self.召唤兽-1)*40+40).."#W点仙玉，你是否需要进行购买仓库操作？"
		发送数据(玩家数据[id].连接id,1501,{名称=玩家数据[id].角色.名称,模型=玩家数据[id].角色.模型,对话=对话,选项={"确定购买共享召唤兽仓库","让我再想想"}})


		elseif 内容.文本=="购买道具仓库" then
			local 对话=[[增加物品仓库数量需要支付40点仙玉，每增加一间仓库将额外消耗（已增加仓库数量*40）点仙玉。本次增加仓库需要消耗#R]]..((#self.数据-3)*40+40).."#W点仙玉，你是否需要进行购买仓库操作？"
    		发送数据(玩家数据[id].连接id,1501,{名称=玩家数据[id].角色.数据.名称,模型=玩家数据[id].角色.数据.模型,对话=对话,选项={"确定购买共享仓库","让我再想想"}})




	end
end


function 共享仓库类:加载数据(账号)
	self.账号=账号
	if f函数.文件是否存在([[data/]]..账号..[[/共享仓库.txt]])==false then
		self.数据 = {[1]={},[2]={},[3]={}}
		写出文件([[data/]]..账号..[[/共享仓库.txt]],table.tostring(self.数据))
	else
	    self.数据=table.loadstring(读入文件([[data/]]..账号..[[/共享仓库.txt]]))
	end
	if f函数.文件是否存在([[data/]]..账号..[[/共享召唤兽.txt]])==false then
		self.召唤兽 = {[1]={}}
		写出文件([[data/]]..账号..[[/共享召唤兽.txt]],table.tostring(self.召唤兽))
	else
	    self.召唤兽=table.loadstring(读入文件([[data/]]..账号..[[/共享召唤兽.txt]]))
	end

end
function 共享仓库类:保存数据()
	    if self.账号==nil or self.账号==""  then
         	return false
        end
		 写出文件([[data/]]..self.账号..[[/共享仓库.txt]],table.tostring(self.数据))
		 写出文件([[data/]]..self.账号..[[/共享召唤兽.txt]],table.tostring(self.召唤兽))
end


function 共享仓库类:加入玩家(id,离开)
	   if 离开 then
	   	  self.使用玩家[id]=nil
	   else
	      self.使用玩家[id]=true
	   end
end



function 共享仓库类:存入仓库(编号,类型,背包id,id)
	if 玩家数据[id].摊位数据~=nil then
		常规提示(id,"#Y/摆摊中无法操作仓库。")
		return
	end
	if 编号==nil  or 编号<1 or 类型==nil  or self.数据==nil or self.数据[编号]==nil then return end
	if 类型~="道具" and 类型~="行囊" then return end
	if 玩家数据[id].角色.数据[类型][背包id]==nil then return end
	local 道具id = 玩家数据[id].角色.数据[类型][背包id]
	if 玩家数据[id].道具.数据[道具id]==nil then return end
	if 玩家数据[id].道具.数据[道具id].名称=="帮派银票" then
	   常规提示(id,"#Y/该物品无法存入到仓库")
	elseif string.find(玩家数据[id].道具.数据[道具id].名称, "会员卡")~=nil then
	 	常规提示(id,"#Y/该物品无法存入到仓库")
	elseif 玩家数据[id].道具.数据[道具id].加锁 then
		常规提示(id,"#Y/该物品无法存入到仓库")
	elseif 玩家数据[id].道具.数据[道具id].不可交易 then
		常规提示(id,"#Y/该物品无法存入到仓库")
	elseif 玩家数据[id].道具.数据[道具id].总类=="跑商商品" then
	   常规提示(id,"#Y/该物品无法存入到仓库")
	elseif 玩家数据[id].道具.数据[道具id].总类==1001 then
	   常规提示(id,"#Y/该物品无法存入到仓库")
	elseif 玩家数据[id].道具.数据[道具id].数量 and 玩家数据[id].道具.数据[道具id].数量>999 then
	   常规提示(id,"#Y/该物品无法存入到仓库")
	elseif #self.数据[编号]>=20 then
		常规提示(id,"#Y/你这个仓库已经无法存放更多的物品了")
	else
		local 存入数据=DeepCopy(玩家数据[id].道具.数据[道具id])
		if 存入数据.数量 and tonumber(存入数据.数量) and 存入数据.数量~=math.floor(存入数据.数量) then
			常规提示(玩家数据[id].连接id,"#Y/改物品数据问题,无法存入")
			return
		end
        table.insert(self.数据[编号],存入数据)
        玩家数据[id].角色.数据[类型][背包id]=nil
        玩家数据[id].道具.数据[道具id]=nil
        道具刷新(id)
		发送数据(玩家数据[id].连接id,3513,玩家数据[id].道具:索要道具4(id,类型))
		发送数据(玩家数据[id].连接id,163,{道具=self:索取仓库数据(编号),页数=编号})
		发送数据(玩家数据[id].连接id,164)
		 for k,v in pairs(self.使用玩家) do
        	if 玩家数据[k]~=nil and k~=id then
        		发送数据(玩家数据[k].连接id,167,{道具=self:索取仓库数据(编号),页数=编号,类型="道具"})
        	end
        end








		存入数据={}
	end

end




function 共享仓库类:取出仓库(编号,类型,物品id,id)
	if 玩家数据[id].摊位数据~=nil then
		常规提示(id,"#Y/摆摊中无法操作仓库。")
		return
	end
	if 编号==nil or 物品id==nil or 编号<1 or 物品id<1 or 物品id>20 or 类型==nil  or self.数据==nil   or self.数据[编号]==nil or self.数据[编号][物品id]==nil then return end
     if 类型~="道具" and 类型~="行囊" then return end

     local 道具格子=玩家数据[id].角色:取道具格子1(类型)
	 if 道具格子==0 then
	    常规提示(id,"#Y/你身上的包裹没有足够的空间")
	 else

	 local 取出数据=DeepCopy(self.数据[编号][物品id])
	 table.remove(self.数据[编号],物品id)
     local 道具编号=玩家数据[id].道具:取新编号()
     玩家数据[id].道具.数据[道具编号]=DeepCopy(取出数据)
     玩家数据[id].道具.数据[道具编号].识别码= 取唯一识别码(id)
     if 取出数据.数量 and tonumber(取出数据.数量) then
	     玩家数据[id].道具.数据[道具编号].数量=math.floor(取出数据.数量)
	 end
     玩家数据[id].角色.数据[类型][道具格子]=道具编号
     道具刷新(id)
	 发送数据(玩家数据[id].连接id,3513,玩家数据[id].道具:索要道具4(id,类型))
	 发送数据(玩家数据[id].连接id,163,{道具=self:索取仓库数据(编号),页数=编号})
	 发送数据(玩家数据[id].连接id,164)
	  for k,v in pairs(self.使用玩家) do
          if 玩家数据[k]~=nil and k~=id then
        	 发送数据(玩家数据[k].连接id,167,{道具=self:索取仓库数据(编号),页数=编号,类型="道具"})
          end
      end



    取出数据={}
    end

end

-- function 共享仓库类:整理仓库(编号,类型,id)
-- 	if 编号==nil  or 编号<1 or 类型==nil  or self.数据==nil or self.数据[编号]==nil then return end
-- 	    local 整理数据= {}
-- 	    for k,v in pairs(self.数据[编号]) do
-- 		    	if v.数量~=nil and v.可叠加 and v.数量<999 then
-- 		    		for i,n in pairs(self.数据[编号])  do
-- 		    			if i~=k and n.数量~=nil and n.可叠加 and v.名称==n.名称 and v.数量+n.数量<999 then
-- 		    				if v.名称~="元宵" then
-- 		    				   if v.阶品==nil then
-- 		    				   	  v.数量=math.floor(v.数量+n.数量)
-- 		    				   	  self.数据[编号][i]=nil
-- 		    				   else
-- 		    				   	  if v.阶品==n.阶品 then
-- 		    				   	  	 v.数量=math.floor(v.数量+n.数量)
-- 		    				   	     self.数据[编号][i]=nil
-- 		    				   	  end
-- 		    				   end
-- 		    			     elseif v.名称== "元宵" and v.食材 == n.食材 then
-- 			    			     	v.数量=math.floor(v.数量+n.数量)
-- 			    				   	self.数据[编号][i]=nil
-- 		                    end
-- 		    			end
-- 		    		end
-- 		        end
-- 		        local 字符编码=string.byte(string.sub(v.名称,1,2))
-- 		        if #v.名称< 3 then
-- 		              字符编码=字符编码+string.byte(string.sub(v.名称,1,2))
-- 		        else
-- 		               字符编码=字符编码+string.byte(string.sub(v.名称,3,4))
-- 		        end
-- 		        if 自定义数据.背包整理配置 and 自定义数据.背包整理配置[v.名称] then
-- 	                字符编码=自定义数据.背包整理配置[v.名称]
-- 		        else
-- 			          字符编码=字符编码+#v.名称
-- 			          if v.总类==nil or type(v.总类)~="number" then
-- 			            字符编码=字符编码..9
-- 			          else
-- 			            字符编码=字符编码..v.总类
-- 			          end
-- 			          if v.分类==nil or type(v.分类)~="number" then
-- 			            字符编码=字符编码..9
-- 			          else
-- 			            字符编码=字符编码..v.分类
-- 			          end
-- 			          if v.子类==nil or type(v.子类)~="number" then
-- 			            字符编码=字符编码..9
-- 			          else
-- 			            字符编码=字符编码..v.子类
-- 			          end
-- 			    end
-- 		        字符编码=字符编码+0
-- 		        整理数据[#整理数据+1]={内容=v,序号=字符编码}
-- 		   end

--    table.sort(整理数据,function(a,b) return a.序号<b.序号 end )
--    local 排序列表={}
--     for k,v in pairs(整理数据) do
--         排序列表[#排序列表+1]=v.内容
--     end
--    self.数据[编号] = 排序列表
--    道具刷新(id)

--    发送数据(玩家数据[id].连接id,3513,玩家数据[id].道具:索要道具4(id,类型))
--    发送数据(玩家数据[id].连接id,163,{道具=self:索取仓库数据(编号),页数=编号})
--    发送数据(玩家数据[id].连接id,164)
--     for k,v in pairs(self.使用玩家) do
--         if 玩家数据[k]~=nil and k~=id then
--            发送数据(玩家数据[k].连接id,167,{道具=self:索取仓库数据(编号),页数=编号,类型="道具"})
--         end
--     end

--    常规提示(id,"整理成功")



-- end





function 共享仓库类:整理仓库(编号,类型,id)
		if 类型==nil then return end
		if os.time()-self.整理时间 <= 20 then
             常规提示(self.数字id,"不要频繁点击整理请"..(20-(os.time()-self.整理时间)).."秒后再尝试！",多角色)
            return
        end
	   	local 整理数据= {}
	    for i=1,#self.数据 do
	    	for k,n in ipairs(self.数据[i]) do
	    		table.insert(整理数据,n)
	    	end
	    	self.数据[i]={}
	    end
	    local 排序数据={}
		for k,v in pairs(整理数据) do
		    if v.数量~=nil and v.可叠加 and v.数量<=999 then
		    	for i,n in pairs(整理数据)  do
		    		if i~=k and n.数量~=nil and n.可叠加 and v.名称==n.名称 and v.数量+n.数量<=999 then
		    				if v.名称~="元宵" and v.名称~= "鸿蒙原石" and v.名称~= "太初原石" then
		    				   if v.阶品==nil then
		    				   	  v.数量=math.floor(v.数量+n.数量)
		    				   	  整理数据[i]=nil
		    				   else
		    				   	  if v.阶品==n.阶品 then
		    				   	  	 v.数量=math.floor(v.数量+n.数量)
		    				   	     整理数据[i]=nil
		    				   	  end
		    				   end
		    				 elseif v.名称== "鸿蒙原石" and v.附带词条 == n.附带词条 and v.数额 == n.数额 then
                              		v.数量=math.floor(v.数量+n.数量)
			    				   	整理数据[i]=nil
			    			 elseif v.名称== "太初原石" and v.附带词条 == n.附带词条  then
                              		v.数量=math.floor(v.数量+n.数量)
			    				   	整理数据[i]=nil
		    			     elseif v.名称== "元宵" and v.食材 == n.食材 then
			    			     	v.数量=math.floor(v.数量+n.数量)
			    				   	整理数据[i]=nil
		                    end
		    		end
		    	end
		    end
		    local 字符编码=string.byte(string.sub(v.名称,1,2))
		    if #v.名称< 3 then
		              字符编码=字符编码+string.byte(string.sub(v.名称,1,2))
		    else
		               字符编码=字符编码+string.byte(string.sub(v.名称,3,4))
		    end
		    if 自定义数据.背包整理配置 and 自定义数据.背包整理配置[v.名称] then
	                字符编码=自定义数据.背包整理配置[v.名称]
	        else
			          字符编码=字符编码+#v.名称+1000
			          if v.总类==nil or type(v.总类)~="number" then
			            字符编码=字符编码..9
			          else
			            字符编码=字符编码..v.总类
			          end
			          if v.分类==nil or type(v.分类)~="number" then
			            字符编码=字符编码..9
			          else
			            字符编码=字符编码..v.分类
			          end
			          if v.子类==nil or type(v.子类)~="number" then
			            字符编码=字符编码..9
			          else
			            字符编码=字符编码..v.子类
			          end
			end
		    字符编码=字符编码+0
		    table.insert(排序数据,{内容=v,序号=字符编码})
		end
   		table.sort(排序数据,function(a,b) return a.序号<b.序号 end )
        local num = 0
        local 页数 =1
	    for i,v in ipairs(排序数据) do
            if not self.数据[页数] then
            	break
            end
		    table.insert(self.数据[页数],v.内容)
		    num=num+1
		    if num==20 then
		    	num = 0
		    	页数=页数+1
		    end
	    end
	   self.整理时间=os.time()
	   道具刷新(id)
	   发送数据(玩家数据[id].连接id,3513,玩家数据[id].道具:索要道具4(id,类型))
	   发送数据(玩家数据[id].连接id,163,{道具=self:索取仓库数据(1),页数=1})
	   发送数据(玩家数据[id].连接id,164)
	    for k,v in pairs(self.使用玩家) do
	        if 玩家数据[k]~=nil and k~=id then
	           发送数据(玩家数据[k].连接id,167,{道具=self:索取仓库数据(1),页数=1,类型="道具"})
	        end
	    end
	   常规提示(self.数字id,"整理成功",多角色)



end

function 共享仓库类:索取仓库数据(仓库号)
	 self.发送数据={道具={}}
	if self.数据~=nil and self.数据[仓库号]~=nil then
		for i=1,20 do
			if self.数据[仓库号][i]~=nil then
			   self.发送数据.道具[i] = DeepCopy(self.数据[仓库号][i])
			 end
		end
	end
	return self.发送数据
end

function 共享仓库类:索取召唤兽仓库数据(仓库号)
	self.发送数据={}
	for n=1,7 do
	    if self.召唤兽~=nil and self.召唤兽[仓库号]~=nil and self.召唤兽[仓库号][n]~=nil then
	    	self.发送数据[n] = self.召唤兽[仓库号][n]
	    end
	end
	return self.发送数据
end



function 共享仓库类:存入召唤兽仓库(id,数据)
	if 玩家数据[id].摊位数据~=nil then
		常规提示(id,"#Y/摆摊中无法操作仓库。")
		return
	end
	if #self.召唤兽 < 数据.页数 or 数据.页数<1 then
		常规提示(id,"#Y/数据异常，请重新打开仓库。")
		return
	end
	if self.召唤兽[数据.页数]~=nil and #self.召唤兽[数据.页数] >=7 then
		常规提示(id,"#Y/一个仓库只能存放7只召唤兽。")
		return
	end
	local 是否存在 = false
	local 数据宝宝 = nil
	for k,v in pairs(玩家数据[id].召唤兽.数据) do
		if 数据.认证码 == v.认证码 then
			是否存在 = true
			数据宝宝 = k
		end
	end
	if 是否存在 and 数据宝宝~=nil and 玩家数据[id].召唤兽.数据[数据宝宝]~=nil then
		if 玩家数据[id].召唤兽.数据[数据宝宝].统御~=nil then
			常规提示(id,"#Y/统御的召唤兽无法放入仓库。")
		elseif 玩家数据[id].召唤兽:是否有装备(数据宝宝) then
            常规提示(id,"请先卸下召唤兽所穿戴的装备")
        elseif 玩家数据[id].召唤兽.数据[数据宝宝].参战信息~=nil then
         	常规提示(id,"#Y/参战的召唤兽无法放入仓库。")
        elseif 玩家数据[id].召唤兽.数据[数据宝宝].不可交易 then
         	常规提示(id,"#Y/参战的召唤兽无法放入仓库。")
        elseif 玩家数据[id].召唤兽.数据[数据宝宝].加锁 then
         	常规提示(id,"#Y/参战的召唤兽无法放入仓库。")


		else
		    self.召唤兽[数据.页数][#self.召唤兽[数据.页数]+1] = 玩家数据[id].召唤兽.数据[数据宝宝]
			table.remove(玩家数据[id].召唤兽.数据,数据宝宝)
			发送数据(玩家数据[id].连接id,163,{召唤兽仓库数据=self:索取召唤兽仓库数据(数据.页数),页数=数据.页数,宝宝列表=玩家数据[id].召唤兽.数据})
			for k,v in pairs(self.使用玩家) do
		        if 玩家数据[k]~=nil and k~=id then
		           发送数据(玩家数据[k].连接id,167,{召唤兽仓库数据=self:索取召唤兽仓库数据(数据.页数),页数=数据.页数,宝宝列表=玩家数据[k].召唤兽.数据,类型="召唤兽"})
		        end
		    end
			道具刷新(id)

		end

	else
	    常规提示(id,"#Y/数据异常，请重新打开仓库。")
		return
	end
end


function 共享仓库类:取出召唤兽仓库(id,数据)
	if 玩家数据[id].摊位数据~=nil then
		常规提示(id,"#Y/摆摊中无法操作仓库。")
		return
	end
	if #self.召唤兽 < 数据.页数 or 数据.页数<1 then
		常规提示(id,"#Y/数据异常，请重新打开仓库。")
		return
	end
	if 玩家数据[id].召唤兽:是否携带上限() then
		常规提示(id,"#Y/玩家只能携带"..玩家数据[id].角色.数据.携带宠物.."只宝宝。")
		return
	end
	local 是否存在 = false
	local 数据宝宝 = nil
	for k,v in pairs(self.召唤兽[数据.页数]) do
		if 数据.认证码 == v.认证码 then
			是否存在 = true
			数据宝宝 = k
		end
	end
	if 是否存在 and 数据宝宝~=nil then
		玩家数据[id].召唤兽.数据[#玩家数据[id].召唤兽.数据+1] = self.召唤兽[数据.页数][数据宝宝]
		table.remove(self.召唤兽[数据.页数],数据宝宝)
		发送数据(玩家数据[id].连接id,163,{召唤兽仓库数据=self:索取召唤兽仓库数据(数据.页数),页数=数据.页数,宝宝列表=玩家数据[id].召唤兽.数据})
		for k,v in pairs(self.使用玩家) do
		    if 玩家数据[k]~=nil and k~=id then
		        发送数据(玩家数据[k].连接id,167,{召唤兽仓库数据=self:索取召唤兽仓库数据(数据.页数),页数=数据.页数,宝宝列表=玩家数据[k].召唤兽.数据,类型="召唤兽"})
		    end
		 end
		道具刷新(id)
	else
	    常规提示(id,"#Y/数据异常，请重新打开仓库。")
		return
	end
end







return 共享仓库类



