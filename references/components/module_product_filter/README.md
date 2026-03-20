# 商品筛选组件

## 简介

本组件提供了根据筛选条件对商品进行筛选的功能。

## 详细介绍

### 简介

本组件提供了根据筛选条件对商品进行筛选的功能。

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.1 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.1 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 5.0.1(13) 及以上

#### 权限

无

### 使用

#### 安装组件

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `module_ui_base` 和 `module_product_filter` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_ui_base 和 module_product_filter 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_ui_base",
    "srcPath": "./XXX/module_ui_base"
  },
  {
    "name": "module_product_filter",
    "srcPath": "./XXX/module_product_filter"
  }
]
```

```json5
// 在项目根目录 oh-package.json5 中添加依赖
"dependencies": {
  "module_product_filter": "file:./XXX/module_product_filter"
}
```

#### 引入组件

```typescript
import { ProductFilter } from 'module_product_filter';
```

#### 调用组件

调用组件，详细参数配置说明参见 API 参考。

### API 参考

#### ProductFilter 工具说明

| 名称 | 描述 |
| :--- | :--- |
| `show(options?: ProductFilterOptions)` | 控制商品筛选器打开的事件 |
| `hide()` | 控制商品筛选器关闭的事件 |

#### ProductFilterOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| `filterTypeList` | `FilterTypeInterface[]` | 否 | 过滤类型列表，默认为 `[]` |
| `initFilter` | `FilterSelectionItem[]` | 否 | 初始化时选中的过滤项，默认为 `[]` |
| `handleConfirm(res: FilterSelectionItem[]) => void` | `Function` | 否 | 确认过滤结果时的回调函数，默认为 `[]` |

#### FilterTypeInterface 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| `id` | `string` | 是 | 过滤类型的唯一标识符 |
| `label` | `string` | 是 | 过滤类型显示的标签 |
| `options` | `FilterOptionItem[]` | 是 | 过滤类型对应的选项列表 |

#### FilterOptionItem 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| `key` | `string` | 是 | 选项的唯一标识 |
| `label` | `string` | 是 | 选项显示的文本 |

#### FilterSelectionItem 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| `id` | `string` | 是 | 选中的过滤类型标识 |
| `value` | `string` | 是 | 选中的过滤值 |

### 示例代码

```typescript
import { FilterSelectionItem, ProductFilter } from 'module_product_filter';

@Entry
@ComponentV2
struct ProductFilterDemo {
  @Local filterList: FilterSelectionItem[] = []

  build() {
    Column({ space: 16 }) {
      Button('筛选')
        .onClick(() => {
          ProductFilter.show({
            initFilter: this.filterList,
            handleConfirm: (res) => {
              this.filterList = res
            },
          })
        })
      Text('选择结果:')
      ForEach(this.filterList, (item: FilterSelectionItem) => {
        Text(item.id + '-' + item.value).margin({ right: 16 })
      })
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}
```

### 更新记录

- **1.0.1** (2026-01-13) - 下载该版本
- **1.0.0** (2025-11-24) - 废弃 API 整改 - 下载该版本
- **初始版本** - 下载该版本

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

| 隐私政策 | SDK 合规使用指南 |
| :--- | :--- |
| 不涉及 | 不涉及 |

### 兼容性

| 项目 | 支持情况 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c68c4f5267b841779509ec054454f9aa/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%95%86%E5%93%81%E7%AD%9B%E9%80%89%E7%BB%84%E4%BB%B6/module_product_filter1.0.1.zip