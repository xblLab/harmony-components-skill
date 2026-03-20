# 分栏基础组件

## 简介

本组件提供了一级通用分类的能力，引入一二三级嵌套所有数据。开发者可以根据实际业务需要快速实现一级分类。

## 详细介绍

### 简介

本组件提供了一级通用分类的能力，引入一二三级嵌套所有数据。开发者可以根据实际业务需要快速实现一级分类。

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.3 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.3 Release SDK 及以上
- 设备类型：华为手机（直板机）
- 系统版本：HarmonyOS 5.0.1(13) 及以上

### 快速入门

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `base_select` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 base_select 路径。其中 XXX 为组件存放的目录名。
"modules": [
  {
    "name": "base_select",
    "srcPath": "./XXX/base_select",
  }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
   "base_select": "file:./XXX/base_select"
}
```

引入组件句柄。

```typescript
import { BaseSelect, SelectItemModel, SecondParam } from 'base_select';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
import { BaseSelect, SelectItemModel, SecondParam } from 'base_select';

@Entry
@ComponentV2
struct Index {
  @Local baseSelectModel: SelectItemModel[] = [] //示例数据

  aboutToAppear(): void {
    this.baseSelectModel = [
      // 第一条全数据
      {
        'id': '1', 'title': '建筑工程', 'list': [{
          'id': '11', 'title': '建造造价', 'list': [{
            'id': '111', 'title': '建造师', 'list': [
              {
                'id': '1111', 'title': '一级建造师', 'list': [
                  { 'id': '11111', 'title': '建筑工程经济' },
                  { 'id': '11112', 'title': '建筑工程政治' },
                  { 'id': '11113', 'title': '建筑工程教育' },
                  { 'id': '11114', 'title': '建筑工程科学' },
                  { 'id': '11115', 'title': '建筑工程管理' },
                  { 'id': '11116', 'title': '建筑工程统筹' }]
              },
              {
                'id': '112', 'title': '二级建造师', 'list': [
                  { 'id': '11121', 'title': '二级建筑工程经济' },
                  { 'id': '11122', 'title': '二级建筑工程政治' },
                  { 'id': '11123', 'title': '二级建筑工程教育' },
                  { 'id': '11124', 'title': '二级建筑工程科学' },
                  { 'id': '11125', 'title': '二级建筑工程管理' },
                  { 'id': '11126', 'title': '二级建筑工程统筹' }]
              }]
          }]
        }]
      },
      {
        'id': '2', 'title': '考公考编', 'list': [{
          'id': '22', 'title': '考公', 'list': [{
            'id': '222', 'title': '公务员', 'list': []
          }]
        }]
      },
      {
        'id': '3', 'title': '职业资格', 'list': [{
          'id': '33', 'title': '在编', 'list': [{
            'id': '333', 'title': '在编人员', 'list': []
          }]
        }]
      },
    ]
  }

  build() {
    Column() {
      // 一级分类组件使用
      BaseSelect({
        // 一级分类传入的总数据
        modelList: this.baseSelectModel,
        //  左侧选中 tab 索引
        selectIndex: (val: number) => {
          console.log('选中的索引--', `${val}`)
        },
        goSecond: (val: SecondParam) => {
          //跳转到二级分类的数据
          console.log(JSON.stringify(val))
        },
        // 选中 tab 背景色
        selectLeftBgc: $r('sys.color.background_primary'),
        // 默认 tab 背景色
        defaultLeftBgc: $r('sys.color.comp_background_gray'),
        // 右侧展示内容的 icon
        contentIcon: $r('app.media.icon_right')  //todo 需要图片资源
      })
    }
    .width('100%')
    .height('100%')
  }
}
```

## API 参考

### 接口

**BaseSelect(options: BaseSelectOptions)**

一级分类组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | BaseSelectOptions | - | 是分栏基础组件相关参数 |

#### BaseSelectOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| modelList | SelectItemModel[] | 是 | 一级分类下嵌套的所有数据，若只需要一级可修改类型到一级即可。 |
| contentIcon | ResourceStr | 否 | 应用图标，参考 UX 设计规范 |
| selectLeftBgc | ResourceStr | 否 | 左侧栏选中背景色 |
| defaultLeftBgc | ResourceStr | 否 | 左侧栏默认背景色 |

#### SelectItemModel 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 一级分类对象的 ID |
| title | string | 是 | 标题 |
| list | ContentItemModel[] | 是 | 一级分类下包含的列表 |

#### ContentItemModel 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 一级分类下包含的列表子对象的 ID |
| title | string | 是 | 标题 |
| list | SecondItemModel[] | 是 | 一级分类下包含的列表子对象的列表 |

#### SecondItemModel 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 二级分类对象的 ID |
| title | string | 是 | 标题 |
| list | ThirdItemModel[] | 是 | 二级分类对象下包含的列表 |

#### ThirdItemModel 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 三级分类对象的 ID |
| title | string | 是 | 标题 |
| list | ItemDetail[] | 是 | 三级分类对象下包含的列表 |

#### ItemDetail 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 最后选择的返回对象 ID |
| title | string | 是 | 标题 |

### 事件

支持以下事件：

- **selectIndex**
  - 签名：`selectIndex: (x: number) => void = (x: number) => {};`
  - 描述：抛出左侧栏选中索引。
- **goSecond**
  - 签名：`goSecond: (x: SecondParam) => void = (x: SecondParam) => {};`
  - 描述：跳转到二级分类的数据。

## 示例代码

```typescript
import { BaseSelect, SelectItemModel, SecondParam } from 'base_select';

