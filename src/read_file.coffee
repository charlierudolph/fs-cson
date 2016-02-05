csonParser = require 'cson-parser'
fsExtra = require 'fs-extra'


readFile = (filePath, done) ->
  fsExtra.readFile filePath, 'utf8', (err, data) ->
    if err then return done err
    try
      result = csonParser.parse data
    catch parseErr
      for field in ['message', 'stack']
        parseErr[field] = parseErr[field].replace 'stdin', filePath
      return done parseErr
    done null, result


readFileSync = (filePath) ->
  data = fsExtra.readFileSync filePath, 'utf8'
  csonParser.parse data


module.exports = {readFile, readFileSync}
