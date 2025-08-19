--
local ffi = require("ffi")
ffi.cdef[[
	void* 	CreateFileA(const char*,int,int,void*,int,int,void*);
	bool  	DeviceIoControl(void*,int,void*,int,void*,int,void*,void*);
	bool 	CloseHandle(void*);
	//
	int      OpenClipboard(void*);
	void*    GetClipboardData(unsigned);
	int      CloseClipboard();
	void*    GlobalLock(void*);
	int      GlobalUnlock(void*);
	size_t   GlobalSize(void*);
	//
	int 	GetPrivateProfileStringA(const char*, const char*, const char*, const char*, unsigned, const char*);
	bool 	WritePrivateProfileStringA(const char*, const char*, const char*, const char*);

	int 	OpenClipboard(void*);
	void* 	GetClipboardData(unsigned);
	int 	CloseClipboard();
	void* 	GlobalLock(void*);
	int 	GlobalUnlock(void*);
	size_t 	GlobalSize(void*);

	int 	EmptyClipboard();
	void* 	GlobalAlloc(unsigned, unsigned);
	void* 	GlobalFree(void*);
	void* 	lstrcpy(void*,const char*);
	void* 	SetClipboardData(unsigned,void*);
	//
	typedef struct {
	    unsigned long i[2]; /* number of _bits_ handled mod 2^64 */
	    unsigned long buf[4]; /* scratch buffer */
	    unsigned char in[64]; /* input buffer */
	    unsigned char digest[16]; /* actual digest after MD5Final call */
	} MD5_CTX;
	void MD5Init(MD5_CTX *);
	void MD5Update(MD5_CTX *, const char *, unsigned int);
	void MD5Final(MD5_CTX *);
	//
	int 	MessageBoxA(void *, const char*, const char*, int);
	void 	Sleep(int);
	int 	_access(const char*, int);
]]
local advapi32 = ffi.load("advapi32.dll")
local fun = {}

--=========================
local lfs = require"lfs"
function 取文件夹的所有文件 (path)
	for file in lfs.dir(path) do
		if file ~= "." and file ~= ".." then
			local f = path..'/'..file
			local attr = lfs.attributes (f)
			assert (type(attr) == "table")
			if attr.mode == "directory" then
				print(f)
			end
		end
	end
end

--=============================
require"lfs"
function Lua遍历文档(rootpath, pathes)
    pathes = pathes or {}

    ret, files, iter = pcall(lfs.dir, rootpath)
    if ret == false then
        return pathes
    end
    for entry in files, iter do
        local next = false
        if entry ~= '.' and entry ~= '..' then
            local path = rootpath .. '/' .. entry
            local attr = lfs.attributes(path)
            if attr == nil then
                next = true
            end

            if next == false then
                if attr.mode == 'directory' then
                    Lua遍历文档(path, pathes)
                else
                    table.insert(pathes, path)
                end
            end
        end
        next = false
    end
    return pathes
end
pathes = {}
for i=1,#pathes do
	print(i .. " " .. pathes[i])
end

