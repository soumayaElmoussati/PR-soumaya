export default async function impersonate ({ route, $auth, redirect }) {
  const { 'access-token': accessToken, client, uid } = route.query

  if (accessToken && client && uid) {
    $auth.strategies.local.client = client
    $auth.strategies.local.uid = uid
    $auth.strategies.local.token.set(accessToken)

    $auth.strategies.local.updateStorage()
    $auth.strategies.local.updateInterceptor()

    try {
      await $auth.fetchUser()
    } catch (e) {}
  }

  return redirect('/')
}
