<template lang="pug">
header(ref="header")
  slot
</template>

<script lang="coffee">
import $on from './on.coffee'

export default {
components:{

}
setup:=>
  header = shallowRef()
  onMounted =>
    el = header.value
    {parentNode:p}=el
    while p.tagName!='HTML'
      if 'auto' == getComputedStyle(p).overflow
        break
      p = p.parentNode

    diff = 0
    top = 0

    {scrollTop} = p
    {clientHeight} = el
    el.style.top = initTop = -clientHeight+'px'

    show = 0
    $on p,{
      scroll:=>
        {scrollTop:top} = p

        d = top - scrollTop
        if d < 0
          if not show
            if diff > 0
              diff = 0
            diff += d
            if diff < - clientHeight and scrollTop > clientHeight
              show = 1
              el.style.top = 0
        else if d > 0
          if show
            if diff < 0
              diff = 0
            diff += d
            if diff > clientHeight or scrollTop < clientHeight
              show = 0
              el.style.top = initTop
        scrollTop = top
        return
    }
    return
  {
    header
  }

}
</script>

<style lang="stylus" scoped>
header
  transition top 0.5s
  position sticky
</style>


