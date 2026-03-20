# ibest-ui 组件

## 简介

一个轻量、简单易用、可定制主题、支持深色模式和浅色模式的 HarmonyOS 开源 UI 组件库，包含 Button、Calendar、Form、Field、Picker、Popup、Toast、Dialog、ImageCropper 等 50+ 个优质组件。

## 详细介绍

### 介绍

IBest-UI 由 安徽百得思维信息科技有限公司 开源，是一个轻量、简单易用、可定制主题、支持深色模式和浅色模式的 HarmonyOS 开源 UI 组件库，包含 Button、Calendar、Form、Field、Picker、Popup、Toast、Dialog、ImageCropper 等 60+ 个优质组件，上手简单，使用方便，可大大提高 HarmonyOS 开发者的开发效率。
目前 ibestservices 官方 提供了 V1 和 V2 版本，当前为状态管理 V1 版本，开发者可根据自己项目使用的状态管理版本选择对应的版本进行开发，官方推荐使用 V2。

### 特性

- 70+ 个高质量组件，覆盖移动端主流场景
- 单元测试覆盖率超过 90%，提供稳定性保障
- 提供丰富的中文文档和组件示例
- 支持主题定制，内置 100+ 个主题变量
- 支持元服务
- 支持深色模式
- 支持国际化

### 体验预览

升级到 HarmonyOS NEXT 的手机，可在应用商店搜索 best、ibest 关键字，下载第一个名为 IBest-UI 的应用，即可体验。

### 下载安装

深色代码主题复制

```bash
ohpm install @ibestservices/ibest-ui
```

### 组件库版本与编辑器版本对应关系

| 组件库版本 | 编辑器版本 |
| :--- | :--- |
| v2.2.6 及以上 | 6.0.1(21) 以上 |
| v2.2.0 及以上 | 5.1.1(19) 以上 |
| v2.1.4 及以上 | 5.0.5(17) 以上 |
| v2.0.8 及以上 | 5.0.3(15) 以上 |

### 组件介绍

#### 基础组件

##### 组件介绍

- **Button 按钮**: 按钮按钮用于触发一个操作，如提交表单。
- **Cell 单元格**: 单元格单元格为列表中的单个展示项。
- **Icon 图标**: 基于字体的图标集，可以通过 IBestIcon 组件使用。
- **Popup 弹出层**: 弹出层容器，用于展示弹窗、信息提示等内容，支持多个弹出层叠加展示。
- **Toast 轻提示**: 在页面中间弹出黑色半透明提示，用于消息通知、加载提示、操作结果提示等场景。

#### 表单组件

##### 组件介绍

- **Calendar 日历**: 日历用于选择单个、多个日期或日期范围。
- **Caliper 卡尺**: 用于选择某个范围内的值。
- **CarInput 车牌输入框**: 用于输入车牌号码。
- **CarKeyboard 车牌键盘**: 带网格的输入框组件，通常与车牌输入框组件或其它自定义输入框配合使用。
- **Cascader 级联选择器**: 级联选择框，用于多层级数据的选择，典型场景为省市区选择。
- **Checkbox 复选框**: 在一组备选项中进行多选。
- **DatePicker 日期选择**: 日期选择器，用于选择年、月、日，通常与弹出层组件配合使用。
- **DateTimePicker 日期时间选择**: 日期时间选择器，用于选择年、月、日、时、分、秒，通常与弹出层组件配合使用。
- **Field 输入框**: 用户可以在文本框内输入或编辑文字。
- **Form 表单**: 用于数据录入、校验，支持输入框、单选框、复选框、文件上传等类型，需要与 Field 输入框 组件搭配使用。
- **NumberKeyboard 数字键盘**: 虚拟数字键盘，可以配合密码输入框组件或自定义的输入框组件使用。
- **PasswordInput 密码输入框**: 带网格的输入框组件，可以用于输入密码、短信验证码等场景，通常与数字键盘组件配合使用。
- **Picker 选择器**: 提供多个选项集合供用户选择，支持单列选择、多列选择和级联选择，通常与弹出层组件配合使用。
- **PickerGroup 选择器组**: 用于结合多个 Picker 选择器组件，在一次交互中完成多个值的选择。
- **Radio 单选框**: 在一组备选项中进行单选。
- **Rate 评分**: 用于对事物进行评级操作。
- **Search 搜索**: 用于搜索场景的输入框组件。
- **Signature 签名**: 用于签名场景的组件，基于 Canvas 实现。
- **Slider 滑块**: 滑动输入条，用于在给定的范围内选择一个值。
- **Stepper 步进器**: 步进器由增加按钮、减少按钮和输入框组成，用于在一定范围内输入、调整数字。
- **Switch 开关**: 用于在打开和关闭状态之间进行切换。
- **TimePicker 时间选择**: 日期选择器，用于选择年、月、日，通常与弹出层组件配合使用。
- **Uploader 文件上传**: 用于将本地的图片或文件上传至服务器，并在上传过程中展示预览图和上传状态。目前 Uploader 组件不包含将文件上传至服务器的接口逻辑，该步骤需要自行实现。
- **WeekPicker 周选择**: 周选择器，用于选择周，通常与弹出层组件配合使用。

