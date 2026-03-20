# 天气组件

## 简介

本组件提供浏览实时天气、24 小时天气、15 天天气和生活指数的相关能力，通过绘图实现直观天气信息展示。并提供对应接口获取相应天气数据。

## 详细介绍

### 简介

本组件提供浏览实时天气、24 小时天气、15 天天气和生活指数的相关能力，通过绘图实现直观天气信息展示。并提供对应接口获取相应天气数据。

### 约束与限制

#### 环境

| 项目 | 要求 |
| :--- | :--- |
| DevEco Studio 版本 | DevEco Studio 5.0.5 Release 及以上 |
| HarmonyOS SDK 版本 | HarmonyOS 5.0.5 Release SDK 及以上 |
| 设备类型 | 华为手机（包括双折叠和阔折叠） |
| 系统版本 | HarmonyOS 5.0.5(17) 及以上 |

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_weather_core` 模块。
   ```json5
   // 项目根目录下 build-profile.json5 填写 module_weather_core 路径。其中 XXX 为组件存放的目录名
   "modules": [
      {
      "name": "module_weather_core",
      "srcPath": "./XXX/module_weather_core"
      }
   ]
   ```
3. 在项目根目录 `oh-package.json5` 中添加依赖。
   ```json5
   // XXX 为组件存放的目录名
   "dependencies": {
      "module_weather_core": "file:./XXX/module_weather_core"
   }
   ```

#### 引入组件句柄

```typescript
import {WeatherUtils, RealTimeWeather, UINow, HourlyWeather, UIHours, DailyWeather, UIDays, IndicesWeather, UIIndices} from 'module_weather_core';
```

#### 使用多种天气组件

详细参数配置说明参见 API 参考。

```typescript
UINow({ weather: this.realTimeWeather })
UIHours({ weathers: this.hourlyWeathers })
UIDays({ weathers: this.dailyWeathers })
UIIndices({ weathers: this.indicesWeathers })
```

### API 参考

#### 子组件

无

#### 接口

##### UINow(options?: UINowOptions)

实时天气组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UINowOptions | 是 | 配置实时天气组件的参数。 |

**UINowOptions 对象说明：**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| weather | RealTimeWeather | 是 | 实时天气数据 |
| customUi() => void | - | 否 | 自定义构建器 |

**RealTimeWeather 对象说明：**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| time | string | 是 | 采集时间 |
| temp | number | 是 | 温度 |
| maxTemp | number | 是 | 最高温度 |
| minTemp | number | 是 | 最低温度 |
| shellTemp | number | 是 | 体表温度 |
| humidity | number | 是 | 湿度 |
| rain | number | 是 | 降雨概率 |
| desc | string | 是 | 相关文字描述 |
| icon | string | 是 | 相关图标描述 |
| pressure | number | 是 | 气压 |
| uv | number | 是 | 紫外线 |
| windDir | string | 是 | 风向 |
| winSpeed | number | 是 | 风速 |
| airQuality | string | 是 | 空气质量 |

##### UIHours(options?: UIHoursOptions)

24 小时天气组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UIHoursOptions | 是 | 配置 24 小时天气组件的参数。 |

**UIHoursOptions 对象说明：**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| weathers | HourlyWeather[] | 是 | 24 小时天气数据 |
| maxTemp | number | 否 | 最高温度 |
| minTemp | number | 否 | 最低温度 |
| itemWidth | number | 否 | 单元宽度 |

**HourlyWeather 对象说明：**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| time | string | 是 | 采集时间 |
| temp | number | 是 | 当前温度 |
| desc | string | 是 | 天气描述 |
| icon | string | 是 | 天气图标 |
| airQuality | string | 是 | 空气质量 |

##### UIDays(options?: UIDaysOptions)

15 天天气组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UIDaysOptions | 是 | 配置 15 天天气组件的参数。 |

**UIDaysOptions 对象说明：**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| weathers | DailyWeather[] | 是 | 15 天天气数据 |
| maxTemp | number | 否 | 最高温度 |
| minTemp | number | 否 | 最低温度 |
| itemWidth | number | 否 | 单元宽度 |

**DailyWeather 对象说明：**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| time | string | 是 | 采集时间 |
| maxTemp | number | 是 | 最高气温 |
| minTemp | number | 是 | 最低气温 |
| dayDesc | string | 是 | 白天天气描述 |
| dayIcon | string | 是 | 白天天气图标 |
| nightDesc | string | 是 | 晚上天气描述 |
| nightIcon | string | 是 | 晚上天气图标 |
| airQuality | string | 是 | 空气质量 |
| rain | number | 是 | 降雨概率 |

##### UIIndices(options?: UIIndicesOptions)

生活指数组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UIIndicesOptions | 是 | 配置生活指数组件的参数。 |

**UIIndicesOptions 对象说明：**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| weathers | IndicesWeather[] | 是 | 生活指数数据 |
| click(weather: IndicesWeather) => void | - | 否 | 点击回调事件 |

**IndicesWeather 对象说明：**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| time | string | 是 | 采集时间 |
| type | number | 是 | 指数类型 |
| name | string | 是 | 指数名称 |
| level | number | 是 | 指数等级 |
| category | string | 是 | 预报名称 |
| text | string | 是 | 详细描述 |
| icon | string | 是 | 显示图标 |

##### WeatherUtils

天气数据获取工具。

- **getRealTimeWeathers**
  `WeatherUtils.getRealTimeWeathers(codes: string[]): Promise<RealTimeWeather[]>`
  获取对应地区码区域的实时天气数据。

- **getHourlyWeathers**
  `WeatherUtils.getHourlyWeathers(codes: string): Promise<HourlyWeather[]>`
  获取对应地区码区域的 24 小时天气数据。

- **getDailyWeathers**
  `WeatherUtils.getRealTimeWeathers(codes: string): Promise<DailyWeather[]>`
  获取对应地区码区域的 15 天天气数据。

- **getIndicesWeathers**
  `WeatherUtils.getRealTimeWeathers(code: string, day: 1 | 3): Promise<IndicesWeather[][]>`
  获取对应地区码区域对应天数的生活指数数据。

### 示例代码

#### 示例 1（实时天气）

本示例通过 `getRealTimeWeathers` 获取实时天气数据，并通过 `UINow` 组件直观展示对应数据。

```typescript
import { RealTimeWeather, UINow, WeatherUtils } from 'module_weather_core';

