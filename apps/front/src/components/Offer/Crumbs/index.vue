<template>
  <div>
    <div class="link">
      <p>
        <span
          id="region"
          @click="$parent.submittedcard('region')"
        >
          {{ getOffer.address.region }}
        </span>
        >
        <span
          id="department"
          @click="$parent.submittedcard('department')"
        >
          {{ getOffer.address.department }}
        </span>
        >
        <span
          id="city"
          @click="$parent.submittedcard('city')"
        >
          {{ getOffer.address.city }}
        </span>
        >
        <span>
          <nuxt-link
            to=""
            class="link"
          >
            {{ getOffer.name }}
          </nuxt-link>
        </span>
      </p>
    </div>
  </div>
</template>
<script>
  import { mapGetters } from 'vuex'
export default {
  name: 'Crumbs',
  computed: {
    ...mapGetters([
      'getOffer'
    ])
  }
}
</script>
<style lang="scss" scoped>
.link {
text-decoration: none;
color: gray;
cursor: pointer;
}
</style>
