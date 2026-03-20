# 绘画组件

## 简介

本组件支持画笔，橡皮擦，图形绘制。

## 详细介绍

### 简介

本组件支持画笔，橡皮擦，图形绘制。

### 代码结构

本组件工程代码结构如下所示：

```text
draw_board/src/main/ets                           // 画板 (har)
|- constants                                    // 模块常量定义
|- components                                   // 模块组件  
|- model                                        // 模型定义
|- utils                                        // 模块工具类
|- tools                                        // 工具类
|- viewmodel                                    // 与页面一一对应的 vm 层 
|- views                                        // 模块页面 
```

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.5(17) 及以上

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `draw_board` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 draw_board。其中 XXX 为组件存放的目录名
"modules": [
    {
    "name": "draw_board",
    "srcPath": "./XXX/draw_board",
    }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "draw_board": "file:./XXX/draw_board"
}
```

#### 引入组件

```typescript
import { DrawBoard } from 'draw_board';
```

#### 调用组件

调用组件，详细参数配置说明参见 API 参考。

```typescript
// 引入组件
import { DrawBoard } from 'draw_board';

@Entry
@ComponentV2
struct Index {
  pageInfo: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pageInfo) {
      DrawBoard({
        pageInfo: this.pageInfo,
        isHideBack:true 
      })
    }
    .hideTitleBar(true)
  }
}
```

### API 参考

#### 子组件

无

#### 接口

`DrawBoard(options?: DrawBoardOptions)`

支持绘画板常用功能

##### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | DrawBoardOptions | 否 | 画板组件的参数。 |

##### DrawBoardOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| pageInfo | NavPathStack | 否 | 传入当前组件所在路由栈 |
| isHideBack | boolean | 否 | 是否显示返回按钮 |

### 示例代码

```typescript
// 引入组件
import { DrawBoard } from 'draw_board';

@Entry
@ComponentV2
struct Index {
  pageInfo: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pageInfo) {
      DrawBoard({
        pageInfo: this.pageInfo,
        isHideBack:true 
      })
    }
    .hideTitleBar(true)
  }
}
```

### 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.1 | 2026-02-13 | 废弃 api 替换。 |
| 1.0.0 | 2025-10-31 | 初始版本 |

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1, 6.0.2 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1, 6.0.2 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/a689ad7c03d445ac81b4c7c695a3a2d1/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%BB%98%E7%94%BB%E7%BB%84%E4%BB%B6/draw_board1.0.1.zip