# 开屏广告组件

## 简介

本组件提供了通过华为广告平台展示开屏广告的能力，开发者可以根据业务需要实现通过开屏广告变现。

## 详细介绍

### 简介

本组件提供了通过华为广告平台展示开屏广告的能力，开发者可以根据业务需要实现通过开屏广告变现。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

#### 权限

- **网络权限**：`ohos.permission.INTERNET`

#### 调试

如需使用模拟器调试组件，请将 DevEco Studio 升级至 6.0.0 Release 及以上版本，模拟器新建设备选择 HarmonyOs 6.0.0(20) 及以上版本。

### 快速入门

1. 开发者需要前往鲸鸿动能媒体服务平台注册开发者账号并认证，并参考展示位创建创建广告展示位用于开发调试。
2. 安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件：
    - a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
    - b. 在项目根目录 `build-profile.json5` 并添加 `aggregated_ads` 模块。
    
    ```json5
    // 在项目根目录的 build-profile.json5 填写 aggregated_ads 路径。其中 xxx 为组件存在的目录名
    "modules": [
      {
        "name": "aggregated_ads",
        "srcPath": "./xxx/aggregated_ads",
      }
    ]
    ```

    - c. 在项目根目录 `oh-package.json5` 中添加依赖。
    
    ```json5
    // xxx 为组件存放的目录名称
    "dependencies": {
      "aggregated_ads": "file:./xxx/aggregated_ads"
    }
    ```

3. 引入广告组件句柄。

    ```typescript
    import { AdServicePage, AdType, ChannelType } from 'aggregated_ads';
    ```

4. 调用组件，详细参数配置说明参见 API 参考。

    ```typescript
    // 华为广告使用
    AdServicePage({
        channelType: ChannelType.HUAWEI_AD,
        adId: 'testq6zq98hecj',
        adType: AdType.SPLASH_AD,
        closeCallBack: () => {
          // 广告结束跳转页面
        },
      });
    ```

## API 参考

### 子组件

无

### 接口

`AdServicePage(channelType: ChannelType, adId: string, adType: AdType, appId: string, appName: string, closeCallBack: () => void)`

广告组件。

#### 参数

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| channelType | ChannelType | 是 | 广告渠道信息数组 |
| adId | string | 是 | 广告位 ID |
| adType | AdType | 是 | 广告类型 |
| appId | string | 否 | 应用 ID |
| appName | string | 否 | 应用名称 |
| closeCallBack | () => void | 是 | 关闭广告回调函数 |

#### ChannelType 枚举说明

| 名称 | 值 | 说明 |
| :--- | :--- | :--- |
| HUAWEI_AD | 0 | 华为广告 |

#### AdType 枚举说明

| 名称 | 值 | 说明 |
| :--- | :--- | :--- |
| SPLASH_AD | 1 | 开屏广告 |

### 事件

支持以下事件：

- **closeCallBack**
  - 签名：`closeCallBack: () => void = () => {}`
  - 描述：广告关闭时的回调函数。

### 示例代码

#### 使用华为广告

```typescript
import { AdServicePage, AdType, ChannelType } from 'aggregated_ads';
import { promptAction } from '@kit.ArkUI';

@Entry
@ComponentV2
struct Index {
  build() {
     RelativeContainer() {
        AdServicePage({
           channelType: ChannelType.HUAWEI_AD,
           adId: 'testq6zq98hecj',
           adType: AdType.SPLASH_AD,
           closeCallBack: () => {
             // todo 这里需要自行编写路由到其他页面的代码
             promptAction.showToast({ message: '跳转页面' })
           },
        })
     }
     .width('100%')
     .height('100%')
  }
}
```

## 更新记录

- **1.0.2** (2025-11-07)
  - 修复加载广告失败后白屏问题
  - [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%BC%80%E5%B1%8F%E5%B9%BF%E5%91%8A%E7%BB%84%E4%BB%B6/aggregated_ads1.0.2.zip)
- **1.0.1** (2025-09-10)
  - 更新 readme 内容
  - [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%BC%80%E5%B1%8F%E5%B9%BF%E5%91%8A%E7%BB%84%E4%BB%B6/aggregated_ads1.0.1.zip)
- **1.0.0** (2025-08-29)
  - 初始版本
  - [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%BC%80%E5%B1%8F%E5%B9%BF%E5%91%8A%E7%BB%84%E4%BB%B6/aggregated_ads1.0.0.zip)

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络。 | 允许使用 Internet 网络。 |

### 隐私政策

不涉及 SDK 合规。

### 使用指南

不涉及。

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/d1cc369096624dc987f287598edd3d28/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%BC%80%E5%B1%8F%E5%B9%BF%E5%91%8A%E7%BB%84%E4%BB%B6/aggregated_ads1.0.2.zip