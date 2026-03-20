# CanvasDrawUtils 自定义绘制组件

## 简介

CanvasDrawUtils 是一个基于 AtkTs 开发的 Canvas 绘制工具类，采用单例模式设计，封装了路径绘制、文本绘制、图形绘制、样式管理、绘制记录（撤销 / 重做）等核心功能。该工具提供统一的 Canvas 绘制入口，确保全局绘制状态一致性，适用于移动端触摸绘图场景（如签名、标注、简单图形绘制等）。

## 详细介绍

### 概述

CanvasDrawUtils 是一个基于 ArkTs 开发的 Canvas 绘制工具类，采用单例模式设计，封装了路径绘制、文本绘制、图形绘制、样式管理、绘制记录（撤销 / 重做）等核心功能。该工具提供统一的 Canvas 绘制入口，确保全局绘制状态一致性，适用于移动端触摸绘图场景（如签名、标注、简单图形绘制等）。

### 安装及初始化使用

#### 1. 安装

```bash
ohpm i @ryan/canvas_utils
```

#### 2. 初始化使用

必须在使用任何绘制功能前调用 `init()` 方法，传入有效的 `CanvasRenderingContext2D` 上下文：

```typescript
// 引入工具类
import CanvasDrawUtils from "@ryan/canvas_utils";

// 调用 init() 方法，传入有效的 Canvas 2D 上下文进行初始化
private setting: RenderingContextSettings = new RenderingContextSettings(true);
private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.setting);

aboutToAppear(): void {
  CanvasDrawUtils.init(this.context)
}
```

### 核心特性

- **单例模式**：全局唯一实例，确保绘制状态（样式、记录）一致性。
- **多类型绘制**：支持路径绘制（触摸事件驱动）、文本绘制、基础图形绘制（矩形等）。
- **样式管理**：提供全局样式设置 / 获取，支持部分样式合并更新，自动同步到所有绘制模块。
- **绘制记录**：支持绘制内容的记录、清空、按 ID 删除，以及撤销 / 重做功能。
- **类型安全**：基于 TypeScript 接口定义，确保参数、返回值类型合规。
- **初始化校验**：所有功能调用前自动校验初始化状态，避免无效操作。

### 文件结构

```text
├──src/main/ets                         
│  ├──common/                                     
│  │  └── Logger.ets                                # 日志工具类，封装系统日志接口并提供环境区分能力
│  ├──constants/            
│  │  └── LoggerConstants.ets                       # 日志常量
│  ├──enum/            
│  │  └── DiagramType.ets                           # 图形元素类型
│  ├──example/                                    
│  │  ├── common/CommonConstants.ets                # page 常量
│  │  ├── components/color.ets                      # 颜色转换工具函数
│  │  ├── components/ControllerRecord.ets           # 绘制操作记录组件
│  │  ├── components/MyPaintSheet.ets               # 绘制样式选择组件
│  │  ├── components/Navbar.ets                     # navbar 租金
│  │  ├── pages/DiagramPage.ets                     # 图形绘制组件
│  │  ├── pages/PathPage.ets                        # 路径绘制组件
│  │  └── pages/TextPage.ets                        # 文本绘制组件
│  ├──model/                                 
│  │  └── DefaultModel.ets                          # 默认数据配置
│  ├──type                     
│  │  ├── CanvasStyle.ets                           # canvas 样式类型
│  │  ├── Drawable.ets                              # 绘制对象接口类型
│  │  ├── DrawOptions.ets                           # 绘制的选项类型
│  │  └── Lifecycle.ets                             # 监听的生命周期类型
│  ├──utils                     
│  │  ├── BaseCanvasDrawUtils.ets                   # canvas 绘制的基类
│  │  ├── CanvasDrawUtils.ets                       # canvas 绘制工具类
│  │  ├── MapUtils.ets                              # Map 工具类
│  │  ├── ObjectUtils.ts                            # Object 工具类
│  │  └── RandomUtils.ets                           # 随机函数工具类
│  ├──viewmodel                     
│  │  ├── BaseDrawable.ets                          # 可绘制元素基类
│  │  ├── BaseDrawViewModel.ets                     # 绘制模型基类
│  │  ├── DrawDiagram.ets                           # 图形绘制模型类
│  │  ├── DrawPath.ets                              # 路径绘制模型类
│  │  ├── DrawRecord.ets                            # 操作记录器
│  │  └── DrawText.ets                              # 文本绘制模型类
└──src/main/resource                                # 资源目录
```

### 绘制功能核心 API

