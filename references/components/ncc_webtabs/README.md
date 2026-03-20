# ncc/webtabs web 选项卡组件

## 简介

WebTabs 是基于 ArkWeb 和 ArkUI 开发的高性能 Web 选项卡，具有高度可定制性，满足各种开发需求。

## 详细介绍

### 简介

WebTabs 是基于 ArkWeb 和 ArkUI 开发的高性能 Web 选项卡。它具有以下的特点：

- **高性能**：支持多种优化方式，支持滑动、点击标签等多种切换方式，多选项卡同时加载，第一次切换也能做到流畅无白屏。
- **高度可定制**：可满足各种开发需求。
- **支持内置 Swiper 和 Web 组件生命周期的自定义**。
- **内置简洁、可调节的 TabBar（标签栏）组件**，支持使用外部自定义 TabBar 组件。
- **提供访问 Web 和 Swiper 控件的接口**，允许开发者自主控制。

### 下载安装

```bash
ohpm install @ncc/webtabs
```

### 接口列表

#### WebTabs 组件

##### 基本属性说明

| 属性名 | 必选 | 说明 |
| :--- | :--- | :--- |
| `itemList: WebTabItem[]` | 是 | WebTabs 的资源列表，包含选项卡要加载的资源链接 `webSrc` 和 TabBar 标签的内容 `label`，不建议包含多于 4 个选项卡。 |
| `controller: WebTabsController` | 否 | WebTabs 控制器，可用于访问内部的 Web 组件和控制选项卡的切换。 |
| `enable_tarBar: boolean` | 否 | 是否使用默认标签，默认值 `true`，开启时会使用内置的 TabBarBuilder 创建选项卡标签。 |
| `enable_preLoad: boolean` | 否 | 是否启用预连接优化，默认值 `true`。 |
| `enable_preRender: boolean` | 否 | 是否启用预渲染优化，默认值 `true`。 |
| `enable_lazy: boolean` | 否 | 是否启用 LazyForEach 加载，默认值 `false`，仅 `enable_preRender` 为 `true` 时有效。 |
| `enable_presetNode: boolean` | 否 | 是否传入预先创建好的 NodeController，默认值 `false`，仅 `enable_preRender` 为 `true` 时有效。 |
| `nodeObjects: WebNodeObject[]` | 否 | `presetNode` 开启时必选。内容可由函数 `createWebNode` 生成。 |

> **提示**：
> - `preLoad` 可以提供 60ms 左右的页面加载速度提升，建议开启；`preRender` 是无白屏切换的核心优化，建议开启。
> - `enable_lazy` 在 3-4 个选项卡情形下的提升效果并不明显，仅供开发者测试使用。开启时注意调整 Swiper 的 `cachedCount`。此外，由于 LazyForEach 的加载机制，组件会被卸载重建，在不使用预渲染组件的情况下会导致 Web 组件销毁、状态丢失，因此仅允许在开启预渲染时使用。
> - 默认情形下，预渲染节点的创建发生在 WebTabs 组件的 `aboutToAppear` 中。如开发者有在别处初始化的需求，可使用 `presetNode` 相关属性直接传入已生成的 Node 列表。一般在性能调优中使用。

##### Swiper 相关属性说明

| 属性名 | 必选 | 说明 |
| :--- | :--- | :--- |
| `enable_loop: boolean` | 否 | 是否开启循环切换，默认值 `false`，开启时第一个选项卡与最后一个选项卡互通。 |
| `curve: Curve` | 否 | 设置动画曲线参数，默认值 `Curve.Ease`。 |
| `onChange: (index: number) => void` | 否 | Swiper 事件。当前显示的子组件索引变化时触发该回调。 |
| `onAnimationEnd: (index: number, extraInfo: SwiperAnimationEvent) => void` | 否 | Swiper 事件。切换动画结束时触发该回调。 |
| `onAnimationStart: (index: number, targetIndex: number, extraInfo: SwiperAnimationEvent) => void` | 否 | Swiper 事件。切换动画开始时触发该回调。 |
| `cachedCount: number` | 否 | 设置预加载子组件个数，默认值 `3`。 |

