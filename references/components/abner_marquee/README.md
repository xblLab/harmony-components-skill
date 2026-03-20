# 跑马灯 marquee 组件

## 简介

marquee，一个支持横向滚动、纵向滚动、连续和停顿的跑马灯组件，不仅仅局限于文字滚动，更支持任意组件滚动！

## 详细介绍

### 功能介绍

marquee，一个支持横向滚动、纵向滚动、连续和停顿的跑马灯组件，不仅仅局限于文字滚动，更支持任意组件滚动！

1、支持纯文字滚动
2、支持纵向自定义组件连续和停顿滚动
3、支持横向自定义组件连续和停顿滚动

### 环境要求

Api 适用版本：>=12

### 示例效果



### 快速入门

**方式一：** 在 Terminal 窗口中，执行如下命令安装三方包，DevEco Studio 会自动在工程的 oh-package.json5 中自动添加三方包依赖。
建议：在使用的模块路径下进行执行命令。

```bash
ohpm install @abner/marquee
```

**方式二：** 在工程模块的 oh-package.json5 中设置三方包依赖，配置示例如下：

```json5
"dependencies": { "@abner/marquee": "^1.0.1"}
```

### 使用样例

#### 1、纯文字跑马灯

```typescript
MarqueeView({
  marqueeText: "我是一段纯文本内容，主要用来展示跑马灯效果，来吧，我们一起看一下吧",
})
```

##### 属性介绍

| 属性名 | 类型 | 描述 |
| :--- | :--- | :--- |
| marqueeText | string/Resource | 跑马灯文本数据 |
| marqueeTextAttribute | MarqueeTextAttribute | 跑马灯文本属性，设置颜色大小等 |
| marqueeStart | boolean | 控制跑马灯播放和停止，true 播放，false 暂停 |
| marqueeTextStep | number | 滚动动画文本滚动步长。默认值：4.0vp |
| marqueeFromStart | boolean | 设置文本从头开始滚动或反向滚动。true 表示从头开始滚动，false 表示反向滚动。默认值：true |
| marqueeTextDelay | number | 设置每次滚动的时间间隔。默认值：0 单位：毫秒 |
| marqueeTextLoop | number | 设置重复滚动的次数，小于等于零时无限循环。默认值：-1 |
| marqueeTextFadeout | boolean | 设置文字超长时的渐隐效果。true 表示支持渐隐效果，false 表示不支持渐隐效果。 |

##### MarqueeTextAttribute

| 属性名 | 类型 | 描述 |
| :--- | :--- | :--- |
| fontColor | Resource Color | 跑马灯文本颜色 |
| fontSize | number / string/ Resource | 跑马灯文本颜色 |
| fontFamily | string / Resource | 字体族。默认字体'HarmonyOS Sans'。 |
| fontStyle | FontStyle | 字体样式。默认值：FontStyle.Normal |
| fontWeight | number / FontWeight / ResourceStr | 文本的字体粗细 |

#### 2、纵向停顿跑马灯

```typescript
@Entry
@Component
struct VerticalPausePage {
  private marqueeDataArray: string[] = [
    "公告：我是测试消息第一条",
    "公告：我是测试消息第二条",
    "公告：我是测试消息第三条"
  ]

  /**
   *AUTHOR:AbnerMing
   *INTRODUCE:可以是任意布局
   */
  @Builder
  marqueeLayout(item: string, _: number) {
    Row() {
      SymbolGlyph($r('sys.symbol.bell_fill'))
        .fontSize(18)
        .renderingStrategy(SymbolRenderingStrategy.SINGLE)
        .fontColor([Color.Red])
        .margin({ left: 5 })
      Text(item)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .margin({ left: 5 })
    }.width("100%")
      .height(50)
  }

  build() {
    RelativeContainer() {
      ActionBar({ title: "纵向停顿跑马灯" })

      Column() {
        MarqueeView({
          marqueeData: this.marqueeDataArray, //可以传递任意类型数据数组
          marqueeType: MarqueeType.pause,
          interval:1000,
          marqueeLayout: (item: Object, index: number) => {
            this.marqueeLayout(item as string, index)
          }
        })
      }.border({ width: 1, color: Color.Red })
        .margin({ left: 10, right: 10 })
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
      .width('100%')
  }
}
```

