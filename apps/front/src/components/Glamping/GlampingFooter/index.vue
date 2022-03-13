<template>
  <div class="container">
    <div class="title-icon">
      {{ $t("tinyhouse.footer.title") }}
      <img
        src="@/assets/img/logo/logo_vertical_noir 1.png"
        class="logo"
        alt="auth"
      >
    </div>
    <div class="schema_deskt">
      <img
        src="@/assets/img/homeTiny/block_agri.png"
        alt="comment ça fonctionne?"
      >
    </div>
    <div class="schema-mobile">
      <img
        src="@/assets/img/homeTiny/footer_mobile.png"
        alt="comment ça fonctionne?"
      >
    </div>
    <a
      class="typeform-share button"
      href="https://form.typeform.com/to/CruG8J?typeform-medium=embed-snippet"
      data-mode="popup"
      data-size="70"
      target="_blank"
    >{{ $t("tinyhouse.footer.button") }}</a
    >
    <script type="application/javascript"> (function() { var qs,js,q,s,d=document, gi=d.getElementById, ce=d.createElement, gt=d.getElementsByTagName, id='typef_orm_share', b='https://embed.typeform.com/'; if(!gi.call(d,id)){ js=ce.call(d,'script'); js.id=id; js.src=b+'embed.js'; q=gt.call(d,'script')[0]; q.parentNode.insertBefore(js,q) } })() </script>
    <div class="garanties">
      <div class="title">
        {{ $t("tinyhouse.footer.garanties.title") }}
      </div>
      <div class="cards">
        <div class="card">
          <img
            src="@/assets/img/homeTiny/img_remplace.png"
            alt="image" >
          <div class="content">
            <p class="title">
              {{ $t("tinyhouse.footer.garanties.cards")[0].title }}
            </p>
            <div class="text">
              {{ $t("tinyhouse.footer.garanties.cards")[0].content }}
            </div>
          </div>
        </div>
        <div class="card">
          <img
            src="@/assets/img/homeTiny/img_remplace.png"
            alt="image" >
          <div class="content">
            <p class="title">
              {{ $t("tinyhouse.footer.garanties.cards")[1].title }}
            </p>
            <div class="text">
              {{ $t("tinyhouse.footer.garanties.cards")[1].content }}
            </div>
          </div>
        </div>
        <div class="card">
          <img
            src="@/assets/img/homeTiny/img_remplace.png"
            alt="image" >
          <div class="content">
            <p class="title">
              {{ $t("tinyhouse.footer.garanties.cards")[2].title }}
            </p>
            <div class="text">
              {{ $t("tinyhouse.footer.garanties.cards")[2].content }}
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="solution">
      <div class="title">
        {{ $t("tinyhouse.footer.solution.title") }}
      </div>
      <div class="lists">
        <ul>
          <li
            v-for="list in $t('tinyhouse.footer.solution.list')"
            id="desktop-list"
            :key="list"
          >
            {{ list }}
          </li>
          <li
            v-for="list in $t('tinyhouse.footer.solution.list').slice(0, 22)"
            id="mobile-list"
            :key="list"
          >
            {{ list }}
          </li>
        </ul>
        <ul>
          <li
            v-for="list in $t('tinyhouse.footer.solution.list2')"
            id="desktop-list2"
            :key="list"
          >
            {{ list }}
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'GlampingFooter'
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
* {
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}
.container {
  height: 1600px;
  background-color: rgba(210, 204, 184, 0.18);
  padding: 50px;
  @media only screen and (max-width: $breakpoint-tablet) {
    padding: 0;
    height: 2200px;
  }
  .title-icon {
    display: flex;
    justify-content: space-between;
    color: $agri-green;
    font-weight: 900;
    font-size: 22px;
    line-height: 26px;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: none;
    }
  }
  .schema_deskt {
    display: flex;
    justify-content: center;
    margin-top: 25px;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: none;
    }
  }
  .schema-mobile {
    display: none;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: block;
    }
    img {
      @media only screen and (max-width: $breakpoint-tablet) {
        margin: 35px 0;
      }
    }
  }
  a {
    text-decoration: none;
    margin: 0 auto;
    text-align: center;
    align-self: center;
    display: flex;
    justify-content: center;
    margin-top: 70px;
    width: 245px;
    padding: 8px 62px;
    border-radius: 12px;
    background-color: transparent !important;
    color: $agri-green;
    border: 1px solid $agri-green;
    font-size: 18px;
    font-weight: 400;
    font-style: italic;
  }
  .garanties {
    margin-top: 60px;
    .title {
      font-size: 22px;
      font-weight: 900;
      color: $agri-green;
    }
    .cards {
      display: grid;
      grid-template-columns: 1fr 1fr 1fr;
      margin-top: 45px;
      @media only screen and (max-width: $breakpoint-tablet) {
        grid-template-columns: 1fr;
      }
      .card {
        display: flex;
        @media only screen and (max-width: $breakpoint-tablet) {
          margin-top: 25px;
          padding: 0 12px;
        }
        .content {
          width: 178px;
          margin-left: 15px;
          .title {
            color: $agri-green;
            font-size: 18px;
            font-weight: 900;
          }
          .text {
            color: $agri-green;
            font-weight: 500;
            font-size: 14px;
            margin-top: 15px;
          }
        }
      }
    }
  }
  .solution {
    margin-top: 150px;
    @media only screen and (max-width: $breakpoint-tablet) {
      margin-top: 50px;
      padding-left: 25px;
    }
    .title {
      font-weight: 900;
      color: $agri-green;
      font-size: 22px;
      line-height: 26px;
    }
    .lists {
      display: flex;
      #desktop-list {
        display: block;
        @media only screen and (max-width: $breakpoint-tablet) {
          display: none;
        }
      }
      #mobile-list {
        display: none;
        @media only screen and (max-width: $breakpoint-tablet) {
          display: block;
        }
      }
      #desktop-list2 {
        display: block;
        @media only screen and (max-width: $breakpoint-tablet) {
          display: none;
        }
      }
      ul {
        line-height: 16.5px;
        li {
          list-style: none;
          color: $agri-green;
          font-weight: 500;
          font-size: 14px;
          line-height: 16.5px;
        }
      }
    }
  }
}
</style>
