<template>
  <div>
    <div class="m-md" id="m-md">
      <div class="m-md-out box-hide-scrollbar" id="m-md-top">
        <div class="p-page" id="p-page" @click="handleClick">
        </div>
      </div>
    </div>
    <div class="m-rt" id="m-rt">
      <div class="m-rt-out box-hide-scrollbar">
        <div class="p-list" id="p-list">
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import EventBus from '@/EventBus';

  export default {
    data() {
      return {
        xmlhttp: null,
        xmlhttp2: null
      }
    },
    created() {
      EventBus.on('loadPage', this.loadPage);
      EventBus.on('reloadPage', this.reloadPage);
    },
    beforeUnmount() {
      EventBus.off('loadPage', this.loadPage);
      EventBus.off('reloadPage', this.reloadPage);
    },
    methods: {
      handleClick(event) {
        let target = event.target;
        while (target) {
          if (target.dataset.pageId) {
            this.loadPage(target.dataset.pageId);
            break;
          }
          target = target.parentNode;
        }
      },
      load() {
        document.getElementById('m-md-top').scrollTop = 0;
        if (window.XMLHttpRequest) {
          this.xmlhttp = new XMLHttpRequest();
          this.xmlhttp2 = new XMLHttpRequest();
        } else {
          this.xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
          this.xmlhttp2 = new ActiveXObject("Microsoft.XMLHTTP");
        }
        this.xmlhttp.onreadystatechange = () => {
          if (this.xmlhttp.readyState == 4 && this.xmlhttp.status == 200) {
            document.getElementById("p-page").innerHTML = this.xmlhttp.responseText;
            hljs.initHighlightingOnLoad();
          }
        }
        this.xmlhttp2.onreadystatechange = () => {
          if (this.xmlhttp2.readyState == 4 && this.xmlhttp2.status == 200) {
            document.getElementById("p-list").innerHTML = this.xmlhttp2.responseText;
            hljs.initHighlightingOnLoad();
          }
        }
      },
      loadPage(pageId) {
        if (pageId.startsWith('note/') || pageId.startsWith('note')) {
          pageId = 'note';
          EventBus.emit('show-note');
          EventBus.emit('now-page', pageId);
        } else {
          this.load();
          EventBus.emit('close-note', pageId);
          this.xmlhttp.open("GET", "../../html/" + pageId + ".html", true);
          this.xmlhttp.send();
          this.xmlhttp2.open("GET", "../../html/" + pageId + "_list.html", true);
          this.xmlhttp2.send();
        }
      },
    },
    mounted() {
      // 获取当前网址
      const currentUrl = window.location.href;
      // 获取前缀之后的内容
      console.log('当前的内容:', currentUrl);
      const prefix = 'http://www.unmooredz.com/?';
      const contentAfterPrefix = currentUrl.replace(prefix, '');
      // 合法路径列表
      const validPaths = ['blog/week3', 'acm/cf1820', 'blog/week1', 'blog/week2', 'blog/week4'];

      // 将内容显示在控制台中
      this.loadPage(contentAfterPrefix);    
      // 判断路径是否合法
      const isValid = validPaths.includes(contentAfterPrefix);
      // 将结果显示在控制台中
      console.log('前缀之后的内容:', contentAfterPrefix);
      console.log('是否合法:', isValid);

      if (isValid) this.loadPage(contentAfterPrefix);    
      else this.loadPage('home'); 
    }
  }
</script>
