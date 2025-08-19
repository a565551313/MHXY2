--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2022-08-28 12:03:04
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 游戏公告类 = class()

function 游戏公告类:初始化(根)
    self.x=全局游戏宽度
    self.y=20
    self.丰富文本=根._丰富文本(9999,25)
    self.数据组={}
    self.显示开关=false
    for n=0,120 do
        self.丰富文本:添加元素(n,根.包子表情动画[n])
    end
    self.提示 = require("script/显示类/游戏提示类")(根)
    -- self.提示:置宽高(1050,25)
end

function 游戏公告类:添加公告(内容)
    self.数据组[#self.数据组+1]="#Y"..内容
    if self.显示开关==false then
        self.显示开关=true
        self.x=全局游戏宽度
        self.丰富文本:清空()
        self.丰富文本:添加文本(self.数据组[1])
    end
end

function 游戏公告类:更新(dt)

end

function 游戏公告类:显示(x,y)
    if self.显示开关 then
        self.x=self.x-1
        self.提示:显示(全局游戏宽度+50,1,-10,52)
        self.丰富文本:显示(self.x,self.y+35)
        if self.x<0 and math.abs(self.x)>=#self.数据组[1]*5  then
            self.x=全局游戏宽度
            table.remove(self.数据组,1)
            if #self.数据组==0 then
                self.显示开关=false
                self.丰富文本:清空()
            else
                self.丰富文本:清空()
                self.丰富文本:添加文本(self.数据组[1])
            end
        end
    end
end

return 游戏公告类