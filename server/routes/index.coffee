alias.require '@models'

module.exports = (app) ->
  [
    'auth/me'
    'auth/local'
    'auth/google'
    'auth/facebook'
    'auth/twitter'
    'auth/github'
    'auth/unlink'
    'api/movie'
    'api/person'
    'api/cinema'
    'api/hall'
    'api/session'
    'error'
  ].map (path) -> require("./#{path}") app
