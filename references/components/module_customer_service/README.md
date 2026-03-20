# 在线客服组件

## 简介

本组件提供了在线客服的功能。

## 详细介绍

### 简介

本组件提供了在线客服的功能。

### 环境

- DevEco Studio 版本：DevEco Studio 5.0.5 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.5 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 5.0.5(17) 及以上

### 快速入门

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 build-profile.json5 添加 module_customer_service 模块。

深色代码主题复制
```json5
// 在项目根目录 build-profile.json5 填写 module_customer_service。其中 XXX 为组件存放的目录名。
"modules": [
   {
      "name": "module_customer_service",
      "srcPath": "./XXX/module_customer_service",
   }
 ]
```

c. 在项目根目录 oh-package.json5 中添加依赖。

深色代码主题复制
```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_customer_service": "file:./XXX/module_customer_service"
 }
```

引入在线客服组件句柄。

深色代码主题复制
```typescript
import { CustomerServicePage } from 'module_customer_service';
```

调用组件，详见示例代码。详细参数配置说明参见 API 参考。

深色代码主题复制
```typescript
CustomerServicePage()
```

## API 参考

### 接口

**CustomerServicePage(options?:CustomerServiceOptions)**
在线客服组件。

**CustomerServiceOptions 函数说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| customerServicecancelCallBack | （）=>void | 是 | 返回页面的回调函数 |

## 示例代码

深色代码主题复制
```typescript
import { CustomerServicePage } from 'module_customer_service';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Pagechat {
  @State message: string = 'Hello World';

  build() {
    NavDestination() {
      Row() {
        Text('客服小燕')
          .fontSize(21)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .expandSafeArea([SafeAreaType.KEYBOARD, SafeAreaType.SYSTEM])

      CustomerServicePage({
        customerServicecancelCallBack: () => {
          router.back()
        }
      })
    }
    .padding({left: 20, right: 20})
    .hideTitleBar(true)
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}
```

## 更新记录

- **1.0.1 (2026-01-06)**
  
  Created with Pixso.
  
  下载该版本修复输入框获取光标后消息展示不全问题
  
- **1.0.0 (2025-12-15)**
  
  Created with Pixso.
  
  下载该版本初始版本

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

- **HarmonyOS 版本**
  - 5.0.5
    Created with Pixso.
  - 5.1.0
    Created with Pixso.
  - 5.1.1
    Created with Pixso.
  - 6.0.0
    Created with Pixso.
  - 6.0.1
    Created with Pixso.

### 应用类型

- 应用
  Created with Pixso.
- 元服务
  Created with Pixso.

### 设备类型

- 手机
  Created with Pixso.
- 平板
  Created with Pixso.
- PC
  Created with Pixso.

### DevEcoStudio 版本

- DevEco Studio 5.0.5
  Created with Pixso.
- DevEco Studio 5.1.0
  Created with Pixso.
- DevEco Studio 5.1.1
  Created with Pixso.
- DevEco Studio 6.0.0
  Created with Pixso.
- DevEco Studio 6.0.1
  Created with Pixso.

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/35bee9a0cfcb4cf5b6f115342cbd2d16/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%9C%A8%E7%BA%BF%E5%AE%A2%E6%9C%8D%E7%BB%84%E4%BB%B6/module_customer_service1.0.1.zip