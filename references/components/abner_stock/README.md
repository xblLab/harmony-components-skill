# 行情 K 线图 stock 组件

## 简介

stock 是一个只需要传递简单数据就可以实现行情 K 线图的组件，支持分时展示，支持日 K、月 K、年 K 等指标展示，可用于基金和股票等常见金融场景。

## 详细介绍

### 功能介绍

stock 是一个只需要传递简单数据就可以实现行情 K 线图的组件，支持分时展示，支持日 K、月 K、年 K 等指标展示，可用于基金和股票等常见金融场景。

### 环境要求

Api 适用版本：>=12

### 目前功能

1. 支持分时行情图数据展示。
2. 支持日 K/月 K/年 K 等指标展示。
3. 支持手势十字光标展示。
4. 支持分时/K 线自定义颜色。
5. 支持分时颜色填充。
6. 支持 K 线空心和实心蜡烛展示。

### 后续功能，逐步迭代开发中

1. 支持历史数据左滑查看
2. 支持五日分时行情

### 示例效果

（此处为示例效果图占位）

## 快速入门

### 方式一

在 Terminal 窗口中，执行如下命令安装三方包，DevEco Studio 会自动在工程的 oh-package.json5 中自动添加三方包依赖。

建议：在使用的模块路径下进行执行命令。

```bash
ohpm install @abner/stock
```

### 方式二

在需要的模块中的 oh-package.json5 中设置三方包依赖，配置示例如下：

```json5
"dependencies": { "@abner/stock": "^1.0.0"}
```

## 使用样例

### 简单使用

```typescript
StockChart({
  data: this.stockData // 数据，需要自己创建数据，可见下面的完整案例
}).width("100%")
  .height(300)
```

### 修改样式

```typescript
StockChart({
  data: this.stockData, // 数据，需要自己创建数据，可见下面的完整案例
  bgColor: Color.White, // 设置背景为白色
  onCrossHairAttr: (attr) => {
    attr.color = "#999999" // 修改十字光标颜色
  },
  onStockGridAttr: (attr) => {
    // 修改边框线灯属性
    attr.width = 1
    attr.color = "#e8e8e8"
    attr.borderColor = "#999999"
    attr.borderWidth = 1
  }
}).width("100%")
  .height(300)
```

### 修改纵向线

```typescript
StockChart({
  data: this.stockData, // 数据，需要自己创建数据，可见下面的完整案例
  onStockGridAttr: (attr) => {
    attr.verticalLineSize = 4 // 修改纵向线为 4 条
  },
  onAxisLabelsAttr: (attr) => {
    attr.xLabelSize = 4 // 底部标签改为 4 个
  }
}).width("100%")
  .height(300)
```

### 日 K 线

```typescript
StockChart({
  data: this.stockData, // 数据，需要自己创建数据，可见下面的完整案例
  stockType: StockType.day // 日 K
}).width("100%")
  .height(300)
```

### 月 K 线

```typescript
StockChart({
  data: this.stockData, // 数据，需要自己创建数据，可见下面的完整案例
  stockType: StockType.month // 月 K
}).width("100%")
  .height(300)
```

### 年 K 线

```typescript
StockChart({
  data: this.stockData, // 数据，需要自己创建数据，可见下面的完整案例
  stockType: StockType.year // 年 K
}).width("100%")
  .height(300)
```

## 完整案例