##### 属性介绍

| 属性名 | 类型 | 描述 |
| :--- | :--- | :--- |
| marqueeData | Object[] | 跑马灯数据数组 |
| marqueeLayout | @BuilderParam | 用于传递跑马灯自定义组件，可以自定义@Builder 来实现 |
| isLoop | boolean | 是否是循环播放，默认 true 为循环 |
| interval | number | 跑马灯间隔时间，默认是 3000 毫秒 |
| autoPlay | boolean | 是否是自动播放，默认 true，是 |
| marqueeType | MarqueeType | 跑马灯类型，默认为文本类型，MarqueeType.text，pause：停顿类型，continuous：连续类型 |
| iterations | number | 循环次数，默认无限次 |
| marqueeStart | boolean | true 播放，false 暂停 |

#### 3、纵向连续跑马灯

```typescript
@Entry
@Component
struct VerticalContinuousPage {
  private marqueeDataArray: string[] = [
    "公告：我是测试消息第一条",
    "公告：我是测试消息第二条",
    "公告：我是测试消息第三条",
    "公告：我是测试消息第四条",
    "公告：我是测试消息第五条"
  ]

  /**
   *AUTHOR:AbnerMing
   *INTRODUCE:可以是任意布局
   */
  @Builder
  marqueeLayout(item: string, _: number) {
    Row() {
      SymbolGlyph($r('sys.symbol.bell_fill'))
        .fontSize(18)
        .renderingStrategy(SymbolRenderingStrategy.SINGLE)
        .fontColor([Color.Red])
        .margin({ left: 5 })
      Text(item)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .margin({ left: 5 })
    }.width("100%")
    .height(50)
  }

  /**
   *AUTHOR:AbnerMing
   *INTRODUCE:可以是任意布局
   */
  @Builder
  marqueeText(item: string, _: number) {
    Text(item)
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .margin({ left: 5 })
      .width("100%")
      .height(50)

  }

  /**
   *AUTHOR:AbnerMing
   *INTRODUCE:可以是任意布局
   */
  @Builder
  marqueeLayout2(item: string, _: number) {
    Column() {
      Image("https://loveharmony.oss-cn-beijing.aliyuncs.com/banner/banner_01.jpg")
        .width("100%")
        .height(100)
      Text(item)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .margin({ left: 5, top: 10 })
    }.width("100%")
    .padding(10)
  }

  build() {
    Column() {
      ActionBar({ title: "纵向连续跑马灯" })

      //纯文本
      MarqueeView({
        marqueeData: this.marqueeDataArray, //可以传递任意类型数据数组
        marqueeType: MarqueeType.continuous, //连续滚动
        marqueeLayout: (item: Object, index: number) => {
          this.marqueeText(item as string, index)
        }
      }).border({ width: 1, color: Color.Red })

      //自定义布局 1
      MarqueeView({
        marqueeData: this.marqueeDataArray, //可以传递任意类型数据数组
        marqueeType: MarqueeType.continuous, //连续滚动
        marqueeLayout: (item: Object, index: number) => {
          this.marqueeLayout(item as string, index)
        }
      }).border({ width: 1, color: Color.Red })
        .margin({ top: 20 })

      //自定义布局 2
      MarqueeView({
        marqueeData: this.marqueeDataArray, //可以传递任意类型数据数组
        marqueeType: MarqueeType.continuous, //连续滚动
        marqueeLayout: (item: Object, index: number) => {
          this.marqueeLayout2(item as string, index)
        }
      }).border({ width: 1, color: Color.Red })
        .margin({ top: 20 })

    }.padding({ left: 20, right: 20 })
    .height('100%')
    .width('100%')
  }
}
```

##### 属性介绍

| 属性名 | 类型 | 描述 |
| :--- | :--- | :--- |
| marqueeData | Object[] | 跑马灯数据数组 |
| marqueeLayout | @BuilderParam | 用于传递跑马灯自定义组件，可以自定义@Builder 来实现 |
| isLoop | boolean | 是否是循环播放，默认 true 为循环 |
| interval | number | 跑马灯间隔时间，默认是 3000 毫秒 |
| autoPlay | boolean | 是否是自动播放，默认 true，是 |
| marqueeType | MarqueeType | 跑马灯类型，默认为文本类型，MarqueeType.text，pause：停顿类型，continuous：连续类型 |
| iterations | number | 循环次数，默认无限次 |
| marqueeStart | boolean | true 播放，false 暂停 |

