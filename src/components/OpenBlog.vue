<template>
  <div class="lockscreen" @click="openblog" id="lockscreen">
    <div id="time">{{ time }}</div>
  </div>
</template>

<script>
  import EventBus from '@/EventBus';
  export default {
    data() {
      return {
        showOpenBlog: true,
        time: '',
      };
    },
    methods:{    
      displayTime() {
      var date = new Date();
      var hours = date.getHours();
      var minutes = date.getMinutes();
      var seconds = date.getSeconds();
      if (minutes < 10) {
        minutes = "0" + minutes;
      }
      if (seconds < 10) {
        seconds = "0" + seconds;
      }
      this.time = hours + ":" + minutes + ":" + seconds;
    },
      openblog() {
        EventBus.emit('open-blog', { message: 'open-blog' });
      }
    },
    mounted() {
      this.displayTime();
      setInterval(this.displayTime, 1000);
    }
  }
</script>

<style scoped>
</style>
