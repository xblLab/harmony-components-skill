# cjcalendar 日历组件

## 简介

cjcalendar 是一款基于 ArkTs+ArkUI+NEXT 适配开发的通用日历组件，支持左右滑动，年视图/月视图/周视图，内部集成常规、单选、时间范围选择、多选、以及各种自定义显示，还包括农历、节日、节气等操作，控制切换周一/周日开始显示。

## 详细介绍

cjcalendar 最新版文档还在更新中，先看效果。

### 简介

cjcalendar 是一款日常开发常用的日历组件，内部集成常规、单选、时间范围选择、多选、自定义日期每项显示等。

### 功能特性

- 支持月视图、周视图显示
- 支持常规日历操作，同时支持单选、多选、一段时间选择
- 支持农历、节假日等
- 支持各种选中标记，文字标记、图片标记、自定义复杂标记
- 支持各个单元格自定义样式，每个单元格样式具备独立性
- 支持各种复杂场景的自定义，自定义背景层、主题日期内容显示层等
- 内置线型、面型等多种样式效果
- 支持设置日历主题色设置
- 后续规划：年视图、日视图、时间独立选择等

### 下载安装

```bash
ohpm install cjcalendar
```

### 本地安装

深色代码主题复制

```json5
"dependencies": {
  "cjcalendar": "file:path/to/cjcalendar.har" // 此处也可以是以当前 oh-package.json5 所在目录为起点的相对路径
}
```

### 使用方式

深色代码主题复制

```typescript
import { CJCalendar } from 'cjcalendar'

CJCalendar()
```

## 一、各项属性

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| logSwitch | boolean | 否 | 日志开关，默认关闭 |
| optMode | OptMode | 否 | 操作模式，常规、单选、一段时间、多选：默认：OptMode.NORMAL |
| viewModel | CJViewModel | 否 | 显示视图模式，年视图/月视图/周视图，年视图正在完善中：默认显示月视图 |
| weekStartMode | WeekStartMode | 否 | 控制日历从周一还是周日开始，默认：周日开始 |
| startDate | Date | 否 | 开始日期：默认：new Date(1970, 0, 1) |
| endDate | Date | 否 | 截止日期：默认：当前时间 +10 年 |
| initShowDate | Date | 否 | 初始化显示所在月/星期/年：默认：当前月/星期/年 |
| monthHeight | number \| undefined | 否 | 设置后每一行会均分 monthHeight 高度 |
| itemCellHeight | number \| undefined | 否 | 设置每一行高度 |
| titleHeight | Length | 否 | 标题栏高度：默认：50vp |
| titleFormat | string | 否 | 标题格式化显示：默认："yyyy-MM" |
| titleFontSize | number \| string \| Resource | 否 | 标题字体大小，默认：18 |
| titleFontColor | ResourceColor | 否 | 标题字体颜色，默认："#252a34" |
| titleBackgroundColor | ResourceColor | 否 | 标题背景颜色，默认：undefined |
| titleBackgroundImage | PixelMap \| ResourceStr \| DrawableDescriptor | 否 | 标题背景图片 |
| showFastToday | boolean | 否 | 是否显示快捷“今”，默认：true |
| showToolbar | boolean | 否 | 是否显示 Toolbar，默认：true |
| fastTodayFontSize | number \| string \| Resource | 否 | 快捷返回今天，字体大小，默认：12 |
| fastTodayFontColor | Resource | 否 | 快捷返回今天，字体颜色，默认："#FFFFFF" |
| fastTodayBg | Resource | 否 | 快捷返回今天，背景颜色，默认与 todayFontColor 一致 |
| weeks | string[] | 否 | 星期标题，默认：["日","一","二","三","四","五","六"] |
| weekTitleFontSize | number \| string \| Resource | 否 | 星期标题字体大小，默认：12 |
| weekTitleFontColor | ResourceColor | 否 | 星期标题字体颜色，默认："#9E9E9E" |
| weekTitleBackgroundColor | ResourceColor | 否 | 星期标题背景色颜色，默认未设置 |
| weekTitleHeight | Length | 否 | 星期标栏高度，默认：40 |
| showWeekTitle | boolean | 否 | 是否显示星期栏，默认：true |
| onlyShowCurrMonthDay | boolean | 否 | 是否仅显示当月日期，默认：false |
| showLunar | boolean | 否 | 是否显示农历，默认：false |
| showJieQi | boolean | 否 | 是否显示节气，显示农历下才支持，默认：false |
| showJieRi | boolean | 否 | 是否显示节日，显示农历下才支持，默认：false |
| selectedShape | SelectedShape | 否 | 默认选中样式形状，optMode = OptMode.MULTIPLE、OptMode.SINGLE 或者 optMode = OptMode.RANGE 且 selectedStyle = SelectedStyle.ALONE 时 SelectedShape.CIRCLE 生效，否则 SelectedShape.RECT 生效 |
| rangeStyle | SelectedStyle | 否 | SelectedStyle.ALONE 独立风格，SelectedStyle.CLOSE 封闭风格，默认：SelectedStyle.ALONE 独立圆形选中风格 |
| controller | CJCalendarControl | 否 | 控制器 |
| isShowFoldView | boolean | 否 | 是否显示折叠视图 |
| isAttchCustomLayoutToWhole | boolean | 否 | 是否将底部用户布局添加到整体，默认是每个月 |
| onlyShowDateArea | boolean | 否 | 是否仅需要日期显示区域，不需要底部自定义区域，默认显示整个日历区域 |
| themeColor | string | 否 | 主题色，默认："#03A9F4" |
| isNeedMarkToday | boolean | 否 | 当“今日”出现在不可用范围时间内时，是否需要标记出“今日”，仅在常规操作模式下生效，默认：false |

