# dialoghub 弹窗模版组件

## 简介

通用弹窗解决方案，提供与 UI 解耦的弹窗方式，支持链式 API 调用、页面级弹窗、自定义弹窗模板，提供丰富的配置用于解决复杂的交互问题与动画问题，并且支持运行时动态属性更新。适用于复杂弹窗场景开发。

## 详细介绍

### 简介

DialogHub 作为弹窗场景解决方案，聚焦应用内弹窗相关场景的实现以及开发体验优化。
DialogHub 底层对系统 OverlayManager、BindSheet 和 OpenCustomDialog 进行封装，提供了页面级弹窗、键盘避让、弹窗生命周期管理、弹窗模板创建、全局弹窗生命周期管理等能力。
开发者在开发过程中无需关心底层实现，聚焦应用场景，根据场景选择不同类型弹窗即可。

### 特性

- 提供页面级弹窗能力，支持页面切换或导航时，自动隐藏旧页面的弹窗
- 提供弹窗管理能力（包含弹窗状态查询、弹窗生命周期监听、弹窗拦截）
- 支持通过链式调用的方式快速创建弹窗（提供 Toast、Popup 等多种类型的默认弹窗）
- 支持自定义弹窗模板能力（支持将弹窗内容、样式、行为、生命周期等配置属性保存至模板内）
- 支持多种配置属性（包含弹窗层级、手势透传、弹窗动画等）
- 支持弹窗显示过程中修改属性（包含弹窗内容、弹窗样式等）
- 提供预置弹窗模板，常用场景的弹窗无需开发者实现弹窗内容，通过简单配置即可实现弹窗
- 页面级弹窗体验增强，页面切换及返回时，保持弹窗随原页面进行显示、隐藏以及动画切换

## 效果展示

- 纯文本有持续时间的提示窗
- 指定位置弹窗的非模态弹窗会定时消失且带弹出动效的弹窗
- 存在跳转链接的弹窗
- 指向选定组件的带箭头弹窗
- 点击蒙层自动关闭的弹窗
- 可主动关闭的弹窗
- 父页面刷新正在展示的弹窗内容
- 能够动态调整高度的底部弹窗
- 会避让键盘的弹窗

## 下载安装

```bash
ohpm install @hadss/dialoghub
```

**使用 ohpm 安装依赖**

```json
{
    "dependencies": {
        "@hadss/dialoghub": "^1.1.4"
    }
}
```

## 快速开始

### 获取 UIContext 实例，进行 DialogHub 初始化

```typescript
// 1.获取 window 实例后，调用 getUIContext() 获取
onWindowStageCreate(windowStage) {
    windowStage.loadContent('pages/Index', (err) => {
    // ...
    windowStage.getMainWindow().then((windowObj) => {
    // getUIContext 接口需要再 loadContent 调用后调用，否则获取的 UIContext 可能为空
    DialogHub.init(windowObj.getUIContext());
    })
  });
}

// 2.在页面中通过 this.getUIContext() 获取
@Entry
@Component
struct CustomTest {
  customDialog: InfCustomDialog | undefined = undefined;

  aboutToAppear(): void {
    DialogHub.init(this.getUIContext(), DialogMode.CUSTOM_DIALOG); // 初始化 DialogHub 时可以设置全局弹窗模式
  }

  build() {
    Column() {
      Button('显示弹窗')
        .onClick(() => {
          // ...
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.Gray)
  }
}
```

### 根据预期的弹窗行为，获取对应弹窗构造器

```typescript
// 1.获取 Toast 弹窗构造器
let toastBuilder = DialogHub.getToast();

// 2.获取 Popup 弹窗构造器
let popupBuilder = DialogHub.getPopup();

// 3.获取自定义弹窗构造器
let customDialogBuilder = DialogHub.getCustomDialog();

// 4.获取 ActionSheet 弹窗构造器
let sheetBuilder = DialogHub.getSheet();
```

### 设置弹窗内容

```typescript
// 以自定义弹窗举例，其它弹窗使用方法相同
// 1.定义全局@Builder 方法，作为弹窗内容
class Param {
    text: string = '';
    constructor(text: string) {
        this.text = text;
    }
}
@Builder
function GlobalBuilder(param: Param) {
    Column() {
        Text(param.text)
    }
    .width(400)
    .height(300)
}
// 2.设置全局 Buidler 为弹窗内容
DialogHub
  .getCustomDialog()
  .setContent(wrapBuilder(GlobalBuilder), new Param('Dialog Content'))
```

