# 资产管理组件

## 简介

本组件提供了 AssetCreateSheet 和 AssetInfoManageSheet 两个资产管理页面。

## 详细介绍

### 简介

本组件提供了以下两个资产管理页面：

**AssetCreateSheet** 支持选择资产类型或新增自定义类型以创建资产数据。开发者可以选择使用组件 AssetCreateSheet 直接嵌入页面，或使用 Builder 方法 assetCreateSheetBuilder 拉起半模态框使用。

**AssetInfoManageSheet** 提供资产信息展示和编辑的能力，根据是否传入初始资产数据，支持资产的创建、编辑和删除操作。它接收资产类型数据、初始资产数据，并通过表单收集和处理资产信息。

AssetCreateSheet AssetInfoManageSheet

## 约束与限制

### 环境

- **DevEco Studio 版本：** DevEco Studio 5.0.2 Release 及以上
- **HarmonyOS SDK 版本：** HarmonyOS 5.0.2 Release SDK 及以上
- **设备类型：** 华为手机（包括双折叠和阔折叠）
- **系统版本：** HarmonyOS 5.0.2(14) 及以上

## 快速入门

### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `asset_base` 和 `asset_manage` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 asset_base 和 asset_manage 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "asset_base",
    "srcPath": "./XXX/asset_base",
  },
  {
    "name": "asset_manage",
    "srcPath": "./XXX/asset_manage",
  }
]
```

3. 在根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "asset_manage": "file:./XXX/asset_manage",
  "asset_base": "file:./XXX/asset_base"
}
```

### 使用组件

#### 使用 AssetCreateSheet 组件

1. 引入组件句柄。

```arkts
import { AssetCreateSheet, assetCreateSheetBuilder } from 'asset_manage';
```

2. 调用组件，详见示例 1。

#### 使用 AssetInfoManageSheet 组件

1. 引入组件句柄。

```arkts
import { AssetInfoManageSheet, assetInfoManageSheetBuilder } from 'asset_manage';
```

2. 调用组件，详见示例 2。

## API 参考

### 接口

#### AssetCreateSheet(option?: AssetCreateSheetOptions)

创建资产组件。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | AssetCreateSheetOptions | 否 | 配置创建资产组件的参数。 |

#### AssetInfoManageSheet(option?: AssetInfoManageSheetOptions)

资产编辑组件。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | AssetInfoManageSheetOptions | 否 | 编辑资产信息组件的参数。 |

### 对象说明

#### AssetCreateSheetOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| bgColor | ResourceColor | 否 | 背景色，默认为 #ffffff |
| assetTypeList | AssetDisplayTypeItem[] | 否 | 资产类型显示数据数组，默认值为空数组 [] |
| handleClick(type: AssetType, subType?: number) => void | Function | 否 | 点击事件回调函数，接收资产类型 type 和可选的子类型 subType |

#### AssetInfoManageSheetOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| assetTypeItem | AssetDisplayTypeItem \| undefined | 否 | 资产类型显示数据，用于展示资产类型信息（如图标、名称等）。 |
| type | AssetType | 否 | 资产的主类型，默认值为 AssetType.FUND（资金账户）。 |
| initAsset | AssetRecordItemModel \| undefined | 否 | 初始资产数据，用于编辑场景。 |
| handleConfirm(data: AssetRecordItemModel) => void | Function | 否 | 表单提交事件回调函数，接收表单数据 data。 |
| handleEditSuccess() => void | Function | 否 | 编辑成功事件回调函数。 |
| handleDelete(id: number) => void | Function | 否 | 删除资产事件回调函数，接收资产的唯一标识 id。 |

#### AssetRecordItemModel 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| assetId | number | 是 | 资产的唯一标识符。 |
| name | string | 是 | 资产的名称。 |
| icon | ResourceStr | 是 | 资产的图标资源路径或标识符。 |
| type | AssetType | 是 | 资产的主类型，如 AssetType.FUND（资金账户）。 |
| subType | number | 是 | 资产的子类型，用于进一步细分资产类型。 |
| category | AssetCategory | 是 | 资产的类别，如 AssetCategory.ASSET（资产）。 |
| note | string | 否 | 资产的备注信息，可选。 |
| amount | number | 是 | 资产的金额或数量。 |
| isCustom | boolean | 否 | 表示资产是否为自定义资产，可选。 |

#### AssetDisplayTypeItem 接口说明

用于描述资产类型在界面上的显示信息。

| 字段名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| name | string | 是 | 资产类型的名称，例如 "股票"、"基金" 等。 |
| iconResourceStr | string | 是 | 资产类型的图标资源路径或标识符，用于在界面上显示图标 |
| type | AssetType | 是 | 资产类型枚举值。 |
| subType | number | 是 | 资产类型的子类型编号，用于进一步细分资产类型。 |
| category | AssetCategory | 是 | 资产所属的类别。 |
| isCustom | boolean | 否 | 是否为自定义资产类型，默认值为 false。 |

