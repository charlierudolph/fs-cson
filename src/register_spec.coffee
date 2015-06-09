fs = require 'fs'
path = require 'path'
tmp = require 'tmp'


describe 'fsCson', ->

  before ->
    require './register'

  after ->
    delete require.extensions['.cson']

  beforeEach (done) ->
    tmp.dir unsafeCleanup: yes, (err, @tmpPath) => done err

  describe 'requiring a cson file', ->
    beforeEach (done) ->
      @filePath = path.join @tmpPath, 'sample.cson'
      fs.writeFile @filePath, 'a: 1\nb: 2', done

    it 'allows a cson file to be required', ->
      expect(require @filePath).to.eql {a: 1, b: 2}


  describe 'requiring an invalid cson file', ->
    beforeEach (done) ->
      @filePath = path.join @tmpPath, 'sample.cson'
      fs.writeFile @filePath, 'a:', done

    it 'allows a cson file to be required', ->
      error = null
      try
        require @filePath
      catch error

      expect(error.message).to.include @filePath
      expect(error.stack).to.include @filePath
      expect(error.toString()).to.include @filePath
