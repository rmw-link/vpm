import $on from './on.coffee'

export default (next)=>
  {pathname:p} = location
  pathname = undefined

  run = =>
    p = p[1..]
    if pathname == p
      return
    if (await next(p,pathname))!=false
      pathname = p
    return

  nextTick run
  f = =>
    {pathname:p} = location
    run()
    return

  $on window, {
    pushState:f
    popstate:f
  }
