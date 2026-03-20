# 地址搜索联想补全组件

## 简介

本组件提供了搜索词条的地址联想、自动补全功能，展示对应的真实地址列表。自定义点击事件、并实现搜索记录的持久化存储。同时还可以设置默认文本展示与结果搜索。

## 详细介绍

### 简介

本组件提供了搜索词条的地址联想、自动补全功能，展示对应的真实地址列表。自定义点击事件、并实现搜索记录的持久化存储。同时还可以设置默认文本展示与结果搜索。

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- HarmonyOS 版本：HarmonyOS 5.0.0 Release 及以上

### 使用

安装组件。

1. 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
2. 如果是从生态市场下载组件，请参考以下步骤安装组件。
   - a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
   - b. 在项目根目录 `build-profile.json5` 添加 `module_address_search` 模块。
     ```json5
     // 项目根目录下 build-profile.json5 填写 module_address_search 路径。其中 XXX 为组件存放的目录名
     "modules": [
       {
         "name": "module_address_search",
         "srcPath": "./XXX/module_address_search"
       }
     ]
     ```
   - c. 在项目根目录 `oh-package.json5` 中添加依赖。
     ```json5
     // XXX 为组件存放的目录名
     "dependencies": {
       "module_address_search": "file:./XXX/module_address_search"
     }
     ```

引入组件句柄。

```typescript
import { AddressSearch } from 'module_address_search';
```

开始地址搜索。详细入参配置说明参见 API 参考。

```typescript
AddressSearch({click: (address) => {}})
```

### API 参考

#### 子组件

无

#### 接口

`AddressSearch(options?: AddressSearchOptions)`

地址搜索组件。

**参数：**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | AddressSearchOptions | 否 | 配置地址搜索组件的参数。 |

#### AddressSearchOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| textInit | string | 否 | 初始搜索 |
| click(address: IAddressInfo) => void | Function | 否 | 点击回调事件 |

#### IAddressInfo

搜索地址结果类型。

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| siteId | string | 是 | ID |
| name | string | 是 | 简称 |
| addr | string | 是 | 全称 |
| location | mapCommon.LatLng | 是 | 经纬度 |

### 示例代码

本示例通过 AddressSearch 实现地址搜索的自动联想补全与点击回调。

```typescript
import { AddressSearch } from 'module_address_search';

@Entry
@ComponentV2
struct Index {
  build() {
    Column() {
      AddressSearch({
        textInit: '金证南京科技园',
        click: (address) => {
          AlertDialog.show({ alignment: DialogAlignment.Center, message: JSON.stringify(address, null, 2) })
        },
      })
    }
    .padding(16)
    .backgroundColor('#F1F3F5')
    .width('100%')
    .height('100%')
  }
}
```

### 更新记录

- **1.0.1 (2025-11-25)**
  - 下载该版本调整 readme 内容
- **1.0.0 (2025-11-03)**
  - 下载该版本初始版本

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 兼容性

| 类别 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/bdabed179aae46cabd0ee0b5d53b3cd6/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%9C%B0%E5%9D%80%E6%90%9C%E7%B4%A2%E8%81%94%E6%83%B3%E8%A1%A5%E5%85%A8%E7%BB%84%E4%BB%B6/module_address_search1.0.1.zip