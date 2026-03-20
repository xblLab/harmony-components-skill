# crypto-js 加解密算法组件

## 简介

本软件是移植开源软件 crypto-js 源码在 OpenHarmony 上进行功能适配，在 OpenHarmony 上已支持原库 crypto-js 的功能，目前 crypto-js 已支持的算法有：MD5、SHA-1、SHA-256、HMAC、HMAC-MD5、HMAC-SHA1、HMAC-SHA256、PBKDF2、AES、RC4、DES 等。

## 详细介绍

### 简介

本软件是移植开源软件 crypto-js 源码在 OpenHarmony 上进行功能适配，在 OpenHarmony 上已支持原库 crypto-js 的功能，目前 crypto-js 已支持的算法有：MD5、SHA-1、SHA-256、HMAC、HMAC-MD5、HMAC-SHA1、HMAC-SHA256、PBKDF2、AES、RC4、DES 等。

### 下载安装

```bash
ohpm install @ohos/crypto-js
```

### 使用说明

#### 引入依赖

最新版本支持：

```typescript
import { CryptoJS } from '@ohos/crypto-js'
// 或者
import CryptoJS from '@ohos/crypto-js'
```

#### MD5 算法使用

MD5 信息摘要算法（英语：MD5 Message-Digest Algorithm），一种被广泛使用的密码散列函数，可以产生出一个 128 位（16 字节）的散列值（hash value），用于确保信息传输完整一致。

**MD5 特点：**
- 不可逆性 --- 根据 MD5 值计算不出原始数据
- 唯一性 --- 不同原始数据会有不同的 MD5 值

**MD5 算法在本库的使用：**

```typescript
// 第一步在需要使用到的页面，导入 CryptoJS
import { CryptoJS } from '@ohos/crypto-js'

// 第二步在需要使用到 md5 的业务逻辑，调用 md5 算法
var hash = CryptoJS.MD5("123456") // 传参是需要加密的内容，返回值是加密后的数据
```

#### AES 算法使用

AES 算法全称 Advanced Encryption Standard，又称 Rijndael 加密法，是美国联邦政府采用的一种区块加密标准。

AES 是对称加密，所以加密解密都需要用到同一个秘钥。

**AES 算法在本库的使用：**

```typescript
// 第一步在需要使用到的页面，导入 CryptoJS
import { CryptoJS } from '@ohos/crypto-js'

// 第二步定义加密解密需要用到的 key
var key = 'secret key 1234'

// 第三步在需要使用 AES 加密的业务逻辑，调用 AES 加密
var encrypted = CryptoJS.AES.encrypt('hello world', key).toString() // 传参为加密内容及秘钥

// 第四步在需要把上面的加密块解密的业务逻辑，调用 AES 解密，注意 key 必须相同
var decrypted = CryptoJS.AES.decrypt(encrypted, key) // 传参为加密后的内容及秘钥
```

#### 其它加密算法使用方式

如 sha1、sha256、sha224、sha512、sha384、sha3、ripemd160、hmac-md5、hmac-sha1、hmac-sha256、hmac-sha224、hmac-sha512、hmac-sha384、hmac-sha3、hmac-ripemd160、pbkdf2、aes、tripledes、rc4、rabbit、rabbit-legacy、evpkdf、des、triple-des、format-openssl、format-hex、enc-latin1、enc-utf8、enc-hex、enc-utf16、enc-base64、mode-cfb、mode-ctr、mode-ctr-gladman、mode-ofb、mode-ecb、pad-pkcs7、pad-ansix923、pad-iso10126、pad-iso97971、pad-zeropadding、pad-nopadding。

### 接口列表

- crypto-js/md5
- crypto-js/sha1
- crypto-js/sha256
- crypto-js/sha224
- crypto-js/sha512
- crypto-js/sha384
- crypto-js/sha3
- crypto-js/ripemd160
- crypto-js/hmac-md5
- crypto-js/hmac-sha1
- crypto-js/hmac-sha256
- crypto-js/hmac-sha224
- crypto-js/hmac-sha512
- crypto-js/hmac-sha384
- crypto-js/hmac-sha3
- crypto-js/hmac-ripemd160
- crypto-js/pbkdf2
- crypto-js/aes
- crypto-js/tripledes
- crypto-js/rc4
- crypto-js/rabbit
- crypto-js/rabbit-legacy
- crypto-js/evpkdf
- crypto-js/des
- crypto-js/triple-des
- crypto-js/format-openssl
- crypto-js/format-hex
- crypto-js/enc-latin1
- crypto-js/enc-utf8
- crypto-js/enc-hex
- crypto-js/enc-utf16
- crypto-js/enc-base64
- crypto-js/mode-cfb
- crypto-js/mode-ctr
- crypto-js/mode-ctr-gladman
- crypto-js/mode-ofb
- crypto-js/mode-ecb
- crypto-js/pad-pkcs7
- crypto-js/pad-ansix923
- crypto-js/pad-iso10126
- crypto-js/pad-iso97971
- crypto-js/pad-zeropadding
- crypto-js/pad-nopadding

