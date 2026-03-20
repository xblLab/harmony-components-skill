# 滑动卡片组件

## 简介

本组件提供了展示滑动卡片的相关功能。

## 详细介绍

### 简介

本组件提供了展示滑动卡片的相关功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、平板
- **HarmonyOS 版本**：HarmonyOS 5.0.4(16) 及以上

#### 权限

无

### 使用

安装组件。
如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。

b. 在项目根目录 `build-profile.json5` 中添加 `swiper_card`。

```json5
// 在项目根目录的 build-profile.json5 填写 swiper_card 路径。其中 xxx 为组件存在的目录名
"modules": [
  {
    "name": "swiper_card",
    "srcPath": "./xxx/swiper_card"
  }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// xxx 为组件存放的目录名称
"dependencies": {
  "swiper_card": "file:./xxx/swiper_card"
}
```

引入组件。

```typescript
import { swiper_card } from 'swiper_card';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
TUISwiper({
  imgWidth: , // 中心图片宽度
  imgHeight: , // 中心图片高度
  interval: , // 间隔时间
  isLoop: , // 是否循环
  builderList: , // 图书卡片布局
  bookList: , // 图书数据
  onImageClick: (index: number) => {
    // 图片被点击时执行的操作
  }
})
```

### API 参考

#### 接口

```typescript
TUISwiper({
   imgWidth: number,
   imgHeight: number,
   interval: number,
   builderList: LazyDataVM,
   bookList: WrappedBuilder,
   isLoop: boolean,
   onImageClick: (index: number) => {
   }
})
```

展示滑动卡片页面组件。

#### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| imgWidth | number | 否 | 中心图片宽度 |
| imgHeight | number | 否 | 中心图片高度 |
| interval | number | 否 | 间隔时间 |
| isLoop | boolean | 否 | 是否循环 |
| builderList | WrappedBuilder\<BookInfo\> | 是 | 封装全局的图书数据 |
| bookList | LazyDataVM\<BookInfo\> | 是 | 图书数据 |

#### LazyDataVM 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| dataArray | BookInfo[] | 是 | 图书列表 |

#### BookInfo 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 图书 id |
| name | string | 是 | 图书名称 |
| coverUrl | PixelMap\ResourceStr\DrawableDescriptor | 否 | 封面 |
| rankUrl | PixelMap\ResourceStr\DrawableDescriptor | 否 | 等级图标 |
| rate | string | 是 | 等级数 |
| description | string | 是 | 描述 |
| author | string | 是 | 作者 |
| localPath | string | 否 | 图书本地路径 |
| epubUrl | string | 是 | 图书的 epub |
| category | string | 是 | 类别 |
| isFree | string | 是 | 付费类型 |
| count | string | 否 | 字数 |
| popular | string | 否 | 热度 |
| gender | string | 否 | 性别 |

#### 事件

支持以下事件：

- **onImageClick**
  ```typescript
  onImageClick(callback: (id: number) => void)
  ```
  图片被点击时执行的操作

### 示例代码

```typescript
import { BookInfo, LazyDataVM, TUISwiper, bookSingleSwiper } from 'swiper_card';

const bookSingleSwiperBuilder: WrappedBuilder<[BookInfo]> = wrapBuilder(bookSingleSwiper);

@Entry
@ComponentV2
struct Index {
   @Local books: LazyDataVM<BookInfo> = new LazyDataVM();
   @Local imgHeight: number = 250;
   @Local imgWidth: number = 150;
   @Local builderList: WrappedBuilder<[BookInfo]>[] = []

   aboutToAppear(): void {
      this.books.pushArrayData([{
         "id": "1",
         "author": "作者",
         "name": "设计理论实践应用",
         "coverUrl": "app.media.book_image_1",
         "category": "艺术",
         "rate": "8",
         "count": "102 万字",
         "popular": "10.5",
         "isFree": "0",
         "gender": "2"
      } as BookInfo, {
         "id": "2",
         "author": "作者",
         "name": "小羊肖恩",
         "coverUrl": "app.media.book_image_2",
         "category": "文学",
         "rate": "7",
         "count": "102 万字",
         "popular": "10.5",
         "isFree": "1",
         "gender": "2"
      } as BookInfo, {
         "id": "2",
         "author": "作者",
         "name": "小羊肖恩",
         "coverUrl": "app.media.book_image_2",
         "category": "文学",
         "rate": "7", 
         "count": "102 万字",
         "popular": "10.5",
         "isFree": "1",
         "gender": "2"
      } as BookInfo])
      this.builderList.push(bookSingleSwiperBuilder);
      this.builderList.push(bookSingleSwiperBuilder);
      this.builderList.push(bookSingleSwiperBuilder);
   }

   build() {
      Column() {
         TUISwiper({
            imgWidth: this.imgWidth,
            imgHeight: this.imgHeight,
            builderList: this.builderList,
            bookList: this.books,
            isLoop: true,
            onImageClick: (index: number) => {
            }
         })
      }
   }
}
```

### 更新记录

- **1.0.3** (2026-01-13) - 下载该版本
- **1.0.2** (2025-10-31) - 下载该版本
- **1.0.1** (2025-07-30) - 下载该版本
- **1.0.0** (2025-07-02) - 下载该版本

### 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| 应用类型 | 应用，元服务 |
| 设备类型 | 手机，平板，PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.4, DevEco Studio 5.0.5, DevEco Studio 5.1.0, DevEco Studio 5.1.1, DevEco Studio 6.0.0, DevEco Studio 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/d89fb3c3ffb84fc38f72c6d443abefc3/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%BB%91%E5%8A%A8%E5%8D%A1%E7%89%87%E7%BB%84%E4%BB%B6/swiper_card1.0.3.zip