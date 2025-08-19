--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-03-21 20:24:37
--======================================================================--
function 引擎.补差(zq,角色)
	local zqs={}
	zqs.x,zqs.y=0,0
	if zq=="汗血宝马" and (角色=="桃夭夭" or 角色=="神天兵" ) then
		zqs.x,zqs.y=0,0
	    return zqs.x,zqs.y




	end
	return zqs.x,zqs.y
end

function 引擎.新增坐骑(人物,坐骑,动作)

	     if 坐骑 =="蓝色狐狸" then
	     	if 动作== "站立" then
	     		if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
	     		   人物=="杀破狼" or 人物=="偃无师" then
	     		   return 0x00100020
	     		elseif 人物=="虎头怪" then
	     			   return 0x00100018
	     	    elseif 人物=="巨魔王" then
	     			   return 0x00100022
	     	    else
	     	        return 0x00100008
	     	    end
	     	 else
	     	 	if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
	     		   人物=="杀破狼" or 人物=="偃无师" then
	     		   return 0x00100021
	     		elseif 人物=="虎头怪" then
	     			   return 0x00100019
	     	    elseif 人物=="巨魔王" then
	     			   return 0x00100023
	     	    else
	     	        return 0x00100009
	     	    end
	     	 end
         elseif 坐骑 =="黄金狮子" then
		     	if 动作== "站立" then
		     		if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0x00100002
		     		elseif 人物=="虎头怪" then
		     			   return 0x00100004
		     	    elseif 人物=="巨魔王" then
		     			   return 0x00100006
		     	    else
		     	        return 0x00100000
		     	    end
		     	 else
		     	 	if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0x00100003
		     		elseif 人物=="虎头怪" then
		     			   return  0x00100005
		     	    elseif 人物=="巨魔王" then
		     			   return  0x00100007
		     	    else
		     	        return 0x00100001
		     	    end
		     	 end
         elseif 坐骑 =="七彩祥云" then
		     	if 动作== "站立" then
		     		if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0x00100016
		     		elseif 人物=="虎头怪" then
		     			   return 0x00100014
		     	    elseif 人物=="巨魔王" then
		     			   return 0x00100010
		     	    else
		     	        return 0x00100012
		     	    end
		     	 else
		     	 	if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0x00100017
		     		elseif 人物=="虎头怪" then
		     			   return  0x00100015
		     	    elseif 人物=="巨魔王" then
		     			   return  0x00100011
		     	    else
		     	        return 0x00100013
		     	    end
		     	 end
         elseif 坐骑 =="粉红火鸡" then
		     	if 动作== "站立" then
		     		if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0x00100028
		     		elseif 人物=="虎头怪" then
		     			   return 0x00100026
		     	    elseif 人物=="巨魔王" then
		     			   return 0x00100024
		     	    else
		     	        return 0x00100030
		     	    end
		     	 else
		     	 	if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0x00100029
		     		elseif 人物=="虎头怪" then
		     			   return  0x00100027
		     	    elseif 人物=="巨魔王" then
		     			   return  0x00100025
		     	    else
		     	        return 0x00100031
		     	    end
		     	 end

----------------------------------------------------------------------------------------------------------
         elseif 坐骑 =="彩虹毛驴" then
		     	if 动作== "站立" then
		     		if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0x00100038
		     		elseif 人物=="虎头怪" then
		     			   return 0x00100034
		     	    elseif 人物=="巨魔王" then
		     			   return 0x00100036
		     	    else
		     	        return 0x00100032
		     	    end
		     	 else
		     	 	if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0x00100039
		     		elseif 人物=="虎头怪" then
		     			   return  0x00100035
		     	    elseif 人物=="巨魔王" then
		     			   return  0x00100037
		     	    else
		     	        return 0x00100033
		     	    end
		     	 end

