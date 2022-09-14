<template>
  <div class="room-index-window">
    <div v-if="rooms" class="rooms" ref="rooms">
      <ul>
        <li v-for="room in rooms" :key="room.id">
          <router-link :to="{ 
              name: 'Chatroom', 
              params: { id: `${room.id}` } 
            }">
            <font-awesome-icon icon="comments" class="comments" />
            <H3>{{ room.name }}</H3>
          </router-link>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data () {
    return {
      rooms: [],
    }
  },
  computed: {
    // formattedMessages () {
    //   if (!this.messages.length) { return [] }
    //   return this.messages.map(message => {
    //     let time = formatDistanceToNow(new Date(message.created_at), { locale: ja })
    //     return { ...message, created_at: time }
    //   })
    // }
  },
  methods: {
    async getRooms () {
      try {
        const res = await axios.get('http://localhost:3000/rooms', {
          headers: {
            uid: window.localStorage.getItem('uid'),
            "access-token": window.localStorage.getItem('access-token'),
            client:window.localStorage.getItem('client')
          }
        })
        if (!res) {
          new Error('メッセージ一覧を取得できませんでした')
        }
        this.rooms = res.data
      } catch (err) {
        console.log(err)
      }
    },
  },
  mounted() {
    this.getRooms()
  },
  beforeUnmount () { 
    // this.messageChannel.unsubscribe()
  }
}
</script>

<style scoped>
  .room-index-window {
    background: white;
    padding: 30px 20px;
    border-bottom: 1px solid #eee;
  }
  .messages {
    max-height: 400px;
    overflow: auto;
  }
  .comments {
    width: 80px;
    height: 80px;
  }
  h3 {
    margin: 0;
  }
</style>
