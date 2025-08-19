-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-04-04 16:55:06
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-01-11 19:03:12
local errored--只显示一次
local _gge = __gge
local tostring = tostring
错误关闭数=0
function __gge.traceback(msg)
	if not errored then
	    if tp==nil or (tp~=nil and tp.进程 ~= 4) then
			_gge.messagebox(tostring(msg),"游戏出错啦!",16)
			更新函数,渲染函数 = nil,nil
			循环函数 = nil
			if 引擎 then 引擎.关闭() end
			return false
	    end
		错误关闭数=错误关闭数+1
		if tp~=nil then
		     tp.窗口.消息框:添加文本(tostring(msg).."请截图给管理员,谢谢".." 错误第"..错误关闭数.."次!","系统")
		     print(tostring(msg).."请截图给管理员,谢谢".." 错误第"..错误关闭数.."次!","系统")
		end
	    if 错误关闭数>999999 then
			_gge.messagebox(tostring(msg).."并且错误数量到达999999","游戏出错啦!",16)
			更新函数,渲染函数 = nil,nil
			循环函数 = nil
			引擎.关闭()
			if 引擎 then 引擎.关闭() end
	    end
	    return false
	end
end