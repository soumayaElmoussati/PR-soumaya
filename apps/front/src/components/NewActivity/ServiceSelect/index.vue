<template>
  <div class="service-select">
    <button
      v-for="(service, k) in services"
      :key="k"
      :class="{
        active: isActive(service.key)
      }"
      type="button"
      class="btn service-select__item"
      @click="select(service.key)"
    >
      <div class="service-select__item__block">
        <i
          v-if="service.className!='icon-towel'"
          :class="service.className"
          class="agri-animals"
        />
        <i
          v-if="service.className=='icon-towel'"
          :class="service.className"
          class="agri-others"
        />
      </div>
      <div class="service-select__item__name">
        {{ service.name }}
      </div>
    </button>
  </div>
</template>

<script>
  export default {
    name: 'ServiceSelect',
    data () {
      return {
        selection: [],
        services: [
          {
            key: 'breakfast',
            name: this.$t('offer.services.breakfast'),
            className: 'icon-breakfast'
          },
          {
            key: 'linens',
            name: this.$t('offer.services.linens'),
            className: 'icon-towel'
          },
          {
            key: 'cleaning',
            name: this.$t('offer.services.cleaning'),
            className: 'icon-clean'
          },
          {
            key: 'host_table',
            name: this.$t('offer.services.host_table'),
            className: 'icon-dish'
          }
        ]
      }
    },
    methods: {
      isActive (service) {
        return this.selection.includes(service)
      },
      select (service) {
        if (!this.isActive(service)) {
          this.selection.push(service)
        } else {
          const index = this.selection.findIndex(v => v === service)
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

    &__item{
      display: flex;
      flex-direction: column;
      align-content: flex-start;
      line-height: initial;
      margin-bottom: 16px;
      margin-right: 16px;
      padding: 0;

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

          .agri-animals, .agri-others{
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

        .agri-animals, .agri-others{
          color: rgba(black, 0.5);
          font-size: 42px;
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
        max-width: 78px;
      }
    }
  }
</style>
