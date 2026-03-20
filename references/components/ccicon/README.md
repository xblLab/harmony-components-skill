# ccicon 组件

## 简介

一个功能强大的 HarmonyOS 图标组件，包含 167 个内置 SVG 图标，支持多种尺寸、颜色、动画效果、主题适配和完整的图标管理系统。

## 详细介绍

### CcIcon 图标组件

#### 功能介绍

CcIcon 图标组件库（ccicon）是一个基于 ArkTS 开发的 HarmonyOS 图标 UI 组件库，旨在为开发者提供开箱即用、功能丰富的图标解决方案。内置 167 个精美 SVG 图标，涵盖 10 大分类，支持多种尺寸、颜色、动画效果和主题适配，帮助开发者快速构建美观、流畅的鸿蒙应用界面。

#### 全量功能清单

##### 核心组件

**CcIcon（核心图标组件）**

*   支持 5 种预设尺寸（TINY/SMALL/MEDIUM/LARGE/XLARGE）
*   支持自定义宽度和高度
*   支持 6 种主题颜色类型（PRIMARY/SUCCESS/WARNING/DANGER/INFO/DEFAULT）
*   支持自定义颜色（十六进制/资源颜色）
*   支持任意角度旋转
*   支持 6 种动画效果（ROTATE/SPIN/SCALE/FADE/BOUNCE/PULSE）
*   支持自定义动画持续时间
*   支持禁用状态
*   支持点击和长按事件
*   内置点击反馈动画

**CcIconButton（图标按钮组件）**

*   4 种按钮类型（PRIMARY/DEFAULT/DASHED/TEXT）
*   3 种预设尺寸
*   加载状态支持（带旋转动画）
*   徽章功能（数字/文本，自动处理 99+）
*   自定义背景色、边框色、圆角
*   圆形按钮支持
*   继承 CcIcon 所有功能
*   智能点击事件处理

**CcIconSelector（图标选择器组件）**

*   网格展示所有图标
*   实时搜索功能
*   分类筛选功能
*   自定义网格列数
*   图标选择回调
*   美观的 UI 设计

```javascript
e.hasActivated="true"=="true",e.index=isNaN(e.index-0)?0:e.index-0,e.needLicense="false"!=e.needLicense
e.hasActivated="true"=="true",e.index=isNaN(e.index-0)?0:e.index-0,e.needLicense="false"!
```

##### 技术特性

*   完整的图标管理系统：支持注册、搜索、分类管理
*   主题适配：自动适配深色/浅色主题，支持主题监听
*   高性能渲染：SVG 矢量图标，任意缩放不失真
*   完整的 TypeScript 类型定义
*   响应式设计，适配不同屏幕尺寸
*   无外部依赖，纯 ArkTS 实现
*   167 个内置图标，涵盖 10 大分类
*   详细的文档和示例

#### 环境要求

##### 开发环境

| 项目版本要求 | 说明 |
| :--- | :--- |
| DevEco Studio | 5.0.0 及以上版本 |
| HarmonyOS SDK | API 11 及以上 |
| ArkTS | 支持 ArkTS 语言特性 |
| OHPM | 最新版本 |

##### 运行环境

| 项目版本要求 | 说明 |
| :--- | :--- |
| HarmonyOS 系统 | API 11 及以上 |
| 设备类型 | 手机、平板、2in1 等 HarmonyOS 设备 |

#### 依赖说明

本组件库为纯 ArkTS 实现，无第三方依赖，可直接集成使用。

## 快速入门

### 方式一：通过 OHPM 安装（推荐）

1.  **安装组件库**

    ```bash
    ohpm install ccicon
    ```

2.  **在页面中导入组件**

    ```typescript
    import {
      CcIcon,
      CcIconButton,
      CcIconSelector,
      IconSize,
      IconColorType,
      IconAnimationType,
      IconButtonType,
      registerBuiltInIcons
    } from 'ccicon';
    ```

3.  **注册内置图标**

    在应用启动时（如 EntryAbility.ets 或首页）注册图标：

    ```typescript
    @Entry
    @Component
    struct Index {
      aboutToAppear(): void {
        // 注册所有内置图标（仅需调用一次）
        registerBuiltInIcons();
      }
      
      build() {
        // 页面内容
      }
    }
    ```

