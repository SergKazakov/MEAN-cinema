mongoose = require 'mongoose'
Schema   = mongoose.Schema
Movie    = require './movie'

personSchema = new Schema
  name :
    type : String
    required : on
  career : [
    type : String
    lowercase : on
    required : on
  ]
  birthdate :
    type : Date
    required : on
  birthPlace : String
  photo :
    type : String
    required : on
  movies : [
    type : Schema.Types.ObjectId
    ref : 'Movie'
  ]

module.exports = mongoose.model 'Person', personSchema
