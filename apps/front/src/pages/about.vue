<template>
  <div class="about">
    <div class="wrap">
      <h1 class="about-title">
        {{ $t("about.titles.stayPartner") }}
      </h1>
      <br>
      <img
        id="hero-about"
        src="@/assets/img/about/banner.png">
      <h2 class="headline">
        {{ $t("about.titles.about") }}
      </h2>
      <div class="text-box">
        <h3 class="body-1">
          {{ $t("about.titles.startUp")[0] }} <br>
          {{ $t("about.titles.startUp")[1] }}
        </h3>
      </div>

      <h2 class="headline">
        {{ $t("about.titles.concept") }}
      </h2>

      <div class="text-box">

        <p class="body-1">
          {{ $t("about.paragraphs.concept")[0] }} <br>
          {{ $t("about.paragraphs.concept")[1] }}
        </p>
      </div>

      <h2 class="headline">
        {{ $t("about.titles.mission") }}
      </h2>

      <div class="text-box">

        <p class="body-1">
          {{ $t("about.paragraphs.mission")[0] }} <br>
          {{ $t("about.paragraphs.mission")[1] }} <br>
          {{ $t("about.paragraphs.mission")[2] }} <br>
          {{ $t("about.paragraphs.mission")[3] }} <br>
        </p>
      </div>

      <h2 class="headline">
        {{ $t("about.titles.difference") }}
      </h2>

      <div class="text-box">

        <h3 class="body-1">{{ $t("about.titles.french") }}</h3>

        <p class="body-1">
          {{ $t("about.paragraphs.agriculture")[0] }} <br>
          {{ $t("about.paragraphs.agriculture")[1] }} <br>
          {{ $t("about.paragraphs.agriculture")[2] }} <br>
          {{ $t("about.paragraphs.agriculture")[3] }} <br>
          {{ $t("about.paragraphs.agriculture")[4] }} <br>
          {{ $t("about.paragraphs.agriculture")[5] }} <br>
          {{ $t("about.paragraphs.agriculture")[6] }} <br>
          {{ $t("about.paragraphs.agriculture")[7] }} <br>
          {{ $t("about.paragraphs.agriculture")[8] }} <br>
          {{ $t("about.paragraphs.agriculture")[9] }}
        </p>

        <h3 class="body-1">{{ $t("about.titles.land") }}</h3>

        <p class="body-1">
          {{ $t("about.paragraphs.france") }} <br>
          {{ $t("about.paragraphs.passion") }}
        </p>

        <h3 class="body-1">{{ $t("about.titles.adaptation") }}</h3>

        <p class="body-1">
          {{ $t("about.paragraphs.work") }} <br>
          {{ $t("about.paragraphs.analyze") }} <br>
          {{ $t("about.paragraphs.assets") }} <br>
          <i>{{ $t("about.paragraphs.quote")[0] }}</i>
          {{ $t("about.paragraphs.quote")[1] }}
        </p>

        <h3 class="body-1">{{ $t("about.titles.simplicity") }}</h3>

        <p class="body-1">
          {{ $t("about.paragraphs.simplicity") }} <br>
          {{ $t("about.paragraphs.platform") }} <br>
          {{ $t("about.paragraphs.facility") }} <br>
          {{ $t("about.paragraphs.information") }}
        </p>

        <h3 class="body-1">{{ $t("about.titles.communication") }}</h3>

        <p class="body-1">
          {{ $t("about.paragraphs.love") }}<br>
          {{ $t("about.paragraphs.socialMedia") }} <br>
          {{ $t("about.paragraphs.cultivate") }} <br>
          {{ $t("about.paragraphs.interact") }}
        </p>

        <h3 class="body-1">{{ $t("about.titles.fun") }}</h3>

        <p class="body-1">
          {{ $t("about.paragraphs.mind") }} <br>
          {{ $t("about.paragraphs.enjoy") }} <br>
          {{ $t("about.paragraphs.result") }}
        </p>

        <h3 class="body-1">{{ $t("about.titles.work") }}</h3>

        <p class="body-1">
          {{ $t("about.paragraphs.connection") }} <br>
          {{ $t("about.paragraphs.entreprise") }} <br>
          {{ $t("about.paragraphs.power") }}
        </p>

        <h3 class="body-1">{{ $t("about.titles.date") }}</h3>

        <p class="body-1">
          {{ $t("about.paragraphs.sept") }} <br>
          {{ $t("about.paragraphs.october") }} <br>
          {{ $t("about.paragraphs.january") }} <br>
          {{ $t("about.paragraphs.march") }} <br>
          {{ $t("about.paragraphs.july") }} <a
            href="http://www.agriculteurs-de-bretagne.fr/actualites.html"
            target="_blank">{{ $t("about.paragraphs.julyLink") }}</a>
        </p>

      </div>

      <br>
      <h4 class="catchline-newsletter">
        {{ $t("about.titles.code") }}
      </h4>
      <!-- Begin Mailchimp Signup Form -->
      <link
        href="//cdn-images.mailchimp.com/embedcode/horizontal-slim-10_7.css"
        rel="stylesheet"
        type="text/css">
      <div
        id="mc_embed_signup">
        <form
          id="mc-embedded-subscribe-form"
          action="https://agrivillage.us20.list-manage.com/subscribe/post?u=9d4d8b8f930e25ea615effb83&amp;id=0dda707543"
          method="post"
          name="mc-embedded-subscribe-form"
          class="validate"
          target="_blank"
          novalidate>
          <div
            id="mc_embed_signup_scroll">
            <input
              id="mce-EMAIL"
              :placeholder="$t('about.placeholder.email')"
              type="email"
              value=""
              name="EMAIL"
              class="email"
              required>
            <div
              class="clear">
              <input
                id="mc-embedded-subscribe"
                type="submit"
                value="S'abonner"
                name="S'abonner"
                class="button">
            </div>
          </div>
        </form>
      </div>

      <!--End mc_embed_signup--></div>
  </div>
