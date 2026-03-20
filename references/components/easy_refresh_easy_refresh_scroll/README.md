# EasyRefreshScroll 上拉下拉刷新组件

## 简介

HarmonyOsRefresh 是基于 ArkUI 封装的上拉下拉刷新组件，支持 List、Grid、WaterFlow,Scroll 组件刷新

## 详细介绍

### 简介
EasyRefreshScroll 上拉，下拉刷新工具。

### 装饰器版本
- v1 装饰器版本
- v2 装饰器版本

### 注
从 1.0.6 版本开始支持 refreshingContent 自定义头部刷新区域，如果设置了 refreshNode.contentNode，那么 customFreshHeader?: CustomBuilder 会失效。之前版本的方法会保留。

### 已知问题
基于 ArkUI 封装的上拉下拉刷新组件，支持列表、网格、瀑布流、以及各种自定义组件的刷新。
对 EasyRefresh 库的升级，全面采用了 V2 状态管理，代码的全面重构，把更多的权限控制交给使用者，它只负责刷新。业务方面和显示样式方面根据由使用者自行控制。
属性和使用方面比 EasyRefresh 库的属性更少，更加方便好用。
希望构建一种对使用者来说使用快捷，方便，不要让使用者在使用过程中感到复杂，繁琐的操作。
备注：之所以没有在 EasyRefresh 库上面直接重构，因为 EasyRefresh 库现在很多项目在使用，无法直接在这个库上面进行修改，所以才有了 EasyRefreshScroll 这个库，再次感谢大家的支持和使用。

### 特性列表
1. 支持 List 列表、Gird、WaterFlow、自定义组件的 Scroll 上拉下拉刷新
2. 支持自定义刷新 header,footer 刷新样式
3. 支持自定义插入头部信息，以及底部信息

## 效果展示
动态效果：
静态效果：
注：请下载 demo 详情查看效果。

## 更多案例
可以查看相关 Demo 并下载。
运行 Demo，如果自身相关开发环境不一致，会运行失败，可更改环境或者直接源码复制至您的项目即可。

## 开发环境
- DevEco Studio 5.0.1 Release, Builder Version:5.0.5.310
- Api 版本：12

## 快速上手

### 安装方式
#### 1、命令安装
在 Terminal 窗口中，执行如下命令安装三方包，DevEco Studio 会自动在工程的 oh-package.json5 中自动添加三方包依赖。
建议：可以自行指定安装目录

```bash
ohpm install @easy_refresh/easy_refresh_scroll
```

**版本更新：**
```bash
ohpm update @easy_refresh/easy_refresh_scroll
```

#### 2、在工程的 oh-package.json5 中设置三方包依赖
配置示例如下：

```json5
"dependencies": { "@easy_refresh/easy_refresh_scroll": "^1.0.4"}
```

下载之后，把 har 包复制项目中，目录自己创建，如下，我创建了一个 libs 目录，复制进去。
引入之后，进行同步项目，点击 Sync Now 即可，当然了你也可以，将鼠标放置在报错处会出现提示，在提示框中点击 Run 'ohpm install'。

## 属性介绍

| 属性名 | 类型 | 说明 |
| :--- | :--- | :--- |
| finished | boolean | 是否还有下一页数据（必填） |
| isEmpty | boolean | 是否没有数据 (必填) |
| pullUpTimer | number | 默认上拉加载显示停留时间，默认 1000(非必填) |
| isAutoRefresh | boolean | 是否开启主动刷新，默认 false(非必填) |
| finishText | string | 底部没有更多显示文字，默认我是有底线的~~~(非必填) |
| loadingText | string | 底部加载中的示文字，默认正在加载中...(非必填) |
| refreshOffset | number | 下来刷新触发的距离，默认 64(非必填) |
| pullDownRatio | number | undefined 有效值为 0-1 之间的值，小于 0 的值会被视为 0，大于 1 的值会被视为 1，默认 undefined(非必填) |
| disEnablePullDownRefresh | boolean | 禁用下拉刷新，默认关闭 false(非必填) |
| disEnablePullUpRefresh | boolean | 禁用上拉刷新，默认关闭 false(非必填) |
| isCustomRefresh | boolean | 是否开启自定义上拉刷新（非必填） |
| customFreshHeader | @BuilderParam | 自定义的刷新头部信息 (非必填) |
| customFreshFooter | @BuilderParam | 自定义刷新尾部信息 (非必填) |
| customHeader | @BuilderParam | 自定义插入的头部信息（非必填） |
| customFooter | @BuilderParam | 自定义插入的头部信息（非必填） |
| isCustomNoMore | @BuilderParam | 是否开启自定义底部没有更多内容显示信息，默认 false（非必填） |
| customNoMoreView | @BuilderParam | 自定义底部没有更多内容显示信息（非必填）需要配合 isCustomNoMore 一起使用才会生效 |
| contentView | @BuilderParam | 内容区域 (必填) |
| customEmptyView | @BuilderParam | 自定义空白页面 (非必填) |
| refreshCallBack | () => void | 下拉刷新的回调方法 |
| loadMoreCallBack | () => void | 上拉加载更多的回调方法 |
| controller | @Param | 控制器，默认可以不需要传入，但是监控滚动事件的时候需要传入 |
| onDidScroll | @Event | 滚动事件的回调 |
| onScrollStop | @Event | 滚动事件的回调 |
| onScrollStart | @Event | 滚动事件的回调 |
| onChangeState | @Event | 下拉刷新状态的回调 |

