
local 场景类_玩家 = class()
local tp
local 光环补差x,光环补差y = 0,0
local 坐骑补差x,坐骑补差y=0,0



function 场景类_玩家:初始化(玩家)
	if tp == nil then
		tp = 引擎.场景
	end

	--玩家.y = 玩家.y + (引擎.取随机整数(1,12) / 100)
	self.玩家 = {}
	self.组队标志=tp.资源:载入('登陆资源.wdf',"网易假人动画",0x2231EBB4)
	self.战斗动画=tp.资源:载入('登陆资源.wdf',"网易假人动画",0x97C79EDB)
	self.名称 = 玩家.名称
	self.坐标 = 生成XY(math.floor(玩家.x),math.floor(玩家.y))
	self.编号 = 玩家.编号
	self.x=玩家.x
	self.y=玩家.y
	self.玩家ID = 玩家.id
	self.行为 = "静立"
	self.方向 = 玩家.方向 or 1
	self.记忆方向 = self.方向
	self.称谓=玩家.当前称谓
	self.执行事件 = nil
	self.初始坐标 = 生成XY(math.floor(玩家.x),math.floor(玩家.y))
	self.行走坐标 = 生成XY(math.floor(玩家.x),math.floor(玩家.y))
	self.事件ID = 玩家.事件ID
	self.武器 = 玩家.武器
	self.模型 = 玩家.模型
	self.组合 = 玩家.组合
	self.副武器=玩家.副武器
	self.行走开关 = false
	self.队长开关 = 玩家.队长
	self.队伍 = 玩家.队伍
	self.类型 = "玩家"
	self.所在地图 = nil
	self.组员数量 = 0
	self.队员编号 = 玩家.队员编号
	self.坐骑 = 玩家.坐骑
	self.染色组 = 玩家.染色组
	self.装备 = 玩家.装备
	self.灵饰 = 玩家.灵饰
	self.锦衣 = 玩家.锦衣
	self.法宝 = 玩家.法宝
	self.染色方案 = 玩家.染色方案
	self.等级 = 玩家.等级
	self.性别 = 玩家.性别
	self.种族 = 玩家.种族
	self.帮派 = 玩家.帮派
	self.门派 = 玩家.门派
	self.战斗开关=玩家.战斗开关
	self.摊位名称=玩家.摊位名称
	self.变身=玩家.变身数据
	self.变异=玩家.变异
	self.pk开关 = 玩家.pk开关
	self.强p开关 = 玩家.强p开关
	self.申请玩家 = nil
	self.特效组={}
	self.祥瑞加速 = 1
	self.飞行 =玩家.飞行
	if self.飞行 then
		self.飞行加速 = 1.15
	else
		self.飞行加速 = 1
    end
	self.飞行偏移 = {x=0,y=0}
	self.飞行计数 = 0
	self.月卡加速 = 玩家.月卡.开通
	self.名字变色 = 玩家.月卡.开通
	self.离线摆摊= 玩家.离线摆摊
	self:置人物模型()
	self.喊话=require("script/显示类/喊话").创建(tp)
	self:更改称谓(玩家)
	self.目标格子 = {}
	self.方向开关 = 4--self.玩家.静立.方向数 == 8
	self.移动 = false
	if self.玩家.静立 ~= nil then
		self.静止转移 = self.玩家.静立.帧数 <= 4 or (self.执行事件 == "明雷怪" or self.行走开关)
		self:置方向(self.方向)
	end
	self.触发事件 = 玩家.触发事件
	self.触发计次 = 0
	self.显示1 = true
end




