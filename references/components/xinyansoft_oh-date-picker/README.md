# oh date picker 日期选择组件

## 简介

Openharmony & HarmonyOS 平台日期选择器增强版，支持选择年月、年月日、年月日时分等多种格式

## 详细介绍

### 简介

oh-date-picker，Openharmony & HarmonyOS 平台日期选择器增强版，支持选择年月、年月日、年月日时分等多种格式。

### 效果图参考

*   年月
*   年月日
*   年月日时分
*   年月日时分秒
*   时分秒
*   时分
*   分秒

### 接口说明

深色代码主题复制

```typescript
DateTimePicker({
    // 主要配置项
    config: {
      format: DateTimeFormat.YmdHm, // 时间格式
      start: '1900-01-01 00:00',  // 开始时间
      end: '2099-12-31 23:59', // 结束时间
      selected: DateUtil.getTodayStr('yyyy-MM-dd HH:mm') // 初始选中时间
    },
    // 后缀模式：独立和非独立模
    // 独立模式：后缀是独立的 Text 控件，不可滚动
    // 非独立模式：每个数据项都带有后缀，跟随数据项滚动
    suffixMode: SuffixMode.Together, 
    suffixes: {  // 后缀文字
      year: '年',
      month: '月',
      day: '日',
      hour: '时',
      minute: '分',
      second: '秒'
    },
    suffixTextStyle: { // 后缀文字样式，仅在后缀模式为独立模式时生效
      font: {
        size: 15
      },
      color: Color.Black
    },
    // 以下三个样式属性参见 TextPicker
    selectedTextStyle: {
      font: {
        size: 15
      },
      color: Color.Black
    },
    disappearTextStyle: {
      font: {
        size: 13
      },
      color: Color.Black
    },
    textStyle: {
      font: {
        size: 13
      }
    },
    
    // 选择回调
    onSelectedCallback: (selected) => {
      this.selected = selected
    },
  
    // 循环模式：Auto，Enable，Disable
    // Auto: 数据项大于 3 项时可以循环滚动
    // Enable: 无论数据项多少都可以循环滚动
    // Disable: 无论数据项多少都不可以循环滚动
    loopMode: LoopMode.Auto
})
```

### 使用示例

```typescript
import { DateTimeFormat, DateTimePicker, DateUtil, SuffixMode } from 'date-time-picker'
import { DateTime, DateTimePickerConfig } from 'date-time-picker/src/main/ets/components/DateTimePicker'

@Entry
@Component
struct Index {
  @State @Watch('conConfigChanged') config : DateTimePickerConfig = {
    format: DateTimeFormat.YmdHm,
    start: '1900-01-01 00:00',
    end: '2099-12-31 23:59',
    selected: DateUtil.getTodayStr('yyyy-MM-dd HH:mm')
  }
  @State suffixMode: SuffixMode = SuffixMode.Together
  @State selected: DateTime = new DateTime(this.config.format, this.config.selected)

  conConfigChanged() {
    this.selected = new DateTime(this.config.format, this.config.selected)
  }

  build() {
    Column() {
      DateTimePicker({
        config: this.config,
        suffixMode: this.suffixMode,
        selectedTextStyle: {
          font: {
            size: 15
          },
          color: Color.Black
        },
        textStyle: {
          font: {
            size: 13
          }
        },
        suffixTextStyle: {
          font: {
            size: 15
          },
          color: Color.Black
        },
        onSelectedCallback: (selected) => {
          this.selected = selected
        }
      }).width('100%')

      Blank()
      Text(`当前选择：${this.selected.format()}`)
      Blank()

      Row() {
        Button('年月', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
          .backgroundColor(0x317aff)
          .width(90)
          .onClick(() => {
            this.config = {
              format : DateTimeFormat.Ym,
              start : '1900-08',
              end : '2100-08',
              selected : '2024-08'
            }
          })

        Button('年月日', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
          .backgroundColor(0x317aff)
          .width(90)
          .onClick(() => {
            this.config = {
              format : DateTimeFormat.Ymd,
              start : '1900-08-29',
              end : '2100-08-29',
              selected : '2024-08-29'
            }
          })

        Button('年月日时分', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
          .backgroundColor(0x317aff)
          .width(90)
          .onClick(() => {
            this.config = {
              format : DateTimeFormat.YmdHm,
              start : '1900-08-29 12:00',
              end : '2100-08-29 12:00',
              selected : '2024-08-29 12:00'
            }
          })
      }.width('100%')
      .height(52)
      .justifyContent(FlexAlign.SpaceAround)

      Row() {
        Button('年月日时分秒', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
          .backgroundColor(0x317aff)
          .width(90)
          .onClick(() => {
            this.config = {
              format : DateTimeFormat.YmdHms,
              start : '1900-08-29 12:00:00',
              end : '2100-08-29 12:00:00',
              selected : '2024-08-29 12:00:00'
            }
          })
        Button('时分秒', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
          .backgroundColor(0x317aff)
          .width(90)
          .onClick(() => {
            this.config = {
              format : DateTimeFormat.Hms,
              start : '00:00:00',
              end : '12:00:00',
              selected : '06:00:00'
            }
          })
        Button('时分', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
          .backgroundColor(0x317aff)
          .width(90)
          .onClick(() => {
            this.config = {
              format : DateTimeFormat.Hm,
              start : '00:00',
              end : '12:00',
              selected : '06:00'
            }
          })
      }.width('100%')
      .height(52)
      .justifyContent(FlexAlign.SpaceAround)

      Row() {
        Button('分秒', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
          .backgroundColor(0x317aff)
          .width(90)
          .onClick(() => {
            this.config = {
              format : DateTimeFormat.Ms,
              start : '00:00',
              end : '12:00',
              selected : '06:00'
            }
          })
        Button('后缀独立', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
          .backgroundColor(0x317aff)
          .width(90)
          .onClick(() => {
            this.suffixMode = SuffixMode.Separated
          })
        Button('后缀非独立', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
          .backgroundColor(0x317aff)
          .width(90)
          .onClick(() => {
            this.suffixMode = SuffixMode.Together
          })
      }.width('100%')
      .height(52)
      .justifyContent(FlexAlign.SpaceAround)

    }.width('100%')
    .height('100%')
  }
}
```

## 开源协议

Apache 2.0

## 更新记录

**0.0.7 (2025-10-25)**

暂无权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

隐私政策不涉及 SDK 合规使用指南 不涉及

兼容性 HarmonyOS 版本 5.0.0

Created with Pixso.

应用类型 应用

Created with Pixso.

元服务

Created with Pixso.

设备类型 手机

Created with Pixso.

平板

Created with Pixso.

PC

Created with Pixso.

DevEcoStudio 版本 DevEco Studio 5.0.0

Created with Pixso.

## 安装方式

```bash
ohpm install @xinyansoft/oh-date-picker
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/ea4589c8fc8b4e858b85a824a2ab50da/PLATFORM?origin=template