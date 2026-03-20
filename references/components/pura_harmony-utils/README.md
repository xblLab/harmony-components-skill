# harmony-utils

## 简介

harmony-utils 一款功能丰富且极易上手的HarmonyOS工具库，借助众多实用工具类，致力于助力开发者迅速构建鸿蒙应用。其封装的工具涵盖了APP、设备、屏幕、授权、通知、线程间通信、弹框、吐司、生物认证、用户首选项、拍照、相册、扫码、文件、日志，异常捕获、字符、字符串、数字、集合、日期、随机、base64、加密、解密、JSON等一系列的功能和操作，能够满足各种不同的开发需求。

## 详细介绍

harmony-utils(API12+)

### 🏆简介与说明

harmony-utils

一款功能丰富且极易上手的HarmonyOS工具库，借助众多实用工具类，致力于助力开发者迅速构建鸿蒙应用。其封装的工具涵盖了APP、设备、屏幕、授权、通知、线程间通信、弹框、吐司、生物认证、用户首选项、拍照、相册、扫码、文件、日志，异常捕获、字符、字符串、数字、集合、日期、随机、base64、加密、解密、JSON等一系列的功能和操作，能够满足各种不同的开发需求。

picker_utils 是harmony-utils拆分出来的一个子库，包含PickerUtil、PhotoHelper、ScanUtil。

> 📚 **温馨提示：**
> - 📕 Harmony-utils 是一款轻量化框架，虽集成了50多个工具类，体积却仅130KB。实现工具数量与轻量性能的极致平衡。
> - 📙 自1.3.2版本起，harmony-utils工具库中的方法将不再直接废弃。请各位开发者放心在第三方库及项目中使用。
> - 📒 在更新记录里，每个版本号，都有对应的最低开发工具版本，如："DevEco Studio 6.0.0 Release"。
> - 📗 使用框架前，请仔细阅读文档 和 查看使用案例。🙏
> - 📔 创作不易，请给童长老点赞👍 gitee❤️ github❤️ gitcode❤️ 三方库❤️
> - 📘 宝子们！更多惊喜请关注「 童长老 」公众号🌻

### 🌞下载安装与使用说明🙏

```bash
ohpm i @pura/harmony-utils
```

OpenHarmony ohpm 环境配置等更多内容，请参考如何安装 OpenHarmony ohpm 包

深色代码主题复制全局初始化方法，从1.2.0版本开始，在UIAbility的onCreate方法中初始化 `AppUtil.init()`

```typescript
onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
  AppUtil.init(this.context);
}
```

在代码中自行配置使用到的权限：

```json5
"ohos.permission.GET_BUNDLE_INFO" //（获取应用信息，会用到）允许查询应用的基本信息。
"ohos.permission.STORE_PERSISTENT_DATA" //（获取设备ID，会用到）允许应用存储持久化的数据，该数据直到设备恢复出厂设置或重装系统才会被清除
"ohos.permission.PRIVACY_WINDOW" //允许应用将窗口设置为隐私窗口，禁止截屏录屏
"ohos.permission.ACCESS_BIOMETRIC" //允许应用使用生物特征识别能力进行身份认证。
"ohos.permission.GET_NETWORK_INFO" //允许应用获取数据网络信息。
"ohos.permission.GET_WIFI_INFO" //允许应用获取Wi-Fi信息。
"ohos.permission.VIBRATE" //允许应用控制马达振动。
```

### 📂模块介绍

| 模块 | 说明 |
|:---|:---|
| AppUtil | APP相关工具类 |
| DeviceUtil | 设备相关工具类 |
| WindowUtil | 窗口相关工具类 |
| DisplayUtil | 屏幕相关工具类 |
| PermissionUtil | 申请授权工具类 |
| AuthUtil | 手机的生物认证（指纹、人脸、密码）工具类 |
| NetworkUtil | 网络相关工具类 |
| FileUtil | 文件操作相关工具类 |
| ImageUtil | 图片相关工具类 |
| PreviewUtil | 文件预览工具类 |
| LocationUtil | 定位工具类(WGS-84坐标系) |
| LogUtil | 日志工具类 |
| CrashUtil | 全局异常捕获，崩溃日志收集 |
| EmitterUtil | Emitter工具类（进行线程间通信） |
| WantUtil | Want工具类 |
| KvUtil | 键值型数据库工具类 |
| PreferencesUtil | Preferences（用户首选项）工具类 |
| CacheUtil | 缓存工具类 |
| LRUCacheUtil | LRUCache缓存工具类 |
| NotificationUtil | 通知工具类 |
| SnapshotUtil | 组件截图和窗口截图工具类。 |
| KeyboardUtil | 键盘工具类 |
| PasteboardUtil | 剪贴板工具类 |
| AssetUtil | 关键资产存储服务工具类 |
| ResUtil | 资源工具类 |
| ObjectUtil | 对象工具类 |
| JSONUtil | JSON工具类 |
| DateUtil | 日期工具类 |
| Base64Util | Base64工具类 |
| StrUtil | 字符串工具类 |
| CharUtil | 字符工具类 |
| NumberUtil | number工具类 |
| ArrayUtil | 集合工具类 |
| RandomUtil | 随机工具类 |
| RegexUtil | 正则工具类 |
| TypeUtil | 类型检查工具类 |
| FormatUtil | 格式化工具类 |
| ClickUtil | 节流、防抖 工具类（用于点击事件，防止按钮被重复点击） |
| TempUtil | 温度转换工具类 |
| DialogUtil | 弹窗工具类（AlertDialog） |
| ToastUtil | 吐司工具类（promptAction） |
| SM2、SM3、SM4、AES、DES、RSA、MD5、SHA、ECDSA、CryptoUtil、CryptoHelper | 加解密算法工具类<br>CryptoUtil：加解密公用工具类，配合各个加密模块使用。<br>CryptoHelper：加解密数据类型转换。 |
| PickerUtil | 拍照、文件(文件、图片、视频、音频)选择和保存,工具类。拆分至 picker_utils |
| PhotoHelper | 相册相关工具类。拆分至 picker_utils |
| ScanUtil | 码工具类（扫码、码图生成、图片识码）。拆分至 picker_utils |

### AppUtil（APP相关工具类） 使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| init | 初始化方法,缓存全局变量，在UIAbility的onCreate方法中初始化该方法 |
| isApiSupported | 检查API版本是否安全 |
| getApplicationContext | 获取应用级别的上下文的能力，ApplicationContext |
| getContext | 获取上下文，common.UIAbilityContext |
| getUIContext | 获取UIContext |
| getWindowStage | 获取WindowStage |
| getMainWindow | 获取主窗口 |
| getConfiguration | 获取应用的Configuration |
| setGrayScale | 设置灰阶，APP一键置灰 |
| setColorMode | 设置应用的颜色模式。仅支持主线程调用。设置颜色模式，包括：深色模式、浅色模式、不设置（跟随系统） |
| getColorMode | 获取应用的颜色模式 |
| setFont | 设置应用的字体类型。仅支持主线程调用 |
| setFontSizeScale | 设置应用字体大小缩放比例。仅支持主线程调用。<API13+> |
| getFontSizeScale | 获取应用字体大小缩放比例 |
| setLanguage | 设置应用的语言 |
| getLanguage | 获取应用的语言 |
| setSupportedProcessCache | 设置应用自身是否支持缓存后快速启动 |
| clearUpApplicationData | 清理应用本身的数据，同时撤销应用向用户申请的权限。 |
| killAllProcesses | 终止应用的所有进程，进程退出时不会正常走完应用生命周期。 |
| restartApp | 重启应用并拉起自身指定UIAbility。重启时不会收到onDestroy回调。 |
| exit | 主动退出整个应用；调用该方法后，任务中心的任务默认不会清理，如需清理，需要配置removeMissionAfterTerminate为true。 |
| getRunningProcessInformation | 获取有关运行进程的信息 |
| onApplicationStateChange | 注册对当前应用前后台变化的监听 |
| offApplicationStateChange | 取消对应用前后台切换事件的监听 |
| onEnvironment | 注册对系统环境变化的监听 |
| offEnvironment | 取消对系统环境变化的监听 |
| onAbilityLifecycle | 注册监听应用内生命周期 |
| offAbilityLifecycle | 取消监听应用内生命周期 |
| getKeyboardAvoidMode | 获取虚拟键盘抬起时的页面避让模式（OFFSET-上抬模式、RESIZE-压缩模式） |
| setKeyboardAvoidMode | 设置虚拟键盘弹出时，页面的避让模式 |
| isPortrait | 当前设备是否以竖屏方式显示 |
| isLandscape | 当前设备是否以横屏方式显示 |
| getStatusBarHeight | 获取状态栏的高度，单位为px |
| getNavigationIndicatorHeight | 获取底部导航条的高度，单位为px。 |
| setStatusBar | 设置沉浸式状态栏（需要配合getStatusBarHeight和getNavigationIndicatorHeight一起使用） |
| getBundleInfo/getBundleInfoSync | 获取当前应用的BundleInfo |
| getAppInfo/getAppInfoSync | 获取应用程序的配置信息 |
| getSignatureInfo/getSignatureInfoSync | 获取应用包的签名信息 |
| getBundleName | 获取应用包的名称 |
| getVersionCode | 获取应用版本号 |
| getVersionName | 获取应用版本名 |
| getTargetVersion | 获取应用运行目标版本 |
| getInstallTime | 应用包安装时间 |
| getUpdateTime | 应用包更新时间 |
| getAppProvisionType | 获取应用程序签名证书文件的类型，分为debug和release两种类型。 |
| debug | 标识应用是否处于调试模式，取值为true表示应用处于调试模式，取值为false表示应用处于非调试模式。 |

