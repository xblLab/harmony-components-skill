# 宜忌查询组件

## 简介

本组件提供了查询开始日期到结束日期内的吉日以及忌日的相关功能。

## 详细介绍

### 简介

本组件提供了查询开始日期到结束日期内的吉日以及忌日的相关功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

### 快速入门

安装组件。

> 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
> 如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `yiji_query` 和 `base_apis` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 yiji_query 和 base_apis 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
        "name": "yiji_query",
        "srcPath": "./XXX/yiji_query",
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
  "yiji_query": "file:./XXX/yiji_query"
}
```

引入组件。

```typescript
import { YiJiQuery } from 'yiji_query';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
import { YiJiQuery } from 'yiji_query';

@Entry
@Component
struct Index {
  pageInfo: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pageInfo) {
      YiJiQuery({
        routerModule:this.pageInfo,
        selectColor:'#c4272b',
        titleColor:'#ffffff',
        selectedDate:new Date('2025-05-15'),
      })
    }
    .hideTitleBar(true) 
  }
}
```

### API 参考

#### 接口

`YiJiQuery(options?: YiJiQueryOptions)`

查询开始日期到结束日期内的吉日以及忌日组件。

**参数：**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | YiJiQueryOptions | 否 | 查询开始日期到结束日期内的吉日以及忌日组件的参数。 |

#### YiJiQueryOptions 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| routerModule | NavPathStack | - | 是当前页面路由栈 |
| selectColor | ResourceStr | 否 | 开始查询的日期 |
| titleColor | ResourceStr | 否 | 主题 |
| selectedDate | ResourceStr | 否 | 查询关键字 |

#### LuckyDays 对象说明

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| daysFromNow | number | 是 | 查询到的日期距离今天还有多少天 |
| solarDate | Date \| string | 是 | 阴历日期 |
| lunarDate | string | 是 | 农历日期 |
| ganZhiYear | string | 是 | 天干地支年 |
| ganZhiMonth | string | 是 | 天干地支月 |
| ganZhiDay | string | 是 | 天干地支日 |
| weekday | string | 是 | 周几 |

#### 事件

支持以下事件：

- **onLunarInfoCardClick**
  - `onLunarInfoCardClick(callback: (lunarInfo: LuckyDays) => void)`
  - 宜忌卡片点击事件，返回卡片信息

#### 示例代码

```typescript
import { YiJiQuery } from 'yiji_query';

@Entry
@Component
struct Index {
  pageInfo: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pageInfo) {
      YiJiQuery({
        routerModule:this.pageInfo,
        selectColor:'#c4272b',
        titleColor:'#ffffff',
        selectedDate:new Date('2025-06-15'),
      })
    }
  }
}
```

### 更新记录

| 版本 | 日期 | 备注 |
| :--- | :--- | :--- |
| 1.0.2 | 2025-10-31 | Created with Pixso. |
| 1.0.1 | 2025-08-29 | Created with Pixso. 下载该版本 README 优化 |
| 1.0.0 | 2025-07-21 | Created with Pixso. 下载该版本 README 内容优化 |

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

| 隐私政策 | SDK 合规使用指南 |
| :--- | :--- |
| 不涉及 | 不涉及 |

### 兼容性

| 项目 | 版本/类型 | 备注 |
| :--- | :--- | :--- |
| HarmonyOS 版本 | 5.0.4 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.5 | Created with Pixso. |
| 应用类型 | 应用 | Created with Pixso. |
| 应用类型 | 元服务 | Created with Pixso. |
| 设备类型 | 手机 | Created with Pixso. |
| 设备类型 | 平板 | Created with Pixso. |
| 设备类型 | PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.4 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.0 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.1 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.0 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/8a6425ead3ee4c31a37ce5c2295279e5/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%AE%9C%E5%BF%8C%E6%9F%A5%E8%AF%A2%E7%BB%84%E4%BB%B6/yiji_query1.0.2.zip