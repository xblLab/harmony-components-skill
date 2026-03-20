# 账单管理组件

## 简介

本组件提供 BillManageSheet 和 ResourceManageSheet 两个账单管理页面。

## 详细介绍

### 简介

本组件提供以下两个账单管理页面：

- **BillManageSheet**：用于管理账单信息，支持初始化账单数据、处理确认操作和资源管理操作。
- **ResourceManageSheet**：用于管理账单来源分类的组件，支持处理弹出操作以及删除操作的成功回调。

BillManageSheet ResourceManageSheet

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.2 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.2 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.2(14) 及以上

### 快速入门

安装组件。

> 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `bill_base` 和 `bill_manage` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 bill_base 和 bill_manage 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "bill_base",
    "srcPath": "./XXX/bill_base"
  },
  {
    "name": "bill_manage",
    "srcPath": "./XXX/bill_manage"
  }
]
```

3. 在根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "bill_manage": "file:./XXX/bill_manage",
  "bill_base": "file:./XXX/bill_base"
}
```

4. 使用 BillManageSheet 组件。
    a. 引入组件句柄。

```typescript
import { BillManageSheet, billManageSheetBuilder } from 'bill_manage';
```

    b. 调用组件，详见 [示例 1](#示例 1（新增、编辑账单）)。

5. 使用 ResourceManageSheet 组件。
    a. 引入组件句柄。

```typescript
import { ResourceManageSheet, resourceManageSheetBuilder } from 'bill_manage';
```

    b. 调用组件，详见 [示例 2](#示例 2（新增账单来源分类，删除分类）)。

## API 参考

### 接口

#### BillManageSheet(option?: BillManageSheetOptions)

创建、编辑账单组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| option | BillManageSheetOptions | 否 | 配置创建、编辑账单组件的参数。 |

#### ResourceManageSheet(option?: ResourceManageSheetOptions)

创建、编辑来源分类组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| option | ResourceManageSheetOptions | 否 | 配置创建、编辑来源分类组件的参数。 |

### BillManageSheetOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| initBill | BillManageModel \| undefined | 否 | 初始化账单数据，用于展示或编辑现有账单。 |
| handleConfirm(data: BillManageModel) => void | 函数 | 否 | 确认操作事件回调函数，接收用户交易数据 data。 |
| handleResourceManage() => void | 函数 | 否 | 资源管理操作事件回调函数，用于处理资源管理逻辑。 |

### ResourceManageSheetOptions 对象说明

| 名称 | 类型 | 说明 |
| :--- | :--- | :--- |
| handleAddSuccess() => void | 函数 | 处理弹出操作的事件回调函数。 |
| handleDeleteSuccess(key: number) => void | 函数 | 处理删除操作成功时的事件回调函数，接收被删除项的唯一标识 key。 |

### BillManageModel 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| accountId | number | 是 | 账户 ID，标识当前账单所属的账户。 |
| type | BalanceChangeType | 是 | 交易类型，表示账单的类型（如收入或支出）。 |
| transactionId | number \| undefined | 否 | 交易 ID，用于标识具体的交易记录，可选。 |
| resource | number | 是 | 资源 ID，表示账单相关的资源信息。 |
| amount | number | 是 | 交易金额，表示账单的金额。 |
| date | string | 是 | 交易日期，格式为 yyyy-mm-dd。 |
| note | string \| undefined | 否 | 备注信息，用于记录账单的额外说明，可选。 |
| assetId | number \| undefined | 否 | 资产 ID，表示账单相关的资产信息，可选。 |

### BalanceChangeType 枚举说明

| 名称 | 值 | 说明 |
| :--- | :--- | :--- |
| EXPENSE | 'expense' | 支出 |
| INCOME | 'income' | 收入 |

## 示例代码

### 示例 1（新增、编辑账单）

```typescript
import { BillManageModel, billManageSheetBuilder } from 'bill_manage';
import { promptAction } from '@kit.ArkUI';

@Entry
@ComponentV2
struct BillManageSheetExample1 {
  @Local showSheet: boolean = false;
  @Local bill: BillManageModel | undefined = undefined;

  build() {
    Column({ space: 24 }) {
      Row() {
        Button(this.bill ? '编辑账单' : '创建账单')
          .onClick(() => {
            this.showSheet = !this.showSheet;
          });
        if (this.bill) {
          Button('删除账单')
            .onClick(() => {
              this.bill = undefined;
              promptAction.showToast({ message: '删除账单成功！' });
            });
        }
      };

      if (this.bill) {
        Column() {
          Text('账单');
          Text('日期：' + this.bill.date);
          Text('来源：' + this.bill.resource);
          Text('金额：' + this.bill.amount);
        }
        .alignItems(HorizontalAlign.Start);
      }
    }
    .bindSheet($$this.showSheet,
      billManageSheetBuilder({
        initBill: this.bill,
        handleConfirm: (data) => {
          this.bill = data;
          this.showSheet = false;
        },
        handleResourceManage: () => {
          promptAction.showToast({ message: '详见 ResourceManageSheet 组件' });
        },
      }), {
        title: { title: '选择资产类型' },
        detents: [SheetSize.FIT_CONTENT],
        preferType: SheetType.BOTTOM,
      });
  }
}
```

### 示例 2（新增账单来源分类，删除分类）

```typescript
import { promptAction } from '@kit.ArkUI';
import { BillManageModel, billManageSheetBuilder, resourceManageSheetBuilder } from 'bill_manage';
import { ResourceUtil } from 'bill_base';

@Entry
@ComponentV2
struct ResourceManageSheetExample1 {
  @Local showSheet: boolean = false;
  @Local showResourceSheet: boolean = false;
  @Local bill: BillManageModel | undefined = undefined;

  @Computed
  get resourceName() {
    if (!this.bill) {
      return '';
    }
    const item = ResourceUtil.getResourceItem(this.bill.resource);
    return item.name ?? '';
  }

  build() {
    Column({ space: 24 }) {
      Row() {
        Button(this.bill ? '编辑账单' : '创建账单')
          .onClick(() => {
            this.showSheet = !this.showSheet;
          });
        if (this.bill) {
          Button('删除账单')
            .onClick(() => {
              this.bill = undefined;
              promptAction.showToast({ message: '删除账单成功！' });
            });
        }
      };

      if (this.bill) {
        Column() {
          Text('账单');
          Text('日期：' + this.bill.date);
          Text('来源：' + this.resourceName);
          Text('金额：' + this.bill.amount);
        }
        .alignItems(HorizontalAlign.Start);
      }
      Column()
        .bindSheet($$this.showResourceSheet,
          resourceManageSheetBuilder({
            handleDeleteSuccess: (key) => {
              if (this.bill?.resource === key) {
                this.bill = undefined;
              }
            },
          }),
          {
            title: { title: '分类管理' },
            detents: [SheetSize.FIT_CONTENT],
            backgroundColor: '#fff',
          },
        );
    }
    .bindSheet($$this.showSheet,
      billManageSheetBuilder({
        initBill: this.bill,
        handleConfirm: (data) => {
          this.bill = data;
          this.showSheet = false;
        },
        handleResourceManage: () => {
          this.showResourceSheet = true;
        },
      }), {
        title: { title: '选择资产类型' },
        detents: [SheetSize.FIT_CONTENT],
      });
  }
}
```

## 更新记录

### 1.0.2 (2025-12-15)

Created with Pixso.

[下载该版本更新 README](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%B4%A6%E5%8D%95%E7%AE%A1%E7%90%86%E7%BB%84%E4%BB%B6/bill_manage1.0.2.zip)

### 1.0.1 (2025-08-29)

Created with Pixso.

[下载该版本 README](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%B4%A6%E5%8D%95%E7%AE%A1%E7%90%86%E7%BB%84%E4%BB%B6/bill_manage1.0.2.zip)

### 1.0.0 (2025-07-14)

Created with Pixso.

[下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%B4%A6%E5%8D%95%E7%AE%A1%E7%90%86%E7%BB%84%E4%BB%B6/bill_manage1.0.2.zip)

BillManageSheet 组件用于管理账单信息，支持初始化账单数据、处理确认操作和资源管理操作。
ResourceManageSheet 是一个用于管理账单来源分类的组件，支持处理弹出操作以及删除操作的成功回调。

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

| 版本 | 状态 |
| :--- | :--- |
| 5.0.2 | Created with Pixso. |
| 5.0.3 | Created with Pixso. |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |
| 5.1.0 | Created with Pixso. |
| 5.1.1 | Created with Pixso. |
| 6.0.0 | Created with Pixso. |
| 6.0.1 | Created with Pixso. |

### 应用类型

| 类型 | 状态 |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

### 设备类型

| 类型 | 状态 |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

### DevEcoStudio 版本

| 版本 | 状态 |
| :--- | :--- |
| DevEco Studio 5.0.2 | Created with Pixso. |
| DevEco Studio 5.0.3 | Created with Pixso. |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/fb4020d8e0e1494390e845dc559e0a31/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%B4%A6%E5%8D%95%E7%AE%A1%E7%90%86%E7%BB%84%E4%BB%B6/bill_manage1.0.2.zip