
local 合成灵犀玉 = class()
local bw = require("gge包围盒")(0,0,40,40)
local insert = table.insert
local mouseb = 引擎.鼠标弹起
local mousea = 引擎.鼠标按住
local tp,hclxykzt
local 坐标 = {{190,311},{188,247},{228,195},{284,150},{351,150},{403,193},{447,247},{447,313},{351,405},{284,405}}
local bw坐标 = {{180,301},{178,237},{217,185},{274,140},{341,140},{393,183},{437,237},{437,303},{341,395},{274,395}}
-- local 十二时辰 = {"子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"}
local 十二时辰 = {"申","酉","戌","亥","子","丑","寅","卯","辰","巳","午","未"}
local 时辰显示与坐标 = {
		子 = {"EB658CF1",344,47},
		丑 = {"A59A5675",442,102},
		寅 = {"F56CEDD2",497,199},
		卯 = {"259869FB",494,311},
		辰 = {"CF7FE283",445,404},
		巳 = {"C0EC5E5F",350,460},
		午 = {"87B01ACC",238,460},
		未 = {"CBB1F1C2",133,403},
		申 = {"A72202ED",82,316},
		酉 = {"3164459D",79,206},
		戌 = {"775AB575",134,104},
		亥 = {"AE8DDDA1",233,46},
	}
	--暗
local 时辰显示光效与坐标1 = {
		子 = {"8A91409E",344,47},
		丑 = {"1A041CE2",442,102},
		寅 = {"41874650",497,199},
		卯 = {"28B8C5F3",494,311},
		辰 = {"82107E7B",445,404},
		巳 = {"012EC80A",350,460},
		午 = {"4B8A3264",238,460},
		未 = {"5BE3867E",133,403},
		申 = {"2AE05825",82,316},
		酉 = {"D143DB61",79,206},
		戌 = {"F79DF796",134,104},
		亥 = {"00DA20F0",233,46},
	}
	--
local 时辰显示光效与坐标2 = {
		子 = {"1F9A4A9A",344,47},
		丑 = {"CC1BEF97",442,102},
		寅 = {"2F2889A6",497,199},
		卯 = {"E778A2FA",494,311},
		辰 = {"19888E8E",445,404},
		巳 = {"5CA04E2E",350,460},
		午 = {"8AB16B84",238,460},
		未 = {"90E84362",133,403},
		申 = {"83534900",82,316},
		酉 = {"97AE47C3",79,206},
		戌 = {"3419BF6E",134,104},
		亥 = {"26120EBB",233,46},
	}
	--亮
local 物品坐标 = {{177,297},{173,232},{211,176},{269,135},{335,135},{388,180},{431,231},{431,296},{334,391},{270,392}}

function 合成灵犀玉:初始化(根)
 	self.ID = 139
	self.x = 0
	self.y = 0
	self.xx = 0
	self.yy = 0
	self.注释 = "合成灵犀玉"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口时间 = 0
	tp = 根
end

