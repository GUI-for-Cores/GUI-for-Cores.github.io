import { defineConfig } from "vitepress";

export const shared = defineConfig({
  title: "GUI.for.Cores",
  description: "GUI for Cores Docs",

  rewrites: {
    "en/:rest*": ":rest*",
  },

  lastUpdated: true,
  cleanUrls: true,
  metaChunk: true,

  themeConfig: {
    socialLinks: [{ icon: "github", link: "https://github.com/GUI-for-Cores" }],
  },
});
