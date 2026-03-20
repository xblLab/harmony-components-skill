# 饼状图组件

## 简介

pie 是一个简单的饼状图表组件，只为饼状图服务！只需要简单的配置，便可以实现一个饼状图，支持内外标注，圆环，点击，动画等效果。

## 详细介绍

### 功能介绍

pie 是一个简单的饼状图表组件，只为饼状图服务！只需要简单的配置，便可以实现一个饼状图，支持内外标注，圆环，点击，动画等效果。

### 环境要求

Api 适用版本：>=12

### 目前功能

1. 支持普通的饼状图表展示。
2. 支持饼状图点击。
3. 支持饼状图圆环形式。
4. 支持外部折线标注。
5. 支持动画形式进入。

### 示例效果

**静态效果**

**动态效果**

### 快速入门

#### 方式一

在 Terminal 窗口中，执行如下命令安装三方包，DevEco Studio 会自动在工程的 oh-package.json5 中自动添加三方包依赖。

建议：在使用的模块路径下进行执行命令。

```bash
ohpm install @abner/pie
```

#### 方式二

在需要的模块中的 oh-package.json5 中设置三方包依赖，配置示例如下：

```json5
"dependencies": { "@abner/pie": "^1.0.0"}
```

### 使用样例

#### 准备好数据

```typescript
private chartData: PieChartData[] = [
    { label: "类别 A", value: 30, color: "#3498db" },
    { label: "类别 B", value: 20, color: "#e74c3c" },
    { label: "类别 C", value: 25, color: "#2ecc71" },
    { label: "类别 D", value: 15, color: "#f39c12" },
    { label: "类别 E", value: 10, color: "#9b59b6" }
];
```

#### 简单使用

```typescript
PieChartView({
  chartData: this.chartData,
  textColor: Color.White
}).height(200)
```

#### 外部标注

```typescript
PieChartView({
  chartData: this.chartData,
  radius: 80, // 饼状图半径
  chartType: PieChartType.external // 外部标注
}).height(220)
```

#### 外部折线标注

```typescript
PieChartView({
  chartData: this.chartData,
  radius: 80, // 饼状图半径
  chartType: PieChartType.polyline // 外部折线标注
}).height(220)
```

#### 点击交互

```typescript
PieChartView({
  chartData: this.chartData,
  radius: 80, // 饼状图半径
  chartType: PieChartType.clickInteraction // 可点击交互
}).height(220)
```

#### 圆环设置

```typescript
PieChartView({
  chartData: this.chartData,
  radius: 80, // 饼状图半径
  chartType: PieChartType.ring // 圆环
}).height(220)
```

#### 圆环点击交互

```typescript
PieChartView({
  chartData: this.chartData,
  radius: 50, // 饼状图半径
  chartType: PieChartType.ringClick // 圆环点击交互
}).height(220)
```

#### 左侧标注

```typescript
Row() {
  Column() {
    ForEach(this.chartData, (item: PieChartData) => {
      Row() {
        Circle()
          .width(10)
          .height(10)
          .fill("" + item.color)
          .borderRadius(10)
        Text(item.label)
          .margin({ left: 5 })
          .fontColor($r("app.color.title_color"))
      }.margin({ bottom: 5 })
    })
  }.margin({ right: 10 })

  PieChartView({
    chartData: this.chartData,
    textColor: Color.White
  }).height(200)
    .width(200)
}
```

#### 顶部标注

```typescript
Column() {
  Row() {
    ForEach(this.chartData, (item: PieChartData) => {
      Row() {
        Circle()
          .width(10)
          .height(10)
          .fill("" + item.color)
          .borderRadius(10)
        Text(item.label)
          .margin({ left: 5 })
          .fontColor($r("app.color.title_color"))
      }.margin({ right: 5 })
    })
  }.margin({ bottom: 10 })

  PieChartView({
    chartData: this.chartData,
    textColor: Color.White
  }).height(200)
    .width(200)
}
```

#### 点击提示

```typescript
Column() {
  Row() {
    ForEach(this.chartData, (item: PieChartData) => {
      Row() {
        Circle()
          .width(10)
          .height(10)
          .fill("" + item.color)
          .borderRadius(10)
        Text(item.label)
          .margin({ left: 5 })
          .fontColor($r("app.color.title_color"))
      }.margin({ right: 5 })
    })
  }.margin({ bottom: 10 })

  Stack() {
    PieChartView({
      chartData: this.chartData,
      textColor: Color.White,
      isAllowClick: true,
      onItemClick: (position) => {
        this.tempPieChartData = this.chartData[position]
        clearTimeout(this.tempPieChartTimeout)
        this.tempPieChartTimeout = setTimeout(() => {
          this.tempPieChartData = undefined
        }, 2000)
      }
    }).height(200)
      .width(200)

    Row() {
      Circle()
        .width(10)
        .height(10)
        .fill("" + this.tempPieChartData?.color)
        .borderRadius(10)
      Text(this.tempPieChartData?.label)
        .margin({ left: 5 })
        .fontColor(Color.White)
    }.backgroundColor("#80000000")
      .padding(10)
      .borderRadius(3)
      .visibility(this.tempPieChartData != undefined ? Visibility.Visible : Visibility.None)
  }
}
```

