#!/usr/bin/env coffee

{env} = process

import thisdir from '@rmw/thisdir'
import {dirname,join} from 'path'

export PWD = thisdir import.meta
export ROOT = dirname PWD

