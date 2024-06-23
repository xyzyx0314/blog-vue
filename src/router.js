import { createRouter, createWebHistory } from 'vue-router';
import App from './App.vue'; // 导入你的App组件

const routes = [
  {
    path: '/:id',
    component: App, // 使用你的App组件
    props: true,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