> **注意**：通过上面提供的三个事件属性，开发者可以自定义内部 Swiper 组件的相关回调。在启用 LazyForEach 加载时，如果 `cachedCount` 无法覆盖到所有的页面，则初次切换到未被覆盖的页面上时会出现白屏闪烁。

##### WebBuilder 相关属性说明

WebTabs 为开发者提供了自定义 Web 组件生命周期的接口。

| 属性名 | 必选 | 说明 |
| :--- | :--- | :--- |
| `lifeCycleList: WebLifeCycle[]` | 否 | LifeCycle 列表，长度要求与选项卡数量一致。每个 LifeCycle 类包含了对应 Web 组件的生命周期回调函数。 |
| `cacheMode: CacheMode` | 否 | 设置缓存模式。默认值 `CacheMode.Default`。 |
| `nestedScroll: NestedScrollOptions` | 否 | 设置嵌套滚动选项。默认值 `{scrollForward: NestedScrollMode.SELF_FIRST, scrollBackward: NestedScrollMode.SELF_FIRST}`。 |
| `overScrollMode: OverScrollMode` | 否 | 设置 Web 过滚动模式，默认值 `OverScrollMode.NEVER`。当过滚动模式开启时，当用户在 Web 界面上滑动到边缘时，Web 会通过弹性动画弹回界面。 |

> **提示**：嵌套滚动场景中，推荐设置 `OverScrollMode` 为 `Never`。

##### TabBar 相关属性说明

当 `enable_tabBar` 为 `true` 时，会使用内置的 `tabBarBuilder` 创建标签栏。该 Builder 会使用下面的参数。
当 `enable_tabBar` 为 `false` 时，下列参数无效，开发者可通过 `controller` 在外部自定义标签栏。
内置 TabBar Builder 固定在选项卡页面的上方，高度由文字大小决定。Web 组件将占满父组件余下的空间。

| 属性名 | 必选 | 说明 |
| :--- | :--- | :--- |
| `fontColor: ResourceColor`<br>`selectedFontColor: ResourceColor` | 否 | 一般情况和选中情况下的标签字符颜色，一般默认值 `Color.Gray`，选中默认值 `'#007DFF'`。 |
| `fontSize: Length` | 否 | 标签字符大小，默认值 `20`。 |
| `fontWeight: string \| number \| FontWeight`<br>`selectedFontWeight: string \| number \| FontWeight` | 否 | 一般情况和选中情况下的标签字符粗细，一般默认值 `400`，选中默认值 `500`。 |
| `dividerVisible: Visibility` | 否 | 选中标签下方的下划线是否可见，默认值 `Visibility.Visible`。 |
| `dividerColor: ResourceColor` | 否 | 选中标签下方的下划线颜色，通常与选中标签字符颜色一致，默认值 `'#007DFF'`。 |
| `bgColor: ResourceColor` | 否 | 标签栏背景颜色，默认值 `Color.White`。

#### WebTabItem 类

WebTabItem 类或 WebTabItemType 接口用于存放选项卡的初始化资源链接和标签。

##### 属性说明

| 属性名 | 必选 | 说明 |
| :--- | :--- | :--- |
| `webSrc: ResourceStr` | 是 | WebTabs 的资源链接。 |
| `label: string` | 是 | 标签的文本。 |

#### WebTabsController 类

用于访问 WebTabs 内部的相关控件，便于开发者对组件进行控制。

##### 属性说明

| 属性名 | 必选 | 说明 |
| :--- | :--- | :--- |
| `webControllers: webview.WebviewController[]` | 不可选 | 每个选项卡对应的 WebviewController，在 WebTabs 加载时自动初始化。 |
| `swiperController: SwiperController` | 不可选 | 控制 WebTabs 内部的 Swiper 组件，创建时自动初始化。 |
| `currentIndex: number` | 不可选 | 当前选项卡序号，Swiper onChange 事件时自动刷新。仅用于辅助开发者开发 TabBar。 |

