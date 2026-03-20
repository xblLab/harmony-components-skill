# 文件管理组件

## 简介

本组件提供了文件上传，重命名，删除和文件预览功能。

## 详细介绍

**简介**
本组件提供了文件上传，重命名，删除和文件预览功能。

文件上传设置文件预览

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.1 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.1(13) Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.1 及以上

### 快速入门

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。

如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `file_management` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 file_management 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
      "name": "file_management",
      "srcPath": "./XXX/file_management",
    }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "file_management": "file:./XXX/file_management"
}
```

引入组件。

```typescript
import { DocumentType, FileManagement, FileDataSource, ResumeEntity } from 'file_management';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
import { DocumentType, FileManagement, FileDataSource, ResumeEntity } from 'file_management';

@Entry
@ComponentV2
struct Index {
  @Local resumeData: FileDataSource<ResumeEntity> = new FileDataSource();

  build() {
    Column(){
      FileManagement({
        resumeData: this.resumeData,
        buttonText: '上传文件',
        documentTypeArray:[DocumentType.PDF, DocumentType.TXT, DocumentType.DOCX, DocumentType.PPTX, DocumentType.XLSX]
      })
    }
    .backgroundColor('#F1F3F5')
      .width('100%')
      .height('100%')
  }
}
```

文件上传设置文件预览

## API 参考

### 子组件

无

### 接口

`FileManagement(options: FileManagementOptions)`

文件管理组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | FileManagementOptions | 否 | 上传文件的参数。 |

**FileManagementOptions 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| resumeData | FileDataSource<ResumeEntity> | 否 | 文件集合 |
| buttonText | string | 是 | 页面按钮文字 |
| documentTypeArray | Array<DocumentType> | 是 | 文件类型枚举 |
| limitCount | number | 否 | 限制文件上传数量 |

**ResumeEntity 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| name | string | 是 | 文件名称 |
| suffix | string | 是 | 文件后缀 |
| uri | string | 是 | 文件沙箱路径 |
| size | string | 是 | 文件大小 (以 KB 为单位) |
| updateTime | string | 是 | 文件修改时间 |

**DocumentType 对象说明**

| 名称 | 说明 |
| :--- | :--- |
| PDF | PDF 文件 |
| TXT | TXT 文件 |
| DOC | DOC 文件 |
| DOCX | DOCX 文件 |
| XLS | XLS 文件 |
| XLSX | XLSX 文件 |
| PPT | PPT 文件 |
| PPTX | PPTX 文件 |

## 示例代码

### 示例 1（未限制文件上传数量）

```typescript
import { DocumentType, FileManagement, FileDataSource, ResumeEntity } from 'file_management';

@Entry
@ComponentV2
struct Index {
  @Local resumeData: FileDataSource<ResumeEntity> = new FileDataSource();

  build() {
    Column() {
      FileManagement({
        resumeData: this.resumeData,
        buttonText: '上传文件',
        documentTypeArray:[DocumentType.PDF, DocumentType.TXT, DocumentType.DOCX, DocumentType.PPTX, DocumentType.XLSX],
      })
    }
    .backgroundColor('#F1F3F5')
      .width('100%')
      .height('100%');
  }
}
```

文件上传设置文件预览

### 示例 2（限制文件上传数量）

```typescript
import { DocumentType, FileManagement, FileDataSource, ResumeEntity } from 'file_management';

@Entry
@ComponentV2
struct Index {
  @Local resumeData: FileDataSource<ResumeEntity> = new FileDataSource();

  build() {
    Column() {
      FileManagement({
        resumeData: this.resumeData,
        buttonText: '上传文件',
        documentTypeArray:[DocumentType.PDF, DocumentType.TXT, DocumentType.DOCX, DocumentType.PPTX, DocumentType.XLSX],
        limitCount: 3
      })
    }
    .backgroundColor('#F1F3F5')
      .width('100%')
      .height('100%');
  }
}
```

文件上传显示限制上传文件限制文件吐司

## 更新记录

- **1.0.1 (2025-11-03)**
  - 下载该版本
  - 修复了 readme
  - Created with Pixso.
- **1.0.0 (2025-08-30)**
  - 下载该版本
  - 初始版本
  - Created with Pixso.

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
| DevEco Studio 5.0.1 | Created with Pixso. |
| DevEco Studio 5.0.2 | Created with Pixso. |
| DevEco Studio 5.0.3 | Created with Pixso. |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/2c2064ed3c5646bbb6841a2b6ee36707/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%96%87%E4%BB%B6%E7%AE%A1%E7%90%86%E7%BB%84%E4%BB%B6/file_management1.0.1.zip