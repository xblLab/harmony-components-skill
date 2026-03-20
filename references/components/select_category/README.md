# 多级分栏组件

## 简介

本组件提供了二级三级分类的能力，开发者可以根据实际业务需要快速实现二三级分类。

## 详细介绍

### 简介

本组件提供了二级三级分类的能力，开发者可以根据实际业务需要快速实现二三级分类。

### 组件概览

- 二级分类组件
- 三级分类组件

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（直板机）
- **系统版本**：HarmonyOS 5.0.1(13) 及以上

### 快速入门

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `select_category` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 select_category 路径。其中 XXX 为组件存放的目录名。
"modules": [
  {
    "name": "select_category",
    "srcPath": "./XXX/select_category",
  }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
   "select_category": "file:./XXX/select_category"
}
```

引入组件句柄。

```typescript
import { SelectCategory, ThirdCategory, SecondParam, ThirdParam, ThirdItemModel, ItemDetail } from 'select_category';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
import { SelectCategory, ThirdCategory, SecondParam, ThirdParam, ThirdItemModel, ItemDetail } from 'select_category';

@Entry
@ComponentV2 struct Index{
   @Local secondParamObj?: SecondParam //示例数据
   @Local thirdParamObj?: ThirdParam //示例数据

   aboutToAppear(): void {
    this.secondParamObj = new SecondParam(['建筑工程', '建造造价', '建造师'], {
      'id': '111', 'title': '建造师', 'list': [
        {
          'id': '1111', 'title': '一级建造师', 'list': [
          { 'id': '11111', 'title': '建筑工程经济' }, { 'id': '11112', 'title': '建筑工程政治' },
          { 'id': '11113', 'title': '建筑工程教育' }, { 'id': '11114', 'title': '建筑工程科学' },
          { 'id': '11115', 'title': '建筑工程管理' }, { 'id': '11116', 'title': '建筑工程统筹' }]
        }
        , {
        'id': '1112', 'title': '二级建造师', 'list': [
          { 'id': '11121', 'title': '二级建筑工程经济' }, { 'id': '11122', 'title': '二级建筑工程政治' },
          { 'id': '11123', 'title': '二级建筑工程教育' },
          { 'id': '11124', 'title': '二级建筑工程科学' }, { 'id': '11125', 'title': '二级建筑工程管理' },
          { 'id': '11126', 'title': '二级建筑工程统筹' }]
      }]
    })


    this.thirdParamObj = new ThirdParam(['建筑工程', '建造造价', '建造师', '二级建造师'],
      { 'id': '1112', 'title': '二级建造师', 'list': [
        { 'id': '11121', 'title': '二级建筑工程经济' },
        { 'id': '11122', 'title': '二级建筑工程政治' },
        { 'id': '11123', 'title': '二级建筑工程教育' },
        { 'id': '11124', 'title': '二级建筑工程科学' },
        { 'id': '11125', 'title': '二级建筑工程管理' },
        { 'id': '11126', 'title': '二级建筑工程统筹' }] })


   }
   
build(){
   Column(){
      // 二级分类组件
      SelectCategory({
         secondParamObj: this.secondParamObj,
         currentColor: '#4B5CC4',
         contentIcon: $r('app.media.icon_right'),  //todo 需要图片资源
         goPage: (val:string) => {
            // 点击的标题名称
            console.log(val)
         },
         goThird: (val:ThirdItemModel) => {
            // 跳转三级分类传递的数据
            console.log(JSON.stringify(val))
         }
      }).height('50%')

      // 三级分类组件
      ThirdCategory({
         thirdParamObj: this.thirdParamObj,
         currentColor: '#4B5CC4',
         contentIcon: $r('app.media.icon_right'),  //todo 需要图片资源
         goPage: (val:string) => {
            // 点击的标题名称
            console.log(val)
         },
         // 返回最后选择的对象 包含标题/ID
         goBack: (val:ItemDetail) => {
            console.log(JSON.stringify(val))
         }
      }).height('50%')
   }
   .width('100%')
   .height('100%')
}
}
```

## API 参考

### 接口

#### SelectCategory(options: CategoryOptions)

二级分类组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | CategoryOptions | - | 多级分栏组件相关参数 |

**CategoryOptions 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| secondParamObj | SecondParam | - | 一级传递二级分类的数据。 |
| contentIcon | ResourceStr | 否 | 应用图标，参考 UX 设计规范 |
| currentColor | ResourceStr | 否 | 左侧栏选中背景色 |

**事件**

支持以下事件：

- **goPage**
  ```typescript
  goPage: (x: string) => void = (x: string) => {};
  ```
  点击的标题名称。

- **goThird**
  ```typescript
  goThird: (x: ThirdItemModel) => void = (x: ThirdItemModel) => {};
  ```
  跳转三级列表页传递数据。

#### ThirdCategory({thirdParamObj: ThirdParam, contentIcon: ResourceStr, currentColor: ResourceStr})

三级分类组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| thirdParamObj | ThirdParam | - | 二级传递三级分类的数据。 |
| contentIcon | ResourceStr | 否 | 应用图标，参考 UX 设计规范 |
| currentColor | ResourceStr | 否 | 左侧栏选中背景色 |

**SecondParam 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| secondItem | SecondItemModel | - | 是跳转二级分类，传递的数据对象 |
| list | string[] | 是 | 顶部分类显示列表 |

**ThirdParam 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| thirdItem | ThirdItemModel | - | 是跳转三级分类，传递的数据对象 |
| list | string[] | 是 | 顶部分类显示列表 |

**SecondItemModel 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | - | 是二级分类对象的 ID |
| title | string | - | 是标题 |
| list | ThirdItemModel[] | - | 是二级分类对象下包含的列表 |

**ThirdItemModel 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | - | 是三级分类对象的 ID |
| title | string | - | 是标题 |
| list | ItemDetail[] | - | 是三级分类对象下包含的列表 |

**ItemDetail 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | - | 是最后选择的返回对象 ID |
| title | string | - | 是标题 |

**事件**

支持以下事件：

- **goPage**
  ```typescript
  goPage: (x: string) => void = (x: string) => {};
  ```
  点击的标题名称。

- **goBack**
  ```typescript
  goBack: (x: ItemDetail) => void = (x: ItemDetail) => {};
  ```
  返回最后点击的对象：包含标题/ID。

## 示例代码

```typescript
import { SelectCategory, ThirdCategory, SecondParam, ThirdParam, ThirdItemModel, ItemDetail } from 'select_category';