--------------------------------------------------------------------------------------------------------------
         elseif 坐骑 =="粉嫩小猪" then
		     	if 动作== "站立" then
		     		if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0x00100046
		     		elseif 人物=="虎头怪" then
		     			   return 0x00100042
		     	    elseif 人物=="巨魔王" then
		     			   return 0x00100044
		     	    else
		     	        return 0x00100040
		     	    end
		     	 else
		     	 	if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0x00100047
		     		elseif 人物=="虎头怪" then
		     			   return  0x00100043
		     	    elseif 人物=="巨魔王" then
		     			   return  0x00100045
		     	    else
		     	        return 0x00100041
		     	    end
		     	 end
------------------------------------------------------------------------------------------------------------------------------------------------
         elseif 坐骑 =="水晶芭蕉" then
		     	if 动作== "站立" then
		     		if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0x30303090
		     		elseif 人物=="虎头怪" then
		     			   return 0x30303084
		     	    elseif 人物=="巨魔王" then
		     			   return 0x30303086
		     	    else
		     	        return 0x30303088
		     	    end
		     	 else
		     	 	if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0x30303091
		     		elseif 人物=="虎头怪" then
		     			   return  0x30303085
		     	    elseif 人物=="巨魔王" then
		     			   return  0x30303087
		     	    else
		     	        return 0x30303089
		     	    end
		     	 end
--------------------------------------------------------------------------------------------------------------------------------------------------
         elseif 坐骑 =="深海狂鲨" then
		     	if 动作== "站立" then
		     		if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0xAABBCC06
		     		elseif 人物=="虎头怪" then
		     			   return 0xAABBCC02
		     	    elseif 人物=="巨魔王" then
		     			   return 0xAABBCC04
		     	    else
		     	        return 0xAABBCC00
		     	    end
		     	 else
		     	 	if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0xAABBCC07
		     		elseif 人物=="虎头怪" then
		     			   return  0xAABBCC03
		     	    elseif 人物=="巨魔王" then
		     			   return  0xAABBCC05
		     	    else
		     	        return 0xAABBCC01
		     	    end
		     	 end
----------------------------------------------------------------------------------------------------------------------------------------------
         elseif 坐骑 =="雷霆黑豹" then
		     	if 动作== "站立" then
		     		if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0xAABBEE06
		     		elseif 人物=="虎头怪" then
		     			   return 0xAABBEE02
		     	    elseif 人物=="巨魔王" then
		     			   return 0xAABBEE04
		     	    else
		     	        return 0xAABBEE00
		     	    end
		     	 else
		     	 	if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0xAABBEE07
		     		elseif 人物=="虎头怪" then
		     			   return  0xAABBEE03
		     	    elseif 人物=="巨魔王" then
		     			   return  0xAABBEE05
		     	    else
		     	        return 0xAABBEE01
		     	    end
		     	 end
------------------------------------------------------------------------------------------------------------------------------------------------
         elseif 坐骑 =="九尾妖狐" then
		     	if 动作== "站立" then
		     		if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0xAABBFF06
		     		elseif 人物=="虎头怪" then
		     			   return 0xAABBFF02
		     	    elseif 人物=="巨魔王" then
		     			   return 0xAABBFF04
		     	    else
		     	        return 0xAABBFF00
		     	    end
		     	 else
		     	 	if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0xAABBFF07
		     		elseif 人物=="虎头怪" then
		     			   return 0xAABBFF03
		     	    elseif 人物=="巨魔王" then
		     			   return  0xAABBFF05
		     	    else
		     	        return 0xAABBFF01
		     	    end
		     	 end
