<template lang="pug">
main.scroll(ref="main")
  aside(@pointerdown="click" ref="aside" v-if="turn")
    i(@pointerdown="down" ref="si")
  div
    .bar(ref="wrap")
      slot
</template>


<script lang="coffee">
import $on from '~/lib/on.coffee'
import _on from '~/lib/_on.coffee'

Scroll = (elem) =>
  runing = 0
  {requestAnimationFrame, cancelAnimationFrame} = window
  (to, duration=300)=>
    cancelAnimationFrame runing
    scrollCount = 0
    cosParameter = (elem.scrollTop - to) / 2
    toCos = to+cosParameter
    oldTimestamp = 0
    step = (newTimestamp) ->
      if oldTimestamp
        # if duration is 0 scrollCount will be Infinity
        scrollCount += Math.PI * (newTimestamp - oldTimestamp) / duration
        if scrollCount >= Math.PI
          elem.scrollTop = to
          return
        elem.scrollTop = toCos + cosParameter * Math.cos(scrollCount)
      oldTimestamp = newTimestamp
      runing = requestAnimationFrame step
      return

    if elem.scrollTop == to
      return
    runing = requestAnimationFrame step
    return

SCROLL_CLS = "scroll"
HTML = document.documentElement
export default {
setup:=>
  main = shallowRef()
  wrap = shallowRef()
  si = shallowRef()
  aside = shallowRef()
  scrollTo = undefined
  turn = ref 0

  _pointerunbind = undefined
  pointerunbind = =>
    for i from [HTML, aside.value]
      i?.classList.remove(SCROLL_CLS)
    _pointerunbind?()
    _pointerunbind = undefined
    return

  timer = undefined

  onUnmounted pointerunbind

  onMounted =>
    mv = main.value
    wv = wrap.value
    scrollTo = Scroll mv
    scroll = =>
      if not turn.value
        return
      {clientHeight,scrollHeight,scrollTop} = mv
      height = Math.max(parseInt(clientHeight*clientHeight/scrollHeight)-4,48)
      iv = si.value
      av = aside.value
      av.style.opacity = 1
      top = parseInt(scrollTop/(scrollHeight-clientHeight)*(clientHeight-4-height))

      Object.assign(
        iv.style
        {
          height : height+"px"
          top:top+"px"
        }
      )
      clearTimeout timer
      timer = setTimeout(
        =>
          av.style.opacity = 0
        1000
      )
      return
    resize = =>
      {clientHeight,scrollHeight} = mv
      if scrollHeight <= clientHeight
        turn.value = 0
      else
        turn.value = 1
      nextTick scroll
    ro = new ResizeObserver resize
    ro.observe wv
    $on(
      mv
      {
        scroll
      }
    )
    $on(
      window
      {
        resize
      }
    )
    onUnmounted =>
      ro.disconnect()
      pointerunbind()
    return

  {
    turn
    main
    si
    aside
    wrap
    click:(e)=>
      mv = main.value
      {clientHeight,scrollHeight} = mv
      scrollTo parseInt(e.offsetY/clientHeight * (scrollHeight-clientHeight))
      return
    down:(e)=>
      HTML.setPointerCapture(e.pointerId)
      for i from [HTML, aside.value]
        i?.classList.add(SCROLL_CLS)
      mv = main.value
      sv = si.value
      _diff = 0
      Y = e.screenY
      _pointerunbind = _on HTML,{
        lostpointercapture:pointerunbind
        pointerup:pointerunbind
        pointermove:({screenY})=>
          {clientHeight,scrollHeight} = mv
          diff = screenY - Y

          mv.scrollTop += diff/clientHeight*scrollHeight
          Y = screenY

          return
      }
  }
}
</script>

<style lang="stylus">
html.scroll
  cursor url(':/cursor/grab.svg'), grab
</style>

<style lang="stylus" scoped>
main
  overflow auto
  -ms-overflow-style none
  scrollbar-width none
  flex-direction row-reverse
  position relative
  display flex

main::-webkit-scrollbar
  width 0

main>div
  margin auto
  height 100%

main>div>div
  min-height 100%
  width 100%
  display flex
  flex-direction column
  align-items center
  justify-content center

main>aside
  user-select none
  position sticky
  z-index 999
  height 100%
  top 0
  left 100%
  width 1.05rem

  &, &>i
    transition all 0.2s, opacity 1s, box-shadow 1s

  &>i
    position absolute
    display block
    width 0.45rem
    right 0.1rem
    margin 2px 0
    border-radius 0.3rem
    background rgba(0, 0, 0, 0.2)

main > div
  width 100%

main > aside+div
  margin-right -1.05rem

main>aside:hover, aside.scroll
  background rgba(125, 125, 125, 0.05)
  opacity 1 !important
  box-shadow inset 0.2rem 0 0.2rem -0.2rem rgba(0, 0, 0, 0.3), inset -0.2rem 0 0.2rem -0.2rem rgba(0, 0, 0, 0.05)

  &>i
    background rgba(0, 0, 0, 0.3)
    width 0.6rem
    right 0.225rem
</style>

