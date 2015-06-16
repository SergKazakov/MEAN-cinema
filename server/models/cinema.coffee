mongoose          = require 'mongoose'
Schema            = mongoose.Schema
mongoosePaginate  = require 'mongoose-paginate'
timestamps        = require 'mongoose-timestamp'
deepPopulate      = require 'mongoose-deep-populate'

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
  reviews : [
    type : Schema.Types.ObjectId
    ref : 'Review'
  ]
  address :
    type : String
    required : on
  location :
    latitude : Number
    longitude : Number


cinemaSchema.plugin timestamps
cinemaSchema.plugin mongoosePaginate
cinemaSchema.plugin deepPopulate,
  whitelist : [
    'halls'
    'reviews'
    'reviews.creator'
  ]

module.exports = mongoose.model 'Cinema', cinemaSchema
