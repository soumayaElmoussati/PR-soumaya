import Vue from 'vue'
import Router from 'vue-router'

import Home from '~/pages/index'
import Search from '~/pages/search'
import Homemap from '~/pages/homemap'

import OffersAll from '~/pages/offers_all'
import OffersBretagne from '~/pages/offers_bretagne'
import OffersAquitaine from '~/pages/offers_aquitaine'
import OffersNormandie from '~/pages/offers_normandie'
import OffersInsolit from '~/pages/offers_insolit'
import OffersHost from '~/pages/offers_host'
import OffersLodge from '~/pages/offers_lodge'
import OffersTinyHouse from '~/pages/offers_tiny'
import Offer from '~/pages/offer'
import OfferBooking from '~/pages/offer_booking'
import TinyBooking from '~/pages/tiny_booking.vue'
import TinyBookingPreview from '~/pages/tiny_booking_preview.vue'
import OfferBookingDone from '~/pages/offer_booking_done'

import NewOffer from '~/pages/new-offer/index'
import OfferIndex from '~/pages/new-offer/offer'
import Housing from '~/pages/new-offer/housing'
import Rules from '~/pages/new-offer/rules'
import Farm from '~/pages/new-offer/farm'
import Service from '~/pages/new-offer/service'
import Pictures from '~/pages/new-offer/pictures'
import Price from '~/pages/new-offer/price'
import Calendar from '~/pages/new-offer/calendar'
import Done from '~/pages/new-offer/done'

import EditOffer from '~/pages/edit-offer/index'
import EditOfferFarm from '~/pages/edit-offer/farm'
import EditOfferRules from '~/pages/edit-offer/rules'
import EditOfferHousing from '~/pages/edit-offer/housing'
import EditOfferPictures from '~/pages/edit-offer/pictures'
import EditOfferOffer from '~/pages/edit-offer/offer'
import EditOfferService from '~/pages/edit-offer/service'
import EditOfferPrice from '~/pages/edit-offer/price'
import EditOfferCalendar from '~/pages/edit-offer/calendar'
import EditOfferAnnexes from '~/pages/edit-offer/annexes'

import NewActivity from '~/pages/new-activity/index'
import ActivityIndex from '~/pages/new-activity/activity'
import ActivityRules from '~/pages/new-activity/rules'
import ActivityFarm from '~/pages/new-activity/farm'
import ActivityPictures from '~/pages/new-activity/pictures'
import ActivityPrice from '~/pages/new-activity/price'
import ActivityDone from '~/pages/new-activity/done'

import NewReview from '~/pages/new-review/index'
import PicturesReview from '~/pages/new-review/pictures'
import DoneReview from '~/pages/new-review/done'

import NewFarmerReview from '~/pages/new-farmer-review/index'
import DoneFarmerReview from '~/pages/new-farmer-review/done'

import ActivitiesAll from '~/pages/activities_all'
import Bretagne from '~/pages/bretagne'
import Activity from '~/pages/activity'
import ActivityBooking from '~/pages/activity_booking'
import ActivityBookingDone from '~/pages/activity_booking_done'

import EditActivity from '~/pages/edit-activity/index'
import EditActivityFarm from '~/pages/edit-activity/farm'
import EditActivityRules from '~/pages/edit-activity/rules'
import EditActivityPictures from '~/pages/edit-activity/pictures'
import EditActivityActivity from '~/pages/edit-activity/activity'
import EditActivityPrice from '~/pages/edit-activity/price'
import EditActivityCalendar from '~/pages/edit-activity/calendar'

import SignIn from '~/pages/auth/sign-in'
import SignInClient from '~/pages/auth/sign-in-client'

import PasswordForget from '~/pages/auth/password-forget'
import PasswordReset from '~/pages/auth/password-reset'

import ImpersonateUser from '~/pages/impersonate_user'

import DashboardOffers from '~/pages/dashboard/offers'
import DashboardActivities from '~/pages/dashboard/activities'
import DashboardBookings from '~/pages/dashboard/bookings'
import DashboardClientBookings from '~/pages/dashboard/client-bookings'
import DashboardClientActivityBookings from '~/pages/dashboard/client-activity-bookings'

import BecomeHost from '~/pages/become-host'
import BecomeClient from '~/pages/become-client'

import Terms from '~/pages/terms'
import About from '~/pages/about'
import Legal from '~/pages/legal'

