--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-06-05 01:47:43
--======================================================================--
local 系统类_人物框 = class()

local floor = math.floor
local ceil = math.ceil
local 矩阵 = require("gge包围盒")(0,0,115,95)
local tp
local insert = table.insert
local remove = table.remove
local mouseb = 引擎.鼠标弹起
local format = string.format
local tx = 引擎.取头像
local min = math.min
local 按钮 = require("script/系统类/按钮")
local 矩阵 = require("gge包围盒")(全局游戏宽度-230,1,228,50)
local qwp = 引擎.取物品功效

function 系统类_人物框:初始化(根)
	tp = 根
	local 资源 = 根.资源
	self.背景 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x2E8758EE)
	self.气血 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xAAD44583)
	self.魔法 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xCE4D3C2D)
	self.经验 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x7B3C08E4)
	self.愤怒 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xBAF8009F)
	self.气血底图 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x008C2611)
	self.人物血条=资源:载入('登陆资源.wdf',"网易WDF动画",0X2E8758EE)
	self.人物蓝条=资源:载入('登陆资源.wdf',"网易WDF动画",0X2E8758EE)
	self.人物怒条=资源:载入('登陆资源.wdf',"网易WDF动画",0X2E8758EE)
	self.人物经条=资源:载入('登陆资源.wdf',"网易WDF动画",0X2E8758EE)
	--=================================
    self.bb血条=资源:载入('登陆资源.wdf',"网易WDF动画",0X2E8758EE)
	self.bb蓝条=资源:载入('登陆资源.wdf',"网易WDF动画",0X2E8758EE)
	self.bb经条=资源:载入('登陆资源.wdf',"网易WDF动画",0X2E8758EE)

	self.记忆角色 = {}
	self.人物头像背景 = {}
	self.小图标 = {}
	self.焦点 = false
	self.队伍头像={}
	self.计次=0
end

-- function 系统类_人物框:加入小图标信息(方式,提示信息,变量)
-- 	for n=1,#self.图标组 do
-- 		if self.图标组[n][4] == 方式 then
-- 			return
-- 		end
-- 	end
-- 	insert(self.图标组,{self.小图标[方式],提示信息,变量,方式})
-- end

-- function 系统类_人物框:删除小图标信息(方式)
-- 	for n=1,#self.图标组 do
-- 		if self.图标组[n][4] == 方式 then
-- 			remove(self.图标组,n)
-- 			break
-- 		end
-- 	end
-- end


function 系统类_人物框:取图标(tx)
	local n={}
	if tx == "双倍时间" then
		n[1]=0x24901650
		n[2]="登陆资源.wdf"
	 elseif tx == "精修时间" then
		n[1]=0x09E2B01B
	 	n[2]="登陆资源.wdf"
	 elseif tx == "罗羹效果" then
	 	n[1]=0xAC4486C4
	    n[2]="登陆资源.wdf"
	 elseif tx == "摄妖香" then
	 	n[1]=0x397B8CF6
	 	n[2]="登陆资源.wdf"
    elseif tx == "变身卡" then
	 	n[1]=0x397B8CF6
		n[2]="登陆资源.wdf"
	elseif tx == "离线储备加成" then
		n[1]=0x09E2B01B
	 	n[2]="登陆资源.wdf"
	 elseif tx == "离线经验加成" then
		n[1]=0x09E2B01B
	 	n[2]="登陆资源.wdf"
	 -- elseif tx == "助战变身卡" then
		-- n[1]=0x397B8CF6
	 -- 	n[2]="登陆资源.wdf"
	end
	return n
end

