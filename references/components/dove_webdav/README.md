# webdav 组件

## 简介

webdav，是一个 OpenHarmony/HarmonyOS webdav 库，基于 ohos-rs 开发，支持使用 API13 以上。

## 详细介绍

### 简介

webdav，是一个 OpenHarmony/HarmonyOS webdav 库，基于 ohos-rs 开发，支持使用 API13 以上。

### 下载安装

```bash
ohpm install @dove/webdav
```

### 接口和使用

```typescript
// 获取路径下所有文件和文件夹信息
list(remotePath: string): Promise<Array<FileInfo>>

// 获取文件流
get(remotePath: string): Promise<ArrayBuffer | null>

// 获取文件并写入到指定路径下
writeTo(remotePath: string, filePath: string): Promise<boolean>

// 上传文件到远程路径
put(remotePath: string, filePath: string): Promise<boolean>

// 删除远端文件
delete(remotePath: string): Promise<boolean>

// 移动远端文件
mv(sourcePath: string, targetPath: string): Promise<boolean>

// 复制远端文件
cp(sourcePath: string, targetPath: string): Promise<boolean>

// 创建文件夹
mkdir(remotePath: string): Promise<boolean>

// 释放连接
close(): void
```

### 更新记录

- **[v0.2.1]** 2025.06.09 - 发布第一个版本
- **[v0.2.2]** 2025.07.18 - 修复问题
- **[v0.2.3]** 2025.08.08 - 修复路径存在空格导致获取失败问题
- **[v0.2.5]** 2025.12.02 - 更新版本

### 兼容性

| 项目 | 详情 |
| :--- | :--- |
| **权限与隐私** | |
| 基本信息 | 暂无 |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| **系统要求** | |
| HarmonyOS 版本 | 5.0.1 |
| **应用类型** | 应用 / 元服务 |
| **设备类型** | 手机 / 平板 / PC |
| **IDE 版本** | DevEco Studio 5.0.1 |

## 安装方式

```bash
ohpm install @dove/webdav
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/54e4e413e96144c39a006a9babc75838/PLATFORM?origin=template