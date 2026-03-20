# Calendar 自定义日历视图组件

## 简介

自定义日历视图组件，支持单天、周、多项选择。

## 详细介绍

### 简介

Calendar，是一个基于 open harmony 基础组件开发的月视图选择器组件，包含单日期选择、周日期选择、多日期选择和时间段选择的功能，让用户快捷选择日期。

### 下载安装

```bash
ohpm install @mlethe/calendar
```

1. 模块 `oh-package.json5` 文件中引入依赖：

```json5
{
 "dependencies": {
   "@mlethe/calendar": "version"
 }
}
```

### 属性 (接口) 说明

**MonthCalendar 组件属性**

| 属性 | 类型 | 释义 | 默认值 |
| :--- | :--- | :--- | :--- |
| paddingLeft | number | 月视图的左边内边距。 | 0 |
| paddingRight | number | 月视图的右边内边距。 | 0 |
| weekBarHeight | number | 星期栏的高度。 | 40 |
| weekBarBgColor | Resource Color | 星期栏的背景颜色。 | - |
| weekBarTextColor | Resource Color | 星期栏的文字颜色。 | - |
| weekBarTextSize | number | 星期栏的文字大小。 | 14 |
| weekBarEndTextColor | Resource Color | 星期栏周末文字颜色。 | - |
| weekBarEndTextSize | number | 星期栏周末文字大小。 | 14 |
| monthItemHeight | number | 月视图 item 的高度。 | 45 |
| minYear | number | 显示时间的范围的最小年。 | 1900 |
| minMonth | number | 显示时间的范围的最小月，范围【1-12】。 | 1 |
| maxYear | number | 显示时间的范围的最大年，默认为当前年加 100 年。 | - |
| maxMonth | number | 显示时间的范围的最大月，范围【1-12】。 | 12 |
| monthViewItem | MonthViewItem | 月视图子项绘制，自定义月视图 item 的样式。 | - |
| schemeDatesMap | HashMap<string, Calendar> | 标记的数据。 | - |
| schemeThemeColor | number | 标记的主题色。 | - |
| weekStart | WeekStartType | 星期栏开始类型。 | - |
| monthViewShowMode | MonthShowMode | 月视图显示模式。 | - |
| monthSelectMode | MonthSelectMode | 时间选择模式，单日期选择、周日期选择、多日期选择和时间段选择模式，默认是单日期选择 | - |
| monthStartDay | number | 月起始日，每月开始的天，范围【1-31】。 | 1 |
| daySelectMode | MonthShowMode | 默认天的选择模式（单日期选择模式生效）。 | - |
| selectedCalendar | Calendar | 单日期选择的选中的日期，默认为当天。 | - |
| multiSelectedArray | Array<Calendar> | 多日期选择的选中的日期。 | - |
| startSelectedCalendar | Calendar | 周日期选择和时间段选择的选中的开始日期。 | - |
| endSelectedCalendar | Calendar | 周日期选择和时间段选择的选中的结束日期。 | - |
| onSelected | `(calendar: Calendar, isClick: boolean) => void` | 日历选中回调（单日期选择、多日期选择），calendar 选中的日期，isClick 是否为点击选中。 | - |
| onRangeSelected | `(calendar: Calendar, isEnd: boolean) => void` | 日历范围选择的回调，calendar 选中的日期，isEnd 是否为选择结束。 | - |
| onWeekSelected | `(startCalendar: Calendar, endCalendar: Calendar, isClick: boolean) => void` | 日历周选择的回调，startCalendar 选中周的开始日期，endCalendar 选中周的结束日期，isEnd 是否为点击选中。 | - |
| onSelectOutOfRange | `(calendar: Calendar) => void` | 日历选择超出范围回调，calendar 选中的日期。 | - |
| onScrolledOutRangeFirstPage | `() => void` | 滑动超出范围，已滑动到第一页。 | - |
| onScrolledOutRangeLastPage | `() => void` | 滑动超出范围，已滑动到最后一页。 | - |
| onMonthChanged | `(year: number, month: number) => void` | 月份切换回调。 | - |
| onControllerAttached | `() => void` | 当控制器绑定到 MonthCalendar 组件时触发，此控制器必须是 MonthCalendarController。 | - |

### WeekStartType 枚举

| 名称 | 说明 |
| :--- | :--- |
| SUNDAY | 周日 |
| MONDAY | 周一 |
| SATURDAY | 周六 |

### MonthShowMode 枚举

| 名称 | 说明 |
| :--- | :--- |
| ALL_MONTH | 全部显示 |
| ONLY_CURRENT_MONTH | 仅显示当前月份 |
| FIT_MONTH | 自适应显示，不会多出一行，但是会自动填充 |

