<template>
  <div class="offer">

    <div
      class="pictures-container-solo">
      <activity-banner/>
      <activity-pictures />
    </div>

    <div class="offer-container">

      <div class="main-content">

        <activity-tags v-if="getActivity.tag" />

        <div class="content-main-box">

          <h3 class="content-title">{{ $t('offer.titles.farm') }}</h3>

          <div class="divider" />

          <activity-content
            v-if="getActivity.description.farm"
            class="content-desc">
            <read-more
              :text="getActivity.description.farm"
              :max-chars="300"
              class="content-desc"
              more-str="En savoir plus"
              link="#"
            />
          </activity-content>

        </div>

        <div class="content-box">
          <activity-animals v-if="getActivity.animal" />
        </div>

        <div class="content-box">

          <h3 class="content-title">{{ $t('activity.titles.activities') }}</h3>

          <div class="divider" />

          <activity-content
            v-if="getActivity.description.activities"
          >
            <div class="activity-list-wrap">
              <div
                v-for="(activity, k) in activitiesList"
                :key="k"
                class="activity-item">
                <div class="activity-item-block">
                  <i
                    :class="activity.className"
                    class="agri-others2 activity-item-icon" />
                  <span class="activity-item-name">{{ activity.name }}</span>
                </div>
              </div>
            </div>

            <read-more
              :text="getActivity.description.activities"
              :max-chars="200"
              class="content-desc"
              more-str="En savoir plus"
              link="#"
            />
          </activity-content>

        </div>

      </div>

      <div class="aside-content">

        <activity-booking
          v-sticky="{ stickyTop: 120, zIndex: 5 }"
          :can-submit="!isFarmer" />

        <activity-modal v-if="!isClient" />

        <div class="chatroom">
          <nuxt-link
            v-if="isClient"
            :to="{
              name: 'ChatRoomActivity',
              params: {
                id: getActivity.id
              }
            }"
            class="btn contact-btn"
            target="_blank"
          >
            {{ $t('activity.buttons.contactAgri') }}
          </nuxt-link>
        </div>

      </div>
    </div>

    <activity-farmer />

  </div>
</template>

<script>
import { mapGetters } from 'vuex'

import ActivityPictures from '@/components/Activity/ActivityPictures'
import ActivityBanner from '@/components/Activity/ActivityBanner'
import ActivityTags from '@/components/Activity/ActivityTags'
import ActivityAnimals from '@/components/Activity/ActivityAnimals'
import ActivityFarmer from '@/components/Activity/ActivityFarmer'
import ActivityContent from '@/components/Activity/ActivityContent'
import ActivityModal from '@/components/Activity/ActivityModal'
import ActivityBooking from '@/components/Activity/ActivityBooking'

