# 通用朗读组件

## 简介

本组件提供了将文本转换成语音并朗读的功能。

## 详细介绍

### 简介

本组件提供了将文本转换成语音并朗读的功能。

### 约束与限制

#### 环境

- DevEco Studio版本：DevEco Studio 5.0.5 Release及以上
- HarmonyOS SDK版本：HarmonyOS 5.0.5 Release SDK及以上
- 设备类型：华为手机（包括双折叠和阔折叠）、平板
- 系统版本：HarmonyOS 5.0.3(15)及以上

#### 权限

获取网络权限：ohos.permission.INTERNET

#### 注意事项

暂不支持模拟器

### 快速入门

1. 安装组件。

   如果是在DevEco Studio使用插件集成组件，则无需安装组件，请忽略此步骤。

   如果是从生态市场下载组件，请参考以下步骤安装组件。

   a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的XXX目录下。

   b. 在项目根目录build-profile.json5添加text_reader模块。

   ```json5
   // 项目根目录下build-profile.json5填写text_reader路径。其中XXX为组件存放的目录名
   "modules": [
     {
       "name": "text_reader",
       "srcPath": "./XXX/text_reader"
     }
   ]
   ```

   c. 在项目根目录oh-package.json5添加依赖。

   ```json5
   // XXX为组件存放的目录名称
   "dependencies": {
     "text_reader": "file:./XXX/text_reader"
   }
   ```

2. 引入朗读组件句柄。

   ```typescript
   import { BarAlignment, DisplayTab, ReaderContent, ReaderParams, ResetParamType, TextReaderController, TextRead, IconParams } from 'text_reader';
   ```

3. 调用组件，详细组件调用参见API参考。

## API参考

### 接口

#### TextRead(option: TextReadOptions)

朗读组件的参数

参数：

| 参数名 | 类型 | 是否必填 | 说明 |
|--------|------|----------|------|
| options | TextReadOptions | 否 | 配置朗读组件的参数。 |

##### TextReadOptions对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
|--------|------|----------|------|
| currentId | string | 是 | 当前朗读文本id |
| readInfoList | ReaderContent[] | 是 | 朗读信息列表。若列表的第一篇文章是有分类的，后续文章不带分类，也会归为"其他"分类下。若列表的第一篇是没有分类的，后续文章即使带分类，也不会生效。 |
| iconParams | IconParams | 否 | 朗读图标参数 |
| readerParam | ReaderParams | 否 | 朗读参数 |
| controller | TextReaderController | 否 | 朗读控制器 |
| onSetArticle | (id: string) => void | 否 | 设置文章回调函数，参数为文章id，点击文章或者切换文章时，若目标文章内容为空（bodyInfo值为空）时，触发该回调执行。 |
| onClickArticle | (id: string) => void | 否 | 点击标题回调函数，参数为文章id，触发该回调执行。 |
| onClickAuthor | (id: string) => void | 否 | 点击作者回调函数，参数为文章id，触发该回调执行。 |
| onClickNotification | (id: string) => void | 否 | 点击通知栏回调函数，参数为文章id，触发该回调执行。 |
| onShowPanel | () => void | 否 | 拉起播放面板回调函数，拉起播放面板时，触发该回调执行。 |
| onHidePanel | () => void | 否 | 收回播放面板回调函数，收回播放面板时，触发该回调执行。 |
| onStop | () => void | 否 | 停止回调函数，调用stop时，触发该回调执行。 |
| onRelease | () => void | 否 | 释放回调函数，调用release时，触发该回调执行。 |
| onEventNotification | (ne: TextReader.NotificationEvent) => void | 否 | 通知栏+播控中心变化时，触发该回调执行。 |
| onEventPanel | (pe: TextReader.PanelEvent) => void | 否 | 播放面板状态发生变化时，触发该回调执行。 |
| onEventReadList | (list: Array<TextReader.ListEventState>) => void | 否 | 播报列表相关事件监听，点击播报列表图标时，触发该回调执行。 |

