# 停车优惠券组件

## 简介

本组件支持停车优惠券的管理和选择。

## 详细介绍

### 简介

本组件支持停车优惠券的管理和选择。

### 优惠券管理

### 优惠券选择

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

### 快速入门

#### 安装组件

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `module_coupon` 模块。

深色代码主题复制
// 项目根目录下 build-profile.json5 填写 module_coupon 路径。其中 XXX 为组件存放的目录名
```json5
"modules": [
  {
    "name": "module_coupon",
    "srcPath": "./XXX/module_coupon"
  }
]
```

c. 在项目根目录 `oh-package.json5` 添加依赖。

深色代码主题复制
// XXX 为组件存放的目录名称
```json5
"dependencies": {
  "module_coupon": "file:./XXX/module_coupon"
}
```

#### 引入组件

深色代码主题复制
```typescript
import { MyCoupons, SelectCoupons, GlobalCouponUtils } from 'module_coupon';
```

#### 调用组件

调用组件，详细参数配置说明参见 API 参考。

## API 参考

### 接口

#### MyCoupons(option?: MyCouponsOptions)

停车优惠券列表

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | MyCouponsOptions | 否 | 配置停车优惠券列表的参数。 |

**MyCouponsOptions 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| clickUseNow() => void | - | 否 | 点击立即使用的回调 |

#### SelectCoupons(option?: SelectCouponsOptions)

选择停车优惠券

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | SelectCouponsOptions | 否 | 配置选择停车优惠券的参数。 |

**SelectCouponsOptions 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| selectIdParam | string | 否 | 传入的优惠券 id |
| onSelect(id: string, money: number) => void | - | 否 | 选择优惠券的回调 |

#### GlobalCouponUtils

优惠券对外方法

**constructor**

`constructor()`

GlobalCouponUtils 的构造函数。

**consumeCoupon**

`consumeCoupon(couponID: string): void`

消费优惠券

### 示例代码

#### 示例 1（管理优惠券）

深色代码主题复制
```typescript
import { MyCoupons } from 'module_coupon';

@Entry
@ComponentV2
struct Sample1 {
  build() {
    NavDestination() {
      Column() {
        MyCoupons({
          clickUseNow: () => {
            this.getUIContext().getPromptAction().showToast({ message: '点击了立即使用' });
          },
        })
      }
      .width('100%')
    }
    .height('100%')
    .width('100%')
    .title('我的券包')
  }
}
```

#### 示例 2（选择优惠券）

深色代码主题复制
```typescript
import { SelectCoupons } from 'module_coupon';

@Entry
@ComponentV2
struct Sample2 {
  @Local selectedCouponID: string = '';
  @Local selectedCouponMoney: number = 0;
  @Local showCouponSheet: boolean = false;

  @Builder
  selectCouponBuilder() {
    Column() {
      SelectCoupons({
        selectIdParam: this.selectedCouponID,
        onSelect: (id: string, money: number) => {
          this.selectedCouponID = id;
          this.selectedCouponMoney = money;
          this.showCouponSheet = false;
        },
      })
    }
    .padding(10)
  }

  build() {
    NavDestination() {
      Column({ space: 20 }) {
        Text(`选择的优惠券 ID：  ${this.selectedCouponID}`)
        Text(`选择的优惠券面额： ${this.selectedCouponMoney}`)
        Button('选择')
          .width('100%')
          .onClick(() => {
            this.showCouponSheet = true;
          })
          .bindSheet($$this.showCouponSheet, this.selectCouponBuilder(), {
            height: SheetSize.MEDIUM,
            preferType: SheetType.CENTER,
            title: {
              title: '选择优惠券',
            },
          })
      }
      .padding(12)
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .height('100%')
    .width('100%')
    .title('选择优惠券')
  }
}
```

## 更新记录

| 版本 | 日期 | 描述 |
| :--- | :--- | :--- |
| 1.0.2 | 2026-01-06 | 下载该版本废弃 API 整改。Created with Pixso. |
| 1.0.1 | 2025-10-31 | 下载该版本优化 README。Created with Pixso. |
| 1.0.0 | 2025-08-30 | 下载该版本本组件支持优惠券的管理和选择。Created with Pixso. |

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### SDK 合规使用指南

不涉及

## 兼容性

| 项目 | 值 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 Created with Pixso. |
| | 5.0.1 Created with Pixso. |
| | 5.0.2 Created with Pixso. |
| | 5.0.3 Created with Pixso. |
| | 5.0.4 Created with Pixso. |
| | 5.0.5 Created with Pixso. |
| | 5.1.0 Created with Pixso. |
| | 5.1.1 Created with Pixso. |
| | 6.0.0 Created with Pixso. |
| 应用类型 | 应用 Created with Pixso. |
| | 元服务 Created with Pixso. |
| 设备类型 | 手机 Created with Pixso. |
| | 平板 Created with Pixso. |
| | PC Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 Created with Pixso. |
| | DevEco Studio 5.0.1 Created with Pixso. |
| | DevEco Studio 5.0.2 Created with Pixso. |
| | DevEco Studio 5.0.3 Created with Pixso. |
| | DevEco Studio 5.0.4 Created with Pixso. |
| | DevEco Studio 5.0.5 Created with Pixso. |
| | DevEco Studio 5.1.0 Created with Pixso. |
| | DevEco Studio 5.1.1 Created with Pixso. |
| | DevEco Studio 6.0.0 Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/e3dee9df82e044199cc6e6c4b824d9b3/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%81%9C%E8%BD%A6%E4%BC%98%E6%83%A0%E5%88%B8%E7%BB%84%E4%BB%B6/module_coupon1.0.2.zip