# 本地影音投屏组件

## 简介

本组件提供了音频投屏、视频投屏等功能。

## 详细介绍

### 简介

本组件提供了音频投屏、视频投屏等功能。

### 工程代码结构

本组件工程代码结构如下所示：

```text
cast_tool/src/main/ets                            // 本地影音投屏 (har)  
|- components                                   // 模块组件
|- constant                                     // 常量  
|- controller                                   // 控制器  
|- model                                        // 模型定义  
|- pages                                        // 页面
|- service                                      // 服务
|- util                                         // 模块类
|- viewModels                                   // 与页面一一对应的 vm 层
```

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.5(17) 及以上

#### 权限

- **读取图片视频权限**：`ohos.permission.READ_IMAGEVIDEO`

#### 调试

本组件的投屏功能不支持使用模拟器调试，请使用真机调试。远端设备需为 HarmonyOS 5.0.0 及以上版本的 2in1 设备、HarmonyOS 3.1 及以上版本的华为智慧屏、支持标准 DLNA 协议的设备。

### 使用

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `cast_tool` 模块。

```json5
"modules": [
   {
   "name": "cast_tool",
   "srcPath": "./xxx/cast_tool",
   },
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
"dependencies": {
   "cast_tool": "file:./xxx/cast_tool",
}
```

本组件使用 `ohos.permission.READ_IMAGEVIDEO` 权限，该权限为受限权限，请申请使用受限权限。

### API 参考

无

### 示例代码

```ets
@Entry
@ComponentV2
export struct Index {
   @Local pageStack: NavPathStack = new NavPathStack();

   build() {
      Navigation(this.pageStack) {
         Button('跳转').onClick(() => {
            // CastPage 为组件路由入口页面名称
            this.pageStack.pushPathByName('CastPage', null);
         });
      }.hideTitleBar(true).mode(NavigationMode.Stack);
   }
}
```

### 更新记录

- **1.0.1 (2025-12-29)**
  - 下载该版本修改组件名称。
  - 修复状态栏部分场景下无法切换上下集的问题。
  - 接入日志组件。
- **1.0.0 (2025-12-10)**
  - 下载该版本初始版本。

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.READ_IMAGEVIDEO | 允许应用读取媒体库的图片和视频媒体文件信息 | 允许应用读取媒体库的图片和视频媒体文件信息 |

### 兼容性

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

| 项目 | 信息 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/6fdabcca50f348e9bb56768295d1448f/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%9C%AC%E5%9C%B0%E5%BD%B1%E9%9F%B3%E6%8A%95%E5%B1%8F%E7%BB%84%E4%BB%B6/cast_tool1.0.1.zip