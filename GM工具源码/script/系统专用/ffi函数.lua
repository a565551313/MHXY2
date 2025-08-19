-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-05-06 16:35:49
-- @最后修改来自: baidwwy
-- @Last Modified time: 2018-06-09 12:26:49
local ffi = require("ffi")
local _ffi = {}
local bit = bit
ffi.cdef [[
	//修改窗口图标
	void* 	LoadImageA(int,const char*,int,int,int,int);
	int 	SendMessageA(int,int,int,void*);
	//取窗口信息
	int GetWindowRect(int,void*);
	//取剪贴板
	int      OpenClipboard(unsigned);
	void*    GetClipboardData(unsigned);
	bool     CloseClipboard();
	void*    GlobalLock(void*);
	int      GlobalUnlock(void*);
	size_t   GlobalSize(void*);
	//置剪贴板
	bool 	EmptyClipboard();
	void* 	GlobalAlloc(unsigned, unsigned);
	void* 	GlobalFree(void*);
	void* 	lstrcpy(void*,const char*);
	void* 	SetClipboardData(unsigned,void*);
	//输出
	int printf(const char *fmt, ...);
	//读配置
	int GetPrivateProfileStringA(const char*, const char*, const char*, const char*, unsigned, const char*);
	//写配置
	bool WritePrivateProfileStringA(const char*, const char*, const char*, const char*);
	//设置窗口样式
	void SetWindowLongA(int ,int ,int );
	//取MD5
	typedef struct {
	    unsigned long i[2]; /* number of _bits_ handled mod 2^64 */
	    unsigned long buf[4]; /* scratch buffer */
	    unsigned char in[64]; /* input buffer */
	    unsigned char digest[16]; /* actual digest after MD5Final call */
	} MD5_CTX;
	void MD5Init(MD5_CTX *);
	void MD5Update(MD5_CTX *, const char *, unsigned int);
	void MD5Final(MD5_CTX *);
	//信息框
	int MessageBoxA(void *, const char*, const char*, int);
	//延迟
	void Sleep(int);
	//文件是否存在
	int _access(const char*, int);
	//打开网站
	void *ShellExecuteA(void*, const char *, const char*, const char*, const char*, int);
	//复制文件
	bool CopyFileA(const char*,const char*,bool );
	//读注册表
	long RegOpenKeyExA(unsigned,const char*,unsigned,unsigned,unsigned*);
	long RegQueryValueExA(unsigned,const char*,unsigned*,unsigned*,char*,unsigned*);
	long RegCloseKey(unsigned);
	//改窗口标题
	//int SetWindowTextA(int,const char*);
	//闪烁窗口
	int FlashWindow(int,bool);
]]
--local shell = ffi.load("shell32")

local advapi32 = ffi.load("advapi32.dll")
-- function _ffi.修改窗口标题(t)
-- 	ffi.C.SetWindowTextA(引擎.取窗口句柄(),t)
-- end
function _ffi.取剪贴板()
	local text = ""
	local ok1    = ffi.C.OpenClipboard(0)
	local handle = ffi.C.GetClipboardData(1)
	if handle ~= nil then
		local size   = ffi.C.GlobalSize( handle )
		local mem    = ffi.C.GlobalLock( handle )
		text   = ffi.string( mem, size -1)
		local ok     = ffi.C.GlobalUnlock( handle )
	end
	local ok3    = ffi.C.CloseClipboard()
	return text
