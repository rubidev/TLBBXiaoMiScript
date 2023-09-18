---
--- Created by up
--- DateTime: 2023/8/14 11:11
---

function readFile(file_path)
    local f = assert(io.open(file_path, 'r'))
    local content = f:read('*all')
    f:close()
    return content
end

function writeFile(file_path, data)
    local f = assert(io.open(file_path, 'w'))
    f:write(data)
    f:close()
end

-- 加密
function encryptString(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
        local r, b = '', x:byte()
        for i = 8, 1, -1 do
            r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and '1' or '0')
        end
        return r;
    end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then
            return ''
        end
        local c = 0
        for i = 1, 6 do
            c = c + (x:sub(i, i) == '1' and 2 ^ (6 - i) or 0)
        end
        return b:sub(c + 1, c + 1)
    end) .. ({ '', '==', '=' })[#data % 3 + 1])
end


-- 执行 ---------------------------------------------------------------------------------
-- TODO 修改origin_path，即lua文本源码文件的路径
origin_path = 'D:\\tlbbxiao-mi-script\\可release脚本\\兑换元宝票加密.lua'

srcData = readFile(origin_path)
print("Source_Code: ", srcData)
encryptRet = encryptString(srcData)
print("Encryption_Code: ", encryptRet)
ret_path = 'encryptCode.txt'
writeFile(ret_path, encryptRet)

