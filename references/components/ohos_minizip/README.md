# minizip 加密解压组件

## 简介

基于 minizip_ng 的 zip 加密解压库，支持 zip 格式的解密解压。

## 详细介绍

### 介绍

基于 minizip_ng 的解压缩库。

### 下载安装

```bash
ohpm install @ohos/minizip
```

### 编译运行

本项目依赖 minizip_ng 库，编译产物.a 文件和头文件通过 git submodule 引入，下载代码时需加上--recursive 参数。

```bash
git clone --recursive https://gitcode.com/openharmony-tpc/openharmony_tpc_samples.git
```

如果想要在本地编译 minizip_ng，参考 minizip_ng 集成到应用 hap。
在 cpp 目录下新增 third_party 目录，并将编译生成的库拷贝到该目录下，如下图所示：

### 使用说明

#### 解压 zip 包获取文件内容

```typescript
import { MinizipNative } from '@ohos/minizip'

let minizipEntry = new MinizipNative(this.selectFilePath);
if (minizipEntry.Open() == 0) {
  let entryNames = minizipEntry.GetEntryNames();
  for (let i = 0; i < entryNames.length; i++) {
    console.log('Minizip names:' + entryNames[i]);
    if(!entryNames[i].endsWith("/")) {
      let arrBuffer = minizipEntry.ExtractFileToJS(entryNames[i], this.password);
      console.log("Minizip arrBuffer: " + arrBuffer?.byteLength)
    }
  }
}
```

使用三方库解压 zip 文件内容到内存，返回至 JS。
GetEntryNames() 获取 zip 文件所有的文件夹路径以及文件路径。
ExtractFileToJS(entryname, password)，解压指定的文件并将内容返回至 JS 侧，若文件没有密码参考如下：

```typescript
ExtractFileToJS(entryname, "");
```

#### 解压 zip 包到磁盘

```typescript
import { unzipToDirectory } from '@ohos/minizip'

unzipToDirectory(this.selectFilePath, this.targetPath, this.password).then(() => {
  
}).catch(() => {
 
});
```

#### 将文件压缩成 zip 包并获取文件内容

```typescript
import { MinizipCompressNative } from '@ohos/minizip'

let minizipCompressEntry = new MinizipCompressNative(this.selectFilePath);
if (minizipCompressEntry.Create() == 0) {
  let arrBuffer = minizipCompressEntry.CompressToJS(this.targetPath, this.password);
  console.log("Minizip arrBuffer: " + arrBuffer?.byteLength)
}
```

使用三方库压缩文件内容到 zip 包中，并返回至 JS。
CompressToJS(entryname, password)，压缩指定的文件并将内容返回至 JS 侧，若文件没有密码参考如下：

```typescript
CompressToJS(entryname, "");
```

#### 压缩 zip 包到磁盘

```typescript
import { MinizipCompressNative } from '@ohos/minizip'

let minizipCompressEntry = new MinizipCompressNative(this.selectFilePath，this.selectFilePath);
if (minizipCompressEntry.Create() == 0) {
  let code : number = minizipCompressEntry.Compress(this.targetPath, this.password);
  console.log("" + code);
  minizipCompressEntry.Close();
}
```

## 接口说明

### MinizipNative

| 接口参数 | 参数说明 | 返回值 | 接口说明 |
| :--- | :--- | :--- | :--- |
| MinizipNative | path:string<br>zip 压缩包路径 | MinizipNative 实例 | 创建 MinizipNative 实例 |
| Open | 无 | 无 | 当返回值为 0 时，打开文件成功<br>打开文件 |
| SetCharEncoding | charEncoding:number<br>字符编码类型，可设置为 437(CP437 主要用于英文和一些西欧语言环境)<br>932(CP932 主要用于日语环境)<br>936(CP936 主要用于简体中文环境)<br>950(CP950 主要用于繁体中文环境)<br>65001(UTF8) | 无返回值 | 设置压缩包的字符编码类型<br>设置字符编码类型 |
| GetEntryNames | 无 | Array< string > | 获取文件列表，如果调用过 SetCharEncoding 设置字符编码，则返回的文件名字符串为 utf8 编码<br>获取文件列表 |
| ExtractFileToJS | entryName : string, password : string<br>entryName：文件名，password：密码 | ArrayBuffer 或者 undefined | 解压文件内容，密码错误或 entryName 为文件夹名时，返回 undefined<br>解压文件内容 |
| unzipToDirectory | selectPath: string, targetPath: string, password?: string, charEncoding?: number<br>selectPath: 待解压文件路径，targetPath: 解压到此路径下，password?: 密码，charEncoding?: 字符编码类型 | Promise< string > | 是否解压成功<br>解压缩文件到文件夹 |
| IsEncrypto | entryName : string<br>entryName: entry 文件名 | boolean | 是否加密<br>判断 entry 是否加密 |
| IsUtf8 | entryName : string<br>entryName: entry 文件名 | boolean | 文件路径是否 utf8 编码<br>判断 entry 路径名是否 utf8 编码 |

### MinizipCompressNative