4.  **开始使用**

    ```typescript
    // 基础使用
    CcIcon({
      name: 'cc_basic_home',
      iconSize: IconSize.MEDIUM,
      colorType: IconColorType.PRIMARY
    })

    // 带动画
    CcIcon({
      name: 'cc_basic_setting',
      iconSize: IconSize.LARGE,
      iconAnimation: IconAnimationType.ROTATE
    })

    // 图标按钮
    CcIconButton({
      name: 'cc_basic_add',
      type: IconButtonType.PRIMARY,
      badge: 5,
      onButtonClick: () => {
        console.log('按钮被点击');
      }
    })
    ```

### 方式二：本地集成

1.  **下载源码**

    将 library 目录复制到你的项目中。

2.  **配置依赖**

    在项目的 oh-package.json5 中添加：

    ```json5
    {
      "dependencies": {
        "ccicon": "file:./library"
      }
    }
    ```

3.  **同步依赖**

    ```bash
    ohpm install
    ```

4.  **导入使用**

    ```typescript
    import { CcIcon, registerBuiltInIcons } from 'ccicon';

    // 注册图标
    registerBuiltInIcons();

    // 使用组件
    CcIcon({ name: 'cc_basic_home' })
    ```

## 使用样例

### 示例 1: 不同尺寸的图标

```typescript
@Component
struct IconSizeDemo {
  build() {
    Row({ space: 16 }) {
      CcIcon({ name: 'cc_basic_home', iconSize: IconSize.TINY })
      CcIcon({ name: 'cc_basic_home', iconSize: IconSize.SMALL })
      CcIcon({ name: 'cc_basic_home', iconSize: IconSize.MEDIUM })
      CcIcon({ name: 'cc_basic_home', iconSize: IconSize.LARGE })
      CcIcon({ name: 'cc_basic_home', iconSize: IconSize.XLARGE })
    }
  }
}
```

### 示例 2: 主题颜色

```typescript
@Component
struct IconColorDemo {
  build() {
    Row({ space: 12 }) {
      CcIcon({ name: 'cc_basic_heart', colorType: IconColorType.PRIMARY })
      CcIcon({ name: 'cc_basic_star', colorType: IconColorType.SUCCESS })
      CcIcon({ name: 'cc_basic_warning', colorType: IconColorType.WARNING })
      CcIcon({ name: 'cc_basic_error', colorType: IconColorType.DANGER })
      CcIcon({ name: 'cc_basic_info', colorType: IconColorType.INFO })
    }
  }
}
```

### 示例 3: 动画效果

```typescript
@Component
struct IconAnimationDemo {
  build() {
    Row({ space: 12 }) {
      // 持续旋转
      CcIcon({ 
        name: 'cc_basic_setting', 
        iconAnimation: IconAnimationType.ROTATE 
      })
      
      // 脉冲效果
      CcIcon({ 
        name: 'cc_basic_heart', 
        iconAnimation: IconAnimationType.PULSE,
        colorType: IconColorType.DANGER
      })
      
      // 弹跳效果
      CcIcon({ 
        name: 'cc_basic_star', 
        iconAnimation: IconAnimationType.BOUNCE,
        colorType: IconColorType.WARNING
      })
    }
  }
}
```

### 示例 4: 图标按钮

```typescript
@Component
struct IconButtonDemo {
  build() {
    Row({ space: 12 }) {
      // 主要按钮
      CcIconButton({ 
        name: 'cc_basic_add', 
        type: IconButtonType.PRIMARY 
      })
      
      // 带徽章
      CcIconButton({ 
        name: 'cc_basic_message', 
        type: IconButtonType.DEFAULT,
        badge: 99 
      })
      
      // 加载状态
      CcIconButton({
        name: 'cc_basic_save', 
        type: IconButtonType.PRIMARY,
        loading: true
      })
      
      // 圆形按钮
      CcIconButton({ 
        name: 'cc_basic_heart', 
        colorType: IconColorType.DANGER,
        buttonBorderRadius: 50 
      })
    }
  }
}
```

### 示例 5: 底部导航栏

