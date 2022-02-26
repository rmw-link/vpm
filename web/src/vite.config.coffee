import pug from 'pug'
###
_compile = pug.compile
pug.compile = ->
  r = _compile.apply this,arguments
  ->
    console.log 'render',arguments
    r.apply(this,arguments)
###
import vitePluginStylusAlias from './plugin/vite-plugin-stylus-alias.mjs'
import AutoImport from 'unplugin-auto-import/vite'
import { writeFileSync } from 'fs'
import compress from 'vite-plugin-compress'
import htmlMinimizeMod from '@sergeymakinen/vite-plugin-html-minimize'
htmlMinimize = htmlMinimizeMod.default
import Components from 'unplugin-vue-components/vite'
import coffee from 'rollup-plugin-coffee2'
import thisdir from '@rmw/thisdir'
import vue from '@vitejs/plugin-vue'
import { ArcoResolver } from 'unplugin-vue-components/resolvers'
import { defineConfig } from 'vite'
import {dirname,join} from 'path'

import * as PUG from './config/pug.js'

PRODUCTION = process.env.NODE_ENV == 'production'
SRC = thisdir(import.meta)
ROOT = dirname SRC
FILENAME = if PRODUCTION then '[hash].[ext]' else '[name].[ext]'
JSNAME = if PRODUCTION then '[hash].js' else '[name].js'

{ env } = process
export default defineConfig ({ mode }) =>
  writeFileSync(
    join(SRC, 'index.html'),
    pug.compileFile(join(SRC, 'index.pug'))({
    })
  )

  plugins = [
    Components(
      resolvers: [
        ArcoResolver(
          resolveIcons: true
          importStyle: 'less'
        )
      ]
    )
    AutoImport(
      include: [
        /\.[tj]s?$/
        /\.vue$/
        /\.coffee$/
      ]
      imports: [ 'vue' ]
    )
    coffee(
      bare: true
      sourceMap: true
    )
    vitePluginStylusAlias()
    vue({
      template:
        preprocessOptions:PUG
    })
  ]

  if PRODUCTION
    plugins = plugins.concat [
      htmlMinimize({
        filter: /\.html?$/,
      })
      compress.default(
        threshold:0
        extensions:'br'
        exclude: ["ssr-manifest.json"]
      )
    ]


  {
    plugins
    clearScreen: false
    publicDir: join(ROOT, 'public'),
    server:
      host: '0.0.0.0' or env.VPM_HOST
      port: 3252 or env.VPM_PORT
    css:
      preprocessorOptions: less: {
        modifyVars: {
          hack: "true; @import '@arco-themes/vue-vlang-vpm/variables.less';@import '#{SRC}/styl/arco.less'"
        }
        javascriptEnabled: true
      }
    resolve:
      alias:
        ":": join(ROOT, "file")
        '~': SRC
    esbuild:
      legalComments: 'none'
      treeShaking: true
    build:
      assetsDir: "/"
      emptyOutDir: true
      outDir: join ROOT,'dist'
      rollupOptions:
        output:
          entryFileNames: JSNAME
          chunkFileNames: JSNAME
          assetFileNames: FILENAME
  }
