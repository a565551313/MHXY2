-- HPSocket HTTP 客户端
-- 基于HPSocket实现HTTP请求功能

local http_client = {}
local encoding_utils = require("Script.encoding_utils")

-- 使用系统命令实现HTTP请求（作为主要方案）
local function make_http_request(url, method, headers, body)
    local temp_file = os.tmpname()
    local header_args = ""
    
    -- 构建curl命令的头部参数
    if headers then
        for key, value in pairs(headers) do
            header_args = header_args .. string.format(' -H "%s: %s"', key, value)
        end
    end
    
    -- 转义body中的特殊字符
    local escaped_body = (body or ""):gsub('"', '\\"')
    
    local curl_cmd = string.format(
        'curl -s -X %s%s -d "%s" -o "%s" "%s"',
        method or "GET",
        header_args,
        escaped_body,
        temp_file,
        url
    )
    
    -- 调试输出
    __gge.print(false, 10, "Executing curl command: " .. curl_cmd .. "\n")
    
    local result = os.execute(curl_cmd)
    __gge.print(false, 10, "curl execution result: " .. tostring(result) .. "\n")
    
    if result then
        local file = io.open(temp_file, "r")
        if file then
            local content = file:read("*a")
            file:close()
            os.remove(temp_file)
            
            -- 暂时跳过编码转换，直接返回原始内容
            __gge.print(false, 10, "HTTP request successful, response length: " .. #content .. "\n")
            __gge.print(false, 10, "Returning original content without encoding conversion\n")
            
            return content, 200
        else
            __gge.print(false, 10, "Cannot read temp file: " .. temp_file .. "\n")
        end
    else
        __gge.print(false, 10, "curl command execution failed\n")
    end
    
    if os.remove then 
        local remove_result = os.remove(temp_file)
        __gge.print(false, 10, "Delete temp file: " .. tostring(remove_result) .. "\n")
    end
    return nil, "HTTP request failed"
end

-- 主要的HTTP请求函数
function http_client.request(url, options)
    options = options or {}
    local method = options.method or "GET"
    local headers = options.headers or {}
    local body = options.body or ""
    
    __gge.print(false, 10, "Sending HTTP request: " .. method .. " " .. url .. "\n")
    
    return make_http_request(url, method, headers, body)
end

-- GET请求
function http_client.get(url, headers)
    __gge.print(false, 10, "Sending GET request: " .. url .. "\n")
    return http_client.request(url, {
        method = "GET",
        headers = headers or {}
    })
end

-- POST请求
function http_client.post(url, data, headers)
    headers = headers or {}
    headers["Content-Type"] = headers["Content-Type"] or "application/json"
    
    local body = ""
    if type(data) == "table" then
        -- 如果是JSON数据
        if headers["Content-Type"] == "application/json" then
            local cjson = require("cjson")
            body = cjson.encode(data)
        else
            -- 如果是表单数据
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
    
    return http_client.request(url, {
        method = "POST",
        headers = headers,
        body = body
    })
end

-- 测试函数
function http_client.test()
    __gge.print(false, 10, "Starting HTTP test...\n")
    local result, status = http_client.get("https://httpbin.org/get")
    if result then
        __gge.print(false, 10, "HTTP test successful\n")
        return true
    else
        __gge.print(false, 10, "HTTP test failed: " .. tostring(status) .. "\n")
        return false
    end
end

-- 检查curl是否可用
function http_client.check_curl()
    local result = os.execute("curl --version")
    if result then
        __gge.print(false, 10, "curl command available\n")
        return true
    else
        __gge.print(false, 10, "curl command not available, please install curl\n")
        return false
    end
end

return http_client 