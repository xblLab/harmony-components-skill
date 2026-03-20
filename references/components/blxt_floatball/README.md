# blxt/floatball 悬浮球组件

## 简介

一个 HarmonyOS 悬浮球

## 详细介绍

### 简介

HarmonyOS 实现的悬浮球，简单好用，像使用一个 ImageView 一样去使用他。

### 下载与安装

```bash
ohpm i @blxt/floatball
```

### 属性详解

| 参数 | 是否必填 | 介绍 | 默认值 |
| :--- | :---: | :--- | :--- |
| image: Resource \| string | √ | 图片资源或者网络 url | -- |
| radius: number | × | 悬浮按钮半径 | 25 |
| opacityHide: number | × | 半隐藏后的透明度 | 1.0 |
| opacityDefault: number | × | 默认透明度 | 1.0 |
| marginSart: number | × | 从隐藏恢复到显示状态的默认边距 | 25 |
| aotoHide: boolean | × | 开启自动隐藏 | true |
| aotoHideTime: number | × | 自动隐藏的超时时间 | 3000 |
| aotoEdging: boolean | × | 自动贴边 | true |
| enableOutEdging: boolean | × | 拖拽时允许超过边界 | true |
| enableDragWhenHidden: boolean | × | 允许隐藏时直接拖动，如果 false，则需要先点击一下，从隐藏状态显示后，才能继续拖动 | true |
| aotoEdgingTime: number | × | 自动贴边的超时时间 | 3000 |
| onClickEvent?: () => boolean; | × | 点击事件传递，如果返回 false，则阻止后续事件 | -- |
| onEdgingEvent?: () => boolean; | × | 贴边事件传递，如果返回 false，则阻止后续事件 | -- |
| onHideEvent?: () => boolean; | × | 半隐藏事件传递，如果返回 false，则阻止后续事件 | -- |
| onShowEvent?: () => boolean; | × | 显示事件传递，如果返回 false，则阻止后续事件 | -- |

## 使用

### 代码使用

```arkts
build() {
  Stack() {
    // 一个 webview，充当用户业务视图
    // ... 用户业务代码

    // 悬浮按钮
    FloatBall({
      image: $r('app.media.startIcon'),             // 图片资源
      radius: 25,                                   // 悬浮按钮半径
      marginSart: 25,                               // 从隐藏恢复到显示状态的默认边距
      aotoEdging: true,                             // 开启自动贴边
      aotoHide: true,                               // 开启自动隐藏
      opacityHide: 0.5,                             // 半隐藏后的透明度
      onClickEvent: (): boolean => {                // 点击事件
        promptAction.showToast({ message: '点击了悬浮球' });
        if(this.controller.accessStep(-1)){
          this.controller.backward(); // 返回上一个 web 页
        }
        return true
      },
      onEdgingEvent: (): boolean => {
        promptAction.showToast({ message: '我贴边了' });
        return true
      },
      onHideEvent: (): boolean => {
        promptAction.showToast({ message: '我隐藏了' });
        return true
      },
      onShowEvent: (): boolean => {
        promptAction.showToast({ message: '我显示了' });
        return true
      }
    })
      // .touchable(false) // 这个过期了，.hitTestBehavior(HitTestMode.None)代替
      .hitTestBehavior(HitTestMode.None) // 重要用于点击事件穿透，不然无法点击 Web 内容
      .width("100%")
      .height("100%")
  }
  .height('100%')
  .width('100%')
}
```

## 更新记录

### 1.0.2 (2025-12-05)

#### 权限与隐私

| 项目 | 说明 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

#### 兼容性

| 项目 | 说明 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |

#### 支持环境

| 项目 | 说明 |
| :--- | :--- |
| 应用类型 | 应用 |
| 元服务 | 是 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @blxt/floatball
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/bb6e3484d9484b96bfc5ccfd6d6e5fbb/PLATFORM?origin=template