#### 反馈组件

##### 组件介绍

- **ActionSheet 动作面板**: 底部弹起的模态面板，包含与当前情境相关的多个选项。
- **Dialog 弹出框**: 弹出模态框，常用于消息提示、消息确认，或在当前页面内完成特定的交互操作。支持组件调用和函数调用两种方式。
- **DropdownMenu 下拉菜单**: 向下弹出的菜单列表。
- **FloatBubble 浮动气泡**: 悬浮在页面边缘的可点击气泡。
- **Guide 引导**: 分步引导用户了解产品功能的气泡组件，用来引导用户并介绍产品。
- **Loading 加载**: 加载图标，用于表示加载中的过渡状态。
- **Notify 消息提示**: 在页面顶部展示消息提示。
- **PullRefresh 下拉刷新**: 轻量级，用于提供下拉刷新的交互操作。
- **SwipeCell 滑动单元格**: 可以左右滑动来展示操作按钮的单元格组件。

#### 展示组件

##### 组件介绍

- **Avatar 头像**: 用于展示用户头像。
- **Badge 徽标**: 在右上角展示徽标数字或小红点。
- **Card 卡片**: 用于将内容展示在有阴影的容器中。
- **CircleProgress 环形进度条**: 圆环形的进度条组件。
- **Collapse 折叠面板**: 将一组内容放置在多个折叠面板中，点击面板的标题可以展开或收缩其内容。
- **CountDown 倒计时**: 用于实时展示倒计时数值，支持毫秒精度。
- **CountTo 数字滚动**: 用于需要滚动数字到某一个值的场景，目标要求是一个递增的值。
- **Divider 分割线**: 用于将内容分隔为多个区域。
- **Empty 空状态**: 空状态时的占位提示。
- **Highlight 高亮文本**: 高亮指定文本内容。
- **ImagePreview 图片预览**: 图片放大预览。
- **Mosaic 马赛克**: 用于将一块内容进行马赛克处理。
- **NoticeBar 通知栏**: 用于循环播放展示一组消息通知。
- **Popover 气泡弹出框**: 弹出式的气泡菜单。
- **Price 价格**: 用于展示价格。
- **Progress 进度条**: 用于展示操作的当前进度。
- **ReadMore 查看更多**: 用于内容超出指定高度时，显示"展开/收起"按钮。
- **RollingText 翻滚文本**: 文本翻滚动效，可以翻滚数字。
- **SectorProgress 扇形进度条**: 用于展示进度、占比。
- **Segmented 分段控制器**: 用于展示多个选项并允许用户选择其中单个选项。
- **Skeleton 骨架屏**: 用于在内容加载过程中展示一组占位图形。
- **Steps 步骤条**: 用于展示操作流程的各个环节，让用户了解当前的操作在整体流程中的位置。
- **Table 表格**: 用于展示多条结构类似的数据。
- **Tag 标签**: 用于标记关键词和概括主要内容。
- **TextEllipsis 文本省略**: 对长文本进行省略，支持展开/收起。
- **Tree 树形控件**: 用清晰的层级结构展示信息，可展开或折叠。
- **Watermark 水印**: 在页面上添加特定的文字或图案作为水印，可用于防止信息盗用。

