# 点餐购物车组件

## 简介

本组件提供了点餐购物车展示功能，可以展示点餐购物车悬浮条以及点餐购物车列表，点餐购物车商品可以编辑修改和选择下单。

## 详细介绍

### 简介

本组件提供了点餐购物车展示功能，可以展示点餐购物车悬浮条以及点餐购物车列表，点餐购物车商品可以编辑修改和选择下单。

### 界面展示

点餐购物车收起点餐购物车展开

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 6.0.2 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 6.0.2 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.5(17) 及以上

#### 权限

无

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。

b. 在项目根目录 `build-profile.json5` 并添加 `shopping_cart` 和 `base_ui` 模块。

深色代码主题复制
```json5
// 在项目根目录的 build-profile.json5 填写 shopping_cart 路径。其中 xxx 为组件存在的目录名
"modules": [
  {
    "name": "shopping_cart",
    "srcPath": "./xxx/shopping_cart",
  },
  {
    "name": "base_ui",
    "srcPath": "./xxx/base_ui",
  }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

深色代码主题复制
```json5
// xxx 为组件存放的目录名称
"dependencies": {
  "shopping_cart": "file:./xxx/shopping_cart"
}
```

#### 引入组件

深色代码主题复制
```typescript
import { ShoppingCart } from 'shopping_cart';
```

#### 调用组件

调用组件，详细参数配置说明参见 API 参考。

深色代码主题复制
```typescript
ShoppingCart({
   myCar: this.myCarModel.myCar,
   carCheck: this.myCarModel.carCheck,
   isRest: this.storeModel.storeInfo.isRest || this.isRest,
   clearCarCb: () => {
     // 清空点餐购物车
   },
   updateCarCb: (id: string, num: number) => {
     // 更新点餐购物车
   },
   goConfirmOrderCb: (carGoodsSelect: Array<CarGoodsInfo>) => {
     // 提交订单
   },
   changeCarCheck: (id: string, isDelete?: boolean) => {
     // 修改点餐购物车商品选择
   },
})
```

## API 参考

### 接口

`ShoppingCart(options?: ShoppingCartOptions)`

点餐购物车组件。

### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | ShoppingCartOptions | 是 | 点餐购物车的参数。 |

#### ShoppingCartOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| myCar | MyCar | 是 | 点餐购物车数据 |
| carCheck | string[] | 是 | 点餐购物车已选商品 |
| isRest | boolean | 否 | 店铺是否休息 |

#### MyCar 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| boxMoney | number | 否 | 打包费用 |
| carGoods | CarGoodsInfo[] | 是 | 点餐购物车商品数据 |
| num | number | 否 | 点餐购物车商品数量 |
| money | number | 否 | 点餐购物车商品总金额 |

#### CarGoodInfo 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | number | 是 | 点餐购物车内商品序号 |
| goodsId | string | 是 | 商品序号 |
| logo | string | 是 | 商品图标 |
| name | string | 是 | 商品名称 |
| num | number | 是 | 商品数量 |
| specType | number | 是 | 商品类别 |
| spec | string | 否 | 商品规格 |
| combinationPackageSpec | [] | 否 | 商品规格信息 |
| money | string | 是 | 商品单价 |

#### PackageSpec 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| specId | string | 是 | 商品规格序号 |
| specValId | string | 是 | 商品规格默认值 |
| specName | string | 是 | 商品规格名称 |
| specLogo | string | 否 | 商品规格图标 |
| specVal | string | 是 | 商品规格枚举值 |
| specNum | number | 是 | 商品规格数据 |

### 事件

支持以下事件：

- **clearCarCb**
  `clearCarCb(callback: (coordinates: string = '', address: string = '') => void)`
  清空点餐购物车

- **updateCarCb**
  `updateCarCb(callback: (storeId: string) => void)`
  更新点餐购物车

- **goConfirmOrderCb**
  `goConfirmOrderCb(callback: (callTelSheet: boolean, tel: string) => void)`
  提交订单

- **changeCarCheck**
  `changeCarCheck(callback: (callTelSheet: boolean, tel: string) => void)`
  修改点餐购物车商品选择

## 示例代码

深色代码主题复制
```typescript
import { promptAction } from '@kit.ArkUI';
import { ShoppingCart } from 'shopping_cart';
import { CarGoodsInfo, MyCar } from 'shopping_cart/src/main/ets/models/Index';

@Entry
@ComponentV2
struct Index {
  @Local myCar: MyCar = new MyCar();
  @Local carCheck: Array<string> = [];
  @Local isRest: boolean = false

  aboutToAppear(): void {
     let goods = new CarGoodsInfo()
     goods.id = '1'
     goods.goodsId = '1'
     goods.name = '商品'
     goods.logo = 'TeaDrinkOrders/good_pkg_logo.png'
     goods.num = 2
     goods.money = '11.5'
     this.myCar.carGoods.push(goods)
     this.carCheck.push(goods.id)
  }

  build() {
     Stack() {
        ShoppingCart({
           myCar: this.myCar,
           carCheck: this.carCheck,
           isRest: this.isRest,
           clearCarCb: () => {
              // 清空点餐购物车
              promptAction.showToast({ message: '清空点餐购物车' })
           },
           updateCarCb: (id: string, num: number) => {
              // 更新点餐购物车
              promptAction.showToast({ message: '更新点餐购物车' })
           },
           goConfirmOrderCb: (carGoodsSelect: Array<CarGoodsInfo>) => {
              // 提交订单
              promptAction.showToast({ message: '提交订单' })
           },
           changeCarCheck: (id: string, isDelete?: boolean) => {
              // 修改点餐购物车商品选择
              promptAction.showToast({ message: '修改点餐购物车商品选择' })
           },
        })
     }
     .alignContent(Alignment.Bottom)
     .height('100%')
     .width('100%')
  }
}
```

## 更新记录

### 1.0.2 (2026-02-13)

Created with Pixso.

- 下载该版本
- 修改 README
- 修改清空操作时购物车半模态展示的问题
- 修改手动减少购物车商品为空时，购物车数据展示错误的问题

### 1.0.1 (2025-10-31)

Created with Pixso.

- 下载该版本
- 修改 README

### 1.0.0 (2025-08-30)

Created with Pixso.

- 下载该版本
- 初始版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规

不涉及

### 兼容性

| 项目 | 详情 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.5 <br/> Created with Pixso. <br/> 5.1.0 <br/> Created with Pixso. <br/> 5.1.1 <br/> Created with Pixso. <br/> 6.0.0 <br/> Created with Pixso. <br/> 6.0.1 <br/> Created with Pixso. <br/> 6.0.2 <br/> Created with Pixso. |
| **应用类型** | 应用 <br/> Created with Pixso. <br/> 元服务 <br/> Created with Pixso. |
| **设备类型** | 手机 <br/> Created with Pixso. <br/> 平板 <br/> Created with Pixso. <br/> PC <br/> Created with Pixso. |
| **DevEcoStudio 版本** | DevEco Studio 6.0.2 <br/> Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/81a63137ab72414583f084236c9326b1/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%82%B9%E9%A4%90%E8%B4%AD%E7%89%A9%E8%BD%A6%E7%BB%84%E4%BB%B6/shopping_cart1.0.2.zip