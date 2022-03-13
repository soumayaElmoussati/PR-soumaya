<template>
  <dialog
    ref="dialog"
    class="dialog">
    <div class="header">
      <span
        class="close"
        @click="$emit('close')">X</span>
      <div class="title">{{ $t("offer.infos.warning") }}</div>
    </div>

    <div class="content">{{ $t("offer.infos.save") }}</div>

    <div class="actions">
      <button
        class="btn btn-discover"
        @click="$emit('discard-changes')">{{ $t("offer.infos.no") }}</button>
      <button
        class="btn btn-discover"
        @click="$emit('save-changes')">{{ $t("offer.infos.yes") }}</button>
    </div>
  </dialog>
</template>

<script>
export default {
  props: {
    value: {
      type: Boolean,
      default: false
    }
  },
  watch: {
    value (val) {
      if (val) this.$refs.dialog.show()
      else this.$refs.dialog.close()
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.btn-discover {
  background-color: $agri-green !important;
  border-radius: 10px;
  color: white;
  padding: 5px 25px;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  font-size: 12px !important;
  margin: auto;
}

.header {
  height: 50px;
  display: grid;
  grid-template-columns: auto;
  justify-content: space-between;
  align-items: center;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}

.header > .close {
  font-weight: bold;
  cursor: pointer;
}

.content {
  padding: 20px;
  display: grid;
  place-items: center;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}

.actions {
  padding: 20px;
  display: grid;
  grid-auto-flow: column;
  justify-content: end;
  gap: 10px;
}

</style>