@Entry
@ComponentV2 struct Index{
  @Local secondParamObj?: SecondParam //示例数据
  @Local thirdParamObj?: ThirdParam //示例数据
  
     aboutToAppear(): void {
      this.secondParamObj = new SecondParam(['建筑工程', '建造造价', '建造师'], {
        'id': '111', 'title': '建造师', 'list': [
          {
            'id': '1111', 'title': '一级建造师', 'list': [
            { 'id': '11111', 'title': '建筑工程经济' }, { 'id': '11112', 'title': '建筑工程政治' },
            { 'id': '11113', 'title': '建筑工程教育' }, { 'id': '11114', 'title': '建筑工程科学' },
            { 'id': '11115', 'title': '建筑工程管理' }, { 'id': '11116', 'title': '建筑工程统筹' }]
          }
          , {
          'id': '1112', 'title': '二级建造师', 'list': [
            { 'id': '11121', 'title': '二级建筑工程经济' }, { 'id': '11122', 'title': '二级建筑工程政治' },
            { 'id': '11123', 'title': '二级建筑工程教育' },
            { 'id': '11124', 'title': '二级建筑工程科学' }, { 'id': '11125', 'title': '二级建筑工程管理' },
            { 'id': '11126', 'title': '二级建筑工程统筹' }]
        }]
      })


   this.thirdParamObj = new ThirdParam(['建筑工程', '建造造价', '建造师', '二级建造师'],
     { 'id': '1112', 'title': '二级建造师', 'list': [
       { 'id': '11121', 'title': '二级建筑工程经济' },
       { 'id': '11122', 'title': '二级建筑工程政治' },
       { 'id': '11123', 'title': '二级建筑工程教育' },
       { 'id': '11124', 'title': '二级建筑工程科学' },
       { 'id': '11125', 'title': '二级建筑工程管理' },
       { 'id': '11126', 'title': '二级建筑工程统筹' }] })


 }
  build(){
     Column(){
        // 二级分类组件
        SelectCategory({
           secondParamObj: this.secondParamObj,
           currentColor: '#4B5CC4',
           contentIcon: $r('app.media.icon_right'),  //todo 需要图片资源
           goPage: (val:string) => {
              // 点击的标题名称
              console.log(val)
           },
           goThird: (val:ThirdItemModel) => {
              // 跳转三级分类传递的数据
              console.log(JSON.stringify(val))
           }
        }).height('50%')

        // 三级分类组件
        ThirdCategory({
           thirdParamObj: this.thirdParamObj,
           currentColor: '#4B5CC4',
           contentIcon: $r('app.media.icon_right'),  //todo 需要图片资源
           goPage: (val:string) => {
              // 点击的标题名称
              console.log(val)
           },
           // 返回最后选择的对象 包含标题/ID
           goBack: (val:ItemDetail) => {
              console.log(JSON.stringify(val))
           }
        }).height('50%')
     }
     .width('100%')
     .height('100%')
  }
}
```

## 更新记录

- **1.0.2 (2025-10-31)**
  - 下载该版本调整 readme 说明
- **1.0.1 (2025-08-29)**
  - 页面布局细节微调
- **1.0.0 (2025-07-02)**
  - 下载该版本本组件提供了二级三级分类的能力，开发者可以根据实际业务需要快速实现二三级分类。

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

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/3ee241829ecd4fc8b687d17d8fca0795/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%A4%9A%E7%BA%A7%E5%88%86%E6%A0%8F%E7%BB%84%E4%BB%B6/select_category1.0.2.zip