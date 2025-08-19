
local 网络处理类 = class()

function 网络处理类:初始化() end

function 网络处理类:取角色选择id(id,账号)
  if 账号==nil or id==nil then
    return 0
  end
  local 临时id = 0
  if f函数.文件是否存在([[data/]]..账号..[[/信息.txt]])==false then
    return 0
  else
    local 临时文件=读入文件([[data/]]..账号..[[/信息.txt]])
    local 写入信息=table.loadstring(临时文件)
    if 写入信息[id+0]~=nil then
      if f函数.文件是否存在([[data/]]..账号..[[/]]..写入信息[id+0]..[[/角色.txt]])==false then
        return 0
      else
        local 读取文件=读入文件([[data/]]..账号..[[/]]..写入信息[id+0]..[[/角色.txt]])
        local 还原数据=table.loadstring(读取文件)
        if 还原数据~=nil then
          临时id = 还原数据.数字id
        else
          return 0
        end
      end
    else
       return 0
    end
  end
  return 临时id
end


function 错误消息输出(内容,事件,id)
    print(内容)
    print(事件)
    print("==================分隔符===================")
end

function 网络处理类:数据解密处理(id,数据内容)
  内容 =self:jm1(数据内容)

  if 内容==nil or 内容=="" then
     --self:断开连接(id,"通讯密码错误")
    return
  end

  if string.find(内容, "function") ~= nil then
    错误消息输出(内容,"接收到局域函数信息",id)
    return
  end
  self.数据=分割文本(内容,fgf)
  if self.数据=="" or self.数据==nil then
    self:断开连接(id,"通讯密码错误")
    return
  end


  self.数据[1]=self.数据[1]+0
  --------
   if not self.数据[3] or not tonumber(self.数据[3]) or not self.数据[4] or not self.数据[5] or not self.数据[6]  then
     return
  end
  if tonumber(self.数据[3])>os.time() then
     return
  elseif os.time()-self.数据[3]>30  then
     return
  end
  local 数据校验 = 取校验数据(self.数据[1],self.数据[2],self.数据[5],self.数据[6],self.数据[3])
  if self.数据[4]~= 数据校验 then
        return
  end
  -- 数据校验
  if self.数据[1]==1  or self.数据[1] == 1.1 then --版本验证


     self.临时数据=分割文本(self.数据[2],fgc)
    if not self.临时数据[1] or not tonumber(self.临时数据[1]) or self.临时数据[1]+0~= 网关参数.版本号   then
        self:发送数据(id,999,"您的客户端版本过低，请到群里更新今日最新补丁运行游戏")
        return
    else
        __C客户信息[id].账号 = self.临时数据[2]
        if not __C客户信息[id].账号 or __C客户信息[id].账号=="" then
            return
        elseif f函数.读配置(程序目录..[[data\]]..__C客户信息[id].账号..[[\账号信息.txt]],"账号配置","封禁") == "1" then
            发送数据(id,999,"该账号已经被封禁！")
            return
        else
            self:数据处理(id,table.tostring({序号=self.数据[1],内容={账号=self.临时数据[2],密码=self.临时数据[3],ip=__C客户信息[id].IP}}))
        end

    end


  elseif self.数据[1]==2 then
    if not __C客户信息[id].账号 or __C客户信息[id].账号==""  then
          return
    else
          self:数据处理(id,table.tostring({序号=self.数据[1],内容={账号=__C客户信息[id].账号}}))
    end
  elseif self.数据[1]==3 then
        if not __C客户信息[id].账号 or __C客户信息[id].账号==""  then
                  return
        else
            local nr= 分割文本(self.数据[2],"1222*-*1222")
            self:数据处理(id,table.tostring({序号=self.数据[1],内容={账号=__C客户信息[id].账号,模型=nr[1],名称=nr[2],染色ID=nr[3],ip=__C客户信息[id].IP}}))
        end
  elseif self.数据[1]==4 or self.数据[1]==4.1 then
      if not __C客户信息[id].账号 or __C客户信息[id].账号==""  then
              return
      else
          self.临时数据=分割文本(self.数据[2],fgc)
          if not self.临时数据[2] or not tonumber(self.临时数据[2]) or self.临时数据[2]+0~=服务端参数.版本 then
                  发送数据(id,999,"您的客户端版本过低，请到群里更新今日最新补丁运行游戏")
                  return
          else
                self:数据处理(id,table.tostring({序号=self.数据[1],内容={账号=__C客户信息[id].账号,id=__C客户信息[id].数字id,ip=__C客户信息[id].IP}}))
          end
      end

  elseif self.数据[1]==34 then --版本验证
    self.临时数据=分割文本(self.数据[2],fgc)
    if not self.临时数据[1] or not tonumber(self.临时数据[1]) or self.临时数据[1]+0~=服务端参数.版本 then
      发送数据(id,999,"您的客户端版本过低，请到群里更新今日最新补丁运行游戏")
    else
          __C客户信息[id].账号=self.临时数据[2]
           if not __C客户信息[id].账号 or __C客户信息[id].账号==""  then
                  return
          else
                self:数据处理(id,table.tostring({序号=self.数据[1],内容={账号=self.临时数据[2],密码=self.临时数据[3],ip=__C客户信息[id].IP}}))
          end
    end
  else
    -- print(self.数据[3])
--       {
--   [1]=14,
--   [2]="''"
--   [3]="时间"
--   [4]=nil
-- }
    self.临时数据=table.loadstring(self.数据[2])
    if self.临时数据==nil or self.临时数据=="" then return  end
    self.临时数据.ip=__C客户信息[id].IP
    self.临时数据.序号=self.数据[1]
    self.临时数据.数字id=__C客户信息[id].数字id
    self:数据处理(id,table.tostring(self.临时数据),self.数据[3])
  end
