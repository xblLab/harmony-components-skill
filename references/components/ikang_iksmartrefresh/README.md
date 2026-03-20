# 自定义刷新组件

## 简介

IKSmartRefresh 是一款专为 HarmonyOS NEXT 打造的直接/间接使用的上拉加载的组件，深度融合 HarmonyOS5.0 的能力，为开发者提供简洁高效的图开发体验。它基于 ArkUI 框架开发，支持直接使用，自定义 Header 和 Footer 组件的刷新组件；

## 详细介绍

IkSmartRefrsh
一个智能刷新组件，适用于 HarmonyOS 的开发，提供便捷的竖向下拉刷新和上拉加载功能、。

### 下载安装

深色代码主题复制
```bash
ohpm install @ikang/iksmartrefresh
```

深色代码主题复制
```typescript
import { IKRefreshController, IKSmartRefreshLayout, PullToRefreshConfig } from '@ikang/iksmartrefresh';
```

### 软件架构

该项目基于 HarmonyOS 的 ETS 架构开发，主要包含以下模块：

*   **配置模块**：包含 Constant.ets、IKRefreshUIConfig.ets 和 PullToRefreshConfig.ets，用于管理刷新组件的相关配置。
*   **控制器模块**：IKRefreshController.ets 提供刷新逻辑的控制与状态管理。
*   **布局与页面模块**：IKSmartRefreshLayout.ets 和 IkRefreshLayout.ets 实现刷新的 UI 布局。
*   **辅助模块**：IKRefreshLayoutHelper.ets 提供刷新过程中的辅助功能。

## 使用说明

在页面中使用 IkSmartRefreshLayout 组件作为容器。

### IKSmartRefreshLayout 使用说明 (常规组件)

深色代码主题复制
```typescript
//定义一个数据模型
export interface ItemModel {
  name: string;
  age: string;
  imgUrl: ResourceStr

}

@Route({ name: 'List' })
@Component
export struct ListView {
  @State message: string = 'Hello World';
  //定义控制器
  public controller: IKRefreshController = new IKRefreshController()
  scroller: Scroller = new Scroller()
  adapter: DataAdapter<ItemModel> = new DataAdapter<ItemModel>()
  private config: PullToRefreshConfig = new PullToRefreshConfig()

  aboutToAppear(): void {
    for (let i = 0; i < 10; i++) {
      this.adapter.data.push({
        name: `我是第 ${i}个测试 Item`,
        age: i + '岁',
        imgUrl: $r("app.media.img_second_res")
      })
    }
    this.adapter.notifyDataReload()
  }

  @Builder
  contentView() {
    List({ scroller: this.scroller }) {
      LazyForEach(this.adapter, (item: ItemModel, index) => {
        ListItem() {
          Column({space: 10}) {
            Text(item.name)
              .fontSize(15)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 10 })
            Text(item.age)
            Image(item.imgUrl)
              .width('100%')
              .height('auto')
          }
        }
      }, (item: string, index) => item)
    }.width("100%").height("100%")
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.None)
  }

  build() {
    NavDestination() {
      Column() {
        IKSmartRefreshLayout({
          scroller: this.scroller,
          viewKey: "ListPage", //记录刷新时间的 key
          /*0:设置控制器*/
          controller: this.controller,
          /*1：具体内容 View*/
          contentView: () => {
            this.contentView()
          },
          /*2：刷新回调*/
          onRefresh: () => {
            setTimeout(() => {
              this.adapter.data.splice(0, 0,
                {
                  name: `我是新增的测试 Item`,
                  age:   '新增岁',
                  imgUrl: $r("app.media.img_list")
                }
              )
              this.adapter.notifyDataAdd(0)
              this.controller.refreshSuccess()
            }, 1000)
          },
          /*3：是否可以下拉*/
          onCanPullRefresh: () => {
            if (!this.scroller.currentOffset()) {
              /*处理无数据，为空的情况*/
              return true
            }
            //如果列表到顶，返回 true，表示可以下拉，返回 false，表示无法下拉
            return this.scroller.currentOffset().yOffset <= 0
          },
          /*4：加载回调*/
          onLoadCallBack: () => {
            setTimeout(() => {
              this.adapter.data.push(
                {
                  name: `我是新增的测试 Item`,
                  age:   `${this.adapter.totalCount()}新增岁`,
                  imgUrl: $r("app.media.img_list")
                }
              )
              this.adapter.notifyDataAdd(this.adapter.totalCount() - 1)
              this.controller.loadSuccess()
            }, 1000)
          },
          /*5：是否可以上拉*/
          onCanPullLoad: () => {
            //如果列表到底部，返回 true，表示可以上拉，返回 false，表示无法上拉
            return this.scroller.isAtEnd()
          }
        }).width("100%").height("100%").clip(true)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .height('100%')
      .width('100%')
    }.hideTitleBar(true)
  }
}
```

### 自定义 IkRefreshLayout 使用说明（用户自定义）

