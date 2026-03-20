# 倒计时 UICountdown

## 简介

UICountdown 是基于 open harmony 基础组件开发的倒计时组件，支持动态赋值、自由控制开始暂停等功能。

## 详细介绍

### 简介

UICountdown 是基于 open harmony 基础组件开发的倒计时组件，支持动态赋值、自由控制开始暂停等功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、平板
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

我们提供两种方式：ohpm 快速集成和下载源码包手工集成，您可以根据需要选择合适的方式，下面以 ohpm 快速集成为例，描述完整集成方法。

### 使用

#### 安装组件

```bash
ohpm install @hw-agconnect/ui-countdown
```

当前模板已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请参考以下命令获取 1.0.0 版本模板。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。

```bash
ohpm install @hw-agconnect/ui-countdown@1.0.0
```

#### 引入组件

```typescript
import { UICountdown, Controller } from '@hw-agconnect/ui-countdown'
```

#### 调用组件

详细参数配置说明参见 API 参考。

```typescript
UICountdown({
  day: '1',
  hour: '1',
  minute: '12',
  second: '40',
  controller: this.controller
})
```

## API 参考

### 子组件

无

### 接口

`UICountdown(options: UICountdownOptions)`

倒计时组件。

#### 参数说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UICountdownOptions | 否 | 配置倒计时组件的参数。 |

#### UICountdownOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| controller | Controller | 否 | 倒计时组件的控制器 |
| timeBackgroundColor | ResourceColor | 否 | 时间背景色 |
| timeColor | ResourceColor | 否 | 文字颜色 |
| splitorColor | ResourceColor | 否 | 分割符号颜色 |
| day | string \| number | 否 | 天<br>说明：若低于 0 则显示 0，非数字则显示 0，若大于等于 24 小时则自动进位为 1 天 |
| hour | string \| number | 否 | 小时<br>说明：若低于 0 则显示 0，非数字则显示 0；若大于等于 60 分钟则自动进位为 1 小时 |
| minute | string \| number | 否 | 分钟<br>说明：若低于 0 则显示 0，非数字则显示 0；若大于等于 60 分钟则自动进位为 1 小时 |
| second | string \| number | 是 | 秒<br>说明：若低于 0 则显示 0，非数字则显示 0; 若显示其他时间且大于等于 60 秒则自动进位为 1 分钟；若只显示秒，不显示其他时间，则超过 60 秒不会进位 |
| showDay | boolean | 否 | 是否显示天数 |
| showHour | boolean | 否 | 是否显示小时 |
| showMinute | boolean | 否 | 是否显示分钟 |
| showColon | boolean | 否 | 是否以冒号为分隔符 |
| fontSize | number | 否 | 字体大小，单位为 vp |
| start | boolean | 否 | 是否初始化组件后就开始倒计时 |
| timeup | callback: () => void | 否 | 倒计时结束触发事件 |

#### Controller 方法说明

| 名称 | 功能描述 |
| :--- | :--- |
| update() | 控制倒计时组件刷新的事件 |

## 示例代码

