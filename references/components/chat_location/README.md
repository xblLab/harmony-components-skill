# 发送位置组件

## 简介

本组件提供了选择地理位置的功能和查看地理位置的功能。

## 详细介绍

### 简介

本组件提供了选择地理位置的功能和查看地理位置的功能。

### 功能列表

- 选择地理位置
- 查看地理位置

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3(15) Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.3(15) 及以上

#### 权限

- **模糊定位权限**：`ohos.permission.APPROXIMATELY_LOCATION`
- **精准定位权限**：`ohos.permission.LOCATION`
- **网络权限**：`ohos.permission.INTERNET`

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `chat_base` 和 `chat_location` 模块。
   在项目根目录 `build-profile.json5` 填写 `chat_base` 和 `chat_location` 路径，其中 `XXX` 为组件存放的目录名称。

   ```json5
   {
     "modules": [
       {
         "name": "chat_base",
         "srcPath": "./XXX/chat_base"
       },
       {
         "name": "chat_location",
         "srcPath": "./XXX/chat_location"
       }
     ]
   }
   ```

3. 在 `module.json5` 中添加 `INTERNET`、`LOCATION`、`APPROXIMATELY_LOCATION` 相应权限。

   ```json5
   {
     "requestPermissions": [
       {
         "name": "ohos.permission.INTERNET"
       },
       {
         "name": "ohos.permission.APPROXIMATELY_LOCATION",
         "reason": "$string:EntryAbility_label",
         "usedScene": {
           "abilities": ["EntryAbility"],
           "when": "inuse"
         }
       },
       {
         "name": "ohos.permission.LOCATION",
         "reason": "$string:EntryAbility_label",
         "usedScene": {
           "abilities": ["EntryAbility"],
           "when": "inuse"
         }
       }
     ]
   }
   ```

4. 在项目根目录 `oh-package.json5` 中添加依赖，`xxx` 为组件存放的目录名称。

   ```json5
   {
     "dependencies": {
       "chat_location": "file:./XXX/chat_location"
     }
   }
   ```

#### 引入组件

```typescript
import { ChatLocationComponent, ChooseLocationUtil } from 'chat_location';
import { ChatBreakpoint } from 'chat_location';
```

#### 获取适配设备数据

详细参数配置说明参见 API 参考。

```typescript
chatBreakpoint = AppStorageV2.connect(ChatBreakpoint, () => new ChatBreakpoint())!;

windowClass.on('avoidAreaChange', () => {
  let type = window.AvoidAreaType.TYPE_SYSTEM;
  let avoidArea = windowClass.getWindowAvoidArea(type);
  this.chatBreakpoint.topValue = px2vp(avoidArea.topRect.height);

  type = window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR;
  avoidArea = windowClass.getWindowAvoidArea(type);
  this.chatBreakpoint.bottomValue = px2vp(avoidArea.bottomRect.height);
  this.chatBreakpoint.currentScreenWidth =
    windowClass.getWindowProperties().windowRect.width / display.getDefaultDisplaySync().densityPixels;
});
```

#### 调用组件

详细参数配置说明参见 API 参考。

```typescript
context: common.UIAbilityContext = this.getUIContext().getHostContext() as common.UIAbilityContext
ChooseLocationUtil.chooseLocation(this.context)
  .then((result: sceneMap.LocationChoosingResult) => {
    hilog.info(0x0000, 'ChatInputComponent', '%{public}s',
              'choose location result = ' + JSON.stringify(result));
  })
  .catch((err: BusinessError) => {
    hilog.error(0x0000, 'ChatInputComponent', '%{public}s',
      'choose location err = ' + JSON.stringify(err));
  })

ChatLocationComponent({
  latitude: 31.8698571539735,
  longitude: 118.82523154589367,
  onReturnClick: () => {
    
  },
  address: '秣周东路悠湖产业园',
  addressDetail: '江苏省南京市江宁区秣周东路'
})
```

## API 参考

### 子组件

无

### 接口

#### ChatLocationComponent

