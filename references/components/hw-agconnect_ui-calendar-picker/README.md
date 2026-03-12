# 日历选择器 UICalendarPicker

## 简介

UICalendarPicker，是一个基于open harmony基础组件开发的日历选择器组件，包含单日期选择、多日期选择和时间段选择的功能，让用户快捷选择日期。

## 详细介绍

### 简介

UICalendarPicker，是一个基于open harmony基础组件开发的日历选择器组件，包含单日期选择、多日期选择和时间段选择的功能，让用户快捷选择日期。

### 约束与限制

- DevEco Studio版本：DevEco Studio 5.0.0 Release及以上
- HarmonyOS SDK版本：HarmonyOS 5.0.0 Release SDK及以上
- 设备类型：华为手机（包括双折叠和阔折叠）、平板
- 系统版本：HarmonyOS 5.0.0(12)及以上

### 使用

安装组件。

```bash
ohpm install @hw-agconnect/ui-base
ohpm install @hw-agconnect/ui-calendar-picker
```

当前组件已使用状态管理V2版本，如果您开发工程使用V1版本，请参考以下命令获取1.0.3版本组件。关于状态管理V1和V2版本的区别，请参见"状态管理版本介绍"。

```bash
ohpm install @hw-agconnect/ui-base
ohpm install @hw-agconnect/ui-calendar-picker@1.0.3
```

引入和调用组件，详细参数配置说明参见API参考。

```typescript
// 在应用的入口文件进行初始化，比如EntryAbility.ets
import { UIBase } from '@hw-agconnect/ui-base';

onWindowStageCreate(windowStage: window.WindowStage): void {
  UIBase.init(windowStage);
}

// 在业务页面使用组件，比如xxx.ets
import { UICalendarPicker, TypePicker， CalendarPickerUtil } from '@hw-agconnect/ui-calendar-picker';

UICalendarPicker({ type: TypePicker.SINGLE })

Button('日历').onClick(() => CalendarPickerUtil.show())
```

## API参考

### 子组件

UICalendarPicker可以包含单个子组件

### 接口

UICalendarPicker(option?: UICalendarPickerOptions)

| 参数名 | 类型 | 是否必填 | 说明 |
|--------|------|----------|------|
| options | UICalendarPickerOptions | 否 | 配置日历选择器组件的参数。 |

### CalendarPickerUtil方法说明

| 名称 | 描述 |
|------|------|
| show(options?: UICalendarPickerOptions) | 控制日历选择器打开的事件 |
| hide() | 控制日历选择器关闭的事件 |

### UICalendarPickerOptions对象说明

| 名称 | 类型 | 是否必填 | 说明 |
|------|------|----------|------|
| type | TypePicker | 否 | 日期选择器类型，默认值是SINGLE单日期 |
| dialogType | DialogType | 否 | 弹窗类型，支持常规弹窗和半模态弹窗，默认值DialogType.SHEET |
| swiperDirection | SwiperDirection | 否 | 滑动方向，支持左右滑动和上下滑动，仅半模态弹窗支持上下滑动，默认值SwiperDirection.HORIZONTAL |
| customColor | ResourceColor | 否 | 定制颜色，涉及所选日期背景色、当日字体、箭头、年月滚轮 |
| customFontColor | ResourceColor | 否 | 定制未选中文字颜色 |
| startDayOfWeek | number | 否 | 一周起始天，默认值是0，星期天，取值范围0 - 6之间的整数 |
| startYear | number | 否 | 切换年月的起始年份，默认是1900 |
| endYear | number | 否 | 切换年月的结束年份，默认是2100 |
| rangeLimit | Date[] | 否 | 设置可选范围，取数组第一项作为可选范围的开始日期，第二项作为可选范围的结束日期 |
| disabledDates | Date[] | 否 | 设置禁选日期，仅针对单日期、多日期生效 |
| disableDayLabel | ResourceStr | 否 | 设置禁选日期下方的文字 |
| maxGap | number | 否 | 设置起止日期之间的最大跨度，仅时间段类型生效 |
| enableSelectTime | boolean | 否 | 开启时间选择，默认值否，仅单日期类型以及横向滑动SwiperDirection.HORIZONTAL时生效 |
| isMilitaryTime | boolean | 否 | 时间选择是否24小时制，默认值否 |
| sheetTitle | ResourceStr | 否 | 设置半模态弹窗标题文字 |
| sheetH | SheetSize \| Length | 否 | 设置半模态弹窗高度，仅横向滑动SwiperDirection.HORIZONTAL生效 |
| detents | [ (SheetSize \|Length), (SheetSize \|Length)?, (SheetSize \|Length)? ] | 否 | 设置半模态弹窗高度档位，仅纵向滑动SwiperDirection.VERTICAL生效 |
| selectedDate | Date | 否 | 选中的单日期，无默认值 |
| selectDates | Date[] | 否 | 选中的多日期、时间段。时间段只取前两个日期作为开始和结束日期。无默认值 |
| yOffset | number | 否 | 常规弹窗垂直方向偏移量，默认垂直居中对齐 |
| embedded （2.0.0+） | boolean | 否 | 是否直接嵌入页面，默认为否 |
| customBuildPanel | () => void | 否 | 自定义触发弹窗的控件 |
| onSelected | (callback: (date: Date \|Date[]) => void) | 否 | 确认选择的回调 |
| cancel | (callback: () => void) | 否 | 取消选择的回调 |
| onClickDate | (callback: (date: Date) => void) | 否 | 点击日期的回调 |