##### ReaderContent对象说明

| 名称 | 类型 | 是否必填 | 说明 |
|------|------|----------|------|
| id | string | 是 | 文章标识ID，不能为空字符串。 |
| title | TextParams | 是 | 标题 |
| bodyInfo | string | 是 | 正文，长度10000汉字以内 |
| category | string | 否 | 类别 |
| author | TextParams | 否 | 文章作者 |
| imgSrc | ResourceStr \| PixelMap | 否 | 文章封面图片，若文章有分类，则采用该分类的第一篇文章的封面图片。 |
| audioInfo | AudioInfo[] | 否 | 提供云端播放录制文件的能力 |
| bodyInfoObject | BodyInfo | 否 | 正文内容信息 |
| categoryObject | CategoryInfo | 否 | 文章分类信息 |
| isFavorite | boolean | 否 | 默认为false，表示不喜欢/未收藏 |

##### TextParams对象说明

| 名称 | 类型 | 是否必填 | 说明 |
|------|------|----------|------|
| text | string | 是 | 文本 |
| isClickable | boolean | 是 | 是否支持点击收回播报面板，true为支持收回，false为不收回 |

##### IconParams对象说明

| 名称 | 类型 | 是否必填 | 说明 |
|------|------|----------|------|
| iconWidth | Length | 否 | 听筒图标宽度，默认为32vp |
| iconHeight | Length | 否 | 听筒图标高度，默认为32vp |
| iconBackgroundColor | ResourceColor | 否 | 听筒图标背景色，默认为系统背景主题色 |
| iconBorderRadius | Length \| BorderRadiuses | 否 | 听筒图标圆角，默认为8vp |

##### ReaderParams对象说明

| 名称 | 类型 | 是否必填 | 说明 |
|------|------|----------|------|
| isVoiceBrandVisible | boolean | 是 | 是否显示播报品牌，默认为false |
| businessBrandInfo | BrandInfo | 否 | 播报品牌信息 |
| isFastForward | boolean | 否 | 快进快退逻辑，默认为false：上下一句切换，配置为true：快进快退15秒 |
| isMinibarNeeded | boolean | 否 | 是否展示minibar，默认为true，配置为false时，controller中的hideMinibar、showMinibar方法无效 |
| minibarParams | MinibarParams | 否 | minibar初始化位置，以及与底部边框的距离。默认吸附左边 |
| customFeatures | CustomFeature[] | 否 | 朗读控件的自定义功能，默认空 |
| displayTab | DisplayTab | 否 | 显示Tab页配置，默认显示封面和内容页 |
| reportProgressPeriod | number | 否 | 多久返回一次已播放时长日志信息，默认为0ms，不回调 |

##### BrandInfo对象说明

| 名称 | 类型 | 是否必填 | 说明 |
|------|------|----------|------|
| panelName | string | 否 | 播报品牌 |

##### MinibarParams对象说明

| 名称 | 类型 | 是否必填 | 说明 |
|------|------|----------|------|
| defaultAlignment | BarAlignment | 是 | minibar默认吸附位置 |
| bottom | number | 否 | minibar离底部的边缘距离，仅支持左右拖动。取值大于等于0，默认为50vp，超过屏幕范围则不显示。 |

##### BarAlignment枚举说明

| 名称 | 值 | 说明 |
|------|-----|------|
| LEFT | 1 | 左侧 |
| RIGHT | 2 | 右侧 |

##### DisplayTab枚举说明

| 名称 | 值 | 说明 |
|------|-----|------|
| COVER_AND_CONTENT | 1 | 显示封面页和内容页 |
| CONTENT | 2 | 仅显示内容页 |
| COVER | 3 | 仅显示封面页 |

##### TextReaderController对象说明

