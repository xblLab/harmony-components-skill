# 散点图组件

## 简介

scatter 是一个简单的散点图组件，只需要简单的配置，便可以实现一个散点图，支持单一和多样颜色配置，支持所有属性自定义实现。

## 详细介绍

### 功能介绍

scatter 是一个简单的散点图组件，只需要简单的配置，便可以实现一个散点图，支持单一和多样颜色配置，支持所有属性自定义实现。

### 环境要求

Api 适用版本：>=12

### 示例效果

*   静态效果
*   动态效果

### 目前功能

1.  支持单一颜色配置和多种颜色配置。
2.  支持自绘制方格和不带方格两种效果。
3.  支持数据动态调整。
4.  所有属性均可自定义实现。

## 快速入门

### 方式一

在 Terminal 窗口中，执行如下命令安装三方包，DevEco Studio 会自动在工程的 oh-package.json5 中自动添加三方包依赖。

建议：在使用的模块路径下进行执行命令。

```bash
ohpm install @abner/scatter
```

### 方式二

在需要的模块中的 oh-package.json5 中设置三方包依赖，配置示例如下：

```json5
"dependencies": { "@abner/scatter": "^1.0.0"}
```

## 使用样例

### 简单使用

```typescript
ScatterChartView({
  scatterChartData: this.scatterChartData
})
  .width("100%")
  .height(300)
```

### 带网格

```typescript
ScatterChartView({
  scatterChartData: this.scatterChartData,
  chartType: ScatterChartType.grid
})
  .width("100%")
  .height(300)
```

### 完整 Demo

```typescript
import { ScatterChartData, ScatterChartType, ScatterChartView } from '@abner/scatter'
import { ActionBar } from '../../view/ActionBar'

/**
 *AUTHOR:AbnerMing
 *DATE:2026/1/17
 *INTRODUCE:散点图
 */
@Entry
@ComponentV2
struct ScatterChartPage {
  private colorArray: string[] = [
    '#3b82f6', '#ef4444', '#10b981', '#f59e0b',
    '#8b5cf6', '#06b6d4', '#6b7280', '#111827'
  ];
  private singleColor: string = '#3b82f6';
  @Local useMultiColor: boolean = true
  @Local scatterChartData: ScatterChartData[] = []

  aboutToAppear(): void {
    this.generateRandomPoints(10)
  }

  build() {
    Column() {
      ActionBar({ title: "散点图" })
      ScatterChartView({
        scatterChartData: this.scatterChartData
      })
        .width("100%")
        .height(300)

      ScatterChartView({
        scatterChartData: this.scatterChartData,
        chartType: ScatterChartType.grid
      })
        .width("100%")
        .height(300)

      Row() {
        Button("随机数据")
          .onClick(() => {
            this.generateRandomPoints(10)
          })
        Button("单色")
          .onClick(() => {
            this.useMultiColor = false
            this.generateRandomPoints(10)
          })
          .margin({ left: 10 })
        Button("多色")
          .margin({ left: 10 })
          .onClick(() => {
            this.useMultiColor = true
            this.generateRandomPoints(10)
          })
      }.margin({ top: 10 })
    }.width("100%")
      .height("100%")
  }

  // 生成随机数据点
  private generateRandomPoints(count: number) {
    this.scatterChartData = [];
    for (let i = 0; i < count; i++) {
      this.addRandomPoint();
    }
  }

  // 添加单个随机数据点
  private addRandomPoint() {
    const x = Math.random() * (100 - 0);
    const y = Math.random() * (100 - 0);
    const color =
      this.useMultiColor ? this.colorArray[Math.floor(Math.random() * this.colorArray.length)] : this.singleColor;
    this.scatterChartData.push({
      x: parseFloat(x.toFixed(2)),
      y: parseFloat(y.toFixed(2)),
      color: color
    })


  }
}
```

## API 说明

### Api 适用版本

Api 适用版本：>=12

### 配置说明

常见属性配置如下：

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| chartType | ScatterChartType | 散点图类型，默认：ScatterChartType.default，无网格 |
| minX | number | x 轴最小坐标，默认为 0 |
| maxX | number | x 轴最大坐标 ,默认为 100 |
| stepX | number | x 轴步长，默认 20 |
| minY | number | y 轴最小坐标 ,默认为 0 |
| maxY | number | y 轴最大坐标 ,默认为 100 |
| stepY | number | y 轴步长 ，默认 20 |
| marginLeft | number | 距离左边，默认 50 |
| marginRight | number | 距离右边，默认 30 |
| marginTop | number | 距离上边，默认 30 |
| marginBottom | number | 距离下边，默认 50 |
| scatterChartData | ScatterChartData | 散点图数据 |
| scatterSize | number | 散点图大小，默认 3 |
| scaleTextSize | number | XY 轴的刻度值大小 |
| scaleTextColor | string / number / CanvasGradient / CanvasPattern | XY 轴的刻度颜色 |
| scaleLineColor | string / number / CanvasGradient / CanvasPattern | 刻度线颜色 |
| scaleLineWidth | number | 刻度线粗细 |
| isShowXLabel | boolean | 是否显示 X 轴标签，默认 fasle 不显示 |
| isShowYLabel | boolean | 是否显示 Y 轴标签，默认 fasle 不显示 |
| labelTextX | string | X 轴标签 |
| labelTextY | string | Y 轴标签 |
| labelTextSize | number | 标签文字大小，默认 14 |
| labelTextColor | string / number / CanvasGradient / CanvasPattern | 标签文字颜色 |
| scatterXYLineColor | string / number / CanvasGradient / CanvasPattern | XY 轴颜色 |
| scatterXYLineWidth | number | XY 轴宽度，默认 1 |
| gridBgColor | string / number / CanvasGradient / CanvasPattern | 网格背景 |
| gridLineColor | string / number / CanvasGradient / CanvasPattern | 网格线颜色 |
| gridLineWidth | number | 网格线粗细 |
| gridStrokeColor | string / number / CanvasGradient / CanvasPattern | 网格边框颜色 |
| gridStrokeWidth | number | 网格线边框粗细 |

### 权限要求

无权限要求

### 技术支持

在 Github 中的 Issues 中提问题，定期解答。

### 开源许可协议

该代码经过 Apache 2.0 授权许可。

## 更新记录

**1.0.0 (2026-01-22)**
1. 散点图组件首次提交。
2. 支持单一颜色配置和多种颜色配置。
3. 支持自绘制方格和不带方格两种效果。

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无权限 | 无权限 | 无权限 |

## SDK 合规使用指南

不涉及

## 兼容性

| HarmonyOS 版本 | Created with Pixso. |
| :--- | :--- |
| 5.0.5 | Created with Pixso. |
| 5.1.0 | Created with Pixso. |
| 5.1.1 | Created with Pixso. |
| 6.0.0 | Created with Pixso. |
| 6.0.1 | Created with Pixso. |

| 应用类型 | Created with Pixso. |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

| 设备类型 | Created with Pixso. |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

| DevEcoStudio 版本 | Created with Pixso. |
| :--- | :--- |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |
| DevEco Studio 6.0.1 | Created with Pixso. |

## 安装方式

```bash
ohpm install @abner/scatter
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/fe95ad3ef053442988145f9b2273592a/b6a17875746941e0b5606c9b1eb174f8?origin=template