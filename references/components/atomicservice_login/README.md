# 通用元服务关联账号组件

## 简介

本组件提供元服务登录/关联手机号码，解除关联的功能。

## 详细介绍

简介
本组件提供元服务登录/关联手机号码，解除关联的功能。

关联号码未关联号码

### 约束与限制

#### 环境

DevEco Studio 版本：DevEco Studio 5.0.4 Release 及以上
HarmonyOS SDK 版本：HarmonyOS 5.0.4 Release SDK 及以上
设备类型：华为手机（包括双折叠和阔折叠）、平板
系统版本：HarmonyOS 5.0.1(13) 及以上

#### 权限

网络权限：ohos.permission.INTERNET

### 快速入门

1. **安装组件**
   如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
   如果是从生态市场下载组件，请参考以下步骤安装组件。
   a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
   b. 在项目根目录 `build-profile.json5` 添加 `atomicservice_login` 模块。
   
   > 项目根目录下 build-profile.json5 填写 atomicservice_login 路径。其中 XXX 为组件存放的目录名
   
   ```json5
   "modules": [
     {
       "name": "atomicservice_login",
       "srcPath": "./XXX/atomicservice_login"
     }
   ]
   ```
   
   c. 在项目根目录 `oh-package.json5` 添加依赖。
   
   > XXX 为组件存放的目录名称
   
   ```json5
   "dependencies": {
     "atomicservice_login": "file:./XXX/atomicservice_login"
   }
   ```

2. **引入元服务登录/关联组件句柄**
   
   ```typescript
   import { AccountUtils, AtomicserviceLogin, ApiController, CancelAuthState, UserInfo } from "atomicservice_login";
   ```

3. **配置 Client ID**
   将元服务的 client ID 配置到项目 entry 模块的 `module.json5` 文件，详细参考：[配置 Client ID](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/configure-client-id)。
   
   ```json5
   "metadata": [
     {
       // 替换应用的 clientID
       "name": "client_id",
       "value": "xxx"
     }
   ],
   ```

4. **申请权限**
   如需获取用户真实手机号，需要申请 phone 权限，详细参考：[申请账号权限](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/request-account-permissions)，并在端侧使用快速验证手机号码 Button 进行验证获取手机号码。

5. **调用组件**
   详细参数配置说明参见 API 参考。

### API 参考

#### 接口

**AtomicserviceLogin(option: AtomicserviceLoginOptions)**
元服务登录/关联组件

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | AtomicserviceLoginOptions | 否 | 元服务登录/关联组件的参数。 |

**AtomicserviceLoginOptions 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| userInfo | UserInfoOptions | 是 | 用户信息 |
| isLink | boolean | 否 | 是否关联，默认为 false，未关联 |
| initValue | ResourceStr | 否 | 用户名初始信息，默认为'华为用户' |
| controller | ApiController | 否 | 控制器 |

**接口：**

| 实例名 | 接口名 | 说明 |
| :--- | :--- | :--- |
| AccountUtils | silentLogin(callback: (data: authentication.LoginWithHuaweiIDCredential | undefined) => void): Promise | 静默登录以及回调 |

**userInfoOptions 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| authCode | string | 否 | 用户凭证 |
| avatar | string | 否 | 用户的头像 |
| idToken | string | 否 | 用户的 token |
| phoneNumber | string | 否 | 用户的手机号 |
| userName | string | 否 | 用户的昵称 |

**ApiController 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| unlink(unBindPhone: () => Promise) => void | 否 | 取消手机号码关联 |

#### 事件

支持以下事件：

- **bindPhone**
  `bindPhone: (code: string | undefined) => void = () => {}`
  
  关联手机号码的回调，返回用户的临时登录凭证（Authorization Code），可通过临时登录凭证获取真实手机号，临时登录凭证时效 5 分钟，具体操作可参考“服务端开发”章节。

- **onGetPhoneError**
  `onGetPhoneError: (err: BusinessError) => void = () => {}`
  
  关联手机号码失败的回调

- **onCancelAuthorization**
  `onCancelAuthorization: (state: CancelAuthState) => void = () => {}`
  
  取消授权的回调

**CancelAuthState 枚举说明**

| 名称 | 值 | 说明 |
| :--- | :--- | :--- |
| SUCCESS | 1 | 取消授权成功 |
| ERROR | 2 | 取消授权错误 |

