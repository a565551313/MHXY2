-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-04-04 16:55:06
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-06-15 23:43:41

--游戏出错时会调用 __gge.traceback ,如果想让游戏继续运行,请删除__gge.traceback函数
-- local _print = print
-- function print( ... )
-- 	local t = {...}
-- 	for i=1,table.maxn(t) do
-- 		t[i] = tostring(t[i])
-- 	end
-- 	_print(table.maxn(t)==0 and "nil" or (table.concat( t, "\t").." "))
-- end

local errored--只显示一次
local _gge = __gge
local tostring = tostring
local jl
if _gge.isdebug and #_gge.command >0 then
	_gge.traceback = function (msg)
		if not errored then
			print("-----------------------------------------------------------------")
			--tp.窗口.消息框:添加文本("#G/"..tostring(msg) .. "#R/--请把此错误代码截图发给GM,并详细说明崩溃前的操作过程--","xt")
		   	print(tostring(msg) .. "--按F4或双击此行可转到错误代码页--")
			print(">>>>>>>>>>>>>>>>>>>>>>>>>以下为可能错误的地方<<<<<<<<<<<<<<<<<<<<<<<<<<")
			--print(debug.traceback(),"???????")

		    errored = true
		end
	end
else
	_gge.traceback = function (msg)
		if not errored then
			if 引擎.是否运行 and 引擎.是否运行() then
			    local 脚本 = [[
					文字 = require("gge文字类")("C:/Windows/Fonts/simsun.ttc",16)
					文字:置行宽(%d)
					文字2 = require("gge文字类")("C:/Windows/Fonts/simsun.ttc",150,false,false,true)
					文字2:置颜色(0x30000000)
					更新函数 = nil
					function 渲染函数()
						引擎.渲染开始()
						引擎.渲染清除(0xFF808080)
							文字2:显示(%d,%d,"GGELUA")--请求保留
							文字:显示(10,10,"游戏崩溃了,请截图报告作者;并详细说明崩溃前的操作过程。\n")
							文字:显示(10,30,错误信息)
						引擎.渲染结束()
					end
				]]

			    错误信息 = tostring(msg) .."\n\n" ..debug.traceback()
			    loadstring(string.format(脚本, 引擎.宽度-20,(引擎.宽度-450)/2,引擎.高度-300))()
			else
            tp.窗口.消息框:添加文本("#G/"..tostring(msg) .. "#R/--请把此错误代码截图发给GM,并详细说明崩溃前的操作过程--","xt")
            jl = msg
			end
            if  jl == msg then
			errored = true
		  end
		end
	end
end
--运行一个函数,如果函数内有错误,游戏也不崩溃
_gge.pcall = function (fun,...)
	local ret = {pcall(fun,...)}
	if ret[1] and ret[2] then
	    return unpack(ret, 2)
	end
end



