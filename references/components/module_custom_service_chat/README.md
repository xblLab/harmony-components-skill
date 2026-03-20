# 客服聊天组件

## 简介

本组件提供客服聊天组件，提供聊天交互界面。

## 详细介绍

### 简介

本组件提供客服聊天组件，提供聊天交互界面。

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.1 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.1 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 5.0.1(13) 及以上

#### 权限

- 网络权限：ohos.permission.INTERNET

### 使用

#### 安装组件

安装组件。
如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 build-profile.json5 添加 module_ui_base 和 module_custom_service_chat 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_ui_base 和 module_custom_service_chat 路径。其中 XXX 为组件存放的目录名
{
  "modules": [
    {
      "name": "module_ui_base",
      "srcPath": "./XXX/module_ui_base"
    },
    {
      "name": "module_custom_service_chat",
      "srcPath": "./XXX/module_custom_service_chat"
    }
  ]
}
```

```json5
// 在项目根目录 oh-package.json5 中添加依赖
{
  "dependencies": {
    "module_custom_service_chat": "file:./XXX/module_custom_service_chat"
  }
}
```

#### 引入组件

```typescript
import { ChatView } from 'module_custom_service_chat';
```

#### 调用组件

调用组件，详细参数配置说明参见 API 参考。

### API 参考

#### ChatView

`ChatView(options: ChatViewOptions)`
客服聊天组件。

#### ChatViewOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| serviceAvatarResourceStr | | 否 | 客服头像 |
| serviceName | string | 否 | 客服名称 |
| userAvatarResourceStr | | 否 | 用户头像 |

### 示例代码

```typescript
import { KeyboardAvoidMode } from '@ohos.arkui.UIContext';
import { ChatView } from 'module_custom_service_chat';

@Entry
@ComponentV2
struct Chat {
  onPageShow(): void {
    this.getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE_WITH_CARET)
  }

  onPageHide(): void {
    this.getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.OFFSET_WITH_CARET)
  }

  build() {
    Column() {
      ChatView({
        serviceAvatar: $r('app.media.startIcon'),
        serviceName: '小艺',
        userAvatar: $r('app.media.ic_default_avatar'),
      })
    }
    .height('100%')
    .width('100%')
  }
}
```

## 更新记录

- **1.0.1** (2026-01-13)
  - 下载该版本
- **1.0.0** (2025-12-10)
  - 废弃 API 整改
  - 下载该版本

## 权限与隐私

### 基本信息

- **权限名称**: ohos.permission.INTERNET
- **权限说明**: 允许使用 Internet 网络
- **使用目的**: 允许使用 Internet 网络
- **隐私政策**: 不涉及
- **SDK 合规使用指南**: 不涉及

### 兼容性

- **HarmonyOS 版本**:
  - 5.0.1
  - 5.0.2
  - 5.0.3
  - 5.0.4
  - 5.0.5
  - 5.1.0
  - 5.1.1
  - 6.0.0
  - 6.0.1
- **应用类型**:
  - 应用
  - 元服务
- **设备类型**:
  - 手机
  - 平板
  - PC
- **DevEco Studio 版本**:
  - DevEco Studio 5.0.1
  - DevEco Studio 5.0.2
  - DevEco Studio 5.0.3
  - DevEco Studio 5.0.4
  - DevEco Studio 5.0.5
  - DevEco Studio 5.1.0
  - DevEco Studio 5.1.1
  - DevEco Studio 6.0.0
  - DevEco Studio 6.0.1

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/395a219c56754a58b4d6d07f54c848ed/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%AE%A2%E6%9C%8D%E8%81%8A%E5%A4%A9%E7%BB%84%E4%BB%B6/module_custom_service_chat1.0.1.zip