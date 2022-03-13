<template>
  <div class="equipment-select">

    <button
      v-for="(tag, k) in tags"
      v-if="tag.className === 'tag'"
      :key="k"
      :class="{
        active: isActive(tag.key)
      }"
      type="button"
      class="btn equipment-select__item"
      @click="select(tag.key)"
    >

      <div
        class="equipment-select__item__name">

        #{{ tag.name }}
      </div>
    </button>

  </div>
</template>

<script>
  export default {
    name: 'TagSelect',
    data () {
      return {
        selection: [],
        tags: [
          {
            key: 'playful',
            name: this.$t('offer.tags.playful'),
            className: 'tag'
          },
          {
            key: 'pedagogic',
            name: this.$t('offer.tags.pedagogic'),
            className: 'tag'
          },
          {
            key: 'unusual',
            name: this.$t('offer.tags.unusual'),
            className: 'tag'
          },
          {
            key: 'public',
            name: this.$t('offer.tags.public'),
            className: 'tag'
          },
          {
            key: 'gustatory',
            name: this.$t('offer.tags.gustatory'),
            className: 'tag'
          },
          {
            key: 'animal',
            name: this.$t('offer.tags.animal'),
            className: 'tag'
          },
          {
            key: 'dirty',
            name: this.$t('offer.tags.dirty'),
            className: 'tag'
          },
          {
            key: 'rewarding',
            name: this.$t('offer.tags.rewarding'),
            className: 'tag'
          },
          {
            key: 'depth',
            name: this.$t('offer.tags.depth'),
            className: 'tag'
          },
          {
            key: 'intensive',
            name: this.$t('offer.tags.intensive'),
            className: 'tag'
          },
          {
            key: 'quick',
            name: this.$t('offer.tags.quick'),
            className: 'tag'
          },
          {
            key: 'physical',
            name: this.$t('offer.tags.physical'),
            className: 'tag'
          }
        ]
      }
    },
    methods: {
      isActive (tag) {
        return this.selection.includes(tag)
      },
      select (tag) {
        if (!this.isActive(tag)) {
          this.selection.push(tag)
        } else {
          const index = this.selection.findIndex(v => v === tag)
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
      height: 38px;
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
