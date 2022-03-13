// // import { cacheAdapterEnhancer, throttleAdapterEnhancer } from 'axios-extensions'
// // import LRUCache from "lru-cache"
// import Vue from 'vue'

// const ONE_HOUR = 1000 * 60 * 60
// const vueApp = new Vue()
// // const defaultCache = new LRUCache({ maxAge: ONE_HOUR })

// export default function ({ $axios, store, redirect, app }) {
//     // const defaults = $axios.defaults
//     // // https://github.com/kuitos/axios-extensions
//     // defaults.adapter = cacheAdapterEnhancer(
//     //     defaults.adapter,
//     //     false,
//     //     "useCache",
//     //     defaultCache
//     // );
//     // $axios.onError(error => {
//     //     if (error.response.status === 401) {
//     //         vueApp.$toasted.show('Access Token expiré, veuillez vous reconnecter', {
//     //             icon: "exclamation-triangle",
//     //             theme: "toasted-primary",
//     //             position: "bottom-right",
//     //             duration: 5000,
//     //             type: 'warning'
//     //         });
//     //         return redirect('/admin-login')
//     //     }
//     //     return Promise.reject(error);
//     // });

//     $axios.onRequest(() => {
//         store.dispatch('clearErrors');
//     });
// }
