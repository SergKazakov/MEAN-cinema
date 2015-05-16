WebpackNotifierPlugin = require 'webpack-notifier'
webpack               = require 'webpack'
autoprefixer          = require 'autoprefixer-core'
csswring              = require 'csswring'
path                  = require 'path'
bowerRoot             = path.join __dirname, 'client/bower_components'
stylusRoot            = path.join __dirname, 'client/stylus'

module.exports =
  entry : './client/coffee/main/main.coffee'
  output :
    path : "#{__dirname}/client/js"
    filename : 'bundle.js'
  cache : on
  watch : on
  debug : on
  devtool : 'source-map'
  module :
    preLoaders : [
        test : /\.coffee$/,
        exclude : /node_modules/
        loader : 'coffeelint-loader'
      ]
    ,
    loaders : [
        test : /\.coffee$/
        loader : 'coffee-loader'
      ,
        test : /\.css$/
        loader : 'style-loader!css-loader!postcss-loader'
      ,
        test : /\.styl$/
        loader : 'style-loader!css-loader!postcss-loader!stylus-loader'
      ,
        test : /\.(svg|eot|ttf|woff)/
        loader : 'url-loader'
      ,
        test : /\.html$/
        loader : "ngtemplate?relativeTo=#{path.resolve __dirname, './client' }/!html"
    ]
  resolve :
    alias :
      bower : bowerRoot
      stylus : stylusRoot
    extensions : [
      ''
      '.js'
      '.json'
      '.coffee'
    ]
  plugins : [
    new WebpackNotifierPlugin()
    new webpack.optimize.DedupePlugin()
  ]
  postcss : [
    autoprefixer
      browsers : ['last 2 version']
    csswring
  ]
