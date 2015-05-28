stringify = require './stringify'
fsExtra = require 'fs-extra'


writeFileSafe = (filePath, object, done) ->
  fsExtra.outputFile filePath, stringify(object), done


writeFileSafeSync = (filePath, object) ->
  fsExtra.outputFileSync filePath, stringify(object)


module.exports = {writeFileSafe, writeFileSafeSync}
