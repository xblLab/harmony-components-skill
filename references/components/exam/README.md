# 考试答题组件

## 简介

本组件支持展示各类考题，并可以进行考试。

## 详细介绍

### 简介

本组件支持展示各类考题，并可以进行考试。

### 练习设置

答题卡模拟考试

### 约束与限制

#### 环境

- DevEco Studio版本：DevEco Studio 5.0.1 Release及以上
- HarmonyOS SDK版本：HarmonyOS 5.0.1 Release SDK及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 5.0.1(13)及以上

### 快速入门

1. 安装组件。

   如果是在DevEco Studio使用插件集成组件，则无需安装组件，请忽略此步骤。

   如果是从生态市场下载组件，请参考以下步骤安装组件。

   a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的XXX目录下。

   b. 在项目根目录build-profile.json5添加exam模块。

   ```json5
   // 在项目根目录build-profile.json5填写exam路径。其中XXX为组件存放的目录名
   "modules": [
       {
         "name": "exam",
         "srcPath": "./XXX/exam"
       }
   ]
   ```

   c. 在项目根目录oh-package.json5中添加依赖。

   ```json5
   // XXX为组件存放的目录名称
   "dependencies": {
     "exam": "file:./XXX/exam"
   }
   ```

2. 引入组件。

   ```typescript
   import { Exam } from 'exam';
   ```

3. 调用组件，详细参数配置说明参见API参考。

   ```typescript
   import { Exam, ExamController, ExamManager, showSettingSheet } from 'exam';
   import { generateExamDetail } from './SequencePractice';

   @Builder
   export function MockExamBuilder() {
     MockExam();
   }

   @ComponentV2
   export struct MockExam {
     @Consumer('appPathStack') appPathStack: NavPathStack = new NavPathStack();
     @Local isShowSetting: boolean = false;
     private examController: ExamController = ExamController.instance;
     @Local examManager: ExamManager = new ExamManager('模拟考试', generateExamDetail());

     aboutToAppear(): void {
        this.examManager.timeLimit = 10;
     }
     build() {
        NavDestination() {
           Column() {
              Exam({
                 appPathStack: this.appPathStack,
                 examManager: this.examManager,
              });
           }
           .width('100%')
              .height('100%')
        }
        .title('模拟考试')
           .menus(this.toolBar())
           .onBackPressed(() => {
              if (this.examManager.timeLimit !== 0) {
                 // 打开模拟考试结束弹窗
                 this.examController.isShowMockExamDialog = true;
                 return true;
              }
              this.appPathStack.pop();
              return true;
           })
     }

     @Builder
     toolBar() {
        Row() {
           SymbolGlyph($r('sys.symbol.gearshape'))
              .fontSize(27)
        }
        .width(50)
           .height(40)
           .justifyContent(FlexAlign.Center)
           .margin({
              top: 10,
              right: '4%',
           })
           .onClick(() => {
              this.isShowSetting = !this.isShowSetting
           })
           .bindSheet($$this.isShowSetting, showSettingSheet(), {
              height: '25%',
              width: '100%',
              title: { title: '设置' },
              backgroundColor: Color.White,
           });
     }
   }
   ```

## API参考

### 子组件

无

### 接口

#### Exam(options: ExamOptions)

驾考-考试组件。

##### ExamOptions对象说明

| 名称 | 类型 | 必填 | 说明 |
|------|------|------|------|
| appPathStack | NavPathStack | 是 | 页面路由栈 |
| examManager | ExamManager | 是 | 考卷 |
| mockExamCall | Callback<number, void> | 否 | 记录模拟考试分数回调，用于计算模拟考试平均分 |

##### ExamManager对象说明

| 名称 | 类型 | 必填 | 说明 |
|------|------|------|------|
| id | string | 是 | 考卷Id |
| name | string \| Resource | 是 | 考卷名称 |
| currentQuestionId | number | 是 | 当前题目Id, 退出后重新进入时展示退出前的题目id |
| total | number | 是 | 题目数量 |
| timeLimit | number | 是 | 时间限制(以分钟为单位)，模拟考试时显示剩余时间 |
| correctNumber | number | 是 | 答题正确数量 |
| errorNumber | number | 是 | 答题错误数量 |
| examDetails | Array<ExamDetail> | 是 | 考题 |
| clearSelectedOption | 方法 | 否 | 清空已选项，顺序练习返回时清空已选项 |
| clearRecords | 方法 | 否 | 清空记录(是否收藏除外)，答题卡清空记录 |