### 枚举说明

#### AssetType 枚举说明

用于表示资产的主类型。

| 枚举值 | 值 | 说明 |
| :--- | :--- | :--- |
| FUND | 1 | 资金账户 |
| CREDIT | 2 | 信用账户 |

#### AssetCategory 枚举说明

表示资产的分类，用于区分资产和负债类别。

| 名称 | 值 | 说明 |
| :--- | :--- | :--- |
| ASSET | 1 | 资产，在净资产计算中为正值 |
| LIABILITY | 2 | 负债，在净资产计算中为负值 |

## 示例代码

### 示例 1（资产创建）

```arkts
import { AssetDisplayTypeItem, AssetType } from 'asset_base';
import { AssetCreateSheet, assetCreateSheetBuilder } from 'asset_manage';
import { promptAction } from '@kit.ArkUI';

const MOCK_ASSET_TYPE_LIST: AssetDisplayTypeItem[] = [
  {
    name: '现金',
    type: 1,
    subType: 101,
    category: 1,
    icon: $r('app.media.ic_asset_1'),
  },
  {
    name: '银行卡',
    type: 1,
    subType: 102,
    category: 1,
    icon: $r('app.media.ic_asset_2'),
  },
  {
    name: '信用卡',
    type: 2,
    subType: 201,
    category: 2,
    icon: $r('app.media.ic_liability_1'),
  },
];

@Entry
@ComponentV2
struct AssetCreateSheetExample1 {
  @Local showCreateSheet: boolean = false;

  build() {
    Column({ space: 24 }) {
      Text('使用方式 1：直接使用组件嵌入页面');
      AssetCreateSheet({
        assetTypeList: MOCK_ASSET_TYPE_LIST,
        handleClick: (type: AssetType, subType?: number) => {
          promptAction.showToast({
            message: '点击了类型为' + type + '子类型为' + subType + '的资产按钮',
          });
        },
      }).height(300);
      Text('使用方式 2：使用 bindSheet 拉起半模态弹框使用');
      Button('打开')
        .onClick(() => {
          this.showCreateSheet = !this.showCreateSheet;
        })
        .bindSheet($$this.showCreateSheet,
          assetCreateSheetBuilder({
            assetTypeList: MOCK_ASSET_TYPE_LIST,
          }), {
            title: { title: '选择资产类型' },
            detents: [SheetSize.MEDIUM],
          });
    }
    .backgroundColor('#eee')
    .padding(16);
  }
}
```

### 示例 2（资产信息管理）

```arkts
import { AssetDisplayTypeItem } from 'asset_base';
import { AssetInfoManageSheet, assetInfoManageSheetBuilder } from 'asset_manage';
import { promptAction } from '@kit.ArkUI';

const MOCK_ASSET_ITEM: AssetDisplayTypeItem = {
  name: '现金',
  type: 1,
  subType: 101,
  category: 1,
  icon: $r('app.media.ic_asset_1'),
};

@Entry
@ComponentV2
struct AssetInfoManageSheetExample1 {
  @Local showManageSheet: boolean = false;

  build() {
    Column({ space: 24 }) {
      Text('使用方式 1：直接使用组件嵌入页面');
      AssetInfoManageSheet({
        assetTypeItem: MOCK_ASSET_ITEM,
        handleConfirm: () => {
          promptAction.showToast({ message: '保存成功~' });
        },
      }).height(300);
      Text('使用方式 2：使用 bindSheet 拉起半模态弹框');
      Button('打开')
        .onClick(() => {
          this.showManageSheet = !this.showManageSheet;
        })
        .bindSheet($$this.showManageSheet,
          assetInfoManageSheetBuilder({}), {
            title: { title: '编辑资产' },
            detents: [SheetSize.MEDIUM],
          });
    }
    .backgroundColor('#eee')
    .padding(16);
  }
}
```

### 示例 3（新增、编辑、删除资产）

