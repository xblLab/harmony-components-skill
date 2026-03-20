# ability 组件

## 简介

This package provides a set of components and APIs for building OpenHarmony activities and it helps us create a application entry for rust application. For OpenHarmony/HarmonyNext development, our application entry must be a ArkTS file and we need to forward some lifecycle event to rust code.

## 详细介绍

### 简介

This package provides a set of components and APIs for building OpenHarmony activities and it helps us create a application entry for rust application.
For OpenHarmony/HarmonyNext development, our application entry must be a ArkTS file and we need to forward some lifecycle event to rust code.

### 安装

```bash
ohpm install @ohos-rs/ability
```

### API and Components

#### RustAbility

The Activity component is a wrapper of the OpenHarmony Activity class. It will load the native code and forward the lifecycle event to rust code by default.
If you want to use rust development OpenHarmony/HarmonyNext application, you must use this component to create your application entry.

```typescript
// ets/entryability/EntryAbility.ets
import { RustAbility } from "@ohos-rs/ability";

export default class MyAbility extends RustAbility {
  public moduleName: string = "hello";

  onCreate() {
    super.onCreate();
  }
}
```

Here are some notes and tips:

*   For every lifecycle callback, you must call the super method to forward the event to rust code as first and then write your own logic.
*   `moduleName` is the name of your native module name which file name is lib${moduleName}.so. You must define it in your project.

#### loadMode

Allow to define that how to load dynamic library in runtime.

##### async

In async mode, we will use await import(${lib}) to load library. And this is default behavior.

##### sync

In sync mode, we will use loadNativeModule to load library. If you define it, you must add some configuration into your build-profile.json5.

```json5
{
  "buildOption": {
    "arkOptions": {
      "runtimeOnly": {
        "packages": ["libentry.so"]
      }
    }
  }
}
```

See more with loadNativeModule.

#### DefaultXComponent

When using rust to develop OpenHarmony/HarmonyNext application, we use XComponent to render the UI by default. And DefaultXComponent loads the native module and forward the lifecycle event to rust code by default.
This component is a optional component, you may don't need it. If you don't need to use it, RustAbility will use it by default.
And if you want to add some custom logic, you can use it with the following code:

```typescript
// ets/entryability/EntryAbility.ets
import { RustAbility } from "@ohos-rs/ability";
import Want from "@ohos.app.ability.Want";
import { AbilityConstant } from "@kit.AbilityKit";
import window from "@ohos.window";

export default class EntryAbility extends RustAbility {
  public moduleName: string = "example";

  // Must mark it as false to prevent the default page from loading
  public defaultPage: boolean = false;

  async onCreate(
    want: Want,
    launchParam: AbilityConstant.LaunchParam
  ): Promise<void> {
    super.onCreate(want, launchParam);
  }

  async onWindowStageCreate(windowStage: window.WindowStage): Promise<void> {
    // Must call super method to forward the event to rust code
    super.onWindowStageCreate(windowStage);
    // Jump to your custom page
    await windowStage.loadContent("pages/Index");
  }
}
```

```typescript
// ets/pages/Index.ets
import { DefaultXComponent } from '@ohos-rs/ability'
import { ItemRestriction, SegmentButton, SegmentButtonOptions, SegmentButtonTextItem } from '@kit.ArkUI';
import { changeRender } from "libwgpu_in_app.so"

@Entry
@Component
struct Index {
  // Add some custom logic
  @State tabOptions: SegmentButtonOptions = SegmentButtonOptions.capsule({
    buttons: [{ text: 'boids' },
      { text: 'MSAA line' },
      { text: 'cube' },
      { text: "water" },
      { text: "shadow" }] as ItemRestriction<SegmentButtonTextItem>,
    backgroundBlurStyle: BlurStyle.BACKGROUND_THICK,
  })
  @State @Watch("handleChange") tabSelectedIndexes: number[] = [0]

  handleChange() {
    console.log(`changeIndex: ${this.tabSelectedIndexes}`)
    changeRender(this.tabSelectedIndexes[0])
  }

  build() {
    Row() {
      Column() {
        SegmentButton({ options: this.tabOptions, selectedIndexes: $tabSelectedIndexes })
        // Must use the default component to render the UI
        DefaultXComponent()
      }
      .width('100%')
    }
    .height('100%')
  }
}
```

### 许可证协议

MIT

### 更新记录

#### 0.3.0

*   Allow render xcomponent and webview at the same time.
*   Add sync method to load dynamic library.

#### 0.2.2

*   Fix: allow enable devtools

#### 0.2.1

*   Allow load page with html string.
*   Allow load url with custom headers.

#### 0.2.0

*   Support webview render mode.

#### 0.1.5-beta.0

*   Add Webview render mode.

#### 0.1.2

*   Use XComponent's on_frame to replace onFrame callback.

#### 0.1.1

*   Revert: Use native soloist to replace onFrame callback.

#### 0.1.0

*   Use native soloist to replace onFrame callback.

#### 0.0.2

*   Allow use custom page or route
*   Move default xcomponent to a single component

#### 0.0.1

*   init package

### 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| 基本信息 | 权限名称：暂无<br>权限说明：暂无<br>使用目的：暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性信息

| 项目 | 内容 |
| :--- | :--- |
| 应用类型 | 应用 |
| 元服务 | 是 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |
| HarmonyOS 版本 | 5.0.0 |

> Generated with Pixso.

## 安装方式

```bash
ohpm install @ohos-rs/ability
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/1f0ef611c746403c8e5097ce8282c21f/PLATFORM?origin=template