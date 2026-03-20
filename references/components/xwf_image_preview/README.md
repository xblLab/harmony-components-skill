# ImagePreview 图片预览组件

## 简介

ImagePreview 提供图片预览组件。

1. 支持单击切换背景
2. 双击放大缩小
3. 双指捏合对图片进行缩放
4. 图片在放大模式下，滑动图片查看图片的对应位置
5. 提供一些自定义属性和事件监听

## 详细介绍

### 简介

ImagePreview 提供图片预览组件。

- 支持单击切换背景
- 双击放大缩小
- 双指捏合对图片进行缩放
- 图片在放大模式下，滑动图片查看图片的对应位置
- 提供一些自定义属性和事件监听

图片预览在应用开发中是一种常见场景，在诸如 QQ、微信、微博等应用中均被广泛使用。基于 Image 组件实现了简单的图片预览功能。

### 已知问题

共享动画不理想

### 下载安装

```bash
ohpm install @xwf/image_preview
```

### 权限

无需权限，若使用网络资源图片，需要互联网访问权限。

### 属性列表

| 属性名 | 类型 | 必须 | 默认值 | 描述 |
| :--- | :--- | :--- | :--- | :--- |
| option | ImagePreviewOption | 是 | null | 配置选项，集体如下介绍 |
| colors | Color[] | 否 | `[Color.Black, Color.White]` | 单击切换背景颜色列表 |
| indicator | DotIndicator | boolean | 否 | DotIndicator 指示器样式 |
| onChange | `(index: number) => void` | 否 | null | 页标改变监听 |

### ImagePreViewOption

| 属性名 | 类型 | 必须 | 默认值 | 描述 |
| :--- | :--- | :--- | :--- | :--- |
| images | ImageType[] | 是 | null | 图片数据集合 |
| index | number | 是 | null | 当前要显示的下标 |

### 共享元素转场

当配置共享元素转场 id 生成策略后，源图片的共享元素 id 也必须与其一致，例如：

```typescript
Image(item)
  .width(100)
  .height(100)
  .sharedTransition(JSON.stringify(item))
```

### 使用示例

#### 列表页

```typescript
import { LengthMetrics } from '@kit.ArkUI';
import { pushImagePreview } from './ImagePreviewPage';

@Entry
@Component
struct Index {
  private imageItems: string[] = [
    'https://img1.baidu.com/it/u=2807075789,3434543590&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=889',
    'https://i1.hdslb.com/bfs/archive/70d35ce74229979f56a53aa0a8b6102ba6ac8c2f.jpg',
    'http://img1.baidu.com/it/u=3486444881,3428035254&fm=253&app=138&f=JPEG?w=800&h=1433',
    'https://wx3.sinaimg.cn/mw690/006KbSl7ly1hs3f42qj74j30pc190az5.jpg',
    'https://up.enterdesk.com/edpic_source/3e/7c/56/3e7c56494327efb5dfe650ff4706bba9.jpg',
    'https://uploadfile.bizhizu.cn/up/3e/08/cd/3e08cdb77c4eaa33c3155d9cd1d53790.jpg.source.jpg',
    'https://p5.itc.cn/q_70/images01/20230828/7fd6b79465d84193b728e8043dd8cc8e.png',
    'https://wx2.sinaimg.cn/mw690/006dJslggy1hpalh2azxkj31401z4hdu.jpg',
    'https://up.enterdesk.com/edpic_source/aa/5e/d6/aa5ed61e5866f2b15bbc0f0bdf1d905f.jpg'
  ]

  build() {
    Column() {
      Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) } }) { // 子组件多行布局
        ForEach(this.imageItems, (item: string, index: number) => {
          Image(item)
            .width(80)
            .height(80)
            //.sharedTransition(JSON.stringify(item))
            .onClick(() => {
              pushImagePreview({ images: this.imageItems, index: index })
            })
        })
      }
      .width(80 * 3 + 10 * 2)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .height('100%')
    .width('100%')
  }
}
```

#### 预览页

```typescript
import { ImagePreviewOption } from 'ImagePreview/src/main/ets/model/ImagePreviewOption'
import { ImagePreview } from 'ImagePreview/src/main/ets/view/ImagePreview'
import { promptAction, router } from '@kit.ArkUI'

export function pushImagePreview(option: ImagePreviewOption) {
  router.pushUrl({
    url: 'pages/ImagePreviewPage',
    params: option
  })
}

@Entry
@Component
struct ImagePreviewPage {
  data: ImagePreviewOption = router.getParams() as ImagePreviewOption

  build() {
    Stack() {
      ImagePreview({
        option: this.data,
        colors: [Color.Black, Color.White],
        indicator: new DotIndicator().color(Color.Gray).selectedColor(Color.Blue),
        onChange: (index: number) => {
          promptAction.showToast({ message: `切换到:${index}` })
        }
      })
    }
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .height('100%')
    .width('100%')
  }
}
```

## 更新记录

### 1.0.1 (2025-10-11)

- **优化内容**: 优化导出权限与隐私基本信息
- **权限名称**: 暂无
- **权限说明**: 暂无
- **使用目的**: 暂无
- **隐私政策**: 不涉及
- **SDK 合规使用指南**: 不涉及
- **兼容性**: HarmonyOS 版本 5.0.0
- **应用类型**: 应用
- **元服务**: 
- **设备类型**: 手机、平板、PC
- **DevEcoStudio 版本**: DevEco Studio 5.0.0

## 安装方式

```bash
ohpm install @xwf/image_preview
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/d4115945268f473c8bad0dd843c61d30/PLATFORM?origin=template