```arkts
import { AssetRecordItemModel, AssetDisplayTypeItem, AssetRecordItem, AssetType } from 'asset_base';
import { assetCreateSheetBuilder, assetInfoManageSheetBuilder } from 'asset_manage';
import { promptAction } from '@kit.ArkUI';

const MOCK_ASSET_TYPE_LIST: AssetDisplayTypeItem[] = [
  {
    name: '现金',
    type: 1,
    subType: 101,
    category: 1,
    icon: $r('app.media.ic_asset_1'),
  },
  {
    name: '银行卡',
    type: 1,
    subType: 102,
    category: 1,
    icon: $r('app.media.ic_asset_2'),
  },
  {
    name: '信用卡',
    type: 2,
    subType: 201,
    category: 2,
    icon: $r('app.media.ic_liability_1'),
  },
];


@Entry
@ComponentV2
struct PreviewPage {
  @Local showCreateSheet: boolean = false;
  @Local showManageSheet: boolean = false;
  @Local manageItem: AssetDisplayTypeItem | undefined = undefined;
  @Local assetList: AssetRecordItemModel[] = [];
  @Local initAsset: AssetRecordItem | undefined = undefined;

  build() {
    Column({ space: 16 }) {
      Button('添加资产').onClick(() => {
        this.showCreateSheet = true;
      })
        .bindSheet($$this.showCreateSheet,
          assetCreateSheetBuilder({
            assetTypeList: MOCK_ASSET_TYPE_LIST,
            handleClick: (type: AssetType, subType?: number) => {
              this.openManageSheet(type, subType);
            },
          }), {
            title: { title: '选择资产类型' },
          });

      List({ space: 12 }) {
        ListItem() {
          Row() {
            Text('编号').width('20%');
            Text('名称').width('20%');
            Text('备注').width('20%');
            Text('金额').width('20%');
            Text('操作').width('20%');
          }.width('100%');
        };

        ForEach(this.assetList, (asset: AssetRecordItemModel) => {
          ListItem() {
            Row() {
              Text(asset.assetId!.toString()).width('20%');
              Text(asset.name).width('20%');
              Text(asset.note).width('20%');
              Text(asset.amount.toFixed(2)).width('20%');
              Text('编辑').width('20%').fontColor(Color.Blue).onClick(() => {
                this.editAsset(asset);
              });
            };
          };
        });
      }
      .width('100%')
      .layoutWeight(1);
    }
    .padding(16)
    .backgroundColor('#eee')
    .justifyContent(FlexAlign.Start)
    .bindSheet($$this.showManageSheet,
      assetInfoManageSheetBuilder({
        assetTypeItem: this.manageItem,
        initAsset: this.initAsset,
        type: this.manageItem?.type,
        handleConfirm: (data) => {
          this.confirmManage(data)
        },
        handleDelete: (id) => {
          this.deleteAsset(id);
        },
      }), {
        title: { title: '新增资产' },
        onWillDismiss: (action) => {
          this.initAsset = undefined;
          action.dismiss();
        },
      });
  }

  openManageSheet(type: AssetType, subType?: number) {
    console.log('点击了某一项资产，资产类型为' + subType);
    if (subType) {
      const item = MOCK_ASSET_TYPE_LIST.find((it) => it.subType === subType);
      this.manageItem = item!;
    } else {
      this.manageItem = undefined;
    }

    this.showManageSheet = true;
  }

  confirmManage(data: AssetRecordItemModel) {
    console.log(JSON.stringify(data));
    if (data.assetId) {
      let idx = this.assetList.findIndex((item) => item.assetId === data.assetId);
      this.assetList[idx] = data;
    } else {
      data.assetId = this.assetList.length + 1;
      this.assetList.push(data);
    }

    this.showManageSheet = false;
    this.showCreateSheet = false;
  }

  editAsset(item: AssetRecordItemModel) {
    const displayItem: AssetRecordItem = {
      assetId: item.assetId!,
      name: item.name,
      icon: '',
      type: item.type,
      subType: item.subType,
      category: item.category,
      amount: Number(item.amount),
      note: item.note,
      isCustom: item.isCustom,
    };
    this.initAsset = displayItem;
    this.showManageSheet = true;
  }

  deleteAsset(id: number) {
    const idx = this.assetList.findIndex((item) => item.assetId === id);
    console.log('index' + idx);
    if (typeof idx === 'number') {
      this.assetList.splice(idx, 1);
    }
    promptAction.showToast({ message: '删除成功' });
    this.showManageSheet = false;
  }
}
```

## 更新记录

| 版本 | 日期 | 说明 | 备注 |
| :--- | :--- | :--- | :--- |
| 1.0.2 | 2025-12-15 | Created with Pixso. | 下载该版本更新 README |
| 1.0.1 | 2025-08-29 | Created with Pixso. | 下载该版本 README 更新 |
| 1.0.0 | 2025-07-14 | Created with Pixso. | 下载该版本 |

本组件支持选择资产类型或新增自定义类型以创建资产数据。开发者可以选择使用组件 AssetCreateSheet 直接嵌入页面，或使用 Builder 方法 assetCreateSheetBuilder 拉起半模态框使用。组件提供资产信息展示和编辑的能力，根据是否传入初始资产数据，支持资产的创建、编辑和删除操作。它接收资产类型数据、初始资产数据，并通过表单收集和处理资产信息。

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

不涉及

## SDK 合规使用指南

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

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/55a859f8e836481d8260c0b1cc9212c5/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%B5%84%E4%BA%A7%E7%AE%A1%E7%90%86%E7%BB%84%E4%BB%B6/asset_manage1.0.2.zip