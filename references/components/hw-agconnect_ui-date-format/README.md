# 日期格式化组件 UIDateFormat

## 简介

UIDateFormat 是基于 open harmony 的 I18N 国际化模块开发的日期格式化组件。支持绝对时间、相对时间和时间段三种类型的显示效果，支持跟随系统语言或特定语言类型的切换。支持其他自定义格式化规则，并提供常用的格式化样式。

## 详细介绍

### 简介

UIDateFormat 是基于 open harmony 的 I18N 国际化模块开发的日期格式化组件。支持绝对时间、相对时间和时间段三种类型的显示效果，支持跟随系统语言或特定语言类型的切换。支持其他自定义格式化规则，并提供常用的格式化样式。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、平板
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

我们提供两种方式：ohpm 快速集成和下载源码包手工集成，您可以根据需要选择合适的方式，下面以 ohpm 快速集成为例，描述完整集成方法。

## 使用

### 安装组件

```bash
ohpm install @hw-agconnect/ui-date-format;
```

当前组件已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请参考以下命令获取 1.0.0 版本组件。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。

```bash
ohpm install @hw-agconnect/ui-date-format@1.0.0;
```

### 引入组件

```typescript
import { FormatStyle, UIDateFormat } from '@hw-agconnect/ui-date-format';
```

### 调用组件

详细参数配置说明参见 API 参考。

```typescript
UIDateFormat({
     /** 内容控制 **/
     time: '2021',
     baseTime: '2020',
     format: 'YYYY',
     style: FormatStyle.ONLY_DATE,
     isPeriod: true,
     locale: 'en',

     /** 样式控制 **/
     fontColor: Color.Pink,
     fontSize: 14,
     fontWeight: 500,
     fontStyle: FontStyle.Italic,
     hasBg: true,
     bgRadius: 0,
     bgColor: Color.Gray,
     alpha: 0.3
})
```

## API 参考

### 子组件

无

### 接口

`UIDateFormat(options: UIDateFormatOptions)`

日期格式化组件。

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UIDateFormatOptions | 是 | 配置日期格式化组件的参数。 |

#### UIDateFormatOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| time | string \| number \| Date | 是 | 格式化时间。baseTime 不存在时显示绝对时间。 |
| baseTime | string \| number \| Date | 否 | 基准时间，作为时间段或相对时间的起点。时间段或相对时间时必须提供。isPeriod 为空或 false 时，切换为相对时间。 |
| format | string | 否 | 自定义格式化规则，默认‘YYYY/MM/DD hh:mm:ss’。具体规则见下表 format 参数规则说明。 |
| style | FormatStyle | 否 | 内置格式化样式。 |
| isPeriod | boolean | 否 | 是否切换时间段，默认 false。时间段不得低于 1 天。 |
| locale | string | 否 | 默认跟随系统语言，设置后覆盖。示例：‘zh-TW’，‘en-GB’。 |
| fontColor | ResourceColor | 否 | 字体颜色，同鸿蒙。 |
| fontSize | Length | 否 | 字体大小，同鸿蒙。 |
| fontWeight | FontWeight | 否 | 字体粗细，同鸿蒙。 |
| fontStyle | FontStyle | 否 | 字体倾斜，同鸿蒙。 |
| hasBg | boolean | 否 | 是否显示背景，默认 false。 |
| bgRadius | Length | 否 | 背景圆角。 |
| bgColor | ResourceColor | 否 | 背景颜色。 |
| alpha | number | 否 | 背景不透明度。 |

#### FormatStyle 枚举说明

| 名称 | 示例（2020-02-02 22:02:02） |
| :--- | :--- |
| FULL_DATE_FULL_TIME | 2020 年 2 月 2 日星期日 中国标准时间 下午 10:02:02 |
| FULL_DATE_LONG_TIME | 2020 年 2 月 2 日星期日 GMT+8 下午 10:02:02 |
| MEDIUM_DATE_SHORT_TIME | 2020 年 2 月 2 日 下午 10:02 |
| SHORT_DATE_LONG_TIME | 2020/2/2 GMT+8 下午 10:02:02 |
| SHORT_DATE_SHORT_TIME | 2020/2/2 下午 10:02 |
| DATE_WITH_ERA | 公元 2020-02-02 |
| ONLY_DATE | 2020 年 2 月 2 日 |
| ONLY_TIME_H12 | 下午 10:02 |
| ONLY_TIME_H12_WITH_SECOND | 下午 10:02:02 |
| ONLY_TIME_H24 | 22:02 |
| ONLY_TIME_H24_WITH_SECOND | 22:02:02 |
| FULL_DATE_WITH_WEEK | 2020 年 2 月 2 日星期日 |
| NARROW_DATE_SHORT_TIME | 02/02 22:02 |