#### 导航组件

##### 组件介绍

- **NavBar 导航栏**: 为页面提供导航功能，常用于页面顶部。
- **Pagination 分页**: 数据量过多时，采用分页的形式将数据分隔，每次只加载一个页面。
- **SideBar 侧边导航**: 垂直展示的导航栏，用于在不同的内容区域之间进行切换。
- **Tab 标签页**: 选项卡组件，用于在不同的内容区域之间进行切换。

#### 业务组件

##### 组件介绍

- **CanvasDrawer 画布绘制**: 用于绘制海报、图片加水印等场景。
- **ColorPicker 颜色选择**: 用于选择颜色。
- **ContactAddress 联系人地址**: 用于选择联系人地址，可粘贴识别。
- **GridsAlbum 九宫格相册**: 用于将图片分块展示在九宫格内。
- **ImageCropper 图片裁剪**: 用于裁剪图片。
- **InputTag 标签输入框**: 用于通过输入方式创建标签。

### 需要权限

```
ohos.permission.INTERNET
```

### 官方生态

#### 项目描述

- **@ibestservices/ibest-ui-v2**: 一个轻量、简单易用、可定制主题、支持深色模式和浅色模式的 HarmonyOS 开源 UI 组件库，基于状态管理 v2 版本。
- **@ibestservices/ucharts**: 一个类型丰富、高性能、可扩展、支持主题定制的图表库。
- **@ibestservices/area-data**: 中国省市区数据，适用于 ArkUI 的 TextPicker 和 IBest-UI 的 IBestCascader 等组件。
- **@ibestservices/ibest-orm**: 一个轻量、简单易用、全功能、支持实体关联、事务、自动迁移的 HarmonyOS 开源 ORM 工具库。
- **@ibestservices/ibest-barcode**: 一个轻量、简单易用的 HarmonyOS 开源条形码组件，支持 CODE39、CODE93、CODE128、EAN13、UPC、ITF、MSI、Pharmacode、Codabar 等多种条码类型。

### 约束与限制

在下述版本验证通过：

```text
深色代码主题复制
DevEco Studio 5.1.1 Release
Build #DS-233.14475.28.36.511840
构建版本：5.1.1.840, built on September 5, 2025
Runtime version: 17.0.12+1-b1087.25 amd64
VM: OpenJDK 64-Bit Server VM by JetBrains s.r.o.
Windows 11.0
GC: G1 Young Generation, G1 Old Generation
Memory: 2048M
Cores: 20
Registry:
 idea.plugins.compatible.build=IC-233.14475.28
Non-Bundled Plugins:
 com.alibabacloud.intellij.cosy (2.6.4)
```

### 开源协议

本项目基于 MIT 协议，请自由地享受和参与开源。

### 更新记录

#### 2.2.6 - 6.0.1(21)

**新增:**

- 新增 IBestTabBar 标签栏 组件;
- IBestCell 新增 valueFontSize 属性;
- IBestSearch 新增 caretColor 属性;
- IBestBadge、IBestAvatar 新增 xOffset、yOffset 属性;
- IBestCard 新增 leftIcon、leftIconColor、leftIconSize、value、valueColor、valueFontSize;
- IBestTabs、IBestSegmented 选项支持动态更新;
- IBestSegmented options 新增 IBestSegmentedItem 类型;
- IBestTable 新增 scrollBarState 属性，支持设置多级表头.

**优化:**

- IBestCaliper 性能优化;
- IBestPullRefresh 内容高度优化.

#### 2.2.5

**新增:**

- 新增 IBestWeekPicker 周选择 组件;
- 新增 IBestCard 卡片 组件;
- 新增 IBestMosaic 马赛克 组件;
- 新增 IBestGridsAlbum 九宫格相册 组件;
- 新增 IBestInputTag 标签输入框 组件;
- IBestCalendar 支持滑动切换月份;
- IBestPicker、IBestDatePicker、IBestDateTimePicker、IBestTimePicker 新增 fontColor、fontWeight、selectedFontSize、selectedFontColor、selectedFontWeight 属性;
- IBestTable 新增 spanMethod 属性，支持合并单元格;
- IBestContactAddress 新增 regionData 属性;
- IBestFloatBubble isMagnetic autoHide 支持动态更新.

