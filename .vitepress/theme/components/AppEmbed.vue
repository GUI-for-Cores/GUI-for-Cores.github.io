<script setup>
import { computed, onBeforeUnmount, onMounted, ref, watch } from "vue";
import { useData } from "vitepress";

const emit = defineEmits(["scale"]);

const props = defineProps({
  src: { type: String, required: true },
  title: { type: String, default: "" },
});

const MIN_WIDTH = 760;
const ASPECT = 0.6;

const { isDark } = useData();

const root = ref(null);
const frame = ref(null);
const width = ref(0);

const logicalWidth = computed(() => Math.max(width.value, MIN_WIDTH));
const logicalHeight = computed(() => Math.round(logicalWidth.value * ASPECT));
const scale = computed(() =>
  width.value ? width.value / logicalWidth.value : 1,
);

let resizeObserver;
let themeObserver;

const theme = () => (isDark.value ? "dark" : "light");

const getDocument = () => {
  try {
    return frame.value?.contentDocument || null;
  } catch {
    return null;
  }
};

const syncTheme = () => {
  const doc = getDocument();
  if (!doc?.body) return;
  doc.documentElement.style.colorScheme = theme();
  if (doc.body.getAttribute("theme-mode") !== theme()) {
    doc.body.setAttribute("theme-mode", theme());
  }
};

const onLoad = () => {
  const doc = getDocument();
  if (!doc?.body) return;

  themeObserver?.disconnect();
  themeObserver = new MutationObserver(syncTheme);
  themeObserver.observe(doc.body, {
    attributes: true,
    attributeFilter: ["theme-mode"],
  });
  syncTheme();
};

watch(isDark, syncTheme);
watch(scale, (value) => emit("scale", value), { immediate: true });

onMounted(() => {
  width.value = root.value.clientWidth;
  resizeObserver = new ResizeObserver(([entry]) => {
    width.value = entry.contentRect.width;
  });
  resizeObserver.observe(root.value);
});

onBeforeUnmount(() => {
  resizeObserver?.disconnect();
  themeObserver?.disconnect();
});
</script>

<template>
  <div
    ref="root"
    class="app-embed"
    :style="{ height: `${logicalHeight * scale}px` }"
  >
    <iframe
      ref="frame"
      :src="src"
      :title="title"
      :style="{
        width: `${logicalWidth}px`,
        height: `${logicalHeight}px`,
        transform: `scale(${scale})`,
      }"
      @load="onLoad"
    ></iframe>
  </div>
</template>

<style scoped>
.app-embed {
  position: relative;
  width: 100%;
  overflow: hidden;
}

.app-embed iframe {
  display: block;
  border: 0;
  border-radius: 0;
  box-shadow: none;
  transform-origin: 0 0;
}
</style>
