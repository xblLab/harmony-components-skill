# 检测应用更新组件

## 简介

本组件提供了检测应用是否存在新版本功能。

## 详细介绍

本组件提供了检测应用是否存在新版本功能。

- 检测新版本（自定义弹窗）
- 检测新版本（系统弹窗）

## 约束与限制

### 环境

- DevEco Studio版本：DevEco Studio 5.0.1 Release及以上
- HarmonyOS SDK版本：HarmonyOS 5.0.1(13) Release SDK及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 5.0.1及以上

### 权限

- 网络权限：ohos.permission.INTERNET

## 快速入门

### 安装组件

> 如果是在DevEco Studio使用插件集成组件，则无需安装组件，请忽略此步骤。

如果是从生态市场下载组件，请参考以下步骤安装组件：

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的XXX目录下。
2. 在项目根目录build-profile.json5添加check_app_update模块。

```json5
// 在项目根目录build-profile.json5填写check_app_update路径。其中XXX为组件存放的目录名
"modules": [
    {
      "name": "check_app_update",
      "srcPath": "./XXX/check_app_update",
    }
]
```

3. 在项目根目录oh-package.json5中添加依赖。

```json5
// XXX为组件存放的目录名称
"dependencies": {
  "check_app_update": "file:./XXX/check_app_update"
}
```

### 引入组件

```typescript
import { checkUpdateAndShowDialog, checkUpdate, DialogController, findNewVersion, Params } from 'check_app_update';
```

### 调用组件（自定义升级对话框）

在项目根目录AppScope/resources下创建文件夹rawfile，在rawfile文件夹下创建data.json文件，内容如下（注：链接后id值为包名）：

```json5
{
   "app_gallery_url": "https://appgallery.huawei.com/app/detail?id=XXX"
}
```

```typescript
import { ComponentContent } from '@kit.ArkUI';
import { checkUpdate, DialogController, findNewVersion, Params } from 'check_app_update';
import { common } from '@kit.AbilityKit';

@Entry
@ComponentV2
struct Index {
  @Local message: string = "hello";
  private ctx: UIContext = this.getUIContext();

  aboutToAppear(): void {
    checkUpdate(this.getUIContext().getHostContext() as common.UIAbilityContext)
      .then(version => {
        // 0 不存在新版本， 1 存在新版本
        if (version === 1) {
          this.showCallDialog(version);
        } else {
          // mock 新版本
          this.showCallDialog(version);
        }
      })
  }

  showCallDialog(version: number) {
    DialogController.setContext(this.ctx);
    let contentNode: ComponentContent<object> =
      new ComponentContent(this.ctx, wrapBuilder(findNewVersion), new Params(version))
    DialogController.setContentNode(contentNode);
    DialogController.setOptions({alignment:DialogAlignment.Center,offset:{dx:0, dy:0}})
    DialogController.openDialog();
  }

  build() {
  
  }
}
```

### 调用组件（使用系统升级对话框）

> 推荐使用

```typescript
import { checkUpdateAndShowDialog } from 'check_app_update';
import { common } from '@kit.AbilityKit';

@Entry
@ComponentV2
struct Index {
  @Local message: string = "hello";

  aboutToAppear(): void {
    checkUpdateAndShowDialog(this.getUIContext().getHostContext() as common.UIAbilityContext)
  }
  
  build() {
    Text(this.message)
  }
}
```

## API参考

### 子组件

无

### 接口

检测应用更新组件。

#### 参数

| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| params | Params | 是 | 向弹窗视图传递的参数 |

#### Params对象说明

| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| text | number | 是 | 是否存在新版本的查询结果 |

### 示例代码

```typescript
import { ComponentContent } from '@kit.ArkUI';
import { checkUpdate, DialogController, findNewVersion, Params } from 'check_app_update';
import { common } from '@kit.AbilityKit';

@Entry
@ComponentV2
struct Index {
  @Local message: string = "hello";
  private ctx: UIContext = this.getUIContext();

  aboutToAppear(): void {
    checkUpdate(this.getUIContext().getHostContext() as common.UIAbilityContext)
      .then(version => {
        // 0 不存在新版本， 1 存在新版本
        if (version === 1) {
          this.showCallDialog(version);
        } else {
          // mock 新版本
          this.showCallDialog(version);
        }
      })
  }

  showCallDialog(version: number) {
    DialogController.setContext(this.ctx);
    let contentNode: ComponentContent<object> =
      new ComponentContent(this.ctx, wrapBuilder(findNewVersion), new Params(version))
    DialogController.setContentNode(contentNode);
    DialogController.setOptions({alignment:DialogAlignment.Center,offset:{dx:0, dy:0}})
    DialogController.openDialog();
  }

  build() {
  
  }
}
```

## 更新记录

### 1.0.2（2025-11-03）

下载该版本更新readme。

### 1.0.1（2025-09-25）

下载该版本更新了调用系统升级弹窗功能。

### 1.0.0（2025-08-30）

下载该版本初始版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
|----------|----------|----------|
| ohos.permission.INTERNET | 允许使用Internet网络。 | 允许使用Internet网络。 |

### 隐私政策

不涉及

### SDK合规使用指南

不涉及

## 兼容性

### HarmonyOS版本

- 5.0.1
- 5.0.2
- 5.0.3
- 5.0.4
- 5.0.5

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEcoStudio版本

- DevEco Studio 5.0.1
- DevEco Studio 5.0.2
- DevEco Studio 5.0.3
- DevEco Studio 5.0.4
- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0

## 来源

- 原始URL: https://developer.huawei.com/consumer/cn/market/prod-detail/be056580e6b14bde9340d5c782776164/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%A3%80%E6%B5%8B%E5%BA%94%E7%94%A8%E6%9B%B4%E6%96%B0%E7%BB%84%E4%BB%B6/check_app_update1.0.2.zip