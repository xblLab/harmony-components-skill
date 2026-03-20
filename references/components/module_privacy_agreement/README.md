# 申请权限许可组件

## 简介

本组件为申请权限许可组件，可在应用首启需要用户同意隐私政策和其他协议时使用。

## 详细介绍

### 简介

本组件为申请权限许可组件，可在应用首启需要用户同意隐私政策和其他协议时使用。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

### 快速入门

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_ui_base` 和 `module_privacy_agreement` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_module_ui_base 和 module_privacy_agreement 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_ui_base",
    "srcPath": "./XXX/module_ui_base"
  },
  {
    "name": "module_privacy_agreement",
    "srcPath": "./XXX/module_privacy_agreement"  
  }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// 在项目根目录 oh-package.json5 中添加依赖
"dependencies": {
  "module_privacy_agreement": "file:./XXX/module_privacy_agreement",
}
```

引入组件。

```typescript
import { PrivacyAgreementView } from 'module_privacy_agreement';
```

调用组件，详见示例代码。详细参数配置说明参见 API 参考。

## API 参考

### PrivacyAgreementView(options: PrivacyAgreementViewOptions)

#### PrivacyAgreementViewOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| stackNavPath | Stack | 否 | 使用评价组件的页面的路由栈，不传参可能会导致路由跳转异常 |
| appIconResourceStr | Str | 否 | 应用图标，默认为空 |
| appNameResourceStr | Str | 否 | 应用名称，默认为空 |
| appDescResourceStr | Str | 否 | 应用描述，默认为空 |
| themeColorResourceColor | Color | 否 | 主题颜色，按钮使用的主题色，默认为 #0A59F7 |
| privacySummaryResourceStr | Str | 否 | 提醒用户同意业务与隐私声明的文案，默认文案：'本应用需联网，调用 XX、XX 权限，获取 XX 信息，以为您提供 XX 服务。我们仅在您使用具体功能业务时，才会触发上述行为收集使用相关的个人信息。详情请参阅' |
| privacyLinkDescResourceStr | Str | 否 | 可打开业务与隐私声明的链接文案，默认文案：'XX 业务与隐私的声明、权限使用说明' |
| privacyLinkResourceStr | Str | 否 | 业务与隐私声明的链接，默认链接：$rawfile('privacy-statement.html') |
| handleConfirm() => void | void | 否 | 用户确认同意后的回调事件 |

## 示例代码

```typescript
import { PrivacyAgreementView } from 'module_privacy_agreement'
import { preferences } from '@kit.ArkData'

@Entry
@ComponentV2
struct PrivacyAgreementPreview {
  @Local
  stack: NavPathStack = new NavPathStack()

  aboutToAppear(): void {
    this.stack.pushPath({ name: 'PrivacyPage' })
  }

  @Builder
  pageMap(name: string) {
    if (name === 'PrivacyPage') {
      PrivacyPage()
    } else if (name === 'EntryPage') {
      EntryPage()
    }
  }

  build() {
    Navigation(this.stack) {
    }
    .backgroundColor($r('app.color.background_color_grey'))
    .hideBackButton(true)
    .hideNavBar(true)
    .mode(NavigationMode.Stack)
    .navDestination(this.pageMap)
  }
}

@ComponentV2
struct PrivacyPage {
  @Local
  stack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      PrivacyAgreementView({
        appIcon: $r('app.media.startIcon'), // 使用时替换为应用图标
        appName: '综合酒店模板',
        appDesc: '这是一个适用于综合酒店的应用模板',
        stack: this.stack,
        handleConfirm: () => {
          this.stack.replacePath({
            name: 'EntryPage',
          })
        },
      })
    }
    .hideTitleBar(true)
    .onReady((context) => {
      this.stack = context.pathStack
    })
  }
}

@ComponentV2
struct EntryPage {
  @Local
  stack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      Column({ space: 16 }) {
        Text('这是应用的主页面').fontSize(28).fontWeight(FontWeight.Bold)
        Text('本组件使用用户首选项存储用户同意结果，如需重复调试请卸载重装，或使用下方按钮手动触发')
        Button('重置同意结果')
          .onClick(() => {
            try {
              const pre = preferences.getPreferencesSync(this.getUIContext().getHostContext(), { name: 'default' })
              pre.putSync('isAgreePrivacy', false)
              this.stack.clear()
              this.stack.replacePath({ name: 'PrivacyPage' })
            } catch (err) {
              this.getUIContext().getPromptAction().showToast({ message: '重置失败：' + JSON.stringify(err) })
            }
          })
      }
      .padding(16)
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .onReady((context) => {
      this.stack = context.pathStack
    })
  }
}
```

## 更新记录

- **1.0.1 (2025-11-07)**
  - 修改 README
- **1.0.0 (2025-11-03)**
  - 初始版本

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

| 隐私政策 | 不涉及 |
| :--- | :--- |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

### HarmonyOS 版本

- 5.0.4
- 5.0.5
- 5.1.0
- 5.1.1
- 6.0.0

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEco Studio 版本

- DevEco Studio 5.0.4
- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/5a6193d4afce48388b5d5c6f004bf660/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%94%B3%E8%AF%B7%E6%9D%83%E9%99%90%E8%AE%B8%E5%8F%AF%E7%BB%84%E4%BB%B6/module_privacy_agreement1.0.1.zip