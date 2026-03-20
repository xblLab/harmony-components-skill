# 敲木鱼组件

## 简介

本组件提供了敲木鱼的功能。

## 详细介绍

### 简介

本组件提供了敲木鱼的功能。

### 工程代码结构

本组件工程代码结构如下所示：

```text
深色代码主题复制decompression_tool/src/main/ets                   // 敲木鱼 (har)
  |- common                                       // 模块常量定义   
  |- model                                        // 模型定义  
  |- pages                                        // 页面
  |- utils                                        // 模块工具类
  |- viewmodel                                    // 与页面一一对应的 vm 层 
```

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.5(17) 及以上

#### 权限

无

### 使用

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。

如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。
2. 在项目根目录 `build-profile.json5` 添加 decompression_tool 模块。

```json5
深色代码主题复制"modules": [
   {
   "name": "decompression_tool",
   "srcPath": "./xxx/decompression_tool",
   },
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖

```json5
深色代码主题复制"dependencies": {
   "decompression_tool": "file:./xxx/decompression_tool",
}
```

### 示例代码

```typescript
深色代码主题复制@Entry
@ComponentV2
export struct Index {
   @Local pageStack: NavPathStack = new NavPathStack();

   build() {
      Navigation(this.pageStack) {
         Button('跳转').onClick(() => {
            // DecompressionToolPage 为敲木鱼路由入口页面名称
            this.pageStack.pushPathByName('DecompressionToolPage', null);
         });
      }.hideTitleBar(true);
   }
}
```

## 更新记录

- **1.0.2 (2026-01-13)**
	
	Created with Pixso.
	
	
		
			
		
	
	
		
	下载该版本接入 @hw-agconnect/util-log 组件

- **1.0.1 (2025-12-29)**
	
	Created with Pixso.
	
	
		
			
		
	
	
		
	下载该版本更新已经废弃的 API

- **1.0.0 (2025-11-03)**
	
	Created with Pixso.
	
	
		
			
		
	
	
		
	下载该版本初始版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

### HarmonyOS 版本

- 5.0.5 
	
			Created with Pixso.
	
- 5.1.0 
	
			Created with Pixso.
	
- 5.1.1 
	
			Created with Pixso.
	
- 6.0.0 
	
			Created with Pixso.
	
- 6.0.1 
	
			Created with Pixso.

### 应用类型

- 应用 
	
			Created with Pixso.
	
- 元服务 
	
			Created with Pixso.

### 设备类型

- 手机 
	
			Created with Pixso.
	
- 平板 
	
			Created with Pixso.
	
- PC 
	
			Created with Pixso.

### DevEcoStudio 版本

- DevEco Studio 5.0.5 
	
			Created with Pixso.
	
- DevEco Studio 5.1.0 
	
			Created with Pixso.
	
- DevEco Studio 5.1.1 
	
			Created with Pixso.
	
- DevEco Studio 6.0.0 
	
			Created with Pixso.
	
- DevEco Studio 6.0.1 
	
			Created with Pixso.

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/716d5c31a3ec4356902b6cc75003e69b/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%95%B2%E6%9C%A8%E9%B1%BC%E7%BB%84%E4%BB%B6/decompression_tool1.0.2.zip