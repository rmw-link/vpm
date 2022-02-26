import mount from '~/lib/mount.coffee'
import DIALOG from './dialog.vue'
import {inc,dec} from '~/lib/Spin'
import _on from '~/lib/_on.coffee'
import autofocus from '~/lib/autofocus.coffee'


export default (page,old)=>
  inc()
  {default:c} = await import("../dialog/#{page}.vue").finally(dec)
  dialog = document.createElement 'dialog'
  document.body.append dialog
  app = mount dialog,DIALOG,{c}
  _on dialog,{
    close:=>
      app.unmount()
      document.body.removeChild(dialog)
      autofocus()
      return
  }
  return dialog