```typescript
@Component
struct BottomNavigation {
  @State currentIndex: number = 0;
  
  build() {
    Row({ space: 0 }) {
      Column({ space: 4 }) {
        CcIcon({ 
          name: 'cc_basic_home',
          iconSize: IconSize.MEDIUM,
          colorType: this.currentIndex === 0 ? IconColorType.PRIMARY : IconColorType.DEFAULT
        })
        Text('首页')
          .fontSize(12)
          .fontColor(this.currentIndex === 0 ? '#007DFF' : '#666666')
      }
      .layoutWeight(1)
      .onClick(() => { this.currentIndex = 0 })
      
      Column({ space: 4 }) {
        CcIcon({ 
          name: 'cc_basic_search',
          iconSize: IconSize.MEDIUM,
          colorType: this.currentIndex === 1 ? IconColorType.PRIMARY : IconColorType.DEFAULT
        })
        Text('搜索')
          .fontSize(12)
          .fontColor(this.currentIndex === 1 ? '#007DFF' : '#666666')
      }
      .layoutWeight(1)
      .onClick(() => { this.currentIndex = 1 })
      
      Column({ space: 4 }) {
        CcIcon({ 
          name: 'cc_basic_user',
          iconSize: IconSize.MEDIUM,
          colorType: this.currentIndex === 2 ? IconColorType.PRIMARY : IconColorType.DEFAULT
        })
        Text('我的')
          .fontSize(12)
          .fontColor(this.currentIndex === 2 ? '#007DFF' : '#666666')
      }
      .layoutWeight(1)
      .onClick(() => { this.currentIndex = 2 })
    }
    .width('100%')
    .height(56)
    .backgroundColor('#FFFFFF')
  }
}
```

### 示例 6: 交互事件

```typescript
@Component
struct IconInteractionDemo {
  build() {
    Row({ space: 20 }) {
      // 点击事件
      CcIcon({ 
        name: 'cc_basic_heart',
        iconSize: IconSize.LARGE,
        colorType: IconColorType.DANGER,
        onIconClick: () => {
          AlertDialog.show({ message: '点击了图标' });
        }
      })
      
      // 长按事件
      CcIcon({ 
        name: 'cc_basic_star',
        iconSize: IconSize.LARGE,
        colorType: IconColorType.WARNING,
        onLongPress: () => {
          AlertDialog.show({ message: '长按了图标' });
        }
      })
      
      // 禁用状态
      CcIcon({ 
        name: 'cc_basic_delete',
        iconSize: IconSize.LARGE,
        disabled: true
      })
    }
  }
}
```

## 特性

*   🎨 多种尺寸和颜色 - 预设尺寸（tiny/small/medium/large/xlarge）和主题颜色
*   🎬 丰富的动画效果 - 旋转、缩放、淡入淡出、弹跳、脉冲等动画
*   🎯 交互支持 - 点击、长按事件，禁用状态
*   🌓 主题适配 - 自动适配深色/浅色主题
*   📦 图标注册系统 - 支持名称和路径两种引用方式
*   🔘 图标按钮 - 多种按钮类型、加载状态、徽章支持
*   🔍 图标选择器 - 搜索、分类、网格预览
*   📚 167 个内置图标 - 涵盖基础 UI、箭头、颜色工具、编程、图表等 10 大分类

## 安装

## API 文档

### CcIcon 组件

| 属性 | 类型 | 说明 | 默认值 |
| :--- | :--- | :--- | :--- |
| name | string | 图标名称（从注册系统获取） | - |
| src | ResourceStr | 图标路径（直接指定） | - |
| iconSize | IconSize \| number | 图标尺寸 | MEDIUM |
| iconWidth | number | 自定义宽度 | - |
| iconHeight | number | 自定义高度 | - |
| color | string \| ResourceColor | 图标颜色 | - |
| colorType | IconColorType | 主题颜色类型 | DEFAULT |
| iconRotate | number | 旋转角度 | 0 |
| iconAnimation | IconAnimationType | 动画类型 | NONE |
| animationDuration | number | 动画持续时间（毫秒） | 300 |
| disabled | boolean | 是否禁用 | false |
| onIconClick | () => void | 点击事件 | - |
| onLongPress | () => void | 长按事件 | - |

### CcIconButton 组件

继承 CcIcon 的所有属性，额外包括：

| 属性 | 类型 | 说明 | 默认值 |
| :--- | :--- | :--- | :--- |
| type | IconButtonType | 按钮类型 | DEFAULT |
| buttonBackgroundColor | string \| ResourceColor | 背景颜色 | - |
| buttonBorderColor | string \| ResourceColor | 边框颜色 | - |
| buttonBorderWidth | number | 边框宽度 | 1 |
| buttonBorderRadius | number | 圆角半径 | 4 |
| buttonPadding | number | 内边距 | 8 |
| loading | boolean | 加载状态 | false |
| badge | number \| string | 徽章内容 | - |
| buttonBadgeColor | string \| ResourceColor | 徽章颜色 | #FF4D4F |
| onButtonClick | () => void | 按钮点击事件 | - |

