# 直尺组件

## 简介

本组件使用 canvas 绘制刻度尺，以厘米为单位进行真实长度的测量。

## 详细介绍

### 简介

本组件使用 canvas 绘制刻度尺，以厘米为单位进行真实长度的测量。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.3(15) 及以上

#### 权限

无

#### 使用

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。

如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 build-profile.json5 添加 ruler 模块。

深色代码主题复制
```json5
// build-profile.json5
"modules": [
   {
     "name": "ruler",
     "srcPath": "./XXX/ruler",
   }
]
```

c. 在项目根目录 oh-package.json5 中添加依赖。

深色代码主题复制
```json5
// 在项目根目录 oh-package.json5 填写 ruler 路径。其中 XXX 为组件存放的目录名
"dependencies": {
   "ruler": "file:./XXX/ruler",
} 
```

引入组件。

深色代码主题复制
```typescript
import { RulerController, Ruler, CrossPointer } from 'ruler'
```

调用组件，详细参数配置说明参见 API 参考。

深色代码主题复制
```typescript
private canvasContext:CanvasRenderingContext2D = new CanvasRenderingContext2D();
crossPointer:CrossPointer = {
   pointerX: 20,
   pointerY: 20,
}
private  rulerController:RulerController = new RulerController(
   this.canvasContext,
   {
      crossPointer:this.crossPointer,
      extraScaleLength: 10,
      lineColor:'#000000'
   }
)    

Ruler({
   canvasContext: this.canvasContext,
   rulerController: this.rulerController,
   onReady:() => {
      this.rulerController.setRulerPointers(
         [
            [0, this.crossPointer.pointerY, this.canvasContext.width, this.crossPointer.pointerY],
            [this.crossPointer.pointerX, 0, this.crossPointer.pointerX, this.canvasContext.height]
         ]
      );
      this.rulerController.drawRuler();
   }
})
```

## API 参考

### 子组件

无

### 接口

`new RulerController(this.canvasContext，param);`

控制器初始化参数。

参数：

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| canvasContext | CanvasRenderingContext2D | 是 | canvas 实例 |
| param | RulerProperty | 是 | 刻度尺属性 |

#### RulerProperty 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| lineWidth | number | 否 | 线宽 |
| lineColor | string | 否 | 线颜色 |
| fontSize | string | 否 | 字体大小 |
| fontColor | string | 否 | 字体颜色 |
| resultFontColor | string | 否 | 测量结果字体颜色 |
| extraScaleLength | number | 否 | 长刻度线比短刻度线多出的长度 |
| crossPointer | CrossPointer | 是 | 横向和纵向刻度尺的交点（0 刻度位置） |

#### CrossPointer 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| pointerX | number | 是 | 横向和纵向刻度尺的交点 X 坐标 |
| pointerY | number | 是 | 横向和纵向刻度尺的交点 Y 坐标 |

#### Ruler 组件属性

| 属性名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| canvasContext | CanvasRenderingContext2D | 是 | canvas 实例 |
| rulerController | RulerController | 是 | 控制器 |
| onReady | Function | 是 | canvas ready 回调函数 |

## 示例代码

深色代码主题复制
```typescript
import { RulerController, Ruler, CrossPointer } from 'ruler'

@Entry
@ComponentV2
struct RulerComponent {
   private canvasContext:CanvasRenderingContext2D = new CanvasRenderingContext2D();
   crossPointer:CrossPointer = {
      pointerX: 20,
      pointerY: 20,
   }
   private  rulerController:RulerController = new RulerController(
      this.canvasContext,
      {
         crossPointer:this.crossPointer,
         extraScaleLength: 10,
         lineColor:'#000000'
      }
   )

   build() {
      Column() {
         Ruler({
            canvasContext: this.canvasContext,
            rulerController: this.rulerController,
            onReady:() => {
               this.rulerController.setRulerPointers(
                  [
                     [0, this.crossPointer.pointerY, this.canvasContext.width, this.crossPointer.pointerY],
                     [this.crossPointer.pointerX, 0, this.crossPointer.pointerX, this.canvasContext.height]
                  ]
               );
               this.rulerController.drawRuler();
            }
         })
      }
      .width('100%')
      .height('100%')
   }
}
```

## 更新记录

- **1.0.1 (2025-12-19)**
  - Created with Pixso.
  - 下载该版本 readme 修改
- **1.0.0 (2025-11-25)**
  - Created with Pixso.
  - 下载该版本
- **初始版本**
  - Created with Pixso.

## 权限与隐私

### 基本信息

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 无 |
| 权限说明 | 无 |
| 使用目的 | 无 |

### 隐私政策

- 不涉及

### SDK 合规使用指南

- 不涉及

### 兼容性

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

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/58f2f2ea4bb34786ad767b7b2e0b5afb/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%9B%B4%E5%B0%BA%E7%BB%84%E4%BB%B6/ruler1.0.1.zip