### 设置弹窗行为、位置、模式

```typescript
let dialogConfig: DialogConfig = {
    dialogBehavior: {
    isModal: true,
    passThroughGesture: false,
    autoDismiss: true,
    keyboardAvoidMode: CustomKeyboardAvoidMode.CONTENT_AVOID,
    keyboardAvoidSpace: 0,
    requestFocusWhenShow: true
  },
  dialogPosition: {
    alignment: DialogAlignment.Center
  },
  dialogMode: DialogMode.CUSTOM_DIALOG
};
DialogHub
  .getCustomDialog()
  .setContent(WrapBuilder) // 参考前文"设置弹窗内容"部分
  .setConfig(dialogConfig); // 链式调用，设置弹窗行为、位置、模式，可选，不设置时使用默认配置项
```

### 设置弹窗样式

```typescript
let style: DialogStyle = {
  height: 200,
  width: 300,
  radius: 8,
  shadow: {
    radius: 10,
    type: ShadowType.COLOR,
    color: Color.Red,
    offsetX: 15,
    offsetY: 15,
    fill: true
  },
  borderWidth: 5,
  borderColor: Color.Green,
  borderStyle: BorderStyle.Dotted,
  backgroundColor: Color.Pink
};
DialogHub.getCustomDialog()
  .setContent(WrapBuilder) // 参考前文"设置弹窗内容"部分
  .setConfig(DialogConfig) // 参考前文"设置弹窗行为、位置、模式"部分
  .setStyle(dialogStyle); // 链式调用，设置弹窗样式，可选，不设置时使用默认样式
```

### 创建弹窗对象

```typescript
let customDialog = DialogHub.getCustomDialog()
  .setContent(WrapBuilder) // 参考前文"设置弹窗内容"部分
  .setConfig(DialogConfig) // 参考前文"设置弹窗行为、位置、模式"部分
  .setStyle(DialogStyle) // 参考前文"设置弹窗样式"部分
  .build() // 链式调用，创建弹窗对象
```

### （可选）设置弹窗动画

```typescript
DialogHub.getCustomDialog()
  .setContent(WrapBuilder) // 参考前文"设置弹窗内容"部分
  .setConfig(DialogConfig) // 参考前文"设置弹窗行为、位置、模式"部分
  .setStyle(DialogStyle) // 参考前文"设置弹窗样式"部分
  .setAnimation({ dialogAnimation: AnimationType.LEFT_TO_RIGHT }) // 链式调用，设置弹窗动画
```

### （可选）注册弹窗生命周期监听事件

```typescript
DialogHub.getCustomDialog()
  .setContent(WrapBuilder) // 参考前文"设置弹窗内容"部分
  .setConfig(DialogConfig) // 参考前文"设置弹窗行为、位置、模式"部分
  .setStyle(DialogStyle) // 参考前文"设置弹窗样式"部分
  .setAnimation(DialogAnimation) // 
  .addLifeCycleListener({ // 链式调用，注册弹窗生命周期监听事件
    onWillShow: () => {},
    onWillDismiss: () => {},
    onHide: () => {},
    onShow: () => {}
  })
```

### 显示弹窗

```typescript
DialogHub.getCustomDialog()
  .setContent(WrapBuilder) // 参考前文"设置弹窗内容"部分
  .setConfig(DialogConfig) // 参考前文"设置弹窗行为、位置、模式"部分
  .setStyle(DialogStyle) // 参考前文"设置弹窗样式"部分
  .build()
  .show() // 链式调用，显示弹窗
```

## 进阶能力

### 使用预置模板

```typescript
let presetToastBuilder = DialogHub.templateManager.getToastTemplate(PresetToast.ICON_HORIZONTAL_TOAST);
let toastDialog = presetToastBuilder
  .setConfig({
    dialogPosition: {
      alignment: DialogAlignment.Bottom,
    }
  })
  .setStyle({
    width: 328,
    height: 48,
    radius: 18
  })
  .setTextContent('已添加到喜欢的音乐')
  .setIcon('app.media.icon')
  .setButton('加入歌单 >')
  .setButtonCallback((dialog: InfDialog) => {
    dialog.dismiss();
  })
  .setDuration(3000)
  .build();
```

### 获取预置弹窗模板，可添加自定义内容后作为弹窗内容

