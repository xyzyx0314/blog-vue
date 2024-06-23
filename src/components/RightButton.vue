<template>
  <div class="m-rtbt" id="m-rtbt">
    <div class="backtop" @click="scrollToTop">
      <img src="../../img/top.svg" class="svgshadow" />
    </div>
    <div class="moon" @click="toggleNightMode">
      <img src="../../img/moon.svg" class="svgshadow" />
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      fnight: 0
    }
  },
  methods: {
    scrollToTop() {
      document.getElementById('m-md-top').scrollTop = 0;
    },
    toggleNightMode() {
      if (this.fnight == 0) {
        document.documentElement.style.setProperty("--color1", "rgb(44, 48, 83)");
        document.documentElement.style.setProperty("--color2", "rgba(32, 35, 62, 0.8)");
        document.documentElement.style.setProperty("--color3", "rgb(32, 35, 62)");
        document.documentElement.style.setProperty("--color4", "#000000ef");
        document.documentElement.style.setProperty("--color5", "rgb(183, 189, 250)");
        document.documentElement.style.setProperty("--color6", "#5f90da");
        this.fnight = 1;
      } else {
        document.documentElement.style.setProperty("--color1", "#FAFAFA");
        document.documentElement.style.setProperty("--color2", "rgba(255, 255, 255, 0.1)");
        document.documentElement.style.setProperty("--color3", "#f0f0f7");
        document.documentElement.style.setProperty("--color4", "#888888ef");
        document.documentElement.style.setProperty("--color5", "#000000");
        document.documentElement.style.setProperty("--color6", "#335a94");
        this.fnight = 0;
      }
    }
  },
  mounted() {
    this.toggleNightMode();
  }
}
</script>
