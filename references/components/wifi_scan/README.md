# wifi 扫描选择组件

## 简介

本组件提供了 wifi 选择的能力，包括 wifi 列表选择，密码展示等

## 详细介绍

### 简介

本组件提供了 wifi 选择的能力，包括 wifi 列表选择，密码展示等

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.4 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.4 Release SDK 及以上
- 设备类型：华为手机（直板机）
- HarmonyOS 版本：HarmonyOS 5.0.4 Release 及以上

#### 权限要求

- wifi 查询权限：ohos.permission.GET_WIFI_INFO

### 快速入门

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。
2. 在项目根目录 `build-profile.json5` 并添加 wifi_scan 模块。

```json5
// 在项目根目录 build-profile.json5 填写 wifi_scan 路径，其中 xxx 为组件存在的目录名
"modules": [
    {
       "name": "wifi_scan",
       "srcPath": "./xxx/wifi_scan"
    }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖

```json5
// xxx 为组件存放的目录名称
"dependencies": {
   "wifi_scan": "file:../xxx/wifi_scan"
}
```

引入组件。

```typescript
import { MessageList, MessageRecordViewModel } from 'message_list';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
import { WifiSelectView } from 'wifi_scan';

@Entry
@ComponentV2
struct Index {
   build() {
     Column() {
       WifiSelectView()
     }
     .backgroundColor('#F1F3F5')
     .width('100%')
     .height('100%')
   }
}
```

## API 参考

### 子组件

无

### 接口

**WifiSelectView()**
Wifi 选择组件。

**参数：**
无

### 事件

支持以下事件：

**clickEvent**
`clickEvent(wifiName: string, wifiPassword: string) => void`
点击下一步回调事件，返回当前选择的 wifi 名称和密码

### 示例代码

**示例 1（传入点击协议回调和登录回调）**
本示例展示了调用回调事件的用法。

```typescript
import { WifiSelectView } from 'wifi_scan'
import { promptAction } from '@kit.ArkUI'

@Entry
@ComponentV2
struct Index {
   build() {
      Column() {
         WifiSelectView({
            clickEvent: (wifiName: string, wifiPassWord) => {
              // 按钮点击事件
               promptAction.showToast({ message: 'wifi 名称：' + wifiName + ' 密码' + wifiPassWord })
            }
         })
      }
      .backgroundColor('#F1F3F5')
         .width('100%')
         .height('100%')
   }
}
```

## 更新记录

### 版本历史

- **1.0.0 (2025-11-03)**: 初始版本

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.GET_WIFI_INFO | 允许应用获取 Wi-Fi 信息 | 允许应用获取 Wi-Fi 信息 |
| 隐私政策 | 不涉及 | - |
| SDK 合规使用指南 | 不涉及 | - |

### 兼容性

| 项目 | 信息 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/b7e8c084fc214b80820ae31ba5ae9358/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/wifi%E6%89%AB%E6%8F%8F%E9%80%89%E6%8B%A9%E7%BB%84%E4%BB%B6/wifi_scan1.0.0.zip