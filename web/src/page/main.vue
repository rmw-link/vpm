<template lang="pug">
side
aside
  a-tabs(default-active-key="2")
    a-tab-pane(key="1")
      template(#title)
        a.logo
        | vpm
      main
        h3 Issue
        h3 Blog
        h3 Update
        a-card(:style="{ width: '360px' }" title="Arco Card")
          template(#extra)
            a-link More
          | ByteDance's core product, Toutiao ("Headlines"), is a content platform in
          |
          | China and around the world. Toutiao started out as a news recommendation
          |
          | engine and gradually evolved into a platform delivering content in various
          |
          | formats.
        a-card(:style="{ width: '360px' }" title="Arco Card")
          template(#extra)
            a-link More
          |
          | ByteDance's core product, Toutiao ("Headlines"), is a content platform in
          |
          | China and around the world. Toutiao started out as a news recommendation
          |
          | engine and gradually evolved into a platform delivering content in various
          |
          | formats.
        a-card(:style="{ width: '360px' }" title="Arco Card")
          template(#extra)
            a-link More
          |
          | ByteDance's core product, Toutiao ("Headlines"), is a content platform in
          |
          | China and around the world. Toutiao started out as a news recommendation
          |
          | engine and gradually evolved into a platform delivering content in various
          |
    a-tab-pane(key="2")
      template(#title)
        a.v
      p 1
    a-tab-pane(key="3" title="vlib")
      p 2
</template>

<script lang="coffee">
import side from '~/util/side.vue'
export default {
components:{
  side
}
setup:=>

}
</script>

<style lang="stylus" scoped>
aside
  flex 1
  flex-direction column
  align-self flex-start
  display flex

  :deep(.arco-tabs)
    flex 1

  :deep(.arco-tabs-pane)
    display flex
    height 100%

  :deep(.arco-tabs-content)
    height 100%
    padding 0
    display flex

  .arco-tabs-tab-title>a
    display inline-block
    margin-right 6px
    background url(':/site/logo.svg') 50% 50% / 18px no-repeat
    height 18px
    width 18px

    &.v
      background-image url(':/site/v.svg')
      margin 0

  .arco-card
    margin 16px
</style>