```typescript
import { UICountdown, Controller } from '@hw-agconnect/ui-countdown'
import { TipsDialog } from '@kit.ArkUI';

@Extend(Text)
function titleStyle() {
  .fontSize(16)
  .margin({ top: 16, bottom: 8 })
  .fontWeight(FontWeight.Bold)
  .width('100%')
}

@Extend(Text)
function startStyle(fontColor: ResourceStr, bgColor: ResourceStr) {
  .fontSize(12)
  .fontColor(fontColor)
  .padding({
    top: 6,
    bottom: 6,
    left: 12,
    right: 12
  })
  .borderRadius(14)
  .backgroundColor(bgColor)
  .margin({ right: 8 })
}

@Entry
@ComponentV2
struct UICountdownSample {
  private controller = new Controller()
  // 背景色
  @Local timeBackgroundColor: ResourceColor = ''
  // 是否显示天数
  @Local showDay: boolean = true
  // 是否显示小时
  @Local showHour: boolean = true
  // 是否显示分钟
  @Local showMinute: boolean = true
  // 是否以冒号为分隔符
  @Local showColon: boolean = false
  // 是否初始化组件后就开始倒计时
  @Local start: boolean = true
  // 字体大小
  @Local fontSize: number = 14
  // 分
  @Local min: string = '30'
  // 秒
  @Local s: string = '0'
  // 控制器
  scroller: Scroller = new Scroller()

  timeup() {
    this.dialogControllerImage.open()
  }

  dialogControllerImage: CustomDialogController = new CustomDialogController({
    builder: TipsDialog({
      content: '倒计时结束',
      primaryButton: {
        value: '确定',
        action: () => {
          console.info('Callback when the first button is clicked')
        },
      }
    }),
  })

  @Builder
  buildTitleBar() {
    Text('Countdown')
      .fontSize(24)
      .fontWeight(FontWeight.Medium)
      .height(56)
      .width('100%')
      .padding({ left: 16, right: 16 })
  }

  build() {
    NavDestination() {
      Scroll() {
        Column() {
          Text('一般用法').titleStyle().margin({ top: 0, bottom: 8 })
          UICountdown({
            day: '1',
            hour: '1',
            minute: '12',
            second: '40'
          }).backgroundColor($r('sys.color.ohos_id_color_list_card_bg')).width('100%').padding(14).borderRadius(10)

          Text('不显示天数').titleStyle()
          UICountdown({
            showDay: false,
            hour: '12',
            minute: '12',
            second: '12'
          }).backgroundColor($r('sys.color.ohos_id_color_list_card_bg')).width('100%').padding(14).borderRadius(10)

          Text('只显示秒数').titleStyle()
          UICountdown({
            second: '120',
            showDay: false,
            showHour: false,
            showMinute: false,
            showColon: false,
            timeup: () => {
              this.timeup()
            }
          }).backgroundColor($r('sys.color.ohos_id_color_list_card_bg')).width('100%').padding(14).borderRadius(10)

          Text('文字分隔符').titleStyle()
          UICountdown({ showColon: false, minute: '30', second: '0' })
            .backgroundColor($r('sys.color.ohos_id_color_list_card_bg'))
            .width('100%')
            .padding(14)
            .borderRadius(10)

          Text('修改字体大小和颜色').titleStyle()
          UICountdown({
            minute: '30',
            second: '0',
            fontSize: 28,
            timeColor: $r('sys.color.ohos_id_color_text_primary_contrary'),
            timeBackgroundColor: $r('sys.color.ohos_id_color_text_primary_activated')
          }).backgroundColor($r('sys.color.ohos_id_color_list_card_bg')).width('100%').padding(14).borderRadius(10)

          Text('自由控制开始/暂停').titleStyle().onClick(() => {
            this.start = !this.start
          })
          Column() {
            UICountdown({
              minute: this.min,
              second: this.s,
              start: this.start,
              controller: this.controller
            })
            Row() {
              Text('开始')
                .startStyle($r('sys.color.ohos_id_color_emphasize'), $r('sys.color.ohos_id_color_button_normal'))
                .onClick(() => {
                  this.start = true
                })
              Text('暂停')
                .startStyle($r('sys.color.ohos_id_color_alert'), $r('sys.color.ohos_id_color_button_normal'))
                .onClick(() => {
                  this.start = false
                })
              Text('重置')
                .startStyle($r('sys.color.ohos_id_color_text_secondary'), $r('sys.color.ohos_id_color_button_normal'))
                .onClick(() => {
                  this.controller.update()
                })
            }.margin({ top: 8 })
          }
          .alignItems(HorizontalAlign.Start)
          .backgroundColor($r('sys.color.ohos_id_color_list_card_bg'))
          .width('100%')
          .padding(14)
          .borderRadius(10)

          Text('倒数计时回调').titleStyle()
          UICountdown({
            second: '20',
            timeup: () => {
              this.timeup()
            }
          }).backgroundColor($r('sys.color.ohos_id_color_list_card_bg')).width('100%').padding(14).borderRadius(10)
        }
        .backgroundColor($r('sys.color.ohos_id_color_bottom_tab_sub_bg'))
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding(12)
      }.scrollBar(BarState.Off)
    }
    .title(this.buildTitleBar())
    .backgroundColor($r('sys.color.ohos_id_color_bottom_tab_sub_bg'))
  }
}
```

## 更新记录

### 2.0.0 (2025-11-04)

下载该版本。从 2.0.*版本开始，组件已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请下载 1.0.X 版本。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。

### 1.0.0 (2025-09-30)

下载该版本。初始版本。

## 基本信息

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0 <br> 5.0.1 <br> 5.0.2 <br> 5.0.3 <br> 5.0.4 <br> 5.0.5 |
| **应用类型** | 应用 <br> 元服务 |
| **设备类型** | 手机 <br> 平板 <br> PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.0 <br> DevEco Studio 5.0.1 <br> DevEco Studio 5.0.2 <br> DevEco Studio 5.0.3 <br> DevEco Studio 5.0.4 <br> DevEco Studio 5.0.5 <br> DevEco Studio 5.1.0 <br> DevEco Studio 5.1.1 <br> DevEco Studio 6.0.0 |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-countdown
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/cbdc97a2327a42619f20af2a9e8eb553/2adce9bbd4cb42d58a87e6add45594b3?origin=template