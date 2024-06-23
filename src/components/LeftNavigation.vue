<template>
  <div class="m-lt" id="m-lt">
    <div class="m-lt-out box-hide-scrollbar">
      <div class="m-lt-list">
        <!-- 个人栏 -->
        <div class="m-lt-person">
          <img src="/img/person.svg" class="rounded-circle" alt="Cinque Terre" width="150">
          <div class="m-lt-per">
            <div class="m-lt-name">UnmooredZ</div>
            <div class="m-lt-sign">不系舟</div>
          </div>
        </div>
        <!-- 导航菜单 -->
        <div class="m-lt-title">导航</div>
        <div class="m-lt-card" v-for="item in menuItems" :key="item.name" @click="loadPage(item.url)">
          <img :src="`../${item.icon}`" class="svgshadow">
          {{ item.name }}
        </div>
        <!-- 分组菜单 -->
        <div class="m-lt-title">分组</div>
        <div class="m-lt-menu" v-for="group in groups" :key="group.id">
          <div class="m-lt-card collapsed" data-bs-toggle="collapse" :href="`#${group.id}`" @click="toggleImage(group.imgId)">
            <img :src="`../img/${group.img}`" class="svgshadow">
            {{ group.title }}
            <h class="open">
              <img :src="'../img/left.svg'" class="svgshadow" :id="group.imgId">
            </h>
          </div>
          <div :id="group.id" class="collapse" data-bs-parent="#accordion">
            <div class="m-lt-card" v-for="item in group.items" :key="item.text" @click="loadPage(item.url)">
              <img :src="`../img/${item.img}.svg`" class="svgshadow">
              {{ item.text }}
            </div>
          </div>
        </div>
        <!-- 底部留白 -->
        <br>
      </div>
    </div>
  </div>

</template>

<script>
  import EventBus from '@/EventBus';
  export default {
    data() {
      return {
        menuItems: [
          { name: ' 主页 ', icon: '../img/home.svg', url: 'home' },
          { name: ' 笔记 ', icon: '../img/write.svg', url: 'note' },
          { name: ' 联系 ', icon: '../img/connect.svg', url: 'connect' },
          { name: ' 投喂 ', icon: '../img/reward.svg', url: 'reward' },
        ],
        groups: [
          { id: 'menuWeb', img: 'classify.svg', title: ' 更新日志', imgId: 'lt-img1', items: [
            {img: 'text', url: 'blog/week1', text: 'web week 1' },
            {img: 'text', url: 'blog/week2', text: 'web week 2' },
            {img: 'text', url: 'blog/week3', text: 'web week 3' },
            {img: 'text', url: 'blog/week4', text: 'web week 4' },
            {img: 'text', url: 'blog/week5', text: 'Change 5' },
            {img: 'text', url: 'blog/week6', text: 'Change 6' },
            {img: 'text', url: 'blog/week7', text: 'Change 7' },
          ]},
          { id: 'menuNote', img: 'note.svg', title: ' ACM', imgId: 'lt-img2', items: [
            {img: 'answer', url: 'acm/cf1820', text: 'Codeforces Round 866 (Div. 2)' },
            {img: 'answer', url: 'acm/ABC301', text: 'AtCoder ABC 301' },
            {img: 'answer', url: 'acm/JT20230717', text: '大一Tarjan' },
            {img: 'calendar', url: 'acm/XL20230621', text: '2023年6月21日' },
            {img: 'calendar', url: 'acm/XL20230622', text: '2023年6月22日' },
            {img: 'calendar', url: 'acm/XL20230623', text: '2023年6月23日 组队+补题' },
            {img: 'board', url: 'acm/board_Graph', text: '图论' },
          ]},
          { id: 'menuProject', img: 'boardmenu.svg', title: ' 实验', imgId: 'lt-img4', items: [
            {img: 'text', url: 'project/project1', text: '远程桌面&内网穿透' },
          ]},
          { id: 'menuDaily', img: 'daily.svg', title: ' 日记', imgId: 'lt-img5',  items: [
          {img: 'daily', url: '404', text: '第一篇' },
          ]},
          { id: 'menuTwo', img: 'friend.svg', title: ' 友链', imgId: 'lt-img6',   items: [
          {img: 'AD', url: 'home', text: '广告位招租' },
          ]},
        ],
      };
    },
    methods: {
      loadPage(pageId) {
        EventBus.emit('loadPage', pageId);
      },
      toggleImage(imageId) {
        var x = document.getElementById(imageId);
        x.src = x.src.match(`../img/left.svg`) ? `../img/open.svg` : `../img/left.svg`;
      },

    },
  };
</script>
