# 日期间隔和计算组件

## 简介

本组件提供日期之间计算能力，包括计算 2 个日期之间的天数，计算选中日期前后的时间等功能。

## 详细介绍

### 简介

本组件提供日期之间计算能力，包括计算 2 个日期之间的天数，计算选中日期前后的时间等功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.4(16) 及以上

### 快速入门

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `module_date_calculation` 和 `module_base_apis` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 module_date_calculation 和 module_base_apis 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
        "name": "module_date_calculation",
        "srcPath": "./XXX/module_date_calculation",
    },
    {
        "name": "module_base_apis",
        "srcPath": "./XXX/module_base_apis",
    }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_date_calculation": "file:./XXX/module_date_calculation"
}
```

引入组件与日历组件句柄。

```typescript
import { DateToolsCalculate } from 'module_date_calculation';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
import { DateToolsCalculate } from 'module_date_calculation';

@Entry
@Component
struct Index {
  build() {
    Column() {
      DateToolsCalculate({
        startDate: new Date('2025-5-28'),
        buttonColor: '#317AF7',
        textColor: '#ffffff',
      })
    }
  }
}
```

### API 参考

#### 子组件

无

#### 接口

`DateToolsCalculate({startDate: string, buttonColor: string, textColor: string})`

日期计算的相关能力，包括日期间隔、日期计算功能。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| buttonColor | ResourceStr | 否 | 按钮颜色 |
| textColor | ResourceStr | 否 | 文字颜色 |
| startDate | ResourceStr \| number | 否 | 开始日期 |

#### 事件

支持以下事件：

- **onIntervalSearch**
  ```typescript
  onIntervalSearch(callback: (betweenDates: number) => void)
  ```
  日期间隔查询事件，返回日期间隔。

- **onCalculateSearch**
  ```typescript
  onCalculateSearch(callback: (calculateInfo: LuckyDays) => void)
  ```
  日期计算查询事件，返回查询日期计算详情。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| calculateInfo | LuckyDays | - | 是根据时间条件查询到的日期信息 |

**LuckyDays 对象说明：**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| daysFromNow | string | 是 | 距离今天的天数 |
| solarDate | string | 是 | 阳历日期 |
| lunarDate | string | 是 | 农历日期 |
| ganZhiYear | string | 是 | 天干地支年 |
| ganZhiMonth | string | 是 | 天干地支月 |
| forwardOrBack | string | 是 | 向前向后查询 |
| ganZhiDay | string | 是 | 天干地支日 |
| weekday | string | 是 | 星期 |

### 示例代码

```typescript
import { DateToolsCalculate } from 'module_date_calculation';

@Entry
@Component
struct Index {
   build() {
      Column() {
         DateToolsCalculate({
            startDate: new Date('2025-5-28'),
            buttonColor: '#317AF7',
            textColor: '#ffffff',
         })
      }
   }
}
```

### 更新记录

- **1.0.2** (2025-11-25)
  - 下载该版本适配深浅模式
- **1.0.1** (2025-10-31)
  - 下载该版本
  - 升级 SDK 的版本
  - 组件相关描述
  - 调整组件目录结构
- **1.0.0** (2025-07-22)
  - 下载该版本
  - 初始版本

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

### 兼容性

| 类型 | 版本/设备 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.4 <br> 5.0.5 <br> 5.1.0 <br> 5.1.1 <br> 6.0.0 |
| **应用类型** | 应用 <br> 元服务 |
| **设备类型** | 手机 <br> 平板 <br> PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.4 <br> DevEco Studio 5.0.5 <br> DevEco Studio 5.1.0 <br> DevEco Studio 5.1.1 <br> DevEco Studio 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/93462f84e42643ad8b022080d0a95376/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%97%A5%E6%9C%9F%E9%97%B4%E9%9A%94%E5%92%8C%E8%AE%A1%E7%AE%97%E7%BB%84%E4%BB%B6/module_date_calculation1.0.2.zip