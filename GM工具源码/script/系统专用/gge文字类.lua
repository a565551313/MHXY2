-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-01-27 03:51:34
-- @最后修改来自: baidwwy
-- @Last Modified time: 2017-07-05 14:30:22
--<<=========================================================================================>>--
local _tostring = function (t) return "ggeFont",tostring(t._obj) end
--<<=========================================================================================>>--
local ggeobj = class()
rawset(ggeobj, '__new__', require("__ggefont__"))

function ggeobj:初始化(文件,大小,粗体,可描边,抗锯齿)
	local 模式 = 4--默认关抗锯齿
	if 可描边 	then 	模式 = bit.bor(模式,2) end
	if 粗体 	then 	模式 = bit.bor(模式,1) end
	if 抗锯齿 	then 	模式 = bit.bxor(模式,4) end

	if(type(文件) == "userdata")then
		self._obj = 文件
	else
		self.文字 = 文件 or wdf配置.."/font/simsun.ttf"
		self.大小 = 大小 or 14
		self._obj = ggeobj.__new__(self.文字,self.大小,模式)
	end

	self.可描边 = 可描边
	self._obj:SetL(__gge.state)
	self._ptr 	= self._obj:GetP()--指针
	self._isok 	= self._ptr >0

	getmetatable(self).__tostring = _tostring
end
function ggeobj:克隆()
	if(self._isok)then return ggeobj(self._obj:Clone())  end
end
function ggeobj:显示(x,y,t)
	if(self._isok)then
		if type(x)=='table' then
			t 	= y
		    x,y = x.x or 0,x.y or 0
		end
		self._obj:Render(x,y,t or "nil")
	end
end
function ggeobj:置颜色(v)
	if(self._isok)then self._obj:SetColor(v) end
	return self
end
function ggeobj:置Z轴(v)
	if(self._isok)then self._obj:SetZ(v) end
	return self
end
function ggeobj:置混合(v)
	if(self._isok)then self._obj:SetBlendMode(v) end
	return self
end
function ggeobj:置行宽(v)
	if(self._isok)then self._obj:SetLineWidth(v) end
	return self
end
function ggeobj:置字间距(v)
	if(self._isok)then self._obj:SetCharSpace(v) end
	return self
end
function ggeobj:置行间距(v)
	if(self._isok)then self._obj:SetLineSpace(v) end
	return self
end
function ggeobj:置限制字数(v)
	if(self._isok)then self._obj:SetCharNum(v or -1) end
	return self
end
	-- /// 字体排版样式
	-- enum FONT_ALIGN
	-- {
	-- 	TEXT_LEFT,		///< 左对齐
	-- 	TEXT_CENTER,	///< 居中对齐
	-- 	TEXT_RIGHT,		///< 右对齐
	-- 	TEXT_FORCE32BIT = 0x7FFFFFFF,
	-- };
function ggeobj:置样式(v)
	if(self._isok)then self._obj:SetAlign(v) end
	return self
end
function ggeobj:置阴影颜色(v)--颜色
	if(self._isok)then self._obj:SetShadowColor(v) end
	return self
end
function ggeobj:置描边颜色(v)--颜色
	if(self._isok and self.可描边)then self._obj:SetBorderColor(v) end
	return self
end
--=========================================================================
function ggeobj:取颜色()
	if(self._isok)then return self._obj:GetColor() end
end
function ggeobj:取Z轴()
	if(self._isok)then return self._obj:GetZ() end
end
function ggeobj:取混合()
	if(self._isok)then return self._obj:GetBlendMode() end
end
function ggeobj:取行宽()
	if(self._isok)then return self._obj:GetLineWidth() end
end
function ggeobj:取字间距()
	if(self._isok)then return self._obj:GetCharSpace() end
end
function ggeobj:取行间距()
	if(self._isok)then return self._obj:GetLineSpace() end
end
function ggeobj:取大小()--取字体大小
	if(self._isok)then return self._obj:GetFontSize() end
end
function ggeobj:取限制字数()
	if(self._isok)then return self._obj:GetCharNum() end
end
function ggeobj:取样式()
	if(self._isok)then return self._obj:GetAlign() end
end
function ggeobj:取阴影颜色()--取阴影颜色
	if(self._isok)then return self._obj:GetShadowColor() end
end
function ggeobj:取描边颜色()--取描边颜色
	if(self._isok)then return self._obj:GetBorderColor() end
end
function ggeobj:取宽高(v)
	if(self._isok)then
		local t = self._obj:GetStringInfo(v)
		return t.Width,t.Height
	end
end
function ggeobj:取宽度(v)
	if(self._isok)then
		return self._obj:GetStringInfo(v).Width
	end
end
function ggeobj:取高度(v)
	if(self._isok)then
		if v then
			return self._obj:GetStringInfo(v).Height
		else
			return self._obj:GetFontHight()
		end
	end
end
-----------------------------------------------------------------
function ggeobj:取指针()
	return self._ptr
end
function ggeobj:置指针(p)
	self._ptr = p
	self._obj:SetP(p)
end
function ggeobj:取引用总数()
	if(self._isok)then  return self._obj:GetRefCount() end
end
function ggeobj:加引用()
	if(self._isok)then  self._obj:AddRef();return self end
end
function ggeobj:释放()
	if(self._isok)then
		self._obj:Release()
		self._isok = self._obj:GetRefCount()>0
	end
end

return ggeobj