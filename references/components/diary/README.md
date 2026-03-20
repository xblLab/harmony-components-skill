# 日记组件

## 简介

本组件提供了写日记、编辑日记、删除日记、私密日记等功能。

## 详细介绍

### 功能简介

本组件提供了写日记、编辑日记、删除日记、私密日记等功能。

**主要功能入口：**
首页、写日记、日记详情、设置、私密日记、密码、操作

### 工程结构

本组件工程代码结构如下所示：

```text
diary/src/main/ets                                // 日记 (har)
 |- commons                                      // 模块常量定义   
 |- components                                   // 模块组件
 |- controller                                   // 模块控制器
 |- database                                     // 本地持久化缓存
 |- models                                       // 模型定义
 |- pages                                        // 页面
 |- utils                                        // 模块工具类  
 |- viewmodel                                    // 与页面一一对应的 vm 层 
```

### 约束和限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.5(17) 及以上

#### 权限

无

## 使用

### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `diary` 模块。

```json5
"modules": [
   {
      "name": "diary",
      "srcPath": "./xxx/diary",
   },
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
"dependencies": {
   "diary": "file:./xxx/diary",
}
```

## 示例代码

```typescript
@Entry
@ComponentV2
export struct Index {
  @Local pageStack: NavPathStack = new NavPathStack();

  build() {
     Navigation(this.pageStack) {
        Button('跳转').onClick(() => {
           // DiaryPage 为日记路由入口页面名称
           this.pageStack.pushPathByName('DiaryPage', null);
        });
     }.hideTitleBar(true);
  }
}
```

## 更新记录

### 1.0.3 (2026-01-13)
- 下载该版本
- 修复 web 富文本编辑器中图片不展示的问题
- 接入 @hw-agconnect/util-log 组件
- 废弃 api 整改

### 1.0.1 (2025-10-23)
- 下载该版本
- 修复日记详情页富文本样式丢失的问题
- 修复日记编写页面插入图片时，尺寸没有自适应的问题

### 1.0.0 (2025-09-25)
- 下载该版本
- 初始版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

### 兼容性

| 项目 | 支持情况 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用、元服务 |
| **设备类型** | 手机、平板、PC |
| **DevEco Studio 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/92a7f15954414f81afd9355037ff533d/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%97%A5%E8%AE%B0%E7%BB%84%E4%BB%B6/diary1.0.3.zip