# log 快速打印工具组件

## 简介

log 一款加快项目开发的打印工具，支持任意类型、格式化快速打印。

## 详细介绍

### 简介

log，一款加快项目开发的打印工具，支持任意类型、格式化快速打印。

### 安装

```bash
ohpm install @wwy/log
```

### 使用

```typescript
import log from '@wwy/log'

log.debug/info/warn/error/fatal(data, [tag])
```

| 参数 | 描述 |
| :--- | :--- |
| debug | 输出 DEBUG 级别日志。仅用于应用/服务调试。 |
| info | 输出 INFO 级别日志。表示普通的信息。 |
| warn | 输出 WARN 级别日志。表示存在警告。 |
| error | 输出 ERROR 级别日志。表示存在错误。 |
| fatal | 输出 FATAL 级别日志。表示出现致命错误、不可恢复错误。 |

**示例代码：**

```typescript
import log from '@wwy/log'

@Entry
@Component
struct Demo {
  build() {
    Row() {
      Button('Config').onClick(() => {
        log.init({
          domain: 0xFF00,
          tag: 'slj',
          icon: '✨',
          close: false,
        })
        log.error('Config Success！')
      })
      Button('Try').onClick(() => {
        log.info(666) // 直接打印，无需配置
        log.info(true)
        log.info('hello')
        log.info(null)
        log.info(undefined)
        log.info([11, 22, 33])
        log.info({ a: 11, b: 22, c: "hello" }) // 直接格式化打印，无需配置
        log.info('{"a":11,"b":22,"c":"hello"}') // 直接格式化打印，无需配置
        log.info({"state":200,"msg":"操作成功","total":13,"list":[{"swiper_id":14,"img":"/slj/swiper/7.png","url":"","created_at":"2024-05-02 17:57:27","updated_at":"2024-05-02 17:57:27"},{"swiper_id":13,"img":"/slj/swiper/6.png","url":"","created_at":"2024-05-02 17:57:09","updated_at":"2024-05-02 17:57:09"},{"swiper_id":12,"img":"/slj/swiper/7.png","url":"","created_at":"2024-05-02 17:56:50","updated_at":"2024-05-02 17:56:50"},{"swiper_id":11,"img":"/slj/swiper/7.png","url":"","created_at":"2024-05-02 17:55:50","updated_at":"2024-05-02 17:55:50"},{"swiper_id":10,"img":"/slj/swiper/7.png","url":"","created_at":"2024-05-02 17:54:36","updated_at":"2024-05-02 17:54:36"},{"swiper_id":9,"img":"/slj/swiper/7.png","url":"","created_at":"2024-05-02 17:54:27","updated_at":"2024-05-02 17:54:27"}]})
      })
    }
  }
}
```

### 配置

```typescript
log.init({
  domain: 0xFF00,
  tag: 'slj',
  icon: '✨',
  close: false,
})
```

## 安装方式

```bash
ohpm install @wwy/log
```

## 权限与隐私

| 项目 | 详情 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 详情 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.1 |
| 应用类型 | 应用、元服务 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.1 |

## License

MIT

## 更新记录

[v1.0.0] 2024-12
log 一款加快项目开发的打印工具，支持任意类型、格式化快速打印。

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/bcce98cf40a448cb9f57d74eee7553d4/PLATFORM?origin=template