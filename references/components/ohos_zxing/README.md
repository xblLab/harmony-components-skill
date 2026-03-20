# zxing 一二维码解析生成组件

## 简介

Zxing 是一款解析和生成一维码、二维码的三方组件，用于声明式应用开发，支持多种一维码、二维码的解析与生成功能。

## 详细介绍

### 简介

zxing 是一个解析/生成一维码/二维码的库。

### 支持的码格式

其中 `QR_CODE`、`DATA_MATRIX`、`AZTEC`、`PDF_417`、`MAXICODE` 生成和解码时传入的宽高不支持小数。

- **1D Product**: UPC-A, UPC-E, EAN-8, EAN-13, RSS-14, RSS-Expanded
- **1D Industrial**: Code 39, Code 93, Code 128, Codabar, ITF
- **2D**: QR Code, Data Matrix, Aztec, PDF 417, MaxiCode

### 下载安装

```bash
ohpm install @ohos/zxing
```

### 使用说明

#### 解码

```typescript
import {MultiFormatReader, BarcodeFormat, DecodeHintType, RGBLuminanceSource, BinaryBitmap, HybridBinarizer} from "@ohos/zxing";

const hints = new Map();
const formats = [BarcodeFormat.QR_CODE];
hints.set(DecodeHintType.POSSIBLE_FORMATS, formats);
const reader = new MultiFormatReader();
reader.setHints(hints);
const luminanceSource = new RGBLuminanceSource(luminances, width, height);
const binaryBitmap = new BinaryBitmap(new HybridBinarizer(luminanceSource));
let result = reader.decode(binaryBitmap);
let text = result.getText();
```

#### 编码

```typescript
import {BarcodeFormat, MultiFormatWriter, BitMatrix, ZXingStringEncoding, EncodeHintType} from '@ohos/zxing';

const encodeHintTypeMap = new Map();
//设置二维码边空白的宽度
encodeHintTypeMap.set(EncodeHintType.MARGIN, 0);
const writer: MultiFormatWriter = new MultiFormatWriter();
let matrix: BitMatrix = writer.encode(content, BarcodeFormat.QR_CODE, width, height, encodeHintTypeMap);
```

OpenHarmony 上是用 `image` 组件显示图片的，所以需要将 `matrix` 转化成 `pixelMap` 这样才可以显示在 `image` 组件上面。

1. 需要将 `matrix` 转成 `pixelMap` 的 buffer。
2. 再根据这个 buffer 去创建 `pixelMap`。
3. 输入的解析生成码的一些限制：
   - `codabar` 只能是数字
   - `ena8` 只能是 7 位数字
   - `ena13` 只能是 12 位数字
   - `ITF` 码只能是数字，且需要双数，长度要>=6 才能解析生成码
   - `upcA` 只能数字，且长度只能是 11 位
   - `upcE` 只能数字，且长度只能是 7 位

具体操作细节可以看 demo 代码，主要转换逻辑都封装在 `imageUtils` 工具类中。

### 接口列表

#### 编码

| 类名 | 方法名 | 功能 |
| :--- | :--- | :--- |
| QRCodeWriter | `encode(contents: string, format: BarcodeFormat, width: int, height: int, hints: Map<EncodeHintType, any>): BitMatrix` | 生成 QRCode 码 |
| DataMatrixWriter | `encode(contents: string, format: BarcodeFormat, width: int, height: int, hints: Map<EncodeHintType, any>): BitMatrix` | 生成 DataMatrix 码 |
| AztecWriter | `encode(contents: string, format: BarcodeFormat, width: int, height: int, hints: Map<EncodeHintType, any>): BitMatrix` | 生成 Aztec 码 |
| PDF417Writer | `encode(contents: string, format: BarcodeFormat, width: int, height: int, hints: Map<EncodeHintType, any>): BitMatrix` | 生成 PDF417 码 |
| Code39Writer | `encode(contents: string, format: BarcodeFormat, width: int, height: int, hints: Map<EncodeHintType, any>): BitMatrix` | 生成 Code39 码 |
| Code93Writer | `encode(contents: string, format: BarcodeFormat, width: int, height: int, hints: Map<EncodeHintType, any>): BitMatrix` | 生成 Code93 码 |
| Code128Writer | `encode(contents: string, format: BarcodeFormat, width: int, height: int, hints: Map<EncodeHintType, any>): BitMatrix` | 生成 Code128 码 |
| CodaBarWriter | `encode(contents: string, format: BarcodeFormat, width: int, height: int, hints: Map<EncodeHintType, any>): BitMatrix` | 生成 CodaBar 码 |
| ITFWriter | `encode(contents: string, format: BarcodeFormat, width: int, height: int, hints: Map<EncodeHintType, any>): BitMatrix` | 生成 ITF 码 |
| UPCAWriter | `encode(contents: string, format: BarcodeFormat, width: int, height: int, hints: Map<EncodeHintType, any>): BitMatrix` | 生成 UPCA 码 |
| UPCEWriter | `encode(contents: string, format: BarcodeFormat, width: int, height: int, hints: Map<EncodeHintType, any>): BitMatrix` | 生成 UPCE 码 |
| EAN8Writer | `encode(contents: string, format: BarcodeFormat, width: int, height: int, hints: Map<EncodeHintType, any>): BitMatrix` | 生成 EAN8 码 |
| EAN13Writer | `encode(contents: string, format: BarcodeFormat, width: int, height: int, hints: Map<EncodeHintType, any>): BitMatrix` | 生成 EAN13 码 |
| MultiFormatWriter | `encode(contents: string, format: BarcodeFormat, width: int, height: int, hints: Map<EncodeHintType, any>): BitMatrix` | 这是一个工厂类方法，它为请求的条形码/二维码格式找到适当的编写器子类，并使用提供的内容编码二维码/条形码 |