function 场景类_玩家:更改称谓(内容)
		self.称谓动画 = nil
		if 内容 and 内容.当前称谓 and 内容.当前称谓 ~= 0  and self.称谓~=内容.当前称谓 then
	     	self.称谓 = 内容.当前称谓
	    end
	    self.名称偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.名称) / 2,-15)
		if self.称谓 and self.称谓 ~= "" and self.称谓 ~= "无称谓" then
			self.称谓颜色 =  -931286529
			self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2,-15)
			self.名称偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.名称) / 2,-40)
			if self.称谓=="武神坛冠军" then
					self.称谓动画=tp.资源:载入('登陆资源.wdf',"网易假人动画",0xAABBCC1A)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2-30,-10)
			elseif self.称谓=="武神坛亚军" then
					self.称谓动画=tp.资源:载入('登陆资源.wdf',"网易假人动画",0xAABBCC1C)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2-30,-10)
			elseif self.称谓=="武神坛季军" then
					self.称谓动画=tp.资源:载入('登陆资源.wdf',"网易假人动画",0xAABBCC1B)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2-30,-10)
			elseif self.称谓=="英雄大会冠军" then
					self.称谓动画=tp.资源:载入('窗口文字.wdf',"网易假人动画",0x5DA1F100)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2-50,-10)
			elseif self.称谓=="英雄大会亚军" then
					self.称谓动画=tp.资源:载入('窗口文字.wdf',"网易假人动画",0x5DA1F101)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2-50,-10)
			elseif self.称谓=="镇妖塔10层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007802)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+20,-5)
			elseif self.称谓=="镇妖塔20层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007803)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+20,-5)
			elseif self.称谓=="镇妖塔30层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007804)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+20,-5)
			elseif self.称谓=="镇妖塔40层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007805)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+20,-5)
			elseif self.称谓=="镇妖塔50层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007806)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+20,-5)
			elseif self.称谓=="镇妖塔60层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007807)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+20,-5)
			elseif self.称谓=="镇妖塔70层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007808)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+20,-5)
			elseif self.称谓=="镇妖塔80层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007809)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+20,-5)
			elseif self.称谓=="镇妖塔90层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007810)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+20,-5)
			elseif self.称谓=="镇妖塔100层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007811)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+17,-5)
			elseif self.称谓=="镇妖塔110层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007821)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+17,-5)
			elseif self.称谓=="镇妖塔120层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007822)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+17,-5)
			elseif self.称谓=="镇妖塔130层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007823)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+17,-5)
			elseif self.称谓=="镇妖塔140层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007824)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+17,-5)
			elseif self.称谓=="镇妖塔150层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007825)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+17,-5)
			elseif self.称谓=="镇妖塔160层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007826)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+17,-5)
			elseif self.称谓=="镇妖塔170层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007827)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+17,-5)
			elseif self.称谓=="镇妖塔180层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007828)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+17,-5)
			elseif self.称谓=="镇妖塔190层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007829)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+17,-5)
			elseif self.称谓=="镇妖塔200层" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007830)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+17,-5)
			elseif self.称谓 and self.称谓~=""and string.find(self.称谓,"镇妖塔")  then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007812)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2,-10)
			elseif self.称谓=="初露锋芒" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007813)
			elseif self.称谓=="千亿称号[血]" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69006801)
			elseif self.称谓=="千亿称号[法]" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69004301)
			elseif self.称谓=="千亿称号[速]" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69003D01)
			elseif self.称谓=="千亿称号[防]" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69004901)
			elseif self.称谓=="千亿称号[伤]" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007801)
			elseif self.称谓=="绝世英豪" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007816)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+35,-5)
			elseif self.称谓=="横扫天下" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007817)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+35,-5)
			elseif self.称谓=="独孤求败" then
					self.称谓动画=tp.资源:载入('xcwsc.wdf',"网易假人动画",0x69007818)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+35,-5)
			elseif self.称谓=="合格菜商" then
					self.称谓动画=tp.资源:载入('靓号.wdf',"网易假人动画",0x00000087)
					self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+35,-5)
			else
				self.名称偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.名称) / 2,-35)
			end
			if self.称谓=="后起之秀"  or self.称谓=="三界菁英"  or self.称谓=="武林高手"  or self.称谓=="英雄会精锐榜眼" or self.称谓=="独孤求败"  or self.称谓=="九天罗刹"  or self.称谓=="皓月战神" or self.称谓=="梦幻元勋" or self.称谓=="叱咤三界" or self.称谓=="笑傲西游" or self.称谓=="唯吾独尊" then
					self.称谓颜色 = 0XFFce24ed
			elseif self.称谓 ~= nil and self.称谓 ~= "" and (string.match(self.称谓,"娘子") or string.match(self.称谓,"夫君")) then
					self.称谓颜色 = 0XFF000000
			elseif self.称谓=="英雄会精锐探花" then
					self.称谓颜色 = 黄色
			elseif self.称谓=="英雄会精锐状元" then
					self.称谓颜色 = 红色
			elseif self.称谓=="虹光" then
					self.称谓颜色 = 红色
			elseif self.称谓=="云影" then
					self.称谓颜色 = 蓝色
			elseif self.称谓=="彩虹霸主" or  self.称谓=="帮战之星" then
						self.称谓颜色 = 紫色
			elseif self.称谓=="大唐官府首席大弟子" or self.称谓=="神木林首席大弟子" or self.称谓=="方寸山首席大弟子" or self.称谓=="化生寺首席大弟子"
				or self.称谓=="女儿村首席大弟子" or self.称谓=="天宫首席大弟子" or self.称谓=="普陀山首席大弟子" or self.称谓=="五庄观首席大弟子"
				or self.称谓=="凌波城首席大弟子" or self.称谓=="龙宫首席大弟子"or self.称谓=="魔王寨首席大弟子"or self.称谓=="狮驼岭首席大弟子"
				or self.称谓=="盘丝洞首席大弟子"or self.称谓=="无底洞首席大弟子" or self.称谓=="阴曹地府首席大弟子" or self.称谓=="九黎城首席大弟子"
				then
					self.称谓颜色 = 4294919424
			end
		end



end

function 场景类_玩家:取目标()
	if self.目标格子[1] == nil then
		return
	end
	self.终点 =  生成XY(math.floor(self.目标格子[1].x*20),math.floor(self.目标格子[1].y*20))
end

function 场景类_玩家:改变飞行(是否)
	self.飞行 = 是否
	if self.飞行 then
		self.飞行加速 = 1.15
	else
		self.飞行加速 = 1
    end
end

function 场景类_玩家:开始移动()
	if self.目标格子[1] == nil then
		self:停止移动()
		return
	end
	self.行为 = "行走"
	local 方向 = 取八方向(取两点角度(self.行走坐标,self.终点),not self.方向开关)

	    local 移动格子 = 2.5 * self.祥瑞加速*self.飞行加速
         if self.月卡加速 then
			移动格子 = 移动格子 * 1.1
		 end
		if 取两点距离(self.行走坐标,self.终点) < 3 then -- 小于可移动点直接到达位置
			self.行走坐标 = self.终点
			table.remove(self.目标格子, 1)
			if #self.目标格子 <= 0 then
				self:停止移动()
			end
			self:取目标()
			return false
		end
		self.行走坐标 = 取移动坐标(self.行走坐标,self.终点,移动格子)
		self.x,self.y=self.行走坐标.x,self.行走坐标.y
		if self.显示1 then
			self:置方向(方向)
		end

