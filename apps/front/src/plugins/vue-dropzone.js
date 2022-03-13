import Vue from 'vue'
import vue2Dropzone from 'vue2-dropzone'

import 'vue2-dropzone/dist/vue2Dropzone.min.css'

export default () => {
  Vue.component('vue-dropzone', vue2Dropzone)
}
