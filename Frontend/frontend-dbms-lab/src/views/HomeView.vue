<template>
  <div class="">
    <h2 class="text-6xl text-center font-semibold mt-12 max-w-3xl mx-auto">
      Connecting Talent with Opportunity: Empowering Innovation, Fostering Careers.
    </h2>
    <p class="mt-12 max-w-5xl mx-auto text-center"> 
      A platform that connects emerging talent with leading companies, creating meaningful career opportunities while driving innovation and growth in the tech industry
    </p>
    <div class="mt-12 max-w-md mx-auto flex justify-around items-center">
      <RouterLink
        to="register"
        class="border px-8 py-4 border-[#4452FE] bg-[#4452FE] text-white hover:bg-[#5563ff] transition-all duration-300"
      >
        Register Now
      </RouterLink>
      <RouterLink
        to="login"
        class="border px-8 py-4"
      >
        Know More
      </RouterLink>
    </div>
  </div>
</template>