export default {
  name: 'Activity',
  components: {
    ActivityPictures,
    ActivityBanner,
    ActivityTags,
    ActivityAnimals,
    ActivityFarmer,
    ActivityContent,
    ActivityModal,
    ActivityBooking
  },
  head () {
    return {
      title: this.getActivity.name,
      meta: [
        {
          hid: 'description',
          name: 'description',
          content: this.getActivityMetaDescription
        }
      ]
    }
  },
  fetch ({ store, app, route, error }) {
    return Promise.all([
      app.$axios.get(`/activities/${route.params.id}`),
      app.$axios.get(`/activities/${route.params.id}/activity_bookings`)
    ])
      .then(values => {
        if (values[0].status === 200) {
          store.dispatch('setActivity', values[0].data)
        }

        if (values[1].status === 200) {
          store.commit('SET_CURRENT_ACTIVITY_BOOKINGS', values[1].data)
        }
      })
      .catch(() => {
        error({
          statusCode: 404,
          message: "Cette activité n'existe pas ou plus"
        })
      })
    // return app.$axios.get(`/offers/${route.params.id}`)
    //   .then((res) => {
    //     if (res.status === 200) {
    //       store.dispatch('setOffer', res.data)
    //     }
    //   })
    //   .catch(() => {
    //     error({
    //       statusCode: 404,
    //       message: 'Cette offre n\'existe pas ou plus'
    //     })
    //   })
  },
  data () {
    return {
      activities: [
        {
          key: 'discovery',
          name: this.$t('offer.activities.discovery'),
          className: 'icon-gardening-boots'
        },
        {
          key: 'meeting_animals',
          name: this.$t('offer.activities.meeting_animals'),
          className: 'icon-binoculars'
        },
        {
          key: 'milking_animals',
          name: this.$t('offer.activities.milking_animals'),
          className: 'icon-cow-milking'
        },
        {
          key: 'tasting',
          name: this.$t('offer.activities.tasting'),
          className: 'icon-taste'
        },
        {
          key: 'birth_animal',
          name: this.$t('offer.activities.birth_animal'),
          className: 'icon-bird-in-broken-egg'
        },
        {
          key: 'stroll',
          name: this.$t('offer.activities.stroll'),
          className: 'icon-tractor'
        },
        {
          key: 'harvest',
          name: this.$t('offer.activities.harvest'),
          className: 'icon-harvest'
        },
        {
          key: 'craft',
          name: this.$t('offer.activities.craft'),
          className: 'icon-stir'
        }
      ]
    }
  },
  computed: {
    ...mapGetters(['getActivity', 'isFarmer', 'isClient', 'getCurrentActivityBookings']),
    getBasePrice () {
      // NOTE: Prix de base de la nuit
      return this.getActivity.price_per_person
    },
    getActivityMetaDescription () {
      const { description } = this.getActivity
      if (typeof description !== 'undefined') {
        const possibleDesc = [description.farm, description.activities].join(
          ''
        )

        if (possibleDesc.length > 0) {
          return possibleDesc.substring(0, 200)
        }
      }

      return this.$t('home.meta.description')
    },
    activitiesList () {
      return this.activities.filter(v => {
        const serviceObj = this.getActivity.description
        return serviceObj[v.key]
      })
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.contact-btn {
  margin: auto;
  background-color: $agri-green;
  color: white;
  padding: 0px 10px;
  border-radius: 50px;
  box-shadow: 1px 1px 12px #555;
  margin-top: 1vw;
  width: 15vw;
  font-size: 12px;

  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100%;
    padding: 0px 0px;
  }
}

.pictures-container {
  display: grid;
  grid-template-columns: 50% 50%;
  grid-column-gap: 5px;
  @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: 100%;
  }
}

.pictures-container-solo {
  display: grid;
  grid-template-columns: 100%;
}

// .farm-pictures-box {

// }

.offer {
  &-container {
    margin-bottom: 50px;
    display: grid;
    grid-template-columns: 55% 30%;
    grid-gap: 15%;

    background-color: white;
    padding-right: 50px;
    padding-left: 50px;
    margin-left: 5vw;
    margin-right: 5vw;
    padding-bottom: 35px;
    margin-bottom: 0px;

    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;

    @media only screen and (max-width: $breakpoint-laptop-m) {
      margin-left: 0px;
      margin-right: 0px;
    }

    @media only screen and (max-width: $breakpoint-tablet) {
      grid-template-columns: 1fr;
      grid-gap: 0%;
      padding: 0 16px;
    }
  }
  .divider {
    height: 1px;
    background-color: rgba(black, 0.3);
    margin-top: 16px;
  }

  .side-content {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    grid-gap: 16px;

    @media only screen and (max-width: $breakpoint-laptop-m) {
      grid-template-columns: 1fr;
    }
  }

  &-farmer {
    margin-top: 32px;
    @media only screen and (max-width: $breakpoint-mobile-l) {
      padding: 0 16px;
    }
  }
}

.main-content {
  padding-left: 25px;
  padding-top: 25px;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    padding-left: 0px;
  }
}

.content-main-box {
  margin-top: 60px;
  margin-bottom: 30px;
}

.content-box {
  margin-bottom: 30px;
}

.content-title {
  text-transform: uppercase;
  color: #476458;
  font-size: 21px;
  font-weight: 900;
}

.content-desc {
  font-size: 14px;
  color: #476458;
}

// ACTIVITIES

.activity-list-wrap {
  display: grid;
  grid-template-columns: auto auto;
  margin-bottom: 30px;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    grid-template-columns: auto;
  }
}

.activity-item-block {
  margin: 5px;
  span {
    font-size: 16px;
  }
}
.activity-item-icon {
  font-size: 30px;
  padding: 10px;
  color: #79BC53 !important;
}

.activity-item-name {
  font-size: 12px;
  font-weight: bold;
  color: #476458;
}

</style>
