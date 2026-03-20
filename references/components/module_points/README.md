# 自助积分组件

## 简介

本组件支持扫码/拍照积分、管理积分记录。

## 详细介绍

### 简介

本组件支持扫码/拍照积分、管理积分记录。

自助积分 > 我的积分 -- 自助积分 > 我的积分 -- 消费记录

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

### 快速入门

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_points` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_points 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_points",
    "srcPath": "./XXX/module_points"
  }
]
```

3. 在项目根目录 `oh-package.json5` 添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_points": "file:./XXX/module_points"
}
```

引入组件。

```arkts
import { RouterMap } from 'module_points';
```

调用组件，详细参数配置说明参见 API 参考。

设置窗口为全屏模式

```arkts
// xxx/entryability/EntryAbility.ets
onWindowStageCreate(windowStage: window.WindowStage): void {
  // 获取应用主窗口
  let windowClass: window.Window = windowStage.getMainWindowSync(); 
  // 设置窗口全屏
  windowClass.setWindowLayoutFullScreen(true);
}
```

### API 参考

#### 接口

由于本组件以页面的方式注册并对外提供，不涉及 UI 组件接口介绍。

#### GlobalPointUtils

自助积分对外方法。

##### constructor

```arkts
constructor()
```

GlobalPointUtils 的构造函数。

##### consumePoint

```arkts
consumePoint(point: number): void
```

消费积分。

##### checkIn

```arkts
checkIn(): void
```

签到。

#### RouterMap 枚举说明

路由表枚举

| 名称 | 说明 |
| :--- | :--- |
| SELF_SERVICE_POINT_PAGE | 自助积分页面 |
| SELF_POINT_RECORD_PAGE | 积分记录页面 |
| SELF_POINT_RULE | 积分规则页面 |
| SELF_POINT_GUIDE | 积分指南页面 |

### 示例代码

```arkts
import { RouterMap } from 'module_points';

@Entry
@ComponentV2
struct Sample1 {
  stack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.stack) {
      Column({ space: 10 }) {
        Text('自助积分').fontSize(20).fontWeight(FontWeight.Bold)
        Button('跳转').width('100%').onClick(() => {
          this.stack.pushPath({
            name: RouterMap.SELF_SERVICE_POINT_PAGE,
          })
        })
      }
      .padding({
        left: 10,
        right: 10,
        top: 40,
      })
    }
    .hideTitleBar(true)
  }
}
```

### 更新记录

#### 1.0.2 (2026-01-06)

- 下载该版本
- 废弃 API 整改。
- Created with Pixso.

#### 1.0.1 (2025-10-31)

- 下载该版本
- 优化 README
- Created with Pixso.

#### 1.0.0 (2025-08-30)

- 下载该版本
- 本组件支持扫码/拍照积分、管理积分记录。
- Created with Pixso.

### 权限与隐私

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

#### SDK 合规使用指南

不涉及

#### 兼容性

| 类别 | 版本/类型 | 备注 |
| :--- | :--- | :--- |
| HarmonyOS 版本 | 5.0.0 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.1 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.2 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.3 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.4 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.5 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.0 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.1 | Created with Pixso. |
| HarmonyOS 版本 | 6.0.0 | Created with Pixso. |
| 应用类型 | 应用 | Created with Pixso. |
| 应用类型 | 元服务 | Created with Pixso. |
| 设备类型 | 手机 | Created with Pixso. |
| 设备类型 | 平板 | Created with Pixso. |
| 设备类型 | PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.1 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.2 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.4 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.0 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.1 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.0 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/86342696e8404293bc0e9451e7bb4235/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%87%AA%E5%8A%A9%E7%A7%AF%E5%88%86%E7%BB%84%E4%BB%B6/module_points1.0.2.zip