**优化:**

- 移除 @ibestservices/area-data、dayjs、Lunar 依赖.

**Bug 修复:**

- IBestNavBar 标题居左，且右侧自定义超过两个图标时，标题位置显示异常问题.

#### 2.2.2

**新增:**

- 新增 IBestTree 树形控件;
- 全局配置新增 fontNames 属性，支持在包含图标的组件上使用自定义图标;
- IBestButton 新增 btnBorder 属性;
- IBestCascader 新增 selectAnyLevel 属性;
- IBestCheckbox 新增 radius 属性;
- IBestField required rules 支持动态验证;
- IBestToast show 方法支持 Resource 类型;
- IBestActionSheet 新增 keyboardAvoidMode 属性;
- IBestProgress 新增 radius 属性;
- IBestSteps 支持异步、动态更新.

**Bug 修复:**

- IBestCaliper 小数刻度显示问题;
- IBestImagePreview closeOnClickImage 为 false 时不生效问题，优化性能;
- IBestPullRefresh onRefresh 初始状态时重复执行问题.

#### 2.2.0 - 5.1.1(19)

**新增:**

- 新增 IBestPrice 价格组件;
- 新增 IBestRollingText 翻滚文本组件;
- IBestSwitch 新增 componentWidth componentPadding activeText inactiveText activeIcon inactiveIcon textFontSize activeTextColor inactiveTextColor activeValue inactiveValue 属性;
- IBestField 新增 inputFilter 属性;
- IBestForm 新增导出 IBestFieldValidateInfo IBestFormValidateResult IBestFieldValidateResult 类型;
- IBestSlider 新增 onTouchStart onTouchMove onTouchEnd 事件;
- IBestHighLight 新增 lineHeight 属性;
- IBestPullRefresh 支持自动下拉加载;
- IBestSideBarItem 新增 contentPadding 属性;
- IBestTable 支持动态更新.

**Bug 修复:**

- IBestSideBarItem defaultBuilder 不生效问题;
- IBestNavBar isShowRight 动态配置时右侧间距问题;
- IBestTableColumn cellAlign 不生效问题.

#### 2.1.9

**新增:**

- 新增 IBestCaliper 卡尺 组件;
- 新增 IBestReadMore 查看更多 组件;
- 新增 IBestSegmented 分段控制器 组件;
- IBestIcon 新增 iconAnimation 属性;
- IBestActionSheet onSelect 新增 name 参数;
- IBestSlider 新增 ticks 属性;
- IBestStepper 新增 minusBtnBgColor minusBtnBorderColor minusBtnIconColor plusBtnBgColor plusBtnBorderColor plusBtnIconColor inputBgColor 属性.

**Bug 修复:**

- IBestPicker 选项 value 值为 0 时切换返回空问题;
- IBestCascader 异步加载方式重复打开报错问题;
- IBestRadio type 为 dot 时中心不显示问题.

#### 2.1.8

**新增:**

- IBestIcon 新增 fontName 属性，支持使用自定义图标;
- IBestCalendar 新增 value 属性，支持双向绑定;
- IBestSearch 新增 outPadding 属性;
- IBestDropdownMenu 新增 dropDownIconSize 属性，IBestDropdownItem 新增 maxHeight beforeOpen 事件，IBestDropdownMenuOption 新增 iconPosition 属性;
- IBestHighlight 新增 onKeywordClick 事件;
- IBestImageCropper 新增 enableRotate maxAngle 属性，IBestImageCropperController 新增 setScale setAngle reset 方法;
- IBestTabItemType 新增 iconPosition 属性.

**优化:**

- IBestCollapseItem readOnly 为 true 时不显示右侧箭头.

**Bug 修复:**

- IBestSteps type 为 num 类型时，activeColor 属性未生效问题;
- IBestColorPicker 滑动时色相滑块抖动问题;
- IBestSideBar maxHeight 无效问题;
- IBestCollapseItem isShowBorder 无效问题;
- IBestTable 高度问题.

#### 2.1.7

**新增:**

