package = "yyjson-nd"
version = "scm-1"

source = {
  url = "git+https://github.com/thedolphin/lua-yyjson-nd.git",
}

description = {
  summary = "Non-destructive Lua binding for yyjson",
  detailed = [[
    yyjson-nd is a Lua binding to the yyjson C library that preserves the original JSON
    document structure and data types by representing JSON nodes as userdata objects.
    Conversion to Lua tables and types happens lazily on access, minimizing data loss
    and improving performance compared to full eager decoding.
  ]],
  homepage = "https://github.com/thedolphin/lua-yyjson-nd",
  license = "MIT"
}

dependencies = {
  "lua >= 5.1"
}

build = {
  type = "command",
  build_command = [[
    git submodule update --init --recursive &&
    mkdir yyjson.build && (cd yyjson.build && cmake ../yyjson && make) &&
    gcc -O2 -fPIC -I$(LUA_INCDIR) -Iyyjson/src -c lua_yyjson.c -o lua_yyjson.o &&
    gcc -shared -o yyjson-nd.so lua_yyjson.o yyjson.build/libyyjson.a
  ]],
  install = {
    lib = {
      ["yyjson-nd"] = "yyjson-nd.so"
    }
  }
}
