<template>
  <div class="content">
    <h3>{{ $t("chambreHote.sejourner.title") }}</h3>
    <div class="card">
      <img
        src="@/assets/img/chambrehote/card1.jpg"
        alt="" >
      <div class="content-card">
        <div class="title">
          <h4>{{ $t("chambreHote.sejourner.card1.title") }}</h4>
        </div>
        <div class="line" />
        <div class="text">
          <p>{{ $t("chambreHote.sejourner.card1.content1") }}</p>
          <br >
          <p>{{ $t("chambreHote.sejourner.card1.content2") }}</p>
        </div>
      </div>
    </div>
    <div class="card">
      <div class="content-card">
        <div class="title">
          <h4>{{ $t("chambreHote.sejourner.card1.title") }}</h4>
        </div>
        <div class="line" />
        <div class="text">
          <p>{{ $t("chambreHote.sejourner.card1.content1") }}</p>
          <br >
          <p>{{ $t("chambreHote.sejourner.card1.content2") }}</p>
        </div>
      </div>
      <img
        src="@/assets/img/chambrehote/card2.jpg"
        alt="" >
    </div>
    <div class="activities">
      <div class="title">
        <h3>{{ $t("chambreHote.activities.title") }}</h3>
      </div>
      <div class="cards">
        <div class="cardAct">
          <img
            src="@/assets/img/chambrehote/Group1.jpg"
            alt="" >
          <p>{{ $t("chambreHote.activities.card1Content") }}</p>
        </div>
        <div class="cardAct">
          <img
            src="@/assets/img/chambrehote/Group2.jpg"
            alt="" >
          <p>{{ $t("chambreHote.activities.card2Content") }}</p>
        </div>
        <div class="cardAct">
          <img
            src="@/assets/img/chambrehote/Group3.jpg"
            alt="" >
          <p>{{ $t("chambreHote.activities.card3Content") }}</p>
        </div>
        <div class="cardAct">
          <img
            src="@/assets/img/chambrehote/Group4.jpg"
            alt="" >
          <p>{{ $t("chambreHote.activities.card4Content") }}</p>
        </div>
      </div>
    </div>
    <div class="readMore">
      <div class="lineup" />
      <div class="contentRead">
        <p>
          {{ $t("chambreHote.paragraphs.guestHouse") }}
        </p>
        <br >
        <p>
          {{ $t("chambreHote.paragraphs.explication") }}
        </p>
        <a
          @click="toggleRead()"
        ><p>{{ $t("chambreHote.readMore.button") }}</p></a
        >
        <transition name="fade">
          <div
            v-if="readMore"
            class="hideContent">
            <div class="title">
              <h3>
                {{ $t("chambreHote.readMore.title1") }}
              </h3>
              <p>
                {{ $t("chambreHote.paragraphs.vacancy") }}
              </p>
              <br >
              <p>
                {{ $t("chambreHote.paragraphs.stayFarm") }}
              </p>
              <br >
              <p>
                {{ $t("chambreHote.paragraphs.prepared") }}
              </p>
              <br >
              <p>
                {{ $t("chambreHote.paragraphs.stopWorked") }}
              </p>
              <br >
              <p>
                {{ $t("chambreHote.paragraphs.discovery") }}
              </p>
              <br >
              <p>
                {{ $t("chambreHote.paragraphs.relax") }}
              </p>
              <h3>
                {{ $t("chambreHote.readMore.title2") }}
              </h3>
              <p>
                {{ $t("chambreHote.paragraphs.criterion") }}
              </p>
              <br >
              <span>
                {{ $t("chambreHote.paragraphs.distance") }}
              </span>
              <br >
              <p>
                {{ $t("chambreHote.paragraphs.changing") }}
              </p>
              <br >
              <p>
                {{ $t("chambreHote.paragraphs.located") }}
              </p>
              <br >
              <p>
                {{ $t("chambreHote.paragraphs.parcours") }}
              </p>
              <br >
              <span>{{ $t("chambreHote.paragraphs.unique") }}</span>
              <br >
              <p>
                {{ $t("chambreHote.paragraphs.work") }}
              </p>
              <br >
              <p>
                {{ $t("chambreHote.paragraphs.activities") }}
              </p>
              <br >
              <p>
                {{ $t("chambreHote.paragraphs.opportunity") }}
              </p>
              <br >
              <span>{{ $t("chambreHote.paragraphs.farmImage") }} </span>
              <br >
              <p>
                {{ $t("chambreHote.paragraphs.rather") }}
              </p>
              <br >
              <p>
                {{ $t("chambreHote.paragraphs.many") }}
              </p>
              <br >
              <h3>{{ $t("chambreHote.readMore.title3") }}</h3>
              <br >
              <p>
                {{ $t("chambreHote.paragraphs.style") }}
              </p>
              <br >
              <span>
                {{ $t("chambreHote.paragraphs.activitiesDiscovery") }}
              </span>
              <p>
                {{ $t("chambreHote.paragraphs.reservation") }}
              </p>
              <br >
              <p>
                {{ $t("chambreHote.paragraphs.change") }}
              </p>
              <br >
              <span>{{ $t("chambreHote.paragraphs.activitiesAnnex") }} </span>
              <p>
                {{ $t("chambreHote.paragraphs.proposition") }}
              </p>
              <br >
              <p>
                {{ $t("chambreHote.paragraphs.listed") }}
              </p>
              <br >
              <span>{{ $t("chambreHote.paragraphs.village") }}</span>
              <p>
                {{ $t("chambreHote.paragraphs.goTo") }}
              </p>
              <br >
              <p>
                {{ $t("chambreHote.paragraphs.franceDiscovery") }}
              </p>
            </div>
          </div>
        </transition>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Sejourner',
  data () {
    return {
      readMore: false
    }
  },
  methods: {
    toggleRead () {
      this.readMore = !this.readMore
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
h1,
h2,
h3,
p,
h4 {
  margin: 0;
  padding: 0;
}

.content {
  min-height: 2000px;
  h3 {
    color: black;
    text-align: center;
    font-size: 48px;
    font-weight: 500;
    margin: 5% 0;
  }
  .card {
    width: 85%;
    height: 470px;
    margin: 0 auto;
    display: flex;
    background-color: $agri-beige;
    margin-bottom: 5%;
    img {
      width: 637px;
    }
    .content-card {
      padding: 2% 5% 5% 5%;
      @media only screen and (max-width: 1381px) {
        padding: 2%;
      }
      display: flex;
      flex-direction: column;
      width: 100%;
      .title {
        text-align: center;
        h4 {
          font-size: 30px;
          font-weight: 400;
        }
      }
      .line {
        text-align: start;
        border-bottom: $agri-green 8px solid;
        align-items: flex-start;
        width: 30%;
        margin: 50px 0;
      }
    }
  }
  .activities {
    .cards {
      display: grid;
      justify-content: center;
      grid-template-columns: 280px 280px 280px 280px;
      grid-template-rows: 411px;
      grid-gap: 75px;
      padding: 0 5%;
      margin-top: 11%;
      text-align: center;
      .cardAct {
        position: relative;
        background-color: $agri-green;
        display: flex;
        justify-content: center;
        align-items: center;
        img {
          position: absolute;
          right: 35px;
          top: -110px;
          width: 200px;
          height: 200px;
        }
        p {
          padding: 0 2%;
          font-size: 25px;
          font-weight: 500;
        }
      }
    }
  }
  .readMore {
    .lineup {
      width: 50%;
      border-bottom: 5px $agri-green solid;
      margin: 5% auto;
    }
    .contentRead {
      width: 70%;
      margin: 5% auto;
      p {
        font-size: 25px;
        font-weight: 500;
      }
      a {
        text-decoration: none;
        color: $agri-green;
        font-size: 25px;
        text-decoration-line: underline;
        margin: 2% 0;
      }
    }
    .fade-enter-active,
    .fade-leave-active {
      transition: opacity 0.5s;
    }
    .fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
      opacity: 0;
    }
    .hideContent {
      .title {
        h3 {
          font-size: 40px;
          text-align: left;
          width: 75%;
          margin: 2% 0;
        }
        p {
          font-size: 25px;
        }
        span {
          font-weight: 800;
        }
      }
    }
  }
}
</style>
