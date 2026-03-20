# TextLayoutBuilder 文本样式定制组件

## 简介

一个可定制任意文字字体样式、文字颜色、大小、间距等的文本构建工具、自定义所需风格。

## 详细介绍

### 简介

TextLayoutBuilder 是一个可定制任意样式的文本构建工具，包括字体间距、大小、颜色、布局方式、富文本高亮显示等，在文字显示的业务场景中都会使用到，特别是通知类特殊显示的字体样式时，TextLayoutBuilder 极大的方便了开发者的开发效率。

### 效果演示

### 下载安装

```bash
ohpm install @ohos/textlayoutbuilder
```

### 使用说明

**第一步：** 初始化，导入 TextLayout 组件到自己项目中，实例化 TextLayout.Layout 对象；

```typescript
import TextLayout from '@ohos/textlayoutbuilder';
import {TextInfo} from '@ohos/textlayoutbuilder';

@State layout: TextLayout.Layout = new TextLayout.Layout(); 
```

**第二步：** 属性设置，通过 layout 类对象设置 UI 属性来自定义所需风格，也可以添加所需的回调；

```typescript
private aboutToAppear() {
    let textInfo = new TextInfo();
    textInfo.setStart(2)
    textInfo.setEnd(8)
    textInfo.setFontColor('#ff0000')
    // ... ...

    this.layout
    .setText(this.strTest)
    .setSpecialTextInfo(textInfo1)
    .setSpecialTextInfo(textInfo2)
    .setSpecialTextInfo(textInfo3)
    .setSpecialTextClick((textInfo) =>{
        console.info('点击了 = '+textInfo.getText())
    });
}
```

**第三步：** 界面绘制，将定制好的 layout 传给 TextLayout。

```typescript
build() {
    Column() {
         Text("默认显示").fontSize(16).fontColor("#999999").margin({ left: 14, top: 14, bottom: 14 })
         Column() {
            TextLayout({ model: this.layout })
         }.backgroundColor("#cccccc").margin({ left: 14, right: 14 }).borderRadius(10)
    }.alignItems(HorizontalAlign.Start)
}
```

### 接口说明

#### 设置文字内容：layout.setText(text: string)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| text | string | 是 | 文本内容 |

#### 设置指定文字内容样式：layout.setSpecialTextInfo(specialTextInfo: TextInfo)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| specialTextInfo | TextInfo | 是 | 文本内容样式 |

#### 设置文字颜色：layout.setTextColor(textColor: string\|Color\|number)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| textColor | string \| Color \| number | 是 | 文本颜色 |

#### 设置是否单行显示：layout.setSingleLine(singleLine: boolean)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| singleLine | boolean | 是 | 是否单行显示，默认否 |

#### 设置最大行数：layout.setMaxLines(maxLines: number)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| maxLines | number | 是 | 最大行数 |

#### 设置文本显示不下时的省略号替代方式：layout.setEllipsize(ellipsize: TextOverflow)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| ellipsize | TextOverflow | 是 | 文本溢出显示方式 |

#### 设置文本对齐方式：layout.setAlignment(textalign: TextAlign)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| textalign | TextAlign | 是 | 文本对齐方式 |

#### 设置每行最小显示字数：layout.setMinEms(minEms: number)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| minEms | number | 是 | 每行显示字数 |

#### 设置组件是否设置内边距：layout.setIncludeFontPadding(shouldInclude: boolean)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| shouldInclude | boolean | 是 | 是否设置 padding，默认否 |

#### 设置最大宽度：layout.setMaxWidth(maxWidth: number)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| maxWidth | number | 是 | 最大宽度 |

#### 设置是否开启按下文字时状态变化开关：layout.setIsEnablePressState(isEnablePressState: boolean)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| isEnablePressState | boolean | 是 | 是否开启按下文字时状态变化开关，默认否 |

#### 设置按下文字状态样式：layout.setTextPressStateStyle(textPressStateStyle: string)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| textPressStateStyle | string | 是 | 按下文字状态样式 |

