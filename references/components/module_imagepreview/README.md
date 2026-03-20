# 图片预览组件

## 简介

本组件提供了图片预览的功能，包括滑动预览、双指放大缩小图片。

## 详细介绍

### 约束与限制

#### 环境

- DevEco Studio版本：DevEco Studio 5.0.3 Release及以上
- HarmonyOS SDK版本：HarmonyOS 5.0.3 Release SDK及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 5.0.1(13)及以上

#### 权限

- 网络权限：ohos.permission.INTERNET

### 快速入门

#### 安装组件

> 如果是在DevEco Studio使用插件集成组件，则无需安装组件，请忽略此步骤。
> 如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的XXX目录下。

b. 在项目根目录build-profile.json5添加module_imagepreview模块。

```json5
// 项目根目录下build-profile.json5填写module_imagepreview路径。其中XXX为组件存放的目录名
"modules": [
  {
    "name": "module_imagepreview",
    "srcPath": "./XXX/module_imagepreview"
  }
]
```

c. 在项目根目录oh-package.json5添加依赖。

```json5
// XXX为组件存放的目录名称
"dependencies": {
  "module_imagepreview": "file:./XXX/module_imagepreview"
}
```

#### 引入组件

```typescript
import { ImagePreview } from 'module_imagepreview';
```

### API参考

#### 子组件

无

#### 接口

**ImagePreview(option: ImagePreviewOption)**

图片预览组件的参数。

参数：

| 参数名 | 类型 | 是否必填 | 说明 |
|--------|------|----------|------|
| options | ImagePreviewOption | 否 | 图片预览的参数。 |

**ImagePreviewOption对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
|------|------|----------|------|
| isBasicMode | boolean | 否 | 是否简单模式，不展示评论、点赞、分享、关注等功能 |
| maskColor | ResourceStr | 否 | 遮罩背景色 |
| startIndex | number | 否 | 指定初始显示的图片索引 |
| swipeDuration | number | 否 | 动画时长 |
| showIndex | boolean | 否 | 是否显示页码 |
| indexFontColor | number \| string | 否 | 页码字体颜色 |
| indexFontSize | ResourceStr | 否 | 页码字体大小 |
| loop | boolean | 否 | 是否循环 |
| doubleScale | boolean | 否 | 节日、节气展示颜色，默认值Color.Red |
| closeOnClickOverlay | boolean | 否 | 是否启用双击缩放手势，禁用后，点击时会立即关闭图片预览 |
| closeOnClickImage | boolean | 否 | 是否在点击遮罩层后关闭图片预览 |
| maxScale | number | 否 | 最大缩放比例 |
| minScale | number | 否 | 最小缩放比例 |
| author | () => void = () => { } | 否 | 顶部操作栏 |
| operation | () => void = () => { } | 否 | 底部操作栏 |
| onClose | () => void = () => { } | 否 | 关闭操作栏 |

#### 事件

支持以下事件：

**onImgClick**

```typescript
onImgClick?: (index: number) => void
```

图片点击事件

**onImgLongPress**

```typescript
onImgLongPress?: (index: number) => void
```

图片长按事件

### 示例代码

```typescript
import { ImagePreview } from 'module_imagepreview'

@Entry
@ComponentV2
export struct Index {
  @Local imageList: string[] = [
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/news-hnp2d/news_tra_2.jpg',
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/news-hnp2d/news_tra_8.jpg',
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/news-hnp2d/news_tra_3.jpg'
  ]

  build() {
    Button('打开图片预览').onClick(() => {
      ImagePreview.show(this.imageList, {
        startIndex: 1,
      })
    })
  }
}
```

### 更新记录

**1.0.0 (2025-08-30)**

- 初始版本

### 权限与隐私

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
|----------|----------|----------|
| ohos.permission.INTERNET | 允许使用Internet网络 | 允许使用Internet网络 |

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
- 5.1.0
- 5.1.1
- 6.0.0

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

- 原始URL: https://developer.huawei.com/consumer/cn/market/prod-detail/18f4594dfc97436aa25d0696db64aa3e/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%9B%BE%E7%89%87%E9%A2%84%E8%A7%88%E7%BB%84%E4%BB%B6/module_imagepreview1.0.0.zip