@Entry
@ComponentV2
struct Index {
 @Local baseSelectModel: SelectItemModel[] = [] //示例数据

 aboutToAppear(): void {
   this.baseSelectModel = [
     // 第一条全数据
     {
       'id': '1', 'title': '建筑工程', 'list': [{
         'id': '11', 'title': '建造造价', 'list': [{
           'id': '111', 'title': '建造师', 'list': [
             {
               'id': '1111', 'title': '一级建造师', 'list': [
                 { 'id': '11111', 'title': '建筑工程经济' },
                 { 'id': '11112', 'title': '建筑工程政治' },
                 { 'id': '11113', 'title': '建筑工程教育' },
                 { 'id': '11114', 'title': '建筑工程科学' },
                 { 'id': '11115', 'title': '建筑工程管理' },
                 { 'id': '11116', 'title': '建筑工程统筹' }]
             },
             {
               'id': '112', 'title': '二级建造师', 'list': [
                 { 'id': '11121', 'title': '二级建筑工程经济' },
                 { 'id': '11122', 'title': '二级建筑工程政治' },
                 { 'id': '11123', 'title': '二级建筑工程教育' },
                 { 'id': '11124', 'title': '二级建筑工程科学' },
                 { 'id': '11125', 'title': '二级建筑工程管理' },
                 { 'id': '11126', 'title': '二级建筑工程统筹' }]
             }]
         }]
       }]
     },
     {
       'id': '2', 'title': '考公考编', 'list': [{
         'id': '22', 'title': '考公', 'list': [{
           'id': '222', 'title': '公务员', 'list': []
         }]
       }]
     },
     {
       'id': '3', 'title': '职业资格', 'list': [{
         'id': '33', 'title': '在编', 'list': [{
           'id': '333', 'title': '在编人员', 'list': []
         }]
       }]
     },
   ]
 }

 build() {
   Column() {
     // 一级分类组件使用
     BaseSelect({
       // 一级分类传入的总数据
       modelList: this.baseSelectModel,
       //  左侧选中 tab 索引
       selectIndex: (val: number) => {
         console.log('选中的索引--', `${val}`)
       },
       goSecond: (val: SecondParam) => {
         //跳转到二级分类的数据
         console.log(JSON.stringify(val))
       },
       // 选中 tab 背景色
       selectLeftBgc: $r('sys.color.background_primary'),
       // 默认 tab 背景色
       defaultLeftBgc: $r('sys.color.comp_background_gray'),
       // 右侧展示内容的 icon
       contentIcon: $r('app.media.icon_right')  //todo 需要图片资源
     })
   }
   .width('100%')
   .height('100%')
 }
}
```

## 更新记录

- **1.0.2 (2025-10-31)**
  - Created with Pixso.
  - 下载该版本调整 readme 说明
- **1.0.1 (2025-08-29)**
  - Created with Pixso.
  - 下载该版本 - 页面布局细节微调
- **1.0.0 (2025-07-02)**
  - Created with Pixso.
  - 下载该版本

本组件提供了一级通用分类的能力，引入一二三级嵌套所有数据。开发者可以根据实际业务需要快速实现一级分类。

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

| 版本 | 备注 |
| :--- | :--- |
| 5.0.1 | Created with Pixso. |
| 5.0.2 | Created with Pixso. |
| 5.0.3 | Created with Pixso. |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |

### 应用类型

| 类型 | 备注 |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

### 设备类型

| 类型 | 备注 |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

### DevEcoStudio 版本

| 版本 | 备注 |
| :--- | :--- |
| DevEco Studio 5.0.3 | Created with Pixso. |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/75b57f4bacd741cfbdfc13025526e8e3/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%88%86%E6%A0%8F%E5%9F%BA%E7%A1%80%E7%BB%84%E4%BB%B6/base_select1.0.2.zip