##### 方法说明

| 方法 | 说明 |
| :--- | :--- |
| `getCurrentWebController(): webview.WebviewController` | 返回当前页面 (currentIndex) 对应的 Web 控件。 |

#### WebLifeCycle 类

用于封装 Web 组件的生命周期回调函数，它们会在预渲染时挂载到对应 Web 组件上。目前仅支持下表中列出的属性名。

| 属性名 | 必选 | 说明 |
| :--- | :--- | :--- |
| `onControllerAttached: () => void;` | 否 | 当 Controller 成功绑定到 Web 组件时触发该回调。 |
| `onLoadIntercept: (event?: LoadInterceptEvent) => boolean` | 否 | 当 Web 组件加载 url 之前触发该回调，用于判断是否阻止此次访问。 |
| `onInterceptRequest: (event?: InterceptRequestEvent) => WebResourceResponse` | 否 | 当 Web 组件加载 url 之前触发该回调，用于拦截 url 并返回响应数据。 |
| `onPageBegin: (event?: PageEvent)` | 否 | 网页开始加载时触发该回调，且只在主 frame 触发。 |
| `onProgressChange: (event?: ProgressEvent) => void` | 否 | 告知开发者当前页面加载的进度。 |
| `onPageEnd: (event?: PageEvent) => void` | 否 | 网页加载完成时触发该回调，且只在主 frame 触发。 |
| `onPageVisible: (event?: PageEvent) => void` | 否 | 当 HTTP 响应的主体开始加载，新页面即将可见时触发该回调，且只在主 frame 触发。 |
| `onRenderExited: (event?: RenderExitedEvent) => void` | 否 | 应用渲染进程异常退出时触发该回调，可以在此回调中进行系统资源的释放、数据的保存等操作。 |
| `onAttach: () => void` | 否 | 组件挂载至组件树时触发此回调。 |
| `onDetach: () => void` | 否 | 组件从组件树卸载时触发此回调。 |
| `onAppear: () => void` | 否 | 组件挂载显示后触发此回调。 |
| `onDisAppear: () => void` | 否 | 组件卸载消失时触发此回调。 |

### 关于 Web 组件的生命周期函数的接口细节和开发建议

#### preRender 相关接口

下面的接口，只有当开发者开启 `enable_presetNode`，自己进行预渲染时会使用到。

##### WebBuilderParam 类

```typescript
interface WebBuilderParamType {
  url: ResourceStr; // Web 链接
  controller?: webview.WebviewController; // 控件
  lifeCycle?: WebLifeCycle; // 生命周期回调函数
  cacheMode?: CacheMode; // 缓存模式
  overScrollMode?: OverScrollMode; // 过滚动选项
  nestedScroll?: NestedScrollOptions; // 嵌套滚动选项
}

export class WebBuilderParam implements WebBuilderParamType {
  url: ResourceStr = '';
  controller: webview.WebviewController = new webview.WebviewController();
  cacheMode: CacheMode = CacheMode.None;
  overScrollMode: OverScrollMode = OverScrollMode.NEVER;
  nestedScroll: NestedScrollOptions = {
    scrollForward: NestedScrollMode.PARENT_FIRST,
    scrollBackward: NestedScrollMode.PARENT_FIRST,
  }
  lifeCycle: WebLifeCycle = new WebLifeCycle({});
}
```

##### WebNodeObject 接口

```typescript
export interface WebNodeObject {
  controller: webview.WebviewController,
  node: CustomNodeController<WebBuilderParam>
}
```

##### createWebNode 函数

传入 UIContext 和相关参数，用于生成 NodeController。返回值包含了创建的预渲染 Web 组件的 NodeController 和 WebviewController。params 中没有传入的参数会依据默认值自动补齐。

```typescript
export function createWebNode(uiContext: UIContext, params: WebBuilderParamType): WebNodeObject;
```

## 使用示例

使用前，需要在模块的 `oh-package.json5` 中添加 dependencies：

