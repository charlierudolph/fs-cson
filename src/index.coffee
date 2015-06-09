{readFile, readFileSync} = require './read_file'
{updateFile, updateFileSync} = require './update_file'
{writeFile, writeFileSync} = require './write_file'
{writeFileSafe, writeFileSafeSync} = require './write_file_safe'
register = -> require './register'


module.exports = {
  readFile
  readFileSync
  register
  updateFile
  updateFileSync
  writeFile
  writeFileSync
  writeFileSafe
  writeFileSafeSync
}
