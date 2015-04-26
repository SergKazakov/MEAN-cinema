jwt     = require 'jwt-simple'
moment  = require 'moment'
conf    = require '../../config/config'

module.exports = (req, res, next) ->
  if not req.headers.authorization
    return res
      .status 401
      .send message : 'Please make sure your request has an Authorization header'
  token = req.headers.authorization.split(' ')[1]
  payload = jwt.decode token, conf.tokenSecret
  if payload.exp <= moment().unix()
    return res.status(401).send message : 'Token has expired'
  req.user = payload.sub
  next()