end
function _ffi.置剪贴板(txt)
	if txt then
		local ok1 = ffi.C.OpenClipboard(0)
		local ok2 = ffi.C.EmptyClipboard() --清空
		local handle = ffi.C.GlobalAlloc(66, #txt+1)
		if handle ~= nil then
			local mem = ffi.C.GlobalLock(handle)
			ffi.copy(mem, txt)
			local ok3 = ffi.C.GlobalUnlock(handle)
			handle = ffi.C.SetClipboardData(1, mem)
		end
		local ok4 = ffi.C.CloseClipboard()
	end
end
--隐藏边框
--_ffi.设置窗口样式(引擎.取窗口句柄(),-16,369098752)
function _ffi.取MD5(txt)
	local pctx = ffi.new("MD5_CTX[1]")
	advapi32.MD5Init(pctx)
	advapi32.MD5Update(pctx, tostring(txt), string.len(txt))
	advapi32.MD5Final(pctx)

	local md5str = ffi.string(pctx[0].digest,16)
	return string.format("%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",string.byte(md5str, 1, -1))
end
--[[local DLL = ffi.load("Zs.dll") --加载DLL
local yz = DLL.Yz
local bjs = {"973F0071E3EB7596867690C8B9F9175Eyx","685212A7C5F04CB06DD81F547CF30F3Dyx",38B7E71149F3AF274254CDEFC06A42F7yx","62C7FC402B6C59BDA25F4673345AD0BByx","6117BA9D0A2F6BAEDBD18EE6179C8E05yx","3A6883CB83DC871EB3BE505476E96DD9yx","A652F9E679A00B2747AB995C046B24FFyx","3782EEC007FF0A3993B5A5DFEFE5069Fyx","DB1D260A66719B48A8EDCA881867EA4Cyx","C24FA4C0084A6807F9C4AA9857A4B028yx","FB2299FEB177751C12135F44CB346B89yx","5A4B586CC34DAE5EE48A7C6684224FB4yx","56B004B57866F1B5E367B060B968EDA6yx","5A0F2D93EF8B0F315287252EA8115647yx","E7C675F3B2D5BC00B3D034622860B104yx","F13DC58905ECBC88ABC64176EB05E909yx","938B81DBFB1C76DD5C3E2E808C199BEEyx","72225DAB29A82D3B0B008BBC295B0B23yx","5E8488A95A75A12EB5963CE728011E5Eyx","5F98B203F5C53791E7F73C7EEAC28B5Byx","713703F436FAB1AA2EE776923C17AE31yx","5BC31D3F3421BAEAC5FAC3AFEBD7681Fyx","CC42044C90EE295447385ACB0ECE9B35yx","830983F7505DEBE727BC4891E6630F69yx","CD5224D0CB3626E389810EBA168257A4yx","30310C3D48C1EE294776D311E732122Fyx","7F1CF3E84D81B50680BE4DEE4EA9762Cyx","37A4474F976A0A48B4F3A95357179673yx",
"C768061343A36BBD209667A6D0F5B7A3yx","AC42DD97A2344C3E8169B3FCA38F56CFyx","165C9DEDC4AF8B20E0CB4A4ACFC420FEyx","DE5ADDD53E142EABDE35237DA7AF8000yx","2106081EFBEC73ABD6318DA427D4D3EEyx","6E67C3DE87614B097360DF5561C532F1yx","54BC5D22AFB7E6D3A8D5BECFDB2E7F74yx","01D1428C28E4E5ECCFDFB65CED98DEDEyx","D9325BBD9DA95D76C71C5CFDF58342B3yx","3D484C9018A4B851DD878537662AF659yx","5E8488A95A75A12EB5963CE728011E5Eyx","F1E93371E31EE5090132F9A23505B01Cyx","165C9DEDC4AF8B20E0CB4A4ACFC420FEyx","AEC85103157BB8BCCA2436713212DE5Byx","252162DF0C566A6E1324CC9D4CCCFB59yx","08D6232B506DFF4D70E82B43952C10A2yx","3760E4422589DDB97FABAE0179B74DF1yx","A1FDF02A516BA859050B76C27D02120Cyx","4DA0D1CB22443B1A08FDACED93BF54D1yx","2EB9DE7700FB0DCE1C1DA63E080F31D3yx","FB7D9C1908F128B3074B63995FA4758Byx","BAED86AF99F780D220930B72E1A55393yx"
}

local bj = false
for i=1,#bjs do
	if yz(bjs[i]) then
		bj = true
		break
	end
end

if bj == false then
	引擎.关闭()
	__gge.messagebox("验证失败，你并非内测人员，本游戏仅供内测人员娱乐使用，非内测人员请及时卸载游戏".."\n".."*已经将你的注册码复制置剪切板，如果你是内测人员请联系作者","单机版0.4")
	_ffi.置剪贴板(ffi.string(DLL.Yp())..ffi.string(DLL.Cp()).."-"..引擎.取随机整数(1,9)..引擎.取随机整数(1,9)..引擎.取随机整数(1,9)..引擎.取随机整数(1,9)..引擎.取随机整数(1,9)..引擎.取随机整数(1,9)..引擎.取随机整数(1,9)..引擎.取随机整数(1,9))
end
DLL = nil--]]
return _ffi