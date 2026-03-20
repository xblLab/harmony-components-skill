# 语音播报组件

## 简介

本组件提供了语音包列表组件，可以进行语言包的下载与切换。提供接口实现对文本的语音播报功能。

## 详细介绍

### 简介

本组件提供了语音包列表组件，可以进行语言包的下载与切换。提供接口实现对文本的语音播报功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.1.1 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.1.1 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.5(17) 及以上

> 说明：系统版本 5.1.1(19) 以上支持音色下载与切换。

### 调试

本组件不支持使用模拟器调试，请使用真机进行调试。

### 使用

安装组件。

1. 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
2. 如果是从生态市场下载组件，请参考以下步骤安装组件。
   - a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
   - b. 在项目根目录 `build-profile.json5` 添加 `module_voice_broadcast` 模块。

   ```json5
   // 项目根目录下 build-profile.json5 填写 module_voice_broadcast 路径。其中 XXX 为组件存放的目录名
   "modules": [
      {
      "name": "module_voice_broadcast",
      "srcPath": "./XXX/module_voice_broadcast"
      }
   ]
   ```

   - c. 在项目根目录 `oh-package.json5` 中添加依赖。

   ```json5
   // XXX 为组件存放的目录名
   "dependencies": {
      "module_voice_broadcast": "file:./XXX/module_voice_broadcast"
   }
   ```

引入组件句柄。

```typescript
import { BroadCastUtil, VoiceList } from 'module_voice_broadcast';
```

使用语音包列表组件。详细参数配置说明参见 API 参考。

```typescript
VoiceList()
```

接口播放文本。详细参数配置说明参见 API 参考。

```typescript
BroadCastUtil.speak(this.text);
```

## API 参考

### 子组件

无

### 接口

#### VoiceList(options?: VoiceListOptions)

语音包列表组件。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | VoiceListOptions | 否 | 配置语音包列表组件的参数 |

**VoiceListOptions 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| space | string \| number | 是 | 列表间隙 |

#### BroadCastUtil 对象说明

语音播报控制器。

##### getVoiceList

```typescript
BroadCastUtil.getVoiceList(): Promise<VoicePackage[]>
```

获取所有语音包列表详情。

##### getCurVoiceType

```typescript
BroadCastUtil.getCurVoiceType(): Promise<VoiceType>
```

获取选择的语音包类型。

##### speak

```typescript
BroadCastUtil.speak(text: string): void
```

根据已选择的语音包进行文本播报。支持播放英文段落。

##### stop

```typescript
BroadCastUtil.stop(): void
```

停止语音播报。

**VoicePackage 对象说明**

| 字段 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| picResourceStr | string | 是 | 语音包图片 |
| type | VoiceType | 是 | 语音包类型 |
| desc | string | 是 | 语音包描述 |
| usednumber | number | 是 | 使用人数，单位万人 |
| rate | number | 是 | 评分，总分 5 分 |
| installed | boolean | 是 | 当前设备是否下载 |

**VoiceType 类型说明**

同系统 VoiceInfo 的 person 字段保持一致。根据不同设备获取对应支持音色。

| 名称 | 数值 | 说明 |
| :--- | :--- | :--- |
| CN_FEMALE_DEFAULT | 0 | 聆小珊女声 |
| CN_FEMALE | 13 | 聆小珊女声 |
| CN_MALE | 21 | 凌飞哲男声 |
| US_FEMALE | 8 | 劳拉女声【注意】劳拉女声无法播放中文文本 |

## 示例代码

本示例通过 VoiceList 实现语音包列表的展示以及切换，并通过 speak 方法实现文本播报。

```typescript
import { BroadCastUtil, VoiceList } from 'module_voice_broadcast';

@Entry
@ComponentV2
struct Broadcast {
  textCn: string = '这是一段文本';
  textUs: string = 'This is a piece of text';

  build() {
    Column({ space: 30 }) {
      Row({ space: 20 }) {
        TextInput({ text: this.textCn }).layoutWeight(1).enabled(false)
        SymbolGlyph($r('sys.symbol.speaker')).fontSize(20).fontWeight(FontWeight.Medium).onClick(() => {
          BroadCastUtil.speak(this.textCn);
        })
      }.width('calc(100% - 32vp)').justifyContent(FlexAlign.SpaceBetween)

      Row({ space: 20 }) {
        TextInput({ text: this.textUs }).layoutWeight(1).enabled(false)
        SymbolGlyph($r('sys.symbol.speaker')).fontSize(20).fontWeight(FontWeight.Medium).onClick(() => {
          // 劳拉音色下无法播放中文文本
          BroadCastUtil.speak(this.textUs);
        })
      }.width('calc(100% - 32vp)').justifyContent(FlexAlign.SpaceBetween)

      Blank().layoutWeight(1)

      VoiceList()
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('sys.color.background_primary'))
    .padding({ top: 20 })
  }
}
```

## 更新记录

### 1.0.0 (2025-08-30)

- 初始版本

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

| 版本 | 兼容性 |
| :--- | :--- |
| 5.0.5 | 支持 |
| 5.1.0 | 支持 |
| 5.1.1 | 支持 |
| 6.0.0 | 支持 |

### 应用类型

| 类型 | 兼容性 |
| :--- | :--- |
| 应用 | 支持 |
| 元服务 | 支持 |

### 设备类型

| 类型 | 兼容性 |
| :--- | :--- |
| 手机 | 支持 |
| 平板 | 支持 |
| PC | 支持 |

### DevEco Studio 版本

| 版本 | 兼容性 |
| :--- | :--- |
| DevEco Studio 5.1.1 | 支持 |
| DevEco Studio 6.0.0 | 支持 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/35a25413b0864074917692d6fcc5c4d2/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%AF%AD%E9%9F%B3%E6%92%AD%E6%8A%A5%E7%BB%84%E4%BB%B6/module_voice_broadcast1.0.0.zip