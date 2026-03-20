# 超值加购组件

## 简介

本组件提供了下单时增加超值商品加购的功能。

## 详细介绍

### 简介

本组件提供了下单时增加超值商品加购的功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

#### 权限

- **网络权限**：ohos.permission.INTERNET

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 并添加 `snack_sized_deal` 模块。

```json5
// 在项目根目录的 build-profile.json5 填写 snack_sized_deal 路径。其中 xxx 为组件存在的目录名
"modules": [
  {
    "name": "snack_sized_deal",
    "srcPath": "./xxx/snack_sized_deal",
  }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// xxx 为组件存放的目录名称
"dependencies": {
  "snack_sized_deal": "file:./xxx/snack_sized_deal"
}
```

#### 引入组件

```typescript
import { SnackSizedDeal } from 'snack_sized_deal';
```

#### 添加权限

在主工程的 `src/main` 路径下的 `module.json5` 文件的 `requestPermissions` 字段中添加如下权限：

```json5
"requestPermissions": [
   ...
   {
     "name": "ohos.permission.INTERNET",
     "reason": "$string:app_name",
     "usedScene": {
       "abilities": [
         "FormAbility"
       ],
       "when": "inuse"
     }
   }
   ...
 ],
```

#### 调用组件

调用组件，详细参数配置说明参见 API 参考。

```typescript
SnackSizedDeal({
  goodsList: this.goodsList,
  closeDialog: (addGoodsList?: Goods[]) => {
    this.closeDialog(addGoodsList)
  },
})
```

### API 参考

#### 接口

`SnackSizedDeal(options?: SnackSizedDealOptions)`

超值加购组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | SnackSizedDealOptions | 是 | 超值加购的参数。 |

**SnackSizedDealOptions 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| goodsList | Goods[] | 是 | 商品信息 |

**Goods 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 商品序号 |
| name | string | 是 | 商品名称 |
| logo | string | 是 | 商品图标 |
| bigImg | string[] | 是 | 商品大图 |
| money | number | 是 | 商品现价 |
| money2 | number | 是 | 商品原价 |
| discount | string | 否 | 商品折扣 |
| content | string | 是 | 商品介绍 |
| sales | number | 是 | 商品销售数量 |
| specType | number | 否 | 商品类别 |
| details | string | 否 | 商品详情 |
| num | number | 否 | 商品数量 |
| isMust | number | 否 | 是否必选商品 |
| spec | SpecCatalogResp[] | 否 | 商品规格 |
| boxMoney | number | 否 | 商品打包费 |

**SpecCatalogResp 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| specId | string | 是 | 规格序号 |
| specName | string | 是 | 规格名称 |
| specValId | string | 是 | 规格内容默认值序号 |
| specVal | SpecItemResp[] | 是 | 规格内容 |

**SpecItemResp 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| specValId | string | 是 | 规格内容序号 |
| specValName | string | 是 | 规格内容值 |
| specValLogo | string | 否 | 套餐规格商品图标 |
| specValNum | string | 否 | 套餐规格商品数量 |

#### 事件

支持以下事件：

**closeDialog**

`closeDialog(callback: (addGoodsList: Goods[]) => void)`

关闭弹窗回调事件。

#### 示例代码

```typescript
import { promptAction } from '@kit.ArkUI';
import { Goods, SnackSizedDeal } from 'snack_sized_deal';

@Entry
@ComponentV2
struct Index {
  @Local goodsList: Goods[] = [];

  aboutToAppear(): void {
     const goods1: Goods = {
        id: '1',
        name: '圆形面包',
        logo: 'CateringOrderTemplate/good_logo1.png',
        bigImg: ['CateringOrderTemplate/good_logo1-1.png', 'CateringOrderTemplate/good_logo1-2.png'],
        money: 5,
        money2: 16.4,
        discount: '',
        content: '圆形奶油面包',
        sales: 200,
        specType: 4,
        details: 'CateringOrderTemplate/good_logo1-1.png',
        num: 200,
        isMust: 0,
        spec: [],
        boxMoney: 1,
     }
     this.goodsList.push(goods1)
     const goods2: Goods = {
        id: '2',
        name: '冰橙美式咖啡',
        logo: 'CateringOrderTemplate/good_logo2.png',
        bigImg: ['CateringOrderTemplate/good_logo2.png'],
        money: 5,
        money2: 25,
        discount: '',
        content: '冰橙美式咖啡',
        sales: 200,
        specType: 4,
        details: 'CateringOrderTemplate/good_logo2.png',
        num: 200,
        isMust: 0,
        spec: [],
        boxMoney: 1,
     }
     this.goodsList.push(goods2)
  }

  build() {
     RelativeContainer() {
        SnackSizedDeal({
           goodsList: this.goodsList,
           closeDialog: (addGoodsList?: Goods[]) => {
              promptAction.showToast({ message: '带参数跳转页面' })
           },
        })
     }
     .height('100%')
     .width('100%')
     .padding({ top: 45 })
     .backgroundColor(`#66000000`)
  }
}
```

## 更新记录

- **1.0.1** (2026-01-13)
  - 下载该版本
- **1.0.0** (2025-11-03)
  - 统一日志打印
  - 下载该版本
- **初始版本**

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

| 类别 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/92e7e3093d3846309bf084a2f9e01f31/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%B6%85%E5%80%BC%E5%8A%A0%E8%B4%AD%E7%BB%84%E4%BB%B6/snack_sized_deal1.0.1.zip