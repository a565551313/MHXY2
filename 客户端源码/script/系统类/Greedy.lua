-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2022-11-13 11:29:50
-- @最后修改来自: baidwwy
-- @Last Modified time: 2025-05-16 20:13:02

local Greedy = class()

function Greedy:初始化()
    self.lineList   = require "script/资源类/传送点坐标"
    self:init()
    --return self
end

function Greedy:init()
    self.curAllPathList = {}
    self.waitCheckList  = {}
    self.checkList      = {}
    self.startIndex		= nil
    self.endIndex		= nil
    self.minValue       = nil -- 最优解
    self.minPathList    = nil -- 最优的路径(不一定只有一条)
end

function Greedy:getValue(index1, index2)
    for k,v in pairs(self.lineList) do
        if (v.当前地图+0 == index1+0 and v.目标地图+0 == index2+0) or (v.目标地图+0 == index2+0 and v.当前地图+0 == index1+0) then
            return 取两点距离a(v.x,v.y,v.x1,v.y1)
        end
    end
   	--print(index1,index2)
    return 9999
end

function Greedy:findPath(当前地图,目标地图)
    for k,v in pairs(self.lineList) do
        if (v.当前地图 == 当前地图 and v.目标地图 == 目标地图) then
            return v
        end
    end
    return nil
end

function Greedy:getFinalPathList(pathList)
	local finalPathList = {}
    for k,v in pairs(pathList) do
    	if #v.path <= 1 then
    		print("当前地图寻径")
    	else
	    	for i=2,#v.path do
	    		table.insert(finalPathList,self:findPath(v.path[i-1],v.path[i]))
	    	end
    	end
    	if v.value >= 9999 then
    		return nil
    	end
        print(string.format("path = %s, value = %d", table.concat(v.path, "-"), v.value))
    end
    return finalPathList
end

-- 获取最短的路径
function Greedy:getShortPath(startIndex,endIndex)
    self:init()
    self.startIndex=startIndex
    self.endIndex=endIndex
    self.waitCheckList = {self.startIndex}
  --  print(startIndex,endIndex)
    local index = self:getNextCheckPoint()
    while true do
        self:updateNewPath(index)
        self.checkList[#self.checkList+1] = index
        index = self:getNextCheckPoint()

        if not index then
            break
        end
    end
    return self:getFinalPathList(self.curAllPathList)
end


function Greedy:getPathValue(path)
    local sum = 0
    for i=1, #path-1 do
    	--print(path[i],path[i+1],self:getValue(path[i], path[i+1]))
        sum = sum + self:getValue(path[i], path[i+1])
    end
    return sum
end


function Greedy:getAllCurNextPoint(curPoint)
    local pointList = {}
    for k,v in pairs(self.lineList) do
        local p1 = v.当前地图
        local p2 = v.目标地图

        if p1 == curPoint then
            if not isContain(pointList, p2) then
                pointList[#pointList+1] = p2
            end
        end
        if p2 == curPoint then
            if not isContain(pointList, p1) then
                pointList[#pointList+1] = p1
            end
        end
    end

    for k,v in pairs(self.checkList) do
        for k2,v2 in pairs(pointList) do
            if v == v2 then
                table.remove(pointList, k2)
                break
            end
        end
    end

    return pointList
end

function Greedy:updateNewPath(curPoint)
    if #self.curAllPathList == 0 then
        local list = self:getAllCurNextPoint(curPoint)
        for k,v in pairs(list) do
            local path = {curPoint, v}
            self.curAllPathList[#self.curAllPathList+1] = {path=path, value=self:getPathValue(path)}
        end
        self:addToWaitCheckList(list)
    else
        local newList = {}
        local count = #self.curAllPathList
        for i=1, count do
            for k,v in pairs(self.curAllPathList) do
                if v.path[#v.path] == curPoint then
                    local list = self:getAllCurNextPoint(curPoint)
                    self:addToWaitCheckList(list)
                    for _,v2 in pairs(list) do
                        local oneList = copy(v.path)
                        oneList[#oneList+1] = v2
                        newList[#newList+1] = {path=oneList, value=self:getPathValue(oneList)}
                    end
                    table.remove(self.curAllPathList, k)
                    break
                end
            end
        end


        for k,v in pairs(newList) do
            self:updateCurAllPathList(v)
        end
    end
end


function Greedy:updateCurAllPathList(pathList)
    local function isSameEndPath(pathList1, pathList2)
        return pathList1[1] == pathList2[1] and pathList1[#pathList1] == pathList2[#pathList2]
    end

    local function checkAllPathList()
        for k,v in pairs(self.curAllPathList) do
            if v.path[#v.path] == self.endIndex then
                if not self.minValue then
                    self.minValue = v.value
                    self.minPathList = v
                elseif self.minValue > v.value then
                    minValue = v.value
                    self.minPathList = v
                end
            end
        end

        if self.minValue then
            local count = #self.curAllPathList
            for i=1, count do
                for k,v in pairs(self.curAllPathList) do
                    if v.value > self.minValue then
                        table.remove(self.curAllPathList, k)
                        break
                    end
                end
            end
        end
    end

    for k,v in pairs(self.curAllPathList) do
        local path = v.path
        local path2 = pathList.path
        if path[1] == path2[1] and path[#path] == path2[#path2] then
            if v.value > pathList.value then -- 局部最优替换
                table.remove(self.curAllPathList, k)
                self.curAllPathList[#self.curAllPathList+1] = pathList
                checkAllPathList()
                return
            elseif v.value < pathList.value then
                return
            end
        end
    end
    self.curAllPathList[#self.curAllPathList+1] = pathList
    checkAllPathList()
end


-- 获取下一个检查点(每获取一次列表里就移除一次)
function Greedy:getNextCheckPoint()
    if #self.waitCheckList == 0 then
        return nil -- 代表已经没有可检查的点了
    end

    local point = self.waitCheckList[1]
    table.remove(self.waitCheckList, 1)
    return point
end


function Greedy:addToWaitCheckList(list)
    for k,v in pairs(list) do
        if not isContain(self.waitCheckList, v) and not isContain(self.checkList, v) and v ~= self.endIndex then
            self.waitCheckList[#self.waitCheckList+1] = v
        end
    end
end

function Greedy:更新(dt)

end


function Greedy:显示()

end

return Greedy