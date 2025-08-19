--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-03-06 04:18:18
--======================================================================--
local 系统类_物品格子 = class()
local tp,zt
local mouse = 引擎.鼠标弹起
local wps = 引擎.取物品

function 系统类_物品格子:初始化(x,y,ID,注释,遮挡)
	self.ID = ID
	self.注释 = 注释
	self.物品 = nil
	self.事件 = false
	self.焦点 = false
	self.右键 = false
	self.遮挡 = 遮挡
	self.确定 = false


	self.变身资源={
	野猪=0xEF3A830D,
	巨蛙=0x98E3377F,
	大海龟=0x3C7B89E8,
	树怪=0x4ED5C9C4,
	赌徒=0x6BE81A68,
	大蝙蝠=0x2481DFCC,
	强盗=0xD5C2566E,
	山贼=0x5F7346A8,
	海毛虫=0x3BD0B554,
	护卫=0x7003F174,
	海星=0xE709CDAD,
	章鱼=0xABB68989,
	浣熊=0xA60EB0D9,

	骷髅怪=0xD0BE29D3,
	羊头怪=0x8F19EF2A,
	黑熊=0xD4D2660A,
	蛤蟆精=0x8A53158C,
	狐狸精=0xDC14E699,
	花妖=0xD294444C,
	老虎=0x463F3E9B,

	牛妖=0x3AF799AA,
	小龙女=0xE05E7656,
	野鬼=0xB90EC617,
	狼=0x92B59426,
	虾兵=0xE89179D1,
	蟹将=0x65DBE48A,

    兔子怪=0xA1B8ACD0,
    蜘蛛精=0xD2C2093D,
    僵尸=0xC7B126C6,
    黑熊精=0x35BDCFC8,
	龟丞相=0x67E0006E,
    牛头=0x06971D21,
	马面=0xCA322977,

    古代瑞兽=0x7728C3B2,
	雷鸟人=0x4E646343,
	蝴蝶仙子=0x976975FB,
	白熊=0x7092E7F5,
	黑山老妖=0x95FDC90D,
	进阶古代瑞兽=0x7728C3B2,
	进阶雷鸟人=0x4E646343,
	进阶蝴蝶仙子=0x976975FB,
	进阶白熊=0x7092E7F5,
	进阶黑山老妖=0x95FDC90D,

	天兵=0x9AB7515F,
	天将=0x7E86C2A9,
	地狱战神=0xB5FE5920,
	风伯=0xDF2F3035,
	凤凰=0x2A4159F7,
    碧水夜叉=0x22B8518F,
    雨师=0xF53D7AE7,
    蚌精=0x4BAA9CBE,
    鲛人=0x0349DFA6,
	蛟龙=0xD4442C3A,
	进阶天兵=0x9AB7515F,
	进阶天将=0x7E86C2A9,
	进阶地狱战神=0xB5FE5920,
	进阶风伯=0xDF2F3035,
	进阶凤凰=0x2A4159F7,
    进阶碧水夜叉=0x22B8518F,
    进阶雨师=0xF53D7AE7,
    进阶蚌精=0x4BAA9CBE,
    进阶鲛人=0x0349DFA6,
	进阶蛟龙=0xD4442C3A,

	巡游天神=0xFD35D4E3,
	芙蓉仙子=0xBAFBFAA8,
	星灵仙子=0xD226E204,
	如意仙子=0x411A18C7,
	锦毛貂精=0xEABE811E,
	千年蛇魅=0x65D26225,
	百足将军=0xDC338F6E,
	犀牛将军人形=0x696AF38B,
	犀牛将军兽形=0xCABF6445,
	野猪精=0xF1127EEA,
	鼠先锋=0xDC338F6E,
	泪妖=0xA22EBC2E,
	镜妖=0x0A545E77,
	阴阳伞=0x60AC19B3,
	进阶巡游天神=0xFD35D4E3,
	进阶芙蓉仙子=0xBAFBFAA8,
	进阶星灵仙子=0xD226E204,
	进阶如意仙子=0x411A18C7,
	进阶锦毛貂精=0xEABE811E,
	进阶千年蛇魅=0x65D26225,
	进阶百足将军=0xDC338F6E,
	进阶犀牛将军人形=0x696AF38B,
	进阶犀牛将军兽形=0xCABF6445,
	进阶野猪精=0xF1127EEA,
	进阶鼠先锋=0xDC338F6E,
	进阶泪妖=0xA22EBC2E,
	进阶镜妖=0x0A545E77,
	进阶阴阳伞=0x60AC19B3,

	律法女娲=0x4ED64302,
	炎魔神=0xB9917494,
	画魂=0xB73FB904,
	灵符女娲=0x5726FB84,
	吸血鬼=0x9D5FA3EC,
	巴蛇=0xBE748368,
	净瓶女娲=0x7E99A5F4,
	踏云兽=0xC6F3C665,
	龙龟=0x964E7FB8,
	红萼仙子=0x2D0D5755,
	噬天虎=0x8DC23CAE,
	灵鹤=0xACEF8DB7,
	大力金刚=0x64287AE7,
	机关鸟=0x8423434C,
	鬼将=0x023AA63E,
	葫芦宝贝=0x48E257D4,
	机关人=0xEA888609,
	幽灵=0x62875401,
	幽萤娃娃=0xD576EDF9,
	雾中仙=0xA88F486E,
	夜罗刹=0xAB1EFFB3,
	连弩车=0xD123A916,
	机关兽=0x9655B4E8,
	琴仙=0x3C3F4DB7,
	金铙僧=0xA8259D75,
	进阶律法女娲=0x4ED64302,
	进阶炎魔神=0xB9917494,
	进阶画魂=0xB73FB904,
	进阶灵符女娲=0x5726FB84,
	进阶吸血鬼=0x9D5FA3EC,
	进阶巴蛇=0xBE748368,
	进阶净瓶女娲=0x7E99A5F4,
	进阶踏云兽=0xC6F3C665,
	进阶龙龟=0x964E7FB8,
	进阶红萼仙子=0x2D0D5755,
	进阶噬天虎=0x8DC23CAE,
	进阶灵鹤=0xACEF8DB7,
	进阶大力金刚=0x64287AE7,
	进阶机关鸟=0x8423434C,
	进阶鬼将=0x023AA63E,
	进阶葫芦宝贝=0x48E257D4,
	进阶机关人=0xEA888609,
	进阶幽灵=0x62875401,
	进阶幽萤娃娃=0xD576EDF9,
	进阶雾中仙=0xA88F486E,
	进阶夜罗刹=0xAB1EFFB3,
	进阶连弩车=0xD123A916,
	进阶机关兽=0x9655B4E8,
	进阶琴仙=0x3C3F4DB7,
	进阶金铙僧=0xA8259D75,

    混沌兽=0xA416C496,
    猫灵人形=0x9ED7CAA8,
	猫灵兽形=0x4C82A29E,
	狂豹人形=0x5579CC03,
	狂豹兽形=0xD20879BD,
	蝎子精=0x07B74E81,
	蜃气妖=0x904F2844,
	曼珠沙华=0xEA0AD25A,
	长眉灵猴=0xBE6EDEDE,
	巨力神猿=0x99FACF23,
	金身罗汉=0xB1B68D86,
	蔓藤妖花=0x5BC38FA5,
	修罗傀儡鬼=0x4D34C63C,
	修罗傀儡妖=0x5E499D7E,
	毗舍童子=0x29A568DE,
	持国巡守=0xE13AF8E0,
	真陀护法=0x021526EC,
	增长巡守=0xCCD35C11,
	灵灯侍者=0x275209D3,
	般若天女=0xC020441E,
	进阶混沌兽=0xA416C496,
    进阶猫灵人形=0x9ED7CAA8,
	进阶猫灵兽形=0x4C82A29E,
	进阶狂豹人形=0x5579CC03,
	进阶狂豹兽形=0xD20879BD,
	进阶蝎子精=0x07B74E81,
	进阶蜃气妖=0x904F2844,
	进阶曼珠沙华=0xEA0AD25A,
	进阶长眉灵猴=0xBE6EDEDE,
	进阶巨力神猿=0x99FACF23,
	进阶金身罗汉=0xB1B68D86,
	进阶蔓藤妖花=0x5BC38FA5,
	进阶修罗傀儡鬼=0x4D34C63C,
	进阶修罗傀儡妖=0x5E499D7E,
	进阶毗舍童子=0x29A568DE,
	进阶持国巡守=0xE13AF8E0,
	进阶真陀护法=0x021526EC,
	进阶增长巡守=0xCCD35C11,
	进阶灵灯侍者=0x275209D3,
	进阶般若天女=0xC020441E,
	}

