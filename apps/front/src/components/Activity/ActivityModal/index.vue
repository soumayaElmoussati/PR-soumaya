<template>

  <div class="client-popup">

    <button
      type="button"
      class="btn contact-btn"
      @click="showModal"
    >
      {{ $t("activity.buttons.contactAgri") }}
    </button>

    <button
      type="button"
      class="btn popup-btn"
      @click="showModal"
    >
      {{ $t("activity.buttons.request") }}
    </button>

    <modal
      v-show="isModalVisible"
      @closeModal="closeModal"
    />
  </div>

</template>

<script>
import Modal from '@/components/Modal.vue'

export default {
  name: 'ActivityModal',
  components: {
    Modal
  },
  data () {
    return {
      isModalVisible: false
    }
  },
  methods: {
    showModal () {
      this.isModalVisible = true
    },
    closeModal (value) {
      this.isModalVisible = value
    }
  }
}
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";
  @import "@/assets/scss/_mixins.scss";

  .modal-backdrop {
    position: fixed;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    z-index: 100;
    background-color: rgba(0, 0, 0, 0.3);
    display: -webkit-box;
    display: flex;
    -webkit-box-pack: center;
    justify-content: center;
    -webkit-box-align: center;
    align-items: center;
    @media only screen and (max-width: $breakpoint-tablet) {
      top: 1vh;
    }
  }

  .contact-btn {
    margin: auto;
    background-color: $agri-green;
    color: white;
    padding: 0px 10px;
    border-radius: 50px;
    box-shadow: 1px 1px 12px #555;
    margin-top: 5px;
    margin-bottom: 10px;
    font-size: 12px;

    @media only screen and (max-width: $breakpoint-tablet) {
      width: 100%;
      padding: 0px 0px;
    }
  }

  .popup-btn {
    margin: auto;
    background-color: #EFCE4A;
    color: black;
    padding: 5px 20px;
    border-radius: 50px;
    box-shadow: 1px 1px 12px #555;
    margin-top: 5px;

    @media only screen and (max-width: $breakpoint-tablet) {
      width: 100%;
      padding: 20px 20px;
    }
  }
</style>