### DeviceUtil（设备相关工具类） 使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| getDeviceId | 获取设备ID（卸载APP后依旧不变，需要权限：ohos.permission.STORE_PERSISTENT_DATA） |
| deleteDeviceId | 移除设备ID |
| getODID | 获取开发者匿名设备标识符，ODID。 |
| getOAID | 获取开放匿名设备标识符，OAID。 |
| getAAID | 获取AAID。 |
| deleteAAID | 删除AAID。 |
| getSerial | 获取设备序列号。说明：可作为设备唯一识别码。示例：序列号随设备差异。 |
| getUdid | 获取设备Udid。 |
| getBrand | 获取设备品牌名称。示例：HUAWEI。 |
| getProductModel | 获取认证型号。示例：ALN-AL00。 |
| getBrandModel | 获取设备品牌名称 认证型号。示例：HUAWEI ALN-AL00。 |
| getMarketName | 获取外部产品系列名称。示例：HUAWEI Mate 60 Pro。 |
| getHardwareModel | 获取硬件版本号。示例：HL1CMSM。 |
| getManufacture | 获取设备厂家名称。示例：HUAWEI。 |
| getOsFullName | 获取系统版本 |
| getDisplayVersion | 获取产品版本。示例：ALN-AL00 5.0.0.1(XXX) |
| getBuildVersion | 获取Build版本号，标识编译构建的版本号 |
| getSdkApiVersion | 获取系统软件API版本。示例：12 |
| getOsVersion | 获取OS版本号（Major版本号,示例：5；Senior版本号，示例：0；Feature版本号，示例：0）。 |
| getAbiList | 应用二进制接口（Abi）。示例：arm64-v8a |
| getOsReleaseType | 获取系统的发布类型，取值为：Canary、Beta、Release |
| getDeviceType | 获取当前设备类型 |
| getDeviceTypeStr | 获取当前设备类型，返回字符串。 |
| getConfiguration/getConfigurationSync | 获取设备的Configuration |
| getDirection | 获取当前设备屏幕方向 |
| getDeviceCapability/getDeviceCapabilitySync | 获取设备的DeviceCapability |
| getScreenDensity | 获取当前设备屏幕密度 |
| getBatterySOC | 获取当前设备剩余电池电量百分比。 |
| getBatteryCapacityLevel | 获取当前设备电池电量的等级。 |
| getHealthStatus | 获取当前设备电池的健康状态。 |
| getBatteryTemperature | 获取当前设备电池的温度，单位0.1摄氏度。 |
| getVoltage | 获取当前设备电池的电压，单位微伏。 |
| getNowCurrent | 获取当前设备电池的电流，单位毫安。 |
| isActive | 检测当前设备是否处于活动状态。有屏的设备为亮屏状态，无屏的设备为非休眠状态。 |
| isStandby | 检测当前设备是否进入待机低功耗续航模式。 |
| getPowerMode | 获取当前设备的电源模式。 |
| startVibration | 开启设备振动 |
| stopVibration | 停止设备振动（按照VIBRATOR_STOP_MODE_TIME模式） |

### WindowUtil（窗口相关工具类） 使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| setPreferredOrientation | 设置窗口的显示方向属性 |
| getPreferredOrientation | 获取窗口的显示方向属性，主窗口调用。 |
| setWindowPrivacyMode | 设置窗口是否为隐私模式。设置为隐私模式的窗口，窗口内容将无法被截屏或录屏 |
| isPrivacyMode | 窗口是否隐私模式，默认主窗口。 |
| setWindowLayoutFullScreen | 设置窗口的布局是否为沉浸式布局（该沉浸式布局状态栏、导航栏仍然显示） |
| isLayoutFullScreen | 判断窗口是否为沉浸式，默认主窗口。 |
| setWindowSystemBarProperties | 设置主窗口三键导航栏、状态栏的属性。 |
| getWindowSystemBarProperties | 获取主窗口三键导航栏、状态栏的属性。 |
| setImmersiveModeEnabledState | 设置当前窗口是否开启沉浸式布局，该调用不会改变窗口模式和窗口大小。 |
| getImmersiveModeEnabledState | 查询当前窗口是否已经开启沉浸式布局。 |
| setWindowGrayScale | 设置窗口灰阶。该接口需要在调用loadContent()或setUIContent()使窗口加载页面内容后调用。 |
| setWindowBackgroundColor | 设置窗口的背景色。Stage模型下，该接口需要在loadContent()或setUIContent()调用生效后使用 |
| setWindowSystemBarEnable | 设置主窗口三键导航栏、状态栏、底部导航条的可见模式，状态栏与底部导航条通过status控制、三键导航栏通过navigation控制。 |
| setSpecificSystemBarEnabled | 设置主窗口三键导航栏、状态栏、底部导航条的显示和隐藏。 |
| setWindowKeepScreenOn | 设置屏幕是否为常亮状态 |
| isKeepScreenOn | 屏幕是否常亮 |
| setWindowBrightness | 设置屏幕亮度值 |
| getBrightness | 获取屏幕亮度。该参数为浮点数，可设置的亮度范围为[0.0, 1.0]，其取1.0时表示最大亮度值。如果窗口没有设置亮度值，表示亮度跟随系统，此时获取到的亮度值为-1。 |
| setWindowFocusable | 设置使用点击或其他方式使该窗口获焦的场景时，该窗口是否支持窗口焦点从点击前的获焦窗口切换到该窗口 |
| isFocusable | 窗口是否可聚焦，默认主窗口。 |
| setWindowTouchable | 设置窗口是否为可触状态 |
| isTouchable | 窗口是否可触摸，默认主窗口。 |
| getWindowProperties | 获取当前窗口的属性，默认主窗口。 |
| getWindowAvoidArea | 获取当前应用窗口内容规避的区域。如系统栏区域、刘海屏区域、手势区域、软键盘区域等与窗口内容重叠时，需要窗口内容避让的区域。 |
| getWindowType | 获取窗口类型，默认主窗口。 |
| getWindowStatus | 获取当前应用窗口的模式 |
| isFullScreen | 判断窗口是否全屏，默认主窗口。 |
| isFocused | 判断当前窗口是否已获焦 |
| isTransparent | 窗口是否透明，默认主窗口。 |
| isWindowShowing | 判断当前窗口是否已显示，默认主窗口。 |
| isWindowSupportWideGamut | 判断当前窗口是否支持广色域模式，默认主窗口。 |
| setDialogBackGestureEnabled | 设置模态窗口是否响应手势返回事件，非模态窗口调用返回错误码 |
| setGestureBackEnabled | 设置当前窗口是否禁用返回手势功能，仅主窗全屏模式下生效，2in1设备下不生效。<API13+> |
| isGestureBackEnabled | 获取当前窗口是否禁用返回手势功能，仅主窗全屏模式下生效，2in1设备不生效。<API13+> |
| moveWindowTo | 移动窗口位置，使用Promise异步回调。 |
| moveWindowToAsync | 移动窗口位置，使用Promise异步回调。 |
| resize | 改变当前窗口大小，使用Promise异步回调。 |
| resizeAsync | 改变当前窗口大小，使用Promise异步回调。 |
| createSubWindow | 创建子窗口，使用Promise异步回调。 |
| destroyWindow | 销毁窗口，使用Promise异步回调。 |
| createWindow | 创建子窗口或者系统窗口，使用Promise异步回调。 |
| findWindow | 查找name所对应的窗口。 |
| getLastWindow | 获取当前应用内最上层的子窗口，若无应用子窗口，则返回应用主窗口。 |
| shiftAppWindowFocus | 在同应用内将窗口焦点从源窗口转移到目标窗口，仅支持应用主窗和子窗的焦点转移。 |

