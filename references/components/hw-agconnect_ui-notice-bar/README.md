# 通告栏 UINoticeBar

## 简介

UINoticeBar 是基于 open harmony 基础组件开发的通告栏组件，用于展示通知公告信息，支持滚动显示等。

## 详细介绍

### 简介

UINoticeBar 是基于 open harmony 基础组件开发的通告栏组件，用于展示通知公告信息，支持滚动显示等。

### 约束与限制

#### 环境

- **DevEco Studio 版本**: DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**: HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**: 华为手机（包括双折叠和阔折叠）、平板
- **系统版本**: HarmonyOS 5.0.0(12) 及以上

我们提供两种方式：ohpm 快速集成和下载源码包手工集成，您可以根据需要选择合适的方式，下面以 ohpm 快速集成为例，描述完整集成方法。

## 使用

### 安装组件

```bash
ohpm install @hw-agconnect/ui-notice-bar
```

当前组件已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请参考以下命令获取 1.0.0 版本组件。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。

```bash
ohpm install @hw-agconnect/ui-notice-bar@1.0.0
```

### 引入组件

```typescript
import { UINoticeBar } from '@hw-agconnect/ui-notice-bar';
```

### 调用组件

详细参数配置说明参见 API 参考。

```typescript
UINoticeBar({
  text: 'UINoticeBar 基于 open harmony 基础组件开发的通告栏组件，支持滚动显示数据、修改颜色等功能。',
  showIcon: true,
  showGetMore: true,
  scrollable: this.scrollable,
  moreText: '查看更多',
  getMore: () => {
    this.scrollable = true;
  }
})
```

## API 参考

### 子组件

无

### 接口

`UINoticeBar(options: UINoticeBarOptions)`

通告栏组件。

### 参数说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UINoticeBarOptions | 否 | 配置通告栏组件的参数。 |

### UINoticeBarOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| text | ResourceStr | 是 | 显示文字 |
| speed | number | 否 | 文字滚动速度，默认 6vp |
| barBackgroundColor | ResourceColor | 否 | 背景颜色 |
| color | ResourceColor | 否 | 文字、左侧图标以及右侧关闭按钮颜色，只支持修改 svg 图标颜色 |
| moreColor | ResourceColor | 否 | 查看更多文字颜色 |
| moreText | string | 否 | 设置“查看更多”的文本 |
| single | boolean | 否 | 是否单行，默认“否” |
| scrollable | boolean | 否 | 是否滚动，为 true 时，NoticeBar 为单行，默认否 |
| showIcon | boolean | 否 | 是否显示左侧图标，默认为否 |
| noticeIcon | ResourceStr | 否 | 左侧通知图标 |
| showClose | boolean | 否 | 是否显示右侧关闭按钮 |
| closeIcon | ResourceStr | 否 | 右侧关闭按钮图标 |
| showGetMore | boolean | 否 | 是否显示右侧查看更多图标，为 true 时，NoticeBar 为单行，默认为否 |
| fontSize | number | 否 | 文字大小 (包括 text 和 moreText 字体大小)，单位为 vp，默认为 14 |
| click | callback: () => void | 否 | 点击 UINoticeBar 触发事件 |
| close | callback: () => void | 否 | 关闭 UINoticeBar 触发事件 |
| getMore | callback: () => void | 否 | 点击”查看更多“时触发事件 |

## 示例代码

```typescript
import { UINoticeBar } from '@hw-agconnect/ui-notice-bar'

@Extend(Text)
function textStyle(isOne: boolean = false) {
  .fontSize(20)
  .fontWeight(500)
  .width('100%')
  .padding({ top: isOne ? 10 : 30, bottom: 10, left: 12 })
}

@Entry
@ComponentV2
struct NoticeBarSample {
  @Local scrollable: boolean = false

  @Builder
  buildTitleBar() {
    Text('NoticeBar')
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
          Text('多行显示').textStyle(true)
          UINoticeBar({
            text: '通告栏组件多用于系统通知，广告通知等场景，可自定义图标，颜色，展现方式等。'
          })

          Text('单行显示').textStyle()
          UINoticeBar({
            text: '使用 single 属性单行显示通知。通告栏组件多用于系统通知，广告通知等场景，可自定义图标，颜色，展现方式等。',
            single: true
          })

          Text('滚动显示 + 图标').textStyle()
          UINoticeBar({
            text: '使用 scrollable 属性使通告滚动，此时 single 属性将失效，始终单行显示',
            scrollable: true,
            showIcon: true,
          })

          Text(`查看更多 - 图标按钮`).textStyle()
          UINoticeBar({
            text: '使用 showGetMore 显示更多，此时 single 属性将失效，始终单行显示，如不配置 moreText 属性 ,将显示箭头图标',
            noticeIcon: $r('app.media.ic_gallery_create'),
            showIcon: true,
            showGetMore: true,
            scrollable: this.scrollable,
            getMore: () => {
              this.scrollable = !this.scrollable;
            }
          }).margin({ bottom: 10 })

          Text(`查看更多 - 文本按钮`).textStyle()
          UINoticeBar({
            text: '使用 showGetMore 显示更多，此时 single 属性将失效，始终单行显示，如不配置 moreText 属性 ,将显示箭头图标',
            showIcon: true,
            showGetMore: true,
            scrollable: this.scrollable,
            moreText: '查看更多',
            getMore: () => {
              this.scrollable = !this.scrollable;
            }
          })

          Text('修改颜色和尺寸').textStyle()
          UINoticeBar({
            text: '使用 color 修改文字和图标的颜色，使用 barBackgroundColor 修改背景色',
            showIcon: true,
            color: $r('sys.color.ohos_id_color_palette10'),
            barBackgroundColor: '#33E08C3A',
            fontSize: 16,
          })

          Text("滚动显示 + 图标 + 关闭").textStyle()
          UINoticeBar({
            text: '使用 showClose 属性，可关闭通知，如果不设置单行，会显示所有的内容且折行显示',
            showClose: true,
            showGetMore: true,
            scrollable: true,
            showIcon: true,
            close: () => {
              console.log("关闭按钮")
            }
          }).margin({ bottom: 10 })

          Text("更改关闭按钮").textStyle()
          UINoticeBar({
            text: '使用 closeIcon 属性，更改关闭图标',
            showClose: true,
            closeIcon: $r('app.media.ic_public_close'),
            close: () => {
              console.log("更改关闭按钮")
            }
          })
        }
      }.scrollBar(BarState.Off)
    }
    .title(this.buildTitleBar())
    .backgroundColor($r('sys.color.ohos_id_color_bottom_tab_sub_bg'))
  }
}
```

## 更新记录

### 2.0.0 (2025-11-03)

下载该版本。从 2.0.* 版本开始，组件已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请下载 1.0.X 版本。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。

### 1.0.0 (2025-09-29)

下载该版本。初始版本。

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

### DevEco Studio 版本

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
ohpm install @hw-agconnect/ui-notice-bar
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/f2775fae249746dba6cd6b6dda8f5337/2adce9bbd4cb42d58a87e6add45594b3?origin=template