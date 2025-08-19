-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2022-10-04 11:10:50
-- @最后修改来自: baidwwy
-- @Last Modified time: 2025-06-16 00:58:57
function 读入文件(fileName)
  --__S服务:输出(fileName,88)
  local f = assert(io.open(fileName,'r'))
  local content = f:read('*all')
  f:close()
  -- print(content)
  if content=="" then content="无文本" end
  -- __S服务:输出(content,99)
  return content
end

function 取当前目录()
  local ffi = require("ffi")
  local path = ffi.new("char[256]")
  ffi.C.GetCurrentDirectoryA(256,path)
  return ffi.string(path)
end

function 写出内容(qq, ww)
  if qq == nil or ww == nil or ww == "" then
    return 0
  end
  qq = 程序目录 .. qq
  local file = io.open(qq,"a+")
  if file == nil then
    __S服务:输出("写出内容失败,请检查写出路径:"..qq)
    return 0
  end
  file:write(ww)
  file:close()
  text =0
  程序目录=lfs.currentdir()..[[\]]
  return text
end

function 时间转换(时间)
  return  "["..os.date("%Y", 时间).."年"..os.date("%m", 时间).."月"..os.date("%d", 时间).."日 "..os.date("%X", 时间).."]"
end

function 分割文本(str,delimiter)
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

kemy={}
mab = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/*=.，'
key={["B"]="Cb,",["S"]="3C,",["5"]="6D,",["D"]="2W,",["c"]="dc,",["E"]="cj,",["b"]="vt,",["3"]="Iv,",["s"]="j1,",["N"]="23,",["d"]="mP,",["6"]="wd,",["7"]="7R,",["e"]="ET,",["t"]="nB,",["8"]="9v,",["4"]="yP,",["W"]="j6,",["9"]="Wa,",["H"]="D2,",["G"]="Ve,",["g"]="JA,",["I"]="Au,",["X"]="NR,",["m"]="DG,",["w"]="Cx,",["Y"]="Qi,",["V"]="es,",["F"]="pF,",["z"]="CO,",["K"]="XC,",["f"]="aW,",["J"]="DT,",["x"]="S9,",["y"]="xi,",["v"]="My,",["L"]="PW,",["u"]="Aa,",["k"]="Yx,",["M"]="qL,",["j"]="ab,",["r"]="fN,",["q"]="0W,",["T"]="de,",["l"]="P8,",["0"]="q6,",["n"]="Hu,",["O"]="A2,",["1"]="VP,",["i"]="hY,",["h"]="Uc,",["C"]="cK,",["A"]="f4,",["P"]="is,",["U"]="u2,",["o"]="m9,",["Q"]="vd,",["R"]="gZ,",["2"]="Zu,",["Z"]="Pf,",["a"]="Lq,",["p"]="Sw,"}

function jm(数据)
  数据=encodeBase641(数据)
  local jg=""
  for n=1,#数据 do
    local z=string.sub(数据,n,n)
    if z~="" then
      if key[z]==nil then
        jg=jg..z
      else
        jg=jg..key[z]
      end
    end
  end
  return jg
end

function jm1(数据)
  local jg=数据
  for n=1,#mab do
    local z=string.sub(mab,n,n)
    if key[z]~=nil then
       jg=string.gsub(jg,key[z],z)
    end
  end
  return decodeBase641(jg)
end
