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
            {{ $t("vacancesEnFamille.readMore.title1") }}
          </h3>
          <b>Le concept de vacances perçu aujourd’hui</b>
          <p>
            Au vu de l’état de l’environnement, il est logique que la réaction conduise à goûter le plus possible à ce qui rapproche de la nature authentique. <br> <br>
            Les vacances sont, par essence, la recherche de nouvelles sensations et plus particulièrement de délassement. La ferme est aujourd’hui le moyen approprié pour répondre à ces attentes. <br> <br>
            La combinaison gagnante est la campagne et les vacances en famille. Éclatez-vous à la ferme en vous livrant à des activités enrichissantes du monde agricole. Ce faisant, vous redécouvrirez les campagnes françaises pour évoluer dans un milieu rural qui respire encore le bon air et le bonheur des journées calmes. <br> <br>
            Les dépenses que vous aviez envisagé de faire en allant à l’étranger s’investissent ainsi dans l’agriculture française. La campagne est autrement plus proche et bien moins budgétivore que les billets d’avion et les frais d’hôtel.
          </p>
        </div>
        <div class="chap2">
          <h3>
            {{ $t("vacancesEnFamille.readMore.title2") }}
          </h3>
          <p>
            Quelques clics suffisent pour que’AgriVillage vous oriente vers la ferme et la région de votre choix. Un réseau d’agriculteurs est mis en place pour vous accueillir dans la destination qui vous branche. <br> <br>
            Différentes options s’offrent à vous. Choisissez un séjour dans un domaine où vous logerez dans le pré, à moins que vous ne préfériez loger chez le fermier pour ne rien perdre de son emploi du temps quotidien. <br> <br>
            C’est à la ferme qu’il est possible de déguster le produit du terroir. Manger sain et frais est ce dont vous avez intérêt à profiter. <br> <br>
            Il faut savoir qu’en certains cas, le woofing est possible. L’hébergement est gratuit, et en échange, vous aidez votre hôte agriculteur dans certains travaux de la ferme. Vous expérimentez quelque chose de nouveau et qui vous plaît tandis que l’agriculteur bénéficie d’un apport de main-d’œuvre temporaire et de compagnie.
          </p>
        </div>
        <div class="chap3">
          <h3>{{ $t("vacancesEnFamille.readMore.title3") }}</h3>
          <p>
            En choisissant de passer des vacances à la ferme avec votre famille, vous donnez à vos enfants l’occasion de vivre des facettes de la vie autres que la maison. Dans ce monde calme et serein, les activités se déroulent tout au long du jour pour le plus grand bonheur des petits et des grands. <br> <br>
            Dans quelle ferme voulez-vous vous initier aux tâches de l’agriculteur ? Êtes-vous attiré par le maraîchage ou plutôt par l’apiculture, à moins que vous n’ayez un faible pour la viticulture? L’élevage bovin et toutes les activités y afférentes vous passionnent ? Quelques clics et vous voilà prêt pour une aventure inédite. <br> <br>
            Donnez un coup de main au fermier en récoltant les légumes ou en aidant à l’étable, à l’écurie ou à la porcherie. Vos enfants trouveront leur bonheur en gambadant dans la vaste cour de la ferme tout en vaquant à des occupations d’apprenti fermier comme ramasser les œufs.
          </p>
        </div>
        <div class="chap4">
          <h3>{{ $t("vacancesEnFamille.readMore.title4") }}</h3>
          <p>
            Le réseau mis en place par AgriVillage n’a pas lésiné sur les moyens pour vous offrir le meilleur en matière d’hébergement. Vous avez tout un éventail de modèles de logements pour vous permettre de passer le meilleur séjour possible. <br> <br>
            Les 530 fermes partenaires proposent des logements entiers. Solution idéale pour la famille, vous pouvez avoir jusqu’à 3 espaces nuit confortables. La maison est construite avec des matériaux respectueux de l’environnement. <br> <br>
            Pour ceux qui recherchent un abri vraiment rustique, certains logements se déclinent en cabane et pour certaines régions une cabane dans l’arbre. La rusticité de l’extérieur n’enlève rien au confort moderne de l’intérieur. <br> <br>
            Les amateurs d’insolite peuvent loger dans des logements à l’architecture atypique. La façade à elle seule a déjà tout d’un ouvrage d’art. Vous pouvez aussi vous choisir un tipi, une yourte ou une tente berbère aménagée flanquée d’une Mini Tiny House pour souligner le dépaysement. Vous pouvez même dormir à la belle étoile, mais dans le confort douillet d’une bulle. <br> <br>
            Pour bien vous convaincre que l’hébergement chez l’agriculteur allie esthétique, confort et fonctionnalité, vous avez la solution glamping. Votre abri est un camping, mais glamour. Installé aux abords des champs, ce modèle de logement vous permet d’avoir des matins radieux en pleine nature.
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
