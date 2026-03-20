# 元服务关联账号组件

## 简介

本组件提供关联华为账号，解除关联的功能。

## 详细介绍

### 简介

本组件提供关联华为账号，解除关联的功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（直板机）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

#### 权限

- **网络权限**：`ohos.permission.INTERNET`

### 快速入门

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `automatic_login` 模块。
   > 项目根目录下 `build-profile.json5` 填写 `automatic_login` 路径。其中 `XXX` 为组件存放的目录名。
   ```json5
   "modules": [
     {
       "name": "automatic_association_count",
       "srcPath": "./XXX/automatic_association_count"
     }
   ]
   ```
3. 在项目根目录 `oh-package.json5` 添加依赖。
   > `XXX` 为组件存放的目录名称。
   ```json5
   "dependencies": {
     "automatic_association_count": "file:./XXX/automatic_association_count"
   }
   ```

#### 引入组件

```typescript
import { AutomaticAssociationCount } from 'automatic_association_count';
```

#### 配置 Client ID

将元服务的 client ID 配置到项目 entry 模块的 `module.json5` 文件。

```json5
"metadata": [
   {
     // 替换应用的 clientID
     "name": "client_id",
     "value": "xxx"
   }
 ],
```

> 如需获取用户真实手机号，需要申请 phone 权限，详细参考：配置 scope 权限，并在端侧使用快速验证手机号码 Button 进行验证获取手机号码。

## API 参考

### 接口

**AutomaticAssociationCount(option: AutomaticAssociationCountOptions)**

元服务关联账号组件。

#### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | AutomaticAssociationCountOptions | 否 | 元服务登录组件的参数。 |

**AutomaticAssociationCountOptions 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| userInfo | UserInfoOptions | 是 | 用户信息 |
| isLogin | boolean | 否 | 是否登录 |

**userInfoOptions 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| authCode | string | 否 | 用户凭证 |
| avatar | string | 否 | 用户的头像 |
| idToken | string | 否 | 用户的 token |
| phoneNumber | string | 否 | 用户的手机号 |
| userName | string | 否 | 用户的昵称 |

### 事件

支持以下事件：

- **onLogin**
  ```typescript
  onLogin: (code: string) => void = () => {}
  ```
  关联账号的回调，返回用户的 authCode。

### 示例代码

```typescript
import { AutomaticAssociationCount, UserInfo } from 'automatic_association_count'

@Entry
@ComponentV2
export struct Index {
  @Local userInfo: UserInfo = {
    authCode: '',
    avatar: '',
    idToken: '',
    phoneNumber: '',
    userName: '',
  }
  @Local isLogin: boolean = false

  build() {
    Column() {
      Column() {
        Text(this.isLogin ? this.userInfo.phoneNumber : '')
        Text(this.isLogin ? this.userInfo.userName : '')
      }

      AutomaticAssociationCount({
        userInfo: this.userInfo!!,
        isLogin: this.isLogin!!,
        onLogin: (code: string) => {
          if(code !== 'err') {
            this.isLogin = true
            this.userInfo.phoneNumber = '123xxx456'
            this.userInfo.userName = '华为用户'
            console.log('code_'+ code)
          }
        },
        onLoginOut:() => {
          this.isLogin = false
          this.userInfo = new UserInfo()
        }
      })
    }
  }
}
```

## 更新记录

### 1.0.0 (2025-08-30)

- 初始版本

## 基本信息

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

**隐私政策**：不涉及  
**SDK 合规使用指南**：不涉及

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/40541ffe6bbc4c2e97319caa35e615cd/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%85%83%E6%9C%8D%E5%8A%A1%E5%85%B3%E8%81%94%E8%B4%A6%E5%8F%B7%E7%BB%84%E4%BB%B6/automatic_association_count1.0.0.zip