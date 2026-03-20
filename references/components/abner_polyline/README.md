# 折线图 polyline 组件

## 简介

polyline 是一个简单的折线图组件，只为折线图服务！支持单折线，多折线展示，支持多种效果，支持点击，手势十字光标展示。

## 功能介绍

polyline 是一个简单的折线图组件，只为折线图服务！支持单折线，多折线展示，支持多种效果，支持点击，手势十字光标展示。

### 目前功能

1. 支持普通的折线图展示。
2. 支持多条折线对比展示。
3. 支持折线背景网格多样式设置。
4. 支持横线纵线虚线属性控制。
5. 支持数据 X 轴居中展示。
6. 支持点击事件。
7. 支持 X 轴自定义标注。
8. 支持刻度自定义展示。
9. 支持手势十字光标展示。

## 环境要求

**Api 适用版本：** >=12

## 快速入门

### 方式一

在 Terminal 窗口中，执行如下命令安装三方包，DevEco Studio 会自动在工程的 `oh-package.json5` 中自动添加三方包依赖。

> **建议：** 在使用的模块路径下进行执行命令。

```bash
ohpm install @abner/polyline
```

### 方式二

在需要的模块中的 `oh-package.json5` 中设置三方包依赖，配置示例如下：

```json5
"dependencies": { 
  "@abner/polyline": "^1.0.0"
}
```

## 使用示例

### 简单使用

```typescript
PolylineView({
  xLabels: ['一月', '二月', '三月', '四月', '五月', '六月'],
  data: [-150, 20, 320, 160, 300, 200]
}).width("100%")
  .height(300)
```

### 更改折线颜色

```typescript
PolylineView({
  xLabels: ['一月', '二月', '三月', '四月', '五月', '六月'],
  data: [-150, 20, 320, 160, 300, 200],
  onLineData: (line) => {
    line.color = Color.Red
  },
  onPointData: (point) => {
    point.fillColor = Color.Red
  }
}).width("100%")
  .height(300)
```

### X 轴标签居中

```typescript
PolylineView({
  xLabels: ['一月', '二月', '三月', '四月', '五月', '六月'],
  data: [-150, 20, 320, 160, 300, 200],
  axisLabelsPosition: AxisLabelsPosition.between
}).width("100%")
  .height(300)
```

### 网格虚线框

```typescript
PolylineView({
  xLabels: ['一月', '二月', '三月', '四月', '五月', '六月'],
  data: [-150, 20, 320, 160, 300, 200],
  axisLabelsPosition: AxisLabelsPosition.between,
  onGridData: (grid) => {
    grid.isDottedLine = true //显示虚线
  }
}).width("100%")
  .height(300)
```

### 隐藏垂直线

```typescript
PolylineView({
  xLabels: ['一月', '二月', '三月', '四月', '五月', '六月'],
  data: [-150, 20, 320, 160, 300, 200],
  axisLabelsPosition: AxisLabelsPosition.between,
  onGridData: (grid) => {
    grid.isDottedLine = true //显示虚线
    grid.showVerticalLine = false
  }
}).width("100%")
  .height(300)
```

### 延长 XY 轴线

```typescript
PolylineView({
  xLabels: ['一月', '二月', '三月', '四月', '五月', '六月'],
  data: [-150, 20, 320, 160, 300, 200],
  axisLabelsPosition: AxisLabelsPosition.between,
  onGridData: (grid) => {
    grid.isDottedLine = true //显示虚线
    grid.showVerticalLine = false
  },
  marginTop: 20,
  onAxisLineData: (axis) => {
    axis.yExceedsSize = 20 //延长 Y 轴
  }
}).width("100%")
  .height(300)
```

### 双折线

```typescript
PolylineView({
  xLabels: ['管理部', '销售部', '采购部', '生产部', '财务部'],
  axisLabelsPosition: AxisLabelsPosition.between,
  includeZero: true, //显示 0 刻度
  multipleData: [
    {
      name: '计划',
      data: [35, 45, 42, 50, 38],
      fillColor: '#10b981',
      lineColor: '#10b981'
    },
    {
      name: '实际',
      data: [25, 38, 28, 48, 35],
      fillColor: '#f97316',
      lineColor: '#f97316'
    }
  ]
})
  .width("100%")
  .height(300)
```

### Y 轴自定义

