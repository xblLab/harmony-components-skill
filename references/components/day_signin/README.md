# 福利签到组件

## 简介

本组件提供了福利页面的打卡功能，其中打卡获取金币数据均为 mock 数据，实际开发中可以做借鉴使用。

## 详细介绍

### 简介

本组件提供了福利页面的打卡功能，其中打卡获取金币数据均为 mock 数据，实际开发中可以做借鉴使用。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、平板
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

#### 权限

无

#### 使用

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `day_signin` 模块。
   ```json5
   // 在项目根目录 build-profile.json5 填写 day_signin 路径。其中 XXX 为组件存放的目录名
   "modules": [
       {
           "name": "day_signin",
           "srcPath": "./XXX/day_signin",
       }
   ]
   ```
3. 在项目根目录 `oh-package.json5` 中添加依赖。
   ```json5
   // XXX 为组件存放的目录名称
   "dependencies": {
       "day_signin": "file:./XXX/day_signin"
   }
   ```

引入组件。
```typescript
import { DaySignIn } from 'day_signin';
```

调用组件，详细参数配置说明参见 API 参考。
```typescript
import { DaySignIn } from 'day_signin'

@Entry
@ComponentV2
struct Index {
  build() {
    Column() {
      DaySignIn({
             title : "天天看好剧",
             coinArray : [50,90,30,23,33,44,55,30,23,33,44,55]
      })
    }
  }
}
```

### API 参考

#### 子组件

无

#### 接口

`DaySignIn(options?: DaySignInOptions)`

福利签到组件

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | DaySignInOptions | 否 | 福利签到组件 |

**DaySignInOptions 对象说明：**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| title | ResourceStr | 否 | 活动名称 |
| coinArray | number[] | 否 | 活动周期每日获取金币数 |
| onSignSuccess(day: number, balance: number)=>void | Function | 否 | 定义回调函数，day 为签到天数，balance 为金币奖励 |

#### 示例代码

```typescript
import { DaySignIn } from 'day_signin'
   
@Entry
@ComponentV2
struct Index {
  bonus: number = 0
  
  build() {
    Column() {
      DaySignIn({
             title: "天天看好剧",
             coinArray: [50, 90, 30, 23, 33, 44, 55, 30, 23, 33, 44, 55],
             onSignSuccess: (day: number, balance: number) => this.bonus += balance
           })
    }
  }
}
```

### 更新记录

- **1.0.1 (2026-01-21)**
  - 下载该版本
  - 更改了背景颜色和圆角
- **1.0.0 (2025-11-03)**
  - 下载该版本
  - 初始版本

### 权限与隐私

- **基本信息**
  - 权限名称：无
  - 权限说明：无
  - 使用目的：无
- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

### 兼容性

- **HarmonyOS 版本**
  - 5.0.0
  - 5.0.1
  - 5.0.2
  - 5.0.3
  - 5.0.4
  - 5.0.5
  - 5.1.0
  - 5.1.1
  - 6.0.0
  - 6.0.1
- **应用类型**
  - 应用
  - 元服务
- **设备类型**
  - 手机
  - 平板
  - PC
- **DevEco Studio 版本**
  - DevEco Studio 5.0.0
  - DevEco Studio 5.0.1
  - DevEco Studio 5.0.2
  - DevEco Studio 5.0.3
  - DevEco Studio 5.0.4
  - DevEco Studio 5.0.5
  - DevEco Studio 5.1.0
  - DevEco Studio 5.1.1
  - DevEco Studio 6.0.0
  - DevEco Studio 6.0.1

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/98ab97f72e974b31b95e58998210b22b/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%A6%8F%E5%88%A9%E7%AD%BE%E5%88%B0%E7%BB%84%E4%BB%B6/day_signin1.0.1.zip