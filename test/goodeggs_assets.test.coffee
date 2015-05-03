require 'mocha-sinon'
expect = require('chai').expect

assetsInstance = require '..'
GoodeggsAssets = assetsInstance.constructor

describe 'goodeggs-assets', ->
  {assets} = {}

  it 'exports a singleton', ->
    expect(assetsInstance).to.be.an.instanceof GoodeggsAssets

  it 'exports middleware', ->
    expect(assetsInstance).to.have.property 'middleware'

  describe 'development (without manifest)', ->

    beforeEach ->
      assets = GoodeggsAssets.build()

    describe 'assetPath', ->

      it 'echos back', ->
        expect(assets.assetPath('/img/banana.gif')).to.equal '/img/banana.gif'

  describe 'production (with manifest)', ->

    beforeEach ->
      assets = GoodeggsAssets.build {'img/banana.gif': 'img/banana-55283dd8.gif'}

    describe 'assetPath', ->

      it 'translates a known asset', ->
        expect(assets.assetPath('/img/banana.gif')).to.equal '/img/banana-55283dd8.gif'

      it 'echos back an unknown asset', ->
        expect(assets.assetPath('/img/apple.gif')).to.equal '/img/apple.gif'

