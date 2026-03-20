# 公交路线搜索组件

## 简介

本组件提供了展示公交路线搜索结果的相关功能。

## 详细介绍

### 简介

本组件提供了展示公交路线搜索结果的相关功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.1.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.1.0 Release SDK 及以上
- **设备类型**：华为手机（直板机、双折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.0(12) 及以上

### 使用

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `route_search` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 route_search 路径。其中 XXX 为组件存放的目录名
"modules": [
 { 
   "name": "route_search",
   "srcPath": "./xxx/route_search",
 }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies":
{
   "route_search": "file:./xxx/route_search"
}
```

引入组件与公交路线搜索组件句柄。

```typescript
import { LineInfo, RouteSearch } from 'route_search'
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
RouteSearch({
  defaultStartText: this.startText,
  defaultEndText: this.endText,
  lineInfo: this.lineInfo,
  onInputChange: (value: string, index: number) => {
    this.inputChange(value, index)
   },
  clickInput: (index: number) => {
    this.clickInput(index)
   },
  clickListItem: (lineItem: LineInfo) => {
    this.clickListItem(lineItem)
   }
})
```

### API 参考

#### 接口

`RouteSearch(options?: RouteSearchOptions)`

公交路线搜索组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | RouteSearchOptions | 否 | 提供公交路线搜索的事件和结果展示功能 |

**RouteSearchOptions 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| defaultStartText | string | 否 | 起点输入框默认值，默认值'' |
| defaultEndText | string | 否 | 终点输入框默认值，默认值'' |
| lineInfo | LineInfo[] | 否 | 公交路线信息列表 |

**LineInfo 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| lineName | string | 否 | 线路名称，比如 1 路 |
| direction | string | 否 | 行车方向 |
| startStation | string | 否 | 起始站点 |
| endStation | string | 否 | 终点站 |
| distance | string | 否 | 与当前位置距离 |
| countDown | string | 否 | 到站倒计时 |

#### 事件

支持以下事件：

**onInputChange**

```typescript
// value 为输入框的值，index 为输入框索引值
onInputChange: (value: string, index: number) => {
}
```

搜索框输入变化的回调。

**clickInput**

```typescript
// index 为输入框的索引值
clickInput: (index: number) => {
}
```

点击搜索框的回调。

**clickListItem**

```typescript
// lineItem 为推荐路线信息
clickListItem: (lineItem: LineInfo) => {
}
```

点击推荐路线卡片的回调。

### 示例代码

```typescript
import { LineInfo, RouteSearch } from 'route_search'

interface BusLine {
 name: string,
 direction: string
 stations: string[]
}

const Lines: BusLine[] = [
 {
   name: '1 路',
   direction: '河道路方向',
   stations: ['长白街', '杨公井', '新街口东', '新街口南', '观音里', '河道路']
 },
 {
   name: '64 路',
   direction: '长白街方向',
   stations: ['河道路','观音里','新街口南','新街口东','杨公井','长白街']
 },
 {
   name: '11 路',
   direction: '河道路方向',
   stations: ['长白街', '新街口东', '新街口南', '观音里', '河道路']
 },
 {
   name: '2 路',
   direction: '林场方向',
   stations: ['长白街', '杨公井', '新街口东', '观音里', '河道路', '林场']
 }
]

@Entry
@ComponentV2
struct Index {
 @Local lineInfo: LineInfo[] = []
 @Local startText: string = ''
 @Local endText: string = ''
 @Local inputStart: string = ''
 @Local inputEnd: string =''

 build() {
   Column() {
     RouteSearch({
       defaultStartText: this.startText,
       defaultEndText: this.endText,
       lineInfo: this.lineInfo,
       onInputChange: (value: string, index: number) => {
         this.lineInfo = []
         if(index === 0){
           this.inputStart = value
         }
         if(index === 1){
           this.inputEnd = value
         }
         if (this.inputStart.length && this.inputEnd.length) {
           Lines.forEach((item: BusLine) => {
             const startIndex: number = item.stations.indexOf(this.inputStart)
             const endIndex: number = item.stations.indexOf(this.inputEnd)
             if (startIndex !== -1 && endIndex !== -1 && startIndex < endIndex) {
               let len: number = item.stations.length
               this.lineInfo.push(new LineInfo(item.name, item.direction, item.stations[0], item.stations[len-1],'5','10'))
             }
           })
         }
       },
       clickInput: (index: number) => {
         console.info(`input change index: ${index}`)
       },
       clickListItem: (lineItem: LineInfo) => {
         this.getUIContext().getPromptAction().showToast({
           message: '点击了路线卡片，暂无路线详情',
           duration: 2000
         });
       }
     })
   }
 }
}
```

### 更新记录

- **1.0.1 (2025-11-03)**
  - 下载该版本
  - 状态管理 V1 切 V2 修改 README
- **1.0.0 (2025-07-31)**
  - 下载该版本
  - 初始版本

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

| 项目 | 说明 |
| :--- | :--- |
| 隐私政策 | 不涉及 |
| SDK 合规 | 不涉及 |

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/e2b611aaf74d48b3994d47b25b60e3f8/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%85%AC%E4%BA%A4%E8%B7%AF%E7%BA%BF%E6%90%9C%E7%B4%A2%E7%BB%84%E4%BB%B6/route_search1.0.1.zip