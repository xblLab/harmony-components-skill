# BulletChat 手持弹幕组件

## 简介

这是一款基于 HarmonyOS 开发的创新性手持弹幕应用组件专为粉丝应援场景打造！它不仅仅是一个简单的文字展示工具，更融入了鸿蒙生态独特的 分布式能力与交互乐趣，使其具备了极高的 可玩性和便捷性。核心亮点在于其独创的“碰一碰”和“抓一抓”分享功能，让应援信息的传递瞬间完成，心意即刻同步！

## 详细介绍

```text
视频播放器 is loading.播放视频播放静音当前时间 0:00/时长 0:24加载完毕：100.00%0:00媒体流类型 直播Seek to live, currently behind live 直播剩余时间 -0:24 1x 播放速度 2x1.75x1.5x1.25x1x, 选择 0.5x 节目段落节目段落描述关闭描述，选择字幕字幕设定，开启字幕设置弹窗关闭字幕，选择音轨画中画全屏This is a modal window.开始对话视窗。离开会取消及关闭视窗文字 Color 白黑红绿蓝黄紫红青 Transparency 不透明半透明背景 Color 黑白红绿蓝黄紫红青 Transparency 不透明半透明透明视窗 Color 黑白红绿蓝黄紫红青 Transparency 透明半透明不透明字体尺寸 50%75%100%125%150%175%200%300%400% 字体边缘样式无浮雕压低均匀下阴影字体库比例无细体单间隔无细体比例细体单间隔细体舒适手写体小型大写字体重启 恢复全部设定至预设值完成关闭弹窗结束对话视窗
```

BulletChat
这是一款基于 HarmonyOS 开发的创新性手持弹幕应用组件专为粉丝应援场景打造！它不仅仅是一个简单的文字展示工具，更融入了鸿蒙生态独特的 分布式能力与交互乐趣，使其具备了极高的 可玩性和便捷性。核心亮点在于其独创的“碰一碰”和“抓一抓”分享功能，让应援信息的传递瞬间完成，心意即刻同步！

### 如何下载

深色代码主题复制

```bash
ohpm install @shuishenhuole/bulletchat
```

### 演示图片

演示图片

### 演示视频

点击播放

### 前置配置

碰一碰和抓一抓依赖与 app linking 能力
相关配置可以查阅如下文档实现
我的个人网站
csdn 发布的文章
华为技术社区

### 组件介绍

#### 参数说明

| 参数名 | 类型 | 是否必填 | 描述 |
| :--- | :--- | :--- | :--- |
| text | string | 是 | 弹幕文字 |
| title | string | 是 | 弹幕分享标题 |
| desc | string | 是 | 弹幕分享描述 |
| OpenLink | string | 是 | 分享的 app linking 链接 |
| fontOption | FontOption | 否 | 字体的配置文件 |
| BCbackgroundColor | ResourceColor | 否 | 背景板的颜色 默认为 Color.Black |

##### FontOption 对象说明

| 参数名 | 类型 | 是否必填 | 描述 |
| :--- | :--- | :--- | :--- |
| fontSize | Length | 否 | 弹幕字体大小 |
| fontWeight | FontWeight \| number \| string | 否 | 弹幕字体粗细 |
| fontFamily | Resource \| string | 否 | 弹幕的字体族 |
| fontStyle | FontStyle | 否 | 弹幕字体的样式 |
| fontColor | ResourceColor | 否 | 弹幕字体颜色 |
| letterSpacing | number \| ResourceStr | 否 | 弹幕的字体间距 |
| textShadow | ShadowOptions \| Array | 否 | 弹幕的字体阴影 |
| marqueeOptions | TextMarqueeOptions | 否 | Marquee 初始化参数 (需要 sdk 版本>=18) |

##### TextMarqueeOptions 对象说明

| 参数名 | 类型 | 是否必填 | 描述 |
| :--- | :--- | :--- | :--- |
| start | boolean | 是 | 控制跑马灯进入播放状态。true 表示播放，false 表示不播放。 |
| step | number | 否 | 滚动动画文本滚动步长。默认值：4.0vp |
| loop | number | 否 | 设置重复滚动的次数，小于等于零时无限循环。默认值：-1 |
| fromStart | boolean | 否 | 设置文本从头开始滚动或反向滚动。true 表示从头开始滚动，false 表示反向滚动。默认值：true |
| delay | number | 否 | 设置每次滚动的时间间隔。默认值：0 单位：毫秒 |
| fadeout | boolean | 否 | 设置文字超长时的渐隐效果。true 表示支持渐隐效果，false 表示不支持渐隐效果。当 Text 内容超出显示范围时，未完全展现的文字边缘将应用渐隐效果。若两端均有文字未完全显示，则两端同时应用渐隐效果。在渐隐效果开启状态下，clip 属性将自动锁定为 true，不允许设置为 false。默认值：false |
| marqueeStartPolicy | MarqueeStartPolicy | 否 | 设置跑马灯启动策略，该属性值生效需将 start 设置为 true。默认值：MarqueeStartPolicy.DEFAULT |

##### MarqueeStartPolicy 枚举说明

| 名称 | 值 | 说明 |
| :--- | :--- | :--- |
| DEFAULT | 0 | 默认持续滚动。 |
| ON_FOCUS | 1 | 获焦以及鼠标悬浮时开始滚动。 |

### 使用方法

深色代码主题复制

```typescript
BulletChat({
  text:"Hello world",
  title:"share kit",
  desc:"来自水深火乐的分享",
  OpenLink:"{app linking 链接}",
  fontOption:{
    fontSize:100,
    textShadow:{
      radius:20,
      color:Color.Green
    }
  }
})
```

### 注意

- 实现抓一抓需要 sdk 版本为 20
- 实现碰一碰需要 sdk 版本为 12

### 更多

- Share Kit（分享服务）能力可以查阅官方文档
- 相关的 arqueestartpolicy18 枚举说明依赖于 Text 组件可以查看官方文档
- 相关的 TextMarqueeOptions 对象配置依赖于 Text 组件可以查看官方文档

### 更新记录

- **2.1.2 (2026-01-12)**: 修复了组件颜色更新不变化的问题
- **2.0.1 (2025-12-03)**: 增加了文字的配置文件可以实现文字的多样化配置
- **1.0.2 (2025-11-12)**: 基于 HarmonyOS 实现的可玩性极高的手持弹幕组件，支持碰一碰，抓一抓。仅需少量配置就可以实现炫酷的功能！

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 | 暂无 |

隐私政策不涉及 SDK 合规使用指南 不涉及

### 兼容性

| 项目 | 详情 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.5 <br> Created with Pixso. |
| | 5.1.0 <br> Created with Pixso. |
| | 5.1.1 <br> Created with Pixso. |
| | 6.0.0 <br> Created with Pixso. |
| 应用类型 | 应用 <br> Created with Pixso. |
| 元服务 | 元服务 <br> Created with Pixso. |
| 设备类型 | 手机 <br> Created with Pixso. |
| | 平板 <br> Created with Pixso. |
| | PC <br> Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 <br> Created with Pixso. |
| | DevEco Studio 5.1.0 <br> Created with Pixso. |
| | DevEco Studio 5.1.1 <br> Created with Pixso. |
| | DevEco Studio 6.0.0 <br> Created with Pixso. |

## 安装方式

```bash
ohpm install @shuishenhuole/bulletchat
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/214a6543a6594914b9c3ce09a8715206/9f7ea0a461e248d0935ca724ffcaa005?origin=template