##### ExamDetail对象说明

| 名称 | 类型 | 必填 | 说明 |
|------|------|------|------|
| id | string | 是 | 题目Id |
| question | string | 是 | 问题 |
| questionImage | string | 是 | 问题图片（部分问题下面会有图片），根据图片回答问题 |
| options | Array | 是 | 全部选项 |
| selected | Array | 是 | 已选项 |
| answer | Array | 是 | 正确答案 |
| isCorrect | boolean | 否 | 是否正确(undefined-未选择, true-选择正确, false-选择错误) |
| questionType | QuestionTypeEnum | 是 | 题目类型 |
| classificationType | ClassificationTypeEnum | 是 | 难易程度 |
| analysis | string | 是 | 题目解析 |
| videoExplainUrl | string | 是 | 视频讲题-视频url |
| isCollect | boolean | 是 | 是否收藏 |
| chapterName | string | 是 | 章节名称-按章节分类 |

##### QuestionTypeEnum对象说明

| 名称 | 说明 |
|------|------|
| RADIO | 单选 |
| CHECK_BOX | 多选 |
| JUDGE | 判断 |

##### ClassificationTypeEnum对象说明

| 名称 | 说明 |
|------|------|
| EASY | 容易 |
| SIMPLE | 简单 |
| MIDDLE | 一般 |
| HARD | 困难 |
| EASY_MISTAKE | 易错 |

### 事件

支持以下事件：

#### mockExamCall

```typescript
mockExamCall: (score: number) => void = (score: number) => {}
// 记录模拟考试分数回调, 用于计算模拟考试平均分
```

## 示例代码

### Index.ets同级目录新建MockExam.ets，模拟考试页面

```typescript
import { Exam, ExamController, ExamManager, showSettingSheet } from 'exam';
import { generateExamDetail } from './SequencePractice';

@Builder
export function MockExamBuilder() {
   MockExam();
}

@ComponentV2
export struct MockExam {
   @Consumer('appPathStack') appPathStack: NavPathStack = new NavPathStack();
   @Local isShowSetting: boolean = false;
   private examController: ExamController = ExamController.instance;
   @Local examManager: ExamManager = new ExamManager('模拟考试', generateExamDetail());

   aboutToAppear(): void {
      this.examManager.timeLimit = 10;
   }
   build() {
      NavDestination() {
         Column() {
            Exam({
               appPathStack: this.appPathStack,
               examManager: this.examManager,
            });
         }
         .width('100%')
            .height('100%')
      }
      .title('模拟考试')
         .menus(this.toolBar())
         .onBackPressed(() => {
            if (this.examManager.timeLimit !== 0) {
               // 打开模拟考试结束弹窗
               this.examController.isShowMockExamDialog = true;
               return true;
            }
            this.appPathStack.pop();
            return true;
         })
   }

   @Builder
   toolBar() {
      Row() {
         SymbolGlyph($r('sys.symbol.gearshape'))
            .fontSize(27)
      }
      .width(50)
         .height(40)
         .justifyContent(FlexAlign.Center)
         .margin({
            top: 10,
            right: '4%',
         })
         .onClick(() => {
            this.isShowSetting = !this.isShowSetting
         })
         .bindSheet($$this.isShowSetting, showSettingSheet(), {
            height: '25%',
            width: '100%',
            title: { title: '设置' },
            backgroundColor: Color.White,
         });
   }
}
```

### Index.ets同级目录新建SequencePractice.ets，顺序练习页面