```typescript
import { StockChart, StockData, StockType } from '@abner/stock'
import { ActionBar } from '../../view/ActionBar'
import { StockHeaderView } from './StockHeaderView'

/**
 * AUTHOR:AbnerMing
 * DATE:2026/1/22
 * INTRODUCE:基金股票行情图
 */
@Entry
@ComponentV2
struct StockPage {
  @Local customPopup: boolean = false
  @Local title: string = "股票基金行情图"
  @Local clickPosition: number = 0
  private titleArray: string[] =
    ["默认分时行情", "修改样式", "修改纵向线", "日 K 线", "月 K 线", "年 K 线", "完整案例"]
  @Local stockData: StockData[] = []
  @Local stockType: StockType = StockType.time // 行情类型
  @Local openPrice: number = 4000 // 开盘价
  @Local currentPrice: number = this.openPrice // 现价
  @Local limit: string = "" // 涨跌幅
  @Local quota: number = 0 // 涨跌额
  @Local clickStockType: StockType = StockType.time // 行情类型

  aboutToAppear(): void {
    this.stockData = this.generateMockData()
  }

  build() {
    Column() {
      ActionBar({
        title: this.title, rightText: "切换", rightClick: () => {
          // 点击切换
          this.customPopup = !this.customPopup;
        }
      })
        .bindPopup(this.customPopup, {
          builder: this.popupBuilder,
          placement: Placement.TopRight,
          mask: { color: '#30000000' },
          popupColor: Color.White,
          enableArrow: true,
          radius: 10,
          // 设置气泡避让软键盘
          keyboardAvoidMode: KeyboardAvoidMode.DEFAULT,
          showInSubWindow: false,
          onStateChange: (e) => {
            if (!e.isVisible) {
              this.customPopup = false;
            }
          }
        })

      Column() {
        if (this.clickPosition == 0) {
          // 分时
          StockChart({
            data: this.stockData // 数据
          }).width("100%")
            .height(300)
        } else if (this.clickPosition == 1) {
          // 修改样式，可根据属性自行修改
          StockChart({
            data: this.stockData, // 数据
            bgColor: Color.White, // 设置背景为白色
            onCrossHairAttr: (attr) => {
              attr.color = "#999999" // 修改十字光标颜色
            },
            onStockGridAttr: (attr) => {
              // 修改边框线灯属性
              attr.width = 1
              attr.color = "#e8e8e8"
              attr.borderColor = "#999999"
              attr.borderWidth = 1
            }
          }).width("100%")
            .height(300)
        } else if (this.clickPosition == 2) {
          StockChart({
            data: this.stockData, // 数据
            onStockGridAttr: (attr) => {
              attr.verticalLineSize = 4 // 修改纵向线为 4 条
            },
            onAxisLabelsAttr: (attr) => {
              attr.xLabelSize = 4 // 底部标签改为 4 个
            }
          }).width("100%")
            .height(300)
        } else if (this.clickPosition == 3) {
          StockChart({
            data: this.stockData, // 数据
            stockType: StockType.day // 日 K
          }).width("100%")
            .height(300)
        } else if (this.clickPosition == 4) {
          StockChart({
            data: this.stockData, // 数据
            stockType: StockType.month // 月 K
          }).width("100%")
            .height(300)
        } else if (this.clickPosition == 5) {
          StockChart({
            data: this.stockData, // 数据
            stockType: StockType.year // 年 K
          }).width("100%")
            .height(300)
        } else if (this.clickPosition == 6) {
          // 完整案例
          Column() {
            StockHeaderView({
              openPrice: this.openPrice,
              currentPrice: this.currentPrice,
              limit: this.limit,
              quota: this.quota,
              onItemClick: (index) => {
                switch (index) {
                  case 0:
                    this.clickStockType = StockType.time
                    break
                  case 1:
                    this.clickStockType = StockType.day
                    break
                  case 2:
                    this.clickStockType = StockType.month
                    break
                  case 3:
                    this.clickStockType = StockType.year
                    break
                }
                if (index == 0) {
                  this.stockData = this.generateMockData()
                } else {
                  this.stockData = this.generateKMockData()
                }
              }
            })

            StockChart({
              data: this.stockData, // 数据
              stockType: this.clickStockType, // 默认分时
              onTouchType: (type) => {
                if (type == TouchType.Up) {
                  // 手指抬起就还原
                  this.currentPrice = this.openPrice
                }
              },
              onCrossHairAttr: (attr) => {
                attr.movePointEvent = (data: StockData, x: number, y: number) => {
                  this.currentPrice = data.price!! // 价格
                  this.limit = data.limit!! // 涨跌幅
                  this.quota = data.quota!! // 涨跌额
                }
              }
            }).width("100%")
              .height(300)

          }.width("100%")
            .height("100%")
            .backgroundColor("#0d1b2a")
        }
      }.layoutWeight(1)
        .justifyContent(FlexAlign.Center)

    }
    .width('100%')
      .height('100%')
  }

  @Builder
  popupBuilder() {
    Column() {
      ForEach(this.titleArray, (item: string, index: number) => {
        Text(item)
          .width("100%")
          .height(50)
          .textAlign(TextAlign.Center)
          .border({ width: { bottom: 1 }, color: $r("app.color.home_select_color") })
          .onClick(() => {
            this.title = item
            this.clickPosition = index
            this.customPopup = !this.customPopup
            // 切换日 K 线
            switch (index) {
              case 3: // 日 K
                this.stockType = StockType.day
                break
              case 4: // 月 K
                this.stockType = StockType.month
                break
              case 5: // 年 K
                this.stockType = StockType.year
                break
              default:
                this.stockType = StockType.time
                break
            }
            if (index > 2 && index < 6) {
              this.stockData = this.generateKMockData()
            } else {
              this.stockData = this.generateMockData()
            }

          })
      })

    }.width(130)
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:模拟分时数据
   */
  private generateMockData(): StockData[] {
    // 国内基金或者股票一般是上午 9:30 开盘，11:30 收盘，下午 13:00 开盘，15:00 收盘，一天总共交易 4 个小时
    // 按照 1 分钟一个点，那么总共 4*60，240 个点，这里是模拟，正常需要时时绘制点
    let sData: StockData[] = []
    const startTime = new Date();
    let date: Date = new Date();
    this.openPrice = 4000 // 开盘价
    let nowPrice: number = 0
    for (let i = 0; i < 241; i++) {
      if (i < 120) {
        startTime.setHours(9, 30, 0, 0);
        date = new Date(startTime.getTime() + i * 60000);
      } else {
        startTime.setHours(13, 0, 0, 0);
        date = new Date(startTime.getTime() + (i - 120) * 60000);
      }
      // 模拟数据
      const price = this.openPrice + Math.random() * 10 - 10 + Math.sin(i / 60) * 10;

      if (i == 0) {
        nowPrice = price
      }
      const change = price!! - nowPrice;
      const changePercent = (change / nowPrice) * 100;
      let limitContent = `${changePercent.toFixed(2)}%`
      if (i == 0) {
        this.limit = limitContent
        this.quota = change
      }
      sData.push({
        time: date,
        price: price,
        open: this.openPrice,
        limit: limitContent,
        quota: change
      })
    }
    return sData
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:模拟 K 线数据
   */
  private generateKMockData(): StockData[] {
    const data: StockData[] = [];
    this.openPrice = 4000 // 开盘价
    let date: Date = new Date();

    // K 线数据：开盘、收盘、最高、最低，日 K，模拟 30 日，月 K，模拟近 60 个月，年模拟近 20 年
    const periods = this.stockType == StockType.day ? 30 :
      this.stockType === StockType.month ? 60 : 20;

    let startDate = new Date();
    if (this.stockType == StockType.day) {
      startDate.setDate(startDate.getDate() - periods);
    }
    if (this.stockType == StockType.month) {
      startDate.setMonth(startDate.getMonth() - periods);
    }
    if (this.stockType == StockType.year) {
      startDate.setFullYear(startDate.getFullYear() - periods);
    }

    let previousDayClose = 0 // 上一天
    for (let i = 0; i < periods; i++) {

      if (this.stockType == StockType.day) {
        date = new Date(startDate.getTime() + i * 24 * 60 * 60 * 1000);
      }
      if (this.stockType == StockType.month) {
        date = new Date(startDate.getTime() + i * 24 * 60 * 60 * 1000 * 30);
      }
      if (this.stockType == StockType.year) {
        date = new Date(startDate.getTime() + i * 24 * 60 * 60 * 1000 * 30 * 12);
      }

      const open = this.openPrice + Math.random() * 200 - 100;
      const close = open + Math.random() * 100 - 50;
      const high = Math.max(open, close) + Math.random() * 50;
      const low = Math.min(open, close) - Math.random() * 50
      // 振幅 (%) = [ (当日最高价 - 当日最低价) / 前一日收盘价 ] × 100%
      // 当日涨跌额 = 当日收盘价 - 前一日收盘价
      let limitContent = (high - low) / previousDayClose * 100 // 振幅
      let currentPrice = close - previousDayClose // 涨跌额
      if (i == 0) {
        this.limit = `0%`
        this.quota = 0
      }
      let limit = `${limitContent.toFixed(2)}%`
      if (currentPrice < 0) {
        limit = "-" + limit
      }
      data.push({
        time: new Date(date),
        open: open,
        close: close,
        high: high,
        low: low,
        price: close,
        limit: limit,
        quota: currentPrice,
      });
      previousDayClose = close
      this.openPrice = close;
      if (this.stockType == StockType.month) {
        date.setMonth(date.getMonth() + 1);
      }
      if (this.stockType == StockType.year) {
        date.setMonth(date.getMonth() + 1);
      }
    }
    return data;
  }
}
```