end

function 系统类_物品格子:置根(根)
	tp = 根
	zt = tp.字体表.描边字体_
	-- zt1 =tp.字体表.老摩托字体
end

function 系统类_物品格子:置物品(物品)
	self.选中=nil
	if 物品 ~= nil then
		if 物品.名称 ~= 0 then
			--self.物品 = 物品
			local item = tp._物品.创建()
			item:置对象(物品.名称)
			self.物品= item
			for n, v in pairs(物品) do
              self.物品[n]=v
		  	end
		  	local 返回值 = 引擎.取同名物品(物品.名称,物品.子类,物品.类型,物品.等级)
		  	if not 判断是否为空表(返回值) then
				self.物品.资源 = 返回值[5] or 返回值[1]
				self.物品.小模型资源 = 返回值[2]
				if 返回值[5] then
					self.物品.url = 返回值[1]
					self.物品.小模型资源 = 返回值[4]
				end
				self.物品.大模型资源 = 返回值[3]
				if 返回值[6] then
					self.物品.pyz = 返回值[6]
				end
			end
			if 物品.名称=="怪物卡片" then
				self.物品.小模型id="物品图标.wdf"
				self.物品.资源="物品图标.wdf"
				if 物品.等级==1 then
					self.物品.小模型资源=0x4A028BEE
				elseif 物品.等级==2 then
					self.物品.小模型资源=0xBB35E1EE
				elseif 物品.等级==3 then
					self.物品.小模型资源=0xE7FC64D2
				elseif 物品.等级==4 then
					self.物品.小模型资源=0xA00740F6
				elseif 物品.等级==5 then
					self.物品.小模型资源=0x21838782
				elseif 物品.等级==6 then
					self.物品.小模型资源=0xF1C84EB5
				elseif 物品.等级==7 then
					self.物品.小模型资源=0xEFA4BA2C
				elseif 物品.等级==8 then
					self.物品.小模型资源=0x2E030271
			    elseif 物品.等级==9 then
					self.物品.小模型资源=0x2E030271
				end
				self.物品.大模型资源=self.变身资源[物品.造型]
			end
			if self.物品.小模型 == nil then
              self.物品.小模型 = tp.资源:载入(self.物品.小模型id or self.物品.资源,"网易WDF动画",self.物品.小模型资源)
			end
		end
	else
		self.物品 = nil
	end
	if self.物品~=nil then
		if self.物品.回合~=nil then
			self:置灰色()
		end
	end
