<template lang="pug">
a.x(@click="x" ref="b") ×
p.b05
  component(:is="c")
</template>

<script lang="coffee">
import $on from "~/lib/on.coffee"

export default {
props:['c']
setup:=>
  b = shallowRef()
  x = =>
    b.value.parentNode.close()
    return
  $on document.body,{
    keyup:(e)=>
      if 27 == e.keyCode
        x()
      return
  }
  {
    x
    b
  }
}
</script>

<style lang="stylus" scoped>
@import './dialog.styl'

dialog
  &>p
    margin 0
    border 8px solid border

    &:after
      border-color alpha(color, 0.8)

&>a.x
  color alpha(#000, 0.8)
  text-shadow alpha(#fff, 0.8) 0 -1px 0
  width 28px
  line-height @width
  top -(@width * 1.5)
  margin-left -(@width / 2)
  height @width
  font-size @width
  font-weight 200
  position absolute
  user-select none
  cursor pointer
  left 50%

  &:hover
    color #f40
</style>