```typescript
/**
 * Canvas 绘制工具类（单例）
 * 继承自基础 Canvas 绘制工具类，封装路径绘制、样式管理、绘制记录等核心功能
 * 提供统一的 Canvas 绘制入口，确保全局绘制状态一致性
 */
export class CanvasDrawUtils {
 /**
  * 处理路径绘制触摸事件
  * 驱动路径绘制视图模型执行触摸事件处理逻辑
  * @param event 触摸事件对象
  * @param drawType 绘制类型（可选，默认描边）
  * @throws {Error} 当工具未初始化时抛出错误
  */
 public drawPath(event: TouchEvent, drawType: DrawType = "stroke"): void;

 /**
  * 处理文本绘制
  * @param text 文本内容
  * @param textOptions 文本的配置信息
  */
 public drawText(text: string, textOptions: DrawTextOptions);

 /**
  * 处理图形绘制
  * @param type 图形绘制类型，默认是矩形 (rect)
  * @param location 绘制的位置信息
  */
 public drawDiagram(type: DiagramTypeEnum | DiagramType = DiagramTypeEnum.RECT, location: Location);

 /**
  * 获取所有绘制记录的配置信息
  * 将绘制记录映射表转换为普通对象，便于序列化或外部使用
  * @returns Record<string, IDrawOptions> 绘制记录配置（键为记录 ID，值为配置）
  */
 public getDrawRecords(): Record<string, IDrawOptions>;

 /**
  * 设置全局自定义绘制样式
  * 合并现有样式与新样式，并同步到路径绘制视图模型
  * @param style 要应用的自定义样式（支持部分样式更新）
  * @throws {Error} 当工具未初始化时抛出错误
  */
 public setGlobalStyle(style: Partial<ICanvasStyle>): void;

 /**
  * 获取当前全局绘制样式
  * 返回样式副本，避免外部直接修改内部状态
  * @returns CanvasStyle 当前全局样式的副本
  */
 public getCurrentGlobalStyle(): CanvasStyle;

 /**
  * 销毁单例实例（用于测试或特殊场景）
  * 重置实例状态，允许重新初始化
  */
 public destroyInstance(): void;

 /**
  * 清除所有绘制内容
  * 清空绘制记录并清除 Canvas 画布
  * @throws {Error} 当工具未初始化时抛出错误
  */
 public clearAllDrawContent(): void;

 /**
  * 清除指定 ID 的绘制内容
  * @throws {Error} 当工具未初始化时抛出错误
  */
 public clearDrawContentById(id: string): void;

 /**
  * 撤销
  */
 public undoDrawContent(): void;

 /**
  * 重新绘制
  */
 public redoDrawContent(): void;

 /**
  * 是否可以撤销绘制
  * @returns true: 是，false: 否
  */
 public canUndoDraw(): boolean;

 /**
  * 是否可以重新绘制
  * @returns true: 是，false: 否
  */
 public canRedoDraw(): boolean;
}
```

### 监听生命周期

```typescript
/**
 * 定义画布元素的生命周期钩子接口
 * 用于管理与 CanvasRenderingContext2D 相关的初始化和清理操作
 */
export interface Lifecycle {
 /**
  * CanvasRenderingContext2D 与 Canvas 组件发生绑定时调用
  * 可用于执行初始化操作，如设置样式、绘制初始状态等
  * @param context - 画布渲染上下文
  */
 onAttach?: (context: CanvasRenderingContext2D) => void;

 /**
  * CanvasRenderingContext2D 与 Canvas 组件解除绑定时调用
  * 可用于执行清理操作，如移除事件监听器、释放资源等
  * @param context - 画布渲染上下文
  */
 onDetach?: (context: CanvasRenderingContext2D) => void;

 /**
  * CanvasDrawUtils 发生错误或异常时触发
  * @param message - 错误信息
  */
 onError?: (message: string) => void
}
```

### 使用示例 (以路径绘制为例)

```typescript
/**
 * 路径演示示例
 */
@Component
export struct PathPage {
 private setting: RenderingContextSettings = new RenderingContextSettings(true);
 private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.setting);
 // 省略代码...
 
 ToggleThicknessColor() {
   // 设置 canvas 样式
   CanvasDrawUtils.setGlobalStyle({
     lineWidth: this.strokeWidth,
     strokeStyle: this.color,
     globalAlpha: this.alpha
   })
 }

 build() {
   NavDestination() {
     Column() {
       Navbar({ title: $r("app.string.path_page_title") })
       Stack({ alignContent: Alignment.Bottom }) {
         Canvas(this.context)
           .width(CommonConstants.ONE_HUNDRED_PERCENT)
           .layoutWeight(1)
           .backgroundColor($r('sys.color.white'))
           .onReady(() => {
             // CanvasUtils 初始化
             CanvasDrawUtils.init(this.context)
           })
           .onTouch((event: TouchEvent) => {
             // 路径绘制，传入 event 对象进行绘制
             CanvasDrawUtils.drawPath(event)
           })
       }
       .width(CommonConstants.ONE_HUNDRED_PERCENT)
       .layoutWeight(1)
       // 省略代码...
     }
   }
   .hideTitleBar(true)
 }
}
```

## 更新记录

### [v1.0.1] 2025.10.24

- 代码优化

### [v1.0.0] 2025.10.04

- 初版，提供路径、文本、图形绘制功能

## 权限与隐私及兼容性

| 项目 | 内容 |
| :--- | :--- |
| **权限与隐私基本信息** | |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| **兼容性** | |
| HarmonyOS 版本 | 5.0.0 |
| **应用类型** | 应用 |
| **元服务** | - |
| **设备类型** | 手机、平板、PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @ryan/canvas_utils
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/065bcdd8472a42bdb2b76a90b584e70d/PLATFORM?origin=template