```typescript
PolylineView({
  minY: 0, //最小
  maxY: 5, //最大
  xLabels: ['1:00', '2:00', '3:00', '4:00', '5:00'],
  axisLabelsPosition: AxisLabelsPosition.between,
  data: [1.2, 1.8, 2.6, 3.6, 4.2], //数据
  onYLabelData: (label) => {
    label.yAxisLabels = ['', '优', '良', '轻', '中', '重']
    label.yAxisColor = ['', '#0ef106', '#cef106', '#f1b706', '#e76108', '#ff0000']
  },
  onLineData: (line) => {
    line.color = "#d95011"
  },
  onPointData: (point) => {
    point.fillColor = "#d95011"
  },
  onGridData: (grid) => {
    grid.isDottedLine = true //显示虚线
    grid.showVerticalLine = false
  },
  onCoordinateScaleData: (scale) => {
    scale.show = true
    scale.showYLine = false //隐藏 Y 轴刻度
    scale.showXLine = true //显示 X 轴刻度
    scale.hideXFirst = true //隐藏 X 轴第一个刻度
  }
}).width("100%")
  .height(300)
```

### 点击事件

```typescript
PolylineView({
  xLabels: this.xLabels,
  data: this.yData,
  onClickPointEvent: (bean) => {
    this.xClickLabel = this.xLabels[bean.position!!]
    this.yClickData = this.yData[bean.position!!]
    clearTimeout(this.tempPieChartTimeout)
    this.tempPieChartTimeout = setTimeout(() => {
      this.xClickLabel = undefined
    }, 2000)
  }
}).width("100%")
  .height(300)
```

### 十字光标

```typescript
PolylineView({
  xLabels: ['一月', '二月', '三月', '四月', '五月', '六月'],
  data: [-150, 20, 320, 160, 300, 200],
  onCrossHairData: (hair) => {
    hair.show = true
    hair.color = "#ff0000" //十字光标颜色
  }
}).width("100%")
  .height(300)
```

## API 说明

**Api 适用版本：** >=12

### 配置说明

常见属性配置如下：

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| marginLeft | number | 距离左边，默认 40 |
| marginRight | number | 距离右边，默认 20 |
| marginTop | number | 距离上边，默认 10 |
| marginBottom | number | 距离下边，默认 30 |
| xLabels | string[] | X 轴的数据 |
| data | number[] | y 轴的数据，单折线数据 |
| multipleData | MultipleData[] | y 轴的数据，多折线数据 |
| includeZero | boolean | Y 轴刻度是否从 0 开始 |
| axisLabelsPosition | AxisLabelsPosition | 折线和 X 轴数据位置，默认 AxisLabelsPosition.scale，以刻度位置展示 |
| onCoordinateScaleData | `(coordinateScale: CoordinateScaleData) => void` | 设置刻度样式 |
| onGridData | `(gridData: GridData) => void` | 设置网格样式 |
| onAxisLineData | `(axisLineData: AxisLineData) => void` | 设置坐标轴样式 |
| onXLabelData | `(xLabelData: XLabelData) => void` | 设置 X 轴标签样式 |
| onYLabelData | `(yLabelData: YLabelData) => void` | 设置 Y 轴标签样式 |
| onPointData | `(pointData: PointData) => void` | 设置交汇点样式 |
| onLineData | `(lineData: LineData) => void` | 设置折线样式 |
| onCrossHairData | `(crossHairData: CrossHairData) => void` | 设置十字光标样式 |
| onClickPointEvent | `(data: PolylineItemData) => void` | 点击交汇点事件 |
| minY | number | Y 轴最小，自定义 Y 轴标签时可配置 |
| maxY | number | Y 轴最大，自定义 Y 轴标签时可配置 |

### 枚举类型

#### AxisLabelsPosition
折线和 X 轴标签位置

```typescript
between: 折线和 X 轴坐标在中间
scale: 折线和 X 轴坐标在坐标轴
```

#### CoordinateScaleData
设置刻度样式

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| show | boolean | 是否显示刻度，默认 true，显示 |
| color | string/number/CanvasGradient/CanvasPattern | 刻度值颜色 |
| length | number | 刻度值长度 |
| width | number | 刻度值线大小 |
| showXLine | boolean | 是否显示 X 轴刻度，默认 true 显示 |
| showYLine | boolean | 是否显示 Y 轴刻度，默认 true 显示 |
| hideXFirst | boolean | X 轴第一个是否隐藏，默认 false 不隐藏 |
| hideYFirst | boolean | Y 轴第一个是否隐藏，默认 false 不隐藏 |

