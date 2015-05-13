async = require 'async'
fs = require 'fs'
fsCson = require './'
path = require 'path'
tmp = require 'tmp'


describe 'fsCson', ->

  beforeEach (done) ->
    tmp.dir unsafeCleanup: yes, (err, @tmpPath) => done err

  describe 'readFile', ->
    beforeEach ->
      @filePath = path.join @tmpPath, 'sample.cson'

    context 'filesystem error', ->
      beforeEach (done) ->
        fsCson.readFile @filePath, (@err, @data) => done()

      it 'returns an error', ->
        expect(@err).to.be.instanceOf Error
        expect(@err.stack).to.include @filePath
        expect(@err.stack).to.include 'ENOENT'

      it 'does not return an object', ->
        expect(@data).to.not.exist

    context 'invalid cson', ->
      beforeEach (done) ->
        async.series [
          (next) => fs.writeFile @filePath, 'a:', next
          (next) => fsCson.readFile @filePath, (@err, @data) => next()
        ], done

      it 'returns an error', ->
        expect(@err).to.be.instanceOf Error
        expect(@err.stack).to.include @filePath
        expect(@err.stack).to.include 'a:'

      it 'does not return an object', ->
        expect(@data).to.not.exist

    context 'valid cson', ->
      beforeEach (done) ->
        async.series [
          (next) => fs.writeFile @filePath, 'a: 1\nb: 2', next
          (next) => fsCson.readFile @filePath, (@err, @data) => next()
        ], done

      it 'does not return an error', ->
        expect(@err).to.not.exist

      it 'returns the parsed object', ->
        expect(@data).to.eql a: 1, b: 2


  describe 'readFileSync', ->
    beforeEach ->
      @filePath = path.join @tmpPath, 'sample.cson'

    context 'filesystem error', ->
      beforeEach ->
        try
          fsCson.readFileSync @filePath
        catch err
          @err = err

      it 'errors', ->
        expect(@err).to.be.instanceOf Error
        expect(@err.stack).to.include @filePath
        expect(@err.stack).to.include 'ENOENT'

    context 'invalid cson', ->
      beforeEach (done) ->
        async.series [
          (next) => fs.writeFile @filePath, 'a:', next
          (next) =>
            try
              fsCson.readFileSync @filePath
            catch err
              @err = err
            finally
              next()
        ], done

      it 'returns an error', ->
        expect(@err).to.be.instanceOf Error
        expect(@err.stack).to.include 'a:'

    context 'valid cson', ->
      beforeEach (done) ->
        async.series [
          (next) => fs.writeFile @filePath, 'a: 1\nb: 2', next
          (next) =>
            @data = fsCson.readFileSync @filePath
            next()
        ], done

      it 'does not return an error', ->
        expect(@err).to.not.exist

      it 'returns the parsed object', ->
        expect(@data).to.eql a: 1, b: 2


  describe 'updateFile', ->
    beforeEach ->
      @filePath = path.join @tmpPath, 'sample.cson'
      @updater = (obj) ->
        for key, value of obj
          obj[key] = value + 1
        obj

    context 'filesystem error', ->
      beforeEach (done) ->
        fsCson.updateFile @filePath, @updater, (@err) => done()

      it 'returns an error', ->
        expect(@err).to.be.instanceOf Error
        expect(@err.stack).to.include @filePath
        expect(@err.stack).to.include 'ENOENT'

    context 'invalid cson', ->
      beforeEach (done) ->
        async.series [
          (next) => fs.writeFile @filePath, 'a:', next
          (next) => fsCson.updateFile @filePath, @updater, (@err) => next()
        ], done

      it 'returns an error', ->
        expect(@err).to.be.instanceOf Error
        expect(@err.stack).to.include @filePath
        expect(@err.stack).to.include 'a:'

    context 'valid cson', ->
      beforeEach (done) ->
        async.series [
          (next) => fs.writeFile @filePath, 'a: 1\nb: 2', next
          (next) => fsCson.updateFile @filePath, @updater, (@err) => next()
          (next) => fs.readFile @filePath, 'utf8', (err, @data) => next err
        ], done

      it 'does not return an error', ->
        expect(@err).to.not.exist

      it 'writes the updated data', ->
        expect(@data).to.eql 'a: 2\nb: 3'


  describe 'updateFileSync', ->
    beforeEach ->
      @filePath = path.join @tmpPath, 'sample.cson'
      @updater = (obj) ->
        for key, value of obj
          obj[key] = value + 1
        obj

    context 'filesystem error', ->
      beforeEach ->
        try
          fsCson.updateFileSync @filePath, @updater
        catch err
          @err = err

      it 'errors', ->
        expect(@err).to.be.instanceOf Error
        expect(@err.stack).to.include @filePath
        expect(@err.stack).to.include 'ENOENT'

    context 'invalid cson', ->
      beforeEach (done) ->
        async.series [
          (next) => fs.writeFile @filePath, 'a:', next
          (next) =>
            try
              fsCson.updateFileSync @filePath, @updater
            catch err
              @err = err
            finally
              next()
        ], done

      it 'returns an error', ->
        expect(@err).to.be.instanceOf Error
        expect(@err.stack).to.include 'a:'

    context 'valid cson', ->
      beforeEach (done) ->
        async.series [
          (next) => fs.writeFile @filePath, 'a: 1\nb: 2', next
          (next) =>
            fsCson.updateFileSync @filePath, @updater
            next()
          (next) => fs.readFile @filePath, 'utf8', (err, @data) => next err
        ], done

      it 'does not return an error', ->
        expect(@err).to.not.exist

      it 'writes the updated data', ->
        expect(@data).to.eql 'a: 2\nb: 3'

  describe 'writeFile', ->
    describe 'parent dir exists', ->
      beforeEach (done) ->
        @filePath = path.join @tmpPath, 'sample.cson'
        async.series [
          (next) => fsCson.writeFile @filePath, {a: 1, b: 2}, (@err) => next()
          (next) => fs.readFile @filePath, 'utf8', (err, @data) => next err
        ], done

      it 'does not return an error', ->
        expect(@err).to.not.exist

      it 'writes cson to the filesystem', ->
        expect(@data).to.eql '''
          a: 1
          b: 2
          '''

    describe 'parent dir does not exist', ->
      beforeEach (done) ->
        @filePath = path.join @tmpPath, 'non_existent', 'sample.cson'
        async.series [
          (next) => fsCson.writeFile @filePath, {a: 1, b: 2}, (@err) => next()
        ], done

      it 'returns an error', ->
        expect(@err).to.be.instanceOf Error
        expect(@err.stack).to.include @filePath
        expect(@err.stack).to.include 'ENOENT'


  describe 'writeFileSync', ->
    describe 'parent dir exists', ->
      beforeEach (done) ->
        @filePath = path.join @tmpPath, 'sample.cson'
        async.series [
          (next) =>
            fsCson.writeFileSync @filePath, {a: 1, b: 2}
            next()
          (next) => fs.readFile @filePath, 'utf8', (err, @data) => next err
        ], done

      it 'writes cson to the filesystem', ->
        expect(@data).to.eql '''
          a: 1
          b: 2
          '''

    describe 'parent dir does not exist', ->
      beforeEach ->
        @filePath = path.join @tmpPath, 'non_existent', 'sample.cson'
        try
          fsCson.writeFileSync @filePath, {a: 1, b: 2}
        catch err
          @err = err

      it 'errors', ->
        expect(@err).to.be.instanceOf Error
        expect(@err.stack).to.include @filePath
        expect(@err.stack).to.include 'ENOENT'
