# 装修表单组件

## 简介

本组件提供装修表单组件。

## 详细介绍

### 简介

本组件提供装修表单组件。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（直板机）
- **HarmonyOS 版本**：HarmonyOS 5.0.4 Release 及以上

### 快速入门

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_decoration_form` 模块。

   ```json5
   // 在项目根目录 build-profile.json5 填写 module_decoration_form 路径。其中 XXX 为组件存放的目录名
   "modules": [
       {
           "name": "module_decoration_form",
           "srcPath": "./XXX/module_decoration_form",
       }
   ]
   ```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

   ```json5
   // XXX 为组件存放的目录名称
   "dependencies": {
     "module_decoration_form": "file:./XXX/module_decoration_form"
   }
   ```

#### 引入组件

```arkts
import { FormDecoration } from 'module_decoration_form';
```

### API 参考

#### FormDecoration(option: FormDecorationOptions)

##### FormDecorationOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| buttonText | string | 否 | 提交按钮文本 |
| homeType | string | 否 | 所选中房屋类型对应 value，默认值第一个选项对应的 value |
| address | string | 否 | 小区地区 |
| cellName | string | 否 | 小区名称 |
| area | string | 否 | 房屋面积 |
| homeLayout | HomeLayout | 否 | 房屋户型 |
| typeOptions | TypeOption[] | 否 | 房屋类型选项信息 |
| onFormSubmit(data: DecorationData) => void | function | 否 | 表单提交的回调事件 |

##### TypeOption 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| label | string | 是 | 房屋类型名称 |
| value | string | 是 | 房屋类型对应值 |
| desc | string | 是 | 补充说明 |

##### HomeLayout 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| room | string | 是 | 卧室数量 |
| hall | string | 是 | 客厅数量 |
| washroom | string | 是 | 卫生间数量 |
| kitchen | string | 是 | 厨房数量 |
| balcony | string | 是 | 阳台数量 |

##### DecorationData 对象说明

| 参数名 | 类型 | 说明 |
| :--- | :--- | :--- |
| homeLayout | HomeLayout | 小区户型 |
| homeType | string | 所选中房屋类型对应 value 值 |
| address | string | 小区地区 |
| cellName | string | 小区名称 |
| area | string | 房屋面积 |

### 示例代码

```arkts
import { promptAction } from '@kit.ArkUI';
import { FormDecoration } from 'module_decoration_form';

@Entry
@ComponentV2
struct Index {
  build() {
    Column() {
      FormDecoration({
        onFormSubmit: (data) => {
          console.log('填写的房屋信息为', JSON.stringify(data));
          promptAction.showToast({ message: '提交成功！' });
        },
      });
    }.backgroundColor($r('sys.color.background_secondary')).padding(16).height('100%');
  }
}
```

### 更新记录

- **1.0.1** (2025-10-31): README 内容优化。
- **1.0.0** (2025-07-02): 本组件提供装修表单组件。

### 权限与隐私

| 基本信息 | 说明 |
| :--- | :--- |
| 权限名称 | 无 |
| 权限说明 | 无 |
| 使用目的 | 无 |
| 隐私政策 | 不涉及 |
| SDK 合规 | 不涉及 |

### 兼容性

| 项目 | 支持版本 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/e8c9ec86bba2447da8a44abe28a0be90/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%A3%85%E4%BF%AE%E8%A1%A8%E5%8D%95%E7%BB%84%E4%BB%B6/module_decoration_form1.0.1.zip