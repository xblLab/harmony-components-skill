# 录音专家组件

## 简介

本组件提供了录音、音频格式转换、音频转文字、音频编辑等功能。

## 详细介绍

### 简介

本组件提供了录音、音频格式转换、音频转文字、音频编辑等功能。

本组件工程代码结构如下所示：

```text
simple_recorder/src/main/ets                      // 录音专家(har) 
  |- components                                   // 模块组件
  |- model                                        // 模型定义  
  |- pages                                        // 页面
  |- util                                         // 模块类
  |- viewModels                                   // 与页面一一对应的vm层
  |- workers                                      // 工作线程
```

### 约束与限制

#### 环境

- DevEco Studio版本：DevEco Studio 5.0.5 Release及以上
- HarmonyOS SDK版本：HarmonyOS 5.0.5 Release SDK及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- HarmonyOS版本：HarmonyOS 5.0.5(17)及以上

#### 权限

- 麦克风权限：ohos.permission.MICROPHONE

#### 调试

录音专家的音频转文字功能不能使用模拟器调试，请使用真机调试。

### 使用

安装组件。

如果是在DevEco Studio使用插件集成组件，则无需安装组件，请忽略此步骤。

如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的xxx目录下。

b. 在项目根目录build-profile.json5添加simple_recorder模块。

```json5
"modules": [
   {
   "name": "simple_recorder",
   "srcPath": "./xxx/simple_recorder",
   },
]
```

c. 在项目根目录oh-package.json5中添加依赖

```json5
"dependencies": {
   "simple_recorder": "file:./xxx/simple_recorder",
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
            // RecorderHomePage为录音专家路由入口页面名称
            this.pageStack.pushPathByName('RecorderHomePage', null);
         });
      }.hideTitleBar(true)
         .mode(NavigationMode.Stack);
   }
}
```

### 更新记录

#### 1.0.4（2026-02-13）

下载该版本优化对超长音频进行音频变速的处理效率。增加音频变速的时长限制。

#### 1.0.3（2026-01-14）

下载该版本废弃api修改替换。优化保存音频时的性能。修复较大音频编辑时频谱数据过多导致的闪退。

#### 1.0.2（2025-11-06）

下载该版本修复平板下半模态框显示异常的问题。

#### 1.0.1（2025-10-23）

下载该版本修复点击跳转保存并编辑跳转时触发崩溃的问题。修复变速时快速双击保存触发崩溃的问题。

#### 1.0.0（2025-09-25）

下载该版本初始版本

### 权限与隐私

| 基本信息 | |
|---------|---|
| 权限名称 | 权限说明 | 使用目的 |
| ohos.permission.MICROPHONE | 允许应用使用麦克风 | 允许应用使用麦克风 |

隐私政策：不涉及

SDK合规使用指南：不涉及

### 兼容性

| HarmonyOS版本 | 5.0.5 | 5.1.0 | 5.1.1 | 6.0.0 | 6.0.1 | 6.0.2 |
|-------------|-------|-------|-------|-------|-------|-------|

| 应用类型 | 应用 | 元服务 |
|---------|------|--------|

| 设备类型 | 手机 | 平板 | PC |
|---------|------|------|-----|

| DevEcoStudio版本 | DevEco Studio 5.0.5 | DevEco Studio 5.1.0 | DevEco Studio 5.1.1 | DevEco Studio 6.0.0 | DevEco Studio 6.0.1 | DevEco Studio 6.0.2 |
|---------------|---------------------|---------------------|---------------------|---------------------|---------------------|---------------------|

## 来源

- 原始URL: https://developer.huawei.com/consumer/cn/market/prod-detail/190b10e8d96d4ab6a7e95e7914ef86b7/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%BD%95%E9%9F%B3%E4%B8%93%E5%AE%B6%E7%BB%84%E4%BB%B6/simple_recorder1.0.4.zip