# 底部曲线导航 curve_navigation

## 简介

curve_navigation 是一个正弦曲线形式的底部导航，摒弃传统的导航模式，让底部导航变得好看又有趣。

## 详细介绍

### 功能介绍

curve_navigation 是一个正弦曲线形式的底部导航，摒弃传统的导航模式，让底部导航变得好看又有趣。

### 环境要求

Api 适用版本：>=12

### 示例效果

静态效果

动态效果

### 快速入门

#### 1、远程依赖

**方式一：** 在 Terminal 窗口中，执行如下命令安装三方包，DevEco Studio 会自动在工程的 oh-package.json5 中自动添加三方包依赖。

建议：在使用的模块路径下进行执行命令。

深色代码主题复制

```bash
ohpm install @abner/curve_navigation
```

**方式二：** 在模块的 oh-package.json5 中设置三方包依赖，配置示例如下：

深色代码主题复制

```json5
"dependencies": { "@abner/curve_navigation": "^1.0.1"}
```

### 使用样例

深色代码主题复制

```typescript
CurveNavigation({
  navigationSize: 5, //tab 数量
  navigationPaddingBottom: WindowUtils.windowBottomNavHeight,//距离底部距离
  onPageChange: (position: number) => {
    //page 改变
    this.selectIndex = position
  },
  tabView: (position: number) => {
    //导航视图
    this.tabView(position)
  },
  pageView: (position: number) => {
    //页面视图
    this.pageView(position)
  }
})
```

### 完整案例

深色代码主题复制

```typescript
@Entry
@Component
struct Index {
  private tempColorArray: ResourceColor[] = ["#ffcc80", "#ff9323ac", "#ff26a965", "#ff93d923", "#ff11c5de",]
  @State selectIndex: number = 0
  private tabArray: Resource[] =
    [$r('sys.symbol.house_fill'), $r('sys.symbol.square_fill_grid_2x2'), $r('sys.symbol.bell_fill'),
      $r('sys.symbol.externaldrive_fill'), $r('sys.symbol.person_2_fill')]

  @Builder
  tabView(position: number) {
    if (this.selectIndex == position) {
      Column() {
        SymbolGlyph(this.tabArray[position])
          .fontSize(20)
          .renderingStrategy(SymbolRenderingStrategy.SINGLE)
          .fontColor([Color.Black])
      }
      .backgroundColor(Color.White)
      .width(35)
      .height(35)
      .borderRadius(35)
      .justifyContent(FlexAlign.Center)
    } else {
      SymbolGlyph(this.tabArray[position])
        .fontSize(20)
        .renderingStrategy(SymbolRenderingStrategy.SINGLE)
        .fontColor([Color.Gray])
    }

  }

  @Builder
  pageView(position: number) {
    Column() {
      Text(position.toString())
    }.width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.tempColorArray[position])
  }

  build() {
    RelativeContainer() {
      CurveNavigation({
        navigationSize: 5, //tab 数量
        navigationPaddingBottom: WindowUtils.windowBottomNavHeight,
        onPageChange: (position: number) => {
          this.selectIndex = position
        },
        tabView: (position: number) => {
          this.tabView(position)
        },
        pageView: (position: number) => {
          this.pageView(position)
        }
      })
    }
    .height('100%')
    .width('100%')
  }
}
```

### API 说明

Api 适用版本：>=12

### 配置说明

暂无配置。

### 权限要求

暂无权限要求

### 技术支持

在 Github 中的 Issues 中提问题，定期解答。

### 开源许可协议

该代码经过 Apache 2.0 授权许可。

### 更新记录

1.0.1 (2026-01-21)
1、优化导航组件属性配置
2、支持页面懒加载方式

### 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无权限 | 无权限 | 无权限 |

### SDK 合规使用指南

不涉及

### 兼容性

| 项目 | 详情 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.5 Created with Pixso. |
| 应用类型 | 应用 Created with Pixso. |
| 元服务 | Created with Pixso. |
| 设备类型 | 手机 Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |
| DevEco Studio 6.0.1 | Created with Pixso. |

## 安装方式

```bash
ohpm install @abner/curve_navigation
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/b76e4b0ab2df4c63b897e5c99f361635/b6a17875746941e0b5606c9b1eb174f8?origin=template