### DisplayUtil（屏幕相关工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| getDefaultDisplaySync | 获取当前默认的display对象 |
| getPrimaryDisplaySync | 获取主屏信息。除2in1之外的设备获取的是设备自带屏幕的Display对象；2in1设备外接屏幕时获取的是当前主屏幕的Display对象；2in1设备没有外接屏幕时获取的是自带屏幕的Display对象。<API14+> |
| getAllDisplays | 获取当前所有的display对象，使用Promise异步回调 |
| getWidth | 获取设备的屏幕宽度，单位为px |
| getHeight | 获取设备的屏幕高度，单位为px |
| getOrientation | 获取设备当前显示的方向 |
| getDisplayState | 获取设备的状态 |
| getCutoutRect | 获取取挖孔屏、刘海屏、瀑布屏等不可用屏幕区域信息。建议应用布局规避该区域 |
| getCutoutHeight | 获取挖孔屏、刘海屏等不可用屏幕区域的高度，单位为px |
| isFoldable | 检查设备是否可折叠 |
| getFoldStatus | 获取可折叠设备的当前折叠状态 |
| getFoldDisplayMode | 获取可折叠设备的显示模式 |
| onFoldStatusChange | 开启折叠设备折叠状态变化的监听 |
| offFoldStatusChange | 关闭折叠设备折叠状态变化的监听 |
| onFoldAngleChange | 开启折叠设备折叠角度变化的监听。如果是双折轴设备，则有两个角度值；在充电口朝下的状态下，从右到左分别是折轴一和折轴二。 |
| offFoldAngleChange | 关闭折叠设备折叠角度变化的监听 |
| isCaptured | 检查设备是否正在截屏、投屏、录屏。 |
| onCaptureStatusChange | 开启屏幕截屏、投屏、录屏状态变化的监听。 |
| offCaptureStatusChange | 关闭屏幕截屏、投屏、录屏状态变化的监听。 |

### PermissionUtil（申请授权工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| requestPermissionsEasy | 申请授权，拒绝后并二次向用户申请授权（申请权限，建议使用该方法）。 |
| checkPermissions | 校验当前是否已经授权 |
| checkRequestPermissions | 校验是否授权后并申请授权 |
| requestPermissions | 申请授权 |
| requestPermissionOnSetting | 二次向用户申请授权（单个权限 或 读写权限组，建议使用该方法）。 |
| requestPermissionOnSettingEasy | 二次向用户申请授权（多个权限建议使用该方法）。 |
| requestGlobalSwitch | 用于UIAbility/UIExtensionAbility拉起全局开关设置弹框。部分情况下，录音、拍照等功能禁用，应用可拉起此弹框请求用户同意开启对应功能。如果当前全局开关的状态为开启，则不拉起弹框。 |

### AuthUtil（手机的生物认证(指纹、人脸、密码)工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| getAvailableStatus | 查询指定类型和等级的认证能力是否支持 |
| onStartEasy | 开始认证,使用指纹和密码认证 |
| onStart | 开始认证，用户指定类型认证 |
| cancel | 取消认证 |
| generateChallenge | 生成挑战值,用来防重放攻击 |
| getErrorMsg | 获取错误msg |

### NetworkUtil（网络相关工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| isDefaultNetMetered/isDefaultNetMeteredSync | 检查当前网络上的数据流量使用是否被计量 |
| hasDefaultNet/hasDefaultNetSync | 检查默认数据网络是否被激活 |
| getDefaultNet/getDefaultNetSync | 获取默认激活的数据网络 |
| getAppNet/getAppNetSync | 获取App绑定的网络信息 |
| getAllNets/getAllNetsSync | 获取所有处于连接状态的网络列表 |
| isNetworkAvailable | 判断当前设备网络是否可用 |
| hasNetMobile | 判断当前网络是否是蜂窝网络（移动网络）。 |
| hasNetWiFi | 判断当前网络是否是Wi-Fi网络。 |
| hasNetEthernet | 判断当前网络是否是以太网网络。 |
| hasNetVPN | 判断当前网络是否是VPN网络。 |
| hasNetBearType | 是否存在指定的网络 |
| getNetBearTypes | 获取网络类型，数组里面只包含了一种具体的网络类型。 |
| getNetBearType | 获取网络类型 |
| getNetCapabilities/getNetCapabilitiesSync | 获取netHandle对应的网络的能力信息 |
| getConnectionProperties/getConnectionPropertiesSync | 获取netHandle对应的网络的连接信息 |
| getIpAddress | 获取当前设备的IP地址(设备连接Wi-Fi后) |
| register | 订阅指定网络状态变化的通知，支持多事件监听回调 |
| unregister | 取消订阅默认网络状态变化的通知 |
| isNRSupported | 判断当前设备是否支持NR(New Radio)。也就是5G。 |
| isRadioOn | 判断Radio是否打开 |
| getPrimarySlotId | 获取主卡所在卡槽的索引号 |
| getOperatorName | 获取运营商名称 |
| getNetworkState | 获取网络状态 |
| getNetworkSelectionMode | 获取当前选网模式 |
| getSignalInformation | 获取指定SIM卡槽对应的注册网络信号强度信息列表。 |
| getNetworkType | 获取网络类型 |
| getNetworkTypeStr | 获取网络类型，返回字符类型。 |
| getDefaultCellularDataSlotId/getDefaultCellularDataSlotIdSync | 获取默认移动数据的SIM卡 |
| getCellularDataFlowType | 获取蜂窝数据业务的上下行状态 |
| getCellularDataState | 获取分组交换域(PS域)的连接状态 |
| isCellularDataEnabled/isCellularDataEnabledSync | 检查蜂窝数据业务是否启用 |
| isCellularDataRoamingEnabled/isCellularDataRoamingEnabledSync | 检查蜂窝数据业务是否启用漫游 |
| getDefaultCellularDataSimId | 获取默认移动数据的SIM卡ID。与SIM卡绑定，从1开始递增。 |
| isSimActive/isSimActiveSync | 获取指定卡槽SIM卡是否激活 |
| hasSimCard/hasSimCardSync | 获取指定卡槽SIM卡是否插卡 |
| getMaxSimCount | 获取卡槽数量 |
| getSimOperatorNumeric/getSimOperatorNumericSync | 获取指定卡槽SIM卡的归属PLMN（Public Land Mobile Network）号。 |
| getSimSpn/getSimSpnSync | 获取指定卡槽SIM卡的服务提供商名称 |
| getSimState/getSimStateSync | 获取指定卡槽的SIM卡状态 |
| getCardType /getCardTypeSync | 获取指定卡槽SIM卡的卡类型 |

