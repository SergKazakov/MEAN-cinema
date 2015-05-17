blockUiConfig = (blockUIConfig) ->
  blockUIConfig.delay = 250
  blockUIConfig.templateUrl = require './block-ui.html'

blockUiConfig.$inject = ['blockUIConfig']

module.exports = blockUiConfig
