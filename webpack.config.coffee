module.exports = 
  entry : './client/coffee/main.coffee'
  output :
    path : './client/js'
    filename: 'bundle.js'
  debug : on
  devtool : 'source-map' 
  module:
#     preLoaders: [
#         test : /\.coffee$/,
#         exclude : /node_modules/
#         loader : 'coffeelint-loader'
#       ]
#     ,
    loaders : [
        test : /\.coffee$/
        loader : 'coffee-loader'
      ,
        test : /\.css$/
        loader : 'style-loader!css-loader'
      ,
        test : /\.styl$/
        loader : 'style-loader!css-loader!stylus-loader'
      ,
        test : /\.(svg|eot|ttf|woff)/
        loader : 'url-loader'
    ]
  resolve :
    extensions : [
      ''
      '.js'
      '.json'
      '.coffee'
    ]