- IBestCheckBox value 值新增 string number 类型，新增 trueValue falseValue 属性;
- IBestField 新增 inputFontColor borderSizeType borderLeft fieldPadding bdColor prefixIcon prefixSize suffixIcon suffixSize showValue 属性，type 新增 new-password 类型;
- IBestForm 新增 setFormValues 方法.

**优化:**

- IBestCheckBox 异步切换时动画.

**Bug 修复:**

- IBestCellGroup 在存在 title 时，顶部圆角不生效问题;
- IBestForm value 为 boolean 类型且自定义表单项时，值为 false 会触发校验问题;
- IBestTextEllipsis 字符串中有表情时行数异常问题;
- IBestDropdownMenu 在 close 方法执行多次时报错问题.

#### 2.1.6

**新增:**

- 新增 IBestAvatar 头像组件;
- 新增 IBestAvatarGroup 头像组组件;
- 新增 IBestSectorProgress 扇形进度条;
- IBestButton 新增 btnPadding stateEffect 属性;
- IBestCellGroup 新增 outerMargin 属性;
- IBestPicker IBestDatePicker IBestDateTimePicker IBestTimePicker 新增 radius 属性;
- IBestDivider 新增 dashGap dashWidth rightLineColor rightDashed 属性;
- IBestBadge 新增 icon iconSize iconColor 属性;
- IBestTabs 新增 outerRadius 属性;
- 全局配置新增 avatar 属性.

**Bug 修复:**

- IBestCollapseItem 内容变化时高度未自适应问题;
- IBestSteps 步骤较多时进度与点无法对齐问题;
- IBestStepper 有小数时无法增加问题;
- IBestDropdownMenu 在页面返回没有关闭问题.

#### 2.1.4 - 5.0.5(17)

**新增:**

- 新增 IBestContactAddress 联系人地址组件;
- IBestCell 新增 arrowSize arrowColor cellPadding 属性;
- IBestCalendar 新增 showOtherMonthDate 属性;
- IBestCountDown 新增 onFinish 事件;
- IBestCountTo 新增 onFinish 事件;
- IBestDatePicker 新增 lunar 属性，支持显示农历;
- IBestNavbar 新增 expandSafeAreaType 属性;
- IBestUpload 新增 imageSelectOption fileSelectOption beforeRemove 属性，onRemove onFileClick 事件; IBestUploaderFile 类型新增 uploadUrl 属性;
- IBestTextEllipsis 新增 textFontWeight actionFontWeight 属性;
- IBestHighLight keywords 新增 IBestHighlightKeywords 类型，支持设置不同颜色、字体大小的高亮词;
- IBestSteps 新增 bgColor 属性.

**优化:**

- IBestCell 传入 rightIcon 时保留箭头，左右图标支持内置图标名;
- 部分组件 radius 支持自定义设置位置.

**Bug 修复:**

- IBestTable 自定义表格内容时，边框线高度不一致问题;
- IBestButton btnBorderRadius 0 未生效问题;
- IBestProgress 进度条宽度较宽时文字错位问题;
- IBestHighlight text 动态修改时，文字未同步变化问题;
- IBestField autosize 为 true 时 inputAlign 不生效问题.

#### 2.1.2

**新增:**

- IBestDropdownMenu 下拉菜单组件;
- IBestGuide 引导组件;
- IBestToast 新增 onClosed 事件;
- IBestCellGroup 新增 titlePadding;
- IBestCell 新增 titleFontSize labelFontSize 属性;
- IBestSlider 新增 customSecondButton 属性.

**优化:**

- IBestCascader 选项支持动态传入;
- IBestCell 使用 valueBuilder 时保留箭头;
- IBestCollapse 支持 activeName 切换;
- IBestCollapseItem 优化高度获取;
- IBestPopup 优化居中时关闭的延迟.

**Bug 修复:**

- IBestNoticeBar 在文字未超出宽度时也会自动滚动问题;
- IBestFloatBubble 点击穿透问题.

#### 2.1.1

**新增:**

- IBestFloatBubble 悬浮球 组件;
- IBestCarKeyboard 车牌键盘 组件;
- IBestCarInput 车牌输入框 组件;
- IBestPasswordInput 新增 autoFocus showCursor highlightType 属性;
- IBestWatermark 新增 contentInteractive 属性.

