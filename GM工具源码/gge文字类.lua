-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-01-27 03:51:34
-- @最后修改来自: baidwwy
-- @Last Modified time: 2020-09-18 22:22:12
--<<=========================================================================================>>--
local ggeobj = class()
local font =  require("__ggefont__")
local type = type
local bor = bit.bor
local bxor = bit.bxor
--<<=========================================================================================>>--
function ggeobj:初始化(文件,大小,粗体,可描边,抗锯齿)
	--print(文件,大小)
	local 模式 = 4--默认关抗锯齿
	if 可描边 	then 	模式 = bor(模式,2) end
	if 粗体 		then 	模式 = bor(模式,1) end
	if 抗锯齿 	then 	模式 = bxor(模式,4) end
	self.文字 = 文件 or 'C:/Windows/Fonts/simsun.ttc'
	self.大小 = 大小 or 14
	self._obj = font(self.文字,self.大小,模式)
	self.可描边 = 可描边
	self._obj:SetL(__gge.state)
	self._ptr 	= self._obj:GetP()--指针
	self._isok 	= self._ptr >0
end
function ggeobj:显示x(x,y,t)
	t 	= y
	x,y = x.x or 0,x.y or 0
	self._obj:Render(x,y,t)
end


function ggeobj:显示(x,y,t)
	self._obj:Render(x,y,t)
end
function ggeobj:置颜色(v)
	self._obj:SetColor(v)
	return self
end
function ggeobj:置行宽(v)
	self._obj:SetLineWidth(v)
	return self
end
function ggeobj:置字间距(v)
 	self._obj:SetCharSpace(v)
	return self
end
function ggeobj:置行间距(v)
	self._obj:SetLineSpace(v)
	return self
end
function ggeobj:置限制字数(v)
	self._obj:SetCharNum(v or -1)
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
	self._obj:SetAlign(v)
	return self
end
function ggeobj:置阴影颜色(v)--颜色
	self._obj:SetShadowColor(v)
	return self
end
function ggeobj:置描边颜色(v)--颜色
	self._obj:SetBorderColor(v)
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
function ggeobj:取宽高(v)
	local t = self._obj:GetStringInfo(v)
	return t.Width,t.Height
end
function ggeobj:取宽度(v)
	return self._obj:GetStringInfo(v).Width
end
function ggeobj:取高度(v)
	if v then
		return self._obj:GetStringInfo(v).Height
	else
		return self._obj:GetFontHight()
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