#### 解码

| 类名 | 方法名 | 功能 |
| :--- | :--- | :--- |
| QRCodeReader | `decode(image: BinaryBitmap, hints?: Map<DecodeHintType, any> | null): Result` | 解析 QRCode 码 |
| DataMatrixReader | `decode(image: BinaryBitmap, hints?: Map<DecodeHintType, any> | null): Result` | 解析 DataMatrix 码 |
| AztecReader | `decode(image: BinaryBitmap, hints?: Map<DecodeHintType, any> | null): Result` | 解析 Aztec 码 |
| PDF417Reader | `decode(image: BinaryBitmap, hints?: Map<DecodeHintType, any> | null): Result` | 解析 PDF417 码 |
| MaxiCodeReader | `decode(image: BinaryBitmap, hints?: Map<DecodeHintType, any> | null): Result` | 解析 MaxiCode 码 |
| Code39Reader | `decode(image: BinaryBitmap, hints?: Map<DecodeHintType, any> | null): Result` | 解析 Code39 码 |
| Code93Reader | `decode(image: BinaryBitmap, hints?: Map<DecodeHintType, any> | null): Result` | 解析 Code93 码 |
| CodaBarReader | `decode(image: BinaryBitmap, hints?: Map<DecodeHintType, any> | null): Result` | 解析 CodaBar 码 |
| Code128Reader | `decode(image: BinaryBitmap, hints?: Map<DecodeHintType, any> | null): Result` | 解析 Code128 码 |
| ITFReader | `decode(image: BinaryBitmap, hints?: Map<DecodeHintType, any> | null): Result` | 解析 ITF 码 |
| UPCAReader | `decode(image: BinaryBitmap, hints?: Map<DecodeHintType, any> | null): Result` | 解析 UPCA 码 |
| UPCEReader | `decode(image: BinaryBitmap, hints?: Map<DecodeHintType, any> | null): Result` | 解析 UPCE 码 |
| EAN8Reader | `decode(image: BinaryBitmap, hints?: Map<DecodeHintType, any> | null): Result` | 解析 EAN8 码 |
| EAN13Reader | `decode(image: BinaryBitmap, hints?: Map<DecodeHintType, any> | null): Result` | 解析 EAN13 码 |
| RSS14Reader | `decode(image: BinaryBitmap, hints?: Map<DecodeHintType, any> | null): Result` | 解析 RSS14 码 |
| RSSExpandedReader | `decode(image: BinaryBitmap, hints?: Map<DecodeHintType, any> | null): Result` | 解析 RSSExpanded 码 |
| MultiFormatReader | `decode(image: BinaryBitmap, hints?: Map<DecodeHintType, any> | null): Result` | 这是一个工厂类方法，它为请求的条形码/二维码格式找到适当的解码器子类，并使用提供的内容解码二维码/条形码 |

### 相机组件

| 组件名 |
| :--- |
| CameraView |
| CameraService |

| 类名 | 方法名 | 功能 |
| :--- | :--- | :--- |
| init | `CameraService.getInstance().init(getContext())` | 打开相机并初始化 |
| destroy | `CameraService.getInstance().destroy()` | 关闭相机 |
| release | `CameraService.getInstance().release()` | 释放 |

### GlobalContext

