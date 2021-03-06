WebpackNotifierPlugin = require 'webpack-notifier'
ExtractTextPlugin     = require 'extract-text-webpack-plugin'
BrowserSyncPlugin     = require 'browser-sync-webpack-plugin'
webpack               = require 'webpack'
path                  = require 'path'
npmRoot               = path.join __dirname, './node_modules'
stylusRoot            = path.join __dirname, './client/stylus'
env                   = process.env.NODE_ENV

module.exports =
  entry :
    bundle : './client/coffee/main/main.coffee'
    vendor : [
      'angular'
      'satellizer'
      'ng-file-upload'
      'angular-permission'
      'angular-utils-pagination'
      'angular-loading-bar'
      'angular-jwt'
      'angular-ui-router'
      'angular-messages'
      'angular-animate'
      'angular-sanitize'
      'ng-tags-input'
      'npm/angular-strap/dist/angular-strap'
      'npm/angular-strap/dist/angular-strap.tpl'
      'npm/angular-ui-bootstrap/ui-bootstrap.min'
      'npm/angular-ui-bootstrap/ui-bootstrap-tpls.min'
      'npm/ui-select/dist/select.min'
      'npm/ng-elif/src/elif'
      'normalize.css'
      'npm/bootstrap/dist/css/bootstrap.css'
      'npm/angular-motion/dist/angular-motion.css'
      'npm/angular-loading-bar/build/loading-bar.css'
      'npm/ng-tags-input/build/ng-tags-input.css'
      'npm/ui-select/dist/select.css'
      'npm/ionicons/css/ionicons.css'
    ]
  output :
    path : "#{__dirname}/client/build"
    filename : '[name].js'
  watch : on unless env is 'production'
  watchOptions :
    aggregateTimeout : 100
  debug : on
  devtool : 'eval' unless env is 'production'
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
        loader : ExtractTextPlugin.extract 'style', 'css!cssnext'
      ,
        test : /\.styl$/
        loader : ExtractTextPlugin.extract 'style', 'css!cssnext!stylus'
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
  resolve :
    modulesDirectories : ['node_modules']
    alias :
      npm : npmRoot
      stylus : stylusRoot
    extensions : [
      ''
      '.js'
      '.coffee'
    ]
  resolveLoader :
    modulesDirectories : ['node_modules']
    moduleTemplates :    ['*-loader']
    extensions :         ['', '.js']
  plugins : [
    new ExtractTextPlugin '[name].css'
    new webpack.NoErrorsPlugin()
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
  ].concat if env is 'production' then [new webpack.optimize.UglifyJsPlugin()] else []
  cssnext :
    browsers : 'last 2 versions'
    features:
      rem : no
    compress : on if env is 'production'
    messages :
      console : on
