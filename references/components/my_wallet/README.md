# 钱包组件

## 简介

本组件提供了钱包充值和查看充值记录的功能，可以使用华为支付充值钱包并查看充值记录。

## 详细介绍

### 简介

本组件提供了钱包充值和查看充值记录的功能，可以使用华为支付充值钱包并查看充值记录。

### 钱包充值充值记录

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

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
b. 在项目根目录 `build-profile.json5` 并添加 `my_wallet` 模块。

```json5
// 在项目根目录的 build-profile.json5 填写 my_wallet 路径。其中 xxx 为组件存在的目录名
"modules": [
  {
    "name": "my_wallet",
    "srcPath": "./xxx/my_wallet",
  }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// xxx 为组件存放的目录名称
"dependencies": {
  "my_wallet": "file:./xxx/my_wallet"
}
```

#### 引入组件

```typescript
import { MyWallet, RechargeRecordComp } from 'my_wallet';
```

#### 调用组件

调用组件，详细参数配置说明参见 API 参考。

```typescript
// 钱包充值页面
MyWallet({
  wallet: this.userInfoModel.userInfo.wallet,
  rechargeTierList: this.rechargeTierList,
  selectTier: this.selectTier,
  goRechargeCb: (): void => RouterModule.push(RouterMap.RECHARGE_RECORD_PAGE),
  changeSelectCb: (selectTier: RechargeTier) => {
    // 切换充值金额档次
  },
  goWalletTermsCb: () => {
    // 跳转协议页面
  },
  goPayCb: () => {
    // 去付款
  },
})
// 账单明细
RechargeRecordComp({ rechargeRecordList: this.rechargeRecordList })
```

### API 参考

#### 接口

**MyWallet(options?: MyWalletOptions)**
钱包充值组件。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | MyWalletOptions | 是 | 钱包充值的参数。 |

**RechargeRecordComp(options?: RechargeRecordCompOptions)**
账单明细组件。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | RechargeRecordCompOptions | 是 | 账单明细的参数。 |

**MyWalletOptions 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| wallet | number | 是 | 钱包金额 |
| rechargeTierList | RechargeTier[] | 是 | 充值档次列表 |
| selectTier | RechargeTier | 否 | 已选充值档次 |

**RechargeRecordCompOptions 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| rechargeRecordList | RechargeRecord[] | 是 | 账单明细列表 |

**RechargeTier 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 充值档次序号 |
| name | string | 是 | 充值档次名称 |
| payMoney | number | 是 | 付款金额 |
| realMoney | number | 是 | 充值金额 |
| desc | string | 是 | 充值档次描述 |
| type | number | 是 | 充值档次类型 |

**RechargeRecord 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 充值档次序号 |
| recordType | number | 是 | 金额变动类型 1：充值 2：消费 |
| rechargeMoney | number | 是 | 充值金额 |
| balance | number | 是 | 当前余额 |
| time | number | 是 | 充值时间 |

#### 事件

支持以下事件：

- **goRechargeCb**
  `goRechargeCb(callback: () => void)`
  跳转账单明细页面
- **changeSelectCb**
  `changeSelectCb(callback: (selectTier: RechargeTier) => void)`
  切换充值金额档次
- **goWalletTermsCb**
  `goWalletTermsCb(callback: () => void)`
  跳转协议页面
- **goPayCb**
  `goPayCb(callback: () => void)`
  去付款

### 示例代码

#### 示例 1（钱包充值）

本示例展示钱包充值页面。

```typescript
import { MyWallet, RechargeTier } from 'my_wallet';

@Entry
@ComponentV2
struct Index {
   @Local rechargeTierList: Array<RechargeTier> = [];
   @Local selectTier: RechargeTier = new RechargeTier()

   aboutToAppear(): void {
      this.rechargeTierList = [{
         id: '1',
         name: '满 100 减 10',
         payMoney: 90,
         realMoney: 100,
         desc: '满 100 减 10',
         type: 1,
      }, {
         id: '2',
         name: '满 200 减 50',
         payMoney: 150,
         realMoney: 200,
         desc: '满 200 减 50',
         type: 1,
      }, {
         id: '3',
         name: '满 300 减 80',
         payMoney: 220,
         realMoney: 300,
         desc: '满 300 减 80',
         type: 1,
      }, {
         id: '4',
         name: '满 500 减 100',
         payMoney: 400,
         realMoney: 500,
         desc: '满 500 减 100',
         type: 1,
      }]
   }

   build() {
      Column({ space: 20 }) {
         MyWallet({
            wallet: 200,
            rechargeTierList: this.rechargeTierList,
            selectTier: this.selectTier,
            goRechargeCb: (): void => {
               this.getUIContext().getPromptAction().showToast({ message: '跳转账单明细页面' })
            },
            changeSelectCb: (selectTier: RechargeTier) => {
               this.selectTier = selectTier
            },
            goWalletTermsCb: () => {
               this.getUIContext().getPromptAction().showToast({ message: '跳转协议页面' })
            },
            goPayCb: () => {
               this.getUIContext().getPromptAction().showToast({ message: '去支付' })
            },
         })
      }
      .height('100%')
      .width('100%')
      .padding(16)
      .backgroundColor($r('sys.color.background_secondary'))
   }
}
```

#### 示例 2（账单明细）

本示例展示钱包钱包页面。

```typescript
import { RechargeRecord, RechargeRecordComp, RechargeTier } from 'my_wallet';

@Entry
@ComponentV2
struct Index {
   @Local rechargeRecordList: Array<RechargeRecord> = [];
   @Local selectTier: RechargeTier = new RechargeTier()

   aboutToAppear(): void {
      for (let index = 0; index < 10; index++) {
         let record: RechargeRecord = {
            id: `${index}`,
            recordType: index % 2 + 1,
            rechargeMoney: index * 100,
            balance: index * 100,
            time: new Date().getTime(),
         }
         this.rechargeRecordList.push(record)
      }
   }
   
   build() {
      Column({ space: 20 }) {
         RechargeRecordComp({ rechargeRecordList: this.rechargeRecordList })
            .height('100%')
            .width('100%')
            .padding(16)
            .backgroundColor($r('sys.color.background_secondary'))
      }
      .padding({ top: 45 })
   }
}
```

### 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.2 | 2026-01-13 | 下载该版本<br>组件示例适配元服务胶囊模拟器充值功能优化补充消费记录 |
| 1.0.0 | 2025-09-10 | 下载该版本<br>初始版本 |

### 基本信息

#### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

#### 隐私政策

不涉及

#### SDK 合规使用指南

不涉及

#### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用、元服务 |
| **设备类型** | 手机、平板、PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/1bcfcd287a7e4fcdaa981f3d2c885b6b/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%92%B1%E5%8C%85%E7%BB%84%E4%BB%B6/my_wallet1.0.2.zip