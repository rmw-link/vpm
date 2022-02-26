import Knex from 'knex'
import knexTinyLogger from './log'
import QueryBuilder from 'knex/lib/query/querybuilder'

###
_transaction = Knex.Client::transaction
Knex.Client::transaction = (container, config)->
  _transaction.call(
    @
    (trx)->
      Object.assign(trx,extend)
      container.apply @,arguments
    config
  )
###

Object.assign(
  QueryBuilder::
  {
  dict:->
    li = await @select(
      ["id","val"]
    )
    r = {}
    for {id,val} in li
      r[id]=val
    r

  upsert_id:(q)->
    table = @clone()
    (
      (
        await @insert(q).returning(
          'id'
        ).onConflict().ignore()
      )[0] or (
        await table.columns('id').get(q)
      )
    )[0]

  iter:(option={})->
    {id,limit,select,begin,where} = {
      begin:0
      id : 'id'
      limit : 1000
      select : "*"
      where: {}
      ...option
    }
    while 1
      q = @clone()
      li = await q.select(select).where(where).where(id,">", begin).limit(limit).orderBy(id)
      for i in li
        yield i
      if li.length
        begin = li[li.length-1][id]
      else
        break

  total:(where)->
    if where
        q = @where(where)
    else
        q = @
    return Object.values((await q.count())[0])[0]

  set:(id, val)->
    if val == undefined
      return @where({id}).delete()
    await @upsert({val},{id})

  val:(id)->
    r = await @get({id}, 'val')
    if r
      return r.val

  val_id: (val)->
    return await @upsert(
      {val}
    )

  get: (dict, column)->
    if parseInt(dict)
        dict = {id:dict}
    return (
      (
        await @where(dict).select(column).limit(1)
      )[0]
    )
  }
)



###
extend = {

_raw:->
  args = []
  for i in arguments
      args.push i
  sql = args.shift()
  return @raw.call(
      @
      sql
      args
  )

one: ->
  return (await (@exec.apply(@,arguments)))[0]

dict:->
  r = {}
  for [k,v] in await @li.apply @,arguments
    r[k] = v
  r

val:->
  r = await @li.apply(@,arguments)
  if r.length
    return r[0][0]
  return

li1:->
  r = []
  for i in await @li.apply(@,arguments)
    r.push i[0]
  return r

li: ->
  {rows} = await @_raw.apply(@, arguments).options({rowMode:'array'})
  return rows

exec : ->
  {rows} = await @_raw.apply(@, arguments)
  return rows
}
###

export default ->
  pg = Knex.apply @,arguments
  #Object.assign(pg, extend)
  pg.on(
    'query-error'
    (error, obj)=>
      console.error obj.sql
      console.error obj.bindings
      console.error error.toString()
  )
  if process.env.NODE_ENV != "production"
    pg = knexTinyLogger pg
  return pg
