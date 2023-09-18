---
--- Created by up
--- DateTime: 2023/8/14 11:14
---

function readFile(file_path)
    local f = assert(io.open(file_path, 'r'))
    local content = f:read('*all')
    f:close()
    return content
end

-- 解密
function decryptedString(a)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    a = string.gsub(a, '[^'..b..'=]', '')
    return (a:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

-- 解密
function huayuanbaobao(a) local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'; a = string.gsub(a, '[^'..b..'=]', ''); return (a:gsub('.', function(x) if (x == '=') then return '' end; local r,f='',(b:find(x)-1); for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end;return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end; local c=0; for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end; return string.char(c); end)); end


-- 执行 ---------------------------------------------
encrypted_path = 'D:\\tlbbxiao-mi-script\\可release脚本\\兑换元宝票加密.lua'
encryptedData = readFile(encrypted_path)
decryptedRet = decryptedString(encryptedData)
print(decryptedRet)
