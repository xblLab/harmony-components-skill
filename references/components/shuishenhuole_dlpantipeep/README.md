# dlpantipeep 防窥组件

## 简介

借助 HarmonyOS6.0 的防窥保护组件，开发工作真正实现了化繁为简。其高度封装的 API 使复杂的 AI 防窥逻辑变得清晰易懂，让开发者能轻松驾驭这面智能盾牌。

## 详细介绍

视频播放器 is loading.播放视频播放静音当前时间 0:00/时长 0:10 加载完毕：100.00%0:00 媒体流类型 直播 Seek to live, currently behind live 直播剩余时间 -0:10 1x 播放速度 2x1.75x1.5x1.25x1x, 选择 0.5x 节目段落节目段落描述关闭描述，选择字幕字幕设定，开启字幕设置弹窗关闭字幕，选择音轨画中画全屏 This is a modal window.开始对话视窗。离开会取消及关闭视窗文字 Color 白黑红绿蓝黄紫红青 Transparency 不透明半透明背景 Color 黑白红绿蓝黄紫红青 Transparency 不透明半透明透明视窗 Color 黑白红绿蓝黄紫红青 Transparency 透明半透明不透明字体尺寸 50%75%100%125%150%175%200%300%400% 字体边缘样式无浮雕压低均匀下阴影字体库比例无细体单间隔无细体比例细体单间隔细体舒适手写体小型大写字体重启 恢复全部设定至预设值完成关闭弹窗结束对话视窗

## DlpAntPeep 组件

借助 HarmonyOS6.0 的防窥保护组件，开发工作真正实现了化繁为简。其高度封装的 API 使复杂的 AI 防窥逻辑变得清晰易懂，让开发者能轻松驾驭这面智能盾牌。

### 前置要求

需要在 module.json5 申请权限

深色代码主题复制
```json5
"requestPermissions": [
      {"name": "ohos.permission.DLP_GET_HIDE_STATUS"}
    ],
```

需要在设备开启人脸识别。
在设备上选择“设置 > 隐私与安全 > 防窥保护”，开启防窥保护开关。通过人脸验证后，打开需要加入保护的应用开关。

## 如何安装

深色代码主题复制
```bash
ohpm install @shuishenhuole/dlpantipeep
```

## 组件介绍

### DlpAntiPeepComponent 组件

| 参数名 | 类型 | 是否必填 | 描述 |
| :--- | :--- | :--- | :--- |
| maskType | MasKType | 否 | 窥屏保护页面的表现 |
| CustomDialogBuilder | CustomBuilder | 否 | 监听之后的回调 |

#### MasKType 枚举说明

| 名称 | 值 | 说明 |
| :--- | :--- | :--- |
| SystemMask | 0 | 默认打开系统浮层 |
| CustomDialog | 1 | 自定义 Builder 函数设置窥屏保护的弹出框 |

## 使用案例

### 使用案例 使用系统浮层

深色代码主题复制
```typescript
@Entry
@Component
struct Index {
  build() {
    Flex({
      justifyContent:FlexAlign.Center,
      alignItems:ItemAlign.Center
    }){
      DlpAntiPeepComponent()
     Column(){
       Text("DlpAntiPeepComponent 组件")
         .margin(10)
         .fontWeight(FontWeight.Bold)
         .fontSize(25)
       Text("power by shuishenhuole")
         .fontWeight(FontWeight.Bold)
         .fontSize(20)
     }
    }
    .height('100%')
    .width('100%')
  }
}
```

### 使用案例 自定义弹出框 加入 builder 函数 写法一

深色代码主题复制
```typescript
@Builder
function DialogBuilder(){
  Flex({
    justifyContent:FlexAlign.Center,
    alignItems:ItemAlign.Center
  }){
    Text("小伙子，窥屏是不对的哦！")
      .fontSize(25)
      .fontWeight(FontWeight.Bolder)
  }
  .height('100%')
  .width("100%")
  .backgroundColor(Color.Orange)
}

@Entry
@Component
struct Index {
  build() {
    Flex({
      justifyContent:FlexAlign.Center,
      alignItems:ItemAlign.Center
    }){
      Column(){
        //进阶用法 可以自定义弹窗的 builder 函数 写法 1
        DlpAntiPeepComponent({
          maskType:MasKType.CustomDialog,
          CustomDialogBuilder:DialogBuilder
        })
        Text("DlpAntiPeepComponent 组件")
          .margin(10)
          .fontWeight(FontWeight.Bold)
          .fontSize(25)
        Text("power by shuishenhuole")
          .fontWeight(FontWeight.Bold)
          .fontSize(20)
      }
    }
    .height('100%')
    .width('100%')
  }
}
```

### 使用案例 自定义弹出框 加入 builder 函数 写法二 (推荐)

深色代码主题复制
```typescript
@Entry
@Component
struct Index {
  build() {
    Flex({
      justifyContent:FlexAlign.Center,
      alignItems:ItemAlign.Center
    }){
      Column(){
        //进阶用法 可以自定义弹窗的 builder 函数 写法 2(推荐)
        DlpAntiPeepComponent({
          maskType:MasKType.CustomDialog
        }){
          Flex({
            justifyContent:FlexAlign.Center,
            alignItems:ItemAlign.Center
          }){
            Text("小伙子，窥屏是不对的哦！")
              .fontSize(25)
              .fontWeight(FontWeight.Bolder)
          }
          .height('100%')
          .width("100%")
          .backgroundColor(Color.Orange)
        }
        Text("DlpAntiPeepComponent 组件")
          .margin(10)
          .fontWeight(FontWeight.Bold)
          .fontSize(25)
        Text("power by shuishenhuole")
          .fontWeight(FontWeight.Bold)
          .fontSize(20)
      }
    }
    .height('100%')
    .width('100%')
  }
}
```

## 更新记录

- **1.0.2 (2025-12-30)** 降低了 sdk 保证不同版本的用户可以使用 在高版本可以使用防窥保护 在不支持的手机中出现 error 日志
- **1.0.1 (2025-12-16)** 借助 HarmonyOS6.0 的防窥保护组件，开发工作真正实现了化繁为简。其高度封装的 API 使复杂的 AI 防窥逻辑变得清晰易懂，让开发者能轻松驾驭这面智能盾牌。

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

| 项目 | 详情 |
| :--- | :--- |
| HarmonyOS 版本 | 6.0.0 Created with Pixso. |
| | 6.0.1 Created with Pixso. |
| 应用类型 | 应用 Created with Pixso. |
| | 元服务 Created with Pixso. |
| 设备类型 | 手机 Created with Pixso. |
| | 平板 Created with Pixso. |
| | PC Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.0 Created with Pixso. |
| | DevEco Studio 6.0.1 Created with Pixso. |

## 安装方式

```bash
ohpm install @shuishenhuole/dlpantipeep
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/fc5ffdf461c8481e84f79c8d9428d70b/9f7ea0a461e248d0935ca724ffcaa005?origin=template