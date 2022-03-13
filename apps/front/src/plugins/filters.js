import currencyFilter from '@/filters/currency'
import Vue from 'vue'

Vue.filter('currency', currencyFilter.filter)
