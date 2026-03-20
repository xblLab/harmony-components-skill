# 翻译组件

## 简介

本组件提供了文本翻译、语音识别的功能。支持配置文本翻译和语音翻译的服务接口认证信息，从而实现多语言翻译。支持的语言类型以配置接口为准。

## 详细介绍

### 简介

本组件提供了文本翻译、语音识别的功能。支持配置文本翻译和语音翻译的服务接口认证信息，从而实现多语言翻译。支持的语言类型以配置接口为准。

### 代码结构

本组件工程代码结构如下所示：

```text
translator/src/main/ets                           // 翻译 (har)
├── common                                        // 模块常量   
├── components                                    // 模块组件
├── model                                         // 模型定义  
├── pages                                         // 页面
├── service                                       // 服务
├── util                                          // 模块类
└── viewmodel                                     // 与页面一一对应的 vm 层
```

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.5(17) 及以上

#### 权限

- 获取网络权限：`ohos.permission.INTERNET`
- 麦克风权限：`ohos.permission.MICROPHONE`

### 使用

1. **安装组件**
   - 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
   - 如果是从生态市场下载组件，请参考以下步骤安装组件：
     - a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
     - b. 在项目根目录 `build-profile.json5` 添加 `translator` 模块。
       ```json5
       "modules": [
           {
               "name": "translator",
               "srcPath": "./xxx/translator",
           },
       ]
       ```
     - c. 在项目根目录 `oh-package.json5` 中添加依赖。
       ```json5
       "dependencies": {
           "translator": "file:./xxx/translator",
       }
       ```

2. **配置文本翻译接口**
   在 `src/main/ets/service/TranslatorService.ets` 文件中配置文本翻译对应的 Websocket 服务接口认证信息。
   - `hostUrl`、`host`、`uri` 不需要进行修改。
   - `appid`、`apiSecret`、`apiKey` 请登录讯飞开放平台，进入控制台，点击我的应用，选择“自然语言处理 > 机器翻译”，在"Websocket 服务接口认证信息”区域查询相应的信息。

3. **配置语音识别接口**
   在 `src/main/ets/util/WSUtils.ets` 文件中配置语音识别对应的 Websocket 服务接口认证信息。
   - `appid`、`apiSecret`、`apiKey` 请登录讯飞开放平台，进入控制台，点击我的应用，选择“语音识别 > 多语种识别大模型”，在"Websocket 服务接口认证信息”区域查询相应的信息。

### API 参考

无

### 示例代码

```typescript
@Entry
@ComponentV2
export struct Index {
   @Local pageStack: NavPathStack = new NavPathStack();

   build() {
      Navigation(this.pageStack) {
         Button('跳转').onClick(() => {
            // TranslatorPage 为翻译路由入口页面名称
            this.pageStack.pushPathByName('TranslatorPage', null);
         });
      }.hideTitleBar(true).mode(NavigationMode.Stack)
   }
}
```

### 更新记录

- **1.0.3** (2026-01-14)
  - 下载该版本接入 `@hw-agconnect/util-log` 组件。
- **1.0.2** (2025-12-29)
  - 下载该版本更新已经废弃的 API。
- **1.0.1** (2025-12-10)
  - 下载该版本修复部分问题。
- **1.0.0** (2025-12-04)
  - 下载该版本初始版本。

### 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| `ohos.permission.INTERNET` | 允许使用 Internet 网络 | 允许使用 Internet 网络 |
| `ohos.permission.MICROPHONE` | 允许应用使用麦克风 | 允许应用使用麦克风 |

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

### 兼容性

| 项目 | 支持版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/330daac02c634d1d9f95549f7156d086/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%BF%BB%E8%AF%91%E7%BB%84%E4%BB%B6/translator1.0.3.zip