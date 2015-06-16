mongoose          = require 'mongoose'
Schema            = mongoose.Schema
mongoosePaginate  = require 'mongoose-paginate'
timestamps        = require 'mongoose-timestamp'
deepPopulate      = require 'mongoose-deep-populate'

movieSchema = new Schema
  name :
    type : String
    required : on
  originalName :
    type : String
    required : on
  poster :
    type : String
    required : on
  trailer : [
    type : String
  ]
  genre : [
    text :
      type : String
      lowercase : on
      required : on
  ]
  synopsis :
    type : String
    required : on
  duration :
    type : Number
    required : on
  ageRating :
    type : Number
    default : 0
  rating :
    type : Number
    default : 0
  country :
    type : String
    required : on
  releaseDate :
    type : Date
    default : Date.now
  finishDate :
    type : Date
    default : Date.now
  directors : [
    type : Schema.Types.ObjectId
    ref : 'Person'
  ]
  actors : [
    type : Schema.Types.ObjectId
    ref : 'Person'
  ]
  reviews : [
    type : Schema.Types.ObjectId
    ref : 'Review'
  ]

movieSchema.plugin timestamps
movieSchema.plugin mongoosePaginate
movieSchema.plugin deepPopulate,
  whitelist : [
    'directors'
    'actors'
    'reviews'
    'reviews.creator'
  ]

module.exports = mongoose.model 'Movie', movieSchema
