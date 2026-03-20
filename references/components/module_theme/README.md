# 主题组件

## 简介

本组件提供了展示当前选中主题、所有主题以及浏览切换主题的相关能力。

## 详细介绍

### 简介

本组件提供了展示当前选中主题、所有主题以及浏览切换主题的相关能力。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.5(17) 及以上

### 使用

安装组件。

1. 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
2. 如果是从生态市场下载组件，请参考以下步骤安装组件。
   - a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
   - b. 在项目根目录 `build-profile.json5` 添加 `module_theme` 模块。
     ```json5
     // 项目根目录下 build-profile.json5 填写 module_theme 路径。其中 XXX 为组件存放的目录名
     {
       "modules": [
         {
           "name": "module_theme",
           "srcPath": "./XXX/module_theme"
         }
       ]
     }
     ```
   - c. 在项目根目录 `oh-package.json5` 中添加依赖。
     ```json5
     // XXX 为组件存放的目录名
     {
       "dependencies": {
         "module_theme": "file:./XXX/module_theme"
       }
     }
     ```

引入组件句柄。
```typescript
import { ThemeController, ThemesCard } from 'module_theme';
```

开启全局沉浸式布局。
```typescript
const win = await window.getLastWindow(getContext());
win.setWindowLayoutFullScreen(true);
```

使用主题卡片组件。详细参数配置说明参见 API 参考。
```typescript
ThemesCard({ stack: this.stack })
```

### API 参考

#### 子组件

无

#### 接口

**ThemesCard(options?: ThemesCardOptions)**
主题卡片组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | ThemesCardOptions | 是 | 配置主题卡片组件的参数。 |

**ThemesCardOptions 对象说明：**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| stack | NavPathStack | 是 | 页面跳转所需的路由栈对象 |
| bgColor | ResourceColor | 否 | 卡片背景颜色 |
| radius | Length | 否 | 卡片圆角 |
| pad | Padding \| Length | 否 | 卡片内边距 |

#### ThemeController

主题控制器，用于切换与获取当前选择的主题。

**字段：**

| 名称 | 类型 | 说明 |
| :--- | :--- | :--- |
| themePic | Resource | 当前主题展示图片。每次获取时，会根据当前时间从当前主题的图片中选择一张。 |
| themeColor | string | 当前主题展示颜色。 |
| themePics | Resource[] | 当前主题所有图片。 |
| themeLabel | string | 当前主题文字标签。 |

**方法：**

| 名称 | 说明 |
| :--- | :--- |
| getThemeId() | 获取当前主题 Id |
| getThemeById(id: number) | 通过 Id 获取对应主题 |
| getThemePicsById(id: number) | 通过 Id 获取对应主题所有图片 |
| change(id: number) | 通过 Id 修改对应主题 |

### 示例代码

本示例通过 ThemesCard 实现主题的浏览与选择。

```typescript
import { window } from '@kit.ArkUI';
import { ThemeController, ThemesCard } from 'module_theme';

@Entry
@ComponentV2
struct Theme {
  stack: NavPathStack = new NavPathStack();
  @Local fullScreen: boolean = false;

  async aboutToAppear() {
    const win = await window.getLastWindow(getContext());
    win.setWindowLayoutFullScreen(true);
    this.fullScreen = true;
  }

  build() {
    if (this.fullScreen) {
      Navigation(this.stack) {
        Column() {
          ThemesCard({ stack: this.stack })
        }
        .backgroundImage(ThemeController.themePic)
        .backgroundImageSize(ImageSize.Cover)
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .height('100%')
      }
      .hideTitleBar(true)
    }
  }
}
```

### 更新记录

#### 1.0.0 (2025-08-30)

- **创建工具**：Created with Pixso
- **权限与隐私**
  - **权限名称**：无
  - **权限说明**：无
  - **使用目的**：无
  - **隐私政策**：不涉及
  - **SDK 合规使用指南**：不涉及
- **兼容性**
  - **HarmonyOS 版本**：5.0.5, 5.1.0, 5.1.1, 6.0.0
- **应用类型**
  - **应用**
  - **元服务**
- **设备类型**
  - **手机**
  - **平板**
  - **PC**
- **DevEco Studio 版本**
  - **DevEco Studio 5.0.5**
  - **DevEco Studio 5.1.0**
  - **DevEco Studio 5.1.1**
  - **DevEco Studio 6.0.0**

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/f7d960ef3ced4c4aadfec15e2ffe23e5/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E4%B8%BB%E9%A2%98%E7%BB%84%E4%BB%B6/module_theme1.0.0.zip