```typescript
import { ClassificationTypeEnum, Exam, ExamDetail, ExamManager, QuestionTypeEnum, showSettingSheet } from 'exam';

@Builder
export function SequencePracticeBuilder() {
   SequencePractice();
}

@ComponentV2
export struct SequencePractice {
   @Consumer('appPathStack') appPathStack: NavPathStack = new NavPathStack();
   @Local isShowSetting: boolean = false;
   @Local examManager: ExamManager = new ExamManager('顺序练习', generateExamDetail());

   build() {
      NavDestination() {
         Column() {
            Exam({
               appPathStack: this.appPathStack,
               examManager: this.examManager,
            });
         }
         .width('100%')
            .height('100%')
      }
      .title('顺序练习')
         .menus(this.toolBar())
   }

   @Builder
   toolBar() {
      Row() {
         SymbolGlyph($r('sys.symbol.gearshape'))
            .fontSize(27)
      }
      .width(50)
         .height(40)
         .justifyContent(FlexAlign.Center)
         .margin({
            top: 10,
            right: '4%',
         })
         .onClick(() => {
            this.isShowSetting = !this.isShowSetting
         })
         .bindSheet($$this.isShowSetting, showSettingSheet(), {
            height: '25%',
            width: '100%',
            title: { title: '设置' },
            backgroundColor: Color.White,
         });
   }
}

/**
 * 生成全部考题
 * @returns 全部考题
 */
export function generateExamDetail(): Array<ExamDetail> {
   let examDetails: Array<ExamDetail> = [];
   examDetails.push(new ExamDetail('驾驶机动车通过学校时要注意什么 ?', '',
      ['观察标志标线',
         '减速慢行',
         '不要鸣喇叭',
         '快速通过'],
      ['观察标志标线', '减速慢行', '不要鸣喇叭'],
      QuestionTypeEnum.CHECK_BOX, ClassificationTypeEnum.SIMPLE,
      '驾驶机动车上路行驶必须随车携带机动车行驶证（' +
         '证明车辆合法上路资格）。其他选项如登记证，保' +
         '险单，合格证无需随车携带。\n' +
         '根据《道路交通安全法》的规定，驾驶机动车上道' +
         '路行驶，应当悬挂机动车号牌，放置检验合格标志' +
         '，保险标志，并随车携带机动车行驶证。',
      '驾驶证和机动车管理规定',
      'https://consumer.huawei.com/content/dam/huawei-cbg-site/cn/mkt/pdp/phones/ah-ultra/video/kv-intro-pop.mp4'));
   examDetails.push(new ExamDetail('下列哪种证件是驾驶机动车上路行驶时，应当随身携带的?', '',
      ['机动车登记证',
         '机动车保险单',
         '机动车行驶证',
         '出厂合格证明'],
      ['机动车登记证'],
      QuestionTypeEnum.RADIO, ClassificationTypeEnum.SIMPLE,
      '驾驶机动车上路行驶必须随车携带机动车行驶证（' +
         '证明车辆合法上路资格）。其他选项如登记证，保' +
         '险单，合格证无需随车携带。\n' +
         '根据《道路交通安全法》的规定，驾驶机动车上道' +
         '路行驶，应当悬挂机动车号牌，放置检验合格标志' +
         '，保险标志，并随车携带机动车行驶证。',
      '驾驶证和机动车管理规定',
      'https://consumer.huawei.com/content/dam/huawei-cbg-site/cn/mkt/pdp/phones/ah-ultra/video/kv-intro-pop.mp4'));

   examDetails.push(new ExamDetail('驾驶这种机动车上路行驶没有违法行为', 'app.media.question_image',
      ['正确',
         '错误'],
      ['错误'],
      QuestionTypeEnum.JUDGE, ClassificationTypeEnum.EASY,
      '驾驶机动车上路行驶必须随车携带机动车行驶证（' +
         '证明车辆合法上路资格）。其他选项如登记证，保' +
         '险单，合格证无需随车携带。\n' +
         '根据《道路交通安全法》的规定，驾驶机动车上道' +
         '路行驶，应当悬挂机动车号牌，放置检验合格标志' +
         '，保险标志，并随车携带机动车行驶证。',
      '驾驶证和机动车管理规定',
      'https://consumer.huawei.com/content/dam/huawei-cbg-site/cn/mkt/pdp/phones/ah-ultra/video/kv-intro-pop.mp4'));

   examDetails.push(new ExamDetail('驾驶机动车行经下列那种路段不得超车?', '',
      ['主要街道',
         '高架路',
         '人行横道',
         '环城高速'],
      ['人行横道'],
      QuestionTypeEnum.RADIO, ClassificationTypeEnum.SIMPLE,
      '驾驶机动车上路行驶必须随车携带机动车行驶证（' +
         '证明车辆合法上路资格）。其他选项如登记证，保' +
         '险单，合格证无需随车携带。\n' +
         '根据《道路交通安全法》的规定，驾驶机动车上道' +
         '路行驶，应当悬挂机动车号牌，放置检验合格标志' +
         '，保险标志，并随车携带机动车行驶证。',
      '驾驶证和机动车管理规定',
      'https://consumer.huawei.com/content/dam/huawei-cbg-site/cn/mkt/pdp/phones/ah-ultra/video/kv-intro-pop.mp4'));

   examDetails.push(new ExamDetail('驾驶人一边驾车，一边打手持电话是违法行为', '',
      ['正确',
         '错误'],
      ['正确'],
      QuestionTypeEnum.JUDGE, ClassificationTypeEnum.MIDDLE,
      '驾驶机动车上路行驶必须随车携带机动车行驶证（' +
         '证明车辆合法上路资格）。其他选项如登记证，保' +
         '险单，合格证无需随车携带。\n' +
         '根据《道路交通安全法》的规定，驾驶机动车上道' +
         '路行驶，应当悬挂机动车号牌，放置检验合格标志' +
         '，保险标志，并随车携带机动车行驶证。',
      '驾驶证和机动车管理规定',
      'https://consumer.huawei.com/content/dam/huawei-cbg-site/cn/mkt/pdp/phones/ah-ultra/video/kv-intro-pop.mp4'));

   examDetails.push(new ExamDetail('驾驶机动车下陡坡时不得有哪些危险行为?', '',
      ['提前减档',
         '空挡滑行',
         '低档减速',
         '制动减速'],
      ['空挡滑行'],
      QuestionTypeEnum.RADIO, ClassificationTypeEnum.SIMPLE,
      '驾驶机动车上路行驶必须随车携带机动车行驶证（' +
         '证明车辆合法上路资格）。其他选项如登记证，保' +
         '险单，合格证无需随车携带。\n' +
         '根据《道路交通安全法》的规定，驾驶机动车上道' +
         '路行驶，应当悬挂机动车号牌，放置检验合格标志' +
         '，保险标志，并随车携带机动车行驶证。',
      '驾驶证和机动车管理规定',
      'https://consumer.huawei.com/content/dam/huawei-cbg-site/cn/mkt/pdp/phones/ah-ultra/video/kv-intro-pop.mp4'));

   examDetails.push(new ExamDetail('机动车驾驶人在实习期内驾驶机动车不得牵引挂车', 'app.media.question_image',
      ['正确',
         '错误'],
      ['正确'],
      QuestionTypeEnum.JUDGE, ClassificationTypeEnum.HARD,
      '驾驶机动车上路行驶必须随车携带机动车行驶证（' +
         '证明车辆合法上路资格）。其他选项如登记证，保' +
         '险单，合格证无需随车携带。\n' +
         '根据《道路交通安全法》的规定，驾驶机动车上道' +
         '路行驶，应当悬挂机动车号牌，放置检验合格标志' +
         '，保险标志，并随车携带机动车行驶证。',
      '道路通行条件及通行规定',
      'https://consumer.huawei.com/content/dam/huawei-cbg-site/cn/mkt/pdp/phones/ah-ultra/video/kv-intro-pop.mp4'));

   examDetails.push(new ExamDetail('驾驶机动车上路前应当检查车辆安全技术性能', '',
      ['正确',
         '错误'],
      ['正确'],
      QuestionTypeEnum.JUDGE, ClassificationTypeEnum.EASY_MISTAKE,
      '驾驶机动车上路行驶必须随车携带机动车行驶证（' +
         '证明车辆合法上路资格）。其他选项如登记证，保' +
         '险单，合格证无需随车携带。\n' +
         '根据《道路交通安全法》的规定，驾驶机动车上道' +
         '路行驶，应当悬挂机动车号牌，放置检验合格标志' +
         '，保险标志，并随车携带机动车行驶证。',
      '道路通行条件及通行规定',
      'https://consumer.huawei.com/content/dam/huawei-cbg-site/cn/mkt/pdp/phones/ah-ultra/video/kv-intro-pop.mp4'));

   return examDetails;
}
```