### FileUtil（文件操作相关工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| getFilesDirPath | 获取文件目录下的文件夹路径或文件路径 |
| getCacheDirPath | 获取缓存目录下的文件夹路径或文件路径 |
| getTempDirPath | 获取临时目录下的文件夹路径或文件路径 |
| getDownloadPath | 获取当前应用的Download路径（Download目录下当前应用包名对应的路径） |
| getDownloadUri | 获取当前应用的Download Uri |
| saveToDownload | 将文件保存到Download目录（Download目录下当前应用包名对应的路径） |
| hasDirPath | 判断是否是完整路径 |
| getFileUri | 通过URI或路径，获取FileUri |
| getFileName | 通过URI或路径，获取文件名 |
| getFilePath | 通过URI或路径，获取文件路径 |
| getParentUri | 通过URI或路径，获取对应文件父目录的URI |
| getParentPath | 通过URI或路径，获取对应文件父目录的路径名 |
| getUriFromPath | 以同步方法获取文件URI |
| getFileExtention | 根据文件名获取文件后缀 |
| getFileDirSize | 获取指定文件夹下所有文件的大小或指定文件大小 |
| isFile | 判断文件是否是普通文件 |
| isDirectory | 判断文件是否是目录 |
| rename/renameSync | 重命名文件或文件夹，使用Promise异步回调 |
| mkdir/mkdirSync | 创建目录，当recursion指定为true，可多层级创建目录 |
| rmdir/rmdirSync | 删除整个目录，使用Promise异步回调 |
| unlink/unlinkSync | 删除单个文件，使用Promise异步回调 |
| access/accessSync | 检查文件是否存在，使用Promise异步回调 |
| open/openSync | 打开文件，支持使用URI打开文件 |
| read/readSync | 从文件读取数据 |
| readText/readTextSync | 基于文本方式读取文件（即直接读取文件的文本内容） |
| write/writeSync | 将数据写入文件 |
| writeEasy | 将数据写入文件，并关闭文件 |
| close/closeSync | 关闭文件 |
| listFile/listFileSync | 列出文件夹下所有文件名，支持递归列出所有文件名（包含子目录下），支持文件过滤 |
| stat/statSync | 获取文件详细属性信息 |
| copy | 拷贝文件或者目录，支持拷贝进度监听 |
| copyFile/copyFileSync | 复制文件 |
| moveFile/moveFileSync | 移动文件 |
| moveDir/moveDirSync | 移动源文件夹至目标路径下 |
| truncate/truncateSync | 截断文件 |
| lstat/lstatSync | 获取链接文件信息 |
| fsync/fsyncSync | 同步文件数据 |
| fdatasync/fdatasyncSync | 实现文件内容数据同步 |
| createStream/createStreamSync | 基于文件路径打开文件流 |
| fdopenStream/fdopenStreamSync | 基于文件描述符打开文件流 |
| mkdtemp/mkdtempSync | 创建临时目录 |
| dup | 将文件描述符转化为File |
| utimes | 修改文件最近访问时间属性 |
| getFormatFileSize | 格式化文件大小 |
| persistPermission/persistPermissionEasy | 对所选择的多个文件或目录URI持久化授权。（需要权限：ohos.permission.FILE_ACCESS_PERSIST） |
| revokePermission/revokePermissionEasy | 对所选择的多个文件或目录uri取消持久化授权。（需要权限：ohos.permission.FILE_ACCESS_PERSIST） |
| activatePermission/activatePermissionEasy | 对已经持久化授权的权限进行使能操作，否则已经持久化授权的权限仍存在不能使用的情况。（需要权限：ohos.permission.FILE_ACCESS_PERSIST） |
| deactivatePermission/deactivatePermissionEasy | 取消使能授权过的多个文件或目录。（需要权限：ohos.permission.FILE_ACCESS_PERSIST） |
| checkPersistentPermission | 校验所选择的多个文件或目录URI持久化授权。（需要权限：ohos.permission.FILE_ACCESS_PERSIST） |

### ImageUtil（图片相关工具类 ）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| base64ToPixelMap | 图片base64字符串转PixelMap |
| pixelMapToBase64Str | PixelMap转图片base64字符串 |
| savePixelMap | 保存pixelMap到本地 |
| saveImageSource | 保存ImageSource到本地 |
| createImageSource | 创建图片源实例 |
| createIncrementalSource | 以增量的方式创建图片源实例 |
| packingFromPixelMap | 图片压缩或重新打包，使用Promise形式返回结果 |
| packingFromImageSource | 图片压缩或重新打包，使用Promise形式返回结果 |
| packToFileFromPixelMap | 将PixelMap图片源编码后直接打包进文件 |
| packToFileFromImageSource | 将ImageSource图片源编码后直接打包进文件 |
| getPixelMapFromMedia | 用户获取resource目录下的media中的图片PixelMap |
| compressedImage | 图片压缩 |
| compressPhoto | 图片压缩，返回压缩后的图片文件路径 |

### PreviewUtil（文件预览工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| generatePreviewInfo | 根据文件uri构建PreviewInfo |
| openPreview | 通过传入文件预览信息，打开预览窗口。1秒内重复调用无效 |
| openPreviewEasy | 通过传入文件的uri，打开预览窗口。1秒内重复调用无效 |
| canPreview | 根据文件的uri判断文件是否可预览 |
| hasDisplayed | 判断预览窗口是否已经存在 |
| closePreview | 关闭预览窗口，仅当预览窗口存在时起效 |
| loadData | 加载预览文件信息。仅当预览窗口存在时起效 |
| loadDataEasy | 加载预览文件信息。仅当预览窗口存在时起效 |
| onSharePreview | 调用其他应用预览文件 |
| getTypeDescriptor | 根据文件后缀名获取TypeDescriptor（标准化数据类型的描述类） |
| getMimeType | 根据文件后缀名获取文件mimeType |
| getIconFileStr | 根据文件后缀名获取对应文件类型的图标 |

### LocationUtil（定位工具类(WGS-84坐标系)）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| isLocationEnabled | 判断位置服务是否已经使能(定位是否开启)。 |
| requestLocationPermissions | 申请定位权限 |
| getCurrentLocationEasy | 获取当前位置 |
| getCurrentLocation | 获取当前位置 |
| getLastLocation | 获取上一次位置 |
| onLocationChangeEasy | 开启位置变化订阅，并发起定位请求。 |
| onLocationChange | 开启位置变化订阅，并发起定位请求 |
| offLocationChange | 关闭位置变化订阅，并删除对应的定位请求 |
| onLocationError | 订阅持续定位过程中的错误码 |
| offLocationError | 取消订阅持续定位过程中的错误码 |
| onLocationEnabledChange | 订阅位置服务状态变化 |
| offLocationEnabledChange | 取消订阅位置服务状态变化 |
| isGeocoderAvailable | 判断地理编码与逆地理编码服务是否可用 |
| getAddressFromLocationName | 地理编码,将地理描述转换为具体坐标 |
| getGeoAddressFromLocationName | 地理编码,将地理描述转换为具体坐标集合 |
| getAddressFromLocation | 逆地理编码,将坐标转换为地理描述 |
| getGeoAddressFromLocation | 逆地理编码,将坐标转换为地理描述集合 |
| getCountryCode | 获取当前的国家码 |
| calculateDistance | 计算这两个点间的直线距离，单位为米 |
| calculateDistanceEasy | 根据指定的两个经纬度坐标点，计算这两个点间的直线距离，单位为米 |
| convertCoordinate/convertCoordinateSync | 坐标转换，将WGS84坐标系转换为GCJ02坐标系 |
| convertCoordinateEasy | 坐标转换，将WGS84坐标系转换为GCJ02坐标系 |
| getErrorMsg | 获取定位相关错误msg |

### LogUtil（日志工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| init | 初始化日志参数（该方法建议在Ability里调用） |
| setDomain | 设置日志对应的领域标识，范围是0x0~0xFFFF。（该方法建议在Ability里调用） |
| setTag | 设置日志标识（该方法建议在Ability里调用） |
| setShowLog | 是否打印日志（该方法建议在Ability里调用） |
| setHilog | 日志打印方式（该方法建议在Ability里调用） |
| debug | 打印DEBUG级别日志 |
| info | 打印INFO级别日志 |
| warn | 打印WARN级别日志 |
| error | 打印ERROR级别日志 |
| fatal | 打印FATAL级别日志 |
| print | 打印日志，无边框。 |

### CrashUtil（全局异常捕获，崩溃日志收集）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| onHandled | 注册错误观测器（该方法建议在Ability里调用）。注册后可以捕获到应用产生的js crash，应用崩溃时进程不会退出。将异常信息写入本地文件 |
| onDestroy | 注销错误观测器 |
| isHandled | 判断错误观测器是否存在 |
| getFilePath | 获取日志文件路径（用于读取异常文件、导出异常文件） |
| access | 判断日志文件是否存在 |
| delete | 删除日志文件 |
| getExceptionJson | 获取异常日志的JSON字符串 |
| getExceptionList | 获取异常日志的集合 |
| enableAppRecovery | 启用应用恢复功能，参数按顺序填入。该接口调用后，应用从启动器启动时第一个Ability支持恢复。 |
| restartApp | 重启APP，并拉起应用启动时第一个Ability，可以配合errorManager相关接口使用 |
| saveAppState | 保存当前App状态 或 主动保存Ability的状态，这个状态将在下次恢复启动时使用。可以配合errorManager相关接口使用 |
| setRestartWant | 设置下次恢复主动拉起场景下的Ability。该Ability必须为当前包下的UIAbility |

### EmitterUtil（Emitter工具类（进行线程间通信））使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| post | 发送事件 |
| onSubscribe | 订阅事件 |
| onceSubscribe | 单次订阅指定事件 |
| unSubscribe | 取消事件订阅 |
| getListenerCount | 获取指定事件的订阅数 |
| on | 订阅事件，支持Callback |
| once | 单次订阅指定事件，支持Callback |
| off | 取消事件订阅，支持Callback |

### WantUtil（Want工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| toSetting | 跳转系统设置页面（配合WantUtil里的URI常量一起使用，可跳转更多的设置页面） |
| toAppSetting | 跳转应用设置页面 |
| toNotificationSetting | 跳转通知设置页面 |
| toNetworkSetting | 跳转移动网络设置页面 |
| toWifiSetting | 跳转WLAN设置页面 |
| toBluetoothSetting | 跳转蓝牙设置页面 |
| toNfcSetting | 跳转NFC设置页面 |
| toVolumeSetting | 跳转声音和振动设置页面 |
| toStorageSetting | 跳转存储设置页面 |
| toBatterySetting | 跳转电池设置页面 |
| toWebBrowser | 拉起系统浏览器 |
| toAppGalleryDetail | 拉起应用市场对应的应用详情界面 |
| toFileManagement | 拉起系统文件管理器 |
| startMMS | 拉起短信界面并指定联系人 |
| openFile | 调用三方软件打开文件 |