| 类名 | 方法名 | 功能 |
| :--- | :--- | :--- |
| setObject | `GlobalContext.getContext().setObject("key", value)` | 设置值 |
| getObject | `GlobalContext.getContext().getObject("key")` | 获取值 |

### 关于混淆

代码混淆，请查看代码混淆简介。如果希望 zxing 库在代码混淆过程中不会被混淆，需要在混淆规则配置文件 `obfuscation-rules.txt` 中添加相应的排除规则：

```
-keep
./oh_modules/@ohos/zxing
```

### 约束与限制

在下述版本验证通过：

- DevEco Studio: 5.0 (5.0.3.122), SDK: API12 (5.0.0.17)
- DevEco Studio: 4.1 Canary (4.1.3.322), SDK: API11 (4.1.0.36)
- DevEco Studio: 4.1 Canary (4.1.3.220), SDK: API11 (4.1.2.1)
- DevEco Studio: 4.0 Beta2 (4.0.3.500), SDK: API10 (4.0.10.7)
- DevEco Studio: 4.0 Canary2 (4.0.3.317), SDK: API10 (4.0.9.5)
- DevEco Studio: 3.1 Beta2 (3.1.0.400), SDK: API9 Release (3.2.11.9)

### 项目目录

```text
|---- Zxing  
|     |---- entry  # 示例代码文件夹
|     |---- library  # zxing 库文件夹
|           |---- index.ets  # 对外接口
|     |---- README.md  # 安装使用方法    
|     |---- README_zh.md  # 安装使用方法                
```

### 贡献代码

使用过程中发现任何问题都可以提 Issue 给组件，当然，也非常欢迎发 PR 共建。

### 开源协议

本项目基于 Apache License 2.0，请自由的享受和参与开源。

### 更新记录

#### Version 2.1.2

Fixing the issue where ISO-8859-1 is not supported in string encoding format modification.

#### Version 2.1.1

Release the official version 2.1.1

#### Version 2.1.0

适配 ComponentV2 装饰器

#### Version 2.0.4

发布 2.0.4 正式版本

#### Version 2.0.4-rc.2

媒体图片的废弃接口 mediaLibrary 替换为 photoAccessHelper 获取图片资源
通过 Picker 方式打开图片相册

#### Version 2.0.4-rc.1

修复重复进入退出扫一扫内存泄漏
修复条形码两边留白过多

#### Version 2.0.4-rc.0

修复扫一扫相机绿屏

#### Version 2.0.3

正式版本

#### Version 2.0.3-rc.1

1. 增加扫一扫和相册图片扫描

#### Version 2.0.3-rc.0

1. 修复 round 接口内的无效判断

#### Version 2.0.2

1. 适配 ArkTs 语法
2. 适配 DevEco Studio: 4.0 Beta2 (4.0.3.500), SDK: API10 (4.0.10.7)

#### Version 2.0.1

1. 适配 DevEco Studio: 4.0 Canary2 (4.0.3.317), SDK: API10 (4.0.9.5)
2. 修正 CodaBar 码可以解析内容只有一个字符能力
3. 修正 HighLevelEncoder 类里静态对象的使用方式

#### Version 2.0.0

1. 适配 DevEco Studio: 3.1 Beta2 (3.1.0.400), SDK: API9 Release (3.2.11.9)
2. 包管理工具由 npm 切换成 ohpm

#### Version 1.0.8

1. 添加关键字。

#### Version 1.0.7

1. 适配 DevEco Studio 3.1 Beta1 版本。

#### Version 1.0.6

1. 适配 STAGE,FA 模型。

#### Version 1.0.5

1. 删除 module 里多余的 MainPage.ets 页面。

#### Version 1.0.3

1. 适配 api9。

#### Version 1.0.2

1. 由 gradle 工程整改为 hvigor 工程。

#### Version 1.0.1

1. 适配 ark 引擎。

#### Version 1.0.0

1. 支持 Code 39、Code 93、Code 128、Codabar 码生成功能。
2. 支持 ITF、UPC-E、UPC-A、EAN-8、EAN-13 码生成功能。
3. 支持 MaxiCode、Code 39、Codabar 码解析功能。
4. 支持 RSS-14、RSS-Expanded、QR Code、Data Matrix、Aztec、PDF 417 码格式功能。

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 | 暂无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

### 兼容性

| HarmonyOS 版本 | 5.0.0 |
| :--- | :--- |
| 应用类型 | 应用 |
| 元服务 | 是 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 |

## 安装方式

```bash
ohpm install @ohos/zxing
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/922ffa0e23f94cc5aa6f8fc365ceec77/PLATFORM?origin=template