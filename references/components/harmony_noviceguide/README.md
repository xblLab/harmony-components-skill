# HarmonyOS_noviceguide

## 简介

HarmonyOS_noviceguide 是一款专为 HarmonyOS（ArkUI）打造的高性能新手引导组件库，基于 ArkTS V2 状态管理架构开发，具备独特的交互穿透能力和智能定位算法，支持高度可定制的 UI（如气泡、连接线）及流畅的形状变换动画，旨在为鸿蒙应用提供原生级、沉浸式的新手引导体验。

> 视频播放器 is loading.播放视频播放静音当前时间 0:00/时长 0:09 加载完毕：100.00% 0:00 媒体流类型 直播 Seek to live, currently behind live 直播剩余时间 -0:09 1x 播放速度 2x 1.75x 1.5x 1.25x 1x, 选择 0.5x 节目段落 节目段落描述 关闭描述，选择字幕 字幕设定，开启字幕设置弹窗 关闭字幕，选择音轨 画中画 全屏 This is a modal window.开始对话视窗。离开会取消及关闭视窗文字 Color 白黑红绿蓝黄紫红青 Transparency 不透明半透明背景 Color 黑白红绿蓝黄紫红青 Transparency 不透明半透明透明视窗 Color 黑白红绿蓝黄紫红青 Transparency 透明半透明不透明字体尺寸 50% 75% 100% 125% 150% 175% 200% 300% 400% 字体边缘样式无浮雕压低均匀下阴影字体库比例无细体单间隔无细体比例细体单间隔细体舒适手写体小型大写字体重启 恢复全部设定至预设值完成关闭弹窗结束对话视窗

## 详细介绍

HarmonyOS_noviceguide 是一款专为 HarmonyOS (ArkUI) 打造的高性能、高可定制的新手引导组件库。它基于最新的 **ArkTS V2 状态管理架构** (@ComponentV2, @ObservedV2) 开发，旨在为鸿蒙应用提供原生级、沉浸式的新手引导体验。

主要功能清单如下：

*   **👆 交互穿透 (Interactive Pass-through)**：独创的挖孔响应机制，允许用户直接点击高亮区域内的组件（如点击按钮），实现“边引导，边操作”的沉浸式体验。
*   **🧠 智能定位与避让**：内置几何算法，当目标靠近屏幕边缘时，气泡自动调整方向（Auto Flip）或偏移，防止遮挡。
*   **🎨 自由定制提示框 UI**：支持通过 WrappedBuilder 传入自定义的 气泡 (Tip) 和 **连接线 (Connector)**，不受预设样式限制。
*   **📐 多种形状支持**：内置圆形 (Circle)、矩形 (Rect)、圆角矩形 (RoundRect) 的高亮区域，并在步骤切换时支持平滑的形状变换动画 (Morphing)。
*   **⚡️ ArkUI V2 架构**：全链路采用 V2 状态管理，状态管理更高效。

## 环境要求

*   IDE 版本：DevEco Studio 5.0.0 Release 及以上
*   SDK 版本：HarmonyOS API 12 及以上
*   编程语言：ArkTS、ArkUI

## 快速入门

### 安装组件

在项目根目录下执行以下命令：

深色代码主题复制
```bash
ohpm install harmony_noviceguide
```

### 引入组件

在需要使用的页面文件中引入核心类：

深色代码主题复制
```typescript
import { 
  NoviceGuide, 
  GuideController, 
  GuideBuilder 
} from 'harmony_noviceguide';
```

### 页面布局

将 NoviceGuide 组件放置在页面根容器 Stack 的 最底层（代码层面的最后一行，使其渲染在最上层）。

深色代码主题复制
```typescript
@Entry
@ComponentV2
struct Index {
  // 1. 创建控制器
  @Local guideController: GuideController = new GuideController();

  build() {
    Stack() {
      // ... 您的业务 UI ...
      Button('目标按钮').id('target_btn_1')

      // 2. 添加引导组件 (必须在 Stack 的最上方)
      NoviceGuide({ controller: this.guideController })
    }
  }
}
```

## 使用样例

通过 GuideBuilder 构建引导步骤并启动：

深色代码主题复制
```typescript
// 在页面加载完成(onPageShow)或点击事件中调用
startGuide() {
  new GuideBuilder()
    // 全局配置
    .setConfig({
      maskColor: 'rgba(0, 0, 0, 0.6)',
      clickMaskToNext: true, // 点击遮罩跳转下一步
      enableBlur: true       // 开启毛玻璃
    })
    // 步骤 1：基础用法
    .addStep({
      targetId: 'target_btn_1', // 对应组件的 .id()
      tipData: { title: '基础功能', content: '这是一个普通的高亮引导' },
      placement: 'bottom',      // 气泡在下方
      shape: 'roundRect'        // 圆角矩形
    })
    // 步骤 2：交互穿透
    .addStep({
      targetId: 'target_btn_2',
      tipData: { title: '交互模式', content: '您可以直接点击这个按钮触发业务逻辑' },
      placement: 'top',
      allowTargetClick: true    // 核心功能：允许点击高亮区
    })
    // 启动引导
    .show(this.guideController);
}
```

