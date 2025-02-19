<script setup>
import DefaultTheme from "vitepress/theme";
import { Navigation, Pagination } from "swiper/modules";
import { Swiper, SwiperSlide } from "swiper/vue";
import "swiper/css";
import "swiper/css/navigation";
import "swiper/css/pagination";

const modules = [Navigation, Pagination];
</script>

<template>
  <DefaultTheme.Layout>
    <template #home-features-before>
      <div class="app-preview">
        <Swiper
          :slides-per-view="1"
          :modules="modules"
          :pagination="{ clickable: true }"
          navigation
        >
          <SwiperSlide class="swiper-slide">
            <iframe src="/apps/gfc/"></iframe>
          </SwiperSlide>
          <SwiperSlide class="swiper-slide">
            <iframe src="/apps/gfs/"></iframe>
          </SwiperSlide>
        </Swiper>
      </div>
    </template>
  </DefaultTheme.Layout>
</template>

<style scoped>
.app-preview {
  width: 60%;
  margin: 0 auto;
  .swiper-slide {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 40px;
  }
  iframe {
    width: 800px;
    height: 540px;
    border: none;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 0 16px rgba(0, 0, 0, 0.4);
  }
}

@media screen and (max-width: 768px) {
  .app-preview {
    width: 100%;
  }
}
</style>
