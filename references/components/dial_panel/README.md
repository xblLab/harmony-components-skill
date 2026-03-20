# 通用拨号组件

## 简介

本组件提供了拉起拨号面板以及一键拨号的能力。

## 详细介绍

### 简介

本组件提供了拉起拨号面板以及一键拨号的能力。

### 支持设备

直板机、折叠屏、平板

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、华为平板
- **系统版本**：HarmonyOS 5.0.1(13) 及以上

#### 调试

如果您需要在模拟器环境下进行相关测试，请使用 HarmonyOS 5.1.1(19) 及以上的模拟器测试拨号功能。(高版本模拟器可以通过最新的 DevEco Studio 下载)

#### 快速入门

##### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `dial_panel` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 dial_panel 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "dial_panel",
    "srcPath": "./XXX/dial_panel"
  }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
{
  "dependencies": {
    "dial_panel": "file:./XXX/dial_panel"
  }
}
```

##### 引入组件

```typescript
import { DialPanel } from 'dial_panel';
```

## API 参考

### 子组件

无

### DialPanel

#### constructor(uiContext: UIContext)

DialPanel 的构造函数。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| uiContext | UIContext | 是 | 应用 UI 上下文 |

#### setTitle(value: string): DialPanel

设置拨号面板顶部标题。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| value | string | 是 | 拨号面板顶部标题 |

**返回值：**

| 类型 | 说明 |
| :--- | :--- |
| DialPanel | 拨号面板实例自身，用于链式调用 |

#### setPhoneNumber(value: string): DialPanel

设置电话号码。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| value | string | 是 | 电话号码 |

**返回值：**

| 类型 | 说明 |
| :--- | :--- |
| DialPanel | 拨号面板实例自身，用于链式调用 |

#### setPhoneNumber(value: string): DialPanel

设置拨号面板自动关闭。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| value | boolean | 是 | 是否在成功前往拨号页面后自动关闭面板 (默认为 true) |

**返回值：**

| 类型 | 说明 |
| :--- | :--- |
| DialPanel | 拨号面板实例自身，用于链式调用 |

#### onMakeCall(callback: AsyncCallback<void>): DialPanel

监听拨号页面跳转事件。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| callback | AsyncCallback<void> | 是 | 页面跳转回调函数 |

**返回值：**

| 类型 | 说明 |
| :--- | :--- |
| DialPanel | 拨号面板实例自身，用于链式调用 |

#### onWillDismiss(callback: (reason: DismissReason) => void): DialPanel

监听交互式关闭事件。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| callback | (reason: DismissReason) => void | 是 | 交互式关闭回调函数，其中 reason 为交互类型，回调注册后模态窗将不会自动关闭 |

**返回值：**

| 类型 | 说明 |
| :--- | :--- |
| DialPanel | 拨号面板实例自身，用于链式调用 |

#### onWillSpringBackWhenDismiss(callback: (action: SpringBackAction) => void): DialPanel

监听模态窗关闭前回弹事件。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| callback | (action: SpringBackAction) => void | 是 | 模态窗回弹回调函数，其中 action 用于主动触发回弹，回调注册后模态窗将不会自动回弹 |

**返回值：**

| 类型 | 说明 |
| :--- | :--- |
| DialPanel | 拨号面板实例自身，用于链式调用 |

#### open(): Promise<boolean>

打开拨号面板。

**返回值：**

| 类型 | 说明 |
| :--- | :--- |
| Promise<boolean> | true: 打开成功，false: 打开失败 |

#### close(): void

关闭拨号面板。

## 示例代码

```typescript
import { DialPanel } from 'dial_panel';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@ComponentV2
struct Index {

  private uiContext: UIContext = this.getUIContext();

  private dialPanel: DialPanel = new DialPanel(this.uiContext)
    .onMakeCall((e: BusinessError<void>): void => {
      if (e.code) {
        this.showToast(`拨号页面跳转失败 -> code: ${e.code}, msg: ${e.message}`);
      }
    })
    .onWillDismiss((reason: DismissReason): void => {
      if (reason === DismissReason.TOUCH_OUTSIDE) {
        this.showToast('已拦截点击其它区域进行关闭的交互方式');
      } else if (reason === DismissReason.SLIDE_DOWN) {
        this.showToast('已拦截下拉模态窗进行关闭的交互方式');
      } else {
        this.dialPanel.close();
      }
    });

  public build(): void {
    Column() {
      Button('立即拨号')
        .onClick(() => {
          this.dialPanel
            .setTitle('联系客服')
            .setPhoneNumber('12345678901')
            .setAutoClosePanel(false) // 成功跳转后不自动关闭模态窗
            .open();
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  private showToast(msg: string): void {
    this.uiContext.getPromptAction().showToast({ message: msg });
  }
}
```

## 更新记录

### 1.0.0 (2025-10-31)

- 初始版本

## 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

## 基本信息

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/a1d9cbd74fb74056943a617c3eed3551/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%80%9A%E7%94%A8%E6%8B%A8%E5%8F%B7%E7%BB%84%E4%BB%B6/dial_panel1.0.0.zip