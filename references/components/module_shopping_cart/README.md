# 商城购物车组件

## 简介

本组件展示了购物车商品列表信息和推荐商品信息，提供了商品选择、删除、增减商品数量、查看明细、结算、查看商品详情、查看推荐商品信息等相关功能，帮助开发者快速集成购物车相关的能力。

## 详细介绍

### 简介

本组件展示了购物车商品列表信息和推荐商品信息，提供了商品选择、删除、增减商品数量、查看明细、结算、查看商品详情、查看推荐商品信息等相关功能，帮助开发者快速集成购物车相关的能力。

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

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_ui_base` 和 `module_shopping_cart` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_shopping_cart 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_shopping_cart",
    "srcPath": "./XXX/module_shopping_cart"
  },
  {
    "name": "module_ui_base",
    "srcPath": "./XXX/module_ui_base"
  }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// 在项目根目录 oh-package.json5 中添加依赖
"dependencies": {
  "module_shopping_cart": "file:./XXX/module_shopping_cart"
}
```

#### 引入组件

```typescript
import { ShoppingCart } from 'module_shopping_cart';
```

#### 调用组件

详细参数配置说明参见 API 参考。

```typescript
import { ShoppingCart } from 'module_shopping_cart';
import { Product } from 'module_shopping_cart';

@Entry
@ComponentV2
struct DemoPage {
  @Local isChildRoute: boolean = false
  @Local isLogin: boolean = true

  build() {
    Column(){
      ShoppingCart({
        isChildRoute: this.isChildRoute,
        isLogin: this.isLogin,
        customContentBuilder: () => {
          // TODO 自定义模块，推荐商品
        },
        onLogin: () => {
          // TODO 登录逻辑
        },
        onCardClick: (productId: string) => {
          // TODO 点击购物车卡片
        },
        onBack: () => {
          // TODO 返回事件
        },
        onCheckout: (selectedList: Product[]) => {
          // TODO 结算逻辑
        }
      })
    }
  }
}
```

## API 参考

### 子组件

无

### 接口

**ShoppingCart(options?: ShoppingCartOptions)**

购物车组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | ShoppingCartOptions | 否 | 配置购物车组件的参数 |

**ShoppingCartOptions 对象说明**

#### @Props

| 名称 | 说明 | 类型 | 默认值 |
| :--- | :--- | :--- | :--- |
| isChildRoute | 购物车组件所在的页面是否是从其他页面跳转进入，非 tab 页面 | boolean | false |
| isLogin | 是否为登录状态 | boolean | false |

#### Events

| 事件名称 | 说明 | 回调参数 |
| :--- | :--- | :--- |
| onLogin | 点击关联登录按钮时触发 | 无 |
| onCardClick | 点击购物车某一商品卡片时触发。返回商品 id | productId: string |
| onBack | 作为子页面时，点击头部返回按钮时触发 | 无 |
| onCheckout | 点击结算按钮时触发。返回选择的商品列表 | selectedList: Product[] |

#### 插槽

| 插槽名 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| customContentBuilder | 自定义内容插槽。比如推荐商品、猜你喜欢等 | 无 |

## 示例代码

### 示例 1（未登录）

本示例展示了未登录状态下购物车组件的展示效果。

```typescript
import { ShoppingCart } from 'module_shopping_cart';

@Entry
@ComponentV2
struct DemoPage {
  @Local isLogin: boolean = false

  build() {
    Column(){
      ShoppingCart({
        isLogin: this.isLogin,
        onLogin: () => {
          // TODO 点击登录按钮跳转到登录页
        }
      })
    }
  }
}
```

### 示例 2（购物车组件所在的页面作为子路由页面）

本示例展示了购物车组件所在页面作为子页面时的效果。

```typescript
import { ShoppingCart } from 'module_shopping_cart';
import { Product } from 'module_shopping_cart';

@Entry
@ComponentV2
struct DemoPage {
  @Local isChildRoute: boolean = true
  @Local isLogin: boolean = true

  build() {
    Column(){
      ShoppingCart({
        isChildRoute: this.isChildRoute,
        isLogin: this.isLogin,
        customContentBuilder: () => {
          // TODO 自定义模块，推荐商品
        },
        onLogin: () => {
          // TODO 登录逻辑
        },
        onCardClick: (productId: string) => {
          // TODO 点击购物车卡片
        },
        onBack: () => {
          // TODO 返回事件
        },
        onCheckout: (selectedList: Product[]) => {
          // TODO 结算逻辑
        }
      })
    }
  }
}
```

## 更新记录

- **1.0.3 (2026-01-13)**
  Created with Pixso.
  下载该版本
  废弃 API 整改
- **1.0.2 (2025-09-10)**
  Created with Pixso.
  下载该版本
  README 更新
- **1.0.1 (2025-08-30)**
  Created with Pixso.
  下载该版本
  README 优化
- **1.0.0 (2025-07-01)**
  Created with Pixso.
  下载该版本

本组件展示了购物车商品列表信息和推荐商品信息，提供了商品选择、删除、增减商品数量、查看明细、结算、查看商品详情、查看推荐商品信息等相关功能，帮助开发者快速集成购物车相关的能力。

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

### 隐私政策

- 不涉及
- SDK 合规使用指南：不涉及

## 兼容性

### HarmonyOS 版本

| 版本 | 状态 |
| :--- | :--- |
| 5.0.1 | Created with Pixso. |
| 5.0.2 | Created with Pixso. |
| 5.0.3 | Created with Pixso. |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |
| 5.1.0 | Created with Pixso. |
| 5.1.1 | Created with Pixso. |
| 6.0.0 | Created with Pixso. |
| 6.0.1 | Created with Pixso. |

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEco Studio 版本

| 版本 | 状态 |
| :--- | :--- |
| DevEco Studio 5.0.1 | Created with Pixso. |
| DevEco Studio 5.0.2 | Created with Pixso. |
| DevEco Studio 5.0.3 | Created with Pixso. |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |
| DevEco Studio 6.0.1 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/68d7d7636cab4565bafbbb7e62b63764/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%95%86%E5%9F%8E%E8%B4%AD%E7%89%A9%E8%BD%A6%E7%BB%84%E4%BB%B6/module_shopping_cart1.0.3.zip