**优化:**

- 日历农历初一日显示为月份.

**Bug 修复:**

- IBestImagePreview 侧滑关闭后无法打开问题;
- 修复 IBestDialog buttonSpace 不生效问题.

#### 2.1.0

**新增:**

- IBestCountTo 数字滚动 组件;
- IBestSkeleton 骨架屏 组件;
- IBestSteps 步骤条 组件;
- IBestPopup  新增  keyboardAvoidMode keyboardAvoidDistance levelMode levelUniqueId 参数;
- IBestDialog 新增 keyboardAvoidMode 参数;
- IBestCheckGroup、IBestRadioGroup 新增 disabled 参数.

**Bug 修复:**

- IBestActionSheet IBestDialogUtil 优化多窗口关闭;
- IBestPasswordInput 最后一位输入问题;
- IBestCheckBox 禁用状态在分组中失效问题;
- IBestStepper 输入时无法限制大小问题.

#### 2.0.9

**新增:**

- IBestColorPicker 颜色选取 组件;
- IBestDateTimePicker 日期时间选择 组件;
- IBestDialog 新增 confirmButtonFontWeight;
- IBestField 新增 messageTextAlign;
- IBestNoticeBar 新增 radius;
- IBestCalendar 新增 dayItemBuilder;
- IBestTabs 新增 showActiveLine tabLineRadius activeFontWeight activeFontSize tabContentBuilder;
- IBestTextEllipsis 新增 onActionClick.

**Bug 修复:**

- IBestDialog 组件宽度为百分比时在宽屏设备不生效问题;
- IBestPopup 组件在横屏时位置错误问题;
- IBestTextEllipsis 在文字较少时也显示操作文字问题.

#### 2.0.8 - 5.0.3(15)

**新增:**

- IBestPagination 分页组件;
- IBestButton 新增 fontWeight 属性;
- IBestHighlight 新增 maxLine overflow 属性;
- IBestCheckbox  IBestCheckboxGroup  IBestRadioGroup 新增 beforeChange;
- IBestDialog IBestPopup 新增 bgColor keyboardAvoidDistance levelMode levelUniqueId 属性;
- IBestActionSheet 新增 radius 属性;
- IBestPasswordInput 新增 onFinish;
- IBestCircleProgress 新增 onReachTarget;
- IBestProgress 新增 target onReachTarget,value 变更为双向绑定.

#### 2.0.7

**新增:**

- 适配国际化;
- IBestHighlight 高亮文本组件;
- IBestTable 表格组件;
- IBestButton iconPosition 新增 top bottom;
- IBestCheckbox 新增 bgColor bdColor 属性;
- IBestRadio 新增 bgColor bdColor 属性;
- IBestField 新增 prefix prefixFontColor suffix suffixFontColor 属性;
- IBestDialog 新增 bgImage 属性;
- IBestPopup 新增 bgImage 属性;
- IBestPullRefresh onRefresh 增加回调参数 direction.

**Bug 修复:**

- 修复日历组件在范围选择时未选日期确认后报错问题.

**优化:**

- IBestCalendar weekFirstDay 属性类型变更为 number.

#### 2.0.6

**新增:**

- 新增 IBestImageCropper 图片裁剪组件;
- IBestRadio name、IBestRadioGroup active 支持 number boolean 类型;
- IBestField verticalAlign radius 属性，rules 属性支持动态编辑;
- IBestForm validate validateField 方法支持返回 Promise;
- IBestUploader 新增 showPreviewList 属性;
- IBestPopover 新增 fixHeight maxHeight scrollBarState;
- IBestCellGroup 新增 radius 属性.

**Bug 修复:**

- 修复 IBestDatePicker IBestTimePicker title 属性不生效问题.

#### 2.0.5

**新增:**

- IBestTabs 新增 isShowActiveBg activeBgColor inactiveBgColor radius 属性;
- IBestPopover 新增 borderSizeType 属性;
- IBestForm 支持动态表单验证;
- IBestField 新增 caretColor min max 属性.

**Bug 修复:**

- 修复 IBestUploader 文件缓存路径不完整问题;
- 修复 IBestPasswordInput 密码输入框 在重新赋值时显示异常的问题;
- 修复 IBestField 必填*位置异常问题;
- 修复元服务报错问题.

