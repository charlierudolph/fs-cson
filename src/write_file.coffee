stringify = require './stringify'
fsExtra = require 'fs-extra'


writeFile = (filePath, object, done) ->
  fsExtra.writeFile filePath, stringify(object), done


writeFileSync = (filePath, object) ->
  fsExtra.writeFileSync filePath, stringify(object)


module.exports = {writeFile, writeFileSync}
