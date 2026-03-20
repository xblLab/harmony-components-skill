# 抽屉 UIDrawer

## 简介

UIDrawer 是基于 open harmony 基础组件开发的组件，用于在屏幕侧边弹出一个面板，支持从左右两侧弹出。

## 详细介绍

### 简介

UIDrawer 是基于 open harmony 基础组件开发的组件，用于在屏幕侧边弹出一个面板，支持从左右两侧弹出。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、华为平板
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

#### 权限

无

#### 使用

安装组件。
深色代码主题复制
```bash
ohpm install @hw-agconnect/ui-drawer;
```

引入组件。
深色代码主题复制
```typescript
import { DrawerType, UIDrawer } from '@hw-agconnect/ui-drawer';
```

调用组件，详细参数配置说明参见 API 参考。

## API 参考

### UIDrawer

#### 操作菜单

##### open(options: UIDDrawerOptions)

创建并打开抽屉。

**参数**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UIDrawerOptions | 是 | 配置抽屉组件的参数，用于设置抽屉的标题栏、内容、弹出方向等属性。 |

#### UIDrawerOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| widthLength | | 否 | 抽屉的宽度，规则如下：抽屉的最小宽度为 72vp；设备的水平宽度 <= 600vp 时，抽屉宽度默认为 288vp，最大不超过 288vp；600vp < 设备的水平宽度 < 840vp 时，抽屉宽度默认为 0.4 * 设备的水平宽度，最大不超过 0.5 * 设备的水平宽度；设备的水平宽度 >= 840vp 时，抽屉宽度默认为 400vp，最大不超过 0.5 * 设备的水平宽度 |
| borderRadius | number \| BorderRadiuses | 否 | 抽屉的圆角，默认值为 0 |
| bgColor | ResourceColor | 否 | 抽屉的背景颜色 |
| placement | DrawerType | 否 | 抽屉的弹出方向，默认值为 DrawerType.LEFT |
| mask | boolean | 否 | 是否显示遮罩，默认值为 true |
| maskColor | ResourceColor | 否 | 遮罩的颜色 |
| maskClosable | boolean | 否 | 是否允许点击遮罩关闭抽屉，默认值为 true |
| backClosable | boolean | 否 | 是否允许系统返回关闭抽屉，默认值为 true |
| title | DrawerTitleOptions | 否 | 标题区 |
| customTitle | CustomBuilder | 否 | 自定义标题区 |
| content | CustomBuilder | 是 | 自定义内容区 |
| onClose | () => void | 否 | 关闭抽屉的回调 |

#### DrawerTitleOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| icon | ResourceStr | 否 | 标题栏自定义图标 |
| content | ResourceStr | 否 | 标题栏内容 |
| fontSize | string \| number | 否 | 内容的字体大小，默认值为 26 |
| fontColor | ResourceColor | 否 | 内容的字体颜色 |
| closable | boolean | 否 | 是否显示关闭按钮，默认值为 false |
| iconClick | () => void | 否 | 点击自定义图标的回调 |

#### DrawerType 枚举说明

| 名称 | 说明 |
| :--- | :--- |
| LEFT | 抽屉从屏幕左侧弹出 |
| RIGHT | 抽屉从屏幕右侧弹出 |

## 示例代码

