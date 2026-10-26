import DefaultTheme from "vitepress/theme";
import HomeLayout from "./components/HomeLayout.vue";

import "@fontsource/dm-sans/latin-400.css";
import "@fontsource/dm-sans/latin-500.css";
import "@fontsource/dm-sans/latin-600.css";
import "@fontsource/montserrat/latin-400.css";
import "@fontsource/montserrat/latin-500.css";
import "@fontsource/fragment-mono/latin-400.css";
import "./style.css";

export default {
  extends: DefaultTheme,
  Layout: HomeLayout,
};
