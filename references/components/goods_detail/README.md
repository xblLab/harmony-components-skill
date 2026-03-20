# 点餐商品详情组件

## 简介

本组件提供了展示多种类型点餐商品详情的功能。

## 详细介绍

### 组件简介

本组件提供了展示多种类型点餐商品详情的功能。

### 支持类型

- 无规格商品
- 选规格商品
- 套餐商品

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

#### 权限

- **网络权限**：`ohos.permission.INTERNET`

### 使用

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 并添加 `goods_detail` 模块。

```json5
// 在项目根目录的 build-profile.json5 填写 goods_detail 路径。其中 xxx 为组件存在的目录名
"modules": [
  {
    "name": "goods_detail",
    "srcPath": "./xxx/goods_detail",
  }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// xxx 为组件存放的目录名称
"dependencies": {
  "goods_detail": "file:./xxx/goods_detail"
}
```

引入组件。

```typescript
import { GoodsDetail } from 'goods_detail';
```

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

调用组件，详细参数配置说明参见 API 参考。

```typescript
GoodsDetail({
    goodsInfo: this.goodsInfo,
    goodSpecList: this.goodSpecList,
    goodSinglePrice: this.goodSinglePrice,
    selectSpecArr: this.selectSpecArr,
    clickAddCarCb: (goodNum: number) => {
      // 点击添加购物车事件
    },
    getSelectSpec: (item: SpecItemResp, index: number) => {
      // 选择规格事件
    },
  })
```

## API 参考

### 接口

`GoodsDetail(options?: GoodsDetailOptions)`

点餐商品详情组件。

#### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | GoodsDetailOptions | 是 | 点餐商品详情的参数。 |

##### GoodsDetailOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| goodsInfo | Goods | 是 | 商品信息 |
| goodSpecList | SpecCatalogResp[] | 否 | 规格信息 |
| selectSpecArr | PackageSpecResp[] | 否 | 已选规格信息 |
| goodSinglePrice | number | 否 | 规格商品单价 |

##### Goods 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 商品序号 |
| name | string | 是 | 商品名称 |
| logo | string | 是 | 商品图标 |
| bigImg | string[] | 是 | 商品大图 |
| money | number | 是 | 商品现价 |
| money2 | number | 否 | 商品原价 |
| discount | string | 否 | 商品折扣 |
| content | string | 是 | 商品介绍 |
| sales | number | 是 | 商品销售数量 |
| specType | number | 否 | 商品类别 |
| details | string | 否 | 商品详情 |
| num | number | 否 | 商品数量 |
| isMust | number | 否 | 是否必选商品 |
| spec | SpecCatalogResp[] | 否 | 商品规格 |
| boxMoney | number | 否 | 商品打包费 |

##### SpecCatalogResp 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| specId | string | 是 | 规格序号 |
| specName | string | 是 | 规格名称 |
| specValId | string | 是 | 规格内容默认值序号 |
| specVal | SpecItemResp[] | 是 | 规格内容 |

##### SpecItemResp 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| specValId | string | 是 | 规格内容序号 |
| specValName | string | 是 | 规格内容值 |
| specValLogo | string | 否 | 套餐规格商品图标 |
| specValNum | string | 否 | 套餐规格商品数量 |

##### PackageSpecResp 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| specName | string | 是 | 规格内容 |
| specNum | number | 是 | 规格内容数量 |

### 事件

支持以下事件：

#### clickAddCarCb

`clickAddCarCb(callback: (goodNum: number) => void)`

点击添加购物车事件

#### getSelectSpec

`getSelectSpec(callback: (item: SpecItemResp, index: number) => void)`

选择规格事件

## 示例代码

### 示例 1（无规格商品）

本示例展示无规格商品详情页。

