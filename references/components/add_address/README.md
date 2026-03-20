# 新增地址组件

## 简介

本组件提供了新建和展示联系地址功能，可以地图选点获取位置信息，输入联系人信息保存后可以展示信息。

## 详细介绍

### 简介

本组件提供了新建和展示联系地址功能，可以地图选点获取位置信息，输入联系人信息保存后可以展示信息。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 6.0.1 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 6.0.1 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 6.0.1(21) 及以上

#### 权限

- **获取位置权限**：`ohos.permission.APPROXIMATELY_LOCATION`、`ohos.permission.LOCATION`
- **网络权限**：`ohos.permission.INTERNET`

### 使用

1. **安装组件**。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。
   - a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
   - b. 在项目根目录 `build-profile.json5` 并添加 `add_address` 模块。

   ```json5
   // 在项目根目录的 build-profile.json5 填写 add_address 路径。其中 xxx 为组件存在的目录名
   "modules": [
     {
       "name": "add_address",
       "srcPath": "./xxx/add_address",
     }
   ]
   ```

   - c. 在项目根目录 `oh-package.json5` 中添加依赖。

   ```json5
   // xxx 为组件存放的目录名称
   "dependencies": {
     "add_address": "file:./xxx/add_address"
   }
   ```

2. **引入组件**。

   ```typescript
   import { AddAddress, AddressCard, AddressComp } from 'add_address';
   ```

3. **在主工程的 src/main 路径下的 module.json5 文件的 requestPermissions 字段中添加如下权限**：

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

4. **调用组件**，详细参数配置说明参见 API 参考。

   ```typescript
   // 展示地址信息
   AddressComp({ address: this.address })
   // 展示地址卡片
   AddressCard({ address: this.address })
   // 新增地址
   AddAddress({
      addressInfo: selectAddress,
      myLocation: this.myLocation,
      modifyAddressInfo: (addressInfo: AddressInfo) => {
        // 保存地址信息
      },
   })
   ```

5. **（可选）智能填充服务**，需要申请接入智能填充服务。

6. **（可选）配置华为账号服务**。地址管理组件支持从华为账号中导入收货地址，这需要您完成账号权限的申请并满足一系列开发前提。详细参考：收货地址能力开发前提。您如果跳过该项配置，仅会导致页面的 '从华为账号导入' 按钮不可用。

## API 参考

### 接口

#### AddressComp(options?: AddressCompOptions)

地址展示组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | AddressCompOptions | 是 | 地址展示的参数。 |

#### AddressCard(options?: AddressCardOptions)

地址卡片展示组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | AddressCardOptions | 是 | 地址卡片展示的参数。 |

#### AddAddress(options?: AddAddressOptions)

新增地址组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | AddAddressOptions | 是 | 新增地址的参数。 |

### 对象说明

#### AddressCompOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| addressInfo | AddressInfo | 是 | 地址信息 |

#### AddressCardOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| addressInfo | AddressInfo | 是 | 地址信息 |
| selectIdnumber | number | 否 | 默认选择地址的 ID。 |
| showSelect | boolean | 否 | 是否展示选择按钮。 |
| disable | boolean | 否 | 是否可以操作。 |
| showEdit | boolean | 否 | 是否展示编辑按钮。 |

#### AddAddressOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| addressInfo | AddressInfo | 否 | 选择修改地址信息 |
| myLocation | Location | - | 是我的位置信息 |

#### AddressInfo 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| idnumber | number | 是 | 地址序号 |
| addressPre | string | - | 地址前缀 |
| addressNum | string | - | 地址门牌号 |
| name | string | - | 收件人名称 |
| sex | boolean | - | 收件人性别 |
| tel | string | - | 收件人电话 |
| tag | number | - | 地址分类标签 |
| latitude | number | - | 地址纬度 |
| longitude | number | - | 地址经度 |

### 事件

支持以下事件：

- **selectAddress**
  ```typescript
  selectAddress(callback: (address: AddressInfo) => void)
  ```
  选择地址回调事件

- **modifyAddressInfo**
  ```typescript
  modifyAddressInfo(callback: (address: AddressInfo) => void)
  ```
  修改地址回调事件

- **modifyAddressInfo**
  ```typescript
  modifyAddressInfo(callback: (addressInfo: AddressInfo) => void)
  ```
  保存修改地址回调事件

## 示例代码

```typescript
import { abilityAccessCtrl, common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { AddAddress, AddressCard, AddressComp, AddressInfo } from 'add_address';
import { geoLocationManager } from '@kit.LocationKit';
import { promptAction } from '@kit.ArkUI';

@Entry
@ComponentV2
struct Index {
   @Local address: AddressInfo = new AddressInfo()
   @Local myLocation?: geoLocationManager.Location

   aboutToAppear(): void {
      let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
      atManager.requestPermissionsFromUser(getContext() as common.UIAbilityContext,
      ['ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION'])
      .then((data) => {
      let grantStatus: Array<number> = data.authResults;
      if (grantStatus.every(item => item === 0)) {
      // 授权成功
      geoLocationManager.getCurrentLocation().then((location: geoLocationManager.Location) => {
      this.myLocation = location;
   }).catch((error: Error) => {
      console.error('getCurrentLocation failed', 'getCurrentLocation error: ' + JSON.stringify(error));
   });
}
}).catch((err: BusinessError) => {
   console.error(`Failed to request permissions from user. Code is ${err.code}, message is ${err.message}`);
});
}

build() {
   Column({ space: 20 }) {
      // 展示地址信息
      AddressComp({ address: this.address })
      // 展示地址卡片
      AddressCard({ address: this.address })
      // 新增地址
      AddAddress({
         addressInfo: this.address,
         myLocation: this.myLocation,
         modifyAddressInfo: (addressInfo: AddressInfo) => {
            // 保存地址信息
            this.address = addressInfo
            promptAction.showToast({ message: '保存地址信息' })
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

## 更新记录

| 版本 | 日期 | 更新内容 |
| :--- | :--- | :--- |
| 1.0.2 | 2026-02-13 | 新增智能填充服务<br>新增从华为账号导入<br>[下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%96%B0%E5%A2%9E%E5%9C%B0%E5%9D%80%E7%BB%84%E4%BB%B6/add_address1.0.2.zip) |
| 1.0.1 | 2025-11-03 | README 修改<br>[下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%96%B0%E5%A2%9E%E5%9C%B0%E5%9D%80%E7%BB%84%E4%BB%B6/add_address1.0.2.zip) |
| 1.0.0 | 2025-08-30 | 初始版本<br>[下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%96%B0%E5%A2%9E%E5%9C%B0%E5%9D%80%E7%BB%84%E4%BB%B6/add_address1.0.2.zip) |

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.APPROXIMATELY_LOCATION | 允许应用获取设备模糊位置信息 | 允许应用获取设备模糊位置信息 |
| ohos.permission.LOCATION | 允许应用获取设备位置信息 | 允许应用获取设备位置信息 |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

### 其他信息

| 项目 | 内容 |
| :--- | :--- |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 支持情况 |
| :--- | :--- |
| HarmonyOS 版本 | 6.0.1, 6.0.2 |
| 应用类型 | 应用，元服务 |
| 设备类型 | 手机，平板，PC |
| DevEco Studio 版本 | DevEco Studio 6.0.1, DevEco Studio 6.0.2 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/682a53e770fe41faa81068ac94c259a4/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%96%B0%E5%A2%9E%E5%9C%B0%E5%9D%80%E7%BB%84%E4%BB%B6/add_address1.0.2.zip