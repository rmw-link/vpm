import _pg from 'pg'
import pgParseFloat from 'pg-parse-float'

pgParseFloat _pg
_pg.types.setTypeParser(20, parseInt)
_pg.types.setTypeParser(1016, (v)->
    if v=="{}"
        return []
    v = v.replace(/{/g,"[").replace(/}/g,"]")
    return JSON.parse(v)
)

import knex_pg from './knex'

export default knex_pg({
  client: 'pg',
  useNullAsDefault: true
  pool: { min: 1, max: 8 }
  acquireConnectionTimeout: 60000
  connection: process.env.pg_url
  version: "13.0.0"
  #...config
  # debug:process.env.NODE_ENV == "development"
  # searchPath: CONFIG.SCHEMA
  # searchPath: ["app", 'public'],
})
