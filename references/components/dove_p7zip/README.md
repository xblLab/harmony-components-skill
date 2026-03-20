# p7zip 解压缩组件

## 简介

是一个 OpenHarmony/HarmonyOS 7zip 解压缩库，基于 ohos-rs 开发，支持使用 API13 以上。

## 详细介绍

### 简介

p7zip 是一个 OpenHarmony/HarmonyOS 7zip 解压缩库，基于 ohos-rs 开发，支持使用 API13 以上。

### 下载安装

```bash
ohpm install @dove/p7zip
```

### 接口和使用

```typescript
/// 将文件/文件夹压缩到指定路径下
export declare function compressToPath(src: string, dest: string): Promise<boolean>;

/// 将文件/文件夹压缩到指定路径下并设置密码
export declare function compressToPathEncrypted(src: string, dest: string, passwd: string): Promise<boolean>;

/// 将文件/文件夹压缩到指定路径下并指定压缩等级
export declare function compressWithPreset(srcPath: string, createPath: string, passwd: string, preset: number): Promise<boolean>;

/// 将压缩包文件解压到指定路径下
export declare function decompressFile(srcPath: string, dest: string): Promise<boolean>

/// 将有密码的压缩包文件解压到指定路径下
export declare function decompressFileWithPassword(srcPath: string, dest: string, passwd: string): Promise<boolean>
```

### 更新记录

- **[v0.13.0]** 2025.06.09 - 发布第一个版本
- **[v0.18.0]** 2025.08.27 - 支持更多的算法
- **[v0.19.2]** 2025.10.28 - 更新版本
- **[v0.19.4]** 2025.12.02 - 更新版本

### 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

### 兼容性

| 项目 | 详情 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.1 |
| 应用类型 | 应用 |
| 元服务 | 支持 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.1 |

## 安装方式

```bash
ohpm install @dove/p7zip
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/574956cb2f614a7a87542e35e0574397/PLATFORM?origin=template