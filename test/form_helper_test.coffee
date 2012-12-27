form_helper = require('../lib/form_helper')
should = require('should')

describe "form_helper", ->

  describe "parse", ->
    it 'should parse 1 level params', ->
      params =
        name: 'Jimmy'
        password: '123456'
      result = form_helper.parse(params)
      result.name.should.eql 'Jimmy'
      result.password.should.eql '123456'

    it 'should block empty params', ->
      params =
        name: 'Jimmy'
        password: ''
        profile: undefined
      result = form_helper.parse(params)
      result.name.should.eql 'Jimmy'
      result.password?.should.be.false
      result.profile?.should.be.false

    it 'should create nested object', ->
      params = 
        'author[name]': 'Jimmy'
        'author[password]': '123456'
        'author[profile]': ''
      result = form_helper.parse(params)
      result.author.name.should.eql 'Jimmy'
      result.author.password.should.eql '123456'
      result.author.profile?.should.be.false

    it 'should create array objects', ->
      params =
        'users[0]': 'Jimmy'
        'users[1]': 'John'
        'users[2]': 'James'
      result = form_helper.parse(params)
      result.users[0].should.eql 'Jimmy'
      result.users[1].should.eql 'John'
      result.users[2].should.eql 'James'

    it "should create nested array objects", ->
      params =
        'users[0][name]': 'Jimmy'
        'users[0][password]': '123456'
        'users[1][name]': 'John'
        'users[1][password]': '123456'
      result = form_helper.parse(params)
      result.users[0].name.should.eql 'Jimmy'
      result.users[0].password.should.eql '123456'
      result.users[1].name.should.eql 'John'
      result.users[1].password.should.eql '123456'

    it "should create nested nested array objects", ->
      params =
        'users[0][profile][name]': 'Jimmy'
        'users[0][profile][posts][0][title]': 'Title'
      result = form_helper.parse(params)
      result.users[0].profile.name.should.eql 'Jimmy'
      result.users[0].profile.posts[0].title.should.eql 'Title'

    it "should skip empty index", ->
      params =
        'users[0]': 'Jimmy'
        'users[3]': 'Jerry'

      result = form_helper.parse(params)
      result.users[0].should.eql 'Jimmy'
      result.users[3].should.eql 'Jerry'

    it "should parse with complex object", ->
      body =
        title: 'title'
        'users[0][name]': 'Jimmy'
        'users[0][profile][address]': 'Earth'
        'users[0][posts][0][title]': 'Test Post'
      result = form_helper.parse(body)
      result.title.should.eql 'title'
      result.users[0].name.should.eql 'Jimmy'
      result.users[0].profile.address.should.eql 'Earth'
      result.users[0].posts[0].title.should.eql 'Test Post'

    it "should ignore empty value", ->
      body =
        title: 'title'
        'users[0][name]': ''
        'users[0][profile][address]': ''
        'users[0][posts][0][title]': ''

      result = form_helper.parse(body)
      result.title.should.eql 'title'
      result.users?[0].should.be.false


  describe "filterEmpty", ->
    it 'should remove empty object in attributes', ->
      body =
        users: [{
          name: ''
          profile: ''
        },{
          name: 'test'
          profile: ''
        }]
      form_helper.filterEmpty(body)
      body.should.eql
        users: [
          name: 'test'
          profile: ''
        ]

    it "should remove empty object in nested array", ->
      body =
        group:
          name: 'test'
          users: [{
            name: 'Jimmy'
          },{
            name: ''
          }]
      form_helper.filterEmpty(body)
      body.should.eql
        group:
          name: 'test'
          users: [
            name: 'Jimmy'
          ]
