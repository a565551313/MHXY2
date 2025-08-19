--======================================================================--
-- @作者: GGE研究群: 684484316
-- @创建时间:   2019-09-03 02:34:19
-- @Last Modified time: 2025-06-05 14:54:03
-- 梦幻西游游戏资源破解  老毕   和 C++PrimerPlus  这俩位大神破解所有资源
--======================================================================--
local tp
local xys = 生成XY
local 场景类_庭院特效 = class()
local floor = math.floor
local mouses = 引擎.鼠标按住
local mousax = 引擎.鼠标按下
local mouseb = 引擎.鼠标弹起
function 场景类_庭院特效:初始化(数据,移动)
    tp = 引擎.场景
    self.方向 = 数据.方向
    self.名称 = 数据.名称
    self.编号 = 数据.编号
    self.可移动 = 移动
    self.坐标 = xys(数据.x*20,数据.y*20)
     local qtx = self:取房屋特效(self.名称..self.方向)
    self.特效点 =  tp.资源:载入(qtx.资源,"网易WDF动画",qtx.切换)-- self.特效点 =  tp.资源:载入('mapani.wdf',"网易WDF动画",0x082DB080)--荷花


end

function 场景类_庭院特效:显示(dt,x,y,pys,zb)
    if (tp.角色坐标.x >= self.坐标.x-1200-self.特效点:取高度() and tp.角色坐标.x <= self.坐标.x + 1200+self.特效点:取高度() and tp.角色坐标.y >= self.坐标.y-1200-self.特效点:取宽度() and tp.角色坐标.y <= self.坐标.y + 1000+self.特效点:取宽度()+200) then
        self.特效点:显示(self.坐标.x + pys.x,self.坐标.y + pys.y,zb)
        self.特效点:更新(dt)
        if self.可移动 then
            local 格子 = xys(floor(x / 20 - pys.x / 20),floor(y / 20 - pys.y / 20))
            self.坐标 = xys(格子.x*20,格子.y*20)
            if  引擎.鼠标按下(左键) then
                客户端:请求服务(1005,{x=self.坐标.x/20,y=self.坐标.y/20,方向=self.方向,编号=self.编号},1)
                self.可移动 = false
            end
            if 引擎.鼠标按下(右键) then
                self.方向 = self.方向 + 1
                local qtx2 = self:取房屋特效(self.名称..self.方向)
                if qtx2.资源 ~= nil then
                    self.特效点 =  tp.资源:载入(qtx2.资源,"网易WDF动画",qtx2.切换)
                else
                    self.方向 = 1
                    local qtx3 = self:取房屋特效(self.名称..self.方向)
                    self.特效点 =  tp.资源:载入(qtx3.资源,"网易WDF动画",qtx3.切换)
                end
            end
        end
        if tp.如意符 == true and self.特效点:是否选中(x,y) then
            tp.选中假人 = true
            self.特效点:置高亮()
            if  引擎.鼠标按下(0) then
                客户端:请求服务(1006,{编号=self.编号},1)
                tp.如意符 = false
            end
        else
            self.特效点:取消高亮()
        end
    end
end

