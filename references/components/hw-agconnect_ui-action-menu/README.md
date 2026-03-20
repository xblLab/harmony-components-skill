# 操作菜单 UIActionMenu

## 简介

UIActionMenu 是基于 open harmony 基础组件开发的组件，用于在屏幕底部弹出一个包含与当前情景相关的多个选项的模态面板，支持单行/多行显示，支持展示图片、状态、标题等多项自定义内容。

## 详细介绍

### 简介

UIActionMenu 是基于 open harmony 基础组件开发的组件，用于在屏幕底部弹出一个包含与当前情景相关的多个选项的模态面板，支持单行/多行显示，支持展示图片、状态、标题等多项自定义内容。

### 约束与限制

#### 环境

| 项目 | 要求 |
| :--- | :--- |
| DevEco Studio 版本 | DevEco Studio 5.0.0 Release 及以上 |
| HarmonyOS SDK 版本 | HarmonyOS 5.0.0 Release SDK 及以上 |
| 设备类型 | 华为手机（包括双折叠和阔折叠）、华为平板 |
| 系统版本 | HarmonyOS 5.0.0(12) 及以上 |

#### 权限

无

### 使用

#### 安装组件

```bash
ohpm install @hw-agconnect/ui-action-menu
```

#### 引入组件

```typescript
import { UIActionMenu } from '@hw-agconnect/ui-action-menu';
```

#### 调用组件