end

function 系统类_物品格子:置灰色()
	if self.物品~=nil and self.物品.小模型~=nil then
		self.物品.小模型:灰度级()
	end
end

-- function 系统类_物品格子:显示(dt,x,y,条件,总类,xx,yy,abs)
-- 	if self.确定 or self.选中 then
-- 		tp.物品格子确定_:显示(self.x+1,self.y+2)
-- 	end
-- 	self.事件 = false
-- 	self.焦点 = false
-- 	self.右键 = false
-- 	if self.物品 ~= nil then
-- 		if self.遮挡 ~= nil then
-- 			self.遮挡:显示(self.x-1+(xx or 0),self.y+4+(yy or 0))
-- 		end
-- 		self.物品.小模型:显示(self.x-1,self.y+2)
-- 		if self.物品.回合~=nil then
-- 			local 数量=string.len(tostring(self.物品.回合))
-- 			for i=1,数量 do
-- 				local 序列=string.sub(self.物品.回合,i,i)-1
-- 				if 战斗类.法宝图片[序列]~=nil then
-- 					战斗类.法宝图片[序列]:显示(self.x-数量*2-数量*1.5+20,self.y+20)
-- 				end
-- 			end
-- 		end
-- 		if self.物品.可叠加 and 总类 == nil then
-- 			zt:置颜色(4294967295)
-- 			zt:置描边颜色(-16777216)
-- 			zt:显示(self.x + 3,self.y + 3,self.物品.数量)
-- 		end
--      local 自适应 = tp._自适应
-- 		if not self.物品.可叠加 and 总类 == nil and 自适应 then
-- 			zt:置颜色(白色)
-- 			zt:显示(self.x + -1,self.y + 30,self.物品.附带技能)
-- 		end
-- 		if ((总类 and 总类 ~= false) and self.物品.总类 ~= 总类[1] and self.物品.总类 ~= 总类[2] and (总类[3]==nil or 总类[3]==false)) then
-- 			tp.物品格子禁止_:显示(self.x + 5,self.y + 6)
-- 		end
-- 	end
-- 	if not tp.消息栏焦点 then
-- 		if x>=self.x and x<=self.x+50 and y>=self.y and y<=self.y+50 and 条件 then
-- 			tp.按钮焦点 = true
-- 			tp.禁止关闭 = true
-- 			if mouse(0) then
-- 				self.事件 = true
-- 			elseif mouse(1) then
-- 				self.右键 = true
-- 			end
-- 			if self.格子显示 == nil then
-- 				if self.物品 and self.物品.大模型 == nil then
-- 					self.物品.大模型 = tp.资源:载入(self.物品.资源,"网易WDF动画",self.物品.大模型资源)
-- 				end
-- 				if abs == nil then
-- 					tp.物品格子焦点_:显示(self.x+1,self.y+1)
-- 				end
-- 			end
-- 			self.焦点 = true
-- 		end
-- 	end
-- end
function 系统类_物品格子:显示(dt,x,y,条件,总类,xx,yy,abs,numb)
	if self.确定 or self.选中 then
		tp.物品格子确定_:显示(self.x+1,self.y+2)
	end
	self.事件 = false
	self.焦点 = false
	self.右键 = false
	if self.物品 ~= nil then
		if self.遮挡 ~= nil then
			self.遮挡:显示(self.x-1+(xx or 0),self.y+4+(yy or 0))
		end
		local pyx,pyy = 0,0
		if self.物品.pyz~=nil then
			self.物品.小模型:更新(dt)
			pyx,pyy = self.物品.pyz[1],self.物品.pyz[2]
		end
		if self.物品.装备境界 and self.物品.装备境界.品质 ~="普通" then
			if self.物品.装备境界.品质 =="优秀" then
					tp.绿装底图:显示(self.x-1+pyx,self.y+2+pyy)
			elseif self.物品.装备境界.品质 =="稀有" then
					tp.蓝装底图:显示(self.x-1+pyx,self.y+2+pyy)
			elseif self.物品.装备境界.品质 =="传说" then
					tp.橙装底图:显示(self.x-1+pyx,self.y+2+pyy)
			elseif self.物品.装备境界.品质 =="神话" then
					tp.红装底图:显示(self.x-1+pyx,self.y+2+pyy)
			end


		end
		self.物品.小模型:显示(self.x-1+pyx,self.y+2+pyy)
		if self.物品.回合~=nil then
			local 数量=string.len(tostring(self.物品.回合))
         	for i=1,数量 do
				local 序列=string.sub(self.物品.回合,i,i)-1
				if 战斗类~=nil and 战斗类.法宝图片[序列]~=nil then
					战斗类.法宝图片[序列]:显示(self.x-数量*2-数量*1.5+20,self.y+20)
				end
     	 	end
	 	end
	 	if self.物品.可叠加 and self.物品.数量 ~= nil then
			zt:置颜色(4294967295)
			zt:置描边颜色(-16777216)
			zt:显示(self.x + 3,self.y + 3,self.物品.数量)
		end
     	local 自适应 = tp._自适应
     	if not self.物品.可叠加 and 自适应 then
     		zt:置颜色(白色)
			if 总类 == nil and self.物品.附带技能~=nil and string.find(self.物品.附带技能,"随机")==nil then
					local 显示技能 =self.物品.附带技能
				    if string.find(self.物品.附带技能,"高级")~=nil then
				   		local 临时取出= 分割文本(self.物品.附带技能,"高级")
				   		if type(临时取出)=="table" and 临时取出[2] then
				   			显示技能 =临时取出[2]
				   		end
				   	elseif string.find(self.物品.附带技能,"超级")~=nil then
				   			local 临时取出= 分割文本(self.物品.附带技能,"超级")
					   		if type(临时取出)=="table" and 临时取出[2] then
					   			显示技能 =临时取出[2]
					   		end
				   end
				   zt:显示(self.x+math.floor((49-zt:取宽度(显示技能))/2),self.y + 30,显示技能)
			elseif (self.物品.名称 == "藏宝图" or self.物品.名称 == "高级藏宝图") and  self.物品.地图名称~=nil and string.find(self.物品.地图名称,"随机")==nil then
					zt:显示(self.x+math.floor((49-zt:取宽度(self.物品.地图名称))/2),self.y + 30,self.物品.地图名称)
			elseif (self.物品.名称 == "百炼精铁" or self.物品.名称 == "元灵晶石") and  self.物品.子类~=nil then
					zt:显示(self.x+math.floor((49-zt:取宽度(self.物品.子类.."级"))/2),self.y + 30,self.物品.子类.."级")
			elseif (self.物品.名称 == "制造指南书" or self.物品.名称 == "灵饰指南书")and self.物品.特效~=nil and self.物品.子类~=nil then
					local it = self.物品.特效
					if self.物品.名称 == "制造指南书" then
						it = tp:取武器子类(self.物品.特效)
					end
					zt:显示(self.x + math.floor((49-zt:取宽度(self.物品.子类.."级"))/2),self.y + 30,self.物品.子类.."级")
					zt:显示(self.x + math.floor((49-zt:取宽度(it))/2),self.y + 15,it)
			elseif self.物品.总类 == 5 and self.物品.分类== 6 and self.物品.级别限制~=nil then
					zt:显示(self.x+math.floor((49-zt:取宽度(self.物品.级别限制.."级"))/2),self.y + 30,self.物品.级别限制.."级")

			elseif (self.物品.名称 == "炼妖石" or self.物品.名称 == "天眼珠") and self.物品.级别限制~=nil then
					zt:显示(self.x+math.floor((49-zt:取宽度(self.物品.级别限制.."级"))/2),self.y + 30,self.物品.级别限制.."级")
			elseif self.物品.名称 == "上古锻造图策" and self.物品.级别限制~=nil and self.物品.种类~=nil then
					zt:显示(self.x+math.floor((49-zt:取宽度(self.物品.级别限制.."级"))/2),self.y + 30,self.物品.级别限制.."级")
					zt:显示(self.x+math.floor((49-zt:取宽度(self.物品.种类))/2),self.y + 15,self.物品.种类)
			end
		end





		if self.物品.鉴定 and self.物品.专用~= nil and self.物品.专用 and self.物品.总类==2  and self.物品.分类<=13  then
            tp.专用:显示(self.x-2,self.y+3)
         end
         if self.物品.加锁~= nil  then
            tp.加锁图标:显示(self.x+35,self.y+3)
         end

		if 总类 then
			if type(总类)=="table" then
				if self.物品.总类 ~= 总类[1] and self.物品.总类 ~= 总类[2] and (总类[3]==nil or 总类[3]==false) then
					tp.物品格子禁止_:显示(self.x + 5,self.y + 6)
			    end
			else
			    if 总类 == true  then
			    	tp.物品格子禁止_:显示(self.x + 5,self.y + 6)
			    end
			end
	    end



	end
	if not tp.消息栏焦点 then
		if x>=self.x and x<=self.x+50 and y>=self.y and y<=self.y+50 and 条件 then
			tp.按钮焦点 = true
			tp.禁止关闭 = true
			if mouse(0) then
				self.事件 = true
			elseif mouse(1) then
				self.右键 = true
			end
			if self.格子显示 == nil then
				if self.物品 and self.物品.大模型 == nil then
					if self.物品.url~=nil then
						self.物品.大模型 = tp.资源:载入(self.物品.url,"网易WDF动画",self.物品.大模型资源)
					else
						self.物品.大模型 = tp.资源:载入(self.物品.资源,"网易WDF动画",self.物品.大模型资源)
					end
				end
				if abs == nil then
					tp.物品格子焦点_:显示(self.x+1,self.y+1)
				end
			end
			self.焦点 = true
		end
	end
end

function 系统类_物品格子:置坐标(x,y)
	self.x,self.y = x,y
end

return 系统类_物品格子