```typescript
class Param {
  templateBuilder: WrapBuilder<[IconHorizontalToastContent]>;
  contentParam: IconHorizontalToastContent;
  text: string;
  
  constructor(templateBuilder: WrapBuilder<[IconHorizontalToastContent]>, contentParam: IconHorizontalToastContent, text: string) {
    this.templateBuilder = templateBuilder;
    this.contentParam = contentParam;
    this.text = text;
  }
}
@Builder
function GlobalBuilder(param: Param) {
  Column() {
    param.templateBuilder.builder(param.contentParam);
    Text('Custom Content') // 添加自定义内容
  }
  .width(300)
  .height(180)
}
 // 后续设置弹窗内容见前文"设置弹窗内容"部分 
```

### 设置弹窗模式，实现增强页面级弹窗

```typescript
uniqueId: number = 0;
build() {
  Column({ space: 20 }) {
    Button('打开弹窗').fontSize(24).fontWeight(FontWeight.Bold).margin({ top: 25 }).onClick(() => {
      DialogHub.getCustomDialog()
        .setOperableContent(wrapBuilder(pageLevelDialog), (dialogAction: DialogAction) => {
          let param = new Param(() => {
            dialogAction.dismiss();
          })
          return param;
        })
        .setConfig({
          dialogBehavior: {
            isModal: true,
            autoDismiss: true,
            levelMode: LevelMode.EMBEDDED,
            levelUniqueId: this.uniqueId
          },
          dialogMode: DialogMode.CUSTOM_DIALOG
        })
        .build().show()
    })
  }
  .height('100%')
  .width('100%')
  .onAppear(() => {
    let frameNode = this.uiContext.getFrameNodeByUniqueId(this.getUniqueId());
    this.uniqueId = frameNode?.getUniqueId()!;
  })
}
```

## 关于混淆

代码混淆，请查看代码混淆简介
如果希望 DialogHub 库在代码混淆过程中不会被混淆，需要在混淆规则配置文件 obfuscation-rules.txt 中添加相应的排除规则：

```text
-keep
./oh_modules/@hadss/dialoghub
```

## 基于 DialogHub 的通用弹窗解决方案