## 二、常用方法

| 方法 | 参数 | 返回 | 必填 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| buildCellBackground | -- | -- | 否 | 自定义每一项背景，引用的组件内声明一个变量：cjDataItem: CJDateItem = new CJDateItem(new Date())，可直接关联当前日期项 |
| buildCellBody | -- | -- | 否 | 自定义每一项自定义主体部分，引用的组件内声明一个变量：cjDataItem: CJDateItem = new CJDateItem(new Date())，可直接关联当前日期项 |
| buildToolbarLayoutBackground | -- | -- | 否 | 仅构建标题栏背景 |
| buildWeekTitleCell | week: string | -- | 否 | 自定义星期标题栏 cell |
| toolbarLayout | item: CJDateItem | -- | 否 | 仅自定义 今日 样式，当使用 cellLayout 时，tadayLayout 无效 |
| reBuildCellItem | cjDateItem: CJDateItem | cjDateItem: CJDateItem | 否 | 重新构建 Item，如需添加更多自定义属性时使用 |
| onMonthChangeBefore | currItem: CJDateItem, target: CJDateItem | -- | 否 | 月份切换之前监听函数 |
| onSelectedChanged | items: Array | -- | 否 | 选择变化监听，OptMode.NORMAL/OptMode.SINGLE，只返：一项；OptMode.RANGE：返回开始日期与截止日期，items[0] 为开始时间，items[1] 为结束时间；MULTIPLE：返回 Array，已选中的日期 |
| buildCellStyle | cjDataItem: CJDateItem | -- | 否 | 自定义构建每一项的样式 |
| buildMonthCustomLayout | -- | -- | 否 | 自定义构建每个月下方主内容 |
| onCellItemClick | item: CJDateItem | boolean | 否 | 点击日期事件响应，需要拦截则返回 true，该拦截为效果响应后的后续操作拦截 |
| onCellClickIntercept | item: CJDateItem | boolean \| undefined | 否 | 点击日期事件拦截，需要拦截则返回 true，该拦截在效果响应前（根拦截） |
| onDisableCellItemClick | item: CJDateItem | boolean | 否 | 不能点击项的点击日期事件响应，需要拦截则返回 true |
| onInitFinish | -- | -- | 否 | 日历数据初始化完成回调，可在这里进行异步数据请求加载 |

### CJCellStyle 属性

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| fontSize | number \| string \| Resource | 否 | 日期每一项字体大小，默认：18 |
| fontColor | Resource | 否 | 日期每一项字体颜色，默认："#252a34" |
| fontFontWeight | Resource | 否 | 日期每一项字体，默认：FontWeight.Normal |
| lunarFontSize | number \| string \| Resource | 否 | 农历日期每一项字体大小，默认：18 |
| lunarFontColor | Resource | 否 | 农历日期每一项字体颜色，默认："#252a34" |
| lunarFontFontWeight | Resource | 否 | 农历日期每一项字体，默认：FontWeight.Normal |
| todayFontColor | ResourceColor | 否 | “今”日字体颜色，默认："#03A9F4" |
| todayBackgroundColor | ResourceColor | 否 | “今”日背景颜色，默认："#FFFFFF" |
| disabledFontColor | ResourceColor | 否 | 不能使用的日期字体颜色，默认："#9E9E9E" |
| selectFontColor | ResourceColor | 否 | 选中日期字体颜色，默认："#FFFFFF" |
| selectItemBackgroundColor | ResourceColor | 否 | 选中日期背景颜色，默认与 todayFontColor 一致 |
| itemBackgroundColor | ResourceColor | 否 | 默认日期背景颜色，默认与 todayFontColor 一致 |
| lightRatio | number | 否 | RANGE 模式下生效，中间区域颜色变淡比例，范围：0-1，默认 0.85 |
| boderColor | ResourceColor | 否 | 边框颜色，默认："#dbe2ef" |
| selectBoderColor | ResourceColor | 否 | 选中时边框颜色 |
| boderWidth | Length | 否 | 边框宽度，默认：0 |
| boderRadius | Length | 否 | 边框圆角，默认：0 |
| markFontSize | Length | 否 | 标注字体大小 |
| markFontColor | ResourceColor | 否 | 标注字体颜色 |
| markFontWeight | FontWeight | 否 | 标注字体粗细 |
| markMarin | Weight | 否 | 标记边距 |
| markImageWidth | Length | 否 | 标记图片大小宽度 |
| markAlignment | Alignment | 否 | 标记显示位置，默认右上角 |

