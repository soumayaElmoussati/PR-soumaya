<template>
  <div class="offer-activities">
    <h2>
      {{ $t('activity.titles.activities') }}:
    </h2>
    <p class="body-1">
      {{ activities }}
    </p>
  </div>
</template>

<script>
  export default {
    name: 'ActivityActivites',
    props: {
      activities: {
        type: String,
        required: true
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .offer-activities{
    h2{
      font-size: 20px;
      font-weight: 400;
      color: $primary-text;
    }
  }
</style>
