<template lang="pug">
scrollbar
  autohide
    nav
      a.logo(href="/")
        i v
        i pm
      nav
        a(href="/sign") Sign In / Up
    a-input-search(placeholder="search mod name / tag / brief")
      a-input-search(search-button)
  li
    h4
      a khalyomede.i18n
      icon-star
    p Translation and pluralization functions for V.
    li
      a i18n
    footer
      a khalyomede
      a
        | 9231
        icon-download
  li
    h4
      a exastencil/vape
      icon-star
    p The functional web micro-framework!
    li
      a web
      a framework
    footer
      a exastencil
      a
        | 81
        icon-download
  li
    h4
      a nsauzede.vsdl2
      icon-star
    p 🎬 SDL2 V module -- libSDL2 wrapper
    li
      a game
      a video
    footer
      a nsauzede
      a
        | 821
        icon-download
  li
    h4
      a ui
      icon-star
    p Cross-platform UI library written in V
    li
      a ui
      a gui
    footer
      a spytheman
      a
        | 3223
        icon-download
</template>

<script lang="coffee">
import scrollbar from '~/lib/scrollbar.vue'
import autohide from '~/lib/autohide.vue'
export default {
components:{
  scrollbar
  autohide
}
setup:=>

}
</script>

<style lang="stylus" scoped>
.scroll
  height 100%
  width 292px
  box-sizing border-box
  border-right 1px solid #eee
  box-shadow 0 0 3px inset #fefefe
  background linear-gradient(180deg, #f5f5f5 116px, #f3f3f3 100%)

  &>div>div
    &>li
      margin 0 16px 16px
      border 1px solid #eee
      padding 16px
      background #f9f9f9
      list-style-type none

      &>h4
        font-family html
        margin 0
        display flex
        justify-content space-between
        align-items center
        line-height 16px
        font-size 16px

        &>a
          color #000

      &>p
        margin-bottom 14px

      &>li
        list-style-type none
        margin-bottom 14px

        &>a
          margin-right 6px
          padding 3px 6px
          color #666
          user-select none
          font-size 12px
          border-radius 5px
          box-shadow 0 0 3px inset #eee
          font-weight 300
          background-image url(':/border/tag.svg')

      &>footer
        user-select none
        color #999
        display flex
        justify-content space-between
        font-size 12px

        .arco-icon-download
          margin-left 3px

    &>header
      margin-bottom 16px
      z-index 0
      background linear-gradient(0deg, #f5f5f5 0, #f9f9f9 100%)

      &>.arco-input-search
        padding 8px 16px
        background #fff
        border 0
        margin 0 16px
        box-sizing border-box
        width calc(100% - 32px)

        &>:deep(.arco-input-suffix svg)
          opacity 0.5

      &>.arco-input-search, &>li
        box-shadow 0 0 3px inset #ccc

      &>nav
        align-items center
        user-select none
        height 70px
        display flex
        justify-content space-between

        &>nav
          justify-content flex-end
          display flex
          flex 1

          &>a
            border 1px solid #437abe
            padding 3px 15px
            margin-right 16px
            border-radius 32px
            text-align center
            font-size 14px
            margin-top -3px

            &:hover, &:focus
              background-color #f40
              color #fff
              border-color @background-color

        &>a.logo
          word-break normal
          flex 0
          margin 0 16px
          background url(':/site/logo.svg') 0 50% / 48px no-repeat
          padding-left 52px
          text-decoration none
          font-weight 600
          color #437ABE
          display flex
          height 48px
          width 93px
          margin-top -3px

          &>i
            transform scale(1, 1.1)
            font-size 28px
            line-height 40px
            font-family h
            font-style normal
            color #84B4E6
            letter-spacing -1px

          &>i:first-child
            margin-right 1px
            color #437ABE
</style>


