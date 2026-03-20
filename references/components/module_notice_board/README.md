# 消息轮播组件

## 简介

本组件提供消息轮播相关功能。

## 详细介绍

### 简介

本组件提供消息轮播相关功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（直板机）
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

#### 权限

无

### 快速入门

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `module_notice_board` 和 `module_base` 模块。

深色代码主题复制
```json5
// 在项目根目录 build-profile.json5 填写 module_notice_board 和 module_base 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
    "name": "module_notice_board",
    "srcPath": "./XXX/module_notice_board",
    },
    {
    "name": "module_base",
    "srcPath": "./XXX/module_base",
    }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

深色代码主题复制
```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_notice_board": "file:./XXX/module_notice_board"
}
```

#### 引入组件与消息轮播组件句柄

深色代码主题复制
```typescript
import { CommonNoticeBoard, INoticeItem } from 'module_notice_board'
```

#### 调用组件

调用组件，详细参数配置说明参见 API 参考。

深色代码主题复制
```typescript
@Entry
@ComponentV2
struct Sample {
  @Local noticeList: INoticeItem[] = [
    {
      id: 1,
      name: '测试数据 1',
      img: '',
      date: '2024.03.29',
    },
    {
      id: 2,
      name: '测试数据 2',
      img: '',
      date: '2024.03.29',
    },
    {
      id: 3,
      name: '测试数据 3',
      img: '',
      date: '2024.03.29',
    }
  ]
  build() {
    Column() {
      CommonNoticeBoard({ noticeList: this.noticeList })
    }
    .backgroundColor('#F1F3F5')
    .padding(10)
    .width('100%')
    .height('100%')
  }
}
```

## API 参考

### 子组件

### 接口

`CommonNoticeBoard(options?: CommonNoticeBoardOptions)`

消息轮播组件。

#### 参数

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | CommonNoticeBoardOptions | 否 | 配置消息轮播组件的参数。 |

#### CommonNoticeBoardOptions 对象说明

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| noticeList | INoticeItem[] | 是 | 消息列表 |

#### INoticeItem 对象说明

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | number | 是 | id |
| name | string | 是 | 名称 |
| img | ResourceStr | 是 | 图片 |
| date | string | 是 | 日期 |

### 示例代码

深色代码主题复制
```typescript
import { CommonNoticeBoard, INoticeItem } from 'module_notice_board'
@Entry
@ComponentV2
struct Sample {
 @Local noticeList: INoticeItem[] = [
   {
     id: 1,
     name: '测试数据 1',
     img: '',
     date: '2024.03.29',
   },
   {
     id: 2,
     name: '测试数据 2',
     img: '',
     date: '2024.03.29',
   },
   {
     id: 3,
     name: '测试数据 3',
     img: '',
     date: '2024.03.29',
   }
 ]
 build() {
   Column() {
     CommonNoticeBoard({ noticeList: this.noticeList })
   }
   .backgroundColor('#F1F3F5')
   .padding(10)
   .width('100%')
   .height('100%')
 }
}
```

## 更新记录

| 版本 | 日期 | 备注 | 说明 |
| :--- | :--- | :--- | :--- |
| 1.0.1 | 2025-11-25 | Created with Pixso. | 下载该版本修改 readme。 |
| 1.0.0 | 2025-08-30 | Created with Pixso. | 下载该版本初始版本 |

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

| 项目 | 值 | 备注 |
| :--- | :--- | :--- |
| HarmonyOS 版本 | 5.0.0 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.1 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.2 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.3 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.4 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.5 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.0 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.1 | Created with Pixso. |
| HarmonyOS 版本 | 6.0.0 | Created with Pixso. |
| 应用类型 | 应用 | Created with Pixso. |
| 应用类型 | 元服务 | Created with Pixso. |
| 设备类型 | 手机 | Created with Pixso. |
| 设备类型 | 平板 | Created with Pixso. |
| 设备类型 | PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.1 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.2 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.4 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.0 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.1 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.0 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/4a7f254b9cf745d897033aa43dc4643f/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%B6%88%E6%81%AF%E8%BD%AE%E6%92%AD%E7%BB%84%E4%BB%B6/module_notice_board1.0.1.zip