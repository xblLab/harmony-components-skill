# Archive 文件解压缩组件

## 简介

本组件是基于 libarchive 开发完成，支持常见的 7z, tar, zip, gz, xz 格式解压缩。

## 详细介绍

### 简介

本组件是基于 libarchive 开发完成，支持常见的 7z, tar, zip, gz, xz 格式解压缩。

### 安装

```bash
ohpm i @mysoft/archive
```

### 效果

（此处保留原文档占位）

### API

#### archiveLib.compress

`compress(inFile: string, outFile: string, format: archiveLib.CompressFormat): Promise<archiveLib.Result>`

压缩文件，压缩的结果使用 Promise 异步返回。成功时返回 `{code: 0, message: 'Success'}`，失败时返回错误码和具体的错误内容。

**参数：**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| inFile | string | 是 | 是指定压缩的文件夹路径或者文件路径，路径必须为沙箱路径，沙箱路径可以通过 context 获取。<br>• `inFile：/a/b/c`；执行结果：压缩文件夹 c<br>• `inFile：/a/b/c/`；执行结果：压缩文件夹 c 下的所有文件和文件夹<br>• `inFile：/a/b/c/test.txt`；执行结果：压缩文件 test.txt |
| outFile | string | 是 | 是指定的压缩结果的文件路径。如果 outFile 已存在，则直接覆盖。多个线程同时压缩文件时，outFile 不能相同。 |
| format | archiveLib.CompressFormat | 是 | 是压缩格式，支持 7z, tar, zip, gz, xz |

**返回值：**

| 类型 | 说明 |
| :--- | :--- |
| Promise<archiveLib.Result> | Promise 对象，返回 archiveLib.Result<br>• `code`：错误码<br>• `message`：错误详情 |

**示例：**

```typescript
import { archiveLib } from '@mysoft/archive'

const ret = await archiveLib.compress(inFile, outFile, format)
if (ret.code === 0) {
  console.log('压缩成功')
} else {
  console.log(`压缩失败，code: ${ret.code}, message: ${ret.message}`)
}
```

#### archiveLib.decompress

`decompress(inFile: string, outFile: string): Promise<archiveLib.Result>`

解压文件，解压的结果使用 Promise 异步返回。成功时返回 `{code: 0, message: 'Success'}`，失败时返回错误码和具体的错误内容。

**参数：**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| inFile | string | 是 | 是指定的待解压缩文件的文件路径。文件路径必须为沙箱路径，沙箱路径可以通过 context 获取。 |
| outFile | string | 是 | 是指定的解压后的文件夹路径，文件夹目录路径需要在系统中存在，不存在则会解压失败。路径必须为沙箱路径，沙箱路径可以通过 context 获取。如果待解压的文件或文件夹在解压后的路径下已经存在，则会直接覆盖同名文件或同名文件夹中的同名文件。多个线程同时解压文件时，outFile 不能相同。 |

**返回值：**

| 类型 | 说明 |
| :--- | :--- |
| Promise<archiveLib.Result> | Promise 对象，返回 archiveLib.Result<br>• `code`：错误码<br>• `message`：错误详情 |

**示例：**

```typescript
import { archiveLib } from '@mysoft/archive'

// 方式一：使用 options 对象（推荐）
const ret = await archiveLib.decompress({
  inFile: '/path/to/archive.zip',
  outFile: '/path/to/output',
  onProgress: (current, total) => {
    console.log(`解压进度：${current}/${total} 字节`)
  }
})

// 方式二：使用多参数（兼容旧版本）
const ret2 = await archiveLib.decompress(inFile, outFile, (current, total) => {
  console.log(`解压进度：${current}/${total} 字节`)
})

if (ret.code === 0) {
  console.log('解压成功')
} else {
  console.log(`解压失败，code: ${ret.code}, message: ${ret.message}`)
}
```

## 开源协议

本项目基于 Apache License 2.0，在拷贝和借鉴代码时，请务必注明出处。

## 更新记录

### 1.0.4

- 新增压缩/解压进度回调，支持实时获取处理进度
- 修复 HarmonyOS zlib 压缩的 zip 文件中文文件名乱码问题
- 新增 interface 入参方式（CompressOptions/DecompressOptions），同时兼容旧版多参数调用
- C++ 层改为真正的异步操作，不再阻塞 UI 线程

### 1.0.3

- 修复部分中文编码路径导致解压缩失败问题
- 解压缩异常时返回具体的报错内容

### 1.0.2

- 新增 keywords

### 1.0.1

- 更新 README

### 1.0.0

- 发布 1.0.0 初版

## 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| **基本信息** | |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| **隐私政策** | |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| **兼容性** | |
| HarmonyOS 版本 | 5.0.1 |
| **应用类型** | |
| 应用 | 应用 |
| 元服务 | 元服务 |
| **设备类型** | |
| 设备 | 手机、平板、PC |
| **开发环境** | |
| DevEcoStudio 版本 | DevEco Studio 5.0.1 |

## 安装方式

```bash
ohpm install @mysoft/archive
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/9cde763f98954ff7889798b063c3fee1/PLATFORM?origin=template