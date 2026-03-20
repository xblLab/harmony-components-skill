# 城市限行组件

## 简介

本组件提供了城市限行组件，当前尾号限行数据均为 mock 数据，实际开发请填充业务真实数据。

## 详细介绍

### 简介

本组件提供了城市限行组件，当前尾号限行数据均为 mock 数据，实际开发请填充业务真实数据。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

#### 权限

- **获取位置权限**：`ohos.permission.APPROXIMATELY_LOCATION`，`ohos.permission.LOCATION`。
- **网络权限**：`ohos.permission.INTERNET`

## 快速入门

安装组件。
如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `traffic_restriction` 模块。
   深色代码主题复制 // 在项目根目录 build-profile.json5 填写 traffic_restriction 路径。其中 XXX 为组件存放的目录名
   ```json5
   "modules": [
       {
           "name": "traffic_restriction",
           "srcPath": "./XXX/traffic_restriction",
       }
   ]
   ```
3. 在项目根目录 `oh-package.json5` 中添加依赖。
   深色代码主题复制 // XXX 为组件存放的目录名称
   ```json5
   "dependencies": {
     "traffic_restriction": "file:./XXX/traffic_restriction"
   }
   ```

引入组件。
```typescript
import { TrafficRestriction } from 'traffic_restriction';
```

调用组件，详细参数配置说明参见 API 参考。
```typescript
import { TrafficRestriction } from 'traffic_restriction';

@Entry
@Component
struct Index {
  build() {
    Column() {
      TrafficRestriction()
    }
  }
}
```

## API 参考

### 子组件

无

### 接口

`TrafficRestriction(options?: TrafficRestrictionOptions)`

城市限行组件。

**参数：**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | TrafficRestrictionOptions | 否 | 城市限行组件。 |

**TrafficRestrictionOptions 对象说明：**

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| selectDate | Date | 否 | 当前日期 |

### 示例代码

#### 示例 1

本示例通过 `selectDate` 实现不同日期的限行查询。

```typescript
import { TrafficRestriction } from 'traffic_restriction';

@Entry
@Component
struct Index {
  build() {
    Column() {
      TrafficRestriction({
         selectDate: new Date('2025-6-18')
      })
    }
  }
}
```

## 更新记录

| 版本 | 日期 | 描述 | 操作 |
| :--- | :--- | :--- | :--- |
| 1.0.2 | 2025-10-31 | Created with Pixso. | 下载该版本 README 优化 |
| 1.0.1 | 2025-08-29 | Created with Pixso. | 下载该版本 README 内容优化 |
| 1.0.0 | 2025-07-21 | Created with Pixso. | 下载该版本初始版本 |

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.APPROXIMATELY_LOCATION | 允许应用获取设备模糊位置信息 | 允许应用获取设备模糊位置信息 |
| ohos.permission.LOCATION | 允许应用获取设备位置信息 | 允许应用获取设备位置信息 |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

### 合规使用指南

不涉及

### 隐私政策

不涉及

## 兼容性

| 项目 | 值 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.4<br>5.0.5 |
| **应用类型** | 应用<br>元服务 |
| **设备类型** | 手机<br>平板<br>PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.4<br>DevEco Studio 5.0.5<br>DevEco Studio 5.1.0<br>DevEco Studio 5.1.1<br>DevEco Studio 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/8b6b4a95269a4568a43d86395cc0b2c4/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%9F%8E%E5%B8%82%E9%99%90%E8%A1%8C%E7%BB%84%E4%BB%B6/traffic_restriction1.0.2.zip