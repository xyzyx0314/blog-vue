<template>
  <OpenBlog id="openBlog" v-bind:style="{ visibility: showOpenBlog ? 'hidden' : 'visible' }"/>
  <TopNavigation id="topNavigation" v-if="!showBlog" />
  <RightButton id="rightButton" v-if="!showBlog" />
  <RightNavigation id="rightNavigation" v-if="!showBlog"/>
  <MainPage id="mainPage" v-if="!showBlog"/>

</template>

<script>
import OpenBlog from './components/OpenBlog.vue'
import RightButton from './components/RightButton.vue'
import TopNavigation from './components/TopNavigation.vue'
import MainPage from './components/MainPage.vue'
import RightNavigation from './components/LeftNavigation.vue'


import EventBus from '@/EventBus';

export default {
  props: ['id'],
  data() {
    return {
      showBlog: false,
      showOpenBlog: true,
    };
  },
  components: {
    OpenBlog,
    RightButton,
    TopNavigation,
    MainPage,
    RightNavigation,
  },
  created() {
    window.addEventListener('hashchange', this.urlHash);
    this.urlHash();

    EventBus.on('lock-blog', this.lockblog);
    EventBus.on('open-blog', this.openblog);
  },
  beforeUnmount() {
    EventBus.off('lock-blog', this.lockblog);
    EventBus.off('open-blog', this.openblog);
    window.removeEventListener('hashchange', this.urlHash);
  },
  methods:{
    urlHash() {
      let url = window.location.href;
      let newUrl = url.split('#')[0];
      window.history.replaceState(null, null, newUrl); 
    },

    lockblog() {
      this.showBlog = true;
      this.showOpenBlog = false;
    },
    openblog() {
      this.showBlog = false;
      this.showOpenBlog = true;
    }
  },
  mounted() {
    window.onhashchange = this.handleHashChange;
  },
  beforeUnmount() {
    window.onhashchange = null;
  },
}


</script>
