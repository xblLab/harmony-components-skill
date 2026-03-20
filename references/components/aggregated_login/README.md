# 华为账号登录组件

## 简介

本组件提供了华为账号一键登录及微信一键登录的能力，开发者可以根据业务需要快速实现应用登录。

## 详细介绍

### 简介

本组件提供了华为账号一键登录及微信一键登录的能力，开发者可以根据业务需要快速实现应用登录。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

#### 权限

- **网络权限**：`ohos.permission.INTERNET`

### 快速入门

1. **安装组件**。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。
    - a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
    - b. 在项目根目录 `build-profile.json5` 并添加 `aggregated_login` 模块。

    ```json5
    // 在项目根目录的 build-profile.json5 填写 aggregated_login 路径。其中 xxx 为组件存在的目录名
    "modules": [
      {
        "name": "aggregated_login",
        "srcPath": "./xxx/aggregated_login",
      }
    ]
    ```

    - c. 在项目根目录 `oh-package.json5` 中添加依赖。

    ```json5
    // xxx 为组件存放的目录名称
    "dependencies": {
      "aggregated_login": "file:./xxx/aggregated_login"
    }
    ```

2. **配置华为账号服务**。
    - a. 将应用的 client ID 配置到项目入口模块（例如：entry）的 `module.json5` 文件，详细参考：配置 Client ID。

    ```json5
    "requestPermissions": [],
    "metadata": [
       {
         "name": "client_id",
         // 配置为获取的 Client ID
         "value": "*****"
       },
     ],
     "extensionAbilities": [],
    ```

    - b. 配置签名和指纹。
    - c. 申请 scope 权限。

3. **前往微信开放平台申请 AppId 并配置鸿蒙应用信息**，详情请参考鸿蒙接入指南。

4. **引入登录组件句柄**。

    ```typescript
    import { Channel, LoginService, LoginType } from 'aggregated_login';
    ```

5. **调用组件**，详细参数配置说明参见 API 参考。

    ```typescript
    // 登录使用
    LoginService({
        icon: $r('app.media.app_icon'),
        privacyPolicyEvent: () => {
          // 跳转页面
         },
        loginBtnBgColor: '#007DFF',
        termOfServiceEvent: () => {
           // 跳转页面
        },
        loginTypes: [new Channel(LoginType.WECHAT, '微信登录', {
           appId: 'wxd5a474c635b8fd17',
           scope: 'snsapi_userinfo,snsapi_friend,snsapi_message,snsapi_contact',
           transaction: 'test123',
           state: 'none',
        }, $r('app.media.wechat'))],
           pathInfos: this.pageInfos,
    });
    ```

### API 参考

#### 子组件

无

#### 接口

**LoginService(icon: ResourceStr, loginTypes: Channel[], loginBtnBgColor: ResourceStr, pathInfos: NavPathStack)**

登录组件。

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| icon | ResourceStr | 是 | 应用图标，参考 UX 设计规范 |
| loginTypes | Channel[] | 是 | 登录渠道信息 |
| loginBtnBgColor | string | 否 | 一键登录按钮背景色 |
| pathInfos | NavPathStack | 否 | 应用路由栈 |

#### Channel 对象说明

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| type | LoginType | 是 | 登录类型 |
| icon | ResourceStr | 是 | 登录渠道信息 |
| extraInfo | ExtraInfo | 是 | 登录必须信息 |
| click | () => {} | 否 | 登录图标点击方法 |
| name | string | 否 | 登录方式名称 |

#### LoginType 枚举说明

| 名称 | 值 | 说明 |
| :--- | :--- | :--- |
| HUAWEI | 0 | 华为一键登录 |
| WECHAT | 1 | 微信一键登录 |

#### ExtraInfo 对象说明

当登录方式为微信登录时，此对象必传，具体参数含义请参考鸿蒙接入指南。

| 参数名 | 类型 | 必填 |
| :--- | :--- | :--- |
| appId | string | 是 |
| appKey | string | 否 |
| scope | string | 否 |
| transaction | string | 否 |
| state | string | 否 |

#### 事件

支持以下事件：

- **privacyPolicyEvent**
  - 定义：`privacyPolicyEvent: () => void = () => {}`
  - 说明：点击隐私政策时的跳转方法。
- **termOfServiceEvent**
  - 定义：`termOfServiceEvent: () => void = () => {}`
  - 说明：点击用户协议时的跳转方法。

### 示例代码

```typescript
import { promptAction } from '@kit.ArkUI';
import { Channel, LoginService, LoginType } from 'aggregated_login';

@Entry
@ComponentV2
struct Index {
  pageInfos: NavPathStack = new NavPathStack();
  
  build() {
     RelativeContainer() {
        LoginService({
           icon: $r('app.media.startIcon'),
           privacyPolicyEvent: () => {
              promptAction.showToast({ message: '跳转页面' })
           },
           loginBtnBgColor: '#FF0000',
           termOfServiceEvent: () => {
              promptAction.showToast({ message: '跳转页面' })
           },
           loginTypes: [new Channel(LoginType.WECHAT, '微信登录', {
              appId: 'wxd5a474c635b8fd17',
              scope: 'snsapi_userinfo,snsapi_friend,snsapi_message,snsapi_contact',
              transaction: 'test123',
              state: 'none',
           }, $r('app.media.startIcon'))],
           pathInfos: new NavPathStack(),
           loginFinishedCb: (flag: boolean, unionID?: string) => {
              // 模板忽略登录失败场景
              promptAction.showToast({ message: '登录成功回调' })
           },
        });
     }
     .height('100%')
     .width('100%')
  }
}
```

### 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.2 | 2025-11-07 | 下载该版本更新修改 readme 内容 |
| 1.0.1 | 2025-09-10 | 下载该版本更新 readme 内容 |
| 1.0.0 | 2025-08-29 | 下载该版本初始版本 |

### 权限与隐私

| 基本信息 | 说明 |
| :--- | :--- |
| 权限名称 | ohos.permission.INTERNET |
| 权限说明 | 允许使用 Internet 网络 |
| 使用目的 | 允许使用 Internet 网络 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| 项目 | 版本 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/e9ceb26920684b5e8b6544209582801e/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%8D%8E%E4%B8%BA%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%E7%BB%84%E4%BB%B6/aggregated_login1.0.2.zip