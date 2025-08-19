-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-01-27 03:51:34
-- @最后修改来自: baidwwy
-- @Last Modified time: 2017-11-10 23:25:27
--<<=========================================================================================>>--
local ffi 	= require("ffi")
local _tostring = function (t) return "ggeTexture",tostring(t._obj) end
--<<=========================================================================================>>--
local ggeobj = class()
rawset(ggeobj, '__new__', require("__ggetexture__"))
local assert       = assert
local cast         = ffi.cast
local tonumber     = tonumber
local getmetatable = getmetatable
--[[
参数1 gge纹理指针
参数2 文件路径,透明色
参数3 内存指针,长度,透明色
参数4 string,长度,透明色
]]
function ggeobj:初始化(...)
	self._obj = ggeobj.__new__()
	if(...)then
		local arg = {...}
		local lt = type(arg[1])
		if(lt == "string")then
			if (type(arg[2])  == "number" and #arg[1]>256) or arg[3] then--2为指针长度--按luastring指针
				local ptr 	= tonumber(cast("intptr_t",arg[1]))
				assert(self._obj:Texture_LoadMem(ptr,arg[2],arg[3] or 0), "载入失败.")
			else--2为透明颜色--按文件路径载入
				assert(self._obj:Texture_LoadFile(arg[1],arg[2] or 0), string.format('载入失败:"%s"', arg[1]))
			end
		elseif(lt == "number")then	--按指针载入
			if type(arg[2])  == "number" then--2为指针长度
				self._obj:Texture_LoadMem(arg[1],arg[2],arg[3] or 0)--按图片指针
			else
				self._obj:SetP(arg[1])--按gge纹理指针
			end
		elseif(lt == "cdata")then
			assert(self._obj:Texture_LoadMem(tonumber(cast("intptr_t",arg[1])),arg[2],arg[3] or 0), "载入失败.")
		elseif(lt == "userdata")then
			self._obj = arg[1]
		end
	end
	self._obj:SetL(__gge.state)
	self._ptr = self._obj:GetP()--指针
	self._isok = self._ptr >0
	getmetatable(self).__tostring = _tostring
end

function ggeobj:是否可用()
	return self._isok
end
function ggeobj:锁定(只读,x,y,宽度,高度)
	self.lock = true
	return self._obj:Lock(只读 or false,x or 0,y or 0,宽度 or 0,高度 or 0)
end
function ggeobj:解锁()
	if(self._isok and self.lock)then self._obj:Unlock() end
	self.lock = false
	return self
end
function ggeobj:复制()
	if(self._isok )then
		local islock = self.lock
		if not self.lock then
		    self:锁定(true)
		end

		local p = self._obj:Copy()
		if not islock then self:解锁() end
		return ggeobj(p)
	end
end
function ggeobj:复制区域(x,y,宽度,高度)
	if(self._isok )then
		local islock = self.lock
		if not self.lock then
		    self:锁定(true)
		end
		local p = self._obj:CopyRect(x or 0,y or 0,宽度 or self:取宽度(),高度 or self:取高度())
		if not islock then self:解锁() end
		return ggeobj(p)
	end
end
function ggeobj:灰度级()
	local islock = self.lock
	if not self.lock then self:锁定() end
	self._obj:Grayscale()
	if not islock then self:解锁() end
	return self
end
function ggeobj:置像素(x,y,c)--宽度,高度,颜色
	if(self._isok and self.lock)then  self._obj:SetPixel(x,y,c) end
end
function ggeobj:取像素(x,y)
	if(self._isok )then
		if not self.lock then
		   	self:锁定(true)
		   	self.宽度 = self:取宽度()
		   	self.高度 = self:取高度()
		end
		if x >=0 and y >=0 and x<self.宽度 and y <self.高度 then
		    return self._obj:GetPixel(x,y)
		end
	end
	return 0
end
function ggeobj:空白纹理(w,h,c)--宽度,高度,颜色
	self._obj:Texture_Create(w or 0,h or 0)
	self._ptr = self._obj:GetP()
	self._isok = self._ptr >0
	if(c)then self._obj:FillColor(c) end
	return self
end
-- /// 渲染目标纹理类型
-- enum TARGET_TYPE
-- {
-- 	TARGET_DEFAULT	= 0,	///< 默认类型
-- 	TARGET_ZBUFFER	= 1,	///< 开启ZBuffer
-- 	TARGET_LOCKABLE	= 2,	///< 渲染目标纹理可以被锁定
-- 	TARGET_ALPHA	= 4,	///< 渲染目标纹理带Alpha通道(可通过系统状态 GGE_ALPHARENDERTARGET 检测显卡是否支持创建带Alpha通道的渲染目标纹理)
-- 	TARGET_FORCE32BIT = 0x7FFFFFFF,
-- };
function ggeobj:渲染目标(w,h,类型)--宽度,高度,ZBuffer,是否是可以锁定,Alpha
	self._obj:Texture_CreateRenderTarget(w,h,类型 or 0)
	self._ptr = self._obj:GetP()
	self._isok = self._ptr >0
	return self
end
function ggeobj:置颜色(v)
	if(self._isok)then self._obj:FillColor(v);return self end
end
--@格式参数 0:jpg,1:png,2:bmp,3:tga
function ggeobj:保存到文件(v,f)
	if(self._isok)then  return self._obj:SaveToFile(v,f or 3) end
end
function ggeobj:取宽度()
	if(self._isok)then  return self._obj:GetWidth() end
end
function ggeobj:取高度()
	if(self._isok)then  return self._obj:GetHeight() end
end
-------------------------------------------------------------------
function ggeobj:取指针()
	return self._ptr
end
function ggeobj:置指针(v)--注意释放
	self._obj:SetP(v)
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