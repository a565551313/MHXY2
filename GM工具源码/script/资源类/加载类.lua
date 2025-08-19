--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-09-18 07:49:07
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 资源类_加载 = class()
local aaaa = require("gge纹理类")
local aaab = require("gge精灵类")
local aaac = require("Fmod类")
local bbbb = require("Script/资源类/动画类")
local yq = 引擎

function 资源类_加载:初始化()
	self.wdf = {}
end

function 资源类_加载:打开()
	self.files = {
		"gj.wdf",
		"迭代.wdf",
		"jn.wdf",


	}
	local __wdf = require("script/资源类/WDF")
	local format = string.format
	local a = wdf配置--"WDF/"
	self.id2file = {}
	for n=1,#self.files do
		self.wdf[self.files[n]] = __wdf(format("%s/%s",a,self.files[n]))
	end
end

function 资源类_加载:取偏移(file,id)
	return self.wdf[file]:读偏移(id)
end

function 资源类_加载:读数据(file,id)
	return self.wdf[file]:读数据(id)
end

function 资源类_加载:载入(文件,类型,文件号,音量,附加,fs,fs1)
	if 文件==nil or 文件=="" then
	    return self:载入未知WDF(nil,类型,文件号)
	end
	if 类型 == "网易WDF动画" then
		if 文件==nil then
		    print("注意WDF载入没有[ NIL值 ]文件")
		elseif 文件~=nil and self.wdf[文件]==nil then
		    print("注意WDF载入没有[ "..文件.." ]文件")
		elseif 文件~=nil and self.wdf[文件]~=nil and self.wdf[文件]:读数据(文件号)==nil then
			print("注意WDF载入[ "..文件.." ]文件没有[ "..文件号.." ]")
		end
		return bbbb(self.wdf[文件 or "gj.wdf"]:读数据(文件号 or 0xFCD58523))
	elseif 类型 == "图片" then
		return aaab(aaaa(文件))
	elseif 类型 == "音乐" then
		return aaac(文件,2,nil,nil,0 or 0)
	elseif 类型 == "网易WDF动画s" then
		return bbbb(文件)
	elseif 类型 == "网易锦衣动画" then
		return WAS动画类动画(self.wdf[文件]:取文件(文件号 or 0xEC4818D8))
	end
end

function 资源类_加载:载入未知WDF(file1,类型,id) -- String 例如 0x00FF 非法, 改为 0xFF 正确   资源:载入未知WDF(nil,"网易WDF动画","0xBECEA063")
	if id and tonumber(id) > 0 and file1 == nil then
		for i,o in pairs(self.files)  do
			if 读配置(wdf配置.."/ini/"..o..".ini","Resource",id)=="1" then
				local file = o
				if not self.wdf[file] then
					self:打开(file)
				end
				self.id2file[id] = file
				return self:载入(file,类型,到整数(id))
			end
		end
	end
	return self:载入("gj.wdf",类型,0xFCD58523)
end

return 资源类_加载