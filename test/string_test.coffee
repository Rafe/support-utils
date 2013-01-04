string = require('../lib/string')

describe "string", ->
  it 'capitalize words', ->
    string.capitalize('test').should.eql 'Test'

  it 'pluralize words', ->
    string.pluralize('Car', [1, 1] ).should.eql 'Cars'
    string.pluralize('Car', [1]).should.eql 'Car'

  it 'pluralize irregular word', ->
    string.pluralize('Dish', [1..4], 'Dishes').should.eql 'Dishes'
