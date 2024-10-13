<script setup>
import { onBeforeMount, ref } from 'vue';
import img from '@/assets/img/placeholder.png'
import CourseCard from '@/components/CourseCard.vue';
import { RouterLink, useRouter } from 'vue-router';

const sessionData = sessionStorage.getItem('user')

const user = ref(JSON.parse(sessionData))

</script>

<template>
    <div class="w-full">
        <div class="max-w-6xl mx-auto flex justify-between items-center bg-black/15 rounded-2xl">
            <div class="flex items-center">
                <img :src="img" alt="" class="w-64">
                <div>
                    <h3 class="text-2xl font-medium mb-3" v-text="user.name"></h3>
                    <p class="text-gray-200" v-text="user.email"></p>
                </div>
            </div>
            <div class="mr-20">
                <h4 class="text-xl font-medium text-center">Score</h4>
                <p class="text-xl font-medium mt-2 text-center" v-text="user.score"></p>
            </div>
        </div>
        <RouterLink :to="course.link" v-for="course in user.completed_courses">
            <CourseCard :course="course" type="completed"/>
        </RouterLink>
        <RouterLink :to="course.link" v-for="course in user.courses_to_complete">
            <CourseCard :course="course" type="incompleted"/>
        </RouterLink>
    </div>
</template>