# 订单详情组件

## 简介

本组件提供了订单详情展示功能，包含订单状态、制作和配送信息、店铺信息、商品列表、优惠信息和订单信息。

## 详细介绍

### 简介

本组件提供了订单详情展示功能，包含订单状态、制作和配送信息、店铺信息、商品列表、优惠信息和订单信息。

### 展开地图收起地图

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 6.0.1 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 6.0.1 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 6.0.1(13) 及以上

#### 权限

- 获取位置权限：ohos.permission.APPROXIMATELY_LOCATION、ohos.permission.LOCATION
- 网络权限：ohos.permission.INTERNET

### 使用

#### 安装组件

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。
b. 在项目根目录 build-profile.json5 并添加 order_detail 和 base_ui 模块。
c. 在项目根目录 oh-package.json5 中添加依赖。

**深色代码主题复制** // 在项目根目录的 build-profile.json5 填写 order_detail 和 base_ui 路径。其中 xxx 为组件存在的目录名

```json5
"modules": [
  {
    "name": "order_detail",
    "srcPath": "./xxx/order_detail",
  },
  {
    "name": "base_ui",
    "srcPath": "./xxx/base_ui",
  }
]
```

**深色代码主题复制** // xxx 为组件存放的目录名称

```json5
"dependencies": {
  "order_detail": "file:./xxx/order_detail",
  "base_ui": "file:./xxx/base_ui"
}
```

#### 引入组件

**深色代码主题复制**

```typescript
import { OrderDetail } from 'order_detail';
```

#### 配置权限

在主工程的 src/main 路径下的 module.json5 文件的 requestPermissions 字段中添加如下权限：

**深色代码主题复制**

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
   },
   {
     "name": "ohos.permission.LOCATION",
     "reason": "$string:app_name",
     "usedScene": {
       "abilities": [
         "EntryAbility"
       ],
       "when": "inuse"
     }
   },
   {
     "name": "ohos.permission.APPROXIMATELY_LOCATION",
     "reason": "$string:app_name",
     "usedScene": {
       "abilities": [
         "EntryAbility"
       ],
       "when": "inuse"
     }
   }
   ...
 ],
