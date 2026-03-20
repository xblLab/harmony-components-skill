# 上传菜谱组件

## 简介

本组件提供了上传菜谱的相关功能，上传的图片目前保存在沙箱，如需上传至服务器需要自行实现。

## 详细介绍

### 简介

本组件提供了上传菜谱的相关功能，上传的图片目前保存在沙箱，如需上传至服务器需要自行实现。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

#### 权限

无

### 使用

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 并添加 `base_ui` 和 `upload_recipe` 模块。

```json5
// 在项目根目录的 build-profile.json5 填写 base_ui 和 upload_recipe 路径。其中 xxx 为组件存在的目录名
"modules": [
  {
    "name": "base_ui",
    "srcPath": "./xxx/base_ui",
  },
  {
    "name": "upload_recipe",
    "srcPath": "./xxx/upload_recipe",
  }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// xxx 为组件存放的目录名称
"dependencies": {
  "upload_recipe": "file:./xxx/upload_recipe"
}
```

引入组件。

```typescript
import { UploadRecipe } from 'upload_recipe';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
UploadRecipe({
  uploadRecipe: (data: UploadRecipeData) => {
    // 调用上传菜谱接口
  },
})
```

### API 参考

#### 接口

`UploadRecipe(options?: UploadRecipeOptions)`
上传菜谱组件。

#### UploadRecipeData 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| title | string | 否 | 菜谱标题 |
| mainImg | string | 否 | 菜谱缩略图 |
| description | string | 否 | 菜谱描述 |
| ingredients | RecipeIngredient | 否 | 用料列表 |
| steps | Step | 否 | 步骤列表 |

#### RecipeIngredient 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| name | string | 是 | 用料名称 |
| quantity | string | 是 | 用料数量 |
| unit | string | 是 | 用料单位 |

#### Step 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| description | string | 是 | 步骤描述 |
| stepImg | string | 是 | 步骤图 |

#### 事件

支持以下事件：

- **uploadRecipe**
  `uploadRecipe(callback: (data: UploadRecipeData) => void)`
  调用上传菜谱接口

#### 示例代码

```typescript
import { promptAction } from '@kit.ArkUI';
import { UploadRecipe, UploadRecipeData } from 'upload_recipe';

@Entry
@ComponentV2
struct Index {
   build() {
      RelativeContainer() {
         UploadRecipe({
            uploadRecipe: (data: UploadRecipeData) => {
               promptAction.showToast({ message: '上传成功' })
            },
         })
      }
      .height('100%')
      .width('100%')
      .padding({ top: 45 })
   }
}
```

## 更新记录

| 版本 | 日期 | 描述 | 备注 |
| :--- | :--- | :--- | :--- |
| 1.0.4 | 2026-01-14 | 废弃 api 修改 | Created with Pixso. 下载该版本 |
| 1.0.3 | 2025-11-07 | 更新修改 readme 内容 | Created with Pixso. 下载该版本 |
| 1.0.2 | 2025-10-31 | 更新 readme 内容 | Created with Pixso. 下载该版本 |
| 1.0.1 | 2025-08-29 | 优化目录结构 | Created with Pixso. 下载该版本 |
| 1.0.0 | 2025-07-10 | 本组件提供了上传菜谱的相关功能，上传的图片目前保存在沙箱，如需上传至服务器需要自行实现。 | Created with Pixso. 下载该版本 |

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

### 兼容性

| 类别 | 详情 | 备注 |
| :--- | :--- | :--- |
| HarmonyOS 版本 | 5.0.4 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.5 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.0 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.1 | Created with Pixso. |
| HarmonyOS 版本 | 6.0.0 | Created with Pixso. |
| HarmonyOS 版本 | 6.0.1 | Created with Pixso. |
| 应用类型 | 应用 | Created with Pixso. |
| 应用类型 | 元服务 | Created with Pixso. |
| 设备类型 | 手机 | Created with Pixso. |
| 设备类型 | 平板 | Created with Pixso. |
| 设备类型 | PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.4 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.0 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.1 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.0 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.1 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/9609e6f22c0a483ab39e506ed99353d6/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E4%B8%8A%E4%BC%A0%E8%8F%9C%E8%B0%B1%E7%BB%84%E4%BB%B6/upload_recipe1.0.4.zip