import Vue from 'vue'
import GAuth from 'vue-google-oauth2'

Vue.use(GAuth, {
  client_id: process.env.GOOGLE_CLIENT_ID,
  scope: 'profile email',
  prompt: 'select_account',
  fetch_basic_profile: true
})
