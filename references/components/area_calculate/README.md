# 面积测量组件

## 简介

本组件提供了绘制多边形，通过设置某一条边的长度可以计算多边形的面积的功能。

## 详细介绍

### 简介

本组件提供了绘制多边形，通过设置某一条边的长度可以计算多边形的面积的功能。

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.3 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.3 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 5.0.3(15) 及以上

#### 权限

无

### 使用

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。

如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `area_calculate` 模块。

```json5
// build-profile.json5
"modules": [
   {
        "name": "area_calculate",
        "srcPath": "./XXX/area_calculate",
   }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// 在项目根目录 oh-package.json5 填写 area_calculate 路径。其中 XXX 为组件存放的目录名
"dependencies": {
   "area_calculate": "file:./XXX/area_calculate"
} 
```

引入组件。

```typescript
import { AreaCalculateController, AreaCalculate } from 'area_calculate'
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
private canvasContext:CanvasRenderingContext2D = new CanvasRenderingContext2D();
// 点击多边形的边回调，后调后需要写入边长 markLength;
borderClick = () => {
   ...
}
private  areaCalculateController:AreaCalculateController = new AreaCalculateController(this.canvasContext, this.borderClick)

build() {
   AreaCalculate({
      canvasContext: this.canvasContext,
      areaCalculateUtil: this.areaCalculateController
   })
}
```

## API 参考

### 子组件

无

### 接口

`new AreaCalculateController(this.canvasContext, this.borderClick)`

### 控制器初始化传参

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| canvasContext | CanvasRenderingContext2D | 是 | canvas 对象 |
| borderClickCallBack | Function | 是 | 点击多边形边长的回调 |

### 属性

**AreaCalculateController 属性：**

| 属性名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| fontSize | string | 否 | 标注字体大小 |
| fontColor | string | 否 | 标注字体颜色 |
| lineWidth | number | 否 | 线宽 |
| lineColor | string | 否 | 边颜色 |
| pointRadius | number | 否 | 顶点半径 |
| pointColor | string | 否 | 顶点颜色 |
| currentPointX | number | 否 | 点击 X 坐标 |
| currentPointY | number | 否 | 点击 Y 坐标 |
| originPointX | number | 否 | 第一个点 X 坐标 |
| originPointY | number | 否 | 第一个点 Y 坐标 |
| referenceLength | number | 否 | 根据两点坐标算的基准边的长度 |
| markLength | number | 否 | 实际标注基准边的长度 |
| unit | string | 否 | 标注单位 |

## 示例代码

```typescript
import { AreaCalculateController, AreaCalculate } from 'area_calculate'

@Entry
@ComponentV2
struct CalculateComponent {
   private canvasContext:CanvasRenderingContext2D = new CanvasRenderingContext2D();
   @Local area: number = 0;
   @Local markLength: number = 0;
   @Local unit: string = 'mm';
   @Local dialogIds:number[] = [];
   // 点击多边形的边回调，后调后需要写入边长 markLength;
   borderClick = () => {
      this.getUIContext().getPromptAction().openCustomDialog({
         builder:() => {
            this.setMark();
         }
      }).then((dialogId: number) => {
         this.dialogIds.push(dialogId); // 保存 dialogId
      })
   }
   private  areaCalculateController:AreaCalculateController = new AreaCalculateController(this.canvasContext, this.borderClick)

   setMarkLength() {
      this.areaCalculateController.markLength = this.markLength;
      this.areaCalculateController.unit = this.unit;
      this.areaCalculateController.setLabels();
   }

   closeDialog() {
      const targetIds = this.dialogIds.pop();
      this.getUIContext().getPromptAction().closeCustomDialog(targetIds)
   }

   @Builder
   setMark() {
      Column({space:12}) {
         Row() {
            Text('长度：')
               .margin({
                  right:10
               })
            TextInput()
               .layoutWeight(1)
               .onChange((value) => {
                  this.markLength = Number(value);
               })
         }
         .width('100%')
         Row() {
            Text('单位：')
               .margin({
                  right:10
               })
            TextInput()
               .layoutWeight(1)
               .onChange((value) => {
                  this.unit = value;
               })
         }
         .width('100%')
         Row() {
            Button('取消')
               .width(100)
               .margin({
                  right:10
               })
               .onClick(() => {
                  this.closeDialog()
               })
            Button('确定')
               .width(100)
               .onClick(() => {
                  this.setMarkLength();
                  this.closeDialog()
               })
         }
         .width('100%')
            .justifyContent(FlexAlign.Center)
      }
      .padding(20)
   }

   build() {
      Column() {
         AreaCalculate({
            canvasContext: this.canvasContext,
            areaCalculateUtil: this.areaCalculateController
         })
            .layoutWeight(1)

         Text(`面积：${this.area}`)
         Row() {
            Button('重置')
               .width(100)
               .onClick(() => {
                  this.areaCalculateController.reset()
               })

            Button('计算面积')
               .width(100)
               .onClick(() => {
                 if (this.markLength === 0 || this.markLength === undefined) {
                   this.getUIContext().getPromptAction().showToast({
                     duration: 1500,
                     message: '请单击某一条边并填写该边的真实长度'
                   })
                 } else {
                   this.area = this.areaCalculateController.calculatePolygonArea();
                 }
               })
         }
         .justifyContent(FlexAlign.SpaceEvenly)
            .width('100%')
            .height(100)
      }
      .width('100%')
         .height('100%')
   }
}
```

## 更新记录

- **1.0.1** (2025-12-19)
  - Created with Pixso.
  - 下载该版本 readme 修改
- **1.0.0** (2025-11-25)
  - Created with Pixso.
  - 下载该版本

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

- 隐私政策：不涉及
- SDK 合规使用指南：不涉及

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.3 (Created with Pixso.) |
| HarmonyOS 版本 | 5.0.4 (Created with Pixso.) |
| HarmonyOS 版本 | 5.0.5 (Created with Pixso.) |
| HarmonyOS 版本 | 5.1.0 (Created with Pixso.) |
| HarmonyOS 版本 | 5.1.1 (Created with Pixso.) |
| HarmonyOS 版本 | 6.0.0 (Created with Pixso.) |
| 应用类型 | 应用 (Created with Pixso.) |
| 应用类型 | 元服务 (Created with Pixso.) |
| 设备类型 | 手机 (Created with Pixso.) |
| 设备类型 | 平板 (Created with Pixso.) |
| 设备类型 | PC (Created with Pixso.) |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 (Created with Pixso.) |
| DevEco Studio 版本 | DevEco Studio 5.0.4 (Created with Pixso.) |
| DevEco Studio 版本 | DevEco Studio 5.0.5 (Created with Pixso.) |
| DevEco Studio 版本 | DevEco Studio 5.1.0 (Created with Pixso.) |
| DevEco Studio 版本 | DevEco Studio 5.1.1 (Created with Pixso.) |
| DevEco Studio 版本 | DevEco Studio 6.0.0 (Created with Pixso.) |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/7c19ff222c4b4d5b8463bb37e6f63f09/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%9D%A2%E7%A7%AF%E6%B5%8B%E9%87%8F%E7%BB%84%E4%BB%B6/area_calculate1.0.1.zip