### CcIconSelector 组件

| 属性 | 类型 | 说明 | 默认值 |
| :--- | :--- | :--- | :--- |
| selectorIconSize | IconSize \| number | 图标尺寸 | LARGE |
| selectorIconColor | string \| ResourceColor | 图标颜色 | - |
| gridColumns | number | 网格列数 | 4 |
| showSearch | boolean | 显示搜索栏 | true |
| showCategory | boolean | 显示分类栏 | true |
| onSelect | (iconName: string) => void | 选择回调 | - |

### 枚举类型

#### IconSize

*   TINY - 16px
*   SMALL - 24px
*   MEDIUM - 32px
*   LARGE - 48px
*   XLARGE - 64px

#### IconColorType

*   PRIMARY - 主题色
*   SUCCESS - 成功色
*   WARNING - 警告色
*   DANGER - 危险色
*   INFO - 信息色
*   DEFAULT - 默认色

#### IconAnimationType

*   NONE - 无动画
*   ROTATE - 持续旋转
*   SPIN - 自旋动画
*   SCALE - 缩放动画
*   FADE - 淡入淡出
*   BOUNCE - 弹跳效果
*   PULSE - 脉冲效果

#### IconButtonType

*   PRIMARY - 主要按钮
*   DEFAULT - 默认按钮
*   DASHED - 虚线按钮
*   TEXT - 文本按钮

## 主题管理

### 切换深色模式

```typescript
import { toggleDarkMode, isDarkMode } from 'library';

// 切换主题
toggleDarkMode();

// 检查当前是否为深色模式
const dark = isDarkMode();
```

### 自定义主题

```typescript
import { setThemeConfig } from 'library';

setThemeConfig({
  isDark: false,
  primaryColor: '#007DFF',
  successColor: '#4CAF50',
  warningColor: '#FF9800',
  dangerColor: '#F44336',
  infoColor: '#2196F3'
});
```

## 图标注册

### 批量注册图标

```typescript
import { registerIcons } from 'library';

registerIcons([
  {
    name: 'icon1',
    path: $rawfile('icons/icon1.svg'),
    category: 'basic',
    tags: ['标签 1'],
    keywords: ['keyword1']
  },
  {
    name: 'icon2',
    path: $rawfile('icons/icon2.svg'),
    category: 'action',
    tags: ['标签 2'],
    keywords: ['keyword2']
  }
]);
```

### 查询图标

```typescript
import { getIconRegistry } from 'library';

const registry = getIconRegistry();

// 获取图标信息
const iconInfo = registry.getIcon('home');

// 搜索图标
const results = registry.searchIcons('home');

// 获取分类下的图标
const icons = registry.getIconsByCategory('basic');
```

## 内置图标

组件库包含 167 个 内置图标，所有图标严格遵循 `cc_类型_名称` 格式。

使用提示：所有图标使用时需要加上完整前缀，例如：`cc_basic_home`、`cc_arrow_left`、`cc_color_picker` 等

### 1️⃣ 基础 UI 图标 (basic) - 63 个

通用的界面操作和功能图标。

