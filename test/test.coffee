# build time tests for bat plugin
# see http://mochajs.org/

bat = require '../client/bat'
expect = require 'expect.js'

describe 'bat plugin', ->

  describe 'expand', ->

    it 'can make itallic', ->
      result = bat.expand 'hello *world*'
      expect(result).to.be 'hello <i>world</i>'
