<script setup>
import { ref } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router'
import { useStorage } from '@vueuse/core'

const form_response = ref({
    "email" : "",
    "password" : ""
})

const router = useRouter()


const onSubmit = async () => {
    try {

        const response = await axios.post("http://127.0.0.1:4567/admin-login", {
            "email" : form_response.value.email,
            "password" : form_response.value.password 
        })
        
        const token = useStorage('token', response.data.token, sessionStorage)

        router.push('/manage');
    } 
    
    catch (error) {
        console.log(error)
    }
}

</script>

<template>
    <div class="mt-18 text-3xl text-center font-semibold max-w-xl mx-auto">
        <div class="flex items-center justify-center w-full">
            <div class="bg-[#1e1e1e] dark:bg-gray-900 shadow-md rounded-lg px-8 py-6 w-[500px]">
                <h1 class="text-2xl font-bold text-center mb-8 dark:text-gray-200">Access the dashboard!</h1>
                <form @submit.prevent="onSubmit">
                    <div class="mb-4">
                        <label for="email" class="block text-sm font-medium text-gray-300 mb-2">Email Address</label>
                        <input v-model="form_response.email" type="email" id="email" class="shadow-sm rounded-md w-full px-3 py-2 border border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 text-[#171717] text-base" autocomplete="off" required>
                    </div>
                    <div class="mb-4">
                        <label for="password" class="block text-sm font-medium text-gray-300 mb-2">Password</label>
                        <input v-model="form_response.password" type="password" id="password" class="shadow-sm rounded-md w-full px-3 py-2 border border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 text-[#171717] text-base" autocomplete="off" required>
                    </div>
                    <button type="submit" class="w-full mt-8 flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Login</button>
                </form>
            </div>
        </div>
    </div>
</template>