### CJCalendarControl 控制器

| 方法 | 参数 | 说明 |
| :--- | :--- | :--- |
| preMonth | - | 上一个月 |
| nextMonth | - | 下一个月 |
| backToday | - | 回到今天 |
| skipToMonth | date: Date \| string | 跳转到指定年月，“2016-08” / new Date("2016-08-01") |
| selectItems | items: Array<string \| Date> \| undefined | 触发选中指定日期项，items ["2024-06-07"] / [new Date("2024-08-01")] |
| refresh | isAll: boolean = false | 刷新，会重新执行 reBuildCellItem，默认刷新当前月，true 刷新缓存 cacheCount 个数月份 |
| getCurrMonthDays | - | 获取当前页面显示的所有日期 items，可直接根据业务修改调整 |
| getCJCalenderStatusParams | - | 获取状态栏状态信息 |
| setFoldStatue | fold: boolean | 设置折叠状态 |
| changViewModel | model: CJViewModel | 切换年、月、周视图（年视图开发中...） |
| showLunar | show: boolean | 显示/隐藏农历 |

## 三、CJDateItem 通用属性

| 属性 | 类型 | 描述 |
| :--- | :--- | :--- |
| fullYear | number | 年 |
| month | number | 月 |
| date | number | 日期 |
| week | number | 星期 |
| time | number | 时间戳 |
| dateText | string | 若赋值则会替代日期显示，通常只显示一个字，例如：可以让今日显示“今”等 |
| isSelected | boolean | 是否被选中 |
| isToday | boolean | 是否是今天 |
| disabled | boolean | 是否禁用 |
| markText | string | 标注文字 |
| markIcon | Resource | 标注图标，可用作加载中图或者加载失败图 |
| markImageUrl | string | 标注图标 url |

## 四、OptMode 操作模式

| 属性 | 描述 |
| :--- | :--- |
| NORMAL | 常规 |
| SINGLE | 单选 |
| RANGE | 一段时间 |
| MULTIPLE | 多选 |

## 五、SelectedStyle 选中样式风格

| 属性 | 描述 |
| :--- | :--- |
| ALONE | 独立选中风格：默认圆形独立 |
| CLOSE | 封闭选中风格：默认举行封闭 |

## 六、SelectedShape 选中形状

| 属性 | 描述 |
| :--- | :--- |
| SHAPE_CIRCLE | 面型 - 圆 |
| SHAPE_RECT | 面型 - 方 |
| LINE_CIRCLE | 线型 - 圆 |
| LINE_RECT | 线型 - 方 |

## 七、CJCalStatusParams 状态信息

| 属性 | 描述 |
| :--- | :--- |
| title | 标题 |
| hasPre | 是否有上一个月 |
| hasNext | 是否有下一个月 |
| showFastToday | 是否现实今 |

## 八、CJDateShowBackMode 月份切换回显模式

月份切换时的回显日期

| 属性 | 描述 |
| :--- | :--- |
| SHOW_LAST | 切换月日期小于当前月选中的日期时，回显最后一天 |
| SHOW_LAST_TO_FIRST | 切换月日期小于当前月选中的日期时，回显第一天 |
| SHOW_FIRST | 只要切换月份，就回显切换月第一天 |
| SHOW_PRE_LAST_NEXT_FIRST | 切换上月显示最后一天，切换下月显示第一天，可与 SHOW_CLICK 结合使用 |
| SHOW_CLICK | 当点击或指定日期时，选中操作的日期，可与其他的同时使用，比如：CJDateShowBackMode.SHOW_CLICK |

## 九、使用案例

### 1、直接使用

深色代码主题复制

```typescript
import { CJCalendar } from 'cjcalendar'
CJCalendar()
```

### 2. 操作模式 optMode

#### 1. 常规：默认/OptMode.NORMAL，仅供展示，不会有选择回调

深色代码主题复制

```typescript
CJCalendar({
  optMode: OptMode.NORMAL
})
```

#### 2. 单选：OptMode.SINGLE

深色代码主题复制

```typescript
CJCalendar({
  optMode: OptMode.SINGLE,
  onSelectedChanged: (items: CJDateItem[]) => {
    console.log(TAG, JSON.stringify(items))
  }
})
```

#### 3. 多选：OptMode.MULTIPLE

