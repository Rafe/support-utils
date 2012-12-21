crypto = require('crypto')

exports.hash = (password, salt)->
  crypto.createHmac('sha1', salt)
        .update(password)
        .digest('hex')

exports.generateSalt = ->
  seed = crypto.randomBytes(256).toString()
  crypto.createHash('sha1')
        .update(seed)
        .digest('hex')
