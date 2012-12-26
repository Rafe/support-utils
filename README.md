# Common support utils

### string

    string = require('support-utils').string
    string.capitalize('jimmy') # => 'Jimmy'
    string.pluralize('user') # => 'users'

### password

    password = require('support-utils').password

    salt = password.generateSalt()
    hashed = password.hash('123456', salt)

### form_helper

    form = require('support-utils').form_helper

    form.parse
      'name': 'Jimmy'
      'profile[address]': 'Taiwan'
      'profile[phone][0]' : '123-456-789'
      'profile[phone][0]' : '456-123-123'
    # =>
    #{
    #  name: 'Jimmy'
    #  profile: {
    #    address: 'Taiwan'
    #    phone: ['123-456-789', '456-123-123']
    #  }
    #}
