# wtr 加载刷新组件

## 简介

下拉刷新、上拉加载，可自定义刷新加载风格 (refresh)；加载弹框、消息提示；JSON 转对应模型；

## 详细介绍

### 简介
基本快捷方法、下拉刷新、上拉加载，可自定义刷新加载风格 (refresh)；加载弹框、消息弹框、成功提示、失败提示；JSON 转对应模型；

*   **WTRRefresh**: 下拉刷新、上拉加载，支持自定义
*   **WTRHUD**: 加载弹框、消息弹框
*   **wtrhttp**: 系统 http 简单封装

### 安装
深色代码主题复制
```bash
ohpm install wtr
```

### 引用方式
深色代码主题复制
```typescript
import { WTRHUD } from 'wtr'
import { WTRRefresh, WTRRefreshController } from 'wtr'
```

### HUD 使用方法
深色代码主题复制
```typescript
WTRHUD.showInfo("信息提示")
WTRHUD.showLoading()
WTRHUD.showSuccess("操作成功")
WTRHUD.showError("网络错误")

WTRHUD.hide()

//另一种方式：
WTRHUD.showInfo({
    msg: "信息提示",
    alignment: DialogAlignment.Bottom
})
```

### 下拉刷新，上拉加载使用方法
深色代码主题复制
```typescript
import {
  WTRRefresh,
  WTRRefreshController,
  WTRRefreshControllerOptions,
  WTRRefreshState,
  WTRRefreshBuilderParam,
  WTR
} from 'wtr'

@Entry
@Component
struct RefreshPage {
  @State arr: Array<number> = []

  aboutToAppear() {
    for (let i = 0; i < 20; i++) {
      this.arr.push(i)
    }
  }

  onPageShow() {
    setTimeout(() => {
      this.refreshController.beginRefresh()
    }, 500)
  }

  refreshController: WTRRefreshController = new WTRRefreshController({

    contentEndOffset: WTR.safeBottom(), //需要和 List 的 contentEndOffset 一样

    onRefresh: () => {
      console.log("开始刷新")
      setTimeout(() => {
        this.arr.reverse()
        this.refreshController.endRefresh()
      }, 1000)
    },
    onLoad: () => {
      console.log("开始加载")
      setTimeout(() => {
        for (let i = 0; i < 5; i++) {
          this.arr.push(Math.round((Math.random() * 100) % 100))
        }
        //noMoreData 是否显示已加载全部  dataAdded 数据是否已加载更多，如果没有数据增加，内容高度不变，dataAdded 需要设置成 false
        this.refreshController.endLoad(false, true)
      }, 1000)
    }
  })

  //内容
  @Builder
  contentBuilder(scroller: Scroller) {
    List({ scroller: scroller }) {
      ForEach(this.arr, (item: number) => {
        ListItem() {
          Text("哈哈哈哈:" + item)
            .height(50)
        }
        .width("100%")
        .backgroundColor(item % 2 == 0 ? Color.Orange : WTR.randomColor())
        .onClick(() => {
          console.log("点击 cell:", item)
        })
      })
    }
    .width("100%")
    .height("100%")
    .contentEndOffset(WTR.safeBottom()) //需要和 WTRRefreshController 内的一样
  }

  build() {
    Column() {
      Row() {
        Text("标题")
          .height(60)
      }
      .padding({ top: WTR.safeTop() })

      WTRRefresh({
        controller: this.refreshController,
        contentBuilder: (scroller: Scroller) => {
          this.contentBuilder(scroller)
        },

        // 自定义刷新加载显示
        // customHeaderBuilder:($$:WTRRefreshBuilderParam)=>{
        //
        // },
        // customFooterBuilder:($$:WTRRefreshBuilderParam)=>{
        //
        // }
      })
      .layoutWeight(1)
       //.margin({ bottom: 60 + WTR.safeTop() }) //顶部标题高度多少这里就设置多少或者用 layoutWeight(1)
    }
    .width("100%")
    .height("100%")
  }
}
```

### wtrhttp 使用方法
深色代码主题复制
```typescript
import { wtrhttp } from 'wtr'

wtrhttp.GET("https://example.com", (err: Error, result: string) => {
  console.log("result:",result)
});
```

### WTR.JSONParse 使用方法
深色代码主题复制
```typescript
import { WTR, JSONType } from 'wtr'

class B {
  p?: number
  test() {
    console.log("test()")
  }
}
class A {
  @JSONType(B)
  b?: B
  @JSONType(B)
  list?: B[]
}

let jsonStr =
`{
  "b" : {
    "p" : 1
  },
  "list" : [
    {
      "p" : 2
    },
    {
      "p" : 3
    }
  ]
}`
    let a: A = WTR.JSONParse(jsonStr, A);
    console.log("a:", JSON.stringify(a))
    a.b?.test()
```

