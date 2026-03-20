# UCharts 可视化图表组件

## 简介

一款基于 TypeScript 的高性能跨平台数据可视化图表库。

## 详细介绍

### 简介

UCharts 是一款类型丰富、高性能、可扩展、支持主题定制的图表库，现已适配 HarmonyOS NEXT。支持多种常用图表类型，满足鸿蒙应用的数据可视化需求。

### 特性

- **模块化设计**：底层渲染与平台适配解耦，易于扩展和维护
- **TypeScript 全面支持**：类型安全，开发体验优秀
- **丰富图表类型**：柱状图、条状图、折线图、区域图、山峰图等
- **高性能渲染**：底层优化，动画流畅
- **易于扩展**：支持自定义图表类型和平台适配
- **自定义样式**：支持主题定制

### 支持的图表类型

- 柱状图 (column)
- 条状图 (bar)
- 折线图 (line)
- 区域图 (area)
- 山峰图 (mount)
- 散点图 (scatter)
- 气泡图 (bubble)
- 混合图 (mix)
- 饼状图 (pie)
- 环形图 (ring)
- 玫瑰图 (rose)
- 雷达图 (radar)
- 词云图 (word)
- 进度条 (arcbar)
- 仪表盘 (gauge)
- 漏斗图 (funnel)
- K 线图 (candle)
- 地图 (map)
- 更多类型持续开发中...

### 图表示例

以下为部分图表类型的 HarmonyOS 平台实际渲染效果：

- 柱状图
- 区域图
- 山峰图
- 散点图
- 气泡图
- 饼图
- 玫瑰图
- 雷达图
- K 线图
- 词云图
- 进度条
- 漏斗图

（更多类型和样式可参考 docs 目录）

## 下载安装

```bash
ohpm install @ibestservices/ucharts
```

## 快速开始

### 基础示例

```typescript
// 鸿蒙版
import { ChartOptions, UCharts, UChartsController } from '@ibestservices/ucharts'

@Entry
@Component
struct Index {
  @State chart: UChartsController = new UChartsController();
  private opts: Partial<ChartOptions> = {
    type: "column",
    categories: ["2018","2019","2020","2021","2022","2023"],
    series: [
      {
        name: "目标值",
        data: [35,36,31,33,13,34]
      },
      {
        name: "完成量",
        data: [18,27,21,24,6,28]
      }
    ],
    padding: [15,15,0,5],
    xAxis: {
      disableGrid: true
    },
    yAxis: {
      data: [{min: 0}]
    },
    extra: {
      column: {
        type: "group",
        width: 30,
        activeBgColor: "#000000",
        activeBgOpacity: 0.08
      }
    }
  }

  build() {
    Column(){
      UCharts({ controller: this.chart, onReady: () => {
          this.chart.updateData(this.opts)
      }})
      /*
       * 或者初始化时传入默认配置
       * @State chart: UChartsController = new UChartsController(this.opts);
       * UCharts({ controller: this.chart })
       * */
    }
    .height('100%')
    .width('100%')
  }
}
```

### 状态管理 V2

```typescript
import { UChartsV2, UChartsControllerV2 } from '@ibestservices/ucharts'

@Entry
@ComponentV2
struct Index {
  @Local chart: UChartsControllerV2 = new UChartsControllerV2(this.opts);
  build() {
    Column(){
      UChartsV2({ controller: this.chart })
    }
    .height('100%')
    .width('100%')
  }
}
```

## 适配说明

本库专为 HarmonyOS NEXT 平台适配，充分利用 HarmonyOS Canvas 绘图能力。
如需自定义扩展，可参考 adapters/platform/harmony 目录下的适配代码。

## 许可证

本项目采用 Apache License 2.0 开源协议。

- 允许自由使用、修改、分发和商业应用
- 需保留原始版权声明和许可证文件
- 详细条款请见根目录 LICENSE 文件

## 更新记录

### 1.1.0

**新增：**

- 支持区间条状图；
- 支持区间柱状图；
- ValueAndColorData 类型新增 start 字段，用于设置区间条状图和区间柱状图起始位置；

### 1.0.9

**新增：**

- 条状图支持自定义 Series 颜色；

**优化：**

- 图表数据更新时，自动关闭 ToolTip；

### 1.0.8

**新增：**

- 环形图、饼图、玫瑰图扩展配置新增 reverse 属性，支持逆时针渲染；
- legend 选项新增 legendShape 配置，如果 Series 中没有设置该属性，则判断尝试使用当前属性值；
- 新增 UChartsVersion 属性获取当前版本号；

**优化：**

- 删除 UChartsControllerV2，统一 UCharts 和 UChartsV2 的控制器；

**Bug 修复：**

- UChartsV2 宽高无效；

### 1.0.7

**Bug 修复：**

- categories 字段为文字数组第一次渲染不显示；

### 1.0.6

**优化：**

- X 轴 Y 轴改为可选配置；
- 饼图、圆环图等画布较小时的半径计算逻辑；
- 全局配置方法 setGlobalConfig 改为 setUChartsGlobalConfig；

**Bug 修复：**

- 横屏模式更新数据时渲染错误；
- 饼图、圆环图的数据存在多 0 值时渲染错误；

### 1.0.5

**新增：**

- 新增贡献热力图；
- 双指缩放，支持缩放的图表类型为 column, mount, line, area, mix, candle；

### 1.0.4

**新增：**

- 新增地图绘制；
- 增加组件 onTap 事件，返回点击图表位置的数据索引；
- 增加图表控制器 getCurrentDataIndex 方法，获取指定位置的数据索引；

**优化：**

- 将 ChartOptions 部分默认值的属性修改为可选；
- 增加组件 contentWidth 和 contentHeight 属性，不再需要外部强制限制高度；
- 所有图表的扩展配置改为可选；
- 在 ChartOptions 中增加 color 属性，不设置时使用全局配置；

**Bug 修复：**

- series 中的 data 属性 `[{ "value": 21, "color": "#EE6666" }, 24, 6, 28]`，color 值无效问题；
- 宽高尺寸变化或设备旋转时，图表没有重新自适应绘制；

### 1.0.3

**新增：**

- 进度条
- 仪表盘
- 漏斗图
- K 线图

### 1.0.2

**新增：**

- 雷达图
- 词云图
- 状态管理 V2 组件

### 1.0.1

**新增：**

- 饼状图
- 环形图
- 玫瑰图

### 1.0.0

初始发布，支持：

- 柱状图
- 山峰图
- 条状图
- 折线图
- 区域图
- 散点图
- 气泡图
- 混合图

## 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 (HarmonyOS 版本) | 5.0.5 |
| 应用类型 | 应用 |
| 元服务 | - |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 |

## 安装方式

```bash
ohpm install @ibestservices/ucharts
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/85a80f99fbd54a4f9d56d0a84251f344/PLATFORM?origin=template