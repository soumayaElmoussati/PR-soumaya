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
            {{ $t("insoliteBretagne.readMore.title1") }}
          </h3>
          <p>
            {{ $t("insoliteBretagne.paragraphs.breton") }}
          </p>
          <p>
            {{ $t("insoliteBretagne.paragraphs.surround") }}
          </p>
          <p>
            {{ $t("insoliteBretagne.paragraphs.definition") }}
          </p>
          <p>
            {{ $t("insoliteBretagne.paragraphs.real") }}
          </p>
          <p>
            {{ $t("insoliteBretagne.paragraphs.farmLife") }}
          </p>
          <p>
            {{ $t("insoliteBretagne.paragraphs.memory") }}
          </p>
        </div>
        <div class="chap2">
          <h3>
            {{ $t("insoliteBretagne.readMore.title2") }}
          </h3>
          <p>
            {{ $t("insoliteBretagne.paragraphs.criterion") }}
          </p>
          <span>
            {{ $t("insoliteBretagne.paragraphs.unique") }}
          </span>
          <p>
            {{ $t("insoliteBretagne.paragraphs.work") }}
          </p>
          <p>
            {{ $t("insoliteBretagne.paragraphs.activities") }}
          </p>
          <p>
            {{ $t("insoliteBretagne.paragraphs.opportunity") }}
          </p>
          <span>{{ $t("insoliteBretagne.paragraphs.farmImage") }}</span>
          <p>
            {{ $t("insoliteBretagne.paragraphs.rather") }}
          </p>
          <p>
            {{ $t("insoliteBretagne.paragraphs.proposed") }}
          </p>
          <!-- <p>
            {{ $t("chambreHote.paragraphs.opportunity") }}
          </p>
          <span>{{ $t("chambreHote.paragraphs.farmImage") }} </span>
          <p>
            {{ $t("chambreHote.paragraphs.rather") }}
          </p>
          <p>
            {{ $t("chambreHote.paragraphs.many") }}
          </p> -->
        </div>
        <div class="chap3">
          <h3>{{ $t("insoliteBretagne.readMore.title3") }}</h3>
          <p>
            {{ $t("insoliteBretagne.paragraphs.style") }}
          </p>
          <span>
            {{ $t("insoliteBretagne.paragraphs.activitiesDiscovery") }}
          </span>
          <p>
            {{ $t("insoliteBretagne.paragraphs.reservation") }}
          </p>
          <p>
            {{ $t("insoliteBretagne.paragraphs.change") }}
          </p>
          <span>{{ $t("insoliteBretagne.paragraphs.activitiesAnnex") }} </span>
          <p>
            {{ $t("insoliteBretagne.paragraphs.many") }}
          </p>
          <p>
            {{ $t("insoliteBretagne.paragraphs.listed") }}
          </p>
          <span>{{ $t("insoliteBretagne.paragraphs.village") }}</span>
          <p>
            {{ $t("insoliteBretagne.paragraphs.goTo") }}
          </p>
          <p>
            {{ $t("insoliteBretagne.paragraphs.franceDiscovery") }}
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
