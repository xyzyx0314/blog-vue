<template>
  <div>
    <div class="m-md" id="m-md">
      <div class="m-md-out box-hide-scrollbar" id="m-md-top">
        <div class="p-page" id="p-page" @click="handleClick">
          <div class="p-m">
            <div class="p-title2">笔记</div>
            <div class="p-top">
              <div class="row">
                <div class="p-top-postion">
                  <h class="p-top-link" data-page-id="home">Journey</h>
                  /
                  <h class="p-top-link" data-page-id="note">笔记</h>
                </div>
              </div>
            </div>
            <div class="p-title4">笔记列表</div>            
            <div class="note-list">
              <div v-for="note in filteredNotes" :key="note.id" class="row">
                <div class="col-md-10 container note-blog" @click="loadPage(note.url)" >
                  <div class="row">
                    <div class="col-md-3 note-pho">
                      <img :src="`../${note.imageSrc}`" >   
                    </div>
                    <div class="col-md-9 note-blog-inf">
                      <div class="note-blog-title">
                        {{ note.title }}
                      </div>
                      <div class="note-blog-mess">
                        {{ note.message }}
                      </div>
                      <div class="note-blog-tag">{{ note.tags }}</div>
                      <div class="note-blog-bot container">
                        <div class="row">
                          <div class="col-md-4">
                            <img src="../img/calendar.svg" class="svgshadow" />
                            {{ note.date }}
                          </div>
                          <div class="col-md-4">
                            <img src="../img/writter.svg" class="svgshadow" />
                            {{ note.author }}
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>


    <div class="m-rt" id="m-rt">
      <div class="m-rt-out box-hide-scrollbar">
        <div class="p-list" id="p-list">
          <div class="note-title" @click="setCurrentGroup('All')">索引</div>
          <div class="note-choose">
            <div  v-for="noteGroup in noteGroups" :key="noteGroup.id" class="note-choose" @click="setCurrentGroup(noteGroup.id)">
              {{ noteGroup.name }}
            </div>
          </div>
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
        noteGroups: [
          { id: '更新日志', name: '更新日志' },
          { id: '训练题解', name: '训练题解' },
          { id: '日记', name: '日记' },
          { id: '实验', name: '实验' },
        ],
        currentGroup: null, // 当前选中的组
        groups: ['Group1', 'Group2', 'Group3'],
        notes: [
          {
            id: 'Change8',
            url: 'blog/week8',
            imageSrc: 'img/note/note1.svg',
            title: 'blog更新8:改写为Vue',
            message: '之前计划的大更新，已经完成',
            tags: 'web vue3',
            date: '2024年6月25日',
            group: '更新日志',
            author: 'UnmooredZ',
          },
          {
            id: 'project1',
            url: 'project/project1',
            imageSrc: 'img/note/note2.svg',
            title: '远程桌面&内网穿透',
            message: '一些关于远程桌面和内网穿透的尝试',
            tags: 'Sunshine+Moonlight 向日葵 frp',
            date: '2024年6月19日',
            group: '实验',
            author: 'UnmooredZ',
          },
          {
            id: 'Change7',
            url: 'blog/week7',
            imageSrc: 'img/note/note3.svg',
            title: 'blog更新7',
            message: ' 小更新，更新了博客更新方式，从服务器下载docker变成了通过github的action自动对比更新',
            tags: 'blogChange  action',
            date: '2024年6月19日',
            group: '更新日志',
            author: 'UnmooredZ',
          },
          {
            id: 'Change6',
            url: 'blog/week6',
            imageSrc: 'img/note/note4.svg',
            title: 'blog更新6',
            message: 'SSL证书部署，js重写等',
            tags: 'SSL证书 js',
            date: '2024年6月2日',
            group: '更新日志',
            author: 'UnmooredZ',
          },
          {
            id: 'Change5',
            url: 'blog/week5',
            imageSrc: 'img/note/note5.svg',
            title: 'blog更新5',
            message: '一年后的复活更新',
            tags: 'blog',
            date: '2024年6月2日',
            group: '更新日志',
            author: 'UnmooredZ',
          },
          {
            id: 'note3',
            url: 'blog/week3',
            imageSrc: 'img/note/note6.svg',
            title: 'web大作业第三周',
            message: '通过整理文件，将所有图片转换成svg，将本地转为引用cdn等方式大大减小了项目体积25MB-5MB; 因为笔记和主页、分组功能高度重合，删去笔记区块；分组增加板子栏，方便日后使用；完成主页，笔记俩个模块；给每篇文章头部加入分级，可快速链接上一目录',
            tags: 'web 项目 记录',
            date: '2023年5月17日',
            group: '更新日志',
            author: 'Journey',
          },
          {
            id: 'cf1820',
            url: 'acm/cf1820',
            imageSrc: 'img/note/note7.svg',
            title: 'Round 866 (Div. 2) CF1820 题解',
            message: 'VP过了 A. Yura\'s New Name B. JoJo\'s Incredible Adventures C. Constructive Problem 未补DEF',
            tags: 'tag：CF VP 题解',
            date: '2023年5月9日',
            group: '训练题解',
            author: 'Journey',
          },
          {
            id: 'board_Graph',
            url: 'acm/board_Graph',
            imageSrc: 'img/note/note8.svg',
            title: '图论模板 (202207标准)',
            message: '目前有dij、Tarjan、网络流、基环树、差分约束',
            tags: 'tag：XCOC Graph Board',
            date: '2023年5月24日',
            group: '训练题解',
            author: 'Journey',
          }
        ]
      };
    },
    methods: {
      setCurrentGroup(group) {
        if (group === 'All') {
          this.currentGroup = null;
        } else {
          this.currentGroup = group;
        }
      },
      loadPage(pageId) {
        EventBus.emit('loadPage', pageId);
      },
    },
    computed: {
      filteredNotes() {
        if (this.currentGroup === null) {
          return this.notes;
        } else {
          return this.notes.filter(note => note.group === this.currentGroup);
        }
      },
    },
  };


</script>