### 在 src/main/resources/base/profile 下新建 router_map.json, 用于页面跳转

```json5
{
   "routerMap": [
      {
         "name": "SequencePractice",
         "pageSourceFile": "src/main/ets/pages/SequencePractice.ets",
         "buildFunction": "SequencePracticeBuilder"
      },
      {
         "name": "MockExam",
         "pageSourceFile": "src/main/ets/pages/MockExam.ets",
         "buildFunction": "MockExamBuilder"
      }
   ]
}
```

### 在 src/main/module.json5 下 module中添加

```json5
"routerMap": "$profile:router_map",
```

### Index.ets，入口页面

```typescript
@Entry
@ComponentV2
struct Index {
   @Provider('appPathStack') appPathStack: NavPathStack = new NavPathStack();

   build() {
      Navigation(this.appPathStack) {
         Column({space: 50}) {
            Text('顺序练习')
               .textAlign(TextAlign.Center)
               .fontSize(24)
               .width('50%')
               .height(64)
               .fontColor(Color.White)
               .backgroundColor(Color.Blue)
               .borderRadius(10)
               .onClick(() => {
                  this.appPathStack.pushPathByName('SequencePractice', undefined)
               })

            Text('模拟考试')
               .textAlign(TextAlign.Center)
               .fontSize(24)
               .width('50%')
               .height(64)
               .fontColor(Color.White)
               .backgroundColor(Color.Blue)
               .borderRadius(10)
               .onClick(() => {
                  this.appPathStack.pushPathByName('MockExam', undefined)
               })
         }
         .padding({
            top: 200
         })
            .width('100%')
            .height('100%')
            .backgroundColor('#F1F3F5')
      }
      .hideTitleBar(true)
      .hideToolBar(true)
      .hideBackButton(true)
      .mode(NavigationMode.Stack)
   }
}
```

