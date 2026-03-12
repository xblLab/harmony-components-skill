# 意见反馈组件

## 简介

本组件提供了通用的自定义的意见反馈功能，数据有问题描述、多张问题截图、联系电话号码、提交时间，四种数据。使用时可以传入想要的最大问题描述长度和最大问题截图数量，在使用处点提交按钮直接获取一条意见反馈的总数据，电话号码长度为11。开发者可以根据业务需要快速实现意见反馈功能。

## 详细介绍

### 简介

本组件提供了通用的自定义的意见反馈功能，数据有问题描述、多张问题截图、联系电话号码、提交时间，四种数据。

使用时可以传入想要的最大问题描述长度和最大问题截图数量，在使用处点提交按钮直接获取一条意见反馈的总数据，电话号码长度为11。开发者可以根据业务需要快速实现意见反馈功能。

### 约束与限制

#### 环境

- DevEco Studio版本：DevEco Studio 5.0.3 Release及以上
- HarmonyOS SDK版本：HarmonyOS 5.0.3 Release SDK及以上
- 设备类型：华为手机（直板机）
- 系统版本：HarmonyOS 5.0.1(13)及以上

### 快速入门

#### 安装组件

如果是在DevEco Studio使用插件集成组件，则无需安装组件，请忽略此步骤。

如果是从生态市场下载组件，请参考以下步骤安装组件：

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的XXX目录下。

b. 在项目根目录build-profile.json5添加feed_back模块。

```json5
// 在项目根目录build-profile.json5填写feed_back路径。其中XXX为组件存放的目录名。
"modules": [
  {
    "name": "feed_back",
    "srcPath": "./XXX/feed_back",
  }
]
```

c. 在项目根目录oh-package.json5中添加依赖。

```json5
// XXX为组件存放的目录名称
"dependencies": {
  "feed_back": "file:./XXX/feed_back"
}
```

#### 引入组件句柄

```typescript
import { Feedback } from 'feed_back';
```

#### 调用组件，详细参数配置说明参见API参考

```typescript
import { Feedback } from "feed_back"
@Entry
@ComponentV2
export struct Index {
  build() {
    Column() {
      Feedback()
    }
    .width('100%')
    .height('100%')
  }
}
```

### API参考

#### 子组件

1、问题描述

```typescript
FeedDes(){}
```

2、问题截图

```typescript
FeedPic(){}
```

3、联系电话

```typescript
FeedPhone(){}
```

#### 接口

`Feedback(options: FeedbackOptions)`

意见反馈组件。

参数：

| 参数名 | 类型 | 是否必填 | 说明 |
|--------|------|----------|------|
| options | FeedbackOptions | 是 | 意见反馈组件相关参数 |

FeedbackOptions对象说明：

| 参数名 | 类型 | 是否必填 | 说明 |
|--------|------|----------|------|
| des | number | 否 | 最大问题描述长度 |
| num | number | 否 | 最大问题截图数量 |

#### 事件

支持以下事件：

**butOnClick**

```typescript
butOnClick: () => void = () => {}
```

点击提交按钮时返回一条完整的意见反馈数据。

#### 示例代码

```typescript
import { Feedback } from "feed_back"
@Entry
@ComponentV2
export struct Index {
  build() {
    Column() {
      Feedback()
    }
    .width('100%')
    .height('100%')
  }
}
```

### 更新记录

#### 1.0.2 (2025-09-25)

下载该版本

调整readme说明

#### 1.0.1 (2025-08-29)

下载该版本

- 部分文件代码抽离

#### 1.0.0 (2025-07-02)

下载该版本

本组件提供了通用的自定义的意见反馈功能，数据有问题描述、多张问题截图、联系电话号码、提交时间，四种数据。使用时可以传入想要的最大问题描述长度和最大问题截图数量，在使用处点提交按钮直接获取一条意见反馈的总数据，电话号码长度为11。开发者可以根据业务需要快速实现意见反馈功能。

### 权限与隐私

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
|----------|----------|----------|
| 无 | 无 | 无 |

#### 隐私政策

不涉及

#### SDK合规使用指南

不涉及

### 兼容性

#### HarmonyOS版本

- 5.0.1
- 5.0.2
- 5.0.3
- 5.0.4
- 5.0.5

#### 应用类型

- 应用
- 元服务

#### 设备类型

- 手机
- 平板
- PC

#### DevEcoStudio版本

- DevEco Studio 5.0.3
- DevEco Studio 5.0.4
- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0

## 来源

- 原始URL: https://developer.huawei.com/consumer/cn/market/prod-detail/7160a26933a1426c92f279d75448e8dc/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%84%8F%E8%A7%81%E5%8F%8D%E9%A6%88%E7%BB%84%E4%BB%B6/feed_back1.0.2.zip