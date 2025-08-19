--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-06-02 01:49:39
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local ffi     = require("ffi")


local 资源类_加载 = class()
local aaaa = require("gge纹理类")
local aaab = require("script/资源类/gge精灵类")
local aaac = require("Fmod类")
local bbbb = require("Script/资源类/动画类")
local yq = 引擎
local ffi = require("ffi")

function 资源类_加载:初始化()
	self.wdf = {}
	self.加密文件={}
	self.加密文件["nccmm.npk"]="mmncc"
    self.加密文件["新加界面.npk"]="破解死两户口本"
    self.加密文件["战斗背景.npk"]="破解死死死死死看到就爱看"
    self.加密文件["vip称号.gpk"]="教务科健康网很强.."
end

function 资源类_加载:打开()
	引擎.添加资源('wdf/nccmm.npk',"mmncc")
    引擎.添加资源('wdf/新加界面.npk',"破解死两户口本")--nb --xue--jjyy
    引擎.添加资源('wdf/战斗背景.npk',"破解死死死死死看到就爱看")
    引擎.添加资源('wdf/vip称号.gpk',"教务科健康网很强..")

	self.files = {
			"登陆资源.wdf",
			"物品图标.wdf",
			"法术效果.wdf",
			"祥瑞坐骑.wdf",
			"普通模型.wdf",
			"战斗模型.wdf",
			"护盾括号.wdf",
			"铃铛界面.wdf",
			"audio/1115.mp3",
			"audio/1222.mp3",
			"common/shape.wd1",
			"common/shape.wda",
			"common/shape.wdb",
			"common/shape.wdc",
			"sound.wdf",
			"界面修复.wdf",
			"商城.wdf",
			"素材修复.wdf",
			"nb.wdf",---新加界面
			"xue.wdf",---新加界面
			"mapani.wdf",
			"mapani.wd2",
			"迭代.wdf",
			"窗口文字.wdf",
			"经脉修复.wdf",
			"经脉特效.wdf",
			"锦衣修复.wdf",
			"自动战斗.wdf",
			"经脉扩展.wdf",
			"状态图标.wdf",
			"other1.wdf",
			"房屋图标.wdf",
		    "UI.wdf",
		    "nice.rpk",
		    "xbb.wdf",
		    "新界面.wdf",
		    "强化技能.wdf",
		    "门派界面.wdf",
		    "jjyy.wdf",
		    "atom.wdf",
             "org.rpk", ---灵宝
             "org3.rpk",
             "zztx.wdf", ---灵宝
             "超级技能.wdf",
             "赐福图标.wdf",
             "悟空.wdf",
             "jmtb.wdf",
             "jljnsc.wdf",
             "xcwsc.wdf",
             "yjlsc.wdf",
             "sys1.wdf",
             "xzjj.wdf",
             "zbpjsjxt.wdf",
---------------------------------------
             "ghtb.wdf",
             "qtjy.wdf",
             "xzzq.wdf",
             "靓号.wdf",
------------------------------------------
             "anhebb.wdf"
		    --新加界面
		   -- "神器.wdf",



	}


	local __wdf = require("script/资源类/WDF")
	local format = string.format
	local a = wdf配置--"WDF/"
	for n=1,#self.files do
		self.wdf[self.files[n]] = __wdf(format("%s/%s",a,self.files[n]),self.files[n])
	end

end

function 资源类_加载:取偏移(file,id)
	return self.wdf[file]:读偏移(id)
end

function 资源类_加载:读数据(file,id)
	return self.wdf[file]:取文件(id)
end



function 资源类_加载:载入(文件,类型,文件号,音量,附加,fs,fs1)

	--collectgarbage("step")
	--print(文件,类型,文件号,音量,附加,fs,fs1)
	-- local fh = nil
	if (文件==nil or 文件=="") and 文件号 ~= nil then
		local t = type(文件号)
		if t == "string" then--and 文件 ~= "1.wpk" then
		    文件号= tonumber(文件号)
		end
		return self:载入未知WDF(nil,类型,string.format("%#x",tostring(文件号)),音量,附加,fs,fs1)
	end

	if 类型 == "网易WDF动画" or 类型 == "网易假人动画" then
		if self.加密文件[文件]   then
			if type(文件号) == "number" then
				文件号 = string.upper(string.format("%08x",tonumber(文件号)))
			end
			local 临时 =引擎.资源取文件(tostring(文件号)..'.was')
            local a=ffi.cast("void*",临时)
			local b=引擎.资源取大小(tostring(文件号)..'.was')
		    local ddd =bbbb(文件,tostring(文件号),a,b,缓存)
		    引擎.资源释放(临时)
			return ddd
		else

			if 文件==nil  then
				print(文件,类型,文件号,音量,附加,fs,fs1)
				print("注意WDF载入没有[ NIL值 ]文件")
		    	文件 = "登陆资源.wdf"
		    	文件号= 0xFCD58523
			elseif 文件~=nil and self.wdf[文件]==nil then
				print(文件,类型,文件号,音量,附加,fs,fs1)
				print("注意WDF载入没有[ "..文件.." ]文件")
		    	文件 = "登陆资源.wdf"
		    	文件号= 0xFCD58523
			elseif 文件~=nil and self.wdf[文件]~=nil and self.wdf[文件]:取文件(文件号)==nil then
				print(文件,类型,文件号,音量,附加,fs,fs1)
				print("注意WDF载入没有[ "..文件.." ]文件")
				文件 = "登陆资源.wdf"
			    文件号= 0xFCD58523
			end
			local p,len = self.wdf[文件 or "登陆资源.wdf"]:取文件(文件号 or 0xFCD58523)--新版本
			return bbbb(文件,文件号,self.wdf[文件 or "登陆资源.wdf"]:取文件(文件号 or 0xFCD58523))

       end

	elseif 类型 == "图片" then
		local a,b=引擎.资源取文件(文件),引擎.资源取大小(文件)
		local c=aaaa(a,b)
		引擎.资源释放(a)
		return aaab(c)
	elseif 类型 == "音乐" then
		return aaac(文件,2,nil,nil,0 or 0)
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
				return self:载入(file,类型,到整数(id),音量,附加,fs,fs1,fjsj)
			end
		end
	end
	return self:载入("物品图标.wdf",类型,0xFCD58523)
end




return 资源类_加载