## 完整案例中的头组件：StockHeaderView

```typescript
/**
 * AUTHOR:AbnerMing
 * DATE:2026/1/27
 * INTRODUCE:k 线图案例头 View，所有数据均为模拟数据
 */
@ComponentV2
export struct StockHeaderView {
  @Param openPrice: number = 4000 // 开盘价
  @Param currentPrice: number = this.openPrice // 现价
  @Param limit: string = "" // 涨跌幅
  @Param quota: number = 0 // 涨跌额
  private tabArray: string[] = ["分时", "日 K", "月 K", "年 K"]
  @Local private clickPosition: number = 0
  @Param onItemClick?: (index: number) => void = undefined

  private getTextColor(): ResourceColor {
    if (this.quota == 0) {
      return Color.Gray
    } else if (this.quota > 0) {
      return Color.Red
    }
    return Color.Green
  }

  build() {
    Column() {
      Row() {
        Column() {
          Text(this.currentPrice != undefined ? this.currentPrice.toFixed(2) : "")
            .fontSize(28)
            .fontColor(this.getTextColor())
            .fontWeight(FontWeight.Bold)
          Row() {
            Text(this.limit)
              .fontSize(11)
              .fontColor(this.getTextColor())
            Text(this.quota.toFixed(2))
              .fontSize(11)
              .fontColor(this.getTextColor())
          }.margin({ top: 5 })
          .width(80)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .alignItems(HorizontalAlign.Start)

        Column() {
          Row() {
            Row() {
              Text("今开")
                .fontSize(14)
                .fontColor(Color.White)
              Text(this.openPrice != undefined ? this.openPrice.toFixed(2) : "")
                .fontSize(14)
                .fontColor(Color.White)
            }.layoutWeight(1)
            .justifyContent(FlexAlign.SpaceBetween)

            Row() {
              Text("最高")
                .fontSize(14)
                .fontColor(Color.White)
              Text("4100")
                .fontSize(14)
                .fontColor(Color.White)
            }.layoutWeight(1)
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ left: 10 })

            Row() {
              Text("最低")
                .fontSize(14)
                .fontColor(Color.White)
              Text("3980")
                .fontSize(14)
                .fontColor(Color.White)
            }.layoutWeight(1)
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ left: 10 })
          }.width("100%")

          Row() {
            Row() {
              Text("换手")
                .fontColor(Color.White)
                .fontSize(14)
              Text("3.77%")
                .fontSize(14)
                .fontColor(Color.White)
            }.layoutWeight(1)
            .justifyContent(FlexAlign.SpaceBetween)

            Row() {
              Text("总手")
                .fontSize(14)
                .fontColor(Color.White)
              Text("20 万手")
                .fontSize(14)
                .fontColor(Color.White)
            }.layoutWeight(1)
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ left: 10 })

            Row() {
              Text("金额")
                .fontSize(14)
                .fontColor(Color.White)
              Text("2000 亿")
                .fontSize(14)
                .fontColor(Color.White)
            }.layoutWeight(1)
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ left: 10 })

          }.width("100%")
          .margin({ top: 10 })

        }.layoutWeight(1)
        .margin({ left: 10 })
      }.width("100%")

      Row() {
        Text() {
          Span("总值  ")
            .fontSize(14)

          Span("40 万亿")
            .fontSize(14)
        }.fontColor(Color.White)

        Text() {
          Span("流值  ")
            .fontSize(14)
          Span("36 万亿")
            .fontSize(14)
        }.margin({ left: 10 })
        .fontColor(Color.White)

        Text() {
          Span("市盈  ")
            .fontSize(14)
          Span("2000")
            .fontSize(14)
        }.margin({ left: 10 })
        .fontColor(Color.White)

      }.width("100%")
      .margin({ top: 10 })

      Row() {
        ForEach(this.tabArray, (text: string, index: number) => {
          Column() {
            Text(text)
              .fontColor(this.clickPosition == index ? "#ff0e98f5" : Color.White)
              .fontSize(14)
            Divider()
              .lineCap(LineCapStyle.Round)
              .height(2)
              .width(20)
              .visibility(this.clickPosition == index ? Visibility.Visible : Visibility.Hidden)
              .backgroundColor("#ff0e98f5")
              .margin({ top: 5 })
          }.margin({ right: 20 })
          .onClick(() => {
            this.clickPosition = index
            if (this.onItemClick != undefined) {
              this.onItemClick(index)
            }
          })

        })
      }.width("100%")
      .height(20)
      .margin({ top: 10 })
      .alignItems(VerticalAlign.Center)

    }.width("100%")
    .margin({ bottom: 20 })
    .padding({ left: 10, right: 10 })
  }
}
```