### MonthSelectMode 枚举

| 名称 | 说明 |
| :--- | :--- |
| SINGLE_DAY | 单日选择 |
| WEEK | 周选择 |
| RANGE_DAY | 范围日期选择 |
| MULTIPLE_DAY | 多日期选择 |

### MonthCalendarController 控制器的方法

| 名称 | 类型 | 说明 |
| :--- | :--- | :--- |
| setMonthStartDay(day: number): boolean | function | 设置月起始日，day 起始日，范围【1-31】，return 是否设置成功。 |
| setWeekStart(weekStart: WeekStartType) => void | function | 设置周起始日。 |
| setMonthShowMode(showMode: MonthShowMode) => void | function | 设置月视图显示模式。 |
| setRange(minYear: number, minYearMonth: number, maxYear: number, maxYearMonth: number) => void | function | 设置日历范围 |
| setSchemeDate(schemeMap: HashMap<string, Calendar>) => void | function | 设置标记日期数据 |
| addSchemeDate(calendar: Calendar) => void | function | 添加事物标记 |
| addSchemeDates(schemeMap: HashMap<string, Calendar>) => void | function | 批量添加事物标记 |
| clearSchemeDate() => void | function | 清空日期标记 |
| scrollToCalendar(year: number, month: number, day?: number, useAnimation?: boolean): boolean | function | 滚动到指定天，useAnimation 是否使用动画，默认使用动画 ,return 是否切换成功，true 切换成功，false 未切换 |
| scrollToMonth(year: number, month: number, useAnimation?: boolean): boolean | function | 滚动到指定月，useAnimation 是否使用动画，默认使用动画 ,return 是否切换成功，true 切换成功，false 未切换 |
| scrollTo(num: number, useAnimation?: boolean): boolean | function | 滚动几个月，num 滚动的数量，正数向后滚，负数向前滚，useAnimation 是否使用动画，默认使用动画 ,return 是否切换成功，true 切换成功，false 未切换 |
| scrollToPre(useAnimation?: boolean): boolean | function | 滚动到上一个月，useAnimation 是否使用动画，默认使用动画 ,return 是否切换成功，true 切换成功，false 未切换 |
| scrollToNext(useAnimation?: boolean): boolean | function | 滚动到下一个月，useAnimation 是否使用动画，默认使用动画 ,return 是否切换成功，true 切换成功，false 未切换 |
| scrollToCurrent(useAnimation?: boolean): boolean | function | 滚动到当前日期，useAnimation 是否使用动画，默认使用动画 ,return 是否切换成功，true 切换成功，false 未切换 |
| scrollToSelectCalendar(useAnimation?: boolean): boolean | function | 滚动到选择的日期，useAnimation 是否使用动画，默认使用动画 ,return 是否切换成功，true 切换成功，false 未切换 |
| setMultiSelectedCalendar(calendars: Array) => void | function | 设置多项选中的日期 |
| setRangeSelectedCalendar(startSelected?: Calendar, endSelected?: Calendar) => void | function | 设置范围选中的日期 |
| setCurrentTime(time: number, timeZone?: string) => void | function | 设置当前时间，time 时间戳，timeZone 时区 |

### MonthViewItem 类（继承 MonthViewItem 实现自定义月视图）

