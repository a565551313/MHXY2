
local 场景类_人物 = class()
local tp
local 坐骑补差x,坐骑补差y=0,0
local 光环补差x,光环补差y = 0,0
local 人物字体

function 场景类_人物:初始化()
	if tp == nil then
		tp = 引擎.场景
	end
	self.人物模型=tp.队伍[1].模型
	local 资源 = 引擎.取模型(tp.队伍[1].模型)
	-- 资源 = qmxs("大海龟")
	self.人物 = {["静立"] = tp.资源:载入(资源[3],"网易WDF动画",资源[1]),["行走"] = tp.资源:载入(资源[3],"网易WDF动画",资源[2])}


	self.id=tp.队伍[1].数字id
	self.特效组 = {}
	self.队伍令牌=false
	self.行为 = "静立"
	self.方向 = 4
	self.移动 = false
	self.目标格子 = {}
	self.名称偏移 = 生成XY(tp.字体表.人物字体:取宽度(tp.队伍[1].名称) / 2,-15)
	self.称谓宽度 = 0
	tp.坐骑列表=tp.队伍[1].坐骑列表
	self:置模型()
	self.鼠标点击动画组 = {}
	self.标识 = true
	self.坐标 = 生成XY()
	self.类型 = "主角"
	self.x,self.y=tp.角色坐标.x,tp.角色坐标.y
	--self.增加 = {x=0,y=0}
	self.延时 = 0
	self.标识 = true
	self.移动计时=os.time()
	self.队伍令牌=tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x2231EBB4)
	self.战斗动画=tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x97C79EDB)
	self.飞行偏移 = {x=0,y=0}
	self.飞行计数 = 0
	self.祥瑞加速 = 1
	self.飞行加速 = 1
	self.飞行 = false
	self:加载称谓()


end

function 场景类_人物:加载称谓()

	self.称谓动画 = nil
    self.名称偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.队伍[1].名称) / 2,-15)
	if tp.当前称谓 ~= nil and tp.当前称谓 ~= "" and tp.当前称谓 ~= "无称谓" then
		self.称谓颜色 =  -931286529
		self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2,-15)
		self.名称偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.队伍[1].名称) / 2,-40)
		if tp.当前称谓=="武神坛冠军" then
				self.称谓动画=tp.资源:载入('登陆资源.wdf',"网易假人动画",0xAABBCC1A)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2-30,-10)
		elseif tp.当前称谓=="武神坛亚军" then
				self.称谓动画=tp.资源:载入('登陆资源.wdf',"网易假人动画",0xAABBCC1C)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2-30,-10)
		elseif tp.当前称谓=="武神坛季军" then
				self.称谓动画=tp.资源:载入('登陆资源.wdf',"网易假人动画",0xAABBCC1B)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2-30,-10)
		elseif tp.当前称谓=="英雄大会冠军" then
				self.称谓动画=tp.资源:载入('窗口文字.wdf',"网易假人动画",0x5DA1F100)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2-50,-10)
		elseif tp.当前称谓=="英雄大会亚军" then
				self.称谓动画=tp.资源:载入('窗口文字.wdf',"网易假人动画",0x5DA1F101)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2-50,-10)
		elseif tp.当前称谓=="镇妖塔10层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007802)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+20,-5)
		elseif tp.当前称谓=="镇妖塔20层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007803)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+20,-5)
		elseif tp.当前称谓=="镇妖塔30层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007804)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+20,-5)
		elseif tp.当前称谓=="镇妖塔40层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007805)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+20,-5)
		elseif tp.当前称谓=="镇妖塔50层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007806)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+20,-5)
		elseif tp.当前称谓=="镇妖塔60层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007807)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+20,-5)
		elseif tp.当前称谓=="镇妖塔70层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007808)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+20,-5)
		elseif tp.当前称谓=="镇妖塔80层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007809)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+20,-5)
		elseif tp.当前称谓=="镇妖塔90层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007810)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+20,-5)
		elseif tp.当前称谓=="镇妖塔100层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007811)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+17,-5)
		elseif tp.当前称谓=="镇妖塔110层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007821)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+17,-5)
		elseif tp.当前称谓=="镇妖塔120层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007822)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+17,-5)
		elseif tp.当前称谓=="镇妖塔130层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007823)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+17,-5)
		elseif tp.当前称谓=="镇妖塔140层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007824)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+17,-5)
		elseif tp.当前称谓=="镇妖塔150层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007825)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+17,-5)
		elseif tp.当前称谓=="镇妖塔160层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007826)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+17,-5)
		elseif tp.当前称谓=="镇妖塔170层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007827)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+17,-5)
		elseif tp.当前称谓=="镇妖塔180层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007828)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+17,-5)
		elseif tp.当前称谓=="镇妖塔190层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007829)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+17,-5)
		elseif tp.当前称谓=="镇妖塔200层" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007830)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+17,-5)
		elseif tp.当前称谓 and tp.当前称谓~=""and string.find(tp.当前称谓,"镇妖塔")  then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007812)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2,-10)
		elseif tp.当前称谓=="初露锋芒" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007813)
		elseif tp.当前称谓=="千亿称号[血]" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69006801)
		elseif tp.当前称谓=="千亿称号[法]" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69004301)
		elseif tp.当前称谓=="千亿称号[速]" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69003D01)
		elseif tp.当前称谓=="千亿称号[防]" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69004901)
		elseif tp.当前称谓=="千亿称号[伤]" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007801)
		elseif tp.当前称谓=="绝世英豪" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007816)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+35,-5)
		elseif tp.当前称谓=="横扫天下" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007817)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+35,-5)
		elseif tp.当前称谓=="独孤求败" then
				self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007818)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+35,-5)
		elseif tp.当前称谓=="合格菜商" then
				self.称谓动画=tp.资源:载入('靓号.wdf',"网易假人动画",0x00000087)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.当前称谓) / 2+35,-5)
		else
			self.名称偏移 = 生成XY(tp.字体表.人物字体_:取宽度(tp.队伍[1].名称) / 2,-35)
		end
		if tp.当前称谓=="后起之秀"  or tp.当前称谓=="三界菁英"  or tp.当前称谓=="武林高手"  or tp.当前称谓=="英雄会精锐榜眼" or tp.当前称谓=="独孤求败"  or tp.当前称谓=="九天罗刹"  or tp.当前称谓=="皓月战神" or tp.当前称谓=="梦幻元勋" or tp.当前称谓=="叱咤三界" or tp.当前称谓=="笑傲西游" or tp.当前称谓=="唯吾独尊" then
				self.称谓颜色 = 0XFFce24ed
		elseif tp.当前称谓 ~= nil and tp.当前称谓 ~= "" and (string.match(tp.当前称谓,"娘子") or string.match(tp.当前称谓,"夫君")) then
				self.称谓颜色 = 0XFF000000
		elseif tp.当前称谓=="英雄会精锐探花" then
				self.称谓颜色 = 黄色
		elseif tp.当前称谓=="英雄会精锐状元" then
				self.称谓颜色 = 红色
		elseif tp.当前称谓=="虹光" then
				self.称谓颜色 = 红色
		elseif tp.当前称谓=="云影" then
				self.称谓颜色 = 蓝色
		elseif tp.当前称谓=="彩虹霸主" or  tp.当前称谓=="帮战之星" then
					self.称谓颜色 = 紫色
		elseif tp.当前称谓=="大唐官府首席大弟子" or tp.当前称谓=="神木林首席大弟子" or tp.当前称谓=="方寸山首席大弟子" or tp.当前称谓=="化生寺首席大弟子"
			or tp.当前称谓=="女儿村首席大弟子" or tp.当前称谓=="天宫首席大弟子" or tp.当前称谓=="普陀山首席大弟子" or tp.当前称谓=="五庄观首席大弟子"
			or tp.当前称谓=="凌波城首席大弟子" or tp.当前称谓=="龙宫首席大弟子"or tp.当前称谓=="魔王寨首席大弟子"or tp.当前称谓=="狮驼岭首席大弟子"
			or tp.当前称谓=="盘丝洞首席大弟子"or tp.当前称谓=="无底洞首席大弟子" or tp.当前称谓=="阴曹地府首席大弟子" or tp.当前称谓=="九黎城首席大弟子"
			then
				self.称谓颜色 = 4294919424
		end
	end







