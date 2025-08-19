-- 编码转换工具模块
-- 处理HTTP响应的编码转换

local encoding_utils = {}

-- 检测字符串编码
function encoding_utils.detect_encoding(content)
    -- 检查是否包含UTF-8 BOM
    if content:sub(1, 3) == "\239\187\191" then
        return "UTF-8"
    end
    
    -- 检查是否包含UTF-16 BOM
    if content:sub(1, 2) == "\255\254" or content:sub(1, 2) == "\254\255" then
        return "UTF-16"
    end
    
    -- 检查是否包含GBK/GB2312特征
    local has_gbk = false
    for i = 1, #content do
        local byte = content:byte(i)
        if byte > 127 then
            has_gbk = true
            break
        end
    end
    
    if has_gbk then
        return "GBK"
    end
    
    return "UTF-8"
end

-- 转换编码（简化版本）
function encoding_utils.convert_encoding(content, from_encoding, to_encoding)
    if from_encoding == to_encoding then
        return content
    end
    
    -- 如果是GBK转UTF-8，使用系统命令
    if from_encoding == "GBK" and to_encoding == "UTF-8" then
        local temp_file = os.tmpname()
        local temp_file2 = os.tmpname()
        
        -- 写入临时文件
        local file = io.open(temp_file, "wb")
        if file then
            file:write(content)
            file:close()
            
            -- 使用系统命令转换
            local cmd = string.format('powershell -Command "[System.Text.Encoding]::GetEncoding(936).GetString([System.IO.File]::ReadAllBytes(\'%s\')) | Out-File -FilePath \'%s\' -Encoding UTF8"', temp_file, temp_file2)
            local result = os.execute(cmd)
            
            if result then
                local read_file = io.open(temp_file2, "r")
                if read_file then
                    local converted = read_file:read("*a")
                    read_file:close()
                    os.remove(temp_file)
                    os.remove(temp_file2)
                    return converted
                end
            end
            
            os.remove(temp_file)
            os.remove(temp_file2)
        end
    end
    
    -- 如果是UTF-8转GBK
    if from_encoding == "UTF-8" and to_encoding == "GBK" then
        local temp_file = os.tmpname()
        local temp_file2 = os.tmpname()
        
        -- 写入临时文件
        local file = io.open(temp_file, "w")
        if file then
            file:write(content)
            file:close()
            
            -- 使用系统命令转换
            local cmd = string.format('powershell -Command "[System.IO.File]::ReadAllText(\'%s\', [System.Text.Encoding]::UTF8) | Out-File -FilePath \'%s\' -Encoding Default"', temp_file, temp_file2)
            local result = os.execute(cmd)
            
            if result then
                local read_file = io.open(temp_file2, "rb")
                if read_file then
                    local converted = read_file:read("*a")
                    read_file:close()
                    os.remove(temp_file)
                    os.remove(temp_file2)
                    return converted
                end
            end
            
            os.remove(temp_file)
            os.remove(temp_file2)
        end
    end
    
    return content
end

-- 自动转换HTTP响应编码
function encoding_utils.convert_http_response(content, content_type)
    if not content or #content == 0 then
        return content
    end
    
    -- 检查Content-Type中的编码信息
    local charset = "UTF-8"
    if content_type then
        local charset_match = content_type:match("charset=([^;]+)")
        if charset_match then
            charset = charset_match:upper()
        end
    end
    
    -- 对于HTTP响应，大多数现代网站都使用UTF-8
    -- 如果检测到是GBK编码，才进行转换
    local detected_encoding = encoding_utils.detect_encoding(content)
    
    __gge.print(false, 10, "Content-Type: " .. (content_type or "unknown") .. "\n")
    __gge.print(false, 10, "Detected encoding: " .. detected_encoding .. "\n")
    __gge.print(false, 10, "Content-Type charset: " .. charset .. "\n")
    
    -- 如果检测到的编码与Content-Type不匹配，使用检测到的编码
    if detected_encoding ~= charset and detected_encoding == "GBK" then
        __gge.print(false, 10, "Converting from GBK to UTF-8\n")
        return encoding_utils.convert_encoding(content, "GBK", "UTF-8")
    end
    
    -- 如果Content-Type明确指定了GBK，进行转换
    if charset == "GBK" or charset == "GB2312" then
        __gge.print(false, 10, "Converting from " .. charset .. " to UTF-8\n")
        return encoding_utils.convert_encoding(content, charset, "UTF-8")
    end
    
    -- 默认返回原内容（假设已经是UTF-8）
    __gge.print(false, 10, "No conversion needed, returning original content\n")
    return content
end

-- 测试编码转换
function encoding_utils.test_encoding()
    __gge.print(false, 10, "=== Testing Encoding Conversion ===\n")
    
    -- 测试UTF-8检测
    local utf8_content = "Hello World 你好世界"
    local detected = encoding_utils.detect_encoding(utf8_content)
    __gge.print(false, 10, "UTF-8 content detected as: " .. detected .. "\n")
    
    -- 测试编码转换
    local converted = encoding_utils.convert_http_response(utf8_content, "text/html; charset=UTF-8")
    __gge.print(false, 10, "Converted content length: " .. #converted .. "\n")
    
    __gge.print(false, 10, "=== Encoding Test Completed ===\n")
end

return encoding_utils 