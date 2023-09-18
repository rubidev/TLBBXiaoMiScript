---
--- Created by up
--- DateTime: 2023/8/14 11:09
---


-- 加密
function encode(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

-- 解密
function huayuanbaobao(a) local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'; a = string.gsub(a, '[^'..b..'=]', ''); return (a:gsub('.', function(x) if (x == '=') then return '' end; local r,f='',(b:find(x)-1); for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end;return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end; local c=0; for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end; return string.char(c); end)); end


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

function readFile(file_path)
    local f = assert(io.open(file_path, 'r'))
    local content = f:read('*all')
    f:close()
    return content
end



local sourceStr = readFile("'D:\\tlbbxiao-mi-script\\可release脚本\\兑换元宝票加密.lua'")
print("------ sourceStr:", sourceStr)
local newStr = encode(sourceStr)
------ newStr:	ZXZlcnR5RGF5X0xvZ2luX3JlZnJlc2gjMSN0cnVlI2ZhbHNlIzAjbmlsIzEwMA==
print("------ newStr:", newStr)
local ret = decryptedString(newStr)
------ sourceStr:	evertyDay_Login_refresh#1#true#false#0#nil#100
print("------ sourceStr:", ret)


ttt = readFile('D:\\tlbbxiao-mi-script\\加密解密工具\\encryptCode.txt')
print(ttt)

print(ttt == newStr)