## 更新记录

**1.4.2**
WTR 新增快捷方法

**1.4.1**
WTRRefresh 修复加载结束后可能会跳一段的问题

**1.4.0**
WTR.emit 优化数据传递，可传递任意类型

**1.3.9**
WTRHUD 短时间同类型提示直接修改文字显示

**1.3.8**
WTRHUD 新增判断是否在显示方法

**1.3.7**
WTRRefresh 修复 Scroller 未绑定到 UI 控件时滑动崩溃问题。

**1.3.6**
修改说明文字

**1.3.5**
WTRHTTP PUT、DELETE 方法可以不用写 req 方式

**1.3.4**
WTRRefresh 修复使用 WaterFlow 时的 bug。

**1.3.3**
WTRHUD 修复间隔时间短时，后一个会闪现消失的 bug。

**1.3.2**
WTRHUD 调用方式优化，例如：WTRHUD.showLoading(); 不用写 new

**1.3.1**
WTR.safeBottom() 调整距离

**1.3.0**
WTRHTTP 增加 try catch 防止数据读取时崩溃

**1.2.10**
新增一个生成唯一 ID 的方法

**1.2.9**
UUID 新增删除功能

**1.2.8**
WTRHTTP 新增流式下载功能

**1.2.7**
刷新功能新增可在 UI 加载之前设置 NoMoreData 状态

**1.2.6**
解决非上拉加载时，设置无数据还会上拉加载的 bug

**1.2.5**
更新说明

**1.2.4**
适配新版 API

**1.2.3**
新增一个拷贝实例的方法

**1.2.2**
新增可设置 context
新增“获取第一次安装随机生成的 UUID”功能

**1.2.1**
JSON 解析支持 @Trace 修饰

**1.2.0**
最低版本修改为 API12
新增 HMAC 签名、MD 签名，支持 MD5 SHA1 SHA224 SHA256 SHA384 SHA512 SM3

**1.1.3**
JSON 解析新增支持数组类型设置

**1.1.2**
WTRRefresh 新增 endLoadDelay 属性，加载动画结束前要保证内部 List 加载完毕 (内容高度修改结束)，可以在存在加载结束后瞬间归位的地方加上延迟时间

**1.1.1**
WTRRefresh 增加数据少的情况下不滑动功能设置 lessDataNoLoadShow

**1.1.0**
更新到 API12
WTRRefresh 适配多层滑动时数据少的情况下的 nestedScroll 功能

**1.0.24**
WTRHUD 可配置大小

**1.0.23**
修复 WTRRefresh 在部分线程环境 (非 UI 操作环境，例如网络回来或者被 emit 调用) 加载后结束会跳一下的问题

**1.0.22**
新增快捷方法

**1.0.21**
修复 bug

**1.0.20**
修复 bug

**1.0.19**
新增给图片染色方法 colorFilterWithTintColor

**1.0.18**
优化 HUD

**1.0.17**
支持深色模式

**1.0.16**
优化 JSONParse，支持任意情况

**1.0.15**
新增 JSONParse 功能

**1.0.14**
修复 WTRHUD 部分情况下不显示问题

**1.0.13**
safeBottom 改为系统距离的一半

**1.0.12**
HUD mainWindow() 改为 mainWindow 属性，windowWidth() 改为返回逻辑宽度

**1.0.11**
HUD 方法调用简化

**1.0.10**
WTR 应用内通信增加单个取消功能

**1.0.9**
wtrhttp 改变打印位置

**1.0.8**
WTRHTTP 改为大写，有方法提示

**1.0.7**
wtrhttp 改为 ts 文件

**1.0.6**
新增 wtrhttp

**1.0.5**
WTR 新增一些快捷方法

**1.0.4**
WTRRefresh 支持 contentStartOffset 和 contentEndOffset

**1.0.3**
HUD 新增 showInSubWindow 参数

**1.0.2**
新增下拉刷新、上拉加载功能

**1.0.1**
新增消息弹框功能

## 权限与隐私及兼容性

| 项目 | 内容 |
| :--- | :--- |
| **权限名称** | 暂无 |
| **权限说明** | 暂无 |
| **使用目的** | 暂无 |
| **隐私政策** | 不涉及 SDK 合规使用指南 不涉及 |
| **兼容性 HarmonyOS 版本** | 5.0.0 |
| **应用类型** | 应用 |
| **元服务** | - |
| **设备类型** | 手机、平板、PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.0 |

Created with Pixso.

## 安装方式

```bash
ohpm install wtr
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c41a42313c2842ee9424a15d2bdadeb7/PLATFORM?origin=template