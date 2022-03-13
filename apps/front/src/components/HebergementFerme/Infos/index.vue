<template>
  <div class="content">
    <div>
      <div class="intro">
        <p>
          En général, les vacances riment avec détente et calme. Un séjour à la ferme est justement perçu comme un délassement quotidien renouvelé tout le temps que dureront les vacances. <br> <br>
          On part aujourd’hui à la redécouverte de la campagne pour que les mots air pur, sérénité et nature ne restent plus à l’état d’idée et de velléité. Heureusement, les fermes vont, elles aussi, à la rencontre des amoureux de la vie libre et de la communion avec la nature. AgriVillage est le trait d’union qui relie ces fermes et ceux qui font le projet de passer du bon temps dans le monde de l’agriculture. <br> <br>
          La vie des animaux est alors observée en vrai et non plus à travers l’objectif d’une caméra de télévision. Les champs et les potagers de la ferme ont des dimensions difficilement comparables au jardin de l’arrière-cour d’un logement standard. Le produit de la ferme est par essence consommé nature.
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
