<template>
  <div class="equipment-select">
    <button
      v-for="(adjectif, k) in adjectifs"
      v-if="adjectif.className === 'adjectif'"
      :key="k"
      :class="{
        active: isActive(adjectif.key)
      }"
      type="button"
      class="btn equipment-select__item"
      @click="select(adjectif.key)"
    >

      <div
        class="equipment-select__item__name">
        #{{ adjectif.name }}
      </div>
    </button>

  </div>
</template>

<script>
  export default {
    name: 'AdjectifSelect',
    data () {
      return {
        selection: [],
        adjectifs: [
          {
            key: 'rustic',
            name: this.$t('offer.adjectifs.rustic'),
            className: 'adjectif'
          },
          {
            key: 'luxurious',
            name: this.$t('offer.adjectifs.luxurious'),
            className: 'adjectif'
          },
          {
            key: 'confortable',
            name: this.$t('offer.adjectifs.confortable'),
            className: 'adjectif'
          },
          {
            key: 'clean',
            name: this.$t('offer.adjectifs.clean'),
            className: 'adjectif'
          },
          {
            key: 'friendly',
            name: this.$t('offer.adjectifs.friendly'),
            className: 'adjectif'
          },
          {
            key: 'calm',
            name: this.$t('offer.adjectifs.calm'),
            className: 'adjectif'
          },
          {
            key: 'exotic',
            name: this.$t('offer.adjectifs.exotic'),
            className: 'adjectif'
          },
          {
            key: 'romantic',
            name: this.$t('offer.adjectifs.romantic'),
            className: 'adjectif'
          },
          {
            key: 'cheap',
            name: this.$t('offer.adjectifs.cheap'),
            className: 'adjectif'
          },
          {
            key: 'insolit',
            name: this.$t('offer.adjectifs.insolit'),
            className: 'adjectif'
          },
          {
            key: 'simple',
            name: this.$t('offer.adjectifs.simple'),
            className: 'adjectif'
          },
          {
            key: 'luminous',
            name: this.$t('offer.adjectifs.luminous'),
            className: 'adjectif'
          }
        ]
      }
    },
    methods: {
      isActive (adjectif) {
        return this.selection.includes(adjectif)
      },
      select (adjectif) {
        if (!this.isActive(adjectif)) {
          this.selection.push(adjectif)
        } else {
          const index = this.selection.findIndex(v => v === adjectif)
          this.selection.splice(index, 1)
        }
        this.$emit('input', this.selection)
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";
  @import "@/assets/scss/_mixins.scss";

  h6 {
    margin-bottom: 0px;
  }

  .equipment-select{
    display: flex;
    flex-wrap: wrap;

    .check-icon{
      font-size: 15px;
    }

    &__title{
      width: 100%;
      text-transform: uppercase;
      margin-bottom: 10px;
    }

    &__item{
      display: flex;
      flex-direction: column;
      align-content: flex-start;
      line-height: initial;
      padding: 0;
      height: 25px;
      width: 30%;
      margin-bottom: 10px;
      @media screen and (max-width: 768px) {
        width: 50%;
      }

      &:focus{
        .equipment-select__item__block{
          @include shadow(gray);
        }
      }

      &.active{
        .equipment-select__item__name{
          color: white;
          background-color: #44933b;
        }

        .equipment-select__item__block{
          border-color: $primary;

          .agri-animals, .agri-others{
            color: $primary;
          }
        }

        &:focus{
          .equipment-select__item__block{
            @include shadow($primary);
          }
        }
      }

      &__block{
        position: relative;
        display: flex;
        border: 1px solid rgba(black, 0.3);
        border-radius: 6px;
        height: 78px;
        width: 78px;
        margin: 0 auto;

        .agri-animals, .agri-others{
          color: rgba(black, 0.5);
          font-size: 42px;
          margin: auto;
        }
        .icon-deck-chair:before {
          color: unset;
        }

        &__check {
          position: absolute;
          background-color: $primary;
          color: white;
          width: 20px;
          height: 20px;
          line-height: 20px;
          border-radius: 100%;
          font-size: 14px;
          bottom: -5px;
          right: -5px;
        }
      }

      &__name{
        color: #44933b;
        text-transform: none;
        font-size: 12px;
        font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
        border: 1px solid #44933b;
        border-radius: 50px;
        padding: 5px 10px;
        margin-top: 10px;
      }
    }
  }

  @media screen and (max-width: 768px) {

    .equipment-select{

      &__item{
        width: 50%;
      }
    }
  }
</style>
