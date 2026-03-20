# 历史上的今天组件

## 简介

本组件提供查询历史上的今天相关功能，此组件为 mock 数据，固定展示 6 月 13 号的历史上的今天，实际接入请替换成业务接口。

## 详细介绍

### 简介

本组件提供查询历史上的今天相关功能，此组件为 mock 数据，固定展示 6 月 13 号的历史上的今天，实际接入请替换成业务接口。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

#### 权限

- **网络权限**：`ohos.permission.INTERNET`

### 快速入门

1. **安装组件**
   - 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
   - 如果是从生态市场下载组件，请参考以下步骤安装组件：
     - a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
     - b. 在项目根目录 `build-profile.json5` 添加 `today_history` 和 `base_apis` 模块。
     - c. 在项目根目录 `oh-package.json5` 中添加依赖。

2. **引入组件**

```typescript
import { TodayHistory } from 'today_history';
```

3. **调用组件**
   详细参数配置说明参见 [API 参考](#api-参考)。

```typescript
import { TodayHistory } from 'today_history';

@Entry
@Component
struct Index {
  pageInfo: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pageInfo) {
      TodayHistory({
        selectColor: '#c4272b',
        titleColor: '#ffffff',
        routerModule: this.pageInfo,
      })
    }
  }
}
```

### API 参考

#### 子组件

无

#### 接口

`TodayHistory(options?: TodayHistoryOptions)`

用户信息组件。

**参数：**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | TodayHistoryOptions | 否 | 历史上的今天组件。 |

**TodayHistoryOptions 对象说明：**

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| selectDate | Date | 否 | 当前选择的日期 |
| selectColor | ResourceStr | 否 | 导航栏颜色 |
| titleColor | ResourceStr | 否 | 导航栏标题颜色 |
| routerModule | NavPathStack | 否 | 路由栈 |

#### 示例代码

##### 示例 1

调用组件

```typescript
import { TodayHistory } from 'today_history';

@Entry
@Component
struct Index {
  pageInfo: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pageInfo) {
      TodayHistory({
        selectColor: '#c4272b',
        titleColor: '#ffffff',
        routerModule: this.pageInfo,
      })
    }
  }
}
```

### 更新记录

#### 1.0.1 (2025-11-03)

- 下载该版本 README 内容优化

#### 1.0.0 (2025-08-30)

- 初始版本

### 权限与隐私

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络。 | 允许使用 Internet 网络。 |

#### 合规使用指南

不涉及

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.4, 5.0.5 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/9dac29f1e07e44d7b728a2e20323f712/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%8E%86%E5%8F%B2%E4%B8%8A%E7%9A%84%E4%BB%8A%E5%A4%A9%E7%BB%84%E4%BB%B6/today_history1.0.1.zip