function 合成灵犀玉:加载资源()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 资源:载入(wdf配置.."/pic/神器素材/hcbj.png","图片"),--zip:取精灵([[hcbj.png]]),
		[2] = 按钮.创建(资源:载入('新加界面.npk',"网易WDF动画","20FD5715"),0,0,3,true,true), --关闭
		[3] = 资源:载入('wdf/pic/神器素材/tbwzbj.png',"图片"),--zip:取精灵([[tbwzbj.png]]),
		-- [4] = 按钮.创建(资源:载入('新加界面.npk',"网易WDF动画","2E78E809),0,0,3,true,true), --碎片合成
		[5] = 按钮.创建(资源:载入('新加界面.npk',"网易WDF动画","16C7CDDB"),0,0,3,true,true), --+号
		[6] = 资源:载入('新加界面.npk',"网易WDF动画","36758F6F"),
		[7] = 资源:载入('新加界面.npk',"网易WDF动画","060482C3"),
		[8] = 资源:载入('新加界面.npk',"网易WDF动画","C4D34CA9"),
		[9] = 资源:载入('新加界面.npk',"网易WDF动画","DD1D0997"),
		[10] = 资源:载入('新加界面.npk',"网易WDF动画","5429517B"),
		[11] = 资源:载入('新加界面.npk',"网易WDF动画","F5BCEA0B"),
		[12] = 资源:载入('新加界面.npk',"网易WDF动画","4E6476BE"),
		[13] = 资源:载入('新加界面.npk',"网易WDF动画","C057E026"),
		[14] = 按钮.创建(资源:载入('新加界面.npk',"网易WDF动画","2E78E809"),0,0,3,true,true),
		[15] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0007"), --小斜正方形
		[16] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0010"), --金
		[17] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0011"), --木
		[18] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0012"), --水
		[19] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0013"), --火
		[20] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0014"), --土
		[21] = 资源:载入('新加界面.npk',"网易WDF动画","4902C991"),
		-- [22] = 资源:载入('新加界面.npk',"网易WDF动画",0x0B000001), --光圈
		[22] = 资源:载入('新加界面.npk',"网易WDF动画","0B000002"), --两角
		-- [22] = 资源:载入('新加界面.npk',"网易WDF动画",0x01AC0033),
	}
	self.按钮组 = {}
	for n=1,10 do
	    self.按钮组[n] = 按钮.创建(资源:载入('新加界面.npk',"网易WDF动画","01AC0022"),0,0,3,true,true)
	end
	self.时辰组 = {}
	self.时辰光效组1 = {}
	self.时辰光效组2 = {}
	self.效果组 = {}
	self.物品 = {}
	local 屑资源=引擎.取物品("灵犀之屑")
	self.物品.小动画 = 资源:载入(屑资源[11],"网易WDF动画",屑资源[12])
	self.物品.大动画 = 资源:载入(屑资源[11],"网易WDF动画",屑资源[13])
	self.物品.说明 = 屑资源[1]
	self.记录时间 = 0
	for n=1,12 do
		self.时辰组[n] = 资源:载入('新加界面.npk',"网易WDF动画",时辰显示与坐标[十二时辰[n]][1])
		self.时辰光效组1[n] = 资源:载入('新加界面.npk',"网易WDF动画",时辰显示光效与坐标1[十二时辰[n]][1])
		self.时辰光效组2[n] = 资源:载入('新加界面.npk',"网易WDF动画",时辰显示光效与坐标2[十二时辰[n]][1])
	end
	hclxykzt = tp.字体表.普通字体
end

function 合成灵犀玉:打开(数据)
 	if self.可视 then
		self.可视 = false
		self.可用数量 = nil
		self.扣除数量 = nil
		self.物品显示 = nil
		return
	else
		insert(tp.窗口_,self)
		if self.资源组==nil then
		    self:加载资源()
		end
		self.加入物品组 = {0,0,0,0,0,0,0,0,0,0}
		self.物品显示 = false
		self.x = (全局游戏宽度/2)-321
		self.y = (全局游戏高度/2)-279
		self.可用数量 = 数据
		self.扣除数量 = 0
		self.是否成功 = false
		self.播放1 = false
		self.播放2 = false
		self.已点亮 = {}
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
	end
end

function 合成灵犀玉:更新位置(位置)
	for n=1,10 do
		-- if 位置 == n and self.加入物品组[n]==0 then
		-- 	self.加入物品组[n] = 1
		-- end
		if 位置 == n then
			if self.加入物品组[n]==0 then
			    self.加入物品组[n] = 1
			else
			    self.加入物品组[n] = 0
			end
		end
	end
end

function 合成灵犀玉:合成开始(数据)
	self.播放1 = true
	self.可用数量=数据.剩余灵犀玉
    self.是否成功=数据.是否成功
end

function 合成灵犀玉:显示(dt,x,y)
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[3]:显示(self.x + 175,self.y - 5)
	self.资源组[2]:更新(x,y)
	self.资源组[13]:更新(dt)
	self.资源组[14]:更新(x,y)
	self.资源组[22]:更新(dt)
	self.资源组[2]:显示(self.x + 585,self.y - 5)
	self.资源组[12]:显示(self.x + 245,self.y)
	self.资源组[13]:显示(self.x - 90,self.y - 40)
	self.资源组[8]:显示(self.x + 101,self.y + 64)
	self.资源组[7]:显示(self.x + 125,self.y + 90)
	self.资源组[6]:显示(self.x + 163,self.y + 123)
	self.资源组[10]:显示(self.x + 385,self.y + 343)
	self.资源组[11]:显示(self.x + 194,self.y + 343)
	self.资源组[21]:显示(self.x + 175,self.y + 150)
	self.资源组[9]:显示(self.x + 262,self.y + 226)
	self.资源组[14]:显示(self.x + 270,self.y + 307)
	self.资源组[15]:显示(self.x + 312,self.y + 192)
	self.资源组[15]:显示(self.x + 312,self.y + 113)
	self.资源组[15]:显示(self.x + 312,self.y + 435)
	self.资源组[15]:显示(self.x + 152,self.y + 277)
	self.资源组[15]:显示(self.x + 474,self.y + 277)
	self.资源组[16]:显示(self.x + 160,self.y + 284)
	self.资源组[17]:显示(self.x + 482,self.y + 284)
	self.资源组[18]:显示(self.x + 319,self.y + 120)
	self.资源组[19]:显示(self.x + 320,self.y + 442)
	self.资源组[20]:显示(self.x + 320,self.y + 198)

	hclxykzt:置颜色(黑色):显示(self.x+329,self.y+277,self.可用数量)

	for n=1,10 do
		local yn = false
		bw:置坐标(self.x + bw坐标[n][1],self.y + bw坐标[n][2])
		self.按钮组[n]:更新(x,y)
		-- self.按钮组[n]:显示(self.x + 坐标[n][1],self.y + 坐标[n][2])
		if self.物品显示 and self.加入物品组[n]==1 then
			self.物品.小动画:显示(self.x+物品坐标[n][1],self.y+物品坐标[n][2])
			if self.物品.小动画:是否选中(x,y) then
				tp.提示:商城提示(self.x + 物品坐标[n][1] ,self.y +物品坐标[n][2],"灵犀之屑",self.物品.说明,self.物品.大动画)
			end
		else
			self.按钮组[n]:显示(self.x + 坐标[n][1],self.y + 坐标[n][2])
		end
		if bw:检查点(x,y) then
			self.焦点 = true
			if mouseb(0) then
				yn = true
			end
		end
		if self.按钮组[n]:事件判断() or yn then --or yn
			--print(self.加入物品组[n])
			if self.加入物品组[n]==0 then
				if self.可用数量 > 0 then
				    self.可用数量 = self.可用数量 - 1
				    self.扣除数量 = self.扣除数量 + 1
				    self.物品显示=true
					self.已点亮[n] = true
				    self:更新位置(n)
				else
					tp.常规提示:打开("#Y/灵犀之屑数量不足！")
					-- return
				end
			else
			    self.可用数量 = self.可用数量 + 1
			    self.扣除数量 = self.扣除数量 - 1
			    self:更新位置(n)
			end
		end
	end
	for n=1,12 do
		self.时辰组[n]:显示(self.x+时辰显示与坐标[十二时辰[n]][2],self.y+时辰显示与坐标[十二时辰[n]][3]) --暗
	end

	for n=1,12 do
		-- self.时辰组[n]:显示(self.x+时辰显示与坐标[十二时辰[n]][2],self.y+时辰显示与坐标[十二时辰[n]][3]) --暗
		if self.已点亮[n] then
			if n>=9 then
			    n=n+1
			end
		    self.时辰光效组2[n]:显示(self.x+时辰显示光效与坐标2[十二时辰[n]][2],self.y+时辰显示光效与坐标2[十二时辰[n]][3]) --最亮
		    if self.扣除数量>=10 then
		        self.时辰光效组2[9]:显示(self.x+时辰显示光效与坐标2[十二时辰[9]][2],self.y+时辰显示光效与坐标2[十二时辰[9]][3]) --最亮
		        self.时辰光效组2[12]:显示(self.x+时辰显示光效与坐标2[十二时辰[12]][2],self.y+时辰显示光效与坐标2[十二时辰[12]][3]) --最亮
		    end
		end
		-- self.时辰光效组1[n]:显示(self.x+时辰显示光效与坐标1[十二时辰[n]][2],self.y+时辰显示光效与坐标1[十二时辰[n]][3]) --第二
		-- self.时辰光效组2[n]:显示(self.x+时辰显示光效与坐标2[十二时辰[n]][2],self.y+时辰显示光效与坐标2[十二时辰[n]][3]) --最亮
	end

	for i=1,#self.效果组 do
		if self.效果组[i] ~= nil then
			self.效果组[i]:更新(x,y)
			self.效果组[i]:显示(self.x,self.y)
			if self.效果组[i].结束帧==self.效果组[i].当前帧 then
				self.效果组[i] = nil
				self.已点亮 = {}
			end
		end
	end
	if self.播放1 then
	    self.资源组[22]:显示(self.x + 160+34,self.y + 284+56)
	    if self.资源组[22].结束帧==self.资源组[22].当前帧 then
	    	self.播放1 = false
	    	self.播放2 = true
		end
	end
	if self.播放2 then
		if self.是否成功 then
		    local sc = tp.资源:载入('新加界面.npk',"网易WDF动画","01AC0034") --成功
		    insert(self.效果组,sc)
		else
			local sc = tp.资源:载入('新加界面.npk',"网易WDF动画","01AC0033") --失败
		    insert(self.效果组,sc)
		end
		self.播放2 = false
	end

	if self.资源组[2]:事件判断() then
		self.可视 = false
	elseif self.资源组[14]:事件判断() then --合成按钮
		self.物品显示 = false
		if self.扣除数量>0 then
		    请求服务(3773,{位置=n,数量=self.扣除数量})
		    self.扣除数量=0
		    self.加入物品组 = {0,0,0,0,0,0,0,0,0,0}
		else
			tp.常规提示:打开("#Y/请放入灵犀之屑！")
		end
	end

end

function 合成灵犀玉:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
		self.窗口时间 = tp.运行时间
	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 合成灵犀玉:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end
function 合成灵犀玉:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		return true
	else
		return false
	end
end
return 合成灵犀玉