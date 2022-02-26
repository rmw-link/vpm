<template lang="pug">
main
  a.github(href=`//github.com/login/oauth/authorize?client_id=${github.client_id}`)
    | Continue with GitHub
</template>

<script lang="coffee">

export default {
setup:=>
}
</script>

<style lang="stylus" scoped>
@import '~/lib/dialog.styl'

main
  background #fff

  &>a
    padding 16px
    color #000
    position relative
    display flex
    align-items center
    line-height @height
    border-top 1px solid border

    &:first-child
      border 0

    &:before
      left 0
      top 2px
      width 20px
      height @width
      display inline-block
      content ''
      background #000
      mask-size contain
      margin-right 7px

    &.github
      &:before
        mask-image url(':/logo/github.svg')

    &:hover, &:focus
      background #f40
      color #fff
      border-color #f40

      &:before
        background #fff

    &:hover + a, &:focus + a
      border-color #f40
</style>


