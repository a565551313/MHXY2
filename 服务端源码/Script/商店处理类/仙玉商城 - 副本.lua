
local 仙玉商城类 = class()
function 仙玉商城类:初始化(文件) end

function 刷新商城商品()
  仙玉商城={银子商城={},仙玉商城={},锦衣商城={},积分商城={},神兽商城={},点卡商城={},冒泡框={}, GM商城={}}
  仙玉商城.银子商城={杂货商品={},锻造商品={},宝石商品={},孩子商品={},房屋装饰={},庭院装饰={}}
  仙玉商城.仙玉商城={仙玉商品={},锻造商品={},宝宝商品={},灵宝商品={},一级法宝={},二级法宝={},三级法宝={}}
  仙玉商城.锦衣商城={锦衣商品={},祥瑞商品={},足迹商品={},足印商品={},战锦商品={}}
  仙玉商城.神兽商城={商品详情={}}--{一代神兽={},二代神兽={},三代神兽={},四代神兽={}}
  仙玉商城.积分商城={妖魔积分={},活跃积分={},镇妖积分={},师门积分={},成就积分={},副本积分={}}
  仙玉商城.点卡商城={商品详情={}}
  仙玉商城.冒泡框={商品详情={}}
  -- 新增GM商城7个子分类
  仙玉商城.GM商城 = {GM1={}, GM2={}, GM3={}, GM4={}, GM5={}, GM6={}, GM7={}}
  -- 示例：每个GM子分类放一个测试商品
  for i=1,7 do
    local cname = "GM"..i
    仙玉商城.GM商城[cname][1] = {"GM测试道具"..i, "GM专属", "GM道具", 1}
  end
  local 代码函数=loadstring(读入文件([[仙玉商城.txt]]))
  代码函数()
end


function 刷新商城购买处理()
 local 代码函数=loadstring(读入文件([[仙玉商城购买处理.txt]]))
  代码函数()
end




