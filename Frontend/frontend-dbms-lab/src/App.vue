<script setup>
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <div class="container mx-auto h-full mt-6 poppins-regular">

    <nav class="flex justify-between items-center my-2">
      <RouterLink
        to="/"
        class="text-4xl font-bold tracking-widest righteous-regular"
      >
        Launchpad
      </RouterLink>
      <RouterLink
        to="login"
        class="border px-6 py-2"
      >
        Login
      </RouterLink>
    </nav>

    <div class="mt-20 flex justify-center items-center">
      <RouterView />
    </div>
    
  </div>
  
</template>

<style scoped>

</style>
