mongoose          = require 'mongoose'
Schema            = mongoose.Schema
mongoosePaginate  = require 'mongoose-paginate'
timestamps        = require 'mongoose-timestamp'
Movie             = alias.require '@models/movie'

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
  gender :
    type : String
    enum : ['male', 'female']
    required : on

personSchema.plugin timestamps
personSchema.plugin mongoosePaginate

module.exports = mongoose.model 'Person', personSchema
