password = require('../lib/password')

describe 'password', ->
  it 'hash with password and salt', ->
    password.hash('123456', 'salt').should.match /[a-z0-9]{40}/

  it 'generate same hash with same password and salt', ->
    hash1 = password.hash('123456', 'salt')
    hash2 = password.hash('123456', 'salt')
    hash1.should.eql hash2

  it 'should be able to generate random salt', ->
    salt = password.generateSalt()
    salt.should.match /[a-z0-9]{40}/
