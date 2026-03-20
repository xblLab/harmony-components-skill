# FastBle 蓝牙 BLE 处理组件

## 简介

FastBle 是一个处理蓝牙 BLE 设备的库，可以对蓝牙 BLE 设备进行过滤，扫描，连接，读取，写入等。

## 详细介绍

### 简介

FastBle 是一个处理蓝牙 BLE 设备的库，可以对蓝牙 BLE 设备进行过滤，扫描，连接，读取，写入等。

### 下载安装

深色代码主题复制
```bash
ohpm install @ohos/fastble
```

### 使用说明

#### 初始化

深色代码主题复制
```typescript
BleManager.getInstance().init();
```

#### 初始化配置

深色代码主题复制
```typescript
BleManager.getInstance()
           .enableLog(true)
           .setReConnectCount(1, 5000)
           .setConnectOverTime(20000)
           .setOperateTimeout(5000);
```

#### 配置扫描规则

深色代码主题复制
```typescript
let scanRuleConfig: BleScanRuleConfig = new BleScanRuleConfig.Builder()
             .setServiceUuids(serviceUuids)      // (Optional) Scan only devices of the specified service.
             .setDeviceName(true, names)         // (Optional) Scan only devices with specified broadcast names.
             .setDeviceMac(mac)                  // (Optional) Scan only devices with specified MAC addresses.
             .setAutoConnect(isAutoConnect)      // (Optional) Set automatic connection. The default value is false.
             .setScanTimeOut(10000)              // (Optional) Set the scanning timeout interval. The default value is 10 seconds.
             .build();
BleManager.getInstance().initScanRule(scanRuleConfig);
```

#### 扫描设备

深色代码主题复制
```typescript
let _this = this;
class TempBleScanCallback extends BleScanCallback {
  onScanStarted(success: boolean): void {
    console.info("onScanStarted success:" + success);
    _this.clearScanDevice();
    _this.is_loading = true;
    _this.loading_rotate = 360;
    _this.btn_scan_text = $r('app.string.stop_scan');
    _this.connectedDevices = BleManager.getInstance().getAllConnectedDevice();
  }

  onLeScan(bleDevice: BleDevice): void {
    console.info("onLeScan");
  }

  onScanning(bleDevice: BleDevice): void {
    console.info("onScanning");
    ArrayHelper.add(_this.bleDeviceList, bleDevice);
  }

  onScanFinished(scanResultList: Array<BleDevice>): void {
    console.info("onScanFinished");
    _this.is_loading = false;
    _this.loading_rotate = 0;
    _this.btn_scan_text = $r('app.string.start_scan');
    _this.connectedDevices = BleManager.getInstance().getAllConnectedDevice();
  }
}

BleManager.getInstance().scan(new TempBleScanCallback());
```

#### 连接设备

深色代码主题复制
```typescript
let _this = this;

class IndexBleGattCallback extends BleGattCallback {
  public onStartConnect(): void {
    _this.progressDialogCtrl.open();
  }

  public onConnectFail(bleDevice: BleDevice, exception: BleException): void {
    _this.progressDialogCtrl.close();
    prompt.showToast({ message: _this.toast_connect_fail, duration: 300, })
  }

  public onConnectSuccess(bleDevice: BleDevice, gatt: ble.GattClientDevice, status: number): void {
    _this.progressDialogCtrl.close();
    ArrayHelper.add(_this.connectedDevices, bleDevice.getMac());
  }

  public onDisConnected(isActiveDisConnected: boolean, device: BleDevice, gatt: ble.GattClientDevice, status: number): void {
    _this.progressDialogCtrl.close();
    _this.connectedDevices = BleManager.getInstance().getAllConnectedDevice();

    if (isActiveDisConnected) {
      prompt.showToast({ message: _this.toast_active_disconnected, duration: 300 })
    } else {
      prompt.showToast({ message: _this.toast_disconnected, duration: 300 })
    }
  }
}

BleManager.getInstance().connect(bleDevice, new IndexBleGattCallback());
```

#### 取消扫描

深色代码主题复制
```typescript
BleManager.getInstance().cancelScan();
```

#### 读数据

深色代码主题复制
```typescript
let bleReadClass: BleReadCallback = new BleReadClass()

BleManager.getInstance().read(
  this.device,
  this.characteristic.serviceUuid,
  this.characteristic.characteristicUuid,
  bleReadClass);
```

#### 写数据

深色代码主题复制
```typescript
let tempBleWriteCallback: BleWriteCallback = new TempBleWriteCallback()

BleManager.getInstance().write(
  this.device,
  this.characteristic.serviceUuid,
  this.characteristic.characteristicUuid,
  HexUtil.hexStringToBytes(hex),
  true,
  true,
  0,
  tempBleWriteCallback);
```

