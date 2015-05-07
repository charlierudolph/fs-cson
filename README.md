# fs-cson

Read and write CSON to the filesystem


### Installation

```
npm install fs-cson
```

### API

# readFile(filePath, callback)

Asynchronously reads the file and parses the contents.
The callback is passed two arguments `(err, data)`, where data is the parsed object.

Example
```
# sample.cson
a: 1
b: 2

# read.coffee
fsCson = require 'fs-cson'

fsCson.readFile 'sample.cson', (err, data) ->
  # data will be {a: 1, b: 2}
```


# readFileSync(filePath)

Synchronous version of readFile


# writeFile(filePath, object, callback)

Stringifies the object and then asynchronously writes to a file.
The callback is passed one argument `(err)`.

```
# write.coffee
fsCson = require 'fs-cson'

fsCson.writeFile 'sample.cson', {a: 1, b: 2}, (err) ->
  # sample.cson now has the content
  # a: 1
  # b: 2
```


# writeFileSync(filePath)

Synchronous version of readFile
