# 隐私笔记组件

## 简介

本组件提供了写笔记、编辑笔记、删除笔记、笔记分类、搜索、多选、排序、分享、复制等功能。

## 详细介绍

### 简介
本组件提供了写笔记、编辑笔记、删除笔记、笔记分类、搜索、多选、排序、分享、复制等功能。

首页新建笔记笔记分类分享、复制操作

### 代码结构

本组件工程代码结构如下所示：

深色代码主题复制
```text
personal_notes/src/main/ets                       // 隐私笔记 (har)
  |- commons                                      // 模块常量定义   
  |- components                                   // 模块组件
  |- models                                       // 模型定义  
  |- pages                                        // 页面
  |- utils                                        // 模块工具类
  |- viewmodel                                    // 与页面一一对应的 vm 层 
  |- controller                                   // 模块控制器 
```

## 约束和限制

### 环境

- DevEco Studio 版本：DevEco Studio 5.0.5 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.5 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- HarmonyOS 版本：HarmonyOS 5.0.5(17) 及以上

### 权限

无

## 使用

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。

如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。

b. 在项目根目录 build-profile.json5 添加 personal_notes 模块。

深色代码主题复制
```json5
"modules": [
   {
      "name": "personal_notes",
      "srcPath": "./xxx/personal_notes",
   },
]
```

c. 在项目根目录 oh-package.json5 中添加依赖

深色代码主题复制
```json5
"dependencies": {
   "personal_notes": "file:./xxx/personal_notes",
}
```

## 示例代码

深色代码主题复制
```typescript
@Entry
@ComponentV2
export struct Index {
   @Local pageStack: NavPathStack = new NavPathStack();

   build() {
      Navigation(this.pageStack) {
         Button('跳转').onClick(() => {
            // PersonalNotesPage 为隐私笔记路由入口页面名称
            this.pageStack.pushPathByName('PersonalNotesPage', null);
         });
      }.hideTitleBar(true);
   }
}
```

## 更新记录

### 1.0.0 (2025-09-25)

Created with Pixso.

基本信息
权限名称  权限说明  使用目的
无  无  无

隐私政策 不涉及

SDK 合规使用指南 不涉及

兼容性
HarmonyOS 版本  5.0.5

Created with Pixso.

应用类型  应用

Created with Pixso.

元服务

Created with Pixso.

设备类型  手机

Created with Pixso.

平板

Created with Pixso.

PC

Created with Pixso.

DevEcoStudio 版本  DevEco Studio 5.0.5

Created with Pixso.

DevEco Studio 5.1.0

Created with Pixso.

DevEco Studio 5.1.1

Created with Pixso.

DevEco Studio 6.0.0

Created with Pixso.

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/cd52767dea37459d92639092b5b1709f/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%9A%90%E7%A7%81%E7%AC%94%E8%AE%B0%E7%BB%84%E4%BB%B6/personal_notes1.0.0.zip