```typescript
import { Goods, GoodsDetail, GoodsSpecResp, PackageSpecResp, SpecCatalogResp, SpecItemResp } from 'goods_detail';
import { promptAction } from '@kit.ArkUI';

@Entry
@ComponentV2
struct Index {
  @Local goodsInfo: Goods = new Goods();
  @Local goodSpecList: Array<SpecCatalogResp> = [];
  @Local selectSpecArr: Array<PackageSpecResp> = [];
  @Local selectSpecInfo?: GoodsSpecResp = undefined;
  @Local goodSinglePrice: number = 0;

  aboutToAppear(): void {
     this.goodsInfo.id = '1'
     this.goodsInfo.name = '商品名称'
     this.goodsInfo.logo = 'CateringOrderTemplate/good_logo1.png';
     this.goodsInfo.bigImg = ['CateringOrderTemplate/good_logo1-1.png', 'CateringOrderTemplate/good_logo1-2.png',
        'CateringOrderTemplate/good_logo1-3.png']
     this.goodsInfo.money = 16.4
     this.goodsInfo.money2 = 16.4
     this.goodsInfo.content = '圆形奶油面包'
     this.goodsInfo.sales = 200
     this.goodsInfo.specType = 1
     this.goodsInfo.details = 'CateringOrderTemplate/good_logo1-1.png'
     this.goodsInfo.num = 200
     this.goodsInfo.isMust = 0
     this.goodsInfo.spec = []
     this.goodsInfo.boxMoney = 1
     this.goodsInfo.discount = ''
     this.goodSinglePrice = 16.4
  }

  build() {
     Column({ space: 20 }) {
        GoodsDetail({
           goodsInfo: this.goodsInfo,
           goodSpecList: this.goodSpecList,
           goodSinglePrice: this.goodSinglePrice,
           selectSpecArr: this.selectSpecArr,
           clickAddCarCb: (goodNum: number) => {
              promptAction.showToast({ message: '添加购物车~' })
           },
           getSelectSpec: (item: SpecItemResp, index: number) => {
              promptAction.showToast({ message: '切换规格查询~' })
           },
        })
     }
     .height('100%')
     .width('100%')
     .backgroundColor($r('sys.color.background_secondary'))
  }
}
```

### 示例 2（有规格商品）

本示例展示有规格商品详情页。

```typescript
import { Goods, GoodsDetail, GoodsSpecResp, PackageSpecResp, SpecCatalogResp, SpecItemResp } from 'goods_detail';
import { promptAction } from '@kit.ArkUI';

@Entry
@ComponentV2
struct Index {
  @Local goodsInfo: Goods = new Goods();
  @Local goodSpecList: Array<SpecCatalogResp> = [];
  @Local selectSpecArr: Array<PackageSpecResp> = [];
  @Local selectSpecInfo?: GoodsSpecResp = undefined;
  @Local goodSinglePrice: number = 0;

  aboutToAppear(): void {
     this.goodsInfo.id = '1'
     this.goodsInfo.name = '商品名称'
     this.goodsInfo.logo = 'CateringOrderTemplate/good_logo1.png';
     this.goodsInfo.bigImg = ['CateringOrderTemplate/good_logo1-1.png', 'CateringOrderTemplate/good_logo1-2.png']
     this.goodsInfo.money = 16.4
     this.goodsInfo.money2 = 16.4
     this.goodsInfo.content = '圆形奶油面包'
     this.goodsInfo.sales = 200
     this.goodsInfo.specType = 2
     this.goodsInfo.details = 'CateringOrderTemplate/good_logo1-1.png'
     this.goodsInfo.num = 200
     this.goodsInfo.isMust = 0
     this.goodsInfo.spec = []
     this.goodsInfo.boxMoney = 1
     this.goodsInfo.discount = ''
     this.goodSinglePrice = 16.4

     this.goodSpecList =
     [{
        specId: '1',
        specName: '奶油',
        specValId: '11',
        specVal: [{
           specValId: '11',
           specValName: '动物奶油',
           specValLogo: '',
           specValNum: '1',
        }, {
           specValId: '12',
           specValName: '植物奶油',
           specValLogo: '',
           specValNum: '1',
        }],
     }, {
        specId: '2',
        specName: '糖类选择',
        specValId: '22',
        specVal: [{
           specValId: '21',
           specValName: '蔗糖',
           specValLogo: '',
           specValNum: '1',
        }, {
           specValId: '22',
           specValName: '赤鲜糖醇（0 糖）',
           specValLogo: '',
           specValNum: '1',
        }],
     }, {
        specId: '3',
        specName: '尺寸',
        specValId: '31',
        specVal: [{
           specValId: '31',
           specValName: '6 寸',
           specValLogo: '',
           specValNum: '1',
        }, {
           specValId: '32',
           specValName: '9 寸',
           specValLogo: '',
           specValNum: '1',
        }, {
           specValId: '33',
           specValName: '12 寸',
           specValLogo: '',
           specValNum: '1',
        }],
     }]
     this.goodsInfo.spec = this.goodSpecList

     this.selectSpecArr = this.goodSpecList.map((item: SpecCatalogResp) => {
        let goodSpec = item.specVal.find((spec: SpecItemResp) => item.specValId === spec.specValId);
        let result: PackageSpecResp =
           { specName: goodSpec?.specValName || '', specNum: Number(goodSpec?.specValNum ?? 1) };
        return result;
     });
  }

  build() {
     Column({ space: 20 }) {
        GoodsDetail({
           goodsInfo: this.goodsInfo,
           goodSpecList: this.goodSpecList,
           goodSinglePrice: this.goodSinglePrice,
           selectSpecArr: this.selectSpecArr,
           clickAddCarCb: (goodNum: number) => {
              promptAction.showToast({ message: '添加购物车~' })
           },
           getSelectSpec: (item: SpecItemResp, index: number) => {

              this.getSelectSpec(item, index)
           },
        })
     }
     .height('100%')
     .width('100%')
     .backgroundColor($r('sys.color.background_secondary'))
  }

  getSelectSpec(item: SpecItemResp, index: number) {
     let pkgSpec: PackageSpecResp = {
        specName: item.specValName,
        specNum: Number(item.specValNum),
     };
     this.selectSpecArr[index] = pkgSpec;
     promptAction.showToast({ message: '切换规格~' })
  }
}
```

