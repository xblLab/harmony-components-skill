# 节日节气组件

## 简介

本组件提供了节日、节气展示的相关功能。

## 详细介绍

### 简介

本组件提供了节日、节气展示的相关功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

### 快速入门

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `festival_solar` 和 `base_apis` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 festival_solar 和 base_apis 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
    "name": "festival_solar",
    "srcPath": "./XXX/festival_solar",
    },
    {
    "name": "base_apis",
    "srcPath": "./XXX/base_apis",
    }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "festival_solar": "file:./XXX/festival_solar"
}
```

引入组件。

```typescript
import { FestivalSolar } from 'festival_solar';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
import { FestivalSolar } from 'festival_solar';

@Entry
@Component
struct Index {
  build() {
    Column() {
      FestivalSolar({
        selectedDate: new Date(),
      });
    }
  }
}
```

### API 参考

#### 接口

`FestivalSolar(options?: FestivalSolarOptions)`

节日节气展示组件。

**参数：**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | FestivalSolarOptions | 否 | 节日节气展示组件的参数。 |

**FestivalSolarOptions 对象说明**

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| selectedDate | Date | - | 是当前日期 |

#### 事件

支持以下事件：

- **onFestivalCardClick**
  ```typescript
  onFestivalCardClick(callback: (festivalInfo: HolidayInfo) => void)
  ```
  公众节日卡片事件，返回节日信息

- **onSolarCardClick**
  ```typescript
  onFestivalCardClick(callback: (solarInfo: SolarInfo) => void)
  ```
  节气卡片事件，返回节日信息

- **onHolidayCardClick**
  ```typescript
  onFestivalCardClick(callback: (festivalInfo: HolidayInfo) => void)
  ```
  公众假日卡片事件，返回节日信息

**HolidayInfo 对象说明**

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| solarDate | string | 是 | 阳历日期 |
| lunarDate | string | 是 | 农历日期 |
| holidayName | string[] | 是 | 假期名称集合 |
| daysUntil | number | 是 | 距离今天还剩多少天 |
| month | string | 是 | 月 |
| day | string | 是 | 日 |

**SolarInfo 对象说明**

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| solarDate | string | 是 | 阳历日期 |
| lunarDate | string | 是 | 农历日期 |
| solarTerm | string | 是 | 节气名称 |

### 示例代码

#### 示例 1

本示例通过 `selectedDate` 实现不同节假日信息展示。

```typescript
import { FestivalSolar } from 'festival_solar';

@Entry
@Component
struct Index {
  build() {
    Column() {
      FestivalSolar({
        selectedDate: new Date(),
      });
    }
  }
}
```

### 更新记录

- **1.0.2** (2025-10-31)
  Created with Pixso.
  下载该版本 README 优化

- **1.0.1** (2025-08-29)
  Created with Pixso.
  下载该版本 README 内容优化

- **1.0.0** (2025-07-21)
  Created with Pixso.
  下载该版本 初始版本

### 权限与隐私

- **基本信息**
  - 权限名称：无
  - 权限说明：无
  - 使用目的：无
- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

### 兼容性

| 项目 | 详情 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.4 <br> Created with Pixso. <br> 5.0.5 <br> Created with Pixso. |
| **应用类型** | 应用 <br> Created with Pixso. <br> 元服务 <br> Created with Pixso. |
| **设备类型** | 手机 <br> Created with Pixso. <br> 平板 <br> Created with Pixso. <br> PC <br> Created with Pixso. |
| **DevEcoStudio 版本** | DevEco Studio 5.0.4 <br> Created with Pixso. <br> DevEco Studio 5.0.5 <br> Created with Pixso. <br> DevEco Studio 5.1.0 <br> Created with Pixso. <br> DevEco Studio 5.1.1 <br> Created with Pixso. <br> DevEco Studio 6.0.0 <br> Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/a061870a03874776a817e4ae9f461cc1/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%8A%82%E6%97%A5%E8%8A%82%E6%B0%94%E7%BB%84%E4%BB%B6/festival_solar1.0.2.zip