```typescript
/**
* 日历重绘方法（不要在 onDrawSelected()、onDrawScheme()、onDrawText() 中调用，容易导致死循环，建议不要频繁调用）
*/
invalidate = () => {
}

/**
* 挂载到组件时执行
*/
abstract aboutToAppear(context: Context): void;

/**
* 析构销毁时执行
*/
abstract aboutToDisappear(): void;

/**
* 绘制选中的日期
*
* @param canvas          canvas
* @param calendar        日历日历 calendar
* @param x               日历 Card x 起点坐标
* @param y               日历 Card y 起点坐标
* @param itemWidth       item 的宽度
* @param itemHeight      item 的高度
* @param hasScheme       hasScheme 非标记的日期
* @param isSelectedPre   前一个是否选中
* @param isSelectedNext  后一个是否选中
* @return 是否绘制 onDrawScheme，true or false，true 调用 onDrawScheme() 方法，false 不调用 onDrawScheme() 方法
*/
abstract onDrawSelected(canvas: CanvasRenderingContext2D, calendar: Calendar, x: number, y: number, itemWidth: number,
itemHeight: number, hasScheme: boolean, isSelectedPre: boolean, isSelectedNext: boolean): boolean;

/**
* 绘制标记的日期，这里可以是背景色，标记色什么的
*
* @param canvas      canvas
* @param calendar    日历 calendar
* @param x           日历 Card x 起点坐标
* @param y           日历 Card y 起点坐标
* @param itemWidth   item 的宽度
* @param itemHeight  item 的高度
* @param schemeColor 标记的颜色
*/
abstract onDrawScheme(canvas: CanvasRenderingContext2D, calendar: Calendar, x: number, y: number, itemWidth: number,
itemHeight: number, schemeColor: number): void;

/**
* 绘制日历文本
*
* 填充颜色
* canvas.fillStyle = 0x50CFCFCF;
* 文字大小和字体设置
* canvas.font = `14vp sans-serif`;
* 文字绘制方式：start|end|left||center|right
* canvas.textAlign = 'start';
* 文字绘制基线方式：top|bottom|middle|alphabetic|hanging
* canvas.textBaseline = 'bottom';
*
* @param canvas      canvas
* @param calendar    日历 calendar
* @param x           日历 Card x 起点坐标
* @param y           日历 Card y 起点坐标
* @param itemWidth   item 的宽度
* @param itemHeight  item 的高度
* @param hasScheme   是否是标记的日期
* @param isSelected  是否选中
*/
abstract onDrawText(canvas: CanvasRenderingContext2D, calendar: Calendar, x: number, y: number, itemWidth: number,
itemHeight: number, hasScheme: boolean, isSelected: boolean): void;

/**
* 图片生成 PixelMap
*
* @param resource
* @returns
*/
protected getImagePixelMap(context: Context, resource: Resource): Promise<image.PixelMap> {}
```

### 示例

#### MonthCalendar

```typescript
import {
 Calendar,
 MonthCalendar,
 MonthCalendarController,
 MonthSelectMode,
 MonthShowMode,
 WeekStartType
} from 'calendar';

@Entry
@Component
struct Index {
 @State message: string = 'Hello World';
 private controller: MonthCalendarController = new MonthCalendarController();
 /**
  * 日期
  */
 @State dateStr: string = ''
 /**
  * 选中的日期
  */
 private calendar: Calendar = new Calendar();
 private startCalendar: Calendar = new Calendar();
 private endCalendar: Calendar = new Calendar();

 aboutToAppear(): void {
   this.calendar.year = 2024;
   this.calendar.month = 12;
   this.calendar.day = 3;
   this.startCalendar.year = 2024;
   this.startCalendar.month = 12;
   this.startCalendar.day = 29;
   this.endCalendar.year = 2025;
   this.endCalendar.month = 1;
   this.endCalendar.day = 24;
 }

 build() {
   Column() {
     Text(this.dateStr)
     MonthCalendar({
       controller: this.controller,
       param: {
         monthStartDay: 1,
         paddingLeft: 10,
         paddingRight: 20,
         weekBarHeight: 40,
         minYear: 2024,
         minMonth: 1,
         maxYear: 2025,
         maxMonth: 1,
         monthSelectMode: MonthSelectMode.WEEK,
         selected: this.calendar,
         startSelected: this.startCalendar,
         endSelected: this.endCalendar,
         onSelected: (calendar: Calendar, isClick: boolean) => {
           console.log('calendar', `onSelected: ${calendar.toString()}, isClick->${isClick}`)
         },
         onRangeSelected: (calendar: Calendar, isEnd: boolean) => {
           console.log('calendar', `onRangeSelected: ${calendar.toString()}, isEnd->${isEnd}`)
         },
         onWeekSelected: (startCalendar: Calendar, endCalendar: Calendar, isClick: boolean) => {
           console.log('calendar',
             `onWeekSelected: startCalendar->${startCalendar}, endCalendar->${endCalendar}, isClick->${isClick}`)
         },
         onMonthChanged: (year: number, month: number) => {
           this.dateStr = `${year}年${month}月`
           console.log('calendar', `onMonthChanged: ${year}年${month}月`)
         },
         onSelectOutOfRange: (calendar: Calendar) => {
           console.log('calendar', `onSelectOutOfRange: ${calendar.toString()}`)
         },
         onScrolledOutRangeFirstPage: () => {
           console.log('calendar', `onScrolledOutRangeFirstPage: 已滑动到第一页`)
         },
         onScrolledOutRangeLastPage: () => {
           console.log('calendar', `onScrolledOutRangeLastPage: 已滑动到最后一页`)
         },
         onControllerAttached: () => {
           console.log('calendar', 'onControllerAttached:')
         }
       }
     })

     Row({ space: 12 }) {
       Button('上一个月')
         .onClick(() => {
           this.controller.scrollToPre();
         })
       Button('下一个月')
         .onClick(() => {
           this.controller.scrollToNext();
         })

       Button('滚动到 2000-1-1')
         .onClick(() => {
           this.controller.scrollToCalendar(2000, 1, 1);
         })
     }.margin(5)

     Row({ space: 12 }) {
       Button('修改月起始日')
         .onClick(() => {
           this.controller.setMonthStartDay(20);
         })
       Button('月起始日还原')
         .onClick(() => {
           this.controller.setMonthStartDay(1);
         })
     }.margin(5)

     Row({ space: 12 }) {
       Button('修改范围')
         .onClick(() => {
           this.controller.setRange(2023, 4, 2025, 4);
         })
       Button('修改显示模式')
         .onClick(() => {
           this.controller.setMonthShowMode(MonthShowMode.ALL_MONTH);
         })
     }.margin(5)

     Row({ space: 12 }) {
       Button('星期一')
         .onClick(() => {
           this.controller.setWeekStart(WeekStartType.MONDAY);
         })
       Button('星期六')
         .onClick(() => {
           this.controller.setWeekStart(WeekStartType.SATURDAY);
         })
       Button('星期日')
         .onClick(() => {
           this.controller.setWeekStart(WeekStartType.SUNDAY);
         })
     }.margin(5)
   }
   .height('100%')
     .width('100%')
 }
}
```