### KvUtil（键值型数据库工具类 ）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| put | 添加指定类型的键值对到数据库 |
| get/getString/getNumber/getBoolean/getUint8Array | 获取指定键的值 |
| delete | 从数据库中删除指定键值的数据 |
| putBatch | 批量插入键值对到SingleKVStore数据库中 |
| deleteBatch | 批量删除SingleKVStore数据库中的键值对 |
| getEntries | 获取匹配指定键前缀的所有键值对 |
| backup | 以指定名称备份数据库 |
| restore | 从指定的数据库文件恢复数据库 |
| deleteBackup | 根据指定名称删除备份文件 |
| onDataChange | 订阅指定类型的数据变更通知 |
| offDataChange | 取消订阅数据变更通知 |

### PreferencesUtil（Preferences工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| init | 初始化 |
| put/putSync | 将数据缓存 |
| get/getSync | 获取缓存值 |
| getString/getStringSync | 获取string类型的缓存值 |
| getNumber/getNumberSync | 获取number类型的缓存值 |
| getBoolean/getBooleanSync | 获取boolean类型的缓存值 |
| has/hasSync | 检查缓存实例中是否包含给定Key的存储键值对 |
| delete/deleteSync | 删除缓存值 |
| clear/clearSync | 清空缓存 |
| deletePreferences | 从缓存中移出指定的Preferences实例，若Preferences实例有对应的持久化文件，则同时删除其持久化文件。 |
| onChange | 订阅数据变更，订阅的Key的值发生变更后，在执行flush方法后，触发callback回调 |
| offChange | 取消订阅数据变更 |
| onDataChange | 精确订阅数据变更，只有被订阅的key值发生变更后，在执行flush方法后，触发callback回调 |
| offDataChange | 取消精确订阅数据变更 |

### CacheUtil（缓存工具类 ）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| has | 缓存中的数据是否存在 |
| get | 获取缓存中的数据 |
| put | 将数据存入缓存中 |
| remove | 删除key对应的缓存 |
| isEmpty | 判断缓存是否为空 |
| clear | 清除缓存数据 |

### LRUCacheUtil（LRUCache缓存工具类 ）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| getInstance | 获取LRUCacheUtil的单例 |
| has | 判断是否包含key对应的缓存 |
| get | 获取key对应的缓存 |
| put | 添加缓存到lruCache中 |
| remove | 删除key对应的缓存 |
| isEmpty | 判断lruCache缓存是否为空 |
| getCapacity | 获取当前缓冲区的容量 |
| updateCapacity | 重新设置lruCache的容量 |
| clear | 清除缓存数据，并重置lruCache的大小 |

### NotificationUtil（通知工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| setDefaultConfig | 设置通知的默认统一配置 |
| isNotificationEnabled/isNotificationEnabledSync | 查询通知是否授权 |
| requestEnableNotification | 拉起通知授权弹窗，让用户选择是否允许发送通知。 |
| openNotificationSettings | 拉起应用的通知设置界面，该页面以半模态形式呈现，可用于设置通知开关、通知提醒方式等。 |
| authorizeNotification | 请求通知授权，第一次调用会弹窗让用户选择。 |
| isSupportTemplate | 查询模板是否存在，目前仅支持进度条模板。 |
| isDistributedEnabled | 查询设备是否支持分布式通知 |
| publishBasic | 发布普通文本通知 |
| publishMultiLine | 发布多文本通知 |
| publishLongText | 发布长文本通知 |
| publishPicture | 发布带有图片的通知 |
| publishTemplate | 发布模板通知 |
| cancel | 取消通知 |
| cancelGroup | 取消本应用指定组下的通知 |
| cancelAll | 取消所有通知 |
| setBadge | 设置桌面角标个数 |
| clearBadge | 清空桌面角标 |
| setBadgeFromNotificationCount | 设置桌面角标数量，来自于通知数量 |
| getActiveNotificationCount | 获取当前应用未删除的通知数量 |
| getActiveNotifications | 获取当前应用未删除的通知列表 |
| addSlot | 创建指定类型的通知渠道 |
| getSlot | 获取一个指定类型的通知渠道 |
| getSlots | 获取此应用程序的所有通知渠道 |
| removeSlot | 删除此应用程序指定类型的通知渠道 |
| removeAllSlots | 删除此应用程序所有通知渠道 |
| generateNotificationId | 生成通知id（用时间戳当id） |
| getDefaultWantAgent | 创建一个可拉起Ability的Want |
| getCompressedPicture | 获取压缩通知的图片（图像像素的总字节数不能超过2MB） |
| getCompressedIcon | 获取压缩通知图标（图标像素的总字节数不超过192KB） |

### SnapshotUtil（组件截图和窗口截图工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| get/getSync | 获取已加载的组件的截图，传入组件的组件id，找到对应组件进行截图 |
| createFromBuilder | 在应用后台渲染CustomBuilder自定义组件，并输出其截图 |
| snapshot | 获取窗口截图，使用Promise异步回调 |
| onSnapshotListener | 开启系统截屏事件的监听 |
| removeSnapshotListener | 关闭系统截屏事件的监听 |

### KeyboardUtil（键盘工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| show | 拉起键盘 |
| hide | 隐藏键盘 |
| onKeyboardListener | 订阅输入法软键盘显示和隐藏事件 |
| removeKeyboardListener | 取消订阅输入法软键盘显示或隐藏事件 |

### PasteboardUtil（剪贴板工具类 ）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| requestPermissions | 申请剪贴板权限 |
| getSystemPasteboard | 获取系统剪贴板对象 |
| hasData/hasDataSync | 判断系统剪贴板中是否有内容 |
| setData/setDataSync | 将数据写入系统剪贴板 |
| getData/getDataSync | 读取系统剪贴板内容 |
| setDataText/setDataTextSync | 将纯文本数据写入系统剪贴板 |
| getDataText/getDataTextSync | 读取系统剪贴板纯文本内容 |
| setDataHtml/setDataHtmlSync | 将HTML数据写入系统剪贴板 |
| getDataHtml/getDataHtmlSync | 读取系统剪贴板HTML内容 |
| setDataUri/setDataUriSync | 将URI数据写入系统剪贴板 |
| getDataUri/getDataUriSync | 读取系统剪贴板URI内容 |
| setDataWant/setDataWantSync | 将Want数据写入系统剪贴板 |
| getDataWant/getDataWantSync | 读取系统剪贴板Want内容 |
| setDataPixelMap/setDataPixelMapSync | 将PixelMap数据写入系统剪贴板 |
| getDataPixelMap/getDataPixelMapSync | 读取系统剪贴板PixelMap内容 |
| getDataStr/getDataStrSync | 读取系统剪贴板里的字符串 |
| getDataEasy | 读取系统剪贴板里的内容（纯文本内容、HTML内容、URI内容、Want内容、PixelMap内容） |
| clearData/clearDataSync | 清空系统剪贴板内容 |

### AssetUtil（关键资产存储服务工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| add/addSync | 新增一条关键资产 |
| get/getSync | 查询关键资产 |
| remove/removeSync | 删除关键资产 |
| canIUse | 当前设备是否支持该模块 |

