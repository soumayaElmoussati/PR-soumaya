<template>
  <div class="edit-offer">

    <div class="wrap">
      <div class="edit-offer__menu">
        <nav>
          <ul>
            <li class="offer-name">
              {{ getCurrentActivity.name }}
            </li>
            <li>
              <nuxt-link
                :to="{
                  name: 'EditActivityActivity'
                }"
              >
                {{ $t("activity.titles.yourResidence") }}
              </nuxt-link>
            </li>
            <li>
              <nuxt-link
                :to="{
                  name: 'EditActivityRules'
                }"
              >
                {{ $t("activity.titles.rules") }}
              </nuxt-link>
            </li>
            <li>
              <nuxt-link
                :to="{
                  name: 'EditActivityFarm'
                }"
              >
                {{ $t("activity.titles.yourOperation") }}
              </nuxt-link>
            </li>
            <li>
              <nuxt-link
                :to="{
                  name: 'EditActivityPrice'
                }"
              >
                {{ $t("activity.titles.rate") }}
              </nuxt-link>
            </li>
            <li>
              <nuxt-link
                :to="{
                  name: 'EditActivityPictures'
                }"
              >
                {{ $t("activity.titles.picture") }}
              </nuxt-link>
            </li>
            <li>
              <nuxt-link
                :to="{
                  name: 'EditActivityCalendar'
                }"
              >
                {{ $t("activity.titles.calendar") }}
              </nuxt-link>
            </li>
          </ul>
        </nav>
      </div>
      <div class="side">
        <nuxt />
      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  import Cloudinary from '@/components/Cloudinary'

  export default {
    name: 'EditActivity',
    components: {
      Cloudinary
    },
    fetch ({ app, route, store }) {
      return app.$axios.get(`/activities/${route.params.id}`)
        .then(res => {
          if (res.status === 200) {
            store.commit('SET_CURRENT_ACTIVITY', res.data)
          }
        })
    },
    computed: {
      ...mapGetters([
        'getCurrentActivity'
      ])
    }
  }
</script>

<style lang="scss" scoped>
  .edit-offer{
    .wrap{
      display: flex;
      width: 100%;
      max-width: none;
    }

    .side{
      width: 90%;
      @media screen and (max-width: 768px) {
        width: 100%;
      }
    }

    &__menu {
      background-color: #476458;
      width: 25%;
      @media screen and (max-width: 768px) {
        display: none;
      }

      ul,
      li {
        list-style-type: none;
        margin: 0;
        padding: 0;
      }

      li {
        padding: 25px;
        color: black !important;
        border: 1px solid #476458;
        border-radius: 50px 0px 0px 50px;
        margin-top: 15px;
      }

      ul {
        display: flex;
        flex-direction: column;
        margin-left: 20px;
      }

      a {
          color: white !important;
          text-transform: uppercase;
          font-size: 13px;
          text-decoration: none;
          text-align: center;
          font-weight: bold;
          font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
      }

      .offer-name {
        color: white !important;
        text-transform: uppercase;
        font-size: 13px;
        text-decoration: none;
        text-align: center;
        font-weight: bold;
        font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
      }
    }
  }

  @media screen and (max-width: 768px) {
    .edit-offer{

      .side{
        width: 100%;
      }

      &__menu {
        display: none;
      }
    }
  }
</style>