查看地理位置组件。

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| latitude | number | 是 | 目的地的维度 |
| longitude | number[] | 是 | 目的地的经度 |
| address | string | 是 | 目的地的名称 |
| addressDetail | string | 是 | 目的地的描述 |
| onReturnClick | Function | 是 | 点击返回事件回调 |

#### ChooseLocationUtil

选择地理位置组件。

| 方法名 | 类型 | 说明 |
| :--- | :--- | :--- |
| chooseLocation | 静态方法 | 拉起地点选择页 |

## 示例代码

```typescript
import { common } from '@kit.AbilityKit';
import { sceneMap } from '@kit.MapKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { AppStorageV2 } from '@kit.ArkUI';
import { ChatLocationComponent, ChooseLocationUtil } from 'chat_location';
import { ChatBreakpoint } from 'chat_location';

@Entry
@ComponentV2
struct Index {
   @Local message: string = '选择地理位置';
   @Local chatBreakpoint: ChatBreakpoint = AppStorageV2.connect(ChatBreakpoint, () => new ChatBreakpoint())!;
   @Local result: sceneMap.LocationChoosingResult = {
      location: {
         latitude: 31.8698571539735,
         longitude: 118.82523154589367
      },
      address: '江苏省南京市江宁区秣周东路',
      name: '秣周东路悠湖产业园',
      zoom: 0
   }

   build() {
      Stack({ alignContent: Alignment.TopEnd }) {
         ChatLocationComponent({
            latitude: this.result.location.latitude,
            longitude: this.result.location.longitude,
            onReturnClick: () => {

            },
            address: this.result.name,
            addressDetail: this.result.address,
         })

         Text('选择地理位置')
            .fontSize($r('sys.float.Body_M'))
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Medium)
            .lineHeight(18)
            .maxLines(3)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .textAlign(TextAlign.End)
            .width('100%')
            .height(54)
            .padding({
               top: this.chatBreakpoint.topValue,
               left: 16,
               right: 16
            })
            .onClick(() => {
               let context: common.UIAbilityContext = this.getUIContext().getHostContext() as common.UIAbilityContext
               ChooseLocationUtil.chooseLocation(context)
                  .then((result: sceneMap.LocationChoosingResult) => {
                     hilog.info(0x0000, 'ChatInputComponent', '%{public}s',
                        'choose location result = ' + JSON.stringify(result));
                     this.result = result;
                     this.message =
                        result.name + '\n' + result.address + '\n' + result.location.latitude + '\n' + result.location.longitude
                  })
                  .catch((err: BusinessError) => {
                     hilog.error(0x0000, 'ChatInputComponent', '%{public}s',
                        'choose location err = ' + JSON.stringify(err));
                  })
            })
      }
      .height('100%')
         .width('100%')
   }
}
```

## 更新记录

### 1.0.0 (2025-12-27)

- 下载该版本
- 初始版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.APPROXIMATELY_LOCATION | 允许应用获取设备模糊位置信息 | 允许应用获取设备模糊位置信息 |
| ohos.permission.LOCATION | 允许应用获取设备位置信息 | 允许应用获取设备位置信息 |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

### 合规使用指南

不涉及

## 兼容性

### HarmonyOS 版本

| 版本 |
| :--- |
| 5.0.3 |
| 5.0.4 |
| 5.0.5 |
| 5.1.0 |
| 5.1.1 |
| 6.0.0 |
| 6.0.1 |

### 应用类型

| 类型 |
| :--- |
| 应用 |
| 元服务 |

### 设备类型

| 类型 |
| :--- |
| 手机 |
| 平板 |
| PC |

### DevEco Studio 版本

| 版本 |
| :--- |
| DevEco Studio 5.0.5 |
| DevEco Studio 5.1.0 |
| DevEco Studio 5.1.1 |
| DevEco Studio 6.0.0 |
| DevEco Studio 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/4503f57ebfb1483abd0d2c725b449780/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%8F%91%E9%80%81%E4%BD%8D%E7%BD%AE%E7%BB%84%E4%BB%B6/chat_location1.0.0.zip