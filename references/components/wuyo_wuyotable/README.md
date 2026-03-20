# WuyoTable 表格渲染组件

## 简介

轻量化即插即用表格渲染组件，支持多行、多列固定，二级三级表头，下滑右滑滚动查看。

## 详细介绍

### 简介

轻量化即插即用表格渲染组件，支持多行、多列固定，一级二级三级表头，下滑右滑滚动查看。

### 示例图

### 表格组件参数说明

#### WuyoTable

| 参数 | 描述 | 类型 | 默认值 | 是否必传 |
| :--- | :--- | :--- | :--- | :--- |
| rowTitle | 表头配置项（参考下面配置） | Array\<title\> | - | 是 |
| data | 数据源 | Array\<object\> | - | 是 |
| isMore | 是否显示更多按钮 | boolean | false | 否 |
| showNum | 默认渲染表格数据数量（仅在 isMore 为 true 时生效） | int | 5 | 否 |
| stripe | 是否显示斑马纹 | boolean | false | 否 |
| loading | 是否加载中 | boolean | false | 否 |
| isScroll | 是否可滑动 | boolean | false | 否 |
| fixedRowNumber | 悬浮列数（仅在 isScroll 为 true 时有效） | int | 0 | 否 |
| fixedColNumber | 悬浮行数（仅在 isScroll 为 true 时有效） | int | 0 | 否 |
| rowHeight | 表头高度 | int | 100 | 否 |
| cellHeight | 单元格高度 | int | 100 | 否 |
| cellWidth | 单元格宽度 | int | 100 | 否 |
| lineWidth | 分割线宽度 | int | 1 | 否 |
| fontSize | 字体大小 | int | 12 | 否 |
| tablePadding | 表格整体左右边距 | int | 8 | 否 |
| titleColor | 表头背景色 | string | #F8FEFF | 否 |
| lineColor | 表格分割线颜色 | string | rgba(237, 237, 237, 1) | 否 |
| loadingColor | 加载中 icon 颜色 | ResourceColor string | #00BCD4 | 否 |
| noDataText | 空数据文本提示 | string | 暂无数据 | 否 |
| noDataFontSize | 空数据文本字体大小 | int | 14 | 否 |
| noDataImgSrc | 空数据缺省图 | PixelMap ResourceStr DrawableDescriptor | - | 否 |
| defaultTableValue | 默认空值显示 | string | - | 否 |
| clickEvent | 单元格点击回调事件<br>(colData: object, rowTitle: object, index: number) => void; // 回调参数：colData 行数据；rowTitle 表头；index：数据源索引 | Function | - | 否 |

### 使用说明

#### 引入组件

```typescript
import { WuyoTable } from "@wuyo/wuyotable";
```

#### 使用组件

在页面 build 函数中渲染组件

```typescript
build({ 
  WuyoTable({...【传递参数】}) 
})
```

#### 表头配置项

```typescript
// 表头配置项
interface title {
  title: string, // 表头名称
  key?: string, // 对应数据 key 值
  fontColor?: string, // 单元格字体颜色
  fontSize?: number, // 单元格字体大小
  fontBold?: FontWeight, // 单元格字体加粗
  bgColor?: string, // 单元格背景颜色
  width?: number, // 单元格宽度
  children?: Array<title>, // 多级表头子集
}

// 一级表头
@State rowTitle: Array<title> = [
  {
    title: '序号',
    key: 'index',
  },
  {
    title: '姓名',
    key: 'name',
    fontColor: 'rgb(255, 164, 0)'
  },
  {
    title: '性别',
    key: 'sex',
  },
  {
    title: '年龄',
    key: 'age',
  },
  {
    title: '职业',
    key: 'job',
  },
  {
    title: '备注',
    key: 'remark',
  },
];

// 多级表头
@State twoRowTitle: Array<title> = [
  {
    title: '序号',
    key: 'index',
    width: 50,
  },
  {
    title: '个人基础信息',
    children: [
      {
        title: '姓名',
        key: 'name',
        fontColor: 'rgb(255, 164, 0)'
      },
      {
        title: '性别',
        key: 'sex',
      },
      {
        title: '年龄',
        key: 'age',
      },
      {
        title: '补充说明',
        children: [
          {
            title: '年龄',
            key: 'age',
          },
          {
            title: '备注',
            key: 'remark',
          },
        ]
      }
    ]
  },
]
```

#### 数据源

```typescript
@State data: Array<ESObject> = [
  {
    index: 1,
    name: '张三',
    sex: '男',
    age: 18,
    job: '程序员',
    remark: '无',
    fontColor: 'rgb(41, 173, 0)'
  },
  {
    index: 2,
    name: '李四',
    sex: '男',
    age: 19,
    job: '说唱歌手',
    remark: '无',
  },
  {
    index: 3,
    name: '王五',
    sex: '男',
    age: 25,
    job: '产品经理',
    remark: '会开车',
  },
  {
    index: 4,
    name: '赵六',
    sex: '女',
    age: 18,
    job: '测试工程师',
    remark: '',
  },
  {
    index: 5,
    name: '钱七',
    sex: '女',
    age: 17,
    job: '大学生',
    remark: '',
  },
]
```

#### 表格组件常用参数示例

```typescript
WuyoTable({
  isMore: true, // 是否显示更多按钮
  showNum: 2, // 默认渲染表格数据数量（仅在 isMore 为 true 时生效）
  stripe: true, // 是否显示斑马纹
  fixedRowNumber: 1, // 悬浮列数（仅在 isScroll 为 true 时有效）
  fixedColNumber: 1, // 悬浮行数（仅在 isScroll 为 true 时有效）
  isScroll: true, // 是否开启滑动
  cellHeight: 50, // 统一单元格高度
  rowHeight: 100, // 统一表头高度
  loading: this.loading, // 表格是否加载中
  rowTitle: this.twoRowTitle, // 表头配置项
  data: this.data, // 表格数据
  clickEvent: (colData: object, rowTitle: object, index: number) => {
    hilog.info(0xFF00, "tableClick", '%{public}s%{public}s', '点击了第', index.toString() + '条数据');
    hilog.info(0xFF00, "tableClick", '%{public}s%{public}s', '当前数据：', JSON.stringify(colData));
    hilog.info(0xFF00, "tableClick", '%{public}s%{public}s', '当前数据表头：', JSON.stringify(rowTitle));
  } // 各个单元格点击回调事件
})
```

### 更新记录

**1.0.0 (2025-10-15)**

暂无权限与隐私

**基本信息**

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

隐私政策：不涉及

SDK 合规使用指南：不涉及

兼容性：HarmonyOS 版本 5.0.5

Created with Pixso.

应用类型：应用

Created with Pixso.

元服务

Created with Pixso.

设备类型：手机

Created with Pixso.

平板

Created with Pixso.

PC

Created with Pixso.

DevEcoStudio 版本：DevEco Studio 5.0.5

Created with Pixso.

## 安装方式

```bash
ohpm install @wuyo/wuyotable
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/3d7b5991696d4095909357c836b6b131/PLATFORM?origin=template