# 消息管理组件

## 简介

本组件提供了消息展示，已读、未读、删除查看等功能。

## 详细介绍

### 简介

本组件提供了消息展示，已读、未读、删除查看等功能。

### 消息列表标记已读\删除卡片列表

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.1 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.1(13) Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.1 及以上

## 快速入门

### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `message_manager` 模块。
   ```json5
   // 在项目根目录 build-profile.json5 填写 message_manager 路径。其中 XXX 为组件存放的目录名
   "modules": [
     {
       "name": "message_manager",
       "srcPath": "./XXX/message_manager",
     }
   ]
   ```
3. 在项目根目录 `oh-package.json5` 中添加依赖。
   ```json5
   // XXX 为组件存放的目录名称
   "dependencies": {
     "message_manager": "file:./XXX/message_manager"
   }
   ```

### 引入组件句柄

```typescript
import { MessageList, TabButton, TabController, MessageManagerService, MessageItem, CardData, ArticleCard, TopicCard } from 'message_manager';
```

### 调用组件

详细参数配置说明参见 API 参考。

```typescript
import { MessageList, TabButton, TabController, MessageManagerService, MessageItem,
 CardData,
 ArticleCard,
 TopicCard} from 'message_manager'

@Entry
@ComponentV2
export struct MyMessage {
 @Local currentIndex: number = 0;
 messageManagerService:MessageManagerService = MessageManagerService.instance;
 tabList: TabController[] = [
   new TabController('新职位发布'),
   new TabController('推送消息', true),
   new TabController('消息样式')
 ]
 swiperController: SwiperController = new SwiperController();
 messageList: MessageItem[] = this.messageManagerService.getMessageList();
 newJobList: CardData[] = this.messageManagerService.getJobDataList();
 cardList: CardData[] = this.messageManagerService.getCardDataList()

 aboutToAppear(): void {
   this.swiperController.changeIndex(this.currentIndex)
 }

 build() {
   Column({space:24}) {
     Row({space:16}) {
       ForEach(this.tabList, (item: TabController, index: number) => {
         TabButton({
           isActive: index === this.currentIndex,
           tabController:item,
           statusChange:() => {
             this.currentIndex = index;
             this.swiperController.changeIndex(index)
           }
         })
       }, (item:TabController) => JSON.stringify(item))
     }
     .width('100%')

     Swiper(this.swiperController) {
       List({space:12}) {
         ForEach(this.newJobList, (item: CardData) => {
           ArticleCard({
             cardStyle: {
               timeColor:'#376BFC',
               timeFontSize: 16,
               maxLines: 6
             },
             cardData:item,
             itemClick:() => {
               console.log('跳转事件')
             }
           })
         }, (item: CardData) => JSON.stringify(item))
       }
       .scrollBar(BarState.Off)

       MessageList({
         list:this.messageList,
         itemClick:(item:MessageItem) => {
           console.log('跳转事件')
         }
       })

       List({space:12}) {
         ForEach(this.cardList, (item:CardData) => {
           ArticleCard({
             cardStyle: {
               maxLines: 2
             },
             cardData:item,
             itemClick:() => {
               console.log('跳转事件')
             }
           })
         }, (item:CardData) => JSON.stringify(item))
         TopicCard({
           cardData:this.cardList[0],
           itemClick:() => {
             console.log('跳转事件')
           }
         })
       }
       .scrollBar(BarState.Off)
     }
     .width('100%')
     .loop(false)
     .indicator(false)
     .layoutWeight(1)
     .onChange((index:number) => {
       this.currentIndex = index;
     })
   }
   .backgroundColor('#F1F3F5')
   .width('100%')
   .height('100%')
   .padding(16)
 }
}
```

## API 参考

### 子组件

#### ArticleCard

**接口**

`ArticleCard(options: ArticleCardOptions)`

文件管理组件。

**参数**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | ArticleCardOptions | 否 | 卡片组件的参数。 |

**ArticleCardOptions 对象说明**

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| cardData | CardData | 是 | 卡片数据 |
| cardStyle | CardStyle | 否 | 卡片样式 |
| itemClick | Function | 是 | 点击事件 |

**CardData 对象说明**

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| title | string | 是 | 标题 |
| time | string | 是 | 时间 |
| description | string | 否 | 描述 |
| markArray | - | 否 | 标签 |
| content | string | 是 | 内容 |

