# NetworkManager 网络管理组件

## 简介

此 Demo 展示如何查询网络详情、域名解析、网络状态监听等功能。

## 详细介绍

### 实现网络管理的功能

#### 介绍

本示例通过 `@ohos.net.connection` 接口实现网络的详情、域名解析、网络监听等功能，注意需要申请 `ohos.permission.GET_NETWORK_INFO` 和 `ohos.permission.INTERNET` 权限。帮助开发者掌握如何处理检查网络、监听网络等的网络相关场景。

### 效果预览

### 使用说明

1. 启动应用，在点击检查网络、网络详情、网络连接信息后，展示对应的信息；
2. 在域名解析的模块下，输入对应的域名后，点击域名解析，展示解析的域名 ip 地址；
3. 在网络监听模块下，开启网络监听后，展示当前监听的网络信息；关闭网络监听后，停止监听网络信息。

### 工程目录

```text
深色代码主题复制
├──entry/src/main/ets/
│  ├──common 
│  │  └──Constant.ets
│  ├──entryability
│  │  └──EntryAbility.ets                      
│  ├──pages
│  │  └──Index.ets
└──entry/src/main/resources
```

### 具体实现

使用 `@ohos.net.connection`（网络连接管理）接口实现网络的详情、域名解析、网络监听等功能。代码：`Index.ets`

### 相关权限

允许应用获取数据网络信息：`ohos.permission.GET_NETWORK_INFO`
允许使用 Internet 网络：`ohos.permission.INTERNET`

### 依赖

不涉及。

### 约束与限制

本示例仅支持标准系统上运行，支持设备：华为手机。

HarmonyOS 系统：HarmonyOS 6.0.0 Beta5 及以上。

DevEco Studio 版本：DevEco Studio 6.0.0 Beta5 及以上。

HarmonyOS SDK 版本：HarmonyOS 6.0.0 Beta5 SDK 及以上。

### 更新记录

1.0.0 (2025-11-07)

### 权限与隐私

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

#### 隐私政策

不涉及

#### SDK 合规使用指南

不涉及

### 兼容性

HarmonyOS 版本：6.0.0

### 项目属性

| 属性 | 值 |
| :--- | :--- |
| 应用类型 | 应用 Created with Pixso. |
| 元服务 | Created with Pixso. |
| 设备类型 | 手机 Created with Pixso. |
| 设备类型 | 平板 Created with Pixso. |
| 设备类型 | PC Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.0 Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/e08136ff76a94e66977ceac1534a1c40/PLATFORM?origin=template