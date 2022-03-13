<template>
  <div class="wi-input">
    <label
      :for="id"
      :title="label"
      class="wi-input__label"
    >
      {{ label }}
    </label>
    <input
      :id="id"
      :name="name"
      :class="{
        'has-error': error
      }"
      v-model="tempValue"
      v-bind="$attrs"
      class="input"
    >
    <span
      v-if="caption && !error"
      :title="caption"
      class="wi-input__caption"
    >
      {{ caption }}
    </span>
    <span
      v-if="error"
      :title="error"
      class="wi-input__error"
    >
      {{ error }}
    </span>
  </div>
</template>

<script>
  export default {
    name: 'WiInput',
    inheritAttrs: false,
    props: {
      id: {
        type: String,
        required: true
      },
      name: {
        type: String,
        default: null
      },
      label: {
        type: String,
        required: true
      },
      caption: {
        type: String,
        default: null
      },
      error: {
        type: String,
        default: null
      },
      value: {
        type: [String, Number, Boolean],
        default: null
      }
    },
    computed: {
      tempValue: {
        get () {
          return this.value
        },
        set (v) {
          this.$emit('input', v)
        }
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .wi-input{
    display: flex;
    flex-direction: column;

    &__label{
      margin: auto 0;
      color: #476458;
      font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
      font-weight: bold;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      @media screen and (max-width: $breakpoint-tablet) {
        margin-top: 20px;
      }
    }

    &__caption, &__error{
      font-size: 16px;
      color: $third-text;
      margin-top: 6px;
    }

    &__error{
      color: $danger;
    }
  }
</style>
