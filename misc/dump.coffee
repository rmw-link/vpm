#!/usr/bin/env coffee

import Q from './q/q'
import zstd from 'zstandard-wasm'
import {encode} from 'msgpackr'

#TABLE = 'user_name user_id_site_id site mod'.split(' ')

select_in = new Proxy(
  {}
  get:(self,table)=>
    (id_set, ...columns)=>
      li = []
      for i from await Q[table].columns(
        columns
      ).whereIn('id',Array.from id_set).options({rowMode:'array'})
        li = li.concat i
      li
)


do =>

  li = await Q "select mod.id,user_id,site_id,url,brief from mod"
  site_set = new Set()
  user_set = new Set()
  mod = new Map()

  for [mod_id,user_id,site_id,url,brief] in li
    mod_li = mod.get(site_id)
    if not mod_li
      mod_li = []
      mod.set site_id, mod_li
    mod_li.push [user_id,url,brief]
    site_set.add(site_id)
    user_set.add(user_id)

  bin = encode [
    mod
    await select_in.user_name user_set,'id','name'
    await select_in.site site_set,'id','host'
  ]

  console.log bin.length/1024/1024



  #LI = []
  #for table from TABLE
  #  li = await Q("select * from public.#{table}")
  #  t = []
  #  if li.length > 0
  #    t.push li[0].length
  #    for i from li
  #      t = t.concat(i)
  #  LI.push t

  #console.log encode LI[0]
  process.exit()


