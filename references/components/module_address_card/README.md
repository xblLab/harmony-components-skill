# 地址卡片组件

## 简介

本组件提供以卡片形式展示地址、选择地址的功能。

## 详细介绍

### 简介

本组件提供以卡片形式展示地址、选择地址的功能。

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 5.0.0(12) 及以上

#### 权限

无

### 使用

安装组件。

1. 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
2. 如果是从生态市场下载组件，请参考以下步骤安装组件。
   - a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
   - b. 在项目根目录 `build-profile.json5` 添加 `module_address_card`、`module_address` 和 `module_base` 模块。
     ```json5
     // 在项目根目录 build-profile.json5 填写 module_address_card、module_address 和 module_base 路径。其中 XXX 为组件存放的目录名
     "modules": [
         {
             "name": "module_address_card",
             "srcPath": "./XXX/module_address_card",
         },
         {
             "name": "module_address",
             "srcPath": "./XXX/module_address",
         },
         {
             "name": "module_base",
             "srcPath": "./XXX/module_base",
         }
     ]
     ```
   - c. 在项目根目录 `oh-package.json5` 中添加依赖。
     ```json5
     // XXX 为组件存放的目录名称
     "dependencies": {
       "module_address_card": "file:./XXX/module_address_card",
       "module_base": "file:./XXX/module_base"
     }
     ```

引入组件与地址卡片组件句柄。

```typescript
import { CommonAddress } from 'module_address_card';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
import { CommonAddress } from 'module_address_card';
import { IAddrInfo, OrderType } from 'module_base'

const addressData: IAddrInfo = {
  id: '',
  name: '',
  phone: '',
  countryCode: '',
  country: '',
  province: '',
  city: '',
  district: '',
  street: '',
  detail: '',
  isDefault: false,
  createdAt: 0,
  updatedAt: 0,
}

@Entry
@ComponentV2
struct Sample {
  private navPathStack: NavPathStack = new NavPathStack()
  @Local isEdit: boolean = true
  @Local sendAddress: IAddrInfo = addressData
  @Local getAddress: IAddrInfo = addressData

  public build(): void {
    Navigation(this.navPathStack) {
      Column() {
        CommonAddress({
          stack: this.navPathStack,
          isEdit: this.isEdit,
          sendAddress: this.sendAddress,
          getAddress: this.getAddress,
          onSelect: (value) => {
            if (value.type === OrderType.SEND) {
              this.sendAddress = value.address
            } else {
              this.getAddress = value.address
            }
          },
          onChange: () => {
            const temp = this.sendAddress
            this.sendAddress = this.getAddress
            this.getAddress = temp
          },
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F1F3F5')
    }
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
  }
}
```

## API 参考

### 子组件

无

### 接口

**CommonAddress(option: CommonAddressOptions)**

地址卡片组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | CommonAddressOptions | 是 | 配置地址卡片组件的参数。 |

**CommonAddressOptions 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| navPathStack | NavPathStack | - | Navigation 路由栈实例 |
| isEdit | boolean | 否 | 是否开启编辑模式 |
| sendAddress | IAddrInfo | 否 | 寄件地址数据 |
| getAddress | IAddrInfo | 否 | 收件地址数据 |

**IAddrInfo 对象说明**

表示地址数据的结构体，用于页面组件传入、组件内部管理，或作为网络接口的请求/响应格式。

| 字段名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 地址唯一标识符 |
| name | string | 是 | 姓名 |
| phone | string | 是 | 手机号 |
| countryCode | string | 是 | 国家代码（如 "CN" 表示中国） |
| country | string | 是 | 国家名称（如 "中国"） |
| province | string | 是 | 所在省份 |
| city | string | 是 | 所在城市 |
| district | string | 是 | 所在区/县 |
| street | string | 是 | 街道名称（如乡镇、街道） |
| detail | string | 是 | 详细地址（如门牌号、楼栋房间号） |
| isDefault | boolean | 是 | 是否为默认地址 |
| createdAt | number | 是 | 创建时间戳（毫秒） |
| updatedAt | number | 是 | 更新时间戳（毫秒） |