#### 4、横向停顿跑马灯

```typescript
@Entry
@Component
struct HorizontalPausePage {
  private marqueeDataArray: string[] = [
    "公告：我是测试消息第一条",
    "公告：我是测试消息第二条",
    "公告：我是测试消息第三条"
  ]

  /**
   *AUTHOR:AbnerMing
   *INTRODUCE:可以是任意布局
   */
  @Builder
  marqueeLayout(item: string, index: number) {
    Row() {
      SymbolGlyph($r('sys.symbol.bell_fill'))
        .fontSize(18)
        .renderingStrategy(SymbolRenderingStrategy.SINGLE)
        .fontColor([Color.Red])
        .margin({ left: 5 })
      Text(item)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .margin({ left: 5 })
    }.width("100%")
    .height(50)
    .justifyContent(FlexAlign.Center) //内容居中
  }

  build() {
    Column() {
      ActionBar({ title: "横向停顿跑马灯" })
      Column() {
        MarqueeView({
          marqueeData: this.marqueeDataArray, //可以传递任意类型数据数组
          marqueeDirection: MarqueeDirection.horizontal, //横向滚动
          marqueeType: MarqueeType.pause,
          marqueeLayout: (item: Object, index: number) => {
            this.marqueeLayout(item as string, index)
          }
        })
      }.border({ width: 1, color: Color.Red })
      .margin({ left: 10, right: 10, top: 50 })
    }
    .height('100%')
    .width('100%')
  }
}
```

##### 属性介绍

| 属性名 | 类型 | 描述 |
| :--- | :--- | :--- |
| marqueeData | Object[] | 跑马灯数据数组 |
| marqueeLayout | @BuilderParam | 用于传递跑马灯自定义组件，可以自定义@Builder 来实现 |
| isLoop | boolean | 是否是循环播放，默认 true 为循环 |
| interval | number | 跑马灯间隔时间，默认是 3000 毫秒 |
| autoPlay | boolean | 是否是自动播放，默认 true，是 |
| marqueeType | MarqueeType | 跑马灯类型，默认为文本类型，MarqueeType.text，pause：停顿类型，continuous：连续类型 |
| iterations | number | 循环次数，默认无限次 |
| marqueeStart | boolean | true 播放，false 暂停 |

#### 5、横向连续跑马灯

```typescript
@Entry
@Component
struct HorizontalContinuousPage {
  private marqueeDataArray: string[] = [
    "公告：我是测试消息第一条",
    "公告：我是测试消息第二条",
    "公告：我是测试消息第三条"
  ]

  /**
   *AUTHOR:AbnerMing
   *INTRODUCE:可以是任意布局
   */
  @Builder
  marqueeText(item: string, _: number) {
    Text(item)
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .margin({ left: 5 })
      .width("100%")
      .height(50)

  }

  /**
   *AUTHOR:AbnerMing
   *INTRODUCE:可以是任意布局
   */
  @Builder
  marqueeLayout(item: string, _: number) {
    Row() {
      SymbolGlyph($r('sys.symbol.bell_fill'))
        .fontSize(18)
        .renderingStrategy(SymbolRenderingStrategy.SINGLE)
        .fontColor([Color.Red])
        .margin({ left: 5 })
      Text(item)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .margin({ left: 5 })
    }.width("100%")
    .height(50)
  }


  /**
   *AUTHOR:AbnerMing
   *INTRODUCE:可以是任意布局
   */
  @Builder
  marqueeLayout2(item: string, _: number) {
    Column() {
      Image("https://loveharmony.oss-cn-beijing.aliyuncs.com/banner/banner_01.jpg")
        .width("100%")
        .height(100)
      Text(item)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .margin({ left: 5, top: 10 })
    }.width("100%")
    .padding(10)
  }

  build() {
    Column() {
      ActionBar({ title: "横向连续跑马灯" })

      //纯文本
      MarqueeView({
        marqueeData: this.marqueeDataArray, //可以传递任意类型数据数组
        marqueeType: MarqueeType.continuous, //连续滚动
        marqueeDirection: MarqueeDirection.horizontal, //横向
        marqueeLayout: (item: Object, index: number) => {
          this.marqueeText(item as string, index)
        }
      }).border({ width: 1, color: Color.Red })

      //自定义布局 1
      MarqueeView({
        marqueeData: this.marqueeDataArray, //可以传递任意类型数据数组
        marqueeType: MarqueeType.continuous, //连续滚动
        marqueeDirection: MarqueeDirection.horizontal, //横向
        marqueeLayout: (item: Object, index: number) => {
          this.marqueeLayout(item as string, index)
        }
      }).border({ width: 1, color: Color.Red })
        .margin({ top: 20 })

      //自定义布局 2
      MarqueeView({
        marqueeData: this.marqueeDataArray, //可以传递任意类型数据数组
        marqueeType: MarqueeType.continuous, //连续滚动
        marqueeDirection: MarqueeDirection.horizontal, //横向
        marqueeLayout: (item: Object, index: number) => {
          this.marqueeLayout2(item as string, index)
        }
      }).border({ width: 1, color: Color.Red })
        .margin({ top: 20 })

    }
    .height('100%')
    .width('100%')
    .padding({ left: 10, right: 10 })
  }
}
```

