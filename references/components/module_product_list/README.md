# 产品列表组件

## 简介

本组件提供产品列表相关功能。

## 详细介绍

### 简介

本组件提供产品列表相关功能。

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上
- 设备类型：华为手机（直板机）
- 系统版本：HarmonyOS 5.0.0(12) 及以上

#### 权限

无

### 快速入门

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_product_list` 和 `module_base` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 module_product_list 和 module_base 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
    "name": "module_product_list",
    "srcPath": "./XXX/module_product_list",
    },
    {
    "name": "module_base",
    "srcPath": "./XXX/module_base",
    }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_product_list": "file:./XXX/module_product_list"
}
```

引入组件与产品列表组件句柄。

```typescript
import { ModuleProductList } from 'module_product_list'
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
@Entry
@ComponentV2
struct Sample {
  @Local productType: number = 1
  @Local currentIndex: number = 0

  build() {
    Column() {
      ModuleProductList({
        productType: this.productType, selectedIndex: this.currentIndex
      })
    }
    .backgroundColor('#F1F3F5')
    .padding(10)
    .width('100%')
    .height('100%')
  }
}
```

### API 参考

#### 子组件

#### 接口

`ModuleProductList(options?: ModuleProductListOptions)`

产品列表组件。

**参数：**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | ModuleProductListOptions | 否 | 配置产品列表组件的参数。 |

**ModuleProductListOptions 对象说明：**

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| productType | number | 是 | 产品类型 |
| currentIndex | number | 是 | tab 索引值 |

#### 示例代码

```typescript
import { ModuleProductList } from 'module_product_list'

@Entry
@ComponentV2
struct Sample {
 @Local productType: number = 1
 @Local currentIndex: number = 0

 build() {
   Column() {
     ModuleProductList({
       productType: this.productType, selectedIndex: this.currentIndex
     })
   }
   .backgroundColor('#F1F3F5')
   .padding(10)
   .width('100%')
   .height('100%')
 }
}
```

### 更新记录

- **1.0.1** (2025-11-25)
  - 下载该版本修改 readme。
- **1.0.0** (2025-09-15)
  - 下载该版本初始版本。

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

**隐私政策**：不涉及  
**SDK 合规使用指南**：不涉及

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/16860036b95347688dd9edd4731699f0/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E4%BA%A7%E5%93%81%E5%88%97%E8%A1%A8%E7%BB%84%E4%BB%B6/module_product_list1.0.1.zip