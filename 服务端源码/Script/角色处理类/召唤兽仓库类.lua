
local 召唤兽仓库类 = class()

function 召唤兽仓库类:初始化()
    self.数据 = {}
end
function 召唤兽仓库类:数据处理(连接id,序号,id,内容)
	if 序号==7001 then
		if 内容.序列 > #玩家数据[id].召唤兽仓库.数据 then
			常规提示(id,"#Y/这已经是最后一页了")
			return
		elseif 内容.序列<1 then
			return
		end
		发送数据(玩家数据[id].连接id,3524,{召唤兽仓库数据=self:索取召唤兽仓库数据(id,内容.序列),页数=内容.序列,宝宝列表=玩家数据[id].召唤兽.数据})
	elseif 序号==7002 then
		local 对话=[[增加召唤兽仓库数量需要支付20点仙玉，每增加一间仓库将额外消耗（已增加仓库数量*20）点仙玉。本次增加仓库需要消耗#R]]..((#玩家数据[id].召唤兽仓库.数据-1)*20+20).."#W点仙玉，你是否需要进行购买仓库操作？"
		发送数据(玩家数据[id].连接id,1501,{名称=玩家数据[id].角色.名称,模型=玩家数据[id].角色.模型,对话=对话,选项={"确定购买召唤兽仓库","让我再想想"}})
	elseif 序号==7003 then
		self:存入召唤兽仓库(id,内容)
	elseif 序号==7004 then
		self:取出召唤兽仓库(id,内容)
	end
end

function 召唤兽仓库类:加载数据(账号,数字id)
	self.数字id=数字id
	if f函数.文件是否存在([[data/]]..账号..[[/]]..数字id..[[/召唤兽仓库.txt]])==false then
		self.数据 = {[1]={}}
		写出文件([[data/]]..账号..[[/]]..数字id..[[/召唤兽仓库.txt]],table.tostring(self.数据))
	else
	    self.数据=table.loadstring(读入文件([[data/]]..账号..[[/]]..数字id..[[/召唤兽仓库.txt]]))
	end
end

function 召唤兽仓库类:存入召唤兽仓库(id,数据,多角色)
	if 玩家数据[id].摊位数据~=nil then
		常规提示(id,"#Y/摆摊中无法操作仓库。",多角色)
		return
	end
	if #self.数据 < 数据.页数 or 数据.页数<1 then
		常规提示(id,"#Y/数据异常，请重新打开仓库。",多角色)
		return
	end
	if self.数据[数据.页数]~=nil and #self.数据[数据.页数] >=7 then
		常规提示(id,"#Y/一个仓库只能存放7只召唤兽。",多角色)
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
			常规提示(id,"#Y/统御的召唤兽无法放入仓库。",多角色)
		elseif 玩家数据[id].召唤兽:是否有装备(数据宝宝) then
            常规提示(id,"请先卸下召唤兽所穿戴的装备",多角色)
        elseif 玩家数据[id].召唤兽.数据[数据宝宝].参战信息~=nil then
         	常规提示(id,"#Y/参战的召唤兽无法放入仓库。")
		else
		    self.数据[数据.页数][#self.数据[数据.页数]+1] = 玩家数据[id].召唤兽.数据[数据宝宝]
			table.remove(玩家数据[id].召唤兽.数据,数据宝宝)
			if 多角色~=nil then
				发送数据(玩家数据[多角色].连接id,6021,{角色=id,召唤兽仓库数据=self:索取召唤兽仓库数据(id,数据.页数),页数=数据.页数,宝宝列表=玩家数据[id].召唤兽.数据})--3524
			else
			    发送数据(玩家数据[id].连接id,3524,{召唤兽仓库数据=self:索取召唤兽仓库数据(id,数据.页数),页数=数据.页数,宝宝列表=玩家数据[id].召唤兽.数据})
			end
			道具刷新(id,多角色)

		end

	else
	    常规提示(id,"#Y/数据异常，请重新打开仓库。",多角色)
		return
	end
end

function 召唤兽仓库类:取出召唤兽仓库(id,数据,多角色)
	if 玩家数据[id].摊位数据~=nil then
		常规提示(id,"#Y/摆摊中无法操作仓库。",多角色)
		return
	end
	if #self.数据 < 数据.页数 or 数据.页数<1 then
		常规提示(id,"#Y/数据异常，请重新打开仓库。",多角色)
		return
	end
	if 玩家数据[id].召唤兽:是否携带上限() then
		常规提示(id,"#Y/玩家只能携带"..玩家数据[id].角色.数据.携带宠物.."只宝宝。",多角色)
		return
	end
	local 是否存在 = false
	local 数据宝宝 = nil
	for k,v in pairs(self.数据[数据.页数]) do
		if 数据.认证码 == v.认证码 then
			是否存在 = true
			数据宝宝 = k
		end
	end
	if 是否存在 and 数据宝宝~=nil then
		玩家数据[id].召唤兽.数据[#玩家数据[id].召唤兽.数据+1] = self.数据[数据.页数][数据宝宝]
		table.remove(self.数据[数据.页数],数据宝宝)
		if 多角色~=nil then
		   发送数据(玩家数据[多角色].连接id,6021,{角色=id,召唤兽仓库数据=self:索取召唤兽仓库数据(id,数据.页数),页数=数据.页数,宝宝列表=玩家数据[id].召唤兽.数据})--3524
		else
		   发送数据(玩家数据[id].连接id,3524,{召唤兽仓库数据=self:索取召唤兽仓库数据(id,数据.页数),页数=数据.页数,宝宝列表=玩家数据[id].召唤兽.数据})
		end
		道具刷新(id,多角色)
	else
	    常规提示(id,"#Y/数据异常，请重新打开仓库。",多角色)
		return
	end
end

function 召唤兽仓库类:索取召唤兽仓库数据(id,仓库号)
	self.发送数据={}
	for n=1,7 do
	    if self.数据~=nil and self.数据[仓库号]~=nil and self.数据[仓库号][n]~=nil then
	    	self.发送数据[n] = self.数据[仓库号][n]
	    end
	end
	return self.发送数据
end



return 召唤兽仓库类