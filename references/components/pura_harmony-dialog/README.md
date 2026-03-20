# harmony-dialog 文本输入弹窗组件

## 简介

一款极为简单易用的零侵入弹窗，仅需一行代码即可轻松实现，无论在何处都能够轻松弹出。其涵盖了 AlertDialog、TipsDialog、ConfirmDialog、SelectDialog、CustomContentDialog、TextInputDialog、TextAreaDialog、BottomSheetDialog、ActionSheetDialog、TextPickerDialog、DatePickerDialog、CustomDialog、BindSheet、LoadingDialog、LoadingProgress、Toast、ToastTip 等多种类型，能够满足各种不同的弹窗开发需求。

## 安装方式

```bash
ohpm install @pura/harmony-dialog
```

## 详细介绍

### 简介

harmony-dialog 是一款极为简单易用的零侵入弹窗，仅需一行代码即可轻松实现，无论在何处都能够轻松弹出。其涵盖了 AlertDialog、TipsDialog、ConfirmDialog、SelectDialog、CustomContentDialog、TextInputDialog、TextAreaDialog、BottomSheetDialog、ActionSheetDialog、TextPickerDialog、DatePickerDialog、CustomDialog、BindSheet、LoadingDialog、LoadingProgress、Toast、ToastTip 等多种类型，能够满足各种不同的弹窗开发需求。

### 下载安装

```bash
ohpm i @pura/harmony-dialog
```

### API 详解

#### DialogHelper 方法介绍

- `setDefaultConfig`：设置默认统一样式
- `showAlertDialog`：显示操作确认类弹出框
- `showConfirmDialog`：显示信息确认类弹出框
- `showTipsDialog`：显示提示弹出框，即为带图形确认框
- `showSelectDialog`：显示选择类弹出框
- `showTextInputDialog`：显示单行文本输入弹框
- `showTextAreaDialog`：显示多行文本输入弹框
- `showCustomContentDialog`：显示自定义内容区弹出框，同时支持定义操作区按钮样式
- `showBottomSheetDialog`：显示动作面板
- `showActionSheetDialog`：显示动作面板（IOS 风格）
- `showTextPickerDialog`：显示选择器弹框；入参参考 TextPicker 组件；配合 china_area 可进行中国省市县数据选择。
- `showDatePickerDialog`：显示日期选择器弹框，配合 harmony-utils 的 DateUtil 工具类使用，格式化日期。
- `showCustomDialog`：显示自定义弹窗
- `update`：刷新自定义弹窗
- `isShowing`：当前弹窗是否显示
- `closeDialog`：关闭弹框
- `showLoadingDialog`：显示加载类弹出框
- `showLoadingProgress`：显示进度条加载弹框
- `updateLoading`：刷新加载弹框
- `showBindSheet`：显示自定义半模态
- `updateBindSheet`：刷新自定义半模态
- `closeBindSheet`：显示带图形的吐司
- `showToast`：显示吐司
- `showToastLong`：显示长吐司
- `showToastShort`：显示短吐司
- `showToastTip`：显示带图形的吐司
- `generateId`：生成弹框 id

#### AnimationHelper 方法介绍

- `transitionInUpInUp`：动画
- `transitionInDownInDown`：动画
- `transitionInLeftInLeft`：动画
- `transitionInRightInRight`：动画

## 使用说明与示例代码

### 简单初始化（1.0.8 版本及以后）

```typescript
// 必须在 UIAbility 的 onCreate 方法里初始化 context。
DialogHelper.setDefaultConfig((config) => {
  config.uiAbilityContext = this.context;
})
```

### 设置默认的统一配置

