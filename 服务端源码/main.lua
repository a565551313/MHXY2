-- @Author              : GGELUA
-- @Last Modified by    : GGELUA2
-- @Date                : 2024-06-14 13:01:24
-- @Last Modified time  : 2024-06-28 01:24:27


localmp = require("Script/服务网络/MessagePack")
__S服务 = require("Script/服务网络/PackServer")('服务','-->内网连接')



__S服务.发送_ = __S服务.发送
function __S服务:发送(id,...)   self:发送_(id,localmp.pack{...})
end
function __S服务:gm发送(id,...) self:发送_(id,...)
end
require("lfs")
程序目录=lfs.currentdir()..[[\]]
初始目录=程序目录
format = string.format

-- __gge.print(false,13,[[
--                                    _ooOoo_
--                                   o8888888o
--                                   88" . "88
--                                   (| -_- |)
--                                   O\  =  /O
--                                ____/`---'\____
--                              .'  \\|     |//  `.
--                             /  \\|||  :  |||//  \
--                            /  _||||| -:- |||||-  \
--                            |   | \\\  -  /// |   |
--                            | \_|  ''\---/''  |   |
--                            \  .-\__  `-`  ___/-. /
--                          ___`. .'  /--.--\  `. . __
--                       ."" '<  `.___\_<|>_/___.'  >'"".
--                      | | :  `- \`.;`\ _ /`;.`/ - ` : | |
--                      \  \ `-.   \_ __\ /__ _/   .-` /  /
--                 ======`-.____`-.___\_____/___.-`____.-'======
--                                    `=---='
--                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
--                             佛祖保佑       永无BUG
--   ]])
__gge.print(false,14,[[

☆————————————女神保佑，代码无bug—————————————☆
☆                                                                     ☆
☆                                                                     ☆
☆                       .::::.                                        ☆
☆                     .::::::::.                                      ☆
☆                    :::::::::::                                      ☆
☆                 ..:::::::::::'                                      ☆
☆              '::::::::::::'                                         ☆
☆                .::::::::::                                          ☆
☆           '::::::::::::::..                                         ☆
☆                ..::::::::::::.                                      ☆
☆              ``::::::::::::::::                                     ☆
☆               ::::``:::::::::'        .:::.                         ☆
☆              ::::'   ':::::'       .::::::::.                       ☆
☆            .::::'      ::::     .:::::::'::::.                      ☆
☆           .:::'       :::::  .:::::::::' ':::::.                    ☆
☆          .::'        :::::.:::::::::'      ':::::.                  ☆
☆         .::'         ::::::::::::::'         ``::::.                ☆
☆     ...:::           ::::::::::::'              ``::.               ☆
☆    ````':.          ':::::::::'                  ::::..             ☆
☆                       '.:::::'                    ':'````..         ☆
☆                                                                     ☆
☆---------------------------------------------------------------------☆
☆————————————女神保佑，代码无bug—————————————☆

]])

--__gge.print(false,13,"\n")
--__gge.print(false,10,"☆---------------------------------------------------------------------☆\n")
__gge.print(true,14,"【开始加载数据】·····\n")
--__gge.print(false,10,"☆---------------------------------------------------------------------☆\n")


require("Script/常用变量")
require("Script/数据中心/变身卡")
require("Script/数据中心/变身卡扩展处理类")--超级变身卡新加
require("Script/数据中心/场景等级")
require("Script/数据中心/场景名称")
require("Script/数据中心/法术技能特效")
require("Script/数据中心/明暗雷怪")
require("Script/数据中心/取经验")
require("Script/数据中心/取师门")
require("Script/数据中心/染色")
require("Script/数据中心/物品")
require("Script/数据中心/野怪")
require("Script/系统处理类/共用")
require("Script/数据中心/符石组合")
require("Script/数据中心/商城神兽")
物品类=require("Script/角色处理类/内存类_物品")
地图坐标类=require("Script/地图处理类/地图坐标类")
路径类=require("Script/地图处理类/路径类")
地图处理类=require("Script/地图处理类/地图处理类")()
网络处理类=require("Script/系统处理类/网络处理类")()
系统处理类=require("Script/系统处理类/系统处理类")()
聊天处理类=require("Script/系统处理类/聊天处理类")()
任务处理类=require("Script/系统处理类/任务处理类")()
游戏活动类=require("Script/系统处理类/游戏活动类")()
角色处理类=require("Script/角色处理类/角色处理类")
道具处理类=require("Script/角色处理类/道具处理类")
神器类=require("Script/角色处理类/神器类")
礼包奖励类=require("Script/角色处理类/礼包奖励类")()
通用道具=require("Script/角色处理类/道具处理类")()
帮派处理类=require("Script/角色处理类/帮派处理类")()
对话处理类=require("Script/对话处理类/初始")()
商店处理类=require("Script/商店处理类/商店处理类")()
仙玉商城类 = require("Script/商店处理类/仙玉商城")()
队伍处理类=require("Script/角色处理类/队伍处理类")()
战斗准备类=require("Script/战斗处理类/战斗准备类")()
召唤兽处理类=require("Script/角色处理类/召唤兽处理类")
召唤兽仓库类=require("Script/角色处理类/召唤兽仓库类")
道具仓库类=require("Script/角色处理类/道具仓库类")
共享仓库类=require("Script/角色处理类/共享仓库类")
幻化处理类=require("Script/角色处理类/幻化处理类")()

装备处理类=require("Script/角色处理类/装备处理类")-------------
经脉处理类=require("Script/角色处理类/经脉处理")
刷怪处理=require("Script/系统处理类/刷怪处理")()
全局坐骑资料=require("script/数据中心/坐骑库")()

帮战活动类=require("Script/系统处理类/帮战活动类")()
装备符石处理=require("Script/角色处理类/装备符石处理")()

--副本脚本加载
副本处理类=require("Script/副本处理类/副本处理类")()
管理工具类=require("Script/系统处理类/管理工具类")()

藏宝阁处理类=require("Script/商店处理类/藏宝阁")()
多开系统类=require("Script/角色处理类/多开系统")()
物品加锁处理类=require("script/角色处理类/加锁处理类")
彩虹争霸=require("Script/副本处理类/彩虹争霸")()
长安保卫战=require("Script/副本处理类/长安保卫战")()
房屋处理类=require("Script/角色处理类/房屋处理类")

好友处理类=require("Script/角色处理类/好友处理类")
嘉年华=require("Script/副本处理类/嘉年华")()
共享货币类=require("Script/系统处理类/共享货币类")
归墟活动=require("Script/副本处理类/归墟活动")()

require("Script/战斗处理类/技能数据")
--战斗处理类=
require("Script/战斗处理类/战斗处理类")
假人战斗处理类=require("Script/系统处理类/假人战斗处理")()



副本战斗类型={}





服务端参数={}
服务端参数.名称 =  f函数.读配置(程序目录.."配置文件.ini","主要配置","名称")
服务端参数.ip=f函数.读配置(程序目录.."配置文件.ini","主要配置","启动ip")
服务端参数.端口=f函数.读配置(程序目录.."配置文件.ini","主要配置","端口") +0
服务端参数.网关ip=f函数.读配置(程序目录.."配置文件.ini","主要配置","网关ip")
服务端参数.角色id=f函数.读配置(程序目录.."配置文件.ini","主要配置","id")+0
服务端参数.版本 = f函数.读配置(程序目录.."配置文件.ini","主要配置","版本")+0
服务端参数.经验获得率=f函数.读配置(程序目录.."配置文件.ini","主要配置","经验")+0
服务端参数.难度=f函数.读配置(程序目录.."配置文件.ini","主要配置","难度")+0
服务端参数.雁塔地宫难度=tonumber(f函数.读配置(程序目录.."配置文件.ini","主要配置","雁塔地宫难度")) or 1
服务端参数.镇妖塔难度=tonumber(f函数.读配置(程序目录.."配置文件.ini","主要配置","镇妖塔难度")) or 1
服务端参数.轮回境难度=tonumber(f函数.读配置(程序目录.."配置文件.ini","主要配置","轮回境难度")) or 1
服务端参数.童子难度=tonumber(f函数.读配置(程序目录.."配置文件.ini","主要配置","童子难度")) or 1
服务端参数.GM难度=tonumber(f函数.读配置(程序目录.."配置文件.ini","主要配置","GM难度")) or 1
服务端参数.副本BOSS难度=tonumber(f函数.读配置(程序目录.."配置文件.ini","主要配置","副本BOSS难度")) or 1
服务端参数.镇妖塔层数=tonumber(f函数.读配置(程序目录.."配置文件.ini","主要配置","镇妖塔层数")) or 200
服务端参数.月饼数量=tonumber(f函数.读配置(程序目录.."配置文件.ini","主要配置","月饼数量")) or 50
服务端参数.自动晶清=tonumber(f函数.读配置(程序目录.."配置文件.ini","主要配置","自动晶清")) or 5
if 服务端参数.自动晶清>10 then
    服务端参数.自动晶清=10
end
服务端参数.等级上限=f函数.读配置(程序目录.."配置文件.ini","主要配置","等级上限")+0
服务端参数.宠物仿官=false
if f函数.读配置(程序目录.."配置文件.ini","主要配置","宠物仿官")=="true" or f函数.读配置(程序目录.."配置文件.ini","主要配置","宠物仿官")=="1" or f函数.读配置(程序目录.."配置文件.ini","主要配置","宠物仿官")==1 then
   服务端参数.宠物仿官 =true
end
服务端参数.是否提现=false
if f函数.读配置(程序目录.."配置文件.ini","主要配置","提现")=="true" or f函数.读配置(程序目录.."配置文件.ini","主要配置","提现")=="1" or f函数.读配置(程序目录.."配置文件.ini","主要配置","提现")==1 then
   服务端参数.是否提现 =true
end
服务端参数.连接数=0
服务端参数.运行时间=0
服务端参数.时间=os.time()
服务端参数.启动时间=os.time()
服务端参数.分钟=os.date("%M", os.time())
服务端参数.小时=os.date("%H", os.time())



服务端参数.授权注册={
   -- 本地测试=true,
}


地图处理类.NPC列表[1501][4].名称 = 服务端参数.名称
地图处理类.NPC列表[1001][66].名称 = 服务端参数.名称.."伤害测试"
地图处理类.NPC列表[1001][78].名称 = "挑战"..服务端参数.名称.."GM"

加载假人配置()
假人玩家类 = require("Script/系统处理类/假人玩家")()
加载摆摊假人()
摆摊假人类 = require("Script/系统处理类/摆摊假人")()
走动假人 = true
假人玩家类:功能开关(走动假人)--默认开启
假人说话 = true
假人摆摊 = true
摆摊假人类:功能开关(假人摆摊)





if f函数.文件是否存在([[tysj/任务数据.txt]])==false then
  加载任务={}
  写出文件([[tysj/任务数据.txt]],table.tostring(加载任务))
else
   加载任务=table.loadstring(读入文件([[tysj/任务数据.txt]]))
end

if f函数.文件是否存在([[tysj/帮派数据.txt]])==false then
  帮派数据={}
  写出文件([[tysj/帮派数据.txt]],table.tostring(帮派数据))
else
   帮派数据=table.loadstring(读入文件([[tysj/帮派数据.txt]]))
end
if f函数.文件是否存在([[tysj/神秘宝箱.txt]])==false then
  神秘宝箱={}
  写出文件([[tysj/神秘宝箱.txt]],table.tostring(神秘宝箱))
else
   神秘宝箱=table.loadstring(读入文件([[tysj/神秘宝箱.txt]]))
end
if f函数.文件是否存在([[tysj/首席争霸.txt]])==false then
  首席争霸 ={龙宫={模型="龙太子",名称="龙太子",武器="天龙破城",武器等级=150},
              天宫={模型="舞天姬",名称="舞天姬",武器="揽月摘星",武器等级=150},
              女儿村={模型="英女侠",名称="英女侠",武器="祖龙对剑",武器等级=150},
              化生寺={模型="逍遥生",名称="逍遥生",武器="浩气长舒",武器等级=150},
              普陀山={模型="玄彩娥",名称="玄彩娥",武器="丝萝乔木",武器等级=150},
              五庄观={模型="神天兵",名称="神天兵",武器="狂澜碎岳",武器等级=150},
              盘丝洞={模型="狐美人",名称="狐美人",武器="牧云清歌",武器等级=150},
              魔王寨={模型="巨魔王",名称="巨魔王",武器="业火三灾",武器等级=150},
              狮驼岭={模型="虎头怪",名称="虎头怪",武器="碧血干戚",武器等级=150},
              方寸山={模型="偃无师",名称="偃无师",武器="秋水澄流",武器等级=150},
              凌波城={模型="羽灵神",名称="羽灵神",武器="碧海潮生",武器等级=150},
              神木林={模型="巫蛮儿",名称="巫蛮儿",武器="雪蟒霜寒",武器等级=140},
              无底洞={模型="鬼潇潇",名称="鬼潇潇",武器="浮生归梦",武器等级=150},
              九黎城={模型="影精灵",名称="影精灵",武器="丝萝乔木",武器等级=150},
              大唐官府={模型="剑侠客",名称="剑侠客",武器="斩妖泣血",武器等级=140},
              阴曹地府={模型="骨精灵",名称="骨精灵",武器="忘川三途",武器等级=150},
             }
    写出文件([[tysj/首席争霸.txt]],table.tostring(首席争霸))
else
    首席争霸=table.loadstring(读入文件([[tysj/首席争霸.txt]]))
end
if not 首席争霸.九黎城 then
    首席争霸.九黎城={模型="影精灵",名称="影精灵",武器="丝萝乔木",武器等级=150}
end
local 临时属性 ={等级=150,气血=20000,魔法=20000,愤怒=150,命中=3000,伤害=4500,防御=1500,法伤=4300,法防=1300,速度=1000,躲避=100}
for k,v in pairs(首席争霸) do
    if not v.名称 then
        v.名称 = v.模型
    end
    for i,n in pairs(临时属性) do
        if not v[i] then
             v[i]=n
        end
    end
end

if f函数.文件是否存在([[tysj/经验数据.txt]])==false then
  经验数据={千亿={},排行={},百亿={}}
  写出文件([[tysj/经验数据.txt]],table.tostring(经验数据))
else
   经验数据=table.loadstring(读入文件([[tysj/经验数据.txt]]))
end
if f函数.文件是否存在([[tysj/押镖数据.txt]])==false then
  押镖数据={}
  写出文件([[tysj/押镖数据.txt]],table.tostring(押镖数据))
else
   押镖数据=table.loadstring(读入文件([[tysj/押镖数据.txt]]))
end

if f函数.文件是否存在([[tysj/名称数据.txt]])==false then
  名称数据={}
  写出文件([[tysj/名称数据.txt]],table.tostring(名称数据))
else
   名称数据=table.loadstring(读入文件([[tysj/名称数据.txt]]))
end


if f函数.文件是否存在([[tysj/生死劫数据.txt]])==false then
  生死劫数据={次数={}}
  写出文件([[tysj/生死劫数据.txt]],table.tostring(生死劫数据))
else
   生死劫数据=table.loadstring(读入文件([[tysj/生死劫数据.txt]]))
end



if f函数.文件是否存在([[tysj/活动次数.txt]])==false then
  活动次数={}
  写出文件([[tysj/活动次数.txt]],table.tostring(活动次数))
else
   活动次数=table.loadstring(读入文件([[tysj/活动次数.txt]]))
end
if f函数.文件是否存在([[tysj/活跃数据.txt]])==false then
  活跃数据={}
  写出文件([[tysj/活跃数据.txt]],table.tostring(活跃数据))
else
   活跃数据=table.loadstring(读入文件([[tysj/活跃数据.txt]]))
end

if f函数.文件是否存在([[tysj/支线奖励.txt]])==false then
  支线奖励={}
  写出文件([[tysj/支线奖励.txt]],table.tostring(支线奖励))
else
   支线奖励=table.loadstring(读入文件([[tysj/支线奖励.txt]]))
end
if f函数.文件是否存在([[tysj/首杀记录.txt]])==false then
  首杀记录={商人的鬼魂 = 0,妖风 = 0,白鹿精 = 0,酒肉和尚 = 0,守门天兵 = 0,蟹将军= 0,真刘洪= 0,幽冥鬼= 0}
  写出文件([[tysj/首杀记录.txt]],table.tostring(首杀记录))
else
   首杀记录=table.loadstring(读入文件([[tysj/首杀记录.txt]]))
end


if f函数.文件是否存在([[tysj/镇妖塔数据.txt]])==false then
  镇妖塔数据={}
  写出文件([[tysj/镇妖塔数据.txt]],table.tostring(镇妖塔数据))
else
   镇妖塔数据=table.loadstring(读入文件([[tysj/镇妖塔数据.txt]]))
end


if f函数.文件是否存在([[tysj/师徒数据.txt]])==false then
  师徒数据={}
  写出文件([[tysj/师徒数据.txt]],table.tostring(师徒数据))
else
   师徒数据=table.loadstring(读入文件([[tysj/师徒数据.txt]]))
end

if f函数.文件是否存在([[tysj/雁塔地宫.txt]])==false then
  雁塔地宫={}
  写出文件([[tysj/雁塔地宫.txt]],table.tostring(雁塔地宫))
else
   雁塔地宫=table.loadstring(读入文件([[tysj/雁塔地宫.txt]]))
end
if f函数.文件是否存在([[tysj/地宫排行.txt]])==false then
  地宫排行={}
  写出文件([[tysj/地宫排行.txt]],table.tostring(地宫排行))
else
   地宫排行=table.loadstring(读入文件([[tysj/地宫排行.txt]]))
end



if f函数.文件是否存在([[tysj/成就数据.txt]])==false then
  成就数据={}
  写出文件([[tysj/成就数据.txt]],table.tostring(成就数据))
else
   成就数据=table.loadstring(读入文件([[tysj/成就数据.txt]]))
end
if f函数.文件是否存在([[tysj/世界挑战.txt]])==false then
    世界挑战={开启=false,气血={当前=9999999999,上限=9999999999},奖励={}}
    写出文件([[tysj/世界挑战.txt]],table.tostring(世界挑战))
  else
    世界挑战=table.loadstring(读入文件([[tysj/世界挑战.txt]]))
  end



if f函数.文件是否存在([[ip列表.txt]])==false then
  ip封禁表={}
  写出文件([[ip列表.txt]],table.tostring(ip封禁表))
else
   ip封禁表=table.loadstring(读入文件([[ip列表.txt]]))
end

if f函数.文件是否存在([[tysj/排行榜.txt]])==false then
  排行榜数据={玩家伤害排行={},玩家灵力排行={},玩家师傅排行={},玩家剑会排行={},玩家剑会季度={},玩家镇妖层数={}}
  写出文件([[tysj/排行榜.txt]],table.tostring(排行榜数据))
else
   排行榜数据=table.loadstring(读入文件([[tysj/排行榜.txt]]))
end


if f函数.文件是否存在([[tysj/帮派缴纳情况.txt]])==false then
  帮派缴纳情况={}
  写出文件([[tysj/帮派缴纳情况.txt]],table.tostring(帮派缴纳情况))
else
   帮派缴纳情况=table.loadstring(读入文件([[tysj/帮派缴纳情况.txt]]))
end
if f函数.文件是否存在([[tysj/炼丹炉.txt]])==false then
  炼丹炉={下注时间=120,转盘时间 = 15,停止时间=120}
  写出文件([[tysj/炼丹炉.txt]],table.tostring(炼丹炉))
else
   炼丹炉=table.loadstring(读入文件([[tysj/炼丹炉.txt]]))
end
if f函数.文件是否存在([[tysj/英雄排名.txt]])==false then
  英雄排名={第一名={},第二名={},第三名={}}
  写出文件([[tysj/英雄排名.txt]],table.tostring(英雄排名))
else
  英雄排名=table.loadstring(读入文件([[tysj/英雄排名.txt]]))
end
if f函数.文件是否存在([[tysj/剑会天下.txt]])==false then
      剑会天下={时间=os.time()+604800,奖励={},单人={},三人={},五人={},次数={}}
      写出文件([[tysj/剑会天下.txt]],table.tostring(剑会天下))
else
      剑会天下=table.loadstring(读入文件([[tysj/剑会天下.txt]]))
end
if f函数.文件是否存在([[tysj/自动回收.txt]])==false then
  自动回收={}
  写出文件([[tysj/自动回收.txt]],table.tostring(自动回收))
else
  自动回收=table.loadstring(读入文件([[tysj/自动回收.txt]]))
end
if f函数.文件是否存在([[tysj/签到数据.txt]])==false then
  签到数据={}
  写出文件([[tysj/签到数据.txt]],table.tostring(签到数据))
else
  签到数据=table.loadstring(读入文件([[tysj/签到数据.txt]]))
end

if f函数.文件是否存在([[tysj/辰星数据.txt]])==false then
    辰星数据={开启=false,时间=os.time(),队伍={},排行={}}
    写出文件([[tysj/辰星数据.txt]],table.tostring(辰星数据))
else
    辰星数据=table.loadstring(读入文件([[tysj/辰星数据.txt]]))
    辰星数据.开启=false
end



if f函数.文件是否存在([[自动充值/充值记录]])==false then
    lfs.mkdir([[自动充值/充值记录]])
end
充值数据={时间=os.time(),日志="",编号=1}

local 临时读取 =f函数.读配置(程序目录.."配置文件.ini","主要配置","编号记录")
if not 临时读取 or 临时读取=="空" or 临时读取=="" then
    f函数.写配置(程序目录.."配置文件.ini","主要配置","编号记录","1")
end
充值数据.编号 = tonumber(f函数.读配置(程序目录.."配置文件.ini","主要配置","编号记录"))
if not f函数.文件是否存在([[自动充值/充值记录/]]..取年月日1(os.time())..[[1.txt]]) then
    充值数据.编号 =1
    f函数.写配置(程序目录.."配置文件.ini","主要配置","编号记录","1")
end
if f函数.文件是否存在([[自动充值/充值记录/]]..取年月日1(os.time())..充值数据.编号 ..[[.txt]]) then
    local 日志 = 读入文件([[自动充值\充值记录\]]..取年月日1(os.time())..充值数据.编号..[[.txt]])
    if #日志<10240 then
        充值数据.日志=日志
    else
        充值数据.编号 = 充值数据.编号 + 1
    end
end




__S服务:启动(服务端参数.ip,服务端参数.端口)
__S服务:置标题(服务端参数.名称.."服务端    当前版本号："..服务端参数.版本)
local 临时题库=读入文件("tk.txt")
local 题库=分割文本(临时题库,"#-#")

for n=1,#题库 do
  科举题库[n]=分割文本(题库[n],"=-=")
end

__gge.print(true,14,format("加载题库结束，总共加载了%s道科举题目",#科举题库).."\n")
__gge.print(false,10,"☆---------------------------------------------------------------------☆\n")
临时题库 = 读入文件("sjtk.txt")
临时题库 = 分割文本(临时题库, "*")
for n = 1, #临时题库 do
  临时题库[n] = 分割文本(临时题库[n], "？")
  三界题库[n] = {
    问题 = 临时题库[n][1],
    答案 = 临时题库[n][2]
  }
end
三界书院 = {答案 = "",开关 = false,结束 = 60,起始 = os.time(),间隔 = 取随机数(30, 90) ,名单 = {}}

__gge.print(true,14,format("加载题库结束，总共加载了%s道三界题目",#科举题库).."\n")


if not 剑会天下.时间 then
    剑会天下.时间=os.time()+604800
    剑会天下.奖励={}
end
剑会天下.单人={}
剑会天下.三人={}
剑会天下.五人={}
剑会天下.次数={}
if 经验数据.排行 == nil then
  经验数据.排行={}
  经验数据.百亿={}
  经验数据.千亿={}
end
for n, v in pairs(加载任务) do
  任务数据[v.存储id]=DeepCopy(v)
end


__gge.print(false,10,"☆---------------------------------------------------------------------☆\n")
__gge.print(true,14,"【数据加载结束】·····\n")
__gge.print(false,10,"☆---------------------------------------------------------------------☆\n")

藏宝阁处理类:加载数据()
__gge.print(false,6,"----------------------------")
__gge.print(false,10,"命令输入说明")
__gge.print(false,6,"---------------------------------\n")
__gge.print(false,11,"@gxsc ")
__gge.print(false,10,"刷新商城 ")
__gge.print(false,11,"      @bcsj ")
__gge.print(false,10,"保存数据 ")
__gge.print(false,11,"        @bcrz ")
__gge.print(false,10,"保存日志 ")
__gge.print(false,6,"\n")
__gge.print(false,11,"@gbyx ")
__gge.print(false,10,"关闭服务器通知 ")
__gge.print(false,11,"@sctj ")
__gge.print(false,10,"刷新商城购买处理")
__gge.print(false,11," @gxblpz ")
__gge.print(false,10,"刷新爆率数据")
__gge.print(false,6,"\n")
__gge.print(false,11,"@gxzdpz ")
__gge.print(false,10,"刷新战斗数据")
__gge.print(false,11," @gxsdpz ")
__gge.print(false,10,"刷新商店数据")
__gge.print(false,11,"   @gxqtpz ")
__gge.print(false,10,"刷新活动月卡等配置")
__gge.print(false,6,"\n")
__gge.print(false,11,"@gxzdy ")
__gge.print(false,10,"更新所有自定义数据")
__gge.print(false,11,"  @czshuj ")
__gge.print(false,10,"清空当天数据")
__gge.print(false,10,"\n-------------------------------------------------------------------------\n")


__S服务:置预投递数量(2000)
--__S服务:置缓冲区大小()
--/* 设置 Socket 缓存池大小（通常设置为平均并发连接数量的 1/3 - 1/2） */
__S服务:置Socket缓存池大小(1000)
--/* 设置 Socket 缓存池回收阀值（通常设置为 Socket 缓存池大小的 3 倍） */
__S服务:置Socket缓存池回收阀值(3000)
--/* 设置内存块缓存池大小（通常设置为 Socket 缓存池大小的 2 - 3 倍） */
__S服务:置内存块缓存池大小(3000)
--/* 设置内存块缓存池回收阀值（通常设置为内存块缓存池大小的 3 倍） */
__S服务:置内存块缓存池回收阀值(9000)
__gge.print(false,11,"缓存池大小")
__gge.print(false,6,__S服务:取Socket缓存池大小())
__gge.print(false,11,"   内存缓存池大小")
__gge.print(false,6,__S服务:取内存块缓存池大小())
__gge.print(false,11,"   预投递数量")
__gge.print(false,6,__S服务:取预投递数量())
__gge.print(false,11,"   缓冲区大小")
__gge.print(false,6,__S服务:取缓冲区大小())
__gge.print(false,10,"\n-------------------------------------------------------------------------\n")








function __S服务:启动成功()
  return 0
end



function 开启服务()
  __gge.print(false,14,"您的机器码已授权成功！\n")
  __gge.print(false,10,"☆---------------------------------------------------------------------☆\n")
    __gge.print(false,10,"请开始游戏!\n")
    __gge.print(false,10,"☆---------------------------------------------------------------------☆\n")
    验证版本=nil
    return
end
在线人数=0



function __S服务:连接进入(ID,IP,PORT)

  if f函数.读配置(程序目录 .. "ip封禁.ini", "ip", IP)=="1" or f函数.读配置(程序目录 .. "ip封禁.ini", "ip", IP)==1 then
        __S服务:输出(string.format("封禁ip的客户进入试图进入(%s):%s:%s", ID, IP, PORT))
        发送数据(ID,997,"")
        return 0
  end
  local 连接数量 = 0
  for k,v in pairs(__C客户信息) do
      连接数量=连接数量+1
  end
  if 连接数量 < 10 and IP~=nil then
      if IP==服务端参数.网关ip and 网关认证==false then
          __S服务:输出(string.format('网关进入(%s):%s:%s',ID, IP,PORT))
      else
          __S服务:输出(string.format('管理工具进入(%s):%s:%s',ID, IP,PORT))
      end
        __C客户信息[ID] = {
          IP = IP,
          认证=os.time(),
          PORT = PORT
        }
       if IP==服务端参数.网关ip and 网关认证==false then
          网关认证=true
          __C客户信息[ID].网关=true
          服务端参数.网关id=ID
       end
  else
      发送数据(ID,998,"你已经登录了游戏,请勿多开")
      __S服务:断开连接(ID)
  end
end


function __S服务:连接退出(ID)
  if __C客户信息[ID] then
      if __C客户信息[ID].网关 then
          网关认证=false
          __S服务:输出(string.format('网关客户退出(%s):%s:%s', ID,__C客户信息[ID].IP,__C客户信息[ID].PORT))
      end
      __C客户信息[ID]=nil
  else
      __S服务:输出("连接不存在(连接退出)。")
  end
  collectgarbage("collect")
end

function __S服务:数据到达(ID,...)
  if ID == nil then
    print("接收空链接数据，异常抛出")
    return
  end

  if localmp~=nil then
    if __C客户信息[ID] then
        if __C客户信息[ID].网关 then
            local arg = localmp.unpack(...)
            --table.insert(接收缓存,arg)
            网络处理类:数据处理(arg[1],arg[2])
        else
            local arg = localmp.unpack(...)
            管理工具类:数据处理(ID,arg)

        end
    else
      __S服务:输出("连接不存在(数据到达)。")
    end

  end
end

function __S服务:错误事件(ID,EO,IE)
  if __C客户信息[ID] then
    __S服务:输出(string.format('错误事件(%s):%s,%s:%s', ID,__错误[EO] or EO,__C客户信息[ID].IP,__C客户信息[ID].PORT))
  else
    __S服务:输出("连接不存在(错误事件)。")
  end
end

function 刷新战斗序号()
        战斗序号={收到=取随机数(5600,5699),发送=取随机数(5700,5799)}
        for i,v in pairs(玩家数据) do
            发送数据(v.连接id,86,{发送=战斗序号.收到,收到=战斗序号.发送})
        end
end




function 循环函数()
    服务端参数.运行时间=服务端参数.运行时间+1
    if os.time()-服务端参数.启动时间>=1 then
        if os.date("%H", os.time())=="00" and os.date("%M", os.time())=="00" and os.date("%S", os.time())=="00" then
              师门数据={}
              押镖数据={}
              心魔宝珠={}
              十二生肖={}
              科举数据={}
              双倍数据={}
              三倍数据={}
              在线时间={}
              生死劫数据.次数={}
              活动次数={}  --12点清空次数
              活跃数据={}
              if 剑会天下.时间<= os.time() then
                  剑会天下={时间=os.time()+604800,奖励={},单人={},三人={},五人={},次数={}}
              else
                   剑会天下.单人={}
                   剑会天下.三人={}
                   剑会天下.五人={}
                   剑会天下.次数={}
              end
              藏宝阁处理类:加载数据()
              任务处理类:开启游泳比赛()
              任务处理类:开启镖王活动()
              任务处理类:开启迷宫()
              刷新战斗序号()
              发送公告("#G美好的一天从这一秒开始，游戏对应的活动任务数据已经刷新，大家可以前去领取任务或参加活动了")
              for n, v in pairs(任务数据) do
                if 任务数据[n].类型==7 then
                  local id=任务数据[n].玩家id
                  if 玩家数据[id]~=nil then
                    玩家数据[id].角色:取消任务(n)
                    常规提示(id,"由于科举数据已经刷新，您本次的活动资格已经被强制取消，请重新参加此活动！")
                  end
                  任务数据[n]=nil
                end
              end
              if 假人摆摊 and 摆摊假人类 then
                  摆摊假人类:加载摆摊()
              end
        end
        整秒处理(os.date("%S", os.time()))
        服务端参数.启动时间=os.time()

    end
    if os.date("%X", os.time())==os.date("%H", os.time())..":00:00" then
        整点处理(os.date("%H", os.time()))
    elseif 服务端参数.分钟~=os.date("%M", os.time()) and os.date("%S", os.time())=="00" then
        整分处理(os.date("%M", os.time()))
    end

    if 战斗准备类 ~= nil then
        战斗准备类:更新()
    end


    if os.time()-保存数据>=1200 then
        保存系统数据()
        保存所有玩家数据()
        保存数据=os.time()
    end

end

function 整秒处理(时间)


        if 服务器关闭 ~= nil and 服务器关闭.开关 then
            服务器关闭.计时=服务器关闭.计时-1
            __S服务:输出("服务器关闭倒计时："..服务器关闭.计时)
            if 服务器关闭.计时<=60 and 服务器关闭.计时>0 then
              广播消息({内容="#Y/服务器将在#R/"..服务器关闭.计时.."#Y/秒后关闭,请所有玩家立即下线。",频道="xt"})
            elseif 服务器关闭.计时<=0 then
              玩家全部下线()
              os.exit()
            end
        end

        时辰函数()
        if 任务处理类 ~= nil then
            任务处理类:更新()
        end
        if 副本处理类 ~= nil  then
            副本处理类:更新()
        end
        if 走动假人 then
            假人玩家类:走动()
        end

        彩虹争霸:活动定时器()
        长安保卫战:活动定时器()

        if os.time()-塔怪刷新>=600 then
            任务处理类:设置大雁塔怪(id)
            塔怪刷新=os.time()
        elseif os.time()-剑会匹配>=5 then
             系统处理类:剑会单人匹配()
             系统处理类:剑会三人匹配()
             系统处理类:剑会五人匹配()
             剑会匹配=os.time()
        elseif os.time()-商店刷新>=7200 then
             商店bb={}
             变异商店bb={}
             商店刷新=os.time()

       end


      if 三界书院.开关 and 三界书院.结束 <= os.time() - 三界书院.起始 then
          三界书院.开关 = false
          for n = 1, #三界书院.名单 do
            if 玩家数据[三界书院.名单[n].id] ~= nil then
              玩家数据[三界书院.名单[n].id].道具:给予道具(三界书院.名单[n].id,"金银锦盒",5)
              玩家数据[三界书院.名单[n].id].角色:添加银子(1000,"答题",1)
            end
          end
          广播消息({内容="#Y/正确答案：#R/" .. 三界书院.答案,频道="xt"})
          if #三界书院.名单 == 0 then
              广播消息({内容="#Y/真是遗憾，竟然无人可以回答正确。",频道="xt"})
          else
              local 卡片等级=取随机数(1,3)
              广播消息({内容="#Y/知识就是金钱，每一位作答正确的玩家均获得1000银子，5仙玉以作奖励#G".. 三界书院.名单[1].名称 .. "#Y/以#R/" .. 三界书院.名单[1].用时 .. "#Y/秒惊人的飞速抢先作答正确，获得了额外的#G/10#Y/个金银锦盒和一张#G/"..卡片等级.."#Y/级怪物卡片的奖励和2000银子，10点仙玉",频道="xt"})
              if 玩家数据[三界书院.名单[1].id] ~= nil then
                玩家数据[三界书院.名单[1].id].角色:添加银子(2000,"答题",1)
                玩家数据[三界书院.名单[1].id].道具:给予道具(三界书院.名单[1].id, "金银锦盒",10)
                玩家数据[三界书院.名单[1].id].道具:给予道具(三界书院.名单[1].id, "怪物卡片", 卡片等级)
                常规提示(三界书院.名单[1].id,"你获得了一张"..卡片等级.."级怪物卡片和10个金银锦盒！")
              end
          end
      end

      if 炼丹炉~=nil then
          游戏活动类:炼丹更新()
      end
      if 迷宫数据.开关 then
        if os.time()-迷宫数据.事件>=600 then
          迷宫数据.事件=os.time()
          任务处理类:刷新迷宫小怪()
        end
      end


      if 宝藏山数据.开关 then
            宝藏山数据.间隔=宝藏山数据.间隔-1
          if 宝藏山数据.间隔==60 then
            地图处理类:当前消息广播1(5001,"#Y各位玩家请注意，宝藏山将在#R1#Y分钟后刷出宝箱。")
          elseif 宝藏山数据.间隔==30 then
            地图处理类:当前消息广播1(5001,"#Y各位玩家请注意，宝藏山将在#R30#Y秒后刷出宝箱。")
          elseif 宝藏山数据.间隔<=0 then
            任务处理类:宝藏山刷出宝箱()
            宝藏山数据.间隔=180
          end
          if os.time()-宝藏山数据.起始>=3600 then
            宝藏山数据.开关=false
            广播消息({内容="#G/宝藏山活动已经结束，处于场景内的玩家将被自动传送出场景。",频道="xt"})
            地图处理类:清除地图玩家(5001,1226,115,15)
          end
      end

      if 帮战活动类.入场开关 and os.time()-帮战活动类.活动计时>=600 then
         帮战活动类:开启比赛()
         帮战活动类.活动计时=os.time()
      end

      if 帮战活动类.活动开关 and os.time()-帮战活动类.活动计时>=3600 then
          帮战活动类:刷出宝箱处理()
          帮战活动类.活动计时=os.time()
      end
      if 帮战活动类.宝箱开关 and os.time()-帮战活动类.活动计时>=1800 then
          帮战活动类:结束比赛()
          帮战活动类.活动计时=os.time()
      end
      for n, v in pairs(玩家数据) do
              if 玩家数据[n]~=nil and 玩家数据[n].角色~=nil and 玩家数据[n].角色.数据~=nil  and 玩家数据[n].管理 == nil then
                  if 玩家数据[n].角色.数据.在线时间~=nil then
                     玩家数据[n].角色:增加在线时间()
                  end
                  if (not 玩家数据[n].战斗 or 玩家数据[n].战斗==0) and 取队长权限(n) then
                      if 玩家数据[n].角色:取任务(300)~=0  and 玩家数据[n].角色.数据.跑镖 and 玩家数据[n].角色.数据.跑镖<= os.time() then
                          战斗准备类:创建战斗(n,110038,0)
                      end
                      if (not 玩家数据[n].角色:取任务(411) or 玩家数据[n].角色:取任务(411)==0) and 玩家数据[n].角色.数据.地图数据.编号==1621  then
                            地图处理类:跳转地图(n,1001,204,112)
                      end
                      if 玩家数据[n].自动抓鬼 and type(玩家数据[n].自动抓鬼)=="table" and 玩家数据[n].自动抓鬼.开启 and 玩家数据[n].自动抓鬼.时间 and 玩家数据[n].自动抓鬼.时间<= os.time() then
                          系统处理类:自动抓鬼(n)
                      end
                      if 玩家数据[n].自动遇怪 and 玩家数据[n].自动遇怪 ~=0 and os.time()-玩家数据[n].自动遇怪>=2  and 取场景等级(玩家数据[n].角色.数据.地图数据.编号) then
                          玩家数据[n].自动遇怪 = 0
                          local 临时xy =地图处理类.地图坐标[玩家数据[n].角色.数据.地图数据.编号]:取随机点()
                          local 路径 ={x =临时xy.x,y=临时xy.y,数字id = n,距离=0}
                          地图处理类:移动请求(玩家数据[n].连接id,路径,n)
                          发送数据(玩家数据[n].连接id,100.1,路径)
                      end
                  end
                --发送数据(玩家数据[n].连接id,76541,os.time())  --每秒给客户端发送一个时间做为认证使用
              end
        end


end
function 整点处理(时刻)
  if 服务端参数.小时==时刻 then
    return 0
  else
    服务端参数.小时=时刻
    服务端参数.分钟="00"
  end

    if 帮派数据 ~= nil then
          for i=1,#帮派数据 do
                if 帮派数据[i] ~= nil then
                    if 帮派数据[i].帮派资金.当前 <= 帮派数据[i].帮派资金.上限*0.01 then
                        广播帮派消息({内容="[整点维护]#R/本次维护由于帮派资金不足未获得国家相应补助,并且导致帮派繁荣度、安定度、人气度各下降100点",频道="bp"},帮派数据[i].帮派编号)
                        帮派数据[i].繁荣度 = 帮派数据[i].繁荣度 -100
                        帮派数据[i].安定度 = 帮派数据[i].安定度 -100
                        帮派数据[i].人气度 = 帮派数据[i].人气度 -100
                        if 帮派数据[i].繁荣度 <= 100 then
                          帮派数据[i].繁荣度 = 100
                        end
                        if 帮派数据[i].安定度 <= 50 then
                          帮派数据[i].安定度 = 50
                        end
                        if 帮派数据[i].人气度 <= 50 then
                          帮派数据[i].人气度 = 50
                        end
                    else
                        帮派处理类:维护处理(i)
                    end
                end
          end
    end
    if 时刻=="11" then
        任务处理类:开启宝藏山()
    elseif 时刻=="23" then
        游泳开关=false
        镖王活动={开关=false}
        迷宫数据={开关=false}
    elseif  时刻=="12" then
          刷新战斗序号()
    elseif 时刻=="19" then
        任务处理类:开启宝藏山()
    end

end

function 整分处理(时间)
    服务端参数.分钟=时间

        if 时间=="00" or 时间=="10" or 时间=="20" or 时间=="30" or 时间=="40" or 时间=="50" then
              商店处理类:刷新跑商商品买入价格()
              for i,v in pairs(跑商) do
                跑商[i] = 取商品卖出价格(i)
              end
              local 玩家数量 = 0
              for i,v in pairs(玩家数据) do
                  if v.角色 and v.角色.数据.帮派加成 and v.角色.数据.帮派加成.开关 then
                      if os.time()>=v.角色.数据.帮派加成.时间  then
                          for n, k in pairs(帮派属性加成[1]) do
                                玩家数据[i].角色.数据[n] = 玩家数据[i].角色.数据[n] - 玩家数据[i].角色.数据.帮派加成[n]
                          end
                          玩家数据[i].角色.数据.帮派加成.开关 = false
                          玩家数据[i].角色.数据.帮派加成.时间 = 0
                          常规提示(玩家数据[i].角色.数据.数字id,"你的帮派加成已到期")
                          玩家数据[i].角色:刷新信息()
                      end
                  end
                  玩家数量=玩家数量+1
              end
              __S服务:置标题(服务端参数.名称.."服务端    当前版本号："..服务端参数.版本.."当前玩家在线："..玩家数量)
              collectgarbage("collect")
        end
        if 服务端参数.小时 + 0 >= 12 and 服务端参数.小时 + 0 <= 17 and 三界书院.间隔 <= os.time() - 三界书院.起始 then
            三界书院.起始 = os.time()
            任务处理类:开启三界书院()
        end
        if 自定义数据.活动刷新时间 then
            for k,v in pairs(自定义数据.活动刷新时间) do
                 if (v.时间==0 or v.时间=="0" or tonumber(服务端参数.小时) == tonumber(v.时间)) and tonumber(时间)  == tonumber(v.分钟)  then
                    开启投放活动(v.名称)
                  end
             end
        end
        if 自定义数据.活动任务时间 then
              if 是否开启活动("帮战活动") then
                  帮战活动类:活动开启()
              end
              if 是否开启活动("剑会天下") then
                    游戏活动类:开启剑会天下()
                    剑会时间 =os.time()
              end
              if 是否开启活动("世界挑战") then
                    刷新世界挑战()
                    世界时间 =os.time()
              end
              if 是否开启活动("天降辰星") then
                  任务处理类:刷出天降辰星()
              end
              if 是否开启活动("嘉年华") then
                  嘉年华:开启活动()
                  嘉年华时间=os.time()
              end
        end

        if 剑会时间 and os.time() - 剑会时间>=3700 then
           游戏活动类:关闭剑会天下()
           剑会时间 =nil
        end
        if 世界时间 and os.time() - 世界时间>=7200 then
           结束世界挑战()
           世界时间 =nil
        end
        if 辰星数据 and 辰星数据.开启 and 辰星数据.时间 and os.time() - 辰星数据.时间>=7200 then
           任务处理类:结束天降辰星()
        end
        if 嘉年华时间 and os.time() - 嘉年华时间>=14400 then
            if os.time() - 嘉年华时间>=14400 then
               嘉年华:关闭活动()
               嘉年华时间 =nil
            elseif 时间=="15" or  时间=="31" or  时间=="46" or  时间=="59" then
              self:刷出怪物()
            end
        end
        if 时间=="28" then
            商店处理类:刷新珍品()
        end
end


function 开启投放活动(名称)

        if 名称=="天降灵猴" then
              任务处理类:刷出天降灵猴()
        elseif 名称=="地煞星" then
                任务处理类:开启地煞星任务()
        elseif 名称=="四墓灵鼠" then
                任务处理类:刷出四墓灵鼠()
        elseif 名称=="妖魔鬼怪" then
                任务处理类:刷出妖魔鬼怪()
        elseif 名称=="福利宝箱" then
                任务处理类:福利宝箱()
        elseif 名称=="糖果派对" then
                任务处理类:糖果派对()
        elseif 名称=="知了王" then
                任务处理类:刷出知了王()
        elseif 名称=="知了先锋" then
                任务处理类:刷出知了先锋()
        elseif 名称=="创世佛屠" then
                任务处理类:刷出创世佛屠()
        elseif 名称=="善恶如来" then
                任务处理类:刷出善恶如来()
        elseif 名称=="天罡星" then
                任务处理类:开启天罡星任务()
        elseif 名称=="邪恶年兽" then
                任务处理类:邪恶年兽()
        elseif 名称=="门派入侵" then
                任务处理类:刷出门派入侵()
        elseif 名称=="世界BOSS" then
                任务处理类:刷新世界BOSS()
        elseif 名称=="星宿" then
                任务处理类:刷出星宿()
        elseif 名称=="经验宝宝" then
                任务处理类:刷出经验宝宝()
        elseif 名称=="倔强青铜" then
                任务处理类:刷出倔强青铜()
        elseif 名称=="秩序白银" then
                任务处理类:刷出秩序白银()
        elseif 名称=="荣耀黄金" then
                任务处理类:刷出荣耀黄金()
        elseif 名称=="永恒钻石" then
                任务处理类:刷出永恒钻石()
        elseif 名称=="至尊星耀" then
                任务处理类:刷出至尊星耀()
        elseif 名称=="最强王者" then
                任务处理类:刷出最强王者()
        elseif 名称=="星官" then
                任务处理类:刷出星官()
        elseif 名称=="影青龙" then
                任务处理类:刷新影青龙()
        elseif 名称=="影朱雀" then
                任务处理类:刷新影朱雀()
        elseif 名称=="影白虎" then
                任务处理类:刷新影白虎()
        elseif 名称=="影玄武" then
                任务处理类:刷新影玄武()
        elseif 名称=="影麒麟" then
                任务处理类:刷新影麒麟()
        elseif 名称=="新冠病毒" then
                任务处理类:刷出新冠状病毒()
        elseif 名称=="财神爷" then
                任务处理类:刷出财神爷()
        elseif 名称=="十二生肖" then
                任务处理类:刷出新十二生肖()
        elseif 名称=="桐人" then
                任务处理类:刷新桐人()
        elseif 名称=="魔化桐人" then
                任务处理类:刷新魔化桐人()
        elseif 名称=="混世魔王" then
                任务处理类:刷新混世魔王()
        elseif 名称=="天庭叛逆" then
                任务处理类:设置天庭叛逆()
        elseif 名称=="捣乱年兽" then
                任务处理类:捣乱的年兽()
        elseif 名称=="万象福" then
                任务处理类:刷出万象福()
        elseif 名称=="新春快乐" then
                任务处理类:刷出新春快乐()
        elseif 名称=="小小盲僧" then
                任务处理类:刷出小小盲僧()
        end
end





function 是否开启活动(活动)
  if 自定义数据.活动任务时间==nil or 自定义数据.活动任务时间[活动]==nil then
    return false
  end
  local 活动数据 = 自定义数据.活动任务时间[活动]
  if 活动数据.时间==服务端参数.小时+0 and 活动数据.分钟==服务端参数.分钟+0 then
        local 当前 =tonumber(os.date("%w", os.time()))
        if type(活动数据.日期)=="string" then
            if 活动数据.日期=="每天" then
                return true
            elseif (string.find(活动数据.日期, "一") or string.find(活动数据.日期, "1")) and 当前==1 then
                    return true
            elseif (string.find(活动数据.日期, "二") or string.find(活动数据.日期, "2")) and 当前==2 then
                    return true
            elseif (string.find(活动数据.日期, "三") or string.find(活动数据.日期, "3")) and 当前==3 then
                    return true
            elseif (string.find(活动数据.日期, "四") or string.find(活动数据.日期, "4")) and 当前==4 then
                    return true
            elseif (string.find(活动数据.日期, "五") or string.find(活动数据.日期, "5")) and 当前==5 then
                    return true
            elseif (string.find(活动数据.日期, "六") or string.find(活动数据.日期, "6")) and 当前==6 then
                    return true
            elseif (string.find(活动数据.日期, "日") or string.find(活动数据.日期, "天") or string.find(活动数据.日期, "0")) and 当前==0 then
                    return true
            end
        elseif type(活动数据.日期)=="table" then
              for k,v in pairs(活动数据.日期) do
                  if 当前==v then
                      return true
                  end
              end
        elseif type(活动数据.日期)=="number" and 当前==活动数据.日期 then
              return true
        end
  end
  return false

end

function 刷新排行榜(id)
  local 符合=true
  符合=true

  for k=1,#排行榜数据.玩家伤害排行 do
    if 排行榜数据.玩家伤害排行[k].id==id then
      if 排行榜数据.玩家伤害排行[k].分数==玩家数据[id].角色.数据.伤害 then --id一样,数据一样,则不符合
        符合=false
      else
        table.remove(排行榜数据.玩家伤害排行,k)
      end
      break
    end
  end
  if 符合 then
    排行榜数据.玩家伤害排行[#排行榜数据.玩家伤害排行+1]={id=id,分数=玩家数据[id].角色.数据.伤害,名称=玩家数据[id].角色.数据.名称}
  end
  if #排行榜数据.玩家伤害排行>=1 then

    table.sort(排行榜数据.玩家伤害排行,function(a,b) return a.分数>b.分数 end )

  end
  if #排行榜数据.玩家伤害排行>10 then --长度大于10则删除10以后的元素
    for m=11,#排行榜数据.玩家伤害排行 do
      table.remove(排行榜数据.玩家伤害排行)
    end
  end


    --刷新玩家灵力排行
  符合=true
  for k=1,#排行榜数据.玩家灵力排行 do
    if 排行榜数据.玩家灵力排行[k].id==id then
      if 排行榜数据.玩家灵力排行[k].分数==玩家数据[id].角色.数据.法伤 then --id一样,数据一样,则不符合
        符合=false
      else
        table.remove(排行榜数据.玩家灵力排行,k)
      end
      break
    end
  end
  if 符合 then
    排行榜数据.玩家灵力排行[#排行榜数据.玩家灵力排行+1]={id=id,分数=玩家数据[id].角色.数据.法伤,名称=玩家数据[id].角色.数据.名称}
  end
  if #排行榜数据.玩家灵力排行>=1 then
    table.sort(排行榜数据.玩家灵力排行,function(a,b) return a.分数>b.分数 end )
  end
  if #排行榜数据.玩家灵力排行>10 then --长度大于10则删除10以后的元素
    for m=11,#排行榜数据.玩家灵力排行 do
      table.remove(排行榜数据.玩家灵力排行)
    end
  end


------------------------------------出师---------------------------------------------------------
  符合=true

  for k=1,#排行榜数据.玩家师傅排行 do
    if 排行榜数据.玩家师傅排行[k].id==id then
      if 排行榜数据.玩家师傅排行[k].出师==玩家数据[id].角色.数据.出师数量 then --id一样,数据一样,则不符合
        符合=false
      else
        table.remove(排行榜数据.玩家师傅排行,k)
      end
      break
    end
  end
  if 符合 then
    排行榜数据.玩家师傅排行[#排行榜数据.玩家师傅排行+1]={id=id,出师=玩家数据[id].角色.数据.出师数量,名称=玩家数据[id].角色.数据.名称}
  end
  if #排行榜数据.玩家师傅排行>1 then
    table.sort(排行榜数据.玩家师傅排行,function(a,b) return a.出师>b.出师 end )
  end
  if #排行榜数据.玩家师傅排行>10 then --长度大于10则删除10以后的元素
    for m=11,#排行榜数据.玩家师傅排行 do
      table.remove(排行榜数据.玩家师傅排行)
    end
  end


  ------------------------------------剑会---------------------------------------------------------
  符合=true

  for k=1,#排行榜数据.玩家剑会排行 do

      if 排行榜数据.玩家剑会排行[k].剑会积分==剑会天下[id].当前积分 then --id一样,数据一样,则不符合
         符合=false
      else
          table.remove(排行榜数据.玩家剑会排行,k)
      end
      break
    end

  if 符合 then
      排行榜数据.玩家剑会排行[#排行榜数据.玩家剑会排行+1]={剑会积分=剑会天下[id].当前积分,剑会名称=玩家数据[id].角色.数据.名称,剑会等级=玩家数据[id].角色.数据.等级,剑会门派=玩家数据[id].角色.数据.门派}
  end
  if #排行榜数据.玩家剑会排行>1 then
    table.sort(排行榜数据.玩家剑会排行,function(a,b) return a.剑会积分>b.剑会积分 end )
  end
  if #排行榜数据.玩家剑会排行>10 then --长度大于10则删除10以后的元素
    for m=11,#排行榜数据.玩家剑会排行 do
      table.remove(排行榜数据.玩家剑会排行)
    end
  end

  local 已领奖励 =1
  if 剑会天下[id].当前积分<1500 and (not 剑会天下.奖励[id] or not 剑会天下.奖励[id][1]) then
      已领奖励 =0
  elseif 剑会天下[id].当前积分>=1500 and 剑会天下[id].当前积分<1800 and (not 剑会天下.奖励[id] or not 剑会天下.奖励[id][2]) then
      已领奖励 =0
  elseif 剑会天下[id].当前积分>=1800 and 剑会天下[id].当前积分<2400 and (not 剑会天下.奖励[id] or not 剑会天下.奖励[id][3]) then
      已领奖励 =0
  elseif 剑会天下[id].当前积分>=2400 and 剑会天下[id].当前积分<3000 and (not 剑会天下.奖励[id] or not 剑会天下.奖励[id][4]) then
      已领奖励 =0
  elseif 剑会天下[id].当前积分>=3000 and 剑会天下[id].当前积分<3600 and (not 剑会天下.奖励[id] or not 剑会天下.奖励[id][5]) then
      已领奖励 =0
  elseif 剑会天下[id].当前积分>=3600 and 剑会天下[id].当前积分<4200 and (not 剑会天下.奖励[id] or not 剑会天下.奖励[id][6]) then
      已领奖励 =0
  elseif 剑会天下[id].当前积分>=4200 and 剑会天下[id].当前积分<4800 and (not 剑会天下.奖励[id] or not 剑会天下.奖励[id][7]) then
      已领奖励 =0
  elseif 剑会天下[id].当前积分>=4800 and 剑会天下[id].当前积分<5400 and (not 剑会天下.奖励[id] or not 剑会天下.奖励[id][8]) then
      已领奖励 =0
  elseif 剑会天下[id].当前积分>=5400 and (not 剑会天下.奖励[id] or not 剑会天下.奖励[id][9]) then
      已领奖励 =0
  end
    ------------------------------------剑会季度---------------------------------------------------------
  符合=true
  for k=1,#排行榜数据.玩家剑会季度 do
    if 排行榜数据.玩家剑会季度[k].是否领取==已领奖励 then
        if 排行榜数据.玩家剑会季度[k].剑会积分1==剑会天下[id].当前积分 then --id一样,数据一样,则不符合
            符合=false
        else
            table.remove(排行榜数据.玩家剑会季度,k)
        end
        break
    end
end
  if 符合 then

      排行榜数据.玩家剑会季度[#排行榜数据.玩家剑会季度+1]={是否领取=已领奖励,剑会积分1=剑会天下[id].当前积分,剑会名称1=玩家数据[id].角色.数据.名称,剑会等级1=玩家数据[id].角色.数据.等级}
  end
  if #排行榜数据.玩家剑会季度>1 then
    table.sort(排行榜数据.玩家剑会季度,function(a,b) return a.剑会积分1>b.剑会积分1 end )
  end
  if #排行榜数据.玩家剑会季度>10 then --长度大于10则删除10以后的元素
    for m=11,#排行榜数据.玩家剑会季度 do
      table.remove(排行榜数据.玩家剑会季度)
    end
  end




    ------------------------------------镇妖层数---------------------------------------------------------
  符合=true

  for k=1,#排行榜数据.玩家镇妖层数 do
    if 排行榜数据.玩家镇妖层数[k].剑会门派2==玩家数据[id].角色.数据.门派 then
      if 排行榜数据.玩家镇妖层数[k].层数== 镇妖塔数据[id].层数 then --id一样,数据一样,则不符合
        符合=false
      else
        table.remove(排行榜数据.玩家镇妖层数,k)
      end
      break
    end
end
  if 符合 then
    排行榜数据.玩家镇妖层数[#排行榜数据.玩家镇妖层数+1]={剑会门派2=玩家数据[id].角色.数据.门派,层数=镇妖塔数据[id].层数,剑会名称2=玩家数据[id].角色.数据.名称,剑会等级2=玩家数据[id].角色.数据.等级}
  end
  if #排行榜数据.玩家镇妖层数>1 then
    table.sort(排行榜数据.玩家镇妖层数,function(a,b) return a.层数>b.层数 end )
  end
  if #排行榜数据.玩家镇妖层数>10 then --长度大于10则删除10以后的元素
    for m=11,#排行榜数据.玩家镇妖层数 do
      table.remove(排行榜数据.玩家镇妖层数)
    end
  end


  写出文件([[tysj/排行榜.txt]],table.tostring(排行榜数据))
end




function 启动服务端时的任务()
任务处理类:加载首席单位()
任务处理类:开启门派闯关()
任务处理类:开启游泳比赛()
任务处理类:开启皇宫飞贼()
任务处理类:开启镖王活动()
任务处理类:开启迷宫()
任务处理类:刷出妖魔鬼怪()
任务处理类:糖果派对()

任务处理类:设置大雁塔怪()
任务处理类:福利宝箱()
任务处理类:刷出创世佛屠()
任务处理类:刷出善恶如来()
任务处理类:刷出门派入侵()
任务处理类:刷出四墓灵鼠()
商店处理类:刷新珍品()
商店处理类:刷新跑商商品买入价格()
任务处理类:刷出天降灵猴()
任务处理类:刷出经验宝宝()
任务处理类:刷出倔强青铜()
任务处理类:刷出秩序白银()
任务处理类:刷出荣耀黄金()
任务处理类:刷出永恒钻石()
任务处理类:刷出至尊星耀()
任务处理类:刷出最强王者()
任务处理类:刷出星官()
任务处理类:刷新影青龙()
任务处理类:刷新影朱雀()
任务处理类:刷新影白虎()
任务处理类:刷新影玄武()
任务处理类:刷新影麒麟()
任务处理类:刷出新冠状病毒()
任务处理类:刷出新十二生肖()



end

启动服务端时的任务()



function 输入函数(t)

  if t=="@sctj" then
    刷新商城购买处理()
    __S服务:输出("商城购买处理已刷新")
  elseif t=="@gxsc" then
    刷新商城商品()
    __S服务:输出("商城商品数据更新成功")
  elseif t=="@bcsj" then
    保存所有玩家数据()
    保存系统数据()

  elseif t=="@qfjy" then
         if 全服禁言 then
              全服禁言 = false
          else
              全服禁言 = true
          end
  elseif t == "@gbyx" then
    服务器关闭={开关=true,计时=60,起始=os.time()}
    发送公告("#R各位玩家请注意，服务器将在1分钟后进行更新,届时服务器将临时关闭，请所有玩家注意提前下线。")
    广播消息({内容=format("#R各位玩家请注意，服务器将在5分钟后进行更新,届时服务器将临时关闭,，请所有玩家提前下线。"),频道="xt"})
    保存所有玩家数据()
    保存系统数据()
  elseif t == "@bcrz" then
    local 保存语句=""
    for n=1,#错误日志 do
      保存语句=保存语句..时间转换(错误日志[n].时间)..'：#换行符'..错误日志[n].记录..'#换行符'..'#换行符'
    end
    写出文件("错误日志.txt",保存语句)
    错误日志={}
    __S服务:输出("保存错误日志成功")
  elseif t=="@cklb" then
    查看在线列表()
  elseif t=="@gxzdy" then
      刷新自定义数据()
      __S服务:输出("自定义数据已更新")
  elseif t=="@gxblpz" then
        加载自定义爆率数据()
         __S服务:输出("自定义爆率数据已更新")


  elseif t=="@gxzdpz" then
         战斗准备类:加载战斗数据()
         __S服务:输出("自定义战斗数据已更新")
  elseif t=="@gxsdpz" then
        加载商店价格数据()
        商店处理类:更新商店价格数据()
        加载回收配置文档()
        加载新人礼包配置()
        __S服务:输出("自定义商店数据已更新")
  elseif t=="@gxqtpz" then
        刷新活动自定义数据()
        更新回收价格配置()
        加载敏感字判断()
         __S服务:输出("自定义其余数据已更新")




  elseif t=="@czshuj" then
              师门数据={}
              押镖数据={}
              心魔宝珠={}
              十二生肖={}
              科举数据={}
              双倍数据={}
              三倍数据={}
              在线时间={}
              生死劫数据.次数={}
              活动次数={}  --12点清空次数
              活跃数据={}
              if 剑会天下.时间<= os.time() then
                  剑会天下={时间=os.time()+604800,奖励={},单人={},三人={},五人={}}
              else
                   剑会天下.单人={}
                   剑会天下.三人={}
                   剑会天下.五人={}
                   剑会天下.次数={}
              end
              藏宝阁处理类:加载数据()
              任务处理类:开启游泳比赛()
              任务处理类:开启镖王活动()
              任务处理类:开启迷宫()
              for n, v in pairs(任务数据) do
                if v.类型==7 then
                    local id=v.玩家id
                    if 玩家数据[id]~=nil then
                        玩家数据[id].角色:取消任务(n)
                        常规提示(id,"由于科举数据已经刷新，您本次的活动资格已经被强制取消，请重新参加此活动！")
                    end
                    任务数据[n]=nil
                end
              end
               __S服务:输出("日常数据已重置")


  end

end


function 退出函数()
  保存所有玩家数据()
  保存系统数据()

end







function 玩家全部下线()
  保存所有玩家数据()
  保存系统数据()
  for n, v in pairs(玩家数据) do
    if 玩家数据[n]~=nil then
      发送数据(玩家数据[n].连接id,998,"您的账号已被强制下线，更新完毕时间咨询群管理~！")
    end
  end

end




刷新商城商品()
刷新商城购买处理()
刷新自定义数据()

if 摆摊假人类 then
    摆摊假人类:加载摆摊()
end