## 示例效果

## API 说明

### 1. NoviceGuide (组件)

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| controller | GuideController | 是 | 核心控制器，用于控制显示/隐藏 |
| tipContent | WrappedBuilder | 否 | 自定义气泡 UI 构建器 (全局默认) |
| connectorBuilder | WrappedBuilder | 否 | 自定义连接线构建器 (全局默认) |
| enableLog | boolean | 否 | 是否开启内部调试日志 |
| customGuideId | string | 否 | 自定义组件 ID，用于多实例场景 |

### 2. GuideController (控制器)

| 方法 | 说明 |
| :--- | :--- |
| start(steps, config?, onFinish?) | 启动引导流程 |
| next() | 跳转下一步 |
| prev() | 返回上一步 |
| stop() | 停止并关闭引导 |
| onStepChange(callback) | 监听步骤切换 |
| onStepWillChange(callback) | 拦截步骤切换（返回 false 可阻止） |

### 3. GuideStepOptions (步骤配置)

| 属性 | 类型 | 说明 |
| :--- | :--- | :--- |
| targetId | string | 目标组件的 ID (需在 UI 中设置 .id()) |
| tipData | Object | 提示数据 (默认包含 title, content，无泛型) |
| placement | GuidePlacement | 气泡方位 (top/bottom/left/right 等) |
| shape | circle/rect/roundRect | 形状 |
| allowTargetClick | boolean | 是否允许点击高亮区域 (穿透) |
| zoneConfig | ZoneConfig | 高亮区的内边距 (padding) 和圆角 (borderRadius) |
| stepBuilder | WrappedBuilder | 单步完全自定义气泡 UI |
| connectorBuilder | WrappedBuilder | 单步自定义连接线 UI |
| scroller | Scroller | 绑定的滚动控制器，用于自动定位 |
| scrollIndex | number | 滚动目标的索引 |

## 配置说明

通过 GuideBuilder.setConfig() 或直接实例化 GuideGlobalConfig 进行配置：

| 属性 | 默认值 | 说明 |
| :--- | :--- | :--- |
| maskColor | 'rgba(0, 0, 0, 0.6)' | 遮罩层颜色 |
| animDuration | 350 | 形状变换动画时长 (ms) |
| clickMaskToNext | true | 点击遮罩空白处是否下一步 |
| enableBlur | false | 是否开启背景模糊 |
| autoPlay | false | 是否自动播放 |
| autoPlayInterval | 3000 | 自动播放间隔 (ms) |
| enableAutoFlip | true | 空间不足时是否自动翻转方向 |
| safePadding | 16 | 屏幕边缘安全距离 |

## 权限要求

本组件为纯 UI 组件，不需要申请任何系统权限。

## 技术支持

如果您在使用过程中遇到问题，或有功能建议，欢迎通过以下方式联系：

*   **Issues**: 请在代码仓库提交 Issue

## 开源许可协议

该代码经过 Apache 2.0 授权许可。

## 获取方式

可以通过 OHPM 中心仓获取，或访问 [https://gitee.com/qq1963861722/HarmonyNoviceGuideGit.git](https://gitee.com/qq1963861722/HarmonyNoviceGuideGit.git) 下载源码。

## 更新记录

*   **1.0.0 (2025-12-25)**
*   **1.0.0 (2025-12-19)**：基于 ArkUI (ArkTS) 的通用新手引导组件 - 初始发布

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

## SDK 合规使用指南

不涉及

## 兼容性

| HarmonyOS 版本 | 备注 |
| :--- | :--- |
| 5.0.0 | Created with Pixso. |
| 5.0.1 | Created with Pixso. |
| 5.0.2 | Created with Pixso. |
| 5.0.3 | Created with Pixso. |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |
| 5.1.0 | Created with Pixso. |
| 5.1.1 | Created with Pixso. |
| 6.0.0 | Created with Pixso. |
| 6.0.1 | Created with Pixso. |

| 应用类型 | 备注 |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

| 设备类型 | 备注 |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

| DevEcoStudio 版本 | 备注 |
| :--- | :--- |
| DevEco Studio 5.0.0 | Created with Pixso. |
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
ohpm install harmony_noviceguide
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/0762360cb4be42e99fafe3959dae07d4/DEVELOPER?origin=template