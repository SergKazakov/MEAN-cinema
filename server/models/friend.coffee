'use strict'

mongoose = require 'mongoose'
Schema   = mongoose.Schema

friendSchema = new Schema
  UserId:  String
  Friends: []

module.exports = mongoose.model 'Friend', friendSchema
