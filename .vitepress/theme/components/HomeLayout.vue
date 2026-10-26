<script setup>
import { ref } from "vue";
import { useData } from "vitepress";
import DefaultTheme from "vitepress/theme";
import { Navigation, Pagination } from "swiper/modules";
import { Swiper, SwiperSlide } from "swiper/vue";
import "swiper/css";
import "swiper/css/navigation";
import "swiper/css/pagination";

import GUIforClash from "/components/GUIforClash.vue";
import GUIforSingBox from "/components/GUIforSingBox.vue";

const { frontmatter } = useData();

const modules = [Navigation, Pagination];
const apps = ["GUI.for.Clash", "GUI.for.SingBox"];
const activeApp = ref(0);

const onSlideChange = (swiper) => {
  activeApp.value = swiper.activeIndex;
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
        <img
          v-if="frontmatter.hero?.image?.src"
          class="eyebrow-logo"
          :src="frontmatter.hero.image.src"
          :alt="frontmatter.hero.image.alt"
        />
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
        <div class="app-window">
          <div class="app-window-bar">
            <span class="dot red"></span>
            <span class="dot yellow"></span>
            <span class="dot green"></span>
            <span class="app-window-title">{{ apps[activeApp] }}</span>
          </div>
          <Swiper
            :slides-per-view="1"
            :modules="modules"
            :pagination="{ clickable: true }"
            navigation
            @slide-change="onSlideChange"
          >
            <SwiperSlide class="swiper-slide">
              <GUIforClash />
            </SwiperSlide>
            <SwiperSlide class="swiper-slide">
              <GUIforSingBox />
            </SwiperSlide>
          </Swiper>
        </div>
      </div>
    </template>

    <template #home-features-after>
      <div class="bottom-glow" aria-hidden="true"></div>
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

.eyebrow-logo {
  width: 64px;
  height: 64px;
  border-radius: 18px;
  border: 1px solid var(--gfc-border-default);
  box-shadow: 0 12px 40px rgba(46, 96, 159, 0.35);
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
  width: min(100% - 48px, 940px);
  margin: 24px auto 96px;
}

.app-window {
  border-radius: var(--gfc-radius-panel);
  border: 1px solid var(--gfc-border-default);
  background-color: color-mix(in srgb, var(--gfc-page) 70%, transparent);
  box-shadow: var(--gfc-shadow-card), 0 40px 120px rgba(0, 0, 0, 0.35);
  -webkit-backdrop-filter: blur(var(--gfc-blur-glass));
  backdrop-filter: blur(var(--gfc-blur-glass));
  overflow: hidden;
}

.app-window-bar {
  display: flex;
  align-items: center;
  gap: 8px;
  height: 40px;
  padding: 0 16px;
  border-bottom: 1px solid var(--gfc-border-subtle);
  background-color: var(--gfc-surface-1);
}

.dot {
  width: 12px;
  height: 12px;
  border-radius: 50%;
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

.app-window-title {
  margin-left: 12px;
  font-size: 13px;
  font-weight: 500;
  color: var(--gfc-text-secondary);
}

.swiper-slide {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 32px 32px 48px;
}

.swiper-slide :deep(iframe) {
  max-width: 100%;
  border-radius: var(--gfc-radius-media);
  border: 1px solid var(--gfc-border-subtle);
  box-shadow: none;
}

.app-preview :deep(.swiper-button-prev),
.app-preview :deep(.swiper-button-next) {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  border: 1px solid var(--gfc-border-default);
  background-color: var(--gfc-surface-1);
  -webkit-backdrop-filter: blur(var(--gfc-blur-glass));
  backdrop-filter: blur(var(--gfc-blur-glass));
  color: var(--gfc-text);
  --swiper-navigation-size: 14px;
}

.app-preview :deep(.swiper-pagination-bullet) {
  background-color: var(--gfc-text);
  opacity: 0.25;
}

.app-preview :deep(.swiper-pagination-bullet-active) {
  opacity: 1;
  width: 20px;
  border-radius: var(--gfc-radius-pill);
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
    width: 100%;
    padding: 0 12px;
  }

  .swiper-slide {
    padding: 16px 12px 40px;
  }
}
</style>
