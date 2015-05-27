mongoose          = require 'mongoose'
Schema            = mongoose.Schema
mongoosePaginate  = require 'mongoose-paginate'
timestamps        = require 'mongoose-timestamp'

seatSchema = new Schema
  row : Number
  col : Number
  x : Number
  y : Number
  price : Number
  status :
    type : Number
    default : 1
    enum : [0, 1, 2]
    # 0 - disabled
    # 1 - free
    # 2 - busy

seatSchema.plugin timestamps
seatSchema.plugin mongoosePaginate

module.exports = mongoose.model 'Seat', seatSchema
