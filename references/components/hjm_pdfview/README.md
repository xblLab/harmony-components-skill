# PDF 文件预览组件

## 简介

PDFView 是一款高性能预览 pdf 文件的库。

## 详细介绍

### 简介

PDFView，是一款高性能预览 pdf 文件的库。

### 功能特性

- 支持在线 PDF 文件预览
- 支持本地 rawfile 文件预览
- 使用 Lazy 懒加载方式，优化性能
- 支持分页加载
- API 12

### 下载安装

```bash
ohpm install @hjm/pdfview
```

### 接口和属性列表

#### 接口列表

| 接口 | 参数描述 |
| :--- | :--- |
| `pdfInit` | `totalPage`: 总页数<br>`pagesPerLoad`: 当前分页数<br>PDF 初始化数据回调函数 |
| `onReachEnd` | `totalPage`: 总页数<br>PDF 滑动到底部回调函数 |
| `onScrollIndex` | `pageIndex`: 当前滚动索引值<br>PDF 滑动时回调函数 |

#### 属性列表

| 属性 | 描述 |
| :--- | :--- |
| `pdfUrl` | PDF 文件地址（在线地址或者本地地址） |
| `pagesPerLoad` | 分页加载数量 |

### 性能分析

结合 HarmonyOS 官方文档要求，应用 CPU 占用峰值应 < 2% 为性能最优体验，使用 PDFView 加载 100 页的 PDF 性能表现如下：

### 使用示例

深色代码主题复制

```typescript
import { PDFView } from '@hjm/pdfview'

@Entry
@Component
struct Test8Page {
  // @State pdfUrl: string = 'https:XXXX/test/demo.pdf';  //在线地址
  @State pdfUrl: Resource = $rawfile('demo.pdf');  //本地地址

  build() {
    Column(){
      Row(){
        PDFView({
          /* 数据源 */
          pdfUrl:this.pdfUrl,
          /* 实现分页加载功能，以缩短首页加载时间。 */
          pagesPerLoad: 10,
          /**
           * PDF 初始化数据回调函数。`
           * @param {number} totalPage - PDF 文档的总页数。
           * @param {number} pagesPerLoad - 每次分页加载的页数。
           */
          pdfInit: (totalPage: number,pagesPerLoad: number) => {
            console.log('总页数为：',totalPage,'，当前分页数为：',pagesPerLoad)
          },
          /**
           * PDF 滑动到底部回调函数。
           * @param {number} totalPage - PDF 文档的总页数。
           */
          onReachEnd: (totalPage: number) => {
            console.log('总页数为：',totalPage)
          },
          /**
           * PDF 滑动时回调函数。
           * @param {number} pageIndex - PDF 文档当前滚动索引值。
           */
          onScrollIndex: (pageIndex: number) => {
            console.log(`当前滚动到第${pageIndex}页`)
          },
        })
      }
      .width('100%')
      .height('100%')

    }
    .width('100%')
    .height('100%')
  }
}
```

### 更新记录

| 项目 | 详情 |
| :--- | :--- |
| **版本** | 1.0.1 (2025-10-11) |
| **权限与隐私基本信息** | 暂无权限与隐私基本信息 |
| **权限说明** | 权限名称 权限说明 使用目的 暂无暂无暂无 |
| **隐私政策** | 隐私政策不涉及 SDK 合规使用指南 不涉及 |
| **兼容性** | HarmonyOS 版本 5.0.0 |
| **应用类型** | 应用 Created with Pixso. |
| **元服务** | Created with Pixso. |
| **设备类型** | 手机 Created with Pixso.<br>平板 Created with Pixso.<br>PC Created with Pixso. |
| **DevEcoStudio 版本** | DevEco Studio 5.0.0 Created with Pixso. |

## 安装方式

```bash
ohpm install @hjm/pdfview
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/b643fcf87fcb494cbb1bc44d534d8dc9/PLATFORM