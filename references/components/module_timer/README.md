# 运动计时面板组件

## 简介

本组件提供了倒计时展示功能，选择时分秒后，即可控制其开始、停止、暂停倒计时，返回倒计时进度。

## 详细介绍

### 简介

本组件提供了倒计时展示功能，选择时分秒后，即可控制其开始、停止、暂停倒计时，返回倒计时进度。

### 界面示意

开始计时 | 倒计时中 | 停止倒计时

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机 (直板机)
- **系统版本**：HarmonyOS 5.0.5(17) 及以上

### 快速入门

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_timer` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_timer 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_timer",
    "srcPath": "./XXX/module_timer"
  }
]
```

3. 在项目根目录 `oh-package.json5` 添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_timer": "file:./XXX/module_timer"
}
```

#### 引入组件

```arkts
import { timeMainPage, executionStatus } from "module_timer";
```

#### 调用组件

详细参数配置说明参见 API 参考。

```arkts
timeMainPage()
```

## API 参考

### 接口

`timeMainPage(options?: TimeOptions )`

#### TimeOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| isRunningChange(status: executionStatus) => void | Function | 否 | status: 接收计时组件返回的执行状态 |
| onProgressChange(progress: number) => void | Function | 否 | progress：返回当前倒计时进度 |

#### executionStatus 对象说明

| 枚举值 | 值 | 说明 |
| :--- | :--- | :--- |
| Start | 0 | 开始 |
| Pause | 1 | 暂停 |
| over | 2 | 结束 |

### 示例代码

```arkts
import { executionStatus, TimeMainPage } from 'module_timer'

@Entry
@ComponentV2
struct Index {
  pageInfo: NavPathStack = new NavPathStack()
  @Provider('isRunning') isRunning: executionStatus = executionStatus.over

  build() {
    Navigation(this.pageInfo) {
      TimeMainPage({
        isRunningChange: (status: executionStatus) => {
          this.isRunning = status
        },
        onProgressChange: (progress: number) => {
        }
      })
      Row() {
        Text('开始')
          .onClick(() => {
            this.isRunning = executionStatus.Start
          })
          .backgroundColor(Color.Green)
          .flexGrow(1)  // 均匀占据空间
          .textAlign(TextAlign.Center)  // 文字水平居中
          .height('100%')

        Text('暂停')
          .onClick(() => {
            this.isRunning = executionStatus.Pause
          })
          .backgroundColor(Color.Yellow)
          .flexGrow(1)
          .textAlign(TextAlign.Center)
          .height('100%')

        Text('结束')
          .onClick(() => {
            this.isRunning = executionStatus.over
          })
          .backgroundColor(Color.Red)
          .flexGrow(1)
          .textAlign(TextAlign.Center)
          .height('100%')
      }
      .width('100%')
      .height(100)
      .justifyContent(FlexAlign.SpaceEvenly)  // 均匀分布
      .alignItems(VerticalAlign.Center)  // 垂直居中
    }.hideTitleBar(true)
  }
}
```

## 开源许可协议

该代码经过 Apache 2.0 授权许可。

## 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.0 | 2025-12-15 | 初始版本 |

## 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

## 基本信息

| 项目 | 内容 |
| :--- | :--- |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 内容 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.5 |
| 应用类型 | 应用，元服务 |
| 设备类型 | 手机，平板，PC |
| DevEco Studio 版本 | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/3903ea73999047cf8a46056fe5323c54/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%BF%90%E5%8A%A8%E8%AE%A1%E6%97%B6%E9%9D%A2%E6%9D%BF%E7%BB%84%E4%BB%B6/module_timer1.0.0.zip