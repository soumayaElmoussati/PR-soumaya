<template>
  <div class="equipment-select">

    <h6 class="headline">{{ $t("activity.titles.fun") }}</h6>

    <br>

    <button
      v-for="(equipment, k) in equipments"
      v-if="equipment.className === 'entertainment'"
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
        {{ equipment.name }}
      </div>
    </button>

    <h6 class="headline">{{ $t("activity.titles.health") }}</h6>

    <button
      v-for="(equipment, k) in equipments"
      v-if="equipment.className === 'hygiene'"
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
        {{ equipment.name }}
      </div>
    </button>

    <h6 class="headline">Confort:</h6>

    <button
      v-for="(equipment, k) in equipments"
      v-if="equipment.className === 'confort'"
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
        {{ equipment.name }}
      </div>
    </button>

    <h6 class="headline">{{ $t("activity.titles.cooking") }}</h6>

    <button
      v-for="(equipment, k) in equipments"
      v-if="equipment.className === 'kitchen' "
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
        {{ equipment.name }}
      </div>
    </button>

    <h6 class="headline">{{ $t("activity.titles.serenity") }}</h6>

    <button
      v-for="(equipment, k) in equipments"
      v-if="equipment.className === 'calm'"
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
            key: 'wifi',
            name: this.$t('offer.equipments.wifi'),
            className: 'entertainment'
          },
          {
            key: 'tv',
            name: this.$t('offer.equipments.tv'),
            className: 'entertainment'
          },
          {
            key: 'internet',
            name: this.$t('offer.equipments.internet'),
            className: 'entertainment'
          },
          {
            key: 'dvd_player',
            name: this.$t('offer.equipments.dvd_player'),
            className: 'entertainment'
          },
          {
            key: 'games',
            name: this.$t('offer.equipments.games'),
            className: 'entertainment'
          },
          // {
          //   key: 'english_speaking',
          //   name: this.$t('offer.equipments.english_speaking'),
          //   className: 'entertainment'
          // },
          {
            key: 'washing_machine',
            name: this.$t('offer.equipments.washing_machine'),
            className: 'hygiene'
          },
          {
            key: 'dryer',
            name: this.$t('offer.equipments.dryer'),
            className: 'hygiene'
          },
          {
            key: 'hair_dryer',
            name: this.$t('offer.equipments.hair_dryer'),
            className: 'hygiene'
          },
          {
            key: 'drying_rack',
            name: this.$t('offer.equipments.drying_rack'),
            className: 'hygiene'
          },
          {
            key: 'iron',
            name: this.$t('offer.equipments.iron'),
            className: 'hygiene'
          },
          {
            key: 'wardrobe',
            name: this.$t('offer.equipments.wardrobe'),
            className: 'hygiene'
          },
          {
            key: 'shower',
            name: this.$t('offer.equipments.shower'),
            className: 'hygiene'
          },
          {
            key: 'bath',
            name: this.$t('offer.equipments.bath'),
            className: 'hygiene'
          },
          {
            key: 'baby_bath',
            name: this.$t('offer.equipments.baby_bath'),
            className: 'hygiene'
          },
          {
            key: 'fireplace',
            name: this.$t('offer.equipments.fireplace'),
            className: 'confort'
          },
          {
            key: 'heater',
            name: this.$t('offer.equipments.heater'),
            className: 'confort'
          },
          {
            key: 'swimming_pool',
            name: this.$t('offer.equipments.swimming_pool'),
            className: 'confort'
          },
          {
            key: 'clim',
            name: this.$t('offer.equipments.clim'),
            className: 'confort'
          },
          {
            key: 'fitness',
            name: this.$t('offer.equipments.fitness'),
            className: 'confort'
          },
          {
            key: 'garden_lounge',
            name: this.$t('offer.equipments.garden_lounge'),
            className: 'confort'
          },
          {
            key: 'bbq',
            name: this.$t('offer.equipments.bbq'),
            className: 'confort'
          },
          {
            key: 'kitchen',
            name: this.$t('offer.equipments.kitchen'),
            className: 'kitchen'
          },
          {
            key: 'oven',
            name: this.$t('offer.equipments.oven'),
            className: 'kitchen'
          },
          {
            key: 'hotplates',
            name: this.$t('offer.equipments.hotplates'),
            className: 'kitchen'
          },
          {
            key: 'microwaves',
            name: this.$t('offer.equipments.microwaves'),
            className: 'kitchen'
          },
          {
            key: 'toaster',
            name: this.$t('offer.equipments.toaster'),
            className: 'kitchen'
          },
          {
            key: 'kettle',
            name: this.$t('offer.equipments.kettle'),
            className: 'kitchen'
          },
          {
            key: 'coffee_machine',
            name: this.$t('offer.equipments.coffee_machine'),
            className: 'kitchen'
          },
          {
            key: 'cutlery',
            name: this.$t('offer.equipments.cutlery'),
            className: 'kitchen'
          },
          {
            key: 'dishwasher',
            name: this.$t('offer.equipments.dishwasher'),
            className: 'kitchen'
          },
          {
            key: 'baby_chair',
            name: this.$t('offer.equipments.baby_chair'),
            className: 'kitchen'
          },
          {
            key: 'fridge',
            name: this.$t('offer.equipments.fridge'),
            className: 'kitchen'
          },
          {
            key: 'freezer',
            name: this.$t('offer.equipments.freezer'),
            className: 'kitchen'
          },
          {
            key: 'deep_freezer',
            name: this.$t('offer.equipments.deep_freezer'),
            className: 'kitchen'
          },
          {
            key: 'parking',
            name: this.$t('offer.equipments.parking'),
            className: 'calm'
          },
          {
            key: 'garage',
            name: this.$t('offer.equipments.garage'),
            className: 'calm'
          },
          {
            key: 'private_garden',
            name: this.$t('offer.equipments.private_garden'),
            className: 'calm'
          },
          {
            key: 'shared_garden',
            name: this.$t('offer.equipments.shared_garden'),
            className: 'calm'
          },
          {
            key: 'secure_local',
            name: this.$t('offer.equipments.secure_local'),
            className: 'calm'
          },
          {
            key: 'train',
            name: this.$t('offer.equipments.train'),
            className: 'calm'
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

  .headline{
    padding-top:20px;
    text-transform: uppercase;
    font-size: 18px;
    width: 100%;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
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
      // margin-bottom: 16px;
      // margin-right: 16px;
      padding: 0;
      height: 25px;
      width: 33%;
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
          color: #44933b;
          font-weight: bold;
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
        color: #466357;
        text-transform: none;
        font-size: 14px;
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