[查看详情](https://developer.huawei.com/consumer/cn/market/prod-detail/d594cfd8aea94db38ca0bbabbfe4c57d/PLATFORM?origin=template)

## SampleCode

本项目包含 Sample 示例代码，开发者可参考 Sample 实现某些常用场景。

## 约束与限制

SDK: Ohos_sdk_public 5.0.3.135 (API 15 Release) 及以上

## 开源协议

本项目基于 Apache License 2.0，请自由享受和参与开源。

## 更新记录

### 1.1.4 (2026.1.12)

**Features**

- SheetDialog 支持自定义圆角
- 调整 compileSdkVersion、targetSdkVersion 字段为 20
- 规范化示例代码，并丰富场景案例

**Bug Fixes**

- 修复使用 SheetDialog 点击跳转下一个页面崩溃的问题
- 适配系统接口 getKeyboardAvoidMode 的不兼容变更
- 修复键盘存在时，弹窗的动画异常问题
- 修复 ComponentContent 销毁后弹窗无法打开的问题
- 修复 CustomDialog 模式下，即使遮罩不存在，也没办法点击弹窗外的问题

### 1.1.3 (2025.9.18)

**修复以下问题**

- Popup 弹窗箭头提供配置项 keepIconColor，默认为 false，设置为 true 后图标显示图片原有颜色，优先级顺序为 arrowColor > arrowIcons.keepIconColor > backgroundColor;
- 弹出多个弹窗时，上层弹窗的手势滑动事件 PanGesture 在手指抬起时，会触发下层弹窗的 onClick 事件修复；
- Toast 弹窗在弹窗进行拦截后，未成功关闭时清空定时器导致弹窗提前关闭问题修复；
- 当前导出文件分为 common 和 model 两个文件进行导出，添加预置弹窗模板相关变量直接导出
- 预置弹窗模板未设置任何内容时，添加警告提示
- ConfirmHorizontalDialog 中 button 不设置风格和字体颜色时，默认字体颜色修改
- ConfirmHorizontalDialog 中 button 的背景颜色不生效问题修复
- 修复 Router、Navigation 混用时，调用 Router.replace 方法将会导致弹窗无法正常关闭问题

### 1.1.2 (2025.8.11)

**修复以下问题**

- DialogHub 的 getCurrentPageDialogByStatus(status?: DialogStatus) 增加返回值 CommonDialog[]，避免编译报错；
- 设置弹窗 autoDismiss 为 true，弹出多个弹窗时，点击遮罩关闭所有弹窗，修改为一次点击只关闭最上层弹窗；
- CustomDialog 关闭弹窗后，getCurrentPageDialogs 接口返回数量未更新问题修复；
- CustomDialog 关闭弹窗后，弹窗中使用的自定义组件 aboutToDisappear 生命周期未触发问题修复；
- CustomDialog 中存在输入框时无法获焦问题修复；
- 弹出多个弹窗时，底层弹窗会响应点击事件问题修复。

### 1.1.1 (2025.7.15)

**修复以下问题**

- 弹出 Popup 弹窗时，目标组件使用 offset 设置偏移量，修复箭头指向位置错误问题

### 1.1.0 (2025.06.21)

**新增以下特性**

- 支持 CustomDialog 弹窗模式，该模式下支持实现页面级弹窗
- onWillDismiss 新增手势侧滑事件拦截

### 1.0.0-rc.5 (2025.04.30)

**新增以下特性**

- 支持预置弹窗模板，开发者可通过预置弹窗模板进行简单配置后创建弹窗，不需要自己传入弹窗内容

### 1.0.0-rc.4 (2025.04.16)

**修复以下问题：**

- 调用弹窗 updateContent 方法时，若更新参数中存在 undefined 会导致更新失败

**新增以下特性：**

- 允许开发者自定义弹窗蒙层的模糊属性 (Sheet 类型暂不支持)
- 弹窗提供 hide 接口及 onWillHide/onHide 生命周期

### 1.0.0-rc.3 (2025.03.18)

**修复以下问题：**

- 模板弹窗使用 setOperableContent 后，创建的弹窗异常
- sheet 类型弹窗的 Detents 只能设置为 3 个挡位
- setContent 的 builder 参数为 Function 类型时，创建的弹窗异常
- 页面存在 Popup 类型弹窗时，路由切换后 Popup 弹窗位置异常
- 使用带箭头的 Popup 类型弹窗时，概率出现箭头与窗体之间存在一条缝隙

**新增以下特性：**

- 弹窗自适应深浅色配置 (同 ApplicationContext.Configuration 触发规则一致)

### 1.0.0-rc.2 (2025.03.04)

**修复以下问题：**

- setOperableContent 功能异常
- 优化 popup 计算逻辑
- 优化特殊场景异常透传

**新增以下特性：**

- popup 新增 edgePadding 属性，允许开发者设置弹窗边缘规避距离
- popup 新增 arrowColor 属性，允许开发者设置箭头颜色
- popup 新增 arrowIcons 属性，允许开发者自定义箭头 icon

### 1.0.0-rc.1 (2025.02.14)

**修复以下问题：**

- OnCurentPageDialogNumberChange 事件触发未在页面切换时触发
- Sheet 类型弹窗进行键盘避让时意外抛出异常
- 弹窗能够避让键盘时，弹窗第二次弹出进行避让时，出现一帧弹窗位置异常
- 非模态弹窗，弹窗外无法与页面进行交互
- DialogHub.init 方法多次执行时会异常注销掉所有路由监听
- Popup 与 Toast 类型弹窗使用默认的内容模板 (未调用 setContent 接口) 时，updateContent 方法不生效的问题
- 非 uiAbility 环境下 (如输入法应用)，弹窗库运行异常的问题
- 弹窗内容补满全屏时，安全区配置无效的问题
- Popup 类型弹窗设置 enableArrow 属性时，位置时弹窗位置不正确的问题
- 使用 string 和 Function 作为参数的 Builder 时，弹窗参数更新异常的问题

**新增以下特性：**

- 允许支持直接使用 DialogHub.getToast.build('Hello').show()
- InfPopup 对象增加 updateComponentTargetId 方法，允许弹窗对象创建后更换目标组件

### 1.0.0-rc.0 (2025.01.20)

**Initial**

初版发布

## 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| **基本信息** | 暂无 |
| **权限名称** | 暂无 |
| **权限说明** | 暂无 |
| **使用目的** | 暂无 |
| **隐私政策** | 不涉及 |
| **SDK 合规使用指南** | 不涉及 |
| **兼容性** | HarmonyOS 版本 5.0.3 |
| **应用类型** | 应用 |
| **元服务** | 无 |
| **设备类型** | 手机、平板、PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.3 |

## 安装方式

```bash
ohpm install @hadss/dialoghub
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/d594cfd8aea94db38ca0bbabbfe4c57d/PLATFORM?origin=template