import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import './assets/main.css'
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome"
import { library } from "@fortawesome/fontawesome-svg-core"
import { faHeart, faComments } from "@fortawesome/free-solid-svg-icons"

library.add(faHeart, faComments)
createApp(App).use(router).component("font-awesome-icon", FontAwesomeIcon).mount('#app')
