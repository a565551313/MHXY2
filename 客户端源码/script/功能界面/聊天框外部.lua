-- @Date:   2018-06-05 07:42:01
-- @Last Modified time: 2020-09-22 08:08:27
local DLL模块 = require("gsub")
local 聊天框 = {}
local 渲染区
local 计次 = 0
local x0 = false
local x0s = 0
临时高度 = 0

local function 初始化(根,标题)
    DLL模块.初始化建窗口(引擎.取窗口句柄(),引擎.宽度,900+3,250," 聊天窗口",0)
    DLL模块.width_height(引擎.取窗口句柄(),250+10,全局游戏高度+30)
    if not 渲染区 then
        渲染区   = require("gge纹理类")():渲染目标(引擎.宽度,900+3,6)--背景高度--########################################################?自己修改?##########################################
    end
    引擎.场景.窗口.消息框.按钮_移动.确定按下 = nil
    return 聊天框
end

function 聊天框.关闭()
    DLL模块.Release()
end

function 聊天框.渲染开始()
    if 临时高度~=0 then
        临时高度 = 0
        DLL模块.width_height(引擎.取窗口句柄(),250+10,全局游戏高度+30)
        return 1
    end
    if 计次==9 then--减少帧数 刷新频率 5
        计次 = 0
    else
        计次 = 计次+1
        return false
    end
    --=============
    local xx,yy =引擎.外部.取鼠标坐标()--鼠标.x,鼠标.y--x,y
    local xxk = 引擎.场景.窗口.消息框
    if (xxk.按钮_左拉:是否选中(xx,yy) and 聊天框.鼠标按下(0)) then--事件判断()
        wbgb按钮开关=1
    elseif  (xxk.按钮_下拉:是否选中(xx,yy) and 聊天框.鼠标按下(0)) then
        wbgb按钮开关=2
    elseif (xxk.按钮_上拉:是否选中(xx,yy) and 聊天框.鼠标按下(0)) then
        wbgb按钮开关=3
    elseif (xxk.按钮_禁止:是否选中(xx,yy) and 聊天框.鼠标按下(0)) then
        wbgb按钮开关=4
    elseif (xxk.按钮_清屏:是否选中(xx,yy) and 聊天框.鼠标按下(0)) then
        wbgb按钮开关=5
    end
    引擎.渲染开始(渲染区)
    if 聊天框.鼠标按下(0) then
        x0s = 1
    end
    if x0s == 1 then
        x0 = true
    end
    if 聊天框.鼠标弹起(0) then
        x0 = false
        x0s = 0
        聊天框.弹起事件 = true
    end
    引擎.渲染清除()
    return true
end

function 聊天框.渲染结束()
    引擎.渲染结束()
    local 宽度 = DLL模块.研究群342119466(渲染区:锁定(),250+10,全局游戏高度+30)
    渲染区:解锁()
    DLL模块.Rende()
end

function 聊天框.取鼠标坐标()
    return DLL模块.取鼠标坐标()
end

function 聊天框.取鼠标滚轮()
    return DLL模块.获取鼠标轮()
end

function 聊天框.窗口坐标()
    return DLL模块.窗口坐标()
end

function 聊天框.是否在窗口内()
    local cx,cy = 聊天框.窗口坐标()
    local mx,my = 聊天框.鼠标坐标()
    if mx+3 > cx and mx+3 < cx+250 and my-23 > cy and my-23 < cy+全局游戏高度-1  then
        return true
    end
    return false
end

function 聊天框.鼠标坐标()
    return DLL模块.鼠标坐标()
end

function 聊天框.鼠标按下(key)
    return DLL模块.鼠标按下(key)
end

function 聊天框.鼠标弹起(key)
    return DLL模块.鼠标弹起(key)
end

function 聊天框.鼠标按住(key)
    return x0
end

function 聊天框.置鼠标按住(key)
    x0 = key
    x0s = 0
    if x0 then
        x0s = 1
    end
end

return 初始化
