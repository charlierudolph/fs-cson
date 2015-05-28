csonParser = require 'cson-parser'


stringify = (object) ->
  csonParser.stringify object, null, 2


module.exports = stringify
