WebpackNotifierPlugin = require 'webpack-notifier'
BrowserSyncPlugin     = require 'browser-sync-webpack-plugin'
webpack               = require 'webpack'
path                  = require 'path'
bowerRoot             = path.join __dirname, 'client/bower_components'
stylusRoot            = path.join __dirname, 'client/stylus'
env                   = process.env.NODE_ENV

plugins = [
  new WebpackNotifierPlugin()
  new webpack.optimize.DedupePlugin()
  new webpack.DefinePlugin
    process :
      env :
        FACEBOOK_ID : JSON.stringify '1653435961554069'
        GOOGLE_ID : JSON.stringify '476828247245-ve3nh4f0fbcg0elggblkvctse9a26821.apps.googleusercontent.com'
        GITHUB_ID : JSON.stringify 'fdf1e069c66bb5a88004'
        TWITTER_URL : JSON.stringify '/auth/twitter'
  new BrowserSyncPlugin
    proxy : 'http://localhost:3000'
    port : 7000
    files : ['./client/js/bundle.js']
    open : no
]

plugins.push new webpack.optimize.UglifyJsPlugin() if env is 'production'

module.exports =
  entry : './client/coffee/main/main.coffee'
  output :
    path : "#{__dirname}/client/build"
    filename : 'bundle.js'
  cache : on
  watch : on unless env is 'production'
  debug : on
  devtool : 'eval'
  module :
    preLoaders : [
      test : /\.coffee$/
      exclude : /node_modules/
      loader : 'coffeelint'
    ]
    loaders : [
        test : /\.coffee$/
        loader : 'coffee'
      ,
        test : /\.css$/
        loader : 'style!css!cssnext'
      ,
        test : /\.styl$/
        loader : 'style!css!cssnext!stylus'
      ,
        test : /\.(png|jpg|gif|svg)/
        loader : 'url?limit=8192&name=img/[name].[ext]'
      ,
        test : /\.(eot|ttf|woff)/
        loader : 'url'
      ,
        test : /\.jade$/
        loader : 'ng-cache?prefix=[dir]/[dir]!jade-html'
    ]
    noParse : [
      path.join bowerRoot, '/angular'
      path.join bowerRoot, '/angular-route'
      path.join bowerRoot, '/angular-ui-router'
      path.join bowerRoot, '/angular-mocks'
      path.join bowerRoot, '/jquery'
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
  plugins : plugins
  cssnext :
    browsers : 'last 2 versions'
    features:
      rem : no
    compress : on if env is 'production'
    messages :
      console : on