function 仙玉商城类:仙玉商城购买(id,类型,序号,数量,大分类)
  -- GM商城权限校验
  if 大分类 == "GM商城" then
    local gm_type = tonumber(string.match(类型, "GM(%d)"))
    local gm_level = 玩家数据[id].角色.数据.GM等级 or 0
    if not gm_type or gm_level < gm_type then
      常规提示(id, "#Y你没有权限购买该GM商品！")
      return
    end
    -- GM商品每日限购校验
    local 商品配置 = 仙玉商城[大分类][类型][序号]
    local 商品名 = 商品配置[1]
    local 限购 = 商品配置[5] or 0
    if 限购 > 0 then
      local today = os.date("%Y-%m-%d")
      local 角色id = 玩家数据[id].角色.数据.数字id
      local record_path = 程序目录.."data/"..玩家数据[id].账号.."/"..角色id.."/GM限购记录.txt"
      
      -- 读取限购记录，使用与写入相同的方式
      local record = {}
      local file = io.open(record_path, "r")
      if file then
        local file_content = file:read("*all")
        file:close()
        if file_content and file_content ~= "" then
          local func = loadstring(file_content)
          if func then
            record = func() or {}
          end
        end
      end
      
      record[today] = record[today] or {}
      local 已购 = record[today][商品名] or 0
      
      -- 调试信息
      print("=== GM限购检查 ===")
      print("商品名: " .. 商品名)
      print("限购数量: " .. 限购)
      print("已购数量: " .. 已购)
      print("本次购买: " .. 数量)
      print("总计: " .. (已购 + 数量))
      print("记录文件: " .. record_path)
      
      if 已购 + 数量 > 限购 then
        常规提示(id, "#Y该商品今日限购"..限购.."个，已购买"..已购.."个！")
        print("限购检查: 购买被阻止")
        return
      end
      print("限购检查: 通过")
      -- 先不更新记录，等扣费成功后再更新
    end

  end
  if 仙玉商城[大分类]==nil or 仙玉商城[大分类][类型]==nil or 仙玉商城[大分类][类型][序号]==nil or not 玩家数据[id] or not 共享货币[玩家数据[id].账号] then
    常规提示(id,"#Y这样的商品并不存在")
    return
  else
    local 名称=仙玉商城[大分类][类型][序号][1]
    local 仙玉=仙玉商城[大分类][类型][序号][4]
    if 仙玉商城[大分类][类型][序号][3]=="神兽" or 大分类=="神兽商城"  then
        常规提示(id,"#Y该商品只供观赏无法购买")
        return
    elseif 玩家数据[id].角色:取道具格子2() <10 then
           常规提示(id,"#Y你的道具背包不足10格,无法购买")
           return
    end

    数量 = tonumber(数量)
    if not 数量 or  数量<=1 then
      数量=1
    end
     if math.ceil(数量)~=数量 then
         print("--------------------------------------------------------------------")
         print("账号:"..玩家数据[id].账号)
         print("ID:"..id)
         print("玩家:"..玩家数据[id].角色.数据.名称.."传入数量是小数")
         print("--------------------------------------------------------------------")
        return
     end
    数量=math.ceil(数量)
    local 需求金钱= 数量*仙玉


    if 大分类 == "GM商城" then
      -- 在扣费前再次进行限购检查
      local 商品配置 = 仙玉商城[大分类][类型][序号]
      local 限购 = 商品配置[5] or 0
      if 限购 > 0 then
        local today = os.date("%Y-%m-%d")
        local 角色id = 玩家数据[id].角色.数据.数字id
        local record_path = 程序目录.."data/"..玩家数据[id].账号.."/"..角色id.."/GM限购记录.txt"
        
        -- 读取限购记录
        local record = {}
        local file = io.open(record_path, "r")
        if file then
          local file_content = file:read("*all")
          file:close()
          if file_content and file_content ~= "" then
            local func = loadstring(file_content)
            if func then
              record = func() or {}
            end
          end
        end
        
        record[today] = record[today] or {}
        local 已购 = record[today][名称] or 0
        
        -- 最终限购检查
        print("=== 最终限购检查 ===")
        print("商品名: " .. 名称)
        print("限购数量: " .. 限购)
        print("已购数量: " .. 已购)
        print("本次购买: " .. 数量)
        print("总计: " .. (已购 + 数量))
        
        if 已购 + 数量 > 限购 then
          常规提示(id, "#Y该商品今日限购"..限购.."个，已购买"..已购.."个！")
          print("最终限购检查: 购买被阻止")
          return
        end
        print("最终限购检查: 通过")
      end
      
      if 共享货币[玩家数据[id].账号]:扣除仙玉(需求金钱,"仙玉商城购买物品，物品名称为："..名称,id) then
        self:仙玉商城商品处理(id,名称,数量)
        常规提示(id,format("#Y你花费了#R%s#Y点仙玉购买了#R%s",需求金钱,名称))
        
        -- 购买成功后更新GM限购记录
        if 限购 > 0 then
          local today = os.date("%Y-%m-%d")
          local 角色id = 玩家数据[id].角色.数据.数字id
          local record_path = 程序目录.."data/"..玩家数据[id].账号.."/"..角色id.."/GM限购记录.txt"
          
          -- 确保目录存在
          local dir_path = 程序目录.."data/"..玩家数据[id].账号.."/"..角色id
          创建目录(dir_path)
          
          local record = {}
          local file = io.open(record_path, "r")
          if file then
            local file_content = file:read("*all")
            file:close()
            if file_content and file_content ~= "" then
              local func = loadstring(file_content)
              if func then
                record = func() or {}
              end
            end
          end
          
          record[today] = record[today] or {}
          local 已购 = record[today][名称] or 0
          record[today][名称] = 已购 + 数量
          
          -- 序列化并写入文件
          local function serialize_table(t, indent)
            indent = indent or ""
            local result = "{\n"
            for k, v in pairs(t) do
              local key_str = type(k) == "string" and string.format('["%s"]', k) or string.format('[%s]', k)
              if type(v) == "table" then
                result = result .. indent .. "  " .. key_str .. " = " .. serialize_table(v, indent .. "  ") .. ",\n"
              elseif type(v) == "string" then
                result = result .. indent .. "  " .. key_str .. " = \"" .. v .. "\",\n"
              else
                result = result .. indent .. "  " .. key_str .. " = " .. tostring(v) .. ",\n"
              end
            end
            result = result .. indent .. "}"
            return result
          end
          
          local record_str = "return " .. serialize_table(record)
          local file = io.open(record_path, "w")
          if file then
            file:write(record_str)
            file:close()
            print("GM限购记录已更新: " .. record_path)
            print("商品: " .. 名称 .. ", 今日已购: " .. record[today][名称])
          else
            print("无法创建GM限购记录文件: " .. record_path)
          end
        end
      end
    elseif 大分类 == "银子商城" then
      if 玩家数据[id].角色.数据.银子 < 需求金钱 then
        常规提示(id,"#Y你没有这么多的银子！")
        return
      end
      玩家数据[id].角色:扣除银子(需求金钱,"仙玉商城购买物品，物品名称为："..名称,1)
      self:仙玉商城商品处理(id,名称,数量)
      常规提示(id,format("#Y你花费了#R%s#Y两银子购买了#R%s",需求金钱,名称))
   elseif 大分类 == "点卡商城"  then
     if 共享货币[玩家数据[id].账号]:扣除点卡(需求金钱,id,"商城购买") then
        self:仙玉商城商品处理(id,名称,数量)
        常规提示(id,format("#Y你花费了#R%s#Y点卡购买了#R%s",需求金钱,名称))
      end
  elseif 大分类 == "积分商城"  then
        if  类型 == "妖魔积分"  then
            if 玩家数据[id].角色.数据.妖魔积分 < 需求金钱 then
              常规提示(id,"#Y你没有这么多的积分！")
              return
            end
            玩家数据[id].角色.数据.妖魔积分 = 玩家数据[id].角色.数据.妖魔积分 -需求金钱
            self:仙玉商城商品处理(id,名称,数量)
            常规提示(id,format("#Y你花费了#R%s#Y妖魔积分购买了#R%s",需求金钱,名称))

        elseif  类型 == "活跃积分"  then
            if 玩家数据[id].角色.数据.活跃积分 < 需求金钱 then
              常规提示(id,"#Y你没有这么多的积分！")
              return
            end
            玩家数据[id].角色.数据.活跃积分 = 玩家数据[id].角色.数据.活跃积分 -需求金钱
            self:仙玉商城商品处理(id,名称,数量)
            常规提示(id,format("#Y你花费了#R%s#Y活跃积分购买了#R%s",需求金钱,名称))
        elseif  类型 == "镇妖积分"  then
                if 玩家数据[id].角色.数据.镇妖积分 < 需求金钱 then
                常规提示(id,"#Y你没有这么多的积分！")
                return
              end
              玩家数据[id].角色.数据.镇妖积分 = 玩家数据[id].角色.数据.镇妖积分 -需求金钱
              self:仙玉商城商品处理(id,名称,数量)
              常规提示(id,format("#Y你花费了#R%s#Y镇妖积分购买了#R%s",需求金钱,名称))
        elseif 类型 == "师门积分"  then
              if 玩家数据[id].角色.数据.师门积分 < 需求金钱 then
                常规提示(id,"#Y你没有这么多的积分！")
                return
              end
              玩家数据[id].角色.数据.师门积分 = 玩家数据[id].角色.数据.师门积分 -需求金钱
              self:仙玉商城商品处理(id,名称,数量)
              常规提示(id,format("#Y你花费了#R%s#Y师门积分购买了#R%s",需求金钱,名称))
        elseif 类型 == "成就积分"  then
               if 玩家数据[id].角色.数据.成就积分 < 需求金钱 then
                常规提示(id,"#Y你没有这么多的积分！")
                return
              end
              玩家数据[id].角色.数据.成就积分 = 玩家数据[id].角色.数据.成就积分 -需求金钱
              self:仙玉商城商品处理(id,名称,数量)
              常规提示(id,format("#Y你花费了#R%s#Y成就积分购买了#R%s",需求金钱,名称))
        elseif 类型 == "副本积分"  then
               if 玩家数据[id].角色.数据.副本积分 < 需求金钱 then
                常规提示(id,"#Y你没有这么多的积分！")
                return
              end
              玩家数据[id].角色.数据.副本积分 = 玩家数据[id].角色.数据.副本积分 -需求金钱
              self:仙玉商城商品处理(id,名称,数量)
              常规提示(id,format("#Y你花费了#R%s#Y副本积分购买了#R%s",需求金钱,名称))


        end

    elseif 大分类 == "锦衣商城"  then
        if 类型 == "祥瑞商品" then
        --- if 玩家数据[id].角色.数据.坐骑列表~= nil and 7 - #玩家数据[id].角色.数据.坐骑列表<1 then
          if 玩家数据[id].角色.数据.坐骑列表~= nil and #玩家数据[id].角色.数据.坐骑列表>=7  then
             常规提示(id,"#Y/对不起你换取的["..名称.."]坐骑失败!携带坐骑数量已上限.")
             return
           end
        else
              if 数量>玩家数据[id].角色:取道具格子2() then
               常规提示(id,"#Y你的道具背包不够了")
               return
              end
         end
      if 共享货币[玩家数据[id].账号]:扣除仙玉(需求金钱,"仙玉商城购买物品，物品名称为："..名称,id) then
        self:仙玉商城商品处理(id,名称,数量)
        常规提示(id,format("#Y你花费了#R%s#Y点仙玉购买了#R%s",需求金钱,名称))
      end
    else
      if 共享货币[玩家数据[id].账号]:扣除仙玉(需求金钱,"仙玉商城购买物品，物品名称为："..名称,id) then
        self:仙玉商城商品处理(id,名称,数量)
        常规提示(id,format("#Y你花费了#R%s#Y点仙玉购买了#R%s",需求金钱,名称))
      end
    end
    self:取仙玉商城商品(id,类型,92.2,大分类)
  end
