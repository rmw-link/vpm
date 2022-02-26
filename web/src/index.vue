<template lang="pug">
component(:is="c" v-if="c")
ing(v-else)
</template>

<script lang="coffee">
import '~/styl/init.styl'
import {inc,dec} from '~/lib/Spin'
import ing from '~/lib/ing.vue'
import autofocus from '~/lib/autofocus.coffee'
import Init from '~/lib/init.coffee'
import route from '~/lib/route.coffee'

init = Init()

export default {
components:{
  ing
}
setup:=>
  c = shallowRef()
  route(c)

  page = import('~/page/main.vue').finally(dec)

  onMounted =>
    await init
    inc()
    c.value = (await page).default
    nextTick =>
      autofocus()
      return
    return


  {
    c
  }
}
</script>

<style lang="stylus" scoped></style>

