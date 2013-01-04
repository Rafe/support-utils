exports.capitalize = (string)->
  string.substr(0, 1).toUpperCase() + string.substr(1)

exports.pluralize = (name, collection, irregular)->
  if collection.length > 1
    if irregular?
      irregular
    else
      name + 's'
  else
    name
