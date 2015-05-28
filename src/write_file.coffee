stringify = require './stringify'
fs = require 'fs'


writeFile = (filePath, object, done) ->
  fs.writeFile filePath, stringify(object), done


writeFileSync = (filePath, object) ->
  fs.writeFileSync filePath, stringify(object)


module.exports = {writeFile, writeFileSync}