### TypePicker枚举说明

| 名称 | 描述 |
|------|------|
| SINGLE | 单日期 |
| MULTIPLE | 多日期 |
| RANGE | 时间段 |

### DialogType枚举说明

| 名称 | 描述 |
|------|------|
| DIALOG | 常规弹窗 |
| SHEET | 半模态弹窗 |

### SwiperDirection枚举说明

| 名称 | 描述 |
|------|------|
| HORIZONTAL | 水平方向 |
| VERTICAL | 垂直方向 |

### 支持情况说明

针对日历选择器在页面中不同的展示方式，参数支持情况说明如下：

| 类型 | 通过控件触发 | 通过API方式触发 | 嵌入页面 |
|------|------------|----------------|----------|
| 组件版本 | 1.0.0+ | 2.0.0+ | 2.0.0+ |
| 嵌入页面embedded | √ | x（API携带，开发者手动更改不生效） | √ |
| 自定义构建函数customBuildPanel | √ | x | x |
| 确认选择的回调onSelected(callback: (date: Date \| Date[]) => void) | √ | √ | x |
| 取消选择的回调cancel(callback: () => void) | √ | √ | x |
| 点击日期的回调onClickDate(callback: (date: Date) => void) | √ | √ | √ |

针对是否支持选择时间、设置禁选日期、设置可选范围、设置最大跨度，不同类型的日期选择器支持情况说明如下：

| 类型 | 单日期 | 多日期 | 时间段 |
|------|--------|--------|--------|
| 时间选择enableSelectTime | √ | x | x |
| 禁选disabledDates | √ | √ | x |
| 可选范围rangeLimit | √ | √ | √ |
| 跨度maxGap | x | x | √ |

### 异常情形说明

| 异常情形 | 对应结果 |
|----------|----------|
| 一周起始天不合法 | 取默认值0 |
| 起始年份小于1900 | 取默认值1900 |
| 结束年份大于2100 | 取默认值2100 |
| 起始年份晚于结束年份 | 起始年份、结束年份均为默认值 |
| 针对单日期选择，选中日期早于起始年份 | 选中日期非法，置空处理，当前视图为系统时间所在月 |
| 针对单日期选择，选中日期晚于结束年份 | 选中日期非法，置空处理，当前视图为系统时间所在月 |
| 针对单日期选择，起始年份晚于当前系统日期，选中日期未设置 | 当前视图为起始年份第一个月 |
| 针对单日期选择，结束年份早于当前系统日期，选中日期未设置 | 当前视图为结束年份最后一个月 |
| 针对多日期选择，部分选中日期不在起止年份间 | 过滤掉不在起止年份间的日期，当前视图为第一个有效日期所在月 |
| 针对多日期选择，全部选中日期不在起止年份间 | 过滤所有非法日期，当前视图为系统时间所在月 |
| 针对时间段选择，开始日期不早于结束日期 | 默认值非法，置空处理，当前视图为系统时间所在月 |
| 针对时间段选择，开始日期或结束日期不在起止年份之间 | 默认值非法，置空处理，当前视图为系统时间所在月 |
| 针对可选范围rangeLimit，开始时间不早于结束时间 | 非法传参，参数不生效 |

