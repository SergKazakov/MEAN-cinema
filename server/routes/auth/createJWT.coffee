jwt     = require 'jwt-simple'
moment  = require 'moment'
conf    = alias.require '@config'

module.exports = (user) ->
  payload =
    sub : user._id
    iat : moment().unix()
    exp : moment().add(14, 'days').unix()
  jwt.encode payload, conf.tokenSecret
