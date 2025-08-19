-- 使用我们自己的HTTP客户端替代socket.http
local http_client = require("Script.HttpSocket.hpsocket_http")
local cjson = require("cjson")

-- 请在下方填写你的 deepseek API Key
local api_key = "sk-f182f6ab3b0e44b5bbade8b39720b46a"  -- TODO: 在这里填写你的 deepseek API Key

local function call_deepseek_ai(user_msg)
    local url = "https://api.deepseek.com/v1/chat/completions"
    
    -- 使用我们的HTTP客户端
    local resp_body, status = http_client.post(url, {
        model = "deepseek-chat",
        messages = {
            {role = "user", content = user_msg}
        }
    }, {
        ["Authorization"] = "Bearer " .. api_key
    })
    
    print("[deepseek_ai 调试] status:", status)
    print("[deepseek_ai 调试] resp_body:", resp_body)
    
    if resp_body then
        print("[deepseek_ai 调试] decode前原始内容:", resp_body)
        local data = cjson.decode(resp_body)
        if data and data.choices and data.choices[1] and data.choices[1].message then
            return data.choices[1].message.content
        else
            print("[deepseek_ai 调试] AI返回格式异常", resp_body)
            return nil, "AI返回格式异常"
        end
    else
        print("[deepseek_ai 调试] AI接口调用失败，状态：", status)
        return nil, "AI接口调用失败，状态："..tostring(status)
    end
end

return {
    call_deepseek_ai = call_deepseek_ai
} 