#### 2.0.4

**新增:**

- 新增 IBestCanvasDrawer 画布绘制组件;
- IBestNavBar 新增 titleTextAlign 属性，适配元服务右上角胶囊位置;
- IBestPullRefresh 新增 上滑加载 配置;
- IBestPopover 新增 onOpen 事件，IBestPopoverAction 新增 value 属性;
- IBestField 新增 inputFontSize 属性.

**Bug 修复:**

- IBestPullRefresh 下拉时卡主问题.

#### 2.0.3

**新增:**

- README 添加组件介绍;
- IBestButton 新增 iconPosition 属性.

#### 2.0.2

**新增:**

- 已适配深色模式，可自定义浅色与深色主题颜色;
- 新增 SwipeCell 滑动单元格组件;
- IBestButton 新增 icon fontColor btnBorderColor btnBorderRadius 属性;
- IBestCalendar 新增 clock 打卡模式，clockSuccessText isShowUnClock unClockText 属性;
- IBestCheckbox 新增 activeList placeDirection space controller 属性;
- IBestPopup 新增 titleColor closeIconColor 属性;
- IBestField 新增 bgColor placeholderColor 属性;
- IBestRadio 新增 active placeDirection space 属性;
- IBestSearch 新增 labelColor textFontSize rightBtnBgColor rightBtnPressBgColor 属性;
- IBestSlider 新增 buttonBgColor 属性;
- IBestStepper 新增 value 属性;
- IBestUploader 新增 uploaderBgColor 属性;
- IBestWatermark 新增 bgColor 属性.

**重要变更:**

- IBestCheckbox IBestRadio IBestStepper 组件优化了使用方法，支持双向绑定，请对照文档修改.

**Bug 修复:**

- 修复 IBestField 的 onLeftIconClick 函数不执行问题;
- 修复 IBestDatePicker 组件 不显示日的情况下月份范围异常问题;
- 修复 IBestUploader 组件在元服务无法使用问题.

#### 2.0.0

**新增:**

- 新增 IBestNoticeBar 通知栏组件;
- 新增 IBestProgress 进度条组件;
- 新增 IBestPopover 气泡弹出框组件;
- 新增 IBestTextEllipsis 文本省略组件;
- 新增 IBestCountDown 倒计时组件;
- 新增 IBestSideBar 侧边导航组件;
- IBestPicker、IBestDatePicker、IBestTimePicker 新增 horizontal、itemWidth、contentHeight、optionFontSize 属性;
- IBestField 新增 showLabel 属性.

#### 1.19.0

**新增:**

- 新增 IBestNavBar 导航栏组件;
- 新增 IBestCircleProgress 环形进度条组件;
- 新增 IBestCollapse 折叠面板组件;
- 新增 IBestDivider 分割线组件;
- IBestIcon 新增 iconRadius 属性;
- IBestField 新增 leftIconSize rightIconSize labelFontSize labelColor 属性;
- IBestPasswordInput 新增 isShowBorder bdColor cellBgColor cellTextColor dotFontSize textFontSize tipFontSize 属性.

**Bug 修复:**

- 修复 IBestCalendar 在设定的跨月时间范围时，如果翻到下月，上月日期会被禁用.

#### 1.18.0

**新增:**

- 新增 IBestBadge 徽标组件;
- IBestSearch 新增 textColor 属性;
- IBestCell 新增 leftContentWidth、leftIconMarginRight、rightIconMarginLeft、leftRightPadding、borderSizeType、borderLeft、bdColor 属性;
- IBestToast 新增 iconWidth 属性;
- IBestCheckBox IBestRadio 新增 labelFontSize 属性;
- IBestEmpty 新增 emptyImgUrl 属性;
- IBestPopup 新增 headerBuilder 插槽;
- IBestSearch 新增 textColor 属性.

**重要变更:**

- 组件库全局尺寸单位默认为 vp，可自定义配置，升级后可能会出现部分组件尺寸偏大情况，只需将原先传递的尺寸改为原来一半即可.

**BUG 修复:**

