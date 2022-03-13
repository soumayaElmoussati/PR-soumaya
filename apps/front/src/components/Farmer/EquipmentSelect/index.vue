<template>
  <div class="equipment-select">

    <button
      v-for="(equipment, k) in equipments"
      v-if="equipment.className === 'language'"
      :key="k"
      :class="{
        active: isActive(equipment.key)
      }"
      type="button"
      class="btn equipment-select__item"
      @click="select(equipment.key)"
    >

      <div
        class="equipment-select__item__name">
        <i
          v-if="isActive(equipment.key)"
          class="equipment-select__item__name__check material-icons check-icon"
          aria-hidden="true"
        >check</i>
        {{ equipment.name }}
      </div>
    </button>

  </div>
</template>

<script>
  export default {
    name: 'EquipmentSelect',
    data () {
      return {
        selection: [],
        equipments: [
          {
            key: 'english',
            name: this.$t('farmer.equipments.english'),
            className: 'language'
          },
          {
            key: 'spanish',
            name: this.$t('farmer.equipments.spanish'),
            className: 'language'
          },
          {
            key: 'german',
            name: this.$t('farmer.equipments.german'),
            className: 'language'
          },
          {
            key: 'italian',
            name: this.$t('farmer.equipments.italian'),
            className: 'language'
          },
          {
            key: 'portuguese',
            name: this.$t('farmer.equipments.portuguese'),
            className: 'language'
          },
          {
            key: 'russian',
            name: this.$t('farmer.equipments.russian'),
            className: 'language'
          },
          {
            key: 'dutch',
            name: this.$t('farmer.equipments.dutch'),
            className: 'language'
          },
          {
            key: 'french',
            name: this.$t('farmer.equipments.french'),
            className: 'language'
          }
        ]
      }
    },
    methods: {
      isActive (equipment) {
        return this.selection.includes(equipment)
      },
      select (equipment) {
        if (!this.isActive(equipment)) {
          this.selection.push(equipment)
        } else {
          const index = this.selection.findIndex(v => v === equipment)
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
    @media screen and (max-width: $breakpoint-mobile-m) {
      flex-direction: column;
      align-items: center;
    }

    .check-icon{
      font-size: 15px;
    }

    &__title{
      width: 100%;

      margin-bottom: 10px;
    }

    &__item{
      display: flex;
      flex-direction: column;
      align-content: flex-start;
      line-height: initial;
      padding: 0;
      width: 25%;
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
          border-color: #44933b;

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
        text-align: center;
        width: 125px;
        border: 1px solid #44933b;
        border-radius: 50px;
        padding: 5px;
        font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
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
