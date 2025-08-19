local 神器获得 = class()
local tp,zts1
local insert = table.insert
local jl = require("gge精灵类")
local 神器模型 = {
		神木林 = {"018013AE","48A22679","27504873"}, --树枝，月亮，树叶
		天宫 = {"290ACCB0","B2A9682E","C68841B3"}, --上,身，尾
        盘丝洞 = {"131B5F07","507F5020","D2EAC261"}, --镜面，上，下
		凌波城 = {"9B10DFD8","65BB498B","3AAA5BED"}, --身子，头，底部
		女儿村 = {"909F588F","14488877","F57FB4C6"}, --碗右，中，左
		无底洞 = {"F991023F","16E503E3","4428166E"}, --上，中，下
		狮驼岭 = {"7A43A176","8167254F","3BECCD5C"}, --上，中，下
		阴曹地府 = {"64DDB00C","523D76AB","D02AC1C7"}, --上，中，脚
		大唐官府 = {"828B7E27","780B0000","52E6A411"}, --剑柄，剑身，剑鞘 --剑身没有
		化生寺 = {"E2F71BD1","DA956848","5CC81540"}, --吊坠，身，鼻毛
		龙宫 = {"6EDC07C1","C7A953A8","F288E253"}, --左，中，右
		五庄观 = {"A00DD3E7","E1CF43ED","DE964585"}, --外圈，中圈，中外圈
		魔王寨 = {"FDF8D071","FDF8D071","FDF8D071"}, --没有
		普陀山 = {"FDF8D071","FDF8D071","FDF8D071"}, --没有
		花果山 = {"FDF8D071","FDF8D071","FDF8D071"}, --没有
		方寸山 = {"FDF8D071","FDF8D071","FDF8D071"}, --没有
		九黎城 = {"FDF8D071","FDF8D071","FDF8D071"}, --没有
	}

local 神器渲染背景 = {
		神木林 = "92A0D697",
		凌波城 = "087BEF28",
		盘丝洞 = "D9EC5E82",
		女儿村 = "5E688B50",
		无底洞 = "8CBAED1B",
		天宫   = "6918E30A",
		狮驼岭 = "FAF8A22D",
		阴曹地府 = "97E88B79",
		方寸山 = "69C5B0D1",
		魔王寨 = "FD1F847B",
		普陀山 = "119883BC",
		大唐官府 = "754D40E2",
		化生寺 = "5587BEF3",
		龙宫   = "F9A0A6B9",
		五庄观 = "5E4F6929",--"A20D7D9D",--5E4F6929--两个
	}

local 神器底图 = {
		神木林 = "4902C991",
		凌波城 = "37364FA2",
		女儿村 = "350639BB",
		无底洞 = "A40E6707",
		天宫   = "B7F12AC8",
		大唐官府 = "593B5349",
		方寸山 = "C8326D89",
		魔王寨 = "F244CEF3",
		五庄观 = "5E4F6929",
	}

function 神器获得:初始化(根)
	self.ID = 138
	self.x =180--(全局游戏宽度/2)-200
	self.y =50-- (全局游戏高度/2)-170
	self.xx = 0
	self.yy = 0
	self.注释 = "神器获得"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = false
	self.窗口时间 = 0
	tp = 根
end


function 神器获得:打开(mp)
	if self.可视 then
		self.可视 = false
		self.资源组 = nil
		self.神器渲染 =nil
		self.神器光源 =nil
		self.神器拼接 =nil
		self.纯色背景 =nil
		self.计时 = nil
		return
	else
		insert(tp.窗口_,self)
		-- dasdasw=0
		-- locla 测试门派={"神木林","天宫","盘丝洞","凌波城","女儿村","无底洞","狮驼岭","阴曹地府","大唐官府","化生寺","龙宫","五庄观","魔王寨","普陀山","花果山","方寸山"}
		-- dasdasw=dasdasw+1
		-- self.门派=测试门派[dasdasw]
		-- print(mp)
		self.门派=mp
		self:加载资源()
		self.计时=250
		tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end

