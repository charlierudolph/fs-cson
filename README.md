# fs-cson
[![Build Status](https://img.shields.io/circleci/project/charlierudolph/fs-cson.svg)](https://circleci.com/gh/charlierudolph/fs-cson)
[![Dependency Status](https://img.shields.io/david/charlierudolph/fs-cson.svg)](https://david-dm.org/charlierudolph/fs-cson)
[![NPM Version](https://img.shields.io/npm/v/fs-cson.svg)](https://www.npmjs.com/package/fs-cson)

Read and write CSON to the filesystem, require CSON files


## Installation

```
npm install fs-cson
```

## API

#### readFile(filePath, callback)

Asynchronously reads the file and parses the contents.
The callback is passed two arguments `(err, data)`, where data is the parsed object.

Synchronous version: `readFileSync(filePath)`

Example
```coffee
# sample.cson
a: 1
b: 2

# read.coffee
fsCson = require 'fs-cson'

fsCson.readFile 'sample.cson', (err, data) ->
  # data will be {a: 1, b: 2}
```


---
#### register()

Allows cson files to be required.

```coffee
fsCson = require 'fs-cson'
fsCson.register()

# or

require 'fs-cson/register'
```


---
#### updateFile(filePath, updater, callback)

Asynchronously reads the file, parses the contents, calls updater, and writes the stringified object.
`updater` is passed on argument `(data)` and should return the updated data.
The callback is passed one argument `(err)`.

Synchronous version: `updateFileSync(filePath, updater)`

Example
```coffee
# sample.cson
a: 1
b: 2

# update.coffee
fsCson = require 'fs-cson'

updater = (data) ->
  result = {}
  for key, value in data
    result[key] = value * 2
  result.c = 6
  result

fsCson.updateFile 'sample.cson', (err) ->
  # sample.cson now has the content
  # a: 2
  # b: 4
  # c: 6
```


---
#### writeFile(filePath, object, callback)

Stringifies the object and then asynchronously writes to a file.
The callback is passed one argument `(err)`.

Synchronous version: `writeFileSync(filePath, object)`

```coffee
# write.coffee
fsCson = require 'fs-cson'

fsCson.writeFile 'sample.cson', {a: 1, b: 2}, (err) ->
  # sample.cson now has the content
  # a: 1
  # b: 2
```


---
#### writeFileSafe(filePath, object, callback)

Same as `writeFile` but creates parent directories if they do not exist.

Synchronous version: `writeFileSafeSync(filePath, object)`