### ResUtil（资源工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| getResourceManager | 获取提供访问应用资源的能力 |
| getBoolean | 获取指定资源对应的布尔结果 |
| getBooleanByName | 获取指定资源名称对应的布尔结果 |
| getNumber | 获取指定资源对应的integer数值或者float数值 |
| getNumberByName | 获取指定资源名称对应的integer数值或者float数值 |
| getStringValue/getStringSync | 获取指定资源对应的字符串 |
| getStringByName/getStringByNameSync | 获取指定资源名称对应的字符串 |
| getStringArrayValue/getStringArrayValueSync | 获取指定资源对应的字符串数组 |
| getStringArrayByName/getStringArrayByNameSync | 获取指定资源名称对应的字符串数组 |
| getPluralStringValue/getPluralStringValueSync | 根据指定数量获取指定resource对象表示的单复数字符串 |
| getPluralStringByName/getPluralStringByNameSync | 根据指定数量获取指定资源名称表示的单复数字符串 |
| getColor/getColorSync | 获取指定资源对应的颜色值（十进制） |
| getColorByName/getColorByNameSync | 获取指定资源名称对应的颜色值（十进制） |
| getMediaContent/getMediaContentSync | 获取指定资源对应的默认或指定的屏幕密度媒体文件内容 |
| getMediaByName/getMediaByNameSync | 获取指定资源名称对应的默认或指定的屏幕密度媒体文件内容 |
| getMediaContentBase64/getMediaContentBase64Sync | 获取指定资源ID对应的默认或指定的屏幕密度图片资源Base64编码 |
| getMediaBase64ByName/getMediaBase64ByNameSync | 获取指定资源名称对应的默认或指定的屏幕密度图片资源Base64编码 |
| getRawFileContent/getRawFileContentSync | 获取resources/rawfile目录下对应的rawfile文件内容 |
| getRawFileContentStr/getRawFileContentStrSync | 获取resources/rawfile目录下对应的rawfile文件内容（字符串） |
| getRawFileList/getRawFileListSync | 获取resources/rawfile目录下文件夹及文件列表（若文件夹中无文件，则不返回；若文件夹中有文件，则返回文件夹及文件列表） |
| getRawFd | 用户获取resources/rawfile目录下对应rawfile文件所在hap的descriptor信息 |
| closeRawFd/closeRawFdSync | 用户关闭resources/rawfile目录下rawfile文件所在hap的descriptor信息 |
| addResource | 应用运行时，加载指定的资源路径，实现资源覆盖 |
| removeResource | 用户运行时，移除指定的资源路径，还原被覆盖前的资源 |
| isRawDir | 用户判断指定路径是否是rawfile下的目录（true：表示是rawfile下的目录，false：表示不是rawfile下的目录） |
| getConfiguration/getConfigurationSync | 获取设备的Configuration |
| getDeviceCapability/getDeviceCapabilitySync | 获取设备的DeviceCapability |

### ObjectUtil（对象工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| getHash | 获取对象的Hash值 |
| getClassName | 获取对象的Class名称 |
| getMethodsNames | 获取对象的所有方法名 |
| isString | 判断是否是String |
| isNull | 判断对象是否为空 |
| isEmpty | 判断属性内容是否为空 |
| shallowCopy | 浅拷贝 |
| deepCopy | 深度拷贝对象 |
| assign | 合并两个或多个对象 |
| has | 检查对象是否具有指定的属性 |
| getValue | 通过key获取对象值 |
| setValue | 给对象obj动态添加或者修改属性 |
| delete | 删除指定的对象的属性 |
| plainToClass | 将普通纯对象转换为指定类的实例（嵌套类需要添加装饰器NestedClassV6） |
| plainToClassArray | 将普通纯对象数组转换为指定类的实例数组（嵌套类需要添加装饰器NestedClassV6） |
| classToPlain | 将类实例转换为普通对象 |

### JSONUtil（JSON工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| jsonToBean | JSON字符串转对象（嵌套类需要添加装饰器NestedClassV6） |
| beanToJsonStr | 对象转JSON字符串 |
| jsonToArray | JSON字符串转Array（嵌套类需要添加装饰器NestedClassV6） |
| jsonToMap | JSON字符串转Map |
| mapToJsonStr | Map转JSON字符串 |
| isJSONStr | 判断是否是字符串格式json |

### DateUtil（日期工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| getFormatDate | 获取格式化日期，将传入的日期格式化为Date |
| getFormatDateStr | 获取格式化日期，将传入的日期格式化为指定格式的字符串 |
| getToday | 获取今天的日期 |
| getTodayTime | 获取今天的时间戳 |
| getTodayStr | 获取今天的时间，字符串类型 |
| isToday | 判断日期是否是今天 |
| getNowYear | 获取当前年 |
| getNowMonth | 获取当前月 |
| getNowDay | 获取当前日 |
| isLeapYear | 判断是否是闰年 |
| getDaysByYear | 获取指定年份的天数 |
| getDaysByMonth | 获取指定月份的天数 |
| isSameYear | 判断两个日期是否是同一年 |
| isSameMonth | 判断两个日期是否是同一月 |
| isSameWeek | 判断两个日期是否是同一周 |
| isSameDay | 判断是否是同一天 |
| isWeekend | 判断指定的日期在日历中是否为周末 |
| compareDays | 比较指定日期相差的天数 |
| compareDate | 比较指定日期相差的毫秒数 |
| getAmountDay | 获取前几天日期或后几天日期 |
| getAmountDayStr | 获取前几天日期或后几天日期,返回字符串 |
| getBeforeDay | 获取前一天日期 |
| getBeforeDayStr | 获取前一天日期,返回字符串 |
| getAfterDay | 获取后一天日期 |
| getAfterDayStr | 获取后一天日期,返回字符串 |
| getWeekOfMonth | 获取给定日期是当月的第几周 |
| getWeekDay | 获取给定的日期是星期几 |
| getLastDayOfMonth | 获取给定年份和月份的最后一天是几号 |
| getFormatTime | 格式化时间日期字符串（DateTimeFormat） |
| getFormatRange | 格式化时间日期段字符串（DateTimeFormat） |
| getFormatRelativeTime | 格式化相对时间 |
| getTipDateStr | 格式化时间戳，获取提示性时间字符串 |

### Base64Util（Base64工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| decode/encodeSync | 解码，通过输入参数解码后输出对应Uint8Array对象 |
| encode/decodeSync | 编码，通过输入参数编码后输出Uint8Array对象 |
| encodeToStr/encodeToStrSync | 编码，通过输入参数编码后输出对应文本 |

### StrUtil（字符串工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| isNull | 判断字符串是否为空(undefined、null) |
| isNotNull | 判断字符串是否为非空 |
| isEmpty | 判断字符串是否为空(undefined、null、字符串长度为0) |
| isNotEmpty | 判断字符串是否为非空 |
| isBlank | 判断字符串是否为空和空白符(空白符包括空格、制表符、全角空格和不间断空格) |
| isNotBlank | 判断字符串是否为非空 |
| trim | 去除字符串两端的空格 |
| trimAll | 去除字符串里的所有空格 |
| replace | 替换字符串中匹配的正则为给定的字符串 |
| replaceAll | 替换字符串中所有匹配的正则为给定的字符串 |
| startsWith | 判断字符串是否以给定的字符串开头 |
| endsWith | 判断字符串是否以给定的字符串结尾 |
| repeat | 将字符串重复指定次数 |
| toLower | 将整个字符串转换为小写 |
| toUpper | 将整个字符串转换为大写 |
| capitalize | 将字符串首字母转换为大写，剩下为小写 |
| equal | 判断两个传入的数值或者是字符串是否相等 |
| notEqual | 判断两个传入的数值或者是字符串是否不相等 |
| strToUint8Array | 字符串转Uint8Array |
| unit8ArrayToStr | Uint8Array转字符串 |
| strToBase64 | 字符串转Base64字符串 |
| base64ToStr | Base64字符串转字符串 |
| strToBuffer | 字符串转ArrayBuffer |
| bufferToStr | ArrayBuffer转字符串 |
| bufferToUint8Array | ArrayBuffer转Uint8Array |
| unit8ArrayToBuffer | Uint8Array转ArrayBuffer |
| getErrorStr | 获取Error的JSON字符串 |
| getErrnoToString | 获取系统错误码对应的详细信息 |

### CharUtil（字符工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| isDigit | 判断字符串char是否是数字 |
| isLetter | 判断字符串char是否是字母 |
| isLowerCase | 判断字符串char是否是小写字母 |
| isUpperCase | 判断字符串char是否是大写字母 |
| isSpaceChar | 判断字符串char是否是空格符 |
| isWhitespace | 判断字符串char是否是空白符 |
| isRTL | 判断字符串char是否是从右到左语言的字符 |
| isIdeograph | 判断字符串char是否是表意文字 |
| isBlankChar | 判断是否空白符 空白符包括空格、制表符、全角空格和不间断空格 |
| isAscii | 判断字符是否位于ASCII范围内（0~127） |

### NumberUtil（number工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| isNaN | 检查值是否为NaN |
| isFinite | 检查值是否为有限数字 |
| isInteger | 检查值是否为整数 |
| isSafeInteger | 检查值是否为安全整数 |
| isNumber | 判断是否是数值 |
| isEven | 检查数字是否为偶数 |
| isOdd | 检查数字是否为奇数 |
| toNumber | 将字符串转换为Number |
| toInt | 将字符串转换为整数 |
| toFloat | 将字符串转换为浮点数 |
| average | 计算数字的平均值 |
| keepDecimals | 保留几位小数（默认保留两位小数） |
| add | 加法 |
| sub | 减法 |
| sum | 求和 |
| toDecimal | 构造Decimal |
| addDecimal | 加法Decimal |
| subDecimal | 减法Decimal |
| sumDecimal | 求和Decimal |

