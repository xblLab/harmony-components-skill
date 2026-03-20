# RoundedImageView 图片形状组件

## 简介

RoundedImageView 支持许多附加功能，包括椭圆、圆角矩形、ScaleTypes 和 TileModes。

## 详细介绍

### 简介

RoundedImageView 支持圆角（和椭圆或圆形）的快速 ImageView。它支持许多附加功能，包括椭圆、圆角矩形、ScaleTypes 和 TileModes。

### 效果展示

### 安装教程

```bash
ohpm install @ohos/roundedimageview
```

### 使用说明

#### 在 page 页面引入包

```typescript
import { RoundedImageView, ScaleType, TileMode, SrcType, FileUtils } from '@ohos/roundedimageview/'
```

#### 创建多种 PictureItem 实例用于构造数据，使用方法类似

#### 初始化

实例化 dialogController 和对应的 RoundedImageView.Model 对象，并添加 typeArr 类型以标记当前页页面类型。

```typescript
dialogController: CustomDialogController = new CustomDialogController({
  alignment: DialogAlignment.Top,
  builder: TypeCustomDialog({ typeValue: $typeValue }),
  autoCancel: true
})

private initViewModels(): void {
  let viewModelsLength = Math.max(this.picIdxArr.length, this.colorIdxArr.length)
  for (var index = 0; index < viewModelsLength; index++) {
    this.viewModels.push(new RoundedImageView.Model)
  }
}
```

#### 属性设置

通过 Model 类对象设置 UI 属性来自定义所需风格。

```typescript
private updateViewModels(pictureItem: PictureItem[]) {
  pictureItem.forEach((val, idx) => {
    this.viewModels[idx]
      .setImageSrc(pictureItem[idx].src)
      .setBackgroundColor(pictureItem[idx].backgroundColor)
      .setSrcType(pictureItem[idx].srcType)
      .setIsSvg(pictureItem[idx].isSvg)
      .setTypeValue(this.typeValue)
      .setUiWidth(pictureItem[idx].uiWidth)
      .setUiHeight(pictureItem[idx].uiHeight)
      .setScaleType(pictureItem[idx].scaleType)
      .setTileModeXY(pictureItem[idx].tileMode)
      .setCornerRadius(pictureItem[idx].cornerRadius)
      .setBorderWidth(pictureItem[idx].borderWidth)
      .setBorderColor(pictureItem[idx].borderColor)
      .setPadding(pictureItem[idx].padding)
      .setColorWidth(this.uiHeight)
      .setColorHeight(this.uiHeight)
  });
}
```

#### 界面绘制

界面顶部为类型选择内容，并监听 type_value 内容的变化，以重新构建 Model，通知给 Model 类，Scroll 中使用 list 布局放置图片。

```typescript
build() {
  Column() {
    Column() {
      Image($r('app.media.down')).width(30).height(30).position({ x: -30, y: 5 }).onClick(() => {
        this.dialogController.open()
      })
      Text(' select:' + this.typeValue).fontSize(30)
    }.margin(15)

    Scroll(this.scroller) {
      List({ space: 10, initialIndex: 0 }) {
        if (this.typeValue == 'Bitmap') {
          ForEach(this.picIdxArr, (item) => {
            ListItem() {
              this.viewItem(this.viewModels[item], this.rectPictureItems[item])
            }.editable(false)
          }, item => item)
        }
        ...
      }
    }
    .scrollable(ScrollDirection.Vertical).scrollBar(BarState.Off)
  }
  .width('100%')
  .height('100%')
  .backgroundColor(0xDCDCDC)
  .padding({ top: 20, bottom: 100 })
}
```

#### 更多详细用法请参考开源库 sample 页面的实现

### 接口说明

```typescript
let data: RoundedImageName.Model = new RoundedImageName.Model();
```

1. 设置图片路径 `data.setImageSrc(src: string | Resource | ArrayBuffer)`
2. 设置图片类型 `data.setSrcType(srcType: SrcType)`
3. 设置图片缩放类型 `data.setScaleType(scaleType: ScaleType)`
4. 设置图片的重复样式 `data.setTileModeXY(value: TileMode)`
5. 设置角半径 `data.setCornerRadius(cornerRadius: number)`
6. 设置图片显示的宽度 `data.setUiWidth(width: number)`
7. 设置图片显示的高度 `data.setUiHeight(height: number)`
8. 设置边框线宽 `data.setBorderWidth(borderWidth: number)`
9. 设置背景颜色 `data.setBackgroundColor(value: string | CanvasGradient | CanvasPattern)`
10. 设置当前场景上下文 `context` `data.setContext(context: common.UIAbilityContext)`

### 关于混淆