end

function 场景类_玩家:停止移动()
	self.目标格子 = {}
	self.行为 = "静立"
	self.移动 = false
	self.行走开关 = false
end

function 场景类_玩家:更新(dt,x,y)
	if self.行走开关 == true then
		self:取目标()
		self.移动 = true
	end
	if self.显示1 then
		if self.玩家[self.行为] ~= nil then
			self.玩家[self.行为]:更新(dt)
			if self.玩家["武器_"..self.行为] ~= nil then
				self.玩家["武器_"..self.行为]:更新(dt)
			end
			if self.玩家["武器_"..self.行为.."1"] ~= nil then
				self.玩家["武器_"..self.行为.."1"]:更新(dt)
			end
		    if self.玩家["坐骑_"..self.行为] ~= nil then
				 self.玩家["坐骑_"..self.行为]:更新(dt)
				if self.玩家["坐骑饰品_"..self.行为] ~= nil then
					self.玩家["坐骑饰品_"..self.行为]:更新(dt)
				end
			end
			if self.玩家["光环_"..self.行为] ~= nil then
				self.玩家["光环_"..self.行为]:更新(dt)
			end
			if self.玩家["足迹_"..self.行为] ~= nil then
				self.玩家["足迹_"..self.行为]:更新(dt)
			end
			if self.玩家[self.行为]~=nil and  self.玩家[self.行为]:是否选中(x,y) and tp:可操作() and not tp.第一窗口移动中 then
				tp.选中玩家 = true
				if 引擎.鼠标弹起(0) and 取两点距离(tp.角色坐标,self.坐标) < 250 and self.执行事件 ~= "摆摊" and not self.开启跟随 and self.特效 == nil then
					if not self.静止转移 then
						-- self:事件开始()
						if tp.窗口.对话栏.可视 then
							self:事件方向(tp.角色坐标,self.坐标)
						end
					end
				end
			end
		end
		if self.特效 ~= nil then
			self.特效:更新(dt)
		end
	 	for i=1,#self.特效组 do
			if self.特效组[i] ~= nil then
				self.特效组[i]:更新(dt)
			end
     	end
		if self.队长开关 then
			self.组队标志:更新(dt)
		end






	end
end


function 场景类_玩家:摊位显示(dt,x,y,pys)
	if self.摊位名称~=nil then
		if 观察[self.玩家ID]~=nil then
			if 观察[self.玩家ID].关注~=nil and 观察[self.玩家ID].关注 then
				摊位文字:置颜色(0xFFFF0000)
			else
				摊位文字:置颜色(0xFF000000)
			end
		else 摊位文字:置颜色(0xFF0084FF) end--0xFF0000FF
		local 摊位xy=生成XY(math.floor(self.x),math.floor(self.y)) + pys
		local 摊位长度=string.len(self.摊位名称)
		if 摊位长度<=4 then
			小摊位:显示(摊位xy.x,摊位xy.y-100)
			摊位文字:显示(摊位xy.x-13+(4-摊位长度)*1.8,摊位xy.y-114,self.摊位名称)
			if 小摊位:是否选中(x,y) and 引擎.鼠标弹起(右键) and tp:可通行() then
				请求服务(3725,{id=self.玩家ID})
				if 观察[self.玩家ID]==nil then 观察[self.玩家ID]={} 观察[self.玩家ID].关注=false end
				观察[self.玩家ID][1]=0
			end
		elseif 摊位长度<=4 then
			中摊位:显示(摊位xy.x,摊位xy.y-100)
			摊位文字:显示(摊位xy.x-25+(8-摊位长度)*1.8,摊位xy.y-114,self.摊位名称)
			if 中摊位:是否选中(x,y) and 引擎.鼠标弹起(右键) and tp:可通行() then
				请求服务(3725,{id=self.玩家ID})
				if 观察[self.玩家ID]==nil then 观察[self.玩家ID]={} 观察[self.玩家ID].关注=false end
				观察[self.玩家ID][1]=0
			end
		else
			大摊位:显示(摊位xy.x,摊位xy.y-100)
			摊位文字:显示(摊位xy.x-40+(12-摊位长度)*1.8,摊位xy.y-114,self.摊位名称)
			if 大摊位:是否选中(x,y) and 引擎.鼠标弹起(右键) and tp:可通行() then
				请求服务(3725,{id=self.玩家ID})
				if 观察[self.玩家ID]==nil then 观察[self.玩家ID]={} 观察[self.玩家ID].关注=false end
				观察[self.玩家ID][1]=0
			end
		end
	end
end

