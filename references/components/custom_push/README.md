# 推送组件

## 简介

本组件提供了推送组件功能，其中消息中心数据均为 mock 数据，实际开发中可以做借鉴使用，具体推送请对接实际业务。

## 详细介绍

### 简介

本组件提供了推送组件功能，其中消息中心数据均为 mock 数据，实际开发中可以做借鉴使用，具体推送请对接实际业务。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、平板
- **HarmonyOS 版本**：HarmonyOS 5.0.4(16) 及以上

#### 权限

- **网络权限**：`ohos.permission.INTERNET`

### 调试

本组件不支持使用模拟器调试，请使用真机进行调试。

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 中添加 `custom_push` 模块。

   ```json5
   // 在项目根目录的 build-profile.json5 填写 custom_push 路径。其中 xxx 为组件存在的目录名
   "modules": [
     {
       "name": "custom_push",
       "srcPath": "./xxx/custom_push"
     }
   ]
   ```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

   ```json5
   // xxx 为组件存放的目录名称
   "dependencies": {
     "custom_push": "file:./xxx/custom_push",
   }
   ```

#### 引入组件

```ets
import { PushKit } from 'custom_push';
```

#### 开通推送服务和申请通知消息自分类权益

1. 开启推送服务。
2. 按照需要的权益开通消息自分类权益。详细参考申请通知消息自分类权益。
3. 更改主模块的 `module.json5` 的 `client_id` 后需重新从步骤 1 申请推送服务。

#### 弹出提醒和获取 Push Token

1. 应用发送通知前需调用 `requestEnableNotification()` 方法弹出提醒，可以在主模块入口 (entry) 的 `src\main\ets\entryability\EntryAbility.ets` 的 `onWindowStageCreate()` 生命周期中弹出。

   ```ets
   notificationManager.requestEnableNotification(this.context).then(() => {
     hilog.info(0x0000, 'testTag', `[ANS] requestEnableNotification success`);
   }).catch((err: BusinessError) => {
     hilog.error(0x0000, 'testTag', `[ANS] requestEnableNotification failed, code is ${err.code}, message is ${err.message}`);
   });
   ```

2. 在主模块入口的 `src\main\ets\entryability\EntryAbility.ets` 的 `onCreate()` 生命周期中通过 `pushService.getToken()` 获取 Push Token。

   ```ets
   try {
     const pushToken = await pushService.getToken();
     AppStorage.setOrCreate('PushToken', pushToken)
     hilog.info(0x0000, 'testTag', 'Succeeded in getting push token');
   } catch (err) {
     let e: BusinessError = err as BusinessError;
     hilog.error(0x0000, 'testTag', 'Failed to get push token: %{public}d %{public}s', e.code, e.message);
   }
   ```

可在此上报 Push Token 到服务端，调试状态可打印出 `pushToken` 后手动放入 `custom_push\src\main\ets\pushKitForJava\messageBody.json` 的 `token` 中，详细参考获取 Push Token。

   ```json5
   "target": {
      "token": ["xxx"]
   }
   ```

#### 配置 skills 标签

在主模块入口 (`src\main\ets\entryability\module.json5`) 的中查看不同的能力：

- `"actions": "action.system.home"` 进入应用首页
- `"actions": "com.test.action"` 进入应用首页

为 `module.json5` 文件中 `skills-->actions` 新增 action。

   ```json5
   "skills": [
       {
         "actions": [
           "com.test.action"
         ]
       }
     ]
   ```

`custom_push\src\main\ets\pushKitForJava\messageBody.json` 中的 `action` 赋相同值。

   ```json5
   "clickAction": {
     "action": "com.test.action",
   },
   ```

#### 获取服务账号密钥文件

获取服务账号密钥文件 (`custom_push\src\main\ets\pushKitForJava\serviceAccountPrivateKey.json`)，详细参考获取服务账号密钥文件中的开发步骤 1。

