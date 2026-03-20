# 账单卡片组件

## 简介

本组件提供了 BillCard、BillSummaryCard、BillDetail 三种形式的卡片。

## 详细介绍

简介
本组件提供了以下三种形式的卡片：

BillCard 提供了根据传入数据，展示固定日期账单列表的能力，支持配置卡片各项字号字色等属性，支持配置是否展示当日概况、是否展示侧滑按钮，支持传入回调处理账单条目的点击、删除事件。

BillSummaryCard 提供了根据传入数据，展示总支出和总收入的能力，支持自定义标题和内容的字号字色。

BillDetail 提供了根据传入数据，展示账单详情卡片的能力。支持设置金额、内容的字号字色，支持设置卡片的背景颜色，支持传入回调处理账单的编辑、删除事件。

BillCard BillSummaryCard BillDetail

## 约束与限制

### 环境

*   DevEco Studio 版本：DevEco Studio 5.0.2 Release 及以上
*   HarmonyOS SDK 版本：HarmonyOS 5.0.2 Release SDK 及以上
*   设备类型：华为手机（包括双折叠和阔折叠）
*   系统版本：HarmonyOS 5.0.2(14) 及以上

## 快速入门

安装组件。

*   如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
*   如果是从生态市场下载组件，请参考以下步骤安装组件。
    *   a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
    *   b. 在项目根目录 build-profile.json5 添加 bill_base 和 bill_card 模块。

深色代码主题复制
```json5
// 在项目根目录 build-profile.json5 填写 bill_base 和 bill_card 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "bill_base",
    "srcPath": "./XXX/bill_base",
  },
  {
    "name": "bill_card",
    "srcPath": "./XXX/bill_card",
  }
]
```

在根目录 oh-package.json5 中添加依赖。

深色代码主题复制
```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "bill_card": "file:./XXX/bill_card",
  "bill_base": "file:./XXX/bill_base"
}
```

使用 BillCard 组件。

*   a. 引入组件句柄。
    深色代码主题复制
    ```typescript
    import { BillCard } from 'bill_card';
    ```
*   b. 调用组件，详见示例 1。

使用 BillSummaryCard 组件。

*   a. 引入组件句柄
    深色代码主题复制
    ```typescript
    import { BillSummaryCard } from 'bill_card';
    ```
*   b. 调用组件，详见示例 2。

使用 BillDetail 组件。

*   a. 引入组件句柄。
    深色代码主题复制
    ```typescript
    import { BillDetail } from 'bill_card';
    ```
*   b. 调用组件，详见示例 3。

## API 参考

### 接口

#### BillCard(BillCardOption?:BillCardOptions)

账单卡片组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | BillCardOptions | 否 | 配置资产卡片组件的参数。 |

#### BillSummaryCard(BillSummaryCardOptions?:BillSummaryCardOptions)

账单概况组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | BillSummaryCardOptions | 否 | 配置资产卡片组件的参数。 |

#### BillDetail(BillDetailOption?:BillDetailOptions)

账单概况组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | BillDetailOptions | 否 | 配置资产卡片组件的参数。 |

### BillCardOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| cardDailyBillGroupModel | DailyBillGroupModel | 否 | 每日账单分组模型，默认为 new DailyBillGroupModel() |
| cardBgColor | ResourceColor | 否 | 卡片背景颜色，默认值为 #ffffff |
| showSummary | boolean | 否 | 是否显示总计，默认值为 true |
| headerFontSize | Length | 否 | 标题字体大小，默认值为 12 |
| headerFontColor | ResourceColor | 否 | 标题字体颜色，默认值为 #E6000000 |
| deleteButtonFontSize | Length | 否 | 删除按钮字体大小，默认值为 14 |
| deleteButtonFontColor | ResourceColor | 否 | 删除按钮字体颜色，默认值为 #ffffff |
| deleteButtonBgColor | ResourceColor | 否 | 删除按钮背景颜色，默认值为 #E84026 |
| emptyNoteSize | Length | 否 | 空提示字体大小，默认值为 14 |
| emptyNoteColor | ResourceColor | 否 | 空提示字体颜色，默认值为 #99000000 |
| dividerColor | ResourceColor | 否 | 分割线颜色，默认值为 ##C4C4C4 |
| showOperation | boolean | 否 | 是否显示操作按钮，默认值为 true |
| handleDelete(id: number) => void | Function | 否 | 删除按钮点击事件，触发时会传入资产 ID |
| handleClickItem(id: BillCardItem) => void | Function | 否 | 点击卡片项事件，触发时会传入卡片项数 |

### BillSummaryCardOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| totalExpense | string | 否 | 总支出，默认值为 '0.00' |
| totalIncome | string | 否 | 总收入，默认值为 '0.00' |
| titleFontSize | Length | 否 | 标题字体大小，默认值为 12 |
| titleFontColor | ResourceColor | 否 | 标题字体颜色，默认值为 #99000000 |
| contentFontSize | Length | 否 | 内容字体大小，默认值为 18 |
| contentFontColor | ResourceColor | 否 | 内容字体颜色，默认值为 #E6000000 |

### BillDetailOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| bill | BillCardItem | 是 | 账单详情数据，必填字段 |
| amountFontColor | ResourceColor | 否 | 标题字体颜色，默认值为 #E6000000 |
| amountFontSize | Length | 否 | 金额字体大小，默认值为 24 |
| contentFontSize | Length | 否 | 内容字体大小，默认值为 14 |
| contentFontColor | ResourceColor | 否 | 内容字体颜色，默认值为 #E6000000 |
| bgColor | ResourceColor | 否 | 背景颜色，默认值为 #ffffff |
| handleDelete() => void | Function | 否 | 删除按钮点击事件处理函数 |
| handleEdit() => void | Function | 否 | 编辑按钮点击事件处理函数 |

### DailyBillGroupModel 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| dateStr | string | 否 | 日期字符串，默认值为空字符串 "" |
| list | BillCardItem[] | 否 | 账单项列表，默认值为空数组 [] |

### BillCardItem 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| accountId | number | 是 | 账户 ID |
| date | string | 是 | 交易日期 |
| transactionId | number | 是 | 交易 ID |
| resource | number | 是 | 资源 ID |
| iconResourceStr | string | 是 | 图标资源字符串 |
| title | string | 是 | 交易标题 |
| note | string | 否 | 交易备注（可选） |
| amount | number | 是 | 交易金额 |
| type | BalanceChangeType | 是 | 余额变化类型（收入/支出） |
| assetId | number | 否 | 资产 ID（可选） |
| assetName | string | 否 | 资产名称（可选） |

### BalanceChangeType 枚举说明

| 名称 | 值 | 说明 |
| :--- | :--- | :--- |
| EXPENSE | 'expense' | 支出 |
| INCOME | 'income' | 收入 |

## 示例代码

### 示例 1（账单卡片数据刷新，点击、删除事件的使用）

深色代码主题复制
```typescript
import { BalanceChangeType, BillCardItem, DailyBillGroupModel } from 'bill_base';
import { BillCard } from 'bill_card';

@Entry
@ComponentV2
struct BillCardExample2 {
 @Local model: DailyBillGroupModel = new DailyBillGroupModel();

 aboutToAppear(): void {
   this.model.dateStr = '2025-05-30';
 }

 build() {
   Column({ space: 16 }) {
     Button('添加账单')
       .onClick(() => {
         const newItem: BillCardItem = {
           accountId: 1,
           date: '2025-05-30',
           transactionId: new Date().getTime(),
           resource: 100,
           icon: $r('app.media.ic_expense_0'), // 图片需自行替换
           title: '餐饮',
           note: '黄焖鸡',
           amount: 30,
           type: BalanceChangeType.EXPENSE,
         };
         this.model.list.push(newItem);
       });

     BillCard({
       card: this.model,
       handleDelete: (id) => {
         const idx = this.model.list.findIndex((item) => item.transactionId === id);
         if (idx) {
           this.model.list.splice(idx, 1);
         }
       },
     });
   }
   .padding(16)
   .backgroundColor('#eee');
 };
}
```

### 示例 2（账单概况与账单卡片联合使用）

