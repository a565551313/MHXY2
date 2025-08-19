-- @Author: baidwwy
-- @Date:   2023-10-03 06:52:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-08-02 21:55:13
--======================================================================--
--======================================================================--
jcsj = os.time()
jcsjj = false
调试模式=false
客户端参数={}
客户端参数.分钟=os.date("%M", os.time())
客户端参数.小时=os.date("%H", os.time())
全局资源缓存={}
全局资源缓存弱 = setmetatable({}, {__mode = 'v'})
任务坐标={}
是否超链接 = false
全局游戏标题="梦幻西游 ONLINE"
授权名称="梦回长安"
版本 = 1.222
-- 添加版本检查相关变量
已检查版本 = false
最后检查时间 = 0

-- 简化的JSON解析函数
function 解析JSON(json_string)
    if not json_string or json_string == "" then
        return nil
    end

    -- 移除首尾空白
    json_string = json_string:match("^%s*(.-)%s*$")

    local function 跳过空白(str, pos)
        while pos <= #str and str:sub(pos, pos):match("%s") do
            pos = pos + 1
        end
        return pos
    end

    local function 解析字符串(str, pos)
        if str:sub(pos, pos) ~= '"' then
            return nil, pos
        end

        local start_pos = pos + 1
        local end_pos = start_pos

        while end_pos <= #str do
            if str:sub(end_pos, end_pos) == '"' and str:sub(end_pos-1, end_pos-1) ~= '\\' then
                break
            end
            end_pos = end_pos + 1
        end

        if end_pos > #str then
            return nil, pos
        end

        return str:sub(start_pos, end_pos - 1), end_pos + 1
    end

    local function 解析数字(str, pos)
        local start_pos = pos
        while pos <= #str and str:sub(pos, pos):match("[%d%.%-]") do
            pos = pos + 1
        end
        local num_str = str:sub(start_pos, pos - 1)
        return tonumber(num_str), pos
    end

    local function 解析值(str, pos)
        pos = 跳过空白(str, pos)

        if pos > #str then
            return nil, pos
        end

        local char = str:sub(pos, pos)

        -- 解析字符串
        if char == '"' then
            return 解析字符串(str, pos)

        -- 解析数字
        elseif char:match("[%d%-]") then
            return 解析数字(str, pos)

        -- 解析布尔值
        elseif str:sub(pos, pos + 3) == "true" then
            return true, pos + 4
        elseif str:sub(pos, pos + 4) == "false" then
            return false, pos + 5

        -- 解析null
        elseif str:sub(pos, pos + 3) == "null" then
            return nil, pos + 4

        -- 解析对象
        elseif char == "{" then
            local obj = {}
            pos = pos + 1
            pos = 跳过空白(str, pos)

            -- 检查空对象
            if pos <= #str and str:sub(pos, pos) == "}" then
                return obj, pos + 1
            end

            while pos <= #str do
                pos = 跳过空白(str, pos)

                -- 解析键
                local key, new_pos = 解析字符串(str, pos)
                if not key then break end
                pos = new_pos

                pos = 跳过空白(str, pos)

                -- 检查冒号
                if pos <= #str and str:sub(pos, pos) == ":" then
                    pos = pos + 1
                else
                    break
                end

                pos = 跳过空白(str, pos)

                -- 解析值
                local value, new_pos = 解析值(str, pos)
                if not value then break end
                pos = new_pos

                obj[key] = value

                pos = 跳过空白(str, pos)

                -- 检查结束或继续
                if pos <= #str then
                    if str:sub(pos, pos) == "}" then
                        return obj, pos + 1
                    elseif str:sub(pos, pos) == "," then
                        pos = pos + 1
                    else
                        break
                    end
                end
            end

            return obj, pos

        -- 解析数组
        elseif char == "[" then
            local arr = {}
            pos = pos + 1
            pos = 跳过空白(str, pos)

            -- 检查空数组
            if pos <= #str and str:sub(pos, pos) == "]" then
                return arr, pos + 1
            end

            while pos <= #str do
                pos = 跳过空白(str, pos)

                -- 解析值
                local value, new_pos = 解析值(str, pos)
                if not value then break end
                pos = new_pos

                table.insert(arr, value)

                pos = 跳过空白(str, pos)

                -- 检查结束或继续
                if pos <= #str then
                    if str:sub(pos, pos) == "]" then
                        return arr, pos + 1
                    elseif str:sub(pos, pos) == "," then
                        pos = pos + 1
                    else
                        break
                    end
                end
            end

            return arr, pos
        end

        return nil, pos
    end

    local result, _ = 解析值(json_string, 1)
    return result