interface LocationInfo {
  name: string;
  code: string;
}

@Entry
@ComponentV2
struct WeatherNow {
  @Local location: LocationInfo = { name: '北京', code: '110100' };
  @Local realTimeWeather: RealTimeWeather | undefined;

  aboutToAppear(): void {
    WeatherUtils.getRealTimeWeathers([this.location.code]).then(res => this.realTimeWeather = res[0]);
  }

  build() {
    Column() {
      if (this.realTimeWeather) {
        UINow({ weather: this.realTimeWeather })
      }
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}
```

#### 示例 2（24 小时天气）

本示例通过 `getHourlyWeathers` 获取 24 小时天气数据，并通过 `UIHours` 组件绘制 24 小时温度曲线图。

```typescript
import { HourlyWeather, UIHours, WeatherUtils } from 'module_weather_core';

interface LocationInfo {
  name: string;
  code: string;
}

@Entry
@ComponentV2
struct WeatherHours {
  @Local location: LocationInfo = { name: '北京', code: '110100' };
  @Local hourlyWeathers: HourlyWeather[] = [];

  aboutToAppear(): void {
    WeatherUtils.getHourlyWeathers(this.location.code).then(res => this.hourlyWeathers = res);
  }

  build() {
    Column() {
      if (this.hourlyWeathers.length) {
        UIHours({ weathers: this.hourlyWeathers })
      }
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}
```

#### 示例 3（15 天天气）

本示例通过 `getDailyWeathers` 获取 15 天天气数据，并通过 `UIDays` 组件绘制最高气温和最低气温的曲线图。

```typescript
import { DailyWeather, UIDays, WeatherUtils } from 'module_weather_core';

interface LocationInfo {
  name: string;
  code: string;
}

@Entry
@ComponentV2
struct WeatherDays {
  @Local location: LocationInfo = { name: '北京', code: '110100' };
  @Local dailyWeathers: DailyWeather[] = [];

  aboutToAppear(): void {
    WeatherUtils.getDailyWeathers(this.location.code).then(res => this.dailyWeathers = res);
  }

  build() {
    Column() {
      if (this.dailyWeathers.length) {
        UIDays({ weathers: this.dailyWeathers })
      }
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}
```

#### 示例 4（生活指数）

本示例通过 `getIndicesWeathers` 获取生活指数数据，并通过 `UIIndices` 组件直观展示对应数据。

```typescript
import { IndicesWeather, UIIndices, WeatherUtils } from 'module_weather_core';

interface LocationInfo {
  name: string;
  code: string;
}

@Entry
@ComponentV2
struct WeatherIndices {
  @Local location: LocationInfo = { name: '北京', code: '110100' };
  @Local indicesWeathers: IndicesWeather[] = [];

  aboutToAppear(): void {
    WeatherUtils.getIndicesWeathers(this.location.code, 1).then(res => this.indicesWeathers = res[0]);
  }

  build() {
    Column() {
      if (this.indicesWeathers.length) {
        UIIndices({ weathers: this.indicesWeathers })
      }
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}
```

### 更新记录

| 版本 | 日期 | 备注 |
| :--- | :--- | :--- |
| 1.0.0 | 2025-11-03 | Created with Pixso. |

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 基本信息

| 项目 | 内容 |
| :--- | :--- |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| 项目 | 内容 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.5 |

### 应用类型

- 应用
- 平板
- PC

### DevEcoStudio 版本

- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/2861dc10fade4744a1880bdc29223476/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%A4%A9%E6%B0%94%E7%BB%84%E4%BB%B6/module_weather_core1.0.0.zip