pathes = {}
function Lua遍历文档2(path)--方法2
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            local f = path .. "/" .. file
            local attr = lfs.attributes(f)
            table.insert(pathes, f)
            print (#pathes,f)
            -- for name, value in pairs(attr) do
            --     -- print (name, value)
            -- end
         end
     end
end
function 取当前目录()
    local ffi = require("ffi")
    local path = ffi.new("char[256]")
    ffi.C.GetCurrentDirectoryA(256,path)
    return ffi.string(path)
end

function 置当前目录(路径)
    local ffi = require("ffi")
    ffi.C.SetCurrentDirectoryA(路径)
end
-- 项目目录  = 取当前目录()


---===================================Lua遍历文档
function 创建目录(dirname)
--	print(lfs.currentdir(dirname))
    lfs.mkdir(dirname)
end

function 判断是否数组(是否数组)
	if type(是否数组) == "table" then
	    return true
	end
	return false
end

function 删除目录(dirname)--成功返回true，失败返回nil加上错误信息
   return lfs.rmdir(dirname)
end

function 删除txt文件(dirname)--成功返回true，失败返回nil加上错误信息
	-- 删除存在的文件
	local rm_file = os.remove(dirname);
	print("remove exist file ret:")
	print(rm_file)
	print("\n")
end


function 取当前目录(dirname)--全部目录
    return lfs.currentdir(dirname)
end

function 取文档名称( strurl, strchar, bafter)
    local ts = string.reverse(strurl)
    local param1, param2 = string.find(ts, strchar)  -- 这里以"/"为例
    local m = string.len(strurl) - param2 + 1
    local result
    if (bafter == true) then
    	result = string.sub(strurl, m+1, string.len(strurl))
    else
    	result = string.sub(strurl, 1, m-1)
    end

    return result
end

function 获取文件名(str)--"aaa.bbb.bbb.txt"
    local idx = str:match(".+()%.%w+$")
    if(idx) then
        return str:sub(1, idx-1)
    else
        return str
    end
end

function 获取扩展名(str)--"aaa.bbb.bbb.txt"
    return str:match(".+%.(%w+)$")
end

function 调试输出(内容)
 return print(内容)
end

function 到文本(内容)
 return tonumber(内容)
end

function 到整数(内容)
 return math.ceil(内容)
end

function 取随机数(开始,结束)
 return math.random(开始,结束) --产生1到100之间的随机数［整数型 欲取随机数的最小值］，［整数型 欲取随机数的最大值］
end

function 取长度不足补位(szFullString)
	local 数据E=string.len(szFullString)
	if 数据E==1 then
	    return "00"..szFullString
	elseif 数据E==2 then
		return "0"..szFullString
	else
		return szFullString
	end
end

function 取文本长度(szFullString, szSeparator)
	return string.len(szFullString)
end

function 判断目录或文件是否存在(path)--判断目录或文件是否存在
	local file = io.open(path, "rb")
	if file then
		file:close()
	end
	return file ~= nil
end

function 读入文件(fileName)
	local f = assert(io.open(fileName,'r'))
	local content = f:read('*all')
	f:close()
	if content=="" then content="无文本" end
	return content
end

function 获得文件长度(filename)
    local fh = assert(io.open(filename, "rb"))
    local len = assert(fh:seek("end"))
    fh:close()
    return len
end

function 判断文件是否存在(path)
    local file = io.open(path, "rb")
    if file then
        file:close()
    end
    return file ~= nil
end

function lua读取文本(文件路径全部)
 local file1=io.input(文件路径全部)
 local str=io.read("*a")
 return str
end

function lua写到文本(文件路径全部,文件内容)
 local file2=io.output(文件路径全部)
 io.write(文件内容)
 io.flush()
 io.close()
end

function 置DLL目录(d)
	package.cpath = package.cpath ..string.format(';%s/?.dll', d)
end

function 读配置(文件,节点,名称)
	local buf = ffi.new("const unsigned char[?]",1024)
	ffi.C.GetPrivateProfileStringA(节点,名称,"空",buf,1024,文件)
	return ffi.string(buf)
end

function 写配置(文件,节点,名称,值)
	return ffi.C.WritePrivateProfileStringA(节点,名称,tostring(值),文件)
end

function 分割文本2(str,delimiter)
    local dLen = string.len(delimiter)
    local newDeli = ''
    for i=1,dLen,1 do
        newDeli = newDeli .. "["..string.sub(delimiter,i,i).."]"
    end
    local locaStart,locaEnd = string.find(str,newDeli)
    local arr = {}
    local n = 1
    while locaStart ~= nil
    do
        if locaStart>0 then
            arr[n] = string.sub(str,1,locaStart-1)
            n = n + 1
        end
        str = string.sub(str,locaEnd+1,string.len(str))
        locaStart,locaEnd = string.find(str,newDeli)
    end
    if str ~= nil then
        arr[n] = str
    end
    return arr
end

function 分割文本(szFullString, szSeparator)
	local nFindStartIndex = 1
	local nSplitIndex = 1
	local nSplitArray = {}
	while true do
		local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
		if not nFindLastIndex then
		    nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
		    break
		end
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
		nFindStartIndex = nFindLastIndex + string.len(szSeparator)
		nSplitIndex = nSplitIndex + 1
	end
	return nSplitArray
end

function 分割字符(str,tv)
	local t = tv or {}
	local i = 1
	local ascii = 0
	while true do
		ascii = string.byte(str, i)
		if ascii then
			if ascii < 127 then
				table.insert(t,string.sub(str, i, i))
				i = i+1
			else
				table.insert(t,string.sub(str, i, i+1))
			    i = i+2
			end
		else
		    break
		end
	end
	return t
end



function encodeBase64(source_str)--64加
    local b64chars ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    local s64 = ''
    local str = source_str

    while #str > 0 do
        local bytes_num = 0
        local buf = 0

        for byte_cnt=1,3 do
            buf = (buf * 256)
            if #str > 0 then
                buf = buf + string.byte(str, 1, 1)
                str = string.sub(str, 2)
                bytes_num = bytes_num + 1
            end
        end

        for group_cnt=1,(bytes_num+1) do
            local b64char = math.fmod(math.floor(buf/262144), 64) + 1
            s64 = s64 .. string.sub(b64chars, b64char, b64char)
            buf = buf * 64
        end

        for fill_cnt=1,(3-bytes_num) do
            s64 = s64 .. '='
        end
    end

    return s64
end

function decodeBase64(str64)--64减
    local b64chars ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    local temp={}
    for i=1,64 do
        temp[string.sub(b64chars,i,i)] = i
    end
    temp['=']=0
    local str=""
    for i=1,#str64,4 do
        if i>#str64 then
            break
        end
        local data = 0
        local str_count=0
        for j=0,3 do
            local str1=string.sub(str64,i+j,i+j)
            if not temp[str1] then
                return
            end
            if temp[str1] < 1 then
                data = data * 64
            else
                data = data * 64 + temp[str1]-1
                str_count = str_count + 1
            end
        end
        for j=16,0,-8 do
            if str_count > 0 then
                str=str..string.char(math.floor(data/math.pow(2,j)))
                data=math.mod(data,math.pow(2,j))
                str_count = str_count - 1
            end
        end
    end

    local last = tonumber(string.byte(str, string.len(str), string.len(str)))
    if last == 0 then
        str = string.sub(str, 1, string.len(str) - 1)
    end
    return str
end

--   'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/*=.，'
function encodeBase641(source_str)
  local b64chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

  local s64 = ''
  local str = source_str
  while #str > 0 do
    local bytes_num = 0
    local buf = 0
    for byte_cnt=1,3 do
        buf = (buf * 256)
        if #str > 0 then
            buf = buf + string.byte(str, 1, 1)
            str = string.sub(str, 2)
            bytes_num = bytes_num + 1
        end
    end
    for group_cnt=1,(bytes_num+1) do
        local b64char = math.fmod(math.floor(buf/262144),64) + 1
        s64 = s64 .. string.sub(b64chars, b64char, b64char)
        buf = buf * 64
    end
    for fill_cnt=1,(3-bytes_num) do
        s64 = s64 .. '='
    end
  end
  return s64
end

function decodeBase641(str64)
    local b64chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    local temp={}
    for i=1,64 do
        temp[string.sub(b64chars,i,i)] = i
    end
    temp['=']=0
    local str=""
    for i=1,#str64,4 do
        if i>#str64 then
            break
        end
        local data = 0
        local str_count=0
        for j=0,3 do
            local str1=string.sub(str64,i+j,i+j)
            if not temp[str1] then
                return
            end
            if temp[str1] < 1 then
                data = data * 64
            else
                data = data * 64 + temp[str1]-1
                str_count = str_count + 1
            end
        end
        for j=16,0,-8 do
            if str_count > 0 then
                str=str..string.char(math.floor(data/math.pow(2,j)))
                data=math.mod(data,math.pow(2,j))
                str_count = str_count - 1
            end
        end
    end
    local last = tonumber(string.byte(str, string.len(str), string.len(str)))
    if last == 0 then
        str = string.sub(str, 1, string.len(str) - 1)
    end
    return str
end

function 取硬盘序列号()
	local h = ffi.gc(ffi.C.CreateFileA("\\\\.\\PhysicalDrive0",bit.bor(2147483648,1073741824),bit.bor(1,2),nil,3,0,nil),ffi.C.CloseHandle)
	if h ~= ffi.cast('void*',-1) then
		local scip = ffi.new('unsigned char[32]')
		scip[10] = 236
		local data = ffi.new('char[528]')
		local size = ffi.new('int[1]')
	    if ffi.C.DeviceIoControl(h,508040,scip,32,data,528,size,nil) then
	        return ffi.string(data+36,20)
	    end
	end
	return ''
end



function 取剪贴板()
    local text = ""
    local ok1    = ffi.C.OpenClipboard(nil)
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
function 置剪贴板(txt)
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



function 取jijo(txt)
	return 取MD5(txt)
end

function 取MD5(txt)
	local pctx = ffi.new("MD5_CTX[1]")
	advapi32.MD5Init(pctx)
	advapi32.MD5Update(pctx, tostring(txt), string.len(txt))
	advapi32.MD5Final(pctx)
	local md5str = ffi.string(pctx[0].digest,16)
	return string.format("%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",string.byte(md5str, 1, -1))
end

function 信息框(msg,title,type)
	ffi.C.MessageBoxA(nil, msg, title or '信息', mtype or 0)
end

function 延迟(int)
	ffi.C.Sleep(int)
end

function 文件是否存在(file)
	return ffi.C._access(file,0)==0
end

table.tostring = function (t)
	local mark={}
	local assign={}
	local function ser_table(tbl,parent)
		mark[tbl]=parent
		local tmp={}
		for k,v in pairs(tbl) do
			local key= type(k)=="number" and "["..k.."]" or "[".. string.format("%q", k) .."]"
			if type(v)=="table" then
				local dotkey= parent.. key
				if mark[v] then
					table.insert(assign,dotkey.."='"..mark[v] .."'")
				else
					table.insert(tmp, key.."="..ser_table(v,dotkey))
				end
			elseif type(v) == "string" then
				table.insert(tmp, key.."=".. string.format('%q', v))
			elseif type(v) == "number" or type(v) == "boolean" then
				table.insert(tmp, key.."=".. tostring(v))
			end
		end
		return "{"..table.concat(tmp,",").."}"
	end
	return "do local ret="..ser_table(t,"ret")..table.concat(assign," ").." return ret end"
end

-- table.loadstring = function (strData)
-- 	local f = loadstring(strData)
-- 	if f then
-- 		return f()
-- 	end
-- end
--表复制
table.copy = function (ori_tab)
    if (type(ori_tab) ~= "table") then
    	--error("非table,不能复制.")
    end
    local new_tab = {};
    for i,v in pairs(ori_tab) do
        local vtyp = type(v);
        if (vtyp == "table") then
            new_tab[i] = table.copy(v);
        elseif (vtyp == "thread") then
            --error("复制失败,非法类型.")
        elseif (vtyp == "userdata") then
            --error("复制失败,非法类型.")
        else
            new_tab[i] = v;
        end
    end
    return new_tab;
end
--表打印
table.print = function (root)
	local print = print
	local tconcat = table.concat
	local tinsert = table.insert
	local srep = string.rep
	local type = type
	local pairs = pairs
	local tostring = tostring
	local next = next
	local cache = {  [root] = "." }
	local function _dump(t,space,name)
		local temp = {}
		for k,v in pairs(t) do
			local key = tostring(k)
			if cache[v] then
				tinsert(temp,"." .. key .. " {" .. cache[v].."}")
			elseif type(v) == "table" then
				local new_key = name .. "." .. key
				cache[v] = new_key
				tinsert(temp,"." .. key .. _dump(v,space .. (next(t,k) and "|" or " " ).. srep(" ",#key),new_key))
			else
				tinsert(temp,"." .. key .. " [" .. tostring(v).."]")
			end
		end
		return tconcat(temp,"\n"..space)
	end
	print(_dump(root, "",""))
	print('-------------------------------------')
end
--分割文本(文本,分割符)
string.split = function (s, p)
	if s then
	    local rt= {}
	    string.gsub(s, '[^'..p..']+', function(w) table.insert(rt, w) end )
	    return rt
	end
	return {}
end
--只适合小数四舍五入(数值,小数位)
math.round = function (num, idp)
  return tonumber(string.format("%." .. (idp or 0) .. "f", num))
end
--适合小数和整数
math.round1 = function (num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end

function 判断是否为空表(t)
    return _G.next( t ) == nil
end

function copy(list)
    local newList = {}
    for k,v in pairs(list) do
        newList[k] = v
    end
    return newList
end


function isContain(list, value)
    local isContain = false
    for k,v in pairs(list) do
        if v == value then
            isContain = true
        end
    end
    return isContain
end