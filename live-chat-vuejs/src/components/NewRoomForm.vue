<template>
    <!-- <textarea
      placeholder="Roomの名前を入力してEnterを押してください"
      v-model="message"
      @keypress.enter.prevent="handleSubmit"
    ></textarea> -->

  <form @submit.prevent="createRoom">
    <div>{{ title }}</div>
    <input type="text" 
      required 
      placeholder="Room Title"
      v-model="title">
    <button>Publish Room</button>
  </form>
</template>

<script>
import axios from 'axios'

export default {
  // emits: ['connectCable'],
  data () {
    return {
      title: ''
    }
  },
  methods: {
    async createRoom () {
      try {
        const res = await  axios.post('http://localhost:3000/rooms',
          { name: this.title },
          { 
            headers: {
              uid: window.localStorage.getItem('uid'),
              "access-token": window.localStorage.getItem('access-token'),
              client: window.localStorage.getItem('client')
            }
          }

        )
        if (!res) {
          new Error('ルームを作成できませんでした')
        }
        console.log(res)
        this.$router.push({ name: 'Chatroom', params: { id: res.data.id }})
      } catch (err) {
        console.log(err)
      }
    },
    // handleSubmit () {
    //   this.$emit('connectCable', this.message)
    //   this.message = ''
    // }
  }
}
</script>

<style scoped>
</style>