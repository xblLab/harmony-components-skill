# SVRefresh 刷新加载组件

## 简介

SVRefresh 是一款 OpenHarmony 环境下，基于 ArkUI 封装的下拉刷新、上拉加载组件。支持主动触发刷新、开启/关闭刷新。上拉加载支持拖拽触发和完全展示自动触发。

## 详细介绍

### 介绍

SVRefresh 是一款 OpenHarmony 环境下，基于 ArkUI 封装的下拉刷新、上拉加载组件。
支持主动触发刷新、开启/关闭刷新。上拉加载支持拖拽触发和完全展示自动触发。

### 效果展示

### 安装教程

深色代码主题复制
```bash
ohpm install @mervin/svrefresh
```

### 使用说明

#### 使用示例

```typescript
import { FooterLoadMoreStatus, HeaderRefreshStatus, SVRefresh } from '@mervin/SVRefresh'

@Entry
@Component
struct Index {
  // 用来控制刷新状态
  @State private refreshStatus: HeaderRefreshStatus = HeaderRefreshStatus.inactive
  // 用来控制加载状态
  @State private loadMoreStatus: FooterLoadMoreStatus = FooterLoadMoreStatus.inactive

  build() {
    Column() {
      SVRefresh({
        /// 状态双向同步
        refreshStatus: this.refreshStatus,
        loadMoreStatus: this.loadMoreStatus,
        /// 参数 Scroller 必须绑定滚动组件
        childList: (scroller) => {
          this.listViewBuilder(scroller)
        },
        /// 可选：传入已经初始化的 Scroller | ListScroller。不传则由 SVRefresh 内部自行初始化 Scroller
        /// scroller: this.scroller,
        /// 可选配置
        refreshOptions: {
          /// 底部完全露出即加载更多，无需拖拽。不传默认为 true
          isAutoLoadMore: true,
          /// 深度刷新，下拉更多距离时触发。不传默认为 false
          deepRefreshEnable: false,
        },
        /// 触发刷新的回调
        onRefreshing: () => {
          this.viewModel.onRefreshing(() => {
            this.refreshStatus = HeaderRefreshStatus.inactive
            if (this.loadMoreStatus == FooterLoadMoreStatus.noMoreData) {
              this.loadMoreStatus = FooterLoadMoreStatus.inactive
            }
          })
        },
        /// 触发深度下拉刷新
        onDeepRefreshing: () => {
          this.refreshStatus = HeaderRefreshStatus.inactive
          /// 长下拉触发页面跳转事件
          router.pushUrl({
            url: 'pages/DeepRefreshView'
          }, router.RouterMode.Standard, (err) => {
            if (err) {
              console.log(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`)
            }
          })
        },
        /// 触发加载的回调
        onLoadingMore: () => {
          this.viewModel.onLoadMore((hasMoreData) => {
            this.loadMoreStatus = hasMoreData ? FooterLoadMoreStatus.inactive : FooterLoadMoreStatus.noMoreData
          })
        },
        /// 自定义 header
        headerUI: (state) => {
          this.testHeaderBuilder(state)
        },
        /// header 背景 view
        headerBackgroundUI: () => {
          this.headerBackgroundView()
        }
      })
    }
  }

  @Builder
  private listViewBuilder(scroller: Scroller) {
    List({ space: 20, scroller: scroller })
      .height("100%")
      .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true }) /*不要设置为 Fade，拖动至边缘会一直显示 Fade 效果，很难看*/
  }

  @Builder
  testHeaderBuilder($$: RefreshStateImp) {
    TestRefreshHeader({ state: $$.state })
  }
  
  @Builder
  headerBackgroundView() {
    Text('backgroundView')
      .fontColor('#FF2E43')
      .fontSize(18)
      .linearGradient({
        direction: GradientDirection.Top,
        colors: [['#551A1A1A', 0.0], ['#221A1A1A', 0.3], ['#001A1A1A', 1.0]]
      })
      .textAlign(TextAlign.Center)
      .width('100%')
      .height(250)
  }
}

@Component
struct TestRefreshHeader {
  @Link state: RefreshState