```typescript
// 在 UIAbility 的 onCreate 方法里初始化
DialogHelper.setDefaultConfig((config) => {
  config.uiAbilityContext = this.context  // 必须初始化上下文
  config.autoCancel = true; // 点击遮障层时，是否关闭弹窗，true 表示关闭弹窗。false 表示不关闭弹窗。默认值：true
  config.backCancel = true; // 点击返回键或手势返回时，是否关闭弹窗；实现 onWillDismiss 函数时，该参数不起作用。true 表示关闭弹窗。false 表示不关闭弹窗。默认值：true。
  config.actionCancel = true; // 点击操作按钮时，是否关闭弹窗。false 表示不关闭弹窗。默认值：true。
  config.alignment = DialogAlignment.Center; // 弹窗的对齐方式。
  config.offset = { dx: 0, dy: 0 }; // 弹窗相对 alignment 所在位置的偏移量。默认值：{ dx: 0, dy: 0 }
  config.maskColor = 0x33000000; // 自定义蒙层颜色。默认值 0x33000000
  config.backgroundColor = Color.White; // 弹窗背板颜色。默认值：Color.White
  config.backgroundBlurStyle = BlurStyle.COMPONENT_ULTRA_THICK; // 弹窗背板模糊材质。默认值：BlurStyle.COMPONENT_ULTRA_THICK
  config.cornerRadius = 20; // 设置背板的圆角半径。可分别设置 4 个圆角的半径。

  config.title = '温馨提示'; // 弹框标题
  config.primaryButton = '取消'; // 弹框左侧按钮。
  config.secondaryButton = '确定'; // 弹框右侧按钮。
  config.imageRes = undefined; // TipsDialog 用到，展示的图片。
  config.imageSize = { width: '64vp', height: '64vp' }; // TipsDialog 用到，自定义图片尺寸。默认值：64*64vp

  config.loading_loadSize = 60; // 加载动画或进度条的大小
  config.loading_loadColor = Color.White; // 加载动画或进度条的颜色
  config.loading_content = ''; // 加载动画的提示文字
  config.loading_fontSize = 16; // 文字大小
  config.loading_fontColor = Color.White; // 文字颜色
  config.loading_backgroundColor = '#CC000000'; // 背景颜色，八位色值前两位为透明度
  config.loading_borderRadius = 10; // 背景圆角
  
  config.picker_textStyle = ; // 设置所有选项中除了最上、最下及选中项以外的文本颜色、字号、字体粗细。
  config.picker_selectedTextStylee = ; // 设置选中项的文本颜色、字号、字体粗细。
  config.picker_disappearTextStylee = ; // 设置所有选项中最上和最下两个选项的文本颜色、字号、字体粗细。
  config.picker_divider: DividerOptions = { strokeWidth: '2px', startMargin: 0, endMargin: 0, color: '#33000000' }; // 设置分割线样式，不设置该属性则按“默认值”展示分割线。
  config.picker_canLoop: boolean = true; // 设置是否可循环滚动。
  config.picker_titleFontColor = $r("sys.color.ohos_id_picker_title_text_color"); // 弹框标题的字体颜色。
  config.picker_titleBackground = "#F9F9F9"; // 头部背景颜色
  config.picker_buttonFontColor = $r("sys.color.ohos_id_picker_button_text_color"); // 按钮颜色

  config.toast_duration = 2000; // 显示时长 (1500ms-10000ms)
  config.toast_durationLong = 10000; // 显示时长 (10000ms)
  config.toast_fontSize = 16; // 文字大小
  config.toast_fontColor = Color.White; // 文字颜色
  config.toast_backgroundColor = '#CC000000'; // 背景颜色，建议八位色值前两位为透明度
  config.toast_borderRadius = 8; // 背景圆角
  config.toast_padding = { left: 16, right: 16, top: 12, bottom: 12 }; // Padding
  config.toast_orientation = Orientation.VERTICAL; // 吐司布局方向，默认垂直。设置该值时，请重新设置 imageSize 和 margin。
  config.toast_imageSize = { width: 45, height: 45 }; // Tip 图片尺寸。垂直默认值：45*45vp，水平建议值：24*24vp。
  config.toast_margin = 10; // 吐司的图片与文字间距。
});
```

### 子窗口使用弹框

```typescript
// 在子窗口 使用弹框需要传入 uiContext
DialogHelper.showTipsDialog({
  uiContext:this.getUIContext(), // 子窗口需要传入 UIContext
  content: '想要卸载这个 APP 嘛？',
  onAction: (action) => {
    ToastUtil.showToast(`${action}`);
  }
})
```

### 操作确认类弹出框

```typescript
// 操作确认类弹出框
DialogHelper.showAlertDialog({
  content: "确定保存该 WPS 文件吗？",
  onAction: (action) => {
    if (action == DialogAction.CANCEL) {
      ToastUtil.showToast(`您点击了取消按钮`);
    } else if (action == DialogAction.SURE) {
      ToastUtil.showToast(`您点击了确认按钮`);
    }
  }
})
```

### 信息确认类弹出框

```typescript
// 信息确认类弹出框
DialogHelper.showConfirmDialog({
  checkTips: "是否记住密码？",
  content: "您是否退出当前应用",
  onCheckedChange: (check) => {
    ToastUtil.showToast(`${check}`);
  },
  onAction: (action) => {
    ToastUtil.showToast(`${action}`);
  }
})
```

### 提示弹出框

```typescript
// 提示弹出框
DialogHelper.showTipsDialog({
  content: '想要卸载这个 APP 嘛？',
  onAction: (action) => {
    ToastUtil.showToast(`${action}`);
  }
})
```

### 选择类弹出框

```typescript
// 选择类弹出框
DialogHelper.showSelectDialog({
  radioContent: ["文本菜单选项一", "文本菜单选项二", "文本菜单选项三", "文本菜单选项四", "文本菜单选项五"],
  onCheckedChanged: (index) => {
    ToastUtil.showToast(`${index}`);
  },
  onAction: (action, dialogId, value) => {
    ToastUtil.showToast(`${action} --- ${value}`);
  }
})
```

