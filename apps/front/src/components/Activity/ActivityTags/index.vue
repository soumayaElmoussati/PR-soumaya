<template>
  <div class="offer-equipments">

    <div class="offer-equipments-list">
      <div
        v-for="(tag, k) in tagsList"
        :key="k"
        class="equipment-item"
      >
        <span class="equipment-item-name">
          #{{ tag.name }}
        </span>
      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'ActivityTags',
    data () {
      return {
        tags: [
          {
            key: 'playful',
            name: this.$t('activity.tags.playful'),
            className: 'tag'
          },
          {
            key: 'pedagogic',
            name: this.$t('activity.tags.pedagogic'),
            className: 'tag'
          },
          {
            key: 'unusual',
            name: this.$t('activity.tags.unusual'),
            className: 'tag'
          },
          {
            key: 'public',
            name: this.$t('activity.tags.public'),
            className: 'tag'
          },
          {
            key: 'gustatory',
            name: this.$t('activity.tags.gustatory'),
            className: 'tag'
          },
          {
            key: 'animal',
            name: this.$t('activity.tags.animal'),
            className: 'tag'
          },
          {
            key: 'dirty',
            name: this.$t('activity.tags.dirty'),
            className: 'tag'
          },
          {
            key: 'rewarding',
            name: this.$t('activity.tags.rewarding'),
            className: 'tag'
          },
          {
            key: 'depth',
            name: this.$t('activity.tags.depth'),
            className: 'tag'
          },
          {
            key: 'intensive',
            name: this.$t('activity.tags.intensive'),
            className: 'tag'
          },
          {
            key: 'quick',
            name: this.$t('activity.tags.quick'),
            className: 'tag'
          },
          {
            key: 'physical',
            name: this.$t('activity.tags.physical'),
            className: 'tag'
          }
        ]
      }
    },
    computed: {
      ...mapGetters([
        'getActivity'
      ]),
      tagsList () {
        return this.tags.filter((v) => {
          const tagObj = this.getActivity.tag
          return tagObj[v.key]
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .offer-equipments{

    margin-top: 15px;
    @media only screen and (max-width: $breakpoint-mobile-l) {
      margin-top: 50px;
    }

    &-list{
      display: flex;
      flex-wrap: wrap;

      .equipment-item{
        display: flex;
        flex-direction: row;
        align-items: center;

        margin-right: 10px;
        margin-bottom: 10px;

        border-right: 1px solid #79BC53;
        border-radius: 50px;

        background-color: #79BC53;

        padding: 5px 10px;

        &:last-child{
          margin-right: 0;
        }

        &-name{
          color: white;
          font-size: 12px;
          text-align: center;
          width: 100%;
          font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;

        }
      }
    }
  }
</style>
