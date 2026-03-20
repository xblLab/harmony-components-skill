# SandboxFinder-沙箱浏览器组件

## 简介

快速访问应用沙箱目录，支持模拟器和真机。支持沙箱文件预览、下载、上传、删除、搜索。

## 详细介绍

SandboxFinder - 沙箱浏览器组件
更方便快捷的访问应用沙箱目录，支持沙箱文件预览、下载、上传、删除、搜索。

### 核心特性

*   **沙箱文件系统**
    *   内置 HTTP 服务器 - 基于 TCP Socket 实现的轻量级 HTTP 服务器
    *   多设备 - 支持模拟器和真机
    *   文件类型识别 - 智能识别文本、图片、视频、音频、SQLite 数据库等文件类型
    *   自定义端口 - 默认端口 7777

### Web 界面访问

*   响应式 Web UI - 使用 Vue 3 + Tailwind CSS 构建的现代化界面
*   快速访问 - 提供便捷的沙箱目录访问（filesDir、cacheDir、tempDir、databaseDir 等）
*   预览 - 支持文本、图片、视频、音频、SQLite 数据库预览
*   排序 - 支持按名称、大小、时间排序
*   搜索 - 实时关键字搜索

### 文件操作功能

*   基础文件操作 - 创建、删除、重命名
*   文件上传 - 支持大文件分块、批量、拖放上传
*   下载 - 直链下载

## 快速开始

### 集成到项目

#### 安装

深色代码主题复制
```bash
ohpm install @cxy/sandboxfinder
```

或 添加依赖，然后同步
深色代码主题复制
```json5
// oh-package.json5
{
  "dependencies": {
    "@cxy/sandboxfinder": "^1.0.5"
  }
}
```

#### 导入并启动

深色代码主题复制
```typescript
// EntryAbility.ets

// 导入 BuildProfile，编译工程自动生成
import BuildProfile from 'BuildProfile';

onWindowStageCreate(windowStage: window.WindowStage): void {
  windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        return;
      }

    // 推荐在 DEBUG 模式下使用 - 动态加载
    if (BuildProfile.DEBUG) {
      import('@cxy/sandboxfinder').then(async (ns: ESObject) => {
        // 默认绑定到端口 7777
        ns.SandboxFinder.run()
      });

      // 避免服务挂起，设置不息屏
      windowStage.getMainWindowSync().setWindowKeepScreenOn(true)
    }
    });
}
```

确保鸿蒙设备和电脑在同一网络，获取访问地址：查看打印 log。
或者直接查看设备 IP：设置 -> WLAN -> 已连接的 WIFI 详情 -> IP 地址。

深色代码主题复制
```text
----------------------------------------------------------
   
   沙箱浏览器启动成功
   请浏览器访问：http://192.168.2.38:7777
   
----------------------------------------------------------
```

浏览器直接访问：`http://192.168.2.38:7777` (换成你的 IP)

### 模拟器使用

沙箱浏览器开启后，模拟器需转发端口，才能访问。
深色代码主题复制
```bash
# 查看模拟器设备
> hdc list targets   # 输出：127.0.0.1:5555

# 转发端口 fport tcp:<localPort> tcp:<serverPort>
hdc -t 127.0.0.1:5555 fport tcp:7777 tcp:7777   

# 输出：Forwardport result:OK 表示成功
```

转发成功后，访问：`http://127.0.0.1:7777`，如果无法访问，关闭网络代理工具试试看。

使用 `hdc` 时如出现异常，可通过 `hdc kill -r` 命令终止异常进程并重启 hdc 服务。

## SandboxFinder 类说明

### 1. 对外静态方法

SandboxFinder 提供了两个对外静态方法：
深色代码主题复制
```typescript
/**
 * 运行服务
 * @param port  端口号，默认 7777
 * @param context UIAbilityContext, 默认 getContext()
 * @returns socket.NetAddress =》 { address: string , port: number }
 */
static async run(port: number = 7777,
  context: common.UIAbilityContext = getContext() as common.UIAbilityContext): Promise<socket.NetAddress>;
    
    
 /**
 * 停止服务
 */
static async stop();
    
    
 /**
 * 停止服务
 */
static async stop();
```

### 2. 查看 ServerInfo

深色代码主题复制
```typescript
// EntryAbility.ets  - onWindowStageCreate()
import('@cxy/sandboxfinder').then(async (ns: ESObject) => {
  // 绑定到端口 6666, 使用 this.context
  ns.SandboxFinder.run(6666, this.context).then((serverInfo: ESObject) => {
    console.log(JSON.stringify(serverInfo))
  })
});
```

如果在使用过程中有什么问题，欢迎提 issues。

## 环境要求

*   HarmonyOS 5.0.0 及以上
*   DevEco Studio 5.0.0 及以上

## 权限要求

需要向系统申请的权限列表：

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| `ohos.permission.INTERNET` | 允许应用通过 HTTP/HTTPS 协议访问互联网资源 | 使得用户能通过网络访问应用沙箱目录 |
| `ohos.permission.GET_WIFI_INFO` | 允许应用查询 Wi-Fi 状态、扫描结果及连接信息（如 SSID、信号强度等） | 用于获取设备本机地址，启动沙箱服务 |

## 开源许可协议

该代码经过 Apache 2.0 授权许可。

## 更新记录

### 1.0.5 (2025-12-19)

优化服务关闭和本机 IP 获取权限与隐私基本信息。

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| `ohos.permission.INTERNET` | 允许应用通过 HTTP/HTTPS 协议访问互联网资源 | 使得用户能通过网络访问应用沙箱目录 |
| `ohos.permission.GET_WIFI_INFO` | 允许应用查询 Wi-Fi 状态、扫描结果及连接信息（如 SSID、信号强度等） | 用于获取设备本机地址，启动沙箱服务 |

### 隐私政策

不涉及 SDK 合规使用指南 不涉及

### 兼容性

| HarmonyOS 版本 | Created with Pixso. |
| :--- | :--- |
| 5.0.0 | Created with Pixso. |
| 5.0.1 | Created with Pixso. |
| 5.0.2 | Created with Pixso. |
| 5.0.3 | Created with Pixso. |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |
| 5.1.0 | Created with Pixso. |
| 5.1.1 | Created with Pixso. |
| 6.0.0 | Created with Pixso. |
| 6.0.1 | Created with Pixso. |

| 应用类型 | Created with Pixso. |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

| 设备类型 | Created with Pixso. |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

| DevEcoStudio 版本 | Created with Pixso. |
| :--- | :--- |
| DevEco Studio 5.0.0 | Created with Pixso. |
| DevEco Studio 5.0.1 | Created with Pixso. |
| DevEco Studio 5.0.2 | Created with Pixso. |
| DevEco Studio 5.0.3 | Created with Pixso. |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |
| DevEco Studio 6.0.1 | Created with Pixso. |

## 安装方式

```bash
ohpm install @cxy/sandboxfinder
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/6b7fb1d31b6f4e3ebfcdb2558307fea9/b729f6f7599f4f11ba126e875b209273?origin=template