深色代码主题复制

```typescript
CJCalendar({
  optMode: OptMode.MULTIPLE,
  onSelectedChanged: (items: CJDateItem[]) => {
    console.log(TAG, JSON.stringify(items))
  }
})
```

#### 4. 时间范围选择：OptMode.RANGE

深色代码主题复制

```typescript
CJCalendar({
  optMode: OptMode.RANGE,
  onSelectedChanged: (items: CJDateItem[]) => {
    console.log(TAG, JSON.stringify(items))
  }
})
```

**说明**：若需要高度自定义，请结合常用方法中的方法。

### 综合案例

深色代码主题复制

```typescript
import {
  CellStatus,
  CJCalendarControl,
  CJCalStatusParams,
  CJCellStyle,
  CJDateItem,
  CJCalendar,
  SelectedShape,
  SelectedStyle,
  CJViewModel,
  OptMode,
  CJDateShowBackMode
} from 'cjcalendar';

const TAG = "TAG"

@Component
@Entry
export struct Index {
  cjDataItem: CJDateItem = new CJDateItem(new Date())
  @State message: string = 'Hello World';
  cjCellStyle: CJCellStyle = new CJCellStyle()
  cjCalStatus: CJCalStatusParams = new CJCalStatusParams()
  cjCellStatus: CellStatus = new CellStatus()
  controller: CJCalendarControl = new CJCalendarControl()
  @State defSelectedItems: Array<string> = ["2024-11-03", "2024-11-08"]
  @State extras: Record<string, number | string | boolean> = {}
  // 测试刷新
  @State test: string = "xx"

  build() {
    Column() {
      Text("日历 Demo")
        .height(50)
        .textAlign(TextAlign.Center)

      Column() {
        CJCalendar({
          logSwitch: true,
          controller: this.controller,
          extras: this.extras,
          // 初始化默认选中项目
          optMode: OptMode.RANGE,
          // 切换从周一 / 周天开始
          weekStartMode: WeekStartMode.Sunday,
          // 默认选中样式形状，optMode = OptMode.MULTIPLE、OptMode.SINGLE
          // 或者 optMode = OptMode.RANGE 且 selectedStyle = SelectedStyle.ALONE 、
          // 时 SelectedShape.CIRCLE 生效
          // 否则 SelectedShape.RECT 生效
          // 选中样式效果
          selectedShape: SelectedShape.SHAPE_RECT,
          selectedStyle: SelectedStyle.ALONE,
          // 全局圆角设置
          // selectedBorderRadius: 50,
          // 是否需要标记处今日
          isNeedMarkToday: true,
          // 回显方式，只有在 OptMode.NORMAL 下才生效
          dateShowBackMode: CJDateShowBackMode.SHOW_PRE_LAST_NEXT_FIRST | CJDateShowBackMode.SHOW_CLICK,
          viewModel: CJViewModel.MONTH,
          // 初始化选中项
          // defSelectedItems: [new Date("2024-12-02")],
          // 指定每一行高度，如果没有特殊需求不需要指定
          // itemCellHeight: 55,
          // startDate: new Date("2024-12-02"),
          // endDate:  new Date("2025-01-15"),
          // initShowDate: new Date("2024-05-01"),
          showFastToday: true,
          // 是否显示折叠按钮
          isShowFoldView: true,
          // 标题栏高度
          // titleHeight: 100,
          // 标题栏背景色
          // titleBackgroundColor: Color.Green,
          // 标题格式化显示
          titleFormat: "yyyy 年 MM 月",
          // 是否显示农历
          showLunar: true,
          // 设置整个月份视图高度
          // monthHeight: 400,
          // 是否显示节日
          showJieRi: true,
          // 仅需要日期显示区域，不需要底部自定义区域
          onlyShowDateArea: false,
          // 是否将底部自定义区域添加到整体
          isAttchCustomLayoutToWhole: false,
          // 主题色
          themeColor: "#b83b5e",
          // 是否显示节气
          // showJieQi: false,
          // 是否仅显示当月日期
          // onlyShowCurrMonthDay: true,
          // showToolbar: true,
          // 自定义标题栏
          // toolbarLayout: this.ToolbarLayout,
          // 不可选中 Cell 背景
          // buildDisableCellBackground: this.BuildDisableCellBackground,
          onMonthChangeBefore: (curr: CJDateItem, target: CJDateItem) => {
            console.log("月份切换之前：", "当前：" + curr.toString() + "，目标：" + target.toString())
          },
          // 当需要自定义农历部分描述信息时添加以下方法
          // buildCellLunarDesc:(item:CJDateItem)=>{
          //   return ""
          // },
          onMonthChanged: (month: CJDateItem) => {
            console.log("月份切换结束：", month.toString())
          },
          onCellItemClick: (item: CJDateItem) => {
            // 这里修改数据后会同步更新到界面
            // item.date = item.date + 1
            // item.extras.set("test", "-" + (item.date + 1) + "-")
            console.log("点击了：", JSON.stringify(item))
            return false
          },
          // 点击拦截，可根据业务实现点击拦截
          // onCellClickIntercept:(item: CJDateItem)=>{
          //   if (item.date == 2 || item.date == 4) {
          //     return true
          //   }
          //   return false
          // },
          onDisableCellItemClick: (item: CJDateItem) => {
            console.log("越界点击了：", JSON.stringify(item))
            return false
          },
          onSelectedChanged: (items: Array<CJDateItem>) => {
            console.log("选择变化：", JSON.stringify(items))
          },
          // 日历初始化完成
          onInitFinish: () => {

            // 1、强制刷新所有
            // this.controller.refresh(true)

            // 2、指定修改具体项目
            // let days: CJDateItem[] | undefined = this.controller.getCurrMonthDays()
            // let now: Date = new Date()
            // days?.forEach(day => {
            //   if (day.date > now.getDate() - 3 && day.date < now.getDate() + 3) {
            //     day.markText = "注"
            //   }
            // })

            // this.controller.setFoldStatue(true)
          },
          // 自定义标注
          // buildMark: this.BuildMark,
          // 自定义单元格背景
          // buildCellBackground: this.BuildCellBackground,
          // 自定义主体部分
          // buildCellBody: this.BuildCellBody,
          // 向 CellItem 中添加自定义属性
          // reBuildCellItem: (cjDateItem: CJDateItem) => {
          //   // 需要向 CJDateItem 中添加附加数据时，可是使用如下方式
          //   cjDateItem.extras.test = "自定义附加属性" + cjDateItem.date
          //  if (cjDateItem.isToday) {
          //    cjDateItem.dateText = "今"
          //  }
          //   // cjDateItem.desc = "描述" // 根据业务添加描述，一般显示农历，不赋值即可
          //   if (cjDateItem.date > 15 && cjDateItem.date < 20) {
          //     // 文字与图片优先显示图片
          //     cjDateItem.markText = "标"
          //     cjDateItem.markIcon = $r("app.media.icon")
          //     cjDateItem.markImageUrl =
          //       "https://img2.baidu.com/it/u=2105446738,2493267053&fm=253&fmt=auto&app=138&f=JPEG?w=100&h=100"
          //   }
          //   if (cjDateItem.fullYear == 2024 && cjDateItem.month == 7
          //     && cjDateItem.date < 20 && cjDateItem.date > 15) {
          //     // 设置不能选中
          //     cjDateItem.disabled = true
          //   }
          //   if (cjDateItem.date > 5 && cjDateItem.date < 13) {
          //     cjDateItem.markText = this.test
          //   }
          // },

          // 自定义 Cell 样式风格
          // buildCellStyle: (item: CJDateItem) => {
          //   let cjCellStyle: CJCellStyle = new CJCellStyle()
          // cjCellStyle.selectItemBackgroundColor = "#b83b5e"
          // if (item.isToday) {
          //   cjCellStyle.fontColor = "#b83b5e"
          //   cjCellStyle.itemBackgroundColor = "#00ccbb"
          // }
          //
          // if ((item.isPre || item.isNext) && item.isToday) {
          //   cjCellStyle.disabledBackgroundColor = "#b83b5e"
          // }

          //   if (item.week == 0 || item.week == 6) {
          //     cjCellStyle.fontColor = "#b83b5e"
          //   }
          //   // 农历字体颜色
          //   cjCellStyle.lunarFontColor = "#AA55CC"
          //   // 设置选中色
          //   cjCellStyle.selectItemBackgroundColor = "#FF00BB"
          //   // 标注样式
          //   cjCellStyle.markFontColor = "#ff922f08"
          //   cjCellStyle.markFontSize = 10
          //   cjCellStyle.markMarin = 4
          //   cjCellStyle.markFontWeight = FontWeight.Bold
          //   cjCellStyle.markImageWidth = 12
          //   cjCellStyle.markAlignment = Alignment.TopEnd
          //
          //   // 设置今天文字颜色
          //   cjCellStyle.todayFontColor = "#FFFFFF"
          //   // 设置今天背景色
          //   cjCellStyle.todayBackgroundColor = "#ff1c6a46"
          //
          //   // 设置空心
          //   // if (item.isToday) {
          //   //   cjCellStyle.todayFontColor = "#ff1c6a46"
          //   //   cjCellStyle.todayBackgroundColor = "#FFFFFF"
          //   //   cjCellStyle.boderColor = "#ff1c6a46"
          //   //   cjCellStyle.boderWidth = 1
          //   //   cjCellStyle.boderRadius = 100
          //   // }
          //   // 根绝条件修改背景色、字体色等
          //   if (item.date < 7) {
          //     cjCellStyle.itemBackgroundColor = "#abedd8"
          //     cjCellStyle.fontColor = "#3f72af"
          //   } else if (item.date >= 10 && item.date < 16) {
          //     cjCellStyle.itemBackgroundColor = "#e4f9f5"
          //     cjCellStyle.fontColor = "#3d84a8"
          //   } else if (item.date >= 20 && item.date <= 28) {
          //     cjCellStyle.itemBackgroundColor = "#88304e"
          //     cjCellStyle.fontColor = "#fae3d9"
          //   }
          // return cjCellStyle
          // },
          // 自定义星期标题样式
          // buildWeekTitleCell: (week: string) => {
          //   this.BuildWeekTitleCell(week)
          // }
          // 月视图下的用户布局区域
          buildMonthCustomLayout: () => {
            this.BuildMonthCustomLayout()
          },
        })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Start)

    }
    .height("100%")
  }

  @Builder
  ToolbarLayout() {
    Column() {
      Row() {
        Button("上一月")
          .onClick(() => {
            this.controller.preMonth()
          })
        Blank()
        Text(this.controller.getCJCalenderStatusParams().title + (this.extras.test ?? ""))
          .fontColor(Color.White)
          .onClick(() => {
            this.extras.test = "测试"
            // let datas = this.controller.getItemSource()
            // if (datas) {
            //   console.log("测试", "点击 11")
            // datas.getData().date = 29
            // datas[0].extras.set("test", "测试")
            // }
          })
        Blank()
        Button("下一月")
          .onClick(() => {
            this.controller.nextMonth()
            // this.defSelectedItems = ["2024-06-05", "2024-06-13"]
            // this.controller.skipToMonth("2024-06-01")

          })
      }
      .width("100%")

      Text("此处可添加广告位")
        .fontSize(20)
        .textAlign(TextAlign.Center)
        .width("100%")
        .height(100)
        .backgroundColor(Color.Pink)
    }
    .backgroundColor(Color.Orange)
    .width("100%")

  }

  @Builder
  BuildMark() {
    Circle()
      .width(10)
      .height(10)
      .fill("#aa2288")
    // 或者以下可自定义各种复杂布局
    // Stack() {
    //   // ......
    // }
    // .width("100%")
    // .height("100%")
    // .alignContent(Alignment.TopEnd)
  }

  @Builder
  BuildWeekTitleCell(week: string) {
    Text(week)
      .textAlign(TextAlign.Center)
      .fontColor(week == '日' || week == '六' ? "#b83b5e" : "#9E9E9E")
      .fontSize(13)
      .layoutWeight(1)

  }

  @Builder
  BuildCellBackground() {
    if (this.cjDataItem.isToday && this.cjDataItem.extras.test == '1') {
      Column()
        .backgroundColor("#D13F3F")
        .width(50)
        .height(56)
        .borderRadius(6)
        .opacity(0.5)

    } else if (this.cjDataItem.isToday && this.cjDataItem.extras.test == '0') {
      Column()
        .backgroundColor("#D13F3F")
        .width(50)
        .height(56)
        .borderRadius(6)

    } else if (this.cjDataItem.isToday) {
      Column()
        .backgroundColor("#D13F3F")
        .width(50)
        .height(56)
        .borderRadius(6)
    } else {
      if (this.cjDataItem.isSelected) {
        Column()
          .alignItems(HorizontalAlign.End)
          .justifyContent(FlexAlign.Start)// .backgroundColor(this.cjDataItem.extras.test == '1' ? Color.Orange : this.cjCellStatus.backgroundColor)
          .width(50)
          .height(56)
          .border({
            width: 1,
            color: "#D13F3F"
          })
          .borderRadius(6)
      }
    }
  }

  @Builder
  BuildMonthCustomLayout() {
    Flex({ wrap: FlexWrap.Wrap }) {
      Button("触发点击")
        .onClick(() => {
          // 实现还没写完
          this.controller.clickItem(2024, 6, 6)
        })
      Button("设置选中")
        .onClick(() => {
          this.controller.selectItems(["2024-06-09"])
        })
      Button("显示农历")
        .onClick(() => {
          this.controller.showLunar(true)
        })
      Button("隐藏农历")
        .onClick(() => {
          this.controller.showLunar(false)
        })
      Button("切换周模式")
        .onClick(() => {
          this.controller.changViewModel(CJViewModel.WEEK)
        })
      Button("切换月模式")
        .onClick(() => {
          this.controller.changViewModel(CJViewModel.MONTH)
        })
      Button("切换年模式")
        .onClick(() => {
          this.controller.changViewModel(CJViewModel.YEAR)
        })
      Button("切换单选/常规操作模式")
        .onClick(() => {
          this.controller.changViewModel(CJViewModel.YEAR)
        })
      Button("跳转至指定星期/月份/年份【1996-02-12】")
        .onClick(() => {
          // this.controller.skipToDate("2024-10-12")
          this.controller.skipToDate("2024-08-12")
        })
      Button("折叠")
        .onClick(() => {
          this.controller.setFoldStatue(true)
        })
      Button("展开")
        .onClick(() => {
          this.controller.setFoldStatue(false)
        })

      Button("异步刷新")
        .onClick(() => {
          this.test = "11"
          // 模拟异步请求
          setTimeout(() => {
            this.controller.refresh()
          }, 3000)
        })

      Button("直接修改当前月全部/指定项数据")
        .onClick(() => {
          let days: CJDateItem[] | undefined = this.controller.getCurrMonthDays()
          if (days) {
            days[7].date = 39
          }
        })
    }
    .margin({
      top: 30
    })
  }

  step: number = 1

  @Builder
  BuildCellBody() {

    Column() {
      //
      Text(this.cjDataItem.date + '')
        .fontColor(this.cjDataItem.isPre || this.cjDataItem.isNext ? "#e1e1e1" : Color.Black)
        .fontSize(this.cjCellStyle.fontSize)
        .fontWeight(this.cjCellStyle.fontFontWeight)
      // 可以加备注之类的自定义信息
      Text(this.cjDataItem.extras.test as string)
        .fontSize(10)
        .fontColor(Color.Gray)
        .fontColor(this.cjCellStatus.fontColor)
    }
    .alignItems(HorizontalAlign.Center)

  }

  @Builder
  BuildDisableCellBackground() {
    Column() {
      Text("测试")
    }
    .backgroundColor(Color.Yellow)
    .width('85%')
    .aspectRatio(1)
    .border({
      width: this.cjCellStyle.borderWidth,
      color: this.cjCellStyle.borderColor
    })
    .borderRadius(this.cjCellStyle.borderRadius)

  }
}
```