| 图标名称 | 说明 | 图标名称 | 说明 |
| :--- | :--- | :--- | :--- |
| cc_basic_about | 关于/信息 | cc_basic_add | 添加/新增 |
| cc_basic_business | 商务/业务 | cc_basic_cancel | 取消 |
| cc_basic_cancel_circle | 取消 (圆形) | cc_basic_case | 大小写 |
| cc_basic_check | 确认/完成 | cc_basic_check_circle | 确认 (圆形) |
| cc_basic_close | 关闭 | cc_basic_copy | 复制 |
| cc_basic_creative | 创意 | cc_basic_delete | 删除 |
| cc_basic_diff | 差异/对比 | cc_basic_edit | 编辑 |
| cc_basic_elegant | 优雅 | cc_basic_error | 错误 |
| cc_basic_export | 导出 | cc_basic_filter | 筛选 |
| cc_basic_folder | 文件夹 | cc_basic_format | 格式化 |
| cc_basic_global | 全球/世界 | cc_basic_hash | 井号 |
| cc_basic_heart | 喜欢/爱心 | cc_basic_help | 帮助 |
| cc_basic_home | 首页 | cc_basic_import | 导入 |
| cc_basic_info | 信息 | cc_basic_jian | 减少 |
| cc_basic_label | 标签 | cc_basic_link | 链接 |
| cc_basic_list | 列表 | cc_basic_list_empty | 空列表 |
| cc_basic_lock | 锁定 | cc_basic_menu | 菜单 |
| cc_basic_message | 消息 | cc_basic_mine | 我的 |
| cc_basic_more | 更多 | cc_basic_nature | 自然 |
| cc_basic_note | 笔记 | cc_basic_ok | 确定 |
| cc_basic_password | 密码 | cc_basic_play | 播放 |
| cc_basic_profile | 个人资料 | cc_basic_qrcode | 二维码 |
| cc_basic_refresh | 刷新 | cc_basic_regex | 正则表达式 |
| cc_basic_remove | 移除 | cc_basic_save | 保存 |
| cc_basic_search | 搜索 | cc_basic_security | 安全 |
| cc_basic_setting | 设置 | cc_basic_share | 分享 |
| cc_basic_sort | 排序 | cc_basic_star | 星标 |
| cc_basic_success | 成功 | cc_basic_table | 表格 |
| cc_basic_tag | 标签 | cc_basic_text | 文本 |
| cc_basic_time | 时间 | cc_basic_tools | 工具 |
| cc_basic_user | 用户 | cc_basic_view | 查看 |
| cc_basic_warning | 警告 | | |

### 2️⃣ 方向箭头 (arrow) - 5 个

方向指示和导航箭头。

| 图标名称 | 说明 |
| :--- | :--- |
| cc_arrow_down | 向下箭头 |
| cc_arrow_down_filled | 向下箭头 (实心) |
| cc_arrow_left | 向左箭头 |
| cc_arrow_right | 向右箭头 |
| cc_arrow_up | 向上箭头 |

### 3️⃣ 颜色工具 (color) - 27 个

颜色处理和转换工具图标（含 RGB 转换功能）。

| 图标名称 | 说明 | 图标名称 | 说明 |
| :--- | :--- | :--- | :--- |
| cc_color_analogous | 类似色 | cc_color_blindness | 色盲测试 |
| cc_color_brand_colors | 品牌色 | cc_color_complementary | 互补色 |
| cc_color_convert | 颜色转换 | cc_color_distance | 色差计算 |
| cc_color_gradient | 渐变色 | cc_color_hex_rgb | HEX 转 RGB |
| cc_color_match | 颜色匹配 | cc_color_mixer | 颜色混合 |
| cc_color_monochromatic | 单色系 | cc_color_name | 颜色名称 |
| cc_color_palette_generator | 调色板生成 | cc_color_picker | 颜色选择器 |
| cc_color_rgb_cmyk | RGB 转 CMYK | cc_color_rgb_hex | RGB 转 HEX |
| cc_color_rgb_hsl | RGB 转 HSL | cc_color_rgb_hsv | RGB 转 HSV |
| cc_color_rgb_lab | RGB 转 LAB | cc_color_rgb_xyz | RGB 转 XYZ |
| cc_color_seasonal_colors | 季节色 | cc_color_split_complementary | 分裂互补色 |
| cc_color_square_scheme | 方形配色 | cc_color_tetradic | 四色组 |
| cc_color_tools | 颜色工具 | cc_color_trends | 颜色趋势 |
| cc_color_triadic | 三色组 | | |

### 4️⃣ 编程代码 (code) - 13 个

编程和代码相关功能图标。

| 图标名称 | 说明 | 图标名称 | 说明 |
| :--- | :--- | :--- | :--- |
| cc_code_base64 | Base64 编码 | cc_code_generator | 代码生成器 |
| cc_code_html | HTML | cc_code_jsp | JSP |
| cc_code_md5 | MD5 加密 | cc_code_react | React 框架 |
| cc_code_sha | SHA 加密 | cc_code_tcp | TCP 协议 |
| cc_code_udp | UDP 协议 | cc_code_unicode | Unicode 编码 |
| cc_code_url | URL 编码 | cc_code_uuid | UUID 生成 |
| cc_code_vue | Vue 框架 | | |