## API 说明

Api 适用版本：>=12

### 配置说明

常见属性配置如下：

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| stockType | StockType | 行情类型，默认是 StockType.time，分时 |
| sPadding | SPadding | 行情组件内边距，也就是距离左上右下的距离 |
| data | StockData[] | 行情数据 |
| bgColor | string/number/CanvasGradient/CanvasPattern | 组件的背景颜色 |
| onStockGridAttr | (stockGridAttr: StockGridAttr) => void | 边框属性 |
| onAxisLabelsAttr | (axisLabelsAttr: AxisLabelsAttr) | 坐标轴属性 |
| onCrossHairAttr | (crossHairAttr: CrossHairAttr) => void | 十字光标属性 |
| onStockLineAttr | (stockLineAttr: StockLineAttr) => void | 分时 K 线属性 |
| onTouchType | (type: TouchType) => void | 手势移动属性 |

### StockGridAttr

网格线属性

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| show | boolean | 是否显示网格样式，默认 true 显示 |
| color | string/number/CanvasGradient/CanvasPattern | 网格线颜色 |
| width | number | 网格线宽度 |
| isDottedLine | boolean | 是否是虚线 |
| lineDash | number[] | 虚线样式 |
| showVerticalLine | boolean | 是否显示垂直线，默认为 true 显示 |
| showHorizontalLine | boolean | 是否显示水平线，默认为 true 显示 |
| borderColor | string/number/CanvasGradient/CanvasPattern | 网格边框线颜色 |
| borderWidth | number | 网格边框线大小 |
| verticalLineSize | number | 垂直线数量，默认 2 |
| horizontalLineSize | number | 水平线数量，默认 5 |

