# 时间轴组件

## 简介

本组件提供时间轴相关功能。

## 详细介绍

### 简介

本组件提供时间轴相关功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（直板机）
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

#### 权限

无

### 快速入门

#### 1. 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_time_line` 模块。
   
   ```json5
   // 在项目根目录 build-profile.json5 填写 module_time_line 路径。其中 XXX 为组件存放的目录名
   "modules": [
       {
           "name": "module_time_line",
           "srcPath": "./XXX/module_time_line",
       }
   ]
   ```

3. 在项目根目录 `oh-package.json5` 中添加依赖。
   
   ```json5
   // XXX 为组件存放的目录名称
   "dependencies": {
     "module_time_line": "file:./XXX/module_time_line"
   }
   ```

#### 2. 引入组件与句柄

```typescript
import { CommonTimeLine, OrderDetailBean } from 'module_time_line'
```

#### 3. 调用组件

详细参数配置说明参见 [API 参考](#api-参考)。

```typescript
@Entry
@ComponentV2
struct Sample {
  @Local timeLineList: OrderDetailBean[] = [
    {
      nodeName:'提出购买申请',
      nodeStatus:1,
      nextNodeStatus:1,
      nodeTime:'2025/06/30'
    },
    {
      nodeName:'扣款',
      nodeStatus:1,
      nextNodeStatus:0,
      nodeTime:'2025/07/01'
    },
    {
      nodeName:'确认份额',
      nodeStatus:0,
      nodeTime:'2025/07/02'
    }
  ]
  @Local totalSize:number = 3

  build() {
    Column() {
      CommonTimeLine({ timeLineList: this.timeLineList, totalSize: this.totalSize })
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

#### 接口

**CommonTimeLine(options?: CommonTimeLineOptions)**

时间轴组件。

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | CommonTimeLineOptions | 否 | 配置时间轴组件的参数。 |

##### CommonTimeLineOptions 对象说明

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| timeLineList | OrderDetailBean[] | 是 | 时间轴数据 |
| totalSize | number | 是 | 时间轴总数 |

##### OrderDetailBean 对象说明

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| nodeStatus | number | - | 是当前节点状态 |
| nextNodeStatus | number | - | 是下一个节点的状态 |
| nodeName | string | - | 是节点名称 |
| nodeTime | string | - | 是节点时间 |

### 示例代码

```typescript
import { CommonTimeLine, OrderDetailBean } from 'module_time_line'

@Entry
@ComponentV2
struct Sample {
 @Local timeLineList: OrderDetailBean[] = [
   {
     nodeName:'提出购买申请',
     nodeStatus:1,
     nextNodeStatus:1,
     nodeTime:'2025/06/30'
   },
   {
     nodeName:'扣款',
     nodeStatus:1,
     nextNodeStatus:0,
     nodeTime:'2025/07/01'
   },
   {
     nodeName:'确认份额',
     nodeStatus:0,
     nodeTime:'2025/07/02'
   }
 ]
 @Local totalSize:number = 3

 build() {
   Column() {
     CommonTimeLine({ timeLineList: this.timeLineList, totalSize: this.totalSize })
   }
   .backgroundColor('#F1F3F5')
   .padding(10)
   .width('100%')
   .height('100%')
 }
}
```

## 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.1 | 2025-11-25 | 修改 readme |
| 1.0.0 | 2025-11-03 | 初始版本 |

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

| 项目 | 支持情况 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: [https://developer.huawei.com/consumer/cn/market/prod-detail/9927afae0d2640c78d8202a1a0bc73ae/2adce9bbd4cb42d58a87e6add45594b3?origin=template](https://developer.huawei.com/consumer/cn/market/prod-detail/9927afae0d2640c78d8202a1a0bc73ae/2adce9bbd4cb42d58a87e6add45594b3?origin=template)

## OSS 下载链接

- [https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%97%B6%E9%97%B4%E8%BD%B4%E7%BB%84%E4%BB%B6/module_time_line1.0.1.zip](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%97%B6%E9%97%B4%E8%BD%B4%E7%BB%84%E4%BB%B6/module_time_line1.0.1.zip)