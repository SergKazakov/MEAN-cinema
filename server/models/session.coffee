mongoose          = require 'mongoose'
Schema            = mongoose.Schema
mongoosePaginate  = require 'mongoose-paginate'
timestamps        = require 'mongoose-timestamp'

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
sessionSchema.plugin mongoosePaginate

module.exports = mongoose.model 'Session', sessionSchema