## 更新记录

### 1.0.3 (2025-11-07)

- ReadMe修改

[下载该版本](#)

### 1.0.2 (2025-08-30)

- ReadMe优化

[下载该版本](#)

### 1.0.1 (2025-07-30)

- README内容优化

[下载该版本](#)

### 1.0.0 (2025-07-01)

- 本组件支持展示各类考题，并可以进行考试。

[下载该版本](#)

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
|---------|---------|---------|
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK合规使用指南

不涉及

## 兼容性

### HarmonyOS版本

| 版本 | 支持 |
|------|------|
| 5.0.1 | ✓ |
| 5.0.2 | ✓ |
| 5.0.3 | ✓ |
| 5.0.4 | ✓ |
| 5.0.5 | ✓ |
| 5.1.0 | ✓ |
| 5.1.1 | ✓ |
| 6.0.0 | ✓ |

### 应用类型

| 类型 | 支持 |
|------|------|
| 应用 | ✓ |
| 元服务 | ✓ |

### 设备类型

| 类型 | 支持 |
|------|------|
| 手机 | ✓ |
| 平板 | ✓ |
| PC | ✓ |

### DevEcoStudio版本

| 版本 | 支持 |
|------|------|
| DevEco Studio 5.0.1 | ✓ |
| DevEco Studio 5.0.2 | ✓ |
| DevEco Studio 5.0.3 | ✓ |
| DevEco Studio 5.0.4 | ✓ |
| DevEco Studio 5.0.5 | ✓ |
| DevEco Studio 5.1.0 | ✓ |
| DevEco Studio 5.1.1 | ✓ |
| DevEco Studio 6.0.0 | ✓ |

## 来源

- 原始URL: https://developer.huawei.com/consumer/cn/market/prod-detail/8a34dbb3647248f28bc83c0033118116/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%80%83%E8%AF%95%E7%AD%94%E9%A2%98%E7%BB%84%E4%BB%B6/exam1.0.3.zip