### AxisLabelsAttr

坐标轴属性

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| show | boolean | 是否显示坐标轴，默认 true 显示 |
| color | string/number/CanvasGradient/CanvasPattern | 坐标轴颜色 |
| fontSize | number | 坐标轴标签文字大小 |
| xLabelSize | number | X 轴标签数量，默认 2 个 |
| yLabelSize | number | Y 轴标签数量，默认 5 个 |
| xLabelMarginTop | number | x 标签距离顶部 |
| yLabelMarginLeft | number | y 标签距离顶部 |
| timeType | TimeType | x 轴时间展示类型 |

### CrossHairAttr

十字光标属性

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| show | boolean | 是否显示十字光标，默认 true 显示 |
| color | string/number/CanvasGradient/CanvasPattern | 十字光标颜色 |
| width | number | 十字光标宽度 |
| isDottedLine | boolean | 是否是虚线 |
| dash | number[] | 虚线样式 |
| movePointEvent | (data: StockData, x: number, y: number) => void | 手势移动事件回调 |
| showPointData | boolean | 十字光标移动时是否展示信息框数据 |
| pointDataColor | string/number/CanvasGradient/CanvasPattern | 信息框数据文字颜色 |
| pointDataSize | number | 信息框数据文字大小 |
| pointDataBorderColor | string/number/CanvasGradient/CanvasPattern | 信息框颜色 |
| pointDataBorderWidth | number | 信息框宽度 |

