mongoose         = require 'mongoose'
Schema           = mongoose.Schema
mongoosePaginate = require 'mongoose-paginate'
timestamps       = require 'mongoose-timestamp'
Hall             = alias.require '@models/Hall'

cinemaSchema = new Schema
  name :
    type : String
    required : on
  poster : String
  description : String
  telephone : String
  website : String
  support3D : Boolean
  halls : [
    type : Schema.Types.ObjectId
    ref : 'Hall'
  ]
  address :
    type : String
    required : on
  location :
    latitude : Number
    longitude : Number


cinemaSchema.plugin timestamps
cinemaSchema.plugin mongoosePaginate

module.exports = mongoose.model 'Cinema', cinemaSchema