function 系统类_人物框:显示(dt,x,y)
	self.焦点 = false
	if tp.队伍[1] ~= nil then
		if tp.队伍[1].最大经验 < 0 then
			tp.队伍[1].最大经验 = tp:取经验(1,tp.队伍[1].等级)
		end
		if tp.队伍[1].当前经验 < 0 then
			tp.队伍[1].当前经验 = tp.队伍[1].最大经验
		end
		if tp.队伍[1].参战宝宝.名称 ~= nil then
			if tp.队伍[1].参战宝宝.最大经验 < 0 then
				tp.队伍[1].参战宝宝.最大经验 = tp:取经验(2,tp.队伍[1].参战宝宝.等级)
			end
			if tp.队伍[1].参战宝宝.当前经验 < 0 then
				tp.队伍[1].参战宝宝.当前经验 = tp.队伍[1].参战宝宝.最大经验
			end
		end
	end
	if self.计次时间 and os.time()-self.计次时间>=1 then
		self.计次= 0
		self.计次时间 = nil
	end

	if #tp.队伍数据 >= 1 and not tp.战斗中 then
		for i=1,#tp.队伍数据 do
			if self.记忆角色[i+1] == nil or self.记忆角色[i+1] ~= tp.队伍数据[i].模型 then
				local x = tx(tp.队伍数据[i].模型)
				self.人物头像背景[i+1] = 按钮(tp.资源:载入(x[7],"网易WDF动画",x[2]),0,0,1)
				self.记忆角色[i+1] = tp.队伍数据[i].模型
			end
			tp.人物头像背景_:显示(全局游戏宽度-245-i*51,2)
			self.人物头像背景[i+1]:更新(x,y)
			self.人物头像背景[i+1]:显示(全局游戏宽度-245-i*51+3,5,true)
			if self.人物头像背景[i+1]:是否选中(x,y) then
				self.焦点 = true
				tp.提示:自定义(x-62,y+10,"#Y名称:#W"..tp.队伍数据[i].名称.."\n#YID  :#W"..tp.队伍数据[i].id.."\n#Y等级:#W"..tp.队伍数据[i].等级.."级\n#Y门派:#W"..tp.队伍数据[i].门派)
			end
			if self.人物头像背景[i+1]:事件判断() and tp.队伍数据[i].id ~= tp.队伍[1].数字id and not tp.战斗中 then
				if 多角色操作 then
				 	self.计次=self.计次+1
				 	self.计次时间 = os.time()
					if self.计次>=2 then
					   self.计次 = 0
				       请求服务(63,{参数=tp.队伍数据[i].id,文本="切换角色"})
				    end
				end
				if tp.鼠标.取当前()=="给予" then
		           	人物点击=true
		            请求服务(3716,{id=tp.队伍数据[i].id})
		            tp.鼠标.还原鼠标()
	           	elseif tp.鼠标.取当前()=="交易" then
		           	人物点击=true
		            请求服务(3718,{id=tp.队伍数据[i].id})
		            tp.鼠标.还原鼠标()
	            end
			end

		end
	end
	if 引擎.按键按住(KEY.ALT)  and not tp.战斗中 and 多角色操作 and not tp.窗口.多开系统.可视 then
		if 引擎.按键按下(KEY._2) and tp.队伍数据[2] and tp.队伍数据[2].id~=tp.队伍[1].数字id then
				请求服务(63,{参数=tp.队伍数据[2].id,文本="切换角色"})
		elseif 引擎.按键按下(KEY._3) and tp.队伍数据[3] and tp.队伍数据[3].id~=tp.队伍[1].数字id then
				请求服务(63,{参数=tp.队伍数据[3].id,文本="切换角色"})
		elseif 引擎.按键按下(KEY._4) and tp.队伍数据[4] and tp.队伍数据[4].id~=tp.队伍[1].数字id then
				请求服务(63,{参数=tp.队伍数据[4].id,文本="切换角色"})
		elseif 引擎.按键按下(KEY._5) and tp.队伍数据[5] and tp.队伍数据[5].id~=tp.队伍[1].数字id then
				请求服务(63,{参数=tp.队伍数据[5].id,文本="切换角色"})
		end
	end
	if self.记忆角色[1] ~= tp.队伍[1].模型 then
		local s = tx(tp.队伍[1].模型)
		self.人物头像背景[1] = 按钮(tp.资源:载入(s[7],"网易WDF动画",s[2]),0,0,1)
		self.记忆角色[1] = tp.队伍[1].模型
		s = nil
	end
	tp.人物头像背景_:显示(全局游戏宽度-120,0)
	self.背景:显示(全局游戏宽度-68,0)
	self.背景:显示(全局游戏宽度-68,13)
	self.背景:显示(全局游戏宽度-68,26)
	self.背景:显示(全局游戏宽度-68,39)
	self.气血底图:置区域(0,0,min(floor(tp.队伍[1].气血上限 / tp.队伍[1].最大气血 * 50),50),8)
	self.气血:置区域(0,0,min(floor(tp.队伍[1].气血 / tp.队伍[1].最大气血 * 50),50),8)
	self.魔法:置区域(0,0,min(floor(tp.队伍[1].魔法 / tp.队伍[1].最大魔法 * 50),50),8)
	self.愤怒:置区域(0,0,min(floor(tp.队伍[1].愤怒 / 150 * 50),50),8)
	self.经验:置区域(0,0,min(floor(tp.队伍[1].当前经验 / tp.队伍[1].最大经验 * 50),50),8)
	if self.人物头像背景[1]:是否选中(x,y) then
		tp.提示:自定义(x-42,y+27,"快捷键:ALT+W")--########################################################?自己修改?##########################################
	end
	self.人物头像背景[1]:更新(x,y)
	if self.人物头像背景[1]:事件判断() then
		if tp.窗口.人物状态栏.可视==false then
			请求服务(7)
			tp.窗口.人物状态栏:打开()
		else
			tp.窗口.人物状态栏:打开()
		end
	end
	self.人物头像背景[1]:显示(全局游戏宽度-117,3,true)
	self.人物血条:显示(全局游戏宽度-56-12,0)
	self.人物蓝条:显示(全局游戏宽度-56-12,13)
	self.人物怒条:显示(全局游戏宽度-56-12,26)
	self.人物经条:显示(全局游戏宽度-56-12,39)
	self.气血底图:显示(全局游戏宽度-56,3)
	self.气血:显示(全局游戏宽度-56,3)
	self.魔法:显示(全局游戏宽度-56,16)
	self.愤怒:显示(全局游戏宽度-56,29)
	self.经验:显示(全局游戏宽度-56,42)
	if self.人物血条:是否选中(x,y) and not tp.选中UI then
		tp.提示:自定义(x-42,y+27,format("#Y/气血：%d/%d/%d",tp.队伍[1].气血,tp.队伍[1].气血上限,tp.队伍[1].最大气血))
		if mouseb(1) and not tp.战斗中 and not tp.消息栏焦点 then
			请求服务(3727,{类型=1})
			--self:快捷吃药(1)
		end
	elseif self.人物蓝条:是否选中(x,y) and not tp.选中UI then
		tp.提示:自定义(x-42,y+27,format("#Y/魔法：%d/%d",tp.队伍[1].魔法,tp.队伍[1].最大魔法))
		if mouseb(1) and not tp.战斗中 and not tp.消息栏焦点 then
			请求服务(3728,{类型=1})
		end
	elseif self.人物怒条:是否选中(x,y) and not tp.选中UI then
		tp.提示:自定义(x-42,y+27,format("#Y/愤怒：%d/150",tp.队伍[1].愤怒))
	elseif self.人物经条:是否选中(x,y) and not tp.选中UI then
		tp.提示:自定义(x-42,y+27,format("#Y/经验：%d/%d",tp.队伍[1].当前经验,tp.队伍[1].最大经验))
	end
	local xx = 0
	local yy = 0
	local 记录 = 1
	self.小图标={}
	if #tp.窗口.任务追踪栏.数据记录 > 0 then
		for i=1,#tp.窗口.任务追踪栏.数据记录 do
			local 名称=tp.窗口.任务追踪栏.数据记录[i].名称
			local 资源=tp.窗口.人物框:取图标(名称)
			if 资源[1]~=nil then
				-- print(名称,全局游戏宽度-148+xx*30,58+yy)
				self.小图标[i]=tp.资源:载入(资源[2],"网易WDF动画",资源[1])
				self.小图标[i]:显示(全局游戏宽度-148+xx,58+yy)
				if  self.小图标[i]:是否选中(x,y) and not tp.选中UI then
					tp.提示:自定义(x-42,y+27,format("#Y/%s\n%s",tp.窗口.任务追踪栏.数据记录[i].名称,string.gsub(tp.窗口.任务追踪栏.数据记录[i].介绍,"L","B")))
				end
				xx=xx+28
		    	if 记录%4==0 then
					xx=0
					yy=yy+28
				end
				记录=记录+1
		    end
		end
	end
	tp.宠物头像背景_:显示(全局游戏宽度-230,0)
	self.背景:显示(全局游戏宽度-190,0)
	self.背景:显示(全局游戏宽度-190,13)
	self.背景:显示(全局游戏宽度-190,26)
	local cz = tp.队伍[1].参战宝宝
	if cz.名称 ~= nil then
		if self.记忆角色[7] ~= cz.模型 then
			local n = tx(cz.模型)
			self.宝宝头像背景 = 按钮(tp.资源:载入(n[7],"网易WDF动画",n[1]),0,0,1)
			self.记忆角色[7] = cz.模型
		end
		-- if cz.当前经验 >= cz.最大经验 and cz.等级 <= tp.队伍[1].等级+5 then
		-- 	cz:升级()
		-- end
		self.气血:置区域(0,0,min(floor(cz.气血 / cz.最大气血 * 50),50),8)
		-- self.气血底图:置区域(0,0,min(floor(cz.气血上限 / cz.最大气血 * 50),50),8)
		self.魔法:置区域(0,0,min(floor(cz.魔法 / cz.最大魔法 * 50),50),8)
		self.经验:置区域(0,0,min(floor(cz.当前经验 / cz.最大经验 * 50),50),8)
		self.气血底图:显示(全局游戏宽度-178,3)
		 self.bb血条:显示(全局游戏宽度-178-12,0)
	     self.bb蓝条:显示(全局游戏宽度-178-12,13)
	     self.bb经条:显示(全局游戏宽度-178-12,26)
		self.气血:显示(全局游戏宽度-178,3)
		self.魔法:显示(全局游戏宽度-178,16)
		self.经验:显示(全局游戏宽度-178,29)
		if self.bb血条:是否选中(x,y) and not tp.选中UI then
			tp.提示:自定义(x-42,y+27,format("#Y/气血：%d/%d",cz.气血,cz.最大气血))
			if mouseb(1) and not tp.战斗中 and not tp.消息栏焦点 then
				--self:快捷吃药(1)
				请求服务(3727,{类型=2})
			end
		elseif self.bb蓝条:是否选中(x,y) and not tp.选中UI then
			tp.提示:自定义(x-42,y+27,format("#Y/魔法：%d/%d",cz.魔法,cz.最大魔法))
			if mouseb(1) and not tp.战斗中 and not tp.消息栏焦点 then

			 请求服务(3728,{类型=2})
			end
		elseif self.bb经条:是否选中(x,y) and not tp.选中UI then
			tp.提示:自定义(x-42,y+27,format("#Y/经验：%d/%d",cz.当前经验,cz.最大经验))
		end
	else
		if self.记忆角色[7] ~= false then
			self.宝宝头像背景 = 按钮(tp.资源:载入("登陆资源.wdf","网易WDF动画",0xCEC838D7),0,0,1)
			self.记忆角色[7] = false
		end
	end
	self.宝宝头像背景:更新(x,y)
	if self.宝宝头像背景:事件判断() and not tp.战斗中 then
		请求服务(5001)
	end
	if self.宝宝头像背景:是否选中(x,y) then
		tp.提示:自定义(x-42,y+27,"快捷键:ALT+R")--########################################################?自己修改?##########################################
	end
	self.宝宝头像背景:显示(全局游戏宽度-227,3,true)

