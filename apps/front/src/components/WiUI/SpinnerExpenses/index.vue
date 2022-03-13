<template>
  <!-- bouncing balls -->
  <div class="bouncer">
    <div />
    <div />
    <div />
    <div />
  </div>
</template>

<script>
export default {
  name: 'SpinnerExpenses'
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
/* bouncing balls */

.bouncer {
  display: flex;
  justify-content: space-around;
  align-items: flex-end;
  width: 100px;
  margin: 35px auto 0 auto;
  height: 100px;
}

.bouncer div {
  width: 20px;
  height: 20px;
  background-color: $agri-green;
  border-radius: 50%;
  animation: bouncer 0.5s cubic-bezier(0.19, 0.57, 0.3, 0.98) infinite alternate;
  /* use https://cubic-bezier.com/ to customize the curve */
}

.bouncer div:nth-child(2) {
  animation-delay: 0.1s;
  opacity: 0.8;
}

.bouncer div:nth-child(3) {
  animation-delay: 0.2s;
  opacity: 0.6;
}

.bouncer div:nth-child(4) {
  animation-delay: 0.3s;
  opacity: 0.4;
}

@keyframes bouncer {
  from {
    transform: translateY(0);
  }
  to {
    transform: translateY(-100px);
  }
}
</style>