### 5️⃣ 统计图表 (chart) - 11 个

数据统计和图表展示图标。

| 图标名称 | 说明 | 图标名称 | 说明 |
| :--- | :--- | :--- | :--- |
| cc_chart_fund_status | 资金状态 | cc_chart_income_expense | 收支统计 |
| cc_chart_ledger | 账本 | cc_chart_money | 金钱 |
| cc_chart_payables | 应付款 | cc_chart_pie_chart | 饼图 |
| cc_chart_ranking | 排名 | cc_chart_receipt | 收据 |
| cc_chart_receivables | 应收款 | cc_chart_statistics | 统计 |
| cc_chart_stats | 数据统计 | | |

### 6️⃣ 学习教育 (education) - 9 个

学习和教育相关图标。

| 图标名称 | 说明 | 图标名称 | 说明 |
| :--- | :--- | :--- | :--- |
| cc_education_dictionary | 字典 | cc_education_exam_record | 考试记录 |
| cc_education_favorite_book | 收藏书籍 | cc_education_standards | 学习标准 |
| cc_education_study_record | 学习记录 | cc_education_test | 测试考试 |
| cc_education_tutorial | 教程指南 | cc_education_wrong_book | 错题本 |
| cc_education_wrong_questions | 错题集 | | |

### 7️⃣ 设置配置 (settings) - 13 个

系统设置和配置相关图标。

| 图标名称 | 说明 | 图标名称 | 说明 |
| :--- | :--- | :--- | :--- |
| cc_settings_brightness_analyzer | 亮度分析 | cc_settings_high_voltage | 高电压 |
| cc_settings_home_config | 首页配置 | cc_settings_low_voltage | 低电压 |
| cc_settings_number | 数字设置 | cc_settings_ruler | 尺子测量 |
| cc_settings_saturation_adjuster | 饱和度调整 | cc_settings_settings | 系统设置 |
| cc_settings_temperature | 温度 | cc_settings_temperature_detector | 温度检测 |
| cc_settings_textsize | 字号大小 | cc_settings_volume | 音量 |
| cc_settings_weight | 重量 | | |

### 8️⃣ 网络互联 (network) - 3 个

网络和数据存储相关图标。

| 图标名称 | 说明 |
| :--- | :--- |
| cc_network_data_wipe | 数据擦除 |
| cc_network_internet | 互联网 |
| cc_network_storage | 数据存储 |

### 9️⃣ 工具辅助 (utility) - 9 个

实用工具和辅助功能图标。

| 图标名称 | 说明 | 图标名称 | 说明 |
| :--- | :--- | :--- | :--- |
| cc_utility_accessibility | 辅助功能 | cc_utility_batch_convert | 批量转换 |
| cc_utility_image_analyzer | 图像分析 | cc_utility_lightbulb | 灯泡/创意 |
| cc_utility_notice | 通知提醒 | cc_utility_psychology | 心理分析 |
| cc_utility_random | 随机生成 | cc_utility_random_color | 随机颜色 |
| cc_utility_tips | 提示建议 | | |

### 🔟 状态指示 (status) - 14 个

状态显示和指示图标。

| 图标名称 | 说明 | 图标名称 | 说明 |
| :--- | :--- | :--- | :--- |
| cc_status_favor | 收藏 | cc_status_favor_fill | 填充收藏 |
| cc_status_favor_filled | 已收藏 | cc_status_favorites | 收藏夹 |
| cc_status_highlight | 高亮显示 | cc_status_history | 历史记录 |
| cc_status_left | 左侧状态 | cc_status_lines | 线条 |
| cc_status_plus | 加号 | cc_status_reduce | 减少 |
| cc_status_return | 返回 | cc_status_right | 右侧状态 |
| cc_status_up | 向上状态 | cc_status_views | 浏览查看 |

### 📊 图标分类统计

| 分类 | 数量 | 占比 |
| :--- | :--- | :--- |
| 基础 UI (basic) | 63 个 | 37.7% |
| 颜色工具 (color) | 27 个 | 16.2% |
| 状态指示 (status) | 14 个 | 8.4% |
| 编程代码 (code) | 13 个 | 7.8% |
| 设置配置 (settings) | 13 个 | 7.8% |
| 统计图表 (chart) | 11 个 | 6.6% |
| 学习教育 (education) | 9 个 | 5.4% |
| 工具辅助 (utility) | 9 个 | 5.4% |
| 方向箭头 (arrow) | 5 个 | 3.0% |
| 网络互联 (network) | 3 个 | 1.8% |
| **总计** | **167 个** | **100%** |

