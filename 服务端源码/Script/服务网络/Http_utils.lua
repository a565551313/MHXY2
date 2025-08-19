-- HTTP工具函数
-- 提供常用的HTTP操作和工具函数

local http = require("Script.hpsocket_http")

local http_utils = {}

-- 安全的HTTP请求函数
function http_utils.safe_request(url, method, data, headers)
    local success, result, status = pcall(http.request, url, {
        method = method or "GET",
        headers = headers or {},
        body = data or ""
    })
    
    if not success then
        return nil, "请求异常: " .. tostring(result)
    end
    
    return result, status
end

-- 获取网页内容
function http_utils.get_webpage(url)
    return http_utils.safe_request(url, "GET")
end

-- 发送JSON数据
function http_utils.send_json(url, data, headers)
    headers = headers or {}
    headers["Content-Type"] = "application/json"
    
    local cjson = require("cjson")
    local json_data = cjson.encode(data or {})
    
    return http_utils.safe_request(url, "POST", json_data, headers)
end

-- 发送表单数据
function http_utils.send_form(url, data, headers)
    headers = headers or {}
    headers["Content-Type"] = "application/x-www-form-urlencoded"
    
    local form_data = {}
    for key, value in pairs(data or {}) do
        form_data[#form_data + 1] = key .. "=" .. tostring(value)
    end
    
    local body = table.concat(form_data, "&")
    return http_utils.safe_request(url, "POST", body, headers)
end

-- 检查网络连接
function http_utils.check_connection()
    local result, status = http.get("https://httpbin.org/get")
    return result ~= nil and status == 200
end

-- 获取服务器时间
function http_utils.get_server_time()
    local result, status = http.get("https://httpbin.org/get")
    if result then
        local cjson = require("cjson")
        local data = cjson.decode(result)
        return data and data.headers and data.headers["Date"]
    end
    return nil
end

-- 下载文件（简单版本）
function http_utils.download_file(url, filename)
    local result, status = http.get(url)
    if result then
        local file = io.open(filename, "wb")
        if file then
            file:write(result)
            file:close()
            return true
        end
    end
    return false
end

-- 调用AI接口的通用函数
function http_utils.call_ai_api(api_url, api_key, message, model)
    local data = {
        model = model or "gpt-3.5-turbo",
        messages = {
            {role = "user", content = message}
        },
        max_tokens = 1000
    }
    
    local headers = {
        ["Content-Type"] = "application/json",
        ["Authorization"] = "Bearer " .. api_key
    }
    
    return http_utils.send_json(api_url, data, headers)
end

-- 发送通知到Discord/Slack等
function http_utils.send_notification(webhook_url, message, username)
    local data = {
        content = message,
        username = username or "游戏服务器"
    }
    
    return http_utils.send_json(webhook_url, data)
end

-- 获取天气信息（示例）
function http_utils.get_weather(city)
    -- 这里需要替换为实际的天气API
    local url = "https://api.weatherapi.com/v1/current.json"
    local data = {
        key = "your-api-key",
        q = city,
        aqi = "no"
    }
    
    return http_utils.send_form(url, data)
end

-- 验证码验证（示例）
function http_utils.verify_captcha(secret_key, response)
    local url = "https://www.google.com/recaptcha/api/siteverify"
    local data = {
        secret = secret_key,
        response = response
    }
    
    return http_utils.send_form(url, data)
end

-- 日志记录到远程服务器
function http_utils.log_to_server(log_server_url, log_data)
    local data = {
        timestamp = os.time(),
        level = log_data.level or "info",
        message = log_data.message,
        server = "游戏服务器",
        version = "1.0.0"
    }
    
    return http_utils.send_json(log_server_url, data)
end

-- 检查更新
function http_utils.check_update(update_url, current_version)
    local result, status = http.get(update_url)
    if result then
        local cjson = require("cjson")
        local data = cjson.decode(result)
        if data and data.version then
            return data.version > current_version, data
        end
    end
    return false, nil
end

-- 测试所有功能
function http_utils.test_all()
    __gge.print(false, 10, "=== Starting HTTP Utils Test ===\n")
    
    -- 测试网络连接
    local connected = http_utils.check_connection()
    __gge.print(false, 10, "Network connection: " .. (connected and "✓" or "✗") .. "\n")
    
    -- 测试获取网页
    local result, status = http_utils.get_webpage("https://httpbin.org/get")
    __gge.print(false, 10, "Get webpage: " .. (result and "✓" or "✗") .. "\n")
    
    -- 测试发送JSON
    local json_result, json_status = http_utils.send_json("https://httpbin.org/post", {
        test = "data",
        message = "Hello World"
    })
    __gge.print(false, 10, "Send JSON: " .. (json_result and "✓" or "✗") .. "\n")
    
    -- 测试发送表单
    local form_result, form_status = http_utils.send_form("https://httpbin.org/post", {
        username = "test",
        password = "test123"
    })
    __gge.print(false, 10, "Send form: " .. (form_result and "✓" or "✗") .. "\n")
    
    __gge.print(false, 10, "=== HTTP Utils Test Completed ===\n")
end

return http_utils 