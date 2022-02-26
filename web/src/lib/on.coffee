import $on from './_on.coffee'
export default (elem, dict)=>
  unbind = $on elem, dict
  onUnmounted unbind
  unbind
