# 拨号组件

## 简介

本组件为拨号组件，可根据传入的电话号码拉起拨号弹窗，并在确认后自动拉起拨号面板。

## 详细介绍

### 简介

本组件为拨号组件，可根据传入的电话号码拉起拨号弹窗，并在确认后自动拉起拨号面板。

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio5.0.4 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS5.0.4 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 5.0.4(16) 及以上

### 快速入门

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_ui_base` 和 `module_call_dialog` 模块。

深色代码主题复制
```json5
// 项目根目录下 build-profile.json5 填写 module_module_ui_base 和 module_call_dialog 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_ui_base",
    "srcPath": "./XXX/module_ui_base"
  },
  {
    "name": "module_call_dialog",
    "srcPath": "./XXX/module_call_dialog"  
  }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

深色代码主题复制
```json5
// 在项目根目录 oh-package.json5 中添加依赖
"dependencies": {
  "module_call_dialog": "file:./XXX/module_call_dialog",
}
```

引入组件。

深色代码主题复制
```typescript
import { CallDialog } from 'module_call_dialog';
```

调用组件，详见示例代码。详细参数配置说明参见 API 参考。

## API 参考

### CallDialog(options: CallDialogOptions)

#### CallDialogOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| customUI | CustomBuilder | 是 | 关联半模态拨号弹窗的自定义 UI，点击可拉起弹窗展示待呼叫的号码，默认为一个按钮。 |
| phoneNumber | string | 是 | 拨号号码，默认为 '' |
| themeColor | ResourceColor | 是 | 半模态弹框主题色，默认为 #0A59F7。 |

### 示例代码

深色代码主题复制
```typescript
import { CallDialog } from 'module_call_dialog'

@Entry
@ComponentV2
struct CallDialogPreview {
  build() {
    Column() {
      CallDialog({
        phoneNumber: '123456',
        themeColor: '#008c8c',
      }) {
        Button('这是一个拨号按钮')
      }
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}
```

## 更新记录

### 1.0.1 (2025-11-07)

Created with Pixso.

下载该版本修改 README，修复平板展示问题

### 1.0.0 (2025-11-03)

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

## 兼容性

### HarmonyOS 版本

| 版本 | 备注 |
| :--- | :--- |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |
| 5.1.0 | Created with Pixso. |
| 5.1.1 | Created with Pixso. |
| 6.0.0 | Created with Pixso. |

### 应用类型

| 类型 | 备注 |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

### 设备类型

| 类型 | 备注 |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

### DevEcoStudio 版本

| 版本 | 备注 |
| :--- | :--- |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c88149c69638437cb053d3ae88970075/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%8B%A8%E5%8F%B7%E7%BB%84%E4%BB%B6/module_call_dialog1.0.1.zip