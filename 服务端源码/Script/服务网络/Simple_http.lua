-- 简单HTTP客户端
-- 使用Windows PowerShell实现HTTP请求

local simple_http = {}
local encoding_utils = require("Script.encoding_utils")

-- 使用PowerShell发送HTTP请求
local function make_ps_request(url, method, headers, body)
    local temp_file = os.tmpname()
    local header_args = ""
    
    -- 构建PowerShell命令
    if headers then
        for key, value in pairs(headers) do
            header_args = header_args .. string.format(' -Headers @{"%s"="%s"}', key, value)
        end
    end
    
    local ps_cmd = string.format(
        'powershell -Command "try { $response = Invoke-RestMethod -Uri \\"%s\\" -Method %s%s -OutFile \\"%s\\"; Write-Output \\"SUCCESS\\" } catch { Write-Output \\"ERROR: $($_.Exception.Message)\\" }"',
        url,
        method or "GET",
        header_args,
        temp_file
    )
    
    __gge.print(false, 10, "Executing PowerShell command: " .. ps_cmd .. "\n")
    
    local result = os.execute(ps_cmd)
    __gge.print(false, 10, "PowerShell execution result: " .. tostring(result) .. "\n")
    
    if result then
        local file = io.open(temp_file, "r")
        if file then
            local content = file:read("*a")
            file:close()
            os.remove(temp_file)
            
            -- 尝试转换编码
            local converted_content = encoding_utils.convert_http_response(content, "text/html; charset=UTF-8")
            __gge.print(false, 10, "HTTP request successful, response length: " .. #converted_content .. "\n")
            return converted_content, 200
        else
            __gge.print(false, 10, "Cannot read temp file: " .. temp_file .. "\n")
        end
    else
        __gge.print(false, 10, "PowerShell command execution failed\n")
    end
    
    if os.remove then 
        os.remove(temp_file)
    end
    return nil, "HTTP request failed"
end

-- GET请求
function simple_http.get(url, headers)
    __gge.print(false, 10, "Sending GET request: " .. url .. "\n")
    return make_ps_request(url, "GET", headers)
end

-- POST请求
function simple_http.post(url, data, headers)
    headers = headers or {}
    headers["Content-Type"] = headers["Content-Type"] or "application/json"
    
    local body = ""
    if type(data) == "table" then
        if headers["Content-Type"] == "application/json" then
            local cjson = require("cjson")
            body = cjson.encode(data)
        else
            local form_data = {}
            for key, value in pairs(data) do
                form_data[#form_data + 1] = key .. "=" .. tostring(value)
            end
            body = table.concat(form_data, "&")
        end
    else
        body = tostring(data or "")
    end
    
    __gge.print(false, 10, "Sending POST request: " .. url .. "\n")
    __gge.print(false, 10, "POST data: " .. body .. "\n")
    
    return make_ps_request(url, "POST", headers, body)
end

-- 测试函数
function simple_http.test()
    __gge.print(false, 10, "Starting simple HTTP test...\n")
    local result, status = simple_http.get("https://httpbin.org/get")
    if result then
        __gge.print(false, 10, "Simple HTTP test successful\n")
        return true
    else
        __gge.print(false, 10, "Simple HTTP test failed: " .. tostring(status) .. "\n")
        return false
    end
end

-- 检查PowerShell是否可用
function simple_http.check_powershell()
    local result = os.execute('powershell -Command "Write-Output \\"PowerShell Available\\""')
    if result then
        __gge.print(false, 10, "PowerShell command available\n")
        return true
    else
        __gge.print(false, 10, "PowerShell command not available\n")
        return false
    end
end

return simple_http 