#### 设置指定文本的点击事件：layout.setSpecialTextClick(clickCallback: (textInfo: TextInfo) => void)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| clickCallback | (textInfo: TextInfo) => void | 是 | 用户自定义回调函数 |

#### 特殊字符属性设置：let textInfo = new TextInfo();

##### 设置特殊文字开始位置：textInfo.setStart(start:number)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| start | number | 是 | 特殊文字开始位置 |

##### 设置特殊文字结束位置：textInfo.setEnd(end:number)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| end | number | 是 | 特殊文字结束位置 |

##### 设置文字颜色：textInfo.setFontColor(fontColor:string)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| fontColor | string | 是 | 文字颜色 |

##### 设置文字内容：textInfo.setText(text:string)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| text | string | 是 | 文本内容 |

##### 设置文字类型：textInfo.setTextType(textType:string)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| textType | string | 是 | 文本类型（TEXT_TYPE_NORMAL\|TEXT_TYPE_RICH\|TEXT_TYPE_HTTP） |

##### 设置文本字体之间的距离：textInfo.setFontLetterSpacing(fontLetterSpacing:string)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| fontLetterSpacing | string | 是 | 文本字体之间的距离 |

##### 设置字体大小：textInfo.setFontSize(fontSize:string)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| fontSize | string | 是 | 字体大小 |

##### 设置字体样式：textInfo.setFontStyle(fontStyle:string)

| 参数名 | 参数类型 | 必填 | 参数描述 |
| :--- | :--- | :--- | :--- |
| fontStyle | string | 是 | 字体样式 |

## 约束与限制

在下述版本验证通过：

- DevEco Studio: NEXT Release(5.0.3.900), SDK: API12 (5.0.0.71)
- DevEco Studio 版本：3.1 Beta2(3.1.0.400), SDK: API9 Release(3.2.11.9)

## 目录结构

```text
|---- TextLayoutBuilder
|     |---- entry  # 示例代码文件夹
|     |---- library  # TextLayout 库文件夹
|          |---- src
|            |---- main
|              |---- ets
|                  |---- commonents
|                       |---- TextInfo.ets  # 富文本数据实体
|                       |---- TextLayout.ets  # UI 自定义组件
|           |---- index.ets  # 对外接口
|     |---- README.md  # 安装使用方法
```

## 关于混淆

如果希望 ohos_text_layout_builder 库在代码混淆过程中不会被混淆，需要在混淆规则配置文件 obfuscation-rules.txt 中添加相应的排除规则：

```text
-keep
./oh_modules/@ohos/textlayoutbuilder
```

## 更新记录

### v2.0.4

- Release version 2.0.4
- v2.0.4-rc.0
- Dynamic render

### v2.0.3

- Release 2.0.3
- v2.0.3-rc.0
- Code obfuscation

### v2.0.2

- Chore: Added supported device types

### v2.0.1

- ArkTs 语法适配

### v2.0.0

- 包管理工具由 npm 切换成 ohpm
- 适配 DevEco Studio 版本：3.1 Beta2(3.1.0.400), SDK: API9 Release(3.2.11.9)

### v1.1.1

- 适配 DevEco Studio: 3.1 Beta1(3.1.0.200), SDK: API9 (3.2.10.6)

### v1.1.0

- 名称由 TextLayoutBuilder-ETS 修改 TextLayoutBuilder。
- 旧的包@ohos/TextLayoutBuilder-ETS 已不维护，请使用新包@ohos/textlayoutbuilder

### v1.0.1

- 布局调整；
- api8 升级到 api9；
- 处理硬编码问题。

### v1.0.0

实现的功能具体如下：

- 文字字体样式，文字颜色，大小，间距等；
- 文字排版方向，对齐方式；
- 副文本样式，点击事件。

未实现的功能如下：

- 文字渐变颜色；
- 文字行间距；
- 副文本插入图片。

## 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

| 项目 | 说明 |
| :--- | :--- |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 信息 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | 支持 |
| 设备类型 | 手机、平板、PC |
| DevEco Studio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @ohos/textlayoutbuilder
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/8bcc73d59aea46c4981d2136a58b4e42/PLATFORM?origin=template