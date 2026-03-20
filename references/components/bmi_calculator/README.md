# BMI 计算器组件

## 简介

本组件提供了 BMI 的计算和记录功能。

## 详细介绍

### 简介

本组件提供了 BMI 的计算和记录功能。

本组件工程代码结构如下所示：

深色代码主题复制
```bash
bmi_calculator/src/main/ets                    // BMI 计算器 (har)
  |- common                                       // 模块常量   
  |- components                                   // 模块组件
  |- pages                                        // 页面
  |- viewmodel                                    // 与页面一一对应的 vm 层
```

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.5 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.5 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- HarmonyOS 版本：HarmonyOS 5.0.5(17) 及以上

#### 权限

无

### 使用

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。

如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `bmi_calculator` 模块。

深色代码主题复制
```json5
"modules": [
   {
   "name": "bmi_calculator",
   "srcPath": "./xxx/bmi_calculator",
   },
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖

深色代码主题复制
```json5
"dependencies": {
   "bmi_calculator": "file:./xxx/bmi_calculator",
}
```

### 示例代码

深色代码主题复制
```arkts
@Entry
@ComponentV2
export struct Index {
   @Local pageStack: NavPathStack = new NavPathStack();

   build() {
      Navigation(this.pageStack) {
         Button('跳转').onClick(() => {
            // BmiHome 为 BMI 计算器路由入口页面名称
            this.pageStack.pushPathByName('BmiHome', null);
         });
      }.hideTitleBar(true);
   }
}
```

## 更新记录

### 1.0.0 (2025-11-03)

Created with Pixso.

下载该版本初始版本权限与隐私基本信息 权限名称  权限说明  使用目的 无无无

Created with Pixso.

隐私政策不涉及

Created with Pixso.

SDK 合规使用指南  不涉及

Created with Pixso.

兼容性 HarmonyOS 版本  5.0.5 

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

DevEcoStudio 版本  DevEco Studio 5.0.5 

Created with Pixso.

DevEco Studio 5.1.0 

Created with Pixso.

DevEco Studio 5.1.1 

Created with Pixso.

DevEco Studio 6.0.0 

Created with Pixso.

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/8635688dc5134ce2943127f957501087/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/BMI%E8%AE%A1%E7%AE%97%E5%99%A8%E7%BB%84%E4%BB%B6/bmi_calculator1.0.0.zip