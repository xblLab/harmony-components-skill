# hm Chart 图表绘制组件

## 简介

一个基于 echarts 原库进行二次封装适配，使其可以运行在 OpenHarmony，并沿用其现有用法和特性。

## 详细介绍

### 简介

一个基于 echarts 原库 v5.5.1 版本进行二次封装适配，使其可以运行在 OpenHarmony，并沿用其现有用法和特性。

### 使用

#### 静态数据示例演示

```typescript
import { hmChart, ChartOptions, hmChartType } from "@wuyan/hm_chart"

@Entry
@Component
struct Index {
  @State myChart: hmChartType | null = null
  @State Options: ChartOptions = {
    xAxis: {
      type: 'category',
      data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
    },
    yAxis: {
      type: 'value'
    },
    tooltip: {
      trigger: 'axis'
    },
    series: [
      {
        data: [820, 932, 901, 934, 1290, 1330, 1320],
        type: 'line',
        smooth: true
      }
    ]
  };

  build() {
    Column() {
      Column() {
        hmChart({ Options: this.Options, myChart: this.myChart })
      }.width('90%')
        .height('400')
    }
    .height('100%')
    .width('100%')
  }
}
```

#### 异步动态数据示例演示

```typescript
import { hmChart, ChartOptions, hmChartType } from "@wuyan/hm_chart"

@Entry
@Component
struct Index {
  @State myChart: hmChartType | null = null
  @State Options: ChartOptions = {
    xAxis: {
      type: 'category',
      data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
    },
    yAxis: {
      type: 'value'
    },
    tooltip: {
      trigger: 'axis'
    },
    series: [
      {
        data: [820, 932, 901, 934, 1290, 1330, 1320],
        type: 'line',
        smooth: true
      }
    ]
  };

  build() {
    Column() {
      Row() {
        Button('异步加载')
          .onClick(() => {
            const Options: ChartOptions = {
              xAxis: {
                type: 'category',
                data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
              },
              yAxis: {
                type: 'value'
              },
              series: [
                {
                  data: [0, 3, 901, 934, 1290, 1330, 1320],
                  type: 'line',
                  smooth: true
                }
              ]
            }
            if (this.myChart) {
              this.myChart.setOption(Options)
            }
          })
      }
      Column() {
        hmChart({ Options: this.Options, myChart: this.myChart })
      }.width('90%')
        .height('400')
    }
    .height('100%')
    .width('100%')
  }
}
```

#### 预览效果

## 许可证协议

Apache-2.0

## 更新记录

**2.0.4** (2025-10-30)

## 系统兼容性与权限

| 项目 | 说明 |
| :--- | :--- |
| **权限** | 暂无 |
| **隐私政策** | 不涉及 |
| **SDK 合规使用指南** | 不涉及 |
| **应用类型** | 应用 |
| **元服务** | 支持 |
| **设备类型** | 手机、平板、PC |
| **兼容性** | HarmonyOS 版本 5.0.0 |
| **DevEcoStudio 版本** | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @wuyan/hm_chart
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/622d9d34c0174d4fa41977c7732a5e10/PLATFORM?origin=template