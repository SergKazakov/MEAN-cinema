module.exports =
  [
    'user'
    'movie'
    'person'
    'cinema'
    'hall'
    'seat'
    'session'
  ].map (path) -> require("./#{path}")
