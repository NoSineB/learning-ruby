<script setup>
import axios from 'axios';
import { ref } from 'vue';

const { user } = defineProps(['user']);

const token = ref(sessionStorage.getItem('token'))

const toggle = ref(false)

</script>

<template>
    <div class="bg-black/15 rounded-2xl p-4 flex justify-between items-center cursor-pointer" @click="toggle = ! toggle">
        <div class="flex items-center">
            <div>
                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
                    <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10s-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664z"/>
                </svg>
            </div>
            <div class="ml-16">
                <h4 v-text="user.name"></h4>
            </div>
            <div class="ml-4">
                <h4> - </h4>
            </div>
            <div class="ml-4">
                <h4 v-text="user.email"></h4>
            </div>
        </div>
        <div class="flex items-center">
            <div class="ml-16">
                <h4>Score</h4>
            </div>
            <div class="ml-4">
                <h4> - </h4>
            </div>
            <div class="ml-4">
                <h4 v-text="user.score"></h4>
            </div>
        </div>
    </div>
    <transition>
        <div v-if="toggle" class="bg-black/15 p-4">
            <div v-for="course in user.completed_courses" class="mt-2">
                <div class="flex items-center max-w-5xl">
                    <div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="fill-green-500" viewBox="0 0 16 16">
                            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0m-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
                        </svg>
                    </div>
                    <div class="ml-12">
                        <h4 v-text="course.name"></h4>
                    </div>
                    <div class="ml-4">
                        <h4> - </h4>
                    </div>
                    <div class="ml-4">
                        <h4 v-text="course.name"></h4>
                    </div>
                </div>
            </div>
            <div v-for="course in user.courses_to_complete" class="flex items-center justify-between mt-2">
                <div class="flex items-center max-w-5xl">
                    <div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" viewBox="0 0 16 16">
                            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0m-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
                        </svg>
                    </div>
                    <div class="ml-12">
                        <h4 v-text="course.name"></h4>
                    </div>
                    <div class="ml-4">
                        <h4> - </h4>
                    </div>
                    <div class="ml-4">
                        <h4 v-text="course.name"></h4>
                    </div>
                </div>
                <div>
                    <button class="bg-green-500 rounded-lg p-2" @click="$emit('add_user', user.user_id, course.course_id)">Mark as completed</button>
                </div>
            </div>
            
        </div>
    </transition>

</template>

<style scoped>
.v-enter-active,
.v-leave-active {
  transition: opacity 0.5s ease;
}

.v-enter-from,
.v-leave-to {
  opacity: 0;
}
</style>