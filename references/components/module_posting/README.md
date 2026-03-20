# 意见反馈和历史记录组件

## 简介

本组件提供填写意见、发布意见的功能。

## 详细介绍

### 简介

本组件提供填写意见、发布意见的功能。

意见反馈反馈历史反馈历史详情

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.4 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.4 Release SDK 及以上
- 设备类型：华为手机（直板机）
- HarmonyOS 版本：HarmonyOS 5.0.4 Release 及以上

### 快速入门

安装组件。

1. 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
2. 如果是从生态市场下载组件，请参考以下步骤安装组件。
   - a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
   - b. 在项目根目录 `build-profile.json5` 添加 `module_posting` 模块。
     ```json5
     // 在项目根目录 build-profile.json5 填写 module_posting 路径。其中 XXX 为组件存放的目录名
     "modules": [
         {
             "name": "module_posting",
             "srcPath": "./XXX/module_posting",
         }
     ]
     ```
   - c. 在项目根目录 `oh-package.json5` 中添加依赖。
     ```json5
     // XXX 为组件存放的目录名称
     "dependencies": {
       "module_posting": "file:./XXX/module_posting"
     }
     ```

本组件基于全屏模式适配，使用组件需要在入口文件进行如下配置。
```typescript
// entry/src/main/ets/entryability/EntryAbility.ets
...
onWindowStageCreate(windowStage: window.WindowStage): void {
  windowStage.getMainWindow((err, data) => {
      data.setWindowLayoutFullScreen(true)
    });
}
...
```

引入组件。
```typescript
import { UrlMap, WindowUtil } from 'module_posting'
```

### API 参考

不涉及。

### 示例代码

```typescript
import { UrlMap, WindowUtil } from 'module_posting'

@Entry
@ComponentV2
struct Index {
  stack: NavPathStack = new NavPathStack()

  aboutToAppear(): void {
    WindowUtil.initWindowUtil()
  }

  build() {
    Navigation(this.stack) {
      Column(){
        Blank().height(WindowUtil.avoidAreaSize.top)
        Column({ space: 10 }) {
          Text('意见反馈').fontSize(20).fontWeight(FontWeight.Bold)
          Button('go').width('100%').onClick(() => {
            this.stack.pushPath({
              name: UrlMap.FEEDBACK_PAGE
            })
          })
        }
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)
        Blank().height(WindowUtil.avoidAreaSize.bottom)
      }
    }
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
  }
}
```

### 更新记录

#### 1.0.1 (2025-10-31)

Created with Pixso.

下载该版本

#### 1.0.0 (2025-07-02)

Created with Pixso.

下载该版本

### 权限与隐私

基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

隐私政策

| 项目 | 内容 |
| :--- | :--- |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.4 <br> Created with Pixso. |
| | 5.0.5 <br> Created with Pixso. |
| | 5.1.0 <br> Created with Pixso. |
| | 5.1.1 <br> Created with Pixso. |
| | 6.0.0 <br> Created with Pixso. |
| 应用类型 | 应用 <br> Created with Pixso. |
| | 元服务 <br> Created with Pixso. |
| 设备类型 | 手机 <br> Created with Pixso. |
| | 平板 <br> Created with Pixso. |
| | PC <br> Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.4 <br> Created with Pixso. |
| | DevEco Studio 5.0.5 <br> Created with Pixso. |
| | DevEco Studio 5.1.0 <br> Created with Pixso. |
| | DevEco Studio 5.1.1 <br> Created with Pixso. |
| | DevEco Studio 6.0.0 <br> Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/868f5cf8cb7c4df9a7385633d5d492d7/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%84%8F%E8%A7%81%E5%8F%8D%E9%A6%88%E5%92%8C%E5%8E%86%E5%8F%B2%E8%AE%B0%E5%BD%95%E7%BB%84%E4%BB%B6/module_posting1.0.1.zip