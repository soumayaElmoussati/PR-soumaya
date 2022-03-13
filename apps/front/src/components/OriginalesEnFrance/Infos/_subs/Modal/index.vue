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
            {{ $t("originalesEnFrance.readMore.title1")[0] }}<br>
            {{ $t("originalesEnFrance.readMore.title1")[1] }}
          </h3>
          <p>
            {{ $t("originalesEnFrance.paragraphs.vacancy") }}
          </p>
          <p>
            {{ $t("originalesEnFrance.paragraphs.trap") }}
          </p>
          <p>
            {{ $t("originalesEnFrance.paragraphs.discovery") }}
          </p>
          <p>
            {{ $t("originalesEnFrance.paragraphs.connection") }}
          </p>
          <!-- <p>
            {{ $t("originalesEnFrance.paragraphs.family") }}
          </p>
          <p>
            {{ $t("originalesEnFrance.paragraphs.forge") }} -->
          <!-- </p> -->
        </div>
        <div class="chap2">
          <h3>
            {{ $t("originalesEnFrance.readMore.title2")[0] }}<br>
            {{ $t("originalesEnFrance.readMore.title2")[1] }}
          </h3>
          <p>
            {{ $t("originalesEnFrance.paragraphs.criterion") }}
          </p>
          <span>
            {{ $t("originalesEnFrance.paragraphs.distance") }}
          </span>
          <p>
            {{ $t("originalesEnFrance.paragraphs.changing") }}
          </p>
          <p>
            {{ $t("originalesEnFrance.paragraphs.farm") }}
          </p>
          <p>
            {{ $t("originalesEnFrance.paragraphs.burnOut") }}
          </p>
          <span>{{ $t("originalesEnFrance.paragraphs.unique") }}</span>
          <p>
            {{ $t("originalesEnFrance.paragraphs.work") }}
          </p>
          <p>
            {{ $t("originalesEnFrance.paragraphs.disponibility") }}
          </p>
          <p>
            {{ $t("originalesEnFrance.paragraphs.opportunity") }}
          </p>
          <span>{{ $t("originalesEnFrance.paragraphs.farmImage") }} </span>
          <p>
            {{ $t("originalesEnFrance.paragraphs.rather") }}
          </p>
          <p>
            {{ $t("originalesEnFrance.paragraphs.many") }}
          </p>
        </div>
        <div class="chap3">
          <h3>
            {{ $t("originalesEnFrance.readMore.title3")[0] }}<br>
            {{ $t("originalesEnFrance.readMore.title3")[1] }}
          </h3>
          <p>
            {{ $t("originalesEnFrance.paragraphs.style") }}
          </p>
          <span>
            {{ $t("originalesEnFrance.paragraphs.activitiesDiscovery") }}
          </span>
          <p>
            {{ $t("originalesEnFrance.paragraphs.reservation") }}
          </p>
          <p>
            {{ $t("originalesEnFrance.paragraphs.change") }}
          </p>
          <span>{{ $t("originalesEnFrance.paragraphs.activitiesAnnex") }} </span>
          <p>
            {{ $t("originalesEnFrance.paragraphs.proposed") }}
          </p>
          <p>
            {{ $t("originalesEnFrance.paragraphs.listed") }}
          </p>
          <span>{{ $t("originalesEnFrance.paragraphs.village") }}</span>
          <p>
            {{ $t("originalesEnFrance.paragraphs.goTo") }}
          </p>
          <p>
            {{ $t("originalesEnFrance.paragraphs.franceDiscovery") }}
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
