# BMI 组件

## 简介

本组件提供了 BMI（Body Mass Index，身体质量指数）评估功能，其中包含：BMI 值计算、BMI 范围显示、用户信息编辑（身高、体重、性别、生日等）、BMI 健康建议等功能。

## 详细介绍

### 功能简介

本组件提供了 BMI（Body Mass Index，身体质量指数）评估功能，其中包含：BMI 值计算、BMI 范围显示、用户信息编辑（身高、体重、性别、生日等）、BMI 健康建议等功能。

### 核心功能

- BMI 计算规则
- BMI 展示
- BMI 结果

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机 (直板机)
- **系统版本**：HarmonyOS 5.0.5(17) 及以上

## 快速入门

### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_bmiassess` 模块。
   
   ```json5
   // 在项目根目录 build-profile.json5 填写 module_bmiassess 路径。其中 XXX 为组件存放的目录名
   "modules": [
     {
       "name": "module_bmiassess",
       "srcPath": "./XXX/module_bmiassess",
     }
   ]
   ```

3. 在项目根目录 `oh-package.json5` 中添加依赖。
   
   ```json5
   // XXX 为组件存放的目录名称
   "dependencies": {
     "module_bmiassess": "file:./XXX/module_bmiassess"
   }
   ```

### 设置全屏模式

在 EntryAbility 的 `onWindowStageCreate` 中设置全屏模式。

```typescript
let windowClass: window.Window = windowStage.getMainWindowSync();
await windowClass.setWindowLayoutFullScreen(true);
```

### 引入组件

```typescript
import { BMIPage, EditUserInfo } from 'module_bmiassess';
```

### 调用组件

调用组件，详细参数配置说明参见 API 参考。

```typescript
BMIPage()
```

## API 参考

### 接口

#### BMIPage(options?: BMIPageOptions)

BMI 组件，提供 BMI 计算、展示等功能。

#### BMIPageOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| isLogin | boolean | 否 | 用户是否登录，默认为 false |
| stackNavPath | Stack | 是 | 路由栈，用于页面跳转 |
| navBarFontSize | number | 否 | 导航栏字体大小，默认为 16 |
| navBarLineHeight | number | 否 | 导航栏行高，默认为 22 |
| navBarColor | string | 否 | 导航栏颜色，默认为 '#4F412E' |
| sliderSelectedColor | string | 否 | 滑块选中颜色，默认为 '#8667FC' |
| rightPartBuilder | () => void | 否 | 右侧自定义构建器 |
| bgImageBuilder | () => void | 否 | 背景图片自定义构建器 |
| bmiInfo | bmiStore | 否 | 用户 bmi 信息 |

#### bmiStore 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| bmiValue | number | 是 | bmi 值 |
| physicalState | string | 是 | 健康状态 |
| healthAnalysis | string | 是 | 健康分析 |
| healthTips | string | 是 | 健康建议 |

#### UserInfo 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| weight | number | 是 | 体重（千克） |
| userheight | number | 是 | 身高（厘米） |
| gender | string | 是 | 性别 |
| birthday | string | 是 | 生日 |

### 事件

支持以下事件：

- **onClick**
  
  ```typescript
  onClick: () => void;
  ```
  点击跳转事件

- **onNeedLogin**
  
  ```typescript
  onNeedLogin: () => void;
  ```
  登录校验事件

## 示例代码

```typescript
import { BMIPage } from 'module_bmiassess';

@Entry
@ComponentV2
struct Index {
  @Consumer() stack: NavPathStack = new NavPathStack();
  @Local isLogin: boolean = true;

  @Builder
  bgImageBuilder() {
    Column().width('100%').height('100%').backgroundColor(Color.Pink)
  }

  build() {
    Navigation(this.stack) {
      Column({ space: 5 }) {
        BMIPage({
          isLogin: this?.isLogin,
          stack: this.stack,
        })
          .width('48%')
          .height(210)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#ffd6d6d7')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .padding({
        bottom: 28,
        top: 100
      })
    }
    .hideTitleBar(true)
  }
}
```

## 开源许可协议

该代码经过 Apache 2.0 授权许可。

## 更新记录

### 1.0.1 (2026-01-06)

- BMI 卡片样式优化
- [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/BMI%E7%BB%84%E4%BB%B6/module_bmiassess1.0.1.zip)

### 1.0.0 (2025-12-15)

- 初始版本
- [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/BMI%E7%BB%84%E4%BB%B6/module_bmiassess1.0.1.zip)

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/e1f04db9ff0c419da71c1294a5b9462c/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/BMI%E7%BB%84%E4%BB%B6/module_bmiassess1.0.1.zip