# taro-oh/library 跨端框架组件

## 简介

开放式跨端跨框架解决方案

## 详细介绍

### 简介

开放式跨端跨框架解决方案，支持使用 React/Vue/Nerv 等框架来开发微信/京东/百度/支付宝/字节跳动/ QQ 小程序/H5/React Native 等应用。现如今市面上端的形态多种多样，Web、React Native、微信小程序等各种端大行其道，当业务要求同时在不同的端都要求有所表现的时候，针对不同的端去编写多套代码的成本显然非常高，这时候只编写一套代码就能够适配到多端的能力就显得极为需要。

### 快速开始

#### 安装 harmony 插件

##### 使用 npm 安装

```bash
$ npm i @tarojs/plugin-platform-harmony-cpp
```

##### 使用 pnpm 安装

```bash
$ pnpm i @tarojs/plugin-platform-harmony-cpp
```

#### 添加插件配置

```javascript
import os from 'os'
import path from 'path'

const config = {
  // ...
  plugin: ['@tarojs/plugin-platform-harmony-cpp'],
  harmony: {
    // 当前仅支持使用 Vite 编译鸿蒙应用
    compiler: 'vite',
    // Note: 鸿蒙工程路径，可以参考 [鸿蒙应用创建导读](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V2/start-with-ets-stage-0000001477980905-V2) 创建
    projectPath: path.join(os.homedir(), 'projects/my-business-project'),
    // Taro 项目编译到对应鸿蒙模块名，默认为 entry
    hapName: 'entry',
  },
  // ...
}
```

开发者也可以使用 ohpm 直接安装 `@taro-oh/library` 来使用：

```bash
$ ohpm install @taro-oh/library
```

除特殊场景外不推荐这样使用，编译项目时 cli 会安装所需 library 版本，详情请查阅官网文档。

## License

MIT

## 更新记录

### [4.1.11] - 2026-01-27

#### Bug Fixes

- C-API: transform-origin 第三个参数
- C-API(lint): blocks lines format
- C-API(helper): 文件下载引用修复
- C-API: 新增 aspect-ratio 修复 TransformOrigin 三个值不生效
- C-API: 修复 createAnimation 创建的动画不生效的问题
- C-API(text): 修复文本刷新问题
- C-API: fmt runtime
- C-API: loadImage: avoid file write race, support mem cache
- C-API: header include
- C-API: add licenserc
- HAR: update desc & license
- HAR: add bisheng
- HAR: build option
- HAR: rm main page ets

#### Features

- C-API: use https for github action
- C-API: 更新 cpp 逻辑至最新
- C-API: format cpp code
- C-API: add format.yml
- C-API: add license
- C-API: support loadImage interface
- HAR: update profile
- HAR: add cpp submodule

#### Other Changes

- C-API: 删除 FileDownloader 中锁逻辑
- C-API: Refactor NapiGetter.cpp to use Optional::value_or instead of manual has_value checks
- C-API(image): use image loader
- C-API: Initial commit

### [4.1.11-beta.4] - 2026-01-24

#### Bug Fixes

- C-API: transform-origin 第三个参数
- C-API(lint): blocks lines format
- C-API(helper): 文件下载引用修复
- C-API: 新增 aspect-ratio 修复 TransformOrigin 三个值不生效
- C-API: 修复 createAnimation 创建的动画不生效的问题
- C-API(text): 修复文本刷新问题
- C-API: fmt runtime
- C-API: loadImage: avoid file write race, support mem cache
- C-API: header include
- C-API: add licenserc
- HAR: update desc & license
- HAR: add bisheng
- HAR: build option
- HAR: rm main page ets

#### Features

- C-API: use https for github action
- C-API: 更新 cpp 逻辑至最新
- C-API: format cpp code
- C-API: add format.yml
- C-API: add license
- C-API: support loadImage interface
- HAR: update profile
- HAR: add cpp submodule

#### Other Changes

- C-API: 删除 FileDownloader 中锁逻辑
- C-API: Refactor NapiGetter.cpp to use Optional::value_or instead of manual has_value checks
- C-API(image): use image loader
- C-API: Initial commit

