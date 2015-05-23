mongoose          = require 'mongoose'
Schema            = mongoose.Schema
mongoosePaginate  = require 'mongoose-paginate'
Movie             = require './movie'

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
