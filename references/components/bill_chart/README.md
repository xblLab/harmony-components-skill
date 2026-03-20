# 账单图表组件

## 简介

本组件提供了 `BillBarChart`、`BillPieChart`、`BillRanking`、`BillReportTable`、`BillCalendar` 这五种形式的账单图表。

## 详细介绍

本组件提供以下几种形式的账单图表：

- **BillBarChart**：提供了根据传入数据，展示账单柱状图的能力。支持设置图表高度、颜色、标记样式等参数，支持自定义 UI 信息和交互逻辑。
- **BillPieChart**：提供了根据传入数据，展示饼图的能力。支持设置图表数据、颜色、字体样式、高度等参数，便于展示分类数据的占比关系。
- **BillRanking**：提供了根据传入数据，展示账单项金额排行榜的能力。支持设置颜色、数据、最大条目长度、标签样式等参数，支持处理条目点击事件。
- **BillReportTable**：提供了根据传入数据，展示报表表格的能力。支持设置表格数据、字体大小、颜色、排序方向等参数，便于展示账单的详细信息。
- **BillCalendar**：提供了根据传入数据，展示日历视图的能力。支持设置月份、卡片高度、背景颜色等参数，支持处理日期点击事件。

BillBarChart BillPieChart BillRanking BillReportTable BillCalendar

## 约束与限制

### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.2 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.2 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.2(14) 及以上

### 快速入门

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
b. 在项目根目录 `build-profile.json5` 添加 `bill_chart` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 bill_chart 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "bill_chart",
    "srcPath": "./XXX/bill_chart",
  }
]
```

在根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "bill_chart": "file:./XXX/bill_chart",
}
```

引入组件句柄。

```typescript
import { 
    BillBarChart,
    BillPieChart,
    BillRanking,
    BillReportTable,
    BillCalendar,
} from 'bill_chart';
```

调用组件，详见示例 1。详细参数配置说明参见 API 参考。

## API 参考

### BillBarChart(options?: BillBarChartOptions)

柱状图组件。

#### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | BillBarChartOptions | 否 | 配置柱状图组件的参数。 |

### BillPieChart(options?: BillPieChartOptions)

饼图组件。

#### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | BillPieChartOptions | 否 | 配置饼图组件的参数。 |

### BillRanking(options?: BillRankingOptions)

排行榜组件。

#### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | BillRankingOptions | 否 | 配置排行榜组件的参数。 |

### BillReportTable(options?: BillReportTableOptions)

报表表格组件。

#### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | BillReportTableOptions | 否 | 配置报表表格组件的参数。 |

### BillCalendar(options?: BillCalendarOptions)

日历组件。

#### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | BillCalendarOptions | 否 | 配置日历组件的参数。 |

### BillBarChartOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| chartData | BillBarChartData | 是 | 柱状图数据，必填字段 |
| chartHeightLength | number | 否 | 柱状图高度，默认值为 200 |
| initColor | number | 否 | 柱状图初始颜色，默认值为 0x8094B982 |
| highlightColor | number | 否 | 柱状图高亮颜色，默认值为 0x94B982 |
| markerColor | ResourceColor | 否 | 标记颜色，默认值为 #e6000000 |
| markerFontSize | Length | 否 | 标记字体大小，默认值为 12 |

### BillPieChartOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| chartData | BillPieChartItem[] | 否 | 饼图数据数组，默认值为空数组 [] |
| colorList | number[] | 否 | 饼图颜色列表，默认值为空数组 [] |
| valueColor | number | 否 | 数据值的颜色，默认值为 0x000000 |
| valueSize | number | 否 | 数据值的字体大小，默认值为 10 |
| labelColor | number | 否 | 数据标签的颜色，默认值为 0x000000 |
| labelSize | number | 否 | 数据标签的字体大小，默认值为 10 |
| valueLineColor | number | 否 | 数据值的连接线颜色，默认值为 0xd0d0d0 |
| chartHeightLength | number | 否 | 饼图的高度，默认值为 200 |

### BillRankingOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| colorList | number[] | 否 | 排行榜条目颜色列表，用于设置每个条目的颜色 |
| chartData | BillPieChartItem[] | 否 | 排行榜数据数组，用于展示排行榜的内容 |
| maxBarLength | number | 否 | 排行榜条目的最大长度，默认值为 180 |
| labelColor | ResourceColor | 否 | 排行榜标签的颜色，默认值为 #e6000000 |
| labelSize | Length | 否 | 排行榜标签的字体大小，默认值为 12 |
| handleClickBar | (resource: number) => void | 否 | 条目点击事件回调函数，接收点击的条目资源标识参数 |

### BillReportTableOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| tableData | ReportTableItem[] | 否 | 表格数据数组，默认值为空数组 [] |
| headerFontSize | Length | 否 | 表头字体大小，默认值为 16 |
| headerFontColor | ResourceColor | 否 | 表头字体颜色，默认值为 #e6000000 |
| contentFontSize | Length | 否 | 表格内容字体大小，默认值为 14 |
| contentFontColor | ResourceColor | 否 | 表格内容字体颜色，默认值为 #e6000000 |
| ascend | boolean | 否 | 是否按升序排序，默认值为 true |

### BillCalendarOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| month | string | 否 | 月份字符串，格式 YYYY-MM，默认值为 当前月份 |
| selectedDateSummary | CalendarBillSummaryModel | 否 | 选中日期的账单摘要，默认值为 new CalendarBillSummaryModel() |
| calendarHeight | Length | 否 | 日历视图的高度，默认值为 360 |
| bgColor | ResourceColor | 否 | 日历视图的背景颜色，默认值为 #ffffff |
| handleDateClick | (dateStr: string) => void | 否 | 日期点击事件回调函数，接收点击的日期字符串参数，格式为 YYYY-MM-DD |

### BillBarChartData 接口说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| data | BillBarItem[] | 是 | 账单数据数组 |
| month | string | 是 | 当前月份字符串 |

### BillBarItem 接口说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| date | string | 是 | 日期字符串，格式 YYYY-MM-DD |
| value | number | 是 | 对应的金额 |

### BillPieChartItem 接口说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| label | string | 是 | 数据项的标签 |
| value | number | 是 | 数据项的值 |
| resource | number | 是 | 数据项的资源标识 |

### ReportTableItem 接口说明

#### 字段说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| date | string | 是 | 日期字符串 |
| totalIncome | number | 是 | 当日总收入金额 |
| totalExpense | number | 是 | 当日总支出金额 |

### CalendarBillSummaryModel 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| date | string | 否 | 日期字符串，默认值为'' |
| totalExpense | number | 否 | 当日总支出金额，默认值为 0 |
| totalIncome | number | 否 | 当日总收入金额，默认值为 0 |

## 示例代码

### 示例 1（账单图表的显示与切换）

#### MockData.ets

```typescript
import { BillBarItem, BillPieChartItem, ReportTableItem } from 'bill_chart';

export const MOCK_BAR_CHART_LIST: BillBarItem[] = [
 {
   date: '05-01',
   value: 400.5,
 },
 {
   date: '05-05',
   value: 50.5,
 },
 {
   date: '05-09',
   value: 200,
 },
 {
   date: '05-24',
   value: 120,
 },
];

export const MOCK_BAR_CHART_LIST2: BillBarItem[] = [
 {
   date: '05-06',
   value: 100,
 },
 {
   date: '05-14',
   value: 198.9,
 },
 {
   date: '05-30',
   value: 3000,
 },
];

export const MOCK_COLOR_LIST: number[] = [
 0x638750, 0x7ea568, 0x94b982, 0xabd39c, 0xc6e5b9, 0xdff3d7, 0xf2fdee,
];

export const MOCK_COLOR_LIST2: number[] = [
 0xd77525, 0xf2992c, 0xfbb935, 0xffce52, 0xffe38e, 0xfff1ca, 0xfffbef,
];

export const MOCK_PIE_CHART_LIST: BillPieChartItem[] = [
 {
   label: '购物',
   value: 400.5,
   resource: 104,
 },
 {
   label: '交通',
   value: 50.5,
   resource: 102,
 },
 {
   label: '生活缴费',
   value: 200,
   resource: 109,
 },
];

export const MOCK_PIE_CHART_LIST2: BillPieChartItem[] = [
 {
   label: '工资',
   value: 3000,
   resource: 201,
 },
 {
   label: '理财',
   value: 200,
   resource: 202,
 },
];

export const MOCK_TABLE_DATA: ReportTableItem[] = [
 {
   date: '05-01',
   totalIncome: 0,
   totalExpense: 524,
 },
 {
   date: '05-04',
   totalIncome: 3000,
   totalExpense: 50.25,
 },
 {
   date: '05-09',
   totalIncome: 200.8,
   totalExpense: 1000,
 },
];
```

