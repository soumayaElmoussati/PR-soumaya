<template>
  <!-- <img
    v-lazy="getSrc"
    class="cloudinary"
  > -->
  <div
    :style="{ backgroundImage: 'url(' + getSrc + ')'}"
    class="cloudinary"
    @click="$parent.index = Number(itemkey)"
  />
</template>

<script>
  export default {
    name: 'Cloudinary',
    props: {
      publicId: {
        type: String,
        required: true
      },
      transformations: {
        type: Object,
        default: () => {}
      }
    },
    computed: {
      getTransformations () {
        const transformations = this.transformations || {}
        const transformationKeys = Object.keys(transformations)
        const trans = transformationKeys.map((key) => {
          return `${key}_${this.transformations[key]}`
        })

        return trans.join(',') + (trans.length > 0 ? '/' : '')
      },
      getSrc () {
        const cloudName = 'agrivillage'
        return `https://res.cloudinary.com/${cloudName}/image/upload/${this.getTransformations}${this.publicId}`
      }
    }
  }
</script>

<style lang="scss" scoped>
  .cloudinary{
    height: 100%;
    width: 100%;
    background-size: cover;
    background-position: center;
  }
</style>
