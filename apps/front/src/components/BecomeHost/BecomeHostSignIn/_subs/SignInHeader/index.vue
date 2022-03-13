<template>
  <div class="sign-in-header">
    <div
      :class="{
        visible: step === 2
      }"
      class="sign-in-header__back"
    >
      <button
        v-if="step === 2"
        class="sign-in-header__back__button"
        @click="$emit('back')"
      >
        <i class="material-icons">chevron_left</i>
      </button>
    </div>
    <div class="sign-in-header__titles">
      <div class="subtitle">
        {{ $t('becomeHost.buttons.create') }}
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'SignInHeader',
    props: {
      step: {
        type: Number,
        required: true
      }
    }
  }
</script>

<style lang="scss" scoped>
  .sign-in-header{
    display: flex;

    &__back{
      display: flex;
      width: 0;

      transition: width 200ms;

      &__button{
        appearance: none;
        background-color: transparent;
        border: none;
        cursor: pointer;

        .material-icons{
          font-size: 32px;
        }
      }

      &.visible{
        width: 50px;
      }
    }
  }
</style>
