# 解压缩组件

## 简介

本组件提供了解压、压缩等功能。

## 详细介绍

### 简介

本组件提供了解压、压缩等功能。

本组件工程代码结构如下所示：

```text
zip_tool/src/main/ets                             // 解压缩工具 (har)
  |- common                                       // 模块常量   
  |- components                                   // 模块组件
  |- model                                        // 模型定义  
  |- pages                                        // 页面
  |- utils                                        // 模块工具类
  |- viewmodel                                    // 与页面一一对应的 vm 层
```

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.5(17) 及以上

#### 权限

无

#### 限制

1. 解压缩工具支持手机软件的 zip、rar、war 格式解压，若希望支持 rar 和 war 的压缩，可将 `@ohos/oh7zip` 替换为 OpenHarmony 三方库中心仓的 `@dove/p7zip`，并做相应适配开发。
2. 解压缩工具不支持模拟器使用。

## 使用

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。
2. 在项目根目录 `build-profile.json5` 添加 zip_tool、membership、module_base、aggregated_login 模块。

```json5
"modules": [
   {
   "name": "zip_tool",
   "srcPath": "./xxx/zip_tool",
   },
   {
   "name": "membership",
   "srcPath": "./xxx/membership",
   },
   {
   "name": "module_base",
   "srcPath": "./xxx/module_base",
   },
   {
   "name": "aggregated_login",
   "srcPath": "./xxx/aggregated_login",
   },
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
"dependencies": {
   "zip_tool": "file:./xxx/zip_tool",
   "membership": "file:./xxx/membership",
   "module_base": "file:./xxx/module_base",
   "aggregated_login": "file:./xxx/aggregated_login",
}
```

配置应用内支付服务。

1. 您需开通商户服务才能开启应用内购买服务。商户服务里配置的银行卡账号、币种，用于接收华为分成收益。
2. 使用应用内购买服务前，需要打开应用内购买服务 (HarmonyOS NEXT) 开关，此开关是应用级别的，即所有使用 IAP Kit 功能的应用均需执行此步骤，详情请参考 [打开应用内购买服务 API 开关](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/iap-open-iap-kit-api-switch)。
3. 开启应用内购买服务 (HarmonyOS NEXT) 开关后，开发者需进一步激活应用内购买服务 (HarmonyOS NEXT)，具体请参见 [激活服务和配置事件通知](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/iap-activate-service-and-config-event-notification)。

（可选）用户购买商品后，IAP 服务器会在订单（消耗型/非消耗型商品）和订阅场景的某些关键事件发生时发送通知至开发者配置的订单/订阅通知接收地址，您可以根据关键事件的通知进行服务端的开发，详情请参考 [激活服务和配置事件通知](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/iap-activate-service-and-config-event-notification)。

配置会员商品信息，详情请参考 [配置商品信息](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/iap-configure-product-info)。

## 示例代码

```typescript
@Entry
@ComponentV2
export struct Index {
   @Local pageStack: NavPathStack = new NavPathStack();

   build() {
      Navigation(this.pageStack) {
         Button('跳转').onClick(() => {
            // ZipPage 为解压缩工具路由入口页面名称
            this.pageStack.pushPathByName('ZipPage', null);
         });
      }.hideTitleBar(true);
   }
}
```

## 更新记录

- **1.0.5** (2026-02-13): 下载该版本修复部分问题。
- **1.0.4** (2026-01-14): 下载该版本新增会员功能修复大文件压缩问题。
- **1.0.3** (2025-12-29): 下载该版本更新已经废弃的 API。
- **1.0.2** (2025-11-25): 下载该版本修改支持范围为：支持.rar、.war、.zip、.7z 格式文件解压和.zip、.7z 格式文件压缩。
- **1.0.1** (2025-11-06): 下载该版本 - 平板适配。- 压缩时禁止页面点击。
- **1.0.0** (2025-09-25): 下载该版本初始版本。

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

| 隐私政策 | SDK 合规使用指南 |
| :--- | :--- |
| 不涉及 | 不涉及 |

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1, 6.0.2 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1, 6.0.2 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/abb65b17dec4404788184123d648196c/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%A7%A3%E5%8E%8B%E7%BC%A9%E7%BB%84%E4%BB%B6/zip_tool1.0.5.zip