# dove/md4 加密组件

## 简介

md4，是一个 OpenHarmony/HarmonyOS MD4 加密工具库，支持使用 API10 以上。基于 js-md4 开发，具体使用步骤参考 js-md4。

## 详细介绍

### 简介

md4，是一个 OpenHarmony/HarmonyOS MD4 加密工具库，支持使用 API10 以上。基于 js-md4 开发，具体使用步骤参考 js-md4。

### 下载安装

```bash
ohpm install @dove/md4
```

### 接口和属性列表

| 接口 | 参数 | 返回值 |
| :--- | :--- | :--- |
| `update()` | `message`: 字符串或字节流 | - |
| `hex()` | - | 16 进制字符串 |
| `digest()` | - | 字节流 |
| `arrayBuffer()` | - | 字节流 |

### 使用示例

```typescript
import md4 from "@dove/md4";

const hash = new md4();
hash.update("Message to hash");
this.message = hash.hex();
```

### 许可证协议

Mulan PSL 2.0

### 更新记录

- **[v1.0.0]** 2025.01.08
  - 发布第一个版本
- **[v1.0.1]** 2025.01.14
  - 语法修改

### 权限与隐私

| 项目 | 详情 |
| :--- | :--- |
| **基本信息** | 权限名称：暂无<br>权限说明：暂无<br>使用目的：暂无 |
| **隐私政策** | 不涉及 |
| **SDK 合规使用指南** | 不涉及 |

### 兼容性

| 项目 | 详情 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0 |
| **应用类型** | 应用 |
| **元服务** | 支持 |
| **设备类型** | 手机、平板、PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @dove/md4
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/b6f977e9577e470dbd89ad9996231801/PLATFORM?origin=template