end



function 场景类_人物:改变飞行(是否)
	self.飞行 = 是否
	if self.飞行 then
	  self.飞行加速 = 1.15
	else
	  self.飞行加速 = 1
	end

end



function 场景类_人物:取目标(xy)
	if self.目标格子[1] == nil then
		return
	end
	--tp.场景.地图.增加.z = 2.5
	zd =  生成XY(math.floor(self.目标格子[1].x*20),math.floor(self.目标格子[1].y*20))
end

function 场景类_人物:取跟随坐标(i)
	return 生成XY(math.floor(tp.角色坐标.x),math.floor(tp.角色坐标.y)-i-1)
end

function 场景类_人物:开始移动(pys)
	if self.目标格子==nil or self.目标格子[1] == nil then
		self:停止移动(1)
		return
	end
	self.行为 = "行走"
	local dsa = 取八方向(取两点角度(tp.角色坐标,zd))
	if tp.队伍[1].变身[1] then
		dsa = 取四至八方向(dsa)
	end

	if self.目标格子==nil and 取两点距离(tp.角色坐标,{x=self.目标格子[#self.目标格子].x*20,y=self.目标格子[#self.目标格子].y*20})<=self.移动距离 then
		self:停止移动(2)
		return
	end

	  local 移动格子 = 2.5 * self.祥瑞加速 *self.飞行加速 * tp.月卡加速

		if 取两点距离(tp.角色坐标,zd) <= 3  then -- 小于可移动点直接到达位置
				if #self.目标格子 == 1 then
				   self:停止移动()
				   return
				end
				self.目标格子 = tp.场景.地图.寻路:寻路1(self.目标格子)
				tp.场景.跟随坐标 = {self.目标格子}
				if self.目标格子==nil or self.目标格子[1]==nil then return  end
				self:取目标(self.目标格子[1])
		end

		tp.角色坐标 = 取移动坐标(tp.角色坐标,zd,移动格子)
		self.x,self.y=tp.角色坐标.x,tp.角色坐标.y
		if 系统参数.时间-self.移动计时>=1 then
			self.移动计时=os.time()
			客户端:请求服务(1002,{x=math.floor(tp.角色坐标.x),y=math.floor(tp.角色坐标.y)},1)
		end
		self:置方向(dsa)

end


function 场景类_人物:停止移动(原因)
	if tp.角色坐标 ~= nil then
		请求服务(1002.1,{x=math.floor(tp.角色坐标.x),y=math.floor(tp.角色坐标.y)})
	end
	if tp.跨地图寻径开关 then
		if 原因==1 then
			return
		elseif 原因==2 then
			if #tp.跨地图寻径 == 0 then
				tp.跨地图寻径开关=false
			end
		end
	end
	self.目标格子 = {}
	self.行为 = "静立"
	self.移动 = false
--	tp.场景.地图.增加.z = 1
	zd = nil
	tp.窗口.小地图:清空()
end
function 场景类_人物:更新(dt,x,y) end

function 场景类_人物:显示(dt,x,y,pys)

    --引擎.置标题(全局游戏标题.." - ("..全局大分区.."["..全局小分区.."] - "..tp.队伍[1].名称.."["..tp.队伍[1].数字id.."])"..os.date(" %Y年%m月%d日 %H:%M:%S 星期")..gl天)
     引擎.置标题("梦幻西游".."-"..系统参数.服务器.名称.."- (江南一区 - "..tp.队伍[1].名称.."["..tp.队伍[1].数字id.."])  -"..os.date("%Y", 系统参数.时间).."年"..os.date("%m", 系统参数.时间).."月"..os.date("%d", 系统参数.时间).."日 "..os.date("%X", 系统参数.时间))
    --引擎.置标题(全局游戏标题.." - ("..全局大分区.."["..全局小分区.."] - "..tp.队伍[1].名称.."["..tp.队伍[1].数字id.."])")
	self:更新(dt,x,y,pys)
	人物点击=false
	if self.隐藏 then
		return
	end

if self.飞行 then
      if  self.飞行计数 < 150 then
		self.飞行计数 = self.飞行计数 + 1
	    self.飞行偏移.y = self.飞行偏移.y - (self.飞行计数/8000)*80
        if self.飞行偏移.y < -100 then
			self.飞行偏移.y = -100
			self.飞行计数 = 0
        end
	  end
    else
	 if  self.飞行计数 < 150 then
			self.飞行计数 = self.飞行计数 + 1
		    self.飞行偏移.y = self.飞行偏移.y + (self.飞行计数/8000)*80
        if self.飞行偏移.y > 0 then
	    	self.飞行偏移.y = 0
			self.飞行计数 = 0
        end
	  end
	end


    self.队伍令牌:更新()
    self.战斗动画:更新()

	local asa = 1
	if self.行为 == "行走" then
		asa = 1.25
	end
	self.人物[self.行为]:更新(dt*asa)
	if self.人物["武器_"..self.行为] ~= nil then
		self.人物["武器_"..self.行为]:更新(dt*asa)
	elseif self.人物["坐骑_"..self.行为] ~= nil then
		self.人物["坐骑_"..self.行为]:更新(dt*asa)
		if self.人物["坐骑饰品_"..self.行为] ~= nil then
			self.人物["坐骑饰品_"..self.行为]:更新(dt*asa)
		end
	end
	if self.人物["武器_"..self.行为.."1"] ~= nil then
			self.人物["武器_"..self.行为.."1"]:更新(dt*asa)
	end
	if self.人物["身体_"..self.行为] ~= nil then
		self.人物["身体_"..self.行为]:更新(dt*asa)
	end

	if self.人物["光环_"..self.行为] ~= nil then
		self.人物["光环_"..self.行为]:更新(dt*asa)
	end
	if self.人物["足迹_"..self.行为] ~= nil then
		self.人物["足迹_"..self.行为]:更新(dt*asa)
	end
	if self.人物["翅膀_"..self.行为] ~= nil then
		self.人物["翅膀_"..self.行为]:更新(dt*asa)
	end


	local 名字颜色 =  4285594736
	if tp.强p开关 ~= nil then
		名字颜色 = 红色
	elseif tp.pk开关 ~= nil then
		名字颜色 = 黄色
	end
	if tp.名字变色 then
		名字颜色=0xFFFF1493-------改色
	end
	local yx = false
	if self.人物["武器_"..self.行为] ~= nil and self.人物["武器_"..self.行为]:是否选中(x,y) then
		yx = true
	elseif self.人物["武器_"..self.行为.."1"] ~= nil and self.人物["武器_"..self.行为.."1"]:是否选中(x,y) then
		yx = true
	elseif self.人物["坐骑_"..self.行为] ~= nil and self.人物["坐骑_"..self.行为]:是否选中(x,y) then
		yx = true
	elseif self.人物["坐骑饰品_"..self.行为] ~= nil and self.人物["坐骑饰品_"..self.行为]:是否选中(x,y) then
		yx = true
	end
	if (self.人物[self.行为]:是否选中(x,y) or yx) and tp:可操作() and not tp.第一窗口移动中 then
		if self.人物["武器_"..self.行为] ~= nil then
			self.人物["武器_"..self.行为]:置高亮()
		elseif self.人物["坐骑_"..self.行为] ~= nil then
			self.人物["坐骑_"..self.行为]:置高亮()
			if self.人物["坐骑饰品_"..self.行为] ~= nil then
				self.人物["坐骑饰品_"..self.行为]:置高亮()
			end
		end
		if self.人物["武器_"..self.行为.."1"] ~= nil then
			self.人物["武器_"..self.行为.."1"]:置高亮()
		end
		if self.人物["光环_"..self.行为] ~= nil then
			self.人物["光环_"..self.行为]:置高亮()
		end
		if self.人物["足迹_"..self.行为] ~= nil then
			self.人物["足迹_"..self.行为]:置高亮()
		end
		if self.人物["翅膀_"..self.行为] ~= nil then
			self.人物["翅膀_"..self.行为]:置高亮()
		end
		-- if self.人物["身体_"..self.行为] ~= nil then
		-- 	self.人物["身体_"..self.行为]:置高亮()
		-- end
		self.人物[self.行为]:置高亮()
		-- 名字颜色 = -419495936
		-- 称谓颜色 = 0xFF2D96FF
		名字颜色 =  红色

	else
		if self.人物["武器_"..self.行为] ~= nil then
			self.人物["武器_"..self.行为]:取消高亮()
		elseif self.人物["坐骑_"..self.行为] ~= nil then
			self.人物["坐骑_"..self.行为]:取消高亮()
			if self.人物["坐骑饰品_"..self.行为] ~= nil then
				self.人物["坐骑饰品_"..self.行为]:取消高亮()
			end
		end
		if self.人物["武器_"..self.行为.."1"] ~= nil then
			self.人物["武器_"..self.行为.."1"]:取消高亮()
		end
		if self.人物["光环_"..self.行为] ~= nil then
			self.人物["光环_"..self.行为]:取消高亮()
		end
		if self.人物["足迹_"..self.行为] ~= nil then
			self.人物["足迹_"..self.行为]:取消高亮()
		end
		if self.人物["翅膀_"..self.行为] ~= nil then
			self.人物["翅膀_"..self.行为]:取消高亮()
		end
		-- if self.人物["身体_"..self.行为] ~= nil then
		-- 	self.人物["身体_"..self.行为]:取消高亮()
		-- end
		self.人物[self.行为]:取消高亮()
	end
	if 引擎.鼠标按住(0) and (self.队长开关==nil and #tp.队伍数据 >= 1) then

	else
		if self.队长开关 or #tp.队伍数据==0 and 摊位名称==nil then
			if 引擎.鼠标按住(0) and not tp.选中假人 then --and tp.队伍[1].自动遇怪~=true
				if self.延时 <= 0 and tp:可通行() then
					if tp.鼠标.取当前()=="组队" and (self.人物[self.行为]:是否选中(x,y) or yx)  then
						人物点击=true
						客户端:请求服务(4002,{id=tp.队伍[1].数字id},1)
						tp.鼠标.还原鼠标()
					elseif tp.鼠标.取当前()=="普通" then
						if self.延时 <= 0 then
							tp.窗口.小地图:清空()
							local 格子 = 生成XY(math.floor(x / 20 - pys.x / 20),math.floor(y / 20 - pys.y / 20))
							local v = {
								x = math.floor(x - pys.x),
								y = math.floor(y - pys.y),
								ani = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x0D98AC0A)
							}
							table.insert(self.鼠标点击动画组,v)
							local 内容={x=格子.x,y=格子.y,距离=0}
							self:设置路径(内容)
							客户端:请求服务(1001,格子,1)
							客户端:请求服务(1002,{x=math.floor(tp.角色坐标.x),y=math.floor(tp.角色坐标.y)},1)
						end
					end
				end
				鼠标延时2=鼠标延时2+1
			end
			if 引擎.鼠标按下(0) or 引擎.鼠标按住(1) or 引擎.鼠标按住(2) then
				鼠标延时2=0
			end
			if 鼠标延时2 >=175 and not tp.选中假人  then
				if self.延时 <= 0 and tp:可通行() then
					if 全局自动走路开关 == true then
						全局自动走路开关 = false
						全局自动走路秒 = 0
						tp.常规提示:打开("#Y/自动挂机快捷键为#GAlt+Z# 请使用快捷键进行挂机开启！")
					end
					tp.窗口.小地图:清空()
					local 格子 = 生成XY(math.floor(x / 20 - pys.x / 20),math.floor(y / 20 - pys.y / 20))
					self.延时 = 10
					self.移动 = true
					local v = {
						x = math.floor(x - pys.x),
						y = math.floor(y - pys.y),
						ani = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x0D98AC0A)--鼠标点击特效
					}
					table.insert(self.鼠标点击动画组,v)
					local 内容={x=格子.x,y=格子.y,距离=0}
					self:设置路径(内容)
					客户端:请求服务(1001,格子,1)
					客户端:请求服务(1002,{x=math.floor(tp.角色坐标.x),y=math.floor(tp.角色坐标.y)},1)
				end
			end
		 	if 全局自动走路开关 and not tp.选中假人 and 全局自动走路秒 >= 175 and tp:可通行() and not self.移动 then
		 		全局自动走路秒 = 0
		 		local xxQ,yyQ,mmxQ,mmyQ
				mmxQ,mmyQ = math.floor(tp.场景.地图.宽度/20),math.floor(tp.场景.地图.高度/20)
				xxQ = 引擎.取随机整数(3,mmxQ)
				yyQ = 引擎.取随机整数(3,mmyQ)
				tp.窗口.小地图:清空()
				if self.延时 <= 0 and 引擎.取随机整数(1,10)==10 then
					tp.窗口.小地图:清空()
					local 格子 = 生成XY(xxQ,yyQ)
					self.延时 = 10
					self.移动 = true
					local v = {
						x = xxQ,
						y = yyQ,
						ani = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x0D98AC0A)
					}
					table.insert(self.鼠标点击动画组,v)
					local 内容={x=格子.x,y=格子.y,距离=0}
					self:设置路径(内容)
					客户端:请求服务(1001,格子,1)
					客户端:请求服务(1002,{x=math.floor(tp.角色坐标.x),y=math.floor(tp.角色坐标.y)},1)
				end
			end
		end
	end
	if self.延时 > 0 then
		self.延时 = self.延时 - 1
	end
	if not self.行走 and not self.移动 and self.行为 ~= "静立" then
		self.行为 = "静立"
	end
    if not self.移动 and 引擎.鼠标按住(1) or 引擎.鼠标按住(2) then
        if 引擎.鼠标按住(1) and not tp.选中假人 and tp:可通行() then
        	self.移动 = false
        	if self.行为 ~= "静立" then
				self.行为 = "静立"
			end
        	--======
			local Qzd =  生成XY(math.floor(x  - pys.x),math.floor(y  - pys.y))
			local dsaQ = 取八方向(取两点角度(tp.角色坐标,Qzd))
			self:置方向(dsaQ)
		end
    end
	for i=1,#self.鼠标点击动画组 do
		if self.鼠标点击动画组[i] ~= nil then
			self.鼠标点击动画组[i].ani:更新(dt)
			self.鼠标点击动画组[i].ani:显示(self.鼠标点击动画组[i] + pys)
			if (self.鼠标点击动画组[i].ani.当前帧 == 5) then
				self.鼠标点击动画组[i].ani = nil
				table.remove(self.鼠标点击动画组,i)
			end
		end
	end
	local s = 生成XY(math.floor(tp.角色坐标.x),math.floor(tp.角色坐标.y))+ self.飞行偏移
	tp.影子:显示(s.x + pys.x,s.y + pys.y-self.飞行偏移.y)


	if self.人物["光环_"..self.行为] ~= nil then
		self.人物["光环_"..self.行为]:显示(s + pys)
		光环补差x,光环补差y=引擎.补差(tp.队伍[1].锦衣[2],self.人物模型)
	end
	if self.人物["足迹_"..self.行为] ~= nil then
		self.人物["足迹_"..self.行为]:显示(s + pys)
	end
	if self.人物["坐骑_"..self.行为] ~= nil then
		self.人物["坐骑_"..self.行为]:显示(s + pys)
		if self.人物["坐骑饰品_"..self.行为] ~= nil then
			self.人物["坐骑饰品_"..self.行为]:显示(s + pys)
		end

	end
	if self.人物["身体_"..self.行为] ~= nil then
		self.人物["身体_"..self.行为]:显示(s.x + pys.x  + 光环补差x  + 坐骑补差x,s.y + pys.y  +光环补差y+坐骑补差y)
	end
	self.人物[self.行为]:显示(s.x + pys.x  + 光环补差x + 坐骑补差x,s.y + pys.y  +光环补差y+坐骑补差y)



	if self.人物["武器_"..self.行为] ~= nil then
		self.人物["武器_"..self.行为]:显示(s + pys)
	end
	if self.人物["武器_"..self.行为.."1"] ~= nil then
		self.人物["武器_"..self.行为.."1"]:显示(s + pys)
	end
	if self.人物["翅膀_"..self.行为] ~= nil then
		self.人物["翅膀_"..self.行为]:显示(s.x + pys.x-50,s.y+pys.y-120)
	end

	-- if 特效开关 then
	--     self.king:显示(s+pys)
	-- end
	if tp.当前称谓 ~= nil and tp.当前称谓 ~= "" and tp.当前称谓 ~= "无称谓" and self.称谓偏移 then
        if self.称谓动画 then
        	self.称谓动画:更新()
 			self.称谓动画:显示(s + pys - self.称谓偏移)
		else
			tp.字体表.人物字体_:置颜色(self.称谓颜色)
			tp.字体表.人物字体_:显示x(s + pys - self.称谓偏移,tp.当前称谓)
		end
	end
	tp.字体表.人物字体_:置阴影颜色(-1275068416)
	tp.字体表.人物字体_:置颜色(名字颜色)
	tp.字体表.人物字体_:显示x(s + pys - self.名称偏移,tp.队伍[1].名称)



	--显示摊位
	if 摊位名称~=nil then
		local 摊位xy=s + pys
		local 摊位长度=string.len(摊位名称)
		if 摊位长度<=4 then
			小摊位:显示(摊位xy.x,摊位xy.y-100)
			摊位文字:显示(摊位xy.x-13+(4-摊位长度)*1.8,摊位xy.y-114,摊位名称)
			if 小摊位:是否选中(x,y) and 引擎.鼠标弹起(右键) then
				请求服务(3720,tp.队伍[1].bb)
			end
		elseif 摊位长度<=4 then
			中摊位:显示(摊位xy.x,摊位xy.y-100)
			摊位文字:显示(摊位xy.x-25+(8-摊位长度)*1.8,摊位xy.y-114,摊位名称)
			if 中摊位:是否选中(x,y) and 引擎.鼠标弹起(右键) then
				请求服务(3720,tp.队伍[1].bb)
			end
		else
			大摊位:显示(摊位xy.x,摊位xy.y-100)
			摊位文字:显示(摊位xy.x-40+(12-摊位长度)*1.8,摊位xy.y-114,摊位名称)
			if 大摊位:是否选中(x,y) and 引擎.鼠标弹起(右键) then
				请求服务(3720,tp.队伍[1].bb)
			end
		end
	end


	for i=1,#self.特效组 do
		if self.特效组[i] ~= nil then
			self.特效组[i]:更新(dt)
			self.特效组[i]:显示(s + pys)
			if (self.特效组[i].当前帧 >= self.特效组[i].帧数-2) then
				self.特效组[i] = nil
			end
		end
	end



	if self.队长开关 then
      self.显示坐标=s + pys
      if self.人物["坐骑_"..self.行为] ~= nil then
      	self.队伍令牌:显示(self.显示坐标.x,self.显示坐标.y-130)
      else
      	self.队伍令牌:显示(self.显示坐标.x,self.显示坐标.y-100)
      end
	end
	if self.移动 then
		self:开始移动(pys)
	end

	self.坐标.x = math.floor(tp.角色坐标.x)
	self.坐标.y = math.floor(tp.角色坐标.y)
end

function 场景类_人物:设置坐标(格子)
	tp.角色坐标.x,tp.角色坐标.y=格子.x,格子.y
	tp.场景.滑屏.x,tp.场景.滑屏.y = tp.角色坐标.x,tp.角色坐标.y
	--tp.场景.屏幕坐标 = 取画面坐标(tp.角色坐标.x,tp.角色坐标.y,tp.场景.地图.宽度,tp.场景.地图.高度)
	self:停止移动()
end

function 场景类_人物:设置路径(格子,重置)
	self.移动计时=os.time()
	if 重置== nil then
		tp.跨地图寻径={}
		tp.跨地图寻径开关=false
	end
    tp.窗口.小地图:清空()
    self.移动距离=格子.距离
	local a = 生成XY(math.floor(tp.角色坐标.x / 20),math.floor(tp.角色坐标.y / 20))
	if  self.飞行 then
		self.目标格子 = tp.场景.地图.寻路:飞行寻路(a,格子)
	else
	    self.目标格子 = tp.场景.地图.寻路:寻路(a,格子)
	end
	if self.目标格子 ~= nil and self.目标格子[1] ~= nil then
		tp.场景.跟随坐标 = {self.目标格子}
		self.延时 = 10
		self.移动 = true
		self:取目标(self.目标格子[1])
	else
		self.目标格子 = {}
	end
end

function 场景类_人物:置方向(d)
	if tp.队伍[1].变身数据~=nil and 变身显示 then
		d= 取四至八方向(d)
	end
	if self.人物["静立"]~=nil then
		self.人物["静立"]:置方向(d)
		self.人物["行走"]:置方向(d)
	end
	if self.人物["武器_静立"] ~= nil and self.人物["武器_行走"] ~= nil then
		self.人物["武器_静立"]:置方向(d)
		self.人物["武器_行走"]:置方向(d)
	elseif self.人物["坐骑_静立"] ~= nil then
		self.人物["坐骑_静立"]:置方向(d)
		self.人物["坐骑_行走"]:置方向(d)
		if self.人物["坐骑饰品_静立"] ~= nil then
			self.人物["坐骑饰品_静立"]:置方向(d)
			self.人物["坐骑饰品_行走"]:置方向(d)
		end
	end
	if self.人物["武器_静立1"] ~= nil and self.人物["武器_行走1"] ~= nil then
		self.人物["武器_静立1"]:置方向(d)
		self.人物["武器_行走1"]:置方向(d)
	end
	if self.人物["身体_静立"] ~= nil and self.人物["身体_行走"] ~= nil then
		self.人物["身体_静立"]:置方向(d)
		self.人物["身体_行走"]:置方向(d)
	end
	if self.人物["翅膀_静立"] ~= nil then
		a= 取四至八方向(d)
		self.人物["翅膀_静立"]:置方向(a)
		self.人物["翅膀_行走"]:置方向(a)
	end
	if self.人物["足迹_行走"] ~= nil then
		self.人物["足迹_行走"]:置方向(d)
	end
	self.方向 = d
end

function 场景类_人物:置染色(染色方案,a,b,c,d)
	if tp.队伍[1].变身[1] ~= nil or tp.队伍[1].锦衣[1] ~= nil then
		return false
	end
	if 染色方案 ~= nil and 染色方案~=0 then
		self.人物["静立"]:置染色(染色方案,a,b,c,0)
		self.人物["行走"]:置染色(染色方案,a,b,c,0)
		self:置方向(self.方向)
	end
end

function 场景类_人物:置模型()
	    self.方向=1
	    self:置人物模型()
		tp.队伍[1]:刷新信息()
		self:置方向(self.方向)
end



function 场景类_人物:置人物模型()
	self.人物["武器_静立"] = nil
	self.人物["武器_行走"] = nil
	self.人物["武器_静立1"] = nil
	self.人物["武器_行走1"] = nil
	self.人物["坐骑_静立"] = nil
	self.人物["坐骑_行走"] = nil
	self.人物["坐骑饰品_静立"] = nil
	self.人物["坐骑饰品_行走"] = nil
	self.祥瑞加速 = 1
	if tp.队伍[1].坐骑 ~= nil and tp.队伍[1].坐骑.模型 and tp.队伍[1].坐骑.祥瑞  then
		self.祥瑞加速 = 1.15
	end

	if tp.队伍[1].变身数据~=nil and  变身显示  then
				local 资源 = 引擎.取模型(tp.队伍[1].变身数据)
				self.人物 = {["静立"] = tp.资源:载入(资源[3],"网易WDF动画",资源[1]),["行走"] = tp.资源:载入(资源[3],"网易WDF动画",资源[2])}
				self.人物.行走:置提速(1.25)
				 if string.find(tp.队伍[1].变身数据, "进阶") then
						local zl = 引擎.取战斗模型(tp.队伍[1].变身数据.."_饰品")  ---这里显示宠物饰品的
						if zl~=nil and zl[10]~=nil then
							self.人物["武器_静立"] = tp.资源:载入(zl[10],"网易WDF动画",zl[6])
							self.人物["武器_行走"] = tp.资源:载入(zl[10],"网易WDF动画",zl[8])
							self.人物["武器_行走"]:置提速(1.25)
						end
				 end
				if tp.队伍[1].变异 and 染色信息[tp.队伍[1].变身数据]~=nil then
						self.染色方案 = 染色信息[tp.队伍[1].变身数据].id
						self.染色组 = 染色信息[tp.队伍[1].变身数据].方案
						self:置染色(self.染色方案,self.染色组[1],self.染色组[2],self.染色组[3])
						self:置方向(self.方向)
				end

	elseif tp.队伍[1].坐骑 ~= nil and tp.队伍[1].坐骑.模型 and (not tp.队伍[1].锦衣 or not tp.队伍[1].锦衣[1] or not tp.队伍[1].锦衣[1].名称 or  屏蔽锦衣效果) and 坐骑显示 then

				local 资源组 = {}
				if 引擎.新增坐骑(tp.队伍[1].模型,tp.队伍[1].坐骑.模型,"站立") then
					资源组.人物资源 = "xzzq.wdf"
					资源组.人物站立 = 引擎.新增坐骑(tp.队伍[1].模型,tp.队伍[1].坐骑.模型,"站立")
					资源组.人物行走 = 引擎.新增坐骑(tp.队伍[1].模型,tp.队伍[1].坐骑.模型,"奔跑")
					资源组.坐骑资源 = "xzzq.wdf"
					资源组.坐骑行走 = 引擎.新增坐骑(tp.队伍[1].模型,tp.队伍[1].坐骑.模型,"奔跑")
					资源组.坐骑站立 = 引擎.新增坐骑(tp.队伍[1].模型,tp.队伍[1].坐骑.模型,"站立")
				else
					资源组 = 引擎.坐骑库(tp.队伍[1].模型,tp.队伍[1].坐骑.模型,tp.队伍[1].坐骑.饰品 or "空")
				end
				if 资源组~=nil then
						self.人物 = {["静立"] = tp.资源:载入(资源组.人物资源,"网易WDF动画",资源组.人物站立),["行走"] = tp.资源:载入(资源组.人物资源,"网易WDF动画",资源组.人物行走)}
						self.人物["行走"]:置提速(1.25)
						self.人物["坐骑_静立"] = tp.资源:载入(资源组.坐骑资源,"网易WDF动画",资源组.坐骑站立)
						self.人物["坐骑_行走"] = tp.资源:载入(资源组.坐骑资源,"网易WDF动画",资源组.坐骑行走)
						self.人物["坐骑_行走"]:置提速(1.25)

						-- if tp.队伍[1].坐骑.染色方案~=nil and tp.队伍[1].坐骑.染色组~=0 and #tp.队伍[1].坐骑.染色组~=0 then
						-- 	self.人物["坐骑_静立"]:置染色(tp.队伍[1].坐骑.染色方案,tp.队伍[1].坐骑.染色组[1],tp.队伍[1].坐骑.染色组[2],tp.队伍[1].坐骑.染色组[3])
						-- 	self.人物["坐骑_行走"]:置染色(tp.队伍[1].坐骑.染色方案,tp.队伍[1].坐骑.染色组[1],tp.队伍[1].坐骑.染色组[2],tp.队伍[1].坐骑.染色组[3])
						-- end
						if 资源组 ~= nil and 资源组.坐骑饰品站立 ~= nil then
							self.人物["坐骑饰品_静立"] = tp.资源:载入(资源组.坐骑饰品资源,"网易WDF动画",资源组.坐骑饰品站立)
							self.人物["坐骑饰品_行走"] = tp.资源:载入(资源组.坐骑饰品资源,"网易WDF动画",资源组.坐骑饰品行走)
							self.人物["坐骑饰品_行走"]:置提速(1.25)
							-- if tp.队伍[1].坐骑.饰品物件~=nil and tp.队伍[1].坐骑.饰品物件.染色方案~=nil and tp.队伍[1].坐骑.饰品物件.染色组~=0 and #tp.队伍[1].坐骑.饰品物件.染色组~=0 then
							-- 	self.人物["坐骑饰品_静立"]:置染色(tp.队伍[1].坐骑.饰品物件.染色方案,tp.队伍[1].坐骑.饰品物件.染色组[1],tp.队伍[1].坐骑.饰品物件.染色组[2],tp.队伍[1].坐骑.饰品物件.染色组[3])
							-- 	self.人物["坐骑饰品_行走"]:置染色(tp.队伍[1].坐骑.饰品物件.染色方案,tp.队伍[1].坐骑.饰品物件.染色组[1],tp.队伍[1].坐骑.饰品物件.染色组[2],tp.队伍[1].坐骑.饰品物件.染色组[3])
							-- end
						end
						self.人物["武器_静立"] = nil
						self.人物["武器_行走"] = nil
						self.人物["武器_静立1"] = nil
						self.人物["武器_行走1"] = nil
						坐骑补差x,坐骑补差y=0,0

				else
					local 资源 = 引擎.取模型(tp.队伍[1].模型)
					 self.人物 = {["静立"] = tp.资源:载入(资源[3],"网易WDF动画",资源[1]),["行走"] = tp.资源:载入(资源[3],"网易WDF动画",资源[2])}
					 self.人物.行走:置提速(1.25)
				     self:置染色(tp.队伍[1].染色方案,tp.队伍[1].染色组[1],tp.队伍[1].染色组[2],tp.队伍[1].染色组[3])
				end

	else

			local v = nil
			if tp.队伍[1].装备[3]~=nil then
				v = tp:取武器子类(tp.队伍[1].装备[3].子类)
				if tp.队伍[1].装备[3].名称 == "龙鸣寒水" or tp.队伍[1].装备[3].名称 == "非攻" then
					v = "弓弩1"
				end
			end
			local 资源 = 引擎.取模型(tp.队伍[1].模型,v)
			local 是否战斗锦衣 = false
			if tp.队伍[1].锦衣[1] ~= nil and tp.队伍[1].锦衣[1].名称 ~= nil  and not 屏蔽锦衣效果 then
				   local 锦衣名称 = tp.队伍[1].锦衣[1].名称
					if 锦衣名称=="青春" or 锦衣名称=="素颜" or 锦衣名称=="绝色" or 锦衣名称=="春秋" or  锦衣名称=="夏蚕"
					  or 锦衣名称=="星河" or 锦衣名称=="白峨" or 锦衣名称=="糖果" or 锦衣名称=="青涩" or 锦衣名称=="傲然"
					  or 锦衣名称=="牛仔" or  锦衣名称=="试剑" or 锦衣名称=="骨龙战骑" or 锦衣名称=="水嘟嘟·钻白" or 锦衣名称=="斗战神"
					  or  锦衣名称=="斗战胜佛"   or  锦衣名称=="八部天龙马·玄" or  锦衣名称=="龙凰·桃" or  锦衣名称=="龙凰·皑"  then
						资源 =引擎.取战斗锦衣素材(tp.队伍[1].锦衣[1].名称,tp.队伍[1].模型)
					    self.人物 = {["静立"] = tp.资源:载入(资源[5],"网易WDF动画",资源[3]),["行走"] = tp.资源:载入(资源[5],"网易WDF动画",资源[4])}
					    是否战斗锦衣 = true
					elseif 新加战斗锦衣[锦衣名称]~=nil  then
						   local 模型类型 = 取角色锦衣武器类型(tp.队伍[1].模型,v)
		                   资源 = 引擎.取武器锦衣素材(tp.队伍[1].锦衣[1].名称,tp.队伍[1].模型,模型类型)
		                   self.人物 = {["静立"] = tp.资源:载入(资源[5],"网易WDF动画",资源[3]),["行走"] = tp.资源:载入(资源[5],"网易WDF动画",资源[4])}
					end
			else
		        self.人物 = {["静立"] = tp.资源:载入(资源[3],"网易WDF动画",资源[1]),["行走"] = tp.资源:载入(资源[3],"网易WDF动画",资源[2])}
		        self:置染色(tp.队伍[1].染色方案,tp.队伍[1].染色组[1],tp.队伍[1].染色组[2],tp.队伍[1].染色组[3])
			end
			self.人物.行走:置提速(1.25)
			if tp.队伍[1].装备[3] and tp.队伍[1].装备[3].名称 then
					local m = tp:取武器附加名称(tp.队伍[1].装备[3].子类,tp.队伍[1].装备[3].级别限制,tp.队伍[1].装备[3].名称)
					local n = 引擎.取模型(m.."_"..tp.队伍[1].模型)
					self.人物["武器_静立"] = tp.资源:载入(n[3],"网易WDF动画",n[1])
					self.人物["武器_行走"] = tp.资源:载入(n[3],"网易WDF动画",n[2])
					self.人物["武器_行走"]:置提速(1.25)
					if tp.队伍[1].装备[3].染色方案~=0  and tp.队伍[1].装备[3].染色组~=nil and tp.队伍[1].装备[3].染色组~=0 and #tp.队伍[1].装备[3].染色组>0 then
					    self.人物["武器_静立"]:置染色(tp.队伍[1].装备[3].染色方案,tp.队伍[1].装备[3].染色组[1],tp.队伍[1].装备[3].染色组[2],tp.队伍[1].装备[3].染色组[3])
					    self.人物["武器_行走"]:置染色(tp.队伍[1].装备[3].染色方案,tp.队伍[1].装备[3].染色组[1],tp.队伍[1].装备[3].染色组[2],tp.队伍[1].装备[3].染色组[3])
					end
					self:置方向(self.方向)
					if 是否战斗锦衣 then
						self.人物["武器_静立"] = nil
						self.人物["武器_行走"] = nil
					end
			end

			if tp.队伍[1].装备[4] and tp.队伍[1].模型=="影精灵" and string.find(tp.队伍[1].装备[4].名称,"(坤)") and (tp.队伍[1].装备[3]==nil or string.find(tp.队伍[1].装备[3].名称,"(乾)")) then
					local n = 引擎.取模型(tp.队伍[1].装备[4].名称.."_"..tp.队伍[1].模型)
					self.人物["武器_静立1"] = tp.资源:载入(n[3],"网易WDF动画",n[1])
					self.人物["武器_行走1"] = tp.资源:载入(n[3],"网易WDF动画",n[2])
					self.人物["武器_行走1"]:置提速(1.25)
					if tp.队伍[1].装备[4].染色方案~=0 and tp.队伍[1].装备[4].染色组~=nil and tp.队伍[1].装备[4].染色组~=0  and #tp.队伍[1].装备[4].染色组>0 then
					    self.人物["武器_静立1"]:置染色(tp.队伍[1].装备[4].染色方案,tp.队伍[1].装备[4].染色组[1],tp.队伍[1].装备[4].染色组[2],tp.队伍[1].装备[4].染色组[3])
					    self.人物["武器_行走1"]:置染色(tp.队伍[1].装备[4].染色方案,tp.队伍[1].装备[4].染色组[1],tp.队伍[1].装备[4].染色组[2],tp.队伍[1].装备[4].染色组[3])
					end
					self:置方向(self.方向)
					if 是否战斗锦衣 then
						self.人物["武器_静立1"] = nil
						self.人物["武器_行走1"] = nil
					end
			end



			if tp.队伍[1].锦衣[2] ~= nil and tp.队伍[1].锦衣[2].名称 ~= nil and not 屏蔽光环足迹效果 then
					self:穿戴光环()
			else
			    	self:卸下光环()
			end
			if tp.队伍[1].锦衣[3] ~= nil and tp.队伍[1].锦衣[3].名称 ~= nil  and not 屏蔽光环足迹效果 then
					self:穿戴足迹()
			else
			    	self:卸下足迹()
			end
	end

end







function 场景类_人物:穿戴光环()

	local n = 引擎.取光环(tp.队伍[1].锦衣[2].名称)
	self.人物["光环_静立"]=tp.资源:载入(n[4],"网易假人动画",n[1])
    self.人物["光环_行走"]=tp.资源:载入(n[4],"网易假人动画",n[2])
    self.人物["光环_行走"]:置提速(1.25)
    self:置方向(self.方向)
end

function 场景类_人物:卸下光环()
	self.人物["光环_静立"] = nil
	self.人物["光环_行走"] = nil
end

function 场景类_人物:穿戴足迹()
	local n = 引擎.取足迹(tp.队伍[1].锦衣[3].名称)
    self.人物["足迹_行走"]=tp.资源:载入(n[4],"网易假人动画",n[1])
    self.人物["足迹_行走"]:置提速(1.25)
    self:置方向(self.方向)
end

function 场景类_人物:卸下足迹()
	self.人物["足迹_行走"] = nil
end

function 场景类_人物:穿戴翅膀()
	if tp.队伍[1].变身[1] ~= nil then
		tp.常规提示:打开("#Y/当前正处于变身状态中，无法取消")
		return false
	end
	-- local n = 引擎.取模型(tp.队伍[1].灵饰[5].名称)
	-- self.人物["翅膀_静立"] = pwd("54")
	-- self.人物["翅膀_行走"] = pwd("54")
	self:置方向(self.方向)
end

function 场景类_人物:卸下翅膀()
	self.人物["翅膀_静立"] = nil
	self.人物["翅膀_行走"] = nil
end

function 场景类_人物:加入动画(动画)
	table.insert(self.特效组,tp:载入特效(动画))
end

return 场景类_人物