#### PreviewPage.ets

```typescript
import {
 MOCK_PIE_CHART_LIST,
 MOCK_PIE_CHART_LIST2,
 MOCK_BAR_CHART_LIST,
 MOCK_BAR_CHART_LIST2,
 MOCK_COLOR_LIST,
 MOCK_COLOR_LIST2,
 MOCK_TABLE_DATA,
} from './Mockdata';
import {
   BillPieChart,
   BillRanking,
   BillBarChart,
   BillReportTable,
   BillCalendar,
   BillBarChartData,
   CalendarBillSummaryModel
} from 'bill_chart';


@Entry
@ComponentV2
struct PreviewPage {
 @Local showChart: boolean = true;
 @Local isExpense: boolean = true;
 @Local summary: CalendarBillSummaryModel = new CalendarBillSummaryModel();

 @Computed
 get barData(): BillBarChartData {
   const list = this.isExpense ? MOCK_BAR_CHART_LIST : MOCK_BAR_CHART_LIST2;
   return {
     month: '2025-05',
     data: list,
   };
 }

 @Computed
 get barColor() {
   return this.isExpense ? 0x8094b982 : 0x80f2992c;
 }

 @Computed
 get colorList() {
   return this.isExpense ? MOCK_COLOR_LIST : MOCK_COLOR_LIST2;
 }

 @Computed
 get pieData() {
   return this.isExpense ? MOCK_PIE_CHART_LIST : MOCK_PIE_CHART_LIST2;
 }

 build() {
   Column({ space: 16 }) {
     Row() {
       Text(this.showChart ? '图表' : '日历').fontSize(18).fontWeight(FontWeight.Medium);
       Button('切换展示')
         .onClick(() => {
           this.showChart = !this.showChart;
         });
     }.width('100%').justifyContent(FlexAlign.SpaceBetween);

     if (this.showChart) {
       Row() {
         Radio({ value: 'Radio1', group: 'radioGroup' }).checked(true)
           .onChange((isChecked: boolean) => {
             this.isExpense = isChecked;
           });
         Text('支出');
         Blank().width(30);
         Radio({ value: 'Radio2', group: 'radioGroup' }).checked(false)
           .onChange((isChecked: boolean) => {
             this.isExpense = !isChecked;
           });
         Text('收入');
       };

       Scroll() {
         Column({ space: 16 }) {
           // 饼图
           BillPieChart({
             chartData: this.pieData,
             colorList: this.colorList,
           });
           // 账单列表图
           BillRanking({
             chartData: this.pieData,
             colorList: this.colorList,
           });
           //柱状图
           BillBarChart({
             chartData: this.barData,
             initColor: this.barColor,
           });
           // 报表
           BillReportTable({
             tableData: MOCK_TABLE_DATA,
           });
         };
       }
       .layoutWeight(1)
       .scrollBar(BarState.Off)
     } else {
       // 日历视图
       BillCalendar({
         selectedDateSummary: this.summary,
         handleDateClick: (date) => {
           this.summary.date = date;
         },
       });
     }
   }
   .padding(16);
 }
}
```

## 更新记录

### 1.0.1 (2025-12-15)
- 下载该版本

### 1.0.0 (2025-09-19)
- 下载该版本

### 初始版本
- 下载该版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策
不涉及

### SDK 合规使用指南
不涉及

## 兼容性

### HarmonyOS 版本

- 5.0.2
- 5.0.3
- 5.0.4
- 5.0.5
- 5.1.0
- 5.1.1
- 6.0.0
- 6.0.1

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEco Studio 版本

- DevEco Studio 5.0.2
- DevEco Studio 5.0.3
- DevEco Studio 5.0.4
- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0
- DevEco Studio 6.0.1

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/5a77f2e01a62415d86bb2d7d41c9d0c1/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%B4%A6%E5%8D%95%E5%9B%BE%E8%A1%A8%E7%BB%84%E4%BB%B6/bill_chart1.0.1.zip