### 关于混淆

代码混淆，请查看代码混淆简介。

如果希望 crypto-js 库在代码混淆过程中不会被混淆，需要在混淆规则配置文件 `obfuscation-rules.txt` 中添加相应的排除规则：

```properties
-keep
./oh_modules/@ohos/crypto-js
```

### 约束与限制

在下述版本验证通过：

- DevEco Studio: NEXT Beta1-5.0.3.806, SDK:API12 Release(5.0.0.66)
- DevEco Studio: 5.0.3.122, SDK: API12 (5.0.0.17)
- DevEco Studio: 4.1.3.600, SDK: API11 (4.1.0.67)

### 目录结构

```text
|---- crypto-js  
|     |---- entry  # 示例代码文件夹
|     |---- crypto  # crypto-js 库文件夹
|         |---- index.ts  # 对外接口
|         |---- src
|             |---- main
|                 |---- ets
|                     |---- components
|                         |---- crypto.ts  # 加密封装类
|     |---- README.md  # 安装使用方法                    
```

### 开源协议

本项目基于 MIT License，请自由地享受和参与开源。

### 遗留问题

- PBKDF2 算法性能问题

### 更新记录

#### v2.0.5

- Fix repository from gitee to gitcode in oh-packaage.json5

#### v2.0.4

- 添加 index.d.ts 声明文件
- 优化_doCryptBlock 方法，还原为源库的二阶数组写法
- 在 DevEco Studio: NEXT Beta1-5.0.3.806, SDK:API12 Release(5.0.0.66) 上验证通过

#### v2.0.4-rc.1

- 添加 index.d.ts 声明文件

#### v2.0.4-rc.0

- 优化_doCryptBlock 方法，还原为源库的二阶数组写法

#### v2.0.3

- 适配源库 4.2.0 版本，更改 PBKDF2 的默认哈希算法和迭代，以通过使用默认配置来防止弱安全性。
- 支持 blowfish 加密
- 修复不兼容 API9 问题
- 优化 hasOwn 方法

#### v2.0.3-rc.1

- 适配源库 4.2.0 版本，更改 PBKDF2 的默认哈希算法和迭代，以通过使用默认配置来防止弱安全性。
- 支持 blowfish 加密

#### v2.0.3-rc.0

- 修复不兼容 API9 问题

#### v2.0.2

- ArkTs 语法规则整改

#### v2.0.1

- 支持 export default 和 export 两种引入方式
- 适配 DevEco Studio:  4.0 Canary1(4.0.3.212)
- 适配 SDK: API 10 Release(4.0.8.3)

#### v2.0.0

- 包管理工具由 npm 切换为 ohpm
- 适配 DevEco Studio: 3.1 Beta2(3.1.0.400)
- 适配 SDK: API9 Release(3.2.11.9)

#### v1.0.6

- 完善 DevEco Studio 3.1 Beta1 及以上版本适配
- 去掉 polyfill 接口，采用 sdk 接口

#### v1.0.5

- 适配 DevEco Studio 3.1 Beta1 及以上版本

#### v1.0.4

- 修复加解密不可逆的问题

#### v1.0.3

- 修复加密算法中特殊字符以及中文字符加密错误的问题

#### v1.0.2

- 适配 API9
- 直接引用源库使用，删除本库的绝大部分逻辑，仅将客制化的部分抽出作为 lib

#### v1.0.1

已实现功能：
- sha224
- sha384
- sha3
- hmac-sha224
- hmac-sha384
- hmac-sha3
- pbkdf2
- aes
- tripledes
- rc4
- rabbit
- rabbit-legacy
- evpkdf
- format-openssl
- format-hex
- enc-latin1
- enc-utf8
- enc-hex
- enc-utf16
- enc-base64
- mode-cfb
- mode-ctr
- mode-ctr-gladman
- mode-ofb
- mode-ecb
- pad-pkcs7
- pad-ansix923
- pad-iso10126
- pad-iso97971
- pad-zeropadding
- pad-nopadding

#### v1.0.0

已实现功能：
- md5
- sha1
- sha256
- sha512
- ripemd160
- hmac-md5
- hmac-sha1
- hmac-sha256
- hmac-sha512
- hmac-ripemd160

## 权限与隐私基本信息

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 |

## 安装方式

```bash
ohpm install @ohos/crypto-js
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c2e3ecb9c63d4925aec91eebb0a3d8ab/PLATFORM?origin=template