end




-- 获取版本信息函数
function 获取版本信息()
    local 重试次数 = 2  -- 每个网络尝试的次数
    local 超时时间 = 5   -- curl超时时间(秒)

    -- 从本地config.json读取服务器列表
    local 网络列表 = {}
    print("正在读取config.json文件...")
    local config文件 = io.open("config.json", "r")
    if config文件 then
        local config内容 = config文件:read("*a")
        config文件:close()
        print("✓ 成功读取config.json文件")
        print("文件内容长度:", #config内容)

        local 解析成功, config数据 = pcall(解析JSON, config内容)
        print("JSON解析结果:", 解析成功)
        if config数据 then
            print("config数据类型:", type(config数据))
            print("servers字段:", config数据.servers)
        end
        if 解析成功 and config数据 and config数据.servers then
            for i, 服务器地址 in ipairs(config数据.servers) do
                -- 确保服务器地址以/结尾
                if 服务器地址:sub(-1) ~= "/" then
                    服务器地址 = 服务器地址 .. "/"
                end
                table.insert(网络列表, {
                    名称 = "服务器" .. i,
                    网址 = 服务器地址 .. "api/config.json"
                })
            end
        else
            print("解析config.json失败或未找到servers配置")
            -- 使用默认服务器列表作为备用
            网络列表 = {
                {名称 = "本地服务器", 网址 = "http://localhost:8182/api/config.json"},
                {名称 = "备用服务器", 网址 = "http://192.168.12.24:8228/api/config.json"}
            }
        end
    else
        print("无法读取config.json文件")
        -- 使用默认服务器列表作为备用
        网络列表 = {
            {名称 = "本地服务器", 网址 = "http://localhost:8182/api/config.json"},
            {名称 = "备用服务器", 网址 = "http://192.168.12.24:8228/api/config.json"}
        }
    end

    print("最终使用的服务器列表:")
    for i, 网络 in ipairs(网络列表) do
        print("  " .. i .. ". " .. 网络.名称 .. " -> " .. 网络.网址)
    end
    print("========================")

    -- 遍历网络列表尝试连接
    print("=== 开始尝试连接服务器 ===")
    print("服务器列表:")
    for i, 网络 in ipairs(网络列表) do
        print("  " .. i .. ". " .. 网络.名称 .. " -> " .. 网络.网址)
    end
    print("========================")

    for _, 网络 in ipairs(网络列表) do
        local 版本网址 = 网络.网址
        print("正在尝试连接: " .. 网络.名称 .. " -> " .. 版本网址)

        for 尝试 = 1, 重试次数 do
            local 命令 = 'curl -s -m ' .. 超时时间 .. ' "' .. 版本网址 .. '"'
            local 句柄 = io.popen(命令)

            if 句柄 then
                local 结果 = 句柄:read("*a")
                句柄:close()

                -- 直接使用curl返回的内容
                local json内容 = 结果

                -- 检查是否有内容
                if json内容 and json内容 ~= "" then
                        local 解析成功, 版本数据 = pcall(解析JSON, json内容)
                        if 解析成功 and 版本数据 then
                            -- 从服务器的config.json中提取version字段
                            if 版本数据.version then
                                tp.常规提示:打开("成功获取版本信息 from " .. 网络.名称 .. ": " .. 版本数据.version)
                                return 版本数据
                            else
                                if tp and tp.常规提示 and tp.常规提示.打开 then
                                    tp.常规提示:打开("服务器响应中未找到version字段")
                                end
                                print("请求网址: " .. 版本网址)
                                print("服务器响应中未找到version字段")
                                print("服务器返回内容: " .. json内容)
                            end
                        else
                            if tp and tp.常规提示 and tp.常规提示.打开 then
                                tp.常规提示:打开("解析版本信息失败: " .. tostring(版本数据))
                            end
                            print("请求网址: " .. 版本网址)
                            print("JSON解析错误: " .. tostring(版本数据))
                            print("原始响应内容: " .. json内容)
                        end
                else
                    if tp and tp.常规提示 and tp.常规提示.打开 then
                        tp.常规提示:打开("获取版本信息失败: 空响应")
                    end
                    print("请求网址: " .. 版本网址)
                    print("返回内容: 空")
                end

                -- 只要命令执行成功(句柄有效)，就不再重试该网络
                break
            else
                if 尝试 < 重试次数 then
                    print("尝试 " .. 尝试 .. " 失败，" .. 网络.名称 .. "无响应，即将重试...")
                    os.execute("sleep 1")  -- 等待1秒后重试
                else
                    print("尝试 " .. 尝试 .. " 失败，" .. 网络.名称 .. "无响应")
                end
            end
        end
    end

    -- 所有网络尝试都失败
    if tp and tp.常规提示 and tp.常规提示.打开 then
        tp.常规提示:打开("所有网络尝试失败，无法获取版本信息")
    end
    return nil
end

-- 格式化文件大小
function 格式化文件大小(字节数)
    if not 字节数 or 字节数 == 0 then
        return "未知"
    end

    local 单位 = {"B", "KB", "MB", "GB"}
    local 大小 = 字节数
    local 单位索引 = 1

    while 大小 >= 1024 and 单位索引 < #单位 do
        大小 = 大小 / 1024
        单位索引 = 单位索引 + 1
    end

    return string.format("%.2f %s", 大小, 单位[单位索引])
end

-- 读取本地配置文件版本的函数
function 读取本地版本()
    local 配置文件路径 = "config.json"
    local 文件 = io.open(配置文件路径, "r")

    if not 文件 then
        tp.常规提示:打开("无法打开配置文件:", 配置文件路径)
        return tostring(版本) -- 回退到全局变量
    end

    local 配置内容 = 文件:read("*a")
    文件:close()

    if not 配置内容 or 配置内容 == "" then
        tp.常规提示:打开("配置文件为空")
        return tostring(版本)
    end

    -- 解析JSON获取版本
    local 配置数据 = 解析JSON(配置内容)

    -- 直接从config.json的version字段读取版本
    if 配置数据 and 配置数据.version then
        print("从config.json读取本地版本:", 配置数据.version)
        return 配置数据.version
    -- 回退到全局变量
    else
        print("配置文件中未找到version字段，使用全局版本:", 版本)
        return tostring(版本)
    end
end

-- 读取本地配置文件热更器版本的函数
function 读取本地热更器版本()
    local 配置文件路径 = "config.json"
    local 文件 = io.open(配置文件路径, "r")

    if not 文件 then
        tp.常规提示:打开("无法打开配置文件:", 配置文件路径)
        return tostring(版本) -- 回退到全局变量
    end

    local 配置内容 = 文件:read("*a")
    文件:close()

    if not 配置内容 or 配置内容 == "" then
        tp.常规提示:打开("配置文件为空")
        return tostring(版本)
    end

    -- 解析JSON获取版本
    local 配置数据 = 解析JSON(配置内容)

    -- 直接从config.json的updater_version字段读取版本
    if 配置数据 and 配置数据.updater_version then
        print("从config.json读取本地热更器版本:", 配置数据.updater_version)
        return 配置数据.updater_version
    -- 回退到全局变量
    else
        print("配置文件中未找到updater_version字段")
        return tostring(版本)
    end
end

-- 检查版本更新函数
function 检查版本更新()
    local 版本信息 = 获取版本信息()
    if 版本信息 and 版本信息.version then
        local 服务器最新版本 = 版本信息.version
        local 本地版本 = 读取本地版本()

        print("服务器最新版本:", 服务器最新版本)
        print("本地游戏版本:", 本地版本)

        -- 版本比较函数
        local function 比较版本(版本1, 版本2)
            local function 分割版本(版本字符串)
                local 部分 = {}
                for 数字 in string.gmatch(tostring(版本字符串), "([^%.]+)") do
                    table.insert(部分, tonumber(数字) or 0)
                end
                return 部分
            end

            local 版本1部分 = 分割版本(版本1)
            local 版本2部分 = 分割版本(版本2)

            local 最大长度 = math.max(#版本1部分, #版本2部分)

            for i = 1, 最大长度 do
                local v1 = 版本1部分[i] or 0
                local v2 = 版本2部分[i] or 0

                if v1 > v2 then
                    return 1  -- 版本1更新
                elseif v1 < v2 then
                    return -1 -- 版本2更新
                end
            end

            return 0 -- 版本相同
        end

        -- 比较本地版本与服务器版本
        local 比较结果 = 比较版本(服务器最新版本, 本地版本)
        print("版本比较结果:", 比较结果)
        if 比较结果 > 0 then
            print("发现新版本，启动更新程序...")

            -- 构建详细的更新消息
            local 更新消息 = "发现新版本！\n\n"
            更新消息 = 更新消息 .. "当前版本: " .. 本地版本 .. "\n"
            更新消息 = 更新消息 .. "最新版本: " .. 服务器最新版本 .. "\n"

            -- 添加更新内容信息
            if 版本信息.info and 版本信息.info ~= "" then
                更新消息 = 更新消息 .. "更新内容: " .. 版本信息.info .. "\n"
            end

            -- 添加发布日期
            if 版本信息.release_date then
                更新消息 = 更新消息 .. "发布日期: " .. 版本信息.release_date .. "\n"
            end

            -- 添加更新大小
            if 版本信息.update_size then
                更新消息 = 更新消息 .. "更新大小: " .. 格式化文件大小(版本信息.update_size) .. "\n"
            end

            -- 添加发布说明
            if 版本信息.release_notes and 版本信息.release_notes ~= "" then
                更新消息 = 更新消息 .. "\n更新内容:\n" .. 版本信息.release_notes .. "\n"
            end

            更新消息 = 更新消息 .. "\n点击确定启动更新程序并关闭游戏"

            信息框(更新消息, "版本更新提示", 0)

            -- 检查更新程序是否存在
            local 版本化更新程序 = "GameUpdater-"..读取本地热更器版本()..".exe"
            local 通用更新程序 = "GameUpdater.exe"
            
            local 更新程序文件 = io.open(版本化更新程序, "r")
            if 更新程序文件 then
                更新程序文件:close()
                -- 启动版本化更新程序
                os.execute("start "..版本化更新程序)
                -- 关闭游戏
                引擎.关闭()
            else
                -- 检查通用更新程序是否存在
                local 通用更新程序文件 = io.open(通用更新程序, "r")
                if 通用更新程序文件 then
                    通用更新程序文件:close()
                    -- 启动通用更新程序
                    os.execute("start "..通用更新程序)
                    -- 关闭游戏
                    引擎.关闭()
                else
                    tp.常规提示:打开("#R更新程序不存在，无法启动自动更新.")
                end
            end


            return true
        else
            tp.常规提示:打开("当前已是最新版本")
        end
    end
    return false
end

function 分区内容()
    if 授权名称 == "梦回长安" then
        return[[
1 梦江南
1 1 江南一区 103.217.195.114 6884
1 2 本地测试 127.0.0.1 6884
        ]]
    elseif 授权名称 == "单机测试1" then
        return[[
1 单机测试1
1 1 单机测试1 127.0.0.1 10001
        ]]
    else
        return[[
1 测试
1 1 测试服 127.0.0.1 6884
        ]]
    end
end



--103.217.195.114 --127.0.0.1
if 授权名称=="单机" then
    调试模式=true
end

-- 加载头文件
require("script/全局/变量1")


引擎(全局游戏标题,全局游戏宽度,全局游戏高度,60,true)
require("script/数据中心/点库")
require("script/数据中心/物品库")
require("script/数据中心/头像库")
require("script/数据中心/技能库")
require("script/数据中心/宝宝库")
require("script/数据中心/音效库")
require("script/数据中心/明雷库")
require("script/数据中心/特效库")
require("script/数据中心/敌人信息")
require("script/数据中心/普通模型库")
require("script/数据中心/战斗模型库")
require("script/数据中心/坐骑库")
--require("script/数据中心/传送表")
require("script/数据中心/场景")
require("script/数据中心/染色")
require("script/数据中心/剧情动画")
require("script/新界面/符石数据")

玩家类 = require("script/全局/玩家")
假人类 =require("script/全局/假人")
-- 加载类
yq = 引擎
全局游戏音量=100
玩家显示开关=true
玩家加载开关=true
玩家摊位显示开关=true
连点模式=false
新道具行囊 = false

if f函数.读配置(程序目录.."config.ini","mhxy","新道具行囊") =="true" then
    新道具行囊=true
end
屏蔽锦衣效果=false
if f函数.读配置(程序目录.."config.ini","mhxy","锦衣效果") =="true" then
    屏蔽锦衣效果=true
end

屏蔽光环足迹效果=false
if f函数.读配置(程序目录.."config.ini","mhxy","光环足迹") =="true" then
    屏蔽光环足迹效果=true
end

新摆摊界面=false
if f函数.读配置(程序目录.."config.ini","mhxy","新摆摊界面") =="true" then
    新摆摊界面=true
end
坐骑显示=true
if f函数.读配置(程序目录.."config.ini","mhxy","坐骑显示") =="false" then
    坐骑显示=false
end
变身显示=true
if f函数.读配置(程序目录.."config.ini","mhxy","变身显示") =="false" then
    变身显示=false
end


yq.场景 = require("script/全局/主控")()
local 垂直 = f函数.读配置(程序目录.."config.ini","mhxy","垂直同步")
if 垂直 == "1" or 垂直 == "2" then

    yq.垂直同步(true)
else
    yq.垂直同步(false)
end
tp = yq.场景
游戏公告=require("script/显示类/游戏公告类")(tp)
Greedy类=require("script/系统类/Greedy")()
if jcsjj then
    错误关闭数=9999999
    引擎.关闭()
    更新函数,渲染函数 = nil,nil
    return 0
end
-- 服务器名称数据 = f函数.读配置(程序目录.."配置文件.ini","主要配置","服务器名称")
游戏传音=require("script/老摩托/防官传音")(tp)
战斗指令类=require("script/战斗类/战斗命令类")(tp)
战斗类=require("script/战斗类/战斗类")(tp)
战斗单位类=require("script/战斗类/战斗单位类")
战斗动画类=require("script/战斗类/战斗动画类")
宝宝类=require("Script/属性控制/宝宝")
collectgarbage("setpause", 100)
-- 添加这段代码：启动时版本检查
tp.常规提示:打开("游戏启动完成，正在检查版本...")
if not 已检查版本 then
    local 成功, 结果 = pcall(检查版本更新)
    if 成功 and 结果 then
        tp.常规提示:打开("检测到新版本，更新程序已启动")
    elseif 成功 then
        tp.常规提示:打开("当前版本是最新的")
    else
        tp.常规提示:打开("版本检查失败，可能是网络问题")
    end
    已检查版本 = true
end


local xrks = yq.渲染开始
local xrqc = yq.渲染清除
local xrjs = yq.渲染结束
local jc = false
网关连接 = true
停止连接 = true
服务状态 = false
重连时间 =os.time()
检测开启=0
时间记录=0
随机记录=0
随机1记录=0
动态加密文本 = ""
内存优化开关= false
if 内存优化开关 then
    动态加密文本 = 动态加密("@#%18918919")
end


function 时间转换(时间)
  return  "["..os.date("%m", 时间).."月"..os.date("%d", 时间).."日 "..os.date("%X", 时间).."]"
end

function 客户端连接断开()
    if  tp.场景 ~= nil then
        网关连接 = false
        停止连接 = false
        重连时间 =os.time()
        tp.常规提示:打开("#Y/断线重连中,请耐心等待,在提示连接成功前请不要进行操作,若连接时间较长，可以手动重启客户端")
    end
end

function 信息框(msg,title,type)
  ffi.C.MessageBoxA(nil, msg, title or '信息', type or 0)
end
xtjc = os.time()
function 渲染函数(dt,x,y)--鼠标x,鼠标y
      if math.floor(引擎.取游戏时间()/1100)>os.time()-xtjc then
       信息框("来你刷你继续刷，来你加速你继续加，我让你加！88了您！","加速检测")
       引擎.关闭()
     end


  if not 网关连接 and os.time()-重连时间 >=2 then
       客户端:重新连接()
  end

  全局dt=dt
  鼠标.x,鼠标.y=x,y
    xrks()
    xrqc()
  if tp~=nil then
    tp:显示(dt,x,y)
  elseif tp==nil and yq~=nil and yq.场景~=nil then
    tp = yq.场景
  end





  游戏公告:显示(dt,x,y)
    xrjs()
    外部聊天框渲染函数(dt,x,y)
    if 物品链接展示 then
    tp.提示:道具行囊(300,150,物品链接数据,nil,true)
    end
    if 物品链接展示 and not tp.窗口.消息框:检查点()  and 引擎.鼠标弹起(1)  then
    物品链接展示 = false
    end
end

function 外部聊天框渲染函数(dt,x,y)
    local wbgb
    local wbgb2
    local xzts = tp.字体表.普通字体
    if 引擎.外部 ~= nil then
        if 引擎.外部.渲染开始() then
            引擎.场景.外部聊天框:显示(0,0)
            local xxx,xxy = 17,0
            local kg = false
            local xx,yy = 引擎.外部.取鼠标坐标()
            local xxk = 引擎.场景.窗口.消息框
            w=引擎.外部.取鼠标滚轮()
            xxk.按钮_左拉:更新(xx,yy)
            xxk.按钮_上拉:更新(xx,yy)
            xxk.按钮_下拉:更新(xx,yy)
            xxk.按钮_移动:更新(xx,yy)
            xxk.按钮_查询:更新(xx,yy)
            xxk.按钮_禁止:更新(xx,yy)
            xxk.按钮_锁定:更新(xx,yy)
            xxk.按钮_清屏:更新(xx,yy)
            if (wbgb按钮开关~=nil and wbgb按钮开关==1)then
                wbgb2 = true
            elseif (wbgb按钮开关~=nil and wbgb按钮开关==2) or (w~= 0 and w< 0) then
                if xxk.丰富文本外框.滚动值 > 0 then
                    xxk.丰富文本外框:滚动(-1)
                end
            elseif (wbgb按钮开关~=nil and wbgb按钮开关==3) or (w~= 0 and w> 0) then
                if xxk.丰富文本外框.滚动值 < #xxk.丰富文本外框.显示表 - 24 then
                    xxk.丰富文本外框:滚动(1)
                end
            elseif (wbgb按钮开关~=nil and wbgb按钮开关==4)  then
                xxk.禁止 = xxk.禁止 == false
            elseif (wbgb按钮开关~=nil and wbgb按钮开关==5)  then
                xxk:清空内容()
            end
            w= 0
            wbgb按钮开关=nil
            xxk.丰富文本外框:显示(xxx -17,xxy + 2)
            if tp.战斗中 then               ---------------------------------------假人修复
                xxk.按钮_左拉:显示(xxx + 10,xxy + 全局游戏高度/2-23,true)
                xxk.按钮_上拉:显示(xxx + 33,xxy + 全局游戏高度/2-23,true)
                xxk.按钮_下拉:显示(xxx + 56,xxy + 全局游戏高度/2-23,true)
                xxk.按钮_移动:显示(xxx + 80,xxy + 全局游戏高度/2-23,true)
                xxk.按钮_查询:显示(xxx + 103,xxy + 全局游戏高度/2-23,true)
                xxk.按钮_禁止:显示(xxx + 126,xxy + 全局游戏高度/2-23,true)
                xxk.按钮_锁定:显示(xxx + 150,xxy + 全局游戏高度/2-23,true)
                xxk.按钮_清屏:显示(xxx + 172,xxy + 全局游戏高度/2-23,true)
                xxk.分割:显示(xxx-20,xxy + 全局游戏高度/2)
                local zdyy = 0
                for i=1,#xxk.头像 do
                  local zdxx = 0


                  if xxk.头像[i] then
                        xxk.头像图标[i]:更新(xx,yy)
                        xxk.头像背景:显示(xxx-12,xxy + 全局游戏高度/2+20+zdyy)
                        xxk.头像图标[i]:显示(xxx-10,xxy + 全局游戏高度/2+22+zdyy)
                        xxk.头像[i] = false
                        if xxk.头像图标[i]:是否选中(xx,yy) then
                          xzts:置颜色(白色):显示(xxx+40,xxy+ 全局游戏高度/2+20+zdyy,"姓名："..xxk.头像提示[i])
                        end
                        if xxk.法术状态[i]~=nil then
                           for n=1,#xxk.法术状态[i] do
                               if xxk.法术状态[i][n]~=nil then
                                  if xxk.法术状态[i][n].显示 then
                                     xxk.法术状态[i][n].图标:更新(xx,yy)
                                     xxk.法术状态[i][n].图标:显示(xxx+42+zdxx,xxy + 全局游戏高度/2+37+zdyy)
                                     if xxk.法术状态[i][n].名称~="灵药" and xxk.法术状态[i][n].名称~="五行珠" and xxk.法术状态[i][n].名称~="雷法" then
                                        xzts:置颜色(白色):显示(xxx+51+zdxx,xxy+ 全局游戏高度/2+58+zdyy,xxk.法术状态[i][n].回合)
                                      else
                                        xzts:置颜色(白色):显示(xxx+51+zdxx,xxy+ 全局游戏高度/2+58+zdyy,9)
                                     end
                                     xxk.法术状态[i][n].显示 = false
                                     if xxk.法术状态[i][n].图标:是否选中(xx,yy) then
                                         if xxk.法术状态[i][n].名称=="灵药" then
                                            xzts:置颜色(白色):显示(xxx+40,xxy+ 全局游戏高度/2+20+zdyy,"灵药："..xxk.法术状态[i][n].回合)
                                         elseif xxk.法术状态[i][n].名称=="五行珠" then
                                            xzts:置颜色(白色):显示(xxx+40,xxy+ 全局游戏高度/2+20+zdyy,"五行珠:"..xxk.法术状态[i][n].回合)
                                         elseif xxk.法术状态[i][n].名称=="雷法" then
                                            xzts:置颜色(白色):显示(xxx+40,xxy+ 全局游戏高度/2+20+zdyy,"雷法:"..xxk.法术状态[i][n].回合)
                                         elseif xxk.法术状态[i][n].名称=="战意" or xxk.法术状态[i][n].名称=="超级战意" or xxk.法术状态[i][n].名称=="风灵" or xxk.法术状态[i][n].名称=="剑意" or xxk.法术状态[i][n].名称=="符咒"  then
                                               xzts:置颜色(白色):显示(xxx+40,xxy+ 全局游戏高度/2+20+zdyy,xxk.法术状态[i][n].名称.."  当前层数："..xxk.法术状态[i][n].回合)
                                         else
                                            xzts:置颜色(白色):显示(xxx+40,xxy+ 全局游戏高度/2+20+zdyy,"状态："..xxk.法术状态[i][n].名称.."  回合："..xxk.法术状态[i][n].回合)
                                         end

                                     end
                                  end
                               end
                                  zdxx = zdxx + 27
                           end

                        end
                   end
                    zdyy = zdyy + 54
                end
            end

            xxk.按钮_左拉:显示(xxx + 13,xxy +全局游戏高度-20,true)
            xxk.按钮_上拉:显示(xxx + 36,xxy + 全局游戏高度-20,true)
            xxk.按钮_下拉:显示(xxx + 59,xxy + 全局游戏高度-20,true)
            xxk.按钮_移动:显示(xxx + 83,xxy + 全局游戏高度-20,true)
            xxk.按钮_查询:显示(xxx + 106,xxy +全局游戏高度-20,true)
            xxk.按钮_禁止:显示(xxx + 129,xxy + 全局游戏高度-20,true)
            xxk.按钮_锁定:显示(xxx + 153,xxy +全局游戏高度-20,true)
            xxk.按钮_清屏:显示(xxx + 175,xxy + 全局游戏高度-20,true)
            引擎.外部.渲染结束()
            if 引擎.是否在窗口内() then
                引擎.外部.置鼠标按住(false)
            end
        end
        -- if yq.外部.是否在窗口内()  then
        --     引擎.在外部 = true
        -- else
        --     引擎.在外部 = nil
        -- end





    end
    if wbgb then
        临时高度=1
    end
    if wbgb2 then
        外部聊天框窗口关闭(wbgb2)
    end
end

function 外部聊天框窗口关闭(wbgb)
    if yq.外部 ~= nil and wbgb then
        local xxk = yq.场景.窗口.消息框
        xxk.外部聊天 = xxk.外部聊天 == false
        yq.外部.关闭()
        yq.外部 = nil
        xxk.丰富文本:置高度(xxk:取高度())
        if xxk.丰富文本.滚动值 > 0 then
            xxk.丰富文本:滚动(-xxk.丰富文本.滚动值)
        end
        if xxk.丰富文本.滚动值 < #xxk.丰富文本.显示表 - 24 then
            xxk.丰富文本:滚动(xxk.丰富文本.滚动值)
        end
        xxk.按钮_左拉.外部按钮 = nil
        xxk.按钮_上拉.外部按钮 = nil
        xxk.按钮_下拉.外部按钮 = nil
        xxk.按钮_移动.外部按钮 = nil
        xxk.按钮_查询.外部按钮 = nil
        xxk.按钮_禁止.外部按钮 = nil
        xxk.按钮_锁定.外部按钮 = nil
        xxk.按钮_清屏.外部按钮 = nil
        xxk.按钮_移动.确定按下 = false
        引擎.在外部 = nil
        collectgarbage("collect")
    end
end

local function 退出函数()
    if tp==nil then
      return false
    end
    if tp.进程 == 1 then
        return true
    elseif tp.进程 == 2 or tp.进程 == 3 or tp.进程 == 5 or tp.进程 == 6 or tp.进程 == 7 or tp.进程 == 8 or tp.进程 == 9 or tp.进程2 == 1 then
        tp.进程2 = 1
        return false
    elseif tp.战斗中 then
        引擎关闭开始()
    else
        tp.窗口.系统设置:打开()
        return false
    end
    return false
end

引擎.置退出函数(退出函数)

function 引擎关闭开始()
    引擎.关闭()
end



