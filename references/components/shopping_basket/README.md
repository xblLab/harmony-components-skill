# 菜篮子组件

## 简介

本组件提供了展示菜篮子页面的相关功能。

## 详细介绍

### 简介

本组件提供了展示菜篮子页面的相关功能。

### 功能描述

展示所有用料展示菜谱中用料

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

#### 权限

无

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 并添加 `base_ui` 和 `shopping_basket` 模块。

```json5
// 在项目根目录的 build-profile.json5 填写 base_ui 和 shopping_basket 路径。其中 xxx 为组件存在的目录名
"modules": [
  {
    "name": "base_ui",
    "srcPath": "./xxx/base_ui",
  },
  {
    "name": "shopping_basket",
    "srcPath": "./xxx/shopping_basket",
  }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// xxx 为组件存放的目录名称
"dependencies": {
  "base_ui": "file:./xxx/base_ui",
  "shopping_basket": "file:./xxx/shopping_basket"
}
```

#### 引入组件

```typescript
import { ShoppingBasket } from 'shopping_basket';
```

#### 调用组件

调用组件，详细参数配置说明参见 API 参考。

```typescript
ShoppingBasket({
  basketList: this.basketList.list,
  goRecipeDetail: (id: number) => {
    // 跳转菜谱详情
  },
  removeRecipe: (param: BasketItem) => {
    // 删除菜篮子里的菜谱
  },
})
```

### API 参考

#### 接口

`ShoppingBasket(options?: ShoppingBasketOptions)`

展示菜篮子页面组件。

#### 参数

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | ShoppingBasketOptions | 否 | 展示菜篮子页面的参数。 |

**ShoppingBasketOptions 对象说明**

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| basketList | BasketItem[] | 否 | 菜篮子里菜谱列表 |

**BasketItem 对象说明**

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | number | 是 | 菜谱序号 |
| title | string | 是 | 菜谱名称 |
| todoList | IngredientItem[] | 是 | 菜谱待完成用料 |
| finishedList | IngredientItem[] | 是 | 菜谱已完成用料 |

**IngredientItem 对象说明**

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| name | string | 是 | 用料名称 |
| quantity | string | 是 | 用料数量 |
| unit | string | 否 | 用料单位 |
| sum | string | 否 | 总用料 |
| sumArr | string | 否 | 已完成用料数量 |

#### 事件

支持以下事件：

- **goRecipeDetail**
  - `goRecipeDetail(callback: (id: number) => void)`
  - 跳转菜谱详情
- **removeRecipe**
  - `removeRecipe(callback: (param: BasketItem) => void)`
  - 删除菜篮子里的菜谱

### 示例代码

```typescript
import { promptAction } from '@kit.ArkUI';
import { BasketItem, IngredientItem, ShoppingBasket } from 'shopping_basket';

@Entry
@ComponentV2
struct Index {
  @Local currentIndex: number = 1
  @Local basketList: BasketItem[] =
     [new BasketItem(1, '可乐鸡翅', [new IngredientItem('鸡翅', '500', '克'), new IngredientItem('可乐', '1', '罐')],
        []),
        new BasketItem(2, '西红柿牛腩',
           [new IngredientItem('牛腩', '500', '克'), new IngredientItem('西红柿', '3', '个')], [])]

  build() {
     RelativeContainer() {
        ShoppingBasket({
           basketList: this.basketList,
           goRecipeDetail: (id: number) => {
              // 跳转菜谱详情
              promptAction.showToast({ message: '跳转菜谱详情' })
           },
           removeRecipe: (param: BasketItem) => {
              // 删除菜篮子里的菜谱
              promptAction.showToast({ message: '删除菜篮子里的菜谱' })
           },
        })
     }
     .height('100%')
     .width('100%')
     .padding({ top: 45 })
  }
}
```

### 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.4 | 2026-01-14 | 下载该版本废弃 api 修改，ux 检测修改 |
| 1.0.3 | 2025-11-07 | 下载该版本更新修改 readme 内容 |
| 1.0.1 | 2025-09-11 | 下载该版本更新 readme 内容 |
| 1.0.0.0 | 2025-08-29 | 下载该版本初始版本 |
| 1.0.0 | 2025-07-10 | 下载该版本本组件提供了展示菜篮子页面的相关功能。 |

### 权限与隐私

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

#### 隐私政策

不涉及

#### SDK 合规使用指南

不涉及

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/d41c85733aeb446db7223080cccef718/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%8F%9C%E7%AF%AE%E5%AD%90%E7%BB%84%E4%BB%B6/shopping_basket1.0.4.zip