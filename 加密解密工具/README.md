# 加密使用方式
- **此加密工具基于lua5.4开发, 其它版本不知是否兼容**

## 1. 开发lua文本源码
- **注释源码中需要用户配置的参数**

## 2. 修改加密脚本, 生成加密数据
- 修改变量`origin_path`
- 切换到加密工具目录: `cd \<path>\加密解密工具\`
- 运行加密脚本: `lua54 encryption.lua`
- 运行脚本后会在当前目录下生成`encryptCode.txt`


## 3. 创建加密后的文本
- 复制一份`encode_tmplate.lua`文件，并修改文件名字为`<function>.lua`
- 打开`encryptCode.txt`, 将其中的数据粘贴到`<function>.lua`中的`m`变量
- 添加需用用户配置的参数, 给用户自定义配置使用
- 完成加密