  ///...
}
```

其中 List 组件的 edgeEffect 属性不要设置为 (EdgeEffect.Fade)，展示效果不好

### 属性（接口）说明

SVRefresh 组件属性

| 名称 | 参数类型 | 描述 | 必填 |
| :--- | :--- | :--- | :--- |
| childList | @BuilderParam($$: Scroller) => void | 自定义主体布局，内部有列表或宫格组件，需绑定参数 scroller | ✅ |
| refreshStatus | HeaderRefreshStatus | 头部刷新组件状态，双向绑定 | ✅ |
| loadMoreStatus | FooterLoadMoreStatus | 尾部刷新组件状态，双向绑定 | ✅ |
| onRefreshing | () => void | 下拉刷新回调 | 否 |
| onDeepRefreshing | () => void | 深度下拉事件回调 | 否 |
| onLoadingMore | () => void | 上拉加载回调 | 否 |
| scroller | Scroller | 由外部初始化与列表绑定的 Scroller。可以不传，SVRefresh 内部会自行初始化 Scroller | 否 |
| refreshOptions | SVRefreshOptions | 刷新组件相关配置：如 header、footer 的高度，是否开启弹性效果，是否自动触发底部加载 | 否 |
| headerUI | @BuilderParam($$: RefreshStateImp) => void | 自定义下拉刷新组件，不传为默认样式 | 否 |
| footerUI | @BuilderParam($$: RefreshStateImp) => void | 自定义上拉加载组件，不传为默认样式 | 否 |
| headerBackgroundUI | @BuilderParam() => void | 作为 headerUI 的 background 展示的 自定义 UI，展示范围可以超出 header 的高度 | 否 |
| componentOptions | SVRefreshComponentOptions | 默认刷新组件的 UI 配置，都是默认刷新控件的样式，使用自定义控件不需要赋值 | 否 |
| onHeaderStateChange | (state: RefreshState) => void | header 刷新状态改变回调 | 否 |
| onFooterStateChange | (state: RefreshState) => void | footer 刷新状态改变回调 | 否 |

### HeaderRefreshStatus 枚举说明

可同步触发刷新组件的状态改变

| 名称 | 枚举值 | 描述 |
| :--- | :--- | :--- |
| hidden | 0 | 隐藏状态，禁用下拉刷新 |
| inactive | 1 | 普通闲置状态，可触发刷新 |
| refreshing | 2 | 正在刷新中的状态，主动赋值列表会滚动到顶部并触发刷新 |
| deepRefreshing | 3 | 正在深度下拉刷新状态，主动赋值列表会滚动到顶部并触发事件 |

### FooterLoadMoreStatus 枚举说明

可同步触发加载组件的状态改变

| 名称 | 枚举值 | 描述 |
| :--- | :--- | :--- |
| hidden | 0 | 隐藏状态，禁用上拉加载 |
| inactive | 1 | 普通闲置状态，可触发加载 |
| loading | 2 | 正在加载中的状态，主动赋值可以触发加载回调，但不会触发列表滚动 |
| noMoreData | 3 | 无更多数据状态，展示但是不可触发刷新 |

### SVRefreshOptions 对象说明

刷新组件相关配置，均为可选值

| 参数名 | 类型 | 描述 | 默认值 |
| :--- | :--- | :--- | :--- |
| headerHeight | number | 下拉刷新控件的展示高度，同时也是触发下拉事件的高度 | 64 |
| footerHeight | number | 上拉加载控件的展示高度，同时也是触发上拉事件的高度 | 54 |
| isAutoLoadMore | boolean | 可以控制上拉加载组件的触发方式，自动 or 拖拽 | true |
| onlyAutoLoadMoreOnceOnSingleDrag | boolean | 当 isAutoLoadMore 为 true 时，可以控制单次拖拽期间内只能触发一次 loading | false |
| headerBounces | boolean | 下拉是否支持弹性效果 | true |
| footerBounces | boolean | 上拉是否支持弹性效果 | true |
| deepRefreshEnable | boolean | 是否支持深度下拉事件 | false |
| deepRefreshTriggersHeight | number | 触发深度下拉事件的偏移量，不能低于 headerHeight | 125 |

### SVRefreshComponentOptions 对象说明

都是默认刷新控件的样式，使用自定义控件不需要关心这个属性

| 参数名 | 类型 | 描述 | 默认值 |
| :--- | :--- | :--- | :--- |
| headerFont | Font | 默认 header 的字体 | { size: 16 } |
| footerFont | Font | 默认 footer 的字体 | { size: 16 } |
| headerLoadingProgressSize | length | header 的默认 loading 组件尺寸 | 36 |
| footerLoadingProgressSize | length | footer 的默认 loading 组件尺寸 | 36 |
| headerText | (state: RefreshState) => string | 各刷新状态下 header 展示的文字 | - |
| footerText | (state: RefreshState) => string | 各刷新状态下 footer 展示的文字 | - |

### RefreshState 枚举说明

刷新组件 UI 展示的不同阶段

| 名称 | 枚举值 | 描述 |
| :--- | :--- | :--- |
| hidden | 0 | 隐藏禁用状态 |
| inactive | 1 | 普通闲置状态，可触发加载 |
| drag | 2 | 下拉中但未达到刷新距离 |
| overDrag | 3 | 松开就可以进行刷新的状态，footer 的 isAutoLoadMore 为 true 时不会走到这个状态 |
| refreshing | 4 | 正在刷新中的状态 |
| noMoreData | 5 | 所有数据加载完毕，没有更多的数据了。仅 footer 可以有这个状态 |
| deepPulling | 6 | 下滑至更高的 offset ,松开触发 deep 回调。仅 header 可以有这个状态 |
| deepRefreshing | 7 | 下滑至更高的 offset 触发，不再走正常刷新逻辑。仅 header 可以有这个状态 |

## 约束与限制

在下述版本验证通过：

DevEco Studio: 4.1 Canary(4.1.3.500), SDK: API11 (4.1.0.36)

## TODO LIST

- 使用 List 嵌套模式实现刷新，可以做到 footer 自动贴在尾部数据之后，而不是一定要拖拽才能出现

## 贡献代码

使用过程中发现任何问题都可以提 Issue 给我们，当然，我们也非常欢迎你给我们发 PR 。

## 开源协议

本项目基于 Apache License 2.0，请自由地享受和参与开源。

## 更新记录

- **v1.1.64** [2025.12]
  - 增加 refreshBackgroundColor 的设置
- **v1.1.63** [2024.09]
  - fix: 当列表滚动一定距离后，通过代码触发 header 刷新。如果列表还未滚动到顶部就已设置刷新结束，会在列表滚动到顶部后继续露出 header
- **v1.1.62** [2024.09]
  - fix: footer 展示时，通过代码触发下拉刷新，为 footer 添加隐藏动作
- **v1.1.61** [2024.09]
  - 打开 bounce 时，增加拖动阻尼效果。
- **v1.1.60** [2024.08]
  - 可以在 headerUI 的页面层级下方设置 backgroundView，高度需自行设置，可以超出 headerUI。
  - 增加 deepRefreshing 深度下拉事件功能，默认不启用。
  - 当 deepRefreshEnable 开启时，下拉距离超过 headerHeight 达到更高的 offset 时可以触发深度下拉事件。
  - fix：修复了在 onRefresh 回调中同步设置 refreshStatus 为 inactive 后，仍然表现为 refreshing 状态的问题
- **v1.1.51** [2024.05]
  - 使用新的方式避免可能出现的列表更新不及时导致频繁多次触发 loadMore 回调的问题。
  - onlyAutoLoadMoreOnceOnSingleDrag 功能仍保留，但默认值改为 false。
- **v1.1.5** [2024.05]
  - 增加 onlyAutoLoadMoreOnceOnSingleDrag，默认值为 true。
  - 当自动触发上拉加载设置为 true 时，默认单次拖拽只能触发一次回调。避免可能出现的列表更新不及时导致频繁多次触发 loadMore 回调的问题
- **v1.1.4** [2024.04]
  - fix bug：拖拽过程中设置 hidden 会导致 Offset 出现异常
- **v1.1.3** [2024.04]
  - 将 HeaderRefreshStatus 和 FooterLoadMoreStatus 换回@Link。
  - 绝大部分使用场景都是页面内状态同步，使用常规变量的情景较少。
  - 而且也可以通过先将常规变量的修改同步到页面内状态，再由状态改变同步更新 UI。
  - 为了少数场景增加多数场景的开发成本，并不划算。
  - @BuilderParam headerUI 和@BuilderParam footerUI 改为带参数形式，方便使用。
- **v1.1.2** [2024.04]
  - 将 HeaderRefreshStatus 和 FooterLoadMoreStatus 从@Link 改为@Prop。
  - 如果监听组件状态，可以使用 onHeaderStateChange 和 onFooterStateChange，refreshStatus 没有双向绑定的必要。
  - 而且@Link 限制了不能使用常规变量来初始化，必须与父组件的@State 等状态变量绑定，限制了使用场景，故去掉双向绑定。
- **v1.1.1** [2024.04]
  - fix：初始状态为 hidden 时对应的刷新控件未禁用
- **v1.1.0** [2024.04]
  - 调整 API
  - 删除 SVRefreshController
  - 增加 HeaderRefreshStatus 和 FooterLoadMoreStatus。使用状态同步而不是面向对象方式控制刷新状态。
  - 删除 SVRefreshUIConfigurator。
  - 增加 SVRefreshOptions 控制刷新组件通用 UI 设置。
  - 增加 SVRefreshComponentOptions 配置默认刷新控件样式。
- **v1.0.0** [2024.03]
  - 支持下拉刷新
  - 支持上拉加载更多
  - 上拉加载更多支持自动触发和手动触发两种模式
  - 支持通过 controller 控制刷新状态
  - 支持自定义组件 UI

## 权限与隐私基本信息

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 | HarmonyOS 版本：5.0.0 |
| 应用类型 | 应用 Created with Pixso. |
| 元服务 | Created with Pixso. |
| 设备类型 | 手机 Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 Created with Pixso. |

## 安装方式

```bash
ohpm install @mervin/svrefresh
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/cae68a24ad9a49bc869677a21e306d29/PLATFORM?origin=template