深色代码主题复制
```typescript
import { BalanceChangeType, BillCardItem, DailyBillGroupModel } from 'bill_base';
import { BillCard, BillSummaryCard } from 'bill_card';

@Entry
@ComponentV2
struct BillSummaryCardExample1 {
 @Local model: DailyBillGroupModel = new DailyBillGroupModel();

 @Computed
 get totalExpense() {
   return this.model.list.reduce((pre, cur) => pre + cur.amount, 0).toFixed(2);
 }

 aboutToAppear(): void {
   this.model.dateStr = '2025-05-30';
 }

 build() {
   Column({ space: 16 }) {
     Button('添加账单')
       .onClick(() => {
         const newItem: BillCardItem = {
           accountId: 1,
           date: '2025-05-30',
           transactionId: new Date().getTime(),
           resource: 100,
           icon: $r('app.media.ic_expense_0'),
           title: '餐饮',
           note: '黄焖鸡',
           amount: 30,
           type: BalanceChangeType.EXPENSE,
         };
         this.model.list.push(newItem);
       });

     BillSummaryCard({
       totalExpense: this.totalExpense,
     });

     BillCard({
       card: this.model,
       handleDelete: (id) => {
         const idx = this.model.list.findIndex((item) => item.transactionId === id);
         if (idx) {
           this.model.list.splice(idx, 1);
         }
       },
     });
   }
   .padding(16)
   .backgroundColor('#eee');
 };
}
```

### 示例 3（账单详情展示与编辑、删除事件使用）

深色代码主题复制
```typescript
import { BalanceChangeType, BillCardItem } from 'bill_base';
import { BillDetail } from 'bill_card';
import { promptAction } from '@kit.ArkUI';

const MOCK_BILL_ITEM: BillCardItem =
 {
   accountId: 1,
   date: '2025-05-15',
   transactionId: 1,
   resource: 100,
   icon: $r('app.media.ic_expense_0'),
   title: '餐饮',
   note: '黄焖鸡',
   amount: 30,
   type: BalanceChangeType.EXPENSE,
   assetName: '支付宝',
 };

@Entry
@ComponentV2
struct BillDetailExample1 {
 @Local bill: BillCardItem = MOCK_BILL_ITEM;

 build() {
   Column() {
     // 账单卡片
     BillDetail({
       bill: this.bill,
       amountFontColor: Color.Pink,
       handleEdit: () => {
         promptAction.showToast({
           message: '触发了账单的编辑事件，随机生成一个金额',
           alignment: Alignment.Top,
         });
         const newBill = JSON.parse(JSON.stringify(MOCK_BILL_ITEM)) as BillCardItem;
         newBill.amount = (Math.random() * 100);
         this.bill = newBill;
       },
       handleDelete: () => {
         promptAction.showToast({ message: '触发了账单的删除事件', alignment: Alignment.Top });
       },
     });
   }
   .padding(16)
   .backgroundColor('#eee');
 };
}
```

## 更新记录

### 1.0.1 (2025-12-12)

Created with Pixso.

下载该版本 README

### 1.0.0 (2025-11-03)

Created with Pixso.

下载该版本初始版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

### HarmonyOS 版本

*   5.0.2
    Created with Pixso.
*   5.0.3
    Created with Pixso.
*   5.0.4
    Created with Pixso.
*   5.0.5
    Created with Pixso.
*   5.1.0
    Created with Pixso.
*   5.1.1
    Created with Pixso.
*   6.0.0
    Created with Pixso.
*   6.0.1
    Created with Pixso.

### 应用类型

*   应用
    Created with Pixso.
*   元服务
    Created with Pixso.

### 设备类型

*   手机
    Created with Pixso.
*   平板
    Created with Pixso.
*   PC
    Created with Pixso.

### DevEcoStudio 版本

*   DevEco Studio 5.0.2
    Created with Pixso.
*   DevEco Studio 5.0.3
    Created with Pixso.
*   DevEco Studio 5.0.4
    Created with Pixso.
*   DevEco Studio 5.0.5
    Created with Pixso.
*   DevEco Studio 5.1.0
    Created with Pixso.
*   DevEco Studio 5.1.1
    Created with Pixso.
*   DevEco Studio 6.0.0
    Created with Pixso.
*   DevEco Studio 6.0.1
    Created with Pixso.

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/218482b979c34fffb8fa4c621869aeae/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%B4%A6%E5%8D%95%E5%8D%A1%E7%89%87%E7%BB%84%E4%BB%B6/bill_card1.0.1.zip