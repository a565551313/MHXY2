
local 道具仓库类 = class()

function 道具仓库类:初始化()
    self.数据 = {}
    self.整理时间= 0
    self.数字id=0
end
function 道具仓库类:数据处理(内容)
	if 内容.文本=="打开仓库" then
		发送数据(玩家数据[self.数字id].连接id,3513,玩家数据[self.数字id].道具:索要道具4(self.数字id,"道具"))
		发送数据(玩家数据[self.数字id].连接id,3523,{道具=self:索取仓库数据(1),仓库总数=#self.数据,召唤兽总数=#玩家数据[self.数字id].召唤兽仓库.数据})
   elseif 内容.文本=="获取道具" then
	    发送数据(玩家数据[self.数字id].连接id,3513,玩家数据[self.数字id].道具:索要道具4(self.数字id,内容.道具类型))
	    发送数据(玩家数据[self.数字id].连接id,3525)
   elseif 内容.文本=="道具仓库" then
	    if 内容.序列>#self.数据 then
	      常规提示(self.数字id,"#Y/这已经是最后一页了")
	      return
	    elseif 内容.序列<1 then
	      return
	    end
	    发送数据(玩家数据[self.数字id].连接id,3524,{道具=self:索取仓库数据(内容.序列),页数=内容.序列})
   elseif 内容.文本=="整理仓库" then
   	     -- if 内容.页数~=nil and 内容.页数>=1 and 内容.道具类型~=nil then
   	     -- 	self:整理仓库(内容.页数,内容.道具类型)
   	     -- end

   	     if 内容.道具类型~=nil then
   	     	  self:整理仓库(内容.页数,内容.道具类型)
   	     end
     elseif 内容.文本=="存入仓库" then
     	    self.存入数据={}
     	    if 内容.页数~=nil and 内容.页数>=1 and 内容.类型~=nil and 内容.物品~=nil and
     	       玩家数据[self.数字id].角色.数据[内容.类型][内容.物品]~=nil and
     	       玩家数据[self.数字id].道具.数据[玩家数据[self.数字id].角色.数据[内容.类型][内容.物品]]~=nil then
               self:存入仓库(内容.页数,内容.类型,内容.物品)
            end
      elseif 内容.文本=="取出物品" then
     	    self.取出数据={}
     	    if 内容.页数~=nil and 内容.页数>=1 and 内容.类型~=nil and 内容.物品~=nil and
     	       self.数据[内容.页数]~=nil and self.数据[内容.页数][内容.物品]~=nil then
               self:取出仓库(内容.页数,内容.类型,内容.物品)
            end


	end
end


function 道具仓库类:加载数据(账号,数字id)
	self.数字id=数字id
	if f函数.文件是否存在([[data/]]..账号..[[/]]..数字id..[[/道具仓库.txt]])==false then
		self.数据 = {[1]={},[2]={},[3]={}}
		写出文件([[data/]]..账号..[[/]]..数字id..[[/道具仓库.txt]],table.tostring(self.数据))
	else
	    self.数据=table.loadstring(读入文件([[data/]]..账号..[[/]]..数字id..[[/道具仓库.txt]]))
	end

end



function 道具仓库类:存入仓库(编号,类型,背包id,多角色)
	if 玩家数据[self.数字id].摊位数据~=nil then
		常规提示(self.数字id,"#Y/摆摊中无法操作仓库。",多角色)
		return
	end
	if 编号==nil or 编号<1 or 类型==nil  or self.数据==nil or self.数据[编号]==nil then return end
	if 类型~="道具" and 类型~="行囊" then return end
	if 玩家数据[self.数字id].角色.数据[类型][背包id]==nil then return end
	local 道具id = 玩家数据[self.数字id].角色.数据[类型][背包id]
	if 玩家数据[self.数字id].道具.数据[道具id]==nil then return end
	if 玩家数据[self.数字id].道具.数据[道具id].名称=="帮派银票" then
	   常规提示(self.数字id,"#Y/该物品无法存入到仓库",多角色)
	elseif string.find(玩家数据[self.数字id].道具.数据[道具id].名称, "会员卡")~=nil then
	 	常规提示(self.数字id,"#Y/该物品无法存入到仓库",多角色)
	elseif 玩家数据[self.数字id].道具.数据[道具id].总类=="跑商商品" then
	   常规提示(self.数字id,"#Y/该物品无法存入到仓库",多角色)
	elseif 玩家数据[self.数字id].道具.数据[道具id].总类==1001 then
	   常规提示(self.数字id,"#Y/该物品无法存入到仓库",多角色)
	elseif 玩家数据[self.数字id].道具.数据[道具id].数量 and 玩家数据[self.数字id].道具.数据[道具id].数量>999 then
	   常规提示(self.数字id,"#Y/该物品无法存入到仓库",多角色)
	elseif #self.数据[编号]>=20 then
		常规提示(self.数字id,"#Y/你这个仓库已经无法存放更多的物品了",多角色)
	else
		local 存入数据 = DeepCopy(玩家数据[self.数字id].道具.数据[道具id])
		if 存入数据.数量 and tonumber(存入数据.数量) and 存入数据.数量~=math.floor(存入数据.数量) then
			常规提示(self.数字id,"#Y/改物品数据问题,无法存入",多角色)
			return
		end
        table.insert(self.数据[编号],存入数据)
        玩家数据[self.数字id].角色.数据[类型][背包id]=nil
        玩家数据[self.数字id].道具.数据[道具id]=nil
        道具刷新(self.数字id,多角色)
        if 多角色~=nil then
		   	发送数据(玩家数据[多角色].连接id,6019,{角色=self.数字id,道具=玩家数据[self.数字id].道具:索要道具4(self.数字id,类型)})--3513
		   	发送数据(玩家数据[多角色].连接id,6021,{角色=self.数字id,道具=self:索取仓库数据(编号),页数=编号})--3524
		   	发送数据(玩家数据[多角色].连接id,6020,{角色=self.数字id})--3525
		 else
		    发送数据(玩家数据[self.数字id].连接id,3513,玩家数据[self.数字id].道具:索要道具4(self.数字id,类型))
			发送数据(玩家数据[self.数字id].连接id,3524,{道具=self:索取仓库数据(编号),页数=编号})
			发送数据(玩家数据[self.数字id].连接id,3525)
		 end
		存入数据={}
	end

end




function 道具仓库类:取出仓库(编号,类型,物品id,多角色)
	if 玩家数据[self.数字id].摊位数据~=nil then
		常规提示(self.数字id,"#Y/摆摊中无法操作仓库。",多角色)
		return
	end
	if 编号==nil or 物品id==nil or 编号<1 or 物品id<1 or 物品id>20 or 类型==nil  or self.数据==nil   or self.数据[编号]==nil or self.数据[编号][物品id]==nil then return end
    if 类型~="道具" and 类型~="行囊" then return end
     local 道具格子=玩家数据[self.数字id].角色:取道具格子1(类型)
	 if 道具格子==0 then
	    常规提示(self.数字id,"#Y/你身上的包裹没有足够的空间",多角色)
	 else

	 local 取出数据 = DeepCopy(self.数据[编号][物品id])
	 table.remove(self.数据[编号],物品id)
     local 道具编号=玩家数据[self.数字id].道具:取新编号()
     玩家数据[self.数字id].道具.数据[道具编号]=DeepCopy(取出数据)
     玩家数据[self.数字id].道具.数据[道具编号].识别码= 取唯一识别码(self.数字id)
     if 取出数据.数量 and tonumber(取出数据.数量) then
	     玩家数据[self.数字id].道具.数据[道具编号].数量 = math.floor(取出数据.数量)
	 end
     玩家数据[self.数字id].角色.数据[类型][道具格子]=道具编号
     道具刷新(self.数字id,多角色)
     if 多角色~=nil then
	    发送数据(玩家数据[多角色].连接id,6019,{角色=self.数字id,道具=玩家数据[self.数字id].道具:索要道具4(self.数字id,类型)})--3513
	   	发送数据(玩家数据[多角色].连接id,6021,{角色=self.数字id,道具=self:索取仓库数据(编号),页数=编号})--3524
	   	发送数据(玩家数据[多角色].连接id,6020,{角色=self.数字id})--3525
	 else
	    发送数据(玩家数据[self.数字id].连接id,3513,玩家数据[self.数字id].道具:索要道具4(self.数字id,类型))
		发送数据(玩家数据[self.数字id].连接id,3524,{道具=self:索取仓库数据(编号),页数=编号})
		发送数据(玩家数据[self.数字id].连接id,3525)
	 end
     取出数据={}
    end

end

-- function 道具仓库类:整理仓库(编号,类型,多角色)
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
-- 	            else
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
-- 			     end
-- 		         字符编码=字符编码+0
-- 		         整理数据[#整理数据+1]={内容=v,序号=字符编码}
-- 		   end

--    table.sort(整理数据,function(a,b) return a.序号<b.序号 end )
--    local 排序列表={}
--     for k,v in pairs(整理数据) do
--         排序列表[#排序列表+1]=v.内容
--     end
--    self.数据[编号] = 排序列表
--    道具刷新(self.数字id,多角色)
--    if 多角色~=nil then
-- 	   	发送数据(玩家数据[多角色].连接id,6019,{角色=self.数字id,道具=玩家数据[self.数字id].道具:索要道具4(self.数字id,类型)})--3513
-- 	   	发送数据(玩家数据[多角色].连接id,6021,{角色=self.数字id,道具=self:索取仓库数据(编号),页数=编号})--3524
-- 	   	发送数据(玩家数据[多角色].连接id,6020,{角色=self.数字id})--3525
--    else
--       发送数据(玩家数据[self.数字id].连接id,3513,玩家数据[self.数字id].道具:索要道具4(self.数字id,类型))
-- 	  发送数据(玩家数据[self.数字id].连接id,3524,{道具=self:索取仓库数据(编号),页数=编号})
-- 	  发送数据(玩家数据[self.数字id].连接id,3525)
--    end

--    常规提示(self.数字id,"整理成功",多角色)



-- end


function 道具仓库类:整理仓库(编号,类型,多角色)
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
		    				if v.名称~="元宵" and v.名称~="鸿蒙原石" and v.名称~="太初原石" then
		    				   if v.阶品==nil then
		    				   	  v.数量=math.floor(v.数量+n.数量)
		    				   	  整理数据[i]=nil
		    				   else
		    				   	  if v.阶品==n.阶品 then
		    				   	  	 v.数量=math.floor(v.数量+n.数量)
		    				   	     整理数据[i]=nil
		    				   	  end
		    				   end
                             elseif v.名称== "鸿蒙原石"  and v.附带词条 == n.附带词条 and v.数额 == n.数额  then
                              		v.数量=math.floor(v.数量+n.数量)
			    				   	整理数据[i]=nil
			    			 elseif  v.名称== "太初原石" and v.附带词条 == n.附带词条 then
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
	   道具刷新(self.数字id,多角色)
	   if 多角色~=nil then
		   	发送数据(玩家数据[多角色].连接id,6019,{角色=self.数字id,道具=玩家数据[self.数字id].道具:索要道具4(self.数字id,类型)})--3513
		   	发送数据(玩家数据[多角色].连接id,6021,{角色=self.数字id,道具=self:索取仓库数据(1),页数=1})--3524
		   	发送数据(玩家数据[多角色].连接id,6020,{角色=self.数字id})--3525
	   else
	      发送数据(玩家数据[self.数字id].连接id,3513,玩家数据[self.数字id].道具:索要道具4(self.数字id,类型))
		  发送数据(玩家数据[self.数字id].连接id,3524,{道具=self:索取仓库数据(1),页数=1})
		  发送数据(玩家数据[self.数字id].连接id,3525)
	   end

	   常规提示(self.数字id,"整理成功",多角色)



end

function 道具仓库类:索取仓库数据(仓库号)
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

function 道具仓库类:取存入格子()
		local 页数 = 0
		for i,v in ipairs(self.数据) do
			if #v < 20 then
				页数=i
				break
			end
		end
		if 页数~=0 then
			return 页数,#self.数据[页数]+1
		else
			return 0,0
		end

end

function 道具仓库类:取剩余格子数量()
		local 数量 = 0
		for i,v in ipairs(self.数据) do
			for n=1,20 do
				if v[n]==nil then
					数量=数量+1
				end
			end
		end
		return 数量
end



return 道具仓库类



