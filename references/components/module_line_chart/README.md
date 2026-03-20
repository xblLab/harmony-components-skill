# 折线图组件

## 简介

本组件提供折线图相关功能。

## 详细介绍

### 简介

本组件提供折线图相关功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（直板机）
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

#### 权限

- **网络权限**：`ohos.permission.INTERNET`

### 快速入门

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `module_line_chart` 和 `module_base` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 module_line_chart 和 module_base 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
    "name": "module_line_chart",
    "srcPath": "./XXX/module_line_chart",
    },
    {
    "name": "module_base",
    "srcPath": "./XXX/module_base",
    }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_line_chart": "file:./XXX/module_line_chart"
}
```

引入组件与折线图组件句柄。

```typescript
import { CommonCharts } from 'module_line_chart';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
@Entry
@ComponentV2
struct Sample {
  @Local xData: string[] =
    ["2024/05/01", "2024/05/02", "2024/05/03", "2024/05/04", "2024/05/05", "2024/05/06", "2024/05/07", "2024/05/08",
      "2024/05/09", "2024/05/10"]
  @Local seriesData: number[] = [2.05, 2.47, 2.28, 2.59, 2.68, 2.15, 2.38, 2.02, 1.65, 2.98]

  build() {
    Column() {
      CommonCharts({ xData: this.xData, seriesData: this.seriesData, label: '七日年化' })
    }
    .backgroundColor('#F1F3F5')
    .padding(10)
    .width('100%')
    .height(300)
  }
}
```

## API 参考

### 子组件

### 接口

`CommonCharts(options?: CommonChartsOptions)`

折线图组件。

**参数：**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | CommonChartsOptions | 否 | 配置折线图组件的参数。 |

**CommonChartsOptions 对象说明**

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| label | string | 是 | 折线图标签 |
| xData | string[] | 是 | 折线图横坐标 |
| seriesData | number[] | 是 | 折线图数据 |

### 示例代码

```typescript
import { CommonCharts } from 'module_line_chart'

@Entry
@ComponentV2
struct Sample {
 @Local xData: string[] =
   ["2024/05/01", "2024/05/02", "2024/05/03", "2024/05/04", "2024/05/05", "2024/05/06", "2024/05/07", "2024/05/08",
     "2024/05/09", "2024/05/10"]
 @Local seriesData: number[] = [2.05, 2.47, 2.28, 2.59, 2.68, 2.15, 2.38, 2.02, 1.65, 2.98]

 build() {
   Column() {
     CommonCharts({ xData: this.xData, seriesData: this.seriesData, label: '七日年化' })
   }
   .backgroundColor('#F1F3F5')
   .padding(10)
   .width('100%')
   .height(300)
 }
}
```

## 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.1 | 2025-11-25 | 下载该版本修改 readme |
| 1.0.0 | 2025-08-30 | 下载该版本初始版本 |

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 权限与隐私 | ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |
| 隐私政策 | - | 不涉及 | - |
| SDK 合规使用指南 | - | 不涉及 | - |

## 兼容性

| 项目 | 详情 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/ba88223bafeb43f9804dd277dbe54954/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%8A%98%E7%BA%BF%E5%9B%BE%E7%BB%84%E4%BB%B6/module_line_chart1.0.1.zip