end

function 取校验数据(序号,内容,随机1,随机2,时间)
  local 加密协议号="xzcjasdiwsnfaasddwf"
  return  f函数.取MD5(序号..内容..随机1..加密协议号..随机2..时间)
end


function 网络处理类:数据处理(id,源,时间记录)
  --   if string.find(源, "function") ~= nil then
  --     错误消息输出(源,"接收到局域函数信息",id)
  --     return
  -- end
  self.数据=table.loadstring(源)
  local 序号=self.数据.序号+0
  if 序号>5 and 序号~=34 and (self.数据.数字id==nil or 玩家数据[self.数据.数字id+0]==nil or not 玩家数据[self.数据.数字id+0].账号) then
    return
  end

if self.数据.数字id ~= nil and 玩家数据[self.数据.数字id+0] ~=nil and  玩家数据[self.数据.数字id+0].摊位数据~=nil and 序号~=7  and 序号~=43  and 序号~=3699 and
    序号~=3700 and 序号~=3720 and 序号~=3721 and 序号~=3722 and 序号~=3723 and 序号~=3724  then
      常规提示(self.数据.数字id+0,"#Y/摆摊状态下禁止此种行为")
   return
end


if self.数据.数字id ~= nil and 玩家数据[self.数据.数字id+0] ~=nil and  玩家数据[self.数据.数字id+0].交易信息~=nil and  序号~=3699 and
    序号~=3717 and 序号~=3718 and 序号~=3719 and 序号~=3738  then
      常规提示(self.数据.数字id+0,"#Y/正在交易中无法使用该功能")
   return
end

if self.数据.数字id and 玩家数据[self.数据.数字id+0] and  玩家数据[self.数据.数字id+0].角色 and  玩家数据[self.数据.数字id+0].角色.数据.地图数据.编号==1003 then
    常规提示(self.数据.数字id+0,"#Y/该地图无法使用该功能")
   return
end






  if 序号<=5 or 序号==34 then  --小于等于5(我现在是4.2)
    系统处理类:数据处理(id,序号,self.数据.内容)--走这边
  elseif 序号<=1000 then
    self.数据.数字id=self.数据.数字id+0
    系统处理类:数据处理(id,序号,self.数据)
  elseif 序号>1000 and 序号<=1500 then --地图事件
  	地图处理类:数据处理(id,序号,self.数据.数字id+0,self.数据)
  elseif 序号>1500 and 序号<=2000 then --对话事件
  	对话处理类:数据处理(id,序号,self.数据.数字id+0,self.数据)
  elseif 序号>3500 and 序号<=4000 then --道具事件
  	玩家数据[self.数据.数字id+0].道具:数据处理(id,序号,self.数据.数字id+0,self.数据)
  elseif 序号>4000 and 序号<=4500 then --道具事件
  	队伍处理类:数据处理(id,序号,self.数据.数字id+0,self.数据)

  elseif 序号>4500 and 序号<=4599 then --道具事件
    玩家数据[self.数据.数字id+0].装备:数据处理(id,序号,self.数据.数字id+0,self.数据)
     elseif 序号==5000 then --道具事件
--   打造处理类:数据处理(id,序号,self.数据.数字id+0,self.数据)
  elseif 序号>5000 and 序号<=5500 then --道具事件
    玩家数据[self.数据.数字id+0].召唤兽:数据处理(id,序号,self.数据.数字id+0,self.数据)
  elseif 序号>5500 and 序号<=6000 then --道具事件

    if self.数据.数字id~=nil then
    战斗准备类:数据处理(self.数据.数字id+0,序号,self.数据)
    return 0
  end

  elseif 序号>6000 and 序号<=6100 then --道具事件
    聊天处理类:数据处理(self.数据.数字id+0,序号,self.数据)
  elseif 序号>6100 and 序号<=6200 then --帮派处理
    帮派处理类:数据处理(self.数据.数字id+0,序号,self.数据)
  elseif 序号>6200 and 序号<=6300 then --神器
    玩家数据[self.数据.数字id+0].神器:数据处理(id,序号,self.数据.数字id+0,self.数据)

  --elseif 序号>6200 and 序号 <=6300 then
  --  管理工具类:数据处理(self.数据.数字id+0,序号,self.数据)
  elseif 序号>6300 and 序号 <=6400 then
--    拍卖系统类:数据处理(id,序号,self.数据.数字id+0,self.数据)
  elseif 序号>7000 and 序号<=7100 then --召唤兽仓库事件
      玩家数据[self.数据.数字id+0].召唤兽仓库:数据处理(id,序号,self.数据.数字id+0,self.数据)
    elseif 序号 == 9000 then
      玩家数据[self.数据.数字id+0].角色:取玩家装备信息(self.数据.数字id+0,self.数据.id)


  elseif  序号==99997 then
    服务端参数.连接数=self.数据.人数
  elseif  序号==99998 then

  elseif  序号==99999 then

  end
end
function 网络处理类:更新(dt) end
function 网络处理类:显示(x,y) end

function 网络处理类:断开处理(id,内容)
  if 内容 == nil then
    内容 = "未知"
  end
  发送数据(id,998,内容)
end

function 网络处理类:encodeBase641(source_str)
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

function 网络处理类:decodeBase641(str64)
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

function 网络处理类:jm(数据)
  数据=self:encodeBase641(数据)
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

function 网络处理类:jm1(数据)
  local jg=数据
  for n=1,#mab do
    local z=string.sub(mab,n,n)
    if key[z]~=nil then
       jg=string.gsub(jg,key[z],z)
    end
  end
  return self:decodeBase641(jg)
end



return 网络处理类