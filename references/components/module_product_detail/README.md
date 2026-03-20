# 商品详情组件

## 简介

本模板提供商品详情组件，支持商品详情的展示和商品规格选择。

## 详细介绍

### 简介

本模板提供商品详情组件，支持商品详情的展示和商品规格选择。

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.1 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.1 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 5.0.1(13) 及以上

#### 权限

- 网络权限：ohos.permission.INTERNET

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
b. 在项目根目录 build-profile.json5 添加 module_ui_base 和 module_product_detail 模块。

深色代码主题复制
```json5
// 项目根目录下 build-profile.json5 填写 module_ui_base 和 module_product_detail 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_ui_base",
    "srcPath": "./XXX/module_ui_base"
  },
  {
    "name": "module_product_detail",
    "srcPath": "./XXX/module_product_detail"
  }
]
```

深色代码主题复制
```json5
// 在项目根目录 oh-package.json5 中添加依赖
"dependencies": {
  "module_product_detail": "file:./XXX/module_product_detail"
}
```

#### 引入组件

深色代码主题复制
```typescript
import { ProductDetail } from 'module_product_detail';
```

### API 参考

#### ProductDetail(options: ProductDetailOptions)

##### ProductDetailOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| productId | string | 是 | 商品的唯一标识符，用于标识当前展示的商品。该 id 用于访问网络接口获取商品详情信息。mock 状态下支持商品展示的 productId 为 product_10001 ~ product_10008 |
| isLogin | boolean | 是 | 表示用户是否已登录，默认值为 false。 |
| cartProdNum | number | 是 | 购物车中商品的数量，默认值为 0。 |
| clickCart() => void | function | 是 | 点击购物车图标时触发的事件回调函数，不接受参数，无返回值。 |
| handleAddCart(skuCode: string, count: number) => void | function | 是 | 添加商品到购物车时触发的事件回调函数，接收商品的 SKU 码和数量。 |
| handlePayNow(skuCode: string, count: number) => void | function | 是 | 点击立即购买时触发的事件回调函数，接收商品的 SKU 码和数量。 |
| handleNotLogin() => void | function | 是 | 用户未登录时触发的事件回调函数，用于处理未登录状态。 |

### 示例代码

深色代码主题复制
```typescript
import { promptAction } from '@kit.ArkUI';
import { ProductDetail } from 'module_product_detail';

@Entry
@ComponentV2
struct PreviewPage {
  @Local
  cartProdNum: number = 0;
  @Local
  skuList: string[] = []
  @Local
  stack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.stack) {
      ProductDetail({
        stack: this.stack,
        productId: 'product_10001',
        isLogin: true,
        cartProdNum: this.cartProdNum,
        clickCart: () => {
          promptAction.showToast({ message: `点击了购物车按钮，当前商品数量为${this.cartProdNum}` });
        },
        handleAddCart: (skuCode, count) => {
          promptAction.showToast({ message: `新添加了 code 为${skuCode}的商品，数量为${count}` });
          if (!this.skuList.includes(skuCode)) {
            this.skuList.push(skuCode)
          }
          this.cartProdNum = this.skuList.length;
        },
        handlePayNow: (skuCode, count) => {
          promptAction.showToast({ message: `立即支付为${skuCode}的商品，数量为${count}` });
        },
      })
    }
      .mode(NavigationMode.Stack)
  }
}
```

## 更新记录

### 1.0.4 (2026-01-13)

下载该版本
Created with Pixso.

### 1.0.3 (2025-11-24)

废弃 API 整改
下载该版本
Created with Pixso.

### 1.0.2 (2025-10-31)

新增折叠屏、平板 UX 适配
下载该版本
Created with Pixso.

### 1.0.1 (2025-08-30)

新增查看用户评价
下载该版本
Created with Pixso.

### 1.0.0 (2025-07-01)

README 优化
下载该版本
Created with Pixso.

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

### HarmonyOS 版本

- 5.0.1
  Created with Pixso.
- 5.0.2
  Created with Pixso.
- 5.0.3
  Created with Pixso.
- 5.0.4
  Created with Pixso.
- 5.0.5
  Created with Pixso.
- 5.1.0
  Created with Pixso.
- 5.1.1
  Created with Pixso.
- 6.0.0
  Created with Pixso.
- 6.0.1
  Created with Pixso.

### 应用类型

- 应用
  Created with Pixso.
- 元服务
  Created with Pixso.

### 设备类型

- 手机
  Created with Pixso.
- 平板
  Created with Pixso.
- PC
  Created with Pixso.

### DevEcoStudio 版本

- DevEco Studio 5.0.1
  Created with Pixso.
- DevEco Studio 5.0.2
  Created with Pixso.
- DevEco Studio 5.0.3
  Created with Pixso.
- DevEco Studio 5.0.4
  Created with Pixso.
- DevEco Studio 5.0.5
  Created with Pixso.
- DevEco Studio 5.1.0
  Created with Pixso.
- DevEco Studio 5.1.1
  Created with Pixso.
- DevEco Studio 6.0.0
  Created with Pixso.
- DevEco Studio 6.0.1
  Created with Pixso.

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/6dc36ea769e0406db1df6d545d7339f6/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%95%86%E5%93%81%E8%AF%A6%E6%83%85%E7%BB%84%E4%BB%B6/module_product_detail1.0.4.zip