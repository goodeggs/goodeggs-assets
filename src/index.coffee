path = require 'path'
middleware = require './middleware'

class GoodeggsAssets

  @build: (manifest) ->
    assets = new @ manifest
    assets.middleware = middleware(assets)
    assets

  constructor: (@_manifest={}) ->
    # noop

  assetPath: (absPath) ->
    relPath = absPath[1..]
    if versionedPath = @_manifest[relPath]
      "/#{versionedPath}"
    else
      absPath

module.exports = GoodeggsAssets.build \
  switch process.env.NODE_ENV
    when 'production'
      require(path.join(process.cwd(), 'build/rev-manifest.json'))
    else
      {}