function 场景类_玩家:显示(dt,x,y,pys)
	self:更新(dt,x,y,pys)
    self.战斗动画:更新(dt)
	if self.移动 then
		self:开始移动(dt)
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



	local yx = false
	 if 取两点距离(tp.角色坐标,self.行走坐标) < 800 then
	     local 名称颜色 = 4285594736
		if self.强p开关 ~= nil then
			名称颜色 = 红色
		elseif self.pk开关 ~= nil then
			名称颜色 = 黄色
		end
		if self.名字变色 then
		   名称颜色 = 0xFFFF1493-----改色
		end
		if tp.窗口.对话栏.可视 == false and self.方向 ~= self.记忆方向 and (self.执行事件 ~= "明雷怪" and not self.行走开关) then
			self:置方向(self.方向)
		end
		local s = 生成XY(math.floor(self.行走坐标.x),math.floor(self.行走坐标.y))+ self.飞行偏移
		tp.影子:显示(s + pys-self.飞行偏移)
		if 玩家显示开关 then
			if self.玩家["光环_"..self.行为] ~= nil then
				self.玩家["光环_"..self.行为]:显示(s.x + pys.x,s.y + pys.y)
				光环补差x,光环补差y=引擎.补差(self.锦衣[2],self.模型)
			end
			if self.玩家["足迹_"..self.行为] ~= nil then
				self.玩家["足迹_"..self.行为]:显示(s.x + pys.x,s.y + pys.y)
			end
			if self.玩家["坐骑_"..self.行为] ~= nil then
				self.玩家["坐骑_"..self.行为]:显示(s.x + pys.x,s.y + pys.y)
				if self.玩家["坐骑饰品_"..self.行为] ~= nil then
					self.玩家["坐骑饰品_"..self.行为]:显示(s.x + pys.x,s.y + pys.y)
				end
			end

			if self.玩家[self.行为] ~= nil then
				self.玩家[self.行为]:显示(s.x + pys.x + 光环补差x + 坐骑补差x,s.y + pys.y  +光环补差y+坐骑补差y)
			end
			if self.玩家["武器_"..self.行为] ~= nil  then
				self.玩家["武器_"..self.行为]:显示(s.x + pys.x,s.y + pys.y)
			end
			if self.玩家["武器_"..self.行为.."1"] ~= nil then
				self.玩家["武器_"..self.行为.."1"]:显示(s.x + pys.x,s.y + pys.y)
			end
			if ((self.玩家[self.行为] ~= nil and self.玩家[self.行为]:是否选中(x,y)) or (self.玩家["武器_"..self.行为]~=nil and self.玩家["武器_"..self.行为]:是否选中(x,y)) or (self.玩家["武器_"..self.行为.."1"]~=nil and self.玩家["武器_"..self.行为.."1"]:是否选中(x,y)) or yx)  and (tp.鼠标.取当前() == "组队" or tp.鼠标.取当前()=="给予" or tp.鼠标.取当前()=="交易" or tp.鼠标.取当前()=="平时攻击") then
				self.移动 = false
				if 引擎.鼠标弹起(0) and tp.鼠标.取当前() == "组队" then
					--if self.队长开关 then
						人物点击=true
						if self.队长开关 then --有队伍的情况
								请求服务(4002,{id=self.玩家ID})
						else
								请求服务(4014,{id=self.玩家ID})
						end
						--请求服务(4002,{id=self.玩家ID})
						tp.鼠标.还原鼠标()
					-- else
					-- 	tp.常规提示:打开("#Y/先看下他是不是队长吧")
					-- end
				elseif 引擎.鼠标弹起(0) and tp.鼠标.取当前()=="给予" then
					人物点击=true
					请求服务(3716,{id=self.玩家ID})
					tp.鼠标.还原鼠标()
				elseif 引擎.鼠标弹起(0) and tp.鼠标.取当前()=="平时攻击" then
					人物点击=true
					tp.鼠标.还原鼠标()
					请求服务(33,{序列=self.玩家ID})
				elseif 引擎.鼠标弹起(0) and tp.鼠标.取当前()=="交易" then
					人物点击=true
					请求服务(3718,{id=self.玩家ID})
					tp.鼠标.还原鼠标()
				end
			end
			if self.玩家[self.行为]~=nil and  self.玩家[self.行为]:是否选中(x,y) and tp:可操作() and not tp.第一窗口移动中 then
				self.玩家[self.行为]:置高亮()
				if self.玩家["光环_"..self.行为] ~= nil then
					self.玩家["光环_"..self.行为]:置高亮()
				end
				if self.玩家["足迹_"..self.行为] ~= nil then
					self.玩家["足迹_"..self.行为]:置高亮()
				end
				if self.玩家["武器_"..self.行为] ~= nil then
					self.玩家["武器_"..self.行为]:置高亮()
				end
				if self.玩家["武器_"..self.行为.."1"] ~= nil then
					self.玩家["武器_"..self.行为.."1"]:置高亮()
				end
				if self.玩家["坐骑_"..self.行为] ~= nil then
					self.玩家["坐骑_"..self.行为]:置高亮()
				end

            	if 引擎.鼠标弹起(右键) then
            		if self.玩家ID>99900 then
					return 0
					end
			    if tp.窗口.人物界面.可视 and tp.窗口.人物界面.玩家id == self.玩家ID then
                    tp.窗口.人物界面:打开()
			    else
			        tp.窗口.人物界面:打开({self.名称,self.玩家ID,self.门派,self.模型})
				    end
				end
				名称颜色 = 红色


			else
				if self.玩家[self.行为]~=nil then
					self.玩家[self.行为]:取消高亮()
				end
				if self.玩家["光环_"..self.行为] ~= nil then
					self.玩家["光环_"..self.行为]:取消高亮()
				end
				if self.玩家["足迹_"..self.行为] ~= nil then
					self.玩家["足迹_"..self.行为]:取消高亮()
				end
				if self.玩家["武器_"..self.行为] ~= nil then
					self.玩家["武器_"..self.行为]:取消高亮()
				end
				if self.玩家["武器_"..self.行为.."1"] ~= nil then
					self.玩家["武器_"..self.行为.."1"]:取消高亮()
				end

				if self.玩家["坐骑_"..self.行为] ~= nil then
					self.玩家["坐骑_"..self.行为]:取消高亮()
				end
			end
		end
	    if self.称谓 and self.称谓偏移 then
			if self.称谓动画 then
				self.称谓动画:更新()
				self.称谓动画:显示(s + pys - self.称谓偏移)
			else
				tp.字体表.人物字体_:置颜色(self.称谓颜色)
			    tp.字体表.人物字体_:显示x(s + pys - self.称谓偏移,self.称谓)
			end
		end
		tp.字体表.人物字体_:置阴影颜色(-1275068416)
		tp.字体表.人物字体_:置颜色(名称颜色)
		tp.字体表.人物字体_:显示x(s + pys - self.名称偏移,self.名称)
		if self.特效 ~= nil then
			self.特效:显示(s.x + pys.x,s.y + pys.y)
			if (self.特效.当前帧 >= self.特效.结束帧) then
				self.特效 = nil
				return false
			end
		end
		for i=1,#self.特效组 do
			if self.特效组[i] ~= nil then
				self.特效组[i]:显示(生成XY(math.floor(self.x),math.floor(self.y)) + pys)
				if (self.特效组[i].当前帧 >= self.特效组[i].帧数-2) then
					self.特效组[i] = nil
				end
			end
		end
		self:摊位显示(dt,x,y,pys)
		self.坐标.x = s.x
		self.坐标.y = s.y
		if self.队长开关 then
			local Qs = 生成XY(math.floor(self.行走坐标.x),math.floor(self.行走坐标.y-100))
			if self.玩家["坐骑_"..self.行为]  ~= nil then
				Qs = 生成XY(math.floor(self.行走坐标.x),math.floor(self.行走坐标.y-130))
			else
				Qs = 生成XY(math.floor(self.行走坐标.x),math.floor(self.行走坐标.y-100))
			end
			self.组队标志:显示(Qs + pys+ self.飞行偏移)
		end
		self.显示1 = true
		if self.战斗开关 then
			self.显示坐标=生成XY(math.floor(self.x),math.floor(self.y)) + pys
			if self.玩家["坐骑_"..self.行为]  ~= nil then
				self.战斗动画:显示(self.显示坐标.x,self.显示坐标.y-130+ self.飞行偏移.y)
			else
				self.战斗动画:显示(self.显示坐标.x,self.显示坐标.y-100+ self.飞行偏移.y)
			end
		end
		self.喊话:显示()
	else
	    self.显示1 = false
	end