import Hote from '~/pages/chambreHoteALaFerme'
import VacancesEnFamille from '~/pages/vacancesEnFamille'
import WeekEndFerme from '~/pages/weekEndFerme'
import InsoliteBretagne from '~/pages/insoliteBretagne'
import HebergementFerme from '~/pages/hebergementFerme'
import OriginalesEnFrance from '~/pages/originalesEnFrance'

import FarmerProfile from '~/pages/farmer'
import EditFarmer from '~/pages/edit-farmer/index'
import EditFarmerProfile from '~/pages/edit-farmer/profile'
import EditFarmerPicture from '~/pages/edit-farmer/picture'

import ChatRoom from '~/pages/chat-room'
import ChatRoomTiny from '~/pages/chat-room-tiny'
import ChatRoomFarmer from '~/pages/chat-room-farmer'
import ChatRoomActivity from '~/pages/chat-room-activity'
import Messenger from '~/pages/messenger'

import Booking from '~/pages/booking'
import BookingFarmer from '~/pages/booking_farmer'

import Blog from '~/pages/blog'
import Cadeaux from '~/pages/cadeaux'

import HomeTiny from '~/pages/home_tiny'
import TinyConcept from '~/pages/tiny_concept'
import Materiaux from '~/pages/tiny_materiaux'

// Glamping
import Glamping from '~/pages/glamping'

// Depenses
import Expenses from '~/pages/expenses'
import NewExpense from '~/pages/new-expense/index'

// seminaire
import CompanySeminar from '~/pages/company-seminar'
Vue.use(Router)

