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
            {{ $t("weekEndFerme.readMore.title1") }}
          </h3>
          <p>
            Opter pour les offres d’AgriVillage ne veut pas dire vivre à la spartiate. Les amoureux ont besoin d’un cadre douillet pour mieux exprimer leurs sentiments l’un envers l’autre. Les agriculteurs partenaires d’AgriVillage font le nécessaire pour offrir un abri confortable spécialement conçu pour deux personnes unies par des liens d’amour. <br> <br>
            Le nord-ouest de la France regorge d’endroits idylliques qui permettent aux amoureux de sublimer leurs sentiments. Parmi ces sites, la Bretagne compte des agriculteurs partenaires chez qui vous pouvez réserver une Tiny House. <br> <br>
            La quintessence du moment et la commodité du logement se marient pour combler les deux tourtereaux qui veulent sortir des sentiers battus pour vivre un weekend de bonheur. <br> <br>
            Vous faites le choix d’aller dans une ferme dont l’activité se concentre surtout sur l’élevage de vaches, ou de moutons ou vous avez un penchant pour les basses-cours ? Les options sont diverses autant que les offres. Le weekend à la ferme peut assurément inspirer le couple pour écrire une histoire d’amour peu commune. <br> <br>
            Une promenade main dans la main permet de découvrir les environs de la ferme ainsi que les curiosités locales. De même, une excursion à deux peut conduire à la cueillette sauvage, un moyen pour connaître les bienfaits des plantes et les spécialités de la région. <br> <br>
            Les moments passés à la ferme initient les couples aux soins à prodiguer aux animaux. C’est également l’occasion des cours de cuisine du terroir ou encore la découverte de la fabrication de produits artisanaux comme les confitures ou le fromage.
          </p>
        </div>
        <div class="chap2">
          <h3>
            {{ $t("weekEndFerme.readMore.title2") }}
          </h3>
          <p>
            Les amoureux recherchent souvent des aventures atypiques. Sans verser dans des exploits de survie dans la nature, les couples veulent surtout vivre un événement original dans un cadre insolite. <br> <br>
            Ainsi, un large éventail se présente pour permettre un choix dans l’hébergement des amoureux. Outre la Tiny House, d’autres choix s’offrent, en l’occurrence des locaux aménagés comme le pigeonnier de Bretagne-Servon. <br> <br>
            Plus insolite encore est l’abri en forme de yourte. Si vous voulez un certain dépaysement, cet abri est fait pour vous. Vous pouvez même choisir de loger dans une bulle pour dormir à l’abri tout en contemplant les étoiles. La liste des choix n’est pas close parce que de la cabane sur un arbre perché à la maison troglodyte en passant par le tonneau aménagé et le tipi, vous ne pouvez avoir que l’embarras du choix. Renouez avec la nature et la vie de la ferme dès votre réveil.
          </p>
        </div>
        <div class="chap3">
          <h3>{{ $t("weekEndFerme.readMore.title3") }}</h3>
          <p>
            Le bonheur à deux ne passe pas forcément par des dépenses faramineuses. L’éventail des destinations est suffisamment large pour que tous les couples y trouvent leur bonheur. De plus, pour rendre le séjour le plus agréable possible, le côté rustique de la campagne est agrémenté par un confort douillet de l’abri que vous choisissez. Cette formule est appelée glamping, car elle allie le glamour et le camping. <br> <br>
            C’est la solution idéale pour un couple d’amoureux qui ne veut rien perdre des subtilités de la nature tout en contant fleurette dans un nid confortable. <br> <br>
            Plus de 500 fermes à travers la France n’attendent que votre réservation. C’est dire l’éventail des possibilités pour choisir la bonne ferme et le bon logement. Il ne vous reste qu’à décider quel est le cadre rêvé pour les déclarations d’amour. <br> <br>
            Pour ce faire, vous pouvez créer un compte. C’est en effet grâce à ce compte que vous pouvez faire votre réservation dans l’une des multiples fermes partenaires d’AgriVillage. <br> <br>
            La réservation doit indiquer quelles sont vos préférences. Quelle est votre région de prédilection et dans quel type de ferme vous voulez passer votre weekend à deux. <br> <br>
            En optant pour un weekend en amoureux dans une ferme du réseau d’AgriVillage, vous faites du tourisme écoresponsable, car le logement insolite est désormais conçu et réalisé avec des modes de construction et des matériaux respectueux de l’environnement.
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
