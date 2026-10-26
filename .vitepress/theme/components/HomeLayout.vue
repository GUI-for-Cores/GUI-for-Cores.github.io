<script setup>
import { ref } from "vue";
import DefaultTheme from "vitepress/theme";
import { Swiper, SwiperSlide } from "swiper/vue";
import "swiper/css";

import AppEmbed from "./AppEmbed.vue";

const apps = [
  { name: "GUI.for.Clash", src: "/apps/gfc/" },
  { name: "GUI.for.SingBox", src: "/apps/gfs/" },
];
const activeApp = ref(0);
const appScale = ref(1);
let swiperInstance = null;

const onSwiper = (swiper) => {
  swiperInstance = swiper;
};

const onSlideChange = (swiper) => {
  activeApp.value = swiper.activeIndex;
};

const selectApp = (index) => {
  swiperInstance?.slideTo(index);
};
</script>

<template>
  <DefaultTheme.Layout>
    <template #home-hero-before>
      <div class="aurora" aria-hidden="true">
        <div class="aurora-layer aurora-a"></div>
        <div class="aurora-layer aurora-b"></div>
        <div class="aurora-layer aurora-c"></div>
        <div class="aurora-layer aurora-d"></div>
      </div>
    </template>

    <template #home-hero-info-before>
      <div class="eyebrow">
        <span class="eyebrow-label">
          <svg viewBox="0 0 24 24" aria-hidden="true">
            <path
              d="M12 2C12.9 6.6 17.4 11.1 22 12C17.4 12.9 12.9 17.4 12 22C11.1 17.4 6.6 12.9 2 12C6.6 11.1 11.1 6.6 12 2Z"
            />
          </svg>
          mihomo · sing-box
        </span>
      </div>
    </template>

    <template #home-features-before>
      <div class="app-preview">
        <div class="app-window" :style="{ '--app-scale': appScale }">
          <Swiper
            :slides-per-view="1"
            :allow-touch-move="false"
            @swiper="onSwiper"
            @slide-change="onSlideChange"
          >
            <SwiperSlide v-for="app in apps" :key="app.src">
              <AppEmbed
                :src="app.src"
                :title="app.name"
                @scale="appScale = $event"
              />
            </SwiperSlide>
          </Swiper>
          <div class="traffic-lights" aria-hidden="true">
            <span class="dot red"></span>
            <span class="dot yellow"></span>
            <span class="dot green"></span>
          </div>
        </div>
        <div class="app-switcher" role="tablist">
          <button
            v-for="(app, index) in apps"
            :key="app.src"
            type="button"
            role="tab"
            class="app-switcher-tab"
            :class="{ active: index === activeApp }"
            :aria-selected="index === activeApp"
            @click="selectApp(index)"
          >
            {{ app.name }}
          </button>
        </div>
      </div>
    </template>

    <template #home-features-after>
      <!-- <div class="bottom-glow" aria-hidden="true"></div> -->
    </template>
  </DefaultTheme.Layout>
</template>

<style scoped>
.aurora {
  position: absolute;
  top: calc(var(--vp-nav-height) * -1);
  left: 0;
  right: 0;
  height: 1180px;
  overflow: hidden;
  pointer-events: none;
  z-index: 0;
  -webkit-mask-image: linear-gradient(
    to bottom,
    #000 0%,
    #000 45%,
    rgba(0, 0, 0, 0.6) 70%,
    transparent 100%
  );
  mask-image: linear-gradient(
    to bottom,
    #000 0%,
    #000 45%,
    rgba(0, 0, 0, 0.6) 70%,
    transparent 100%
  );
}

.aurora-layer {
  position: absolute;
  border-radius: 50%;
  filter: blur(90px);
  will-change: transform;
}

.aurora-a {
  width: 80vw;
  height: 760px;
  left: -18vw;
  top: -180px;
  background: radial-gradient(
    closest-side,
    var(--gfc-aurora-a),
    transparent
  );
  opacity: 0.9;
  animation: drift-a 22s ease-in-out infinite alternate;
}

.aurora-b {
  width: 70vw;
  height: 640px;
  right: -16vw;
  top: -120px;
  background: radial-gradient(
    closest-side,
    var(--gfc-aurora-b),
    transparent
  );
  opacity: 0.7;
  animation: drift-b 26s ease-in-out infinite alternate;
}

