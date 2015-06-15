module.exports = (req, res, next) ->
  if req.user.role is 'Admin' then next() else res.status(401).send message : 'Forbidden'