#### 动画进入

```typescript
PieChartView({
  chartData: this.chartData,
  radius: 80, // 饼状图半径
  chartType: PieChartType.animation, // 动画进入
  pieChartControl: this.pieChartControl,
  animateTime: 50
}).height(220)
  .margin({ top: 10 })
```

### API 说明

Api 适用版本：>=12

#### 配置说明

常见属性配置如下：

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| chartData | PieChartData | 饼状图数据源 |
| strokeStyle | string/number/CanvasGradient/CanvasPattern | 扇形边框颜色，默认白色 |
| strokeWidth | number | 扇形边框大小 |
| textColor | string/number/CanvasGradient/CanvasPattern | 文本颜色，默认黑色 |
| textAlign | CanvasTextAlign | 文本横向对齐方式，默认 center |
| textBaseline | CanvasTextBaseline | 文本纵向对齐方式，默认 middle |
| textSize | number | 文本大小 |
| radius | number | 饼状图半径 |
| chartType | PieChartType | 饼状图展示类型 |
| externalLineColor | string/number/CanvasGradient/CanvasPattern | 外部折线颜色 |
| externalLineWidth | number | 外部折线大小 |
| externalLineRadius | number | 外部折线半径大小 |
| externalLineLeftTextAlign | CanvasTextAlign | 外部折线文本左半边对齐方式 |
| externalLineRightTextAlign | CanvasTextAlign | 外部折线文本右半边对齐方式 |
| polylineColor | string/number/CanvasGradient/CanvasPattern | 外部双折线折线颜色 |
| polylineWidth | number | 外部双折线大小 |
| polylineRadius | number | 外部双折线半径大小 |
| polylineDoubleRadius | number | 外部第二条线半径大小 |
| maxAnimationProgress | number | 最大放大，默认为 1 |
| ringLineColor | string/number/CanvasGradient/CanvasPattern | 圆环线颜色 |
| ringLineWidth | number | 圆环线大小 |
| ringWidth | number | 圆环宽度 |
| ringLineRadius | number | 圆环线半径大小 |
| ringLineLeftTextAlign | CanvasTextAlign | 外部折线文本左半边对齐方式 |
| ringLineRightTextAlign | CanvasTextAlign | 外部折线文本右半边对齐方式 |
| animateTime | number | 展开动画时间，默认 10 毫秒 |
| pieChartControl | PieChartControl | 饼状图控制器，可以控制动画重新展开 |
| onItemClick | (position: number) => void | 块状点击回调 |
| isAllowClick | boolean | 是否允许点击 |

#### PieChartData

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| label | string | 饼状图数据源 |
| value | number | 饼状百分比 |
| color | string/number/CanvasGradient/CanvasPattern | 饼状图颜色 |

### 权限要求

无权限要求

### 技术支持

在 Github 中的 Issues 中提问题，定期解答。

### 开源许可协议

该代码经过 Apache 2.0 授权许可。

### 更新记录

1.0.0 (2026-01-19)
1. 饼状图表组件首次提交。
2. 支持圆环和圆两种类型。
3. 支持饼状图条目点击。
4. 支持饼状图动画进入。

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无权限 | 无权限 | 无权限 |

### 隐私政策

| 项目 | 内容 |
| :--- | :--- |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 版本/信息 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.5 (Created with Pixso.) |
| HarmonyOS 版本 | 5.1.0 (Created with Pixso.) |
| HarmonyOS 版本 | 5.1.1 (Created with Pixso.) |
| HarmonyOS 版本 | 6.0.0 (Created with Pixso.) |
| HarmonyOS 版本 | 6.0.1 (Created with Pixso.) |
| 应用类型 | 应用 (Created with Pixso.) |
| 元服务 | 元服务 (Created with Pixso.) |
| 设备类型 | 手机 (Created with Pixso.) |
| 设备类型 | 平板 (Created with Pixso.) |
| 设备类型 | PC (Created with Pixso.) |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 (Created with Pixso.) |
| DevEcoStudio 版本 | DevEco Studio 5.1.0 (Created with Pixso.) |
| DevEcoStudio 版本 | DevEco Studio 5.1.1 (Created with Pixso.) |
| DevEcoStudio 版本 | DevEco Studio 6.0.0 (Created with Pixso.) |
| DevEcoStudio 版本 | DevEco Studio 6.0.1 (Created with Pixso.) |

## 安装方式

```bash
ohpm install @abner/pie
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c04297b021b6424c8ef21add8038000c/b6a17875746941e0b5606c9b1eb174f8?origin=template