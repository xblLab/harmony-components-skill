# 量角器组件

## 简介

本组件使用 canvas、相机绘制量角器，可自由设置量角器半径、起始角度结束角度、刻度值。

## 详细介绍

### 简介

本组件使用 canvas、相机绘制量角器，可自由设置量角器半径、起始角度结束角度、刻度值。

### 约束与限制

#### 环境

- **DevEco Studio 版本：** DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本：** HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型：** 华为手机（包括双折叠和阔折叠）
- **系统版本：** HarmonyOS 5.0.3(15) 及以上

#### 权限

- **获取相机权限：** `ohos.permission.CAMERA`

### 使用

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 protractor 模块。

```json5
// build-profile.json5
"modules": [
   {
       "name": "protractor",
       "srcPath": "./XXX/protractor",
   }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// 在项目根目录 oh-package.json5 填写 protractor 路径。其中 XXX 为组件存放的目录名
"dependencies": {
   "protractor": "file:./XXX/protractor",
} 
```

引入组件。

```typescript
import { Protractor, ProtractorController } from 'protractor'
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
@Local angle:number = 0;
@Local protractorUtil: ProtractorController = new ProtractorController({
   radius: this.radius,
   startAngle: this.startAngle,
   endAngle: this.endAngle,
   startValue: this.startValue,
   endValue: this.endValue,
   step: 10,
});

Protractor({
   protractorUtil: this.protractorUtil,
   angleChange:(angle) => {
      this.angle = angle;
   }
})
```

### API 参考

#### 子组件

无

#### 接口

`new ProtractorController(param);`

控制器初始化参数。

**param 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| radius | number | 是 | 量角器半径 (单位 vp) |
| startAngle | number | 是 | 起始角度 |
| endAngle | number | 是 | 终止角度 |
| startValue | number | 是 | 起始刻度 |
| endValue | number | 是 | 终止刻度 |
| step | number | 是 | 刻度步长值 |
| textColor | string | 否 | 刻度值颜色（例：'#00ff00'） |
| textFontSize | string | 否 | 刻度值字体大小（例：'30px'） |
| lineColor | string | 否 | 量角器颜色（例：'00ff00'） |

#### Protractor 组件属性

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| protractorController | ProtractorController | 是 | 量角器控制器对象 |
| angleChange | Function | 是 | 角度变化回调 |

### 示例代码

1. 在 `module.json5` 中配置如下权限。

```json5
"requestPermissions": [
   {
      "name": "ohos.permission.CAMERA",
      "reason": "$string:camera",
      "usedScene": {
         "abilities": [
            "EntryAbility"
         ],
         "when": "always"
      }
   }
 ]
```

2. 在使用组件的页面添加如下代码。

```typescript
import { Protractor, ProtractorController } from 'protractor'

@Entry
@ComponentV2
struct ProtractorComponent {
   @Local angle:number = 0;  // 测量角度值
   @Local radius: number = 180; // 量角器半径
   @Local startAngle: number = 180; // 起始角度
   @Local endAngle: number = 360;  // 终止角度（需要大于起始角度）
   @Local startValue: number = 0; // 起始刻度值
   @Local endValue: number = 180; // 终止刻度值
   @Local protractorController: ProtractorController = new ProtractorController({
      radius: this.radius,
      startAngle: this.startAngle,
      endAngle: this.endAngle,
      startValue: this.startValue,
      endValue: this.endValue,
      step: 10,
   });

   build() {
     Column() {
         Protractor({
            protractorController: this.protractorController,
            angleChange:(angle) => {
               this.angle = angle;
            }
         })
            .layoutWeight(1)

         Column({space:16}) {
            Row() {
               Text('半径:')
               TextInput()
                  .layoutWeight(1)
                  .onChange((value) => {
                     this.radius = Number(value);
                  })
            }
            .width('100%')
               .justifyContent(FlexAlign.Start)

            Row() {
               Text('起始角度:')
               TextInput()
                  .layoutWeight(1)
                  .onChange((value) => {
                     this.startAngle = Number(value);
                  })
               Blank()
               Text('终止角度:')
               TextInput()
                  .layoutWeight(1)
                  .onChange((value) => {
                     this.endAngle = Number(value);
                  })
            }
            .width('100%')
               .justifyContent(FlexAlign.Start)

            Row() {
               Text('起始刻度:')
               TextInput()
                  .layoutWeight(1)
                  .onChange((value) => {
                     this.startValue = Number(value);
                  })
               Blank()
               Text('终止刻度:')
               TextInput()
                  .layoutWeight(1)
                  .onChange((value) => {
                     this.endValue = Number(value);
                  })
            }
            .width('100%')
               .justifyContent(FlexAlign.Start)


            Button('更新')
               .onClick(() => {
                  this.protractorController.updateParam({
                     radius: this.radius,
                     startAngle: this.startAngle,
                     endAngle: this.endAngle,
                     startValue: this.startValue,
                     endValue: this.endValue,
                  })
                  this.protractorController.drawProtractor();
               })
         }
         .padding(16)
         Text(`测量值${String(this.angle)}`)
            .height(60)
         }.width('100%').height('100%')
   }
}
```

### 更新记录

- **1.0.1** (2025-12-19)
  - 修改 readme
  - Created with Pixso.
- **1.0.0** (2025-11-25)
  - 初始版本
  - Created with Pixso.

### 权限与隐私

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.CAMERA | 允许应用使用相机。 | 允许应用使用相机。 |

- **隐私政策：** 不涉及
- **SDK 合规使用指南：** 不涉及

### 兼容性

| 项目 | 详情 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.3 (Created with Pixso.) |
| | 5.0.4 (Created with Pixso.) |
| | 5.0.5 (Created with Pixso.) |
| | 5.1.0 (Created with Pixso.) |
| | 5.1.1 (Created with Pixso.) |
| | 6.0.0 (Created with Pixso.) |
| **应用类型** | 应用 (Created with Pixso.) |
| | 元服务 (Created with Pixso.) |
| **设备类型** | 手机 (Created with Pixso.) |
| | 平板 (Created with Pixso.) |
| | PC (Created with Pixso.) |
| **DevEcoStudio 版本** | DevEco Studio 5.0.3 (Created with Pixso.) |
| | DevEco Studio 5.0.4 (Created with Pixso.) |
| | DevEco Studio 5.0.5 (Created with Pixso.) |
| | DevEco Studio 5.1.0 (Created with Pixso.) |
| | DevEco Studio 5.1.1 (Created with Pixso.) |
| | DevEco Studio 6.0.0 (Created with Pixso.) |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/e6197ee042534b429739ee16f51f76c6/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%87%8F%E8%A7%92%E5%99%A8%E7%BB%84%E4%BB%B6/protractor1.0.1.zip