## 示例代码

### 示例1

```typescript
import { DialogType, SwiperDirection, TypePicker, UICalendarPicker } from '@hw-agconnect/ui-calendar-picker';

@Extend(Row)
function rowStyle() {
  .width('100%')
  .justifyContent(FlexAlign.SpaceBetween)
  .padding(16)
  .borderRadius(12)
  .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
}

@Extend(Text)
function textStyle() {
  .margin({ right: 20 })
  .layoutWeight(1)
}

@Entry
@ComponentV2
struct CalendarPickerSample1 {
  @Local selectedDate: Date = new Date(2024, 2, 1);
  @Local selectedDates: Date[] = [];

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 10 }) {
          Row() {
            Text('常规弹窗：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              dialogType: DialogType.DIALOG,
              startYear: 2024,
              endYear: 2034,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              dialogType: DialogType.SHEET,
              startYear: 2024,
              endYear: 2025,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，纵向滑动,2025年：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              dialogType: DialogType.SHEET,
              swiperDirection: SwiperDirection.VERTICAL,
              startYear: 2025,
              endYear: 2025,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，纵向滑动，1900-2100：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              dialogType: DialogType.SHEET,
              swiperDirection: SwiperDirection.VERTICAL,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，支持选择时间：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              dialogType: DialogType.SHEET,
              enableSelectTime: true,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，设置禁选日期：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              dialogType: DialogType.SHEET,
              disabledDates: [
                new Date('2024-12-20'),
                new Date(),
                new Date('2024-12-26'),
                new Date('2025-01-20'),
                new Date('2025-01-26'),
              ],
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，设置range范围：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              dialogType: DialogType.SHEET,
              rangeLimit: [new Date()],
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，有默认值：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              dialogType: DialogType.SHEET,
              selected: new Date(2024, 2, 15),
              startYear: 2020,
              endYear: 2030,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，有默认值，支持选择时间：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              dialogType: DialogType.SHEET,
              selected: new Date('2024-12-25 14:20:20'),
              enableSelectTime: true,
              startYear: 2020,
              endYear: 2030,
            })
          }.rowStyle()
        }
        .width('100%')
      }
      .padding(16)
      .height('100%')
      .edgeEffect(EdgeEffect.Spring)
      .align(Alignment.TopStart)
    }
    .title('选择单日期')
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }
}
```

### 示例2

```typescript
import {
  CalendarPickerUtil,
  DialogType,
  SwiperDirection,
  TypePicker,
  UICalendarPicker,
} from '@hw-agconnect/ui-calendar-picker';

@Extend(Row)
function rowStyle() {
  .width('100%')
  .justifyContent(FlexAlign.SpaceBetween)
  .padding(16)
  .borderRadius(12)
  .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
}

@Extend(Text)
function textStyle() {
  .margin({ right: 20 })
  .layoutWeight(1)
}

@Entry
@ComponentV2
struct CalendarPickerSample2 {
  @Local selectedDate: Date = new Date(2024, 2, 1);
  @Local selectedDates: Date[] = [];

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Row() {
            Text('常规弹窗：').textStyle()
            UICalendarPicker({
              type: TypePicker.MULTIPLE,
              dialogType: DialogType.DIALOG,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗：').textStyle()
            UICalendarPicker({
              type: TypePicker.MULTIPLE,
              dialogType: DialogType.SHEET,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，纵向滑动：').textStyle()
            UICalendarPicker({
              type: TypePicker.MULTIPLE,
              dialogType: DialogType.SHEET,
              swiperDirection: SwiperDirection.VERTICAL,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，设置禁选日期：').textStyle()
            UICalendarPicker({
              type: TypePicker.MULTIPLE,
              dialogType: DialogType.SHEET,
              disabledDates: [
                new Date('2024-12-20'),
                new Date(),
                new Date('2024-12-26'),
                new Date('2025-01-20'),
                new Date('2025-01-26'),
              ],
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，设置range范围：').textStyle()
            UICalendarPicker({
              type: TypePicker.MULTIPLE,
              dialogType: DialogType.SHEET,
              rangeLimit: [new Date()],
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，有默认值：').textStyle()
            UICalendarPicker({
              type: TypePicker.MULTIPLE,
              dialogType: DialogType.SHEET,
              selectDates: [new Date(2024, 2, 15)],
              startYear: 2020,
              endYear: 2030,
            })
          }.rowStyle()
        }
        .width('100%')
      }
      .padding(16)
      .height('100%')
      .edgeEffect(EdgeEffect.Spring)
      .align(Alignment.TopStart)
    }
    .title('选择多日期')
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }
}
```

