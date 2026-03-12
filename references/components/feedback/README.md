# 通用问题反馈组件

## 简介

本组件提供了通用的问题反馈功能。

## 详细介绍

### 简介

本组件提供了通用的问题反馈功能。

### 直板机折叠屏平板

- 问题反馈提交页
- 问题反馈列表页

### 约束与限制

#### 环境

- DevEco Studio版本：DevEco Studio 5.0.5 Release及以上
- HarmonyOS SDK版本：HarmonyOS 5.0.5 Release SDK及以上
- 设备类型：华为手机（包括双折叠和阔折叠）、华为平板
- 系统版本：HarmonyOS 5.0.1(13)及以上

#### 权限

- 网络权限：`ohos.permission.INTERNET`
- 振动权限：`ohos.permission.VIBRATE`

## 快速入门

### 安装组件

> 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
> 如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 feedback 模块。

```json5
// 在项目根目录 build-profile.json5 填写 feedback 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "feedback",
    "srcPath": "./XXX/feedback"
  }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
{
  "dependencies": {
    "feedback": "file:./XXX/feedback"
  }
}
```

### 配置组件基本能力

在 feedback 模块的 `src/main/ets/common/Config.ets` 中根据自身业务需求修改配置项。

```typescript
export class Config {
  /**
   * 启用 Mock 模式
   *
   * 该设置启用后，问题反馈相关请求将被 Axios 适配器拦截，返回 Mock 数据
   */
  public static readonly IS_MOCK_ADAPTER_ENABLE: boolean = true;
  
  /**
   * 问题描述文本可输入的最大字数
   */
  public static readonly DESC_TEXT_MAX_LENGTH: number = 150;
  
  /**
   * 问题描述文本需要输入的最小字数
   */
  public static readonly DESC_TEXT_MIN_LENGTH: number = 10;
  
  /**
   * 可选择的最大图片数量 (可设置的值上限为500)
   */
  public static readonly MAX_IMAGE_COUNT: number = 6;
  
  /**
   * 请求基础 URL, 例如 https://127.0.0.1:8443
   */
  public static readonly API_BASE_URL: string = '';
  
  /**
   * 请求超时时长
   */
  public static readonly REQUEST_TIMEOUT: number = 8 * 1000;
}
```

### 引入组件

```typescript
import { FeedbackTrigger } from 'feedback';
```

## API参考

### 子组件

无

### 接口

`FeedbackTrigger(options?: FeedbackTriggerOptions)`

问题反馈组件

#### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
|--------|------|----------|------|
| options | FeedbackTriggerOptions | 是 | 配置问题反馈组件的参数。 |

#### FeedbackTriggerOptions对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
|--------|------|----------|------|
| onBeforeNavigate | () => boolean | 否 | 页面跳转前的回调，返回false将取消跳转 |

### 示例代码

```typescript
import { FeedbackTrigger } from 'feedback';

@Entry
@ComponentV2
struct Index {

  private navPathStack: NavPathStack = new NavPathStack();

  public build(): void {
    Navigation(this.navPathStack) {
      Column() {
        // 在 FeedbackTrigger 中自定义触发样式，被点击时将自动跳转至问题反馈页面。
        FeedbackTrigger() {
          Button('问题反馈')
        }
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
  }
}
```

## 更新记录

### 1.0.0 (2025-11-03)

初始版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
|----------|----------|----------|
| ohos.permission.INTERNET | 允许使用Internet网络 | 允许使用Internet网络 |
| ohos.permission.VIBRATE | 单次振动、预置的振动效果、自定义振动。 | 单次振动、预置的振动效果、自定义振动。 |

### 隐私政策

不涉及

### SDK合规使用指南

不涉及

## 兼容性

### HarmonyOS版本

- 5.0.1
- 5.0.2
- 5.0.3
- 5.0.4
- 5.0.5

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEcoStudio版本

- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0

## 来源

- 原始URL: https://developer.huawei.com/consumer/cn/market/prod-detail/f8f4d24cb4f24d73a4febe6553c611b3/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%80%9A%E7%94%A8%E9%97%AE%E9%A2%98%E5%8F%8D%E9%A6%88%E7%BB%84%E4%BB%B6/feedback1.0.0.zip