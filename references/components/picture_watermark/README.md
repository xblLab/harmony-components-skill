# 图片水印组件

## 简介

本组件提供了图片添加水印、下载保存相册、历史添加缓存等功能。

## 详细介绍

### 简介

本组件提供了图片添加水印、下载保存相册、历史添加缓存等功能。

### 工程结构

本组件工程代码结构如下所示：

```text
picture_watermark/src/main/ets                    // 图片水印(har)
|- constants                                    // 模块常量定义   
|- components                                   // 模块组件
|- types                                        // 模型定义  
|- pages                                        // 页面
|- utils                                        // 模块工具类
|- viewmodel                                    // 与页面一一对应的 vm 层
```

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.5(17) 及以上

### 使用

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 picture_watermark 模块。

```json5
// 项目根目录下 build-profile.json5 填写 picture_watermark 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
  "name": "picture_watermark",
  "srcPath": "./XXX/picture_watermark"
  }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名
"dependencies": {
    "picture_watermark": "file:./XXX/picture_watermark"
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
            // WaterMarksShow 为添加水印路由入口页面名称
            this.pageStack.pushPathByName('WaterMarksShow', null);
         });
      }.hideTitleBar(true);
   }
}
```

### 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.2 | 2026-01-13 | 下载该版本接入 @hw-agconnect/util-log 组件 |
| 1.0.1 | 2025-12-29 | 下载该版本更新已经废弃的 API |
| 1.0.0 | 2025-11-03 | 初始版本 |

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

### 基本信息

| 项目 | 内容 |
| :--- | :--- |
| 应用类型 | 应用 |
| 元服务 | 是 |

### 兼容性

| 项目 | 支持版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/4ef29e6d1eda466b94f0fc221d71726f/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%9B%BE%E7%89%87%E6%B0%B4%E5%8D%B0%E7%BB%84%E4%BB%B6/picture_watermark1.0.2.zip