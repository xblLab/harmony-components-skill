# ablekits/framework 开发框架组件

## 简介

ablekits 是一款高效、开箱即用的 HarmonyOS 框架，提供常用的 UI 组件和工具类，帮助开发者快速构建鸿蒙应用。

## 详细介绍

### 简介

ablekits 是一款高效、开箱即用的 HarmonyOS 框架，提供常用的 UI 组件和工具类，帮助开发者快速构建鸿蒙应用。

### 安装 (Install)

```bash
ohpm i @ablekits/framework
```

### 注册框架 (RegisterFramework)

在 entry（或 default）模块的 ets 目录下新增 configs 目录，然后新建 MyAblekitsConfig.ets 文件，增加以下配置代码：

```ets
import { AblekitsConfig } from "@ablekits/framework";
import { hilog } from "@kit.PerformanceAnalysisKit";

export default AblekitsConfig({
  // 全屏效果，不设置默认为 true
  FullScreen: true,
  // 监控网络状态，不设置默认为 true
  MonitorNetworkStatus: true,
  // 日志 domain，不设置则默认为 0x0000
  loggerDomain: 0x0009,
  // 日志 prefix，不设置则默认为 applog
  loggerPrefix: 'applog',
  // 最低日志级别，不设置则默认为 INFO
  minLogLevel: hilog.LogLevel.DEBUG
})
```

在 EntryAbility 的 onWindowStageCreate 生命周期 windowStage.loadContent 回调中注册框架：

```ets
import { AblekitsFramework } from '@ablekits/framework';
import MyAblekitsConfig from '../configs/MyAblekitsConfig';

//...

onWindowStageCreate(windowStage: window.WindowStage): void {
  windowStage.loadContent('pages/Index', (err) => {
    //...
    // 注册框架
    AblekitsFramework.register(MyAblekitsConfig, windowStage, this.context)
  });
}
```

### 目录

#### UI 组件

| 名称 | 介绍 |
| :--- | :--- |
| Titlebar | 标题栏 |
| NavDest | 导航目的页 |
| DividerPlus | 分割线增强版 |
| TogglePlus | Toggle 加强版，增加 onWillChange 回调事件 |
| ToggleCard | 开关式卡片 |
| DialogKit | 弹窗工具，提供多种不同类型的弹窗 |

#### 工具类

| 名称 | 介绍 |
| :--- | :--- |
| TimeKit | 时间工具，提供一些常用的功能。例如：1. 按定制格式输出时间。2. 将字符串解析为 Date。 |
| WindowKit | Window 工具，实现 Window 相关的功能 |

### 简单示例

#### UI 组件

**TogglePlus 增强版 Toggle**

```ets
TogglePlus({
  isOn: this.isDeveloper,
  onWillChange: (target: boolean) => {
    Logger.info(`开发者模式：target=${target}`)
    this.isDeveloper = target
    if (!this.isDeveloper) {
      this.isUpload = this.isDeveloper
    }
    return true
  },
  onChange: (isOn: boolean) => {
    Logger.info(`开发者模式：isOn=${isOn}`)
  },
})
```

#### 与 stage 相关功能

```ets
StageKit.getUIAbilityContext()
StageKit.getWindowStage()
StageKit.getUIContext()
```

#### Date 工具

```ets
DateFormat() // "2023-10-05 14:30:45"（当前时间）
DateFormat({ format: 'yyyy/mm/dd' }) // "2023/10/05"
DateFormat({ date: new Date('2023-01-02 14:05:09'), format: 'yy 年 m 月 d 日 H:M:S' }) // "23 年 1 月 2 日 14:5:9"
```

#### 避让区

```ets
import { avoidArea } from '@ablekits/framework';

//...

.padding({ top: avoidArea.topRectHeight, bottom: avoidArea.bottomRectHeight + avoidArea.keyboardHeight })
```

### 更新记录

#### 1.0.11

- 重构和优化 StageKit、PreferencesKit 工具类。

#### 1.0.10

- 增加确认弹窗配置。
- 增加 SystemKit 系统工具。
- 增加 PreferencesKit 首选项工具。

#### 1.0.9

- 优化弹窗相关配置。
- 适配更低版本的 IDE。

#### 1.0.8

- 完善：TimeKit.parseDate 方法。

#### 1.0.7

- 新增：
  - TimeKit：时间工具类，增加功能如下
    - formatDate 格式化日期对象为指定格式的字符串
    - parseDate 将字符串转换成 Date 对象

#### 1.0.6

- 新增：
  - DialogKit：弹窗工具类，增加功能如下
    - toast 提示
    - showDialog 显示弹窗 (PromptAction.showDialog 实现方式)
    - openCustomDialog 打开自定义弹窗 (PromptAction.openCustomDialog 实现方式)
    - getLastDialog 获取最后一个弹窗 (不包括 toast 和 showDialog 弹窗)
    - updateCustomDialog 更新自定义弹窗
    - close 关闭最新的弹窗 或 根据 ID 关闭弹窗
    - clear 清空所有弹窗 (不包括 toast 和 showDialog 弹窗)
    - loading 加载中弹窗
    - confirm 确认弹窗

#### 1.0.5

- 新增：
  - DividerPlus：Divider 组件增强版，分割线组件。
  - Titlebar：标题栏组件，包含返回按钮、标题、关闭按钮。
  - NavDest：导航目标页组件。
  - Logger：日志工具类

#### 1.0.4

- 新增：
  - TogglePlus：Toggle 组件增强版，主要增加了 onWillChange 事件。
  - ToggleCard：Toggle 卡片组件，切换开关和卡片组合组件。

#### 1.0.3

- 新增：
  - WindowKit：Window 工具，实现获取 Window、设置全屏、设置系统栏显隐、设置系统栏属性、保持屏幕常亮、设置隐私模式、设置窗口灰阶等功能。

#### 1.0.2

- 新增：
  - StageKit：Stage 工具，用于获取 UIAbilityContext、WindowStage、UIContext。
  - WindowKit：Window 工具，实现获取 Window、设置全屏、设置系统栏显隐、设置系统栏属性、保持屏幕常亮、设置隐私模式、设置窗口灰阶等功能。
  - avoidArea：AvoidArea 工具，获取避让区尺寸信息，如顶部避让区、底部避让区、软键盘区域尺寸等。
  - windowRect：WindowRect 工具，获取窗口矩形尺寸。

#### 1.0.1

- 公开发布首版本。

### 开发计划

- preference 工具
- RDB 数据工具
- 完善弹窗相关功能和配置项
- 新增工具：ThemeKit
- 增加主题样式配置实装
- Toggle 相关的 UI 组件适配深浅色主题

### 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| 基本信息 | 暂无 |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| 项目 | 内容 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | - |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @ablekits/framework
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/42911b6be9384409b84a0c675e3980de/PLATFORM?origin=template