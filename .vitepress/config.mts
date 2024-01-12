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
        text: "GUI.for.Clash",
        items: [
          { text: "简介", link: "/gfc/index.md" },
          { text: "安装", link: "/gfc/01-install.md" },
          { text: "卸载", link: "/gfc/02-uninstall.md" },
          { text: "运行原理", link: "/gfc/03-how-it-works.md" },
        ],
      },
      {
        text: "GUI.for.SingBox",
        items: [
          { text: "简介", link: "/gfs/index.md" },
          { text: "社区版教程", link: "/gfs/community.md" },
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