- IBestToast 同时打开无法关闭问题;
- IBestCascader 异步加载时崩溃问题.

#### 1.17.1

- 修复 bug

#### 1.17.0

**新增:**

- 新增 IBestIcon 组件;
- 新增 IBestPullRefresh 下拉刷新组件;
- IBestTab 新增 onTabClick 事件;
- 增加导出 IBestCascaderContent 级联组件，可独立在页面中使用或与其他自定义组件组合使用;
- IBestCell 新增 leftIcon leftIconColor leftIconSize rightIcon rightIconColor rightIconSize 属性;
- IBestActionSheet 新增 cancelTextColor、beforeClose 属性.

另：新发布 @ibestservices/area-data 库，可用于 Cascader 相关组件.

#### 1.16.0

**新增:**

- 新增 IBestDialogUtil 弹框 API;
- IBestDialog 新增 visible、theme、buttonSpace、confirmButtonBgColor、cancelButtonBgColor、closeOnBackPress、onOpen、onClose 属性;
- 新增 IBestNotify 消息提示 API;
- IBestToast 新增 showLoading 方法.

**变更:**

- IBestDialog 组件显隐控制方式由原来的 controller 方式变为由 visible 属性控制，简化使用.

**优化:**

- 优化 IBestLoading 组件动画效果;
- 优化 IBestPopup 组件隐藏动画效果.

#### 1.15.0

**新增:**

- 新增 slider 滑块组件;
- 新增 Uploader 文件上传组件;
- 增加图片预览 api IBestImagePreview;
- tab 组件新增 fontSize 属性;
- form 组件新增 getFormValues 方法，同步获取表单数据.

**兼容变更:**

- 所有组件 (Watermark、Signature 除外) 颜色相关属性类型改为 RescourseColor.

#### 1.14.0

**新增:**

- Search 组件增加 customRightButton 属性;
- 新增 IBestActionSheet API;
- 新增 IBestSignature 组件;
- 组件库初始化变更.

#### 1.13.0

**新增:**

- 增加 search rate 组件;
- watermark 组件使用 stack 包裹;
- button 组件增加宽高设置.

#### 1.12.1

**新增:**

- watermark 引用文件大小写不一致报错 bug 修复.

#### 1.12.0

**新增:**

- 新增 numberKeyboard、passwordInput 组件;
- popup 新增 maskColor 属性;
- 新增全局初始化方法 IBestInit;
- 一些样式优化.

#### 1.11.1

- bug 修复

#### 1.11.0

**新增:**

- 新增：Picker、DatePicker、TimePicker、PickerGroup;
- Cascader 组件支持双向绑定;
- Tab 组件支持双向绑定，优化参数声明.

#### 1.10.0

**新增:**

- 增加 Form 以及 Field 组件.

#### 1.9.1

**新增:**

- Cascader 与 Popup 组件代码大小写格式纠正.

#### 1.9.0

**新增:**

- 增加 Cascader 与 Popup 组件.

#### 1.8.0

**新增:**

- 增加 tab 组件.

#### 1.7.0

**新增:**

- 增加 loading 组件;
- 修复若干 bug.

#### 1.6.0

**新增:**

- 增加 toast 组件.

#### 1.5.0

**新增:**

- 增加 calendar 组件.

#### 1.4.0

**新增:**

- 编写 stepper 组件以及对应的展示页面.

#### 1.3.0

- 兼容 API 11.

#### 1.2.0

- 增加 dialog 组件以及对应的展示页面.

#### 1.1.0

- 增加 empty 组件以及对应的展示页面.

#### 1.0.3

- checkbox 组件 UI 展示 bug 修复.

#### 1.0.2

- package 增加 keywords、tags、homepage、repository;
- 代码格式以及注释调整.

#### 1.0.1

- Readme 内容调整.

#### 1.0.0 初版

### 权限与隐私基本信息

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 | HarmonyOS 版本 5.1.1 |
| 应用类型 | 应用 Created with Pixso. |
| 元服务 | Created with Pixso. |
| 设备类型 | 手机 Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.1 Created with Pixso. |

## 安装方式

```bash
ohpm install @ibestservices/ibest-ui
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/730168628da54dcaa0183e8c1dc4eee3/PLATFORM?origin=template