## 相关库

- **harmony-utils**: 一款功能丰富且极易上手的 HarmonyOS 工具库，借助众多实用工具类，致力于助力开发者迅速构建鸿蒙应用。
- **harmony-dialog**: 一款极为简单易用的零侵入弹窗，仅需一行代码即可轻松实现，无论在何处都能够轻松弹出。
- 还有很多功能可自行探索
- .........

## 更新记录

### v2.3.5

- 添加 setDisableSwipe，设置禁用组件滑动切换功能

### v2.3.4

- CJCellStyle 添加属性 markBackgroundColor?: ResourceColor、markRadius?: Length、markPadding?: Padding \| Length \| LocalizedPadding

### v2.3.3

- 添加枚举 WeekStartMode：切换从日历从周一/周二/周二/周三/周四/周五/周六/周天开始

### v2.3.2

- 修复部分已知问题

### v2.3.1

- 添加属性 weekStartMode：切换从日历从周一 或 周天开始

### v2.3.0

- 修复已知问题

### v2.2.9

- CJDateItem 添加 dateText 属性，当 dateText 被赋值时，会替代 date 日期显示

### v2.2.8

- 添加自定义样式字体处理

### v2.2.7

- 选中样式 SelectedShape 添加：线型 - 圆（LINE_CIRCLE）、线型 - 矩形（LINE_RECT）
- 选中样式 SelectedShape 字段调整：CIRCLE -> SHAPE_CIRCLE, RECT -> SHAPE_RECT
- 添加主题色：themeColor，会自定关联选中色、今日、标签色等
- 新加字段 CJCellStyle 中：todayDisabledFontColor、todayDisabledBackgroundColor·······
- 添加字段是否标记今日，仅在常规模式下支持，isNeedMarkToday
- 添加字段全局圆角设置，优先级低于单元格内部圆角，selectedBorderRadius
- 样式结构算法整体调整

