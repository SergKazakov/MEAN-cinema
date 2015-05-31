mongoose     = require 'mongoose'
Schema       = mongoose.Schema
deepPopulate = require 'mongoose-deep-populate'
timestamps   = require 'mongoose-timestamp'

sessionSchema = new Schema
  movie :
    type : Schema.Types.ObjectId
    ref : 'Movie'
    required : on
  hall :
    type : Schema.Types.ObjectId
    ref : 'Hall'
  date :
    type : Date
    default : Date.now
  format :
    type : String
    default : '2D'
    enum : ['2D', '3D', 'IMAX 2D', 'IMAX 3D']

sessionSchema.plugin timestamps
sessionSchema.plugin deepPopulate,
  whitelist : [
    'movie'
    'hall'
    'hall.cinema'
  ]

module.exports = mongoose.model 'Session', sessionSchema
