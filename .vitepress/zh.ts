import { defineConfig } from "vitepress";

export const zh = defineConfig({
  lang: "zh-Hans",
  themeConfig: {
    nav: [
      { text: "主页", link: "/zh/" },
      { text: "指南", link: "/zh/guide/" },
      { text: "群组", link: "https://t.me/GUI_for_Cores" },
      { text: "频道", link: "https://t.me/GUI_for_Cores_Channel" },
    ],

    sidebar: {
      "/zh/guide/": {
        base: "/zh/guide/",
        items: [
          {
            text: "通用文档",
            items: [
              { text: "项目指南", link: "index.md" },
              { text: "安装", link: "01-install" },
              { text: "卸载", link: "02-uninstall" },
              { text: "更新", link: "09-update" },
              { text: "运行原理", link: "03-how-it-works" },
              { text: "插件系统", link: "04-plugins" },
              { text: "计划任务系统", link: "05-tasks" },
              { text: "混入与脚本", link: "06-mixin-script" },
              { text: "使用技巧", link: "08-skills" },
            ],
          },
          {
            text: "GUI.for.Clash",
            base: "/zh/guide/gfc/",
            items: [
              { text: "简介", link: "index.md" },
              { text: "使用教程", link: "how-to-use" },
            ],
          },
          {
            text: "GUI.for.SingBox",
            base: "/zh/guide/gfs/",
            items: [
              { text: "简介", link: "index.md" },
              { text: "社区版教程", link: "community" },
            ],
          },
          {
            text: "插件中心",
            base: "/zh/guide/plugin-hub/",
            items: [
              {
                text: "插件列表",
                link: "index.md",
              },
            ],
          },
          {
            text: "社区教程",
            base: "/zh/guide/community/",
            items: [
              {
                text: "添加节点和规则集",
                link: "01-add-proxies-and-rulesets",
              },
              {
                text: "在 Gnome 桌面环境中免密码运行 TUN 模式",
                link: "02-run-tun-mode-without-password",
              },
            ],
          },
        ],
      },
    },

    footer: {
      message: "",
      copyright: "版权所有 © 2023 至今 GUI-for-Cores",
    },
  },
});
