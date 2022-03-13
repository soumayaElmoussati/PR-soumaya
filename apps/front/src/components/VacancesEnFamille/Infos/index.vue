<template>
  <div class="content">
    <div>
      <div class="intro">
        <p>
          Au vu de l’état de l’environnement, il est logique que la réaction conduise à goûter le plus possible à ce qui rapproche de la nature authentique. <br> <br>
          Les vacances sont, par essence, la recherche de nouvelles sensations et plus particulièrement de délassement. La ferme est aujourd’hui le moyen approprié pour répondre à ces attentes. <br> <br>
          La combinaison gagnante est la campagne et les vacances en famille. Éclatez-vous à la ferme en vous livrant à des activités enrichissantes du monde agricole. Ce faisant, vous redécouvrirez les campagnes françaises pour évoluer dans un milieu rural qui respire encore le bon air et le bonheur des journées calmes. <br> <br>
        </p>
      </div>
      <div>
        <div>
          <example-modal class="modal-show"/>
        </div>
        <div class="links">
          <button
            class="btn-light"
            @click="click">Voir plus ...</button>
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
      }
    }
  }
  h3 {
    font-size: 20px!important;
  }
  p {
    font-size: 16px!important;
  }
</style>
