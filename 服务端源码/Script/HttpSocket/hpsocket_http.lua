-- HPSocket HTTP 客户端
-- 基于HPSocket实现HTTP请求功能

local http_client = {}

-- 安全地加载encoding_utils模块
local encoding_utils = nil
local success, module = pcall(require, "Script.encoding_utils")
if success then
    encoding_utils = module
    __gge.print(false, 10, "encoding_utils module loaded successfully\n")
else
    __gge.print(false, 10, "encoding_utils module not found, continuing without encoding support\n")
end

-- 安全的shell参数转义函数
local function escape_shell_arg(str)
    if not str then return "" end
    -- 转义特殊字符
    return string.gsub(str, '([^%w%./-])', '\\%1')
end

-- 安全的URL编码函数
local function url_encode(str)
    if not str then return "" end
    return string.gsub(str, "([^%w])", function(c)
        return string.format("%%%02X", string.byte(c))
    end)
end

-- 清理临时文件的函数
local function cleanup_temp_file(file_path)
    if file_path and os.remove then
        local success = pcall(os.remove, file_path)
        if not success then
            __gge.print(false, 10, "Failed to remove temp file: " .. tostring(file_path) .. "\n")
        end
    end
end

-- 使用系统命令实现HTTP请求（作为主要方案）
local function make_http_request(url, method, headers, body)
    local temp_file = os.tmpname()
    local header_args = ""
    
    -- 构建curl命令的头部参数
    if headers then
        for key, value in pairs(headers) do
            -- 安全转义header值
            local escaped_key = escape_shell_arg(key)
            local escaped_value = escape_shell_arg(value)
            header_args = header_args .. string.format(' -H "%s: %s"', escaped_key, escaped_value)
        end
    end
    
    -- 安全转义body内容
    local escaped_body = escape_shell_arg(body or "")
    
    -- 添加超时和错误处理参数
    local curl_cmd = string.format(
        'curl -s --connect-timeout 10 --max-time 30 --fail -X %s%s -d "%s" -o "%s" "%s"',
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
            
            -- 尝试编码转换（如果encoding_utils可用）
            if encoding_utils and encoding_utils.convert_encoding then
                local converted_content = encoding_utils.convert_encoding(content, "utf-8")
                if converted_content then
                    content = converted_content
                    __gge.print(false, 10, "Content encoding converted successfully\n")
                end
            end
            
            __gge.print(false, 10, "HTTP request successful, response length: " .. #content .. "\n")
            
            -- 清理临时文件
            cleanup_temp_file(temp_file)
            
            return content, 200
        else
            __gge.print(false, 10, "Cannot read temp file: " .. temp_file .. "\n")
            cleanup_temp_file(temp_file)
        end
    else
        __gge.print(false, 10, "curl command execution failed\n")
        cleanup_temp_file(temp_file)
    end
    
    return nil, "HTTP request failed"
end

-- 主要的HTTP请求函数
function http_client.request(url, options)
    options = options or {}
    local method = options.method or "GET"
    local headers = options.headers or {}
    local body = options.body or ""
    
    -- 验证URL格式
    if not url or url == "" then
        __gge.print(false, 10, "Error: Invalid URL\n")
        return nil, "Invalid URL"
    end
    
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
            local success, cjson = pcall(require, "cjson")
            if success then
                body = cjson.encode(data)
            else
                __gge.print(false, 10, "Warning: cjson module not available, using string representation\n")
                body = tostring(data)
            end
        else
            -- 如果是表单数据
            local form_data = {}
            for key, value in pairs(data) do
                form_data[#form_data + 1] = url_encode(key) .. "=" .. url_encode(tostring(value))
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
    
    -- 首先检查curl是否可用
    if not http_client.check_curl() then
        __gge.print(false, 10, "HTTP test failed: curl not available\n")
        return false
    end
    
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
    local result = os.execute("curl --version >nul 2>&1")
    if result then
        __gge.print(false, 10, "curl command available\n")
        return true
    else
        __gge.print(false, 10, "curl command not available, please install curl\n")
        return false
    end
end

-- 获取HTTP状态码（从curl输出中解析）
function http_client.get_status_code(response)
    -- 这里可以添加状态码解析逻辑
    -- 目前返回默认200，因为curl -s不显示状态码
    return 200
end

-- 设置超时时间
function http_client.set_timeout(connect_timeout, max_timeout)
    http_client.connect_timeout = connect_timeout or 10
    http_client.max_timeout = max_timeout or 30
end

return http_client 