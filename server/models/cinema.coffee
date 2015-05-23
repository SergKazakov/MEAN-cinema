mongoose         = require 'mongoose'
Schema           = mongoose.Schema
mongoosePaginate = require 'mongoose-paginate'

cinemaSchema = new Schema
  name :
    type : String
    required : on
  poster : String
  description : String
  address :
    type : String
    required : on
  telephone : String
  website : String
  support3D : Boolean

cinemaSchema.plugin mongoosePaginate

module.exports = mongoose.model 'Cinema', cinemaSchema
