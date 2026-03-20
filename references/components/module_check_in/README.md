# 打卡组件

## 简介

展示打卡界面，支持选择图片、视频资源并展示预览效果。

## 详细介绍

### 简介

展示打卡界面，支持选择图片、视频资源并展示预览效果。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.2 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.2 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.2 Release 及以上

#### 权限

无

### 快速入门

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_ui_base` 和 `module_check_in` 模块。
   ```json5
   // 在项目根目录 build-profile.json5 填写 module_ui_base 和 module_check_in 路径。其中 XXX 为组件存放的目录名
   "modules": [
       {
           "name": "module_ui_base",
           "srcPath": "./XXX/module_ui_base",
       },
       {
           "name": "module_check_in",
           "srcPath": "./XXX/module_check_in",
       }
   ]
   ```
3. 在项目根目录 `oh-package.json5` 中添加依赖。
   ```json5
   // XXX 为组件存放的目录名称
   "dependencies": {
     "module_check_in": "file:./XXX/module_check_in"
   }
   ```

引入打卡组件句柄。
```typescript
import { CheckInView } from 'module_check_in';
```

调用组件，详细参数配置说明参见 API 参考。
```typescript
import { CheckInView } from 'module_check_in';

@Entry
@Component
struct CheckInPage1 {
  build() {
    Navigation() {
      CheckInView() {
        Column() {
          Text('打卡要求 xxx');
        };
      };
    }.title('提交打卡')
  }
}
```

### API 参考

#### 子组件

无

#### 接口

`CheckInView(options: CheckInViewOptions)`

课程列表组件。

**参数：**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | CheckInViewOptions | 否 | 配置日历组件的参数。 |

#### 事件

支持以下事件：

- `handleSubmit`
  - 签名：`(course: CheckInDataModel) => void`
  - 描述：点击课程卡片时触发的事件

#### CheckInViewOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| title | string | 否 | 标题，默认为任务详情。 |
| maxResourceNumber | number | 否 | 最大可添加的资源数量，默认为 9。 |
| bgColor | ResourceColor | 否 | 背景颜色，默认为 #f1f3f5。 |
| textLimit | number | 否 | 文本内容限制，默认为 200 字符。 |
| customDesc | CustomBuilder | 是 | 自定义任务描述插槽。 |

#### CheckInDataModel 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| textDetail | string | 否 | 文本详情，默认为空字符串。 |
| pictureDetail | ResourceStr[] | 否 | 图片详情资源数组，默认为空数组。 |
| audioDetail | ResourceStr[] | 否 | 音频详情资源数组，默认为空数组。 |
| videoDetail | ResourceStr[] | 否 | 视频详情资源数组，默认为空数组。 |
| createTime | string | 否 | 创建时间，默认为空字符串。 |

### 示例代码

#### 示例一（提交打卡文字和媒体信息，并进行校验）

```typescript
import { CheckInDataModel, CheckInView } from 'module_check_in';

@Entry
@ComponentV2
struct CheckInPage2 {
  build() {
    Navigation() {
      CheckInView(
        {
          textLimit: 100,
          handleSubmit: (data) => {
            this.handleSubmit(data);
          },
        },
      ) {
        Column() {
          Text(`文字要求：不少于 10 字`).cardContentStyle();
          Text(`图片要求：不少于 3 张`).cardContentStyle();
          Text('视频要求：至少上传 1 个打卡视频').cardContentStyle();
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start);
      };
    }.title('提交打卡')
  }

  handleSubmit(data: CheckInDataModel) {
    const promptAction = this.getUIContext().getPromptAction();
    if (data.textDetail.length < 10) {
      promptAction.showToast({ message: `打卡文字不得少于 10 个字~` });
      return;
    }
    if (data.pictureDetail.length < 3) {
      promptAction.showToast({ message: `打卡图片不得少于 3 张~` });
      return;
    }
    if (!data.videoDetail.length) {
      promptAction.showToast({ message: '请至少上传一个打卡视频~' });
      return;
    }
    promptAction.showToast({ message: '提交打卡成功~' });
  }
}

@Extend(Text)
function cardContentStyle() {
  .fontSize(12)
  .margin({ bottom: 4 })
  .fontColor('#99000000');
}
```

### 更新记录

| 版本 | 日期 | 更新内容 |
| :--- | :--- | :--- |
| 1.0.1 | 2025-11-07 | 新增一多适配：双折叠、阔折叠、平板 |
| 1.0.0 | 2025-11-03 | 初始版本 |

### 权限与隐私

| 项目 | 说明 |
| :--- | :--- |
| 权限名称 | 无 |
| 权限说明 | 无 |
| 使用目的 | 无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| 项目 | 支持版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/94b0c24e567844b59b2357fcb17df58c/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%89%93%E5%8D%A1%E7%BB%84%E4%BB%B6/module_check_in1.0.1.zip