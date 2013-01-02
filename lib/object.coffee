exports.isEmpty = (obj)->
  not (obj? and Object.keys(obj).length)
