mongoose          = require 'mongoose'
Schema            = mongoose.Schema
Movie             = require './movie'
mongoosePaginate  = require 'mongoose-paginate'

personSchema = new Schema
  name :
    type : String
    required : on
  career : [
    text :
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

personSchema.plugin mongoosePaginate

module.exports = mongoose.model 'Person', personSchema
