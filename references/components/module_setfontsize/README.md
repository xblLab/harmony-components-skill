# 字体大小调节组件

## 简介

本组件支持实时查看字体大小调整效果。

## 详细介绍

### 简介

本组件支持实时查看字体大小调整效果。

### 列表页详情页

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.3 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.3 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）、平板
- 系统版本：HarmonyOS 5.0.1(13) 及以上

### 快速入门

1. **安装组件**
   如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
   如果是从生态市场下载组件，请参考以下步骤安装组件。
   - a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
   - b. 在项目根目录 `build-profile.json5` 添加 `module_setfontsize` 模块。

   深色代码主题复制
   // 项目根目录下 build-profile.json5 填写 module_setfontsize 路径。其中 XXX 为组件存放的目录名
   ```json5
   "modules": [
     {
       "name": "module_setfontsize",
       "srcPath": "./XXX/module_setfontsize"
     }
   ]
   ```

   - c. 在项目根目录 `oh-package.json5` 添加依赖。

   深色代码主题复制
   // XXX 为组件存放的目录名称
   ```json5
   "dependencies": {
     "module_setfontsize": "file:./XXX/module_setfontsize"
   }
   ```

2. **引入组件**

   深色代码主题复制
   ```typescript
   import { SettingFontCore } from 'module_setfontsize';
   ```

3. **调用组件**
   详细参数配置说明参见 API 参考。

   深色代码主题复制
   ```typescript
   SettingFontCore({
     currentRatio: this.currentRatio,
     confirm: (ratio: number) => {
       this.currentRatio = ratio;
       this.getUIContext().getPromptAction().showToast({
         message: '字号设置已成功'
       });
     },
   })
   ```

### API 参考

#### 接口

`SettingFontCore(option?: SettingFontCoreOptions)`

字体大小调节组件。

#### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | SettingFontCoreOptions | 否 | 配置字体大小调节组件的参数。 |

#### SettingFontCoreOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| currentRatio | number | 否 | 字体比例初始值 |
| breakpoint | string | 否 | 应用断点 |
| confirm | (ratio: number) => void | 否 | 确认调整的回调 |

### 示例代码

深色代码主题复制
```typescript
import { SettingFontCore } from 'module_setfontsize'

@Entry
@ComponentV2
struct SettingFont {
  @Local currentRatio: number = 1;

  build() {
    NavDestination() {
      SettingFontCore({
        currentRatio: this.currentRatio,
        confirm: (ratio: number) => {
          this.currentRatio = ratio;
          this.getUIContext().getPromptAction().showToast({
            message: '字号设置已成功'
          });
        },
      })
        .layoutWeight(1)
    }
    .title('字体大小')
    .backgroundColor($r('sys.color.background_secondary'))
  }
}
```

### 更新记录

- **1.0.1 (2025-11-03)**
  
  Created with Pixso.

- **1.0.0 (2025-08-30)**
  
  Created with Pixso.

### 权限与隐私

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

- **隐私政策**: 不涉及
- **SDK 合规使用指南**: 不涉及

#### 兼容性

| 项目 | 版本/类型 | 备注 |
| :--- | :--- | :--- |
| HarmonyOS 版本 | 5.0.1 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.2 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.3 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.4 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.5 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.0 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.1 | Created with Pixso. |
| HarmonyOS 版本 | 6.0.0 | Created with Pixso. |
| 应用类型 | 应用 | Created with Pixso. |
| 应用类型 | 元服务 | Created with Pixso. |
| 设备类型 | 手机 | Created with Pixso. |
| 设备类型 | 平板 | Created with Pixso. |
| 设备类型 | PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.4 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.0 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.1 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.0 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/2c65271abd6f44b2b3dc6ecd454fc50d/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%AD%97%E4%BD%93%E5%A4%A7%E5%B0%8F%E8%B0%83%E8%8A%82%E7%BB%84%E4%BB%B6/module_setfontsize1.0.1.zip