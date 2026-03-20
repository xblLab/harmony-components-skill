# 选择店铺组件

## 简介

本组件提供了店铺选择功能，可以展示地图窗口，显示店铺位置与名称，选择店铺时可以切换地图上的店铺。

## 详细介绍

### 简介

本组件提供了店铺选择功能，可以展示地图窗口，显示店铺位置与名称，选择店铺时可以切换地图上的店铺。

展开地图 收起地图

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 6.0.1 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 6.0.1 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 6.0.1(21) 及以上

#### 权限

- 获取位置权限：`ohos.permission.APPROXIMATELY_LOCATION`、`ohos.permission.LOCATION`
- 网络权限：`ohos.permission.INTERNET`

### 使用

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。

b. 在项目根目录 `build-profile.json5` 并添加 `select_store` 和 `base_ui` 模块。

```json5
// 在项目根目录的 build-profile.json5 填写 select_store 和 base_ui 路径。其中 xxx 为组件存在的目录名
"modules": [
  {
    "name": "select_store",
    "srcPath": "./xxx/select_store",
  },
  {
    "name": "base_ui",
    "srcPath": "./xxx/base_ui",
  }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// xxx 为组件存放的目录名称
"dependencies": {
  "select_store": "file:./xxx/select_store"
}
```

引入组件。

```typescript
import { SelectStore } from 'select_store';
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

调用组件，详细参数配置说明参见 API 参考。

```typescript
SelectStore({
  storeInfoList: this.storeInfoList,
  navigateStoreCb: (coordinates: string = '', address: string = '') => {
    // 跳转店铺导航
  },
  selectStoreCb: (storeId: string) => {
    // 选择店铺后跳转页面
  },
  callTelCb: (callTelSheet: boolean, tel: string) => {
    // 拉起拨号页面
  },
})
```

## API 参考

### 接口

`SelectStore(options?: SelectStoreOptions)`

选择店铺组件。

### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | SelectStoreOptions | 是 | 选择店铺的参数。 |

### SelectStoreOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| storeInfoList | storeInfo[] | 否 | 店铺列表 |
| listOffset | number | 否 | list 内容区末尾偏移量 |

### storeInfo 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 店铺序号 |
| name | string | 是 | 店铺名称 |
| address | string | 是 | 店铺地址 |
| time1 | string | 是 | 店铺营业开始时间 |
| time2 | string | 是 | 店铺营业结束时间 |
| tel | string | 是 | 店铺电话 |
| logo | string | 是 | 店铺图标 |
| coordinates | string | 是 | 店铺位置 |
| distance | number | 是 | 店铺距离 |
| distanceStr | string | 是 | 店铺距离字符串 |
| canTakeaways | boolean | 是 | 是否可外带 |
| makingNum | number | 是 | 店铺制作中数量 |
| makingWaitTime | number | 是 | 店铺等待时间 |

### 事件

支持以下事件：

- **navigateStoreCb**
  `navigateStoreCb(callback: (coordinates: string = '', address: string = '') => void)`
  跳转店铺导航

- **selectStoreCb**
  `selectStoreCb(callback: (storeId: string) => void)`
  选择店铺后跳转页面

- **callTelCb**
  `callTelCb(callback: (callTelSheet: boolean, tel: string) => void)`
  拉起拨号页面

## 示例代码

```typescript
import { promptAction } from '@kit.ArkUI';
import { SelectStore, StoreInfo } from 'select_store';
import { abilityAccessCtrl, common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@ComponentV2
struct Index {
  @Local storeInfoList: StoreInfo[] = [];

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
  for (let index = 0; index < 3; index++) {
     let store = new StoreInfo()
     store.id = `${index}`
     store.name = `店铺名称（${index}）`
     store.address = '南京市雨花台区华为路华为云楼'
     store.time1 = '00:00'
     store.time2 = '21:30'
     store.tel = `1000000000${index}`
     store.logo = ''
     store.coordinates = '31.97919489020034,118.76224773565536'
     store.distanceStr = '888M'
     this.storeInfoList.push(store)
  }
  this.storeInfoList[1].coordinates = '31.97831,118.76362'
  this.storeInfoList[1].makingNum = 1
  this.storeInfoList[2].coordinates = '31.97052568354233,118.76447685976373'
  this.storeInfoList[2].makingNum = 10
  }
  
  build() {
     RelativeContainer() {
        SelectStore({
           storeInfoList: this.storeInfoList,
           listOffset: 30,
           navigateStoreCb: (coordinates: string = '', address: string = '') => {
              // 跳转店铺导航
              promptAction.showToast({ message: '点击店铺导航' })
           },
           selectStoreCb: (storeId: string) => {
              // 选择店铺后跳转页面
              promptAction.showToast({ message: '选择店铺' })
           },
           callTelCb: (callTelSheet: boolean, tel: string) => {
              // 拉起拨号页面
              promptAction.showToast({ message: '点击店铺电话' })
           },
        })
     }
     .height('100%')
     .width('100%')
  }
}
```

## 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.2 | 2026-02-13 | 下载该版本<br>新增一多适配折叠屏<br>新增搜索功能<br><br>Created with Pixso. |
| 1.0.1 | 2025-11-03 | 下载该版本<br>README 修改<br><br>Created with Pixso. |
| 1.0.0 | 2025-08-30 | 下载该版本<br>初始版本<br><br>Created with Pixso. |

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.APPROXIMATELY_LOCATION | 允许应用获取设备模糊位置信息 | 允许应用获取设备模糊位置信息 |
| ohos.permission.LOCATION | 允许应用获取设备位置信息 | 允许应用获取设备位置信息 |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

| 项目 | 值 |
| :--- | :--- |
| HarmonyOS 版本 | 6.0.1 |
| 6.0.2 | |
| 应用类型 | 应用 |
| 元服务 | |
| 设备类型 | 手机 |
| 平板 | |
| PC | |
| DevEcoStudio 版本 | DevEco Studio 6.0.1 |
| DevEco Studio 6.0.2 | |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/dea0e547b0be453fa2a02bb469a21bee/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%80%89%E6%8B%A9%E5%BA%97%E9%93%BA%E7%BB%84%E4%BB%B6/select_store1.0.2.zip