## 使用示例

### 关于网络请求部分的模拟代码
```typescript
// 网络请求方法：
async getData(append: boolean) {
    setTimeout(() => {
      if (!append) {
        this.page = 1
      }
      let array: number[] = [];
      let startIndex = (this.page - 1) * 10;
      let endIndex = this.page * 10;

      for (let index = startIndex; index < endIndex; index++) {
        array.push(index);
      }

      if(append){
        this.dataArray.push(...array)
      }else {
        this.dataArray = []
        this.dataArray = array
      }
      this.page ++

    }, 500)
  }
```

### 自定义没有更多内容
```typescript
@Builder
  noMoreView() {
    Row() {
      Text('我是 list 自定义的没有更多内容了')
        .fontColor(Color.White)
    }
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.Brown)
    .width('100%')
    .height(60)
  }
```

### 自定义空白页
```typescript
@Builder
  customEmptyView(){
    Row(){
      Text('我是 list 自定义的空白页')
        .fontSize(16)
        .fontColor(Color.Red)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
```

### List 的使用
```typescript
build() {
    NavDestination() {
      Column() {
        NavBarView({ title: this.params?.title })
        EasyFreshScroll({
          finished: this.dataArray.length < this.total ? true : false, //是否有下一页
          isEmpty: this.dataArray.length > 0 ? false : true, //是否为空页面
          isAutoRefresh:false, //是否开启进入页面的时候进行主动刷新
          disEnablePullUpRefresh:false,//禁用上拉
          isCustomNoMore:false, //开启自定义没有更多内容，默认 false
          refreshCallBack: (async () => {
            await this.getData(false) //下拉网络请求的回调
          }),
          loadMoreCallBack: (async () => {
            await this.getData(true) //上拉加载更多的回调
          }),
          contentView: () => {
            this.listView()
          },
          // 如果不自定义空白页，会使用默认的空白页面，如果既不想显示默认的空白，
          // 只想显示一个空白的内容，直接给自定义空白页，给一个空的就可以了，
          // 不指定任何内容
          // customEmptyView:()=>{
          //   this.customEmptyView()
          // }
          customNoMoreView:()=>{
            this.noMoreView()
          },
          onDidScroll:(xOffset: number, yOffset: number, scrollState: ScrollState)=>{

          },

        })
          .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .margin({
        top: ScreenManager.getInstance().model?.topHeight,
        bottom: ScreenManager.getInstance().model?.bottomHeight
      })
    }
    .onReady((ctx) => {
      const item = ctx.pathInfo.param as TitleItemModel
      this.params = item
    })
    .hideTitleBar(true)
  }
```

### Gird 的使用
```typescript
build() {
    NavDestination(){
      Column() {
        NavBarView({title:this.params?.title})
        EasyFreshScroll({
          finished: this.dataArray.length < this.total ? true : false, //是否有下一页
          isEmpty: this.dataArray.length > 0 ? false : true, //是否为空页面
          isAutoRefresh:false, //是否开启进入页面的时候进行主动刷新
          refreshCallBack: (async () => {
            await this.getData(false) //下拉网络请求的回调
          }),
          loadMoreCallBack: (async () => {
            await this.getData(true) //上拉加载更多的回调
          }),
          contentView: () => {
            this.contentView()
          },
          // 如果不自定义空白页，会使用默认的空白页面，如果既不想显示默认的空白，
          // 只想显示一个空白的内容，直接给自定义空白页，给一个空的就可以了，
          // 不指定任何内容
          // customEmptyView:()=>{
          //   this.customEmptyView()
          // }
        })
          .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        top:ScreenManager.getInstance().model?.topHeight,
        bottom: ScreenManager.getInstance().model?.bottomHeight
      })
    }
    .onReady((ctx)=>{
      const item = ctx.pathInfo.param as TitleItemModel
      this.params = item
    })
    .hideTitleBar(true)
  }
```

