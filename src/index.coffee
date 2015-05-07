csonParser = require 'cson-parser'
fs = require 'fs'


readFile = (filePath, done) ->
  fs.readFile filePath, 'utf8', (err, data) ->
    if err then return done err
    try
      result = csonParser.parse data
    catch parseErr
      for field in ['message', 'stack']
        parseErr[field] = parseErr[field].replace 'stdin', filePath
      return done parseErr
    done null, result


readFileSync = (filePath) ->
  data = fs.readFileSync filePath, 'utf8'
  csonParser.parse data


writeFile = (filePath, object, done) ->
  fs.writeFile filePath, _stringifyObject(object), done


writeFileSync = (filePath, object) ->
  fs.writeFileSync filePath, _stringifyObject(object)


_stringifyObject = (object) ->
  csonParser.stringify object, null, 2


module.exports = {readFile, readFileSync, writeFile, writeFileSync}