-----------------------------------------------------------------------------------------------------------------------------------------------
         elseif 坐骑 =="砖石小马" then
		     	if 动作== "站立" then
		     		if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0xAABBDD06
		     		elseif 人物=="虎头怪" then
		     			   return 0xAABBDD02
		     	    elseif 人物=="巨魔王" then
		     			   return 0xAABBDD04
		     	    else
		     	        return 0xAABBDD00
		     	    end
		     	 else
		     	 	if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		     		   人物=="杀破狼" or 人物=="偃无师" then
		     		   return 0xAABBDD07
		     		elseif 人物=="虎头怪" then
		     			   return  0xAABBDD03
		     	    elseif 人物=="巨魔王" then
		     			   return  0xAABBDD05
		     	    else
		     	        return 0xAABBDD01
		     	    end
		     	 end

		--------------------------------------------------------------------------------------------------------------------------------新加
		elseif 坐骑 =="天南蝙蝠" then
			if 动作== "站立" then
				if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000001
				elseif 人物=="虎头怪" then
					   return 0x00000002
				elseif 人物=="巨魔王" then
					   return 0x00000003
				else
					return 0x00000004
				end
			 else
				 if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000005
				elseif 人物=="虎头怪" then
					   return  0x00000006
				elseif 人物=="巨魔王" then
					   return  0x00000007
				else
					return 0x00000008
				end
			 end

		--------------------------------------------------------------------------------------------------------------------
		elseif 坐骑 =="飞天神虎" then
			if 动作== "站立" then
				if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000009
				elseif 人物=="虎头怪" then
					   return 0x00000010
				elseif 人物=="巨魔王" then
					   return 0x00000011
				else
					return 0x00000012
				end
			 else
				 if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000013
				elseif 人物=="虎头怪" then
					   return  0x00000014
				elseif 人物=="巨魔王" then
					   return  0x00000015
				else
					return 0x00000016
				end
			 end
		-------------------------------------------------------------------------------------------------------------------------------
		elseif 坐骑 =="飞天神象" then
			if 动作== "站立" then
				if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000017
				elseif 人物=="虎头怪" then
					   return 0x00000018
				elseif 人物=="巨魔王" then
					   return 0x00000019
				else
					return 0x00000020
				end
			 else
				 if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000021
				elseif 人物=="虎头怪" then
					   return  0x00000022
				elseif 人物=="巨魔王" then
					   return  0x00000023
				else
					return 0x00000024
				end
			 end

		-----------------------------------------------------------------------------------------------------------------------------------------------
		elseif 坐骑 =="飞天神鱼" then
			if 动作== "站立" then
				if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000025
				elseif 人物=="虎头怪" then
					   return 0x00000026
				elseif 人物=="巨魔王" then
					   return 0x00000027
				else
					return 0x00000028
				end
			 else
				 if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000029
				elseif 人物=="虎头怪" then
					   return  0x00000030
				elseif 人物=="巨魔王" then
					   return  0x00000031
				else
					return 0x00000032
				end
			 end

		--------------------------------------------------------------------------------------------------------------------------------------------
		elseif 坐骑 =="雷天红狮" then
			if 动作== "站立" then
				if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000033
				elseif 人物=="虎头怪" then
					   return 0x00000034
				elseif 人物=="巨魔王" then
					   return 0x00000035
				else
					return 0x00000036
				end
			 else
				 if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000037
				elseif 人物=="虎头怪" then
					   return  0x00000038
				elseif 人物=="巨魔王" then
					   return  0x00000039
				else
					return 0x00000040
				end
			 end

		--------------------------------------------------------------------------------------------------------------------------------------
		elseif 坐骑 =="通天金牛" then
			if 动作== "站立" then
				if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000041
				elseif 人物=="虎头怪" then
					   return 0x00000042
				elseif 人物=="巨魔王" then
					   return 0x00000043
				else
					return 0x00000044
				end
			 else
				 if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000045
				elseif 人物=="虎头怪" then
					   return  0x00000046
				elseif 人物=="巨魔王" then
					   return  0x00000047
				else
					return 0x00000048
				end
			   end
		-----------------------------------------------------------------------------------------------------------------------------------------
		elseif 坐骑 =="神域孔雀" then
			if 动作== "站立" then
				if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000049
				elseif 人物=="虎头怪" then
					   return 0x00000050
				elseif 人物=="巨魔王" then
					   return 0x00000051
				else
					return 0x00000052
				end
			 else
				 if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000053
				elseif 人物=="虎头怪" then
					   return  0x00000054
				elseif 人物=="巨魔王" then
					   return  0x00000055
				else
					return 0x00000056
				end
			 end
		------------------------------------------------------------------------------------------------------------
		elseif 坐骑 =="远古恐龙" then
			if 动作== "站立" then
				if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000057
				elseif 人物=="虎头怪" then
					   return 0x00000058
				elseif 人物=="巨魔王" then
					   return 0x00000059
				else
					return 0x00000060
				end
			 else
				 if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000061
				elseif 人物=="虎头怪" then
					   return  0x00000062
				elseif 人物=="巨魔王" then
					   return  0x00000063
				else
					return 0x00000064
				end
			 end
		--------------------------------------------------------------------------------------------------------------
		elseif 坐骑 =="神猫头鹰" then
			if 动作== "站立" then
				if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000065
				elseif 人物=="虎头怪" then
					   return 0x00000066
				elseif 人物=="巨魔王" then
					   return 0x00000067
				else
					return 0x00000068
				end
			 else
				 if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000069
				elseif 人物=="虎头怪" then
					   return  0x00000070
				elseif 人物=="巨魔王" then
					   return  0x00000071
				else
					return 0x00000072
				end
			 end

		-----------------------------------------------------------------------------------------------------------------------
		elseif 坐骑 =="鬼火南瓜" then
			if 动作== "站立" then
				if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000073
				elseif 人物=="虎头怪" then
					   return 0x00000074
				elseif 人物=="巨魔王" then
					   return 0x00000075
				else
					return 0x00000076
				end
			 else
				 if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000077
				elseif 人物=="虎头怪" then
					   return  0x00000078
				elseif 人物=="巨魔王" then
					   return  0x00000079
				else
					return 0x00000080
				end
			 end
		-----------------------------------------------------------------------------------------
		elseif 坐骑 =="圣诞狂欢" then
			if 动作== "站立" then
				if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000081
				elseif 人物=="虎头怪" then
					   return 0x00000082
				elseif 人物=="巨魔王" then
					   return 0x00000083
				else
					return 0x00000084
				end
			 else
				 if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000085
				elseif 人物=="虎头怪" then
					   return  0x00000086
				elseif 人物=="巨魔王" then
					   return  0x00000087
				else
					return 0x00000088
				end
			 end
		-------------------------------------------------------------------------------------------------------
		elseif 坐骑 =="神偷兔兔" then
			if 动作== "站立" then
				if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000089
				elseif 人物=="虎头怪" then
					   return 0x00000090
				elseif 人物=="巨魔王" then
					   return 0x00000091
				else
					return 0x00000092
				end
			 else
				 if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000093
				elseif 人物=="虎头怪" then
					   return  0x00000094
				elseif 人物=="巨魔王" then
					   return  0x00000095
				else
					return 0x00000096
				end
			 end
		------------------------------------------------------------------------------------------------------------
		elseif 坐骑 =="国宝熊猫" then
			if 动作== "站立" then
				if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000097
				elseif 人物=="虎头怪" then
					   return 0x00000098
				elseif 人物=="巨魔王" then
					   return 0x00000099
				else
					return 0x00000100
				end
			 else
				 if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000101
				elseif 人物=="虎头怪" then
					   return  0x00000102
				elseif 人物=="巨魔王" then
					   return  0x00000103
				else
					return 0x00000104
				end
			 end
		----------------------------------------------------------------------------------------------------------------
		elseif 坐骑 =="繁星月亮" then
			if 动作== "站立" then
				if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000105
				elseif 人物=="虎头怪" then
					   return 0x00000106
				elseif 人物=="巨魔王" then
					   return 0x00000107
				else
					return 0x00000108
				end
			 else
				 if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
				   人物=="杀破狼" or 人物=="偃无师" then
				   return 0x00000109
				elseif 人物=="虎头怪" then
					   return  0x00000110
				elseif 人物=="巨魔王" then
					   return  0x00000111
				else
					return 0x00000112
				end
			 end
		--------------------------------------------------------------------------------------------
		elseif 坐骑 =="繁星珍珠" then
		      if 动作== "站立" then
		          if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		            人物=="杀破狼" or 人物=="偃无师" then
		            return 0x00000113
		          elseif 人物=="虎头怪" then
		              return 0x00000115
		          elseif 人物=="巨魔王" then
		              return 0x00000116
		          else
		            return 0x00000117
		          end
		      else
		          if 人物=="剑侠客" or 人物=="龙太子" or 人物=="神天兵" or 人物=="逍遥生" or 人物=="羽灵神" or
		              人物=="杀破狼" or 人物=="偃无师" then
		              return 0x00000118
		            elseif 人物=="虎头怪" then
		                return  0x00000119
		            elseif 人物=="巨魔王" then
		                return  0x00000120
		            else
		              return 0x00000121
		            end
		      end
		-----------------------------------------------------------------------------------------------------
		     end

