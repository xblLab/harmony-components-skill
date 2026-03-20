# 弹窗组件 UIDialog

## 简介

UIDialog 是基于 open harmony 基础组件开发的组件，用于在屏幕中显示一个全局弹窗的功能，支持自定义样式，支持任意视图弹出，支持动态数据更新。

## 详细介绍

### 简介

UIDialog 是基于 open harmony 基础组件开发的组件，用于在屏幕中显示一个全局弹窗的功能，支持自定义样式，支持任意视图弹出，支持动态数据更新。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、华为平板
- **系统版本**：HarmonyOS 5.0.3(15) 及以上

#### 权限

无

### 使用

#### 安装组件

```bash
ohpm install @hw-agconnect/ui-dialog
```

#### 工程配置

Entry 模块下 src/main/ets/entryability/EntryAbility.ets 获取 UIContext 实例。

```typescript
onWindowStageCreate(windowStage: window.WindowStage): void {
  windowStage.loadContent('pages/Index', (err) => {
    contextUtil.setUiContext(windowStage.getMainWindowSync().getUIContext());
  });
}
```

#### 引入组件

```typescript
import { UIDialog } from '@hw-agconnect/ui-dialog';
```

#### 调用组件

详细参数配置说明参见 API 参考。

```typescript
UIDialog.open({
  content: this.message,
})
```

## API 参考

### UIDialog

#### 自定义弹窗

- **open(options: UIDialogOptionsModel | UIDialogOptions)**
  创建并打开弹窗，支持动态刷新弹窗内容。可以通过修改对象的属性来更新弹窗显示。
- **update(id: number, options: UIDialogOptionsModel | UIDialogOptions)**
  更新弹窗。
- **close(id: number)**
  关闭弹窗。
- **closeLast()**
  关闭最新打开的弹窗。

**说明：**

UIDialogOptionsModel 和 UIDialogOptions 的字段结构完全一致，但它们的使用场景和目的略有不同：
- `UIDialogOptions` 是一个接口（interface），用于定义弹窗配置的参数结构。开发者可以直接使用字面量对象的方式传入参数，适用于不需要动态更新弹窗内容的场景。
- `UIDialogOptionsModel` 是一个类（class），继承自 UIDialogOptions，适用于支持弹窗内容的动态更新。

#### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UIDialogOptionsModel \| UIDialogOptions | 是 | 配置弹窗组件的参数，用于设置弹窗的标题区、内容区、操作区等属性。 |

#### UIDialogOptionsModel 和 UIDialogOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| titleOptions | TitleOptions | 否 | 配置弹出框的标题参数 |
| contentOptions | ContentOptions | 否 | 配置弹出框的内容参数 |
| confirmButtonOptions | ButtonOptions | 否 | 配置确认按钮的参数 |
| cancelButtonOptions | ButtonOptions | 否 | 配置取消按钮的参数 |
| title | string | 否 | 主标题的文本，配置优先级低于 titleOptions 中的 primaryTitle。 |
| content | string | 否 | 弹出框内容的文本，配置优先级低于 contentOptions 中的 content。 |
| confirmButton | string | 否 | 确认按钮的文本，配置优先级低于 confirmButtonOptions 中的 button。 |
| cancelButton | string | 否 | 取消按钮的文本，配置优先级低于 cancelButtonOptions 中的 button。 |
| dialogWidth | Length | 否 | 弹出框的宽度。限制不可大于 400vp。 |
| dialogBorderRadius | Length | 否 | 弹出框的圆角。默认值为 32vp。 |
| bgImageResource | Str | 否 | 弹出框的背景图片 |
| bgColorResource | Color | 否 | 弹出框的背景颜色，默认值为 `$r('sys.color.comp_background_primary')`。 |
| maskColorResource | Color | 否 | 遮罩层颜色，默认值为 `'#33000000'`。 |
| alignment | DialogAlignment | 否 | 弹出框在竖直方向上的对齐方式。默认值为 Default。 |
| offsetX | string \| number | 否 | 弹出框相对 alignment 所在位置的横向偏移量。默认值为 0。 |
| offsetY | string \| number | 否 | 弹出框相对 alignment 所在位置的纵向偏移量。默认值为 0。 |
| showConfirmButton | boolean | 否 | 是否展示确认按钮，true 表示展示，false 表示不展示。默认为 false。 |
| showCancelButton | boolean | 否 | 是否展示取消按钮，true 表示展示，false 表示不展示。默认为 false。 |
| showMask | boolean | 否 | 是否展示遮罩层，true 表示展示，false 表示不展示。默认为 true。 |
| closeOnClickMask | boolean | 否 | 是否允许点击遮罩层关闭弹窗，true 表示允许，false 表示不允许。默认为 true。 |
| closeOnBackPress | boolean | 否 | 是否允许返回键关闭弹窗，true 表示允许，false 表示不允许。默认为 true。 |
| keyboardAvoidMode | KeyboardAvoidMode | 否 | 设置弹出框的键盘避让模式。默认值为 DEFAULT。 |
| keyboardAvoidSpace | string \| number | 否 | 弹出框避让键盘后，和键盘之间的距离。默认值为 0。 |
| titleBuilder | CustomBuilder | 否 | 自定义标题区 |
| contentBuilder | CustomBuilder | 否 | 自定义内容区 |
| actionBuilder | CustomBuilder | 否 | 自定义操作区 |
| onCancel | () => void | 否 | 取消按钮的 onClick 事件 |
| onConfirm | () => void | 否 | 确认按钮的 onClick 事件 |

#### TitleOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| primaryTitle | ResourceStr | 否 | 主标题的内容 |
| primaryTitleColor | ResourceColor | 否 | 主标题的文字颜色，默认值为 `$r('sys.color.font_primary')`。 |
| primaryFontSize | string \| number | 否 | 主标题的文字大小，默认值为 20vp，取值范围为 [18, 30]。 |
| primaryFontWeight | FontWeight | 否 | 主标题的文字字重，默认值为 FontWeight.Bold。 |
| primaryTextAlign | TextAlign | 否 | 主标题的对齐方式，默认值为 TextAlign.Center。 |
| secondaryTitle | ResourceStr | 否 | 副标题的内容 |
| secondaryTitleColor | ResourceColor | 否 | 副标题的文字颜色，默认值为 `$r('sys.color.font_secondary')`。 |
| secondaryFontSize | string \| number | 否 | 副标题的文字大小，默认值为 14vp，取值范围为 [14, 18]。 |
| secondaryFontWeight | FontWeight | 否 | 副标题的文字字重，默认值为 FontWeight.Regular。 |
| secondaryTextAlign | TextAlign | 否 | 副标题的对齐方式，默认值为 TextAlign.Center。 |
| titleImage | ResourceStr | 否 | 标题的图标 |
| imgWidth | Length | 否 | 图标的宽度，默认值为 32vp，取值范围为 [16, 64]。 |
| imgHeight | Length | 否 | 图标的高度，默认值为 32vp，取值范围为 [16, 64]。 |
| imgAlign | Alignment | 否 | 图标的对齐方式，默认值为 Alignment.center。 |

#### ContentOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| content | ResourceStr | 是 | 弹出框内容的文本 |
| contentFontColor | ResourceColor | 否 | 弹出框内容的文字颜色，默认值为 `$r('sys.color.font_primary')`。 |
| contentFontSize | string \| number | 否 | 弹出框内容的文字大小，默认值为 16vp。 |
| contentFontWeight | FontWeight | 否 | 弹出框内容的文字字重，默认值为 FontWeight.Medium。 |
| contentTextAlign | TextAlign | 否 | 弹出框内容的对齐方式，默认值为 TextAlign.Start。 |

#### ButtonOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| button | ResourceStr | 否 | 按钮的内容 |
| buttonFontColor | ResourceColor | 否 | 按钮的文字颜色，默认值为 `'#E84026'`。 |
| buttonFontSize | string \| number | 否 | 按钮的文字大小，默认值为 16vp。 |
| buttonFontWeight | FontWeight | 否 | 按钮的文字字重，默认值为 FontWeight.Medium。 |
| buttonType | ButtonType | 否 | 按钮的显示样式，默认值为 Normal。 |
| buttonBgColor | ResourceColor | 否 | 按钮的背景颜色，默认值为 `$r('sys.color.comp_background_primary')`。 |
| buttonBorderRadius | Length | 否 | 按钮的圆角，默认值为 14vp。 |

