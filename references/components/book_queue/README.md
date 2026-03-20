# 订座排号组件

## 简介

本模块提供了浏览门店、立即订座、取消订座、立即排号、取消排号、刷新排号、查看订单等相关的能力，可以帮助开发者快速集成订座排号的相关业务。

## 详细介绍

### 简介

本模块提供了浏览门店、立即订座、取消订座、立即排号、取消排号、刷新排号、查看订单等相关的能力，可以帮助开发者快速集成订座排号的相关业务。

### 订座排号订单

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上
- 设备类型：华为手机（直板机）
- HarmonyOS 版本：HarmonyOS 5.0.0 Release 及以上

#### 权限

- 网络权限：ohos.permission.INTERNET
- 读日历权限：ohos.permission.READ_CALENDAR
- 写日历权限：ohos.permission.WRITE_CALENDAR

## 快速入门

### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `book_queue` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 book_queue 路径。其中 XXX 为组件存放的目录名
"modules": [
   {
   "name": "book_queue",
   "srcPath": "./XXX/book_queue"
   }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
"dependencies": {
   "book_queue": "file:./XXX/book_queue"
}
```

### 引入组件句柄

```typescript
import { BookQueue, BookQueueRouterMap } from 'book_queue';
```

### 模块初始化

详细入参配置说明参见 API 参考。

```typescript
BookQueue.init(this.stack, this.getUIContext(), true);
```

### 页面跳转

详细页面配置说明参见 API 参考。

```typescript
this.stack.pushPathByName(BookQueueRouterMap.BOOK_PAGE, null)
```

## API 参考

### 子组件

无

### init

`BookQueue.init(stack: NavPathStack, ctx: UIContext, fullScreen: boolean)`

订座排号初始化。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| stack | NavPathStack | 是 | 模块内页面跳转所需的路由栈对象 |
| ctx | UIContext | 是 | 相关弹窗构建所需的上下文 |
| fullScreen | boolean | 是 | 模块内页面是否开启沉浸式，与项目保持一致。 |

### BookQueueRouterMap

订座排号页面名。

| 枚举名 | 对应页面 |
| :--- | :--- |
| BOOK_PAGE | 订座开始页面 |
| BOOK_ORDER_PAGE | 订座订单页面 |
| BOOK_RES_PAGE | 订座结果页面 |
| QUEUE_PAGE | 排号开始页面 |
| QUEUE_ORDER_PAGE | 排号订单页面 |
| QUEUE_RES_PAGE | 排号结果页面 |
| ORDER_LIST_PAGE | 订单管理页面 |

### RouterModule

路由管理工具。

| 方法名 | 功能 |
| :--- | :--- |
| push | 页面跳转 (指定页面) |
| replace | 页面替换 (指定页面) |
| pop | 页面回退 (上个页面) |
| popWithRes | 页面回退 (携带参数) |
| popToName | 页面回退 (至对应页面名) |
| clear | 页面栈清空 (回 Navigation) |
| size | 获取页面栈大小 |
| getNavParam | 获取参数 (指定页面) |
| getPrePage | 获取页面名 (前页面) |
| getNowPage | 获取页面名 (当前页面) |

### WidgetUtil

卡片管理工具。

| 方法名 | 功能 |
| :--- | :--- |
| getFormIds | 获取卡片 ID |
| addFormId | 添加卡片 ID |
| delFormId | 删除卡片 ID |
| publishFormId | 发送卡片 ID |
| subscribeFormId | 接收卡片 ID |
| getQueueOrder | 获取最近排号订单 |
| publishQueueId | 发送排号订单 ID |
| subscribeQueueId | 接收排号订单 ID |
| updateWidgets | 更新卡片 |
| resetWidgets | 重置卡片 |

### QueueOrder

卡片排号订单对象。

| 字段名 | 类型 | 说明 |
| :--- | :--- | :--- |
| orderId | number | 订单 ID |
| count | number | 桌数人数 |
| mine | number | 我的排号 |
| now | number | 当前排号 |
| wait | number | 等待桌数 |

### cancelQueueOrderApi

`cancelQueueOrderApi(orderId: number)`

取消排号订单。

| 参数名 | 类型 | 说明 |
| :--- | :--- | :--- |
| orderId | number | 取消排号订单 ID |

## 示例代码

本示例通过 `pushPathByName` 选择 `BookQueueRouterMap` 实现不同业务页面的跳转。

```typescript
import { BookQueue, BookQueueRouterMap } from 'book_queue';

@Entry
@ComponentV2
struct Index {
 stack: NavPathStack = new NavPathStack();
 
 aboutToAppear(): void {
   BookQueue.init(this.stack, this.getUIContext(), false);
 }

 build() {
   Navigation(this.stack) {
     Column({ space: 20 }) {
       Button('Book').onClick(() => {
         this.stack.pushPathByName(BookQueueRouterMap.BOOK_PAGE, null);
       })

       Button('Queue').onClick(() => {
         this.stack.pushPathByName(BookQueueRouterMap.QUEUE_PAGE, null);
       })

       Button('Order').onClick(() => {
         this.stack.pushPathByName(BookQueueRouterMap.ORDER_LIST_PAGE, null);
       })
     }
     .justifyContent(FlexAlign.Center)
     .height('100%')
   }
   .hideToolBar(true)
   .hideTitleBar(true)
   .hideBackButton(true)
   .mode(NavigationMode.Stack)
 }
}
```

## 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.0 | 2025-10-31 | Created with Pixso. |

## 下载该版本

本模块为订座排号组件，提供了浏览门店、立即订座、取消订座、立即排号、取消排号、刷新排号、查看订单等相关的能力。

### 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |
| ohos.permission.READ_CALENDAR | 允许应用读取日历信息 | 允许应用读取日历信息 |
| ohos.permission.WRITE_CALENDAR | 允许应用添加、移除或更改日历活动 | 允许应用添加、移除或更改日历活动 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| 应用类型 | 应用，元服务 |
| 设备类型 | 手机，平板，PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/a438caa22da44186bc7d1dbcae1d2346/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%AE%A2%E5%BA%A7%E6%8E%92%E5%8F%B7%E7%BB%84%E4%BB%B6/book_queue1.0.0.zip