### ArrayUtil（集合工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| isNotEmpty | 判断集合是否为非空集合 |
| isEmpty | 判断集合是否为空集合 |
| removeEmpty | 去除字符串数组中的空值 |
| trim | 去除字符串数组的每个值的前后空格 |
| distinct | 将数组去重，去重后生成新的数组，原数组不变 |
| reverse | 将数组反转，会修改原始数组 |
| filter | 数组过滤，通过filter函数实现来过滤返回需要的元素 |
| append | 拼接数据，使用扩展运算符，不影响原数组。 |
| min | 获取数组最小值（数值、字符串、日期） |
| max | 获取数组最大值（数值、字符串、日期） |
| flatten | 平铺二维数组 |
| union | 平铺二维数组，并去重 |
| chunk | 数组分块 |
| contain | 判断集合是否包含某个值 |
| remove | 移除集合的某个值 |

### RandomUtil（随机工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| getRandomBoolean | 生成随机Boolean值 |
| getRandomInt | 生成随机整数（可指定范围） |
| getRandomNumber | 生成指定范围内的随机数 |
| getRandomLimit | 生成指定范围内的随机数 [0,limit) |
| getRandomChineseChar | 生成一个随机汉字 |
| getRandomChinese | 生成随机汉字 |
| getRandomStr | 根据指定字符串，随机生成 指定长度的字符串 |
| getRandomDataBlob | 生成随机指定长度的DataBlob |
| getRandomUint8Array | 生成随机指定长度的Uint8Array |
| getRandomColor | 生成随机颜色，十六进制 |
| generateUUID36 | 生成36位UUID，带- |
| generateUUID32 | 生成32位UUID，带- |
| generateRandomUUID | 使用加密安全随机数生成器生成随机的RFC 4122版本4的string类型UUID |
| generateRandomBinaryUUID | 使用加密安全随机数生成器生成随机的RFC 4122版本4的Uint8Array类型UUID |

### RegexUtil（正则工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| isMatch | 给定内容是否匹配正则（配合RegexUtil里的正则常量一起使用） |
| isPhone | 判断传入的电话号码格式是否正确 |
| isDigits | 检查字符串是否只包含数字字符 |
| isEmail | 判断传入的邮箱格式是否正确 |
| isEmoji | 判断字符串是否包含表情 |
| isValidCard | 验证身份证号码的有效性 |

### TypeUtil（类型检查工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| isBoolean | 判断是否是Boolean类型 |
| isNumber | 判断是否是Number类型 |
| isString | 判断是否是String类型 |
| isObject | 判断是否是Object类型 |
| isArray | 判断是否是数组类型 |
| isResource | 判断是否是Resource类型 |
| isResourceStr | 判断是否是ResourceStr类型 |
| isFunction | 判断是否是函数类型 |
| isMap | 检查是否为Map类型 |
| isWeakMap | 检查是否为WeakMap类型 |
| isSet | 检查是否为Set类型 |
| isWeakSet | 检查是否为WeakSet类型 |
| isDate | 检查是否为Date类型 |
| isArrayBuffer | 检查是否为ArrayBuffer类型 |
| isSharedArrayBuffer | 检查是否为SharedArrayBuffer类型 |
| isAnyArrayBuffer | 检查是否为ArrayBuffer或SharedArrayBuffer类型 |
| isUint8Array | 检查是否为Uint8Array数组类型 |
| isUint16Array | 检查是否为Uint16Array数组类型 |
| isUint32Array | 检查是否为Uint32Array数组类型 |
| isInt8Array | 检查是否为Int8Array数组类型 |
| isInt16Array | 检查是否为Int16Array数组类型 |
| isInt32Array | 检查是否为Int32Array数组类型 |
| isTypedArray | 检查是否为TypedArray类型 |
| isAsyncFunction | 检查是否为异步函数类型 |
| isPromise | 检查是否为Promise类型 |
| isProxy | 检查是否为Proxy类型 |
| isRegExp | 检查是否为RegExp类型 |
| isDataView | 检查是否为DataView类型 |
| isExternal | 检查是否为native External类型 |
| isNativeError | 检查是否为Error类型 |

### FormatUtil（格式化工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| isPhone | 判断传入的电话号码格式是否正确 |
| getPhoneFormat | 对电话号码进行格式化 |
| getPhoneLocationName | 获取电话号码归属地 |
| transliterator | 将输入字符串从源格式转换为目标格式（中文汉字转为拼音） |
| getFormatPercentage | 格式化百分比，将数字转化从百分比字符串 |
| getFormatPhone | 格式化手机号码，隐藏中间四位 |
| getFormatCardNo | 格式化身份证号码，隐藏中间部分数字 |
| getFormatFileSize | 格式化文件大小 |
| getTruncateText | 缩短长文本，超出部分用省略号表示 |
| getIconFont | 解析iconFont字符 |
| getQueryValue | 获取url里的参数，Key对应的Value |
| getParamsUrl | 将参数拼接在url上，返回新的url |

### ClickUtil（节流、防抖 工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| throttle | 节流：在一定时间内，只触发一次 |
| debounce | 防抖：一定时间内，只有最后一次操作，再过wait毫秒后才执行函数 |

### TempUtil(温度转换工具类)使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| C2F | 摄氏度转华氏度 |
| F2C | 华氏度转摄氏度 |
| C2K | 摄氏度转开尔文 |
| K2C | 开尔文转摄氏度 |
| F2K | 华氏度转开尔文 |
| K2F | 开尔文转华氏度 |

### DialogUtil（弹窗工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| setDefaultConfig | 设置默认统一样式 |
| showConfirmDialog | 显示弹窗（一个按钮） |
| showPrimaryDialog | 显示弹窗（两个按钮） |
| showDialog | 显示弹窗（可多个按钮） |
| showActionSheet | 列表选择弹窗 |
| showCalendarPicker | 日历选择器弹窗 |
| showDatePicker | 日期滑动选择器弹窗 |
| showTimePicker | 时间滑动选择器弹窗 |
| showTextPicker | 文本滑动选择器弹窗 |

### ToastUtil（吐司工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| setDefaultConfig | 设置默认统一样式 |
| showToast | 弹出吐司，默认时长为2s |
| showShort | 弹出短吐司，默认时长为:1.5s |
| showLong | 弹出长吐司，默认时长为:10s |

### SM2（SM2加解密）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| encrypt/encryptSync | 加密 |
| decrypt/decryptSync | 解密 |
| generateKeyPair/generateKeyPairSync | 生成非对称密钥KeyPair |
| getConvertKeyPair/getConvertKeyPairSync | 获取转换的非对称密钥KeyPair |
| getSM2PubKey | 获取转换SM2公钥, 将C1C2C3格式的SM2公钥转换为鸿蒙所需的ASN.1格式 |
| getSM2PriKey | 获取转换SM2私钥 |
| getCipherTextSpec | 获取转换SM2密文格式，ASN.1格式转换为C1C2C3或C1C3C2 |
| sign/signSync | 对数据进行签名 |
| verify/verifySync | 对数据进行验签 |
| signSegment/signSegmentSync | 对数据进行分段签名 |
| verifySegment/verifySegmentSync | 对数据进行分段验签 |

### SM3（SM3工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| digest/digestSync | SM3摘要 |
| digestSegment/digestSegmentSync | SM3分段摘要 |
| hmac/hmacSync | SM3消息认证码计算 |
| hmacSegment/hmacSegmentSync | SM3消息认证码计算，分段 |

### SM4（SM4加解密）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| encrypt/encryptSync | 加密 |
| decrypt/decryptSync | 解密 |
| encryptGCM/encryptGCMSync | 加密（GCM模式） |
| decryptGCM/decryptGCMSync | 解密（GCM模式） |
| encryptCBC/encryptCBCSync | 加密（CBC模式） |
| decryptCBC/decryptCBCSync | 解密（CBC模式） |
| encryptECB/encryptECBSync | 加密（ECB模式） |
| decryptECB/decryptECBSync | 解密（ECB模式） |
| encryptGCMSegment/encryptGCMSegmentSync | 加密（GCM模式）分段 |
| decryptGCMSegment/decryptGCMSegmentSync | 解密（GCM模式）分段 |
| generateSymKey/generateSymKeySync | 生成对称密钥SymKey |