.aurora-c {
  width: 90vw;
  height: 560px;
  left: 5vw;
  top: 300px;
  background: radial-gradient(
    closest-side,
    var(--gfc-aurora-c),
    transparent
  );
  opacity: 0.8;
}

.aurora-d {
  width: 46vw;
  height: 360px;
  left: 27vw;
  top: 40px;
  background: radial-gradient(
    closest-side,
    var(--gfc-aurora-b),
    transparent
  );
  opacity: 0.28;
  animation: drift-a 30s ease-in-out infinite alternate-reverse;
}

@keyframes drift-a {
  to {
    transform: translate3d(6vw, 40px, 0) scale(1.08);
  }
}

@keyframes drift-b {
  to {
    transform: translate3d(-8vw, 60px, 0) scale(0.94);
  }
}

@media (prefers-reduced-motion: reduce) {
  .aurora-layer {
    animation: none;
  }
}

.eyebrow {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 20px;
  margin-bottom: 20px;
}

.eyebrow-label {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  font-family: var(--gfc-font-mono);
  font-size: 12px;
  font-weight: 500;
  line-height: 1;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  color: var(--gfc-text-description);
}

.eyebrow-label svg {
  width: 12px;
  height: 12px;
  fill: var(--gfc-brand-deep);
  opacity: 0.8;
}

.app-preview {
  position: relative;
  z-index: 1;
  width: min(100% - 48px, 800px);
  margin: 24px auto 96px;
}

.app-window {
  position: relative;
  border-radius: var(--gfc-radius-panel);
  border: 1px solid var(--gfc-border-default);
  background-color: var(--gfc-page);
  box-shadow: var(--gfc-shadow-card), 0 40px 120px rgba(0, 0, 0, 0.35);
  overflow: hidden;
  isolation: isolate;
}

.traffic-lights {
  position: absolute;
  top: 0;
  left: 0;
  z-index: 2;
  display: flex;
  align-items: center;
  gap: calc(8px * var(--app-scale, 1));
  height: calc(40px * var(--app-scale, 1));
  padding-left: calc(16px * var(--app-scale, 1));
  pointer-events: none;
}

.dot {
  width: calc(12px * var(--app-scale, 1));
  height: calc(12px * var(--app-scale, 1));
  border-radius: 50%;
  box-shadow: inset 0 0 0 0.5px rgba(0, 0, 0, 0.18);
}

.dot.red {
  background-color: #ff5f57;
}

.dot.yellow {
  background-color: #febc2e;
}

.dot.green {
  background-color: #28c840;
}

.app-switcher {
  display: flex;
  justify-content: center;
  gap: 2px;
  width: fit-content;
  margin: 36px auto 0;
  padding: 3px;
  border-radius: var(--gfc-radius-pill);
  border: 1px solid var(--gfc-border-subtle);
  background-color: var(--gfc-surface-3);
}

.app-switcher-tab {
  padding: 4px 14px;
  border-radius: var(--gfc-radius-pill);
  font-size: 13px;
  font-weight: 500;
  line-height: 18px;
  color: var(--gfc-text-description);
  transition: background-color 0.2s ease, color 0.2s ease;
}

.app-switcher-tab:hover {
  color: var(--gfc-text);
}

.app-switcher-tab.active {
  color: var(--gfc-text);
  background-color: var(--gfc-surface-5);
}

.bottom-glow {
  position: relative;
  height: 260px;
  margin-top: -20px;
  pointer-events: none;
  background: radial-gradient(
    45% 45% at 50% 60%,
    color-mix(in srgb, var(--gfc-aurora-a) 40%, transparent),
    transparent 100%
  );
  -webkit-mask-image: linear-gradient(
    to bottom,
    transparent,
    #000 45%,
    #000 60%,
    transparent
  );
  mask-image: linear-gradient(
    to bottom,
    transparent,
    #000 45%,
    #000 60%,
    transparent
  );
}

@media screen and (max-width: 768px) {
  .app-preview {
    width: calc(100% - 24px);
  }

  .app-switcher-tab {
    padding: 4px 10px;
    font-size: 12px;
  }
}
</style>