#### GridData
设置网格样式

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| show | boolean | 是否显示网格，默认 true，显示 |
| color | string/number/CanvasGradient/CanvasPattern | 网格颜色 |
| width | number | 网格线大小 |
| isDottedLine | boolean | 是否是虚线，默认 false 不是 |
| lineDash | number[] | 虚线间隔 |
| showVerticalLine | boolean | 是否显示垂直线，默认 true 显示 |
| showHorizontalLine | boolean | 是否显示水平线，默认 true 显示 |

#### AxisLineData
设置坐标轴样式

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| show | boolean | 是否显示坐标轴，默认 true，显示 |
| color | string/number/CanvasGradient/CanvasPattern | 坐标轴颜色 |
| width | number | 坐标轴线大小 |
| xExceedsSize | number | X 轴超出，根据自己需要设置 |
| yExceedsSize | number | Y 轴超出，根据自己需要设置 |

#### XLabelData
设置 X 轴标签样式

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| show | boolean | 是否显示 X 轴标签，默认 true，显示 |
| color | string/number/CanvasGradient/CanvasPattern | X 轴标签颜色 |
| fontSize | number | X 轴标签文字大小 |
| fontWeight | FontWeight | X 轴标签文字字重 |

#### YLabelData
设置 Y 轴标签样式

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| show | boolean | 是否显示 Y 轴标签，默认 true，显示 |
| color | string/number/CanvasGradient/CanvasPattern | Y 轴标签颜色 |
| fontSize | number | Y 轴标签文字大小 |
| fontWeight | FontWeight | Y 轴标签文字字重 |
| yAxisLabels | string[] | Y 轴自定义标签 |
| yAxisColor | string[]/number[]/CanvasGradient[]/CanvasPattern[] | Y 轴自定义标签颜色 |

#### PointData
设置交汇点样式

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| show | boolean | 是否显示交汇点，默认 true，显示 |
| fillColor | string/number/CanvasGradient/CanvasPattern | 交汇点填充颜色 |
| strokeColor | string/number/CanvasGradient/CanvasPattern | 交汇点边框颜色 |
| width | number | 交汇点大小 |
| fill | boolean | 是否是填充，默认是 |

#### LineData
折线样式

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| show | boolean | 是否显示折线，默认 true，显示 |
| color | string/number/CanvasGradient/CanvasPattern | 折线颜色 |
| width | number | 折线大小 |

#### CrossHairData
十字光标样式

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| show | boolean | 是否显示十字光标，默认 false，不显示 |
| color | string/number/CanvasGradient/CanvasPattern | 十字光标颜色 |
| width | number | 十字光标大小 |
| isDottedLine | boolean | 是否是虚线，默认 false 不是 |
| dash | number[] | 虚线间隔 |
| movePointEvent | `(data: PolylineItemData) => void` | 十字光标移动点位 |

#### PolylineItemData
点击和手势对象

```typescript
position: 当前位置索引
parentIndex: 父索引位置
```

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无权限 | 无权限 | 无权限 |

### SDK 合规使用指南

不涉及

## 技术支持

在 Github 中的 Issues 中提问题，定期解答。

## 开源许可协议

该代码经过 Apache 2.0 授权许可。

## 更新记录

### 1.0.0 (2026-01-26)

1. 支持普通的折线图展示。
2. 支持多条折线对比展示。
3. 支持折线背景网格多样式设置。
4. 支持横线纵线虚线属性控制。
5. 支持数据 X 轴居中展示。
6. 支持点击事件。
7. 支持 X 轴自定义标注。
8. 支持刻度自定义展示。
9. 支持手势十字光标展示。

## 兼容性

| HarmonyOS 版本 | 应用类型 | 设备类型 | DevEco Studio 版本 |
| :--- | :--- | :--- | :--- |
| 5.0.5 | 应用 | 手机 | DevEco Studio 5.0.5 |
| 5.1.0 | 元服务 | 平板 | DevEco Studio 5.1.0 |
| 5.1.1 | - | - | DevEco Studio 5.1.1 |
| 6.0.0 | - | PC | DevEco Studio 6.0.0 |
| 6.0.1 | - | - | DevEco Studio 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/804e082053524c47a43438d1ab942304/b6a17875746941e0b5606c9b1eb174f8?origin=template