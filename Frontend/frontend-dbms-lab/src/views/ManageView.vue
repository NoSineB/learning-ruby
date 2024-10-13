<script setup>
import axios from 'axios';
import { onMounted, reactive, ref } from 'vue';
import UserCard from '@/components/UserCard.vue';
import { useRouter } from 'vue-router'

const token = ref(sessionStorage.getItem('token'))
const router = useRouter()

const userDetails = reactive({})

onMounted(async () => {
    try{
        const res = await axios.post("http://127.0.0.1:4567/users", {"_token" : token.value})
        userDetails.data = res.data
    }
    catch(err) {
        console.log(err)
    }  
})

const onClick = async (userId, courseId) => {
    try{
        await axios.post(`http://127.0.0.1:4567/add/${userId}/course/${courseId}`, { "_token" : token })
        const res = await axios.post("http://127.0.0.1:4567/users", {"_token" : token.value})
        userDetails.data = res.data

    }
    catch (err) {
        console.log(err)
    }
}

</script>

<template>
    <div class="w-full">
        <h3 class="text-3xl font-semibold text-center">Admin Dashboard</h3>
        <div class="mt-20 max-w-6xl mx-auto">
            <h3 class="text-xl font-semibold">Users</h3>
            <div class="mt-12" v-for="user in userDetails.data">
                <UserCard :user="user" @add_user="onClick"/>
            </div>
            
        </div>
    </div>
</template>