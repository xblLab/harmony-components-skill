# sdk base 基础开发工具组件

## 简介

基础开发工具包

## 详细介绍

### 初始化

在 UIAbility 的 `onWindowStageCreate` 方法中初始化该方法。

```typescript
// 初始化
import { GlobalContext } from '@szyx/sdk_base';
export default class AppAbility extends UIAbility {
  onWindowStageCreate(windowStage: window.WindowStage): void {
    GlobalContext.setContext(this.context);

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        LogHelper.error(`Failed to load the content. Cause: ${JSON.stringify(err) ?? ''}`);
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
      WindowHelper.windowClass = windowStage.getMainWindowSync();
    });
  }
}
```

### utils

#### AppStorageHelper

缓存工具类，运行时存储，应用停止运行后清空。

```typescript
import { AppStorageHelper } from '@szyx/sdk_base/Index';

// 存储 string 数据
AppStorageHelper.save(StorageKeys.CLIENT_ID, d);

// 获取存储的 string 数据
let d = AppStorageHelper.get(StorageKeys.CLIENT_ID);

// 删除指定存储
AppStorageHelper.delete(StorageKeys.CLIENT_ID);
```

#### PreferencesHelper

永久存储类，应用停止后也不会清空。需要验证，更新应用会不会被清理。

可存储类型：`number | string | boolean | Array<number> | Array<string> | Array<boolean> | Uint8Array`

```typescript
import { PreferencesHelper } from '@szyx/sdk_base/Index';

// 存储数据
PreferencesHelper.put(StorageKeys.CLIENT_ID, value);

// 获取存储的数据
PreferencesHelper.get(StorageKeys.CLIENT_ID).then(res => {
  console.log('>>>>>', res);
});

// 删除存储的数据
PreferencesHelper.delete(StorageKeys.CLIENT_ID).then(() => {
  console.log('>>>>>');
});
```

#### ToolsHelper

常用方法工具栏。

##### 基础方法

**弹出 Toast 提示**

```typescript
import { ToolsHelper } from '@szyx/sdk_base';

ToolsHelper.showMessage('Hello Word!');
```

**打印日志**

打印格式：`========>${顶层调用栈}::`

```typescript
import { ToolsHelper } from '@szyx/sdk_base';

ToolsHelper.log('Hello Word!');
```

**获取调用栈第一个**

```typescript
import { ToolsHelper } from '@szyx/sdk_base';

ToolsHelper.getStackKey();
```

**获取设备信息**

```typescript
import { ToolsHelper } from '@szyx/sdk_base';

ToolsHelper.getDeviceInfo();
```

**ArrayBuffer 转 string**

```typescript
import { ToolsHelper } from '@szyx/sdk_base';

ToolsHelper.toString();
```

**获取随机数**

```typescript
import { ToolsHelper } from '@szyx/sdk_base';

ToolsHelper.getUuid();
```

**防抖**

```typescript
import { ToolsHelper } from '@szyx/sdk_base';

ToolsHelper.debounceHold(() => {}, 300);
```

##### Dialog

```typescript
import { ToolsHelper } from '@szyx/sdk_base';

ToolsHelper.showConfirmDialog({
  title: '提示',
  msg: '提示信息',
  confirm: {
    text: '确定',
    color: '#18ABFB',
    onClick: () => {

    }
  },
  cancel: {
    text: '取消',
    onClick: () => {

    }
  }
});

ToolsHelper.showAlertDialog({
  title: '提示',
  msg: '提示信息',
  action: {
    onClick: () => {

    }
  }
});
```

如果需要自定义弹窗 UI，可以参考 ToolsHelper 中以下部分代码：

```typescript
@Builder
function customDialogBuilder<T>(option: ListOptions<T>, dialogTag: string) {
  //......
}
```

注意，传入参数 `(options: AlertBean)` 是固定的。

#### ValidatorHelper

[ValidatorHelper](./src/main/ets/utils/ValidatorHelper.ets)

常用正则。

**验证手机号**

```typescript
import { ValidatorHelper } from '@szyx/sdk_base';

ValidatorHelper.isPhone('13800000000');
```

**是否为身份证号**

```typescript
import { ValidatorHelper } from '@szyx/sdk_base';

ValidatorHelper.isIdcardNum();
```

### 许可证协议

Apache 2.0

### 更新记录

#### [v1.0.12] 2026.01.22

- 添加一个图片组件 AutoImage，高度固定，宽度自适应
- RefreshView 组件，添加一个 canLoadMore 字段，主动控制加载更多
- 替换一些过期 api
- 调整网络工具，不在白名单里面的请求，并发只会请求最后一个，前面几次请求会等待最后一个完成，返回相同的数据

#### [v1.0.11] 2025.09.02

- 修改初始化逻辑，解决 This window state is abnormal 的问题

#### [v1.0.10] 2025.05.30

- ToolsHelper.showConfirmDialog()&ToolsHelper.showAlertDialog() 添加自定义 UI 功能
- 添加一个 ImageHelper，处理图片相关
- 添加一个 SwipeView，左滑删除的 item 组件

#### [v1.0.9] 2025.04.06

- RefreshView 参数不包含 onLoadMore 的时候，上划不应该提示没有更多数据了
- RefreshView 添加一个 controller，补充跳转到顶部，跳转到底部等方法，具体见文档 4.3 注释
- WindowHelper 添加一个获取屏幕宽高的方法
- HttpHelper 上传文件逻辑完善

#### [v1.0.8] 2025.03.11

- 添加 ToolsHelper.getDeviceInfo().productModel

#### [v1.0.7] 2025.03.11

- 调整 web 相关，添加 JavaScript 机制，用来做 H5 和原生通信
- TimerHelper 添加时间格式化方法

#### [v1.0.6] 2024.12.02

- 优化 confirm 弹窗样式
- ToolsHelper 优化
- 限制 RefreshView 接口调用频率
- 优化 XWeb 相关
- 其它优化，可自行探索

#### [v1.0.5] 2024.11.08

- webView 工具优化
- 网络工具优化
- 新增下拉刷新和加载更多组件
- ToolsHelper 优化
- 新增日期选择工具 PickerDateTimeHelper
- 其它优化，可自行探索

#### [v1.0.4] 2024.10.21

- 优化缓存工具
- 网络工具优化
- 本次更新内容较多，请自行查看文档

#### [v1.0.3] 2024.10.15

- 新增 WindowHelper 工具栏
- 优化缓存工具
- 网络工具添加 postForm 请求
- ToolsHelper 添加一个方法，获取调用栈第一个类

#### [v1.0.2] 2024.09.04

- 新增携带 loading 的自定义 View

#### [v1.0.1] 2024.05.08

- 优化网络请求方法
- 简化自定义弹窗的使用

#### [v1.0.0] 2024.04.23

- 网络请求
- 正则验证
- 基础工具
- 统一弹窗
- 存储管理

### 兼容性及其他信息

| 项目 | 详情 |
| :--- | :--- |
| **权限与隐私** | 基本信息：权限名称、权限说明、使用目的（暂无）<br>隐私政策：不涉及<br>SDK 合规使用指南：不涉及 |
| **兼容性** | HarmonyOS 版本：5.0.4 |
| **应用类型** | 应用 |
| **设备类型** | 手机、平板、PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.4 |

> 注：Created with Pixso.

## 安装方式

```bash
ohpm install @szyx/sdk_base
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/a412382da4b146068399acc6bd56d548/PLATFORM?origin=template