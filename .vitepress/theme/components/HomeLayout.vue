<script setup>
import DefaultTheme from "vitepress/theme";
</script>

<template>
  <DefaultTheme.Layout>
    <template #home-features-before>
      <div class="app-preview">
        <iframe src="/apps/gfs/"></iframe>
      </div>
    </template>
  </DefaultTheme.Layout>
</template>

<style scoped>
.app-preview {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0 0 40px 0;
  iframe {
    width: 800px;
    height: 540px;
    border: none;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 16px rgba(0, 0, 0, 0.4);
  }
}
</style>