### v2.2.6

- CJDateItem 添加描述 desc，用于承载之前的农历，也可以是其他描述，区别于 Mark 的文字标签
- CJCellStyle 下变量名调整：lunarFontSize -> descFontSize，lunarFontColor -> descFontColor，lunarFontFontWeight -> descFontFontWeight, lunarMargin -> descMargin, selectLunarFontColor -> selectDescFontColor
- CJCellStyle 添加不可用描述字体颜色控制字段：disabledDescFontColor
- 添加农历描述信息构建方法，可添加更满足业务的实现：buildCellLunarDesc
- CJDateShowBackMode 添加回显模式：SHOW_CLICK，当点击或指定日期时，选中操作的日期，可与其他的同时使用，比如：CJDateShowBackMode.SHOW_CLICK \| CJDateShowBackMode.SHOW_PRE_LAST_NEXT_FIRST

### v2.2.5

- CJDateShowBackMode 添加回显模式：SHOW_PRE_LAST_NEXT_FIRST，切换上月显示最后一天，切换下月显示第一天
- 丰富农历字体颜色控制，更加便捷控制样式显示
- 添加点击事件前置拦截：onCellClickIntercept

### v2.2.4

- 修复因 Swiper 因嵌套其他带滑动容器所导致的数据加载异常问题
- onDisableCellItemClick 添加返回值，需要拦击返回 true
- onCellItemClick 添加返回值，需要拦击返回 true
- 完善部分文档