end

function 场景类_玩家:置方向(d)
	if 玩家显示开关 and 玩家加载开关 and self.摊位名称 == nil then
		if self.变身 ~= nil and 变身显示 then
			d= 取四至八方向(d)
		end
		if self.玩家["静立"] ~= nil then
			self.玩家["静立"]:置方向(d)
			self.玩家["行走"]:置方向(d)
		end
		if self.玩家["武器_静立"] ~= nil and self.玩家["武器_行走"] ~= nil then
			self.玩家["武器_静立"]:置方向(d)
			self.玩家["武器_行走"]:置方向(d)
		elseif self.玩家["坐骑_静立"] ~= nil then
			self.玩家["坐骑_静立"]:置方向(d)
			self.玩家["坐骑_行走"]:置方向(d)
			if self.玩家["坐骑饰品_静立"] ~= nil then
				self.玩家["坐骑饰品_静立"]:置方向(d)
				self.玩家["坐骑饰品_行走"]:置方向(d)
			end
		end
		if self.玩家["武器_静立1"] ~= nil and self.玩家["武器_行走1"] ~= nil then
			self.玩家["武器_静立1"]:置方向(d)
			self.玩家["武器_行走1"]:置方向(d)
		end

		if self.玩家["翅膀_静立"] ~= nil then
			self.玩家["翅膀_静立"]:置方向(d)
			self.玩家["翅膀_行走"]:置方向(d)
		end
		if self.玩家["足迹_行走"] ~= nil then
			self.玩家["足迹_行走"]:置方向(d)
		end
		self.方向 = d
	end
end

function 场景类_玩家:更改染色(数据)
	 if self.锦衣~=nil and self.锦衣[1]~=nil then return end
	if 玩家显示开关 and 玩家加载开关 then
		self.玩家["静立"]:置染色(数据.染色方案,数据.染色组[1],数据.染色组[2],数据.染色组[3],0)
		self.玩家["行走"]:置染色(数据.染色方案,数据.染色组[1],数据.染色组[2],数据.染色组[3],0)
	end
end

function 场景类_玩家:设置动画(类型)
	table.insert(self.特效组,tp:载入特效(类型))
end

function 场景类_玩家:设置路径(数据)
    self.移动距离=数据.距离
	local a = 生成XY(math.floor(self.x / 20),math.floor(self.y / 20))
    if  self.飞行 then
		self.目标格子 = tp.场景.地图.寻路:飞行寻路(a,数据)
	else
	    self.目标格子 = tp.场景.地图.寻路:寻路(a,数据)
	end
	if self.目标格子 ~= nil and self.目标格子[1] ~= nil then
		self:取目标(self.目标格子[1],数据.id)
		self.移动=true
	else
		self.目标格子 = {}
	end
end