### WaterFlow 的使用
```typescript
build() {
    NavDestination(){
      Column() {
        NavBarView({title:this.params?.title})
        EasyFreshScroll({
          finished: this.dataArray.length < this.total ? true : false, //是否有下一页
          isEmpty: this.dataArray.length > 0 ? false : true, //是否为空页面
          isAutoRefresh:false, //是否开启进入页面的时候进行主动刷新
          refreshCallBack: (async () => {
            await this.getData(false) //下拉网络请求的回调
          }),
          loadMoreCallBack: (async () => {
            await this.getData(true) //上拉加载更多的回调
          }),
          contentView: () => {
            this.contentView()
          },
          // 如果不自定义空白页，会使用默认的空白页面，如果既不想显示默认的空白，
          // 只想显示一个空白的内容，直接给自定义空白页，给一个空的就可以了，
          // 不指定任何内容
          // customEmptyView:()=>{
          //   this.customEmptyView()
          // }

        })
          .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        top:ScreenManager.getInstance().model?.topHeight,
        bottom: ScreenManager.getInstance().model?.bottomHeight
      })
    }
    .onReady((ctx)=>{
      const item = ctx.pathInfo.param as TitleItemModel
      this.params = item
    })
    .hideTitleBar(true)
  }
```

### Scroll 自定义的使用
```typescript
build() {
    NavDestination(){
      Column() {
        NavBarView({title:this.params?.title})

        EasyFreshScroll({
          finished: false, //是否有下一页
          isEmpty: this.dataArray.length > 0 ? false : true, //是否为空页面
          isAutoRefresh:false, //是否开启进入页面的时候进行主动刷新
          refreshCallBack: (async () => {
            await this.getData(false) //下拉网络请求的回调
          }),
          loadMoreCallBack: (async () => {
            await this.getData(true) //上拉加载更多的回调
          }),
          contentView: () => {
            this.contentItem()
          },
          // 如果不自定义空白页，会使用默认的空白页面，如果既不想显示默认的空白，
          // 只想显示一个空白的内容，直接给自定义空白页，给一个空的就可以了，
          // 不指定任何内容
          // customEmptyView:()=>{
          //   this.customEmptyView()
          // }

        })
          .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        top:ScreenManager.getInstance().model?.topHeight,
        bottom: ScreenManager.getInstance().model?.bottomHeight
      })
    }
    .onReady((ctx)=>{
      const item = ctx.pathInfo.param as TitleItemModel
      this.params = item
    })
    .hideTitleBar(true)
  }
```

## 更多案例
可以查看相关 Demo 并下载
运行 Demo，如果自身相关开发环境不一致，会运行失败，可更改环境或者直接源码复制至您的项目即可。

## 贡献者
非常感谢大家对本项目的付出，在此感谢大家的努力，欢迎更多的同学加入进来交流，名次不分先后。

## License
Apache-2.0

## 更新记录

### [v1.1.1] 2025-10-16
修复在设置半透明失败的问题

### [v1.1.0] 2025-03-16
优化 refreshNode.contentNode 的逻辑

### [v1.0.9] 2025-03-13
更新 readme

### [v1.0.8] 2025-03-09
demo 仓库调整

### [v1.0.7] 2025-03-06
修改 readme 信息

### [v1.0.6] 2025-03-03
- 修复页面作为整体下拉的问题，注意：在使用 list 的时候不要给 list 设置高度 height('100%) 或者.layoutWeight(1)
- demo 中增加 Tab 嵌套 List 的使用示列
- 优化数据较少的时候，内容居中显示的逻辑优化
- 从 1.0.6 版本开始支持 refreshingContent 自定义头部刷新区域，如果设置了 refreshNode.contentNode，那么 customFreshHeader?: CustomBuilder 会失效。

### [v1.0.5] 2025-01-17
修复主动刷新不成功的问题

### [v1.0.4] 2025-01-06
- 修复自定义上拉偶发显示异常状态的问题
- 增加支持上拉显示停留时间默认 1000
- 修复滚动条 BarState 显示问题，默认不显示
- 修复下拉刷新状态的回调
- 修复上拉加载更多请求失败的相关异常处理
- 修复我是有底线的显示问题

### [v1.0.3] 2024-11-17
- 修复偶发上拉加载显示异常的问题
- 开放底部加载的显示文字可以修改

### [v1.0.2] 2024-9-23
修复自定义没有更多内容失效的问题

### [v1.0.1] 2024-9-15
修复命名问题

### [v1.0.0] 2024-9-6
- 支持 List 列表、Gird、WaterFlow、自定义组件的 Scroll 上拉下拉刷新
- 完成对 EasyFresh 库的重构升级

## 权限与隐私

| 字段 | 值 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 | HarmonyOS 版本 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | 无 |
| 设备类型 | 手机，平板，PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.1 |

## 来源
- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/67b4d14f93ef47cc9455baef4c15c7e9/PLATFORM?origin=template

## 安装方式
```bash
ohpm install @easy_refresh/easy_refresh_scroll