function 神器获得:加载资源()
	local 资源 = tp.资源
	self.纯色背景 = jl(0,0,0,全局游戏宽度+500,全局游戏高度+300)
	self.纯色背景:置颜色(-1189208494)
	self.资源组 = {
		[1] = 资源:载入('新加界面.npk',"网易WDF动画","013253E7"), --五庄观的棋子
	}
	if self.门派=="普陀山" then
		self.资源组[13] = 资源:载入('wdf/pic/神器素材/pt1.png',"图片") -- 云
		self.资源组[14] = 资源:载入('wdf/pic/神器素材/pt2.png',"图片")--zip:取精灵([[pt2.png]]) -- 蛋下
		self.资源组[15] = 资源:载入('wdf/pic/神器素材/pt3.png',"图片")--zip:取精灵([[pt3.png]]) -- 蛋上
		self.资源组[16] = 资源:载入('wdf/pic/神器素材/pt11.png',"图片")--zip:取精灵([[pt11.png]]) -- 云
		self.资源组[17] = 资源:载入('wdf/pic/神器素材/pt22.png',"图片")--zip:取精灵([[pt22.png]]) -- 蛋下
		self.资源组[18] = 资源:载入('wdf/pic/神器素材/pt33.png',"图片")--zip:取精灵([[pt33.png]]) -- 蛋上
    elseif self.门派=="魔王寨" then
		self.资源组[19] = 资源:载入('wdf/pic/神器素材/mw1.png',"图片")--zip:取精灵([[mw1.png]]) -- 大圈
		self.资源组[20] = 资源:载入('wdf/pic/神器素材/mw2.png',"图片")--zip:取精灵([[mw2.png]]) -- 火苗
		self.资源组[21] = 资源:载入('wdf/pic/神器素材/mw3.png',"图片")--zip:取精灵([[mw3.png]]) -- S
		self.资源组[22] = 资源:载入('wdf/pic/神器素材/mw11.png',"图片")--zip:取精灵([[mw11.png]]) -- 大圈
		self.资源组[23] = 资源:载入('wdf/pic/神器素材/mw22.png',"图片")--zip:取精灵([[mw22.png]]) -- 火苗
		self.资源组[24] = 资源:载入('wdf/pic/神器素材/mw33.png',"图片")--zip:取精灵([[mw33.png]]) -- S
	elseif self.门派=="方寸山" then
		self.资源组[25] = 资源:载入('wdf/pic/神器素材/fc1.png',"图片")--zip:取精灵([[fc1.png]]) -- 衣
		self.资源组[26] = 资源:载入('wdf/pic/神器素材/fc2.png',"图片")--zip:取精灵([[fc2.png]]) -- 领
		self.资源组[27] = 资源:载入('wdf/pic/神器素材/fc3.png',"图片")--zip:取精灵([[fc3.png]]) -- 肩膀
		self.资源组[28] = 资源:载入('wdf/pic/神器素材/fc11.png',"图片")--zip:取精灵([[fc11.png]]) -- 衣
		self.资源组[29] = 资源:载入('wdf/pic/神器素材/fc22.png',"图片")--zip:取精灵([[fc22.png]]) -- 领
		self.资源组[30] = 资源:载入('wdf/pic/神器素材/fc33.png',"图片")--zip:取精灵([[fc33.png]]) -- 肩膀
	elseif self.门派=="花果山" then
		self.资源组[31] = 资源:载入('wdf/pic/神器素材/hg1.png',"图片")--zip:取精灵([[hg1.png]]) -- 云
		self.资源组[32] = 资源:载入('wdf/pic/神器素材/hg2.png',"图片")--zip:取精灵([[hg2.png]]) -- 下
		self.资源组[33] = 资源:载入('wdf/pic/神器素材/hg3.png',"图片")--zip:取精灵([[hg3.png]]) -- 上
		self.资源组[34] = 资源:载入('wdf/pic/神器素材/hg11.png',"图片")--zip:取精灵([[hg11.png]]) -- 云
		self.资源组[35] = 资源:载入('wdf/pic/神器素材/hg22.png',"图片")--zip:取精灵([[hg22.png]]) -- 下
		self.资源组[36] = 资源:载入('wdf/pic/神器素材/hg33.png',"图片")--zip:取精灵([[hg33.png]]) -- 上
	elseif self.门派=="九黎城" then
		self.资源组[37] = 资源:载入('wdf/pic/神器素材/mxjs.png',"图片")--zip:取精灵([[hg1.png]]) -- 云
		self.资源组[38] = 资源:载入('wdf/pic/神器素材/mxjz.png',"图片")--zip:取精灵([[hg2.png]]) -- 下
		self.资源组[39] = 资源:载入('wdf/pic/神器素材/mxjm.png',"图片")--zip:取精灵([[hg3.png]]) -- 上

	end
	self.神器拼接 = {图片={}}
	if self.门派~="无" and self.门派~="花果山" then
		if 神器渲染背景[self.门派]~=nil then
		    self.神器渲染 = tp.资源:载入('新加界面.npk',"网易WDF动画",神器渲染背景[self.门派])
		end
		if 神器底图[self.门派]~=nil then
		    self.神器光源 = tp.资源:载入('新加界面.npk',"网易WDF动画",神器底图[self.门派])
		end
	end
	if self.门派~="无" then
		for n=1,3 do
			self.神器拼接.图片[n] = tp.资源:载入("新加界面.npk","网易WDF动画",神器模型[self.门派][n])
		end
	end