function 场景类_玩家:设置坐标(内容)
	self.x,self.y=内容.x,内容.y
	self:停止移动()
end



function 场景类_玩家:置人物模型()
	self.玩家.静立= nil
	self.玩家.行走 = nil
	self.玩家["武器_静立"] = nil
    self.玩家["武器_行走"] = nil
    self.玩家["武器_静立1"] = nil
	self.玩家["武器_行走1"] = nil
	self.玩家["坐骑_静立"] = nil
	self.玩家["坐骑_行走"] = nil
	self.玩家["坐骑饰品_静立"] = nil
	self.玩家["坐骑饰品_行走"] = nil
	self.祥瑞加速 = 1
	if self.坐骑 == nil or self.坐骑.模型 == nil then
		self.坐骑 = nil
	end

	if 玩家显示开关 then
		if self.离线摆摊 then
			self.飞行=false
			local 资源 = 引擎.取模型("小孩_飞儿")
			self.玩家 = {["静立"] = tp.资源:载入(资源[3],"网易WDF动画",资源[1]),["行走"] = tp.资源:载入(资源[3],"网易WDF动画",资源[2])}
			self.玩家.静立:置提速(0.25)
			self.玩家.行走:置提速(0.25)
			return
	   	end
		if self.坐骑  and self.坐骑.模型 and not self.摊位名称 and self.坐骑.祥瑞 then
			 self.祥瑞加速 = 1.15
		end

		if self.变身~=nil and  变身显示 and not self.摊位名称 then
			local 资源 = 引擎.取模型(self.变身)
			self.玩家 = {["静立"] = tp.资源:载入(资源[3],"网易WDF动画",资源[1]),["行走"] = tp.资源:载入(资源[3],"网易WDF动画",资源[2])}
			self.玩家.行走:置提速(1.25)
			if string.find(self.变身, "进阶") then
					local zl = 引擎.取战斗模型(self.变身.."_饰品")  ---这里显示宠物饰品的
					if zl~=nil and zl[10]~=nil then
						self.玩家["武器_静立"] = tp.资源:载入(zl[10],"网易WDF动画",zl[6])
						self.玩家["武器_行走"] = tp.资源:载入(zl[10],"网易WDF动画",zl[8])
						self.玩家["武器_行走"]:置提速(1.25)
					end
			 end
			if self.变异 and 染色信息[self.变身]~=nil then
					self.染色方案 = 染色信息[self.变身].id
					self.染色组 = 染色信息[self.变身].方案
					self:置染色(self.染色方案,self.染色组[1],self.染色组[2],self.染色组[3])
					self:置方向(self.方向)
			end



		elseif self.坐骑 ~= nil and self.坐骑.模型 and not self.摊位名称 and (not self.锦衣 or  not self.锦衣[1] or not self.锦衣[1].名称 or  屏蔽锦衣效果)  and 坐骑显示 then
				local 资源组 = {}
				if 引擎.新增坐骑(self.模型,self.坐骑.模型,"站立")  then
					资源组.人物资源 = "xzzq.wdf"
					资源组.人物站立 = 引擎.新增坐骑(self.模型,self.坐骑.模型,"站立")
					资源组.人物行走 = 引擎.新增坐骑(self.模型,self.坐骑.模型,"奔跑")
					资源组.坐骑资源 = "xzzq.wdf"
					资源组.坐骑行走 = 引擎.新增坐骑(self.模型,self.坐骑.模型,"奔跑")
					资源组.坐骑站立 = 引擎.新增坐骑(self.模型,self.坐骑.模型,"站立")
				else
					资源组 = 引擎.坐骑库(self.模型,self.坐骑.模型,self.坐骑.饰品 or "空")
				end
				if 资源组~=nil then
						self.玩家 = {["静立"] = tp.资源:载入(资源组.人物资源,"网易WDF动画",资源组.人物站立),["行走"] = tp.资源:载入(资源组.人物资源,"网易WDF动画",资源组.人物行走)}
						self.玩家["坐骑_静立"] = tp.资源:载入(资源组.坐骑资源,"网易WDF动画",资源组.坐骑站立)
						self.玩家["坐骑_行走"] = tp.资源:载入(资源组.坐骑资源,"网易WDF动画",资源组.坐骑行走)
						self.玩家.行走:置提速(1.25)
						self.玩家["坐骑_行走"]:置提速(1.25)
						-- if self.坐骑.染色方案~=nil and self.坐骑.染色组~=0 and #self.坐骑.染色组~=0 then
						-- 	self.玩家["坐骑_静立"]:置染色(self.坐骑.染色方案,self.坐骑.染色组[1],self.坐骑.染色组[2],self.坐骑.染色组[3])
						-- 	self.玩家["坐骑_行走"]:置染色(self.坐骑.染色方案,self.坐骑.染色组[1],self.坐骑.染色组[2],self.坐骑.染色组[3])
						-- end
						if 资源组 ~= nil and 资源组.坐骑饰品站立 ~= nil then
							self.玩家["坐骑饰品_静立"] = tp.资源:载入(资源组.坐骑饰品资源,"网易WDF动画",资源组.坐骑饰品站立)
							self.玩家["坐骑饰品_行走"] = tp.资源:载入(资源组.坐骑饰品资源,"网易WDF动画",资源组.坐骑饰品行走)
							self.玩家["坐骑饰品_行走"]:置提速(1.25)
							-- if self.坐骑.饰品物件~=nil and self.坐骑.饰品物件.染色方案~=nil and self.坐骑.饰品物件.染色组~=0 and #self.坐骑.饰品物件.染色组~=0 then
							-- 	self.玩家["坐骑饰品_静立"]:置染色(self.坐骑.饰品物件.染色方案,self.坐骑.饰品物件.染色组[1],self.坐骑.饰品物件.染色组[2],self.坐骑.饰品物件.染色组[3])
							-- 	self.玩家["坐骑饰品_行走"]:置染色(self.坐骑.饰品物件.染色方案,self.坐骑.饰品物件.染色组[1],self.坐骑.饰品物件.染色组[2],self.坐骑.饰品物件.染色组[3])
							-- end
						end
						self.玩家["武器_静立"] = nil
						self.玩家["武器_行走"] = nil
						self.玩家["武器_静立1"] = nil
						self.玩家["武器_行走1"] = nil
						坐骑补差x,坐骑补差y=0,0
				else
					local 资源 = 引擎.取模型(self.模型)
					 self.玩家 = {["静立"] = tp.资源:载入(资源[3],"网易WDF动画",资源[1]),["行走"] = tp.资源:载入(资源[3],"网易WDF动画",资源[2])}
					 self.玩家.行走:置提速(1.25)
				     if self.玩家ID<900000 then
						     self:置染色(self.染色方案,self.染色组[1],self.染色组[2],self.染色组[3])
					end
				end

		else



			local v = nil
			if self.武器 and self.武器.名称 then
				v = tp:取武器子类(self.武器.子类)
				if self.武器.名称 == "龙鸣寒水" or self.武器.名称 == "非攻" then
					v = "弓弩1"
				end
			end
			local 资源 = 引擎.取模型(self.模型,v)
			local 是否战斗锦衣 = false
			if self.锦衣~= nil and self.锦衣[1] ~= nil and self.锦衣[1].名称  and not 屏蔽锦衣效果 then
				   local 锦衣名称 = self.锦衣[1].名称
					if 锦衣名称=="青春" or 锦衣名称=="素颜" or 锦衣名称=="绝色" or 锦衣名称=="春秋" or  锦衣名称=="夏蚕"
					  or 锦衣名称=="星河" or 锦衣名称=="白峨" or 锦衣名称=="糖果" or 锦衣名称=="青涩" or 锦衣名称=="傲然"
					  or 锦衣名称=="牛仔" or  锦衣名称=="试剑" or 锦衣名称=="骨龙战骑" or 锦衣名称=="水嘟嘟·钻白" or 锦衣名称=="斗战神"
					  or  锦衣名称=="斗战胜佛" or  锦衣名称=="八部天龙马·玄" or  锦衣名称=="龙凰·桃" or  锦衣名称=="龙凰·皑" then
						资源 =引擎.取战斗锦衣素材(self.锦衣[1].名称,self.模型)
					    self.玩家 = {["静立"] = tp.资源:载入(资源[5],"网易WDF动画",资源[3]),["行走"] = tp.资源:载入(资源[5],"网易WDF动画",资源[4])}
					    是否战斗锦衣 = true
					elseif 新加战斗锦衣[锦衣名称]~=nil  then
						   local 模型类型 = 取角色锦衣武器类型(self.模型,v)
		                   资源 = 引擎.取武器锦衣素材(self.锦衣[1].名称,self.模型,模型类型)
		                   self.玩家 = {["静立"] = tp.资源:载入(资源[5],"网易WDF动画",资源[3]),["行走"] = tp.资源:载入(资源[5],"网易WDF动画",资源[4])}
					end
			else
		        self.玩家 = {["静立"] = tp.资源:载入(资源[3],"网易WDF动画",资源[1]),["行走"] = tp.资源:载入(资源[3],"网易WDF动画",资源[2])}
		       	if self.玩家ID<900000 then
				   self:置染色(self.染色方案,self.染色组[1],self.染色组[2],self.染色组[3])
				end
			end
			self.玩家.行走:置提速(1.25)

			if self.武器 and self.武器.名称 then
					local m = tp:取武器附加名称(self.武器.子类,self.武器.级别限制,self.武器.名称)
					local n = 引擎.取模型(m.."_"..self.模型)
					self.玩家["武器_静立"] = tp.资源:载入(n[3],"网易WDF动画",n[1])
					self.玩家["武器_行走"] = tp.资源:载入(n[3],"网易WDF动画",n[2])
					self.玩家["武器_行走"]:置提速(1.25)
					if self.武器.染色方案~=0 and self.武器.染色组~=0 and self.武器.染色组~=nil and #self.武器.染色组>0 and self.玩家ID<900000 then
					    self.玩家["武器_静立"]:置染色(self.武器.染色方案,self.武器.染色组[1],self.武器.染色组[2],self.武器.染色组[3])
					    self.玩家["武器_行走"]:置染色(self.武器.染色方案,self.武器.染色组[1],self.武器.染色组[2],self.武器.染色组[3])
					end
					self:置方向(self.方向)
					if 是否战斗锦衣 then
						self.玩家["武器_静立"] = nil
						self.玩家["武器_行走"] = nil
					end
			end

			if self.副武器 and self.副武器.名称 and self.模型=="影精灵" and string.find(self.副武器.名称,"(坤)") and (self.武器==nil or (self.武器.名称~=nil and string.find(self.武器.名称,"(乾)"))) then
					local n = 引擎.取模型(self.副武器.名称.."_"..self.模型)
					self.玩家["武器_静立1"] = tp.资源:载入(n[3],"网易WDF动画",n[1])
					self.玩家["武器_行走1"] = tp.资源:载入(n[3],"网易WDF动画",n[2])
					self.玩家["武器_行走1"]:置提速(1.25)
					if self.副武器.染色方案~=0 and self.副武器.染色组~=0 and self.副武器.染色组~=nil and #self.副武器.染色组>0 and self.玩家ID<900000  then
					    self.玩家["武器_静立1"]:置染色(self.副武器.染色方案,self.副武器.染色组[1],self.副武器.染色组[2],self.副武器.染色组[3])
					    self.玩家["武器_行走1"]:置染色(self.副武器.染色方案,self.副武器.染色组[1],self.副武器.染色组[2],self.副武器.染色组[3])
					end
					self:置方向(self.方向)
					if 是否战斗锦衣 then
						self.玩家["武器_静立1"] = nil
						self.玩家["武器_行走1"] = nil
					end
			end





			self.静止转移 = self.玩家.静立.帧数 <= 4 or (self.执行事件 == "明雷怪" or self.行走开关)
			if  self.锦衣~= nil and self.锦衣[2] ~= nil and self.锦衣[2].名称 ~= nil and not 屏蔽光环足迹效果 then
					self:穿戴光环()
			else
			    	self:卸下光环()
			end
			if self.锦衣~= nil and  self.锦衣[3] ~= nil and self.锦衣[3].名称 ~= nil  and not 屏蔽光环足迹效果 then
					self:穿戴足迹()
			else
			    	self:卸下足迹()
			end
		end
	end
