# 计划任务系统

![](/guide/resources/301_tasks.png)

## 计划任务系统能够做什么？

- 定时更新订阅。

- 定时更新规则集。

- 定时更新插件。

- 定时运行插件。

- 定时执行脚本。

## 计划任务运行原理

计划任务系统使用的依赖：https://github.com/robfig/cron/tree/v3

- 计划任务使用 cron 表达式；

- 支持到秒级，即 cron 表达式格式为 6 位，例如 `*  *  *  *  *  *`，一秒钟运行一次。

## 计划任务创建示例

1、定时更新订阅

![](/guide/resources/302_tasks.png)

2、定时更新规则集

![](/guide/resources/303_tasks.png)

1、定时更新插件

![](/guide/resources/304_tasks.png)

1、定时运行插件

插件需要有一个`onTask`方法：

```javascript
const onTask = () => {
  // 插件逻辑
  return "返回值会出现在日志中";
};
```

![](/guide/resources/305_tasks.png)

1、定时执行脚本

脚本中可以直接写`return`，返回值会出现在日志中

![](/guide/resources/306_tasks.png)

## 定时任务日志

![](/guide/resources/307_tasks.png)
