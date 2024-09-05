import { defineConfig } from "vitepress";

export const en = defineConfig({
  lang: "en-US",
  themeConfig: {
    nav: [
      { text: "Home", link: "/" },
      { text: "Guide", link: "/guide/" },
      { text: "Group", link: "https://t.me/GUI_for_Cores" },
      { text: "Channel", link: "https://t.me/GUI_for_Cores_Channel" },
    ],

    sidebar: {
      "/guide/": {
        base: "/guide/",
        items: [
          {
            text: "通用文档",
            items: [
              { text: "User Manual", link: "index.md" },
              { text: "Installation", link: "01-install" },
              { text: "Uninstallation", link: "02-uninstall" },
              { text: "Update", link: "09-update" },
              { text: "How it works", link: "03-how-it-works" },
              { text: "Plugins System", link: "04-plugins" },
              { text: "Scheduled Task System", link: "05-tasks" },
              { text: "Mixin & Script", link: "06-mixin-script" },
              { text: "Tips", link: "08-skills" },
            ],
          },
          {
            text: "GUI.for.Clash",
            base: "/guide/gfc/",
            items: [
              { text: "简介", link: "index.md" },
              { text: "A Guide for GUI.for.Clash", link: "how-to-use" },
            ],
          },
          {
            text: "GUI.for.SingBox",
            base: "/guide/gfs/",
            items: [
              { text: "简介", link: "index.md" },
              { text: "A Guide for GUI.for.SingBox", link: "community" },
            ],
          },
          {
            text: "社区教程",
            base: "/guide/community/",
            items: [
              {
                text: "Import Custom Proxies",
                link: "01-add-proxies-and-rulesets",
              },
              {
                text: "Run TUN mode in Gnome Desktop Environment Without Password",
                link: "02-run-tun-mode-without-password",
              },
            ],
          },
        ],
      },
    },

    footer: {
      message: "",
      copyright: "Copyright © 2023-present GUI-for-Cores",
    },
  },
});