## 示例代码

```typescript
import { UIDialog } from '@hw-agconnect/ui-dialog';

@Entry
@ComponentV2
struct Index {
  @Local message: string = 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
  @Local value: number = 0;
  @Local timer: number = 0;
  @Local noMoreChecked: boolean = false;
  @Local noMoreTips: boolean = false;
  @Local isRunning: boolean = false;
  @Local dialogId: number = 0;
  @Local list: number[] = [1, 2, 3];
  @Local longList: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  startProgress() {
    if (this.isRunning) return;
    this.isRunning = true;
    this.value = 0;
    this.timer = setInterval(() => {
      if (this.value < 100 && this.isRunning) {
        this.value += 10;
        if (this.value >= 100) {
          this.value = 100;
          if (this.dialogId) {
            UIDialog.update(this.dialogId, {
              confirmButtonOptions: {
                buttonBgColor: 'rgba(0, 0, 0, 0.05)',
                buttonBorderRadius: 20
              },
              showConfirmButton: true,
            });
          }
        }
      } else {
        this.stopProgress();
      }
    }, 500);
  }

  stopProgress() {
    if (this.timer) {
      clearInterval(this.timer);
      this.timer = 0;
    }
    this.isRunning = false;
  }

  @Builder pictureContent() {
    Column() {
      Image($r('app.media.startIcon'))
        .height(180)
        .width(180)
    }
    .width('100%')
    .padding({ top: 4, left: 16, right: 16, bottom: 4 });
  }

  @Builder inputContent() {
    Column() {
      TextInput()
        .showUnderline(true)
        .width('80%')
    }
    .width('100%')
    .height(64)
  }

  @Builder noMoreContent() {
    Column({ space: 8 }) {
      Text(this.message)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.font_primary'))
        .textAlign(TextAlign.Start)
      Text(this.message)
        .fontSize(12)
        .fontColor($r('sys.color.font_secondary'))
        .textAlign(TextAlign.Start)
      Row() {
        Checkbox()
          .shape(CheckBoxShape.CIRCLE)
          .height(20)
          .width(20)
          .margin({ right: 10 })
          .align(Alignment.Start)
          .onChange((value: boolean) => {
            this.noMoreChecked = value;
          })
        Text('不再提示')
          .fontSize(14)
          .fontColor($r('sys.color.font_primary'))
          .textAlign(TextAlign.Start)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .padding({ top: 4, left: 16, right: 16, bottom: 4 })
  }

  @Builder progressContent() {
    Column() {
      Row() {
        Text('Title')
          .fontSize(14)
          .fontColor('rgba(0, 0, 0, 0.9)')
          .textAlign(TextAlign.Start)
          .width('50%')
        Text(this.value + '%')
          .fontSize(14)
          .fontColor('rgba(0, 0, 0, 0.9)')
          .textAlign(TextAlign.End)
          .width('50%')
      }
      .width('70%')
      .offset({x: -16})
      .margin({ top: 20 })
      .justifyContent(FlexAlign.SpaceBetween)
      Row() {
        Progress({ value: this.value, total: 100, type: ProgressType.Linear })
          .style({ strokeWidth: 4, enableSmoothEffect: true })
          .width('70%')
          .margin({ right: 12 })
        Image($r('app.media.startIcon'))
          .width(20)
          .height(20)
          .onClick(() =>{
            this.isRunning = false;
          })
      }
      .margin({ bottom: 8 })
    }
  }

  @Builder listContent() {
    Column() {
      List() {
        ForEach(this.list, (item: number) => {
          ListItem() {
            Row() {
              Text('Single list' + item)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .textAlign(TextAlign.Start)
                .width('70%')
              Column() {
                Radio({
                  group: '',
                  value: '' + item,
                  indicatorType: RadioIndicatorType.TICK
                })
                  .checked(!(item - 1))
                  .height(20)
                  .width(20)
                  .align(Alignment.End)
              }
              .width('30%')
            }
            .height(48)
            .offset({ x: '5%'})
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: 8 })
          }
        })
      }
      .margin({ bottom: 12 })
    }
  }

  @Builder longListContent() {
    Column() {
      List() {
        ForEach(this.longList, (item: number) => {
          ListItem() {
            Row() {
              Text('Single list' + item)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .textAlign(TextAlign.Start)
                .width('70%')
              Column() {
                Checkbox({ name: '' + item })
                  .shape(CheckBoxShape.CIRCLE)
                  .height(20)
                  .width(20)
                  .align(Alignment.End)
              }
              .width('30%')
            }
            .height(48)
            .offset({ x: '5%'})
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: 8 })
          }
        })
      }
      .margin({ bottom: 12 })
      .edgeEffect(EdgeEffect.Spring, {alwaysEnabled: true})
    }
  }

  @Builder declareContent() {
    Scroll() {
      Column({ space: 16 }) {
        Column({ space: 8 }) {
          Text('你可以选择“同意基本模式”以使用 华为 XX 基本服务（播放本地歌曲），该服务需联网，调用存储权限。')
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_primary'))
            .textAlign(TextAlign.Start)
          Text('需调用 XX、XX 权限，获取 XX 信息')
            .fontSize(10)
            .fontColor($r('sys.color.font_tertiary'))
            .textAlign(TextAlign.Start)
            .width('100%')
        }

        Column() {
          Text('你可以选择“同意全量模式”以使用更多功能（如音乐推荐、歌单等）。')
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_primary'))
            .textAlign(TextAlign.Start)
            .margin({ bottom: 8 })
          Text('本应用需联网，调用 XX、XX 权限，获取 XX 信息，以为你提供 XX 服务。我们仅在你使用具体功能业务时，才会触发上述行为收集使用相关的个人信息。详情请参阅 关于 XX 业务与隐私的声明 。')
            .fontSize(10)
            .fontColor($r('sys.color.font_tertiary'))
            .textAlign(TextAlign.Start)
            .margin({ bottom: 4 })
          Text('请你仔细阅读上述声明，点击“同意”，即表示你知悉并同意我们向你提供本应用服务。')
            .fontSize(10)
            .fontColor($r('sys.color.font_tertiary'))
            .textAlign(TextAlign.Start)
        }
      }
      .width('100%')
      .margin({ top: 8, bottom: 8 })
      .padding({
        top: 4,
        left: 16,
        right: 16,
        bottom: 4
      })
    }.constraintSize({ maxHeight: '45%'})
  }

  @Builder declareAction() {
    Scroll() {
      Column({ space: 8 }) {
        Button('退出应用')
          .declareButtonStyle()
          .onClick(() => {
            UIDialog.closeLast()
          })
        Button('同意基本模式')
          .declareButtonStyle()
          .onClick(() => {
            UIDialog.closeLast()
          })
        Button('同意全量模式')
          .declareButtonStyle()
          .onClick(() => {
            UIDialog.closeLast()
          })
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
    }.constraintSize({ maxHeight: '40%'})
  }

  @Builder innerContent() {
    Column({ space: 16 }) {
      Button('拉起弹窗')
        .fontColor('#0A59F7')
        .height(40)
        .width('50%')
        .backgroundColor($r('sys.color.comp_background_warning_secondary'))
        .onClick(() => {
          UIDialog.open({
            content: this.message,
            showConfirmButton: true,
            alignment: DialogAlignment.Bottom,
          })
        })
    }
    .width('100%')
    .margin({ top: 8, bottom: 8 })
    .padding({ top: 4, left: 16, right: 16, bottom: 4 })
  }

  build() {
    Navigation() {
      Scroll() {
        Column() {
          Button('打开弹窗 1，文字')
            .margin({ top: 16 })
            .onClick(() => {
              UIDialog.open({
                content: this.message,
              })
            })
          Button('打开弹窗 2，文字 + 按钮')
            .margin({ top: 16 })
            .onClick(() => {
              UIDialog.open({
                content: this.message,
                confirmButtonOptions: {
                  button: '知道了',
                  buttonBgColor: 'rgba(0, 95, 255, 0.1)',
                },
                showConfirmButton: true,
              })
            })
          Button('打开弹窗 3，标题图标')
            .margin({ top: 16 })
            .onClick(() => {
              UIDialog.open({
                titleOptions: {
                  primaryTitle: '礼物',
                  primaryFontSize: '10px',
                  titleImage: $r('app.media.startIcon'),
                  imgWidth: 24,
                  imgHeight: 24,
                },
                content: this.message,
                showConfirmButton: true,
                showCancelButton: true,
              })
            })
          Button('打开弹窗 4，不再提示')
            .margin({ top: 16 })
            .onClick(() => {
              if (this.noMoreTips) {
                return;
              }
              this.noMoreChecked = false;
              UIDialog.open({
                titleOptions: {
                  primaryTitle: '礼物',
                  titleImage: $r('app.media.startIcon'),
                  imgWidth: 24,
                  imgHeight: 24,
                },
                showConfirmButton: true,
                showCancelButton: true,
                contentBuilder: (): void => this.noMoreContent(),
                onConfirm: () => {
                  if (this.noMoreChecked) {
                    this.noMoreTips = true;
                  }
                },
              })
            })
          Button('打开弹窗 5，图片')
            .margin({ top: 16 })
            .onClick(() => {
              UIDialog.open({
                titleOptions: {
                  primaryTitle: '安全',
                  secondaryTitle: 'XX 为你提供最安全的支付环境',
                },
                confirmButtonOptions: {
                  button: '知道了',
                  buttonBgColor: 'rgba(0, 95, 255, 0.1)',
                },
                showConfirmButton: true,
                contentBuilder: (): void => this.pictureContent(),
              })
            })
          Button('打开弹窗 6，输入框')
            .margin({ top: 16 })
            .onClick(() => {
              UIDialog.open({
                title: '标题',
                showConfirmButton: true,
                showCancelButton: true,
                contentBuilder: (): void => this.inputContent(),
                alignment: DialogAlignment.Bottom,
                keyboardAvoidSpace: 10,
              })
            })
          Button('打开弹窗 7，进度条')
            .margin({ top: 16 })
            .onClick(async () => {
              this.startProgress();
              this.dialogId = await UIDialog.open({
                closeOnClickMask: false,
                onConfirm: () => {
                  this.stopProgress();
                },
                contentBuilder: (): void => this.progressContent(),
              })
            })
          Button('打开弹窗 8，单选列表')
            .margin({ top: 16 })
            .onClick(() => {
              UIDialog.open({
                title: '标题',
                showConfirmButton: true,
                showCancelButton: true,
                contentBuilder: (): void => this.listContent(),
              })
            })
          Button('打开弹窗 9，多选列表')
            .margin({ top: 16 })
            .onClick(() => {
              UIDialog.open({
                title: '标题',
                showConfirmButton: true,
                showCancelButton: true,
                contentBuilder: (): void => this.longListContent(),
              })
            })
          Button('打开弹窗 10，应用声明')
            .margin({ top: 16 })
            .onClick(() => {
              UIDialog.open({
                contentBuilder: (): void => this.declareContent(),
                actionBuilder: (): void => this.declareAction(),
              })
            })
          Button('打开弹窗 11，弹窗拉起弹窗')
            .margin({ top: 16 })
            .onClick(() => {
              UIDialog.open({
                title: '标题',
                contentBuilder: (): void => this.innerContent(),
                showConfirmButton: true,
                showCancelButton: true,
              })
            })
        }
        .width('100%')
      }
      .layoutWeight(1)
    }
    .title('弹窗')
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
    .width('100%')
    .height('100%')
  }
}

@Extend(Button)
function declareButtonStyle() {
  .fontColor('#0A59F7')
  .height(40)
  .width('100%')
  .backgroundColor($r('sys.color.comp_background_primary'))
}
```

## 更新记录

### 1.0.1 (2026-01-28)

- 修复了标题高度的错误。
- 修复了传入自定义确认事件后弹窗不触发关闭事件的 bug。
- 在取消和确定按钮之间增加了一条分割线。
- 将侧滑和点击遮罩关闭弹窗改为默认响应。
- 新增设置字重的能力。
- 新增支持单独设置标题区、内容区、操作区文本的能力。

### 1.0.0 (2025-12-02)

- 提供弹窗 UI 组件，支持自定义样式，任意视图弹出和动态数据更新。

## 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

**隐私政策**：不涉及

**SDK 合规使用指南**：不涉及

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1, 6.0.2 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1, 6.0.2 |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-dialog
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/45d6d1bc3d5c4f588d877d065f924af5/2adce9bbd4cb42d58a87e6add45594b3?origin=template