详细参数配置说明参见 [API 参考](#api-参考)。

### API 参考

#### UIActionMenu

**操作菜单**

`open(options: UIActionMenuOptions)`

创建并打开操作菜单。

**参数**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UIActionMenuOptions | 是 | 配置操作菜单组件的参数，用于设置操作菜单的标题栏、选项、取消按钮等属性。 |

**UIActionMenuOptions 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| sheetHeight | SheetSize \| Length | 否 | 操作菜单的高度，默认值为 `SheetSize.FIT_CONTENT` |
| sheetRadius | BorderRadiuses | 否 | 操作菜单的圆角，默认值为 `{ topLeft: 32, topRight: 32 }` |
| bgColor | ResourceColor | 否 | 操作菜单的背景颜色 |
| detents | `(SheetSize \| Length), (SheetSize \| Length)?, (SheetSize \| Length)?` | 否 | 操作菜单的高度切换档位 |
| preferType | SheetType | 否 | 操作菜单的样式，默认值为 `SheetType.CENTER` |
| mode | SheetMode | 否 | 操作菜单的显示层级，默认值为 `SheetMode.OVERLAY` |
| dragBar | boolean | 否 | 是否显示控制条，默认值为 `false` |
| title | SheetTitleOptions \| CustomBuilder | 否 | 标题区 |
| showClose | boolean | 否 | 是否显示关闭按钮，默认值为 `false` |
| actions | `(UIActionType \| string)[]` \| `UIActionMultiLine[][]` | 否 | 选项列表，支持单行单列和单行多列两种形式 |
| cancelText | ResourceStr | 否 | 取消按钮的文字 |
| closeOnClickMask | boolean | 否 | 是否允许点击遮罩层关闭弹窗，默认值为 `true` |
| closeOnBackPress | boolean | 否 | 是否允许返回键关闭弹窗，默认值为 `true` |
| customContent | CustomBuilder | 否 | 自定义内容区 |
| onSelect | `(index1: number, index2?: number) => void` | 否 | 点击选项后的回调 |
| onCancel | `() => void` | 否 | 点击取消按钮后的回调 |

**UIActionType 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| content | ResourceStr | 否 | 选项内容 |
| icon | ResourceStr | 否 | 选项图标 |
| value | string | 否 | 选项标识 |
| description | ResourceStr | 否 | 选项描述信息 |
| contentSize | string \| number | 否 | 内容字体大小，范围 14-30，默认值为 16 |
| contentColor | ResourceColor | 否 | 内容字体颜色 |
| iconWidth | Length | 否 | 图标宽度，范围 16-40 |
| iconHeight | Length | 否 | 图标高度，范围 16-40 |
| dpSize | string \| number | 否 | 描述信息字体大小，范围 12-16，默认值为 14 |
| dpColor | ResourceColor | 否 | 描述信息字体颜色 |
| isDisabled | boolean | 否 | 是否禁用，默认值为 `false` |
| isRead | boolean | 否 | 是否只读，默认值为 `false` |

**UIActionMultiLine 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| content | ResourceStr | 是 | 选项内容 |
| icon | ResourceStr | 是 | 选项图标 |
| value | string | 否 | 选项标识 |
| description | ResourceStr | 否 | 选项描述信息 |
| contentSize | string \| number | 否 | 内容字体大小，范围 14-30，默认值为 14 |
| contentColor | ResourceColor | 否 | 内容字体颜色 |
| iconWidth | Length | 否 | 图标宽度，范围 40-64 |
| iconHeight | Length | 否 | 图标高度，范围 40-64 |
| dpSize | string \| number | 否 | 描述信息字体大小，范围 12-16，默认值为 12 |
| dpColor | ResourceColor | 否 | 描述信息字体颜色 |
| isDisabled | boolean | 否 | 是否禁用，默认值为 `false` |
| isRead | boolean | 否 | 是否只读，默认值为 `false` |

### 示例代码

```typescript
import { UIActionMenu } from '@hw-agconnect/ui-action-menu'

@Entry
@ComponentV2
struct DemoActionMenuPage {
  @Builder poetryContent() {
    Column() {
      Text('君不见，黄河之水天上来，奔流到海不复回。\n' +
        '君不见，高堂明镜悲白发，朝如青丝暮成雪。\n' +
        '人生得意须尽欢，莫使金樽空对月。\n' +
        ' 天生我材必有用，千金散尽还复来。\n' +
        '烹羊宰牛且为乐，会须一饮三百杯。\n' +
        '\n' +
        '岑夫子，丹丘生，将进酒，杯莫停。\n' +
        '与君歌一曲，请君为我倾耳听。\n' +
        '钟鼓馔玉不足贵，但愿长醉不愿醒。\n' +
        '古来圣贤皆寂寞，惟有饮者留其名。\n' +
        ' 陈王昔时宴平乐，斗酒十千恣欢谑。\n' +
        '\n' +
        '主人何为言少钱，径须沽取对君酌。\n' +
        '五花马、千金裘，呼儿将出换美酒，与尔同销万古愁。')
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.font_primary'))
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding({ left: 12, right: 12, top: 12, bottom:80 })
    .backgroundColor($r('sys.color.background_secondary'))
  }

  build() {
    Scroll() {
      Column() {
        Button('打开菜单 1，无标题')
          .margin({ top: 16 })
          .onClick(() => {
            UIActionMenu.open({
              actions: [
                '选项一',
                '选项二',
                '选项三',
                '选项四'
              ]
            })
          })
        Button('打开菜单 2，自定义文本色')
          .margin({ top: 16 })
          .onClick(() => {
            UIActionMenu.open({
              actions: [
                { icon: $r('app.media.startIcon'), content: '选项一', contentColor: '#ED6F21' },
                { icon: $r('app.media.startIcon'), content: '选项二', contentColor: '#E64566' },
                { icon: $r('app.media.startIcon'), content: '选项三', contentColor: '#AC49F5' },
                { icon: $r('app.media.startIcon'), content: '选项四', contentColor: '#A5D61D' }
              ]
            })
          })
        Button('打开菜单 3，选项状态')
          .margin({ top: 16 })
          .onClick(() => {
            UIActionMenu.open({
              title: {
                title: '主标题',
                subtitle: '次标题'
              },
              showClose: true,
              dragBar: true,
              actions: [
                '正常选项',
                { content: '禁用选项', isDisabled: true },
                { content: '只读选项', isRead: true }
              ],
              cancelText: 'BUTTON',
            })
          })
        Button('打开菜单 4，单行单列')
          .margin({ top: 16 })
          .onClick(() => {
            UIActionMenu.open({
              title: {
                title: '主标题',
                subtitle: '次标题'
              },
              showClose: true,
              dragBar: true,
              actions: [
                '选项一',
                { icon: $r('app.media.startIcon'), content: '选项二' },
                { icon: $r('app.media.startIcon'), content: '选项三', description: '我是一段描述信息' },
                { icon: $r('app.media.startIcon'), content: '选项四——标题单行显示超长文本截断省略', description: 'https://developer.huawei.com/consumer/cn/' },
                { description: '我是一段描述信息我是一段描述信息我是一段描述信息我是一段描述我是一段描述信息我是一段描述信息' },
                { icon: $r('app.media.startIcon'), content: '选项六', contentSize: 30 },
                { icon: $r('app.media.startIcon'), content: '选项七', contentColor: $r('sys.color.warning')}
              ],
              cancelText: 'BUTTON',
            })
          })
        Button('打开菜单 5，单行多列')
          .margin({ top: 16 })
          .onClick(() => {
            UIActionMenu.open({
              title: {
                title: '主标题',
                subtitle: '次标题'
              },
              showClose: true,
              dragBar: true,
              actions: [
                [
                  { icon: $r('app.media.startIcon'), content: '选项一' },
                  { icon: $r('app.media.startIcon'), content: '选项一' },
                  { icon: $r('app.media.startIcon'), content: '选项一' }
                ],
                [
                  { icon: $r('app.media.startIcon'), content: '选项一', iconWidth: 64, iconHeight: 64 },
                  { icon: $r('app.media.startIcon'), content: '选项一', iconWidth: 64, iconHeight: 64 },
                  { icon: $r('app.media.startIcon'), content: '选项一', iconWidth: 64, iconHeight: 64 },
                  { icon: $r('app.media.startIcon'), content: '选项一', iconWidth: 64, iconHeight: 64 }
                ],
                [
                  { icon: $r('app.media.startIcon'), content: '超长文本截断' },
                  { icon: $r('app.media.startIcon'), content: '超长文本截断' },
                  { icon: $r('app.media.startIcon'), content: '选项一' },
                  { icon: $r('app.media.startIcon'), content: '选项一' },
                  { icon: $r('app.media.startIcon'), content: '选项一' },
                  { icon: $r('app.media.startIcon'), content: '选项一' },
                  { icon: $r('app.media.startIcon'), content: '选项一' },
                  { icon: $r('app.media.startIcon'), content: '选项一' }
                ]
              ],
              cancelText: 'BUTTON'
            })
          })
        Button('打开菜单 6，自定义')
          .margin({ top: 16 })
          .onClick(() => {
            UIActionMenu.open({
              title: { title: '将进酒' },
              showClose: true,
              dragBar: true,
              customContent: (): void => this.poetryContent(),
            })
          })
      }
      .width('100%')
    }
    .layoutWeight(1)
  }
}
```

## 更新记录

### 1.0.0 (2025-12-02)

下载该版本提供操作菜单 UI 组件，支持单行/多行显示，支持展示图片、状态、标题等多项自定义内容。

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

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-action-menu
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/b33e4a3553204c32a0a441576f48d26c/2adce9bbd4cb42d58a87e6add45594b3?origin=template