local http_client = {}

-- 使用 Lua 内置功能实现简单的 HTTP 请求
-- 注意：这是一个简化版本，主要用于调用 AI 接口

local function make_http_request(url, method, headers, body)
    -- 这里使用系统命令 curl 作为备选方案
    local temp_file = os.tmpname()
    local curl_cmd = string.format(
        'curl -s -X %s -H "Content-Type: application/json" %s -d "%s" -o "%s"',
        method or "POST",
        url,
        body or "",
        temp_file
    )
    
    local result = os.execute(curl_cmd)
    if result then
        local file = io.open(temp_file, "r")
        if file then
            local content = file:read("*a")
            file:close()
            os.remove(temp_file)
            return content, 200
        end
    end
    
    if os.remove then os.remove(temp_file) end
    return nil, "HTTP request failed"
end

function http_client.request(url, options)
    options = options or {}
    local method = options.method or "GET"
    local headers = options.headers or {}
    local body = options.body or ""
    
    return make_http_request(url, method, headers, body)
end

return http_client 