### 单行文本输入弹出框

```typescript
// 单行文本输入弹出框
DialogHelper.showTextInputDialog({
  text: this.inputText,
  onChange: (text) => {
    console.error("onChange: " + text);
  },
  onAction: (action, dialogId, content) => {
    if (action == DialogAction.SURE) {
      this.inputText = content;
    }
  }
})
```

### 多行文本输入弹出框

```typescript
// 多行文本输入弹出框
DialogHelper.showTextAreaDialog({
  text: this.inputText,
  onChange: (text) => {
    console.error("onChange: " + text);
  },
  onAction: (action, dialogId, content) => {
    if (action == DialogAction.SURE) {
      this.inputText = content;
    }
  }
})
```

### 自定义内容区弹出框

```typescript
// 自定义内容区弹出框
DialogHelper.showCustomContentDialog({
  contentBuilder: () => {
    this.customTextBuilder("我是一个自定义弹框！")
  },
  onAction: (action) => {
    ToastUtil.showToast(`${action}`);
  }
})
```

### 动作面板

```typescript
// 动作面板
DialogHelper.showBottomSheetDialog({
  title: "请选择上传方式",
  sheets: ["相机", "相册", "文件管理器"],
  onAction: (index) => {
    ToastUtil.showToast(`您点击了，${this.menuArray[index]}`);
  }
})
```

### 动作面板（IOS 风格）

```typescript
// 动作面板（IOS 风格）
DialogHelper.showActionSheetDialog({
  title: "请选择上传方式",
  sheets: ["相机", "相册", "文件管理器"],
  onAction: (index) => {
    ToastUtil.showToast(`您点击了，${this.menuArray[index]}`);
  }
})
```

### 选择器弹框（TextPickerDialog）

```typescript
// 选择器弹框（TextPickerDialog）
let areas = AreaHelper.getAreaSync();
DialogHelper.showTextPickerDialog({
  title: "请选择收货地址",
  range: areas,
  onAction: (action: number, dialogId: string, value: string | string[]) => {
    if (action == DialogAction.SURE) {
      ToastUtil.showToast(`已选择：${value}`);
    }
  }
})
```

### 日期选择器弹框（DatePickerDialog）

```typescript
// 日期选择器弹框（DatePickerDialog）
DialogHelper.showDatePickerDialog({
  dateType: DateType.YmdHm,
  onAction: (action: number, dialogId: string, date: Date): void => {
    if (action == DialogAction.SURE) {
      let dateStr = DateUtil.getFormatDateStr(date, "yyyy-MM-dd HH:mm");
      ToastUtil.showToast(`选中日期：${dateStr}`);
      LogUtil.error(`选中日期：${dateStr}`);
    }
  }
})
```

### 进度加载类弹出框

```typescript
// 进度加载类弹出框
DialogHelper.showLoadingDialog({
  loadType: SpinType.spinP,
  loadColor: Color.White,
  loadSize: 70,
  backgroundColor: '#BB000000',
  content: "加载中…",
  fontSize: 18,
  padding: { top: 30, right: 50, bottom: 30, left: 50 },
  autoCancel: true
 })
```

### 进度条加载弹框

```typescript
// 进度条加载弹框
DialogHelper.showLoadingProgress({ progress: this.progress })
```

### 吐司

```typescript
// 吐司
DialogHelper.showToast("这是一个自定义吐司")
DialogHelper.showToastLong("这是一个自定义的长吐司呀")
```

### 吐司 Tip

```typescript
// 吐司 Tip
DialogHelper.showToastTip({
  message: "操作成功",
  imageRes: $r('sys.media.ohos_ic_public_ok')
})
```

### 自定义弹窗

```typescript
// 自定义弹窗
let drawer: DrawerOptions = {
  width: 260,
  msg: "这是一个自定义弹框，DrawerLayout",
  alignment: DialogAlignment.CenterStart,
  offset: { dx: 0, dy: 0 },
  transition: AnimationHelper.transitionInLeft(250)
}
DialogHelper.showCustomDialog(wrapBuilder(DrawerBuilder), drawer)
```

## 沟通与交流

使用过程中发现任何问题都可以提 Issue 给我们；当然，我们也非常欢迎你给我们发 PR。

## 开源协议

本项目基于 Apache License 2.0，在拷贝和借鉴代码时，请大家务必注明出处。

## 更新记录

### 1.1.8 (2025-09-15)

暂无

## 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

| 项目 | 内容 |
| :--- | :--- |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 内容 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | 元服务 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/54571053d8e345e0bf8dd8acdd6b0ebd/PLATFORM?origin=template