### [4.1.11-beta.3] - 2026-01-23

#### Bug Fixes

- C-API: transform-origin 第三个参数
- C-API(lint): blocks lines format
- C-API(helper): 文件下载引用修复
- C-API: 新增 aspect-ratio 修复 TransformOrigin 三个值不生效
- C-API: 修复 createAnimation 创建的动画不生效的问题
- C-API(text): 修复文本刷新问题
- C-API: fmt runtime
- C-API: loadImage: avoid file write race, support mem cache
- C-API: header include
- C-API: add licenserc
- HAR: update desc & license
- HAR: add bisheng
- HAR: build option
- HAR: rm main page ets

#### Features

- C-API: use https for github action
- C-API: 更新 cpp 逻辑至最新
- C-API: format cpp code
- C-API: add format.yml
- C-API: add license
- C-API: support loadImage interface
- HAR: update profile
- HAR: add cpp submodule

#### Other Changes

- C-API: 删除 FileDownloader 中锁逻辑
- C-API: Refactor NapiGetter.cpp to use Optional::value_or instead of manual has_value checks
- C-API(image): use image loader
- C-API: Initial commit

### [4.1.11-beta.2] - 2026-01-23

#### Bug Fixes

- C-API: transform-origin 第三个参数
- C-API(lint): blocks lines format
- C-API(helper): 文件下载引用修复
- C-API: 新增 aspect-ratio 修复 TransformOrigin 三个值不生效
- C-API: 修复 createAnimation 创建的动画不生效的问题
- C-API(text): 修复文本刷新问题
- C-API: fmt runtime
- C-API: loadImage: avoid file write race, support mem cache
- C-API: header include
- C-API: add licenserc
- HAR: update desc & license
- HAR: add bisheng
- HAR: build option
- HAR: rm main page ets

#### Features

- C-API: use https for github action
- C-API: 更新 cpp 逻辑至最新
- C-API: format cpp code
- C-API: add format.yml
- C-API: add license
- C-API: support loadImage interface
- HAR: update profile
- HAR: add cpp submodule

#### Other Changes

- C-API: 删除 FileDownloader 中锁逻辑
- C-API: Refactor NapiGetter.cpp to use Optional::value_or instead of manual has_value checks
- C-API(image): use image loader
- C-API: Initial commit

### [4.1.11-beta.1] - 2026-01-20

#### Bug Fixes

- C-API: transform-origin 第三个参数
- C-API(lint): blocks lines format
- C-API(helper): 文件下载引用修复
- C-API: 新增 aspect-ratio 修复 TransformOrigin 三个值不生效
- C-API: 修复 createAnimation 创建的动画不生效的问题
- C-API(text): 修复文本刷新问题
- C-API: fmt runtime
- C-API: loadImage: avoid file write race, support mem cache
- C-API: header include
- C-API: add licenserc
- HAR: update desc & license
- HAR: add bisheng
- HAR: build option
- HAR: rm main page ets

#### Features

- C-API: use https for github action
- C-API: 更新 cpp 逻辑至最新
- C-API: format cpp code
- C-API: add format.yml
- C-API: add license
- C-API: support loadImage interface
- HAR: update profile
- HAR: add cpp submodule

#### Other Changes

- C-API: 删除 FileDownloader 中锁逻辑
- C-API: Refactor NapiGetter.cpp to use Optional::value_or instead of manual has_value checks
- C-API(image): use image loader
- C-API: Initial commit

### [4.1.11-beta.0] - 2026-01-20

#### Bug Fixes

- C-API: transform-origin 第三个参数
- C-API(lint): blocks lines format
- C-API(helper): 文件下载引用修复
- C-API: 新增 aspect-ratio 修复 TransformOrigin 三个值不生效
- C-API: 修复 createAnimation 创建的动画不生效的问题
- C-API(text): 修复文本刷新问题
- C-API: fmt runtime
- C-API: loadImage: avoid file write race, support mem cache
- C-API: header include
- C-API: add licenserc
- HAR: update desc & license
- HAR: add bisheng
- HAR: build option
- HAR: rm main page ets

