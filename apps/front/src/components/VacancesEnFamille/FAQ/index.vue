<template>
  <div class="faqContent">
    <h3>F.A.Q</h3>
    <div class="line" />
    <div class="questions">
      <div class="title">
        <h4>{{ $t("vacancesEnFamille.questions.question1") }}</h4>
      </div>
      <button @click="question1 = !question1">
        <img
          :src="arrowDown"
          alt="" >
      </button>
    </div>
    <transition name="fade">
      <div v-if="question1">
        <p>
          {{ $t("vacancesEnFamille.questions.content1") }}
        </p>
      </div>
    </transition>
    <div class="questions">
      <div class="title">
        <h4>{{ $t("vacancesEnFamille.questions.question2") }}</h4>
      </div>
      <button @click="question2 = !question2">
        <img
          :src="arrowDown"
          alt="" >
      </button>
    </div>
    <transition name="fade">
      <div v-if="question2">
        <p>
          {{ $t("vacancesEnFamille.questions.content2.first") }}
          <br >
          <br >
          {{ $t("vacancesEnFamille.questions.content2.second") }}
          <br >
          <br >
          {{ $t("vacancesEnFamille.questions.content2.third") }}
        </p>
      </div>
    </transition>
    <div class="questions">
      <div class="title">
        <h4>{{ $t("vacancesEnFamille.questions.question3") }}</h4>
      </div>
      <button @click="question3 = !question3">
        <img
          :src="arrowDown"
          alt="" >
      </button>
    </div>
    <transition name="fade">
      <div v-if="question3">
        <p>
          {{ $t("vacancesEnFamille.questions.content3.first") }}
          <br >
          {{ $t("vacancesEnFamille.questions.content3.second") }}
          <br >
          {{ $t("vacancesEnFamille.questions.content3.third") }}
          <br >
          {{ $t("vacancesEnFamille.questions.content3.fourth") }}
        </p>
      </div>
    </transition>
    <div class="questions">
      <div class="title">
        <h4>{{ $t("vacancesEnFamille.questions.question4") }}</h4>
      </div>
      <button @click="question4 = !question4">
        <img
          :src="arrowDown"
          alt="" >
      </button>
    </div>
    <transition name="fade">
      <div v-if="question4">
        <p>
          {{ $t("vacancesEnFamille.questions.content4") }}
        </p>
      </div>
    </transition>
  </div>
</template>

<script>
import arrowDown from '@/assets/img/chambrehote/arrowdown.png'
export default {
  name: 'Faq',
  data () {
    return {
      arrowDown,
      question1: false,
      question2: false,
      question3: false,
      question4: false
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
* {
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}
h2,
h3,
h4,
p {
  margin: 0;
  padding: 0;
}
p {
  font-size: 14px;
}

.faqContent {
  margin: auto;
  width: 80%;
  margin-bottom: 4%;
  h3 {
    text-align: center;
    font-size: 30px;
  }
  .line {
    width: 20%;
    margin: 0 auto;
    color: $agri-green;
    border-bottom: 5px solid $agri-green;
  }
  .questions {
    background-color: rgba(194, 194, 194, 0.17);
    border-radius: 20px;
    padding: 20px;
    margin: 2% 0;
    display: flex;
    justify-content: space-between;
    @media only screen and (max-width: $breakpoint-mobile-m) {
      padding: 8px;
    }
    h4 {
      font-size: 20px;
      font-weight: 500;
      @media only screen and (max-width: $breakpoint-mobile-m) {
        font-size: 18px;
        text-align: center;
      }
    }
  }
  button {
    border: none;
    background-color: transparent;
    img {
      width: 50%
    }
  }
  .fade-enter-active,
  .fade-leave-active {
    transition: opacity 0.5s;
  }
  .fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
    opacity: 0;
  }
}
</style>
