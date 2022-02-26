#!/usr/bin/env coffee

import Q from './q/q'
import {memoize} from 'lodash-es'
import {get} from './net.coffee'

_tag_id = memoize (name)=>
  await Q.tag.upsert_id {name}

_license_id = memoize (spdx)=>
  if not spdx
    return 0
  await Q.license.upsert_id {spdx}

do =>

  for [id,url] from await Q "select id,url from mod where site_id=1 order by id"
    {
      topics
      license
      created_at
      updated_at
    } = await get "https://api.github.com/repos/#{url}"

    for tag from topics
      tag = tag.toLowerCase()
      if ['v','vlang'].indexOf(tag)>=0
        continue
      if tag.startsWith 'vlang-'
        continue
      tag_id = await _tag_id(tag)
      await Q.mod_tag.insert({
        tag_id
        mod_id:id
      }).onConflict().ignore()

    console.log await Q.mod.where({id}).update {
      license_id : await _license_id(license?.spdx_id)
      ctime: new Date(created_at) / 1000
      utime: new Date(updated_at) / 1000
    }

  process.exit()


