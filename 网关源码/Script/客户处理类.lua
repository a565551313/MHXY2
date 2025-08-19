
local 客户处理类 = class()
function 客户处理类:初始化() end
function 客户处理类:更新(dt) end
function 客户处理类:连接处理(客户)
      if 已连接服务端 == 0 then
        return
      end
      --检查ip是否被封禁
      local time = os.time()
      self:发送数据(客户.id,76542,time)
      __C客户信息[客户.id].key=time

end

function 取校验数据(序号,随机1,随机2,时间)
  local 协议号="xzcjasdiwsnfaasddwf"
  return  f函数.取MD5(序号..随机1..协议号..随机2..时间)
end



function 客户处理类:数据处理(id,数据内容)
  local 内容 =jm1(数据内容)

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
  if not self.数据[1] or not tonumber(self.数据[1]) then return  end



  self.数据[1]=tonumber(self.数据[1])


  -- 1.5 key验证，不用发送给服务端
  if self.数据[1]==1.5 and self.数据[2]~= nil then
    if self.数据[2]+0 == __C客户信息[id].key * 3 + 12 then
      __C客户信息[id].认证 = 2
    end
    return
  end
  -- 9527 心跳验证，不用发送给服务端
  -- if self.数据[1]==9527 then
  --     __C客户信息[id].心跳验证时间 = os.time()
  --     return
  -- end

   if self.数据[1]==9527 then

      __C客户信息[id].心跳验证 = os.time()
      if  self.数据[2] then
          self.临时数据=分割文本(self.数据[2],fgc)
         if  self.临时数据[1] and self.临时数据[2] then
            __C客户信息[id].sj1=self.临时数据[1]
            __C客户信息[id].sj2=self.临时数据[2]
          end
      end
      return
  end





  if __C客户信息[id].认证 ~= 2 then
    __C客户信息[id].异常尝试数 = __C客户信息[id].异常尝试数+1
    if __C客户信息[id].异常尝试数 > 30 then
      self:断开连接(id,"未知异常")
    end
    return
  end


  if  not self.数据[3]  or  not tonumber(self.数据[3]) or not self.数据[4] then
    return
  end
  if os.time()-self.数据[3]>20 then
     return
  end


  local 数据校验 = 取校验数据(self.数据[1],__C客户信息[id].sj1,__C客户信息[id].sj2,self.数据[3])
  if self.数据[4]~=数据校验 then
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
             self:发送数据(id,999,"您的客户端版本过低，请到群里更新今日最新补丁运行游戏")
             self:断开连接(id,"未知异常")
            return
        else
            客户端类:发送数据(id,table.tostring({序号=self.数据[1],内容={账号=self.临时数据[2],密码=self.临时数据[3],ip=__C客户信息[id].IP}}))
        end
    end
  elseif self.数据[1]==2 then
        if not __C客户信息[id].账号 or __C客户信息[id].账号=="" then
                  self:断开连接(id,"未知异常")
                  return
        else
            客户端类:发送数据(id,table.tostring({序号=self.数据[1],内容={账号=__C客户信息[id].账号}}))
        end
  elseif self.数据[1]==3 then
        if not __C客户信息[id].账号 or __C客户信息[id].账号=="" then
                  self:断开连接(id,"未知异常")
                  return
        else
            local nr= 分割文本(self.数据[2],"1222*-*1222")
            客户端类:发送数据(id,table.tostring({序号=self.数据[1],内容={账号=__C客户信息[id].账号,模型=nr[1],名称=nr[2],染色ID=nr[3],ip=__C客户信息[id].IP}}))
        end
  elseif self.数据[1]==4 or self.数据[1]==4.1 then
          if not __C客户信息[id].账号 or __C客户信息[id].账号=="" then
              self:断开连接(id,"未知异常")
              return
          else
              self.临时数据=分割文本(self.数据[2],fgc)
              if not self.临时数据[2] or not tonumber(self.临时数据[2]) or self.临时数据[2]+0~=网关参数.版本号 then
                  self:发送数据(id,999,"您的客户端版本过低，请到群里更新今日最新补丁运行游戏")
                  return
              else
                  客户端类:发送数据(id,table.tostring({序号=self.数据[1],内容={账号=__C客户信息[id].账号,id=self.临时数据[1],ip=__C客户信息[id].IP}}))
              end
          end
  elseif self.数据[1]==34 then --版本验证
      self.临时数据=分割文本(self.数据[2],fgc)
      if  not self.临时数据[1] or not tonumber(self.临时数据[1]) or self.临时数据[1]+0~=网关参数.版本号 then
          self:发送数据(id,999,"您的客户端版本过低，请到群里更新今日最新补丁运行游戏")
           return
      else
           __C客户信息[id].账号=self.临时数据[2]
           if not __C客户信息[id].账号 or __C客户信息[id].账号=="" then
                  self:断开连接(id,"未知异常")
                  return
          else
                客户端类:发送数据(id,table.tostring({序号=self.数据[1],内容={账号=self.临时数据[2],密码=self.临时数据[3],授权码=self.临时数据[4],ip=__C客户信息[id].IP}}))
          end
      end
  else
        self.临时数据=table.loadstring(self.数据[2])
        if self.临时数据==nil or self.临时数据=="" then return  end
        self.临时数据.ip=__C客户信息[id].IP
        self.临时数据.序号 = self.数据[1]
        self.临时数据.数字id=__C客户信息[id].数字id
        客户端类:发送数据(id,table.tostring(self.临时数据),self.数据[3])
  end
end
function 客户处理类:断开处理(信息)
  网关参数.当前连接数=网关参数.当前连接数-1
  if 信息.数字id~=nil then
    客户端类:发送数据(信息.id,table.tostring({内容=信息.数字id,序号=5}))
  end
  __C客户信息[信息.id]=nil
end

function 客户处理类:断开连接(id)
  网关参数.当前连接数=网关参数.当前连接数-1
  __S服务:断开连接(id)
  __S服务:输出(string.format('客户退出(%s):%s:%s', id,__C客户信息[id].IP,__C客户信息[id].PORT))
  __C客户信息[id]=nil
  客户端类:更新连接数()
end

function 客户处理类:发送数据(id,序号,内容)
  if 内容==nil then
    内容="2134211"
  end
  --内容=序号.."*-*"..内容
  组合内容={序号=序号,内容=内容}
  --   if localmp~=nil then
  --   __S服务:发送(id,table.tostring(组合内容))
  -- else
    __S服务:发送(id,table.tostring(组合内容))
  -- end
end
function 客户处理类:显示(x,y) end
return 客户处理类