## 接口说明

1. 获取实例 `public static getInstance(): BleManager;`
2. 配置扫描规则 `public initScanRule(config: BleScanRuleConfig)`
3. 扫描设备 `public scan(callback: BleScanCallback)`
4. 取消扫描 `public cancelScan()`
5. 连接设备 `public connect(device: BleDevice | string, bleGattCallback: BleGattCallback)`
6. 判断设备是否连接 `public isConnected(device: BleDevice | string): boolean`
7. 断开连接 `public disconnect(bleDevice: BleDevice)`
8. 读数据 `public read(bleDevice: BleDevice, uuid_service: string, uuid_read: string, callback: BleReadCallback)`
9. 写数据 `public write(bleDevice: BleDevice, uuid_service: string, uuid_write: string, data: Uint8Array, split: boolean=true, sendNextWhenLastSuccess: boolean=true, intervalBetweenTwoPackage: number=0, callback: BleWriteCallback)`

## 约束与限制

DevEco Studio: 4.1 Canary (4.1.3.317)

OpenHarmony SDK: API 11 (4.1.0.36)

## 目录结构

深色代码主题复制
```text
|---- FastBle
|     |---- entry  # Sample code
|     |---- wxFastBle  # FastBle library
|	    |----src
         |----main
             |----ets
                 |----Bluetooth core logic
                 |----callback # Callback processing
                 |----exception # Exception handling
                 |----scan # Bluetooth scanning implementation
                 |----data # Data processing implementation
                 |----utils # Tools
                 |----BleManager.ets # Bluetooth connection management
|           |---- index.ets  # External APIs
|     |---- README.md  # Readme                    
```

## 开源协议

本项目基于 Apache LICENSE，请自由地享受和参与开源。

## 更新记录

### v2.0.6

modify BleManager.getInstance.scan(callback: BleScanCallback, scanOptions?: ble.ScanOptions) The scanOptions parameter of the interface.

### v2.0.5

resolving the issue where the BleManager.getInstance().write() method fails when writing large amounts of data with the data segmentation set to true.
Switch from gitee to gitcode

### v2.0.5-rc.0

resolving the issue where the BleManager.getInstance().write() method fails when writing large amounts of data with the data segmentation set to true.

### v2.0.4

发布 2.0.4 正式版

### v2.0.3

修改调用 setMtu 时返回设置失败问题。
修改调用 write 进行特征值写入时，部分设备收不到数据问题。
修改调用 write 方法后，关闭手机蓝牙，然后打开重新扫描链接后再调用 write 方法，onCharacteristicChanged 会多次回调。
优化蓝牙扫描、连接、断开连接、以及监听事件注册的逻辑，添加异常捕获。

### v2.0.2

修改调用 BleManager 的 notify 接口后，在 onNotifySuccess 回调中再调用 BleManager 的 write 方法后，报错 device is busy 的 BUG。

### v2.0.1

新增 notify 特征值改变事件监听

### v2.0.1-rc.0

完善权限配置字段
修复语法报错问题

### v2.0.0

适配 DevEco Studio 版本：4.1 Canary(4.1.3.317)，OpenHarmony SDK:API11 (4.1.0.36)
ArkTs 语法适配

### v1.1.0

名称由@ohos/fastble-ets 修改为@ohos/fastble
旧的包@ohos/fastble-ets 已不维护，请使用新包@ohos/fastble

### v1.0.1

api8 升级到 api9 stage 模型
解决一些 bug，如写操作的 crash 问题，解析权限处理流
修改描述符操作，为搜索结果添加设备名称

### v1.0.0

已实现功能
1.初始化
2.扫描
3.连接
4.取消扫描
5.打开蓝牙
6.关闭蓝牙
7.读 Characteristic
8.写 Characteristic

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

| 隐私政策 | 不涉及 |
| :--- | :--- |
| SDK 合规使用指南 | 不涉及 |

| 兼容性 | HarmonyOS 版本 |
| :--- | :--- |
| 5.0.0 |

Created with Pixso.

| 应用类型 | 应用 |
| :--- | :--- |
| Created with Pixso. |

| 元服务 | |
| :--- | :--- |
| Created with Pixso. |

| 设备类型 | 手机 |
| :--- | :--- |
| Created with Pixso. |

| 平板 | |
| :--- | :--- |
| Created with Pixso. |

| PC | |
| :--- | :--- |
| Created with Pixso. |

| DevEcoStudio 版本 | DevEco Studio 5.0.0 |
| :--- | :--- |
| Created with Pixso. |

## 安装方式

```bash
ohpm install @ohos/fastble
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/dca785c6dc1d458c8fd12568ecd78f05/PLATFORM?origin=template