export function createRouter () {
  return new Router({
    mode: 'history',
    routes: [
      {
        name: 'Index',
        path: '/',
        component: Home
      },
      {
        name: 'Search',
        path: '/search',
        component: Search
      },
      {
        name: 'OffersBretagne',
        path: '/sejour-en-bretagne',
        component: OffersBretagne
      },
      {
        name: 'OffersAquitaine',
        path: '/sejour-en-nouvelle-aquitaine',
        component: OffersAquitaine
      },
      {
        name: 'OffersNormandie',
        path: '/sejour-en-normandie',
        component: OffersNormandie
      },
      {
        name: 'OffersInsolit',
        path: '/sejour-insolite',
        component: OffersInsolit
      },
      {
        name: 'OffersHost',
        path: '/sejour-en-chambre-d-hote',
        component: OffersHost
      },
      {
        name: 'OffersLodge',
        path: '/sejour-en-gite',
        component: OffersLodge
      },
      {
        name: 'OffersTinyHouse',
        path: '/sejour-en-tiny-house',
        component: OffersTinyHouse
      },
      {
        name: 'OffersAll',
        path: '/nos-offres',
        component: OffersAll
      },
      {
        name: 'Homemap',
        path: '/homemap',
        component: Homemap
      },
      {
        name: 'FarmerProfile',
        path: '/farmer/:id/:slug',
        component: FarmerProfile
      },
      {
        name: 'EditFarmer',
        path: '/edit-farmer/:id',
        component: EditFarmer,
        redirect: {
          name: 'EditFarmerProfile'
        },
        children: [
          {
            name: 'EditFarmerProfile',
            path: '/edit-farmer/:id/profile',
            component: EditFarmerProfile
          },
          {
            name: 'EditFarmerPicture',
            path: '/edit-farmer/:id/picture',
            component: EditFarmerPicture
          }
        ]
      },
      {
        name: 'ChatRoom',
        path: '/inbox/:id',
        component: ChatRoom
      },
      {
        name: 'ChatRoomTiny',
        path: '/inbox-tiny/:id',
        component: ChatRoomTiny
      },
      {
        name: 'ChatRoomFarmer',
        path: '/inbox-farmer/:id',
        component: ChatRoomFarmer
      },
      {
        name: 'ChatRoomActivity',
        path: '/inbox/activity/:id',
        component: ChatRoomActivity
      },
      {
        name: 'Messenger',
        path: '/messenger/',
        component: Messenger
      },
      {
        name: 'Booking',
        path: '/booking/:id',
        component: Booking
      },
      {
        name: 'BookingFarmer',
        path: '/booking-farmer/:id',
        component: BookingFarmer
      },
      {
        name: 'Offer',
        path: '/offer/:id/:slug/:domaine',
        component: Offer
      },
      {
        name: 'Expenses',
        path: '/offer/:id/:slug/:domaine/expenses',
        component: Expenses
      },
      {
        name: 'Activity',
        path: '/activity/:id/:slug',
        component: Activity
      },
      {
        name: 'ActivityBooking',
        path: '/activity/:id/:slug/booking/indemand',
        component: ActivityBooking
      },
      {
        name: 'ActivityBookingDone',
        path: '/activity/:id/:slug/booking/done',
        component: ActivityBookingDone
      },
      {
        name: 'OfferBooking',
        path: '/offer/:id/:slug/booking/indemand',
        component: OfferBooking
      },
      {
        name: 'TinyBooking',
        path: '/offer/:id/:bookingId/:slug/booking/tiny',
        component: TinyBooking
      },
      {
        name: 'TinyBookingPreview',
        path: '/offer/:id/booking/tiny/preview',
        component: TinyBookingPreview
      },
      {
        name: 'OfferBookingDone',
        path: '/offer/:id/:slug/booking/done',
        component: OfferBookingDone
      },
      {
        name: 'PasswordForget',
        path: '/auth/password-forget',
        component: PasswordForget
      },
      {
        name: 'PasswordReset',
        path: '/auth/password/reset',
        component: PasswordReset
      },
      {
        name: 'SignIn',
        path: '/auth/sign-in',
        component: SignIn
      },
      {
        name: 'SignInClient',
        path: '/auth/sign-in-client',
        component: SignInClient
      },
      {
        name: 'ImpersonateUser',
        path: '/impersonate-user',
        component: ImpersonateUser
      },
      {
        name: 'DashboardOffers',
        path: '/dashboard/offers',
        component: DashboardOffers
      },
      {
        name: 'DashboardActivities',
        path: '/dashboard/activities',
        component: DashboardActivities
      },
      {
        name: 'DashboardBookings',
        path: '/dashboard/bookings',
        component: DashboardBookings
      },
      {
        name: 'DashboardClientBookings',
        path: '/dashboard/client-bookings',
        component: DashboardClientBookings
      },
      {
        name: 'DashboardClientActivityBookings',
        path: '/dashboard/client-activity-bookings',
        component: DashboardClientActivityBookings
      },
      {
        name: 'BecomeHost',
        path: '/devenir-hote-agrivillage',
        component: BecomeHost
      },
      {
        name: 'BecomeClient',
        path: '/devenir-client',
        component: BecomeClient
      },
      {
        name: 'EditOffer',
        path: '/edit-offer/:id',
        component: EditOffer,
        redirect: {
          name: 'EditOfferFarm'
        },
        children: [
          {
            name: 'EditOfferFarm',
            path: '/edit-offer/:id/farm',
            component: EditOfferFarm
          },
          {
            name: 'EditOfferHousing',
            path: '/edit-offer/:id/housing',
            component: EditOfferHousing
          },
          {
            name: 'EditOfferRules',
            path: '/edit-offer/:id/rules',
            component: EditOfferRules
          },
          {
            name: 'EditOfferPictures',
            path: '/edit-offer/:id/pictures',
            component: EditOfferPictures
          },
          {
            name: 'EditOfferOffer',
            path: '/edit-offer/:id/offer',
            component: EditOfferOffer
          },
          {
            name: 'EditOfferService',
            path: '/edit-offer/:id/service',
            component: EditOfferService
          },
          {
            name: 'EditOfferPrice',
            path: '/edit-offer/:id/price',
            component: EditOfferPrice
          },
          {
            name: 'EditOfferCalendar',
            path: '/edit-offer/:id/calendar',
            component: EditOfferCalendar
          },
          {
            name: 'EditOfferAnnexes',
            path: '/edit-offer/:id/annexes',
            component: EditOfferAnnexes
          }
        ]
      },
      {
        name: 'NewReview',
        path: '/:booking/new-review',
        component: NewReview
      },
      {
        name: 'PicturesReview',
        path: '/new-review/pictures',
        component: PicturesReview
      },
      {
        name: 'DoneReview',
        path: '/new-review/done',
        component: DoneReview
      },
      {
        name: 'NewFarmerReview',
        path: '/:booking/new-farmer-review',
        component: NewFarmerReview
      },
      {
        name: 'DoneFarmerReview',
        path: '/new-farmer-review/done',
        component: DoneFarmerReview
      },
      {
        name: 'NewExpense',
        path: '/offer/:id/:slug/:domaine/new-expense',
        component: NewExpense
      },
      {
        name: 'NewOffer',
        path: '/new-offer',
        component: NewOffer
      },
      {
        name: 'OfferIndex',
        path: '/new-offer/offer',
        component: OfferIndex
      },
      {
        name: 'Housing',
        path: '/new-offer/housing',
        component: Housing
      },
      {
        name: 'Rules',
        path: '/new-offer/rules',
        component: Rules
      },
      {
        name: 'Farm',
        path: '/new-offer/farm',
        component: Farm
      },
      {
        name: 'Pictures',
        path: '/new-offer/pictures',
        component: Pictures
      },
      {
        name: 'Calendar',
        path: '/new-offer/calendar',
        component: Calendar
      },
      {
        name: 'Service',
        path: '/new-offer/service',
        component: Service
      },
      {
        name: 'Price',
        path: '/new-offer/price',
        component: Price
      },
      {
        name: 'Done',
        path: '/new-offer/done',
        component: Done
      },
      {
        name: 'NewActivity',
        path: '/new-activity',
        component: NewActivity
      },
      {
        name: 'ActivityIndex',
        path: '/new-activity/activity',
        component: ActivityIndex
      },
      {
        name: 'ActivityRules',
        path: '/new-activity/rules',
        component: ActivityRules
      },
      {
        name: 'ActivityFarm',
        path: '/new-activity/farm',
        component: ActivityFarm
      },
      {
        name: 'ActivityPictures',
        path: '/new-activity/pictures',
        component: ActivityPictures
      },
      {
        name: 'ActivityPrice',
        path: '/new-activity/price',
        component: ActivityPrice
      },
      {
        name: 'ActivityDone',
        path: '/new-activity/done',
        component: ActivityDone
      },
      {
        name: 'ActivitiesAll',
        path: '/activities-all',
        component: ActivitiesAll
      },
      {
        name: 'Bretagne',
        path: '/agriculteurs-de-bretagne',
        component: Bretagne
      },
      {
        name: 'EditActivity',
        path: '/edit-activity/:id',
        component: EditActivity,
        redirect: {
          name: 'EditActivityFarm'
        },
        children: [
          {
            name: 'EditActivityFarm',
            path: '/edit-activity/:id/farm',
            component: EditActivityFarm
          },
          {
            name: 'EditActivityRules',
            path: '/edit-activity/:id/rules',
            component: EditActivityRules
          },
          {
            name: 'EditActivityPictures',
            path: '/edit-activity/:id/pictures',
            component: EditActivityPictures
          },
          {
            name: 'EditActivityActivity',
            path: '/edit-activity/:id/activity',
            component: EditActivityActivity
          },
          {
            name: 'EditActivityPrice',
            path: '/edit-activity/:id/price',
            component: EditActivityPrice
          },
          {
            name: 'EditActivityCalendar',
            path: '/edit-activity/:id/calendar',
            component: EditActivityCalendar
          }
        ]
      },
      {
        name: 'Terms',
        path: '/conditions',
        component: Terms
      },
      {
        name: 'About',
        path: '/sejour-agritourisme',
        component: About
      },
      {
        name: 'Blog',
        path: '/blog',
        component: Blog
      },
      {
        name: 'Cadeaux',
        path: '/cadeaux',
        component: Cadeaux
      },
      {
        name: 'Legal',
        path: '/mentions-legales',
        component: Legal
      },
      {
        name: 'ChambreHoteALaFerme',
        path: '/chambre-hote',
        component: Hote
      },
      {
        name: 'VacancesEnFamille',
        path: '/vacances-en-famille-a-la-ferme',
        component: VacancesEnFamille
      },
      {
        name: 'WeekEndFerme',
        path: '/week-end-a-la-ferme',
        component: WeekEndFerme
      },
      {
        name: 'InsoliteBretagne',
        path: '/insolite-en-bretagne',
        component: InsoliteBretagne
      },
      {
        name: 'HebergementFerme',
        path: '/hebergement-a-la-ferme',
        component: HebergementFerme
      },
      {
        name: 'OriginalesEnFrance',
        path: '/vacances-originales-en-france',
        component: OriginalesEnFrance
      },
      {
        name: 'HomeTiny',
        path: '/tiny-house',
        component: HomeTiny
      },
      {
        name: 'TinyConcept',
        path: '/tiny-house-concept',
        component: TinyConcept
      },
      {
        name: 'Materiaux',
        path: '/tiny-house-materiaux',
        component: Materiaux
      },
      {
        name: 'CompanySeminar',
        path: '/seminaire-entreprise',
        component: CompanySeminar
      },
      {
        name: 'Glamping',
        path: '/glamping',
        component: Glamping
      }
    ],
    scrollBehavior () {
      return { x: 0, y: 0 }
    }
  })
}