- **unBindPhone**
  `unBindPhone: () => Promise = () => new Promise(() => {})`
  
  取消手机号码关联的回调

#### 示例代码

```typescript
import { AtomicserviceLogin, ApiController, UserInfo } from "atomicservice_login";

@Entry
@ComponentV2
struct AtomicserviceLoginPage {
  @Local userInfo: UserInfo = new UserInfo()
  @Local isLink: boolean = false
  @Local controller: ApiController = new ApiController()

  unBindPhone = async (): Promise<void> => {
    this.isLink = false
    this.userInfo = new UserInfo()
  }

  build() {
    NavDestination() {
      Column() {
        AtomicserviceLogin({
          userInfo: this.userInfo,
          isLink: this.isLink,
          controller: this.controller,
          bindPhone: (code: string | undefined) => {
            this.isLink = true
            this.userInfo.userName = '华为用户'
            this.userInfo.avatar = $r('app.media.startIcon')  // todo 替换为开发者需要的资源
            this.getUIContext().getPromptAction().showToast({message: '请通过临时登录凭证获取真实手机号'})
          },
          onGetPhoneError: (err) => {
            if (err.code === 1001502014) {
              this.getUIContext().getPromptAction().showToast({message: '元服务未获取 phone 权限或用户授权，此为模拟关联。'})
              this.isLink = true
              this.userInfo.phoneNumber = '120****4456'
              this.userInfo.userName = '华为用户'
              this.userInfo.avatar = $r('app.media.startIcon')  // todo 替换为开发者需要的资源
            }
          },
          unBindPhone: this.unBindPhone,
        })
      }
      .backgroundColor($r('sys.color.background_secondary'))
      .borderRadius(16)
      .margin({ right: 16, left: 16 })
    }
  }
}
```

### 更新记录

**1.0.0 (2025-10-24)**

Created with Pixso.

下载该版本初始版本

**权限与隐私基本信息**

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

**隐私政策**
不涉及

**SDK 合规使用指南**
不涉及

**兼容性**

| HarmonyOS 版本 | 5.0.1 |
| :--- | :--- |
| Created with Pixso. | Created with Pixso. |

| HarmonyOS 版本 | 5.0.2 |
| :--- | :--- |
| Created with Pixso. | Created with Pixso. |

| HarmonyOS 版本 | 5.0.3 |
| :--- | :--- |
| Created with Pixso. | Created with Pixso. |

| HarmonyOS 版本 | 5.0.4 |
| :--- | :--- |
| Created with Pixso. | Created with Pixso. |

| HarmonyOS 版本 | 5.0.5 |
| :--- | :--- |
| Created with Pixso. | Created with Pixso. |

**应用类型**

| 应用类型 | 应用 |
| :--- | :--- |
| Created with Pixso. | Created with Pixso. |

| 应用类型 | 元服务 |
| :--- | :--- |
| Created with Pixso. | Created with Pixso. |

**设备类型**

| 设备类型 | 手机 |
| :--- | :--- |
| Created with Pixso. | Created with Pixso. |

| 设备类型 | 平板 |
| :--- | :--- |
| Created with Pixso. | Created with Pixso. |

| 设备类型 | PC |
| :--- | :--- |
| Created with Pixso. | Created with Pixso. |

**DevEcoStudio 版本**

| DevEcoStudio 版本 | DevEco Studio 5.0.4 |
| :--- | :--- |
| Created with Pixso. | Created with Pixso. |

| DevEcoStudio 版本 | DevEco Studio 5.0.5 |
| :--- | :--- |
| Created with Pixso. | Created with Pixso. |

| DevEcoStudio 版本 | DevEco Studio 5.1.0 |
| :--- | :--- |
| Created with Pixso. | Created with Pixso. |

| DevEcoStudio 版本 | DevEco Studio 5.1.1 |
| :--- | :--- |
| Created with Pixso. | Created with Pixso. |

| DevEcoStudio 版本 | DevEco Studio 6.0.0 |
| :--- | :--- |
| Created with Pixso. | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/b3eb399413db4c8ab73ad1773bb9c7e2/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%80%9A%E7%94%A8%E5%85%83%E6%9C%8D%E5%8A%A1%E5%85%B3%E8%81%94%E8%B4%A6%E5%8F%B7%E7%BB%84%E4%BB%B6/atomicservice_login1.0.0.zip