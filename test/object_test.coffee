object = require('../lib/object')

describe 'object', ->
  describe "isEmpty", ->
    it 'should return object is empty or not', ->
      empty = {}
      notEmpty = {test: true}
      object.isEmpty(empty).should.be.ok
      object.isEmpty(null).should.be.ok
      object.isEmpty(notEmpty).should.be.false

  describe 'fileExists', ->
    it 'should check if file empty', ->
      empty = {}
      object.fileExists('image', empty).should.be.false

    it 'should check filename', ->
      files =
        image: 'test'
      object.fileExists('test', files).should.be.false

    it 'should check size', ->
      files = 
        image:
          size: 2
          path: 'test'
      object.fileExists('image', files).should.be.true
