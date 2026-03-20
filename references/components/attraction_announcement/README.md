# 景点播报组件

## 简介

本组件提供景点介绍语音播报功能。

## 详细介绍

### 简介

本组件提供景点介绍语音播报功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.3(15) 及以上

#### 权限

获取网络权限：`ohos.permission.INTERNET`、`ohos.permission.GET_NETWORK_INFO`。

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。

b. 在项目根目录 `build-profile.json5` 并添加 `attraction_announcement` 和 `module_base` 模块：

```json5
"modules": [
   {
   "name": "attraction_announcement",
   "srcPath": "./xxx/attraction_announcement",
   },
   {
      "name": "module_base",
      "srcPath": "./xxx/module_base",
   }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖：

```json5
"dependencies": {
   "attraction_announcement": "file:./xxx/attraction_announcement",
   "module_base": "file:./xxx/module_base"
}
```

#### 引入组件

```typescript
import { VoiceComponent } from 'attraction_announcement';
```

### API 参考

#### 接口

`VoiceComponent(playInfo: PlayInfo)`

景区播报组件

##### 参数说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| playInfo | PlayInfo | 是 | 播报信息 |

##### PlayInfo 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| panelIconResourceStr | Str | 是 | 面板图标 |
| panelName | string | 是 | 面板名称 |
| playId | string | - | 音频 id |
| introduction | string | - | 音频内容 |
| title | string | - | 音频标题 |
| imageUrl | string | - | 音频图片地址 |

### 示例代码

```typescript
import { VoiceComponent } from 'attraction_announcement';
import { PlayInfo } from 'module_base';

@Entry
@ComponentV2
struct Index {
  build() {
    Column() {
      VoiceComponent({
        playInfo: {
          playId: '1', 
          introduction: 'L 区建筑以海德堡建筑风格为主，红褐色古城堡是海德堡城的标志，大多为白墙红瓦的老城建筑。设计参考了在人文科学上闻名、并在德国具有最悠久历史的海德堡大学，以红砂岩外墙和传统街区构成建筑群，布置在小山丘上细致而雄伟的城堡与由网格状道路构成的街区形成了鲜明的对比。',
          title: '松山湖景区',
          imageUrl: 'https://agc-storage-drcn.platform.dbankcloud.cn/v0/scenic-i0v1l/common%2FHeidelberg_B.png?token=66ceba4d-be1d-4c87-a01b-98ed7002c2de',
          panelName: '松山湖景区',
          panelIcon: $r('app.media.startIcon')
        } as PlayInfo,
      });
    }.width('100%').alignItems(HorizontalAlign.Center);
  }
}
```

### 更新记录

- **1.0.1 (2025-12-15)**
  - 下载该版本修复部分问题
- **1.0.0 (2025-09-11)**
  - 下载该版本初始版本

### 权限与隐私

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |
| ohos.permission.GET_NETWORK_INFO | 允许应用获取数据网络信息 | 允许应用获取数据网络信息 |

#### 合规使用指南

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

### 兼容性

| 项目 | 支持情况 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/528897894d2f41ed8f742e5cb272216a/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%99%AF%E7%82%B9%E6%92%AD%E6%8A%A5%E7%BB%84%E4%BB%B6/attraction_announcement1.0.1.zip