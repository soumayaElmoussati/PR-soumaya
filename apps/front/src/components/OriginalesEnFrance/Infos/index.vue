<template>
  <div class="content">
    <div>
      <div class="intro">
        <p>{{ $t("originalesEnFrance.paragraphs.stay") }}</p>
        <p>{{ $t("originalesEnFrance.paragraphs.explication") }}</p>
      </div>
      <div>
        <div>
          <example-modal class="modal-show"/>
        </div>
        <div class="links">
          <button
            class="btn-light"
            @click="click">Lire plus </button>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import ExampleModal from './_subs/Modal'
  export default {
    name: 'Infos',
    components: {
      ExampleModal
    },
    methods: {
      click () {
        this.$modal.show('example-modal')
      }
    }
  }
</script>
<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";
  .content {
    margin-left: 5%;
    margin-right: 5%;
    .intro {
      text-align: center;
      margin: auto;
      width: 90%;
    }
    .links {
      padding-top: 15px;
      text-align: end;
      .btn-light {
        padding-left: 1%;
        padding-right: 1%;
        font-size: 14px;
        color: $agri-green;
        text-decoration: underline;
      }
    }
  }
  h3 {
    font-size: 20px!important;
  }
  p {
    font-size: 16px!important;
    text-align: justify;
  }
</style>