### 示例3

```typescript
import { DialogType, SwiperDirection, TypePicker, UICalendarPicker } from '@hw-agconnect/ui-calendar-picker';

@Extend(Row)
function rowStyle() {
  .width('100%')
  .justifyContent(FlexAlign.SpaceBetween)
  .padding(16)
  .borderRadius(12)
  .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
}

@Extend(Text)
function textStyle() {
  .margin({ right: 20 })
  .layoutWeight(1)
}

@Entry
@ComponentV2
struct CalendarPickerSample3 {
  @Local selectedDate: Date = new Date(2024, 2, 1);
  @Local selectedDates: Date[] = [];

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Row() {
            Text('常规弹窗：').textStyle()
            UICalendarPicker({
              type: TypePicker.RANGE,
              dialogType: DialogType.DIALOG,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗：').textStyle()
            UICalendarPicker({
              type: TypePicker.RANGE,
              dialogType: DialogType.SHEET,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，纵向滑动：').textStyle()
            UICalendarPicker({
              type: TypePicker.RANGE,
              dialogType: DialogType.SHEET,
              swiperDirection: SwiperDirection.VERTICAL,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，设置最大跨度：').textStyle()
            UICalendarPicker({
              type: TypePicker.RANGE,
              dialogType: DialogType.SHEET,
              swiperDirection: SwiperDirection.VERTICAL,
              maxGap: 3,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，设置range范围：').textStyle()
            UICalendarPicker({
              type: TypePicker.RANGE,
              dialogType: DialogType.SHEET,
              swiperDirection: SwiperDirection.VERTICAL,
              rangeLimit: [new Date()],
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，有默认值：').textStyle()
            UICalendarPicker({
              type: TypePicker.RANGE,
              dialogType: DialogType.SHEET,
              swiperDirection: SwiperDirection.VERTICAL,
              selectDates: [new Date(2024, 4, 15), new Date(2024, 4, 20)],
              startYear: 1940,
              endYear: 2050,
            })
          }.rowStyle()
        }
        .width('100%')
      }
      .padding(16)
      .height('100%')
      .edgeEffect(EdgeEffect.Spring)
      .align(Alignment.TopStart)
    }
    .title('选择时间段')
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }
}
```

### 示例4