1. 将获取到的服务账号密钥文件命名为 `serviceAccountPrivateKey.json` 替换原有文件。
2. 获取服务账号密钥文件后手动去除 `"private_key"` 字段的 `'-----BEGIN PRIVATE KEY-----\n'` 和 `'\n-----END PRIVATE KEY-----\n'` 或在 `JsonWebTokenFactory.java` 中去除。
3. 将 `pushKitForJava` 所有文件放入 java 项目中，项目结构如图显示。
4. 检查 `JsonWebTokenFactory.java` 中的路径并将 `String url` 中的项目 id 替换为 `serviceAccountPrivateKey.json` 的 `project_id`。
5. 运行 `JsonWebTokenFactory.java` 即可收到推送。

#### 修改推送内容

修改 `custom_push\src\main\ets\pushKitForJava\messageBody.json`，详细参考发送通知消息开发步骤 4 请求示例。

推送内容示例，本示例通过 `title`、`body`、`actionType` 实现打开应用首页并设置标题为 BookReadTitle，内容为 BookReadContent。

   ```json5
   {
      "payload": {
         "notification": {
            "category": "EXPRESS",
            "title": "BookReadTitle",
            "body": "内容为 BookReadContent",
            "badge": {
               "addNum": 1,
               "setNum": 1
            },
            "clickAction": {
               "actionType": 0,
               "action": "com.test.action",
               "pushData": {
                  "pushContent": "亲爱的用户您好~2025.06.26 24:00:00-02:00 进行安全升级，部分评价功能将无法使用，给您带来不便万分抱歉！感谢您的理解和支持！",
                  "time": "2 小时前"
               }
            },
            "foregroundShow": true
         }
      },
      "target": {
         "token": ["xxx"]
      }
   }
   ```

#### 推送流程

1. 后端发送推送消息。
2. 主模块入口的 `src\main\module.json5` 通过 skill 添加 actions 字段。在 `onCreate` 方法中获得推送消息内容并全局存储，可打印 `want.parameters` 查看具体结构。

   ```ets
   const pushData: PushData = {
      pushContent: want.parameters?.content as string,
      time: want.parameters?.time as string,
      read: false
   }
   AppStorage.setOrCreate('pushData', data)
   ```

3. 在 `onCreate` 方法中标记为此次应用拉起方式为内页拉起，后在主模块入口的 `src\main\ets\pages\Index.ets` 中路由至消息中心页面。

   ```ets
   AppStorage.setOrCreate('takeMessage', 1)
   ```

   ```ets
   aboutToAppear(): void {
     if (AppStorage.get('takeMessage') === 1) {
       TCRouter.push(Constants.MESSAGE_PAGE_ROUTE)
     }
   }
   ```

## API 参考

详细 API 请参考 push kit api。

## 示例代码

```ets
import { PushKit } from 'custom_push';

@Entry
@ComponentV2
struct Index {
  
  build() {
    NavDestination(){
      PushKit({
        // 传入路由栈
      })
    }
    .hideTitleBar(true)
    .hideBackButton(true)
  }
}
```

## 更新记录

| 版本 | 日期 | 描述 |
| :--- | :--- | :--- |
| 1.0.2 | 2026-01-13 | 适配折叠屏和平板 |
| 1.0.1 | 2025-08-29 | 优化 README |
| 1.0.0 | 2025-07-30 | 初始版本 |

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

### HarmonyOS 版本

| 版本 |
| :--- |
| 5.0.4 |
| 5.0.5 |
| 5.1.0 |
| 5.1.1 |
| 6.0.0 |
| 6.0.1 |

### 应用类型

| 类型 |
| :--- |
| 应用 |
| 元服务 |

### 设备类型

| 类型 |
| :--- |
| 手机 |
| 平板 |
| PC |

### DevEco Studio 版本

| 版本 |
| :--- |
| DevEco Studio 5.0.4 |
| DevEco Studio 5.0.5 |
| DevEco Studio 5.1.0 |
| DevEco Studio 5.1.1 |
| DevEco Studio 6.0.0 |
| DevEco Studio 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/2e0da975bc454793a2ad6a4d55a5cedb/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%8E%A8%E9%80%81%E7%BB%84%E4%BB%B6/custom_push1.0.2.zip