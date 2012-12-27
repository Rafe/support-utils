###
form_helper is utility for forms
###


###
  Parse form body and return nested attributes

  Example

  body =
    title: 'title'
    'users[0][name]': 'Jimmy'
    'users[0][profile][address]': 'Earth'
    'users[0][posts][0][title]': 'Test Post'

  console.log parse(body)

  => {
    title: 'title'
    profile:
      address: 'Earth'
    users: [{
      name: 'Jimmy'
      posts: [{
        title: 'Test Post'
      }]
    }]
  }

  @param {Object} body

  @api public
###

exports.parse = parse = (body)->
  result = {}
  Object.keys(body).forEach (key)->
    return if not body[key]? or body[key] is ""

    params = key.replace(/\]/g,'').split('[')
    build result, params, body[key]

  result

build = (parent, params, value)->
  node = params.shift()

  unless params.length
    parent[node] = value
    return parent[node]

  unless parent[node]?
    if isNumber params[0]
      parent[node] = []
    else
      parent[node] = {}

  build(parent[node], params, value)

isNumber = (n)->
  !isNaN(parseInt(n))


###
  Filter empty objects in nested array

  Example:
      body =
        users: [{
          name: ''
          profile: ''
        },{
          name: 'test'
          profile: ''
        }]
      form_helper.filter(body)
      console.log body # =>
      #users: [{
      # name: 'test'
      # profile: ''
      #}]
###

exports.filterEmpty = filter = (attributes = '')->
  keep = false
  if attributes is ''
    return false
  else if Array.isArray(attributes)
    for attribute, i in attributes
      if filter(attribute)
        keep = true
      else
        attributes.splice(i,i+1)
  else if typeof attributes is 'object'
    for key, value of attributes
      keep = true if filter(value)
  else
    keep = true
  keep
