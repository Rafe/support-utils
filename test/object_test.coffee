object = require('../lib/object')

describe 'object', ->
  describe "isEmpty", ->
    it 'should return object is empty or not', ->
      empty = {}
      notEmpty = {test: true}
      object.isEmpty(empty).should.be.ok
      object.isEmpty(null).should.be.ok
      object.isEmpty(notEmpty).should.be.false
