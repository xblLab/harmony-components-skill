# formula hybrid 三方公式混合计算组件

## 简介

formula 主要目的是显示用 LaTeX 编写的数学公式。

## 详细介绍

### 简介

formula 主要目的是显示用 LaTeX 编写的数学公式。

### 特性

解析生成数学公式数据

### 软件架构

#### 源码目录

深色代码主题复制
```text
├─ har
├─ libs
└─ src
   └─ main
      ├─ cangjie
      ├─ ets
      └─ resources
```

har har 包目录
libs so 目录
src main cangjie 仓颉源码目录
src main ets ets 源码目录
src main resources 资源目录

### 接口说明

#### 主要类和函数接口说明

深色代码主题复制
```typescript
/*
* 通过文本参数生成数学公式图片数组数据
*
* 参数 - latexMathTextString 数学公式文本内容
* 参数 - latexMathTextSize 数学公式文字大小 - 单位 px
* 参数 - latexMathTextColor 数学公式文字颜色
* 参数 - latexMathBackGroupColor 数学公式背景颜色
* 参数 - latexMathColorFormat 数学公式图片格式
*
* 返回值 - Promise<ArrayBuffer> 图片数组数据
*/
latexStringToImage(latexMathTextString: string, latexMathTextSize: number, latexMathTextColor: number, latexMathBackGroupColor: number, latexMathColorFormat: LatexMathColorFormat): Promise<ArrayBuffer>

/**
 * 图片格式枚举
 */
enum LatexMathColorFormat {
  COLOR_FORMAT_RGB_565, // RGB_565
  COLOR_FORMAT_BGRA_8888 // BGRA_8888
}
```

### 使用说明

#### ohpm 安装使用

深色代码主题复制
```bash
ohpm install @cangjie-tpc/formula_hybrid
```

### 功能示例

#### 解析数学公式

深色代码主题复制
```typescript
import { LatexMathColorFormat, latexStringToImage } from '@cangjie-tpc/formula_hybrid';
import { image } from '@kit.ImageKit';

@Entry
@Component
struct Index0 {
  str: string = "(a \\pm b)^2 = a^2 \\pm 2ab + b^2"
  @State pixelMap: image.PixelMap = undefined!;
  @State imageWidth: number = 0;
  @State imageHeight: number = 0;

  async aboutToAppear(): Promise<void> {
    try {
      // 通过接口解析数学公式获取数学公式图片数组数据
      let buf: ArrayBuffer = await latexStringToImage(this.str, fp2px(20), 0xFF000000, 0xFFFFFFFF,
        LatexMathColorFormat.COLOR_FORMAT_BGRA_8888)
      let imageSource = image.createImageSource(buf)
      // 图片 pixelMap
      this.pixelMap = imageSource.createPixelMapSync()
      let size: Size = this.pixelMap.getImageInfoSync().size
      // 图片宽度
      this.imageWidth = px2vp(size.width)
      // 图片高度
      this.imageHeight = px2vp(size.height)
    } catch (e) {
    }
  }

  build() {
    Scroll() {
      Column() {
        Image(this.pixelMap)
          .objectFit(ImageFit.Contain)
          .width(this.imageWidth)
          .height(this.imageHeight)
          .margin({ top: 5, bottom: 5 })
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
    }
    .height('100%')
    .scrollBar(BarState.Off)
    .backgroundColor(Color.White)
  }
}
```

执行结果如下

### 约束与限制

在下述版本验证通过：         IDE: DevEco Studio 5.1.1 Release(Build Version:5.1.1.851)

resPath 默认参数"/data/storage/el1/bundle/entry/resources/resfile/res"，如果修改 entry 命名，需要改成对应的"/data/storage/el1/bundle/xxxx/resources/resfile/res"。

### 开源协议

本项目基于 MIT License，请自由的享受和参与开源。

### 参与贡献

欢迎给我们提交 PR，欢迎给我们提交 Issue，欢迎参与任何形式的贡献。

### 更新记录

v1.2.7

适配升级 5.1.1.851

v1.2.6

文档修改用例添加

v1.2.5

修复数学公式闪退问题

v1.2.4

修复数学公式特殊符号闪退问题

v1.2.3

修复数学公式闪退问题

v1.2.2

修复化学公式中&导致闪退

v1.2.1

修复设置透明背景色时背景色为黑色的问题
增加 resPath 入参，默认"/data/storage/el1/bundle/entry/resources/resfile/res"

v1.2.0

@cangjie-tpc/formula 修改成 @cangjie-tpc/formula_hybrid

v1.1.7

修复 V 数学公式显示不全
修复部分错误数学公式闪退
兼容 5.0 和 5.1deveco

v1.1.6

修复异常数学公式返回空数组

v1.1.5

适配升级 5.1.1.821

v1.0.0

解析生成数学公式数据

### 权限与隐私

基本信息 权限名称  权限说明  使用目的 暂无暂无暂无隐私政策不涉及 SDK 合规使用指南 不涉及 兼容性 HarmonyOS 版本  5.1.1 
	
			Created with Pixso.
	
	
		
			
		
	
	
		
		
		
		
		
		
		
		
	

 应用类型  应用 
	
			Created with Pixso.
	
	
		
			
		
	
	
		
		
		
		
		
		
		
		
	

 元服务 
	
			Created with Pixso.
	
	
		
			
		
	
	
		
		
		
		
		
		
		
		
		
	

 设备类型  手机 
	
			Created with Pixso.
	
	
		
			
		
	
	
		
		
		
		
		
		
		
		
	

 平板 
	
			Created with Pixso.
	
	
		
			
		
	
	
		
		
		
		
		
		
		
		
		
	

 PC 
	
			Created with Pixso.
	
	
		
			
		
	
	
		
		
		
		
		
		
		
		
		
	

 DevEcoStudio 版本  DevEco Studio 5.1.1 
	
			Created with Pixso.

## 安装方式

```bash
ohpm install @cangjie-tpc/formula_hybrid
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/f3c26e6821234c689220e8d494740f5d/PLATFORM?origin=template