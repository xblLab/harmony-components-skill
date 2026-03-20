# 标准计算器组件

## 简介

本组件提供了标准计算器以及查看历史记录能力。

## 详细介绍

### 简介

本组件提供了标准计算器、科学计算器以及查看历史记录能力。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.4(16) 及以上

#### 快速入门

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_standard_calculator` 和 `module_base_apis` 模块。

   ```json5
   // 在项目根目录 build-profile.json5 填写 module_base_apis 和 module_standard_calculator 路径。其中 XXX 为组件存放的目录名
   "modules": [
       {
           "name": "module_base_apis",
           "srcPath": "./XXX/module_base_apis",
       },
       {
           "name": "module_standard_calculator",
           "srcPath": "./XXX/module_standard_calculator",
       }
   ]
   ```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

   ```json5
   // XXX 为组件存放的目录名称
   "dependencies": {
     "module_standard_calculator": "file:./XXX/module_standard_calculator"
   }
   ```

4. 在主工程的 `EntryAbility.ets` 文件中 `onWindowStageCreate` 的生命周期函数中增加监听窗口尺寸大小的变化。

   ```ets
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

5. 引入组件与计算器组件句柄。

   ```ets
   import { StandardCalculator } from 'module_standard_calculator';
   ```

6. 调用组件，详细参数配置说明参见 API 参考。

   ```ets
   import { StandardCalculator } from 'module_standard_calculator';

   @Entry
   @ComponentV2
   struct Index {
      @Local stack: NavPathStack = new NavPathStack()
      build() {
         Navigation(this.stack) {
            Column() {
               StandardCalculator({ routerModule: this.stack })
            }
         }
      }
   }
   ```

### API 参考

**StandardCalculator({routerModule: NavPathStack})**

标准计算器、科学计算器以及查看历史记录功能。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| routerModule | NavPathStack | 是 | 路由栈 |

### 示例代码

**EntryAbility.ets**

```ets
import { AbilityConstant, common, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

export default class EntryAbility extends UIAbility {
   // ...此处省略上下文
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
               hilog.error(DOMAIN, 'testTag', 'Failed to listen windowSizeChange. Cause: %{public}s', JSON.stringify(exception));
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

**Index.ets**

```ets
import { StandardCalculator } from 'module_standard_calculator';

@Entry
@ComponentV2
struct Index {
   @Local stack: NavPathStack = new NavPathStack()
   build() {
      Navigation(this.stack) {
         Column() {
            StandardCalculator({ routerModule: this.stack })
         }
      }.title('示例')
      .mode(NavigationMode.Stack);
   }
}
```

### 更新记录

- **1.0.2** (2025-11-25)
  - 下载该版本
  - 增加科学计算器功能
  - 适配深浅模式
- **1.0.1** (2025-10-31)
  - 下载该版本
  - 升级 SDK 的版本
- **1.0.0** (2025-07-01)
  - 下载该版本
  - 本组件为标准计算器功能，提供简单计算功能

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### SDK 合规使用指南

不涉及

### 兼容性

| 项目 | 支持版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c7f6a66250c045eabfb64311c7db9220/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%A0%87%E5%87%86%E8%AE%A1%E7%AE%97%E5%99%A8%E7%BB%84%E4%BB%B6/module_standard_calculator1.0.2.zip