**CardStyle 对象说明**

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| bgColor | string/Resource | 否 | 卡片背景色 |
| borderRadius | number/Resource | 否 | 卡片圆角 |
| titleFontSize | number/Resource | 否 | 标题字体大小 |
| titleColor | string/Resource | 否 | 标题字体颜色 |
| timeFontSize | number/Resource | 否 | 时间字体大小 |
| timeColor | string/Resource | 否 | 时间字体颜色 |
| descriptionFontSize | number/Resource | 否 | 描述字体大小 |
| descriptionColor | string/Resource | 否 | 描述字体颜色 |
| contentFontSize | number/Resource | 否 | 内容字体大小 |
| contentColor | string/Resource | 否 | 内容字体颜色 |
| maxLines | number | 否 | 展示行数 |

**示例代码**

```typescript
import { MessageList, TabButton, TabController, MessageManagerService, MessageItem,
 CardData,
 ArticleCard,
 TopicCard} from 'message_manager'

@Entry
@ComponentV2
export struct Index {
 @Local currentIndex: number = 0;
 messageManagerService:MessageManagerService = MessageManagerService.instance;
 tabList: TabController[] = [
   new TabController('新职位发布'),
   new TabController('推送消息', true),
   new TabController('消息样式')
 ]
 swiperController: SwiperController = new SwiperController();
 messageList: MessageItem[] = this.messageManagerService.getMessageList();
 newJobList: CardData[] = this.messageManagerService.getJobDataList();
 cardList: CardData[] = this.messageManagerService.getCardDataList()

 aboutToAppear(): void {
   this.swiperController.changeIndex(this.currentIndex)
 }

 build() {
   Column({space:24}) {
     Row({space:16}) {
       ForEach(this.tabList, (item: TabController, index: number) => {
         TabButton({
           isActive: index === this.currentIndex,
           tabController:item,
           statusChange:() => {
             this.currentIndex = index;
             this.swiperController.changeIndex(index)
           }
         })
       }, (item:TabController) => JSON.stringify(item))
     }
     .width('100%')

     Swiper(this.swiperController) {
       List({space:12}) {
         ForEach(this.newJobList, (item: CardData) => {
           ArticleCard({
             cardStyle: {
               timeColor:'#376BFC',
               timeFontSize: 16,
               maxLines: 6
             },
             cardData:item,
             itemClick:() => {
               console.log('跳转事件')
             }
           })
         }, (item: CardData) => JSON.stringify(item))
       }
       .scrollBar(BarState.Off)

       MessageList({
         list:this.messageList,
         itemClick:(item:MessageItem) => {
           console.log('跳转事件')
         }
       })

       List({space:12}) {
         ForEach(this.cardList, (item:CardData) => {
           ArticleCard({
             cardStyle: {
               maxLines: 2
             },
             cardData:item,
             itemClick:() => {
               console.log('跳转事件')
             }
           })
         }, (item:CardData) => JSON.stringify(item))
         TopicCard({
           cardData:this.cardList[0],
           itemClick:() => {
             console.log('跳转事件')
           }
         })
       }
       .scrollBar(BarState.Off)
     }
     .width('100%')
       .loop(false)
       .indicator(false)
       .layoutWeight(1)
       .onChange((index:number) => {
         this.currentIndex = index;
       })
   }
   .backgroundColor('#F1F3F5')
     .width('100%')
     .height('100%')
     .padding(16)
 }
}
```

## 更新记录

### 1.0.1 (2025-11-03)

- 下载该版本修改了 readme
- Created with Pixso.

### 1.0.0 (2025-08-30)

- 下载该版本初始版本
- Created with Pixso.

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

| 版本 | 备注 |
| :--- | :--- |
| 5.0.1 | Created with Pixso. |
| 5.0.2 | Created with Pixso. |
| 5.0.3 | Created with Pixso. |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |

### 应用类型

| 类型 | 备注 |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

### 设备类型

| 类型 | 备注 |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

### DevEcoStudio 版本

| 版本 | 备注 |
| :--- | :--- |
| DevEco Studio 5.0.1 | Created with Pixso. |
| DevEco Studio 5.0.2 | Created with Pixso. |
| DevEco Studio 5.0.3 | Created with Pixso. |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/b111d8b49c56423aa5cfb9e7afb6fb95/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%B6%88%E6%81%AF%E7%AE%A1%E7%90%86%E7%BB%84%E4%BB%B6/message_manager1.0.1.zip