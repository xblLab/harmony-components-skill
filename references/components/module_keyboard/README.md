# 车牌输入键盘组件

## 简介

本组件支持国内通用车牌号的输入。

## 详细介绍

### 简介

本组件支持国内通用车牌号的输入。

### 功能特性

- 输入省份、输入字母、数字 + 特殊字

## 约束与限制

### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

## 快速入门

### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_keyboard` 模块。
   > 深色代码主题复制
   ```json5
   // 项目根目录下 build-profile.json5 填写 module_keyboard 路径。其中 XXX 为组件存放的目录名
   "modules": [
     {
       "name": "module_keyboard",
       "srcPath": "./XXX/module_keyboard"
     }
   ]
   ```
3. 在项目根目录 `oh-package.json5` 添加依赖。
   > 深色代码主题复制
   ```json5
   // XXX 为组件存放的目录名称
   "dependencies": {
     "module_keyboard": "file:./XXX/module_keyboard"
   }
   ```

### 引入组件

> 深色代码主题复制
```typescript
import { UILicensePlate } from 'module_keyboard';
```

### 调用组件

调用组件，详细参数配置说明参见 API 参考。

## API 参考

### 接口

#### `UILicensePlate(options?: UILicensePlateOptions)`

车牌输入键盘组件

#### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | `UILicensePlateOptions` | 否 | 配置车牌输入键盘组件的参数。 |

#### `UILicensePlateOptions` 对象说明

| 参数 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| intFocus | `boolean` | 否 | 默认值为 false，初始化是否为输入框聚焦状态 |
| plateNumber | `string` | 否 | 默认值为 ''，传入的车牌号，当该车牌号格式不合法时，不回显该车牌号。 |
| controller | `TextInputController` | 否 | 设置 TextInput 控制器，可控制键盘收起。 |
| onChange | `(carNumber:string[], isComplete:boolean) => void` | 否 | 输入车牌号发生变化时触发，carNumber 为输入车牌号，isComplete 标志当前车牌号是否输入完成 |
| onFormatError | `(plateNumber: string) => void` | 否 | 传入的车牌号格式不正确时触发，plateNumber 为格式不正确的车牌号 |

## 示例代码

> 深色代码主题复制
```typescript
import { UILicensePlate } from 'module_keyboard';

@Entry
@ComponentV2
struct Sample1 {
  @Local plateNumber: string = '';

  build() {
    NavDestination() {
      Column() {
        UILicensePlate({
          // 传入的车牌号
          plateNumber: this.plateNumber,
          // 是否默认激活键盘，选中输入框
          intFocus: false,
          // 输入完整车牌后触发回调，获取车牌号
          onChange: (carNumber: string[], isComplete: boolean) => {
            console.log('当前输入车牌号', carNumber, '是否为完整车牌号', isComplete);
          },
          // 传入车牌号格式错误时触发
          onFormatError: (plateNumber: string) => {
            console.log('格式错误的车牌号', plateNumber);
          },
        })
      }
      .padding(10)
      .width('100%')
    }
    .height('100%')
    .width('100%')
    .title('车牌输入')
  }
}
```

## 更新记录

| 版本 | 日期 | 备注 | 操作 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| 1.0.2 | 2026-01-06 | Created with Pixso. | 下载该版本 | 废弃 API 整改。 |
| 1.0.1 | 2025-10-31 | Created with Pixso. | 下载该版本 | 优化 README |
| 1.0.0 | 2025-08-30 | Created with Pixso. | 下载该版本 | 本组件支持国内通用车牌号的输入。 |

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

### HarmonyOS 版本

| 版本 | 备注 |
| :--- | :--- |
| 5.0.0 | Created with Pixso. |
| 5.0.1 | Created with Pixso. |
| 5.0.2 | Created with Pixso. |
| 5.0.3 | Created with Pixso. |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |
| 5.1.0 | Created with Pixso. |
| 5.1.1 | Created with Pixso. |
| 6.0.0 | Created with Pixso. |

### 应用类型

| 类型 | 备注 |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

### 设备类型

| 类型 | 备注 |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

### DevEcoStudio 版本

| 版本 | 备注 |
| :--- | :--- |
| DevEco Studio 5.0.0 | Created with Pixso. |
| DevEco Studio 5.0.1 | Created with Pixso. |
| DevEco Studio 5.0.2 | Created with Pixso. |
| DevEco Studio 5.0.3 | Created with Pixso. |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/aa3fb71bacad4e84a7890d05e6a40131/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%BD%A6%E7%89%8C%E8%BE%93%E5%85%A5%E9%94%AE%E7%9B%98%E7%BB%84%E4%BB%B6/module_keyboard1.0.2.zip