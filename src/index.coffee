path = require 'path'
middleware = require './middleware'

class GoodeggsAssets

  @build: ({manifest, config}={}) ->
    assets = new @ {manifest, config}
    assets.middleware = ->
      middleware(assets)
    assets

  constructor: ({@manifest, @config}) ->
    @manifest ?= {}

  assetPath: (absPath) ->
    relPath = absPath[1..]
    if versionedPath = @manifest[relPath]
      "/#{versionedPath}"
    else
      absPath


# set up our runtime singleton
config = try require(path.join(process.cwd(), 'Assetfile'))
manifest = switch process.env.NODE_ENV
  when 'production'
    require(path.join(process.cwd(), config.dest.manifest))
  else
    {}

module.exports = GoodeggsAssets.build {config, manifest}

