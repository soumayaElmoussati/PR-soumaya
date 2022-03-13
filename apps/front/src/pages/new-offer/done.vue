<template>
  <div class="done">
    <div class="wrap">
      <div class="side">
        <h1 class="title">
          {{ $t("offer.titles.save") }}
        </h1>

        <p class="body-1">
          {{ $t("offer.paragraphs.save")[0] }}
          <strong>{{ $t("offer.paragraphs.save")[1] }}</strong>
          {{ $t("offer.paragraphs.save")[2] }}
        </p>
        <p class="body-1">
          {{ $t("offer.paragraphs.modify") }}
        </p>
        <nuxt-link
          :to="{
            name: 'Index'
          }"
          class="btn btn-agri-yellow"
        >
          {{ $t("offer.buttons.back") }}

        </nuxt-link>
      </div>
      <div class="image">
        <img
          src="~/assets/img/auth/confirmation.svg"
          alt="confirmation"
          title="confirmation"
          width="300"
        >
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Done',
    middleware: 'auth'
  }
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

  .side {
    background-color:white;
    margin:0 auto;
    padding:30px;
    width:75%
  }

  .body-1 em {
    font-size:14px;
  }

  .housing-types__item label{
    font-size:13px;
  }

  span.wi-textarea__label__wordcount {
    font-size:12px;
  }

  .headline{
    padding-top:20px;
  }

  .wi-input__caption{
    font-size:14px!important;
  }

  .done{
    padding-top:40px
  }

  .done{
    padding-top: 32px;
    min-height: 70vh;

    .wrap{
      display: flex;
    }

    .side{
      width: 60%;
      margin-right: 16px;
    }

    .image{
      display: flex;
      justify-content: center;

      img{
        margin: 0 auto;
        align-self: center;
      }
    }
  }

  @media screen and (max-width: 600px) {

    .done{
      padding-top: 0px;
      min-height: 70vh;

      .side{
        width: 100%;
        margin-right: 0px;
      }

      .image{
        display: none;
      }
    }
  }
</style>