```json5
{
  "dependencies": {
    "@ncc/webtabs": "1.0.0"
  }
}
```

添加后，即可在代码中引用相关类和组件。
**注意**：下面所有使用了在线页面的示例，需要 `ohos.permission.INTERNET` 权限。

### 基础示例

下面的例子创建了一个简单的 WebTabs。

```typescript
import { WebTabs, WebTabItemType } from '@ncc/webtabs';

@Entry
@Component
struct Index {
  // 资源列表，使用 WebTabItemType 来初始化比较方便
  @State itemList: WebTabItemType[] = [
    { webSrc: 'https://developer.huawei.com/', label: 'huawei' },
    { webSrc: $rawfile('index.html'), label: 'local' } // 支持本地文件
  ];

  build() {
    Column() {
      WebTabs({ itemList: this.itemList })
    }
  }
}
```

### 通过 Controller 进行控制

通过 WebTabsController，可以实现对标签页的自定义控制。下面的例子演示了简单的用法：

```typescript
import { WebTabs, WebTabItemType, WebTabsController } from '@ncc/webtabs';
import { LengthMetrics } from '@ohos.arkui.node';

@Entry
@Component
struct Index {
  @State itemList: WebTabItemType[] = [
    { webSrc: 'https://developer.huawei.com/', label: 'huawei' },
    { webSrc: $rawfile('index.html'), label: 'local' }
  ];
  @State controller: WebTabsController = new WebTabsController();

  build() {
    Column({space: 20}) {
      Row() {
        WebTabs({
          itemList: this.itemList,
          controller: this.controller,
        })
      }.height('60%')
      // 通过 SwiperController 和 currentIndex 可以自定义页面的切换
      Flex({ direction: FlexDirection.Row, space: {main: LengthMetrics.px(10)} }) {
        Button('ShowPrevious').onClick(() => {
          this.controller.swiperController.showPrevious();
        })
        Button('Goto1').onClick(() => {
          this.controller.swiperController.changeIndex(1, true);
        })
      }
      // 通过 WebviewController 可以控制内部 Web 组件
      Flex({ direction: FlexDirection.Row, space: {main: LengthMetrics.px(10)} }) {
        Button('Backward').onClick(() => {
          this.controller.getCurrentWebController().backward();
        })
      }
    }
  }
}
```

### 自定义 TabBar

通过 WebTabsController 的联动，可以进行灵活的 TabBar 自定义和布局控制。
下面展示了一个自定义 TabBar，并将其布置在 WebTabs 组件下方的例子：

```typescript
import { WebTabs, WebTabItemType, WebTabItem, WebTabsController } from '@ncc/webtabs';
import { LengthMetrics } from '@ohos.arkui.node';

@Entry
@Component
struct Index {
  @State itemList: WebTabItemType[] = [
    { webSrc: 'https://developer.huawei.com/', label: 'huawei' },
    { webSrc: $rawfile('index.html'), label: 'local' }
  ];
  @State controller: WebTabsController = new WebTabsController();

  build() {
    Column({space: 20}) {
      Row() {
        WebTabs({
          itemList: this.itemList,
          controller: this.controller,
          enable_tabBar: false,
        })
      }.height('70%')
      // 页面下方的 tabBar
      Row() {
        Flex({ direction: FlexDirection.Row }) {
          ForEach(this.itemList, (item: WebTabItem, index: number) => {
            Column() {
              Text(item.label)
                .fontSize(30)
                .fontColor(Color.White)
                .onClick(() => {
                  this.controller.swiperController.changeIndex(index, true);
                })
                .textAlign(TextAlign.Center)
            }.width('50%')
            .backgroundColor(this.controller.currentIndex == index ? Color.Blue : Color.Black)
          })
        }
      }
    }
  }
}
```

### 自定义生命周期/事件

下面的例子展示了如何通过自定义 Web 组件和 Swiper 组件的生命周期/事件来实现当前 Url 的跟踪。在例子中，当 Web 组件完成页面加载或 Swiper 发生切换时，currentUrl 会更新：