### AES（AES加解密）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| encrypt/encryptSync | 加密 |
| decrypt/decryptSync | 解密 |
| encryptGCM/encryptGCMSync | 加密（GCM模式） |
| decryptGCM/decryptGCMSync | 解密（GCM模式） |
| encryptCBC/encryptCBCSync | 加密（CBC模式） |
| decryptCBC/decryptCBCSync | 解密（CBC模式） |
| encryptECB/encryptECBSync | 加密（ECB模式） |
| decryptECB/decryptECBSync | 解密（ECB模式） |
| encryptGCMSegment/encryptGCMSegmentSync | 加密（GCM模式）分段 |
| decryptGCMSegment/decryptGCMSegmentSync | 解密（GCM模式）分段 |
| generateSymKey/generateSymKeySync | 生成对称密钥SymKey |

### DES（DES加解密）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| encrypt/encryptSync | 加密 |
| decrypt/decryptSync | 解密 |
| encryptECB/encryptECBSync | 加密（ECB模式） |
| decryptECB/decryptECBSync | 解密（ECB模式） |
| encryptCBC/encryptCBCSync | 加密（CBC模式） |
| decryptCBC/decryptCBCSync | 解密（CBC模式） |
| generateSymKey/generateSymKeySync | 生成对称密钥SymKey |

### RSA（RSA加解密）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| encrypt/encryptSync | 加密 |
| decrypt/decryptSync | 解密 |
| encryptSegment/encryptSegmentSync | 加密,分段 |
| decryptSegment/decryptSegmentSync | 解密,分段 |
| generateKeyPair/generateKeyPairSync | 生成非对称密钥KeyPair |
| getConvertKeyPair/getConvertKeyPairSync | 获取转换的非对称密钥KeyPair |
| sign/signSync | 对数据进行签名 |
| verify/verifySync | 对数据进行验签 |
| signSegment/signSegmentSync | 对数据进行分段签名 |
| verifySegment/verifySegmentSync | 对数据进行分段验签 |
| recover/recoverSync | 对数据进行签名恢复原始数据，目前仅RSA支持 |

### MD5（MD5工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| digest/digestSync | MD5摘要 |
| digestSegment/digestSegmentSync | MD5摘要，分段 |
| hmac/hmacSync | 消息认证码计算 |
| hmacSegment/hmacSegmentSync | 消息认证码计算，分段 |

### SHA（SHA工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| digest/digestSync | SHA摘要 |
| digestSegment/digestSegmentSync | SHA摘要，分段 |
| hmac/hmacSync | 消息认证码计算 |
| hmacSegment/hmacSegmentSync | 消息认证码计算，分段 |

### ECDSA（ECDSA工具类）使用案例

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| sign/signSync | 对数据进行签名 |
| verify/verifySync | 对数据进行验签 |
| signSegment/signSegmentSync | 对数据进行分段签名 |
| verifySegment/verifySegmentSync | 对数据进行分段验签 |

### CryptoUtil（加解密公用工具类，配合各个加密模块使用）

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| encrypt/encryptSync | 加密 |
| decrypt/decryptSync | 解密 |
| generateSymKey/generateSymKeySync | 生成对称密钥SymKey |
| getConvertSymKey/getConvertSymKeySync | 获取转换的对称密钥SymKey |
| generateKeyPair/generateKeyPairSync | 生成非对称密钥KeyPair |
| getConvertKeyPair/getConvertKeyPairSync | 获取转换的非对称密钥KeyPair |
| getPemKeyPair | 获取指定数据生成非对称密钥 |
| generateIvParamsSpec | 生成IvParamsSpec |
| getIvParamsSpec | 获取转换IvParamsSpec |
| generateGcmParamsSpec | 生成GcmParamsSpec |
| getGcmParamsSpec | 获取转换GcmParamsSpec |
| sign/signSync | 对数据进行签名 |
| verify/verifySync | 对数据进行验签 |
| signSegment/signSegmentSync | 对数据进行分段签名 |
| verifySegment/verifySegmentSync | 对数据进行分段验签 |
| dynamicKey/dynamicKeySync | 密钥协商 |
| digest/digestSync | 摘要 |
| digestSegment/digestSegmentSync | 摘要，分段 |
| hmac/hmacSync | 消息认证码计算 |
| hmacSegment/hmacSegmentSync | 消息认证码计算，分段 |

### CryptoHelper（加解密数据类型转换，配合各个加密模块使用）

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| strToDataBlob | 字符串转DataBlob |
| dataBlobToStr | DataBlob转字符串 |
| strToUint8Array | 字符串转Uint8Array |
| uint8ArrayToStr | Uint8Array转字符串 |
| getSymKeyDataBlob | 获取DataBlob类型的密钥 |
| getKeyDataBlob | 获取DataBlob类型的公钥或私钥 |
| getRandomUint8Array | 根据传入的大小生成随机Uint8Array |
| getUint8ArrayPaddingZero | Uint8Array补零操作 |
| toHexWithPaddingZero | 补零操作 |
| stringToHex | 字符串转Hex字符串 |
| uint8ArrayToString | 字节流转成可理解的字符串 |

### PickerUtil（拍照、文件选择和保存,工具类）拆分至 picker_utils

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| camera/cameraEasy | 调用系统相机，拍照、录视频 |
| selectPhoto | 通过选择模式拉起photoPicker界面，用户可以选择一个或多个图片/视频 |
| savePhoto | 通过保存模式拉起photoPicker进行保存图片或视频资源的文件名，若无参数，则默认需要用户自行输入 |
| selectDocument | 通过选择模式拉起documentPicker界面，用户可以选择一个或多个文件 |
| saveDocument | 通过保存模式拉起documentPicker界面，用户可以保存一个或多个文件 |
| selectAudio | 通过选择模式拉起audioPicker界面，用户可以选择一个或多个音频文件 |
| saveAudio | 通过保存模式拉起audioPicker界面，用户可以保存一个或多个音频文件 |

### PhotoHelper（相册相关,工具类）拆分至 picker_utils

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| select/selectEasy | 通过选择模式拉起photoPicker界面，用户可以选择一个或多个图片/视频 |
| save | 申请权限保存，保存图片或视频到相册。 |
| showAssetsCreationDialog | 弹窗授权保存，调用接口拉起保存确认弹窗。 |
| showAssetsCreationDialogEasy | 弹窗授权保存，调用接口拉起保存确认弹窗，并保存。 |
| applyChanges | 安全控件保存，提交媒体变更请求，插入图片/视频。 |
| getPhotoAsset | 获取对应uri的PhotoAsset对象,用于读取文件信息 |

### ScanUtil（码工具类(扫码、码图生成、图片识码)）拆分至 picker_utils

#### 方法介绍

| 方法 | 说明 |
|:---|:---|
| startScanForResult | 调用默认界面扫码，使用Promise方式异步返回解码结果 |
| generateBarcode | 码图生成，使用Promise异步返回生成的码图 |
| decode | 调用图片识码，使用Promise方式异步返回识码结果 |
| decodeImage | 调用图像数据识码能力，使用Promise异步回调返回识码结果 |
| onPickerScanForResult | 通过picker拉起图库并选择图片,并调用图片识码 |
| canIUseScan | 判断当前设备是否支持码能力 |

## 🍎沟通与交流

使用过程中发现任何问题都可以提 Issue 给我们；当然，我们也非常欢迎你给我们发 PR。

- https://gitee.com/tongyuyan/harmony-utils
- https://github.com/787107497
- https://gitcode.com/tongzhanglao/harmony-utils
- 三方库中心
- 童长老鸿蒙造器阁

## 🌏开源协议

本项目基于 Apache License 2.0 ，在拷贝和借鉴代码时，请大家务必注明出处。

## 更新记录

### 1.3.9 (2026-01-13)

代码优化。

### 1.3.1 (2025-03-31)

代码以及权限优化。

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
|:---|:---|:---|
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK合规使用指南

不涉及

## 兼容性

| HarmonyOS版本 | 5.0.0 | 5.0.1 | 5.0.2 | 5.0.3 | 5.0.4 | 5.0.5 | 5.1.0 | 5.1.1 | 6.0.0 | 6.0.1 |
|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|
| | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

| 应用类型 | 应用 | 元服务 |
|:---|:---|:---|
| | ✅ | ✅ |

| 设备类型 | 手机 | 平板 | PC |
|:---|:---|:---|:---|
| | ✅ | ✅ | ✅ |

| DevEcoStudio版本 | DevEco Studio 6.0.0 |
|:---|:---|
| | ✅ |

## 安装方式

```bash
ohpm install @pura/harmony-utils
```

## 来源

- 原始URL: https://developer.huawei.com/consumer/cn/market/prod-detail/cf1aaeceeff14daa903ef1e05a2af056/8ec916dd959b42c4927412bdf4a96253?origin=template