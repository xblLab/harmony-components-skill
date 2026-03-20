# 桌面布局

## 简介

一款用于 OpenHarmony / HarmonyOS 的响应式桌面栅格布局组件

## 详细介绍

视频播放器 is loading.播放视频播放静音当前时间 0:00/时长 0:40 加载完毕：100.00%0:00 媒体流类型 直播 Seek to live, currently behind live 直播剩余时间 -0:40 1x 播放速度 2x1.75x1.5x1.25x1x, 选择 0.5x 节目段落节目段落描述关闭描述，选择字幕字幕设定，开启字幕设置弹窗关闭字幕，选择音轨画中画全屏 This is a modal window.开始对话视窗。离开会取消及关闭视窗文字 Color 白黑红绿蓝黄紫红青 Transparency 不透明半透明背景 Color 黑白红绿蓝黄紫红青 Transparency 不透明半透明透明视窗 Color 黑白红绿蓝黄紫红青 Transparency 透明半透明不透明字体尺寸 50%75%100%125%150%175%200%300%400% 字体边缘样式无浮雕压低均匀下阴影字体库比例无细体单间隔无细体比例细体单间隔细体舒适手写体小型大写字体重启 恢复全部设定至预设值完成关闭弹窗结束对话视窗

  
    
      
        
          
          
        
      
    
  

Desktop Layout
desktop_layout 是一个用于 OpenHarmony / HarmonyOS 的响应式桌面栅格布局组件。它允许用户像在桌面操作系统上一样自由拖拽、调整组件大小，并支持根据屏幕宽度自动调整列数的响应式布局。

## ✨ 特性 (Features)

- 🖱️ **拖拽布局 (Drag & Drop)**: 长按组件即可进入编辑模式，自由拖拽改变位置。
- 📐 **自由调整大小 (Resizable)**: 支持通过拖动组件边缘的手柄来调整组件的宽和高。
- 📱 **响应式设计 (Responsive)**: 支持自定义断点（Breakpoints），根据屏幕宽度动态调整布局列数。
- 💾 **状态保存 (State Persistence)**: 提供回调接口，方便保存布局更新后的序列和位置信息。
- 🎨 **高度定制 (Customizable)**: 支持自定义组件内容渲染，以及最大尺寸限制。
- 🧩 **服务卡片支持 (Service Widgets)**: 支持对应服务卡片加桌（需 API 18+）。

## 示例效果

下面是 EasyTier 采用本组件后的效果

## 🚀 快速入门 (Quick Start)

### 1. 引入组件
确保你的项目中已经包含了 `desktop_layout` 模块。

### 2. 基本使用
在你的页面中引入 `DesktopLayout` 并配置必要的参数。

深色代码主题复制
```typescript
import { DesktopLayout, CompSizeWithPos, BreakpointConfig } from 'desktop_layout';
import { wrapBuilder } from '@kit.ArkUI';
import { Want } from '@kit.AbilityKit';

// 定义组件内容构建器
@Builder
function MyContentBuilder(type: string) {
  Column() {
    Text(type)
      .fontSize(24)
      .fontWeight(FontWeight.Bold)
      .fontColor(Color.White)
  }
  .width('100%')
  .height('100%')
  .backgroundColor(Color.Blue)
  .justifyContent(FlexAlign.Center)
  .borderRadius(12)
}

@Entry
@Component
struct Index {
  // 1. 初始化组件数据 (位置与尺寸)
  @State compSequence: CompSizeWithPos[] = [
    { type: 'widget_1', x: 0, y: 0, width: 2, height: 2 },
    { type: 'widget_2', x: 2, y: 0, width: 2, height: 1 },
    { type: 'card_weather', x: 0, y: 2, width: 4, height: 2 } // 假设这是一个卡片
  ];

  // 2. 注册所有组件类型
  types: string[] = ['widget_1', 'widget_2', 'card_weather'];

  // 3. 定义响应式断点
  myBreakpoints: BreakpointConfig[] = [
    { breakpoint: 0, columns: 2 },    // 0vp - 600vp: 2 列
    { breakpoint: 600, columns: 4 },  // 600vp - 1200vp: 4 列
    { breakpoint: 1200, columns: 6 }  // 1200vp+: 6 列
  ];

  // 4. 包装 Builder
  wrapper = wrapBuilder(MyContentBuilder);

  build() {
    Column() {
      DesktopLayout({
        name: 'home',                     // 定义当前布局的唯一名称
        comp_sequence: this.compSequence, // 初始布局数据
        types: this.types,                // 组件类型列表
        contentBuilder: this.wrapper,     // 普通组件内容渲染器
        breakpoints: this.myBreakpoints,  // 响应式配置
        maxCompW: 4,                      // 组件最大宽度 (占列数)
        maxCompH: 4,                      // 组件最大高度 (占行数)
        saveSequence: (layout) => {       // 布局变更回调
          console.info('Layout updated:', JSON.stringify(layout.comp_sequence));
        },
        
        // --- 服务卡片配置 (API 18+) ---
        hasWidgetList: ['card_weather'],  // 指定哪些组件 ID 是卡片
        formWantFunc: (type: string): Want => { // 返回卡片的 Want 信息
           return {
             bundleName: "com.example.app",
             abilityName: "EntryFormAbility",
             parameters: {
               'ohos.extra.param.key.form_dimension': 2, 
               'ohos.extra.param.key.form_name': type,
               'ohos.extra.param.key.module_name': 'entry'
             }
           };
        }
      })
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F1F3F5')
  }
}
```

