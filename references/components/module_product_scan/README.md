# 商品识别组件

## 简介

本组件支持扫描商品条码/二维码，拍摄商品图片并获取返回结果。

## 详细介绍

### 功能简介

本组件支持扫描商品条码/二维码，拍摄商品图片并获取返回结果。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.1 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.1 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.1(13) 及以上

#### 权限

- **相机权限**：`ohos.permission.CAMERA`

### 使用

#### 安装组件

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `module_ui_base` 和 `module_product_scan` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_ui_base 和 module_product_scan 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_ui_base",
    "srcPath": "./XXX/module_ui_base"
  },
  {
    "name": "module_product_scan",
    "srcPath": "./XXX/module_product_scan"
  }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// 在项目根目录 oh-package.json5 中添加依赖
"dependencies": {
  "module_product_scan": "file:./XXX/module_product_scan"
}
```

#### 使用组件

使用组件，详见示例代码。

## API 参考

### CustomScanOptions 对象说明

使用 Navigation 路由跳转商品识别页面时，作为 param 参数传入。

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| enableMultiMode | boolean | 否 | 是否支持多码识别，默认为 true |
| enableAlbum | boolean | 否 | 是否支持相册选择，默认为 true |
| handleScanResult(code: string) => void | function | 否 | 处理扫码结果的回调 |
| handlePhotoResult(image: image.PixelMap \| Resource \| string) => void | function | 否 | 处理拍照结果的回调 |

## 示例代码

```typescript
import { CustomScanOptions, ScanRouterMap } from 'module_product_scan';

@Builder
export function buildScanPage() {
  CustomScanPage()
}

@Entry
@ComponentV2
struct CustomScanPage {
  @Local stack: NavPathStack = new NavPathStack()
  @Local isStr: boolean = true
  @Local msg: string = ''
  @Local image: PixelMap | string | undefined

  toast(message: string) {
    try {
      this.getUIContext().getPromptAction().showToast({ message })
    } catch (err) {
      console.log(JSON.stringify(err))
    }
  }

  build() {
    Navigation(this.stack) {
      Column({ space: 16 }) {
        Button('进入扫码')
          .onClick(() => {
            this.stack.pushPath({
              name: ScanRouterMap.CUSTOM_SCAN_PAGE,
              param: {
                enableMultiMode: true,
                enableAlbum: true,
                handleScanResult: (url: string) => {
                  this.isStr = true
                  this.msg = '识别到商品条码：' + url;
                  this.stack.pop()
                },
                handlePhotoResult: (uri: string | PixelMap) => {
                  this.isStr = false;
                  this.image = uri
                  this.stack.pop()
                },
              } as CustomScanOptions,
            });
          })

        Text('识别信息：')
        if (this.isStr) {
          Text(this.msg)
        } else {
          Image(this.image).width(200)
        }
      }
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
  }
}
```

## 更新记录

### 1.0.1 (2026-01-13)

- 下载该版本

### 1.0.0 (2025-11-24)

- 废弃 API 整改
- 下载该版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.CAMERA | 允许应用使用相机 | 允许应用使用相机 |

### 合规使用指南

- 隐私政策：不涉及
- SDK 合规使用指南：不涉及

## 兼容性

### HarmonyOS 版本

| 版本 | 支持状态 |
| :--- | :--- |
| 5.0.1 | 支持 |
| 5.0.2 | 支持 |
| 5.0.3 | 支持 |
| 5.0.4 | 支持 |
| 5.0.5 | 支持 |
| 5.1.0 | 支持 |
| 5.1.1 | 支持 |
| 6.0.0 | 支持 |
| 6.0.1 | 支持 |

### 应用类型

| 类型 | 支持状态 |
| :--- | :--- |
| 应用 | 支持 |
| 元服务 | 支持 |

### 设备类型

| 类型 | 支持状态 |
| :--- | :--- |
| 手机 | 支持 |
| 平板 | 支持 |
| PC | 支持 |

### DevEco Studio 版本

| 版本 | 支持状态 |
| :--- | :--- |
| DevEco Studio 5.0.1 | 支持 |
| DevEco Studio 5.0.2 | 支持 |
| DevEco Studio 5.0.3 | 支持 |
| DevEco Studio 5.0.4 | 支持 |
| DevEco Studio 5.0.5 | 支持 |
| DevEco Studio 5.1.0 | 支持 |
| DevEco Studio 5.1.1 | 支持 |
| DevEco Studio 6.0.0 | 支持 |
| DevEco Studio 6.0.1 | 支持 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/f03e43da17644aba93328bb535e75b7e/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%95%86%E5%93%81%E8%AF%86%E5%88%AB%E7%BB%84%E4%BB%B6/module_product_scan1.0.1.zip