#### DefaultMonthViewItem

```typescript
export class DefaultMonthViewItem extends MonthViewItem {
 aboutToAppear(context: Context): void {
 }

 aboutToDisappear(): void {
 }

 onDrawSelected(canvas: CanvasRenderingContext2D, calendar: Calendar, x: number, y: number, itemWidth: number,
   itemHeight: number, hasScheme: boolean, isSelectedPre: boolean, isSelectedNext: boolean): boolean {
   const isCurrentMonth = calendar.isCurrentMonth;
   if (isCurrentMonth) {
     canvas.fillStyle = 0x50CFCFCF;
     canvas.fillRect(x, y, itemWidth, itemHeight);
   }
   return false;
 }

 onDrawScheme(canvas: CanvasRenderingContext2D, calendar: Calendar, x: number, y: number, itemWidth: number,
   itemHeight: number, schemeColor: number): void {
 }

 onDrawText(canvas: CanvasRenderingContext2D, calendar: Calendar, x: number, y: number, itemWidth: number,
   itemHeight: number, hasScheme: boolean, isSelected: boolean): void {
   const isCurrentMonth = calendar.isCurrentMonth;
   const day = calendar.day;
   if (isCurrentMonth) {
     if (calendar.isCurrentDay) {
       canvas.fillStyle = 0xFF0000;
       canvas.fillRect(x, y, itemWidth, itemHeight);
     }
     canvas.fillStyle = 0xFF111111;
     // 文字大小和字体设置
     canvas.font = `14vp sans-serif`;
     // 文字绘制方式：start|end|left||center|right
     canvas.textAlign = 'center';
     // 文字绘制基线方式：top|bottom|middle|alphabetic|hanging
     canvas.textBaseline = 'middle';
     canvas.fillText(day.toString(), x + itemWidth / 2, y + itemHeight / 2, itemWidth);
   } else {
     canvas.fillStyle = 0XFFE1E1E1;
     // 文字大小和字体设置
     canvas.font = `14vp sans-serif`;
     // 文字绘制方式：start|end|left||center|right
     canvas.textAlign = 'center';
     // 文字绘制基线方式：top|bottom|middle|alphabetic|hanging
     canvas.textBaseline = 'middle';
     canvas.fillText(day.toString(), x + itemWidth / 2, y + itemHeight / 2, itemWidth);
   }
 }
}
```

### 更新记录

- **1.0.0** 初版
  - 发布 1.0.0 初版。
- **1.0.1**
  - 每月绘制画布重置，图片转换优化
- **1.0.2**
  - 滚动到指定月滚动失败修复
- **1.0.3**
  - 日历视图最大范围判段错误修复
- **1.0.4**
  - 日历视图周选择，周起始日切换当前周数据切换修复，支持星期栏周末文字颜色、大小自定义
- **1.0.5**
  - 周起始日默认值设置显示错误修复
- **1.0.6**
  - 周选择模式设置默认值后左右滑动选中未跟随修复
- **1.0.7**
  - Calendar 对象转为 Date 带当时的时分秒毫秒
  - 月视图重新绘制优化
- **1.0.8**
  - 添加开源仓库地址
  - bug 修复
- **1.0.9**
  - 添加关键词
- **1.1.0**
  - 滑动动画 bug 修复
  - 滑动事件优化

### 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| 基本信息 | 暂无 |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 | HarmonyOS 版本 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | - |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

Created with Pixso.

## 安装方式

```bash
ohpm install @mlethe/calendar
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/85d0ed93cddb48dd8d92049c20129ae9/PLATFORM?origin=template