### 3. 使用提示
使用 `Consumer` 可以接收子组件的宽高，便于去快速处理尺寸问题。

深色代码主题复制
```typescript
@Consumer("w") w: number = 1
@Consumer("h") h: number = 1
```

为了进行组件的显隐控制，可以通过 `LayoutManager` 获取到对应布局的 `LayoutUtil`。

深色代码主题复制
```typescript
@Computed
get layout() {
    return LayoutManager.getLayout("home")
}
```

判断组件的显隐状态。

深色代码主题复制
```typescript
this.layout!.comp_sequence.includes(type)
```

显示组件。

深色代码主题复制
```typescript
this.layout!.addComponent(type)
```

隐藏组件。

深色代码主题复制
```typescript
this.layout!.removeComponent(type)
```

## 📖 API 说明

### DesktopLayout 组件参数

| 参数名 | 类型 | 必填 | 默认值 | 说明 |
| :--- | :--- | :---: | :--- | :--- |
| comp_sequence | CompSizeWithPos[] | ✅ | - | 组件的初始位置和尺寸序列。 |
| types | string[] | ✅ | - | 包含所有可用组件类型的数组 (ID)。 |
| contentBuilder | WrappedBuilder<[string]> | ✅ | - | 用于渲染每个组件实际内容的全局 Builder。 |
| breakpoints | BreakpointConfig[] | ❌ | `[0->2, 720->4, 1080->6]` | 响应式断点配置，定义不同宽度下的列数。 |
| maxCompW | number | ❌ | 6 | 组件允许调整的最大宽度（单位：网格列数）。 |
| maxCompH | number | ❌ | 4 | 组件允许调整的最大高度（单位：网格行数）。 |
| saveSequence | `(layout: LayoutUtil) => void` | ❌ | log | 当布局发生改变（拖拽或缩放结束）时的回调。 |
| name | string | ❌ | "index" | 布局实例的唯一标识名称。 |
| hasWidgetList | string[] | ❌ | [] | (API 18+) 指定哪些 type 是服务卡片 (Service Widgets)，这些组件在长按时将提供添加到桌面选项。 |
| formWantFunc | `(type: string) => Want` | ❌ | Default Impl | (API 18+) 当组件被标记为卡片时，该回调用于生成对应的 Want 信息。 |

### 接口定义

#### CompSizeWithPos
描述组件的位置和尺寸。

深色代码主题复制
```typescript
interface CompSizeWithPos {
  type: string;  // 组件唯一标识符
  x: number;     // 起始列索引 (0-based)
  y: number;     // 起始行索引 (0-based)
  width: number; // 占用的列数
  height: number;// 占用的行数
}
```

#### BreakpointConfig
定义屏幕宽度的响应式断点。

深色代码主题复制
```typescript
interface BreakpointConfig {
  breakpoint: number; // 屏幕宽度断点 (vp)
  columns: number;    // 该宽度区间对应的网格列数
}
```

## 交互说明

- **进入编辑模式**: 长按任意组件。
- **拖拽**: 在编辑模式下，按住组件并拖动到新位置。
- **调整大小**: 在编辑模式下，点击组件，组件四周会出现调整手柄（小圆点），拖动手柄改变大小。
- **退出编辑模式**: 点击被编辑组件以外的区域。

## 更新记录

- **1.0.6** (2026-01-27): 修复所有异常 bug
- **1.0.4** (2026-01-20): 修复 bug，点击菜单后将直接关闭菜单，不再等待 onDisappear 回调
- **1.0.3** (2026-01-13): 替换包内开源协议为 MIT
- **1.0.2** (2026-01-13): 清除子组件 R 角、背景颜色
- **1.0.0** (2026-01-12): 初次发布

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.VIBRATE | 实现长按震动 | 提升交互质感 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

### HarmonyOS 版本

| 版本 | 状态 |
| :--- | :--- |
| 5.0.5 | Created with Pixso. |
| 5.1.0 | Created with Pixso. |
| 5.1.1 | Created with Pixso. |
| 6.0.0 | Created with Pixso. |
| 6.0.1 | Created with Pixso. |

### 应用类型

| 类型 | 状态 |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

### 设备类型

| 设备 | 状态 |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

### DevEcoStudio 版本

| 版本 | 状态 |
| :--- | :--- |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |
| DevEco Studio 6.0.1 | Created with Pixso. |

## 安装方式

```bash
ohpm install desktop_layout
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/453500e15bdf443a883b7947d356b022/DEVELOPER?origin=template