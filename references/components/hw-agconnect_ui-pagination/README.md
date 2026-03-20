# 分页器 UIPagination

## 简介

UIPagination，是一个基于 open harmony 基础组件开发的分页器按钮，包含图标按钮版本、文字按钮版本、支持输入当前页码以及支持设置主题色等。

## 详细介绍

### 简介

UIPagination，是一个基于 open harmony 基础组件开发的分页器按钮，包含图标按钮版本、文字按钮版本、支持输入当前页码以及支持设置主题色等。
我们提供两种方式：ohpm 快速集成和下载源码包手工集成，您可以根据需要选择合适的方式，下面以 ohpm 快速集成为例，描述完整集成方法。

### 快速开始

#### 安装

深色代码主题复制
```bash
ohpm install @hw-agconnect/ui-pagination
```

#### 使用

深色代码主题复制
```typescript
// 在业务页面使用组件，比如 xxx.ets
import { UIPagination } from '@hw-agconnect/ui-pagination';

UIPagination({
   currentPage: this.currentPage,
   total: this.totalNum,
   change: (currentV: number) => {
     this.onPageChange(currentV);
   }
})
```

### 相关权限

无

### 约束与限制

1. 本示例仅支持标准系统上运行，支持设备：华为手机。
2. HarmonyOS 系统：HarmonyOS 5.0.0 Release 及以上。
3. DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上。
4. HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上。

### 子组件

无

### 接口

`UIPagination(option: UIPaginationOptions)`

**UIPaginationOptions 对象说明**

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| currentPagenumber | number | 否 | 当前页 |
| totalnumber | number | 否 | 数据总量 |
| pageSizenumber | number | 否 | 每页数据量 |
| enableInput | boolean | 否 | 是否支持输入当前页码，默认值：true |
| pageFgSize | Length | 否 | 页码字体大小 |
| themeColor | ResourceColor | 否 | 主题色，可以控制当前页码的颜色和输入框颜色 |
| btnOption | IBtnOption | 否 | 按钮选项 |

**IBtnOption 对象说明**

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| prevText | ResourceStr | 否 | 左侧按钮文字 |
| nextText | ResourceStr | 否 | 右侧按钮文字 |
| showIcon | boolean | 否 | 是否图标版本按钮，默认值：true |
| btnFgSize | Length | 否 | 按钮文字大小 |
| btnFgColor | ResourceColor | 否 | 按钮文字颜色 |
| btnIconColor | ResourceColor | 否 | 按钮图标颜色 |
| btnBgColor | ResourceColor | 否 | 按钮背景颜色 |
| iconH | number | 否 | 设置图标按钮中图标高度，默认值：16。 |

### 事件

| 名称 | 功能描述 |
| :--- | :--- |
| change(callback: (currentV: number) => void) | 当前页码改变时触发事件 |

### 示例

#### 示例 1

深色代码主题复制
```typescript
import { UIPagination } from '@hw-agconnect/ui-pagination';

@ComponentV2
struct Card {
 @Param title: string = '';
 @BuilderParam content: () => void;

 build() {
   Column({ space: 10 }) {
     Text(this.title).fontSize(16).fontWeight(500)
     Column() {
       if (this.content) {
         this.content();
       }
     }
     .width('100%')
     .padding(16)
     .borderRadius(12)
     .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
   }
   .alignItems(HorizontalAlign.Start)
 }
}

@Entry
@ComponentV2
struct PaginationSample1 {
 @Local currentPage: number = 1;
 @Local totalNum: number = 50;
 @Local pageSize: number = 10;
 onPageChange: (currentV: number) => void = (currentV: number) => {
   this.currentPage = currentV;
 };

 build() {
   NavDestination() {
     Scroll() {
       Column({ space: 16 }) {
         Card({ title: '默认样式（图标版）' }) {
           UIPagination({
             currentPage: this.currentPage,
             total: this.totalNum,
             change: (currentV: number) => {
               this.onPageChange(currentV);
             }
           })
         }

         Card({ title: '文字样式' }) {
           UIPagination({
             btnOption: {
               showIcon: false,
             },
             currentPage: this.currentPage,
             total: this.totalNum,
             change: (currentV: number) => {
               this.onPageChange(currentV);
             }
           })
         }

         Card({ title: '精简版' }) {
           UIPagination({
             btnOption: {
               btnBgColor: Color.Transparent,
             },
             currentPage: this.currentPage,
             total: this.totalNum,
             change: (currentV: number) => {
               this.onPageChange(currentV);
             }
           })
         }

         Card({ title: '页码只读' }) {
           UIPagination({
             enableInput: false,
             currentPage: this.currentPage,
             total: this.totalNum,
             change: (currentV: number) => {
               this.onPageChange(currentV);
             }
           })
         }
       }
       .width('100%')
     }
     .padding(16)
     .height('100%')
     .edgeEffect(EdgeEffect.Spring)
     .align(Alignment.TopStart)
   }
   .title('基础用法')
   .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
 }
}
```