end


function 场景类_玩家:穿戴光环()
		local n = 引擎.取光环(self.锦衣[2].名称)
		self.玩家["光环_静立"]=tp.资源:载入(n[4],"网易假人动画",n[1])
	    self.玩家["光环_行走"]=tp.资源:载入(n[4],"网易假人动画",n[2])
	    self.玩家["光环_行走"]:置提速(1.25)
	    self:置方向(self.方向)
end

function 场景类_玩家:卸下光环()
	self.玩家["光环_静立"] = nil
	self.玩家["光环_行走"] = nil
end

function 场景类_玩家:穿戴足迹()
	local n = 引擎.取足迹(self.锦衣[3].名称)
    self.玩家["足迹_行走"]=tp.资源:载入(n[4],"网易假人动画",n[1])
     self.玩家["足迹_行走"]:置提速(1.25)
    self:置方向(self.方向)
end

function 场景类_玩家:卸下足迹()
	self.玩家["足迹_行走"] = nil
end

function 场景类_玩家:置染色(染色方案,a,b,c)
	if not 玩家显示开关 and not 玩家加载开关 then
		return
	end
  if self.锦衣~=nil and self.锦衣[1]~=nil then return end
	self.玩家["静立"]:置染色(染色方案,a,b,c)
	if self.玩家.行走 ~= nil then
		self.玩家.行走:置染色(染色方案,a,b,c)
	end
	self:置方向(self.方向)