#### Features

- C-API: use https for github action
- C-API: 更新 cpp 逻辑至最新
- C-API: format cpp code
- C-API: add format.yml
- C-API: add license
- C-API: support loadImage interface
- HAR: update profile
- HAR: add cpp submodule

#### Other Changes

- C-API: 删除 FileDownloader 中锁逻辑
- C-API: Refactor NapiGetter.cpp to use Optional::value_or instead of manual has_value checks
- C-API(image): use image loader
- C-API: Initial commit

### [4.1.10] - 2026-01-16

#### Bug Fixes

- C-API: transform-origin 第三个参数
- C-API(lint): blocks lines format
- C-API(helper): 文件下载引用修复
- C-API: 新增 aspect-ratio 修复 TransformOrigin 三个值不生效
- C-API: 修复 createAnimation 创建的动画不生效的问题
- C-API(text): 修复文本刷新问题
- C-API: fmt runtime
- C-API: loadImage: avoid file write race, support mem cache
- C-API: header include
- C-API: add licenserc
- HAR: update desc & license
- HAR: add bisheng
- HAR: build option
- HAR: rm main page ets

#### Features

- C-API: use https for github action
- C-API: 更新 cpp 逻辑至最新
- C-API: format cpp code
- C-API: add format.yml
- C-API: add license
- C-API: support loadImage interface
- HAR: update profile
- HAR: add cpp submodule

#### Other Changes

- C-API: 删除 FileDownloader 中锁逻辑
- C-API: Refactor NapiGetter.cpp to use Optional::value_or instead of manual has_value checks
- C-API(image): use image loader
- C-API: Initial commit

### [4.1.9] - 2025-11-28

#### Bug Fixes

- C-API: transform-origin 第三个参数
- C-API(lint): blocks lines format
- C-API(helper): 文件下载引用修复
- C-API: 新增 aspect-ratio 修复 TransformOrigin 三个值不生效
- C-API: 修复 createAnimation 创建的动画不生效的问题
- C-API(text): 修复文本刷新问题
- C-API: fmt runtime
- C-API: loadImage: avoid file write race, support mem cache
- C-API: header include
- C-API: add licenserc
- HAR: update desc & license
- HAR: add bisheng
- HAR: build option
- HAR: rm main page ets

#### Features

- C-API: use https for github action
- C-API: 更新 cpp 逻辑至最新
- C-API: format cpp code
- C-API: add format.yml
- C-API: add license
- C-API: support loadImage interface
- HAR: update profile
- HAR: add cpp submodule

#### Other Changes

- C-API: 删除 FileDownloader 中锁逻辑
- C-API: Refactor NapiGetter.cpp to use Optional::value_or instead of manual has_value checks
- C-API(image): use image loader
- C-API: Initial commit

### [4.1.9-beta.7] - 2025-11-28

#### Bug Fixes

- C-API: transform-origin 第三个参数
- C-API(lint): blocks lines format
- C-API(helper): 文件下载引用修复
- C-API: 新增 aspect-ratio 修复 TransformOrigin 三个值不生效
- C-API: 修复 createAnimation 创建的动画不生效的问题
- C-API(text): 修复文本刷新问题
- C-API: fmt runtime
- C-API: loadImage: avoid file write race, support mem cache
- C-API: header include
- C-API: add licenserc
- HAR: update desc & license
- HAR: add bisheng
- HAR: build option
- HAR: rm main page ets

#### Features

- C-API: use https for github action
- C-API: 更新 cpp 逻辑至最新
- C-API: format cpp code
- C-API: add format.yml
- C-API: add license
- C-API: support loadImage interface
- HAR: update profile
- HAR: add cpp submodule

#### Other Changes

- C-API: 删除 FileDownloader 中锁逻辑
- C-API: Refactor NapiGetter.cpp to use Optional::value_or instead of manual has_value checks
- C-API(image): use image loader
- C-API: Initial commit

