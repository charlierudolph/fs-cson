{readFileSync} = require './read_file'

require.extensions['.cson'] = (module, filename) ->
  try
    module.exports = readFileSync filename
  catch error
    oldMessage = error.message
    error.message = "#{filename}: #{error.message}"
    error.stack = error.stack.replace oldMessage, error.message
    throw error