| 名称 | 类型 | 是否必填 | 说明 |
|------|------|----------|------|
| textReaderStart | (readInfoList: ReaderContent[], articleId?: string) => Promise | 否 | 开始朗读。参数一为播放文章列表，必填参数，参数二为文章id，可选参数。若文章id不填，默认从文章列表第一篇开始。 |
| textReaderStop | () => Promise | 否 | 停止朗读。 |
| textReaderResetParam | (paramName: ResetParamType) => void | 否 | 重置初始化参数、清除播放列表接口。 |
| textReaderRelease | () => Promise | 否 | 释放朗读控件的所有资源。 |
| textReaderPause | () => void | 否 | 暂停朗读。 |
| textReaderResume | () => void | 否 | 继续朗读。 |
| textReaderPlayPrev | () => void | 否 | 朗读上一篇文章。 |
| textReaderPlayNext | () => void | 否 | 朗读下一篇文章。 |
| textReaderHidePanel | () => void | 否 | 隐藏播放面板。 |
| textReaderShowPanel | () => void | 否 | 打开播放面板。 |
| textReaderHideMinibar | () => void | 否 | 隐藏minibar。 |
| textReaderShowMinibar | () => void | 否 | 显示minibar。 |
| queryReadState | (id: string) => ReaderState | 否 | 查询文章朗读状态。id为选填参数，若不填，默认查询正在朗读的文章id。 |
| setArticleContent | (id: string, bodyInfo?: string) => void | 否 | 设置文章内容。参数一为文章id，必填参数，参数二为文章内容，可选参数，若文章内容不填，朗读指定文章id时，控件内容页加载失败。 |
| setArticle | (readInfo: ReaderContent) => void | 否 | 设置指定文章的信息，并立即朗读。readInfo为必填参数。仅更新imgSrc和bodyInfo，如果文章的ID不在列表中，则不会生效。 |
| queryReadStateByCategoryId | (categoryId: string) => ReaderState | 否 | 根据分类id查询文章状态，查询当前分类是否有正在朗读的文章。categoryId为必填参数，表示当前播报文章的分类id。 |

##### ResetParamType枚举说明

| 名称 | 值 | 说明 |
|------|-----|------|
| ALL | 1 | 重置所有本地数据 |
| BAR_PARAM | 2 | 重置minibar参数 |
| READ_LIST | 3 | 重置文章列表 |

### 示例代码