深色代码主题复制
```typescript
@Route({name: 'CustomerHeaderList'})
@Component
export struct CustomerHeaderList{
  private mainRenderingSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private mainCanvasRenderingContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.mainRenderingSettings)
  private animationItem: AnimationItem | undefined
  private path: string = "lottie/pull_refresh.json"
  public controller: IKRefreshController = new IKRefreshController()
  adapter: DataAdapter<String> = new DataAdapter<String>()
  scroller: Scroller = new Scroller()
  @State pullDown: PullDownConfig | undefined = undefined

  @State status: IKRefreshStatus = IKRefreshStatus.DEF

  public config: IKRefreshUIConfig = new IKRefreshUIConfig()
  aboutToAppear(): void {
    for (let i = 0; i < 16; i++) {
      this.adapter.data.push(i + " item")
    }
    this.adapter.notifyDataReload()
    this.config.pullHeaderHeightRefresh=110
  }

  aboutToDisappear(): void {
    this.animationItem?.destroy('lottie');
  }

  build() {
    NavDestination() {
      IkRefreshLayout({
        config: this.config,
        scroller: this.scroller,
        /*0:设置控制器*/
        controller: this.controller,
        /*1：自定义 Header View*/
        customerHeaderView: () => {
          this.defHeaderView()
        },
        /*2：自定义 Footer View(加载更多)*/
        customerLoadView: () => {
          this.defFooterView()
        },
        /*3：内容 View*/
        customerContentView: () => {
          this.contentView()
        },
        /*4：刷新回调*/
        onRefresh: () => {
          this.animationItem?.play()
          setTimeout(() => {
            this.adapter.data.splice(0, 0, "刷新 item" + this.adapter.totalCount())
            this.adapter.notifyDataAdd(0)
            this.controller.refreshSuccess()
          }, 3000)
        },
        /*5：是否可以下拉*/
        onCanRefresh: () => {
          if (!this.scroller.currentOffset()) {
            /*处理无数据，为空的情况*/
            return true
          }
          //如果列表到顶，返回 true，表示可以下拉，返回 false，表示无法下拉
          return this.scroller.currentOffset().yOffset <= 0
        },
        /*6：加载回调*/
        onLoadCallBack: () => {
          setTimeout(() => {
            this.adapter.data.push("新增 item" + this.adapter.totalCount())
            this.adapter.notifyDataAdd(this.adapter.totalCount() - 1)
            this.controller.loadSuccess()
          }, 1000)
        },
        /*7：是否可以上拉*/
        onCanPullLoad: () => {
          //如果列表到底部，返回 true，表示可以上拉，返回 false，表示无法上拉
          return this.scroller.isAtEnd()
        },
        /*8：监听下拉上拉状态，便于实现自定义动画*/
        onPullListener: (pullDown) => {
          this.pullDown=pullDown
          if (pullDown.pullDistance <= 0) {
            this.animationItem?.pause()
          }
        }
      })
        .width("100%")
        .height("100%")
        .clip(true) /******直接使用 IKRefreshLayout 必须要加这个 clip(true) 属性*******/

    }.hideTitleBar(true)
  }

  @Builder
  defHeaderView() {
    Stack({ alignContent: Alignment.Bottom }) {
      Canvas(this.mainCanvasRenderingContext)
        .height("160").width("100%").offset({ y: 50 })// .backgroundColor(Color.Gray)
        .onReady(() => {
          //抗锯齿的设置
          this.mainCanvasRenderingContext.imageSmoothingEnabled = true;
          this.mainCanvasRenderingContext.imageSmoothingQuality = 'medium'
          this.playAnim()
        })

    }.width("100%").height(100)
    .backgroundColor($r('app.color.black'))

  }

  private playAnim() {
    this.animationItem?.destroy('lottie'); //加载动画前先销毁之前加载的动画
    this.animationItem = lottie.loadAnimation({
      container: this.mainCanvasRenderingContext, // 渲染上下文
      renderer: 'canvas', // 渲染方式
      loop: true, // 是否循环播放，默认 true
      autoplay: true, // 是否自动播放，默认 true
      name: 'lottie', // 动画名称
      contentMode: 'Contain', // 填充的模式
      frameRate: 30, //设置 animator 的刷帧率为 30
      path: this.path, // json 路径
      initialSegment: [0, 90]                      // 播放的动画片段
    })
    this.animationItem?.addEventListener("DOMLoaded", () => {
      this.animationItem?.goToAndStop(1, true)
    })
  }

  @Builder
  contentView() {
    List({ scroller: this.scroller }) {
      LazyForEach(this.adapter, (item: string, index) => {
        ListItem() {
          Text(item).width("100%").height("60")
        }
      }, (item: string, index) => item)
    }.width("100%").height("100%")
    .edgeEffect(EdgeEffect.None) /*.id("list")*/
  }
  @State pause:boolean=false
  onPageShow(): void {
    this.pause=false
  }
  onPageHide(): void {
    this.pause=true
  }
  @Builder
  defFooterView() {
    LottieView({lottiePath:"lottie/pull_refresh.json",pause:$pause}).height(150).width("100%")
  }

}
```