```typescript
import { DialogType, TypePicker, UICalendarPicker } from '@hw-agconnect/ui-calendar-picker';

@Extend(Row)
function rowStyle() {
  .width('100%')
  .justifyContent(FlexAlign.SpaceBetween)
  .padding(16)
  .borderRadius(12)
  .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
}

@Extend(Text)
function textStyle() {
  .margin({ right: 20 })
  .layoutWeight(1)
}

@Entry
@ComponentV2
struct CalendarPickerSample4 {
  @Local selectedDate: Date = new Date(2024, 2, 1);
  @Local selectedDates: Date[] = [];

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Row() {
            Text('单日期-自定义主题色：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              customColor: Color.Orange,
              selected: this.selectedDate,
              onSelected: (date) => {
                this.selectedDate = date as Date;
              },
            }) {
              Text(this.selectedDate.toLocaleDateString())
            }
          }.rowStyle()

          Row() {
            Text('多日期-自定义控件：').textStyle()
            UICalendarPicker({
              type: TypePicker.MULTIPLE,
              customColor: Color.Pink,
              selectDates: this.selectedDates,
              onSelected: (date) => {
                this.selectedDates = date as Date[];
              },
            }) {
              Scroll() {
                Column({ space: 4 }) {
                  if (this.selectedDates.length) {
                    ForEach(this.selectedDates, (item: Date) => {
                      Text(item.toLocaleDateString())
                    })
                  } else {
                    Text('请选择您的日期')
                  }
                }
              }.constraintSize({ maxHeight: 200, minHeight: 40 })
            }
          }.rowStyle()

          Row() {
            Text('半模态弹窗，点击日期有事件：').textStyle()
            UICalendarPicker({
              type: TypePicker.RANGE,
              dialogType: DialogType.SHEET,
              onClickDate: (date) => {
                this.getUIContext().getPromptAction().showToast({ message: '点击了日期:' + date });
              },
            })
          }.rowStyle()
        }
        .width('100%')
      }
      .padding(16)
      .height('100%')
      .edgeEffect(EdgeEffect.Spring)
      .align(Alignment.TopStart)
    }
    .title('定制参数')
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }
}
```

### 示例5

```typescript
import {
  CalendarPickerUtil, DialogType, SwiperDirection, TypePicker,
} from '@hw-agconnect/ui-calendar-picker';

@Extend(Row)
function rowStyle() {
  .width('100%')
  .justifyContent(FlexAlign.SpaceBetween)
  .padding(16)
  .borderRadius(12)
  .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
}

@Extend(Text)
function textStyle() {
  .margin({ right: 20 })
  .layoutWeight(1)
}

@Entry
@ComponentV2
struct CalendarPickerSample5 {
  @Local selectedDate: Date = new Date(2024, 2, 1);
  @Local selectedDates: Date[] = [];

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 10 }) {
          Row() {
            Text('Api方式拉起常规弹窗，单选：').textStyle()
            Button('点击')
              .onClick(() => {
                CalendarPickerUtil.show({
                  type: TypePicker.SINGLE,
                  dialogType: DialogType.DIALOG,
                  startYear: 2024,
                  endYear: 2034,
                  onSelected: (date) => {
                    this.toast(date)
                  },
                })
              })
          }.rowStyle()

          Row() {
            Text('Api方式拉起半模态弹窗，单选：').textStyle()
            Button('点击')
              .onClick(() => {
                CalendarPickerUtil.show({
                  type: TypePicker.SINGLE,
                  dialogType: DialogType.SHEET,
                  startYear: 2024,
                  endYear: 2034,
                  onSelected: (date) => {
                    this.toast(date)
                  },
                })
              })
          }.rowStyle()

          Row() {
            Text('Api方式拉起半模态弹窗，纵向滑动，单选：').textStyle()
            Button('点击')
              .onClick(() => {
                CalendarPickerUtil.show({
                  type: TypePicker.SINGLE,
                  dialogType: DialogType.SHEET,
                  swiperDirection: SwiperDirection.VERTICAL,
                  startYear: 2024,
                  endYear: 2034,
                  onSelected: (date) => {
                    this.toast(date)
                  },
                })
              })
          }.rowStyle()

          Row() {
            Text('Api方式拉起半模态弹窗，设置range范围，多选：').textStyle()
            Button('点击')
              .onClick(() => {
                CalendarPickerUtil.show({
                  type: TypePicker.MULTIPLE,
                  dialogType: DialogType.SHEET,
                  rangeLimit: [new Date()],
                  onSelected: (date) => {
                    this.toast(date)
                  },
                })
              })
          }.rowStyle()

          Row() {
            Text('Api方式拉起半模态弹窗，设置禁选日期，多选：').textStyle()
            Button('点击')
              .onClick(() => {
                CalendarPickerUtil.show({
                  type: TypePicker.MULTIPLE,
                  dialogType: DialogType.SHEET,
                  disabledDates: [
                    new Date(),
                    new Date('2025-10-15'),
                    new Date('2025-11-20'),
                    new Date('2025-12-25'),
                  ],
                  onSelected: (date) => {
                    this.toast(date)
                  },
                })
              })
          }.rowStyle()

          Row() {
            Text('Api方式拉起半模态弹窗，设置最大跨度，时间段选择：').textStyle()
            Button('点击')
              .onClick(() => {
                CalendarPickerUtil.show({
                  type: TypePicker.RANGE,
                  dialogType: DialogType.SHEET,
                  maxGap: 3,
                  onSelected: (date) => {
                    this.toast(date)
                  },
                })
              })
          }.rowStyle()
        }
        .width('100%')
      }
      .padding(16)
      .height('100%')
      .edgeEffect(EdgeEffect.Spring)
      .align(Alignment.TopStart)
    }
    .title('Api方式拉起选择器')
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }

  toast(date: Date | Date[]) {
    let message = ''
    if (date instanceof Date) {
      message = date.toLocaleDateString()
    } else {
      message = date.map((item) => item.toLocaleDateString()).join(';')
    }
    try {
      this.getUIContext().getPromptAction().showToast({ message: JSON.stringify(message) })
    } catch (err) {
      console.error('open toast failed. error:' + JSON.stringify(err))
    }
  }
}
```