</template>

<script>
  export default {
    name: 'APropos',
    head () {
      return {
        title: 'Qui sommes-nous ? - AgriVillage',
        meta: [
          {
            hid: 'description',
            name: 'description',
            content: 'AgriVillage est portée par un jeune breton qui souhaite faire partager sa passion pour l\'agriculture à travers des séjours à la ferme.'
          }
        ]
      }
    }
  }
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
@import "@/assets/scss/_mixins.scss";

  .wrap {
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  }

  .about-title {
    margin-top: 5vw;
    color: $agri-green;
    font-weight: bold;
  }

  .catchline-newsletter {
    font-size: 12px;
    color: $agri-green;
    font-weight: bold;
    text-align: center;
  }

  .catchline {
    // font-size: 12px;
    color: $agri-green;
    font-weight: bold;
    text-align: center;
    padding: 20px;
  }

  .about{

  }

  .about .wrap {
    background-color:white;
    @media only screen and (max-width: 768px) {
      padding: 20px;
    }
  }

  .text-box {
    box-shadow: 1px 1px 12px #555;
    border-radius: 0px 25px 25px 25px;
  }

  .about .body-1{
    color: $agri-green;
    padding: 15px;
  }

  .about .headline {
    color: $agri-green;
    font-weight: bold;
  }

  #hero-about{
    width: 100%;
    box-shadow: 1px 1px 12px #555;
  }

  #mc_embed_signup{
    clear:left;
    font-size:14px;
    width:100%;
  }

  #mc_embed_signup form[data-v-3836ae43]{
    text-align: right;
  }

  #mc-embedded-subscribe-form input[type=checkbox]{
    display: inline;
    width: auto;
    margin-right: 10px;
  }

  #mc_embed_signup input.email{
    width: 200px;
    border-radius: 10px;
    border: 1px solid $agri-green ;
    font-size: 13px;
    color: $agri-green !important;
  }

  #mc_embed_signup .button{
      background-color: $agri-yellow;
      color: black;
      border-radius: 50px;
      box-shadow: 1px 1px 12px #555;
      margin-left: 15px;
      @media only screen and (max-width: 768px) {
        width: 120px;
        margin-top: 10px;
        margin-left: 0px;
      }
  }

  #mc_embed_signup .button:hover{
    background-color: $agri-yellow;
    color:white;
    border: 1px solid white;
  }

</style>