### v2.2.3

- 新增 buildWeekTitleCell：自定义星期 cell

### v2.2.2

- 控制器添加方法 getPreMonthDays：获取上一月 days 项
- 控制器添加方法 getNextMonthDays：获取下一月 days 项
- 添加 CJDateShowBackMode：月份切换回显模式，：
  - SHOW_LAST：显示最后一天
  - SHOW_FIRST: 显示第一天
  - SHOW_LAST_TO_FIRST: 日期不足显示第一天
- 添加 onMonthChangeBefore：月份切换之前监听函数

### v2.2.1

1. 添加月份切换切换时，回显最后一次选中日期日期，比如选中 10 月 20 日，切换 11 月时，会标记 11 月 20 日
2. 调整为常规模式下才会回显

### v2.2.0

- 新增字段 onlyShowDateArea：仅需要日期显示区域，不需要底部自定义区域
- 修复已知问题

### v2.1.9

- 新增字段 isAttchCustomLayoutToWhole：是否将底部用户布局添加到整体，默认是每个月，可跟随滑动
- 新增方法 onInitFinish：日历初始化数据完成
- 完善部分内部功能
- 完善部分文档信息

### v2.1.8

- 新增自定义布局 buildMonthCustomLayout：月视图底部用户自定义区域
- 新增字段 isShowFoldView，是否显示折叠按钮
- 新增自定义布局 buildFoldCustomLayout：自定义折叠区域样式
- 日历内部调整
- reBuildCellItem 去掉返回值
- 年模式待更新...
- 文档不断完善中，有疑问进群讨论

