import { defineConfig } from "vitepress";

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "GUI for Cores Docs",
  description: "GUI for Cores Docs",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: "Home", link: "/" },
      { text: "Guide", link: "/guide/index.md" },
      { text: "TG Group", link: "https://t.me/GUI_for_Cores" },
      { text: "TG Channel", link: "https://t.me/GUI_for_Cores_Channel" },
    ],

    sidebar: [
      {
        text: "通用文档",
        items: [
          { text: "安装", link: "/guide/01-install.md" },
          { text: "卸载", link: "/guide/02-uninstall.md" },
          { text: "运行原理", link: "/guide/03-how-it-works.md" },
          { text: "插件系统", link: "/guide/04-plugins.md" },
          { text: "计划任务系统", link: "/guide/05-tasks.md" },
          { text: "使用技巧", link: "/guide/08-skills.md" },
        ],
      },
      {
        text: "GUI.for.Clash",
        items: [
          { text: "简介", link: "/gfc/index.md" },
          { text: "使用教程", link: "/gfc/how-to-use.md" },
        ],
      },
      {
        text: "GUI.for.SingBox",
        items: [
          { text: "简介", link: "/gfs/index.md" },
          { text: "社区版教程", link: "/gfs/community.md" },
        ],
      },
      {
        text: "社区教程",
        items: [
          { text: "添加节点和规则集", link: "/community/01-add-proxies-and-rulesets.md" },
        ],
      },
    ],

    footer: {
      message: "",
      copyright: "版权所有 © 2023 至今 GUI-for-Cores",
    },

    socialLinks: [{ icon: "github", link: "https://github.com/GUI-for-Cores" }],
  },
});
