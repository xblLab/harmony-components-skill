# 修图神器组件

## 简介

本组件提供了滤镜相机、图片拼接、图片编辑的功能。

## 详细介绍

### 简介

本组件提供了滤镜相机、图片拼接、图片编辑的功能。

### 约束与限制

#### 环境

- DevEco Studio版本：DevEco Studio 5.0.5 Release及以上
- HarmonyOS SDK版本：HarmonyOS 5.0.5 Release SDK及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- HarmonyOS版本：HarmonyOS 5.0.5(17)及以上

#### 权限

获取相机权限：ohos.permission.CAMERA。

### 使用

1. 安装组件。

   如果是在DevEco Studio使用插件集成组件，则无需安装组件，请忽略此步骤。
   
   如果是从生态市场下载组件，请参考以下步骤安装组件。
   
   a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的xxx目录下。
   
   b. 在项目根目录build-profile.json5添加photo_editing、membership、module_base、aggregated_login。
   
   ```json5
   "modules": [
     {
       "name": "photo_editing",
       "srcPath": "./xxx/photo_editing",
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
   
   c. 在项目根目录oh-package.json5中添加依赖
   
   ```json5
   "dependencies": {
     "photo_editing": "file:./xxx/photo_editing",
     "membership": "file:./xxx/membership",
     "module_base": "file:./xxx/module_base",
     "aggregated_login": "file:./xxx/aggregated_login",
   }
   ```

2. 配置应用内支付服务。

   a. 您需开通商户服务才能开启应用内购买服务。商户服务里配置的银行卡账号、币种，用于接收华为分成收益。
   
   b. 使用应用内购买服务前，需要打开应用内购买服务(HarmonyOS NEXT) 开关，此开关是应用级别的，即所有使用IAP Kit功能的应用均需执行此步骤，详情请参考打开应用内购买服务API开关。
   
   c. 开启应用内购买服务(HarmonyOS NEXT) 开关后，开发者需进一步激活应用内购买服务 (HarmonyOS NEXT)，具体请参见激活服务和配置事件通知。

3. （可选）用户购买商品后，IAP服务器会在订单（消耗型/非消耗型商品）和订阅场景的某些关键事件发生时发送通知至开发者配置的订单/订阅通知接收地址，您可以根据关键事件的通知进行服务端的开发，详情请参考激活服务和配置事件通知。

4. 配置会员商品信息，详情请参考配置商品信息。

### 示例代码

```typescript
@Entry
@ComponentV2
export struct Index {
  @Local pageStack: NavPathStack = new NavPathStack();

  build() {
    Navigation(this.pageStack) {
      Button('跳转').onClick(() => {
        // PhotoEditing为修图神器路由入口页面名称
        this.pageStack.pushPathByName('PhotoEditing', null);
      });
    }.hideTitleBar(true).mode(NavigationMode.Stack);
  }
}
```

### 更新记录

#### 1.0.4（2026-02-13）

修复部分依赖缺失的问题。

#### 1.0.3（2026-01-13）

新增会员功能。

#### 1.0.2（2025-12-29）

修复固定拼接未限制图片数量问题。

#### 1.0.1（2025-12-03）

修复部分兼容性问题。

#### 1.0.0（2025-09-25）

初始版本。

### 权限与隐私

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
|---------|---------|---------|
| ohos.permission.CAMERA | 允许应用使用相机 | 允许应用使用相机 |

#### 隐私政策

不涉及

#### SDK合规使用指南

不涉及

### 兼容性

#### HarmonyOS版本

| 版本 | 支持 |
|-----|------|
| 5.0.5 | ✓ |
| 5.1.0 | ✓ |
| 5.1.1 | ✓ |
| 6.0.0 | ✓ |
| 6.0.1 | ✓ |
| 6.0.2 | ✓ |

#### 应用类型

| 类型 | 支持 |
|-----|------|
| 应用 | ✓ |
| 元服务 | ✓ |

#### 设备类型

| 类型 | 支持 |
|-----|------|
| 手机 | ✓ |
| 平板 | ✓ |
| PC | ✓ |

#### DevEco Studio版本

| 版本 | 支持 |
|-----|------|
| DevEco Studio 5.0.5 | ✓ |
| DevEco Studio 5.1.0 | ✓ |
| DevEco Studio 5.1.1 | ✓ |
| DevEco Studio 6.0.0 | ✓ |
| DevEco Studio 6.0.1 | ✓ |
| DevEco Studio 6.0.2 | ✓ |

## 来源

- 原始URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c894fd557262442187337da4f9b356e9/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E4%BF%AE%E5%9B%BE%E7%A5%9E%E5%99%A8%E7%BB%84%E4%BB%B6/photo_editing1.0.4.zip