### [4.1.9-beta.6] - 2025-11-28

#### Bug Fixes

- C-API: transform-origin 第三个参数
- C-API(lint): blocks lines format
- C-API(helper): 文件下载引用修复
- C-API: 新增 aspect-ratio 修复 TransformOrigin 三个值不生效
- C-API: 修复 createAnimation 创建的动画不生效的问题
- C-API(text): 修复文本刷新问题
- C-API: fmt runtime
- C-API: loadImage: avoid file write race, support mem cache
- C-API: header include
- C-API: add licenserc
- HAR: update desc & license
- HAR: add bisheng
- HAR: build option
- HAR: rm main page ets

#### Features

- C-API: use https for github action
- C-API: 更新 cpp 逻辑至最新
- C-API: format cpp code
- C-API: add format.yml
- C-API: add license
- C-API: support loadImage interface
- HAR: update profile
- HAR: add cpp submodule

#### Other Changes

- C-API: 删除 FileDownloader 中锁逻辑
- C-API: Refactor NapiGetter.cpp to use Optional::value_or instead of manual has_value checks
- C-API(image): use image loader
- C-API: Initial commit

### [4.1.9-beta.5] - 2025-11-28

#### Bug Fixes

- C-API: transform-origin 第三个参数
- C-API(lint): blocks lines format
- C-API(helper): 文件下载引用修复
- C-API: 新增 aspect-ratio 修复 TransformOrigin 三个值不生效
- C-API: 修复 createAnimation 创建的动画不生效的问题
- C-API(text): 修复文本刷新问题
- C-API: fmt runtime
- C-API: loadImage: avoid file write race, support mem cache
- C-API: header include
- C-API: add licenserc
- HAR: update desc & license
- HAR: add bisheng
- HAR: build option
- HAR: rm main page ets

#### Features

- C-API: use https for github action
- C-API: 更新 cpp 逻辑至最新
- C-API: format cpp code
- C-API: add format.yml
- C-API: add license
- C-API: support loadImage interface
- HAR: update profile
- HAR: add cpp submodule

#### Other Changes

- C-API: 删除 FileDownloader 中锁逻辑
- C-API: Refactor NapiGetter.cpp to use Optional::value_or instead of manual has_value checks
- C-API(image): use image loader
- C-API: Initial commit

### [4.1.9-beta.4] - 2025-11-25

#### Bug Fixes

- C-API: transform-origin 第三个参数
- C-API(lint): blocks lines format
- C-API(helper): 文件下载引用修复
- C-API: 新增 aspect-ratio 修复 TransformOrigin 三个值不生效
- C-API: 修复 createAnimation 创建的动画不生效的问题
- C-API(text): 修复文本刷新问题
- C-API: fmt runtime
- C-API: loadImage: avoid file write race, support mem cache
- C-API: header include
- C-API: add licenserc
- HAR: update desc & license
- HAR: add bisheng
- HAR: build option
- HAR: rm main page ets

#### Features

- C-API: use https for github action
- C-API: 更新 cpp 逻辑至最新
- C-API: format cpp code
- C-API: add format.yml
- C-API: add license
- C-API: support loadImage interface
- HAR: update profile
- HAR: add cpp submodule

#### Other Changes

- C-API: 删除 FileDownloader 中锁逻辑
- C-API: Refactor NapiGetter.cpp to use Optional::value_or instead of manual has_value checks
- C-API(image): use image loader
- C-API: Initial commit

## 权限与隐私

| 项目 | 详情 |
| :--- | :--- |
| **权限名称** | 暂无 |
| **权限说明** | 暂无 |
| **使用目的** | 暂无 |
| **隐私政策** | 不涉及 |
| **SDK 合规使用指南** | 不涉及 |
| **兼容性** | HarmonyOS 版本 5.0.2 |
| **应用类型** | 应用 |
| **元服务** | 是 |
| **设备类型** | 手机、平板、PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.2 |

## 安装方式

```bash
ohpm install @taro-oh/library
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/6a576ccb05e6497c82e979000709da31/PLATFORM?origin=template