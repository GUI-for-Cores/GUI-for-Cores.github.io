# Scheduled Task System

![](/zh/resources/guide/301_tasks.png)

## What Can the Scheduled Task System do?

- Regularly updates subscriptions

- Regularly updates rulesets

- Regularly updates plugins

- Regularly runs plugins

- Regularly runs scripts

## How the Scheduled Task Works

Dependencies for the Scheduled Task System: https://github.com/robfig/cron/tree/v3

- Scheduled tasks use cron expression

- Supports second-level precision, meaning the cron expression format is 6 fields, for example, `*  *  *  *  *  *`, which runs every second.

## Examples of Creating Scheduled Tasks

1. Regularly update subscriptions

![](/zh/resources/guide/302_tasks.png)

2. Regularly update rulesets

![](/zh/resources/guide/303_tasks.png)

3. Regularly update plugins

![](/zh/resources/guide/304_tasks.png)

4. Regularly run plugins

The plugin requires an `onTask` action present

```javascript
const onTask = () => {
  // 插件逻辑
  return "返回值会出现在日志中";
};
```

![](/zh/resources/guide/305_tasks.png)

5. Regularly run scripts

`return` can be written in the script. The returned value will show up in the logs

![](/zh/resources/guide/306_tasks.png)

## Scheduled Task Logs

![](/zh/resources/guide/307_tasks.png)
