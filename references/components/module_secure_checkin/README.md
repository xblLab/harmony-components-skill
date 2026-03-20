# 签到组件

## 简介

本组件提供课堂签到功能，支持根据实时位置与验证码进行签到。

## 详细介绍

### 简介

本组件提供课堂签到功能，支持根据实时位置与验证码进行签到。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（直板机）
- **HarmonyOS 版本**：HarmonyOS 5.0.3 Release 及以上

#### 权限

- **网络权限**：`ohos.permission.INTERNET`
- **位置权限**：`ohos.permission.LOCATION`
- **模糊位置权限**：`ohos.permission.APPROXIMATELY_LOCATION`

### 快速入门

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
b. 在项目根目录 `build-profile.json5` 添加 `module_secure_checkin` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_secure_checkin 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_secure_checkin",
    "srcPath": "./XXX/module_secure_checkin"
  }
]
```

```json5
// 在项目根目录 oh-package.json5 中添加依赖
"dependencies": {
  "module_secure_checkin": "file:./XXX/module_secure_checkin"
}
```

```json5
// 在程序入口模块下的 src/main/module.json5 中声明权限
"requestPermissions": [
  {
    "name": "ohos.permission.INTERNET"
  },
  {
    "name": "ohos.permission.APPROXIMATELY_LOCATION",
    "reason": "$string:permission_reason_location", // 在 string.json 中添加该字段
    "usedScene": {
      "abilities": [
        "EntryAbility"
      ],
      "when": "inuse"
    }
  },
  {
    "name": "ohos.permission.LOCATION",
    "reason": "$string:permission_reason_location", // 在 string.json 中添加该字段
    "usedScene": {
      "abilities": [
        "EntryAbility"
      ],
      "when": "inuse"
    }
  }
]
```

引入组件。

```typescript
import { goToCheckinPage, CheckinContext } from 'module_secure_checkin';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
import { CheckinContext, goToCheckinPage } from 'module_secure_checkin';

@Entry
@ComponentV2
struct Index {

  private ctx: CheckinContext = {
    courseName: '离散数学',
    courseId: 'li_san_shu_xue',
    studentId: '00001'
  };

  private navPathStack: NavPathStack = new NavPathStack()

  public build(): void {
    Navigation(this.navPathStack) {
      Column() {
        Button('课堂签到')
          .onClick(() => {
            goToCheckinPage(this.navPathStack, this.ctx);
          })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
  }
}
```

### API 参考

#### goToCheckinPage(stack: NavPathStack, ctx: CheckinContext)

前往签到页面

#### CheckinContext

承载签到页面上下文的结构体。

| 字段名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| studentId | string | 是 | 学号 |
| courseId | string | 是 | 课程编号 |
| courseName | string | 是 | 课程名称 |

### 示例代码

```typescript
import { CheckinContext, goToCheckinPage } from 'module_secure_checkin';

@Entry
@ComponentV2
struct Index {

 private ctx: CheckinContext = {
   courseName: '离散数学',
   courseId: 'li_san_shu_xue',
   studentId: '00001'
 };

 private navPathStack: NavPathStack = new NavPathStack()

 public build(): void {
   Navigation(this.navPathStack) {
     Column() {
       Button('课堂签到')
         .onClick(() => {
           goToCheckinPage(this.navPathStack, this.ctx);
         })
     }
     .width('100%')
     .height('100%')
     .justifyContent(FlexAlign.Center)
   }
   .hideTitleBar(true)
   .mode(NavigationMode.Stack)
 }
}
```

### 更新记录

#### 版本历史

| 版本 | 日期 | 备注 |
| :--- | :--- | :--- |
| 1.0.0 | 2025-11-03 | 初始版本 |

#### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |
| ohos.permission.LOCATION | 允许应用获取设备位置信息 | 允许应用获取设备位置信息 |
| ohos.permission.APPROXIMATELY_LOCATION | 允许应用获取设备模糊位置信息 | 允许应用获取设备模糊位置信息 |

#### 合规使用指南

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

#### 兼容性

| 类别 | 详细信息 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/97705f5013a742feadf8d0fcae0dcf2c/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%AD%BE%E5%88%B0%E7%BB%84%E4%BB%B6/module_secure_checkin1.0.0.zip