```typescript
import {
  BarAlignment,
  DisplayTab,
  ReaderContent,
  ReaderParams,
  ResetParamType,
  TextReaderController,
  TextRead,
  IconParams
} from 'text_reader';

@Entry
@ComponentV2
struct TextReaderPage {
  @Local iconParams: IconParams = {
    iconWidth: 32,
    iconHeight: 32,
    iconBackgroundColor: $r('sys.color.background_primary'),
    iconBorderRadius: 8
  }
  @Local ancientPoetry: ReaderContent[] = [
    {
      id: '001',
      title: { text: '静夜思', isClickable: true },
      author: { text: '唐·李白', isClickable: true },
      bodyInfo: '床前明月光，疑是地上霜。\n' +
        '举头望明月，低头思故乡。',
      imgSrc: $r('app.media.startIcon'),  // todo 需要替换为开发者所需要的资源。
    },
    {
      id: '002',
      title: { text: '春晓', isClickable: true },
      author: { text: '唐·孟浩然', isClickable: true },
      bodyInfo: '春眠不觉晓，处处闻啼鸟。\n' +
        '夜来风雨声，花落知多少。'
    },
    {
      id: '003',
      title: { text: '登鹳雀楼', isClickable: true },
      author: { text: '唐·王之涣', isClickable: true },
      bodyInfo: '白日依山尽，黄河入海流。\n' +
        '欲穷千里目，更上一层楼。'
    }
  ]
  @Local readerParam: ReaderParams = {
    isVoiceBrandVisible: true,
    businessBrandInfo: { panelName: '朗读组件' },
    isFastForward: false,
    isMinibarNeeded: true,
    minibarParams: { defaultAlignment: BarAlignment.LEFT, bottom: 50 },
    displayTab: DisplayTab.COVER_AND_CONTENT,
  }
  @Local controller: TextReaderController = new TextReaderController()

  build() {
    NavDestination() {
      Column() {
        Row() {
          TextRead({
            currentId: this.ancientPoetry[0]?.id,
            readInfoList: this.ancientPoetry,
            readerParam: this.readerParam,
            iconParams: this.iconParams,
            controller: this.controller,
          })
        }
        .height(56)
        
        Scroll() {
          Column() {
            Button('开始')
              .margin({ bottom: 12 })
              .onClick(() => {
                this.controller.textReaderStart(this.ancientPoetry, '001')
              })
            Button('暂停')
              .margin({ bottom: 12 })
              .onClick(() => {
                this.controller.textReaderPause()
              })
            Button('继续播放')
              .margin({ bottom: 12 })
              .onClick(() => {
                this.controller.textReaderResume()
              })
            Button('重置')
              .margin({ bottom: 12 })
              .onClick(() => {
                this.controller.textReaderResetParam(ResetParamType.ALL)
              })
            Button('上一首')
              .margin({ bottom: 12 })
              .onClick(() => {
                this.controller.textReaderPlayPrev()
              })
            Button('下一首')
              .margin({ bottom: 12 })
              .onClick(() => {
                this.controller.textReaderPlayNext()
              })
            Button('隐藏播放面板')
              .margin({ bottom: 12 })
              .onClick(() => {
                this.controller.textReaderHidePanel()
              })
            Button('打开播放面板')
              .margin({ bottom: 12 })
              .onClick(() => {
                this.controller.textReaderShowPanel()
              })
            Button('隐藏minibar')
              .margin({ bottom: 12 })
              .onClick(() => {
                this.controller.textReaderHideMinibar()
              })
            Button('打开minibar')
              .margin({ bottom: 12 })
              .onClick(() => {
                this.controller.textReaderShowMinibar()
              })
            Button('查询《登鹳雀楼》状态')
              .margin({ bottom: 12 })
              .onClick(() => {
                const queryResult = this.controller.queryReadState('003')
                let queryState = ''
                switch (queryResult?.state) {
                  case 1:
                    queryState = '播放';
                    break;
                  case 2:
                    queryState = '暂停';
                    break;
                  case 3:
                    queryState = '播放完成';
                    break;
                  case 4:
                    queryState = '未播放/停止';
                    break;
                  case 5:
                    queryState = '未在播放列表';
                    break;
                }
                this.getUIContext().getPromptAction().showToast({ message: '查询结果为' + queryState })
              })
          }
        }
      }
      .height('100%')
    }
  }
}
```

## 更新记录

### 1.0.0（2025-10-31）

初始版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
|----------|----------|----------|
| ohos.permission.INTERNET | 允许使用Internet网络。 | 允许使用Internet网络。 |

### 隐私政策

不涉及

### SDK合规使用指南

不涉及

## 兼容性

| HarmonyOS版本 | 5.0.3 | 5.0.4 | 5.0.5 |
|---------------|-------|-------|-------|
| 应用类型 | 应用 | 元服务 | |
| 设备类型 | 手机 | 平板 | PC |
| DevEco Studio版本 | DevEco Studio 5.0.5 | DevEco Studio 5.1.0 | DevEco Studio 5.1.1 | DevEco Studio 6.0.0 |

## 来源

- 原始URL: https://developer.huawei.com/consumer/cn/market/prod-detail/9adc04bbd7d74712a17a4f77fd2b024c/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%80%9A%E7%94%A8%E6%9C%97%E8%AF%BB%E7%BB%84%E4%BB%B6/text_reader1.0.0.zip