end

function 场景类_玩家:事件方向(a,b)
	if self.方向开关 then
		self:置方向(取八方向(math.floor(取两点角度(b,a))))
		tp.场景.人物:置方向(取八方向(math.floor(取两点角度(a,b))))
	else
		self:置方向(取四至八方向(取八方向(math.floor(取两点角度(b,a)))))
		tp.场景.人物:置方向(取八方向(math.floor(取两点角度(a,b))))
	end
end




function 场景类_玩家:卸载()
	if self.玩家 then
		if self.玩家["静立"] then
			self.玩家["静立"]:释放()
		end
		if self.玩家["行走"] then
			self.玩家["行走"]:释放()
		end
		if self.玩家["武器_静立"] then
			self.玩家["武器_静立"]:释放()
		end
		if self.玩家["武器_行走"] then
			self.玩家["武器_行走"]:释放()
		end
		if self.玩家["坐骑_静立"] then
			self.玩家["坐骑_静立"]:释放()
		end
		if self.玩家["坐骑_行走"] then
			self.玩家["坐骑_行走"]:释放()
		end
		if self.玩家["武器_静立"] then
			self.玩家["武器_静立"]:释放()
		end
		if self.玩家["武器_行走"] then
			self.玩家["武器_行走"]:释放()
		end
		if self.玩家["坐骑饰品_静立"] then
			self.玩家["坐骑饰品_静立"]:释放()
		end
		if self.玩家["坐骑饰品_行走"] then
			self.玩家["坐骑饰品_行走"]:释放()
		end
		if self.玩家["武器_静立1"] then
			self.玩家["武器_静立1"]:释放()
		end
		if self.玩家["武器_行走1"] then
			self.玩家["武器_行走1"]:释放()
		end
		if self.玩家["翅膀_静立"] then
			self.玩家["翅膀_静立"]:释放()
		end
		if self.玩家["翅膀_行走"] then
			self.玩家["翅膀_行走"]:释放()
		end
		if self.玩家["光环_行走"] then
			self.玩家["光环_行走"]:释放()
		end
		if self.玩家["光环_静立"] then
			self.玩家["光环_静立"]:释放()
		end
		if self.玩家["足迹_行走"] then
			self.玩家["足迹_行走"]:释放()
		end
	end

	--递归清空(self)

end


return 场景类_玩家