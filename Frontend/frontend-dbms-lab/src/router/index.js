import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LoginView from '../views/LoginView.vue'
import AdminLoginView from '../views/AdminLoginView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView,
    },
    {
      path: '/login',
      name: 'login',
      component: LoginView,
    },
    {
      path: '/register',
      name: 'register',
      component: () => import('../views/RegisterView.vue'),
    },
    {
      path: '/view',
      name: 'view',
      component: () => import('../views/ViewDetailsView.vue'),
    },
    {
      path: '/admin',
      name: 'admin',
      component: AdminLoginView,
    },
    {
      path: '/manage',
      name: 'manage',
      component: () => import('../views/ManageView.vue'),
    },
  ],
})

router.beforeEach(async (to, from) => {
  if (! sessionStorage.getItem('user') && to.name === 'view') {
    return { name: 'login' }
  }

  if(! sessionStorage.getItem('token') && to.name === 'manage') {
    return { name: 'admin'}
  }
})

export default router
