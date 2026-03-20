# AGConnect 认证服务组件

## 简介

认证服务可以为您的应用快速构建安全可靠的用户认证系统，您只需在应用中访问认证服务的相关能力，而不需要关心云侧的设施和实现。

## 功能介绍

AGConnect 认证服务支持以下功能：

- 支持手机帐号注册和登录。
- 支持邮箱帐号注册和登录。
- 支持华为账号登录。
- 支持获取用于 CloudFoundationKit 初始化方法的 AuthProvider。

[Learn More](https://developer.huawei.com/consumer/cn/market/prod-detail/4951c61695934e528cdf607cffa4e697/2adce9bbd4cb42d58a87e6add45594b3?origin=template)

## 安装方式

```bash
ohpm install @hw-agconnect/auth
```

## 使用说明

### 导入依赖

```typescript
import auth from '@hw-agconnect/auth';
```

### 需要权限

```xml
ohos.permission.INTERNET
```

### 使用示例

#### 初始化

在您的项目中导入 agc 组件。

```typescript
import auth from '@hw-agconnect/auth';
```

在您的应用初始化阶段使用 context 初始化 SDK，推荐在 MainAbility 的 onCreate 中进行。

```typescript
// 初始化 SDK
onCreate(want, launchParam) {
  // 务必保证 resources/rawfile 中包含 agconnect-services.json 文件
  let file = this.context.resourceManager.getRawFileContentSync('agconnect-services.json');
  let json: string = buffer.from(file.buffer).toString();
  auth.init(this.context, json);
}
```

#### 主要功能

##### 手机号登录

```typescript
import auth from '@hw-agconnect/auth';
import { AuthUser, VerifyCodeAction } from '@hw-agconnect/auth';

// 申请验证码
auth.requestVerifyCode({
  action: VerifyCodeAction.RESET_PASSWORD,
  lang: 'zh_CN',
  sendInterval: 60,
  verifyCodeType: {
    phoneNumber: "188********",
    countryCode: "86",
    kind: "phone",
  }
})

// 登录
let signInResult = auth.signIn({
  autoCreateUser: true,
  credentialInfo: {
    kind: "phone",
    phoneNumber: "188********",
    countryCode: "86",
    verifyCode: "验证码"
  }
})
let user = signInResult.getUser();
```

##### 邮箱登录

```typescript
import auth from '@hw-agconnect/auth';
import { AuthUser, VerifyCodeAction } from '@hw-agconnect/auth';

// 申请验证码
auth.requestVerifyCode({
  action: VerifyCodeAction.RESET_PASSWORD,
  lang: 'zh_CN',
  sendInterval: 60,
  verifyCodeType: {
    email: "your_email@xxx.com",
    kind: "email",
  }
})

// 登录
let signInResult = await auth.signIn({
  autoCreateUser: true,
  credentialInfo: {
    kind: "email",
    email: "your_email@xxx.com",
    verifyCode: "验证码"
  }
})
let user = signInResult.getUser();
```

##### 华为账号登录

```typescript
import auth, { AuthUser } from '@hw-agconnect/auth';

let signInResult = await auth.signIn({
  autoCreateUser: true,
  credentialInfo: {
    kind: "hwid"
  }
})
let user = signInResult.getUser();
```

##### 获取当前用户信息

```typescript
import auth from '@hw-agconnect/auth';
import { AuthUser, TokenResult } from '@hw-agconnect/auth';

auth.getCurrentUser().then((user) => {
  if (user == null) {
    console.info('no user login in')
  } else {
    console.info('getcurrentUser success: getUid' + user.getUid())
  }
})
```

##### 获取用于 CloudFoundationKit 初始化的 AuthProvider

```typescript
import auth from '@hw-agconnect/auth';

let provider = auth.getAuthProvider();
```

## 约束与限制

在下述版本验证通过：DevEco Studio NEXT Developer Beta1(5.0.3.403), SDK: API12 Release(5.0.0.25)

## License

auth-ohos sdk is licensed under the: "ISC"

## 更新记录

### 1.0.4 (2025-07-02)

认证服务可以为您的应用快速构建安全可靠的用户认证系统，您只需在应用中访问认证服务的相关能力，而不需要关心云侧的设施和实现。

## 权限与隐私

| 项目 | 说明 |
| :--- | :--- |
| **权限名称** | 无 |
| **权限说明** | 无 |
| **使用目的** | 无 |
| **隐私政策** | 不涉及 |
| **SDK 合规使用指南** | 不涉及 |

## 兼容性

| 项目 | 支持列表 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/4951c61695934e528cdf607cffa4e697/2adce9bbd4cb42d58a87e6add45594b3?origin=template