```

#### 调用组件

调用组件，详细参数配置说明参见 API 参考。

**深色代码主题复制**

```typescript
OrderDetail({
  orderInfo: this.orderDetailInfo.order,
  goods: this.orderDetailInfo.goods,
  address: this.orderDetailInfo.address,
  delivery: this.orderDetailInfo.delivery,
  confirmOrder: (): void => {
    // 下单接口调用
  },
  showPaySheet: (): void => {
    // 展示支付弹窗支付
  },
  cancelOrderCb: (): void => {
    // 取消订单  
  },
  oneMoreOrder: (): void => {
    // 再来一单跳转
  },
  callTelCb: (): void => {
    // 展示拨号弹窗  
  },
  goNavigation: (): void => {
    // 跳转地图导航
  },
})
```

## API 参考

### 接口

**OrderDetail(options?: OrderDetailOptions)**
订单详情组件。

#### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | OrderDetailOptions | 是 | 订单详情参数。 |

##### OrderDetailOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| orderInfo | OrderInfo | 是 | 订单详细信息 |
| goods | GoodsOfOrder[] | 是 | 订单商品列表 |
| address | AddressInfo | 否 | 订单配送地址 |
| delivery | DeliveryInfo | 否 | 订单配送信息 |

###### OrderInfo 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 订单序号 |
| orderNum | string | 是 | 订单号 |
| time | string | 是 | 下单时间 |
| payTime | number | 否 | 支付时间 |
| money | number | 是 | 订单金额 |
| boxMoney | number | 是 | 打包费用 |
| mjMoney | string | 否 | 满减金额 |
| xyhMoney | string | 否 | 新用户优惠金额 |
| note | number | 否 | 订单备注 |
| payType | number | 否 | 支付类型 |
| orderType | number | 是 | 订单类型 |
| cutlery | number | 是 | 用餐人数 |
| yhqMoney | string | 否 | 优惠券金额 |
| couponId | string | 否 | 优惠券 id |
| state | number | 是 | 订单状态 |
| oid | string | 否 | 取餐码 |
| tel | string | 是 | 店铺电话 |
| storeName | string | 是 | 店铺名称 |
| address | string | 是 | 店铺地址 |
| coordinates | string | 是 | 店铺坐标 |
| bagMoney | number | 否 | 保温袋费用 |

###### GoodsOfOrder 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 商品序号 |
| logo | string | 是 | 商品图标 |
| money | string | 是 | 商品金额 |
| name | string | 是 | 商品名称 |
| num | number | 是 | 商品数量 |
| specType | string | 是 | 商品类别 |
| spec | string | 是 | 商品规格 |
| combinationPackageSpec | [] | 是 | 商品规格列表 |

###### PackageSpec 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| specId | string | 是 | 规格序号 |
| specValId | string | 是 | 规格默认选择序号 |
| specName | string | 是 | 规格名称 |
| specLogo | string | 是 | 套餐图标 |
| specVal | string | 是 | 规格选择内容 |
| specNum | number | 是 | 规格商品数量 |

###### AddressInfo 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 订单地址序号 |
| addressPre | string | 是 | 订单街道地址 |
| addressNum | string | 是 | 订单地址门牌号 |
| name | string | 是 | 订单收货人名称 |
| sex | boolean | 是 | 订单收货人性别 |
| tel | string | 是 | 订单收货人电话 |
| tag | number | 否 | 订单收货地址标签 |
| latitude | number | 是 | 订单收货人纬度 |
| longitude | number | 是 | 订单收货人经度 |

###### DeliveryInfo 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| name | string | 是 | 配送人名称 |
| tel | string | 是 | 配送人电话 |
| latitude | number | 是 | 配送人纬度 |
| longitude | number | 是 | 配送人经度 |
| distance | number | 是 | 配送人距离 |
| remainingTime | number | 是 | 剩余送达时间 |
| estimatedTime | string | 是 | 预计送达时间 |

### 事件

#### confirmOrder

confirmOrder(callback: () => void)
下单接口调用

#### showPaySheet

showPaySheet(callback: () => void)
展示支付弹窗支付

#### cancelOrderCb

cancelOrderCb(callback: () => void)
取消订单

#### oneMoreOrder

oneMoreOrder(callback: () => void)
再来一单跳转

#### callTelCb

callTelCb(callback: () => void)
展示拨号弹窗

#### goNavigation

goNavigation(callback: () => void)
跳转地图导航

## 示例代码

**深色代码主题复制**

```typescript
import { abilityAccessCtrl, common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { AddressInfo, DeliveryInfo, OrderDetail, OrderInfo } from 'order_detail';
import { GoodsOfOrder } from 'base_ui';
import { promptAction } from '@kit.ArkUI';

@Entry
@ComponentV2
struct Index {
   @Local orderInfo: OrderInfo = new OrderInfo()
   @Local goods: Array<GoodsOfOrder> = []
   @Local address: AddressInfo = new AddressInfo()
   @Local delivery: DeliveryInfo = new DeliveryInfo()

   aboutToAppear(): void {
      let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
      atManager.requestPermissionsFromUser(getContext() as common.UIAbilityContext,
      ['ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION'])
      .then((data) => {
         let grantStatus: Array<number> = data.authResults;
         if (grantStatus.every(item => item === 0)) {
         // 授权成功
         }
      }).catch((err: BusinessError) => {
         console.error(`Failed to request permissions from user. Code is ${err.code}, message is ${err.message}`);
      });
      
      this.orderInfo.id = '1';
      this.orderInfo.orderNum = new Date().getTime().toString();
      this.orderInfo.time = '2025-02-01 10:33:33'
      this.orderInfo.money = 100;
      this.orderInfo.boxMoney = 0;
      this.orderInfo.bagMoney = 0;
      this.orderInfo.mjMoney = '5';
      this.orderInfo.note = '';
      this.orderInfo.payType = 1;
      this.orderInfo.orderType = 1;
      this.orderInfo.cutlery = '1';
      this.orderInfo.yhqMoney = '5';
      this.orderInfo.couponId = '1';
      this.orderInfo.state = 2;
      this.orderInfo.oid = `80001`;
      this.orderInfo.storeName = 'AGC 奶茶 (雨花客厅店)';
      this.orderInfo.address = '南京市雨花台区华为路华为云楼';
      this.orderInfo.tel = '10000000003';
      this.orderInfo.coordinates = '31.97831,118.76362';
      let good: GoodsOfOrder = new GoodsOfOrder()
      good.id = '1'
      good.name = '商品'
      good.logo = 'TeaDrinkOrders/good_pkg_logo.png'
      good.num = 2
      good.money = '11.5'
      good.num = 1;
      good.specType = '1';
      good.spec = '';
      good.combination = [];
      this.goods.push(good)
      
      this.address.addressPre = '雨花客厅'
      this.address.addressNum = 'D1 栋 xx 单元 xxxx'
      this.address.name = '索先生'
      this.address.sex = true
      this.address.tel = '10000000005'
      this.address.tag = 0
      this.address.latitude = 31.9789782
      this.address.longitude = 118.7641445
      
      this.delivery.latitude = 31.984119763914883
      this.delivery.longitude = 118.76458756248296
      this.delivery.distance = 573.883184314602
      this.delivery.remainingTime = 10
      this.delivery.estimatedTime = '16:29-16:34'
   }
   
   build() {
      Column({ space: 20 }) {
         OrderDetail({
            orderInfo: this.orderInfo,
            goods: this.goods,
            address: this.address,
            delivery: this.delivery,
            showPaySheet: (): void => {
               // 展示支付弹窗支付
               promptAction.showToast({ message: '展示支付弹窗支付' })
            },
            cancelOrderCb: (): void => {
               // 取消订单
               promptAction.showToast({ message: '取消订单' })
            },
            oneMoreOrder: (): void => {
               // 再来一单跳转
               promptAction.showToast({ message: '再来一单跳转' })
            },
            callTelCb: (): void => {
               // 展示拨号弹窗
               promptAction.showToast({ message: '展示拨号弹窗' })
            },
             contactRider: (): void => {
               // 联系骑手
               promptAction.showToast({ message: '联系骑手' })
            },
            goNavigation: (): void => {
               // 跳转地图导航
               promptAction.showToast({ message: '跳转地图导航' })
            },
         })
      }
      .height('100%')
      .width('100%')
      .backgroundColor($r('sys.color.background_secondary'))
   }
}
```

## 更新记录

### 1.0.2 (2026-02-13)

Created with Pixso.

下载该版本修改 readme

### 1.0.1 (2025-11-03)

Created with Pixso.

下载该版本 README 修改

### 1.0.0 (2025-08-30)

Created with Pixso.

下载该版本初始版本

## 权限与隐私

### 基本信息

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 权限说明 |
| 使用目的 | ohos.permission.APPROXIMATELY_LOCATION 允许应用获取设备模糊位置信息允许应用获取设备模糊位置信息 |
| ohos.permission.LOCATION | 允许应用获取设备位置信息允许应用获取设备位置信息 |
| ohos.permission.INTERNET | 允许使用 Internet 网络允许使用 Internet 网络 |

### 隐私政策

不涉及 SDK 合规使用指南 不涉及

### 兼容性

| HarmonyOS 版本 | 内容 |
| :--- | :--- |
| 6.0.1 | Created with Pixso. |
| 6.0.2 | Created with Pixso. |

### 应用类型

| 应用类型 | 内容 |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

### 设备类型

| 设备类型 | 内容 |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

### DevEcoStudio 版本

| DevEcoStudio 版本 | 内容 |
| :--- | :--- |
| DevEco Studio 6.0.1 | Created with Pixso. |
| DevEco Studio 6.0.2 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/e079f0b60d4d43c2aa9e755d0117901c/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%AE%A2%E5%8D%95%E8%AF%A6%E6%83%85%E7%BB%84%E4%BB%B6/order_detail1.0.2.zip