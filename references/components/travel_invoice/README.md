# 发票编辑组件

## 简介

本组件提供了发票管理的相关功能，支持发票列表展示、添加新发票、编辑现有发票、删除发票等能力。组件采用列表展示形式呈现发票信息，并提供添加、编辑、删除操作入口。支持发票列表展示、添加新发票、编辑现有发票、删除发票、表单验证等功能。

## 详细介绍

### 功能简介

本组件提供了发票管理的相关功能，支持发票列表展示、添加新发票、编辑现有发票、删除发票等能力。组件采用列表展示形式呈现发票信息，并提供添加、编辑、删除操作入口。支持发票列表展示、添加新发票、编辑现有发票、删除发票、表单验证等功能。

发票列表视图新增/编辑发票视图

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.5 Release 及以上
- Harmony0s SDK 版本：Harmony0s 5.0.3(15)Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 5.0.3 及以上

#### 权限

无

### 使用

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。
b. 在项目根目录 build-profile.json5 并添加 travel_invoice 模块。

```json5
// 在项目根目录的 build-profile.json5 填写 travel_invoice 路径。其中 xxx 为组件存在的目录名
"modules": [
  {
    "name": "travel_invoice",
    "srcPath": "./xxx/travel_invoice"
  }
]
```

c. 在项目根目录 oh-package.json5 中添加依赖

```json5
// xxx 为组件存放的目录名称
"dependencies": {
  "travel_invoice": "file:./xxx/travel_invoice"
}
```

引入组件。

```typescript
import { InvoiceList, InvoiceListComp } from 'travel_invoice';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
// 发票列表组件
InvoiceListComp({
    invoiceList: this.myInvoiceList,
    routerModule: this.pathStack
})
```

## API 参考

### 接口

#### InvoiceListComp

`InvoiceListComp(options: { invoiceList: InvoiceList })`

发票列表组件，用于展示发票列表并提供添加、编辑、删除操作入口。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| invoiceList | InvoiceList | 是 | 发票列表数据 |
| routerModule | NavPathStack | 是 | 传入当前组件所在路由栈 |

#### AddInvoiceComp

`AddInvoiceComp(options: { invoiceInfo: InvoiceInfo })`

发票列表组件，用于展示发票列表并提供添加、编辑、删除操作入口。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| invoiceInfo | InvoiceInfo | 否 | 发票信息数据 |

### 数据类型

#### InvoiceInfo

发票信息数据模型，用于描述单个发票的详细信息。

| 属性名 | 类型 | 说明 |
| :--- | :--- | :--- |
| id | string | 发票唯一标识 |
| type | InvoiceType | 发票类型 |
| title | string | 发票抬头 |
| taxID | string | 税号 |
| isNeedVAD | boolean | 是否需要增值税专用发票 |

#### InvoiceList

发票列表管理模型，用于管理发票列表数据，提供添加、编辑、删除等操作。

| 参数名 | 类型 | 是否必填 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| list | InvoiceInfo[] | 否 | [] | 发票信息数组 |
| add(invoiceInfo: InvoiceInfo) | - | 否 | - | 添加新发票 |
| editData(invoiceInfo: InvoiceInfo) | - | 否 | - | 编辑现有发票 |
| deleteById(id: string) | - | 否 | - | 根据 ID 删除发票 |

#### InvoiceType

发票类型枚举，定义了支持的发票类型。

| 值 | 说明 |
| :--- | :--- |
| InvoiceType.ENTERPRISE | 企业发票 |
| InvoiceType.INDIVIDUAL | 个人发票 |
| InvoiceType.NON_ENTERPRISE_UNIT | 非企业单位发票 |

## 示例代码

```typescript
import { InvoiceList, InvoiceListComp } from 'travel_invoice';
import { AppStorageV2 } from '@kit.ArkUI';

@Entry
@ComponentV2
struct Index {
  @Local myInvoiceList: InvoiceList = AppStorageV2.connect(InvoiceList, () => new InvoiceList())!
  private pathStack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pathStack) {
      Column() {
        InvoiceListComp({
          invoiceList: this.myInvoiceList,
          routerModule: this.pathStack
        })
      }
      .padding({ top: 50, left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#F1F3F5")
  }
}
```

## 更新记录

### 1.0.0 (2026-01-06)

Created with Pixso.

下载该版本初始版本

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

隐私政策：不涉及
SDK 合规使用指南：不涉及

### 兼容性

Created with Pixso.

| HarmonyOS 版本 | 备注 |
| :--- | :--- |
| 5.0.3 | Created with Pixso. |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |
| 5.1.0 | Created with Pixso. |
| 5.1.1 | Created with Pixso. |
| 6.0.0 | Created with Pixso. |
| 6.0.1 | Created with Pixso. |

| 应用类型 | 备注 |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

| 设备类型 | 备注 |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

| DevEcoStudio 版本 | 备注 |
| :--- | :--- |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |
| DevEco Studio 6.0.1 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/96808affce7742d3ae0aac504805cce8/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%8F%91%E7%A5%A8%E7%BC%96%E8%BE%91%E7%BB%84%E4%BB%B6/travel_invoice1.0.0.zip