#### format 参数规则说明

正则替换：

| 字符 | 说明（不足补 0） |
| :--- | :--- |
| YYYY | 四位年份 |
| YY | 两位年份 |
| MM | 两位月份 |
| M | 月份 |
| DD | 两位天份 |
| D | 天 |
| hh | 两位小时 |
| h | 时 |
| mm | 两位分钟 |
| m | 分钟 |
| ss | 两位秒 |
| s | 秒 |
| SSS | 三位毫秒 |
| S | 毫秒 |

## 示例代码

### 异常示例

time 格式错误。

- 月份、天份、时、分、秒，超出范围；
- 后半段，仅传入小时。比如‘2020/10/20 20’；
- ......

baseTime 格式错误。

- 同上

相对时间不能为 0。

- time 和 baseTime 是转换成 Date 对象后进行计算的，因此‘2020/1'和‘2020/1/1'实际上是同一时间。

```typescript
import { UIDateFormat } from '@hw-agconnect/ui-date-format';

@Entry
@ComponentV2
struct ErrorUse {
  build() {
    Navigation() {
      Scroll(){
        Column({ space: 12 }) {
          CardItem({ title: '越界输入' }) {
            // time 格式错误
            UIDateFormat({ time: '2020/13/25' })
          }

          CardItem({ title: '仅输入小时' }) {
            // time 格式错误
            UIDateFormat({ time: '2020/02/02 10' })
          }

          CardItem({ title: '非法格式' }) {
            // time 格式错误
            UIDateFormat({ time: new Date('AABB') })
          }

          CardItem({ title: '基准时间同上' }) {
            // baseTime 格式错误
            UIDateFormat({ time:'2020/10/25',baseTime:'2020/13/25'  })
          }

          CardItem({ title: '获取相对时间' }) {
            // 相对时间不能为 0
            UIDateFormat({ time: '2020/1', baseTime: '2020/1/1' })
          }
        }.alignItems(HorizontalAlign.Start)
      }.scrollBar(BarState.Off)
    }
    .title('错误使用')
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
    .padding(10)
    .width('100%')
    .height('100%')
  }
}

@ComponentV2
struct CardItem {
  @Param title: string = '';

  @Builder
  customBuilder() {};

  @BuilderParam ui: () => void = this.customBuilder;

  build() {
    Column() {
      Text(this.title).position({ x: -14, y: -16 }).fontSize(13).fontColor($r('sys.color.ohos_fa_text_primary'))
      this.ui()
    }
    .width('100%').borderRadius(16)
    .padding(20)
    .backgroundColor($r('sys.color.ohos_id_color_foreground_contrary_disable'))
  }
}
```

### 正面示例

#### 基本使用

