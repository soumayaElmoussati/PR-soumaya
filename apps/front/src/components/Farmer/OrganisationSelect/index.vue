<template>
  <div class="service-select">
    <button
      v-for="(organisation, k) in organisations"
      :key="k"
      :class="{
        active: isActive(organisation.key)
      }"
      type="button"
      class="btn service-select__item"
      @click="select(organisation.key)"
    >
      <div class="service-select__item__block">
        <i
          :class="organisation.className"
          class="agri-organisations"
        />
      </div>
      <div class="service-select__item__name">
        {{ organisation.name }}
      </div>
    </button>
  </div>
</template>

<script>
  export default {
    name: 'OrganisationSelect',
    data () {
      return {
        selection: [],
        organisations: [
          {
            key: 'adb',
            name: this.$t('farmer.organisations.adb'),
            className: 'icon-adb'
          },
          {
            key: 'bbc',
            name: this.$t('farmer.organisations.bbc'),
            className: 'icon-bbc'
          },
          {
            key: 'fairefrance',
            name: this.$t('farmer.organisations.fairefrance'),
            className: 'icon-fairefrance'
          }
        ]
      }
    },
    methods: {
      isActive (organisation) {
        return this.selection.includes(organisation)
      },
      select (organisation) {
        if (!this.isActive(organisation)) {
          this.selection.push(organisation)
        } else {
          const index = this.selection.findIndex(v => v === organisation)
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

  .service-select{
    display: flex;
    flex-wrap: wrap;
    align-items: center;

    &__item{
      display: flex;
      flex-direction: column;
      align-content: flex-start;
      line-height: initial;
      margin-right: 16px;
      padding: 0;
      width: 120px;

      &:focus{
        .service-select__item__block{
          @include shadow(gray);
        }
      }

      &.active{
        .service-select__item__name{
          color: #7BBA59;
        }

        .service-select__item__block{
          border-color: #7BBA59;

          .agri-organisations{
            color: #7BBA59;
          }
        }

        &:focus{
          .service-select__item__block{
            @include shadow(#7BBA59);
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

        .agri-organisations{
          color: rgba(black, 0.5);
          font-size: 70px;
          margin: auto;
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
        color: rgba(black, 0.5);
        text-transform: none;
        font-size: 14px;
        text-align: center;
        width: 100%;
      }
    }
  }
</style>
