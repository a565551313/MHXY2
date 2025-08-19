--======================================================================--
-- @作者: GGE研究群: 34211 9466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2022-10-01 23:27:01
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local errored--只显示一次
local _print = print
function __gge.traceback(msg)
	if not errored then
		print(tostring(msg))
	end
end
