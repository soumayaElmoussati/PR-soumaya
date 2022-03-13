<template>
  <div class="services">
    <div class="block">
      <div class="image">
        <a>
          <img
            :src="information"
            alt="information" >
          <span v-if="offer.description">{{ offer.description }}</span>
        </a>
        <h3>{{ $t("bookingTiny.servicesAnnexes.title")[9].title }}</h3>
        <p class="unity">
          {{ offer.price / 100
          }}{{ $t("bookingTiny.servicesAnnexes.title")[9].currency }}
        </p>
      </div>
      <div class="compteur">
        <div class="buttons">
          <a
            class="moins"
            @click="moins()">
            <p>-</p>
          </a>
          <input
            v-model="numberNuitAnimal"
            type="number" >
          <a
            class="plus"
            @click="plus()">
            <p>+</p>
          </a>
        </div>
        <div class="details">
          <textarea
            id="panier"
            v-model="questions"
            :placeholder="$t('bookingTiny.servicesAnnexes.title')[9].details"
            name="panier"
            rows="5"
            cols="33"
            type="textarea"
            @input="updateValue()"
          />
        </div>
      </div>
      <div class="price">
        <p>{{ convert() }}€</p>
        <p>{{ $t("bookingTiny.paragraphs.for") }} {{ numberNuitAnimal * offer.unity }} {{ $t("bookingTiny.paragraphs.animals") }}</p>
      </div>
    </div>
  </div>
</template>

<script>
import information from '@/assets/img/servicesTiny/information.png'
export default {
  name: 'NuitsAnimaux',
  props: {
    offer: {
      type: [Array, Object],
      default: function () {
        return null
      }
    }
  },
  data () {
    return {
      information,
      numberNuitAnimal: 0,
      totalAnimaux: 0,
      questions: ''
    }
  },
  mounted () {
    this.convert()
  },
  methods: {
    plus () {
      this.numberNuitAnimal++
      this.convert()
      this.$emit('totalAnimaux', this.totalAnimaux)
      this.$emit('numberAnimaux', this.numberNuitAnimal)
    },
    moins () {
      if (this.numberNuitAnimal === 0) {
        this.numberNuitAnimal = 0
        this.$emit('totalAnimaux', this.totalAnimaux)
        this.$emit('numberAnimaux', this.numberNuitAnimal)
      } else {
        this.numberNuitAnimal--
        this.convert()
        this.$emit('totalAnimaux', this.totalAnimaux)
        this.$emit('numberAnimaux', this.numberNuitAnimal)
      }
    },
    convert () {
      return (this.totalAnimaux =
        (this.offer.price / 100) * (this.numberNuitAnimal * this.offer.unity))
    },
    updateValue () {
      this.$emit('questions', this.questions)
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.unity {
  background: rgba(108, 121, 118, 0.5);
  font-weight: bold !important;
}

.services {
  margin-bottom: 15%;
  .block {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    height: 170px;
    align-items: center;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: flex;
    }
    @media only screen and (max-width: $breakpoint-mobile-m) {
      display: flex;
      flex-direction: column;
    }
    .image {
      position: relative;
      width: 258px;
      height: 155px;
      margin: 0 auto;
      background-image: url("../../../assets/img/servicesTiny/animauxNuits.png");
      /* background-repeat: no-repeat;
          background-position: center; */
      background-size: cover;
      display: flex;
      align-items: center;
      flex-direction: column;
      justify-content: center;
      @media only screen and (max-width: $breakpoint-laptop-l) {
        width: 80%;
      }
      @media only screen and (max-width: $breakpoint-mobile-large) {
        width: 100%;
      }
      a {
        cursor: pointer;
        position: absolute;
        top: 5px;
        right: 5px;
      }
      a span {
        min-width: 300px;
        position: absolute;
        margin-top: 0;
        margin-right: -85px;
        color: white;
        background: rgba(71, 100, 88, 0.9);
        padding: 15px;
        border-radius: 3px;
        box-shadow: 0 0 2px rgba(71, 100, 88, 0.5);
        transform: scale(0) rotate(-12deg);
        transition: all 0.25s;
        opacity: 0;
      }
      a:hover span,
      a:focus span {
        transform: scale(1) rotate(0);
        opacity: 1;
      }
      h3 {
        margin: 0;
        padding: 0;
        text-align: center;
        background-color: #fadf7f;
        padding: 8px 15px;
        border-radius: 30px;
        color: $agri-white;
        width: 184px;
        font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
          Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
        font-weight: 400;
        font-size: 18px;
      }
      p {
        margin: 12px 0 0 0;
        padding: 0;
        font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
          Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
        color: $agri-white;
      }
    }
    .compteur {
      text-align: center;
      margin: 0 auto;
      align-items: center;
      display: flex;
      justify-content: center;
      flex-direction: column;
      width: 80%;
      @media only screen and (max-width: $breakpoint-mobile-large) {
        width: 100%;
      }
      .buttons {
        display: flex;
        justify-content: center;
        align-items: center;
        .moins {
          cursor: pointer;
          background-color: #fadf7f;
          border-radius: 50%;
          color: white;
          width: 35px;
          height: 35px;
          display: flex;
          justify-content: center;
          align-items: center;
          margin-right: 25px;
          p {
            font-size: 36px;
            font-weight: 700;
          }
        }
        input {
          background-color: $agri-white;
          border: 1px solid black;
          width: 37px;
          height: 22px;
          text-align: center;
        }
        .plus {
          cursor: pointer;
          background-color: #fadf7f;
          border-radius: 50%;
          color: white;
          width: 35px;
          height: 35px;
          display: flex;
          justify-content: center;
          align-items: center;
          margin-left: 25px;
          p {
            font-size: 36px;
            font-weight: 700;
          }
        }
      }
      .details {
        margin-top: 17px;
        width: 100%;
        margin: 0 auto;
        textarea {
          font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
            Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
          text-align: start;
          padding: 5px 20px;
          font-size: 16px;
          font-weight: 400;
          background-color: rgba(158, 158, 158, 0.1);
          border-radius: 30px;
          border: none;
          margin: 0;
          width: 100%;
          height: 85px;
          text-align: center !important;
          @media only screen and (max-width: $breakpoint-mobile-large) {
            padding: 0px;
            border-radius: 0px;
          }
        }
        ::placeholder {
          color: black;
        }
      }
    }
    .price {
      border-left: 1px solid black;
      display: flex;
      justify-content: center;
      flex-direction: column;
      height: 100%;
      @media only screen and (max-width: $breakpoint-tablet) {
        display: none;
      }
      // @media only screen and (max-width: $breakpoint-mobile-large) {
      //   display: grid;
      //   grid-template-columns: auto;
      // }
      p {
        font-size: 30px;
        font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
          Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
        font-weight: 700;
        margin: 0;
        padding: 0 0 0 55px;
        // @media only screen and (max-width: $breakpoint-mobile-large) {
        //   padding: 0px;
        // }
      }
    }
  }
}
</style>
