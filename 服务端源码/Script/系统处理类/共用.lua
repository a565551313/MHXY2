local ffi = require("ffi")
  ffi.cdef[[
  const char* Jckh(const char *qq);
  const char* Jcsql();
  const char* Ydwj(const char *qq,const char *qq,const char *qq);
  ]]



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

function 取随机数(q,w)
  随机序列=随机序列+1
  if 随机序列>=1000 then 随机序列=0 end
  if q==nil or w==nil then
    q=1 w=100
  else

  end
  math.randomseed(tostring(os.clock()*os.time()*随机序列))
  return  math.random(math.floor(q),math.floor(w))
end

function sj(q,w)
  随机序列=随机序列+1
  if 随机序列>=1000 then 随机序列=0 end
  if q==nil or w==nil then
    q=1 w=100
  else

  end
  math.randomseed(tostring(os.clock()*os.time()*随机序列))
  return  math.random(math.floor(q),math.floor(w))
end

function 写出内容(qq, ww)
  if qq == nil or ww == nil or ww == "" then
    return 0
  end
  qq = 程序目录 .. qq
  local file = io.open(qq,"w")
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

function 写出内容1(qq, ww)
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

function 写出文件(qq,ww)
  写出内容(qq,ww)
  lfs.chdir(初始目录)
  程序目录=初始目录
end

function 写出文件1(qq,ww)
  写出内容1(qq,ww)
  lfs.chdir(初始目录)
  程序目录=初始目录
end

