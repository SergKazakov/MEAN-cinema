mongoose          = require 'mongoose'
Schema            = mongoose.Schema
mongoosePaginate  = require 'mongoose-paginate'
timestamps        = require 'mongoose-timestamp'

hallSchema = new Schema
  name :
    type : String
    required : on
  cinema :
    type : Schema.Types.ObjectId
    ref : 'Cinema'
  priceList : [Number]
  plan : [
    type : Schema.Types.ObjectId
    ref : 'Seat'
  ]

hallSchema.plugin timestamps
hallSchema.plugin mongoosePaginate

module.exports = mongoose.model 'Hall', hallSchema
