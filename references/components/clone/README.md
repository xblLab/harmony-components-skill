# 克隆工具组件

## 简介

本组件提供了通讯录、图片、视频的克隆和隔空投送等功能。

## 详细介绍

### 简介

本组件提供了通讯录、图片、视频的克隆和隔空投送等功能。

### 工程结构

本组件工程代码结构如下所示：

```text
clone/src/main/ets                                // 克隆工具 (har)
  |- common                                       // 模块常量   
  |- components                                   // 模块组件
  |- model                                        // 模型定义  
  |- pages                                        // 页面
  |- service                                      // 服务类
  |- utils                                        // 模块工具类
  |- viewmodel                                    // 与页面一一对应的 vm 层
  |- workers                                      // 进程
```

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.1.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.1.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.1.0(18) 及以上

#### 权限

- 获取网络权限：`ohos.permission.INTERNET`
- 读取联系人权限：`ohos.permission.READ_CONTACTS`
- 写入联系人权限：`ohos.permission.WRITE_CONTACTS`
- 读取图片视频权限：`ohos.permission.READ_IMAGEVIDEO`
- 写入图片视频权限：`ohos.permission.WRITE_IMAGEVIDEO`

#### 限制

`ohos.permission.READ_CONTACTS`、`ohos.permission.WRITE_CONTACTS`、`ohos.permission.READ_IMAGEVIDEO`、`ohos.permission.WRITE_IMAGEVIDEO` 权限均为受限权限，参考申请使用受限权限，否则会导致工具运行失败。

#### 使用

1. **安装组件**
   - 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
   - 如果是从生态市场下载组件，请参考以下步骤安装组件。
     - a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
     - b. 在项目根目录 `build-profile.json5` 添加 clone 模块。

     ```json5
     "modules": [
       {
         "name": "clone",
         "srcPath": "./xxx/clone",
       },
     ]
     ```

     - c. 在项目根目录 `oh-package.json5` 中添加依赖。

     ```json5
     "dependencies": {
       "clone": "file:./xxx/clone",
     }
     ```

## 示例代码

```arkts
@Entry
@ComponentV2
export struct Index {
   @Local pageStack: NavPathStack = new NavPathStack();

   build() {
      Navigation(this.pageStack) {
         Button('跳转').onClick(() => {
            // ClonePage 为克隆工具路由入口页面名称
            this.pageStack.pushPathByName('ClonePage', null);
         });
      }.hideTitleBar(true);
   }
}
```

## 更新记录

- **1.0.3 (2026-01-13)**
  - 下载该版本接入 @hw-agconnect/util-log 组件
- **1.0.2 (2025-12-29)**
  - 下载该版本更新已经废弃的 API
- **1.0.1 (2025-12-03)**
  - 下载该版本修复大量文件读取和传送导致的闪退。
- **1.0.0 (2025-10-23)**
  - 下载该版本初始版本

## 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |
| ohos.permission.READ_CONTACTS | 允许应用读取联系人数据。 | 允许应用读取联系人数据。 |
| ohos.permission.WRITE_CONTACTS | 允许应用添加、移除或更改联系人数据。 | 允许应用添加、移除或更改联系人数据。 |
| ohos.permission.READ_IMAGEVIDEO | 允许读取用户公共目录的图片或视频文件。 | 允许读取用户公共目录的图片或视频文件。 |
| ohos.permission.WRITE_IMAGEVIDEO | 允许修改用户公共目录的图片或视频文件。 | 允许修改用户公共目录的图片或视频文件。 |

**隐私政策**：不涉及 SDK 合规使用指南 不涉及

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| 应用类型 | 应用，元服务 |
| 设备类型 | 手机，平板，PC |
| DevEco Studio 版本 | DevEco Studio 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/f6a511bf70a64523b54485b8753d1906/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%85%8B%E9%9A%86%E5%B7%A5%E5%85%B7%E7%BB%84%E4%BB%B6/clone1.0.3.zip