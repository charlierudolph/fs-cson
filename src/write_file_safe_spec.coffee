async = require 'async'
fs = require 'fs'
fsCson = require './'
path = require 'path'
tmp = require 'tmp'


describe 'fsCson', ->

  beforeEach (done) ->
    tmp.dir unsafeCleanup: yes, (err, @tmpPath) => done err

  describe 'writeFileSafe', ->
    describe 'parent dir exists', ->
      beforeEach (done) ->
        @filePath = path.join @tmpPath, 'sample.cson'
        async.series [
          (next) => fsCson.writeFileSafe @filePath, {a: 1, b: 2}, (@err) => next()
          (next) => fs.readFile @filePath, 'utf8', (err, @data) => next err
        ], done

      it 'does not return an error', ->
        expect(@err).to.not.exist

      it 'writes cson to the filesystem', ->
        expect(@data).to.eql 'a: 1\nb: 2\n'

    describe 'parent dir does not exist', ->
      beforeEach (done) ->
        @filePath = path.join @tmpPath, 'non_existent', 'sample.cson'
        async.series [
          (next) => fsCson.writeFileSafe @filePath, {a: 1, b: 2}, (@err) => next()
          (next) => fs.readFile @filePath, 'utf8', (err, @data) => next err
        ], done

      it 'does not return an error', ->
        expect(@err).to.not.exist

      it 'writes cson to the filesystem', ->
        expect(@data).to.eql 'a: 1\nb: 2\n'


  describe 'writeFileSafeSync', ->
    describe 'parent dir exists', ->
      beforeEach (done) ->
        @filePath = path.join @tmpPath, 'sample.cson'
        async.series [
          (next) =>
            fsCson.writeFileSafeSync @filePath, {a: 1, b: 2}
            next()
          (next) => fs.readFile @filePath, 'utf8', (err, @data) => next err
        ], done

      it 'writes cson to the filesystem', ->
        expect(@data).to.eql 'a: 1\nb: 2\n'

    describe 'parent dir does not exist', ->
      beforeEach (done) ->
        @filePath = path.join @tmpPath, 'non_existent', 'sample.cson'
        async.series [
          (next) =>
            fsCson.writeFileSafeSync @filePath, {a: 1, b: 2}
            next()
          (next) => fs.readFile @filePath, 'utf8', (err, @data) => next err
        ], done

      it 'writes cson to the filesystem', ->
        expect(@data).to.eql 'a: 1\nb: 2\n'
