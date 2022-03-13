<template>
  <div>
    <modal
      :adaptive="true"
      :style="overflow-y | scroll"
      height="auto"
      name="example-modal"
      class="content">
      <div class="text">
        <div
          slot="top-right"
          style="z-index: 10000">
          <button
            style="color: red; font-size: 20px;"
            @click="$modal.hide('example-modal')">
            X
          </button>
        </div>
        <div class="chap1">
          <h3>
            {{ $t("hebergementFerme.readMore.title1") }}
          </h3>
          <p>
            En général, les vacances riment avec détente et calme. Un séjour à la ferme est justement perçu comme un délassement quotidien renouvelé tout le temps que dureront les vacances. <br> <br>
            On part aujourd’hui à la redécouverte de la campagne pour que les mots air pur, sérénité et nature ne restent plus à l’état d’idée et de velléité. Heureusement, les fermes vont, elles aussi, à la rencontre des amoureux de la vie libre et de la communion avec la nature. AgriVillage est le trait d’union qui relie ces fermes et ceux qui font le projet de passer du bon temps dans le monde de l’agriculture. <br> <br>
            La vie des animaux est alors observée en vrai et non plus à travers l’objectif d’une caméra de télévision. Les champs et les potagers de la ferme ont des dimensions difficilement comparables au jardin de l’arrière-cour d’un logement standard. Le produit de la ferme est par essence consommé nature.
          </p>
        </div>
        <div class="chap2">
          <h3>
            {{ $t("hebergementFerme.readMore.title2") }}
          </h3>
          <p>
            Il fut un temps où partir en vacances signifiait se rendre dans des contrées exotiques à la découverte de sensations nouvelles à des coûts parfois faramineux. L’exotisme est pourtant à portée de main avec la ferme qui se substitue à la mer et à la montagne et à moindre frais. <br> <br>
            Les dépenses de vacances sont ainsi réduites sans pour autant sacrifier du plaisir au changement de style. Il n’y a pas que la vie des animaux de la ferme qui est passionnante. Les relations humaines, elles aussi, connaissent une approche enrichissante. Loger chez un agriculteur permet de connaître une autre facette de l’hébergement qui n’est pas standardisé comme dans le circuit classique. <br> <br>
            Initiez-vous à la fabrication de fromage de chèvre, apprenez à traire des vaches et des chèvres, occupez-vous des cochons et des moutons ou découvrez la permaculture. La liste des activités possibles est conséquente ! <br> <br>
            Un séjour à la ferme est une véritable aubaine pour les enfants. Ils peuvent découvrir les animaux et apprendre à communiquer avec eux par les gestes. Cela améliore notamment leur intelligence émotionnelle.
          </p>
        </div>
        <div class="chap3">
          <h3>{{ $t("hebergementFerme.readMore.title3") }}</h3>
          <p>
            Avec l’engouement qui prévaut aujourd’hui pour le retour aux sources, l’hôte agriculteur s’est transformé en professionnel de l’hébergement. Ainsi, le vacancier peut bénéficier d’un séjour sur mesure. Il renoue avec le terroir et permet à l’agriculteur d’ajouter des revenus additionnels sans se détourner de sa profession. La relation gagnant-gagnant est de ce fait au rendez-vous. <br> <br>
            Les solutions sont diverses. Ainsi, il existe des fermes aux chambres d’hôtes. Vous pouvez alors habiter avec vos hôtes agriculteurs pour vivre pleinement la vie de la ferme. Logez à proximité des propriétaires des lieux pour ne rien perdre du quotidien de la ferme. <br> <br>
            Les chambres d’hôtes sont la solution qui consiste à loger dans l’habitation principale de la ferme. C’est pour vous l’occasion de rencontrer de nouveaux amis qui partagent avec vous le petit déjeuner composé de produits de la ferme. <br> <br>
            Il y a également des fermes gîtes. Participez à des activités en plein air dans des domaines de grande étendue, logé dans un bungalow et en pleine réserve animalière. Ces gîtes paysans allient l’utile et l’insolite parce que les formes du logement se déclinent en maisons, chalets ou appartements tout comme elles peuvent être des tentes. <br> <br>
            Des solutions financières avantageuses peuvent se conclure. Ainsi le woofing est la solution qui consiste pour le vacancier à être nourri et logé gratuitement en échange d’une participation aux activités de la ferme. Outre les découvertes, cette solution a l’avantage de donner le plaisir d’aider les autres. <br> <br>
            Pour bénéficier de ces possibilités, pensez à créer un compte auprès d’AgriVillage. Cela vous permet en quelques clics de trouver la ferme de votre choix et de réserver en conséquence. Il vous suffit alors d’indiquer la région de destination et le genre de ferme que vous recherchez. Êtes-vous plutôt porté sur l’élevage des vaches ou des moutons, des cochons ou du petit élevage. <br> <br>
            Il faut savoir que certaines fermes se spécialisent dans l’élevage d’animaux exotiques tels que l’autruche ou le cerf.
          </p>
        </div>
      </div>
    </modal>
  </div>
</template>
<script>
  export default {
    name: 'ExampleModal'
  }
</script>
<style lang="scss" scoped>
  @import '@/assets/scss/_variables.scss';
.content {
  padding-top: 2%;
  z-index: 10000;
  overflow-y: scroll!important;
  width: 100%;
  margin-bottom: 4%;
  .text {
    padding: 1%;
    margin: 4%;
  }
}
</style>
