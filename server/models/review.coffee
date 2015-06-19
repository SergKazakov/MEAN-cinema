mongoose          = require 'mongoose'
Schema            = mongoose.Schema
mongoosePaginate  = require 'mongoose-paginate'
timestamps        = require 'mongoose-timestamp'

movieSchema = new Schema
  creator :
    type : Schema.Types.ObjectId
    ref : 'User'
    required : on
  rating :
    type : Number
    required : on
  headline :
    type : String
    required : on
  description :
    type : String
    required : on

movieSchema.plugin timestamps
movieSchema.plugin mongoosePaginate

module.exports = mongoose.model 'Review', movieSchema
