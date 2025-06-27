# Summary

**yyjson-nd** is a Lua binding to the yyjson C library that preserves the original JSON document structure and data types by representing JSON nodes as userdata objects, creating them on demand. Conversion to Lua tables and types happens lazily on access, minimizing data loss and improving performance compared to full eager decoding (unmarshalling).

When assigning a number to a field, the library attempts to store it as an integer if possible.

JSON array creation is currently unsupported

# Functions and constants

1. `load` - parses JSON into a read-only document
1. `load_mut` - parses JSON into a mutable document
1. `new` - creates a new mutable JSON document
1. `null` - null constant
1. `tostring(<mutable document>)` - serializes a mutable JSON object to a string

# Examples
```lua
yyjson = require("yyjson-nd")

j = yyjson.new() -- create an empty JSON document
j = yyjson.load(json_string) -- load JSON for read-only access (faster)
j = yyjson.load_mut(json_string) -- load JSON for modification

-- access fields
print(j.int32)
print(j.object.nested_object.inner_float)

-- modify and create new fields
j.uuid = nil -- delete
j.boolean = yyjson.null -- overwrite with null
j.newobject = {test = 1, test1 = {test2 = "test"}}
j.array[4] = 8 -- modify existing array
j.copy = j.object -- copy subtrees, even between different documents

-- serialize to JSON
tostring(j) -- full document
tostring(j.object) -- document part
```