```typescript
import { FormatStyle, UIDateFormat } from '@hw-agconnect/ui-date-format';

@Entry
@ComponentV2
struct BasicUse {
  build() {
    Navigation() {
      Scroll() {
        Column({ space: 12 }) {
          CardItem({ title: '输入字符串' }) {
            // 2020/01/01 00:00:00
            UIDateFormat({ time: '2020/01' })
          }

          CardItem({ title: '输入时间戳' }) {
            // 2020/10/20 20:20:20
            UIDateFormat({ time: 1603196420000 })
          }

          CardItem({ title: '输入日期对象' }) {
            // 2020/01/01 00:00:00
            UIDateFormat({ time: new Date('2020/01') })
          }

          CardItem({ title: '自定义规则' }) {
            // 20 年 1 月 1 日 1 时 1 分 1 秒 0 毫秒
            UIDateFormat({ time: '2020/01/01 1:1:1', format: 'YY 年 M 月 D 日 h 时 m 分 s 秒 S 毫秒' })
          }

          CardItem({ title: '内置样式' }) {
            // 公元 2020-01-01
            UIDateFormat({ time: '2020/01/01 1:1:1', style: FormatStyle.DATE_WITH_ERA })
          }

          CardItem({ title: '显示时间段' }) {
            // 2020/1/1-2020/2/1
            UIDateFormat({ time: '2020/02', baseTime: '2020/01', isPeriod: true })
          }

          CardItem({ title: '显示相对时间（正）' }) {
            // 1 年后
            UIDateFormat({ time: '2021', baseTime: '2020' })
          }

          CardItem({ title: '显示相对时间（逆）' }) {
            // 1 年前
            UIDateFormat({ time: '2020', baseTime: '2021' })
          }

          CardItem({ title: '多语言（台湾）' }) {
            // 西元 2020/1/1
            UIDateFormat({ time: '2020', locale: 'zh-tw', style: FormatStyle.DATE_WITH_ERA })
          }
        }.alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
    }
    .title('基本使用')
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
    .padding(10)
    .width('100%')
    .height('100%')
  }
}

@ComponentV2
struct CardItem {
  @Param title: string = '';

  @Builder
  customBuilder() {
  };

  @BuilderParam ui: () => void = this.customBuilder;

  build() {
    Column() {
      Text(this.title).position({ x: -14, y: -16 }).fontSize(13).fontColor($r('sys.color.ohos_fa_text_primary'))
      this.ui()
    }
    .width('100%').borderRadius(16)
    .padding(20)
    .backgroundColor($r('sys.color.ohos_id_color_foreground_contrary_disable'))
  }
}
```

#### 相对刻度

```typescript
import { UIDateFormat } from '@hw-agconnect/ui-date-format';

@Entry
@ComponentV2
struct RelativeUse {
  date1_1 = '2020';
  date1_2 = '2022';
  date2_1 = '2020/1';
  date2_2 = '2020/8';
  date3_1 = '2020/1';
  date3_2 = '2020/3';
  date4_1 = '2020/1/1';
  date4_2 = '2020/1/17';
  date5_1 = '2020/1/1';
  date5_2 = '2020/1/3';
  date6_1 = '2020/1/1 08:00';
  date6_2 = '2020/1/1 10:00';
  date7_1 = '2020/1/1 08:00';
  date7_2 = '2020/1/1 08:02';
  date8_1 = '2020/1/1 08:00:00';
  date8_2 = '2020/1/1 08:00:02';

  build() {
    Navigation() {
      Scroll(){
        Column({ space: 12 }) {
          CardItem({ title: '2020-2022' }) {
            // 2 年后
            UIDateFormat({ baseTime: this.date1_1, time: this.date1_2 })
          }

          CardItem({ title: '2020/1-2020/8' }) {
            // 2 个季度后
            UIDateFormat({ baseTime: this.date2_1, time: this.date2_2 })
          }

          CardItem({ title: '2020/1-2020/3' }) {
            // 2 个月后
            UIDateFormat({ baseTime: this.date3_1, time: this.date3_2 })
          }

          CardItem({ title: '2020/1/1-2020/1/17' }) {
            // 2 周后
            UIDateFormat({ baseTime: this.date4_1, time: this.date4_2 })
          }

          CardItem({ title: '2020/1/3-2020/1/1' }) {
            // 2 天前
            UIDateFormat({ time: this.date5_1, baseTime: this.date5_2 })
          }

          CardItem({ title: '2020/1/1 10:00-2020/1/1 08:00' }) {
            // 2 小时前
            UIDateFormat({ time: this.date6_1, baseTime: this.date6_2 })
          }

          CardItem({ title: '2020/1/1 08:02-2020/1/1 08:00' }) {
            // 2 分钟前
            UIDateFormat({ time: this.date7_1, baseTime: this.date7_2 })
          }

          CardItem({ title: '2020/1/1 08:00:02-2020/1/1 08:00:00' }) {
            // 2 秒前
            UIDateFormat({ time: this.date8_1, baseTime: this.date8_2 })
          }
        }.alignItems(HorizontalAlign.Start)
      }.scrollBar(BarState.Off)
    }
    .title('相对时间 - 正反')
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
    .padding(10)
    .width('100%')
    .height('100%')
  }
}

@ComponentV2
struct CardItem {
  @Param title: string = '';

  @Builder
  customBuilder() {};

  @BuilderParam ui: () => void = this.customBuilder;

  build() {
    Column() {
      Text(this.title).position({ x: -14, y: -16 }).fontSize(13).fontColor($r('sys.color.ohos_fa_text_primary'))
      this.ui()
    }
    .width('100%').borderRadius(16)
    .padding(20)
    .backgroundColor($r('sys.color.ohos_id_color_foreground_contrary_disable'))
  }
}
```