### v2.1.5

- 完善部分周模式功能

### v2.1.4

- 完善部分新功能

### v2.1.3

- 分离标注、自定义标注等，更加简洁添加标注信息等

### v2.1.2

- 修复已知 BUG

### v2.1.1

- 修复已知 BUG

### v2.1.0

- 添加滑动
- 内部结构调整

### v2.0.7

1. 添加单元格是否选中状态 isSelected

### v2.0.6

1. 修复已知 BUG

### v2.0.5

1. 添加标题格式化显示 titleFormat
2. 添加初始化加载月份 initMonth
3. 修复已知问题

### v2.0.4

1. CJCalendarControl 添加 selectItems

### v2.0.3

1. 修复已知问题

### v2.0.2

1. 修复已知问题

### v2.0.1

1. 添加日历控制器 controller
2. 添加初始化默认选中项目 defSelectedItems

### v2.0.0

1. 文档调整
2. 属性调整

### v1.2.3

1. 添加是否显示农历控制字段
2. 添加是否显示节气
3. 添加是否显示节日

### v1.2.2

1. 添加是否仅显示当月日期字段

### v1.2.1

1. 功能完善

### v1.2.0

1. 代码重构 适配 NEXT 版本

### v1.1.8

- 修复已知 BUG

### v1.1.7

- 修复设置 startDate 时，不包含当天的 BUG

### v1.1.6

- 修复兼容部分 next 语法

### v1.1.5

- 添加 selectedBackgroundLayout, 添加自定义独立选中风格样式
- 添加 仅自定义 每项 日期文字注意区域
- 添加属性 extremityRadius，当为 RANGE、CLOSE 时，两头的圆角

### v1.1.4

- 兼容处理 rangeStyle == 2 的样式

### v1.1.3

- 移除 weekTitle 默认背景色
- 修复初始化加载选中项

### v1.1.2

- 添加自定义顶部布局：cusTopLayout、cusTopStateListener

### v1.1.1

- 添加月份改变回调：onMonthChange

### v1.1.0

- 调整默认不显示时间选择
- 添加文档案例

### v1.0.9

- 添加属性：showTime
- onSelectChange 更名为 onDateChange
- 添加 onTimeChange
- 添加 CJTimeItem
- 时间选择交互还在不断优化中

### v1.0.8

- 细节调整

### v1.0.7

- 添加 startDate、endDate 日期限制

### v1.0.6

- 使用文档更新

### v1.0.5

- 添加属性 已选中日期 selectedDates
- 添加属性 不能使用日期颜色 disabledFontColor

### v1.0.3

- 添加时间范围选择

### v1.0.2

- fastTodayBg 修改默认背景 为当前主题色

### v1.0.1

- 添加属性 selectItemBgColor
- 文档整理

### v1.0.0

- 日历组件

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 | 暂无 |

## 兼容性

| 项目 | 信息 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | 无 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

Created with Pixso.

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/95b5833090de40dca6f775c5aa091671/PLATFORM?origin=template