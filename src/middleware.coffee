path = require 'path'
serveStatic = require 'serve-static'
chain = require 'connect-chain'

module.exports = (assets) ->

  assetHelperMiddleware = (req, res, next) ->
    res.locals.assetPath = assets.assetPath.bind(assets)
    next()
  
  if process.env.NODE_ENV is 'production'
    chain assetHelperMiddleware, serveStatic(path.join(process.cwd(), 'build/public'), maxAge: '365d')
  else
    chain assetHelperMiddleware, serveStatic(path.join(process.cwd(), 'public'))