## 使用示例

### 基础图标展示

```typescript
// 不同尺寸
Row({ space: 16 }) {
  CcIcon({ name: 'cc_basic_home', iconSize: IconSize.TINY })
  CcIcon({ name: 'cc_basic_home', iconSize: IconSize.SMALL })
  CcIcon({ name: 'cc_basic_home', iconSize: IconSize.MEDIUM })
  CcIcon({ name: 'cc_basic_home', iconSize: IconSize.LARGE })
  CcIcon({ name: 'cc_basic_home', iconSize: IconSize.XLARGE })
}
```

### 主题颜色

```typescript
Row({ space: 12 }) {
  CcIcon({ name: 'cc_basic_heart', colorType: IconColorType.PRIMARY })
  CcIcon({ name: 'cc_basic_star', colorType: IconColorType.SUCCESS })
  CcIcon({ name: 'cc_basic_warning', colorType: IconColorType.WARNING })
  CcIcon({ name: 'cc_basic_error', colorType: IconColorType.DANGER })
  CcIcon({ name: 'cc_basic_info', colorType: IconColorType.INFO })
}
```

### 动画效果

```typescript
Row({ space: 12 }) {
  CcIcon({ name: 'cc_basic_setting', iconAnimation: IconAnimationType.ROTATE })
  CcIcon({ name: 'cc_basic_heart', iconAnimation: IconAnimationType.PULSE })
  CcIcon({ name: 'cc_basic_star', iconAnimation: IconAnimationType.BOUNCE })
}
```

### 图标按钮

```typescript
Row({ space: 12 }) {
  CcIconButton({ name: 'cc_basic_add', type: IconButtonType.PRIMARY })
  CcIconButton({ name: 'cc_basic_edit', type: IconButtonType.DEFAULT })
  CcIconButton({ name: 'cc_basic_delete', type: IconButtonType.DASHED })
  CcIconButton({ name: 'cc_basic_search', type: IconButtonType.TEXT })
}
```

### 底部导航栏

```typescript
Row({ space: 0 }) {
  Column({ space: 4 }) {
    CcIcon({ name: 'cc_basic_home', iconSize: IconSize.MEDIUM, colorType: IconColorType.PRIMARY })
    Text('首页').fontSize(12)
  }.layoutWeight(1)
  
  Column({ space: 4 }) {
    CcIcon({ name: 'cc_basic_search', iconSize: IconSize.MEDIUM })
    Text('搜索').fontSize(12)
  }.layoutWeight(1)
  
  Column({ space: 4 }) {
    CcIcon({ name: 'cc_basic_user', iconSize: IconSize.MEDIUM })
    Text('我的').fontSize(12)
  }.layoutWeight(1)
}
```

查看项目中的 MainPage.ets 和 Index.ets 文件获取更多完整使用示例。

## 许可证

Apache-2.0

## 更新记录

### 1.2.0 (2025-12-02)

本次版本更新新增了 100+ 全新图标，整体视觉表现更加统一清晰，为您带来更现代、更精致的界面体验。

### 1.2.0 完善

更新动画处理机制，更符合鸿蒙风格。

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| --- | 隐私政策 | 不涉及 |
| SDK 合规 | 使用指南 | 不涉及 |

## 兼容性

| HarmonyOS 版本 | 5.0.3 |
| :--- | :--- |

| 元数据项 | 内容 | 备注 |
| :--- | :--- | :--- |
| 应用类型 | 应用 | Created with Pixso. |
| 元服务 | 元服务 | Created with Pixso. |
| 设备类型 | 手机 | Created with Pixso. |
| 设备类型 | 平板 | Created with Pixso. |
| 设备类型 | PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 | Created with Pixso. |
| DevEco Studio | 5.0.1 | Created with Pixso. |
| DevEco Studio | 5.0.2 | Created with Pixso. |
| DevEco Studio | 5.0.3 | Created with Pixso. |

## 安装方式

```bash
ohpm install ccicon
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/6bcc2d51c3a94d79b28fa1bcb4052995/7e81a9d7464241fc97febe17c28a18e4?origin=template