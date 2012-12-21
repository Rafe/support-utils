exports.capitalize = (string)->
  string.substr(0, 1).toUpperCase() + string.substr(1)

exports.pluralize = (name, collection)->
  if collection.length > 1
    name + 's'
  else
    name
