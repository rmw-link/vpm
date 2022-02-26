import IS_DEV from '~/config/is_dev.js'

export default =>
  if IS_DEV
    if window.imported
      return
    window.imported = true

  await import('~/lib/a.coffee')
  return