end


function 神器获得:显示(dt,x,y)
	self.焦点= false
	self.纯色背景:显示(0,0)
	if self.门派~="无" then
    	if self.门派=="神木林" then
    		self.神器光源:显示(self.x + 109,self.y + 30) --发光圆圈
    		self.神器拼接.图片[1]:显示(self.x + 260,self.y + 67) --,nil,nil,nil,true,4) ,nil,nil,nil,true,2
    		self.神器渲染:显示(self.x + 110,self.y + 29)
			self.神器拼接.图片[2]:显示(self.x + 234,self.y + 137)
			self.神器拼接.图片[3]:显示(self.x + 203,self.y + 134)
		elseif self.门派=="大唐官府" then
			self.神器渲染:显示(self.x + 73,self.y + 50)
			self.神器拼接.图片[3]:显示(self.x + 119,self.y + 240)
			self.神器光源:显示(self.x + 75,self.y + 45) --龙
			self.神器拼接.图片[2]:显示(self.x + 39,self.y + 191) --暗剑身
		    self.神器拼接.图片[1]:显示(self.x + 260,self.y + 114)
	    elseif self.门派=="化生寺" then
		    self.神器渲染:显示(self.x + 53,self.y + 32)
		    self.神器拼接.图片[3]:显示(self.x + 86,self.y + 216)
			self.神器拼接.图片[2]:显示(self.x + 201,self.y + 70)
		    self.神器拼接.图片[1]:显示(self.x + 336,self.y + 136)
	    elseif self.门派=="女儿村" then
		    self.神器渲染:显示(self.x + 78,self.y + 12)
		    self.神器拼接.图片[3]:显示(self.x + 108,self.y + 155)
		    self.神器拼接.图片[2]:显示(self.x + 193,self.y + 185)
		    self.神器拼接.图片[1]:显示(self.x + 146,self.y + 63)
		    self.神器光源:显示(self.x + 80,self.y + 10)
	    elseif self.门派=="方寸山" then
			self.神器渲染:显示(self.x + 111,self.y + 18)
			self.资源组[25]:显示(self.x + 96,self.y + 65)
			self.资源组[26]:显示(self.x + 96,self.y + 65)
			self.资源组[27]:显示(self.x + 96,self.y + 65)
			self.神器光源:显示(self.x + 114,self.y + 13)
	    elseif self.门派=="龙宫" then
	    	self.神器渲染:显示(self.x + 108,self.y + 18)
		    self.神器拼接.图片[3]:显示(self.x + 76,self.y + 71)
		    self.神器拼接.图片[2]:显示(self.x + 232,self.y + 66)
		    self.神器拼接.图片[1]:显示(self.x + 127,self.y + 66)
	    elseif self.门派=="普陀山" then
		    self.神器渲染:显示(self.x + 138,self.y + 25)
            self.资源组[14]:显示(self.x + 126,self.y + 33) --2
            self.资源组[15]:显示(self.x + 126,self.y + 33) --3
            self.资源组[13]:显示(self.x + 126,self.y + 33) --1
	    elseif self.门派=="五庄观" then
    		self.神器渲染:显示(self.x + 88,self.y + 44)
		    self.神器拼接.图片[3]:显示(self.x + 153,self.y + 159)
		    self.神器拼接.图片[1]:显示(self.x + 156,self.y + 86)--外圈，中圈，中外圈
		    self.神器拼接.图片[2]:显示(self.x + 193,self.y + 186)
		    self.神器光源:显示(self.x + 88,self.y + 41)
		    self.资源组[1]:显示(self.x + 89,self.y + 42)  --五庄观的棋子
	    elseif self.门派=="天宫" then
	    	self.神器渲染:显示(self.x + 108,self.y + 46)
		    self.神器拼接.图片[3]:显示(self.x + 177,self.y + 232) --尾
		    self.神器拼接.图片[2]:显示(self.x + 121,self.y + 122) --身
		    self.神器拼接.图片[1]:显示(self.x + 277,self.y + 66) --上
		    self.神器光源:显示(self.x + 114,self.y + 43)
	    elseif self.门派=="凌波城" then
	    	self.神器光源:显示(self.x + 88,self.y + 45)
		    self.神器拼接.图片[3]:显示(self.x + 104,self.y + 201) --底部
		    self.神器拼接.图片[2]:显示(self.x + 148,self.y + 91) --头
		    self.神器拼接.图片[1]:显示(self.x + 183,self.y + 66) ----身子，头，底部
		    self.神器渲染:显示(self.x + 85,self.y + 48)
	    elseif self.门派=="狮驼岭" then
			self.神器拼接.图片[3]:显示(self.x + 213,self.y + 239)
			self.神器拼接.图片[2]:显示(self.x + 150,self.y + 143)
			self.神器拼接.图片[1]:显示(self.x + 135,self.y + 60)--上，中，下
			self.神器渲染:显示(self.x + 83,self.y + 47)
	    elseif self.门派=="魔王寨" then
			self.神器光源:显示(self.x + 88,self.y + 45)
			self.资源组[19]:显示(self.x + 96,self.y + 33)
			self.资源组[20]:显示(self.x + 96,self.y + 33)
			self.资源组[21]:显示(self.x + 96,self.y + 33)
	    elseif self.门派=="阴曹地府" then
		    self.神器拼接.图片[3]:显示(self.x + 151,self.y + 261)
			self.神器拼接.图片[2]:显示(self.x + 165,self.y + 173)
			self.神器拼接.图片[1]:显示(self.x + 115,self.y + 126)--上，中，脚
			self.神器渲染:显示(self.x + 88,self.y + 29)
	    elseif self.门派=="无底洞" then
		    self.神器拼接.图片[3]:显示(self.x + 137,self.y + 238)
			self.神器拼接.图片[2]:显示(self.x + 234,self.y + 151)
			self.神器拼接.图片[1]:显示(self.x + 323,self.y + 60)--上，中，下
			self.神器渲染:显示(self.x + 118,self.y + 28)
			self.神器光源:显示(self.x + 116,self.y + 33)
		elseif self.门派=="盘丝洞" then
			self.神器渲染:显示(self.x + 97,self.y + 23)
			self.神器拼接.图片[1]:显示(self.x + 165,self.y + 120)--镜面，上，下
			self.神器拼接.图片[3]:显示(self.x + 138,self.y + 189)
			self.神器拼接.图片[2]:显示(self.x + 125,self.y + 53)
	    elseif self.门派=="花果山" then
			self.资源组[32]:显示(self.x + 96,self.y + 37)
			self.资源组[33]:显示(self.x + 96,self.y + 37)
			self.资源组[31]:显示(self.x + 96,self.y + 37)
		elseif self.门派=="九黎城" then
			self.资源组[37]:显示(self.x + 96,self.y + 37)
			self.资源组[38]:显示(self.x + 96,self.y + 37)
			self.资源组[39]:显示(self.x + 96,self.y + 37)
    	end
	end
	self.计时=self.计时-1
    if self.计时<1 or not self.计时 then
        self:打开()
        return
    end
end


function 神器获得:检查点(x,y)
	return false
end

function 神器获得:初始移动(x,y)
end

function 神器获得:开始移动(x,y)
end

return 神器获得