```typescript
import { DrawerType, UIDrawer } from '@hw-agconnect/ui-drawer';

@Entry
@ComponentV2
struct DemoDrawerPage {
  @Local isOpen: boolean = false;

  @Builder poetryContent() {
    Scroll() {
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
          .textAlign(TextAlign.Center);
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
      .constraintSize({ minHeight: '100%'})
      .backgroundColor($r('sys.color.background_secondary'))
      .padding(8);
    }.layoutWeight(1);
  }

  @Builder buttonContent() {
    Column() {
      Button('打开二级抽屉')
        .onClick(() => {
          UIDrawer.open({
            title:{
              icon: $r('app.media.back_icon'),
              content: 'Title',
            },
            content: (): void => {},
            placement: DrawerType.RIGHT,
          })
        })
    }
    .width('100%')
  }

  build() {
    Navigation() {
      Scroll() {
        Column() {
          Button('打开抽屉 1，左侧弹出无标题')
            .margin({ top: 16 })
            .onClick(() => {
              UIDrawer.open({
                content: (): void => this.poetryContent(),
                borderRadius: 24,
                width: '30%',
              })
            })
          Button('打开抽屉 2，右侧弹出有标题')
            .margin({ top: 16 })
            .onClick(() => {
              UIDrawer.open({
                title: {
                  icon: $r('app.media.startIcon'),
                  content: 'Title',
                  closable: true,
                  iconClick: () => {},
                },
                content: (): void => {},
                placement: DrawerType.RIGHT,
                width: '80%',
              })
            })
          Button('打开抽屉 3，最小宽度')
            .margin({ top: 16 })
            .onClick(() => {
              UIDrawer.open({
                title: {
                  icon: $r('app.media.startIcon'),
                },
                width: 72,
                content: (): void => {},
              })
            })
          Button('打开抽屉 4，点击遮罩返回键不关闭')
            .margin({ top: 16 })
            .onClick(() => {
              UIDrawer.open({
                title: {
                  content: 'Title',
                  closable: true,
                },
                content: (): void => {},
                maskClosable: false,
                backClosable: false,
              })
            })
          Button('打开抽屉 5，无遮罩')
            .margin({ top: 16 })
            .onClick(() => {
              if (!this.isOpen ) {
                UIDrawer.open({
                  title: {
                    content: 'Title',
                    closable: true,
                  },
                  content: (): void => {},
                  onClose: () => {
                    this.isOpen = false;
                  },
                  mask: false,
                  bgColor: $r('sys.color.background_secondary'),
                });
                this.isOpen = true;
              }
            })
          Button('打开抽屉 6，多层抽屉')
            .margin({ top: 16 })
            .onClick(() => {
              UIDrawer.open({
                title: {
                  icon: $r('app.media.startIcon'),
                  content: 'Title',
                  closable: true,
                },
                content: (): void => this.buttonContent(),
                placement: DrawerType.RIGHT,
              })
            })
        }.width('100%').constraintSize({ minHeight: '100%' })
      }.layoutWeight(1)
    }
    .title('抽屉')
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
    .width('100%')
    .height('100%')
  }
}
```

## 更新记录

### 1.0.0 (2025-12-02)

Created with Pixso.

下载该版本提供抽屉 UI 组件，支持左右两侧弹出。

**权限与隐私基本信息**

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

**隐私政策**

不涉及

**SDK 合规使用指南**

不涉及

**兼容性**

| 项目 | 版本/类型 | 备注 |
| :--- | :--- | :--- |
| HarmonyOS 版本 | 5.0.0 | Created with Pixso. |
| | 5.0.1 | Created with Pixso. |
| | 5.0.2 | Created with Pixso. |
| | 5.0.3 | Created with Pixso. |
| | 5.0.4 | Created with Pixso. |
| | 5.0.5 | Created with Pixso. |
| | 5.1.0 | Created with Pixso. |
| | 5.1.1 | Created with Pixso. |
| | 6.0.0 | Created with Pixso. |
| 应用类型 | 应用 | Created with Pixso. |
| | 元服务 | Created with Pixso. |
| 设备类型 | 手机 | Created with Pixso. |
| | 平板 | Created with Pixso. |
| | PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 | Created with Pixso. |
| | DevEco Studio 5.0.1 | Created with Pixso. |
| | DevEco Studio 5.0.2 | Created with Pixso. |
| | DevEco Studio 5.0.3 | Created with Pixso. |
| | DevEco Studio 5.0.4 | Created with Pixso. |
| | DevEco Studio 5.0.5 | Created with Pixso. |
| | DevEco Studio 5.1.0 | Created with Pixso. |
| | DevEco Studio 5.1.1 | Created with Pixso. |
| | DevEco Studio 6.0.0 | Created with Pixso. |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-drawer
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/3247ebd1b4684806abbde3b49ebcbc26/2adce9bbd4cb42d58a87e6add45594b3?origin=template