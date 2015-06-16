module.exports =
  [
    'user'
    'movie'
    'person'
    'cinema'
    'hall'
    'seat'
    'session'
    'review'
  ].map (path) -> require("./#{path}")
