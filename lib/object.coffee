exports.isEmpty = isEmpty = (obj)->
  not (obj? and Object.keys(obj).length)

# check express req.files object have file or not
exports.fileExists = (name, files)->
  not isEmpty(files) and files[name]?.size > 0
