# 一键登录组件

## 简介

本组件提供了华为账号一键登录的能力，开发者可以根据业务需要快速实现应用登录。

## 详细介绍

### 简介

本组件提供了华为账号一键登录的能力，开发者可以根据业务需要快速实现应用登录。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（直板机）
- **系统版本**：HarmonyOS 5.0.1(13) 及以上

### 添加配置

配置华为账号服务。

a. 将应用的 client ID 配置到 entry 模块的 module.json5 文件，详细参考：配置 Client ID。

```json5
"requestPermissions": [],
"metadata": [
   {
     "name": "client_id",
     "value": "*****"
     // 配置为获取的 Client ID
   },
 ],
 "extensionAbilities": [],
...
```

b. 配置签名和指纹。
c. 申请账号权限。

### 快速入门

安装组件。
如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
b. 在项目根目录 build-profile.json5 添加 login_info 模块。

```json5
// 在项目根目录 build-profile.json5 填写 login_info 路径。其中 XXX 为组件存放的目录名。
  "modules": [
 {
   "name": "login_info",
   "srcPath": "./XXX/login_info",
 }
  ]
```

c. 在项目根目录 oh-package.json5 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
   "login_info": "file:./XXX/login_info"
  }
```

引入登录组件句柄。

```typescript
import { QuickLogin } from 'login_info';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
import { QuickLogin } from 'login_info';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  build() {
    Column() {
      QuickLogin({
        isBindContentCover: true,
        icon: $r("app.media.startIcon"),  //todo 需要图片资源
        loginBtnBgColor: "#4B5CC4",
        appName: "xxx",
        // 登录回调方法
        onLoginWithHuaweiID: () => {
          promptAction.showToast({ message: '登录成功', duration: 2000 });
        },
        // 隐私协议方法
        onPrivacyPolicy: () => {
          promptAction.showToast({ message: '隐私协议点击事件', duration: 2000 });
        },
        // 服务协议方法
        onServicePolicy: () => {
          promptAction.showToast({ message: '服务协议点击事件', duration: 2000 });
        },
        // 华为账号用户认证协议
        onHYAccountRouter: () => {
          promptAction.showToast({ message: '华为账号用户认证协议点击事件', duration: 2000 });
        },
      })
    }
    .width('100%')
    .height('100%')
  }
}
```

## API 参考

### 接口

**QuickLogin(options:LoginOptions)**
登录组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | LoginOptions | 是 | 登录组件相关参数 |

**LoginOptions 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| iconResourceStr | ResourceStr | 是 | 应用图标，参考 UX 设计规范 |
| loginBtnBgColor | ResourceStr | 是 | 一键登录按钮背景色 |
| appName | string | 是 | 应用隐私协议名称 |
| isBindContentCover | boolean | 否 | 区分模态和半模态弹窗 |

### 事件

支持以下事件：

- **onLoginWithHuaweiID**
  - 签名：`onLoginWithHuaweiID: () => void = () => {}`
  - 描述：点击华为账号一键登录时的跳转方法。
- **onPrivacyPolicy**
  - 签名：`onPrivacyPolicy: () => void = () => {}`
  - 描述：点击隐私协议时的跳转方法。
- **onServicePolicy**
  - 签名：`onServicePolicy: () => void = () => {}`
  - 描述：点击服务协议时的跳转方法。
- **onHYAccountRouter**
  - 签名：`onHYAccountRouter: () => void = () => {}`
  - 描述：点击华为用户认证协议时的跳转方法。

### 示例代码

```typescript
import { QuickLogin } from 'login_info';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  build() {
    Column() {
      QuickLogin({
        isBindContentCover: true,
        icon: $r("app.media.startIcon"),  //todo 需要图片资源
        loginBtnBgColor: "#4B5CC4",
        appName: "xxx",
        // 登录回调方法
        onLoginWithHuaweiID: () => {
          promptAction.showToast({ message: '登录成功', duration: 2000 });
        },
        // 隐私协议方法
        onPrivacyPolicy: () => {
          promptAction.showToast({ message: '隐私协议点击事件', duration: 2000 });
        },
        // 服务协议方法
        onServicePolicy: () => {
          promptAction.showToast({ message: '服务协议点击事件', duration: 2000 });
        },
        // 华为账号用户认证协议
        onHYAccountRouter: () => {
          promptAction.showToast({ message: '华为账号用户认证协议点击事件', duration: 2000 });
        },
      })
    }
    .width('100%')
    .height('100%')
  }
}
```

## 更新记录

| 版本 | 日期 | 描述 | 备注 |
| :--- | :--- | :--- | :--- |
| 1.0.1 | 2025-11-03 | 下载该版本调整 readme 说明修改业务 bug | Created with Pixso. |
| 1.0.0 | 2025-09-15 | 下载该版本初始版本 | Created with Pixso. |

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |
| 隐私政策 | 不涉及 | SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 值 | 备注 |
| :--- | :--- | :--- |
| HarmonyOS 版本 | 5.0.1 | Created with Pixso. |
| | 5.0.2 | Created with Pixso. |
| | 5.0.3 | Created with Pixso. |
| | 5.0.4 | Created with Pixso. |
| | 5.0.5 | Created with Pixso. |
| 应用类型 | 应用 | Created with Pixso. |
| | 元服务 | Created with Pixso. |
| 设备类型 | 手机 | Created with Pixso. |
| | 平板 | Created with Pixso. |
| | PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 | Created with Pixso. |
| | DevEco Studio 5.0.4 | Created with Pixso. |
| | DevEco Studio 5.0.5 | Created with Pixso. |
| | DevEco Studio 5.1.0 | Created with Pixso. |
| | DevEco Studio 5.1.1 | Created with Pixso. |
| | DevEco Studio 6.0.0 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/0cde1f897ce04ab09ddd0a5c0cfd5769/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E4%B8%80%E9%94%AE%E7%99%BB%E5%BD%95%E7%BB%84%E4%BB%B6/login_info1.0.1.zip