end





function 仙玉商城类:取仙玉商城商品(id,类型,序号,大分类)
   if 仙玉商城[大分类]==nil or 仙玉商城[大分类][类型]==nil or not 共享货币[玩家数据[id].账号] then
    常规提示(id,"#Y商品数据错误")
    return
  end
  local 发送信息={}
  发送信息.商品=仙玉商城[大分类][类型]
  发送信息.神兽介绍 = {}

  if 序号==nil then
     序号=91
  end
  if 大分类=="神兽商城" then
      for i=1,#发送信息.商品 do
        发送信息.神兽介绍[i] = {}
        local  取物理宝宝 = 取商城宝宝(发送信息.商品[i][1].."(物理型)")
        local  取法术宝宝 = 取商城宝宝(发送信息.商品[i][1].."(法术型)")
        发送信息.神兽介绍[i].攻击资质 = 取物理宝宝[2]
        发送信息.神兽介绍[i].防御资质 = 取物理宝宝[3]
        发送信息.神兽介绍[i].体力资质 = 取物理宝宝[4]
        发送信息.神兽介绍[i].法力资质 = 取物理宝宝[5]
        发送信息.神兽介绍[i].速度资质 = 取物理宝宝[6]
        发送信息.神兽介绍[i].躲闪资质 = 取物理宝宝[7]
        发送信息.神兽介绍[i].成长 = 取物理宝宝[8]
        发送信息.神兽介绍[i].物理技能 =""
        for n=1,#取物理宝宝[9] do
          发送信息.神兽介绍[i].物理技能 =发送信息.神兽介绍[i].物理技能..取物理宝宝[9][n].." "
        end
        发送信息.神兽介绍[i].物理天生 =""
        for n=1,#取物理宝宝[11] do
          发送信息.神兽介绍[i].物理天生 =发送信息.神兽介绍[i].物理天生..取物理宝宝[11][n].." "
        end
        发送信息.神兽介绍[i].法术技能 =""
        for n=1,#取法术宝宝[9] do
          发送信息.神兽介绍[i].法术技能 =发送信息.神兽介绍[i].法术技能..取法术宝宝[9][n].." "
        end
        发送信息.神兽介绍[i].法术天生 =""
        for n=1,#取法术宝宝[11] do
          发送信息.神兽介绍[i].法术天生 =发送信息.神兽介绍[i].法术天生..取法术宝宝[11][n].." "
        end
      end
  end

  -- GM商城剩余限购和GM等级
  if 大分类=="GM商城" then
    local today = os.date("%Y-%m-%d")
    local 角色id = 玩家数据[id].角色.数据.数字id
    local record_path = 程序目录.."data/"..玩家数据[id].账号.."/"..角色id.."/GM限购记录.txt"
    
    -- 读取限购记录，使用与写入相同的方式
    local record = {}
    local file = io.open(record_path, "r")
    if file then
      local file_content = file:read("*all")
      file:close()
      if file_content and file_content ~= "" then
        local func = loadstring(file_content)
        if func then
          record = func() or {}
        end
      end
    end
    
    record[today] = record[today] or {}
    发送信息.剩余限购 = {}
    for i=1,#发送信息.商品 do
      local 商品名 = 发送信息.商品[i][1]
      local 限购 = 发送信息.商品[i][5] or 0
      local 已购 = record[today][商品名] or 0
      if 限购 > 0 then
        发送信息.剩余限购[i] = 限购 - 已购
      else
        发送信息.剩余限购[i] = -1 --不限购
      end
    end
    -- 发送GM等级
    发送信息.GM等级 = 玩家数据[id].角色.数据.GM等级 or 0
  end

  发送信息.仙玉=共享货币[玩家数据[id].账号].仙玉
  发送信息.银子=玩家数据[id].角色.数据.银子
  发送信息.点卡 = 共享货币[玩家数据[id].账号].点卡
  发送信息.活跃积分 = 玩家数据[id].角色.数据.活跃积分
  发送信息.妖魔积分 = 玩家数据[id].角色.数据.妖魔积分
  发送信息.镇妖积分 = 玩家数据[id].角色.数据.镇妖积分
  发送信息.师门积分 = 玩家数据[id].角色.数据.师门积分
  发送信息.成就积分 = 玩家数据[id].角色.数据.成就积分
  发送信息.副本积分 = 玩家数据[id].角色.数据.副本积分
  发送信息.分类=类型
  发送信息.大分类=大分类
  发送数据(玩家数据[id].连接id,序号,发送信息)
  发送信息=nil
end






return 仙玉商城类