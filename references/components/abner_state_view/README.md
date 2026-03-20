# 缺省页 state_view 组件

## 简介

state_view 是一个简单的缺省页组件，目前支持 35 种默认缺省样式，可根据属性修改样式，也支持自定义样式。

## 详细介绍

### 功能介绍

state_view 是一个简单的缺省页组件，目前支持 35 种默认缺省样式，可根据属性修改样式，也支持自定义样式。

### 环境要求

Api 适用版本：>=12

### 目前功能

1. 支持 35 种默认缺省样式。
2. 支持修改大小，颜色等属性。
3. 支持动态显示隐藏控件。
4. 支持自定义样式。

## 示例效果

## 快速入门

### 方式一

在 Terminal 窗口中，执行如下命令安装三方包，DevEco Studio 会自动在工程的 oh-package.json5 中自动添加三方包依赖。

建议：在使用的模块路径下进行执行命令。

```bash
ohpm install @abner/state_view
```

### 方式二

在需要的模块中的 oh-package.json5 中设置三方包依赖，配置示例如下：

```json5
"dependencies": { "@abner/state_view": "^1.0.0"}
```

## 使用样例

```typescript
StateView({
  prompt: "数据为空",
  stateModel: StateModel.blank
})
```

## API 说明

Api 适用版本：>=12

### 配置说明

常见属性配置如下：

#### 属性类型概述

| 属性 | 类型 | 描述 |
| :--- | :--- | :--- |
| sWidthLength | Length | 组件宽度，默认 100% |
| sHeightLength | Length | 组件高度，默认 100% |
| sPadding | Padding / Length / LocalizedPadding | 组件内边距 |
| sMargin | Margin / Length / LocalizedMargin | 组件外边距 |
| prompt | string / Resource | 缺省页提示信息 |
| btnText | string / Resource | 按钮文字信息 |
| bgColor | ResourceColor | 缺省页背景颜色 |
| stateModel | StateModel | 缺省页模式 |
| hidePrompt | boolean | 是否隐藏信息提示，默认不隐藏 |
| hideButton | boolean | 是否隐藏按钮，默认不隐藏 |
| contentAttribute | (attr: ContentAttribute) => void | 设置内容属性 |

### StateModel

默认的缺省页类型

```typescript
// 数据为空
StateModel.blank
// 暂无数据
StateModel.noData
// 请等待
StateModel.pleaseWait
// 暂无地址
StateModel.noAddress
// 暂无文件
StateModel.noProblem
// 暂无计划
StateModel.noPlan
// 暂无会议
StateModel.noMeeting
// 暂无任务
StateModel.noTask
// 暂无审批
StateModel.noApproval
// 暂无意见
StateModel.noOpinion
// 暂无预警
StateModel.noWarning
// 暂无方案
StateModel.noScheme
// 暂无搜索
StateModel.noSearch
// 暂无灵感
StateModel.noInspiration
// 暂无工作
StateModel.noWork
// 暂无短信
StateModel.noMessage
// 暂无动态
StateModel.noDynamic
// 暂无网络
StateModel.noNetwork
// 暂无数据 02
StateModel.noData02
// 暂无数据 03
StateModel.noData03
// 暂无数据 04
StateModel.noData04
// 暂无数据 05
StateModel.noData05
// 暂无数据 06
StateModel.noData06
// 暂无数据 07
StateModel.noData07
// 暂无数据 08
StateModel.noData08
// 暂无数据 09
StateModel.noData09
// 暂无数据 10
StateModel.noData10
// 暂无数据 11
StateModel.noData11
// 错误 404
StateModel.error404
// 错误 404_02
StateModel.error40402
// 错误 404_03
StateModel.error40403
// 加载中
StateModel.loading
// 暂无优惠券
StateModel.noDiscount
// 未开启定位
StateModel.noLocation
// 暂无评论
StateModel.noComment
// 自定义图片
StateModel.default
```

### ContentAttribute

缺省页内容属性，可以配置图标，信息，按钮等属性。

#### 属性类型概述

| 属性 | 类型 | 描述 |
| :--- | :--- | :--- |
| iconSrc | PixelMap / ResourceStr / DrawableDescriptor | 图标资源 |
| iconWidth | Length | 图标宽度，默认 200 |
| iconHeight | Length | 图标高度，默认 200 |
| iconFillColor | ResourceColor | 图标颜色 |
| iconBorder | BorderOptions | 图标边框样式 |
| iconOnClick | (event: ClickEvent) => void | 图标事件点击 |
| iconBgColor | ResourceColor | icon 背景颜色 |
| iconObjectFit | ImageFit | 设置图片填充效果 |
| textFontColor | ResourceColor | 文字提示信息颜色 |
| textFontSize | number / string / Resource | 文字提示信息大小 |
| textMargin | Margin / Length / LocalizedMargin | 文字提示信息边距 |
| textAlign | TextAlign | 文字居中方式 |
| textOnClick | (event: ClickEvent) => void | 文字提示信息点击组件 |
| fontStyle | FontStyle | 文字提示信息样式 |
| fontWeight | number / FontWeight / ResourceStr | 文字提示字重 |
| btnMargin | Margin / Length / LocalizedMargin | 按钮边距 |
| btnBgColor | ResourceColor | 按钮背景颜色 |
| btnFontColor | ResourceColor | 按钮文字颜色 |
| btnWidth | Length | 按钮宽度 |
| btnHeight | Length | 按钮高度 |
| btnBorder | BorderOptions | 按钮边框 |
| btnFontSize | number / string / Resource | 按钮文字大小 |
| btnFontStyle | FontStyle | 按钮文字样式 |
| btnFontWeight | number / FontWeight / string | 按钮文字字重 |
| btnStateEffect | boolean | 设置按钮是否开启按压态显示效果，默认开启 |
| btnOnClick | (event: ClickEvent) => void | 按钮点击事件 |

## 权限要求

无权限要求。

## 技术支持

在 Github 中的 Issues 中提问题，定期解答。

## 开源许可协议

该代码经过 Apache 2.0 授权许可。

## 更新记录

### 1.0.0 (2026-01-28)

1. 支持 35 种默认缺省样式。
2. 支持修改大小，颜色等属性。
3. 支持动态显示隐藏控件。
4. 支持自定义样式。

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无权限 | 无权限 | 无权限 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

### HarmonyOS 版本

- 5.0.5
- 5.1.0
- 5.1.1
- 6.0.0
- 6.0.1
- 6.0.2

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEcoStudio 版本

- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0
- DevEco Studio 6.0.1
- DevEco Studio 6.0.2

## 安装方式

```bash
ohpm install @abner/state_view
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/975e4048fd43496aa9ef7dadbba14047/b6a17875746941e0b5606c9b1eb174f8?origin=template