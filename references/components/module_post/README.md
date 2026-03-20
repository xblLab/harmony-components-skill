# 发帖组件

## 简介

本组件支持编辑互动发帖。

## 详细介绍

简介
本组件支持编辑互动发帖。

发表图片&文字发表视频&文字

## 约束与限制

### 环境

- **DevEco Studio 版本**：DevEco Studio 6.0.1 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 6.0.1 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、平板
- **系统版本**：HarmonyOS 5.1.1(19) 及以上

## 使用

### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `module_post`、`module_imagepreview` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_post、module_imagepreview 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_post",
    "srcPath": "./XXX/module_post"
  },
  {
    "name": "module_imagepreview",
    "srcPath": "./XXX/module_imagepreview"
  }
]
```

c. 在项目根目录 `oh-package.json5` 添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_post": "file:./XXX/module_post"
}
```

### 引入组件

```typescript
import { PublishPostComp } from 'module_post';
```

### 调用组件

详细参数配置说明参见 API 参考。

```typescript
PublishPostComp({
  fontRatio: 1,
  onChange: (body: string, mediaList: PostImgVideoItem[]) => {
    this.body = body;
    this.mediaList = mediaList;
  },
})
```

## API 参考

### 接口

`PublishPostComp(option?: PublishPostCompOptions)`

发帖组件

参数：

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | PublishPostCompOptions | 否 | 配置发帖组件的参数。 |

#### PublishPostCompOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| fontRatio | number | 否 | 字体大小比例 |
| imageParams | MediaParams | 否 | 图片参数 |
| videoParams | MediaParams | 否 | 视频参数 |
| controller | TextAreaController | 否 | TextArea 控制器 |
| onChange | `(body: string, mediaList: PostImgVideoItem[]) => void` | 否 | 文字、图片、视频变化的回调 |
| isFocus | `(result: boolean) => void` | 否 | 键盘是否被拉起的回调 |

#### MediaParams 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| type | photoAccessHelper.PhotoViewMIMETypes | 是 | 媒体文件类型 |
| maxLimit | number | 是 | 限制资源选择最大数量 |
| maxSize | number | 否 | 限制资源选择最大大小，单位是 MB |

#### PostImgVideoItem 对象说明

| 参数名 | 类型 | 说明 |
| :--- | :--- | :--- |
| id | number | 唯一索引 |
| picVideoUrl | string | 图片/视频媒体文件 uri |
| surfaceUrl | string | 视频封面图沙箱 uri |

## 示例代码

```typescript
import { PublishPostComp, PostImgVideoItem } from 'module_post';

@Entry
@ComponentV2
struct Sample1 {
  @Local body: string = '';
  @Local mediaList: PostImgVideoItem[] = [];

  build() {
    NavDestination() {
      this.titleBuilder()

      Column() {
        PublishPostComp({
          fontRatio: 1,
          onChange: (body: string, mediaList: PostImgVideoItem[]) => {
            this.body = body;
            this.mediaList = mediaList;
          },
        })
      }
      .layoutWeight(1)
    }
    .hideTitleBar(true)
    .padding(16)
  }

  @Builder
  titleBuilder() {
    Row() {
      Text('发帖页面')
        .fontSize($r('sys.float.Body_L'))
        .fontWeight(FontWeight.Medium)
      Blank()
      Button('发布')
        .width(72)
        .height(40)
        .fontSize($r('sys.float.Body_L'))
        .fontColor(this.enablePublish ? $r('sys.color.font_on_primary') : $r('sys.color.font_tertiary'))
        .backgroundColor(this.enablePublish ? '#5C79D9' : $r('sys.color.comp_background_secondary'))
        .enabled(this.enablePublish)
        .onClick(() => {
          this.getUIContext().getPromptAction().showToast({
            message: '点击了发布按钮',
          })
        })
    }
    .width('100%')
    .height(56)
  }

  @Computed
  get enablePublish() {
    if (this.body) {
      return true;
    }
    if (this.mediaList.length) {
      return true;
    }
    return false;
  }
}
```

## 更新记录

- **1.0.2** (2026-01-13)
  - 下载该版本支持限制上传图片、视频大小。
- **1.0.1** (2025-09-10)
  - 下载该版本新增平板适配。
- **1.0.0** (2025-08-30)
  - 下载该版本初始版本。

## 基本信息

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 合规性

- **隐私政策**：不涉及
- **SDK 合规**：不涉及

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.1.1, 6.0.0, 6.0.1 |
| 应用类型 | 应用，元服务 |
| 设备类型 | 手机，平板，PC |
| DevEcoStudio 版本 | DevEco Studio 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/20b7df314358487590128830e0904c7e/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%8F%91%E5%B8%96%E7%BB%84%E4%BB%B6/module_post1.0.2.zip