#### 示例 2

深色代码主题复制
```typescript
import { UIPagination } from '@hw-agconnect/ui-pagination';

@ComponentV2
struct Card {
 @Param title: string = '';
 @BuilderParam content: () => void;

 build() {
   Column({ space: 10 }) {
     Text(this.title).fontSize(16).fontWeight(500)
     Column() {
       if (this.content) {
         this.content();
       }
     }
     .width('100%')
     .padding(16)
     .borderRadius(12)
     .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
   }
   .alignItems(HorizontalAlign.Start)
 }
}

@Entry
@ComponentV2
struct PaginationSample1 {
 @Local currentPage: number = 1;
 @Local totalNum: number = 50;
 @Local pageSize: number = 10;
 onPageChange: (currentV: number) => void = (currentV: number) => {
   this.currentPage = currentV;
 };

 build() {
   NavDestination() {
     Scroll() {
       Column({ space: 16 }) {
         Card({ title: '文字样式 (自定义)' }) {
           UIPagination({
             btnOption: {
               showIcon: false,
               prevText: '前一页',
               nextText: '后一页',
             },
             currentPage: this.currentPage,
             total: this.totalNum,
             change: (currentV: number) => {
               this.onPageChange(currentV);
             },
           })
         }

         Card({ title: '设置字号和图标大小' }) {
           UIPagination({
             btnOption: {
               iconH: 20,
             },
             pageFgSize: 20,
             currentPage: this.currentPage,
             total: this.totalNum,
             change: (currentV: number) => {
               this.onPageChange(currentV);
             },
           })
         }

         Card({ title: '自定义主题色' }) {
           UIPagination({
             themeColor: Color.Pink,
             currentPage: this.currentPage,
             total: this.totalNum,
             change: (currentV: number) => {
               this.onPageChange(currentV);
             },
           })
         }

         Card({ title: '超长数据' }) {
           UIPagination({
             currentPage: this.currentPage,
             total: 99999999999991 * this.pageSize,
             change: (currentV: number) => {
               this.onPageChange(currentV);
             },
           })
         }

         Card({ title: '只读超长数据' }) {
           UIPagination({
             enableInput: false,
             currentPage: 1666666666667,
             total: 99999999999991 * this.pageSize,
             change: (currentV: number) => {
               this.onPageChange(currentV);
             },
           })
         }
       }
       .width('100%')
     }
     .padding(16)
     .height('100%')
     .edgeEffect(EdgeEffect.Spring)
     .align(Alignment.TopStart)
   }
   .title('自定义参数')
   .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
 }
}
```

### 更新记录

- **1.0.1** (2025-12-12)
  Created with Pixso.
  下载该版本内部资源
- **1.0.0** (2025-09-29)
  Created with Pixso.
  下载该版本初始版本

### 权限与隐私

| 项目 | 详情 |
| :--- | :--- |
| 基本信息 | 权限名称：无<br>权限说明：无<br>使用目的：无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| 项目 | 详情 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 <br> Created with Pixso. <br><br> 5.0.1 <br> Created with Pixso. <br><br> 5.0.2 <br> Created with Pixso. <br><br> 5.0.3 <br> Created with Pixso. <br><br> 5.0.4 <br> Created with Pixso. <br><br> 5.0.5 <br> Created with Pixso. <br><br> 5.1.0 <br> Created with Pixso. <br><br> 5.1.1 <br> Created with Pixso. <br><br> 6.0.0 <br> Created with Pixso. <br><br> 6.0.1 <br> Created with Pixso. |
| 应用类型 | 应用 <br> Created with Pixso. <br><br> 元服务 <br> Created with Pixso. |
| 设备类型 | 手机 <br> Created with Pixso. <br><br> 平板 <br> Created with Pixso. <br><br> PC <br> Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 <br> Created with Pixso. <br><br> DevEco Studio 5.0.1 <br> Created with Pixso. <br><br> DevEco Studio 5.0.2 <br> Created with Pixso. <br><br> DevEco Studio 5.0.3 <br> Created with Pixso. <br><br> DevEco Studio 5.0.4 <br> Created with Pixso. <br><br> DevEco Studio 5.0.5 <br> Created with Pixso. <br><br> DevEco Studio 5.1.0 <br> Created with Pixso. <br><br> DevEco Studio 5.1.1 <br> Created with Pixso. <br><br> DevEco Studio 6.0.0 <br> Created with Pixso. <br><br> DevEco Studio 6.0.1 <br> Created with Pixso. |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-pagination
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/1e7ffb4bfbdf4af4abb44c36899b2722/2adce9bbd4cb42d58a87e6add45594b3?origin=template