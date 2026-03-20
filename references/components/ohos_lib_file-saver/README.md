# ohos_lib/file-saver 图片保存组件

## 简介

此开源库为基于 HarmonyOS ArkTS 的应用提供便捷功能，支持将图片一键保存至系统相册和应用内部存储。

## 详细介绍

### 功能概述

FileSaver 此开源库为基于 HarmonyOS ArkTS 的应用提供便捷功能：

1. 支持将图片一键保存至系统相册和应用内部存储
2. 支持保存文件各种形式至应用沙盒
3. 支持压缩图片到指定大小以下 - 用于微信分享等

### 安装

```bash
ohpm install @ohos_lib/file-saver
```

### 权限配置

添加权限 `entry->module.json5`：

```json5
{
  "requestPermissions": [
    {
      "name": "ohos.permission.INTERNET"
    },
    {
      "name": "ohos.permission.GET_NETWORK_INFO"
    }
  ]
}
```

### FileSaverHelper 类

#### Api 方法描述

| 方法名 | 描述 |
| :--- | :--- |
| `downloadFile` | 下载图片等文件统一方法封装，有进度回调监听 |
| `saveNetImageToGallery` | 保存网络图片到系统相册 |
| `saveImgBufferToGallery` | 保存图片二进制 ArrayBuffer 到系统相册 |
| `savePixelMapToGallery` | 保存 PixelMap 图片形式到系统相册 |
| `saveImgBase64ToGallery` | 保存 Base64 图片形式到系统相册 |
| `saveSandBoxImageToGallery` | 保存图片的沙箱路径到系统相册 |
| `saveLocalRawImageToGallery` | 保存本地 resource/rawFile 中的图片资源到系统相册 |
| `saveLocalResImageToGallery` | 保存本地 resource/Media 中的图片资源到系统相册 |
| `transferImage2PixelMap` | 拉起图片选择器选择或拍照后的图片 uri 路径 - 转化为 PixelMap |
| `base64ToPixelMap` | 图片 base64 字符串转 PixelMap |
| `packingPixelMapToArrayBuffer` | 图片 PixelMap 转化 ArrayBuffer（传入 quality 可压缩） |
| `downloadFileToSandBox` | 下载网络资源 (图片等文件) 保存应用沙盒 |
| `savePixelMapToSandBox` | 保存 PixelMap 到应用沙盒 |
| `saveArrayBufferToSandBox` | 保存 ArrayBuffer 到应用沙盒 |
| `saveRawFileToSandBox` | 将资源文件夹 Resource/rawFile 下的文件存放到沙箱目录下 |
| `saveMediaFileToSandBox` | 将资源文件夹 Resource/Media 下的文件存放到沙箱目录下 |
| `fileToArrayBuffer` | 沙箱文件转 ArrayBuffer |
| `readLocalFileWithStream` | 沙箱文件转 ArrayBuffer(文件较大时使用更好) |

### CompressorUtil 类

采用华为官方二分法质量压缩。

#### Api 方法描述

**async compressedImage(sourcePixelMap: image.PixelMap, maxCompressedImageSize: number): Promise**

- `sourcePixelMap`：原始待压缩图片的 PixelMap 对象
- `maxCompressedImageSize`：指定图片的压缩目标大小，单位 kb
- `compressedImageInfo`：返回最终压缩后的图片信息

### 基本用法

