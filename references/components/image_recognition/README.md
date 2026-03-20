# 图文识别组件

## 简介

本组件提供了文字识别、二维码扫描、票据识别、卡证识别等功能。

## 详细介绍

### 简介

本组件提供了文字识别、二维码扫描、票据识别、卡证识别等功能。

### 工程结构

本组件工程代码结构如下所示：

```text
image_recognition/src/main/ets                    // 图文识别 (har)  
|- components                                   // 模块组件
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

#### 权限

- **相机权限**：ohos.permission.CAMERA

#### 调试

图文识别的扫描和识别功能均需调用相机，不能使用模拟器调试，请使用真机调试。

#### 使用

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。
2. 在项目根目录 `build-profile.json5` 添加 image_recognition 模块。

```json5
"modules": [
   {
   "name": "image_recognition",
   "srcPath": "./xxx/image_recognition",
   },
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
"dependencies": {
   "image_recognition": "file:./xxx/image_recognition",
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
           // RecognitionHomePage 为图文识别路由入口页面名称
           this.pageStack.pushPathByName('RecognitionHomePage', null);
        });
     }.hideTitleBar(true)
        .mode(NavigationMode.Stack);
  }
}
```

## 更新记录

### 1.0.0 (2025-11-06)

下载该版本初始版本

权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 权限与隐私 | ohos.permission.CAMERA | 允许应用使用相机。 | 允许应用使用相机。 |
| 隐私政策 | - | 不涉及 | - |
| SDK 合规使用指南 | - | 不涉及 | - |

Created with Pixso.

兼容性

| HarmonyOS 版本 |
| :--- |
| 5.0.5 |

Created with Pixso.

| 5.1.0 |
| :--- |

Created with Pixso.

| 5.1.1 |
| :--- |

Created with Pixso.

| 6.0.0 |
| :--- |

Created with Pixso.

| 应用类型 |
| :--- |
| 应用 |

Created with Pixso.

| 元服务 |
| :--- |

Created with Pixso.

| 设备类型 |
| :--- |
| 手机 |

Created with Pixso.

| 平板 |
| :--- |

Created with Pixso.

| PC |
| :--- |

Created with Pixso.

| DevEcoStudio 版本 |
| :--- |
| DevEco Studio 5.0.5 |

Created with Pixso.

| DevEco Studio 5.1.0 |
| :--- |

Created with Pixso.

| DevEco Studio 5.1.1 |
| :--- |

Created with Pixso.

| DevEco Studio 6.0.0 |
| :--- |

Created with Pixso.

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/d76f949061ef4e7cafe217180115c2f4/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%9B%BE%E6%96%87%E8%AF%86%E5%88%AB%E7%BB%84%E4%BB%B6/image_recognition1.0.0.zip