# turtlegraphics 矢量图形处理

## 简介

一个基于 ArkTS 的 Turtle 库，为 HarmonyOS 提供 SVG 与个性化绘制，同时为编程教育提供便利工具。

## 详细介绍

### 简介

ArkTS Turtle 个性化渲染解决方案，提供高效的矢量图形绘制能力。

### 下载安装

```bash
ohpm install @szcuoh/turtlegraphics
```

### 快速开始

```ets
// ets/main/index.ets
import { Turtle } from 'ets/Turtle/TurtleCore'; // 导入 Turtle 类
import { Point} from 'ets/types/Point'
import { drawKochCurveDynamic } from '../Patterns/index';

@Entry
@Component
struct TurtleDemo {
  private turtle: Turtle = new Turtle(); // 创建 Turtle 实例
  private kochOrder: number = 4; // 设置科赫曲线的阶数，可以根据需要调整

  // define Paths[]
  // private presetPoints: Point[] = [
  //   Point.create(100, 100),        // 起点
  //   Point.create(200, 100, 120),   // 向右移动并设置方向 120°(移动后的朝向)
  //   Point.create(150, 200, 240),   // 向上移动并设置方向 240°
  //   Point.create(100, 100, 0)      // 返回起点
  // ];

  build() {
    Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
      Canvas(this.turtle.getContext()) // 使用 Turtle 的上下文
        .width(this.turtle.getCanvasWidth())
        .height(this.turtle.getCanvasHeight())
        .backgroundColor(Color.White)
        .onReady(() => {
            
          drawKochCurveDynamic(this.turtle,5);
        })
    }.width('100%')
    .height('100%')
  }
}
```

### 模块说明

1. **核心绘图引擎（TurtleCore）**
   - 位置：`src/main/ets/Turtle/TurtleCore.ets`
   - 功能：提供基础绘图功能，被其他模块调用，是整个库的核心
   - 主要方法：`forward()`, `backward()`, `left()`, `right()`, `penUp()`, `penDown()` 等

2. **类型定义（Types）**
   - 位置：`src/main/ets/types/`
   - 功能：定义各种数据类型和结构
   - 主要类型：`Point` 等

3. **图案库（Patterns）**
   - 位置：`src/main/ets/Turtle/` 下的各种图案文件
   - 功能：封装各种预定义图案的绘制函数
   - 主要图案：`KochCurve`, `SierpinskiTriangle`, `FractalTree` 等

4. **SVG 支持（SVG）**
   - 位置：`src/main/ets/Attempting to add SVG/`
   - 功能：提供 SVG 解析和绘制功能（开发中）
   - 主要方法：`drawSVG()` 等

5. **工具类（Utils）**
   - 位置：`src/main/ets/utils/`
   - 功能：提供辅助功能

### 更新记录 [v1.0.0] 2025.04

- **新增**
  - 提供 Turtle 绘图核心类，支持移动、旋转、笔迹控制等基础功能
  - 支持 SVG 路径字符串解析与绘制渲染
  - 内置基本图形图案（如五角星、正方形等）
  - 提供 Fractal 分形图案等复杂图案的示例

### 权限与兼容性

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
| **元服务** | 元服务 |
| **设备类型** | 手机 |
| | 平板 |
| | PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.0 |

> Created with Pixso.

## 安装方式

```bash
ohpm install @szcuoh/turtlegraphics
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/2f1c6cdccc1a4a659edafb52751295a1/PLATFORM?origin=template