<template>
  <div class="m-top" id="m-top">
    <div class="row">
      <div class="person">
        <img src="../../img/person.svg" class="rounded-circle" alt="Cinque Terre" width="150">
      </div>
      <div class="name">
        不系舟UnmooredZ's Blog
      </div>

      <!-- <h class="p-top-link" @click="csload('home')">Journey</h> -->

      <div class="github" @click="loadGithub">
        <img src="../../img/github.svg" class="rounded-circle svgshadow" alt="Cinque Terre" width="150">
      </div>
      <div class="lock" @click="locked">
        <img src="../../img/lock.svg" class="rounded-circle svgshadow" alt="Cinque Terre" width="150">
      </div>
      <!-- 遮挡无用区域 -->
      <div class="over bk">
        <img src="../../img/lock.svg" class="rounded-circle svgshadow" alt="Cinque Terre" width="150">
      </div>

      <div class="music">
        <span></span>
        <span></span>
        <span></span>
        <span></span>
        <span></span>
        <span></span>
        <span></span>
        <span></span>
        <span></span>
      </div>
    </div>
  </div>
</template>

<script>
  import EventBus from '@/EventBus';
  export default {
    data() {
      return {
        showTopNavigation: false
      };
    },
    methods: {
      loadGithub() {
        window.open("https://github.com/xyzyx0314");
      },
      locked() {       
        EventBus.emit('lock-blog', { message: 'lock-blog' });
      },
      csload(pageId){
        EventBus.emit('loadPage', pageId);
      }
    }
  }
</script>

<style scoped>
</style>