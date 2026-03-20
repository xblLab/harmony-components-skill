# 科学计算器组件

## 简介

提供了多种科学计算方法的计算的功能。

## 详细介绍

### 简介

提供了多种科学计算方法的计算的功能。

本组件工程代码结构如下所示：

```text
science_calculator/src/main/ets                   // 科学计算器 (har)
|- common                                       // 模块常量定义   
|- components                                   // 模块组件
|- model                                        // 模型定义  
|- pages                                        // 页面
|- utils                                        // 模块工具类
|- viewmodel                                    // 与页面一一对应的 vm 层
```

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.5(17) 及以上

#### 权限

无

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。
2. 在项目根目录 `build-profile.json5` 添加 science_calculator 模块。

```json5
"modules": [
   {
   "name": "science_calculator",
   "srcPath": "./xxx/science_calculator",
   },
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
"dependencies": {
   "science_calculator": "file:./xxx/science_calculator",
}
```

#### 监听窗口尺寸变化

在主工程的 `EntryAbility.ets` 文件中 `onWindowStageCreate` 的生命周期函数中增加监听窗口尺寸大小的变化。

```typescript
let windowClass: window.Window | undefined = undefined;
try {
   window.getLastWindow(this.context, (err: BusinessError, data) => {
     const errCode: number = err.code;
     if (errCode) {
       return;
     }
     windowClass = data;
     try {
       // 对窗口尺寸大小变化的监听
       windowClass.on('windowSizeChange', (data) => {
         AppStorage.setOrCreate('height', px2vp(data.height));
       });
     } catch (exception) {
       hilog.error(DOMAIN, 'testTag', 'Failed to listen windowSizeChange. Cause: %{public}s', JSON.stringify(exception));
     }
   });
 } catch (exception) {
   hilog.error(DOMAIN, 'testTag', 'Failed to getLastWindow. Cause: %{public}s', JSON.stringify(exception));
 }
```

### 示例代码

#### EntryAbility.ets

```typescript
// EntryAbility.ets
import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
     try {
        this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
     } catch (err) {
        hilog.error(DOMAIN, 'testTag', 'Failed to set colorMode. Cause: %{public}s', JSON.stringify(err));
     }
     hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
     hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  async onWindowStageCreate(windowStage: window.WindowStage): Promise<void> {
     // ...此处省略上下文
     let windowClass: window.Window | undefined = undefined;
     try {
        window.getLastWindow(this.context, (err: BusinessError, data) => {
           const errCode: number = err.code;
           if (errCode) {
              return;
           }
           windowClass = data;
           try {
              // 对窗口尺寸大小变化的监听
              windowClass.on('windowSizeChange', (data) => {
                 AppStorage.setOrCreate('height', px2vp(data.height));
              });
           } catch (exception) {
              hilog.error(DOMAIN, 'testTag', 'Failed to listen windowSizeChange. Cause: %{public}s',
                 JSON.stringify(exception));
           }
        });
     } catch (exception) {
        hilog.error(DOMAIN, 'testTag', 'Failed to getLastWindow. Cause: %{public}s', JSON.stringify(exception));
     }
     windowStage.loadContent('pages/Index', (err) => {
        if (err.code) {
           hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
           return;
        }
        hilog.info(DOMAIN, 'testTag', 'Succeeded in loading the content.');
     });
  }
  // ...此处省略上下文
};
```

#### Index.ets

```typescript
// Index.ets
@Entry
@ComponentV2
export struct Index {
  @Local pageStack: NavPathStack = new NavPathStack();

  build() {
     Navigation(this.pageStack) {
        Button('跳转').onClick(() => {
           // ScienceCalcHomePage 为科学计算器路由入口页面名称
           this.pageStack.pushPathByName('ScienceCalcHomePage', null);
        });
     }.hideTitleBar(true);
  }
}
```

## 更新记录

| 版本 | 日期 | 说明 | 操作 |
| :--- | :--- | :--- | :--- |
| 1.0.3 | 2025-12-10 | 初始发布 | [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%A7%91%E5%AD%A6%E8%AE%A1%E7%AE%97%E5%99%A8%E7%BB%84%E4%BB%B6/science_calculator1.0.3.zip) |
| 1.0.2 | 2025-12-04 | 修复除不尽运算最后一位结果不正确的问题<br>修复运算后输入双曲函数未清空表达式的问题<br>C 键删除支持删除整个函数表达式 | [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%A7%91%E5%AD%A6%E8%AE%A1%E7%AE%97%E5%99%A8%E7%BB%84%E4%BB%B6/science_calculator1.0.3.zip) |
| 1.0.1 | 2025-11-03 | README 内容优化 | [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%A7%91%E5%AD%A6%E8%AE%A1%E7%AE%97%E5%99%A8%E7%BB%84%E4%BB%B6/science_calculator1.0.3.zip) |
| 1.0.0 | 2025-09-10 | 初始版本 | [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%A7%91%E5%AD%A6%E8%AE%A1%E7%AE%97%E5%99%A8%E7%BB%84%E4%BB%B6/science_calculator1.0.3.zip) |

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规

不涉及

### 兼容性

| HarmonyOS 版本 |
| :--- |
| 5.0.5 |
| 5.1.0 |
| 5.1.1 |
| 6.0.0 |
| 6.0.1 |

### 应用类型

| 类型 |
| :--- |
| 应用 |
| 元服务 |

### 设备类型

| 类型 |
| :--- |
| 手机 |
| 平板 |
| PC |

### DevEcoStudio 版本

| 版本 |
| :--- |
| DevEco Studio 5.0.5 |
| DevEco Studio 5.1.0 |
| DevEco Studio 5.1.1 |
| DevEco Studio 6.0.0 |
| DevEco Studio 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/6d1c44ad3b11468a865b6f97ee3f3aae/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%A7%91%E5%AD%A6%E8%AE%A1%E7%AE%97%E5%99%A8%E7%BB%84%E4%BB%B6/science_calculator1.0.3.zip