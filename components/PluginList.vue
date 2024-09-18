<script setup lang="ts">
import generic from "/Plugin-Hub/plugins/generic.json";
</script>

<template>
  <div class="plugins-list">
    <div v-for="plugin in generic" :key="plugin.id" class="item">
      <h2 class="header">
        <div class="name">
          {{ plugin.name }}
        </div>
        <a class="source" :href="plugin.url" target="_blank">查看源码</a>
      </h2>
      <div class="id">{{ plugin.id }}</div>
      <div class="description">{{ plugin.description }}</div>
    </div>
  </div>
</template>

<style scoped>
.plugins-list {
  .item {
    a {
      text-decoration: none;
    }
    .header {
      display: flex;
      align-items: center;
      .name {
        font-weight: bold;
      }
      .source {
        margin-left: auto;
        font-size: 14px;
      }
    }
    .id {
      font-size: 14px;
    }
    .description {
      font-size: 14px;
      line-height: 1.6;
    }
  }
}
</style>
