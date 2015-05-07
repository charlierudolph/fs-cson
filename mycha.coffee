module.exports =

  # Default options to pass to mocha (can be overriden by command line options)
  mochaOptions:
    colors: yes
    compilers: 'coffee:coffee-script/register'
    reporter: 'dot'

  # Regular expression used for finding tests
  testFileRegex: /_(spec|test)\.(coffee|js)$/

  # Files to include before all tests
  testHelpers: [
    'spec/spec_helper.coffee'
  ]