### 示例6

```typescript
import { SwiperDirection, TypePicker, UICalendarPicker } from '@hw-agconnect/ui-calendar-picker';
import { LengthMetrics } from '@kit.ArkUI';

@Entry
@ComponentV2
struct CalendarPickerSample6 {
  @Local
  selected: Date | undefined = undefined
  @Local
  selectDates: Date[] = []
  @Local
  latestClick: Date | undefined = undefined
  @Local
  type: TypePicker = TypePicker.SINGLE
  @Local
  swiperDirection: SwiperDirection = SwiperDirection.HORIZONTAL
  @Local
  disabledDates: Date[] = []
  @Local
  enableSelectTime: boolean = false
  @Local
  refresh: boolean = false

  @Computed
  get selectDateLabel() {
    if (!this.selected) {
      return '--'
    }
    const dateStr = this.selected.toLocaleDateString()
    const timeStr = this.selected.toLocaleTimeString()
    return this.enableSelectTime ? dateStr + ' ' + timeStr : dateStr
  }

  @Computed
  get selectDatesLabel() {
    if (!this.selectDates.length) {
      return '--'
    }
    return this.selectDates.map((item) => item.toLocaleDateString()).join('; ')
  }

  getTypeLabel() {
    if (this.type === TypePicker.SINGLE) {
      return '单选'
    } else if (this.type === TypePicker.MULTIPLE) {
      return '多选'
    } else {
      return '范围'
    }
  }

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 10 }) {
          Column({ space: 16 }) {
            Text('最后一次点击的日期：' + (this.latestClick ? this.latestClick.toLocaleDateString() : '--'))
            Text('单选时选中的日期：' + (this.selectDateLabel))
            Text('多日期或范围选中的日期：' + this.selectDatesLabel)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')

          Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.px(12), cross: LengthMetrics.px(12) } }) {
            Button('切换单选/多选/范围')
              .onClick(() => {
                this.refreshDisplay(() => {
                  this.type = (this.type + 1) % 3 + 1
                  this.toast('当前选择类型：' + this.getTypeLabel())
                })
              })
            Button('切换横向翻页/纵向滚动展示')
              .onClick(() => {
                this.refreshDisplay(() => {
                  this.swiperDirection =
                    this.swiperDirection === SwiperDirection.HORIZONTAL ? SwiperDirection.VERTICAL :
                      SwiperDirection.HORIZONTAL
                  this.toast('当前展示方向：' + (this.swiperDirection === SwiperDirection.HORIZONTAL ? '横向' : '纵向'))
                })
              })
            Button('是否展示禁选日期')
              .onClick(() => {
                this.refreshDisplay(() => {
                  if (!this.disabledDates.length) {
                    this.disabledDates = [new Date()]
                  } else {
                    this.disabledDates = []
                  }
                  this.toast('是否支持展示禁选日期：' + (this.disabledDates.length ? '是' : '否'))
                })
              })
            Button('是否支持选择时间（仅单日期以及横向滑动）')
              .onClick(() => {
                this.refreshDisplay(() => {
                  this.enableSelectTime = !this.enableSelectTime
                  this.toast('是否支持选择时间：' + (this.enableSelectTime ? '是' : '否'))
                })
              })
          }

          if (!this.refresh) {
            UICalendarPicker({
              embedded: true,
              type: this.type,
              swiperDirection: this.swiperDirection,
              disabledDates: this.disabledDates,
              enableSelectTime: this.enableSelectTime,
              startYear: 2025,
              endYear: 2025,
              onClickDate: (date) => {
                this.latestClick = date;
                if (this.type === TypePicker.SINGLE) {
                  this.selected = date
                } else if (this.type === TypePicker.MULTIPLE) {
                  if (this.selectDates.some((item) => item.toLocaleDateString() === date.toLocaleDateString())) {
                    this.selectDates =
                      this.selectDates.filter((item) => item.toLocaleDateString() !== date.toLocaleDateString())
                  } else {
                    this.selectDates.push(date)
                  }
                } else {
                  if (this.selectDates.length === 2) {
                    this.selectDates = []
                  }
                  this.selectDates.push(date)
                }
                this.selectDates.sort((a, b) => a.getTime() - b.getTime())
              },
            })
              .backgroundColor('#ffffff')
              .layoutWeight(1)
          } else {
            LoadingProgress().width(32)
          }
        }
        .width('100%')
      }
      .padding(16)
      .height('100%')
      .edgeEffect(EdgeEffect.Spring)
      .align(Alignment.TopStart)
    }
    .title('在页面中直接嵌入日期选择')
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }

  refreshDisplay(callback: () => void) {
    this.refresh = true
    this.selected = undefined
    this.selectDates = []
    setTimeout(() => {
      callback()
      this.refresh = false
    }, 200)
  }

  toast(message: string) {
    try {
      this.getUIContext().getPromptAction().showToast({ message: JSON.stringify(message) })
    } catch (err) {
      console.error('open toast failed. error:' + JSON.stringify(err))
    }
  }
}
```

