# 列表筛选组件

## 简介

本组件提供列表筛选组件，支持条件筛选和列表展示等功能。

## 详细介绍

### 简介

本组件提供列表筛选组件，支持条件筛选和列表展示等功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（直板机）
- **HarmonyOS 版本**：HarmonyOS 5.0.4 Release 及以上

### 快速入门

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `module_filter_list` 模块。

深色代码主题复制
```json5
// 在项目根目录 build-profile.json5 填写 module_filter_list 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
    "name": "module_filter_list",
    "srcPath": "./XXX/module_filter_list",
    }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

深色代码主题复制
```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_filter_list": "file:./XXX/module_filter_list"
}
```

### 引入组件

深色代码主题复制
```typescript
import { FilterList, FilterOption, LayoutType } from 'module_filter_list';
```

### API 参考

#### FilterList(option: FilterListOptions)

##### FilterListOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| listBuilderParam | CustomBuilder | 否 | 展示列表区域自定义内容 |
| layoutStyle | LayoutType | 否 | 筛选行布局风格 |
| filterOptions | FilterOption | 否 | 筛选条件配置 |
| onchange | (data: ResultItem[]) => void | 否 | 筛选条件改变的回调事件 |

##### LayoutType 枚举说明

| 名称 | 值 | 说明 |
| :--- | :--- | :--- |
| DEFAULT | 0 | 默认布局，无分割线，筛选条件文本弹性均匀分布 |
| SPLIT | 1 | 分割线布局，有分割线，筛选条件从左到右固定间隔分布 |

##### FilterOption 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| name | string | 是 | 筛选类型名称 |
| selectIndex | number | 是 | 备选项数组中，选中项的对应索引 |
| selectArr | string[] | 是 | 备选项数组 |

##### ResultItem 对象说明

| 参数名 | 类型 | 说明 |
| :--- | :--- | :--- |
| filterName | string | 筛选类型名称 |
| selectIndex | number | 该类型选中项的索引 |

### 示例代码

深色代码主题复制
```typescript
import { FilterList, FilterOption, LayoutType } from 'module_filter_list';

@Entry
@ComponentV2
struct Index {
  types: string[] = ['一居室', '两居室', '三居室', '四居室'];
  styles: string[] = ['原木风', '简约风', '新中式', '奶油风'];
  @Local typeIndex: number = 0;
  @Local styleIndex: number = 0;
  @Local listArr: string[] = new Array(5).fill('');
  @Local filterOptions: FilterOption[] = [
    new FilterOption('房屋户型', this.typeIndex, this.types),
    new FilterOption('房屋风格', this.styleIndex, this.styles),
  ];

  build() {
    Column() {
      FilterList(
        {
          filterOptions: this.filterOptions,
          layoutStyle: LayoutType.SPLIT,
          onchange: (res) => {
            this.typeIndex = res[0].selectIndex;
            this.styleIndex = res[1].selectIndex;
          },
        },
      ) {
        List({ space: 12 }) {
          ForEach(this.listArr, (item: string, index) => {
            ListItem() {
              Column({ space: 12 }) {
                Image($r('app.media.sample')).width('100%').height(140).borderRadius(16);
                Text(this.types[this.typeIndex] + '  ' + this.styles[this.styleIndex]);
              };
            };
          });

        }.padding({ top: 12, right: 16, left: 16 }).layoutWeight(1)
      };
    };
  }
}
```

### 更新记录

#### 1.0.1 (2025-10-31)

Created with Pixso.

下载该版本 README 内容优化。

#### 1.0.0 (2025-07-02)

Created with Pixso.

下载该版本

本组件提供列表筛选组件，支持条件筛选和列表展示等功能。

#### 权限与隐私

**基本信息**

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

**隐私政策**

不涉及

**SDK 合规使用指南**

不涉及

#### 兼容性

**HarmonyOS 版本**

- 5.0.4 (Created with Pixso.)
- 5.0.5 (Created with Pixso.)
- 5.1.0 (Created with Pixso.)
- 5.1.1 (Created with Pixso.)
- 6.0.0 (Created with Pixso.)

**应用类型**

- 应用 (Created with Pixso.)
- 元服务 (Created with Pixso.)

**设备类型**

- 手机 (Created with Pixso.)
- 平板 (Created with Pixso.)
- PC (Created with Pixso.)

**DevEcoStudio 版本**

- DevEco Studio 5.0.4 (Created with Pixso.)
- DevEco Studio 5.0.5 (Created with Pixso.)
- DevEco Studio 5.1.0 (Created with Pixso.)
- DevEco Studio 5.1.1 (Created with Pixso.)
- DevEco Studio 6.0.0 (Created with Pixso.)

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/9ad75e3f213c4320a19d1bf05225809a/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%88%97%E8%A1%A8%E7%AD%9B%E9%80%89%E7%BB%84%E4%BB%B6/module_filter_list1.0.1.zip