```typescript
import { WebTabs, WebTabItemType, WebTabsController } from '@ncc/webtabs';
import { WebLifeCycle, CustomNodeController, WebBuilderParam } from '@ncc/webtabs';

@Entry
@Component
struct Index {

  @State tabController: WebTabsController = new WebTabsController();
  @State itemList: WebTabItemType[] = [
    { webSrc: 'https://developer.huawei.com/', label: 'huawei' },
    { webSrc: $rawfile('index.html'), label: 'local' }
  ];
  @State currentURL: string = 'Unloaded!';
  private lifeCycleList: WebLifeCycle[] = [];

  aboutToAppear(): void {
    // 自定义 Web 组件生命周期，以获取实时 url
    this.itemList.forEach(_ => {
      this.lifeCycleList.push(new WebLifeCycle({
        onPageEnd: () => {
          this.currentURL = this.tabController.getCurrentWebController().getUrl();
        }
      }));
    })
  }

  build() {
    Column({space: 20}) {
      Row() {
        WebTabs({
          itemList: this.itemList,
          controller: this.tabController,
          lifeCycleList: this.lifeCycleList,
          // 自定义 Swiper 组件事件
          onChange: () => {
            this.currentURL = this.tabController.getCurrentWebController().getUrl();
          }
        })
      }.height('70%')
      // 显示当前 Url
      Row() {
        Text('Current URL: ' + this.currentURL)
          .textAlign(TextAlign.Center)
          .maxLines(2).fontSize(20)
          .textOverflow({overflow: TextOverflow.Ellipsis})
      }
    }
    .width('100%')
    .height('100%')
  }
}
```

### 自定义预渲染时机

通过 `presetNode` 选项，开发者可以在别处进行预渲染，再传入生成好的 NodeController。
下面的例子中，预渲染步骤在 EntryAbility.ets 的 `onWindowStageCreate` 提前完成：

```typescript
import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';
import { WebTabs, WebNodeObject } from '@ncc/webtabs';
import { createWebNode } from '@ncc/webtabs';

// 预渲染的结果通过 export 导出
export let presetNodes: WebNodeObject[] = [];

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // 初始化 Web 组件内核
    webview.WebviewController.initializeWebEngine();
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    windowStage.loadContent('pages/Index', (err) => {
      // 提前预渲染
      let uiContext = windowStage.getMainWindowSync().getUIContext();
      let urlList: ResourceStr[] = [
       'https://main.m.taobao.com/',
       'https://sina.cn/',
       'https://m.jd.com/',
      ]
      urlList.forEach((item, index) => {
       presetNodes.push(createWebNode(uiContext, {url: item}))
      })
    });
  }
}
```

通过 `nodeObjects` 属性传参：

```typescript
import { presetNodes } from '../entryability/EntryAbility';
import { WebTabs, WebTabItemType } from '@ncc/webtabs';

@Entry
@Component
struct Index {
// 资源列表，使用 WebTabItemType 来初始化比较方便
@State itemList: WebTabItemType[] = [
   { webSrc: 'https://developer.huawei.com/', label: 'huawei' },
   { webSrc: $rawfile('index.html'), label: 'local' } // 支持本地文件
];

build() {
   Column() {
      WebTabs({ itemList: this.itemList, enable_presetNode: true, nodeObjects: presetNodes })
   }
}
}
```

## 约束与限制

在下述版本验证通过：DevEco Studio: 5.0 Beta1(5.0.3.806)，SDK: API12(5.0.0.25)

## 开源协议

本项目基于 Apache-2.0

## 更新记录

[1.0.0] 2024-9-28
初版。

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

## 兼容性

| 项目 | 值 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 |  |
| 设备类型 | 手机 |
| 平板 |  |
| PC |  |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

> Created with Pixso.

## 安装方式

```bash
ohpm install @ncc/webtabs
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/7b381b15c0274b02bb6e47853a7aaa88/PLATFORM?origin=template