### 示例 3（套餐商品）

本示例展示套餐商品详情页。

```typescript
import { Goods, GoodsDetail, GoodsSpecResp, PackageSpecResp, SpecCatalogResp, SpecItemResp } from 'goods_detail';
import { promptAction } from '@kit.ArkUI';

@Entry
@ComponentV2
struct Index {
  @Local goodsInfo: Goods = new Goods();
  @Local goodSpecList: Array<SpecCatalogResp> = [];
  @Local selectSpecArr: Array<PackageSpecResp> = [];
  @Local selectSpecInfo?: GoodsSpecResp = undefined;
  @Local goodSinglePrice: number = 0;

  aboutToAppear(): void {
     this.goodsInfo.id = '1'
     this.goodsInfo.name = '商品名称'
     this.goodsInfo.logo = 'CateringOrderTemplate/good_logo1.png';
     this.goodsInfo.bigImg = ['CateringOrderTemplate/good_logo1-1.png', 'CateringOrderTemplate/good_logo1-2.png']
     this.goodsInfo.money = 16.4
     this.goodsInfo.money2 = 16.4
     this.goodsInfo.content = '圆形奶油面包'
     this.goodsInfo.sales = 200
     this.goodsInfo.specType = 3
     this.goodsInfo.details = 'CateringOrderTemplate/good_logo1-1.png'
     this.goodsInfo.num = 200
     this.goodsInfo.isMust = 0
     this.goodsInfo.spec = []
     this.goodsInfo.boxMoney = 1
     this.goodsInfo.discount = ''
     this.goodSinglePrice = 16.4

     this.goodSpecList =
     [{
        specId: '1',
        specName: '招牌菜品  （必选）',
        specValId: '11',
        specVal: [{
           specValId: '11',
           specValName: '黄金炙烤谷饲战斧牛排',
           specValLogo: 'CateringOrderTemplate/good_spec_logo1.png',
           specValNum: '2',
        }],
     }, {
        specId: '2',
        specName: '特色配菜 3 选 1',
        specValId: '23',
        specVal: [{
           specValId: '21',
           specValName: '蔬菜沙拉',
           specValLogo: 'CateringOrderTemplate/good_spec_logo2.png',
           specValNum: '1',
        }, {
           specValId: '22',
           specValName: '酸橘汁配虾仁和橙子双拼',
           specValLogo: 'CateringOrderTemplate/good_spec_logo3.png',
           specValNum: '1',
        }, {
           specValId: '23',
           specValName: '豌豆炒虾仁',
           specValLogo: 'CateringOrderTemplate/good_spec_logo4.png',
           specValNum: '1',
        }],
     }, {
        specId: '3',
        specName: '主食  2 选 1',
        specValId: '32',
        specVal: [{
           specValId: '31',
           specValName: '意大利面',
           specValLogo: 'CateringOrderTemplate/good_spec_logo5.png',
           specValNum: '2',
        }, {
           specValId: '32',
           specValName: '披萨',
           specValLogo: 'CateringOrderTemplate/good_spec_logo6.png',
           specValNum: '1',
        }],
     }, {
        specId: '4',
        specName: '甜品  4 选 1',
        specValId: '43',
        specVal: [{
           specValId: '41',
           specValName: '蜂蜜柚子茶',
           specValLogo: 'CateringOrderTemplate/good_spec_logo7.png',
           specValNum: '1',
        }, {
           specValId: '42',
           specValName: '鲜榨果汁（口味备注，默认随机）...',
           specValLogo: 'CateringOrderTemplate/good_spec_logo8.png',
           specValNum: '2',
        }, {
           specValId: '43',
           specValName: '冰橙美式咖啡',
           specValLogo: 'CateringOrderTemplate/good_spec_logo9.png',
           specValNum: '2',
        }, {
           specValId: '44',
           specValName: '柠檬红茶',
           specValLogo: 'CateringOrderTemplate/good_spec_logo10.png',
           specValNum: '1',
        }],
     }]
     this.goodsInfo.spec = this.goodSpecList

     this.selectSpecArr = this.goodSpecList.map((item: SpecCatalogResp) => {
        let goodSpec = item.specVal.find((spec: SpecItemResp) => item.specValId === spec.specValId);
        let result: PackageSpecResp =
           { specName: goodSpec?.specValName || '', specNum: Number(goodSpec?.specValNum ?? 1) };
        return result;
     });
  }

  build() {
     Column({ space: 20 }) {
        GoodsDetail({
           goodsInfo: this.goodsInfo,
           goodSpecList: this.goodSpecList,
           goodSinglePrice: this.goodSinglePrice,
           selectSpecArr: this.selectSpecArr,
           clickAddCarCb: (goodNum: number) => {
              promptAction.showToast({ message: '添加购物车~' })
           },
           getSelectSpec: (item: SpecItemResp, index: number) => {

              this.getSelectSpec(item, index)
           },
        })
     }
     .height('100%')
     .width('100%')
     .padding({ top: 45 })
  }

  getSelectSpec(item: SpecItemResp, index: number) {
     let pkgSpec: PackageSpecResp = {
        specName: item.specValName,
        specNum: Number(item.specValNum),
     };
     this.selectSpecArr[index] = pkgSpec;
     promptAction.showToast({ message: '切换规格~' })
  }
}
```

## 更新记录

### 1.0.2 (2026-01-13)

- 下载该版本
- 样式调整

### 1.0.0 (2025-09-10)

- 下载该版本
- 初始版本

## 权限与隐私

| 基本信息 | 说明 |
| :--- | :--- |
| 权限名称 | ohos.permission.INTERNET |
| 权限说明 | 允许使用 Internet 网络 |
| 使用目的 | 允许使用 Internet 网络 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| 应用类型 | 应用，元服务 |
| 设备类型 | 手机，平板，PC |
| DevEco Studio 版本 | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/71a4be36314d4023a23c403c48f2430a/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%82%B9%E9%A4%90%E5%95%86%E5%93%81%E8%AF%A6%E6%83%85%E7%BB%84%E4%BB%B6/goods_detail1.0.2.zip