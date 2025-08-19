-- 基本测试脚本
-- 测试系统命令执行是否正常

local basic_test = {}

-- 测试echo命令
function basic_test.test_echo()
    __gge.print(false, 10, "=== Testing echo command ===\n")
    
    local result = os.execute('echo "Hello World"')
    __gge.print(false, 10, "echo command execution result: " .. tostring(result) .. "\n")
    
    return result
end

-- 测试dir命令
function basic_test.test_dir()
    __gge.print(false, 10, "=== Testing dir command ===\n")
    
    local result = os.execute('dir')
    __gge.print(false, 10, "dir command execution result: " .. tostring(result) .. "\n")
    
    return result
end

-- 测试ping命令
function basic_test.test_ping()
    __gge.print(false, 10, "=== Testing ping command ===\n")
    
    local result = os.execute('ping -n 1 8.8.8.8')
    __gge.print(false, 10, "ping command execution result: " .. tostring(result) .. "\n")
    
    return result
end

-- 测试PowerShell基本命令
function basic_test.test_powershell_basic()
    __gge.print(false, 10, "=== Testing PowerShell basic command ===\n")
    
    local result = os.execute('powershell -Command "Write-Output \\"PowerShell Test\\""')
    __gge.print(false, 10, "PowerShell basic command execution result: " .. tostring(result) .. "\n")
    
    return result
end

-- 测试curl命令
function basic_test.test_curl()
    __gge.print(false, 10, "=== Testing curl command ===\n")
    
    local result = os.execute('curl --version')
    __gge.print(false, 10, "curl command execution result: " .. tostring(result) .. "\n")
    
    return result
end

-- 测试文件操作
function basic_test.test_file_ops()
    __gge.print(false, 10, "=== Testing file operations ===\n")
    
    local test_file = "test_file.txt"
    local test_content = "This is a test file"
    
    -- 写入文件
    local file = io.open(test_file, "w")
    if file then
        file:write(test_content)
        file:close()
        __gge.print(false, 10, "File write successful\n")
        
        -- 读取文件
        local read_file = io.open(test_file, "r")
        if read_file then
            local content = read_file:read("*a")
            read_file:close()
            __gge.print(false, 10, "File read successful, content: " .. content .. "\n")
            
            -- 删除文件
            os.remove(test_file)
            __gge.print(false, 10, "File delete successful\n")
            
            return true
        else
            __gge.print(false, 10, "File read failed\n")
        end
    else
        __gge.print(false, 10, "File write failed\n")
    end
    
    return false
end

-- 运行所有基本测试
function basic_test.run_all()
    __gge.print(false, 10, "Starting basic tests...\n")
    
    basic_test.test_echo()
    __gge.print(false, 10, "\n")
    
    basic_test.test_dir()
    __gge.print(false, 10, "\n")
    
    basic_test.test_ping()
    __gge.print(false, 10, "\n")
    
    basic_test.test_powershell_basic()
    __gge.print(false, 10, "\n")
    
    basic_test.test_curl()
    __gge.print(false, 10, "\n")
    
    basic_test.test_file_ops()
    __gge.print(false, 10, "\n")
    
    __gge.print(false, 10, "Basic tests completed!\n")
end

return basic_test 