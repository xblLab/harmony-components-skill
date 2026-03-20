# ya520/webdav 协议通信与远程文件管理组件

## 简介

一个基础的 WebDAV 客户端工具

## 详细介绍

### 简介

一个为 HarmonyOS 设计的基础、易用的 WebDAV 客户端库，支持文件上传、下载、目录浏览等完整的 WebDAV 操作。

### 特性

- 完整的目录和文件操作（创建、删除、移动、复制）
- 文件上传和下载
- 目录内容浏览
- 连通性测试
- 兼容多种 WebDAV 服务器（测试兼容坚果云、TeraCloud）
- 强大的错误处理和重试机制

### 安装

深色代码主题复制
```bash
ohpm install @ya520/webdav
```

### 需要权限

深色代码主题复制
```text
ohos.permission.INTERNET
```

### 快速开始

#### 属性列表

| 属性 | 类型 | 默认值 | 描述 |
| :--- | :--- | :--- | :--- |
| baseUrl | string | - | WebDAV 服务器的基础 URL |
| username | string | - | 认证用户名 |
| password | string | - | 认证密码 |
| authType | 'basic' | 'basic' | 认证类型，目前支持基本认证 |

#### 接口列表

**WebDavManager**
高级管理器类，提供更便捷的文件操作接口。

| 接口 | 参数 | 功能 | 描述 |
| :--- | :--- | :--- | :--- |
| manager.linkTest() | 无 | 执行连通性测试并返回结果 | - |
| manager.listDirectory(path, depth, headers) | path: 目录路径<br>depth: 深度<br>headers: 请求头 | 列出目录内容 | - |
| manager.createDirectory(path, headers) | path: 目录路径<br>headers: 请求头 | 创建目录 | - |
| manager.delete(path, headers) | path: 删除路径<br>headers: 请求头 | 删除文件或目录 | - |
| manager.upload(path, fileName) | path: 上传路径<br>fileName: 本地文件名 | 上传文件 | - |
| manager.downloadFile(remotePath, fileName, downType) | remotePath: 远程路径<br>fileName: 本地文件名<br>downType: 下载类型 | 下载文件 | - |
| manager.getTextFileContent(path, headers) | path: 文件路径<br>headers: 请求头 | 获取文本文件内容 | - |

**WebDavClient**
核心 WebDAV 客户端类，提供底层 WebDAV 操作。

| 接口 | 参数 | 功能 | 描述 |
| :--- | :--- | :--- | :--- |
| client.testConnection() | 无 | 测试与 WebDAV 服务器的连通性 | - |
| client.propfind(path, depth, props, headers) | path: 请求路径<br>depth: 深度<br>props: 属性列表<br>headers: 请求头 | 获取资源属性（PROPFIND） | - |
| client.mkcol(path, headers) | path: 创建路径<br>headers: 请求头 | 创建文件夹（MKCOL） | - |
| client.delete(path, headers) | path: 删除路径<br>headers: 请求头 | 删除资源（DELETE） | - |
| client.get(path, headers) | path: 下载路径<br>headers: 请求头 | 下载文件（GET） | - |
| client.put(path, data, headers) | path: 上传路径<br>data: 文件数据<br>headers: 请求头 | 上传文件（PUT） | - |
| client.move(sourcePath, destinationPath, overwrite, headers) | sourcePath: 源路径<br>destinationPath: 目标路径<br>overwrite: 是否覆盖<br>headers: 请求头 | 移动资源（MOVE） | - |

### 基本配置

#### 导入依赖

深色代码主题复制
```typescript
import { WebDavManager } from '@ya/webdav';
```

#### 配置

深色代码主题复制
```typescript
const config: WebDavConfig = {
    baseUrl: 'https://dav.xxx.com/dav/',
    username: 'your-username',
    password: 'your-password',
    authType: 'basic'
};
```

### 使用示例

#### 创建管理器实例

深色代码主题复制
```typescript
// 创建管理器实例
private webdavManager = new WebDavManager(new WebDavClient(config), this.getUIContext().getHostContext()!);
```

#### 测试连接

深色代码主题复制
```typescript
// 测试连接
try {
    const result = await this.webdavManager.linkTest()
    if (result.success) {
        // 连接成功
        console.info(result.message); // "连接成功：WebDAV 服务器有效"
    } else {
        // 连接失败
        console.error(result.message); // "认证失败：请检查用户名和密码是否正确"
    }
} catch (err) {
    console.error(`创建失败 name: ${err.name} message: ${err.message}`)
}
```

#### 列出目录内容

