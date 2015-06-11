csonParser = require 'cson-parser'


stringify = (object) ->
  csonParser.stringify(object, null, 2) + '\n'


module.exports = stringify