```typescript
import { CompressorUtil, FileSaverHelper } from '@ohos_lib/file-saver'
import { componentSnapshot, promptAction } from '@kit.ArkUI'
import { image } from '@kit.ImageKit'
import { getBase64 } from '../utils/base64'
import { getArrayBuffer } from '../utils/arraybuffer'
import { BusinessError } from '@kit.BasicServicesKit'

@Entry
@ComponentV2
struct Index {
    @Local netUrl: string = 'https://i.gsxcdn.com/3053295419_6crg62os.png'
    
    build() {
        Column() {
            Scroll() {
                Column() {
                    Button('保存网络图片到系统相册').onClick(() => {
                        FileSaverHelper.getInstance(getContext()).saveNetImageToGallery(this.netUrl, (progress: number) => {
                            console.log('下载进度....' + progress)
                        }, (error) => {
                            console.log('异常信息', error.message, error.code);
                        }).then((isSuccess) => {
                            if (isSuccess) {
                                promptAction.showToast({
                                    message: '保存成功'
                                })
                            }
                        })
                    }).id('SnapshotId')

                    Button('下载图片等文件保存至应用沙盒').onClick(() => {
                        FileSaverHelper.getInstance(getContext()).downloadFileToSandBox(this.netUrl, (progress: number) => {
                            console.log('下载进度....' + progress)
                        }).then(result => {
                            if (result.success) {
                                // 本地保存的沙盒文件路径
                                const filePath = result.filePath;
                                promptAction.showToast({
                                    message: '保存成功' + filePath
                                })
                            }
                        })
                    }).margin({
                        top: 20
                    })
                    
                    Button('保存图片 PixelMap 到系统相册').onClick(() => {
                        componentSnapshot.get("SnapshotId", async (error: Error, pixmap: image.PixelMap) => {
                            if (error) {
                                console.log("error: " + JSON.stringify(error))
                                return;
                            }
                            FileSaverHelper.getInstance(getContext()).savePixelMapToGallery(pixmap, 85, () => {
                                promptAction.showToast({
                                    message: '保存成功'
                                })
                            }, (error) => {

                            })
                        }, { scale: 2, waitUntilRenderFinished: true })
                    }).margin({
                        top: 20
                    })
                    
                    Button('保存 ArrayBuffer 到系统相册').onClick(() => {
                        getArrayBuffer(this.netUrl, (buffer) => {
                            FileSaverHelper.getInstance(getContext()).saveImgBufferToGallery(buffer, (isSuccess) => {
                                promptAction.showToast({
                                    message: '保存成功'
                                })
                            })
                        })
                    }).margin({
                        top: 20
                    })
                    
                    Button('保存图片 base64 到系统相册').onClick(() => {
                        const base64Str = getBase64();
                        FileSaverHelper.getInstance(getContext()).saveImgBase64ToGallery(base64Str, () => {
                            promptAction.showToast({
                                message: '保存成功'
                            })
                        }, () => {

                        })
                    }).margin({
                        top: 20
                    })
                    
                    Button('保存应用沙箱图片到系统相册').onClick(() => {
                        // 确保沙箱有真实路径图片
                        const filePath = getContext().filesDir + `/1752459448284_IMG.jpg`;
                        FileSaverHelper.getInstance(getContext()).saveSandBoxImageToGallery(filePath, () => {
                            promptAction.showToast({
                                message: '保存成功'
                            })
                        }, (err) => {
                            console.log('异常信息----', err.message);
                        })
                    }).margin({
                        top: 20
                    })
                    
                    Button('保存本地 Resource/RawFile 中的图片到系统相册').onClick(() => {
                        FileSaverHelper.getInstance(getContext()).saveLocalRawImageToGallery('raw.png', () => {
                            promptAction.showToast({
                                message: '保存成功'
                            })
                        }, (err) => {
                            console.log('异常信息----', err.message);
                        })
                    }).margin({
                        top: 20
                    })
                    
                    Button('保存本地 Resource/Media 中的图片到系统相册').onClick(() => {
                        FileSaverHelper.getInstance(getContext()).saveLocalRawImageToGallery('startIcon.png', () => {
                            promptAction.showToast({
                                message: '保存成功'
                            })
                        }, (err) => {
                            console.log('异常信息----', err.message);
                        })
                    }).margin({
                        top: 20
                    })
                    
                    Button('保存本地 Resource/RawFile 中的文件到应用沙盒').onClick(() => {
                        FileSaverHelper.getInstance(getContext()).saveRawFileToSandBox('raw.png').then(result => {
                            if (result.success) {
                                // 本地保存的沙盒文件路径
                                const filePath = result.filePath;
                                promptAction.showToast({
                                    message: '保存成功' + filePath
                                })
                            }
                        }).catch((err: BusinessError) => {
                            console.log('异常----', err.message)
                        })
                    }).margin({
                        top: 20
                    })

                    Button('保存本地 Resource/Media 中的文件到应用沙盒').onClick(() => {
                        FileSaverHelper.getInstance(getContext()).saveRawFileToSandBox('startIcon.png').then(result => {
                            if (result.success) {
                                // 本地保存的沙盒文件路径
                                const filePath = result.filePath;
                                promptAction.showToast({
                                    message: '保存成功' + filePath
                                })
                            }
                        })
                    }).margin({
                        top: 20
                    })

                    Button('保存 PixelMap 到应用沙盒').onClick(() => {
                        componentSnapshot.get("SnapshotId", async (error: Error, pixmap: image.PixelMap) => {
                            if (error) {
                                console.log("error: " + JSON.stringify(error))
                                return;
                            }
                            FileSaverHelper.getInstance(getContext()).savePixelMapToSandBox(pixmap, 85, (result) => {
                                if (result.success) {
                                    // 本地保存的沙盒文件路径
                                    const filePath = result.filePath;
                                    promptAction.showToast({
                                        message: '保存成功' + filePath
                                    })
                                }
                            }, (error) => {

                            })
                        }, { scale: 2, waitUntilRenderFinished: true })
                    }).margin({
                        top: 20
                    })
                    
                    Button('沙箱文件转 ArrayBuffer').onClick(() => {
                        // 确保沙箱路径真实有效
                        const filePath = getContext().filesDir + `/1752460544695_IMG.jpg`;
                        // 文件较大时建议使用 FileSaverHelper.getInstance(getContext()).readLocalFileWithStream(filePath)
                        FileSaverHelper.getInstance(getContext()).fileToArrayBuffer(filePath).then(buffer => {
                            promptAction.showToast({
                                message: '转换成功' + buffer.byteLength
                            })
                        }).catch((err: BusinessError) => {
                            console.log('异常信息', err.code, err.message)
                        })
                    }).margin({
                        top: 20
                    })
                    
                    Button('保存 ArrayBuffer 到应用沙盒').onClick(() => {
                        getArrayBuffer(this.netUrl, (buffer) => {
                            FileSaverHelper.getInstance(getContext()).saveArrayBufferToSandBox(buffer).then(result => {
                                if (result.success) {
                                    // 本地保存的沙盒文件路径
                                    const filePath = result.filePath;
                                    promptAction.showToast({
                                        message: '保存成功' + filePath
                                    })
                                }
                            })
                        })
                    }).margin({
                        top: 20
                    })

                    Button('压缩图片到指定大小 - 返回 ArrayBuffer').onClick(() => {
                        componentSnapshot.get("SnapshotId", async (error: Error, pixmap: image.PixelMap) => {
                            if (error) {
                                console.log("error: " + JSON.stringify(error))
                                return;
                            }
                            CompressorUtil.compressedImage(pixmap, 64).then(res => {
                                // 压缩后的图片存储位置及字节
                                const imageUri = res.imageUri;
                                const imageBuffer = res.imageBuffer;
                                const byteLength = res.imageByteLength;
                                promptAction.showToast({
                                    message: '压缩成功' + imageUri
                                })
                            })
                        }, { scale: 2, waitUntilRenderFinished: true })
                    }).margin({
                        top: 20
                    })
                }
            }
        }
        .height('100%')
        .width('100%')
    }
}
```

### 更新记录

- **1.0.0（API12）**
  1. 支持将图片一键保存至系统相册和应用内部存储
  2. 支持保存文件各种形式至应用沙盒
- **1.0.11（API12）**
  1. 支持压缩图片到指定大小以下 - 用于微信分享等
- **1.0.12（API12）**
  1. 优化代码
- **1.0.14（API12）**
  1. 添加下载文件统一 DownloadFile 方法
  2. 添加下载文件进度监听回调
- **1.0.17（API12）**
  1. 修复下载进度监听 BUG
- **1.1.0**
  1. 以源码形式进行发布，方便开发者查看使用

### 权限与隐私基本信息

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| 项目 | 内容 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | - |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @ohos_lib/file-saver
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/29aba962827449978cd2ae3be1ef095a/PLATFORM?origin=template