## 更新记录

### 2.0.1 (2025-12-12)

下载该版本

内部资源更新

### 2.0.0 (2025-10-21)

下载该版本

（1）从2.0.*版本开始，组件已使用状态管理V2版本，如果您开发工程使用V1版本，请下载1.0.X版本。关于状态管理V1和V2版本的区别，请参见"状态管理版本介绍"。
（2）新增支持使用API方式调用选择器
（3）新增支持日历选择器嵌入页面

### 1.0.3 (2025-09-30)

下载该版本

修复时间段选择bug

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
|----------|----------|----------|
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK合规使用指南

不涉及

## 兼容性

### HarmonyOS版本

| 版本 | 支持情况 |
|------|----------|
| 5.0.0 | ✓ |
| 5.0.1 | ✓ |
| 5.0.2 | ✓ |
| 5.0.3 | ✓ |
| 5.0.4 | ✓ |
| 5.0.5 | ✓ |
| 5.1.0 | ✓ |
| 5.1.1 | ✓ |
| 6.0.0 | ✓ |
| 6.0.1 | ✓ |

### 应用类型

| 类型 | 支持情况 |
|------|----------|
| 应用 | ✓ |
| 元服务 | ✓ |

### 设备类型

| 类型 | 支持情况 |
|------|----------|
| 手机 | ✓ |
| 平板 | ✓ |
| PC | ✓ |

### DevEcoStudio版本

| 版本 | 支持情况 |
|------|----------|
| DevEco Studio 5.0.0 | ✓ |
| DevEco Studio 5.0.1 | ✓ |
| DevEco Studio 5.0.2 | ✓ |
| DevEco Studio 5.0.3 | ✓ |
| DevEco Studio 5.0.4 | ✓ |
| DevEco Studio 5.0.5 | ✓ |
| DevEco Studio 5.1.0 | ✓ |
| DevEco Studio 5.1.1 | ✓ |
| DevEco Studio 6.0.0 | ✓ |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-calendar-picker
```

## 来源

- 原始URL: https://developer.huawei.com/consumer/cn/market/prod-detail/23ebcd87854048bab42048e8f88dc24e/2adce9bbd4cb42d58a87e6add45594b3?origin=template