### StockLineAttr

行情 K 线属性

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| color | string/number/CanvasGradient/CanvasPattern | 行情线的颜色 |
| width | number | 行情线宽度 |
| showFillBg | boolean | 是否显示分时填充背景，默认 true 显示 |
| isGradient | boolean | 是否是渐变，默认为 true 是 |
| gradientStartColor | string | 渐变开始颜色 |
| gradientStopColor | string | 渐变结束颜色 |
| fillColor | string/number/CanvasGradient/CanvasPattern | 填充背景颜色，isGradient 为 false 时使用 |
| candleStyle | CandleStyle | 行情 K 线条蜡烛是实体还是空心 |
| candleWidth | number | 行情 K 线大小 |
| upColor | string/number/CanvasGradient/CanvasPattern | 上涨颜色 |
| downColor | string/number/CanvasGradient/CanvasPattern | 下跌颜色 |
| flatColor | string/number/CanvasGradient/CanvasPattern | 收平颜色 |
| showCurrentPriceLine | boolean | 是否显示当前价格线，默认显示，分时显示 |
| currentPriceLineUpColor | string/number/CanvasGradient/CanvasPattern | 价格线上涨颜色 |
| currentPriceLineFlatColor | string/number/CanvasGradient/CanvasPattern | 价格线收平颜色 |
| currentPriceLineDownColor | string/number/CanvasGradient/CanvasPattern | 价格线下跌颜色 |
| isCurrentPriceLineDash | boolean | 当前价格线是否是虚线，默认是 |
| currentPriceLineDash | number[] | 价格线虚线样式 |

### 权限要求

无权限要求。

### 技术支持

在 Github 中的 Issues 中提问题，定期解答。

### 开源许可协议

该代码经过 Apache 2.0 授权许可。

### 更新记录

**1.0.0 (2026-01-28)**

1. 支持分时行情图数据展示。
2. 支持日 K/月 K/年 K 等指标展示。
3. 支持手势十字光标展示。
4. 支持分时/K 线自定义颜色。
5. 支持分时颜色填充。
6. 支持 K 线空心和实心蜡烛展示。

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无权限 | 无权限 | 无权限 | 无权限 |

### 隐私政策

不涉及 SDK 合规使用指南 不涉及

### 兼容性

| HarmonyOS 版本 | 应用类型 | 设备类型 | DevEco Studio 版本 |
| :--- | :--- | :--- | :--- |
| 5.0.5 | 应用 | 手机 | Created with Pixso. |
| 5.1.0 | 元服务 | 平板 | Created with Pixso. |
| 5.1.1 | | PC | Created with Pixso. |
| 6.0.0 | | | DevEco Studio 5.1.0 |
| 6.0.1 | | | DevEco Studio 5.1.1 |
| 6.0.2 | | | DevEco Studio 6.0.0 |
| | | | DevEco Studio 6.0.1 |
| | | | DevEco Studio 6.0.2 |

## 安装方式

```bash
ohpm install @abner/stock
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/d70400ae9ee2456aa6059495cb83b87e/b6a17875746941e0b5606c9b1eb174f8?origin=template