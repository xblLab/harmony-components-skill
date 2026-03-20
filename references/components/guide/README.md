# 考试引导组件

## 简介

本组件提供驾考信息登记导航组件，用于引导用户完成驾考报名前的信息登记流程。

## 详细介绍

### 简介

本组件提供驾考信息登记导航组件，用于引导用户完成驾考报名前的信息登记流程。

- **城市选择**：集成城市选择功能
- **驾照类型选择**：支持 5 种驾照类型选择
- **考试科目选择**：科目一至科目四选择
- **数据验证**：自动验证表单完整性
- **响应式设计**：适配不同屏幕尺寸
- **国际化支持**：内置多语言资源支持

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.1 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.1 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.1(13) 及以上

## 快速入门

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 guide 模块。

```json5
// 在项目根目录 build-profile.json5 填写 guide 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
      "name": "guide",
      "srcPath": "./XXX/guide",
    }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "@ohos_agcit/driver_license_exam_guide": "file:./XXX/guide"
}
```

引入组件。

```typescript
import { GuideView, GuideService } from '@ohos_agcit/driver_license_exam_guide'
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
import { GuideView, GuideService } from '@ohos_agcit/driver_license_exam_guide'
import { promptAction } from '@kit.ArkUI';

@Entry
@ComponentV2
struct DrivingTestPage {
   private guideService: GuideService = GuideService.instance;

   // 跳转城市选择页面
   goCitySelectPage() {
      promptAction.showToast({
         message: '需要跳转城市选择页面',
         duration: 1500,
      })
      // 选择城市后需要更新城市选择数据
      this.guideService.updateCity('北京')
   }

   // 登记引导完成回调
   onComplete() {
      promptAction.showToast({
         message: '登记引导完成',
         duration: 1500,
      })
      const data = this.guideService.getGuideData();
      console.log('引导数据', JSON.stringify(data))
   }

   build() {
      Column() {
         GuideView({
            goCitySelectPage: this.goCitySelectPage,
            completed: this.onComplete
         })
      }
      .width('100%')
      .height('100%')
   }
}
```

## API 参考

### GuideService 服务

| 方法名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| updateCity | city: string | void | 更新当前城市 |
| updateLicenseType | type: LICENSE_TYPE | void | 更新驾照类型 |
| updateDriveStage | stage: DRIVE_STAGE | void | 更新考试阶段 |
| getGuideData | - | GuideData | 获取当前数据 |
| isCompleteGuidance | - | boolean | 检查是否完成 |

## 示例代码

```typescript
import { GuideView, GuideService } from '@ohos_agcit/driver_license_exam_guide'
import { promptAction } from '@kit.ArkUI';

@Entry
@ComponentV2
struct DrivingTestPage {
  private guideService: GuideService = GuideService.instance;  
  
  // 跳转城市选择页面
  goCitySelectPage() {    
    promptAction.showToast({
      message: '需要跳转城市选择页面',
      duration: 1500,
    })
    // 选择城市后需要更新城市选择数据
    this.guideService.updateCity('北京')
  }

  // 登记引导完成回调
  onComplete() {
    promptAction.showToast({
      message: '登记引导完成',
      duration: 1500,
    })
    const data = this.guideService.getGuideData();
    console.log('引导数据', JSON.stringify(data))
  }

  build() {
    Column() {
      GuideView({
        goCitySelectPage: this.goCitySelectPage,
        completed: this.onComplete
      })
    }
    .width('100%')
    .height('100%')
  }
}
```

## 更新记录

- **1.0.3 (2025-11-07)**
  - Created with Pixso.
  - 下载该版本 README 内容修改
- **1.0.2 (2025-08-30)**
  - Created with Pixso.
  - 下载该版本 README 内容优化
- **1.0.1 (2025-07-30)**
  - Created with Pixso.
  - 下载该版本 README 优化
- **1.0.0 (2025-07-01)**
  - Created with Pixso.
  - 下载该版本

本组件提供驾考信息登记导航组件，用于引导用户完成驾考报名前的信息登记流程。

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

| 隐私政策 | SDK 合规使用指南 |
| :--- | :--- |
| 不涉及 | 不涉及 |

## 兼容性

| 类别 | 版本/值 | 备注 |
| :--- | :--- | :--- |
| HarmonyOS 版本 | 5.0.1 | Created with Pixso. |
| | 5.0.2 | Created with Pixso. |
| | 5.0.3 | Created with Pixso. |
| | 5.0.4 | Created with Pixso. |
| | 5.0.5 | Created with Pixso. |
| | 5.1.0 | Created with Pixso. |
| | 5.1.1 | Created with Pixso. |
| | 6.0.0 | Created with Pixso. |
| 应用类型 | 应用 | Created with Pixso. |
| | 元服务 | Created with Pixso. |
| 设备类型 | 手机 | Created with Pixso. |
| | 平板 | Created with Pixso. |
| | PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.1 | Created with Pixso. |
| | DevEco Studio 5.0.2 | Created with Pixso. |
| | DevEco Studio 5.0.3 | Created with Pixso. |
| | DevEco Studio 5.0.4 | Created with Pixso. |
| | DevEco Studio 5.0.5 | Created with Pixso. |
| | DevEco Studio 5.1.0 | Created with Pixso. |
| | DevEco Studio 5.1.1 | Created with Pixso. |
| | DevEco Studio 6.0.0 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/08c56f3577cc40098e79281dcb91ea6b/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%80%83%E8%AF%95%E5%BC%95%E5%AF%BC%E7%BB%84%E4%BB%B6/guide1.0.3.zip