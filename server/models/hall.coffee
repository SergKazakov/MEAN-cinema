mongoose          = require 'mongoose'
Schema            = mongoose.Schema
mongoosePaginate  = require 'mongoose-paginate'
timestamps        = require 'mongoose-timestamp'
Cinema            = require '@models/cinema'

hallSchema = new Schema
  cinemaId :
    type : Schema.Types.ObjectId
    ref : 'Cinema'
    required : on
  totalSeatNumber : Number

hallSchema.plugin timestamps
hallSchema.plugin mongoosePaginate

module.exports = mongoose.model 'Hall', hallSchema
