mongoose = require 'mongoose'
Schema   = mongoose.Schema
Person   = require './person'
User     = require './user'

movieSchema = new Schema
  name :
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
  directors : [
    type :
      Schema.Types.ObjectId
    ref : 'Person'
  ]
  actors : [
    type :
      Schema.Types.ObjectId
    ref : 'Person'
    role : String
  ]
  likes : [
    type :
      Schema.Types.ObjectId
    ref : 'User'
  ]
  dislikes : [
    type :
      Schema.Types.ObjectId
    ref : 'User'
  ]

module.exports = mongoose.model 'Movie', movieSchema