可自定义刷新头和加载更多尾部样式，参考 PullToRefreshConfig 进行配置。

## 配置模块

### IKRefreshStatus

| 状态描述 |
| :--- |
| PullDown 下拉状态 |
| PreRefresh 下拉至可以刷新的状态 (准备刷新) |
| Refresh 刷新中 |
| RefreshSuccess 刷新成功 |
| RefreshError 刷新失败 |
| PullUp 上拉中 |
| PreLoad 上拉至可以加载的状态 (准备加载) |
| Loading 正在加载更多 |
| LoadSuccess 加载成功 |
| LoadError 加载失败 |

### PullDownConfig

| Key | 类型 | 描述 |
| :--- | :--- | :--- |
| isPullDown | boolean | 是否下拉 |
| isPullUp | boolean | 是否上拉 |
| isTouch | boolean | 是否触摸 |
| pullDistance | number | 下拉距离 |
| distanceLoad | number | 上拉距离 |
| headerViewSize | number | headerView 高度 |
| footerViewSize | number | footerView 高度 |
| status | IKRefreshStatus | 加载状态 |

### 配置刷新控制器 IKRefreshController 来控制刷新状态。

#### Controller 介绍

| 函数 | 描述 | 返回 |
| :--- | :--- | :--- |
| refreshSuccess | 刷新成功 | 无 |
| refreshError | 刷新失败 | 无 |
| refreshComplete | 刷新完成 | 无 |
| refreshCancel | 取消刷新 | 无 |
| loadSuccess | 加载成功 | 无 |
| loadError | 加载失败 | 无 |
| loadComplete | 加载完成 | 无 |
| loadCancel | 取消加载 | 无 |
| getStatus | 获取当前刷新状态 | IKRefreshStatus |
| getConfig | 获取配置 | IKRefreshUIConfig |
| setConfig | 设置刷新配置 | 无 |

### IKRefreshLayoutHelper 介绍

通过 IKRefreshLayoutHelper 设置刷新动画和触发逻辑。

```typescript
/**
   * Records the offset when the list scrolls to the bottom
   * 记录列表滑动到底部的偏移量
   */
  public scrollerOffset: number = 0;
  
  /**
   * Pull down refresh - previous offset
   * 下拉刷新 - 上一次偏移量
   */
  public preOffset: number = 0;
  
  /**
   * Pull down refresh - total offset
   * 下拉刷新 - 总偏移量
   */
  public totalOffset: number = 0;
  
  /**
   * Pull up load - total offset
   * 上拉加载 - 总偏移量
   */
  // public preOffsetLoad: number = 0;
  public totalOffsetLoad: number = 0;
  
  /**
   * Header view size
   * 头部视图高度
   */
  public headerSize: number = 0;
  
  /**
   * Footer view size
   * 底部视图高度
   */
  public footerSize: number = 0;
  
  /**
   * Whether the user is pressing down
   * 用户是否正在按下
   */
  public isPressDown: boolean = false
  
  /**
   * Pan gesture options for handling pull gestures
   * 处理拖拽手势的选项
   */
  public options: PanGestureOptions = new PanGestureOptions({ direction: PanDirection.Down | PanDirection.Up })
  
  /**
   * Not release to refresh
   * 非释放刷新状态
   */
  public notReleaseRefresh: boolean = false
  
  /**
   * Not release to load
   * 非释放加载状态
   */
  public notReleaseLoad: boolean = false
```

## Gitee 特性

支持 Gitee 提供的标准 Issue 与 Pull Request 模板，便于社区协作与问题反馈。

## 许可证

本项目遵循 MIT 许可证，详见 LICENSE 文件。

## 更新记录

### 1.0.4 (2025-11-26)

初始版本、目前仅支持竖向下拉刷新上拉加载，更新 HAR 包签名，删除包中三方链接权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 网络访问权限 | 可以通过该权限访问设备网络 | 通过网络加载数据绘制到组件 |
| 隐私政策 | 不涉及 SDK | 合规使用指南 不涉及 |

| 兼容性 | HarmonyOS 版本 |
| :--- | :--- |
| 5.0.0 |

Created with Pixso.

| 应用类型 | 应用 |
| :--- | :--- |
| Created with Pixso. | |
| 元服务 | |
| Created with Pixso. | |
| 设备类型 | 手机 |
| Created with Pixso. | |
| 平板 | |
| Created with Pixso. | |
| PC | |
| Created with Pixso. | |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |
| Created with Pixso. | |

## 安装方式

```bash
ohpm install @ikang/iksmartrefresh
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/60e540678e3644a1b60af6880cdc095a/c5ef800e4cc6476ab179493aa30dff52?origin=template