#!/usr/bin/env coffee

import {PWD} from './dir.coffee'
import {readFileSync} from 'fs'
import Q from './q/q'
import {memoize} from 'lodash-es'


_site_id = memoize (host)=>
  (
    await Q.site.get(
      {host}, 'id'
    ) or (
      await Q.site.insert({host}).returning('id')
    )[0]
  ).id


_user_id = memoize (name)=>
  o = await Q.user.get({name})
  site_id = await _site_id('github.com')
  if o
    await Q.user_id_site_id.insert({
      user_id:o.id
      site_id
    }).onConflict().ignore()
    return o.id

  [{id}] = await Q.user.insert({name}).returning('id')
  await Q.user_id_site_id.insert({
    user_id:id
    site_id
  })
  return id


for i from readFileSync(PWD+'/li.txt','utf8').split("\n")
  i = i.trim()
  if not i
    continue

  {
    name
    url
    nr_downloads:down
  } = await get 'https://vpm.vlang.io/jsmod/'+i

  {host,pathname} = new URL url


  url = pathname[1..]

  if url.endsWith(".git")
    url = url[..-5]

  if await Q.mod.get({url})
    continue

  console.log url
  org = url.split('/')[0]

  r = await get "https://api.github.com/repos/#{url}"

  {owner,description:brief,full_name} = r

  if not owner
    console.log r
  else
    {login} = owner
    console.log login,brief
    site_id = await _site_id host
    user_id = await _user_id(login)
    await Q.mod.insert({
      user_id
      site_id
      url
      brief:brief or ''
      down
      name
    })

    #for {full_name,owner,description} from li
    #  console.log full_name,owner,description
  #console.log url, down
  #console.log site_id
  #console.log host,pathname[1..]
  #
process.exit()
