<template>
  <div class="container welcome">
    <p>ようこそ！</p>
    <div v-if="shouldShowLoginForm">
      <LoginForm @redirectToChatRoom="redirectToChatRoom"/>
      <p class="change-form">初めての方は<span @click="shouldShowLoginForm = false">こちら</span>をクリック</p>
    </div>
    <div v-if="!shouldShowLoginForm">
      <SignupForm @redirectToChatRoom="redirectToChatRoom"/>
      <p class="change-form">アカウントをお持ちの方は<span @click="shouldShowLoginForm = true">こちら</span>をクリック</p>
    </div>
    <button @click="authTwitter" class="twitter">Twitter</button>
  </div>
</template>

<script>
import LoginForm from '../components/LoginForm.vue'
import SignupForm from '../components/SignupForm.vue'
import axios from 'axios'
// import setItem from '../auth/setItem'

export default {
  components: { LoginForm, SignupForm },
  data () {
    return {
      shouldShowLoginForm: false,
      error: null
    }
  },
  methods: {
    redirectToChatRoom () {
      this.$router.push({ name: 'Chatroom' })
    },
    async authTwitter () {
      this.error = null
      console.log("try!!!")
      try {
        const res = await axios.get('http://localhost:3000/auth/twitter?use_authorize=true', {
          headers: {
            "Access-Control-Allow-Origin": 'http://localhost:8080'
          }
        })
        if (!res) {
          throw new Error('Twitterアカウントを登録できませんでした')
        }
        if (!this.error) {
          // setItem(res.headers, res.data.data.name)
          this.$emit('redirectToChatRoom')
        }
        console.log({ res })
        return res
      } catch (error) {
        this.error = 'アカウントを登録できませんでした'
      }
    }
  } 
}
</script>

<style>
  .welcome {
    text-align: center;
    padding: 20px 0;
  }
  .welcome form {
    width: 300px;
    margin: 20px auto;
  }
  .welcome label {
    display: block;
    margin: 20px 0 10px;
  }
  .welcome input {
    width: 100%;
    padding: 12px 20px;
    margin: 8px auto;
    border-radius: 4px;
    border: 1px solid #eee;
    outline: none;
    box-sizing: border-box;
  }
  .welcome span{
    font-weight: bold;
    text-decoration: underline;
    cursor: pointer;
  }
  .welcome button {
    margin: 20px auto;
  }
  .twitter {
    background-color: #00acee;
  }
  .change-form {
    font-size: 14px;
    margin: 10px;
  }
</style>