function 取文件夹的所有名(path)

  local z={}
  for file in lfs.dir(path) do
    if file ~= "." and file ~= ".." then
      local f = path..'/'..file
      local attr = lfs.attributes (f)
      assert (type(attr) == "table")
      if attr.mode == "directory" then
         z[#z+1]=file
      end
    end
  end
  return z
end

function 取文件的所有名(path)

  local z={}
  for file in lfs.dir(path) do
    local x = 分割文本(file, ".")
     if x[2]=="txt" then
         z[#z+1]=x[1]
        end
  end
  return z
end





function 写配置(文件,节点,名称,值)--写配置("./config.ini","mhxy","宽度",全局游戏宽度)
  return ffi.C.WritePrivateProfileStringA(节点,名称,tostring(值),文件)
end

function 取分(a)
  return math.floor(a/60)
end

function 取剩余分钟(时间)
  local 分 = math.modf(时间/60)
  local 秒 = 时间 - 分*60
  return 分,秒
end

function MergeTable(tbA,tbB)
  for m,v in pairs(tbB) do
      tbA[m] = v
    end
  end

function 刷新货币(连接id,id)
  发送数据(连接id,35,{银子=玩家数据[id].角色.数据.银子,储备=玩家数据[id].角色.数据.储备,存银=玩家数据[id].角色.数据.存银,经验=玩家数据[id].角色.数据.当前经验})
end

function 取灵气上限(等级)
  if 等级==1 then
    return 2000
  elseif 等级==2 then
    return 3000
  else
    return 5000
  end
end

function 封禁账号(id,内容)
      地图处理类:强制跳转地图(id)
      f函数.写配置(程序目录..[[data/]] .. 玩家数据[id].账号 .. "/账号信息.txt", "账号配置", "封禁", "1")
      发送数据(玩家数据[id].连接id,998,"您的账号已经被封禁")
      广播消息(9, "#xt/#g/ " .. 玩家数据[id].角色.数据.名称 .. "使用非法软件,已经封号,封禁原因为:"..内容)
      -- __S服务:断开连接(玩家数据[id].连接id)
	  --玩家数据[id].连接id=id
	  系统处理类:断开游戏(id)
	  --__N连接数 = __N连接数-1
    -- 网络处理类:退出处理(id, 内容)
end

function 取等级(id)
  return 玩家数据[id].角色.数据.等级
end

function 检查格子(id)
  if 玩家数据[id].角色:取道具格子()==0 then
    return false
  else
    return true
  end
end

function 广播消息(消息)
  for n, v in pairs(玩家数据) do
    if  玩家数据[n].管理 == nil then
      发送数据(玩家数据[n].连接id,38,消息)
    end
  end
end

function 广播门派消息(消息,内容)
  for n, v in pairs(玩家数据) do
    if  玩家数据[n].管理 == nil and 玩家数据[n].角色.数据.门派 == 内容 then
      发送数据(玩家数据[n].连接id,38,消息)
    end
  end
end

function 广播帮派消息(消息,内容)
  for n, v in pairs(玩家数据) do
    if 玩家数据[n].管理 == nil and 玩家数据[n].角色.数据.帮派数据~=nil and 玩家数据[n].角色.数据.帮派数据.编号>0 and 玩家数据[n].角色.数据.帮派数据.编号 == 内容 then
      发送数据(玩家数据[n].连接id,38,消息)
    end
  end
end

function 发送公告(消息)
  for n, v in pairs(玩家数据) do
    if  玩家数据[n].管理 == nil then
      发送数据(玩家数据[n].连接id,59,消息)
    end
  end
end
function 发送传音(名称,内容,类型,道具)
  for n, v in pairs(玩家数据) do
    if  玩家数据[n].管理 == nil then
       发送数据(玩家数据[n].连接id,59.1,{名称,内容,类型,道具})
    end
  end
end
function 读入文件(fileName)
  local f = assert(io.open(fileName,'r'))
  local content = f:read('*all')
  f:close()
  if content=="" then content="无文本" end
  return content
end

function 时辰函数()
  if os.time()-时辰信息.起始>=时辰信息.刷新 then
    时辰信息.起始=os.time()
    时辰信息.当前=时辰信息.当前+1
    if 时辰信息.当前==13 then
      时辰信息.当前=1
    end
    if 时辰信息.当前==12 then
      local random = math.random
      if 昼夜参数==1 then
        昼夜参数=2
        广播消息({内容="天亮了...\n#G(物理伤害恢复正常了)",频道="xt"})
      else
        昼夜参数=1
        广播消息({内容="天黑了...\n#G(所有物理伤害降低20%)\n#G(夜战单位和地府不受影响)",频道="xt"})
      end
    end
    for n, v in pairs(玩家数据) do--发送时辰更换
      if 玩家数据[n].管理 == nil then
        发送数据(玩家数据[n].连接id,43,{时辰=时辰信息.当前})
      end
    end
  end
end

function qbfb(a,b)
  return a/b
end

function 剧情点数量查找(名字)
  if 名字 == "调息" then
    return 3
  elseif 名字 == "变化之术" then
   return 4
  elseif 名字 == "奇门遁甲" then
   return 4
  elseif 名字 == "妙手空空" then
   return 3
  elseif 名字 == "打坐" then
   return 3
  elseif 名字 == "宝石工艺" then
   return 2
  elseif 名字 == "仙灵店铺" then
   return 3
  -- elseif 名字 == "翱翔" then
  --  return 1
  else
      return 1
  end
end

function 常规提示(id,内容,多角色)
  --print(id,内容)
   if id==nil then  return end
   if 玩家数据[id] ==nil then print("是玩家数据[id]导致的错误,玩家id:"..id.."内容:"..内容) return end
   if 多角色 ~=nil then
      if 玩家数据[多角色]==nil or (玩家数据[多角色]~=nil and 玩家数据[多角色].连接id==nil) or 内容==nil then
        return
      end
      发送数据(玩家数据[多角色].连接id,7,"#Y/"..内容)
  else
      if 玩家数据[id]==nil or (玩家数据[id]~=nil and 玩家数据[id].连接id==nil) or 内容==nil then
         return
      end
      发送数据(玩家数据[id].连接id,7,"#Y/"..内容)
  end

end




function 取唯一识别码(id)
    随机序列=随机序列+1
    return id.."_"..os.time().."_"..随机序列.."_"..取随机数(1,9999).."_"..id..取随机数(1,9999).."_"..id
end





function 取id组(id)
  local id组={}
  if 玩家数据[id].队伍==0 then
    id组[1]=id
  else
    local 队伍id=玩家数据[id].队伍
    for n=1,#队伍数据[队伍id].成员数据 do
     id组[n]=队伍数据[队伍id].成员数据[n]
    end
  end
  return id组
end

function 取队伍人数(id)
  if 玩家数据[id].队伍==0 then
      return 1
  else
      return #队伍数据[玩家数据[id].队伍].成员数据
  end
end

function 取队长权限(id)
  if 玩家数据[id].队伍==0 then
      return true
  elseif 玩家数据[id].队长 then
      return true
  end
  return false
end

function 取等级要求(id,等级)
  local id组={}
  if 玩家数据[id].队伍==0 then
      id组[1]=id
  else
      local 队伍id=玩家数据[id].队伍
      for n=1,#队伍数据[队伍id].成员数据 do
          id组[n]=队伍数据[队伍id].成员数据[n]
      end
  end
  for n=1,#id组 do
      if 玩家数据[id组[n]].角色.数据.等级<等级 then
          return false
      end
  end
  return true
end

function 取任务符合id(id,任务id)
  if 任务数据[任务id]==nil then return false end
  for n=1,#任务数据[任务id].队伍组 do
    if 任务数据[任务id].队伍组[n]==id then
      return true
    end
  end
  return false
end

function 广播队伍消息(队伍id,文本,超链)
  for n=1,#队伍数据[队伍id].成员数据 do
    if 玩家数据[队伍数据[队伍id].成员数据[n]] then
     发送数据(玩家数据[队伍数据[队伍id].成员数据[n]].连接id,38,{内容=文本,超链=超链,频道="dw"})
    end
  end
  return false
end

function 取门派示威对象(门派)
 local 示威对象={}
  for n, v in pairs(玩家数据) do
    if 玩家数据[n].管理==nil and 玩家数据[n].角色.数据.门派~="无" and 玩家数据[n].角色.数据.门派~=门派 then
      示威对象[#示威对象+1]=n
    end
  end
  if #示威对象==0 then
    return
  else
    local 临时序列=取随机数(1,#示威对象)
    local id=示威对象[临时序列]
    return 玩家数据[id].角色:取地图数据()
  end
end
function 取文韵示威对象(门派)---------远方文韵墨香
 local 示威对象={}
  for n, v in pairs(玩家数据) do
    if 玩家数据[n].管理==nil and 玩家数据[n].角色.数据.门派~="无" and 玩家数据[n].角色.数据.门派~=门派 then
      示威对象[#示威对象+1]=n
    end
  end
  if #示威对象==0 then
    return
  else
    local 临时序列=取随机数(1,#示威对象)
    local id=示威对象[临时序列]
    return 玩家数据[id].角色:取地图数据()
  end
end



function 添加最后对话(id,对话,选项)
          if not 玩家数据[id] then return end
          local 队长id = id
          if 选项 ~= nil and 选项[1] ~=  nil and 选项[1] ~= "确定强行PK" and (玩家数据[id].最后对话 == nil or 玩家数据[id].最后对话.名称 == nil) then
              if 玩家数据[id].队伍 ~= 0 then
                    队长id = 队伍数据[玩家数据[id].队伍].成员数据[1]
                    if not 队长id or 队长id == 0 or not 玩家数据[队长id] then
                        队长id = id
                    end
              else
                  队长id = id
              end
          end
          if not 玩家数据[队长id] then return end
          if 玩家数据[队长id].最后对话==nil then
              玩家数据[队长id].最后对话 = {}
              玩家数据[队长id].最后对话.名称=玩家数据[id].角色.数据.名称
              玩家数据[队长id].最后对话.模型=玩家数据[id].角色.数据.模型
          end
          local 名称=玩家数据[队长id].最后对话.名称
          local 模型=玩家数据[队长id].最后对话.模型
          if 名称==nil then
            名称=玩家数据[id].角色.数据.名称
          end
          if 模型==nil then
            模型=玩家数据[id].角色.数据.模型
          end
          发送数据(玩家数据[id].连接id,1501,{名称=名称,模型=模型,对话=对话,选项=选项})
end

function 取队伍最低等级(队伍id,等级)
    if not 玩家数据[队伍id].队伍 or 玩家数据[队伍id].队伍==0 then
        if 玩家数据[队伍id].角色.数据.等级<等级 then
             return true
        else
              return false
        end
    end
    for n=1,#队伍数据[队伍id].成员数据 do
        if 玩家数据[队伍数据[队伍id].成员数据[n]].角色.数据.等级<等级 then
            return true
        end
    end
    return false
end


function 取队伍最高等级(队伍id,等级)
    if not 玩家数据[队伍id].队伍 or 玩家数据[队伍id].队伍==0 then
        if 玩家数据[队伍id].角色.数据.等级>等级 then
            return true
        else
            return false
        end
    end
    for n=1,#队伍数据[队伍id].成员数据 do
      if 玩家数据[队伍数据[队伍id].成员数据[n]].角色.数据.等级>等级 then
        return true
      end
    end
    return false
end


function 取队伍最高等级数(队伍id,id)
  if 队伍id==nil or 队伍数据[队伍id]==nil then
    if id~=nil and 玩家数据[id] then
        return 玩家数据[id].角色.数据.等级
    else
        return 175
    end
  end
  local t = {}
  for n=1,#队伍数据[队伍id].成员数据 do
    t[n]=玩家数据[队伍数据[队伍id].成员数据[n]].角色.数据.等级
  end
  table.sort(t)
  return t[#队伍数据[队伍id].成员数据]
end

function 取队伍最低等级数(队伍id,id)
  if 队伍id==nil or 队伍数据[队伍id]==nil then
      if id~=nil and 玩家数据[id] then
          return 玩家数据[id].角色.数据.等级
      else
          return 175
      end
  end
  local t = {}
  for n=1,#队伍数据[队伍id].成员数据 do
    t[n]=玩家数据[队伍数据[队伍id].成员数据[n]].角色.数据.等级
  end
  table.sort(t)
  return t[1]
end


function 取队伍平均等级(队伍id,id)
  if 队伍id==nil or 队伍数据[队伍id]==nil then
     if id~=nil and 玩家数据[id] and 玩家数据[id].角色 then
          return 玩家数据[id].角色.数据.等级
      else
          return 175
      end
  end
  local 等级=0
  for n=1,#队伍数据[队伍id].成员数据 do
      if 玩家数据[队伍数据[队伍id].成员数据[n]] and 玩家数据[队伍数据[队伍id].成员数据[n]].角色 then
          等级=等级+玩家数据[队伍数据[队伍id].成员数据[n]].角色.数据.等级
      else
          等级=等级+175
      end
  end
  等级=math.floor(等级/#队伍数据[队伍id].成员数据)
  return 等级
end

function 取队伍任务(队伍id,等级)
          if not 玩家数据[队伍id].队伍 or 玩家数据[队伍id].队伍==0 then
              if 玩家数据[队伍id].角色:取任务(等级)~=0  then
                  return true
              else
                  return false
              end
          end
          for n=1,#队伍数据[队伍id].成员数据 do
                if 玩家数据[队伍数据[队伍id].成员数据[n]].角色:取任务(等级)~=0 then
                    return true
                end
          end
          return false
end

function 取队员任务一致(id,任务,提示)
          local 任务id = 玩家数据[id].角色:取任务(任务)
          if not 任务id or 任务id==0 or not 任务数据[任务id] then
              if 提示 then
                  常规提示(id,"#Y你没有这个任务")
              end
             return false
          end
          if 玩家数据[id].队伍 and  玩家数据[id].队伍~=0 then
              for i,v in ipairs(队伍数据[玩家数据[id].队伍].成员数据) do
                  if not 玩家数据[v] or 玩家数据[v].角色:取任务(任务)~=任务id then
                      if 提示 then
                          if 玩家数据[v] then
                            常规提示(id,"#Y玩家#R"..玩家数据[v].角色.数据.名称.."#Y与你的任务不一致！")
                          end
                      end
                      return false
                  end
              end
          end
          return true
end


function 取等级(id)
  return 玩家数据[id].角色.数据.等级
end

function 取银子(id)
  return 玩家数据[id].角色.数据.银子
end

function 取储备(id)
  return 玩家数据[id].角色.数据.储备
end

function 取存银(id)
  return 玩家数据[id].角色.数据.存银
end

function 取名称(id)
  return 玩家数据[id].角色.数据.名称
end
function 道具刷新(id,多角色)
  if 多角色~=nil then
     发送数据(玩家数据[多角色].连接id,6002,{角色=id,角色属性=玩家数据[id].角色:取总数据()})
     发送数据(玩家数据[多角色].连接id,6007,{角色=id,道具=玩家数据[id].道具:索要道具2(id)})
     发送数据(玩家数据[多角色].连接id,6009,{角色=id,道具=玩家数据[id].道具:索要道具4(id,"行囊")})
     发送数据(玩家数据[多角色].连接id,6010,{角色=id,道具=玩家数据[id].道具:索要法宝(玩家数据[id].连接id,id,多角色)})
  else
     发送数据(玩家数据[id].连接id,3699)
  end
end
function 人物刷新(id)
  发送数据(玩家数据[id].连接id,12)
end
function 金钱刷新(id)
  发送数据(玩家数据[id].连接id,3520,取银子(id))
end
function 门派代号(门派)
  if 门派 == "大唐官府" then
      return "dt"
  elseif 门派 == "化生寺" then
      return "hs"
  elseif 门派 == "方寸山" then
      return "fc"
  elseif 门派 == "女儿村" then
      return "ne"
  elseif 门派 == "狮驼岭" then
      return "st"
  elseif 门派 == "阴曹地府" then
      return "df"
  elseif 门派 == "天宫" then
      return "tg"
  elseif 门派 == "盘丝洞" then
      return "ps"
  elseif 门派 == "魔王寨" then
      return "mw"
  elseif 门派 == "五庄观" then
      return "wz"
  elseif 门派 == "龙宫" then
      return "lg"
  elseif 门派 == "普陀山" then
      return "pts"
  elseif 门派 == "无底洞" then
      return "wd"
  elseif 门派 == "凌波城" then
      return "lb"
  elseif 门派 == "神木林" then
      return "sm"
  end
end

function 刷新修炼数据(id)
  发送数据(玩家数据[id].连接id,44,{人物=玩家数据[id].角色.数据.修炼,bb=玩家数据[id].角色.数据.bb修炼})
end



function 体活刷新(id)
  if 玩家数据[id] ~=nil and 玩家数据[id].角色 ~=nil and 玩家数据[id].角色.数据.体力 ~=nil and 玩家数据[id].角色.数据.活力 ~= nil  then
      发送数据(玩家数据[id].连接id,15,{体力=玩家数据[id].角色.数据.体力,活力=玩家数据[id].角色.数据.活力})
  end
end

function 发送数据(id,序号,内容,封装)
  if id==nil then return  end
  if 内容==nil then 内容="1" end
  if 封装==nil then
    local 组合内容={序号=序号,内容=内容}
    local 临时添加={id,table.tostring(组合内容)}
    --table.insert(发送缓存,临时添加)
    __S服务:发送(服务端参数.网关id,id,table.tostring(组合内容))
  end
  组合内容={}
end

function 发送数据1(id,序号,内容)
  __S服务:gm发送(id,序号,内容)
end

function txt(布尔值)
  if 布尔值 then
    return "true"
  else
    return "false"
  end
end
function 调试信息(o) end

function 时间转换(时间)
  return  "["..os.date("%Y", 时间).."年"..os.date("%m", 时间).."月"..os.date("%d", 时间).."日 "..os.date("%X", 时间).."]"
end

function 时间转换1(时间)
  return  os.date("%Y", 时间).."-"..os.date("%m", 时间).."-"..os.date("%d", 时间).." "..os.date("%X", 时间)
end

function 时间转换2(时间)
  return  os.date("%m", 时间).."-"..os.date("%d", 时间).." "..os.date("%H", 时间)..":"..os.date("%M", 时间)
end
function 时间转换3(时间)
  return  "["..os.date("%H", 时间)..":"..os.date("%M", 时间).."]"
end

function 取年月日(时间)
  return  os.date("%Y", 时间).."年"..os.date("%m", 时间).."月"..os.date("%d", 时间).."日 "
end

function 取年月日1(时间)
  return  os.date("%Y", 时间).."年"..os.date("%m", 时间).."月"..os.date("%d", 时间).."日"
end

-- function 取年月日时分(时间)
--   return  os.date("%Y", 时间).."年"..os.date("%m", 时间).."月"..os.date("%d", 时间).."日"..os.date("%H", 时间).."时"..os.date("%M",时间).."分"
-- end

function 强制下线()
  for n, v in pairs(战斗准备类.战斗盒子) do
    if 战斗准备类.战斗盒子[n]~=nil  then
       战斗准备类.战斗盒子[n]:结束战斗处理(0,0,1)
    end
  end
  for n, v in pairs(玩家数据) do
    if 玩家数据[n]~=nil and 玩家数据[n].管理 == nil then
      玩家数据[n].角色:存档()
      系统处理类:断开游戏(n)
    end
  end
end



function 保存系统数据()
  local 临时数据={}
  local 数量=0
  for n, v in pairs(任务数据) do
      if (v.类型==2  or v.类型==3 or v.类型==9 or v.类型==411 or v.类型==7756 or v.类型==7757 or v.类型==7755 or not v.结束) and v.类型~=999888  then
          数量=数量+1
          临时数据[数量]=DeepCopy(v)
          临时数据[数量].存储id=n
      end
  end
  写出文件([[tysj/任务数据.txt]],table.tostring(临时数据))
  __S服务:输出("保存任务数据成功……")
  写出文件([[tysj/经验数据.txt]],table.tostring(经验数据))
  __S服务:输出("保存经验数据成功……")
  写出文件([[tysj/押镖数据.txt]],table.tostring(押镖数据))
  __S服务:输出("保存押镖数据成功……")
  写出文件([[tysj/帮派数据.txt]],table.tostring(帮派数据))
  __S服务:输出("保存帮派数据成功……")
  写出文件([[tysj/英雄排名.txt]],table.tostring(英雄排名))
  __S服务:输出("保存英雄排名成功……")
  写出文件([[tysj/首席争霸.txt]],table.tostring(首席争霸))
  __S服务:输出("保存首席争霸成功……")
  写出文件([[tysj/生死劫数据.txt]],table.tostring(生死劫数据))
  __S服务:输出("保存生死劫数据成功……")
  写出文件([[tysj/活动次数.txt]],table.tostring(活动次数))
   __S服务:输出("保存活动次数成功……")
  写出文件([[tysj/首杀记录.txt]],table.tostring(首杀记录))
   __S服务:输出("保存首杀记录成功……")
  写出文件([[tysj/支线奖励.txt]],table.tostring(支线奖励))
   __S服务:输出("保存支线奖励成功……")
  写出文件([[tysj/炼丹炉.txt]],table.tostring(炼丹炉))
   __S服务:输出("保存炼丹炉成功……")
  写出文件([[tysj/镇妖塔数据.txt]],table.tostring(镇妖塔数据))
   __S服务:输出("保存镇妖塔数据成功……")
  写出文件([[tysj/师徒数据.txt]],table.tostring(师徒数据))
   __S服务:输出("保存师徒数据成功……")
  写出文件([[tysj/剑会天下.txt]],table.tostring(剑会天下))  --剑会天下数据保存
   __S服务:输出("保存剑会天下成功……")
  写出文件([[tysj/帮派缴纳情况.txt]],table.tostring(帮派缴纳情况))
   __S服务:输出("保存帮派缴纳成功……")
--  写出文件([[tysj/拍卖系统.txt]],table.tostring(拍卖系统数据))
  写出文件([[tysj/成就数据.txt]],table.tostring(成就数据))
   __S服务:输出("保存成就数据成功……")
  -- 写出文件([[tysj/国庆数据.txt]],table.tostring(国庆数据))
  --  __S服务:输出("保存国庆数据成功……")
  写出文件([[tysj/雪人活动.txt]],table.tostring(雪人活动))
   __S服务:输出("保存雪人活动成功……")
  写出文件([[tysj/世界挑战.txt]],table.tostring(世界挑战))
   __S服务:输出("保存世界挑战成功……")
--  写出文件([[tysj/图鉴系统.txt]],table.tostring(图鉴系统))
--  写出文件([[tysj/交易中心.txt]],table.tostring(交易中心))
  写出文件([[tysj/自动回收.txt]],table.tostring(自动回收))
   __S服务:输出("保存自动回收成功……")
  写出文件([[tysj/签到数据.txt]],table.tostring(签到数据))
   __S服务:输出("保存签到数据成功……")
  写出文件([[tysj/活跃数据.txt]],table.tostring(活跃数据))
   __S服务:输出("保存活跃数据成功……")
  写出文件([[tysj/雁塔地宫.txt]],table.tostring(雁塔地宫))
   __S服务:输出("保存雁塔地宫成功……")
  写出文件([[tysj/地宫排行.txt]],table.tostring(地宫排行))
   __S服务:输出("保存地宫排行成功……")
  写出文件([[tysj/辰星数据.txt]],table.tostring(辰星数据))
   __S服务:输出("保存辰星数据成功……")


  -- 写出文件([[tysj/跨服数据.txt]],table.tostring(跨服数据))
  --  __S服务:输出("保存跨服数据成功……")
  -- 写出文件([[tysj/跨服排名.txt]],table.tostring(跨服排名))
  --  __S服务:输出("保存跨服排名成功……")
  --写出文件([[tysj/轮回境数据.txt]],table.tostring(轮回境数据))
  写出文件([[自动充值\充值记录\]]..取年月日1(充值数据.时间)..充值数据.编号..[[.txt]],充值数据.日志)
  __S服务:输出("保存充值记录成功……")
  if #充值数据.日志>=10240 then
      写出文件([[自动充值\充值记录\]]..取年月日1(充值数据.时间)..充值数据.编号..[[.txt]],充值数据.日志)
      授权连接:发送数据(3,{编号=授权连接.授权编号,名称=服务端参数.名称,内容=充值数据},1)
      充值数据.编号=充值数据.编号 + 1
      f函数.写配置(程序目录.."配置文件.ini","主要配置","编号记录",充值数据.编号)
      充值数据.日志=""
  end
  if 取年月日1(os.time())~=取年月日1(充值数据.时间) then
      充值数据.编号 = 1
      充值数据.日志=""
      充值数据.时间=os.time()
      f函数.写配置(程序目录.."配置文件.ini","主要配置","编号记录","1")
  end
  __S服务:输出("所有数据保存成功……")
  当前时间=os.time()
  当前年份=os.date("%Y",当前时间)
  当前月份=os.date("%m",当前时间)
  当前日份=os.date("%d",当前时间)
  保存时间=os.date("%H",当前时间).."时"..os.date("%M",当前时间).."分"..os.date("%S",当前时间).."秒 "
  if f函数.文件是否存在([[log\]]..当前年份)==false then
    lfs.mkdir([[log\]]..当前年份)
  end
  if f函数.文件是否存在([[log\]]..当前年份..[[\]]..当前月份)==false then
    lfs.mkdir([[log\]]..当前年份..[[\]]..当前月份)
  end
  if f函数.文件是否存在([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份)==false then
    lfs.mkdir([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份)
    lfs.mkdir([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."错误日志")
    -- lfs.mkdir([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."在线日志")
    -- lfs.mkdir([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."备份日志")

  end
  if #错误日志<500 then
    local 保存语句=""
    for n=1,#错误日志 do
      保存语句=保存语句..时间转换(错误日志[n].时间)..'：\n'..错误日志[n].记录..'\n'
    end
    写出文件1([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."错误日志"..[[\]]..保存时间..".txt",保存语句)
  else
    local 文件名称=保存时间
    local 计次数量=0
    local 保存语句=""
    for n=1,#错误日志 do
      保存语句=保存语句..时间转换(错误日志[n].时间)..'：\n'..错误日志[n].记录..'\n'
      计次数量=计次数量+1
      if 计次数量>=500 then
        写出文件1([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."错误日志"..[[\]]..文件名称.."_"..n..".txt",保存语句)
        计次数量=0
        保存语句=""
      end
    end
  end
  错误日志={}
  __S服务:输出("错误日志保存成功……")

end



function 保存所有玩家数据()
  for n, v in pairs(玩家数据) do
    if 玩家数据[n]~=nil  and 玩家数据[n].管理 == nil then
      玩家数据[n].角色:存档()
    end
  end
  __S服务:输出("保存玩家数据成功……")
  local 删除共享={}
  for n, v in pairs(共享仓库) do
      共享仓库[n]:保存数据()
      local 使用数量 = 0
      for k,z in pairs(v.使用玩家) do
         if 玩家数据[k]~=nil then
            使用数量=使用数量+1
         end
      end
      if 使用数量==0 then
          删除共享[#删除共享+1]=n
      end
  end
  for i=1,#删除共享 do
      if 共享仓库[删除共享[i]] then
        共享仓库[删除共享[i]]=nil
      end
  end
  __S服务:输出("保存共享仓库成功……")
  local 删除货币={}
  for n, v in pairs(共享货币) do
      共享货币[n]:保存数据()
      local 使用数量 = 0
      for k,z in pairs(v.使用玩家) do
         if 玩家数据[k]~=nil then
            使用数量=使用数量+1
         end
      end
      if 使用数量==0 then
          删除货币[#删除货币+1]=n
      end
  end
  for i=1,#删除货币 do
      if 共享货币[删除货币[i]] then
         共享货币[删除货币[i]]=nil
      end
  end
  __S服务:输出("保存贵重货币成功……")
end

function 查看在线列表()
  local 列表=""
  for n, v in pairs(玩家数据) do
    列表=列表..format("账号%s,角色id%s",玩家数据[n].账号,n)..'\n'
  end
  写出文件("在线列表.txt",列表)
end
function 退出函数() end

function 打印在线时间()
  local 语句=""
  for n, v in pairs(在线时间) do
    语句=语句..string.format("角色id：%s，本日累积在线：%s秒\n",n,在线时间[n])
  end
  写出文件("在线时间.txt",语句)
end

function 异常账号(数字id,信息)
        if 玩家数据[数字id] then
          __gge.print(false,6,时间转换(os.time()).."账号:")
          __gge.print(false,11,玩家数据[数字id].账号)
        end
        __gge.print(false,6,"ID:")
        __gge.print(false,11,数字id)
        if 玩家数据[数字id] then
          __gge.print(false,6,"名称:")
          __gge.print(false,11,玩家数据[数字id].角色.数据.名称)
        end
        __gge.print(false,10,信息)

end

function 添加充值日志(内容)
      if not 充值数据 then
          充值数据={时间=os.time(),日志="",编号=1}
          f函数.写配置(程序目录.."配置文件.ini","主要配置","编号记录","1")
          if f函数.文件是否存在([[自动充值/充值记录/]]..取年月日1(os.time())..[[1.txt]]) then
              local 日志 = 读入文件([[自动充值\充值记录\]]..取年月日1(os.time())..[[1.txt]])
              if #日志<10240 then
                  充值数据.日志=日志
              else
                  充值数据.编号 = 充值数据.编号 + 1
              end
          end
      end
      充值数据.日志=充值数据.日志.."\n"..时间转换(os.time())..内容
      if #充值数据.日志>=10240 then
          写出文件([[自动充值\充值记录\]]..取年月日1(充值数据.时间)..充值数据.编号..[[.txt]],充值数据.日志)
          授权连接:发送数据(3,{编号=授权连接.授权编号,名称=服务端参数.名称,内容=充值数据},1)
          充值数据.编号=充值数据.编号 + 1
          f函数.写配置(程序目录.."配置文件.ini","主要配置","编号记录",充值数据.编号)
          充值数据.日志=""
      end
end




-- function 添加每日数据(数额,id,类型)
--     local 活动文件={"每日消费","每日充值","神秘礼包","超值抢购"}
--     local 每日数据 = table.loadstring(读入文件([[每日活动/领取数据/]]..玩家数据[id].账号..".txt"))
--     for i=1,#活动文件 do
--         if os.time() > 每日数据[活动文件[i]].到期时间 then
--            每日数据[活动文件[i]] ={数额=0,到期时间=os.time()+86400}
--         end
--     end
--     每日数据[类型].数额 = 每日数据[类型].数额+数额
--     玩家数据[id].每日活动.领取数据=每日数据
--     写出文件([[每日活动/领取数据/]]..玩家数据[id].账号..".txt",table.tostring(每日数据))
-- end



function 添加帮贡(id,数量)
  if 帮派数据[玩家数据[id].角色.数据.帮派数据.编号]~=nil  then
      帮派数据[玩家数据[id].角色.数据.帮派数据.编号].成员数据[id].帮贡.当前=帮派数据[玩家数据[id].角色.数据.帮派数据.编号].成员数据[id].帮贡.当前+数量
      帮派数据[玩家数据[id].角色.数据.帮派数据.编号].成员数据[id].帮贡.上限=帮派数据[玩家数据[id].角色.数据.帮派数据.编号].成员数据[id].帮贡.上限+数量
      玩家数据[id].角色.数据.帮贡=帮派数据[玩家数据[id].角色.数据.帮派数据.编号].成员数据[id].帮贡.当前
      常规提示(id,"#Y获得了#R"..数量.."#Y点帮贡")
  end
end


function 扣除帮贡(id,数量)
  帮派数据[玩家数据[id].角色.数据.帮派数据.编号].成员数据[id].帮贡.当前=帮派数据[玩家数据[id].角色.数据.帮派数据.编号].成员数据[id].帮贡.当前-数量
  帮派数据[玩家数据[id].角色.数据.帮派数据.编号].成员数据[id].帮贡.上限=帮派数据[玩家数据[id].角色.数据.帮派数据.编号].成员数据[id].帮贡.上限-数量
  玩家数据[id].角色.数据.帮贡=帮派数据[玩家数据[id].角色.数据.帮派数据.编号].成员数据[id].帮贡.当前
  常规提示(id,"#Y扣除了#R"..数量.."#Y点帮贡")
end





function 发送系统消息(id,内容,名称)
  local 内容数据={
                  id=999999999,
                  名称=名称 or "系统",
                  模型="梦幻头像",
                  等级=200,
                  好友度=9999,
                  账号=false,
                  时间= os.time(),
                  内容=内容
                }
    玩家数据[id].好友:更新消息(内容数据)



end

-- function 删除重复(key)
--   local k;
--   for i=1,#key do
--     for j=i+1,#key do
--       if(key[i] == key[j]) then
--         key[i] = - 1
--       end
--     end
--   end
--   k = 1;
--   for i=1, #key do
--     if (key[k] == -1) then
--       table.remove(key, k);k=k - 1
--     end
--     k=k+1
--   end
--   k = nil;
--   return key
-- end

function 删除重复(key)
    local seen = {}  -- 用于记录已存在的元素
    local result = {}  -- 存储去重后的结果

    for _, v in ipairs(key) do
        if not seen[v] then  -- 如果该值尚未出现
            seen[v] = true   -- 标记为已出现
            table.insert(result, v)  -- 加入结果表
        end
    end

    return result
end

function qjy(dj)
  if dj==nil then dj=1 end
  return math.floor(dj*dj+20)*3
end

function qyz(dj)
  if dj==nil then dj=1 end
  return math.floor(dj*dj)
end

function qcb(dj)
  if dj==nil then dj=1 end
  return math.floor(dj*dj*1.5)
end



function 取随机小数(x,y)
  return 取随机数(x*10000,y*10000)/10000
end

function 生成XY(x,y)
  local f ={}
  f.x = tonumber(x) or 0
  f.y = tonumber(y) or 0
  setmetatable(f,{
  __add = function (a,b)
    return 生成XY(a.x + b.x,a.y + b.y)
  end,
  __sub = function (a,b)
    return 生成XY(a.x - b.x,a.y - b.y)
  end
  })
  return f
end

function 取两点距离(src,dst)
    return math.sqrt(math.pow(src.x-dst.x,2) + math.pow(src.y-dst.y,2))
end

function 取两点距离a(x, y, x1, y1)
  return math.sqrt(math.pow(x - x1, 2) + math.pow(y - y1, 2))
end

function 取距离坐标(xy,r,a) --r距离,a孤度
  local x1,y1 = 0,0
  x1=r* math.cos(a) + xy.x + 取随机数(-2,2)
  y1=r* math.sin(a) + xy.y + 取随机数(-2,2)
  return 生成XY(math.floor(x1),math.floor(y1))
end

function 取商品卖出价格(spm)

  local dj
  if spm== "商品武器" then
      dj = 取随机数(3600,4500)
  elseif spm== "商品棉布" then
      dj = 取随机数(3200,3800)
  elseif spm== "商品佛珠" then
      dj = 取随机数(6200,8000)
  elseif spm== "商品扇子" then
      dj = 取随机数(3500,4200)
  elseif spm== "商品纸钱" then
      dj = 取随机数(2600,3400)
  elseif spm== "商品夜明珠" then
      dj = 取随机数(7600,9000)
  elseif spm== "商品首饰" then
      dj = 取随机数(3600,4800)
  elseif spm== "商品珍珠" then
      dj = 取随机数(5000,6000)
  elseif spm== "商品帽子" then
      dj = 取随机数(3000,4000)
  elseif spm== "商品盐" then
      dj = 取随机数(4800,6000)
  elseif spm== "商品蜡烛" then
      dj = 取随机数(1500,2500)
  elseif spm== "商品酒" then
      dj = 取随机数(3200,4500)
  elseif spm== "商品木材" then
      dj = 取随机数(3200,5000)
  elseif spm== "商品鹿茸" then
      dj = 取随机数(6800,8500)
  elseif spm== "商品面粉" then
      dj = 取随机数(2500,3500)
  elseif spm== "商品符" then
      dj = 取随机数(4500,6000)
  elseif spm== "商品人参" then
      dj = 取随机数(6500,9000)
  elseif spm== "商品铃铛" then
      dj = 取随机数(3200,4800)
  elseif spm== "商品香油" then
      dj = 取随机数(3200,5000)
  elseif spm== "商品麻线" then
      dj = 取随机数(2000,3800)
  end
  return dj
end

跑商={}
跑商.商品棉布=取商品卖出价格("商品棉布")
跑商.商品佛珠=取商品卖出价格("商品佛珠")
跑商.商品扇子=取商品卖出价格("商品扇子")
跑商.商品武器=取商品卖出价格("商品武器")
跑商.商品纸钱=取商品卖出价格("商品纸钱")
跑商.商品帽子=取商品卖出价格("商品帽子")
跑商.商品木材=取商品卖出价格("商品木材")
跑商.商品人参=取商品卖出价格("商品人参")
跑商.商品夜明珠=取商品卖出价格("商品夜明珠")
跑商.商品盐=取商品卖出价格("商品盐")
跑商.商品鹿茸=取商品卖出价格("商品鹿茸")
跑商.商品铃铛=取商品卖出价格("商品铃铛")
跑商.商品首饰=取商品卖出价格("商品首饰")
跑商.商品蜡烛=取商品卖出价格("商品蜡烛")
跑商.商品面粉=取商品卖出价格("商品面粉")
跑商.商品香油=取商品卖出价格("商品香油")
跑商.商品珍珠=取商品卖出价格("商品珍珠")
跑商.商品酒=取商品卖出价格("商品酒")
跑商.商品符=取商品卖出价格("商品符")
跑商.商品麻线=取商品卖出价格("商品麻线")

--print(时间转换(1558546218))
帮派修炼={
  [1]=16,
  [2]=32,
  [3]=52,
  [4]=75,
  [5]=103,
  [6]=136,
  [7]=179,
  [8]=231,
  [9]=295,
  [10]=372,
  [11]=466,
  [12]=578,
  [13]=711,
  [14]=867,
  [15]=1049,
  [16]=1280,
  [17]=1503,
  [18]=1780,
  [19]=2096,
  [20]=2452,
  [21]=2854,
  [22]=3304,
  [23]=3807,
  [24]=4364,
  [25]=4983
}

帮派技能={
  [1]=16,
  [2]=32,
  [3]=52,
  [4]=75,
  [5]=103,
  [6]=136,
  [7]=179,
  [8]=231,
  [9]=295,
  [10]=372,
  [11]=466,
  [12]=578,
  [13]=711,
  [14]=867,
  [15]=1049,
  [16]=1280,
  [17]=1503,
  [18]=1780,
  [19]=2096,
  [20]=2452,
  [21]=2854,
  [22]=3304,
  [23]=3807,
  [24]=4364,
  [25]=4983,
  [26]=5664,
  [27]=6415,
  [28]=7238,
  [29]=8138,
  [30]=9120,
  [31]=10188,
  [32]=11347,
  [33]=12602,
  [34]=13959,
  [35]=15423,
  [36]=16998,
  [37]=18692,
  [38]=20508,
  [39]=22452,
  [40]=24532,
  [41]=26753,
  [42]=29121,
  [43]=31642,
  [44]=34323,
  [45]=37169,
  [46]=40186,
  [47]=43388,
  [48]=46773,
  [49]=50352,
  [50]=54132,
  [51]=58120,
  [52]=62324,
  [53]=66750,
  [54]=71407,
  [55]=76303,
  [56]=81444,
  [57]=86840,
  [58]=92500,
  [59]=104640,
  [60]=111136,
  [61]=117931,
  [62]=125031,
  [63]=132444,
  [64]=140183,
  [65]=148253,
  [66]=156666,
  [67]=156666,
  [68]=165430,
  [69]=174556,
  [70]=184052,
  [71]=193930,
  [72]=204198,
  [73]=214868,
  [74]=225948,
  [75]=237449,
  [76]=249383,
  [77]=261760,
  [78]=274589,
  [79]=287884,
  [80]=301652,
  [81]=315908,
  [82]=330662,
  [83]=345924,
  [84]=361708,
  [85]=378023,
  [86]=394882,
  [87]=412297,
  [88]=430280,
  [89]=448844,
  [90]=468000,
  [91]=487760,
  [92]=508137,
  [93]=529145,
  [94]=550796,
  [95]=573103,
  [96]=596078,
  [97]=619735,
  [98]=644088,
  [99]=669149,
  [100]=721452,
  [101]=748722,
  [102]=776755,
  [103]=805566,
  [104]=835169,
  [105]=865579,
  [106]=896809,
  [107]=928876,
  [108]=961792,
  [109]=995572,
  [110]=1030234,
  [111]=1065190,
  [112]=1102256,
  [113]=1139649,
  [114]=1177983,
  [115]=1217273,
  [116]=1256104,
  [117]=1298787,
  [118]=1341043,
  [119]=1384320,
  [120]=1428632,---1
  [121]=1473999,
  [122]=1520435,
  [123]=1567957,
  [124]=1616583,
  [125]=1666328,
  [126]=1717211,
  [127]=1769248,
  [128]=1822456,
  [129]=1876852,
  [130]=1932456,
  [131]=1989284,
  [132]=2047353,
  [133]=2106682,
  [134]=2167289,
  [135]=2229192,
  [136]=2292410,
  [137]=2356960,
  [138]=2422861,
  [139]=2490132,
  [140]=2558792,
  [141]=2628860,
  [142]=2700356,
  [143]=2773296,
  [144]=2847703,
  [145]=2923593,
  [146]=3000989,
  [147]=3079908,
  [148]=3160372,
  [149]=3242400,
  [150]=6652022,
  [151]=6822452,
  [152]=6996132,
  [153]=7173104,
  [154]=7353406,
  [155]=11305620,
  [156]=15305620,
  [157]=22305620,
  [158]=27305620,
  [159]=37305620,
  [160]=45305620,
  [161]=54305620
}


帮派建筑升级经验 = {
  [0]={经验=1600,繁荣=5,人气=3},
  [1]={经验=1600,繁荣=5,人气=3},
  [2]={经验=3200,繁荣=10,人气=6},
  [3]={经验=6400,繁荣=20,人气=12},
  [4]={经验=12800,繁荣=40,人气=24},
  [5]={经验=25600,繁荣=80,人气=48},
  [6]={经验=51200,繁荣=160,人气=96},
  [7]={经验=102400,繁荣=320,人气=192},
  [8]={经验=204800,繁荣=640,人气=384},
  [9]={经验=409600,繁荣=1280,人气=768},
  [10]={经验=819200,繁荣=2560,人气=1536},
  [11]={经验=1638400,繁荣=5120,人气=3072},
  [12]={经验=3276800,繁荣=10240,人气=6144},
  [13]={经验=6553600,繁荣=20480,人气=12288},
  [14]={经验=13107200,繁荣=40960,人气=24576},
  [15]={经验=15728640,繁荣=49150,人气=29491},
  [16]={经验=18874368,繁荣=58980,人气=35398},
  [17]={经验=22649241,繁荣=70776,人气=42467},
  [18]={经验=27179089,繁荣=84931,人气=50960},
  [19]={经验=35332816,繁荣=110410,人气=66248},
  [20]={经验=45932661,繁荣=143533,人气=86123},
  [21]={经验=59712460,繁荣=186593,人气=111960},
  [22]={经验=77626198,繁荣=242573,人气=145548},
  [23]={经验=100914057,繁荣=315345,人气=189212},
  [24]={经验=141279680,繁荣=441482,人气=264899},
  [25]={经验=197791552,繁荣=618073,人气=370587},
  [26]={经验=276908173,繁荣=865302,人气=519199},
  [27]={经验=387671443,繁荣=1211424,人气=726880},
  [28]={经验=542740018,繁荣=1695993,人气=1017630},
}

帮派属性加成={
[1]={气血=50,魔法=25,命中=0,伤害=25,防御=0,速度=0,法伤=25,法防=0},
[2]={气血=100,魔法=50,命中=25,伤害=50,防御=25,速度=25,法伤=50,法防=25},
[3]={气血=200,魔法=100,命中=50,伤害=100,防御=50,速度=50,法伤=100,法防=50},
[4]={气血=300,魔法=200,命中=100,伤害=150,防御=100,速度=100,法伤=150,法防=100},
[5]={气血=400,魔法=300,命中=150,伤害=200,防御=150,速度=150,法伤=200,法防=150},
[6]={气血=500,魔法=400,命中=200,伤害=250,防御=200,速度=200,法伤=250,法防=200},
[7]={气血=600,魔法=500,命中=250,伤害=300,防御=250,速度=250,法伤=300,法防=250},
}



function 取人物修炼等级上限(等级)
    local 修炼上限 = math.floor((等级 - 20) / 5)
    if 修炼上限 < 0 then return 0 end
    if 修炼上限 > 30 then return 30 end
    return 修炼上限
end



function 取高级地煞星武器造型(角色)

  local 武器={}
  武器["剑侠客"]={武器="四法青云",级别=140}
  武器["逍遥生"]={武器="秋水人家",级别=140}
  武器["飞燕女"]={武器="九天金线",级别=140}
  武器["英女侠"]={武器="祖龙对剑",级别=140}
  武器["巫蛮儿"]={武器="紫金葫芦",级别=140}
  武器["狐美人"]={武器="游龙惊鸿",级别=140}
  武器["巨魔王"]={武器="护法灭魔",级别=140}
  武器["虎头怪"]={武器="元神禁锢",级别=140}
  武器["骨精灵"]={武器="九阴勾魂",级别=140}
  武器["杀破狼"]={武器="冥火薄天",级别=140}
  武器["舞天姬"]={武器="此最相思",级别=140}
  武器["玄彩娥"]={武器="青藤玉树",级别=140}
  武器["羽灵神"]={武器="庄周梦蝶",级别=140}
  武器["神天兵"]={武器="九瓣莲花",级别=140}
  武器["龙太子"]={武器="飞龙在天",级别=140}
  武器["鬼潇潇"]={武器="月影星痕",级别=140}
  武器["桃夭夭"]={武器="月露清愁",级别=140}
  武器["偃无师"]={武器="秋水澄流",级别=140}
  return 武器[角色]
end

function 取天罡星武器造型(角色)
  local 武器={}
  武器["剑侠客"]={武器="霜冷九州",级别=150}
  武器["逍遥生"]={武器="浩气长舒",级别=150}
  武器["飞燕女"]={武器="无关风月",级别=150}
  武器["英女侠"]={武器="紫电青霜",级别=150}
  武器["巫蛮儿"]={武器="云雷万里",级别=150}
  武器["狐美人"]={武器="牧云清歌",级别=150}
  武器["巨魔王"]={武器="业火三灾",级别=150}
  武器["虎头怪"]={武器="碧血干戚",级别=150}
  武器["骨精灵"]={武器="忘川三途",级别=150}
  武器["杀破狼"]={武器="九霄风雷",级别=150}
  武器["舞天姬"]={武器="揽月摘星",级别=150}
  武器["玄彩娥"]={武器="丝萝乔木",级别=150}
  武器["羽灵神"]={武器="碧海潮生",级别=150}
  武器["神天兵"]={武器="狂澜碎岳",级别=150}
  武器["龙太子"]={武器="天龙破城",级别=150}
  武器["鬼潇潇"]={武器="浮生归梦",级别=150}
  武器["桃夭夭"]={武器="夭桃秾李",级别=150}
  武器["偃无师"]={武器="百辟镇魂",级别=150}
  return 武器[角色]
end









function 野外掉落装备(id,地图等级)
  local 等级=math.floor(地图等级/10)
  if 等级>8 then 等级=8 end
  if 取随机数()<=5 then
      等级=取随机数(1,10)
      玩家数据[id].道具:给予暗器(id,等级)
  else
      玩家数据[id].道具:取随机装备(id,等级)
  end

end

function 野外掉落二级药(id,地图等级)
  local 等级=math.floor(地图等级/10)
  if 等级>4 then
    local 药品名称={"孔雀红","鹿茸","仙狐涎","地狱灵芝","六道轮回","凤凰尾","火凤之睛","龙之心屑","紫石英","白露为霜","熊胆","血色茶花","丁香水","麝香"}
    local 名称=药品名称[取随机数(1,#药品名称)]
    玩家数据[id].道具:给予道具(id,名称,1)
    常规提示(id,"#Y/你获得了"..名称)
  end
end

function 取乾元丹消耗(等级)
  local 需求经验=等级+1
  local 需求金钱=需求经验/2
  return {经验=需求经验*10000000,金钱=需求金钱*10000000}
end






function 读csv数据( str,reps )
    local resultStrList = {}
    string.gsub(str,'[^'..reps..']+',function ( w )
        table.insert(resultStrList,w)
    end)
    return resultStrList
end
--用于获取csv表
function 取csv数据(filePath)
    -- 读取文件
    local data = 读入文件(filePath);
    -- 按行划分
    local lineStr = 读csv数据(data, '\n\r');
    --第一行是分类 例如  名称 参数 关键字 价格
    local lm = {"仙玉商城","银子商城","法宝商城"}
    local titles = string.split(lineStr[2], ",");
    --tutlese
    local ID = 1
    local arrs = {}
    local gg = 1
    arrs[lm[gg]]={}
    local fillContent
    for i = 3, #lineStr, 1 do
        local content = string.split(lineStr[i], ",");
        if content[1] ==lm[gg+1] and arrs[lm[gg+1]] == nil then
          gg = gg +1
          arrs[lm[gg]] = {}
          ID = 0
        end
        if ID ~= 0 then
          arrs[lm[gg]][ID] = {}
        end
        for j = 1, #titles, 1 do
          if content[j] ~= nil and content[j] ~= "" and content[j] ~= "银子商城" and content[j] ~= "法宝商城" then
              arrs[lm[gg]][ID][titles[j]] = tonumber(content[j]) or content[j]
            end
        end
        ID = ID + 1
    end
    return arrs
end



function 开启首席争霸报名()
  -- 首席争霸报名开关=true
  -- local 门派名称={"大唐官府","神木林","方寸山","化生寺","女儿村","天宫","普陀山","五庄观","凌波城","龙宫","魔王寨","狮驼岭","盘丝洞","无底洞","阴曹地府"}
  -- for n=1,#门派名称 do
  --   if 首席争霸[门派名称[n]]~=nil and 首席争霸[门派名称[n]].id~=nil and 玩家数据[首席争霸[门派名称[n]].id] ~= nil then
  --     玩家数据[首席争霸[门派名称[n]].id].角色:批量删除称谓("首席大弟子")
  --     常规提示(首席争霸[门派名称[n]].id,"你的首席称谓已回收！！！")
  --   end
  -- end
  -- 发送公告("#G首席争霸赛报名已经开启，请需要参与比武大会的玩家找到#R首席争霸使者#G进行首席争霸赛报名！！！")
end

function 开启首席争霸进场()

  -- 首席争霸进场=true
  -- 首席争霸开启=os.time()
  -- 首席争霸报名开关=false
  -- 发送公告("#G首席争霸赛入场已经开启，请需要参与首席争霸赛的玩家找到#R首席争霸使者#G入场，首席争霸赛将于10分钟后正式开始！！！")
end

function 开启首席争霸()
  -- 首席争霸开关=true
  -- 首席争霸进场=false
  -- 地图处理类:重置首席争霸赛()
  -- 发送公告("#G首席争霸赛正式开始！！！")
end

function 结束首席争霸(类型,门派)
  -- -- table.print(首席争霸数据)
  -- -- 首席争霸开关=false
  -- if 类型==1 then  --- 开场的时候场景只剩下1人 此门派结束战斗
  --   if 首席争霸数据[门派]~=nil then
  --     for i,v in pairs(首席争霸数据[门派]) do
  --         if 玩家数据[i]~=nil and 玩家数据[i].角色.数据.首席报名 then
  --           玩家数据[i].角色.数据.首席报名=false
  --         end
  --         if 首席排名[门派]==nil then
  --           首席排名[门派]={}
  --         end
  --         首席争霸数据[门派][i].奖励=true
  --         首席排名[门派][#首席排名[门派]+1]=首席争霸数据[门派][i]
  --     end
  --     首席争霸数据[门派].统计 = true
  --     if #首席排名[门派]~=nil and #首席排名[门派]~=0 then
  --       table.sort(首席排名[门派], function (a,b) return a.积分 > b.积分 end)
  --       首席争霸[门派]=首席排名[门派][1]
  --       玩家数据[首席争霸[门派].id].角色:添加称谓(门派.."首席大弟子")
  --       常规提示(首席争霸[门派].id,"恭喜你，获得了#R"..门派.."首席大弟子#Y称谓！！！")
  --       地图处理类:跳转地图(首席争霸[门派].id,1001,364,36)
  --       地图处理类:删除单位(Q_首席弟子[门派].地图,1000)
  --       保存系统数据()
  --       任务处理类:加载首席单位()
  --     end
  --   end
  -- elseif 类型==2 then --结束所有
  --   首席争霸开关=false
  --   for k,v in pairs(首席争霸数据) do
  --     if v.统计==nil then
  --       for i,n in pairs(v) do
  --         if 玩家数据[i]~=nil and 玩家数据[i].角色.数据.首席报名 then
  --           玩家数据[i].角色.数据.首席报名=false
  --         end
  --         if 首席排名[k]==nil then
  --           首席排名[k]={}
  --         end
  --         首席争霸数据[k][i].奖励=true
  --         首席排名[k][#首席排名[k]+1]=首席争霸数据[k][i]
  --       end
  --       v.统计=true
  --       if #首席排名[k]~=nil and #首席排名[k]~=0 then
  --         table.sort(首席排名[k], function (a,b) return a.积分 > b.积分 end)
  --         首席争霸[k]=首席排名[k][1]
  --         玩家数据[首席争霸[k].id].角色:添加称谓(k.."首席大弟子")
  --         常规提示(首席争霸[k].id,"恭喜你，获得了#R"..k.."首席大弟子#Y称谓！！！")
  --         地图处理类:删除单位(Q_首席弟子[k].地图,1000)
  --       end
  --     end
  --   end
  --   地图处理类:清除地图玩家(6009,1001,313,85)
  --   保存系统数据()
  --   任务处理类:加载首席单位()
  --   发送公告("#G首席争霸赛已经结束，参与首席争霸赛的玩家可找到首席争霸使者领取参与奖励！！！")
  -- end
end

-- Q_首席弟子={
--  龙宫={地图=1116,方向=1,x=94,y=68}
-- ,女儿村={地图=1142,方向=0,x=35,y=34}
-- ,化生寺={地图=1002,方向=1,x=49,y=65}
-- ,大唐官府={地图=1198,方向=0,x=94,y=65}
-- ,普陀山={地图=1140,方向=0,x=22,y=21}
-- ,五庄观={地图=1146,方向=1,x=36,y=49}
-- ,盘丝洞={地图=1144,方向=1,x=24,y=48}
-- ,魔王寨={地图=1512,方向=0,x=99,y=23}
-- ,狮驼岭={地图=1131,方向=1,x=119,y=77}
-- ,天宫={地图=1111,方向=0,x=160,y=113}
-- ,方寸山={地图=1135,方向=1,x=67,y=66}
-- ,阴曹地府={地图=1122,方向=0,x=41,y=63}
-- ,凌波城={地图=1150,方向=0,x=34,y=68}
-- ,神木林={地图=1138,方向=0,x=50,y=106}
-- ,无底洞={地图=1139,方向=1,x=60,y=124}
-- ,九黎城 ={地图=2008,方向=0,x=48,y=16}
-- }




function 刷新队伍任务跟踪(任务id)
    if 任务数据[任务id] and 任务数据[任务id].队伍组 then
        for i=1,#任务数据[任务id].队伍组 do
            local id = 任务数据[任务id].队伍组[i]
            if 玩家数据[id] then
                玩家数据[id].角色:刷新任务跟踪()
            end
        end
    end
end

function 取消队伍任务(任务id,类型)
      if 任务数据[任务id] and 任务数据[任务id].队伍组 then
          for i=1,#任务数据[任务id].队伍组 do
              local id = 任务数据[任务id].队伍组[i]
              if 玩家数据[id] then
                玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(类型))
              end
          end
      end
end


取随机神兽={
  "超级神龙"
  ,"超级土地公公"
  ,"超级六耳猕猴"
  ,"超级神鸡"
  ,"超级玉兔"
  ,"超级神猴"
  ,"超级神马"
  ,"超级神羊"
  ,"超级孔雀"
  ,"超级灵狐"
  ,"超级筋斗云"
  ,"超级麒麟"
  ,"超级大鹏"
  ,"超级赤焰兽"
  ,"超级白泽"
  ,"超级灵鹿"
  ,"超级大象"
  ,"超级金猴"
  ,"超级大熊猫"
  ,"超级泡泡"
  ,"超级神兔"
  ,"超级神虎"
  ,"超级神牛"
  ,"超级海豚"
  ,"超级人参娃娃"
  ,"超级青鸾"
  ,"超级腾蛇"
  ,"超级神蛇"
}

function 取门派师傅名称(门派)
  if 门派=="大唐官府" then
    return "程咬金"
  elseif 门派=="化生寺" then
    return "空度禅师"
  elseif 门派=="女儿村" then
    return "孙婆婆"
  elseif 门派=="方寸山" then
    return "菩提祖师"
  elseif 门派=="神木林" then
    return "巫奎虎"
  elseif 门派=="龙宫" then
    return "东海龙王"
  elseif 门派=="天宫" then
    return "李靖"
  elseif 门派=="普陀山" then
    return "观音姐姐"
  elseif 门派=="五庄观" then
    return "镇元子"
  elseif 门派=="凌波城" then
    return "二郎神"
  elseif 门派=="狮驼岭" then
    return "大大王"
  elseif 门派=="魔王寨" then
    return "牛魔王"
  elseif 门派=="盘丝洞" then
    return "白晶晶"
  elseif 门派=="无底洞" then
    return "地涌夫人"
  elseif 门派=="阴曹地府" then
    return "地藏王"
  elseif 门派 == "九黎城" then
    return "刑天"

  end
end

function 判断是否为空表(t,类型)
  -- print(类型)
  return _G.next(t) == nil
end

function 取可佩带武器名称(模型,等级)
  local n={}
  local 子类 = 角色武器类型[模型]
  -- print(模型)
  --table.print(子类)
  local 佩戴 = 子类[取随机数(1,#子类)]
  local 序列 = 0
  if 等级<=99 then
    序列=9
  elseif 等级<=109 then
    序列=11
  elseif 等级<=119 then
    序列=12
  elseif 等级<=129 then
    序列=13
  elseif 等级<=139 then
    序列=14
  elseif 等级<=149 then
    序列=15
  elseif 等级<=159 then
    序列=16
  else
    序列=17
  end
  n[1] = {"红缨枪","曲尖枪","锯齿矛","乌金三叉戟","火焰枪","墨杆金钩","玄铁矛","金蛇信","丈八点钢矛","暗夜","梨花","梨花","刑天之逆","五虎断魂","飞龙在天","天龙破城","弑皇"}
  n[2] = {"青铜斧","开山斧","双面斧","双弦钺","精钢禅钺","黄金钺","乌金鬼头镰","狂魔镰","恶龙之齿","破魄","肃魂","无敌","五丁开山","元神禁锢","护法灭魔","碧血干戚","裂天"}
  n[3] = {"青铜短剑","铁齿剑","吴越剑","青锋剑","龙泉剑","黄金剑","游龙剑","北斗七星剑","碧玉剑","鱼肠","倚天","湛卢","魏武青虹","灵犀神剑","四法青云","霜冷九州","擒龙"}
  n[4] = {"双短剑","镔铁双剑","龙凤双剑","竹节双剑","狼牙双剑","鱼骨双剑","赤焰双剑","墨玉双剑","梅花双剑","阴阳","月光双剑","灵蛇","金龙双剪","连理双树","祖龙对剑","紫电青霜","浮犀"}
  n[5] = {"五色缎带","幻彩银纱","金丝彩带","无极丝","天蚕丝带","云龙绸带","七彩罗刹","缚神绫","九天仙绫","彩虹","流云","碧波","秋水落霞","晃金仙绳","此最相思","揽月摘星","九霄"}
  n[6] = {"铁爪","天狼爪","幽冥鬼爪","青龙牙","勾魂爪","玄冰刺","青刚刺","华光刺","龙鳞刺","撕天","毒牙","胭脂","九阴勾魂","雪蚕之刺","贵霜之牙","忘川三途","离钩"}
  n[7] = {"折扇","铁骨扇","精钢扇","铁面扇","百折扇","劈水扇","神火扇","阴风扇","风云雷电","太极","玉龙","秋风","画龙点睛","秋水人家","逍遥江湖","浩气长舒","星瀚"}
  n[8] = {"细木棒","金丝魔棒","玉如意","点金棒","云龙棒","幽路引魂","满天星","水晶棒","日月光华","沧海","红莲","盘龙","降魔玉杵","青藤玉树","墨玉骷髅","丝萝乔木","醍醐"}
  n[9] = {"松木锤","镔铁锤","八棱金瓜","狼牙锤","烈焰锤","破甲战锤","震天锤","巨灵神锤","天崩地裂","八卦","鬼牙","雷神","混元金锤","九瓣莲花","鬼王蚀日","狂澜碎岳","碎寂"}
  n[10] = {"牛皮鞭","牛筋鞭","乌龙鞭","钢结鞭","蛇骨鞭","玉竹金铃","青藤柳叶鞭","雷鸣嗜血鞭","混元金钩","龙筋","百花","吹雪","游龙惊鸿","仙人指路","血之刺藤","牧云清歌","霜陨"}
  n[11] = {"黄铜圈","精钢日月圈","离情环","金刺轮","风火圈","赤炎环","蛇形月","子母双月","斜月狼牙","如意","乾坤","月光双环","别情离恨","金玉双环","九天金线","无关风月","朝夕"}
  n[12] = {"柳叶刀","苗刀","夜魔弯刀","金背大砍刀","雁翅刀","破天宝刀","狼牙刀","龙鳞宝刀","黑炎魔刀","冷月","屠龙","血刃","偃月青龙","晓风残月","斩妖泣血","业火三灾","鸣鸿"}
  n[13] = {"曲柳杖","红木杖","白椴杖","墨铁拐","玄铁牛角杖","鹰眼法杖","腾云杖","引魂杖","碧玺杖","业焰","玉辉","鹿鸣","庄周梦蝶","凤翼流珠","雪蟒霜寒","碧海潮生","弦月"}
  n[14] = {"硬木弓","铁胆弓","紫檀弓","宝雕长弓","錾金宝弓","玉腰弯弓","连珠神弓","游鱼戏珠","灵犀望月","非攻","幽篁","百鬼","冥火薄天","龙鸣寒水","太极流光","九霄风雷","若木"}
  n[15] = {"琉璃珠","水晶珠","珍宝珠","翡翠珠","莲华珠","夜灵珠","如意宝珠","沧海明珠","无量玉璧","离火","飞星","月华","回风舞雪","紫金葫芦","裂云啸日","云雷万里","赤明"}
  n[16] = {"钝铁重剑","桃印铁刃","赭石巨剑","壁玉长铗","青铜古剑","金错巨刃","惊涛雪","醉浮生","沉戟天戊","鸦九","昆吾","弦歌","墨骨枯麟","腾蛇郁刃","秋水澄流","百辟镇魂","长息"}
  n[17] = {"油纸伞","红罗伞","紫竹伞","锦绣椎","幽兰帐","琳琅盖","孔雀羽","金刚伞","落梅伞","鬼骨","云梦","枕霞","碧火琉璃","雪羽穿云","月影星痕","浮生归梦","晴雪"}
  n[18] = {"素纸灯","竹骨灯","红灯笼","鲤鱼灯","芙蓉花灯","如意宫灯","玲珑盏","玉兔盏","冰心盏","蟠龙","云鹤","风荷","金风玉露","凰火燎原","月露清愁","夭桃秾李","荒尘"}
  return {n[佩戴][序列],(序列-1)*10}
end


function 取可佩带武器名称1(模型,等级)
  local n={}
  local 子类 = 角色武器类型[模型]
  -- print(模型)
  --table.print(子类)
  local 佩戴 = 子类[取随机数(1,#子类)]
  local 序列 = 0
  local 奖励参数=取随机数(1,30)
  if 等级<=175 then
    if 奖励参数<=10 then
    序列=13
    elseif 奖励参数<=20 then
      序列=14
     elseif 奖励参数<=30 then
      序列=15
     end
   end
  n[1] = {"红缨枪","曲尖枪","锯齿矛","乌金三叉戟","火焰枪","墨杆金钩","玄铁矛","金蛇信","丈八点钢矛","暗夜","梨花","梨花","刑天之逆","五虎断魂","飞龙在天","天龙破城","弑皇"}
  n[2] = {"青铜斧","开山斧","双面斧","双弦钺","精钢禅钺","黄金钺","乌金鬼头镰","狂魔镰","恶龙之齿","破魄","肃魂","无敌","五丁开山","元神禁锢","护法灭魔","碧血干戚","裂天"}
  n[3] = {"青铜短剑","铁齿剑","吴越剑","青锋剑","龙泉剑","黄金剑","游龙剑","北斗七星剑","碧玉剑","鱼肠","倚天","湛卢","魏武青虹","灵犀神剑","四法青云","霜冷九州","擒龙"}
  n[4] = {"双短剑","镔铁双剑","龙凤双剑","竹节双剑","狼牙双剑","鱼骨双剑","赤焰双剑","墨玉双剑","梅花双剑","阴阳","月光双剑","灵蛇","金龙双剪","连理双树","祖龙对剑","紫电青霜","浮犀"}
  n[5] = {"五色缎带","幻彩银纱","金丝彩带","无极丝","天蚕丝带","云龙绸带","七彩罗刹","缚神绫","九天仙绫","彩虹","流云","碧波","秋水落霞","晃金仙绳","此最相思","揽月摘星","九霄"}
  n[6] = {"铁爪","天狼爪","幽冥鬼爪","青龙牙","勾魂爪","玄冰刺","青刚刺","华光刺","龙鳞刺","撕天","毒牙","胭脂","九阴勾魂","雪蚕之刺","贵霜之牙","忘川三途","离钩"}
  n[7] = {"折扇","铁骨扇","精钢扇","铁面扇","百折扇","劈水扇","神火扇","阴风扇","风云雷电","太极","玉龙","秋风","画龙点睛","秋水人家","逍遥江湖","浩气长舒","星瀚"}
  n[8] = {"细木棒","金丝魔棒","玉如意","点金棒","云龙棒","幽路引魂","满天星","水晶棒","日月光华","沧海","红莲","盘龙","降魔玉杵","青藤玉树","墨玉骷髅","丝萝乔木","醍醐"}
  n[9] = {"松木锤","镔铁锤","八棱金瓜","狼牙锤","烈焰锤","破甲战锤","震天锤","巨灵神锤","天崩地裂","八卦","鬼牙","雷神","混元金锤","九瓣莲花","鬼王蚀日","狂澜碎岳","碎寂"}
  n[10] = {"牛皮鞭","牛筋鞭","乌龙鞭","钢结鞭","蛇骨鞭","玉竹金铃","青藤柳叶鞭","雷鸣嗜血鞭","混元金钩","龙筋","百花","吹雪","游龙惊鸿","仙人指路","血之刺藤","牧云清歌","霜陨"}
  n[11] = {"黄铜圈","精钢日月圈","离情环","金刺轮","风火圈","赤炎环","蛇形月","子母双月","斜月狼牙","如意","乾坤","月光双环","别情离恨","金玉双环","九天金线","无关风月","朝夕"}
  n[12] = {"柳叶刀","苗刀","夜魔弯刀","金背大砍刀","雁翅刀","破天宝刀","狼牙刀","龙鳞宝刀","黑炎魔刀","冷月","屠龙","血刃","偃月青龙","晓风残月","斩妖泣血","业火三灾","鸣鸿"}
  n[13] = {"曲柳杖","红木杖","白椴杖","墨铁拐","玄铁牛角杖","鹰眼法杖","腾云杖","引魂杖","碧玺杖","业焰","玉辉","鹿鸣","庄周梦蝶","凤翼流珠","雪蟒霜寒","碧海潮生","弦月"}
  n[14] = {"硬木弓","铁胆弓","紫檀弓","宝雕长弓","錾金宝弓","玉腰弯弓","连珠神弓","游鱼戏珠","灵犀望月","非攻","幽篁","百鬼","冥火薄天","龙鸣寒水","太极流光","九霄风雷","若木"}
  n[15] = {"琉璃珠","水晶珠","珍宝珠","翡翠珠","莲华珠","夜灵珠","如意宝珠","沧海明珠","无量玉璧","离火","飞星","月华","回风舞雪","紫金葫芦","裂云啸日","云雷万里","赤明"}
  n[16] = {"钝铁重剑","桃印铁刃","赭石巨剑","壁玉长铗","青铜古剑","金错巨刃","惊涛雪","醉浮生","沉戟天戊","鸦九","昆吾","弦歌","墨骨枯麟","腾蛇郁刃","秋水澄流","百辟镇魂","长息"}
  n[17] = {"油纸伞","红罗伞","紫竹伞","锦绣椎","幽兰帐","琳琅盖","孔雀羽","金刚伞","落梅伞","鬼骨","云梦","枕霞","碧火琉璃","雪羽穿云","月影星痕","浮生归梦","晴雪"}
  n[18] = {"素纸灯","竹骨灯","红灯笼","鲤鱼灯","芙蓉花灯","如意宫灯","玲珑盏","玉兔盏","冰心盏","蟠龙","云鹤","风荷","金风玉露","凰火燎原","月露清愁","夭桃秾李","荒尘"}
  return {n[佩戴][序列],(序列-1)*10}
end

function 取剑会天下数据(id)
  if 剑会天下[id]==nil then
    剑会天下[id]={当前积分=1200,连胜=0,名称=玩家数据[id].角色.名称,等级=玩家数据[id].角色.等级,id=id,门派=玩家数据[id].角色.门派}
  end
end

function 取随机中文姓名(num)
  local 字库 = "闻霁充娅思邸硕司马凝远哀元绿端元瑶褚曜灿堂涵忍摘大郝奥翦含莲罗小瑜查冷雪乐正玉琲田正平钟之玉赵斯令狐昆明檄春燕范振海夙元龙赫嘉玉子车舒兰蛮谧登谷雪夔毅秋锁鸿媳赖温瑜折靖之集晓曼甲文思妫巧凡酒擅邗雁卉帛小蕊左春兰节书双应卿陶骏中望舒驹建修禚又儿似修远百令雪占嘉悦谢刚毅银青梦苏波涛鲍慕诗敖弘伟贯语儿姬寄波澄正信蒉鹤梦琦银河鞠春祁秋翠开智渊东郭雅素闵妮子辟雨雪勾红螺张廖元勋隐弘量晋紫雪洛冰慎贤淑嬴天音续之桃唐涵意招正平归梦云束新苗喜逸明史语林后同光青安青接凝芙洋庄雅位英范危芳茵及谷槐郗访曼逯雨珍信昊苍慕驰月诸白萱臧彤彤畅阳曦仉傲雪守易云运思彤漆雕韫玉空歌闪梦菡赫连翰采督代珊姓蕾宝洛妃建诗霜米海菡颛孙瀚昂贲仕壬雅云禽文康后漾漾藩驰丽卿瑜江欣悦杞傲冬阿含之卢雅丹悟远碧如波糜雨信南家欣窦冬卉贝启颜水子美辉高兴喻荷紫黎和通辛问萍纳本眭晗日滕月天赏鹏涛历乃丰家伍心曾沙摩凌兰熊昭昭出文景康卫睢痴凝闾清润修骊英莫向晨愧采萱九驰不听然稽安珊库燕妮伯巧夏营欢问音愚晶灵亓官馨欣竹晓蕾拓跋琨瑜盖问萍阎捷揭元槐纵兴运斐闲丽舜赐迟欣崇书萱宗政夜蓉丁易梦宇梦香郁静柏戏飞薇裔音韵云彩萱牵芊候一嘉求慕悦贰馨香伊白云淳于春英亢三载半兰能清逸蒲千亦检夜梅李寄瑶余盼翠张简琨燕佩杉端木诗珊万心菱台浩宕恽平婉终阳阳岳藏栾鸿飞巴云飞狂新梅郏凌兰衷平母子芸卜静舷萨任真太史天薇蹉宛妙房飞文宋乐游边佩蓟天罡纳喇和裕贵立人呼延素昕薛明熙考飒理丹烟封静慧线叡费慕山谷蔓官梦华谌初夏成芦冠英韶饶颖初枚浩波全从筠风闲公新蕾春山兰拱晨欣宇文思萱鹿寒天邢清涵牧心语双寒介平心抄幼荷图门沛首堂却强严景澄绍曦之纪德昌剧沛容和新筠奕白卉翠问兰校以丹禹骏英强靓影沙银弭海颖告博简段干庄葛雨真支怜双褒静枫巫慕思屠建柏汝燕珺缪斯雅松秋英刚星河勤昆峰宛宜阮凡雁楼和洽卯友安善宏阔裘鸿彩柳乐章华倩秀说暮芸长秋玉师飞兰蔺以彤宿曼寒凭雨伯山幼仪钞怀玉汉华晖幸宏大广洋洋树隽美进乐容芒倚本天巧隽文光完颜亦凝乔冷萱用晴虹温芦雪夏侯飞昂书映秋马佳云逸英听芹辜厚荆书艺亓若淑芮惠然羊英苌明珠穰西生雨石但梓璐岑睿范完湘所代梅清翰学答陶秘以彤融菡梅蒋曼凡帖雅彤向绮梅恭昶良语燕豆涤咎凝罕幼柏聊敏达愈曼岚波晴照那拉翠芙桥映冬倪柔妙夏空牢元绿蒯春晓皮迎丝拜烨华红吉玉马惠君敛半香那含巧陀嘉祥骑访文禾润魏向秋桑驰海卯阳旭邬凌春福听安连醉波原浩然扶施诗邵靖颜寻双车子蕙垄醉巧第悟蓬白曼律楚庞颖秀势文惠仝安宜谈晶滢满梦竹瞿丝劳乐然元浩气有浩淼司徒嘉致玉颖颖竭袖公冶兰英让森丽蹇清淑泉思美佴昊东潘鹏池宓霞雰浦桂芝同斯伯种向晨厚娜周舟邛采绿前香桃祢春梳溥云亭绪水彤兆阳蓉秦腾逸舒魄羽家美令和硕永慕蕊由亦梅仇依辰柏甜恬仲孙俊捷功映秋笪昕昕麦平萱化清绮酆易容尹姗寿山芙段证百里浩岚碧鲁清怡仁俊爽花香莲太叔欣悦冉山蝶呼晗玥少骊蓉司嘉议轩援又青宾若骞鄂永贞邰新知谷梁又槐公西学义业绿蕊肥荌牛含香仪智勇尤噬汪伟志甫紫云奚觅风于家美栗庆音童半雪野翰藻丑礼骞路半青肇同方漆暖梦世幼枫峪景龙硕寄松弥丹萱箕岚风谯志行朱玉树费莫阳晖象翠茵东方震繁梓云公良凌蝶綦凡灵资夏旋潜高义冀香旋伺醉柳祈海白焉文斌俎赞乌雅丽华植乐双犹诗桃乌孙弘壮勇婷婷力三姗夷阳舒大凌春毓敏智普巍然包文昌希之仆鸿运宣用才唁红泥俨虞璞性元正甄水风卑耘豪蔡清雅尉初雪曲琛雍经业高知荀涵涤吉通随思远苗凝海诺纯战承安夹谷霞梳左丘南琴称之卉瑞古代唱月兴香岚佼兴德茹昊硕杨谷之侯沛槐况瑜英军丹寒蓉希慕慕容涵蕾貊凯唱养福濯茂学郦彰明朗丽刘阳火骆轩秀智春柏石浩广泰嘉平虢芝兰鄢秋寒市饮月镇寒梦易鹏飞鲜安楚易真卫瑛瑶齐博涛函秀竹茂楠楠謇济彤玛丽屈丹山顿复孟又菡利廷剑作人度暄莹危元嘉庚雅琴之虹彩门念双虎朝池灵珊望和同延映寒廖博瀚娄钰诸葛茂唁布幻天文晓枫笃凝珍东门兴昌闳虹颖奈碧春俟楠乙音华达灵安威夏月公羊羡寻才捷棺玉轩蒙溪隋琪睿柯宜然以惜芹刀晴曦汗健尉迟雅琴皇甲钱豫暴雨莲时秋露北访冬速盼易樊思怡缑哲思斛熙星伦建武鸿达宦惜香寇代巧上官半凡竺赫尔夜雪改清懿通从凝源雨琴焦晴波析芳茵穆梳美麴依白郁旻骞巩宁税谷槐祝鸿卓始淳静井映雪籍辰皓钮白梅保若芳睦初蝶昔虹雨章佳浚乐嘉熙佘令锋肖运洁励阳曜京英豪郸元甲吴雅美于夏菡詹依秋阴绍辉雪春雪管骊霞闫晖素婉静奇笛韵僪问柳捷瑛承英才刁采白郑惜玉城澍钭若翠买任习春翠椅灵雨施叶春侨采苟绿海耿萄萄毕秋华檀程单于凌丝犁新儿璩嘉树鲁建安区巧荷老颜骏初倩鱼南琴惠蕴和枝丽泽士运菱佛靖儿欧梦露祖晶滢盈修文扬玲逄伦六湘君顾博雅塔尚庹尔阳昌水之摇碧琴莘浩涆伟佁然微生玥逮愉东望雅沃爵殳欣悦陆半脱向卉在驰媛丙莱言思义侍涵蕾朴宇邴慧颖敬迎南冯兴盛丹秋仰寅果迎曼次芃孙明凝多月灵廉怿昂丹彤公孙问凝霜为郎翊君紫冷之歧彤可念烟千依云索友灵庾瑜然漫友安镜涵菱蔚怜烟申高峰丛庄静实问薇薄简藏梅梅范姜锐意蓝豪纤情文森易天寄灵雀和昶刑洋公叔慈农嘉良靳向南嘉艳蕊疏玑单雪羽哈高格字静安嵇凯旋都苑项映寒乾芳荃牟云水矫昊宇渠奕俞水洪腾骏澹台书兰巫马南晴潭陶然行俊艾匡雅韵淦志明琴元青家甘盍念珍孝弘大雷丰茂亥绮烟益河灵真胤运司寇梦桃宁茵禄萦党明德荤羡丽敏怿梅思美聂德运局涵韵宫柔蔓游乐邝怀梦干鸣革德华黄从蕾戴卓然曹昊天腾经零惜儿湛骊颖香含云阳子帆胡吉星藤晓曼国德厉丝柳别俊晤皋荷止曼蔓卷骄无念梦环嘉珍钟离飞语晁安萱仵平绿声宏硕麻初彤戢清漪寸方凤素昕吕华翰频琴贾凌覃采梦苑雅逸操又夏浑柔惠章运诚诗文君乌以蕊礼鸿才慈听枫错惜狄溥心韶博裕独湛芳戊曜曦柔存郯迎真居扬僧羲过琛丽锐惠心须卿月堵曼衍展香萱其和悌昝修雅班和雅冒诗蕊崔雅素仍采南旗曼冬墨毅梅磨雯华圣冬梅潭觅露纵智系玉瑾尾修永相半双典琅翁韵萧和悌兰妙芙赤勇毅何浩慨杜胤富察丽文王谷菱示坚壁赛醉柳梁丘阳兰依安翔允曼寒沉秀雅邓端敏么梓馨浮安易龚芸若彭雄掌秀媚己伶俐请南霜暨芝戚飞光第五凝莲步夏瑶星元基郜傲之祭瑞芝储海超抗畅然念慧秀钊香梅忻笛濮阳春华练毅文户和美铣小夏粟晓曼栋听枫壤驷访文毋舒兰隆迎丝是南露留严和林紫雪权涵煦戎智敏涂若云方尔柳季以柳逢凝安侍阳煦夕涵育将芳馨乘友槐白雪曼袁半芹茅夜玉经禹巢春柔邶逸思厍鸿哲晏灵卉莱广符天蓝宜永嘉绳昕解弼宏宜修龙文德吾秀美卞振国戈冰冰谬梓露信凝绿赧晓山南门浦泽孛鸿祯裴心语陈证琪类昊然朋尾府运珹帅寻云道虹影贸驰逸程幻巧学醉柳秋觅柔针启寒秋珊怀玉龙闽星爵塞艳卉殷曼容甘紫萱尚新美淡秀妮席飞双斯丽窃碧灵衣灵波潮冰真丘春海汤语彤从谷翠叶素欣光晴曦伏湉湉印从霜傅彩严许迎天佟佳壮羿海凡徐语蓉偶乐松越凌晓柴妙晴衡中旁学民古芳商芸芸阙沛白锺离从蓉盘婉柔欧阳晨辰杭初之平云蔚飞雅静濮云金乐巧冷春雪宰永宁靖光耀迮昭君爱若雁卓高达乜语梦闭小翠休娟严合全夫怡悦万俟书琴德欣然贺念云苍笑柳粘证蝶长孙半兰姜天和鄞孤萍简晋鹏铁毅远董沛凝司空清韵贡志文来暄和桓凡桃宗梦寒悉丽梳阚弘济叔自霍怀曼汲平卉撒白秋旅依琴仙依心翟乐天宰父幼荷郭国源常浦泽翁语弓红叶委依云梁新雅张筠溪安嘉祯苦子珍闾丘俊美沐幼霜义子骞皇甫谷玉遇儿五又松南宫涵映孔平卉锺昊空计翰飞申屠阔定白凝谏允晨凌田絮沛白员雅柔訾慕凝表元凯巨书萱机景明桐醉蝶艾锐锋关渺仲子萱丹正卿奉浩思任暄闻人曼梅蒿皓月景芮丽富宜庄艳芳务蕙兰法景明扈紫丝玄宛曼鲜于岑巧善和滑安和铎珠轩海同韩飞雪召宇烟昊天桂绮晴容惜灵年芬芬邱芳蔼徭佳惠西门思莹佟白翠姚远骞旷天骄毛青友芝宇坚建元板松月泣乐蕊羊舌新洁圭湘云弘以蕊受霞文回兴贤忻证烟寒辰龙错远悦郏怜雪本羡丽巫俊民虢辰钊陶绮波危兴请从鹏云书湘云师朗权华美侯翠梅謇惠君濮采萱繁素昕公西暮芸令紫南欧阳悦媛皇甫珍丽段干冠宇僧梳全苗边萦心揭翰采辛嘉禾睦碧螺阿静粟凡白梁光熙昂玄静钮小蕊锺离易绿碧向槐抗宏壮戊依白羽小蕾莘宏博单迎南逄高兴古新林战灵槐萨曦悟梓珊孛晓星请宛卓芊芊中宜嘉字蓓蕾喻清芬焦书云劳彤犁英睿光暖聂以蕊钟离芸芸锐凌香真寒梅郁龙皇香天乌雅烨磊郜阳司空翠岚九山菡皮静秀嵇昭懿薛雨泽伍瑞渊单于梦露纪润亓绮玉区经亘甫冷萱藏妙晴练志学宗萄貊伟兆罗绿凝秘康成左丘婉丽邝小星乜乐安谷梁梦桐覃春柏恽耘涛傅贤淑伺光辉谈星驰载易巧理陶宁革涵涵在梓萱伊奇文独寒香合静婉苦安国枚涵阳越含说艳丽阮月悦函安娜郸飞跃赫连俊雅诗婉静善运凯应惜筠环君浩翠白竹矫文昌窃冬梅丹思雅武菡操毅君富润丽姜清婉斛雅容仰琬义弘光詹志行庾方方晁英华班雅韵慕鸿祯干若纳宏峻铎湛英铣雅宁褒浦和乔毅秋东方香洁喜怡和于千山养雅容车珠玉荆证若茹胜撒晨轩富察静雅东郭刚毅解夏寒袁芙受承安禾盼丹孝凡儿鄂冰安蹉秉漆雕香波宇文楚天长星强毅灵须秋芸通宛丝蒯顺慈同若英戎成侍山槐郭雅惠夕怀山封谷尤山雁示俊力阴暄美桥元菱斯鸿信瞿沛雯拓跋采枫翦雪兰庄雅舷都毅安潭秀雅类淑华蛮冰表晓彤似香卉节丽华汪问风燕苑杰法鸿远苟天韵纵高朗罕云溪机梦琪倪思义帛诗翠伦迎夏丁巧云宇文曜晏天真甘高原代绮云圣以晴沉绿兰巢桂华第运鹏贝智辰垄思博空振锐顾月杉玉骊萍陀昭祝灵松威韶翁静枫楚秀颖家婷美辟和煦奚广君毛莞然宗政笑严阎向雪姚雍雅哈尔阳申语蕊尉冰双佴新翰钞问梅厍依柔委和正多堂庚又柔纤绿竹元蔓儿资妙音亓官静芙尚运珹钭证文随宏义白浩阔犹安安邛宏爽施尔槐驹姗姗贺代梅逮浩然栗景彰仙和悦峪雅艳支语丝波绿蕊候国兴章钧接凌青上官雅艳祭依美云严严伟新月贸凡灵酒霈周夏柳笪妙芙叔鸿云以乐家玄春华刀梓柔昔毅梅象寒烟念冷荷端华晖郁泽雨蓟阳兰百里以晴路宜欣闳蕴秀公冶昌勋甄兴德曹采文暨小春严本林曲静锁冷雪硕和洽司徒白秋桑巧春董元忠巴和玉乙远航前含秀竭雄禚醉芙涂艳芳唐夏柳金如曼青年茅翠阳虎微澜范姜雅达卿清怡彤心香闾尔柳京素昕邓丹丹敏天青励星华巧悦爱壤驷流如慎安祯端木凝芙薄齐心蓝念文士灵慧延鸿晖宏韵磬雪丽芳堵馨欣麻智敏北蔼贾乐成嘉玲珑廖曼珠种文敏毕诗珊石慕卉江山蝶仲绮玉旁安荷佟佳金玉让慧婕旷谷兰松悦宜考幼怡卢扬滕佩杉军觅双藤正平侨晴岚刚平良危凝静孙宏阔戚魁将沛凝郑良骏始今敖雅安宿恬畅潜初雪是陶然晋瑶岑睢静竹衷寒梅银琪告景福宣若云化曼冬惠曼婉眭亦褚毅南稽夏瑶呼延姣严张简新知温水丹植永昌红毅彤闵灵波公宏貌向平宁隽代双赛筱贲星文花念念摘景明钟子珍仝谷蕊寿雨琴捷起壬昊昊东门山雁赤沛春储腾骏枝慧月毓觅晴哀宁徐梦之湛苒苒卫慧牛迎南亥忻欢熊英叡过优悠问允建乐圣郎安娜万俟飞翔买秀隽梁丘振宇徭云飞有荷珠速浚伯冰海愚慧君英静竹俞幻玉琦米冀元行访烟凤阳夏泥寄柔敬凝竹王博擅公叔兰英赏婉娜闾丘星火藩初柳佘靖巧庞靖易辉元冬充晓莉老流乌皓轩刘雅辰城韵诗鄞学名才绿旋频代秋树巧夏卯宇臧奇伟弘阳炎畅书文改危杨夜蓉沙念桃厚灵溪令狐双玉修琰淳于毅霜户中闽溶溶赵浦势小蕊鲍香雪佟南琴芮玉成凭浩渺姬桂诸葛如馨澹台正德尹笑容冉才俊尔梓敏辜臻五穰仵夜梅逯冰凡高锦欣盘君丽典懿勤云逸僪莹洁耿鹤骞况华池杞哲圣赖欣畅利博学张晶滢程冬灵池志泽汤绮南刑白安竹听安丙盼旋门怿逢迎梅信悠素鲜雁露杜项明展元旋麦水荷吴元彤塔高貌掌沛白万幼旋实丽文长孙其雨板涵韵亢飇丑利谢瀚海鄢毅成林楠普芳茵剧心宜声伟唁溥洁玉析宵雨吾高旻华之桃梅岑招寅骏靖衍易向卉司寇悦项莺莺务赞莱梓琬腾向阳贰姿夷旭炎鲜于齐濯蕴涵常寄春蒙淳美岳梦寒蒲志用蒿春翠迮秀穆听所舞苍初阳用清润管赫别小凝力晖扈义桂半梅赧蕴和烟天骄后雅蕊春芮佳伏和悌文南栾映雪仁凌春清青柏疏清俊麴傲薇帖慕山融玉泉祈思语旗令羽冷文滨茂泰华桐逸秀盛朔谯烨烨厉和平巩阳禽飞柏连胤文许觅丹夔芳洲保梅风位红雪泣凡桃召惜珊宋晨辰裴傲云谏伟祺祢英卫祁飞捷脱佳文奇青香尾白山暴晤市翰飞缑浩广容证雪休承教登松南门博雅求思菱段唁杉妫听筠宦彤霞方思烟卞掣楼慕蕊邱明旭么依白国宛秋赫恩霈淦子楠阙秀越那拉清华乐正寻梅粘光启聊依琴艾意智允欣美饶心箕清馨庹含桃奉宏恺律翰初田田陈雁风检子石微生致远叶又绿零羽霜古兰贯证文绪锦诗翟平凡季永思羿慈心凌曼彤印歌阑寇钰洪慕凝阳紫文年易梦南馨香守弘新崔隽洁鞠全巫马诗柳张廖皓月费乐邦次萍韵答梦秋达娟闻人嘉佑香毅秋棺幻玉谷忻慕匡茜双琴雪邶雪儿己茗弓昊磊苗书雁智听南呼阳飇敛恨桃焉谷槐蔺静云戏惜珊綦绮美系博文漫雅韶第五沛凝剑冰枫望语雪佼夏雪隐访波依清漪乌孙怀魏永丰肖展景古香斐壤巨煜游烨然丘迎彤党璞称宕舒问凝殷凡灵虞玲折蒙黎斯乔秦季雅完晓习绮兰功向秋朱鹤源娜娜束端敏马鹏举相华灿澄柔丽屠秀媛不丁进吟柔阳朔宰父可可舜雪曼邗尔阳司天工洛智宇碧鲁昕昕盍景龙堂子民步宣朗冠家骏占刚捷莫尔蓉章佳桃雨席琪睿羊睿好隋千叶汝莹华浑雅逸曾化籍馨兰闭问萍甲英朗柳奇水镜晨萱母谧辰友莺语李振博韶丹蝶祖雪卉史白云谬之岑舒昌紫萱笃元容蓬恨真羊舌暄莹浦竹雨荀胤水兴邦竺绮琴由志诚盖白飞惜寒俎天玉康欢欣来元武狂冬灵大新文桓芸若扶纳禹亦竹夹谷野雪任羲鱼毅雪朋蕴美台甘潘雅丹遇宏放太史晴波朴飞掣钊俊智仇晓凡符蔚然吕谨度卿云卜依凝益绿柏闫玉书星笑南韩冰洁圭采萱商芳蕤龙雅丽宓鸿运海静枫柯正文宁游彭书白漆代桃布建白檄维诸欣愉糜朋兴苑丽君历材于韶华檀茵却秋寒禄温文明洛灵拜寒凝完颜沙羽言怡畅房作幸建木介鸿振礼鸿朗希采梦汗恬时芳荃曲尔蝶卑荡蔡清逸鲁雅彤邢俊茂肇晓闻一嘉雀溥心宰健和忻然窦依薇兆芳茵靳兴贤愈冬萱卷念巧翁雅宁迟雅逸针卿月颛孙曜坤局春岚仍飞飙闪品诺清绮泉皓廉才英摇新美乐幼珊咎玉树勾坚白霍驰海包水冬之松崇清涵坚茹云豆觅珍骆巍然戈谷芹居秀兰郗盼晴汲半蕾良以宫暄文戴司辰弥可佳陆绿夏郦启绍畴璩冷松夏侯高岑承坚诚世坚秉绳妙芙蹇正思司马元良悉媛汉之卉欧唁君絮从筠柏绮彤官清淑沃凝心塞鹤梦酆书兰邴琨瑜栋飞双秋英华南宫心菱蒋之槐蒉清卓嬴昊天衡惜筠贵良奥其雪羽风方雅永怜烟线虹星缪格格邵念巧宾气生涵柳磨嘉良抄青梦殳晏然首梅花定怡然续聪慧山骊茹侍灵波纵善静镇尔风锺修洁阚代灵米伶伶安人公良畅畅公羊秀越千琳冒书兰丛半兰芒沛柔仪凝芙计芳林苏正平贡央田鸿博集博无雨歧涵忍仉危井鸿煊关歌阑爱晶辉何舒畅钱永新宜茂才索月渠依萱怀文止高驰盈澍雷霞梳墨学林森思云胡梦蕊刁驰颖愧飞翰百曼衍琴建柏葛晶辉骑云岚寻飞羽野蒙雨顿清淑铁玉韵督蝶梦颜弘济德恨之运天睿开仙仪姓芮帅子真滑毅南留高明范君昊信银柳仆元枫六昂杰龚颖馨出君雅乾逸丽经秋双弭莉莉戢玮琪勇一南图门静槐平若骞旅慕雁偶珠佩果冰之郯依珊夏自珍裘慧语宛飞薇能辰危苌甜恬简菀西门向晨衣和硕佛雪松童良翰长静柏尉迟友易归超子车朝雨邰夏兰恭代蓝回雁菱娄听云牵晗摩婵娟及鹏鲸齐语柔道毅然原卓逸鹿言文广吹屈歆然紫端邬平灵素霞月雍小珍穰怜晴兴素欣员仪文"
  local 字数 = string.len(字库)/2
  local 昵称 = ""
  for i=1,num do
    local 随机文字 = math.random(2,字数)*2
    昵称=昵称..string.sub(字库,随机文字-1,随机文字)
  end
  return 昵称
end

--修正飞蛾丢失的函数 start




function 取宝宝(bb)
  local bbs = {}
  if bb=="超级大熊猫" then
    bbs[1] = 0
    bbs[2] = 1400 --攻资
    bbs[3] = 1400 --防资
    bbs[4] = 3800 --体资
    bbs[5] = 2200 --法资
    bbs[6] = 1350 --速资
    bbs[7] = 1300 --躲闪
    bbs[8] = {1.15,1.15,1.15,1.15,1.15}--1.7
    if 取随机数()<=50 then
        bbs[9] = {"奔雷咒","高级法术连击","高级魔之心","高级龙魂","高级法术波动"}
    else
         bbs[9] = {"剑荡四方","高级偷袭","高级幸运","高级必杀","高级驱鬼"}
    end
  elseif bb == "老虎" then
    bbs[1] = 15
    bbs[2] = 1080
    bbs[3] = 1140
    bbs[4] = 2520
    bbs[5] = 1800
    bbs[6] = 1500
    bbs[7] = 1500
    bbs[8] = {1.058,1.069,1.08,1.09,1.101}
    bbs[9] = {"连击","驱鬼","幸运","强力"}
  elseif bb == "白熊" then
    bbs[1] = 45
    bbs[2] = 1320
    bbs[3] = 1320
    bbs[4] = 3280
    bbs[5] = 1800
    bbs[6] = 960
    bbs[7] = 1380
    bbs[8] = {1.097,1.108,1.12,1.131,1.142}
    bbs[9] = {"迟钝","强力","防御","高级反击","高级必杀"}
  elseif bb == "虾兵" then
    bbs[1] = 25
    bbs[2] = 1200
    bbs[3] = 1380
    bbs[4] = 2800
    bbs[5] = 2400
    bbs[6] = 1080
    bbs[7] = 1140
    bbs[8] = {1.014,1.024,1.035,1.045,1.055}
    bbs[9] = {"高级反击","高级必杀","驱鬼","水属性吸收"}
  elseif bb == "狼" then
    bbs[1] = 25
    bbs[2] = 1440
    bbs[3] = 960
    bbs[4] = 2600
    bbs[5] = 1200
    bbs[6] = 1500
    bbs[7] = 1500
    bbs[8] = {1.014,1.024,1.035,1.045,1.055}
    bbs[9] = {"连击","夜战","偷袭","驱鬼","高级连击"}
  elseif bb == "进阶鬼将" then
    bbs[1] = 0
    bbs[2] = 1660
    bbs[3] = 1313
    bbs[4] = 3514
    bbs[5] = 1525
    bbs[6] = 1432
    bbs[7] = 1251
    bbs[8] = {1.21,1.24,1.26,1.28,1.3}
    bbs[9] = {"高级必杀","高级连击","吸血","高级偷袭","高级反震","嗜血追击","高级驱鬼"}
  elseif bb == "噬天虎" then
    bbs[1] = 125
    bbs[2] = 1500
    bbs[3] = 1440
    bbs[4] = 3800
    bbs[5] = 2400
    bbs[6] = 1500
    bbs[7] = 1600
    bbs[8] = {1.215,1.227,1.24,1.252,1.264}
    bbs[9] = {"高级连击","驱鬼","幸运","高级强力"}
  elseif bb == "雨师" then
    bbs[1] = 65
    bbs[2] = 1200
    bbs[3] = 1380
    bbs[4] = 3200
    bbs[5] = 3424
    bbs[6] = 1440
    bbs[7] = 1618
    bbs[8] = {1.156,1.168,1.18,1.191,1.203}
    bbs[9] = {"水攻","烈火","高级雷属性吸收","高级水属性吸收","高级土属性吸收","高级火属性吸收"}
  elseif bb == "牛头" then
    bbs[1] = 35
    bbs[2] = 1320
    bbs[3] = 1320
    bbs[4] = 2600
    bbs[5] = 1800
    bbs[6] = 1400
    bbs[7] = 1200
    bbs[8] = {1.058,1.069,1.08,1.09,1.101}
    bbs[9] = {"驱鬼","高级必杀","招架","高级鬼魂术"}
  elseif bb == "骷髅怪" then
    bbs[1] = 15
    bbs[2] = 1260
    bbs[3] = 1380
    bbs[4] = 2360
    bbs[5] = 1320
    bbs[6] = 1200
    bbs[7] = 1200
    bbs[8] = {1.004,1.014,1.025,1.035,1.045}
    bbs[9] = {"土属性吸收","弱点雷","鬼魂术"}
  elseif bb == "祥瑞腾蛇" then
    bbs[1] = 0
    bbs[2] = 1400
    bbs[3] = 1400
    bbs[4] = 3500
    bbs[5] = 2500
    bbs[6] = 1200
    bbs[7] = 1200
    bbs[8] = {1.25,1.25,1.25,1.25,1.25}
    bbs[9] = {}
  elseif bb == "修罗傀儡鬼" then
    bbs[1] = 155
    bbs[2] = 1524
    bbs[3] = 1380
    bbs[4] = 4040
    bbs[5] = 2400
    bbs[6] = 1440
    bbs[7] = 1440
    bbs[8] = {1.244,1.257,1.27,1.282,1.295}
    bbs[9] = {"高级驱鬼","反震","高级必杀","强力","嗜血追击"}
  elseif bb == "树怪" then
    bbs[1] = 5
    bbs[2] = 1320
    bbs[3] = 1320
    bbs[4] = 2300
    bbs[5] = 1320
    bbs[6] = 900
    bbs[7] = 960
    bbs[8] = {0.882,0.891,0.9,0.909,0.918}
    bbs[9] = {"反击","感知","驱鬼","再生","烈火","弱点火","迟钝"}
  elseif bb == "羊头怪" then
    bbs[1] = 15
    bbs[2] = 1260
    bbs[3] = 1380
    bbs[4] = 2360
    bbs[5] = 1320
    bbs[6] = 1200
    bbs[7] = 1200
    bbs[8] = {1.004,1.014,1.025,1.035,1.045}
    bbs[9] = {"连击","必杀","幸运","永恒"}
  elseif bb == "海毛虫" then
    bbs[1] = 5
    bbs[2] = 1440
    bbs[3] = 900
    bbs[4] = 1400
    bbs[5] = 1200
    bbs[6] = 1320
    bbs[7] = 1200
    bbs[8] = {0.989,0.999,1.01,1.02,1.03}
    bbs[9] = {"毒","高级反震","必杀","驱鬼","弱点火"}
  elseif bb == "野猪" then
    bbs[1] = 5
    bbs[2] = 1320
    bbs[3] = 1320
    bbs[4] = 2300
    bbs[5] = 1320
    bbs[6] = 900
    bbs[7] = 960
    bbs[8] = {0.999,1.009,1.02,1.03,1.04}
    bbs[9] = {"感知","高级感知","高级幸运","强力","弱点土","弱点火"}
  elseif bb == "天兵" then
    bbs[1] = 55
    bbs[2] = 1400
    bbs[3] = 1500
    bbs[4] = 4100
    bbs[5] = 2319
    bbs[6] = 1368
    bbs[7] = 1320
    bbs[8] = {1.127,1.138,1.15,1.161,1.173}
    bbs[9] = {"高级防御","高级感知","必杀","高级驱鬼"}
  elseif bb == "野猪精" then
    bbs[1] = 85
    bbs[2] = 1464
    bbs[3] = 1560
    bbs[4] = 3800
    bbs[5] = 2400
    bbs[6] = 1200
    bbs[7] = 1320
    bbs[8] = {1.205,1.217,1.23,1.242,1.254}
    bbs[9] = {"反击","感知","弱点水","高级强力"}
  elseif bb == "赌徒" then
    bbs[1] = 5
    bbs[2] = 1020
    bbs[3] = 1140
    bbs[4] = 2000
    bbs[5] = 1440
    bbs[6] = 1440
    bbs[7] = 1380
    bbs[8] = {0.931,0.94,0.95,0.959,0.969}
    bbs[9] = {"反击","偷袭"}
  elseif bb == "野鬼" then
    bbs[1] = 35
    bbs[2] = 1320
    bbs[3] = 1320
    bbs[4] = 3200
    bbs[5] = 1200
    bbs[6] = 1140
    bbs[7] = 1260
    bbs[8] = {0.994,1.004,1.015,1.025,1.035}
    bbs[9] = {"落岩","弱点雷","鬼魂术"}
  elseif bb == "修罗傀儡妖" then
    bbs[1] = 165
    bbs[2] = 1536
    bbs[3] = 1380
    bbs[4] = 2800
    bbs[5] = 2400
    bbs[6] = 1500
    bbs[7] = 1440
    bbs[8] = {1.254,1.267,1.28,1.292,1.3}
    bbs[9] = {"合纵","感知","高级幸运","高级连击"}
  elseif bb == "连弩车" then
    bbs[1] = 145
    bbs[2] = 1500
    bbs[3] = 1560
    bbs[4] = 4400
    bbs[5] = 2400
    bbs[6] = 1200
    bbs[7] = 1320
    bbs[8] = {1.235,1.247,1.26,1.273,1.285}
    bbs[9] = {"高级强力","防御","连击","迟钝"}
  elseif bb == "黑熊精" then
    bbs[1] = 35
    bbs[2] = 1380
    bbs[3] = 1260
    bbs[4] = 4040
    bbs[5] = 2160
    bbs[6] = 1020
    bbs[7] = 1320
    bbs[8] = {1.038,1.049,1.06,1.07,1.081}
    bbs[9] = {"反震","必杀","幸运","高级强力","弱点雷"}
  elseif bb == "金身罗汉" then
    bbs[1] = 165
    bbs[2] = 1380
    bbs[3] = 1500
    bbs[4] = 4400
    bbs[5] = 2400
    bbs[6] = 1560
    bbs[7] = 1440
    bbs[8] = {1.254,1.267,1.28,1.292,1.3}
    bbs[9] = {"永恒","高级反震","神佑复生","盾气","高级敏捷"}
  elseif bb == "犀牛将军人形" then
    bbs[1] = 75
    bbs[2] = 1440
    bbs[3] = 1464
    bbs[4] = 3800
    bbs[5] = 2520
    bbs[6] = 1200
    bbs[7] = 1140
    bbs[8] = {1.205,1.217,1.23,1.242,1.254}
    bbs[9] = {"高级强力","高级幸运","剑荡四方","再生"}
  elseif bb == "大海龟" then
    bbs[1] = 0
    bbs[2] = 960
    bbs[3] = 960
    bbs[4] = 2600
    bbs[5] = 1200
    bbs[6] = 840
    bbs[7] = 1320
    bbs[8] = {0.882,0.891,0.9,0.909,0.918}
    bbs[9] = {"反震","慧根","幸运","水属性吸收","防御"}
  elseif bb == "曼珠沙华" then
    bbs[1] = 165
    bbs[2] = 1440
    bbs[3] = 1440
    bbs[4] = 3800
    bbs[5] = 2800
    bbs[6] = 1500
    bbs[7] = 1440
    bbs[8] = {1.254,1.267,1.28,1.292,1.3}
    bbs[9] = {"奔雷咒","魔之心","反震","法术连击","高级再生"}
  elseif bb == "长眉灵猴" then
    bbs[1] = 155
    bbs[2] = 1440
    bbs[3] = 1500
    bbs[4] = 4640
    bbs[5] = 3240
    bbs[6] = 1200
    bbs[7] = 1560
    bbs[8] = {1.244,1.257,1.27,1.282,1.295}
    bbs[9] = {"奔雷咒","高级法术暴击","冥思","高级再生"}
  elseif bb == "护卫" then
    bbs[1] = 0
    bbs[2] = 1140
    bbs[3] = 1020
    bbs[4] = 1700
    bbs[5] = 1800
    bbs[6] = 1200
    bbs[7] = 1200
    bbs[8] = {0.931,0.94,0.95,0.959,0.969}
    bbs[9] = {"反击","必杀","强力"}
  elseif bb == "巨力神猿" then
    bbs[1] = 155
    bbs[2] = 1500
    bbs[3] = 1440
    bbs[4] = 3560
    bbs[5] = 2640
    bbs[6] = 1500
    bbs[7] = 1560
    bbs[8] = {1.244,1.257,1.27,1.282,1.295}
    bbs[9] = {"敏捷","高级盾气","高级连击","强力","高级驱鬼"}
  elseif bb == "章鱼" then
    bbs[1] = 0
    bbs[2] = 1440
    bbs[3] = 840
    bbs[4] = 1400
    bbs[5] = 1200
    bbs[6] = 1320
    bbs[7] = 1200
    bbs[8] = {0.989,0.999,1.01,1.02,1.03}
    bbs[9] = {"连击","毒","吸血","水属性吸收","弱点火"}
  elseif bb == "蔓藤妖花" then
    bbs[1] = 155
    bbs[2] = 1464
    bbs[3] = 1440
    bbs[4] = 3560
    bbs[5] = 3120
    bbs[6] = 1200
    bbs[7] = 1440
    bbs[8] = {1.244,1.257,1.27,1.282,1.295}
    bbs[9] = {"灵能激发","落岩","高级招架","高级法术连击"}
  elseif bb == "金饶僧" then
    bbs[1] = 125
    bbs[2] = 1550
    bbs[3] = 1500
    bbs[4] = 3800
    bbs[5] = 2400
    bbs[6] = 1500
    bbs[7] = 1500
    bbs[8] = {1.215,1.227,1.24,1.252,1.264}
    bbs[9] = {"再生","必杀","招架","偷袭","高级防御"}
  elseif bb == "大力金刚" then
    bbs[1] = 125
    bbs[2] = 1548
    bbs[3] = 1334
    bbs[4] = 4600
    bbs[5] = 2640
    bbs[6] = 1200
    bbs[7] = 1200
    bbs[8] = {1.215,1.227,1.24,1.252,1.264}
    bbs[9] = {"高级强力","泰山压顶","力劈华山","高级永恒"}
  elseif bb == "花妖" then
    bbs[1] = 15
    bbs[2] = 1020
    bbs[3] = 1440
    bbs[4] = 2780
    bbs[5] = 1440
    bbs[6] = 1140
    bbs[7] = 1140
    bbs[8] = {1.029,1.039,1.05,1.06,1.071}
    bbs[9] = {"感知","慧根","落岩","防御","水属性吸收"}
  elseif bb == "蜃气妖" then
    bbs[1] = 155
    bbs[2] = 1464
    bbs[3] = 1440
    bbs[4] = 4040
    bbs[5] = 3240
    bbs[6] = 1320
    bbs[7] = 1440
    bbs[8] = {1.244,1.257,1.27,1.282,1.295}
    bbs[9] = {"高级法术连击","雷击","法术暴击","上古灵符"}
  elseif bb == "猫灵人形" then
    bbs[1] = 155
    bbs[2] = 1524
    bbs[3] = 1464
    bbs[4] = 3560
    bbs[5] = 2640
    bbs[6] = 1500
    bbs[7] = 1680
    bbs[8] = {1.244,1.257,1.27,1.282,1.295}
    bbs[9] = {"必杀","高级幸运","高级偷袭","反击","敏捷"}
  elseif bb == "蚌精" then
    bbs[1] = 65
    bbs[2] = 1200
    bbs[3] = 1500
    bbs[4] = 2840
    bbs[5] = 2880
    bbs[6] = 1200
    bbs[7] = 1140
    bbs[8] = {1.176,1.188,1.2,1.212,1.224}
    bbs[9] = {"水攻","慧根","高级水属性吸收","神迹","冥思"}
  elseif bb == "机关兽" then
    bbs[1] = 145
    bbs[2] = 1440
    bbs[3] = 1500
    bbs[4] = 4280
    bbs[5] = 2880
    bbs[6] = 1440
    bbs[7] = 1440
    bbs[8] = {1.235,1.247,1.26,1.273,1.285}
    bbs[9] = {"魔之心","高级法术连击","土属性吸收","烈火"}
  elseif bb == "阴阳伞" then
    bbs[1] = 95
    bbs[2] = 1440
    bbs[3] = 1440
    bbs[4] = 3800
    bbs[5] = 3000
    bbs[6] = 1500
    bbs[7] = 1440
    bbs[8] = {1.205,1.217,1.23,1.242,1.254}
    bbs[9] = {"上古灵符","驱鬼","剑荡四方","高级飞行"}
  elseif bb == "混沌兽" then
    bbs[1] = 155
    bbs[2] = 1440
    bbs[3] = 1476
    bbs[4] = 4400
    bbs[5] = 3240
    bbs[6] = 1320
    bbs[7] = 1560
    bbs[8] = {1.244,1.257,1.27,1.282,1.295}
    bbs[9] = {"再生","高级慧根","高级永恒","高级魔之心","奔雷咒"}
  elseif bb == "古代瑞兽" then
    bbs[1] = 45
    bbs[2] = 1210
    bbs[3] = 1260
    bbs[4] = 2600
    bbs[5] = 2504
    bbs[6] = 1380
    bbs[7] = 1200
    bbs[8] = {1.127,1.138,1.15,1.161,1.173}
    bbs[9] = {"高级神迹","高级反震","泰山压顶","高级驱鬼"}
  elseif bb == "蛟龙" then
    bbs[1] = 65
    bbs[2] = 1440
    bbs[3] = 1440
    bbs[4] = 3560
    bbs[5] = 3000
    bbs[6] = 1200
    bbs[7] = 1320
    bbs[8] = {1.176,1.188,1.2,1.212,1.224}
    bbs[9] = {"水漫金山","感知","高级永恒","高级水属性吸收"}
  elseif bb == "葫芦宝贝" then
    bbs[1] = 135
    bbs[2] = 1440
    bbs[3] = 1500
    bbs[4] = 3800
    bbs[5] = 2760
    bbs[6] = 1320
    bbs[7] = 1800
    bbs[8] = {1.225,1.237,1.25,1.262,1.275}
    bbs[9] = {"高级冥思","上古灵符","反震","魔之心"}
  elseif bb == "踏云兽" then
    bbs[1] = 135
    bbs[2] = 1524
    bbs[3] = 1440
    bbs[4] = 4400
    bbs[5] = 1800
    bbs[6] = 1440
    bbs[7] = 1440
    bbs[8] = {1.225,1.237,1.25,1.262,1.275}
    bbs[9] = {"高级招架","高级必杀","高级强力","弱点土"}
  elseif bb == "雪仙" then
    bbs[1] = 105
    bbs[2] = 1440
    bbs[3] = 1440
    bbs[4] = 3200
    bbs[5] = 2640
    bbs[6] = 1536
    bbs[7] = 1560
    bbs[8] = {1.215,1.227,1.24,1.252,1.264}
    bbs[9] = {"泰山压顶","魔之心","神佑复生","再生","敏捷"}
  elseif bb == "鬼将" then
    bbs[1] = 105
    bbs[2] = 1524
    bbs[3] = 1380
    bbs[4] = 4040
    bbs[5] = 1440
    bbs[6] = 1320
    bbs[7] = 1320
    bbs[8] = {1.215,1.227,1.24,1.252,1.264}
    bbs[9] = {"惊心一剑","高级必杀","冥思","鬼魂术"}
  elseif bb == "狸" then
    bbs[1] = 5
    bbs[2] = 1440
    bbs[3] = 900
    bbs[4] = 1880
    bbs[5] = 1200
    bbs[6] = 1380
    bbs[7] = 1320
    bbs[8] = {0.996,1.002,1.03,1.032,1.042}
    bbs[9] = {}
  elseif bb == "狐狸精" then
    bbs[1] = 15
    bbs[2] = 1320
    bbs[3] = 1260
    bbs[4] = 2000
    bbs[5] = 1440
    bbs[6] = 1320
    bbs[7] = 1200
    bbs[8] = {1.009,1.019,1.03,1.04,1.05}
    bbs[9] = {"高级感知","慧根","高级慧根","弱点雷"}
  elseif bb == "巨蛙" then
    bbs[1] = 0
    bbs[2] = 1080
    bbs[3] = 840
    bbs[4] = 1700
    bbs[5] = 1190
    bbs[6] = 1309
    bbs[7] = 1309
    bbs[8] = {0.882,0.891,0.9,0.909,0.918}
    bbs[9] = {"慧根","幸运","水攻","弱点火"}
  elseif bb == "山贼" then
    bbs[1] = 5
    bbs[2] = 1080
    bbs[3] = 1200
    bbs[4] = 2600
    bbs[5] = 1200
    bbs[6] = 1200
    bbs[7] = 1320
    bbs[8] = {0.989,0.999,1.01,1.02,1.03}
    bbs[9] = {"招架","偷袭","强力","高级否定信仰"}
  elseif bb == "海星" then
    bbs[1] = 0
    bbs[2] = 1080
    bbs[3] = 1140
    bbs[4] = 1400
    bbs[5] = 1440
    bbs[6] = 1200
    bbs[7] = 1020
    bbs[8] = {0.989,0.999,1.01,1.02,1.04}
    bbs[9] = {"水属性吸收","弱点火","慧根","高级反震","水攻"}
  elseif bb == "小龙女" then
    bbs[1] = 25
    bbs[2] = 1500
    bbs[3] = 1020
    bbs[4] = 2000
    bbs[5] = 1140
    bbs[6] = 1320
    bbs[7] = 960
    bbs[8] = {1.058,1.069,1.08,1.09,1.101}
    bbs[9] = {"神佑复生","高级驱鬼","慧根","水攻","高级水属性吸收"}
  elseif bb == "红萼仙子" then
    bbs[1] = 135
    bbs[2] = 1500
    bbs[3] = 1500
    bbs[4] = 4400
    bbs[5] = 3000
    bbs[6] = 960
    bbs[7] = 1800
    bbs[8] = {1.225,1.237,1.25,1.262,1.275}
    bbs[9] = {"上古灵符","高级飞行","高级冥思","奔雷咒"}
  elseif bb == "浣熊" then
    bbs[1] = 5
    bbs[2] = 1440
    bbs[3] = 900
    bbs[4] = 1880
    bbs[5] = 1200
    bbs[6] = 1380
    bbs[7] = 1320
    bbs[8] = {0.996,1.002,1.03,1.032,1.042}
    bbs[9] = {"幸运","偷袭","必杀","招架"}
  elseif bb == "风伯" then
    bbs[1] = 55
    bbs[2] = 1380
    bbs[3] = 1395
    bbs[4] = 3200
    bbs[5] = 2358
    bbs[6] = 1368
    bbs[7] = 1320
    bbs[8] = {1.127,1.138,1.15,1.161,1.173}
    bbs[9] = {"高级敏捷","奔雷咒","高级雷属性吸收","高级飞行"}
  elseif bb == "大蝙蝠" then
    bbs[1] = 5
    bbs[2] = 1080
    bbs[3] = 1140
    bbs[4] = 1520
    bbs[5] = 1800
    bbs[6] = 1500
    bbs[7] = 1500
    bbs[8] = {1.058,1.069,1.08,1.09,1.101}
    bbs[9] = {"吸血","高级感知","高级驱鬼","飞行","高级驱鬼","弱点水"}
  elseif bb == "幽萤娃娃" then
    bbs[1] = 105
    bbs[2] = 1440
    bbs[3] = 1440
    bbs[4] = 3200
    bbs[5] = 2640
    bbs[6] = 1536
    bbs[7] = 1560
    bbs[8] = {1.215,1.227,1.24,1.252,1.264}
    bbs[9] = {"高级鬼魂术","高级防御","敏捷","高级法术抵抗"}
  elseif bb == "强盗" then
    bbs[1] = 5
    bbs[2] = 1260
    bbs[3] = 1260
    bbs[4] = 2300
    bbs[5] = 1380
    bbs[6] = 1200
    bbs[7] = 1200
    bbs[8] = {0.989,0.999,1.01,1.02,1.03}
    bbs[9] = {"连击","烈火","强力","否定信仰"}
  elseif bb == "巴蛇" then
    bbs[1] = 145
    bbs[2] = 1524
    bbs[3] = 1440
    bbs[4] = 3800
    bbs[5] = 1560
    bbs[6] = 1560
    bbs[7] = 1560
    bbs[8] = {1.235,1.247,1.26,1.273,1.285}
    bbs[9] = {"敏捷","嗜血追击","感知","毒","再生"}
  elseif bb == "机关鸟" then
    bbs[1] = 145
    bbs[2] = 1500
    bbs[3] = 1344
    bbs[4] = 3800
    bbs[5] = 2520
    bbs[6] = 1560
    bbs[7] = 1560
    bbs[8] = {1.235,1.247,1.26,1.273,1.285}
    bbs[9] = {"高级偷袭","驱鬼","高级再生","神迹","飞行"}
  elseif bb == "律法女娲" then
    bbs[1] = 95
    bbs[2] = 1440
    bbs[3] = 1560
    bbs[4] = 3440
    bbs[5] = 2400
    bbs[6] = 1440
    bbs[7] = 1680
    bbs[8] = {1.205,1.217,1.23,1.242,1.254}
    bbs[9] = {"善恶有报","敏捷","再生","高级反击"}
  elseif bb == "猫灵兽形" then
    bbs[1] = 135
    bbs[2] = 1464
    bbs[3] = 1464
    bbs[4] = 3080
    bbs[5] = 2400
    bbs[6] = 1560
    bbs[7] = 1680
    bbs[8] = {1.225,1.237,1.25,1.262,1.275}
    bbs[9] = {"必杀","敏捷","高级偷袭","弱点水"}
  elseif bb == "镜妖" then
    bbs[1] = 85
    bbs[2] = 1481
    bbs[3] = 1325
    bbs[4] = 3027
    bbs[5] = 2492
    bbs[6] = 1584
    bbs[7] = 1455
    bbs[8] = {1.205,1.217,1.23,1.242,1.254}
    bbs[9] = {"反震","高级驱鬼","鬼魂术","雷击"}
  elseif bb == "龙龟" then
    bbs[1] = 135
    bbs[2] = 1440
    bbs[3] = 1560
    bbs[4] = 4760
    bbs[5] = 3000
    bbs[6] = 1200
    bbs[7] = 1560
    bbs[8] = {1.225,1.237,1.25,1.262,1.275}
    bbs[9] = {"水属性吸收","反震","高级防御","法术防御","水攻"}
  elseif bb == "机关人人形" then
    bbs[1] = 135
    bbs[2] = 1500
    bbs[3] = 1500
    bbs[4] = 4400
    bbs[5] = 1680
    bbs[6] = 1320
    bbs[7] = 1440
    bbs[8] = {1.225,1.237,1.25,1.262,1.275}
    bbs[9] = {"壁垒击破","弱点火","必杀","高级招架"}
  elseif bb == "吸血鬼" then
    bbs[1] = 95
    bbs[2] = 1440
    bbs[3] = 1320
    bbs[4] = 2600
    bbs[5] = 2400
    bbs[6] = 1320
    bbs[7] = 1800
    bbs[8] = {1.205,1.217,1.23,1.242,1.254}
    bbs[9] = {"偷袭","吸血","鬼魂术","驱鬼","弱点水"}
  elseif bb == "地狱战神" then
    bbs[1] = 55
    bbs[2] = 1500
    bbs[3] = 1530
    bbs[4] = 3500
    bbs[5] = 1868
    bbs[6] = 1080
    bbs[7] = 1503
    bbs[8] = {1.107,1.118,1.13,1.141,1.152}
    bbs[9] = {"泰山压顶","高级连击","高级魔之心","高级反震"}
  elseif bb == "琴仙" then
    bbs[1] = 125
    bbs[2] = 1500
    bbs[3] = 1500
    bbs[4] = 4100
    bbs[5] = 3499
    bbs[6] = 1490
    bbs[7] = 1555
    bbs[8] = {1.215,1.227,1.24,1.252,1.264}
    bbs[9] = {"泰山压顶","魔之心","神佑复生","再生","敏捷"}
  elseif bb == "蛤蟆精" then
    bbs[1] = 15
    bbs[2] = 1380
    bbs[3] = 1140
    bbs[4] = 2300
    bbs[5] = 1200
    bbs[6] = 1320
    bbs[7] = 1320
    bbs[8] = {1.009,1.019,1.03,1.04,1.05}
    bbs[9] = {"毒","必杀"}
  elseif bb == "如意仙子" then
    bbs[1] = 75
    bbs[2] = 1200
    bbs[3] = 1416
    bbs[4] = 3378
    bbs[5] = 2700
    bbs[6] = 1400
    bbs[7] = 1380
    bbs[8] = {1.205,1.217,1.23,1.242,1.254}
    bbs[9] = {"奔雷咒","地狱烈火","泰山压顶","烈火","雷击","弱点水"}
  elseif bb == "锦毛貂精" then
    bbs[1] = 75
    bbs[2] = 1200
    bbs[3] = 1260
    bbs[4] = 3200
    bbs[5] = 2711
    bbs[6] = 1560
    bbs[7] = 1680
    bbs[8] = {1.205,1.217,1.23,1.242,1.254}
    bbs[9] = {"冥思","泰山压顶","法术连击","敏捷"}
  elseif bb == "雾中仙" then
    bbs[1] = 125
    bbs[2] = 1440
    bbs[3] = 1500
    bbs[4] = 4400
    bbs[5] = 3000
    bbs[6] = 1320
    bbs[7] = 1880
    bbs[8] = {1.215,1.227,1.24,1.252,1.264}
    bbs[9] = {"高级神佑复生","高级感知","法术连击","敏捷"}
  elseif bb == "灵鹤" then
    bbs[1] = 125
    bbs[2] = 1440
    bbs[3] = 1440
    bbs[4] = 3560
    bbs[5] = 2760
    bbs[6] = 1560
    bbs[7] = 1440
    bbs[8] = {1.215,1.227,1.24,1.252,1.264}
    bbs[9] = {"高级永恒","高级驱鬼","高级再生","高级慧根","飞行"}
  elseif bb == "百足将军" then
    bbs[1] = 85
    bbs[2] = 1440
    bbs[3] = 1320
    bbs[4] = 3560
    bbs[5] = 2640
    bbs[6] = 1560
    bbs[7] = 1320
    bbs[8] = {1.205,1.217,1.23,1.242,1.254}
    bbs[9] = {"毒","落岩","高级驱鬼","弱点水"}
  elseif bb == "牛妖" then
    bbs[1] = 25
    bbs[2] = 1080
    bbs[3] = 1140
    bbs[4] = 1520
    bbs[5] = 1800
    bbs[6] = 1500
    bbs[7] = 1500
    bbs[8] = {1.058,1.069,1.08,1.09,1.101}
    bbs[9] = {"高级反击","高级慧根","高级防御","烈火"}
  elseif bb == "黑山老妖" then
    bbs[1] = 45
    bbs[2] = 1130
    bbs[3] = 1500
    bbs[4] = 4800
    bbs[5] = 2400
    bbs[6] = 952
    bbs[7] = 1320
    bbs[8] = {1.107,1.118,1.13,1.141,1.152}
    bbs[9] = {"高级偷袭","高级吸血","高级精神集中"}
  elseif bb == "雷鸟人" then
    bbs[1] = 45
    bbs[2] = 1200
    bbs[3] = 1200
    bbs[4] = 3200
    bbs[5] = 1920
    bbs[6] = 1440
    bbs[7] = 1140
    bbs[8] = {1.205,1.217,1.23,1.242,1.254}
    bbs[9] = {"高级雷属性吸收","奔雷咒","飞行","弱点土","雷击"}
  elseif bb == "芙蓉仙子" then
    bbs[1] = 75
    bbs[2] = 1440
    bbs[3] = 1440
    bbs[4] = 3560
    bbs[5] = 2632
    bbs[6] = 1380
    bbs[7] = 1440
    bbs[8] = {1.205,1.217,1.23,1.242,1.254}
    bbs[9] = {"高级再生","高级飞行","高级幸运"}
  elseif bb == "凤凰" then
    bbs[1] = 65
    bbs[2] = 1200
    bbs[3] = 1440
    bbs[4] = 3200
    bbs[5] = 2400
    bbs[6] = 1560
    bbs[7] = 1320
    bbs[8] = {1.205,1.217,1.23,1.242,1.254}
    bbs[9] = {"地狱烈火","高级神佑复生","高级火属性吸收","飞行"}
  elseif bb == "千年蛇魅" then
    bbs[1] = 75
    bbs[2] = 1380
    bbs[3] = 1320
    bbs[4] = 3380
    bbs[5] = 2640
    bbs[6] = 1440
    bbs[7] = 1500
    bbs[8] = {1.2,1.21,1.229,1.238,1.244}
    bbs[9] = {"敏捷","毒","偷袭","高级吸血"}
  elseif bb == "巡游天神" then
    bbs[1] = 75
    bbs[2] = 1380
    bbs[3] = 1380
    bbs[4] = 4400
    bbs[5] = 2640
    bbs[6] = 1210
    bbs[7] = 1680
    bbs[8] = {1.195,1.207,1.22,1.232,1.244}
    bbs[9] = {"泰山压顶","地狱烈火","高级招架","高级必杀"}
  elseif bb == "兔子怪" then
    bbs[1] = 35
    bbs[2] = 1320
    bbs[3] = 1140
    bbs[4] = 3200
    bbs[5] = 2400
    bbs[6] = 1440
    bbs[7] = 1140
    bbs[8] = {1.038,1.049,1.06,1.07,1.081}
    bbs[9] = {"高级感知","高级冥思","高级驱鬼","高级幸运","高级永恒","高级敏捷","弱点土"}
  elseif bb == "黑熊" then
    bbs[1] = 15
    bbs[2] = 1080
    bbs[3] = 1140
    bbs[4] = 1520
    bbs[5] = 1800
    bbs[6] = 1500
    bbs[7] = 1500
    bbs[8] = {1.058,1.069,1.08,1.09,1.101}
    bbs[9] = {"反击","必杀","强力","防御","迟钝"}
  elseif bb == "狂豹兽形" then
    bbs[1] = 135
    bbs[2] = 1500
    bbs[3] = 1440
    bbs[4] = 3560
    bbs[5] = 2160
    bbs[6] = 1320
    bbs[7] = 1560
    bbs[8] = {1.225,1.237,1.25,1.262,1.275}
    bbs[9] = {"高级强力","驱鬼","高级飞行","偷袭"}
  elseif bb == "灵符女娲" then
    bbs[1] = 95
    bbs[2] = 1320
    bbs[3] = 1560
    bbs[4] = 3800
    bbs[5] = 3000
    bbs[6] = 1440
    bbs[7] = 1440
    bbs[8] = {1.205,1.217,1.23,1.242,1.254}
    bbs[9] = {"上古灵符","高级冥思","地狱烈火","落岩"}
  elseif bb == "泡泡" then
    bbs[1] = 0
    bbs[2] = 1320
    bbs[3] = 1380
    bbs[4] = 3200
    bbs[5] = 2160
    bbs[6] = 1320
    bbs[7] = 1320
    bbs[8] = {1.048,1.059,1.07,1.08,1.091}
    bbs[9] = {"高级防御","高级幸运","连击","精神集中","再生"}
  elseif bb == "幽灵" then
    bbs[1] = 95
    bbs[2] = 1476
    bbs[3] = 1440
    bbs[4] = 3200
    bbs[5] = 2640
    bbs[6] = 1320
    bbs[7] = 1680
    bbs[8] = {1.205,1.217,1.23,1.242,1.254}
    bbs[9] = {"高级反击","高级飞行","死亡召唤","鬼魂术"}
  elseif bb == "泪妖" then
    bbs[1] = 85
    bbs[2] = 1296
    bbs[3] = 1296
    bbs[4] = 2888
    bbs[5] = 2592
    bbs[6] = 1296
    bbs[7] = 1684
    bbs[8] = {1.205,1.217,1.23,1.242,1.254}
    bbs[9] = {"冥思","高级魔之心","法术暴击","弱点土","水攻"}
  elseif bb == "炎魔神" then
    bbs[1] = 125
    bbs[2] = 1500
    bbs[3] = 1440
    bbs[4] = 3800
    bbs[5] = 3000
    bbs[6] = 1440
    bbs[7] = 1320
    bbs[8] = {1.215,1.227,1.24,1.252,1.264}
    bbs[9] = {"高级必杀","高级火属性吸收","烈火","地狱烈火"}
  elseif bb == "鼠先锋" then
    bbs[1] = 85
    bbs[2] = 1200
    bbs[3] = 1440
    bbs[4] = 3440
    bbs[5] = 2880
    bbs[6] = 1560
    bbs[7] = 1560
    bbs[8] = {1.205,1.217,1.23,1.242,1.254}
    bbs[9] = {"驱鬼","冥思","泰山压顶","敏捷"}
  elseif bb == "夜罗刹" then
    bbs[1] = 125
    bbs[2] = 1500
    bbs[3] = 1440
    bbs[4] = 4760
    bbs[5] = 2880
    bbs[6] = 1440
    bbs[7] = 1440
    bbs[8] = {1.215,1.227,1.24,1.252,1.264}
    bbs[9] = {"必杀","高级敏捷","高级魔之心","夜舞倾城"}
  elseif bb == "星灵仙子" then
    bbs[1] = 75
    bbs[2] = 1200
    bbs[3] = 1416
    bbs[4] = 3378
    bbs[5] = 2700
    bbs[6] = 1440
    bbs[7] = 1446
    bbs[8] = {1.205,1.217,1.23,1.242,1.254}
    bbs[9] = {"雷击","奔雷咒","水漫金山","高级慧根"}
  elseif bb == "蜘蛛精" then
    bbs[1] = 35
    bbs[2] = 1140
    bbs[3] = 1355
    bbs[4] = 3980
    bbs[5] = 2580
    bbs[6] = 1080
    bbs[7] = 1200
    bbs[8] = {1.038,1.049,1.06,1.07,1.081}
    bbs[9] = {"吸血","高级感知","高级毒","弱点土"}
  elseif bb == "净瓶女娲" then
    bbs[1] = 105
    bbs[2] = 1464
    bbs[3] = 1440
    bbs[4] = 3800
    bbs[5] = 2880
    bbs[6] = 1560
    bbs[7] = 1560
    bbs[8] = {1.215,1.227,1.24,1.252,1.264}
    bbs[9] = {"上古灵符","奔雷咒","高级慧根","感知"}
  elseif bb == "鲛人" then
    bbs[1] = 65
    bbs[2] = 1440
    bbs[3] = 1440
    bbs[4] = 3560
    bbs[5] = 1920
    bbs[6] = 1380
    bbs[7] = 1440
    bbs[8] = {1.176,1.188,1.2,1.212,1.224}
    bbs[9] = {"连击","高级水属性吸收","移花接木","敏捷"}
  elseif bb == "天将" then
    bbs[1] = 55
    bbs[2] = 1380
    bbs[3] = 1140
    bbs[4] = 4406
    bbs[5] = 2450
    bbs[6] = 1380
    bbs[7] = 1204
    bbs[8] = {1.136,1.148,1.16,1.171,1.183}
    bbs[9] = {"高级强力","驱鬼","连击","幸运"}
  elseif bb == "龟丞相" then
    bbs[1] = 35
    bbs[2] = 1375
    bbs[3] = 1313
    bbs[4] = 2000
    bbs[5] = 2500
    bbs[6] = 1500
    bbs[7] = 1500
    bbs[8] = {1.038,1.049,1.06,1.07,1.081}
    bbs[9] = {"冥思","驱鬼","防御","水漫金山","水属性吸收","水攻"}
  elseif bb == "蝎子精" then
    bbs[1] = 135
    bbs[2] = 1464
    bbs[3] = 1464
    bbs[4] = 5040
    bbs[5] = 2880
    bbs[6] = 1320
    bbs[7] = 1920
    bbs[8] = {1.225,1.237,1.25,1.262,1.275}
    bbs[9] = {"高级反震","招架","高级再生","毒"}
  elseif bb == "犀牛将军兽形" then
    bbs[1] = 75
    bbs[2] = 1440
    bbs[3] = 1464
    bbs[4] = 3800
    bbs[5] = 2520
    bbs[6] = 1200
    bbs[7] = 1140
    bbs[8] = {1.205,1.217,1.23,1.242,1.254}
    bbs[9] = {"法术暴击","土属性吸收","法术波动","落岩"}
  elseif bb == "僵尸" then
    bbs[1] = 35
    bbs[2] = 1440
    bbs[3] = 1080
    bbs[4] = 3320
    bbs[5] = 2400
    bbs[6] = 1200
    bbs[7] = 1380
    bbs[8] = {1.048,1.059,1.07,1.08,1.091}
    bbs[9] = {"土属性吸收","弱点雷","防御","鬼魂术"}
  elseif bb == "蝴蝶仙子" then
    bbs[1] = 45
    bbs[2] = 1320
    bbs[3] = 1140
    bbs[4] = 2000
    bbs[5] = 2500
    bbs[6] = 1440
    bbs[7] = 1440
    bbs[8] = {1.097,1.108,1.12,1.131,1.142}
    bbs[9] = {"神迹","高级魔之心","高级敏捷","飞行","弱点水"}
  elseif bb == "马面" then
    bbs[1] = 35
    bbs[2] = 1320
    bbs[3] = 1320
    bbs[4] = 2600
    bbs[5] = 1800
    bbs[6] = 1440
    bbs[7] = 1200
    bbs[8] = {1.048,1.059,1.07,1.08,1.091}
    bbs[9] = {"驱鬼","高级必杀","强力","高级鬼魂术"}
  elseif bb == "蟹将" then
    bbs[1] = 25
    bbs[2] = 1320
    bbs[3] = 1200
    bbs[4] = 4100
    bbs[5] = 2280
    bbs[6] = 1200
    bbs[7] = 1200
    bbs[8] = {1.025,1.035,1.46,1.56,1.066}
    bbs[9] = {"高级连击","精神集中","招架","水属性吸收"}
  elseif bb == "画魂" then
    bbs[1] = 105
    bbs[2] = 1380
    bbs[3] = 1440
    bbs[4] = 3320
    bbs[5] = 2880
    bbs[6] = 1320
    bbs[7] = 1440
    bbs[8] = {1.215,1.227,1.24,1.252,1.264}
    bbs[9] = {"高级鬼魂术","地狱烈火","幸运","高级魔之心"}
  elseif bb == "碧水夜叉" then
    bbs[1] = 65
    bbs[2] = 1380
    bbs[3] = 1320
    bbs[4] = 3200
    bbs[5] = 2760
    bbs[6] = 1440
    bbs[7] = 1800
    bbs[8] = {1.186,1.198,1.21,1.222,1.234}
    bbs[9] = {"高级反震","奔雷咒","强力","壁垒击破"}
  elseif bb == "狂豹人形" then
    bbs[1] = 155
    bbs[2] = 1536
    bbs[3] = 1440
    bbs[4] = 3800
    bbs[5] = 2280
    bbs[6] = 1440
    bbs[7] = 1560
    bbs[8] = {1.244,1.257,1.27,1.282,1.295}
    bbs[9] = {"驱鬼","高级飞行","高级强力","偷袭","吸血"}
  elseif bb == "小毛头" or bb == "小精灵" or bb == "小魔头"  then
    bbs[1] = 0
    bbs[2] = 960
    bbs[3] = 960
    bbs[4] = 2600
    bbs[5] = 1200
    bbs[6] = 840
    bbs[7] = 1320
    bbs[8] = {0.882,0.891,0.9,0.909,0.918}
    bbs[9] = {"高级连击","高级防御","高级驱鬼","高级偷袭"}
  elseif bb == "小丫丫" or bb == "小仙灵" or bb == "小仙女" then
    bbs[1] = 0
    bbs[2] = 960
    bbs[3] = 960
    bbs[4] = 2600
    bbs[5] = 1200
    bbs[6] = 840
    bbs[7] = 1320
    bbs[8] = {0.882,0.891,0.9,0.909,0.918}
    bbs[9] = {"高级连击","高级防御","高级驱鬼","高级偷袭"}
  elseif bb == "毗舍童子" then
    bbs[1] = 175
    bbs[2] = 1684
    bbs[3] = 1542
    bbs[4] = 3536
    bbs[5] = 2332
    bbs[6] = 1555
    bbs[7] = 1749
    bbs[8] = {1.265,1.27,1.275,1.28,1.285}
    bbs[9] = {"高级合纵","敏捷","高级法术抵抗","连击","神迹"}
    elseif bb == "持国巡守" then
    bbs[1] = 175
    bbs[2] = 1684
    bbs[3] = 1542
    bbs[4] = 3536
    bbs[5] = 2332
    bbs[6] = 1555
    bbs[7] = 1749
    bbs[8] = {1.265,1.27,1.275,1.28,1.285}
    bbs[9] = {"须弥真言","再生","奔雷咒","神佑复生"}
  elseif bb == "增长巡守" then
    bbs[1] = 175
    bbs[2] = 1684
    bbs[3] = 1542
    bbs[4] = 3536
    bbs[5] = 2332
    bbs[6] = 1555
    bbs[7] = 1749
    bbs[8] = {1.264,1.277,1.29,1.3,1.31}
    bbs[9] = {"合纵","高级敏捷","高级法术抵抗","高级连击","精神集中"}
  elseif bb == "般若天女" then
    bbs[1] = 175
    bbs[2] = 1684
    bbs[3] = 1542
    bbs[4] = 3536
    bbs[5] = 2332
    bbs[6] = 1555
    bbs[7] = 1749
    bbs[8] = {1.265,1.27,1.275,1.28,1.285}
    bbs[9] = {"须弥真言","再生","奔雷咒","神佑复生"}
  elseif bb == "灵灯侍者" then
    bbs[1] = 175
    bbs[2] = 1440
    bbs[3] = 1440
    bbs[4] = 3800
    bbs[5] = 2800
    bbs[6] = 1500
    bbs[7] = 1440
    bbs[8] = {1.264,1.277,1.29,1.3,1.31}
    bbs[9] = {"合纵","高级敏捷","高级法术抵抗","高级连击","精神集中"}
  elseif bb == "真陀护法" then
    bbs[1] = 175
    bbs[2] = 1684
    bbs[3] = 1542
    bbs[4] = 3536
    bbs[5] = 2332
    bbs[6] = 1555
    bbs[7] = 1749
    bbs[8] = {1.265,1.27,1.275,1.28,1.285}
    bbs[9] = {"高级精神集中","高级感知","偷袭","吸血","驱鬼","连击"}
  elseif bb == "谛听" then
    bbs[1] = 175
    bbs[2] = 1684
    bbs[3] = 1542
    bbs[4] = 3536
    bbs[5] = 2332
    bbs[6] = 1555
    bbs[7] = 1749
    bbs[8] = {1.265,1.27,1.275,1.28,1.285}
    bbs[9] = {"高级法术连击","魔之心","雷击","高级幸运","奔雷咒"}

  else
    bbs[1] = 15
    bbs[2] = 1080
    bbs[3] = 1140
    bbs[4] = 2520
    bbs[5] = 1800
    bbs[6] = 1500
    bbs[7] = 1500
    bbs[8] = {1.058,1.069,1.08,1.09,1.101}
    bbs[9] = {"连击","驱鬼","幸运","强力"}
  end
  return bbs
end


function 取天生(ac)
  local acs = {}
  if ac == "大海龟" then
    acs = {"水属性吸收","防御"}
  elseif ac == "巨蛙" then
    acs = {"弱点火"}
  elseif ac == "海星" then
    acs = {"弱点火","水属性吸收"}
  elseif ac == "章鱼" then
    acs = {"弱点火"}
  elseif ac == "海毛虫" then
    acs = {"弱点火","驱鬼"}
  elseif ac == "树怪" then
    acs = {"弱点火","迟钝"}
  elseif ac == "浣熊" then
    acs = {"招架"}
  elseif ac == "大蝙蝠" then
    acs = {"弱点水","高级驱鬼","飞行"}
  elseif ac == "花妖" then
    acs = {"水属性吸收"}
  elseif ac == "黑熊" then
    acs = {"迟钝"}
  elseif ac == "狐狸精" then
    acs = {"弱点雷","驱鬼"}
  elseif ac == "骷髅怪" then
    acs = {"弱点雷","鬼魂术"}
  elseif ac == "蟹将" then
    acs = {"水属性吸收"}
  elseif ac == "虾兵" then
    acs = {"水属性吸收"}
  elseif ac == "小龙女" then
    acs = {"高级水属性吸收"}
  elseif ac == "狼" then
    acs = {"连击","偷袭","驱鬼"}
  elseif ac == "野鬼" then
    acs = {"鬼魂术","驱鬼"}
  elseif ac == "僵尸" then
    acs = {"鬼魂术","驱鬼"}
  elseif ac == "黑熊精" then
    acs = {"弱点雷"}
  elseif ac == "兔子哥" then
    acs = {"弱点土"}
  elseif ac == "牛头" then
    acs = {"高级鬼魂术","驱鬼"}
  elseif ac == "马面" then
    acs = {"高级鬼魂术","驱鬼"}
  elseif ac == "白熊" then
    acs = {"迟钝"}
  elseif ac == "雷鸟人" then
    acs = {"弱点土","雷击","飞行"}
  elseif ac == "蝴蝶仙子" then
    acs = {"弱点水","飞行"}
  elseif ac == "鲛人" then
    acs = {"敏捷"}
  elseif ac == "蚌精" then
    acs = {"冥思"}
  elseif ac == "雨师" then
    acs = {"水攻"}
  elseif ac == "蛟龙" then
    acs = {"感知"}
  elseif ac == "凤凰" then
    acs = {"飞行"}
  elseif ac == "如意仙子" then
    acs = {"烈火"}
  elseif ac == "星灵仙子" then
    acs = {"雷击"}
  elseif ac == "鼠先锋" then
    acs = {"敏捷"}
  elseif ac == "百足将军" then
    acs = {"弱点水"}
  elseif ac == "犀牛将军人形" then
    acs = {"再生"}
  elseif ac == "犀牛将军兽形" then
    acs = {"落岩"}
  elseif ac == "锦毛貂精" then
    acs = {"敏捷"}
  elseif ac == "吸血鬼" then
    acs = {"弱点水","驱鬼","鬼魂术"}
  elseif ac == "幽灵" then
    acs = {"鬼魂术"}
  elseif ac == "灵符女蜗" then
    acs = {"落岩"}
  elseif ac == "画魂" then
    acs = {"高级鬼魂术","地狱烈火"}
  elseif ac == "幽萤娃娃" then
    acs = {"高级鬼魂术"}
  elseif ac == "鬼将" then
    acs = {"鬼魂术"}
  elseif ac == "净瓶女娲" then
    acs = {"感知"}
  elseif ac == "炎魔神" then
    acs = {"地狱烈火"}
  elseif ac == "机关人" then
    acs = {"高级招架"}
  elseif ac == "龙龟" then
    acs = {"水攻"}
  elseif ac == "猫灵兽形" then
    acs = {"弱点水"}
  elseif ac == "蝎子精" then
    acs = {"毒"}
  elseif ac == "葫芦宝贝" then
    acs = {"魔之心"}
  elseif ac == "踏云兽" then
    acs = {"弱点土"}
  elseif ac == "巴蛇" then
    acs = {"再生"}
  elseif ac == "机关兽" then
    acs = {"烈火"}
  elseif ac == "连弩车" then
    acs = {"迟钝"}
  elseif ac == "机关鸟" then
    acs = {"飞行"}
  elseif ac == "蜃气妖" then
    acs = {"雷击"}
  elseif ac == "蔓藤妖花" then
    acs = {"高级法术连击"}
  elseif ac == "长眉灵猴" then
    acs = {"奔雷咒"}
  elseif ac == "修罗傀儡鬼" then
    acs = {"嗜血追击"}
  elseif ac == "巨力神猿" then
    acs = {"敏捷"}
  elseif ac == "混沌兽" then
    acs = {"奔雷咒"}
  elseif ac == "狂豹人形" then
    acs = {"吸血","偷袭"}
  elseif ac == "猫灵人形" then
    acs = {"敏捷"}
  elseif ac == "曼珠沙华" then
    acs = {"高级再生"}
  elseif ac == "金身罗汉" then
    acs = {"高级敏捷"}
  elseif ac == "修罗傀儡妖" then
    acs = {"高级连击"}
  elseif ac == "小丫丫" then--孩子new
    acs = {"高级连击","高级防御"}
  elseif ac == "小毛头" then
    acs = {"高级连击","高级防御"}
  elseif ac == "小神灵" then
    acs = {"高级连击","高级防御"}
  elseif ac == "小精灵" then
    acs = {"高级连击","高级防御"}
  elseif ac == "小魔头" then
    acs = {"高级连击","高级防御"}
  elseif ac == "小仙女" then
    acs = {"高级连击","高级防御"}
  end
  return acs
end



function 取低级要诀()
  local ms = {"反震","合纵","夜战","弱点雷","弱点土","吸血",
          "反击","连击","飞行","隐身","感知","再生","冥思","慧根",
          "必杀","幸运","神迹","招架","永恒","敏捷","强力","防御",
          "偷袭","毒","驱鬼","鬼魂术","魔之心","神佑复生","精神集中",
          "否定信仰","雷击","落岩","水攻","烈火","法术连击",
          "法术暴击","法术波动","雷属性吸收","土属性吸收",
          "火属性吸收","水属性吸收","迟钝","弱点水"}

  return ms[取随机数(1,#ms)]
end


function 取高级要诀()
  local ms =  {"高级合纵","高级反震","高级吸血","法术防御","盾气","驱怪",
             "高级反击","高级连击","高级飞行","高级夜战","高级隐身","高级感知","高级再生",
             "高级冥思","高级慧根","高级必杀","高级幸运","高级神迹","高级招架","高级永恒",
             "高级敏捷","高级强力","高级防御","高级偷袭","高级毒","高级驱鬼","高级鬼魂术",
             "高级魔之心","高级神佑复生","高级精神集中","高级否定信仰","奔雷咒","泰山压顶",
             "水漫金山","地狱烈火","高级法术连击","高级法术暴击","高级法术波动","高级雷属性吸收",
             "高级土属性吸收","高级火属性吸收","高级水属性吸收"}
  return ms[取随机数(1,#ms)]
end


function 取特殊要诀()
  local ms =  {"上古灵符","千钧一怒","夜舞倾城","须弥真言","高级龙魂","进击法暴","进击必杀",
                "惊心一剑","八凶法阵","天降灵葫","嗜血追击","净台妙谛",
                "壁垒击破","力劈华山","善恶有报","剑荡四方","从天而降","死亡召唤","高级盾气"}

                --有效果暴不出来的
                --张弛有道 "灵山禅语",凝光炼彩,"流沙轻音","食指大动","叱咤风云",溜之大吉,赴汤蹈火,开门见山,昼伏夜出,高级驱怪
                --神出鬼没,"移花接木","高级进击必杀","高级进击法暴","观照万象","大快朵颐","浮云神马",
                --"理直气壮","灵能激发","苍鸾怒击",,"月光"
                --"凭风借力","狂莽一击","虎虎生威","出其不意","风起龙游" "北冥之渊" "气贯长虹" "无畏布施"  "神来气旺" "水击三千" "哼哼哈兮"
                --  "义薄云天"

  return ms[取随机数(1,#ms)]
end

function 取超级要诀()
  local ms =  {"超级毒","超级夜战","超级反震","超级吸血","超级连击","超级飞行","超级隐身",
               "超级感知","超级再生","超级冥思","超级驱鬼","超级慧根", "超级必杀","超级幸运",
               "超级神迹","超级招架","超级永恒","超级敏捷","超级偷袭","超级强力","超级防御",
               "超级盾气","超级合纵","超级驱怪","超级魔之心","超级奔雷咒","超级泰山压顶","超级水漫金山",
               "超级地狱烈火","超级进击必杀","超级进击法暴","超级法术连击","超级法术暴击",
               "超级法术波动","超级壁垒击破","超级法术抵抗","超级精神集中","超级否定信仰",
               "超级雷属性吸收","超级土属性吸收","超级水属性吸收","超级火属性吸收"}
  return ms[取随机数(1,#ms)]
end


function 取召唤兽技能编号(技能组,超级名称)
    local 超级技能=分割文本(超级名称,"超级")
    local 编号=0
    local 技能="高级"..超级技能[2]
    if 超级技能[2]=="奔雷咒" or 超级技能[2]=="泰山压顶"  or 超级技能[2]=="水漫金山" or 超级技能[2]=="地狱烈火" or 超级技能[2]=="壁垒击破" then
        技能=超级技能[2]
    end
    for i,v in ipairs(技能组) do
       if v == 技能 then
           编号=i
       end
    end
    return 编号,技能
end




兽决被动={反震=1,合纵=1,夜战=1,弱点雷=1,弱点土=1,吸血=1,反击=1,连击=1,飞行=1,隐身=1,感知=1,再生=1,冥思=1,慧根=1,必杀=1,幸运=1,神迹=1,
      招架=1,永恒=1,敏捷=1,强力=1,防御=1,偷袭=1,毒=1,驱鬼=1,鬼魂术=1,魔之心=1,神佑复生=1,精神集中=1,否定信仰=1,法术连击=1,法术暴击=1,法术波动=1,雷属性吸收=1,
      火属性吸收=1,水属性吸收=1,土属性吸收=1,迟钝=1,弱点水=1
}
for k,v in pairs(兽决被动) do
    兽决被动["高级"..k]=1
    兽决被动["超级"..k]=1
end
local 临时兽决 = {"凭风借力","出其不意","风起龙游","虎虎生威","气贯长虹","狂莽一击",}
for k,v in ipairs(临时兽决) do
    兽决被动[v]=1
end





function 取一代神兽()
  local ms =  {"超级泡泡", "超级灵鹿","超级腾蛇","超级白泽","超级金猴","超级玉兔","超级大熊猫","超级人参娃娃"}
  return ms[取随机数(1,#ms)]
end


function 取是否一代神兽(模型)
  local ms =  {"超级泡泡", "超级灵鹿","超级腾蛇","超级白泽","超级金猴","超级玉兔","超级大熊猫","超级人参娃娃"}
  for  i=1,#ms do
    if 模型 == ms[i] then
      return true
    end
  end

  return false
end

function 取二代神兽()
  local ms =  {"超级孔雀","恶魔泡泡","超级青鸾","超级灵狐","超级赤焰兽","超级筋斗云","超级赤焰兽","超级土地公公","超级六耳猕猴","超级飞廉",
               "自在心猿","进阶沙暴","超级红孩儿","超级神柚"}
  return ms[取随机数(1,#ms)]
end



function 取是否二代神兽(模型)
  local ms =  {"超级孔雀","恶魔泡泡","超级青鸾","超级灵狐","超级赤焰兽","超级筋斗云","超级赤焰兽","超级土地公公","超级六耳猕猴","超级飞廉",
               "自在心猿","进阶沙暴","超级红孩儿","超级神柚"}
  for  i=1,#ms do
    if 模型 == ms[i] then
      return true
    end
  end
  return false
end


function 取三代神兽()
  local ms =  {"超级神猪","超级神狗","超级神狗","超级神鸡","超级神猴","超级神羊","超级神马","超级神蛇","超级神龙",
               "超级神兔","超级神虎","超级神牛","超级神鼠","超级海豚","超级大鹏","超级大象","超级麒麟","超级翼龙"}
  return ms[取随机数(1,#ms)]
end



function 取四代神兽()
  local ms =  {"独角兽","月影","雪仙","花仙","小精灵","裁决者","葬送者","画江湖","超级尾巴","超级阿狸","飞天",
               "超级贪狼","超级武罗","超级小白龙","超级猪小戒","超级小猴子","超级小萝莉","超级帝释天","赵云",
               "貂蝉","关羽","吕布","碧瑶","凤九","鬼厉","剑圣","怜星","龙儿","阿朱","洛神","普智","人皇",
               "小昭","雄霸","邀月","赵敏","白子画","花无缺","巨灵神","李蓉蓉","李逍遥","凌凌漆","陆雪琪",
               "杀阡陌","万人往","尉迟恭","张小凡","紫霞仙子","青霞仙子","通臂猿猴","有苏鸠","司雨","进阶司雨","觉醒涂山雪",
               "泡泡仙灵·飞燕女","泡泡仙灵·骨精灵","泡泡仙灵·剑侠客","泡泡仙灵·龙太子","泡泡仙灵·杀破狼",
               "泡泡仙灵·神天兵","泡泡仙灵·巫蛮儿","泡泡仙灵·羽灵神","暗黑谛听","暗黑童子","彩蝶女孩","彩蝶男孩"}



  return ms[取随机数(1,#ms)]
end






function 取认证法术()
  local ms = {"反震","吸血","反击","连击","飞行","驱怪","隐身","感知","再生","冥思","慧根","必杀","幸运","神迹","招架","永恒","敏捷","强力","防御","偷袭","毒","驱鬼","鬼魂术","魔之心","神佑复生","精神集中","否定信仰","法术连击","法术暴击","法术波动","雷属性吸收","土属性吸收","火属性吸收","水属性吸收","迟钝"}
  return ms[取随机数(1,#ms)]
end

function 观照万象()
  local ms =  {"观照万象"}
  return ms[取随机数(1,#ms)]
end

function 取钟灵石()
  local ms =  {"心源","固若金汤","锐不可当","通真达灵","气血方刚","健步如飞","心无旁骛","回春之术","风雨不动","气壮山河"}
  return ms[取随机数(1,#ms)]
end


function DeepCopy(object)
  local lookup_table = {}
  local function _copy(object)
    if type(object) ~= "table" then
      return object
    elseif lookup_table[object] then
      return lookup_table[object]
    end
    local new_table = {}
    lookup_table[object] = new_table
    for key, value in pairs(object) do
      new_table[_copy(key)] = _copy(value)
    end
    return setmetatable(new_table, getmetatable(object))
  end
  return _copy(object)
end




 -- if  类型=="水陆大会" or 类型=="通天河" or 类型=="幻域迷宫" or 类型=="乌鸡副本" or 类型=="车迟副本"   then
 --      活动次数[类型][id]=1
 --      elseif 类型=="师门任务" then
 --      活动次数[类型][id]=20
 --      elseif 类型=="抓鬼任务" then
 --      活动次数[类型][id]=100
 --      elseif 类型=="游泳比赛" then
 --      活动次数[类型][id]=40
 --      elseif 类型=="知了王"then
 --      活动次数[类型][id]=50
 --      elseif 类型=="知了先锋" then
 --      活动次数[类型][id]=100
 --      elseif 类型=="天庭叛逆"then
 --      活动次数[类型][id]=50
 --      elseif 类型=="可恶的病毒" then
 --      活动次数[类型][id]=100
 --      elseif 类型=="封妖战斗" then
 --      活动次数[类型][id]=50
 --      elseif 类型=="妖魔鬼怪" then
 --      活动次数[类型][id]=100
 --      elseif 类型=="地煞星" then
 --      活动次数[类型][id]=20
 --      elseif 类型=="三界悬赏令" or 类型=="天罡星" or 类型=="创世佛屠" or 类型=="善恶如来" or 类型=="三国武圣"  then
 --      活动次数[类型][id]=20
 --      elseif 类型=="跑环" then
 --      活动次数[类型][id]=1
 --      elseif 类型=="押镖" then
 --      活动次数[类型][id]=10
 --      elseif 类型=="门派闯关" then
 --      活动次数[类型][id]=12
 --      elseif 类型=="镖王押镖" then
 --      活动次数[类型][id]=2
 --      elseif 类型=="皇宫飞贼" then
 --      活动次数[类型][id]=10
 --      elseif 类型=="皇宫飞贼贼王" then
 --      活动次数[类型][id]=2
 --      elseif 类型=="世界BOSS" then
 --      活动次数[类型][id]=3
 --      elseif 类型=="初出江湖" then
 --      活动次数[类型][id]=20
 --      elseif 类型=="官职任务" then
 --      活动次数[类型][id]=20
 --      elseif 类型=="建邺城赏金任务"then
 --      活动次数[类型][id]=20
 --      elseif 类型=="青龙任务" then
 --      活动次数[类型][id]=10
 --      elseif 类型=="玄武任务" then
 --      活动次数[类型][id]=10
 --      elseif 类型=="宝藏山小宝箱" then
 --      活动次数[类型][id]=10
 --      elseif 类型=="宝藏山大宝箱" then
 --      活动次数[类型][id]=5
 --      elseif 类型=="星宿" then
 --      活动次数[类型][id]=30
 --      elseif 类型=="妖王" then
 --      活动次数[类型][id]=10
 --      elseif 类型=="跑商" then
 --      活动次数[类型][id]=50
 --      elseif 类型=="降妖伏魔" then
 --      活动次数[类型][id]=50
 --      elseif 类型=="法宝材料" then
 --      活动次数[类型][id]=2
 --      elseif 类型=="法宝内丹" then
 --      活动次数[类型][id]=1
 --      elseif 类型=="宠物跑环" then
 --      活动次数[类型][id]=1
 --    end
--修正飞蛾丢失的函数 end
function 添加活动次数(id,类型)
  if 活动次数[类型]==nil then   --如果没有这个类型则添加这个类型
    活动次数[类型]={}
  end
  if 活动次数[类型][id]==nil then
    if 自定义数据.活动次数[类型]==nil then
        活动次数[类型][id]=1
    else
        活动次数[类型][id]=自定义数据.活动次数[类型]
    end
  end
  活动次数[类型][id] = 活动次数[类型][id] - 1
  if 活动次数[类型][id]<=0 then
    常规提示(id,"#Y/你已经完成了今日所有#G/"..类型.."#Y/活动!")
  else
    常规提示(id,"#Y/你已经完成了一次#G/"..类型.."#Y/活动，今日还可以挑战#R/"..活动次数[类型][id].."#Y/次！")
  end
end

function 活动次数查询(id,类型)  --查询活动次数
  if 活动次数[类型]==nil then   --如果没有这个类型则添加这个类型
    活动次数[类型]={}
  end
  local id组={}
  if 玩家数据[id].队伍==0 then   --判断这个是否有队伍  没有队伍则统计单人次数,有队伍则统计队伍次数
    id组[1]=id
  else
    local 队伍id=玩家数据[id].队伍
    for n=1,#队伍数据[队伍id].成员数据 do
      id组[n]=队伍数据[队伍id].成员数据[n]
    end
  end
  for n=1,#id组 do
    if 活动次数[类型][id组[n]]~=nil and 活动次数[类型][id组[n]]<=0 then  --判断队伍中是否有人次数达到上限
      常规提示(id,"#Y/队伍中#R/"..玩家数据[id组[n]].角色.数据.名称.."#Y/的挑战#G/["..类型.."]#Y/活动已经达到次数上限啦")
      return false
    end
  end
  return true
end





取所有动物套 = {
  "强盗","海毛虫","蛤蟆精","老虎","马面","天将","地狱战神","巡游天神","鬼将","夜罗刹","噬天虎","狂豹人形","巨力神猿","修罗傀儡鬼",
  "大海龟","树怪","山贼","野猪","黑熊","野鬼","龟丞相","黑熊精","僵尸","白熊","黑山老妖","大力金刚","踏云兽","机关兽","金身罗汉",
  "蔓藤妖花","巨蛙","花妖","小龙女","蜘蛛精","蝴蝶仙子","古代瑞兽","蛟龙","雨师","如意仙子","星灵仙子","净瓶女娲","灵符女娲","灵鹤",
  "炎魔神","葫芦宝贝","混沌兽","混沌兽","长眉灵猴","蜃气妖","护卫","羊头怪","牛妖","蟹将","牛头","天兵","芙蓉仙子","律法女娲",
  "幽萤娃娃","红萼仙子","龙龟","连弩车","蝎子精","曼珠沙华","赌徒","大蝙蝠","骷髅怪","狐狸精","狼","虾兵","兔子怪","雷鸟人","风伯",
  "凤凰","幽灵","吸血鬼","画魂","雾中仙","机关鸟","巴蛇","猫灵人形","修罗傀儡妖"
}

function 取动物套加成(名称,等级)
  local 动物套数据 = {}
  --力量套
  动物套数据["强盗"] = {类型="力量",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["海毛虫"] = {类型="力量",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["蛤蟆精"] = {类型="力量",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["老虎"] = {类型="力量",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["马面"] = {类型="力量",属性=math.floor(等级/5),件数={10,15}}
  动物套数据["天将"] = {类型="力量",属性=math.floor(等级/5),件数={10,15}}
  动物套数据["地狱战神"] = {类型="力量",属性=math.floor(等级/5),件数={10,15}}
  动物套数据["巡游天神"] = {类型="力量",属性=math.floor(等级/4),件数={10,15}}
  动物套数据["鬼将"] = {类型="力量",属性=math.floor(等级/4),件数={10,15}}
  动物套数据["夜罗刹"] = {类型="力量",属性=math.floor(等级/4),件数={15,25}}
  动物套数据["噬天虎"] = {类型="力量",属性=math.floor(等级/4),件数={15,25}}
  动物套数据["狂豹人形"] = {类型="力量",属性=math.floor(等级/4),件数={15,25}}
  动物套数据["巨力神猿"] = {类型="力量",属性=math.floor(等级/3),件数={5,15}}
  动物套数据["修罗傀儡鬼"] = {类型="力量",属性=math.floor(等级/3),件数={5,15}}
  --体质套
  动物套数据["大海龟"] = {类型="体质",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["树怪"] = {类型="体质",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["山贼"] = {类型="体质",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["野猪"] = {类型="体质",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["黑熊"] = {类型="体质",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["野鬼"] = {类型="体质",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["龟丞相"] = {类型="体质",属性=math.floor(等级/5),件数={10,15}}
  动物套数据["黑熊精"] = {类型="体质",属性=math.floor(等级/5),件数={10,15}}
  动物套数据["僵尸"] = {类型="体质",属性=math.floor(等级/5),件数={10,15}}
  动物套数据["白熊"] = {类型="体质",属性=math.floor(等级/5),件数={10,15}}
  动物套数据["黑山老妖"] = {类型="体质",属性=math.floor(等级/5),件数={10,15}}
  动物套数据["大力金刚"] = {类型="体质",属性=math.floor(等级/4),件数={15,25}}
  动物套数据["踏云兽"] = {类型="体质",属性=math.floor(等级/4),件数={15,25}}
  动物套数据["机关兽"] = {类型="体质",属性=math.floor(等级/4),件数={15,25}}
  动物套数据["金身罗汉"] = {类型="体质",属性=math.floor(等级/3),件数={5,15}}
  动物套数据["蔓藤妖花"] = {类型="体质",属性=math.floor(等级/3),件数={5,15}}
  --魔力套
  动物套数据["巨蛙"] = {类型="魔力",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["花妖"] = {类型="魔力",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["小龙女"] = {类型="魔力",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["蜘蛛精"] = {类型="魔力",属性=math.floor(等级/5),件数={10,15}}
  动物套数据["蝴蝶仙子"] = {类型="魔力",属性=math.floor(等级/5),件数={10,15}}
  动物套数据["古代瑞兽"] = {类型="魔力",属性=math.floor(等级/5),件数={10,15}}
  动物套数据["蛟龙"] = {类型="魔力",属性=math.floor(等级/4),件数={10,15}}
  动物套数据["雨师"] = {类型="魔力",属性=math.floor(等级/4),件数={10,15}}
  动物套数据["如意仙子"] = {类型="魔力",属性=math.floor(等级/4),件数={10,15}}
  动物套数据["星灵仙子"] = {类型="魔力",属性=math.floor(等级/4),件数={10,15}}
  动物套数据["净瓶女娲"] = {类型="魔力",属性=math.floor(等级/4),件数={10,15}}
  动物套数据["灵符女娲"] = {类型="魔力",属性=math.floor(等级/4),件数={10,15}}
  动物套数据["灵鹤"] = {类型="魔力",属性=math.floor(等级/4),件数={15,25}}
  动物套数据["炎魔神"] = {类型="魔力",属性=math.floor(等级/4),件数={15,25}}
  动物套数据["葫芦宝贝"] = {类型="魔力",属性=math.floor(等级/4),件数={15,25}}
  动物套数据["混沌兽"] = {类型="魔力",属性=math.floor(等级/3),件数={5,15}}
  动物套数据["长眉灵猴"] = {类型="魔力",属性=math.floor(等级/3),件数={5,15}}
  动物套数据["蜃气妖"] = {类型="魔力",属性=math.floor(等级/3),件数={5,15}}
  --耐力套
  动物套数据["护卫"] = {类型="耐力",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["羊头怪"] = {类型="耐力",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["牛妖"] = {类型="耐力",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["蟹将"] = {类型="耐力",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["牛头"] = {类型="耐力",属性=math.floor(等级/5),件数={10,15}}
  动物套数据["天兵"] = {类型="耐力",属性=math.floor(等级/5),件数={10,15}}
  动物套数据["芙蓉仙子"] = {类型="耐力",属性=math.floor(等级/4),件数={10,15}}
  动物套数据["律法女娲"] = {类型="耐力",属性=math.floor(等级/4),件数={10,15}}
  动物套数据["幽萤娃娃"] = {类型="耐力",属性=math.floor(等级/4),件数={15,25}}
  动物套数据["红萼仙子"] = {类型="耐力",属性=math.floor(等级/4),件数={15,25}}
  动物套数据["龙龟"] = {类型="耐力",属性=math.floor(等级/4),件数={15,25}}
  动物套数据["连弩车"] = {类型="耐力",属性=math.floor(等级/4),件数={15,25}}
  动物套数据["蝎子精"] = {类型="耐力",属性=math.floor(等级/3),件数={5,15}}
  动物套数据["曼珠沙华"] = {类型="耐力",属性=math.floor(等级/3),件数={5,15}}
  --敏捷套
  动物套数据["赌徒"] = {类型="敏捷",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["大蝙蝠"] = {类型="敏捷",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["骷髅怪"] = {类型="敏捷",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["狐狸精"] = {类型="敏捷",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["狼"] = {类型="敏捷",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["虾兵"] = {类型="敏捷",属性=math.floor(等级/6),件数={5,10}}
  动物套数据["兔子怪"] = {类型="敏捷",属性=math.floor(等级/5),件数={10,15}}
  动物套数据["雷鸟人"] = {类型="敏捷",属性=math.floor(等级/5),件数={10,15}}
  动物套数据["风伯"] = {类型="敏捷",属性=math.floor(等级/5),件数={10,15}}
  动物套数据["凤凰"] = {类型="敏捷",属性=math.floor(等级/4),件数={10,15}}
  动物套数据["幽灵"] = {类型="敏捷",属性=math.floor(等级/4),件数={10,15}}
  动物套数据["吸血鬼"] = {类型="敏捷",属性=math.floor(等级/4),件数={10,15}}
  动物套数据["画魂"] = {类型="敏捷",属性=math.floor(等级/4),件数={15,25}}
  动物套数据["雾中仙"] = {类型="敏捷",属性=math.floor(等级/4),件数={15,25}}
  动物套数据["机关鸟"] = {类型="敏捷",属性=math.floor(等级/4),件数={15,25}}
  动物套数据["巴蛇"] = {类型="敏捷",属性=math.floor(等级/4),件数={15,25}}
  动物套数据["猫灵人形"] = {类型="敏捷",属性=math.floor(等级/4),件数={15,25}}
  动物套数据["修罗傀儡妖"] = {类型="敏捷",属性=math.floor(等级/3),件数={5,15}}
  return 动物套数据[名称]
end

function 判断n号帮(id,编号)
  local id组={}
  if 玩家数据[id].队伍==0 then
    id组[1]=id
  else
    local 队伍id=玩家数据[id].队伍
    for n=1,#队伍数据[队伍id].成员数据 do
     id组[n]=队伍数据[队伍id].成员数据[n]
    end
  end
  for n=1,#id组 do
    if 玩家数据[id组[n]].角色.数据.帮派数据.编号~=编号 or 编号<=0 or 玩家数据[id组[n]].角色.数据.帮派数据.编号<=0 then
      return false
    end
  end
  return true
end




function 保留小数位数(nNum, n)
    if type(nNum) ~= "number" then
        return nNum;
    end

    n = n or 0;
    n = math.floor(n)
    local fmt = '%.' .. n .. 'f'
    local nRet = tonumber(string.format(fmt, nNum))

    return nRet;
end

function 文件是否存在(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function 随机排序(tbl)
  local n = #tbl
  for i = 1, n do
    local j =math.random(i,n)
      if j>i then
          tbl[i], tbl[j] = tbl[j], tbl[i]
      end
    end
end

function 铃铛奖励生成(玩家id,名称,数量)
  local 铃铛奖励数据=nil
  local 识别码=取唯一识别码(玩家id)
  铃铛奖励数据=物品类()
  铃铛奖励数据:置对象(名称)
  临时道具 = 取物品数据(名称)
  临时道具.总类=临时道具[2]
  临时道具.子类=临时道具[4]
  临时道具.分类=临时道具[3]
  if 名称=="点化石" then
      if 取随机数(1,100)<=1 then
      铃铛奖励数据.附带技能="剑荡四方"
    elseif 取随机数(1,100)<=5 then
      铃铛奖励数据.附带技能=取高级要诀()
    else
      铃铛奖励数据.附带技能=取低级要诀()
    end
  elseif 名称=="藏宝图" or 名称=="高级藏宝图" then

  elseif 名称=="神兜兜" then
    铃铛奖励数据.数量=数量
  elseif 名称=="珍珠" then
    铃铛奖励数据.级别限制=数量
  elseif 名称=="清灵净瓶" then
    铃铛奖励数据.数量=数量
  elseif 名称=="魔兽要诀" then

  elseif 名称=="高级魔兽要诀" then
  elseif 名称=="召唤兽内丹" then
  elseif 名称=="百炼精铁" then
    铃铛奖励数据.子类=数量
  elseif 名称=="金柳露" then
    铃铛奖励数据.数量=数量
  elseif 名称=="超级金柳露" then
    铃铛奖励数据.数量=数量
  elseif 名称=="九转金丹" then
    铃铛奖励数据.阶品=数量
  end
  if 铃铛奖励数据.可叠加 then
    铃铛奖励数据.数量=数量
  end
  铃铛奖励数据.识别码=识别码
  return 铃铛奖励数据
end

function 播放引擎动画(id,动画编号)
  发送数据(玩家数据[id].连接id,3902,{编号=动画编号})
end

低级兽决 = {"反震","合纵","夜战","弱点雷","弱点土","吸血","反击","连击","飞行","隐身","感知","再生","冥思","慧根","必杀","幸运","神迹","招架","永恒","敏捷","强力","防御","偷袭","毒","驱鬼","鬼魂术","魔之心","神佑复生","精神集中","否定信仰","雷击","落岩","水攻","烈火","法术连击","法术暴击","法术波动","雷属性吸收","土属性吸收","火属性吸收","水属性吸收","迟钝","弱点水"}
高级兽决 = {"高级合纵","高级反震","高级进击必杀","高级进击法暴","高级吸血","高级反击","高级连击","高级飞行","高级夜战","高级隐身","高级感知","高级再生","高级冥思","高级慧根","高级必杀","高级幸运","高级神迹","高级招架","高级永恒","高级敏捷","高级强力","高级防御","高级偷袭","高级毒","高级驱鬼","高级鬼魂术","高级魔之心","高级神佑复生","高级精神集中","高级否定信仰","奔雷咒","泰山压顶","水漫金山","地狱烈火","高级法术连击","高级法术暴击","高级法术波动","高级雷属性吸收","高级土属性吸收","高级火属性吸收","高级水属性吸收"}


-- function 初始化交易中心()
--   local 装备相关={}
--   table.insert(装备相关,{类型="100装备相关",内容=取制造指南书组(100)})
--   table.insert(装备相关,{类型="110装备相关",内容=取制造指南书组(110)})
--   table.insert(装备相关,{类型="70装备相关",内容=取制造指南书组(70)})
--   table.insert(装备相关,{类型="70装备相关",内容=取制造指南书组(80)})
--   table.insert(交易中心,装备相关)
--   local 兽决相关={}
--   table.insert(兽决相关,{类型="低级魔兽要诀",内容=取低级魔兽要诀组()})
--   table.insert(兽决相关,{类型="高级魔兽要诀",内容=取高级魔兽要诀组()})
--   table.insert(交易中心,兽决相关)
--   写出文件([[tysj/交易中心.txt]],table.tostring(交易中心))
--   __S服务:输出("初始化交易中心成功")
-- end



-- function 更新交易中心涨跌幅()
--   for i=1,#交易中心 do
--       for n=1,#交易中心[i] do
--           for k=1,#交易中心[i][n].内容 do
--               交易中心[i][n].内容[k].日涨跌幅 = 0.0
--           end
--       end
--   end
--   写出文件([[tysj/交易中心.txt]],table.tostring(交易中心))
--   __S服务:输出("交易中心日涨跌幅更新成功")
-- end

function 取制造指南书组(等级)
  local 制造指南书数组={}
  local 初始价格=100000
  if 等级<= 50 then
    初始价格=等级*800
  elseif 等级<= 100 then
    初始价格=等级*40000
  elseif 等级<=120 then
    初始价格=等级*80000
  end
  local 铁数据={名称="百炼精铁",参数一类型="子类",参数一=等级,价格=math.floor(初始价格/2),日涨跌幅=0.0}
  table.insert(制造指南书数组,铁数据)
  for i=1,25 do
    local 临时指南={名称="制造指南书",参数一类型="子类",参数一=等级,参数二类型="特效",参数二=i,价格=初始价格,日涨跌幅=0.0}
    table.insert(制造指南书数组,临时指南)
  end
  return 制造指南书数组
end

function 取低级魔兽要诀组()
  local 低级兽决数组={}
  for i=1,#低级兽决 do
    local 临时兽决={名称="魔兽要诀",参数一类型="附带技能",参数一=低级兽决[i],价格=40000,日涨跌幅=0.0}
    table.insert(低级兽决数组,临时兽决)
  end
  return 低级兽决数组
end

function 取高级魔兽要诀组()
  local 高级兽决数组={}
  for i=1,#高级兽决 do
    local 初始价格=300000
    if 高级兽决[i] == "高级进击必杀" or 高级兽决[i] == "高级夜战" or 高级兽决[i] == "高级强力" or 高级兽决[i] == "高级敏捷" or
    高级兽决[i] == "高级法术连击" or 高级兽决[i] == "高级法术暴击" or 高级兽决[i] == "高级进击法暴" or 高级兽决[i] == "高级进击法暴"
    or 高级兽决[i] == "高级法术波动" or 高级兽决[i] == "高级魔之心" or 高级兽决[i] == "高级飞行" or 高级兽决[i] == "高级隐身" then
      初始价格=2000000
    elseif 高级兽决[i] == "高级必杀" or 高级兽决[i] == "高级吸血" or 高级兽决[i] == "高级连击" or 高级兽决[i] == "高级偷袭" or 高级兽决[i] == "高级神佑复生"
      or 高级兽决[i] == "奔雷咒" or 高级兽决[i] == "地狱烈火" or 高级兽决[i] == "水漫金山" or 高级兽决[i] == "泰山压顶" then
      初始价格=3000000
    end
    local 临时兽决={名称="高级魔兽要诀",参数一类型="附带技能",参数一=高级兽决[i],价格=初始价格,日涨跌幅=0.0}
    table.insert(高级兽决数组,临时兽决)
  end
  return 高级兽决数组
end

-- function 获取交易中心列表(类型,类名)
--   for i=1,#交易中心[类型] do
--     if 交易中心[类型][i].类型 == 类名 then
--       return 交易中心[类型][i].内容,i
--     end
--   end
--   return nil,nil
-- end

-- function 取NPC寻路信息(地图,NPC名称,x,y )
--   local NPC采集 = "#Y/xx/"..地图.."|"..NPC名称.."|"..x.."|"..y.."|#W"
--   return NPC采集
-- end

function 数组去重(a)
    local b = {}
    for k,v in ipairs(a) do
        if(#b == 0) then
            b[1]=v;
        else
            local index = 0
            for i=1,#b do
                if(v == b[i]) then
                    break

                end
                index = index + 1
            end
            if(index == #b) then
                b[#b + 1] = v;
            end
        end
    end
    return b
end


一级符石 = {"冰符石","土符石","雷符石","电符石","风符石","炎符石","火符石"}
二级符石 = {"红云符石","碧玉符石","金光符石","天神符石","飘渺符石","天仙符石","霞光符石","逍遥符石"}
三级符石 = {"虹珀符石","陌影符石","北冥符石","灵月符石","锦瑟符石","银光符石","清心符石","星辰符石","雪月符石","玄魂符石","乾坤符石","珍珀符石",
      "银竹符石","神川符石","玲珑符石","暮影符石","天珍符石","九影符石","百冥符石","莫念符石","醉魂符石","玄羽符石","霸风符石","无相符石",
      "无极符石","紫晶符石","圣火符石","昔光符石","子蚀符石","流风符石","地炎符石","素影符石","燕灵符石","降龙符石","苍玉符石","流魂符石",
      "九凤符石","墨陀符石","南夕符石","引幽符石","波涛符石","铃星符石","狂念符石","乱花符石","幽月符石","两仪符石","七情符石","召影符石"}
新三级符石 = {"太极符石","阴仪符石","阳仪符石","太阴符石","少阴符石","少阳符石","太阳符石"}




所有神兽模型={超级泡泡=1,超级灵鹿=1,超级腾蛇=1,超级白泽=1,超级金猴=1,超级玉兔=1,超级大熊猫=1,超级人参娃娃=1,超级孔雀=1,超级青鸾=1,
             超级灵狐=1,超级赤焰兽=1,超级筋斗云=1,超级土地公公=1,超级六耳猕猴=1,超级神猪=1,超级神狗=1,超级神鸡=1,超级神猴=1,超级神羊=1,
             超级神马=1,超级神蛇=1,超级神龙 =1,超级神兔=1,超级神虎=1,超级神牛=1,超级神鼠=1,超级海豚=1,超级大鹏=1,超级大象=1,超级麒麟=1,
             超级翼龙=1,独角兽=1,月影=1,飞天=1,雪仙=1,花仙=1,裁决者=1,葬送者=1,画江湖=1,超级尾巴=1,超级阿狸=1,超级贪狼=1,超级武罗=1,
             超级小白龙=1,超级猪小戒=1,超级小猴子=1,超级小萝莉=1,超级帝释天=1,赵云=1,貂蝉=1,关羽=1,吕布=1,碧瑶=1,凤九=1,鬼厉=1,龙儿=1,
             阿朱=1,洛神=1,剑圣=1,怜星=1,普智=1,人皇=1,小昭=1,雄霸=1,邀月=1,赵敏=1,白子画=1,花无缺=1,巨灵神=1,李蓉蓉=1,李逍遥=1,凌凌漆=1,
             陆雪琪=1,杀阡陌=1,万人往=1,尉迟恭=1,张小凡=1,紫霞仙子=1,青霞仙子=1,通臂猿猴=1,恶魔泡泡=1,超级飞廉=1,自在心猿=1,进阶沙暴=1,
             超级红孩儿=1,超级神柚=1,有苏鸠=1,司雨=1,进阶司雨=1,觉醒涂山雪=1}

所有召唤兽模型={白熊=1,雨师=1,天兵=1,天将=1,风伯=1,凤凰=1,蛟龙=1,鲛人=1,蚌精=1,泪妖=1,镜妖=1,画魂=1,巴蛇=1,龙龟=1,灵鹤=1,琴仙=1,鬼将=1,
                幽灵=1,谛听=1,雷鸟人=1,野猪精=1,鼠先锋=1,阴阳伞=1,炎魔神=1,噬天虎=1,踏云兽=1,吸血鬼=1,机关鸟=1,机关人=1,雾中仙=1,夜罗刹=1,
                连弩车=1,机关兽=1,混沌兽=1,金铙僧=1,蝎子精=1,蜃气妖=1,长眉灵猴=1,古代瑞兽=1,蝴蝶仙子=1,巡游天神=1,黑山老妖=1,地狱战神=1,
                碧水夜叉=1,如意仙子=1,芙蓉仙子=1,星灵仙子=1,锦毛貂精=1,千年蛇魅=1,百足将军=1, 律法女娲=1, 灵符女娲=1,净瓶女娲=1,红萼仙子=1,
                大力金刚=1,葫芦宝贝=1,幽萤娃娃=1,猫灵人形=1,猫灵兽形=1,狂豹人形=1,狂豹兽形=1,曼珠沙华=1,巨力神猿=1,金身罗汉=1,蔓藤妖花=1,
                灵灯侍者=1,毗舍童子=1,持国巡守=1,真陀护法=1,增长巡守=1,般若天女=1,修罗傀儡鬼=1,修罗傀儡妖=1, 犀牛将军人形=1,犀牛将军兽形=1}







地宫怪物模型={"大海龟","巨蛙","海星","章鱼","海毛虫","树怪","浣熊","大蝙蝠","花妖","黑熊",
"狐狸精","骷髅怪","蟹将","虾兵","小龙女","狼","野鬼","僵尸","黑熊精","兔子怪",
"牛头","马面","白熊","雷鸟人","蝴蝶仙子","鲛人","蚌精","雨师","蛟龙","凤凰",
"如意仙子","星灵仙子","鼠先锋","百足将军","犀牛将军人形","犀牛将军兽形","锦毛貂精","吸血鬼","幽灵","灵符女娲",
"画魂","幽萤娃娃","鬼将","净瓶女娲","炎魔神","机关人","龙龟","猫灵兽形","蝎子精","葫芦宝贝",
"踏云兽","巴蛇","机关兽","连弩车","机关鸟","蜃气妖","蔓藤妖花","长眉灵猴","修罗傀儡鬼","巨力神猿",--
"混沌兽","狂豹人形","猫灵人形","曼珠沙华","金身罗汉","修罗傀儡妖","超级泡泡", "超级灵鹿","超级腾蛇","超级白泽",
"超级金猴","超级玉兔","超级大熊猫","超级人参娃娃","超级孔雀","超级青鸾","超级灵狐","超级赤焰兽","超级筋斗云","超级赤焰兽",
"超级土地公公","超级六耳猕猴","超级神猪",
"超级神狗","超级神狗","超级神鸡","超级神猴","超级神羊","超级神马","超级神蛇",
"超级神龙","超级神兔","超级神虎","超级神牛","超级神鼠","超级海豚","超级大鹏",
"超级大象","超级麒麟","超级翼龙","月影","雪仙","花仙","小精灵","裁决者","葬送者",
"画江湖","超级尾巴","超级阿狸","飞天","超级贪狼","超级武罗","超级小白龙","超级猪小戒",
"超级小猴子","超级小萝莉","超级帝释天","赵云","貂蝉","关羽","吕布","碧瑶","凤九","鬼厉",
"剑圣","怜星","龙儿","阿朱","洛神","普智","人皇","小昭","雄霸","邀月","赵敏","白子画",
"花无缺","巨灵神","李蓉蓉","李逍遥","凌凌漆","陆雪琪","杀阡陌","万人往","尉迟恭",
"张小凡","紫霞仙子","青霞仙子","通臂猿猴","超级麒麟","超级翼龙","月影","雪仙","花仙",
"小精灵","裁决者","葬送者","画江湖","超级尾巴","超级阿狸","飞天","超级贪狼","超级武罗",
"超级小白龙","超级猪小戒","超级小猴子","超级小萝莉","超级帝释天","赵云","貂蝉","关羽",
"吕布","碧瑶","凤九","鬼厉","剑圣","怜星","龙儿","阿朱","洛神","普智","人皇","小昭",
"雄霸","邀月","赵敏","白子画","花无缺","巨灵神","李蓉蓉","李逍遥","凌凌漆","陆雪琪",
"杀阡陌","万人往","尉迟恭","张小凡","紫霞仙子","青霞仙子","通臂猿猴","恶魔泡泡",
"超级飞廉", "自在心猿","进阶沙暴","超级红孩儿","超级神柚","有苏鸠","司雨","进阶司雨",
"觉醒涂山雪","泡泡仙灵·飞燕女","泡泡仙灵·骨精灵","泡泡仙灵·剑侠客","泡泡仙灵·龙太子",
"泡泡仙灵·杀破狼","泡泡仙灵·神天兵","泡泡仙灵·巫蛮儿","泡泡仙灵·羽灵神","暗黑谛听","暗黑童子",
"彩蝶女孩","彩蝶男孩"}

function 取地宫挑战模型(层数)
  if 层数 <= 2 then
    return {"白熊"}
  elseif 层数 <= 3 then
    return {"天兵","白熊"}
  elseif 层数 <= 4 then
    return {"蝴蝶仙子","天兵","白熊"}
  elseif 层数 <= 7 then
    return {"雨师","蝴蝶仙子","天兵","白熊"}
  elseif 层数 <= 12 then
    return {"蚌精","雨师","蝴蝶仙子","天兵","白熊"}
  elseif 层数 <= 18 then
    return {"狂豹人形","蚌精","雨师","蝴蝶仙子","天兵","白熊"}
  elseif 层数 <= 22 then
    return {"雷鸟人","蚌精","雨师","蝴蝶仙子","天兵","白熊"}
  elseif 层数 <= 28 then
    return {"巨力神猿","雷鸟人","蚌精","雨师","蝴蝶仙子","天兵","白熊"}
  elseif 层数 <= 32 then
    return {"小龙女","巨力神猿","雷鸟人","蚌精","雨师","蝴蝶仙子","天兵","白熊"}
  elseif 层数 <= 38 then
    return {"画魂","小龙女","巨力神猿","雷鸟人","蚌精","雨师","蝴蝶仙子","天兵","白熊"}
  elseif 层数 <= 42 then
    return {"混沌兽","画魂","小龙女","巨力神猿","雷鸟人","蚌精","雨师","蝴蝶仙子","天兵","白熊"}
  elseif 层数 <= 42 then
    return {"夜罗刹","混沌兽","画魂","小龙女","巨力神猿","雷鸟人","蚌精","雨师","蝴蝶仙子","天兵","白熊"}
  elseif 层数 <= 52 then
    return {"葫芦宝贝","混沌兽","画魂","小龙女","巨力神猿","雷鸟人","蚌精","雨师","蝴蝶仙子","天兵","白熊"}
  elseif 层数 <= 58 then
    return {"巴蛇","葫芦宝贝","混沌兽","画魂","小龙女","巨力神猿","雷鸟人","蚌精","雨师","蝴蝶仙子","天兵","白熊"}
  elseif 层数 <= 62 then
    return {"曼珠沙华","巴蛇","葫芦宝贝","混沌兽","画魂","小龙女","巨力神猿","雷鸟人","蚌精","雨师","蝴蝶仙子","天兵","白熊"}
  elseif 层数 <= 68 then
    return {"噬天虎","曼珠沙华","巴蛇","葫芦宝贝","混沌兽","画魂","小龙女","巨力神猿","雷鸟人","蚌精","雨师","蝴蝶仙子","天兵","白熊"}
  elseif 层数 <= 72 then
    return {"鬼将","噬天虎","曼珠沙华","巴蛇","葫芦宝贝","混沌兽","画魂","小龙女","巨力神猿","雷鸟人","蚌精","雨师","蝴蝶仙子","天兵","白熊"}
  elseif 层数 <= 78 then
    return {"蔓藤妖花","鬼将","噬天虎","曼珠沙华","巴蛇","葫芦宝贝","混沌兽","画魂","小龙女","巨力神猿","雷鸟人","蚌精","雨师","蝴蝶仙子","天兵","白熊"}
  elseif 层数 <= 82 then
    return {"律法女娲","蔓藤妖花","鬼将","噬天虎","曼珠沙华","巴蛇","葫芦宝贝","混沌兽","画魂","小龙女","巨力神猿","雷鸟人","蚌精","雨师","蝴蝶仙子","天兵","白熊"}
  elseif 层数 <= 88 then
    return {"大力金刚","蔓藤妖花","鬼将","噬天虎","曼珠沙华","巴蛇","葫芦宝贝","混沌兽","画魂","小龙女","巨力神猿","雷鸟人","蚌精","雨师","蝴蝶仙子","天兵","白熊"}
  else
    return {"炎魔神","大力金刚","蔓藤妖花","鬼将","噬天虎","曼珠沙华","巴蛇","葫芦宝贝","混沌兽","画魂","小龙女","巨力神猿","雷鸟人","蚌精","雨师","蝴蝶仙子","天兵","白熊"}
  end
end
-- function 取地宫挑战模型1(层数)
--   if 层数 <= 2 then
--     return {"树怪"}
--   elseif 层数 == 3 then
--     return {"赌徒"}
--   elseif 层数 == 4 then
--     return {"强盗"}
--   elseif 层数 == 5 then
--     return {"骷髅怪"}
--   elseif 层数 == 6 then
--     return {"羊头怪"}
--   elseif 层数 == 7 then
--     return {"黑熊"}
--   elseif 层数 == 8 then
--     return {"老虎"}
--   elseif 层数 == 9 then
--     return {"野鬼"}
--   elseif 层数 == 10 then
--     return {"僵尸"}
--   elseif 层数 == 11 then
--     return {"牛头"}
--   elseif 层数 == 12 then
--     return {"马面"}
--   elseif 层数 == 13 then
--     return {"古代瑞兽"}
--   elseif 层数 == 14 then
--     return {"雷鸟人"}
--   elseif 层数 == 15 then
--     return {"蝴蝶仙子"}
--   elseif 层数 == 16 then
--     return {"白熊"}
--   elseif 层数 == 17 then
--     return {"黑山老妖"}
--   elseif 层数 == 18 then
--     return {"天兵"}
--   elseif 层数 == 19 then
--     return {"天将"}
--   elseif 层数 == 20 then
--     return {"地狱战神"}
--   elseif 层数 == 21 then
--     return {"风伯"}
--   elseif 层数 == 22 then
--     return {"凤凰"}
--   elseif 层数 == 23 then
--     return {"碧水夜叉"}
--   elseif 层数 == 24 then
--     return {"蚌精"}
--   elseif 层数 == 25 then
--     return {"鲛人"}
--   elseif 层数 == 26 then
--     return {"蛟龙"}
--   elseif 层数 == 27 then
--     return {"巡游天神"}
--   elseif 层数 == 28 then
--     return {"芙蓉仙子"}
--   elseif 层数 == 29 then
--     return {"星灵仙子"}
--   elseif 层数 == 30 then
--     return {"如意仙子"}
--   elseif 层数 == 31 then
--     return {"锦毛貂精"}
--   elseif 层数 == 32 then
--     return {"千年蛇魅"}
--   elseif 层数 == 33 then
--     return {"百足将军"}
--   elseif 层数 == 34 then
--     return {"犀牛将军人形"}
--   elseif 层数 == 35 then
--     return {"犀牛将军兽形"}
--   elseif 层数 == 36 then
--     return {"野猪精"}
--   elseif 层数 == 37 then
--     return {"鼠先锋"}
--   elseif 层数 == 38 then
--     return {"泪妖"}
--   elseif 层数 == 39 then
--     return {"镜妖"}
--   elseif 层数 == 40 then
--     return {"阴阳伞"}
--   elseif 层数 == 41 then
--     return {"律法女娲"}
--   elseif 层数 == 42 then
--     return {"炎魔神"}
--   elseif 层数 == 43 then
--     return {"画魂"}
--   elseif 层数 == 44 then
--     return {"灵符女娲"}
--   elseif 层数 == 45 then
--     return {"吸血鬼"}
--   elseif 层数 == 46 then
--     return {"巴蛇"}
--   elseif 层数 == 47 then
--     return {"净瓶女娲"}
--   elseif 层数 == 48 then
--     return {"踏云兽"}
--   elseif 层数 == 49 then
--     return {"龙龟"}
--   elseif 层数 == 40 then
--     return {"红萼仙子"}
--   elseif 层数 == 41 then
--     return {"噬天虎"}
--   elseif 层数 == 42 then
--     return {"灵鹤"}
--   elseif 层数 == 43 then
--     return {"大力金刚"}
--   elseif 层数 == 44 then
--     return {"机关鸟"}
--   elseif 层数 == 45 then
--     return {"鬼将"}
--   elseif 层数 == 46 then
--     return {"葫芦宝贝"}
--   elseif 层数 == 47 then
--     return {"机关人"}
--   elseif 层数 == 48 then
--     return {"幽灵"}
--   elseif 层数 == 49 then
--     return {"幽萤娃娃"}
--   elseif 层数 == 50 then
--     return {"雾中仙"}
--   elseif 层数 == 51 then
--     return {"夜罗刹"}
--   elseif 层数 == 52 then
--     return {"连弩车"}
--   elseif 层数 == 53 then
--     return {"琴仙"}
--   elseif 层数 == 54 then
--     return {"机关兽"}
--   elseif 层数 == 55 then
--     return {"金铙僧"}
--   elseif 层数 == 56 then
--     return {"混沌兽"}
--   elseif 层数 == 57 then
--     return {"猫灵人形"}
--   elseif 层数 == 58 then
--     return {"猫灵兽形"}
--   elseif 层数 == 59 then
--     return {"狂豹人形"}
--   elseif 层数 == 60 then
--     return {"狂豹兽形"}
--   elseif 层数 == 61 then
--     return {"蝎子精"}
--  elseif 层数 == 62 then
--     return {"进阶凤凰"}
--   elseif 层数 == 63 then
--     return {"进阶碧水夜叉"}
--   elseif 层数 == 64 then
--     return {"进阶蚌精"}
--   elseif 层数 == 65 then
--     return {"进阶鲛人"}
--   elseif 层数 == 66 then
--     return {"进阶蛟龙"}
--   elseif 层数 == 67 then
--     return {"进阶巡游天神"}
--   elseif 层数 == 68 then
--     return {"进阶芙蓉仙子"}
--   elseif 层数 == 69 then
--     return {"进阶星灵仙子"}
--   elseif 层数 == 70 then
--     return {"进阶如意仙子"}
--   elseif 层数 == 71 then
--     return {"进阶锦毛貂精"}
--   elseif 层数 == 72 then
--     return {"进阶千年蛇魅"}
--   elseif 层数 == 73 then
--     return {"进阶百足将军"}
--   elseif 层数 == 74 then
--     return {"进阶犀牛将军人形"}
--   elseif 层数 == 75 then
--     return {"进阶犀牛将军兽形"}
--   elseif 层数 == 76 then
--     return {"进阶野猪精"}
--   elseif 层数 == 77 then
--     return {"进阶鼠先锋"}
--   elseif 层数 == 78 then
--     return {"进阶泪妖"}
--   elseif 层数 == 79 then
--     return {"进阶镜妖"}
--   elseif 层数 == 80 then
--     return {"进阶阴阳伞"}
--   elseif 层数 == 81 then
--     return {"进阶律法女娲"}
--   elseif 层数 == 82 then
--     return {"进阶炎魔神"}
--   elseif 层数 == 83 then
--     return {"进阶画魂"}
--   elseif 层数 == 84 then
--     return {"进阶灵符女娲"}
--   elseif 层数 == 85 then
--     return {"进阶吸血鬼"}
--   elseif 层数 == 86 then
--     return {"进阶巴蛇"}
--   elseif 层数 == 87 then
--     return {"进阶净瓶女娲"}
--   elseif 层数 == 88 then
--     return {"进阶踏云兽"}
--   elseif 层数 == 89 then
--     return {"进阶龙龟"}
--   elseif 层数 == 90 then
--     return {"进阶红萼仙子"}
--   elseif 层数 == 91 then
--     return {"进阶噬天虎"}
--   elseif 层数 == 92 then
--     return {"进阶灵鹤"}
--   elseif 层数 == 93 then
--     return {"进阶大力金刚"}
--   elseif 层数 == 94 then
--     return {"进阶机关鸟"}
--   elseif 层数 == 95 then
--     return {"进阶鬼将"}
--   elseif 层数 == 96 then
--     return {"进阶葫芦宝贝"}
--   elseif 层数 == 97 then
--     return {"进阶机关人"}
--   elseif 层数 == 98 then
--     return {"进阶幽灵"}
--   elseif 层数 == 99 then
--     return {"进阶幽萤娃娃"}
--   elseif 层数 == 100 then
--     return {"进阶雾中仙"}
--   elseif 层数 == 101 then
--     return {"进阶夜罗刹"}
--   elseif 层数 == 102 then
--     return {"进阶连弩车"}
--   elseif 层数 == 103 then
--     return {"进阶琴仙"}
--   elseif 层数 == 104 then
--     return {"进阶机关兽"}
--   elseif 层数 == 105 then
--     return {"进阶金铙僧"}
--   elseif 层数 == 106 then
--     return {"进阶混沌兽"}
--   elseif 层数 == 107 then
--     return {"进阶猫灵人形"}
--   elseif 层数 == 108 then
--     return {"进阶猫灵兽形"}
--   elseif 层数 == 109 then
--     return {"进阶狂豹人形"}
--   elseif 层数 == 110 then
--     return {"进阶狂豹兽形"}
--   elseif 层数 == 111 then
--     return {"进阶蝎子精"}

--   else
--     return {"炎魔神","大力金刚","蔓藤妖花","毗舍童子","噬天虎","曼珠沙华","巴蛇","葫芦宝贝","混沌兽","画魂","曼珠沙华","巨力神猿","长眉灵猴","金身罗汉","修罗傀儡鬼","修罗傀儡妖","蝎子精","蜃气妖"}
--   end
-- end
function 取地宫挑战名称(造型)
  local 名称 = 造型
  local 主动技能 = {}
  local 伤害=1
  local 气血=1
  local 法伤=1
  local 速度=1
  local 防御=1
  local 法防=1
  local 躲闪=1
  local 技能 = {}
  if 造型 == "白熊" then
    名称 = {"肥胖的白熊死士","肥胖的白熊","疯癫的白熊","汗血的白熊","坚韧的白熊","强壮的白熊","白熊","裸衣的白熊"}
  elseif 造型 == "天兵" then
    名称 = {"强壮的天兵刺客","肥胖的天兵","疯癫的天兵","汗血的天兵","坚韧的天兵","强壮的天兵","天兵","裸衣的天兵"}
  elseif 造型 == "蝴蝶仙子" then
    名称 = {"敏捷的蝴蝶仙子","坚韧的蝴蝶仙子","蝴蝶仙子","坚韧的蝴蝶仙子富豪","肥胖的蝴蝶仙子","虔诚的蝴蝶仙子","裸衣的蝴蝶仙子","自愈的蝴蝶仙子","狡猾的蝴蝶仙子"}
    速度=1.3
    主动技能 = {"推气过宫"}
  elseif 造型 == "雨师" then
    名称 = {"虔诚的雨师","坚韧的雨师","敏捷的雨师","笨重的雨师","强壮的雨师","自愈的雨师","狡猾的雨师"}
    速度=1.5
    主动技能 = {"失魂符"}
  elseif 造型 == "蚌精" then
    名称 = {"全能的蚌精精英","坚韧的蚌精","好赌的蚌精","虔诚的蚌精","强壮的蚌精","入魔的蚌精","狡猾的蚌精","聪慧的蚌精","偏执的蚌精","敏捷的蚌精"}
    防御=0.7
    速度=0.7
    主动技能 = {"泰山压顶","地狱烈火","奔雷咒","水漫金山"}
  elseif 造型 == "狂豹人形" then
    名称 = {"全能的狂豹精英","嗜血的狂豹精英","坚韧的狂豹精英","全能的狂豹","坚韧的狂豹","裸衣的狂豹","裸衣的狂豹莽夫","裸衣的狂豹傀儡","肥胖的狂豹士卒","肥胖的狂豹","无畏的狂豹","隐忍的狂豹","强壮的狂豹","全能的狂豹傀儡","好战的狂豹士卒","好战的狂豹","嗜血的狂豹护卫","汗血的狂豹","嗜血的狂豹"}
    防御=0.7
    速度=1.3
    主动技能 = {"鹰击"}
    技能 = {"高级神迹"}
  elseif 造型 == "雷鸟人" then
    速度=0.7
    名称 = {"好赌的雷鸟人精英","偏执的雷鸟人","入魔的雷鸟人精英","肥胖的雷鸟人","好赌的雷鸟人","入魔的雷鸟人","坚韧的雷鸟人","聪慧的雷鸟人","敏捷的雷鸟人"}
    主动技能 = {"雷击","烈火","落岩","水攻"}
  elseif 造型 == "巨力神猿" then
    防御=1.3
    速度=1.3
    名称 = {"强壮的巨力神猿","好战的巨力神猿","嗜血的巨力神猿","裸衣的巨力神猿","无畏的巨力神猿莽夫","肥胖的巨力神猿","汗血的巨力神猿"}
    主动技能 = {"破血狂攻"}
  elseif 造型 == "小龙女" then
    名称 = {"聪慧的小龙女","无畏的小龙女","笨重的小龙女","好赌的小龙女","坚韧的小龙女花魁","偏执的小龙女","好战的小龙女"}
    主动技能 = {"雷击","烈火","落岩","水攻"}
  elseif 造型 == "画魂" then
    名称 = {"肥胖的画魂死士","自愈的画魂","狡猾的画魂徘优","肥胖的画魂护卫","肥胖的画魂","坚韧的画魂","全能的画魂","虔诚的画魂","狡猾的画魂"}
    防御=1.3
    速度=1.3
    技能 = {"神迹"}
    主动技能 = {"日光华"}
  elseif 造型 == "混沌兽" then
    名称 = {"入魔的混沌兽傀儡","坚韧的混沌兽","偏执的混沌兽","好赌的混沌兽百姓","聪慧的混沌兽","全能的混沌兽傀儡","肥胖的混沌兽","好战的混沌兽","虔诚的混沌兽精英","虔诚的混沌兽","好赌的混沌兽精英","入魔的混沌兽","好赌的混沌兽莽夫","聪慧的混沌兽精英","坚韧的混沌兽精英","全能的混沌兽精英","隐忍的混沌兽","好赌的混沌兽","无畏的混沌兽"}
    防御=1.3
    速度=0.7
    法伤=1.3
    主动技能 = {"龙卷雨击"}
  elseif 造型 == "夜罗刹" then
    名称 = {"嗜血的夜罗刹","虔诚的夜罗刹精英","笨重的夜罗刹","好战的夜罗刹徘优","好战的夜罗刹","无畏的夜罗刹护卫","好战的夜罗刹士卒","全能的夜罗刹","隐忍的夜罗刹","强壮的夜罗刹","全能的夜罗刹精英"}
    速度=1.3
    主动技能 = {"天雷斩"}
  elseif 造型 == "葫芦宝贝" then
    名称 = {"坚韧的葫芦宝贝","轻灵的葫芦宝贝","狡猾的葫芦宝贝富豪","敏捷的葫芦宝贝","全能的葫芦宝贝精英","自恋的葫芦宝贝富豪","狡猾的葫芦宝贝","自愈的葫芦宝贝徘优","全能的葫芦宝贝","虔诚的葫芦宝贝","自愈的葫芦宝贝","狡猾的葫芦宝贝徘优","狡猾的葫芦宝贝护卫"}
    主动技能 = {"日月乾坤"}
  elseif 造型 == "巴蛇" then
    名称 = {"隐忍的巴蛇","裸衣的巴蛇刺客","嗜血的巴蛇","裸衣的巴蛇","嗜血的巴蛇精英","全能的巴蛇","全能的巴蛇精英","无畏的巴蛇莽夫","好战的巴蛇","无畏的巴蛇","好战的巴蛇士卒","疯癫的巴蛇富豪"}
    伤害 = 1.3
    防御 = 1.3
    速度 = 1.3
  elseif 造型 == "曼珠沙华" then
    名称 = {"自愈的曼珠沙华","狡猾的曼珠沙华","虔诚的曼珠沙华","肥胖的曼珠沙华死士","坚韧的曼珠沙华","肥胖的曼珠沙华","肥胖的曼珠沙华护卫","敏捷的曼珠沙华"}
    防御 = 0.7
    速度 = 1.3
    主动技能 = {"五雷轰顶"}
  elseif 造型 == "噬天虎" then
    防御 = 0.7
    伤害 = 1.3
    名称 = {"汗血的噬天虎","嗜血的噬天虎精英","强壮的噬天虎","笨重的噬天虎","嗜血的噬天虎莽夫","无畏的噬天虎","隐忍的噬天虎","裸衣的噬天虎"}
    主动技能 = {"破血狂攻"}
  elseif 造型 == "鬼将" then
    防御 = 0.7
    速度 = 1.3
    伤害 = 1.3
    名称 = {"嗜血的鬼将","敏捷的鬼将","轻灵的鬼将","无畏的鬼将","狡猾的鬼将","全能的鬼将"}
    主动技能 = {"惊心一剑"}
  elseif 造型 == "蔓藤妖花" then
    防御 = 0.7
    速度 = 1.8
    名称 = {"自愈的蔓藤妖花花魁","自愈的蔓藤妖花","肥胖的蔓藤妖花死士","虔诚的蔓藤妖花花魁","轻灵的蔓藤妖花徘优","轻灵的蔓藤妖花花魁","全能的蔓藤妖花","轻灵的蔓藤妖花护卫","狡猾的蔓藤妖花","敏捷的的蔓藤妖花","自愈的蔓藤妖花富豪","虔诚的蔓藤妖花","全能的蔓藤妖花精英"}
    主动技能 = {"日月乾坤"}
  elseif 造型 == "律法女娲" then
    防御 = 1.3
    速度 = 0.7
    伤害 = 1.3
    名称 = {"全能的律法女娲","强壮的律法女娲","虔诚的律法女娲","汗血的律法女娲","笨重的律法女娲莽夫","好战的律法女娲","肥胖的律法女娲"}
    主动技能 = {"善恶有报"}
  elseif 造型 == "大力金刚" then
    速度 = 1.3
    名称 = {"虔诚的大力金刚富豪","坚韧的大力金刚精英","肥胖的大力金刚","虔诚的大力金刚","肥胖的大力金刚死士","虔诚的大力金刚精英","自愈的大力金刚护卫","坚韧的大力金刚","自愈的大力金刚富豪","全能的大力金刚精英","敏捷的大力金刚","全能的大力金刚","自愈的大力金刚"}
    主动技能 = {"推气过宫"}
  elseif 造型 == "炎魔神" then
    法伤 = 1.5
    防御 = 1.3
    主动技能 = {"飞砂走石"}
    名称 = {"入魔的炎魔神傀儡","坚韧的炎魔神","偏执的炎魔神","好赌的炎魔神百姓","聪慧的炎魔神","全能的炎魔神傀儡","肥胖的炎魔神","好战的炎魔神","虔诚的炎魔神精英","虔诚的炎魔神","好赌的炎魔神精英","入魔的炎魔神","好赌的炎魔神莽夫","聪慧的炎魔神精英","坚韧的炎魔神精英","全能的炎魔神精英","隐忍的炎魔神","好赌的炎魔神","无畏的炎魔神"}
  end
  return {名称=名称[取随机数(1,#名称)],主动技能=主动技能,伤害=伤害,气血=气血,法伤=法伤,速度=速度,防御=防御,法防=法防,躲闪=躲闪,技能=技能}
end




-- function 战斗准备类:取镇妖塔信息(任务id,玩家id,假人属性)
--   local 层数 = 镇妖塔数据[玩家id].层数
--   local 等级=层数*10
--   if 等级>=200 then
--      等级= 200
--   end
--   if 层数==nil then
--      层数=1
--   end
--   local 怪物模型 = 地宫怪物模型[层数]
--   if 怪物模型 == nil then
--      怪物模型 = 地宫怪物模型[取随机数(150,200)]
--   end
--   local 主怪名 = "【"..层数.."层】看门队长"
--   local 副将名= "【"..层数.."层】巡逻队长"
--   local 守卫名 = "【"..层数.."层】守卫队长"
--   local 喽喽名 = "【"..层数.."层】小喽喽"
--   local 是否变异 =false
--   local 是否封印 = false
--   if 层数/10==math.floor(层数/10) then
--       主怪名 = "【"..层数.."层】妖皇"
--       副将名 = "【"..层数.."层】妖后"
--       守卫名 = "【"..层数.."层】妖童"
--       喽喽名 = "【"..层数.."层】守卫"
--       是否变异 = true
--       是否封印 = true
--   end

--   local 战斗单位={}

--    战斗单位[1]={
--      名称=主怪名
--     ,模型=怪物模型
--     ,变异=是否变异
--     ,不可封印=是否封印
--     ,伤害=等级*32+层数*35+1600
--     ,气血=等级*等级*层数+2000
--     ,法伤=等级*22+层数*24+1100
--     ,速度=等级*5+层数*15
--     ,防御=等级*19+层数*21+960
--     ,法防=等级*13+层数*14+660
--     ,躲闪=等级*5
--     ,魔法=200000000
--     ,愤怒=99999
--     ,攻击修炼=math.floor(层数/5) + 3
--     ,防御修炼=math.floor(层数/5) + 3
--     ,法术修炼=math.floor(层数/5) + 3
--     ,抗法修炼=math.floor(层数/5) + 3
--     ,等级=等级
--     ,技能=取随机兽决被动(20)
--     ,主动技能={}
--   }
--   if 取随机数()<=50 then
--      战斗单位[1].主动技能=取随机法术新(10)
--   else
--      战斗单位[1].主动技能=取随机物理法术(6)
--   end
-- 战斗单位[2]={
--      名称=副将名
--     ,模型=怪物模型
--     ,变异=是否变异
--     ,伤害=等级*32+层数*35+1600
--     ,气血=等级*等级*层数+2000
--     ,法伤=等级*22+层数*24+1100
--     ,速度=等级*5+层数*15
--     ,防御=等级*19+层数*21+960
--     ,法防=等级*13+层数*14+660
--     ,躲闪=等级*5
--     ,魔法=200000000
--     ,愤怒=99999
--     ,攻击修炼=math.floor(层数/5) + 3
--     ,防御修炼=math.floor(层数/5) + 3
--     ,法术修炼=math.floor(层数/5) + 3
--     ,抗法修炼=math.floor(层数/5) + 3
--     ,等级=等级
--     ,技能=取随机兽决被动(10)
--     ,主动技能={}
--   }
--   if 取随机数()<=50 then
--      战斗单位[1].主动技能=取随机法术新(5)
--   else
--      战斗单位[1].主动技能=取随机物理法术(3)
--   end
-- 战斗单位[3]={
--      名称=副将名
--     ,模型=怪物模型
--     ,变异=是否变异
--     ,伤害=等级*32+层数*35+1600
--     ,气血=等级*等级*层数+2000
--     ,法伤=等级*22+层数*24+1100
--     ,速度=等级*5+层数*15
--     ,防御=等级*19+层数*21+960
--     ,法防=等级*13+层数*14+660
--     ,躲闪=等级*5
--     ,魔法=200000000
--     ,愤怒=99999
--     ,攻击修炼=math.floor(层数/5)
--     ,防御修炼=math.floor(层数/5)
--     ,法术修炼=math.floor(层数/5)
--     ,抗法修炼=math.floor(层数/5)
--     ,等级=等级
--     ,技能=取随机兽决被动(10)
--     ,主动技能={}
--   }
--   if 取随机数()<=50 then
--      战斗单位[1].主动技能=取随机法术新(5)
--   else
--      战斗单位[1].主动技能=取随机物理法术(3)
--   end
--   战斗单位[4]={
--      名称=守卫名
--     ,模型=怪物模型
--     ,变异=是否变异
--     ,伤害=等级*32+层数*35+1600
--     ,气血=等级*等级*层数+2000
--     ,法伤=等级*22+层数*24+1100
--     ,速度=等级*5+层数*15
--     ,防御=等级*19+层数*21+960
--     ,法防=等级*13+层数*14+660
--     ,躲闪=等级*5
--     ,魔法=200000000
--     ,愤怒=99999
--     ,攻击修炼=math.floor(层数/5)
--     ,防御修炼=math.floor(层数/5)
--     ,法术修炼=math.floor(层数/5)
--     ,抗法修炼=math.floor(层数/5)
--     ,等级=等级
--     ,技能={"高级感知","高级神佑复生"}
--     ,主动技能={"失心符","催眠符","定身符","落雷符","反间之计","晶清诀"}
--   }

-- 战斗单位[5]={
--      名称=守卫名
--     ,模型=怪物模型
--     ,变异=是否变异
--     ,伤害=等级*32+层数*35+1600
--     ,气血=等级*等级*层数+2000
--     ,法伤=等级*22+层数*24+1100
--     ,速度=等级*5+层数*15
--     ,防御=等级*19+层数*21+960
--     ,法防=等级*13+层数*14+660
--     ,躲闪=等级*5
--     ,魔法=200000000
--     ,愤怒=99999
--     ,攻击修炼=math.floor(层数/5)
--     ,防御修炼=math.floor(层数/5)
--     ,法术修炼=math.floor(层数/5)
--     ,抗法修炼=math.floor(层数/5)
--     ,等级=等级
--     ,技能={"高级感知","高级神佑复生"}
--     ,主动技能={"失心符","催眠符","定身符","落雷符","反间之计","晶清诀"}
--   }
--   for i=6,10 do
--     战斗单位[i]={
--      名称=喽喽名
--     ,模型=怪物模型
--     ,变异=是否变异
--     ,伤害=等级*32+层数*35+1600
--     ,气血=等级*等级*层数+2000
--     ,法伤=等级*22+层数*24+1100
--     ,速度=等级*5+层数*15
--     ,防御=等级*19+层数*21+960
--     ,法防=等级*13+层数*14+660
--     ,躲闪=等级*5
--     ,魔法=200000000
--     ,愤怒=99999
--     ,等级=等级
--     ,技能=取随机兽决被动(10)
--     ,主动技能=取随机法术(10)
--   }
--   end
--   return 战斗单位
-- end