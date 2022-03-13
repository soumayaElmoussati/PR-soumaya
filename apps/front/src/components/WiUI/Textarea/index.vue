<template>
  <div class="wi-textarea">
    <div class="wi-textarea__label">
      <label
        :for="id"
        class="wi-textarea__label__el"
      >
        {{ label }}
      </label>
      <span
        v-if="wordCount"
        class="wi-textarea__label__wordcount"
      >
        {{ (tempValue || '').length }} {{ $t("weekEndFerme.label.character") }}
      </span>
    </div>
    <textarea
      :id="id"
      :name="name"
      v-bind="$attrs"
      v-model="tempValue"
      :class="{
        'has-error': error
      }"
      type="text"
      class="textarea"
    />
    <span
      v-if="caption && !error"
      class="wi-textarea__caption"
    >
      {{ caption }}
    </span>
    <span
      v-if="error"
      class="wi-textarea__error"
    >
      {{ error }}
    </span>
  </div>
</template>

<script>
  export default {
    name: 'WiTextarea',
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
      value: {
        type: [String, Number, Boolean],
        default: null
      },
      wordCount: {
        type: Boolean,
        default: false
      },
      error: {
        type: String,
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

  .wi-textarea{
    display: flex;
    flex-direction: column;

    &__label{
      display: flex;
      justify-content: space-between;

      &__el{
        margin-bottom: 6px;
        color: $primary-text;
      }

      &__wordcount{
        color: $third-text;
        white-space: nowrap;
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