end

function 引擎.坐骑库(id,zq,sp)
	if zq==nil then
	    return
	end
	local zqs = {
		宝贝葫芦 = {0x63C1AA04,0x939B6AA2,1,"祥瑞坐骑.wdf"},
		神气小龟 = {0xE88353,0x702610D3,2,"祥瑞坐骑.wdf"},
		汗血宝马 = {0x7B49FA9A,0x3F76F5B2,3,"祥瑞坐骑.wdf"},
		欢喜羊羊 = {0x8D4DBAAE,0x2636063C,4,"祥瑞坐骑.wdf"},
		魔力斗兽 = {0x4B0E16F1,0x28F7499E,3,"祥瑞坐骑.wdf"},
		披甲战狼 = {0x3B0CC9,0xF6B76F79,4,"祥瑞坐骑.wdf"},
		闲云野鹤 = {0x49CAB729,0x1544FBAD,3,"祥瑞坐骑.wdf"},
		云魅仙鹿 = {0x621ECF47,0x98D7DB2,4,"祥瑞坐骑.wdf"},
		七彩神驴 = {0x03633E07,0x01040DCE,4,"祥瑞坐骑.wdf"},
	}
	local sps = {
		展翅高飞 = {0x2DC16EF4,0x47A59E6C,"祥瑞坐骑.wdf"},
		旗开得胜 = {0x4FB7A645,0xC89B8D7B,"祥瑞坐骑.wdf"},
		霸王雄风 = {0x8AC5514E,0xD30116BE,"祥瑞坐骑.wdf"},
		独眼观天 = {0xCB41BF07,0x6D415352,"祥瑞坐骑.wdf"},
		威武不屈 = {0xE385373B,0x71FE0155,"祥瑞坐骑.wdf"},
		深藏不露 = {0x2529E5A5,0x51C03CD4,"祥瑞坐骑.wdf"},
		异域浓情 = {0xE8B35E96,0x3949C769,"祥瑞坐骑.wdf"},
		流星天马 = {0x72489CFD,0x4D136355,"祥瑞坐骑.wdf"},
		威猛将军 = {0x5BDBA7CB,0x5CDC5A5E,"祥瑞坐骑.wdf"},
		知情达理 = {0xCCBF24B8,0xFE4B37F2,"祥瑞坐骑.wdf"},
		气宇轩昂 = {0xEC4C09DF,0x57B096DF,"祥瑞坐骑.wdf"},
		如花似玉 = {0xA6966FD2,0xCA8864D1,"祥瑞坐骑.wdf"},
		傲视天下 = {0xBB906984,0x2549904, "祥瑞坐骑.wdf"},
		铁血豪情 = {0x742FBF19,0x103FFB93,"祥瑞坐骑.wdf"},
		唯我独尊 = {0x7F6FFC35,0x716B5DC1,"祥瑞坐骑.wdf"},
		异域风情 = {0x1FED0CD8,0xD8EB6880,"祥瑞坐骑.wdf"},
		叱咤风云 = {0xAB007164,0x2E177381,"祥瑞坐骑.wdf"},
		假面勇者 = {0xE7CB8205,0xE615404,"祥瑞坐骑.wdf"},
		霓裳魅影 = {0xE0CB07C8,0xD9D958E6,"祥瑞坐骑.wdf"},
		披星戴月 = {0x8ED6D8CC,0xC5D8F53D,"祥瑞坐骑.wdf"},
		烈焰燃情 = {0x8C575D26,0x7B15590A,"祥瑞坐骑.wdf"},
		天雨流芳 = {0x503F394B,0x23BF657B,"祥瑞坐骑.wdf"},
		灵光再现 = {0xC4D118C5,0xCBC6930A,"祥瑞坐骑.wdf"},
		倾国倾城 = {0x1F01B8BE,0xBDA4DDAB,"祥瑞坐骑.wdf"},
		空 = {}
	}
	local scs
	if id == "飞燕女" then
		scs = {{0x4492502E,0xF6D6D5E6,"祥瑞坐骑.wdf"},{0xDCB946EC,0xDCC84D4E,"祥瑞坐骑.wdf"},{0xDF01F29D,0xA77B55E4,"祥瑞坐骑.wdf"},{0x6E0AD379,0x87C7A650,"祥瑞坐骑.wdf"}}
	elseif id == "英女侠" then
		scs = {{0xD43912A9,0xD2D4CAD3,"祥瑞坐骑.wdf"},{0x70291C50,0x30CABF19,"祥瑞坐骑.wdf"},{0x726C392E,0x68FB1969,"祥瑞坐骑.wdf"},{0x2474769B,0xACD868DE,"祥瑞坐骑.wdf"}}
	elseif id == "巫蛮儿" then
		scs = {{0xF2BC9369,0xB11F6642,"祥瑞坐骑.wdf"},{0x9B73C75F,0xDA0A8B06,"祥瑞坐骑.wdf"},{0x2F5EAD3F,0x499F9D37,"祥瑞坐骑.wdf"},{0xCCC0985C,0xC8F56BA3,"祥瑞坐骑.wdf"}}
	elseif id == "偃无师" then
		scs = {{0x00000110,0x00000111,"祥瑞坐骑.wdf"},{0x00000110,0x00000111,"祥瑞坐骑.wdf"},{0x00000110,0x00000111,"祥瑞坐骑.wdf"},{0x00000110,0x00000111,"祥瑞坐骑.wdf"}}
	elseif id == "逍遥生" then
		scs = {{0xA35491C9,0x49D7C76E,"祥瑞坐骑.wdf"},{0xB770EAD4,0x9A1479D8,"祥瑞坐骑.wdf"},{0x76D629EA,0xFB50C58F,"祥瑞坐骑.wdf"},{0x3D392EF4,0xA5E02A65,"祥瑞坐骑.wdf"}}
	elseif id == "剑侠客" then
		scs = {{0x67101CB7,0x9C8790BA,"祥瑞坐骑.wdf"},{0x32DA9583,0xEC9AC961,"祥瑞坐骑.wdf"},{0x766731D,0x8C50358A,"祥瑞坐骑.wdf"},{0xA95A126D,0x513DDE6C,"祥瑞坐骑.wdf"}}
	elseif id == "狐美人" then
		scs = {{0xE3123BDA,0x956305B5,"祥瑞坐骑.wdf"},{0xFB798485,0xD1997415,"祥瑞坐骑.wdf"},{0x64C21A63,0xD5D2FA14,"祥瑞坐骑.wdf"},{0xBCD86DDA,0xF0062006,"祥瑞坐骑.wdf"}}
	elseif id == "骨精灵" or id=="影精灵"  then
		scs = {{0xBEEF3795,0x3C6BF98F,"祥瑞坐骑.wdf"},{0xE2C1CDE4,0xBAD0F711,"祥瑞坐骑.wdf"},{0x75B09FA1,0x5E5736EE,"祥瑞坐骑.wdf"},{0x83DD50D3,0xB84C7C38,"祥瑞坐骑.wdf"}}
	elseif id == "鬼潇潇" then
		scs = {{0x0000118,0x0000119,"祥瑞坐骑.wdf"},{0x0000118,0x0000119,"祥瑞坐骑.wdf"},{0x0000118,0x0000119,"祥瑞坐骑.wdf"},{0x0000118,0x0000119,"祥瑞坐骑.wdf"}}
	elseif id == "杀破狼" then
		scs = {{0xE137A55D,0xDB553291,"祥瑞坐骑.wdf"},{0x8BEA762D,0x14EE7109,"祥瑞坐骑.wdf"},{0x46A79E5,0x3CD5444,"祥瑞坐骑.wdf"},{0xF974CEB,0x54A8F096,"祥瑞坐骑.wdf"}}
	elseif id == "巨魔王" then
		scs = {{0x21ED721D,0x5A05E1C0,"祥瑞坐骑.wdf"},{0x9DFEB143,0x77C20678,"祥瑞坐骑.wdf"},{0x1AF61311,0x6E370D46,"祥瑞坐骑.wdf"},{0xCC1426ED,0x39FE09DB,"祥瑞坐骑.wdf"}}
	elseif id == "虎头怪" then
		scs = {{0x99AD84CD,0x9FA6D533,"祥瑞坐骑.wdf"},{0xF56603D1,0x83DBBA94,"祥瑞坐骑.wdf"},{0x37FFB9DF,0x64426F93,"祥瑞坐骑.wdf"},{0x95BC0425,0xC6053278,"祥瑞坐骑.wdf"}}
	elseif id == "舞天姬" then
		scs = {{0x54DB4F4D,0xCB722714,"祥瑞坐骑.wdf"},{0xD92FC3DE,0x809F42FE,"祥瑞坐骑.wdf"},{0x212848A1,0xAAD7CB93,"祥瑞坐骑.wdf"},{0xB44DF735,0xECA5DB49,"祥瑞坐骑.wdf"}}
	elseif id == "玄彩娥" then
		scs = {{0x861EE4D9,0x9F2F9C11,"祥瑞坐骑.wdf"},{0x3316877C,0x31F77503,"祥瑞坐骑.wdf"},{0x779A3DF,0x622664DC,"祥瑞坐骑.wdf"},{0xA6FD7850,0xB9FD9DBD,"祥瑞坐骑.wdf"}}
	elseif id == "桃夭夭" then
		scs = {{0x0000109,0x0000112,"祥瑞坐骑.wdf"},{0x0000109,0x0000112,"祥瑞坐骑.wdf"},{0x0000109,0x0000112,"祥瑞坐骑.wdf"},{0x0000109,0x0000112,"祥瑞坐骑.wdf"}}
	elseif id == "羽灵神" then
		scs = {{0x7D31F43E,0x76E4E3D6,"祥瑞坐骑.wdf"},{0x7B86A5F4,0xE496A2D7,"祥瑞坐骑.wdf"},{0x8072202A,0x6528F013,"祥瑞坐骑.wdf"},{0x4BBD02E6,0x694A236B,"祥瑞坐骑.wdf"}}
	elseif id == "神天兵" then
		scs = {{0x77104303,0xBC38000F,"祥瑞坐骑.wdf"},{0xF4EF98B5,0x7C731501,"祥瑞坐骑.wdf"},{0x7F6D09AB,0x13AD1C23,"祥瑞坐骑.wdf"},{0x60A47C21,0x63930A54,"祥瑞坐骑.wdf"}}
	elseif id == "龙太子" then
		scs = {{0x4F27A59F,0x801F438D,"祥瑞坐骑.wdf"},{0x46F4FDF6,0xC9EF2751,"祥瑞坐骑.wdf"},{0x5B0EDDAD,0xB227D39F,"祥瑞坐骑.wdf"},{0x643F7DDE,0xCC8E0921,"祥瑞坐骑.wdf"}}
	end

	if zq==nil then
		tp.窗口.消息框:添加文本("坐骑zp1为空"..zq,"xt")
	elseif  zq~=nil and zqs[zq]==nil and 引擎.新增坐骑(sp,zq,"站立")==nil then
		tp.窗口.消息框:添加文本("坐骑zp2为空"..zq,"xt")
	elseif  zq~=nil and zqs[zq]~=nil and zqs[zq][3]==nil and 引擎.新增坐骑(sp,zq,"站立")==nil  then
		tp.窗口.消息框:添加文本("坐骑zp3为空"..zq,"xt")
	end
	if zqs[zq]==nil then
		return
	end
	local bh = zqs[zq][3]
	-- table.print(zqs[zq])
	return {坐骑资源=zqs[zq][4],坐骑站立=zqs[zq][1],坐骑行走=zqs[zq][2],人物资源=scs[bh][3],人物站立=scs[bh][1],人物行走=scs[bh][2],坐骑饰品站立=sps[sp][1],坐骑饰品行走=sps[sp][2],坐骑饰品资源=sps[sp][3]}
end

	-- body
