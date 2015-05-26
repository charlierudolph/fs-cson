{readFile, readFileSync} = require './read'
{writeFile, writeFileSync} = require './write'


updateFile = (filePath, updater, done) ->
  readFile filePath, (err, object) ->
    if err then return done err
    updatedObject = updater object
    writeFile filePath, updatedObject, done


updateFileSync = (filePath, updater) ->
  object = readFileSync filePath
  updatedObject = updater object
  writeFileSync filePath, updatedObject


module.exports = {updateFile, updateFileSync}
