<template>

  <div class="client-popup">

    <a
      href="#"
      @click="showModal">{{ $t('offer.buttons.contactAgri') }}</a>

    <modal
      v-show="isModalVisible"
      @closeModal="closeModal"
    />
  </div>

</template>

<script>
import Modal from '@/components/Modal.vue'

export default {
  name: 'OfferModal',
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

  .client-popup {
    text-align: center;
  }

  .modal-backdrop {
    // position: s
    width: auto;
    z-index: 10000!important;
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
      top: 2vh;
    }
    @media only screen and (max-width: $breakpoint-mobile-s) {
      top: 30vh;
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
      padding: 0px 0px;
    }
  }
</style>
