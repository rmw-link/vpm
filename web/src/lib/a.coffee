import TITLE from "~/config/title.coffee"
import _on from "~/lib/_on.coffee"
document.title = TITLE

pushState = history.pushState
history.pushState = ->
  r = pushState.apply @,arguments
  window.dispatchEvent new Event('pushState')
  return r

_on(
  document.body
  click: (e) =>
    p = e.target
    while p
      {nodeName:name} = p
      if name == "A"
        href = p.href
        if href
          if p.host == location.host
            history.pushState(null,TITLE,p.pathname + p.search)
            e.preventDefault()
          else
            if not p.target
              p.target = "_blank"
        break
      else if name == "BODY"
        break
      p = p.parentNode
    return
)