如果希望 roundedimageview 库在代码混淆过程中不会被混淆，需要在混淆规则配置文件 `obfuscation-rules.txt` 中添加相应的排除规则：

```text
-keep
./oh_modules/@ohos/roundedimageview
```

### 约束与限制

在下述版本验证通过：
DevEco Studio: NEXT Beta1-5.0.3.806, SDK:API12 Release(5.0.0.66)

**HSP 场景适配：**
RoundedImageView.Model 配置类新增 `setContext(context:common.UIAbilityContext)` 接口，在 HSP 场景下需要传入正确的 context，才能保证三方库后续正确获取 Resource 资源。非 HSP 场景不影响原功能，context 可以不传。

### 目录结构

```text
|---- RoundedImageView
|     |---- entry                       # 示例代码文件夹
|     |---- library            # RoundedImageView 库文件夹
|           |---- src     
|                   |---- main 
|                           |---- ets 
|                                   |---- components
|                                             |---- DownloadUtils.ts  # 图片下载工具类
|                                             |---- FileUtils.ts  # 文件操作工具类
|                                             |---- PixelMapUtils.ts  # PixelMap 工具类
|                                             |---- RoundedImageView.ets  # 库的核心实现
|                                             |---- ScaleType.ts  # ScaleType 枚举
|                                             |---- SrcType.ts  # SrcType 枚举
|                                             |---- TileMode.ts  # TileMode 枚举
|                                             |---- GlobalContext.ts  # GlobalContext 替代 globalThis
|     |---- README.md                   # 安装使用方法  
|     |---- README_zh.md                   # 安装使用方法  
```

### 更新记录

#### 2.1.2

Release version 2.1.2

#### 2.1.2-rc.0

Fix Cannot read property getImageInfo of undefined

#### 2.1.1

Replace the deprecated interface

#### 2.1.0

适配 V2 装饰器

#### 2.0.2

发布 2.0.2 正式版本

#### 2.0.2-rc.0

RoundedImageView.Model 类
1. 新增 `setContext(context:common.UIAbilityContext)` 接口，在 hsp 场景下需要传入正确的 context 才能保证后续获取资源代码正常运行，对于非 HSP 场景无影响可以不传。
2. 新增 `getContext()` 接口，多用于自定义组件内部，开发者也可以用该方法判断当前 context 是否传入。

项目名称和核心模块名称相同，三方库核心模块更名为 library

hsp 的默认 library 依赖更名为 sharedlibrary

#### 2.0.1

ArkTs 语法适配
接口使用方式变更：GlobalContext 替代 globalThis

#### 2.0.0

适配 DevEco Studio 版本：DevEco Studio 版本：4.0 Canary1(4.0.0.112), SDK: API10 (4.0.7.3)
包管理工具由 npm 切换成 ohpm

#### 1.0.4

DevEco Studio 版本：3.1 Beta1（3.1.0.200），OpenHarmony SDK:API9（3.2.10.6）。

#### 1.0.3

实现功能
1. 修改 svg 模块依赖方式

#### 1.0.2

实现功能（整体使用 canvas 绘制）

- 支持图片显示为圆角矩形并带边框
- 支持图片显示为椭圆并带边框
- 支持 Color 类型显示并带边框
- 支持 Background 类型显示并带边框
- 支持 svg 图片显示并带边框
- 支持设置 ScaleType 七种缩放类型
- 支持设置 TileMode 三种背景平铺类型
- 支持路径 uri、media、本地 rawfile、网络 url 等相关数据绘制

遗留问题
裁剪 destination-in 在 3.2 上不生效，导致图片裁剪出问题，属系统 bug

#### 1.0.1

实现功能
1. api8 升级到 api9

#### 1.0.0

实现功能

- 图片圆角设置
- 图片椭圆
- 用于重复绘制的 TileModes
- 透明背景

遗留问题

- 除开 oval 的模式，其他的模式都不支持圆角添加边框的能力（目前只能支持组件添加边框，内容图像裁剪）
- oval 模式使用了 canvas 做，目前还没有做 scaleType（图像和目标组件的显示适配和 objectFit 能力差不多）类型适配

### 权限与隐私基本信息

| 项目 | 内容 |
| :--- | :--- |
| **权限名称** | 暂无 |
| **权限说明** | 暂无 |
| **使用目的** | 暂无 |
| **隐私政策** | 不涉及 |
| **SDK 合规使用指南** | 不涉及 |
| **兼容性** | HarmonyOS 版本 5.0.0 |
| **应用类型** | 应用 |
| **元服务** | - |
| **设备类型** | 手机、平板、PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @ohos/roundedimageview
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/7479c326242d48a5814744893e1d040b/PLATFORM?origin=template