**IAddressParam 对象说明**

| 字段名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| type | OrderType | 是 | 地址类型 |
| address | IAddrInfo | 是 | 地址数据 |

**OrderType 常量说明**

| 字段名 | 说明 |
| :--- | :--- |
| ALL | 全部 |
| SEND | 寄快递 |
| RECEIVE | 收快递 |

**onSelect 事件说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| value | IAddressParam | 是 | 选中的地址 |

**onChange 事件说明**

自定义交换寄件地址和收件地址

### 示例代码

```typescript
import { CommonAddress } from 'module_address_card';
import { IAddrInfo, OrderType } from 'module_base'

const addressData: IAddrInfo = {
 id: '',
 name: '',
 phone: '',
 countryCode: '',
 country: '',
 province: '',
 city: '',
 district: '',
 street: '',
 detail: '',
 isDefault: false,
 createdAt: 0,
 updatedAt: 0,
}

@Entry
@ComponentV2
struct Sample {
 private navPathStack: NavPathStack = new NavPathStack()
 @Local isEdit: boolean = true
 @Local sendAddress: IAddrInfo = addressData
 @Local getAddress: IAddrInfo = addressData

 public build(): void {
   Navigation(this.navPathStack) {
     Column() {
       CommonAddress({
         stack: this.navPathStack,
         isEdit: this.isEdit,
         sendAddress: this.sendAddress,
         getAddress: this.getAddress,
         onSelect: (value) => {
           if (value.type === OrderType.SEND) {
             this.sendAddress = value.address
           } else {
             this.getAddress = value.address
           }
         },
         onChange: () => {
           const temp = this.sendAddress
           this.sendAddress = this.getAddress
           this.getAddress = temp
         },
       })
     }
     .width('100%')
     .height('100%')
     .justifyContent(FlexAlign.Center)
     .backgroundColor('#F1F3F5')
   }
   .hideTitleBar(true)
   .mode(NavigationMode.Stack)
 }
}
```

## 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.1 | 2026-02-13 | 下载该版本更新废弃 API<br>Created with Pixso. |
| 1.0.0 | 2025-11-03 | 下载该版本初始版本<br>Created with Pixso. |

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

| 项目 | 版本/类型 | 备注 |
| :--- | :--- | :--- |
| HarmonyOS 版本 | 5.0.0 | Created with Pixso. |
| | 5.0.1 | Created with Pixso. |
| | 5.0.2 | Created with Pixso. |
| | 5.0.3 | Created with Pixso. |
| | 5.0.4 | Created with Pixso. |
| | 5.0.5 | Created with Pixso. |
| | 5.1.0 | Created with Pixso. |
| | 5.1.1 | Created with Pixso. |
| | 6.0.0 | Created with Pixso. |
| | 6.0.1 | Created with Pixso. |
| | 6.0.2 | Created with Pixso. |
| 应用类型 | 应用 | Created with Pixso. |
| | 元服务 | Created with Pixso. |
| 设备类型 | 手机 | Created with Pixso. |
| | 平板 | Created with Pixso. |
| | PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 | Created with Pixso. |
| | DevEco Studio 5.0.1 | Created with Pixso. |
| | DevEco Studio 5.0.2 | Created with Pixso. |
| | DevEco Studio 5.0.3 | Created with Pixso. |
| | DevEco Studio 5.0.4 | Created with Pixso. |
| | DevEco Studio 5.0.5 | Created with Pixso. |
| | DevEco Studio 5.1.0 | Created with Pixso. |
| | DevEco Studio 5.1.1 | Created with Pixso. |
| | DevEco Studio 6.0.0 | Created with Pixso. |
| | DevEco Studio 6.0.1 | Created with Pixso. |
| | DevEco Studio 6.0.2 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/6774d9eac4824cd5b193d16f6c6e333d/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%9C%B0%E5%9D%80%E5%8D%A1%E7%89%87%E7%BB%84%E4%BB%B6/module_address_card1.0.1.zip