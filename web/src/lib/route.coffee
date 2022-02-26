import state from '~/lib/state.coffee'
import replaceUrl from '~/lib/replaceUrl.coffee'
import _on from '~/lib/_on.coffee'
import Dialog from '~/lib/dialog.coffee'
import _dialog from '~/config/dialog.js'

DIALOG = new Set(_dialog.split(' '))
OPENED = new Map()

export default (view)=>

  close_dialog = (page)=>
    =>
      path = OPENED.get(page) or '/'
      if location.pathname[2..] == page
        replaceUrl path
      OPENED.delete page
      return

  state (page,old)=>
    if DIALOG.has page
      if not OPENED.has page
        OPENED.set page, old
        dialog = await Dialog(page).catch(
          =>
            OPENED.delete(page)
            return
        )
        dialog.show()
        _on dialog,{
          close:close_dialog(page)
        }
      return false
    return
  return
