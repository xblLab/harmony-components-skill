# 手机号注册登录组件

## 简介

一款基于华为认证服务的注册登录组件。
1. 手机号验证码注册。
2. 手机号密码登录。

## 详细介绍

视频播放器 is loading.播放视频播放静音当前时间 0:00/时长 0:16加载完毕：100.00%0:00媒体流类型 直播Seek to live, currently behind live 直播剩余时间 -0:16 1x 播放速度 2x1.75x1.5x1.25x1x, 选择 0.5x 节目段落节目段落描述关闭描述，选择字幕字幕设定，开启字幕设置弹窗关闭字幕，选择音轨画中画全屏 This is a modal window.开始对话视窗。离开会取消及关闭视窗文字 Color 白黑红绿蓝黄紫红青 Transparency 不透明半透明背景 Color 黑白红绿蓝黄紫红青 Transparency 不透明半透明透明视窗 Color 黑白红绿蓝黄紫红青 Transparency 透明半透明不透明字体尺寸 50%75%100%125%150%175%200%300%400% 字体边缘样式无浮雕压低均匀下阴影字体库比例无细体单间隔无细体比例细体单间隔细体舒适手写体小型大写字体重启 恢复全部设定至预设值完成关闭弹窗结束对话视窗

### 功能介绍

基于华为认证服务的手机号验证码注册登录组件。

### 环境要求

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、平板
- **系统版本**：HarmonyOS 5.0.1(13) 及以上

### 使用说明

深色代码主题复制

```typescript
import { LoginPage } from "@caint/login"
import { RegisterPage } from "@caint/login"

@Entry
@Component
struct Index {
  build() {
    Column() {
      Column() {
        LoginPage({ themeColor: "#298CC4" })
      }
      .width('100%')
      .height('100%')
    }
    .height('100%')
    .width('100%')
  }
}
```

### 权限要求

- **网络权限**：ohos.permission.INTERNET

### 技术支持

196067@qq.com

### 开源许可协议

该代码经过 Apache 2.0 授权许可。

### 更新记录

- **1.1.2 (2026-01-28)**
  1. 提供注册和登录功能。
  2. 支持主题颜色参数。
  3. 修复一些问题。

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 权限与隐私 | ohos.permission.INTERNET | 网络权限 | 注册登录 |

### 兼容性

| 项目 | 详情 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 5.0.1 | Created with Pixso. |
| 5.0.2 | Created with Pixso. |
| 5.0.3 | Created with Pixso. |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |
| 5.1.0 | Created with Pixso. |
| 5.1.1 | Created with Pixso. |
| 6.0.0 | Created with Pixso. |
| 6.0.1 | Created with Pixso. |
| 应用类型 | 应用 |
| 元服务 | Created with Pixso. |
| 设备类型 | 手机 |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |
| DevEco Studio 5.0.1 | Created with Pixso. |
| DevEco Studio 5.0.2 | Created with Pixso. |
| DevEco Studio 5.0.3 | Created with Pixso. |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |
| DevEco Studio 6.0.1 | Created with Pixso. |

## 安装方式

```bash
ohpm install @caint/login
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/a0af3ed4beaa443f8d103dd1164399c4/DEVELOPER?origin=template