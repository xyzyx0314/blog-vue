<template>
  
  <TopNavigation id="topNavigation" v-bind:style="{ visibility: showBlog ? 'hidden' : 'visible' }" />
  <RightButton id="rightButton" v-bind:style="{ visibility: showBlog ? 'hidden' : 'visible' }" />
  <RightNavigation id="rightNavigation" v-bind:style="{ visibility: showBlog ? 'hidden' : 'visible' }"/>
  <MainPage id="mainPage" v-bind:style="{ visibility: showMain ? 'hidden' : 'visible' }"/>
  <NotePage id="notePage" v-bind:style="{ visibility: showNote ? 'hidden' : 'visible' }"/>
  <OpenBlog id="openBlog" v-bind:style="{ visibility: showOpenBlog ? 'hidden' : 'visible' }"/>

</template>

<script>
import OpenBlog from './components/OpenBlog.vue'
import RightButton from './components/RightButton.vue'
import TopNavigation from './components/TopNavigation.vue'
import MainPage from './components/MainPage.vue'
import RightNavigation from './components/LeftNavigation.vue'
import NotePage from './components/NotePage.vue'


import EventBus from '@/EventBus';

export default {
  data() {
    return {
      showMain: false,  //中间主要页面展示
      showNote: true,  //笔记集合页面显示
      lastShowMain: false, //上次是否显示中间主要页面
      lastShowNote: false, //上次是否显示笔记集合页面
      showBlog: false, //博客页面显示
      showOpenBlog: true, //博客带解锁页面 
    };
  },
  components: {
    OpenBlog,
    RightButton,
    TopNavigation,
    MainPage,
    RightNavigation,
    NotePage,
  },
  created() {
    window.addEventListener('hashchange', this.urlHash);
    this.urlHash();

    EventBus.on('lock-blog', this.lockblog);
    EventBus.on('open-blog', this.openblog);
    EventBus.on('show-note', this.shownote);
    EventBus.on('close-note', this.closenote);
  },
  beforeUnmount() {
    EventBus.off('lock-blog', this.lockblog);
    EventBus.off('open-blog', this.openblog);
    EventBus.off('show-note', this.shownote);
    EventBus.off('close-note', this.closenote);
    window.removeEventListener('hashchange', this.urlHash);
  },
  methods:{
    urlHash() {
      let url = window.location.href;
      let newUrl = url.split('#')[0];
      window.history.replaceState(null, null, newUrl); 
    },
    lockblog() {
      this.lastShowMain = this.showMain;
      this.lastShowNote = this.showNote;
      this.showMain = true;
      this.showNote = true;
      this.showBlog = true;
      this.showOpenBlog = false;
    },
    openblog() {
      this.showMain = this.lastShowMain;
      this.showNote = this.lastShowNote;
      this.showOpenBlog = true;
      this.showBlog = false;
    },
    shownote() {
      this.showNote = false;
      this.showMain = true;
      this.lastShowMain = this.showMain;
      this.lastShowNote = this.showNote;
    },
    closenote() {
      this.showNote = true;
      this.showMain = false;
      this.lastShowMain = this.showMain;
      this.lastShowNote = this.showNote;
    },
  },
  mounted() {
    window.onhashchange = this.handleHashChange;
  },
  beforeUnmount() {
    window.onhashchange = null;
  },
}


</script>