function 场景类_庭院特效:取房屋特效(mc)
    local tx = {}
    if mc == "蝴蝶兰1" then
        tx = {x=62,y=64,切换=0x74EF6D5E,资源='atom.wdf'}--荷花1
    elseif mc == "桦木圆桌1" then
        tx = {x=62,y=64,切换=0x21B9BBE,资源='atom.wdf'}
    elseif mc == "窗帘1" then
        tx = {x=62,y=64,切换=0x977228A6,资源='atom.wdf'}
    elseif mc == "窗帘2" then
        tx = {x=62,y=64,切换=0xAB5D1743,资源='atom.wdf'}--荷花1
    elseif mc == "红木地板1" then
        tx = {x=62,y=64,切换=0x663fc75A,资源='物品图标.wdf'}
    elseif mc == "壮丽山河1" then
        tx = {x=62,y=64,切换=0xEABCDF89,资源='item.wdf'}
    elseif mc == "红木八仙桌1" then
        tx = {x=62,y=64,切换=0xCE322B80,资源='item.wdf'}
    elseif mc == "长信女宫灯1" then
        tx = {x=62,y=64,切换=0xDEC76AF6,资源='item.wdf'}
    elseif mc == "黄锻锦边帘1" then
        tx = {x=62,y=64,切换=0xE71A42E5,资源='item.wdf'}
    elseif mc == "宁安夜梦1" then
        tx = {x=62,y=64,切换=0xA02C51DB,资源='item.wdf'}
    elseif mc == "草编地毯1" then
        tx = {x=62,y=64,切换=0x5E95A672,资源='atom.wdf'}--荷花1
    elseif mc == "草编地毯2" then
        tx = {x=62,y=64,切换=0x60CA8F51,资源='atom.wdf'}--荷花1
    elseif mc == "黑麻垂曼帘1" then
        tx = {x=62,y=64,切换=0x9CC0FC97,资源='atom.wdf'}--荷花1
    elseif mc == "黑麻垂曼帘2" then
        tx = {x=62,y=64,切换=0xECF29BBB,资源='atom.wdf'}--荷花1
    elseif mc == "君子兰1" then
        tx = {x=62,y=64,切换=0x2D8A3513,资源='atom.wdf'}--荷花1
    elseif mc == "漆花竹凳1" then
        tx = {x=62,y=64,切换=0x57B2FF33,资源='atom.wdf'}--荷花1
    elseif mc == "漆花竹凳2" then
        tx = {x=62,y=64,切换=0x6D8CBB1A,资源='atom.wdf'}--荷花1
    elseif mc == "水仙1" then
        tx = {x=62,y=64,切换=0x6A38DC23,资源='atom.wdf'}--荷花1
    elseif mc == "踏春图1" then
        tx = {x=62,y=64,切换=0x7E810230,资源='atom.wdf'}--荷花1
    elseif mc == "踏春图2" then
        tx = {x=62,y=64,切换=0xC6495528,资源='atom.wdf'}--荷花1
    elseif mc == "文竹1" then
        tx = {x=62,y=64,切换=0xFE72755B,资源='atom.wdf'}--荷花1
    elseif mc == "仙人掌1" then
        tx = {x=62,y=64,切换=0xA5C0843E,资源='atom.wdf'}--荷花1
    elseif mc == "银烛台1" then
        tx = {x=62,y=64,切换=0x8986C2B8,资源='atom.wdf'}--荷花1
    elseif mc == "印花屏风1" then
        tx = {x=62,y=64,切换=0x1DD23345,资源='atom.wdf'}--荷花1
    elseif mc == "印花屏风2" then
        tx = {x=62,y=64,切换=0x4853B8FA,资源='atom.wdf'}--荷花1
    elseif mc == "玉瓷画瓶1" then
        tx = {x=62,y=64,切换=0xF70BF42D,资源='atom.wdf'}--荷花1
    elseif mc == "桦木立柜1" then
        tx = {x=62,y=64,切换=0x534E2BC7,资源='atom.wdf'}--荷花1
    elseif mc == "桦木立柜2" then
        tx = {x=62,y=64,切换=0xF92EAB94,资源='atom.wdf'}--荷花1
    elseif mc == "榛木床1" then
        tx = {x=62,y=64,切换=0x6D603700,资源='atom.wdf'}--荷花1
    elseif mc == "榛木床2" then
        tx = {x=62,y=64,切换=0xB3C53F3A,资源='atom.wdf'}--荷花1
    elseif mc == "八卦镇邪塌1" then
        tx = {x=62,y=64,切换=0x25936E8E,资源='atom.wdf'}--荷花1
    elseif mc == "八卦镇邪塌2" then
        tx = {x=62,y=64,切换=0x484F7A84,资源='atom.wdf'}--荷花1
    elseif mc == "白鹤展翅帘1" then
        tx = {x=62,y=64,切换=0xC93D6B43,资源='atom.wdf'}--荷花1
    elseif mc == "白鹤展翅帘2" then
        tx = {x=62,y=64,切换=0xDB94B112,资源='atom.wdf'}--荷花1
    elseif mc == "彩绘花瓶1" then
        tx = {x=62,y=64,切换=0x7710A334,资源='atom.wdf'}--荷花1
    elseif mc == "彩绘立柜1" then
        tx = {x=62,y=64,切换=0x6CB98F54,资源='atom.wdf'}--荷花1
    elseif mc == "彩绘立柜2" then
        tx = {x=62,y=64,切换=0xF197C6A3,资源='atom.wdf'}--荷花1
    elseif mc == "长信宫灯1" then
        tx = {x=62,y=64,切换=0x2224131A,资源='atom.wdf'}--荷花1
    elseif mc == "长信宫灯2" then
        tx = {x=62,y=64,切换=0x2D613E27,资源='atom.wdf'}--荷花1
    elseif mc == "长信宫灯3" then
        tx = {x=62,y=64,切换=0x7C6C1872,资源='atom.wdf'}--荷花1
    elseif mc == "长信宫灯4" then
        tx = {x=62,y=64,切换=0xD78587D1,资源='atom.wdf'}
    elseif mc == "雕花马桶1" then
        tx = {x=62,y=64,切换=0x4D5F3B18,资源='atom.wdf'}
    elseif mc == "雕花马桶2" then
        tx = {x=62,y=64,切换=0xBBA82846,资源='atom.wdf'}
    elseif mc == "长信宫灯4" then
        tx = {x=62,y=64,切换=0xD78587D1,资源='atom.wdf'}
    elseif mc == "龟鹤延年灯1" then
        tx = {x=62,y=64,切换=0x9CB213E0,资源='atom.wdf'}
    elseif mc == "龟鹤延年灯2" then
        tx = {x=62,y=64,切换=0xF24B1171,资源='atom.wdf'}
    elseif mc == "红木八仙桌" then
        tx = {x=62,y=64,切换=0x24B0DB4B,资源='atom.wdf'}
    elseif mc == "花鸟图屏风1" then
        tx = {x=62,y=64,切换=0xBB82C17C,资源='atom.wdf'}
    elseif mc == "花鸟图屏风2" then
        tx = {x=62,y=64,切换=0xC155D8B3,资源='atom.wdf'}
    elseif mc == "蓝绸绣花帘1" then
        tx = {x=62,y=64,切换=0xCD5A958F,资源='atom.wdf'}
    elseif mc == "蓝绸绣花帘2" then
        tx = {x=62,y=64,切换=0xE5B707B3,资源='atom.wdf'}
    elseif mc == "麻布地毯1" then
        tx = {x=62,y=64,切换=0x917AA70,资源='atom.wdf'}
    elseif mc == "麻布地毯2" then
        tx = {x=62,y=64,切换=0xEC48F0DC,资源='atom.wdf'}
    elseif mc == "猛虎坐山图1" then
        tx = {x=62,y=64,切换=0x162A74B1,资源='atom.wdf'}
    elseif mc == "猛虎坐山图2" then
        tx = {x=62,y=64,切换=0x9561FCA8,资源='atom.wdf'}
    elseif mc == "嵌玉虎纹桌1" then
        tx = {x=62,y=64,切换=0xECE6D460,资源='atom.wdf'}
    elseif mc == "神仙帐1" then
        tx = {x=62,y=64,切换=0x3CD5A1C1,资源='atom.wdf'}
    elseif mc == "神仙帐2" then
        tx = {x=62,y=64,切换=0x5D3976CB,资源='atom.wdf'}
    elseif mc == "狮子图屏风1" then
        tx = {x=62,y=64,切换=0xA97E7654,资源='atom.wdf'}
    elseif mc == "狮子图屏风2" then
        tx = {x=62,y=64,切换=0xEFACD8B5,资源='atom.wdf'}
    elseif mc == "兽皮地毯1" then
        tx = {x=62,y=64,切换=0x7F1049D7,资源='atom.wdf'}
    elseif mc == "兽皮地毯2" then
        tx = {x=62,y=64,切换=0xCE5F651C,资源='atom.wdf'}
    elseif mc == "双鱼吉庆柜1" then
        tx = {x=62,y=64,切换=0xD4001A88,资源='atom.wdf'}
    elseif mc == "双鱼吉庆柜2" then
        tx = {x=62,y=64,切换=0xEF30F5E4,资源='atom.wdf'}
    elseif mc == "天山云雪1" then
        tx = {x=62,y=64,切换=0x6963D165,资源='atom.wdf'}
    elseif mc == "夕阳山水图1" then
        tx = {x=62,y=64,切换=0xA75F8D0D,资源='atom.wdf'}
    elseif mc == "夕阳山水图2" then
        tx = {x=62,y=64,切换=0xC9368BE9,资源='atom.wdf'}
    elseif mc == "月牙凳1" then
        tx = {x=62,y=64,切换=0x43853A2F,资源='atom.wdf'}
    elseif mc == "月牙凳2" then
        tx = {x=62,y=64,切换=0xEEA4726F,资源='atom.wdf'}
    elseif mc == "桦木靠背椅1" then
        tx = {x=62,y=64,切换=0x291F1300,资源='atom.wdf'}
    elseif mc == "桦木靠背椅2" then
        tx = {x=62,y=64,切换=0x38D9122F,资源='atom.wdf'}
    elseif mc == "桦木靠背椅3" then
        tx = {x=62,y=64,切换=0xD4582E5C,资源='atom.wdf'}
    elseif mc == "桦木靠背椅4" then
        tx = {x=62,y=64,切换=0xEF3E35B6,资源='atom.wdf'}
    elseif mc == "白虎皮毯1" then
        tx = {x=62,y=64,切换=0x3611E764,资源='atom.wdf'}
    elseif mc == "白虎皮毯2" then
        tx = {x=62,y=64,切换=0xB590C8E6,资源='atom.wdf'}
    elseif mc == "白虎皮毯3" then
        tx = {x=62,y=64,切换=0xC07BE47B,资源='atom.wdf'}
    elseif mc == "白虎皮毯4" then
        tx = {x=62,y=64,切换=0xF8D7516B,资源='atom.wdf'}
    elseif mc == "百兽镇邪桌1" then
        tx = {x=62,y=64,切换=0x3A4FB4E6,资源='atom.wdf'}
    elseif mc == "波斯地毯1" then
        tx = {x=62,y=64,切换=0x3BA5C4F6,资源='atom.wdf'}
    elseif mc == "波斯地毯2" then
        tx = {x=62,y=64,切换=0xA1DB3447,资源='atom.wdf'}
    elseif mc == "凤凰傲意图1" then
        tx = {x=62,y=64,切换=0x19668C39,资源='atom.wdf'}
    elseif mc == "凤凰傲意图2" then
        tx = {x=62,y=64,切换=0xADFDC47A,资源='atom.wdf'}
    elseif mc == "虎威太师椅1" then
        tx = {x=62,y=64,切换=0x12B7F681,资源='atom.wdf'}
    elseif mc == "虎威太师椅2" then
        tx = {x=62,y=64,切换=0xB50CCD0A,资源='atom.wdf'}
    elseif mc == "虎威太师椅3" then
        tx = {x=62,y=64,切换=0xCDAF25A6,资源='atom.wdf'}
    elseif mc == "虎威太师椅4" then
        tx = {x=62,y=64,切换=0xEEF34E15,资源='atom.wdf'}
    elseif mc == "黄缎锦边帘1" then
        tx = {x=62,y=64,切换=0x4D8E639F,资源='atom.wdf'}
    elseif mc == "黄缎锦边帘2" then
        tx = {x=62,y=64,切换=0xE649E0EA,资源='atom.wdf'}
    elseif mc == "金座雕龙屏风1" then
        tx = {x=62,y=64,切换=0x11C5B94D,资源='atom.wdf'}
    elseif mc == "金座雕龙屏风2" then
        tx = {x=62,y=64,切换=0x1981A498,资源='atom.wdf'}
    elseif mc == "金座雕龙屏风3" then
        tx = {x=62,y=64,切换=0x70459F4E,资源='atom.wdf'}
    elseif mc == "金座雕龙屏风4" then
        tx = {x=62,y=64,切换=0xCCA34401,资源='atom.wdf'}
    elseif mc == "龙凤呈祥1" then
        tx = {x=62,y=64,切换=0x3291E592,资源='atom.wdf'}
    elseif mc == "龙凤呈祥2" then
        tx = {x=62,y=64,切换=0x368DA460,资源='atom.wdf'}
    elseif mc == "千佛图1" then
        tx = {x=62,y=64,切换=0x4F87C814,资源='atom.wdf'}
    elseif mc == "千佛图2" then
        tx = {x=62,y=64,切换=0x9F6EDC5B,资源='atom.wdf'}
    elseif mc == "壮丽河山1" then
        tx = {x=62,y=64,切换=0x335339A5,资源='atom.wdf'}
    elseif mc == "壮丽河山2" then
        tx = {x=62,y=64,切换=0xA4D974C2,资源='atom.wdf'}
    elseif mc == "紫檀雕花柜1" then
        tx = {x=62,y=64,切换=0xA666FD13,资源='atom.wdf'}
    elseif mc == "紫檀雕花柜2" then
        tx = {x=62,y=64,切换=0xEC841CBB,资源='atom.wdf'}
    elseif mc == "紫檀雕花椅1" then
        tx = {x=62,y=64,切换=0x3B7D42C9,资源='atom.wdf'}
    elseif mc == "紫檀雕花椅2" then
        tx = {x=62,y=64,切换=0xD78587D1,资源='atom.wdf'}
    elseif mc == "紫檀雕花椅3" then
        tx = {x=62,y=64,切换=0x7924DC61,资源='atom.wdf'}
    elseif mc == "紫檀雕花椅4" then
        tx = {x=62,y=64,切换=0xF753388E,资源='atom.wdf'}
    elseif mc == "紫檀马桶1" then
        tx = {x=62,y=64,切换=0x2AEF0F24,资源='atom.wdf'}
    elseif mc == "紫檀马桶2" then
        tx = {x=62,y=64,切换=0x970FA734,资源='atom.wdf'}
    elseif mc == "紫檀马桶3" then
        tx = {x=62,y=64,切换=0xDDCB9DA7,资源='atom.wdf'}
    elseif mc == "紫檀马桶4" then
        tx = {x=62,y=64,切换=0xD78587D1,资源='atom.wdf'}
    elseif mc == "八宝呈祥桌1" then
        tx = {x=62,y=64,切换=0x1D952151,资源='atom.wdf'}
    elseif mc == "红杏闹春帘1" then
        tx = {x=62,y=64,切换=0x68F0DA23,资源='atom.wdf'}
    elseif mc == "红杏闹春帘2" then
        tx = {x=62,y=64,切换=0xA5781F59,资源='atom.wdf'}
    elseif mc == "宁夜安梦1" then
        tx = {x=62,y=64,切换=0x19AFB2FD,资源='atom.wdf'}
    elseif mc == "宁夜安梦2" then
        tx = {x=62,y=64,切换=0x788960BB,资源='atom.wdf'}
    elseif mc == "五谷轮回桶1" then
        tx = {x=62,y=64,切换=0x1F389D5C,资源='atom.wdf'}
    elseif mc == "五谷轮回桶2" then
        tx = {x=62,y=64,切换=0x1FE2A757,资源='atom.wdf'}
    elseif mc == "五谷轮回桶3" then
        tx = {x=62,y=64,切换=0x62576574,资源='atom.wdf'}
    elseif mc == "五谷轮回桶4" then
        tx = {x=62,y=64,切换=0xE8E3C910,资源='atom.wdf'}
    elseif mc == "招财聚宝柜1" then
        tx = {x=62,y=64,切换=0x5E1DC5ED,资源='atom.wdf'}
    elseif mc == "招财聚宝柜2"  then
        tx = {x=62,y=64,切换=0x9B75BD21,资源='atom.wdf'}
    elseif mc == "豪宅房子1" then
        tx = {x=62,y=64,切换=0x3E029CE4,资源='atom.wdf'}
    elseif mc == "白栅绿竹门1" then
        tx = {x=62,y=64,切换=0xCEFCDB53,资源='atom.wdf'}
    elseif mc == "篱笆花圃1" then
        tx = {x=62,y=64,切换=0xA3FEB3CD,资源='atom.wdf'}
    elseif mc == "篱笆花圃2" then
        tx = {x=62,y=64,切换=0xC0BED963,资源='atom.wdf'}
    elseif mc == "篱笆花圃3" then
        tx = {x=62,y=64,切换=0xCCE37A1C,资源='atom.wdf'}
    elseif mc == "篱笆花圃4" then
        tx = {x=62,y=64,切换=0x14B6131E,资源='atom.wdf'}
    elseif mc == "篱笆院墙1" then
        tx = {x=62,y=64,切换=0x59633B00,资源='atom.wdf'}
    elseif mc == "篱笆院墙2" then
        tx = {x=62,y=64,切换=0x8C028EC5,资源='atom.wdf'}
    elseif mc == "篱笆院墙3" then
        tx = {x=62,y=64,切换=0xF6283A5C,资源='atom.wdf'}
    elseif mc == "篱笆院墙4" then
        tx = {x=62,y=64,切换=0xF65D0D28,资源='atom.wdf'}
    elseif mc == "篱笆院墙5" then
        tx = {x=62,y=64,切换=0xF9AE22FA,资源='atom.wdf'}
    elseif mc == "篱笆院墙6" then
        tx = {x=62,y=64,切换=0x2BB8AC86,资源='atom.wdf'}
    elseif mc == "石凳1" then
        tx = {x=62,y=64,切换=0x0AC018C5,资源='atom.wdf'}
    elseif mc == "石制宫灯" then
        tx = {x=62,y=64,切换=0xAD02948A,资源='atom.wdf'}
    elseif mc == "石制影壁1" then
        tx = {x=62,y=64,切换=0x7C13ECBC,资源='atom.wdf'}
    elseif mc == "石制影壁2" then
        tx = {x=62,y=64,切换=0x86947818,资源='atom.wdf'}
    elseif mc == "石桌1" then
        tx = {x=62,y=64,切换=0x7B1C7866,资源='atom.wdf'}
    elseif mc == "大理石凳1" then
        tx = {x=62,y=64,切换=0x3F5484B0,资源='atom.wdf'}
    elseif mc == "大理石花圃1" then
        tx = {x=62,y=64,切换=0x2AFCCD3A,资源='atom.wdf'}
    elseif mc == "大理石花圃2" then
        tx = {x=62,y=64,切换=0x7B217955,资源='atom.wdf'}
    elseif mc == "大理石花圃3" then
        tx = {x=62,y=64,切换=0x85602592,资源='atom.wdf'}
    elseif mc == "大理石花圃4" then
        tx = {x=62,y=64,切换=0x079B7DB2,资源='atom.wdf'}
    elseif mc == "大理石影壁1" then
        tx = {x=62,y=64,切换=0x908C2651,资源='atom.wdf'}
    elseif mc == "大理石影壁2" then
        tx = {x=62,y=64,切换=0x18233140,资源='atom.wdf'}
    elseif mc == "大理石桌1" then
        tx = {x=62,y=64,切换=0x1B2CD3A3,资源='atom.wdf'}
    elseif mc == "红漆雕花门1" then
        tx = {x=62,y=64,切换=0x2CBB70CE,资源='atom.wdf'}
    elseif mc == "青瓷花盆1" then
        tx = {x=62,y=64,切换=0x0F517478,资源='atom.wdf'}
    elseif mc == "青瓷花盆2" then
        tx = {x=62,y=64,切换=0xD79DB6BA,资源='atom.wdf'}
    elseif mc == "青石路砖1" then
        tx = {x=62,y=64,切换=0xE2E13E2C,资源='atom.wdf'}
    elseif mc == "青石路砖2" then
        tx = {x=62,y=64,切换=0xCC452AAE,资源='atom.wdf'}
    elseif mc == "青石路砖3" then
        tx = {x=62,y=64,切换=0x748478DE,资源='atom.wdf'}
    elseif mc == "青铜鼎1" then
        tx = {x=62,y=64,切换=0x0DCB229B,资源='atom.wdf'}
    elseif mc == "青铜鼎2" then
        tx = {x=62,y=64,切换=0x4A4563E3,资源='atom.wdf'}
    elseif mc == "石制院墙1" then
        tx = {x=62,y=64,切换=0x5BD27559,资源='atom.wdf'}
    elseif mc == "石制院墙2" then
        tx = {x=62,y=64,切换=0x81CFA71A,资源='atom.wdf'}
    elseif mc == "石制院墙3" then
        tx = {x=62,y=64,切换=0xD1E1CB62,资源='atom.wdf'}
    elseif mc == "石制院墙4" then
        tx = {x=62,y=64,切换=0xE3CB368B,资源='atom.wdf'}
    elseif mc == "石制院墙5" then
        tx = {x=62,y=64,切换=0x4D0D83AD,资源='atom.wdf'}
    elseif mc == "白玉花圃1" then
        tx = {x=62,y=64,切换=0xC28D2CD3,资源='atom.wdf'}
    elseif mc == "白玉花圃2" then
        tx = {x=62,y=64,切换=0xE21C0291,资源='atom.wdf'}
    elseif mc == "白玉花圃3" then
        tx = {x=62,y=64,切换=0xD60AE872,资源='atom.wdf'}
    elseif mc == "白玉花圃4" then
        tx = {x=62,y=64,切换=0x5F764EC3,资源='atom.wdf'}
    elseif mc == "白玉狮子1" then
        tx = {x=62,y=64,切换=0x16084D62,资源='atom.wdf'}
    elseif mc == "白玉狮子2" then
        tx = {x=62,y=64,切换=0xC48D5B8D,资源='atom.wdf'}
    elseif mc == "白玉石凳1" then
        tx = {x=62,y=64,切换=0x3E1C245A,资源='atom.wdf'}
    elseif mc == "白玉影壁1" then
        tx = {x=62,y=64,切换=0xB553BC7D,资源='atom.wdf'}
    elseif mc == "白玉石桌1" then
        tx = {x=62,y=64,切换=0xB553BC7D,资源='atom.wdf'}
    elseif mc == "白玉影壁1" then
        tx = {x=62,y=64,切换=0x42E81640,资源='atom.wdf'}
    elseif mc == "白玉影壁2" then
        tx = {x=62,y=64,切换=0x90F24693,资源='atom.wdf'}
    elseif mc == "花岗石路砖1" then
        tx = {x=62,y=64,切换=0x1FE877C3,资源='atom.wdf'}
    elseif mc == "花岗石路砖2" then
        tx = {x=62,y=64,切换=0x988193A8,资源='atom.wdf'}
    elseif mc == "花岗石路砖3" then
        tx = {x=62,y=64,切换=0x58C02150,资源='atom.wdf'}
    elseif mc == "混土砖石院墙1" then
        tx = {x=62,y=64,切换=0x55EBE00B,资源='atom.wdf'}
    elseif mc == "混土砖石院墙2" then
        tx = {x=62,y=64,切换=0x0986F631,资源='atom.wdf'}
    elseif mc == "混土砖石院墙3" then
        tx = {x=62,y=64,切换=0x44AB1406,资源='atom.wdf'}
    elseif mc == "混土砖石院墙4" then
        tx = {x=62,y=64,切换=0x6947518B,资源='atom.wdf'}
    elseif mc == "混土砖石院墙5" then
        tx = {x=62,y=64,切换=0x6FE91DC0,资源='atom.wdf'}
    elseif mc == "混土砖石院墙6" then
        tx = {x=62,y=64,切换=0x92317A9E,资源='atom.wdf'}
    elseif mc == "混土砖石院墙7" then
        tx = {x=62,y=64,切换=0x9FDA2C6E,资源='atom.wdf'}
    elseif mc == "混土砖石院墙8" then
        tx = {x=62,y=64,切换=0xD5A793DB,资源='atom.wdf'}
    elseif mc == "金丝楠木门1" then
        tx = {x=62,y=64,切换=0xD6192A54,资源='atom.wdf'}
    elseif mc == "山水盆景1" then
        tx = {x=62,y=64,切换=0x21B94425,资源='atom.wdf'}
    elseif mc == "山水盆景2" then
        tx = {x=62,y=64,切换=0x31878048,资源='atom.wdf'}
    elseif mc == "四圣兽之白虎1" then
        tx = {x=62,y=64,切换=0x1E574327,资源='atom.wdf'}
    elseif mc == "四圣兽之青龙1" then
        tx = {x=62,y=64,切换=0xDD287793,资源='atom.wdf'}
    elseif mc == "四圣兽之玄武1" then
        tx = {x=62,y=64,切换=0xA76F6B63,资源='atom.wdf'}
    elseif mc == "四圣兽之朱雀" then
        tx = {x=62,y=64,切换=0xEC41B4C1,资源='atom.wdf'}
    elseif mc == "物品柜1" then
        tx = {x=62,y=64,切换=0x476D99FE,资源='atom.wdf'}
    elseif mc == "物品柜2" then
        tx = {x=62,y=64,切换=0xFCCCF953,资源='atom.wdf'}
    elseif mc == "对联1" then
        tx = {x=62,y=64,切换=0x27E4C222,资源='atom.wdf'}
    elseif mc == "对联2" then
        tx = {x=62,y=64,切换=0xCD0720CB,资源='atom.wdf'}
    elseif mc == "福" then
        tx = {x=62,y=64,切换=0x8086FD37,资源='atom.wdf'}
    elseif mc == "横批" then
        tx = {x=62,y=64,切换=0x8D36A901,资源='atom.wdf'}
    elseif mc == "西瓜1" then
        tx = {x=62,y=64,切换=0x305A6459,资源='atom.wdf'}
    elseif mc == "木瓜1" then
        tx = {x=62,y=64,切换=0x31812A00,资源='atom.wdf'}
    elseif mc == "苦瓜1" then
        tx = {x=62,y=64,切换=0x3510F10E,资源='atom.wdf'}
    elseif mc == "荔枝树1" then
        tx = {x=62,y=64,切换=0x3635E2A7,资源='atom.wdf'}
    elseif mc == "茄子1" then
        tx = {x=62,y=64,切换=0x376B1845,资源='atom.wdf'}
     elseif mc == "绿树1" then
        tx = {x=62,y=64,切换=0x2E544C15,资源='atom.wdf'}
    elseif mc == "白菜1" then
        tx = {x=62,y=64,切换=0x391BECF6,资源='atom.wdf'}
    elseif mc == "萝卜1" then
        tx = {x=62,y=64,切换=0x3B9EF2B4,资源='atom.wdf'}
    elseif mc == "梨子树1" then
        tx = {x=62,y=64,切换=0x3B9EF2B4,资源='atom.wdf'}
    elseif mc == "叮当猫藏书架1" then  ---
        tx = {x=62,y=64,切换=0x00000001,资源='xzjj.wdf'}
    elseif mc == "叮当猫藏书架2" then
        tx = {x=62,y=64,切换=0x00000002,资源='xzjj.wdf'}
    elseif mc == "叮当猫贵妃椅1" then
        tx = {x=62,y=64,切换=0x00000003,资源='xzjj.wdf'}
    elseif mc == "叮当猫贵妃椅2" then
        tx = {x=62,y=64,切换=0x00000004,资源='xzjj.wdf'}
    elseif mc == "叮当猫梦幻屛1" then
        tx = {x=62,y=64,切换=0x00000005,资源='xzjj.wdf'}
    elseif mc == "叮当猫梦幻屛2" then
        tx = {x=62,y=64,切换=0x00000006,资源='xzjj.wdf'}
    elseif mc == "叮当猫木桌1" then
        tx = {x=62,y=64,切换=0x00000007,资源='xzjj.wdf'}
    elseif mc == "叮当猫如意饰1" then
        tx = {x=62,y=64,切换=0x00000008,资源='xzjj.wdf'}
    elseif mc == "叮当猫如意饰2" then
        tx = {x=62,y=64,切换=0x00000009,资源='xzjj.wdf'}
    elseif mc == "叮当猫衣柜1" then
        tx = {x=62,y=64,切换=0x00000010,资源='xzjj.wdf'}
    elseif mc == "叮当猫衣柜2" then
        tx = {x=62,y=64,切换=0x00000011,资源='xzjj.wdf'}
    elseif mc == "叮当猫迎客屏1" then
        tx = {x=62,y=64,切换=0x00000012,资源='xzjj.wdf'}
    elseif mc == "叮当猫迎客屏2" then
        tx = {x=62,y=64,切换=0x00000013,资源='xzjj.wdf'}
    elseif mc == "叮当貓编织毯1" then
        tx = {x=62,y=64,切换=0x00000014,资源='xzjj.wdf'}
    elseif mc == "叮当貓靠背椅1" then
        tx = {x=62,y=64,切换=0x00000015,资源='xzjj.wdf'}
    elseif mc == "叮当貓靠背椅2" then
        tx = {x=62,y=64,切换=0x00000016,资源='xzjj.wdf'}
    elseif mc == "叮当貓朦胧榻1" then
        tx = {x=62,y=64,切换=0x00000017,资源='xzjj.wdf'}
    elseif mc == "叮当貓朦胧榻2" then
        tx = {x=62,y=64,切换=0x00000018,资源='xzjj.wdf'}
    elseif mc == "叮当貓书桌1" then
        tx = {x=62,y=64,切换=0x00000019,资源='xzjj.wdf'}
    elseif mc == "叮当貓书桌2" then
        tx = {x=62,y=64,切换=0x00000020,资源='xzjj.wdf'}
    elseif mc == "叮当貓温馨帘1" then
        tx = {x=62,y=64,切换=0x00000021,资源='xzjj.wdf'}
    elseif mc == "叮当貓温馨帘2" then
        tx = {x=62,y=64,切换=0x00000022,资源='xzjj.wdf'}
    elseif mc == "叮当貓摇揺椅1" then
        tx = {x=62,y=64,切换=0x00000023,资源='xzjj.wdf'}
    elseif mc == "叮当貓摇揺椅2" then
        tx = {x=62,y=64,切换=0x00000024,资源='xzjj.wdf'}
    elseif mc == "玲珑兔藏经阁1" then
        tx = {x=62,y=64,切换=0x00000039,资源='xzjj.wdf'}
    elseif mc == "玲珑兔藏经阁2" then
        tx = {x=62,y=64,切换=0x00000040,资源='xzjj.wdf'}
    elseif mc == "玲珑兔粉缎帘1" then
        tx = {x=62,y=64,切换=0x00000042,资源='xzjj.wdf'}
    elseif mc == "玲珑兔粉缎帘2" then
        tx = {x=62,y=64,切换=0x00000043,资源='xzjj.wdf'}
    elseif mc == "玲珑兔宫灯1" then
        tx = {x=62,y=64,切换=0x00000045,资源='xzjj.wdf'}
    elseif mc == "玲珑兔宫灯2" then
        tx = {x=62,y=64,切换=0x00000046,资源='xzjj.wdf'}
    elseif mc == "玲珑兔贵妃卧1" then
        tx = {x=62,y=64,切换=0x00000048,资源='xzjj.wdf'}
    elseif mc == "玲珑兔贵妃卧2" then
        tx = {x=62,y=64,切换=0x00000049,资源='xzjj.wdf'}
    elseif mc == "玲珑兔靠背椅1" then
        tx = {x=62,y=64,切换=0x00000051,资源='xzjj.wdf'}
    elseif mc == "玲珑兔靠背椅2" then
        tx = {x=62,y=64,切换=0x00000052,资源='xzjj.wdf'}
    elseif mc == "玲珑兔立柜1" then
        tx = {x=62,y=64,切换=0x00000054,资源='xzjj.wdf'}
    elseif mc == "玲珑兔立柜2" then
        tx = {x=62,y=64,切换=0x00000055,资源='xzjj.wdf'}
    elseif mc == "玲珑兔美梦屏风1" then
        tx = {x=62,y=64,切换=0x00000057,资源='xzjj.wdf'}
    elseif mc == "玲珑兔美梦屏风2" then
        tx = {x=62,y=64,切换=0x00000058,资源='xzjj.wdf'}
    elseif mc == "玲珑兔愜意桶1" then
        tx = {x=62,y=64,切换=0x00000060,资源='xzjj.wdf'}
    elseif mc == "玲珑兔愜意桶2" then
        tx = {x=62,y=64,切换=0x00000061,资源='xzjj.wdf'}
    elseif mc == "玲珑兔书桌1" then
        tx = {x=62,y=64,切换=0x00000063,资源='xzjj.wdf'}
    elseif mc == "玲珑兔书桌2" then
        tx = {x=62,y=64,切换=0x00000064,资源='xzjj.wdf'}
    elseif mc == "玲珑兔甜梦榻1" then
        tx = {x=62,y=64,切换=0x00000066,资源='xzjj.wdf'}
    elseif mc == "玲珑兔甜梦榻2" then
        tx = {x=62,y=64,切换=0x00000067,资源='xzjj.wdf'}
    elseif mc == "玲珑兔揺揺椅1" then
        tx = {x=62,y=64,切换=0x00000069,资源='xzjj.wdf'}
    elseif mc == "玲珑兔揺揺椅2" then
        tx = {x=62,y=64,切换=0x00000070,资源='xzjj.wdf'}
    elseif mc == "玲珑兔迎客屏1" then
        tx = {x=62,y=64,切换=0x00000072,资源='xzjj.wdf'}
    elseif mc == "玲珑兔迎客屏2" then
        tx = {x=62,y=64,切换=0x00000073,资源='xzjj.wdf'}
    elseif mc == "玲珑兔圆桌1" then
        tx = {x=62,y=64,切换=0x00000075,资源='xzjj.wdf'}
    elseif mc == "玲珑兔织毯1" then
        tx = {x=62,y=64,切换=0x00000077,资源='xzjj.wdf'}
    elseif mc == "玲珑兔珠帘1" then
        tx = {x=62,y=64,切换=0x00000079,资源='xzjj.wdf'}
    elseif mc == "玲珑兔珠帘2" then
        tx = {x=62,y=64,切换=0x00000080,资源='xzjj.wdf'}


    end
    return tx
end


return 场景类_庭院特效

