import DB from './db.coffee'

Q = (args)=>
  sql = args.shift()
  (await DB.raw(sql, args).options({rowMode:'array'})).rows

export default new Proxy(
  Q

  apply:(target, self, args)=>
    Q(args)

  get:(self,name)=>
    DB(name).options({rowMode:'array'})
)
