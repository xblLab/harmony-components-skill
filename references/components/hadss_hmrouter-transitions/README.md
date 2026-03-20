# Hmrouter 高阶转场动效组件

## 简介

基于 HMRouter 的高阶转场动画库，包含一镜到底等。

## 详细介绍

### 简介

HMRouterTransitions 基于 HMRouter 封装了高阶转场动效，以及一系列 HMRouter 自定义模板。当前提供卡片一镜到底转场动画，后续会陆续补充更多动画效果。

### 依赖系统版本

- SDK: Ohos_sdk_public 5.0.3.135 (API 15 Release) 及以上

### 快速开始

在 UIAbility 初始化：

```typescript
export default class PhoneAbility extends UIAbility {
  onWindowStageCreate(windowStage: window.WindowStage): void {
    HMRouterTransitions.init(windowStage);
  }
}
```

配置页面模板：

通过 HMRouter 自定义模板能力配置一镜到底页面模板：

```json
{
  "customPageTemplate": [
    {
      "srcPath": [
        "**/CardLongTakePageTwo.ets" // 一镜到底目标页面
      ],
      "templatePath": "./oh_modules/@hadss/hmrouter-transitions/ets/template/CardLongTakeTemplate.ejs" // HMRouterTransitions 提供的模板文件地址
    }
  ]
}
```

### 一镜到底转场动画的实现

使用一镜到底页面模版：`./oh_modules/@hadss/hmrouter-transitions/ets/template/CardLongTakeTemplate.ejs`

源页面指的是卡片承载页面，需要通过 `HMRouterTransitions.cardLongTake` 获取转场动画，然后通过 `HMRouterMgr.push` 传入一次性动画跳转目标页面。

`HMRouterTransitions.cardLongTake(clickedComponentId: string, targetComponentId: string, options?: LongTakeTransitionOptions)` 接口用于生成一镜到底动画。

- `clickedComponentId`: `string`，标识源页面点击卡片对应的 id;
- `targetComponentId`: `string`，目标页面承载卡片内容对应的组件 id;
- `options`: `LongTakeTransitionOptions`，可选参数，定义一镜到底动画开始的回调，以及从目标页面返回到源页面时的结束回调，可以用来控制卡片的显隐状态。

### 页面实现以及跳转方式

#### 起始页面

```typescript
@HMRouter({ pageUrl: 'CardLongTakePageOne' })
@Component
export struct CardLongTakePageOne {
  @State dataSource: WaterFlowDataSource = new WaterFlowDataSource();
  
  build() {
    Stack() {
      WaterFlow() {
        LazyForEach(this.dataSource, (item: CardAttr, index: number) => {
          FlowItem() {
            CardComponent();
          }
          .id(Constants.getFlowItemIdByIndex(index.toString())) // 对应 clickedComponentId
        }, (item: string) => item);
      }
      .cachedCount(4)
      .columnsTemplate(this.columnType)
      .columnsGap(5)
      .rowsGap(5)
      .width('100%')
      .height('100%');
    }
    .size({ width: '100%', height: '100%' })
    .padding({ left: 10, right: 10 });
  }
}
```

#### 目标页面

```typescript
@HMRouter({ pageUrl: 'CardLongTakePageTwo' })
@Component
export struct DetailPageContent {
  @Prop indexValue: number;

  build() {
    Column() {
      this.MyTitleBuilder()
      Image($r(`app.media.img_${this.indexValue % 6}`))
        .size({ width: '100%' })
        .objectFit(ImageFit.Auto)
        .id('targetId') // 对应 targetComponentId 参数
  
      Text($r('app.string.DetailPage_text'))
        .width(px2vp(WindowUtils.windowWidth_px))
        .margin({ top: 20 }).padding(10)
    }.backgroundColor(Color.White)
    .expandSafeArea([SafeAreaType.SYSTEM])
    .backgroundColor(Color.White)
  }
}
```

### 路由跳转使用方法

```typescript
const animator = HMRouterTransitions.cardLongTake(Constants.getFlowItemIdByIndex(index.toString()), 'targetId', {
    onTransitionStart: () => {
      Logger.info('onTransitionStart');
    },
    onTransitionEnd: () => {
      Logger.info('onTransitionEnd');
    }
  });
HMRouterMgr.push({ pageUrl: 'CardLongTakePageTwo', param: index, animator: animator });
```

## 许可证协议

Apache-2.0

## 更新记录

- **1.2.2** (2025.10.27)
  - 更新版本号
- **1.2.0** (2025.09.17)
  - 更新版本号
- **1.2.0-rc.0** (2025.09.02)
  - 修复进入 H5 页面时 Webview 容器高度异常的问题
- **1.2.0-beta.1** (2025.07.29)
  - 更新版本号
- **1.2.0-beta.0** (2025.06.17)
  - Docs
  - 更新 README 及版本号
- **1.0.0-rc.10** (2024.11.20)
  - Features
  - 支持卡片一镜到底

## 权限与隐私

| 项目 | 说明 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 信息 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | 无 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @hadss/hmrouter-transitions
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/9abaf35ff32842b196639c160dcc049a/PLATFORM?origin=template