#### 自定义样式

```typescript
import { UIDateFormat } from '@hw-agconnect/ui-date-format';

@Entry
@ComponentV2
struct StyleChange {
  date = new Date()

  build() {
    Navigation() {
      Scroll() {
        Column({ space: 12 }) {
          CardItem({ title: '基础样式' }) {
            UIDateFormat({ time: this.date })
          }

          CardItem({ title: '字体颜色' }) {
            UIDateFormat({ time: this.date, fontColor: $r('sys.color.ohos_id_color_text_primary_activated') })
          }

          CardItem({ title: '字体大小' }) {
            UIDateFormat({ time: this.date, fontSize: $r('sys.float.ohos_id_text_size_body3') })
          }

          CardItem({ title: '字体粗细' }) {
            UIDateFormat({ time: this.date, fontWeight: FontWeight.Bold })
          }

          CardItem({ title: '字体倾斜' }) {
            UIDateFormat({ time: this.date, fontStyle: FontStyle.Italic })
          }

          CardItem({ title: '显示背景色' }) {
            UIDateFormat({ time: this.date, hasBg: true })
          }

          CardItem({ title: '自定义背景色' }) {
            UIDateFormat({
              time: this.date,
              hasBg: true,
              fontColor: '#ffffff',
              bgColor: '#0A59F7',
            })
          }

          CardItem({ title: '自定义透明度' }) {
            UIDateFormat({
              time: this.date,
              hasBg: true,
              fontColor: '#ffffff',
              bgColor: '#0A59F7',
              alpha: 0.4,
            })
          }

          CardItem({ title: '自定义圆角' }) {
            UIDateFormat({
              time: this.date,
              hasBg: true,
              fontColor: '#ffffff',
              bgColor: '#0A59F7',
              bgRadius: 0,
            })
          }
        }.alignItems(HorizontalAlign.Start)
      }.scrollBar(BarState.Off)
    }
    .title('样式修改')
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
    .padding(10)
    .width('100%')
    .height('100%')
  }
}

@ComponentV2
struct CardItem {
  @Param title: string = '';

  @Builder
  customBuilder() {
  };

  @BuilderParam ui: () => void = this.customBuilder;

  build() {
    Column() {
      Text(this.title).position({ x: -14, y: -16 }).fontSize(13).fontColor($r('sys.color.ohos_fa_text_primary'))
      this.ui()
    }
    .width('100%').borderRadius(16)
    .padding(20)
    .backgroundColor($r('sys.color.ohos_id_color_foreground_contrary_disable'))
  }
}
```

## 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 2.0.1 | 2025-12-12 | 下载该版本内部资源 |
| 2.0.0 | 2025-11-03 | 从 V2.0.*版本开始，组件已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请下载 1.0.0 版本。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。 |
| 1.0.0 | 2025-09-30 | 初始版本 |

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

| 版本 |
| :--- |
| 5.0.0 |
| 5.0.1 |
| 5.0.2 |
| 5.0.3 |
| 5.0.4 |
| 5.0.5 |
| 5.1.0 |
| 5.1.1 |
| 6.0.0 |
| 6.0.1 |

### 应用类型

| 类型 |
| :--- |
| 应用 |
| 元服务 |

### 设备类型

| 类型 |
| :--- |
| 手机 |
| 平板 |
| PC |

### DevEcoStudio 版本

| 版本 |
| :--- |
| DevEco Studio 5.0.0 |
| DevEco Studio 5.0.1 |
| DevEco Studio 5.0.2 |
| DevEco Studio 5.0.3 |
| DevEco Studio 5.0.4 |
| DevEco Studio 5.0.5 |
| DevEco Studio 5.1.0 |
| DevEco Studio 5.1.1 |
| DevEco Studio 6.0.0 |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-date-format
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/2704bbb046a54a9ab290ef979ae3d922/2adce9bbd4cb42d58a87e6add45594b3?origin=template