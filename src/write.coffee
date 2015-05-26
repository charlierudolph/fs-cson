csonParser = require 'cson-parser'
fs = require 'fs'


writeFile = (filePath, object, done) ->
  fs.writeFile filePath, _stringifyObject(object), done


writeFileSync = (filePath, object) ->
  fs.writeFileSync filePath, _stringifyObject(object)


_stringifyObject = (object) ->
  csonParser.stringify object, null, 2


module.exports = {writeFile, writeFileSync}