深色代码主题复制
```typescript
// 列出目录内容
try {
    const files = await this.webdavManager.listDirectory('/XXX')
    console.log(`XXX 根目录下共存有 ${files.length} 个项目`);
    for (const file of files) {
        console.log(`- [${file.isDirectory ? 'DIR' : 'FILE'}]${file.name} (大小：${file.size} 字节)`);
    }
} catch (err) {
    console.error(`获取文件夹失败 name: ${err.name} message: ${err.message}`)
}
```

#### 上传文件

深色代码主题复制
```typescript
// 上传文件
try {
    const value = await this.webdavManager.upload('/XXX/')
    console.log(`状态（${value.statusCode}）: ${value.statusCode == 201 ? '上传成功' : '上传失败'}`)
} catch (err) {
    console.error(`上传失败 name: ${err.name} message: ${err.message}`)
}
```

#### 下载文件

深色代码主题复制
```typescript
// 下载文件
try {
    const value = await this.webdavManager.downloadFile('/XXX/test.zip')
    console.log(`test.zip 下载状态（${value}）: ${value ? '下载成功' : '下载失败'}`)
} catch (err) {
    console.error(`下载失败 name: ${err.name} message: ${err.message}`)
}
```

#### 创建目录

深色代码主题复制
```typescript
// 创建目录
try {
    const value = await this.webdavManager.createDirectory('/XXX')
    console.log(`创建状态：${value.statusCode}`)
} catch (err) {
    console.error(`创建失败 name: ${err.name} message: ${err.message}`)
}
```

#### 删除文件或目录

深色代码主题复制
```typescript
// 删除文件或目录
try {
    const value = await this.webdavManager.delete('/XXX/test.zip')
    console.log(`状态（${value.statusCode}）: ${value.statusCode == 204 ? '删除成功' : '删除失败'}`)
} catch (err) {
    console.error(`删除失败 name: ${err.name} message: ${err.message}`)
}
```

## 兼容性

本库已测试兼容以下 WebDAV 服务：

- 坚果云
- TeraCloud
- 更多平台兼容性待测试

## 错误处理

所有方法都包含完整的错误处理，会抛出包含详细错误信息的异常：

## 高级用法

### 自定义请求头

深色代码主题复制
```typescript
const headers = {
    'User-Agent': 'MyApp/1.0',
    'X-Custom-Header': 'value'
};

await webdavManager.listDirectory('/path/', '1', headers);
```

## 故障排除

### 常见问题

**连接超时**
- 检查网络连接
- 确认服务器地址和端口正确

**认证失败**
- 验证用户名和密码
- 确认服务器支持基本认证

## 约束与限制

在下述版本验证通过：
DevEco Studio: 6.0.0 Release(6.0.0.858), SDK: 6.0.0.47 (API 20 Release)

## 许可证

Apache License 2.0

## 更新记录

### [1.0.0] - 2025-10-21

**新增**
- 首次发布 HarmonyOS WebDAV 客户端库
- 持基本认证（Basic Auth）
- 完整的 WebDAV 协议实现（PROPFIND, GET, PUT, DELETE, MKCOL, COPY, MOVE）
- 件上传和下载功能
- 目录浏览和创建功能
- 连通性测试功能
- 完整的 TypeScript 类型定义
- 智能的 XML 解析，兼容不同服务器的命名空间
- 健壮的错误处理机制
- 从路径提取文件名的备用方案
- 路径规范化处理，兼容有无斜情况杠的

### [1.0.1] - 2025-10-22

**新增**
- 取消代码混淆

**下兼容**
- 兼容性
- 测试兼容坚果云 WebDAV 服务
- 测试兼容 TeraCloud WebDAV 服务
- 兼容 HarmonyOS 5.0+

**技术细节**
- 使用 @kit.RemoteCommunicationKit 进行网络请求
- 使用 @kit.ArkTS 进行 XML 解析
- 使用 @kit.CoreFileKit 进行文件操作
- 完全异步的 API 设计

**文档**
- 完整的 API 文档
- 详细的使用示例
- 错误处理指南

## 兼容性信息

基本信息
权限名称 权限说明 使用目的 暂无 暂无 暂无
隐私政策 不涉及
SDK 合规使用指南 不涉及
兼容性 HarmonyOS 版本 5.0.0

Created with Pixso.

应用类型 应用

Created with Pixso.

元服务

Created with Pixso.

设备类型 手机

Created with Pixso.

平板

Created with Pixso.

PC

Created with Pixso.

DevEcoStudio 版本 DevEco Studio 5.0.0

Created with Pixso.

## 安装方式

```bash
ohpm install @ya520/webdav
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/a27e8bbfa1ee422f849ce34dc8fe72b2/PLATFORM?origin=template