# 证件照组件

## 简介

本组件提供了证件照生成、背景更换、服装更换、证件照保存等功能。

## 详细介绍

### 简介

本组件提供了证件照生成、背景更换、服装更换、证件照保存等功能。

### 工程结构

本组件工程代码结构如下所示：

```text
credentials_photo/src/main/ets                    // 证件照 (har)
  |- components                                   // 模块组件
  |- constant                                     // 常量 
  |- model                                        // 模型定义  
  |- pages                                        // 页面
  |- util                                         // 模块工具类 
  |- viewModels                                   // 与页面一一对应的 vm 层  
```

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.5(17) 及以上

#### 调试

证件照拍摄和人像分离能力，不能使用模拟器调试，请使用真机调试。

### 使用

安装组件。
如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 credentials_photo 模块。

    ```json5
    "modules": [
       {
       "name": "credentials_photo",
       "srcPath": "./xxx/credentials_photo",
       },
    ]
    ```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

    ```json5
    "dependencies": {
       "credentials_photo": "file:./xxx/credentials_photo",
    }
    ```

### 示例代码

```typescript
@Entry
@ComponentV2
export struct Index {
   @Local pageStack: NavPathStack = new NavPathStack();

   build() {
      Navigation(this.pageStack) {
         Button('跳转').onClick(() => {
            // CredentialsPage 为证件照路由入口页面名称
            this.pageStack.pushPathByName('CredentialsPage', null);
         });
      }.hideTitleBar(true)
         .mode(NavigationMode.Stack);
   }
}
```

### 更新记录

#### 1.0.1 (2026-01-13)

Created with Pixso.

下载该版本接入@hw-agconnect/util-log

#### 1.0.0 (2025-11-25)

Created with Pixso.

下载该版本初始版本

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

#### 兼容性

| 项目 | 支持情况 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/8cd80593bfef44c0aa7c0aefc27a6165/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%AF%81%E4%BB%B6%E7%85%A7%E7%BB%84%E4%BB%B6/credentials_photo1.0.1.zip