##### 属性介绍

| 属性名 | 类型 | 描述 |
| :--- | :--- | :--- |
| marqueeData | Object[] | 跑马灯数据数组 |
| marqueeLayout | @BuilderParam | 用于传递跑马灯自定义组件，可以自定义@Builder 来实现 |
| isLoop | boolean | 是否是循环播放，默认 true 为循环 |
| interval | number | 跑马灯间隔时间，默认是 3000 毫秒 |
| autoPlay | boolean | 是否是自动播放，默认 true，是 |
| marqueeType | MarqueeType | 跑马灯类型，默认为文本类型，MarqueeType.text，pause：停顿类型，continuous：连续类型 |
| iterations | number | 循环次数，默认无限次 |
| marqueeStart | boolean | true 播放，false 暂停 |

## API 说明

Api 适用版本：>=12

### 配置说明

纯组件，无需配置

### 权限要求

纯组件，无权限要求

### 技术支持

在 Github 中的 Issues 中提问题，定期解答。

### 开源许可协议

```text
Copyright (C) AbnerMing, marquee Open Source Project

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

## 更新记录

- **1.0.1 (2026-01-26)**：跑马灯组件优化 Api18 及以下的属性适配。
- **1.0.0 (2025-11-17)**：跑马灯组件 1.0.0 版本提交
  - 支持纯文字滚动
  - 支持纵向自定义组件连续和停顿滚动
  - 支持横向自定义组件连续和停顿滚动

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无权限 | 无权限 | 无权限 |

## SDK 合规使用指南

不涉及

## 兼容性

| 项目 | 详情 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 Created with Pixso. |
| HarmonyOS 版本 | 5.0.1 Created with Pixso. |
| HarmonyOS 版本 | 5.0.2 Created with Pixso. |
| HarmonyOS 版本 | 5.0.3 Created with Pixso. |
| HarmonyOS 版本 | 5.0.4 Created with Pixso. |
| HarmonyOS 版本 | 5.0.5 Created with Pixso. |
| HarmonyOS 版本 | 5.1.0 Created with Pixso. |
| HarmonyOS 版本 | 5.1.1 Created with Pixso. |
| HarmonyOS 版本 | 6.0.0 Created with Pixso. |
| HarmonyOS 版本 | 6.0.1 Created with Pixso. |
| 应用类型 | 应用 Created with Pixso. |
| 应用类型 | 元服务 Created with Pixso. |
| 设备类型 | 手机 Created with Pixso. |
| 设备类型 | 平板 Created with Pixso. |
| 设备类型 | PC Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.0 Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.1 Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.0 Created with Pixso. |

## 安装方式

```bash
ohpm install @abner/marquee
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/625ae135d7ed4fe7aee3e3f8b99a9f91/b6a17875746941e0b5606c9b1eb174f8?origin=template