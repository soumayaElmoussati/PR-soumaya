<template>
  <div class="offers">

    <div class="wrap">

      <div class="dashboard__lists">

        <div class="dashboard__lists__offers">
          <div class="navigation">
            <h2 class="offers-title">
              {{ $t('dashboard.activities.my_activities') }}
            </h2>
            <div class="add-offer">
              <nuxt-link
                :to="{
                  name: 'NewActivity'
                }"
                class="btn btn-agri"

              >
                {{ $t('dashboard.activities.add') }}
              </nuxt-link>
            </div>
          </div>
          <div
            v-if="!$wait.is('fetching offers')"
            class="dashboard__lists__offers__items"
          >

            <div
              v-if="activities.length"
              class="items"
            >

              <activity-card-private
                v-for="(activity, k) in activities"
                :key="k"
                :activity="activity"
                :id="activity.id"
              />

            </div>
          </div>
          <div
            v-else
          >
            {{ $t('dashboard.activities.loading') }}
          </div>
        </div>

      </div>

    </div>

  </div>

</template>

<script>
  import ActivityCardPrivate from '@/components/ActivitiesList/_subs/ActivityCardPrivate'

  export default {
    name: 'Activities',
    middleware: 'auth',
    components: {
      ActivityCardPrivate
    },
    head () {
      return {
        title: 'Mes activités'
      }
    },
    data () {
      return {
        activities: []
      }
    },
    created () {
      this.$parent.$parent.expl = false
    },
    mounted () {
      if (this.$auth.loggedIn) {
        this.$wait.start('fetching activities')
        this.$axios.$get(`/farmers/${this.$auth.user.farmer.id}/activities`)
          .then(res => {
            this.activities = res.activities
          })
          .finally(() => {
            this.$wait.end('fetching activities')
          })
      }
    }
  }
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.offers-title {
  font-size: 26px;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  color: $agri-green;
  font-weight: bold;
}

.infos-secondary {
  display: grid;
  grid-template-columns: auto auto;
}

.calendar-link {
  text-align: right;
}

.navigation {
  display: grid;
  grid-template-columns: 20% 20%;
  grid-column-gap: 55%;
  margin-bottom: 10px;

  .add-offer {
    width: 100%;
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 100%;
      margin-bottom: 10vh;
    }

  }

  @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: 1fr;
  }

}
.offers{
  padding-top: 32px;
  min-height: 440px;
}

.dashboard{
  padding-top: 32px;
  min-height: 440px;
  @media only screen and (max-width: $breakpoint-tablet) {
    padding: 30px !important;
  }

  &__lists{
    margin-bottom: 30px;

    .items{
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      grid-gap: 16px;

      @media only screen and (max-width: $breakpoint-tablet) {
        grid-template-columns: 50% 50%;
      }
      @media only screen and (max-width: $breakpoint-mobile-m) {
        grid-template-columns: 100%;
      }
    }

  }
}
</style>