end


function 系统类_人物框:快捷吃药(方式)

	if 1==1 then return  end
	local qs = 取指定物品数量
	local sq = 物品失去
	if 方式 == 1 then
		if tp.队伍[1].气血 == tp.队伍[1].最大气血 then
			return
		end
		local js = tp.队伍[1].最大气血 - tp.队伍[1].气血
		local 优先 = {"包子"}
		local 次优先 = {"四叶花"}
		local 次2优先 = {"熊胆","血色茶花","天青地白","天不老","紫石英","鹿茸","六道轮回","凤凰尾","硫磺草","龙之心屑","火凤之睛"}
		local 次3优先 = {"金创药","金香玉","小还丹","千年保心丹"}
		-- 先算出最大需要多少，在算出目前有多少，如果大于则吃完，小于则吃完当前的
		for i=1,#优先 do
			local sl = qs(优先[i])
			if sl > 0 then
				local bc = qwp(优先[i])
				local zd = ceil(js/bc.气血)
				if sl >= zd then
				   local zz = bc.气血 * zd
				   tp.队伍[1].气血 = min(tp.队伍[1].气血 + zz,tp.队伍[1].最大气血)
				   sq(优先[i],zd)
				else
				   local zz = bc.气血 * sl
				   tp.队伍[1].气血 = min(tp.队伍[1].气血 + zz,tp.队伍[1].最大气血)
				   sq(优先[i],sl)
				end
			end
			if tp.队伍[1].气血 == tp.队伍[1].最大气血 then
				return
			end
		end
		for i=1,#次优先 do
			local sl = qs(次优先[i])
			if sl > 0 then
				local bc = qwp(次优先[i])
				local zd = ceil(js/bc.气血)
				if sl >= zd then
				   local zz = bc.气血 * zd
				   tp.队伍[1].气血 = min(tp.队伍[1].气血 + zz,tp.队伍[1].最大气血)
				   sq(次优先[i],zd)
				else
				   local zz = bc.气血 * sl
				   tp.队伍[1].气血 = min(tp.队伍[1].气血 + zz,tp.队伍[1].最大气血)
				   sq(次优先[i],sl)
				end
			end
			if tp.队伍[1].气血 == tp.队伍[1].最大气血 then
				return
			end
		end
		for i=1,#次2优先 do
			local sl = qs(次2优先[i])
			if sl > 0 then
				local bc = qwp(次2优先[i])
				local zd = ceil(js/bc.气血)
				if sl >= zd then
				   local zz = bc.气血 * zd
				   tp.队伍[1].气血 = min(tp.队伍[1].气血 + zz,tp.队伍[1].最大气血)
				   sq(次2优先[i],zd)
				else
				   local zz = bc.气血 * sl
				   tp.队伍[1].气血 = min(tp.队伍[1].气血 + zz,tp.队伍[1].最大气血)
				   sq(次2优先[i],sl)
				end
			end
			if tp.队伍[1].气血 == tp.队伍[1].最大气血 then
				return
			end
		end
		for i=1,#次3优先 do
			local sl = qs(次3优先[i])
			if sl > 0 then
				local bc = qwp(次3优先[i])
				local zd = ceil(js/bc.气血)
				if sl >= zd then
				   local zz = bc.气血 * zd
				   tp.队伍[1].气血 = min(tp.队伍[1].气血 + zz,tp.队伍[1].最大气血)
				   sq(次3优先[i],zd)
				else
				   local zz = bc.气血 * sl
				   tp.队伍[1].气血 = min(tp.队伍[1].气血 + zz,tp.队伍[1].最大气血)
				   sq(次3优先[i],sl)
				end
			end
			if tp.队伍[1].气血 == tp.队伍[1].最大气血 then
				return
			end
		end
	elseif 方式 == 2 then
		if tp.队伍[1].魔法 == tp.队伍[1].最大魔法 then
			return
		end
		local js = tp.队伍[1].最大魔法 - tp.队伍[1].魔法
		local 优先 = {"紫丹罗","佛手","旋复花","百色花","香叶","龙须草","灵脂","白玉骨头","曼佗罗花"}
		local 次优先 = {"丁香水","月星子","仙狐涎","地狱灵芝","麝香","血珊瑚","餐风饮露","白露为霜","孔雀红","天龙水"}
		local 次2优先 = {"麝香","风水混元丹","定神香","蛇蝎美人"}
		local 次3优先 = {}
		-- 先算出最大需要多少，在算出目前有多少，如果大于则吃完，小于则吃完当前的
		for i=1,#优先 do
			local sl = qs(优先[i])
			if sl > 0 then
				local bc = qwp(优先[i])
				local zd = ceil(js/bc.魔法)
				if sl >= zd then
				   local zz = bc.魔法 * zd
				   tp.队伍[1].魔法 = min(tp.队伍[1].魔法 + zz,tp.队伍[1].最大魔法)
				   sq(优先[i],zd)
				else
				   local zz = bc.魔法 * sl
				   tp.队伍[1].魔法 = min(tp.队伍[1].魔法 + zz,tp.队伍[1].最大魔法)
				   sq(优先[i],sl)
				end
			end
			if tp.队伍[1].魔法 == tp.队伍[1].最大魔法 then
				return
			end
		end
		for i=1,#次优先 do
			local sl = qs(次优先[i])
			if sl > 0 then
				local bc = qwp(次优先[i])
				local zd = ceil(js/bc.魔法)
				if sl >= zd then
				   local zz = bc.魔法 * zd
				   tp.队伍[1].魔法 = min(tp.队伍[1].魔法 + zz,tp.队伍[1].最大魔法)
				   sq(次优先[i],zd)
				else
				   local zz = bc.魔法 * sl
				   tp.队伍[1].魔法 = min(tp.队伍[1].魔法 + zz,tp.队伍[1].最大魔法)
				   sq(次优先[i],sl)
				end
			end
			if tp.队伍[1].魔法 == tp.队伍[1].最大魔法 then
				return
			end
		end
		for i=1,#次2优先 do
			local sl = qs(次2优先[i])
			if sl > 0 then
				local bc = qwp(次2优先[i])
				local zd = ceil(js/bc.魔法)
				if sl >= zd then
				   local zz = bc.魔法 * zd
				   tp.队伍[1].魔法 = min(tp.队伍[1].魔法 + zz,tp.队伍[1].最大魔法)
				   sq(次2优先[i],zd)
				else
				   local zz = bc.魔法 * sl
				   tp.队伍[1].魔法 = min(tp.队伍[1].魔法 + zz,tp.队伍[1].最大魔法)
				   sq(次2优先[i],sl)
				end
			end
			if tp.队伍[1].魔法 == tp.队伍[1].最大魔法 then
				return
			end
		end
		for i=1,#次3优先 do
			local sl = qs(次3优先[i])
			if sl > 0 then
				local bc = qwp(次3优先[i])
				local zd = ceil(js/bc.魔法)
				if sl >= zd then
				   local zz = bc.魔法 * zd
				   tp.队伍[1].魔法 = min(tp.队伍[1].魔法 + zz,tp.队伍[1].最大魔法)
				   sq(次3优先[i],zd)
				else
				   local zz = bc.魔法 * sl
				   tp.队伍[1].魔法 = min(tp.队伍[1].魔法 + zz,tp.队伍[1].最大魔法)
				   sq(次3优先[i],sl)
				end
			end
			if tp.队伍[1].魔法 == tp.队伍[1].最大魔法 then
				return
			end
		end
	end
end

function 系统类_人物框:检查点(x,y)
	return 矩阵:检查点(x,y) or self.焦点
end

return 系统类_人物框