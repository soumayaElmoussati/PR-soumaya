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
            {{ $t("chambreHote.readMore.title1") }}
          </h3>
          <p>
            {{ $t("chambreHote.paragraphs.vacancy") }}
          </p>
          <p>
            {{ $t("chambreHote.paragraphs.stayFarm") }}
          </p>
          <p>
            {{ $t("chambreHote.paragraphs.prepared") }}
          </p>
          <p>
            {{ $t("chambreHote.paragraphs.stopWorked") }}
          </p>
          <p>
            {{ $t("chambreHote.paragraphs.discovery") }}
          </p>
          <p>
            {{ $t("chambreHote.paragraphs.relax") }}
          </p>
        </div>
        <div class="chap2">
          <h3>
            {{ $t("chambreHote.readMore.title2") }}
          </h3>
          <p>
            {{ $t("chambreHote.paragraphs.criterion") }}
          </p>
          <span>
            {{ $t("chambreHote.paragraphs.distance") }}
          </span>
          <p>
            {{ $t("chambreHote.paragraphs.changing") }}
          </p>
          <p>
            {{ $t("chambreHote.paragraphs.located") }}
          </p>
          <p>
            {{ $t("chambreHote.paragraphs.parcours") }}
          </p>
          <span>{{ $t("chambreHote.paragraphs.unique") }}</span>
          <p>
            {{ $t("chambreHote.paragraphs.work") }}
          </p>
          <p>
            {{ $t("chambreHote.paragraphs.activities") }}
          </p>
          <p>
            {{ $t("chambreHote.paragraphs.opportunity") }}
          </p>
          <span>{{ $t("chambreHote.paragraphs.farmImage") }} </span>
          <p>
            {{ $t("chambreHote.paragraphs.rather") }}
          </p>
          <p>
            {{ $t("chambreHote.paragraphs.many") }}
          </p>
        </div>
        <div class="chap3">
          <h3>{{ $t("chambreHote.readMore.title3") }}</h3>
          <p>
            {{ $t("chambreHote.paragraphs.style") }}
          </p>
          <span>
            {{ $t("chambreHote.paragraphs.activitiesDiscovery") }}
          </span>
          <p>
            {{ $t("chambreHote.paragraphs.reservation") }}
          </p>
          <p>
            {{ $t("chambreHote.paragraphs.change") }}
          </p>
          <span>{{ $t("chambreHote.paragraphs.activitiesAnnex") }} </span>
          <p>
            {{ $t("chambreHote.paragraphs.proposition") }}
          </p>
          <p>
            {{ $t("chambreHote.paragraphs.listed") }}
          </p>
          <span>{{ $t("chambreHote.paragraphs.village") }}</span>
          <p>
            {{ $t("chambreHote.paragraphs.goTo") }}
          </p>
          <p>
            {{ $t("chambreHote.paragraphs.franceDiscovery") }}
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
  // modal {
  //   overflow-y: scroll;
  // }
  // .v--modal-background-click {
  //   .v--modal-box .v--modal {
  //     overflow: overlay!important;
  //   }
  // }
}
</style>