| 接口参数 | 参数说明 | 返回值 | 接口说明 |
| :--- | :--- | :--- | :--- |
| MinizipCompressNative | catchPath:string, zipFilePath:string<br>catchPath 获取压缩包内容时压缩包暂存路径，zipFilePath 压缩包路径 | MinizipCompressNative 实例 | 创建 MinizipCompressNative 实例 |
| Create | 无 | 无 | 当返回值为 0 时，创建文件成功<br>创建 zip 文件 |
| Close | 无 | 无返回值 | 关闭 zip 文件 |
| SetCompressMethod | compressMethod:number<br>压缩方法，可设置为 0(不压缩)<br>8(Deflate 压缩)<br>12(Bzip2 压缩)<br>14(LZMA1 压缩)<br>93(ZSTD 压缩)<br>95(XZ 压缩) | 无返回值 | 当返回值为 0 时，设置成功<br>设置压缩方法 |
| SetCompressLevel | compressLevel:number<br>压缩等级，可设置为 -1(默认等级)<br>2(Fast 压缩等级)<br>6(Mid 压缩等级)<br>9(Slow 压缩等级) | 无返回值 | 当返回值为 0 时，设置成功<br>设置压缩等级 |
| SetzipFilePath | zipFilePath:string<br>zipFilePath：压缩包名 | 无返回值 | 重新设置压缩包名<br>设置压缩包名 |
| Compress | entries : Array, password : string<br>entries : 需要压缩的文件，password : 密码 | 无返回值 | 当返回值为 0 时，压缩成功<br>压缩文件 |
| CompressToJS | entries : Array, password : string<br>entries：需要压缩的文件，password：密码 | ArrayBuffer 或者 undefined | 压缩文件内容，密码错误或压缩失败时，返回 undefined<br>压缩文件并获取文件内容 |

## 注意事项

1. 创建 minizipNative 对象需要传入完整的文件路径：文件路径 + 文件名。
2. 创建对象之后一定要调用 Open 函数，并且每一次 new minizipNative 只能调用一次 Open，若 Open 函数返回值非 0 则是打开文件失败。

## 关于混淆

代码混淆，请查看代码混淆简介。
如果希望 minizip 库在代码混淆过程中不会被混淆，需要在混淆规则配置文件 obfuscation-rules.txt 中添加相应的排除规则：

```bash
-keep
./oh_modules/@ohos/minizip
```

## 约束与限制

在下述版本验证通过：
- DevEco Studio: NEXT Beta1-5.0.3.806, SDK: API12 Release (5.0.0.66)。
- DevEco Studio: NEXT Developer Beta1-5.0.3.320, SDK: API12(5.0.0.23)。

## 目录结构

```text
|----ohos_minizip  
|     |---- entry  # 示例代码文件夹
|     |---- library  
|                |---- cpp # c/c++和 napi 代码
|                      |---- minizipAdapter # minizip 的 napi 逻辑代码
|                      |---- CMakeLists.txt  # 构建脚本
|                      |---- thirdparty # 三方依赖
|                      |---- types # 接口声明
|           |---- index.ets  # 对外接口
|     |---- README.md  # 安装使用方法
|     |---- README_zh.md  # 安装使用方法   
```

## 贡献代码

使用过程中发现任何问题都可以提 Issue 给我们，当然，我们也非常欢迎你给我们发 PR。

## 开源协议

本项目基于 Apache License 2.0 ，请自由地享受和参与开源。

## 更新记录

### 1.0.4

Release official version 1.0.4

### 1.0.4-rc.0

Fixed the issue where decompressing a Zip file with empty content would cause the execution flow to enter the catch block.

### 1.0.3

The shared library is compiled with -O3 optimization and supports LTO
Fix CVE-2019-12900, CVE-2016-3189

### 1.0.3-rc.0

MinizipNative add IsEncrypto() & IsUtf8() functions.

### 1.0.2

Fixed the issue where the unzipToDirectory interface did not return an error when the password error failed

### 1.0.2-rc.2

Added the encryption compression interface and the compression to "arrarybuffer" interface

### 1.0.2-rc.1

Fixed an issue in unzipToDirectory where fs.write was returned without execution

### 1.0.2-rc.0

Fix the issue of failed file creation for unzippToDirectory interface decompression

### 1.0.1

Update the version to 1.0.1.

### 1.0.1-rc.2

Upgrade the dependent aki version to 1.2.13

### 1.0.1-rc.1

unzipToDirectory supports user-defined character encoding.

### 1.0.1-rc.0

Fix the issue of Chinese character garbling.
Add new interfaces SetCharEncoding(charEncoding : number)


Fix the issue of failing to create multi-level directories.
Fix the issue of unzipToDirectory interface failing to decompress 0KB files.

### 1.0.0

Support decryption and decompression of zip packages, including support for the GetEntryNames (get the list of files in the archive) and ExtractFileToJS (decompress file content) interfaces.

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 | 暂无 |
| 隐私政策 | 不涉及 | SDK 合规使用指南 | 不涉及 |
| 兼容性 | HarmonyOS 版本 | 5.0.0 | |

Created with Pixso.

## 应用类型

应用

Created with Pixso.

## 元服务

Created with Pixso.

## 设备类型

手机

Created with Pixso.

平板

Created with Pixso.

PC 

Created with Pixso.

## DevEcoStudio 版本

DevEco Studio 5.0.3

Created with Pixso.

## 安装方式

```bash
ohpm install @ohos/minizip
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/569848195e2148c0bd7968fc429c2a20/PLATFORM?origin=template