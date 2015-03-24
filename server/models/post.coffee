'use strict'

mongoose = require 'mongoose'
Schema   = mongoose.Schema

postSchema = new Schema
  UserId:       String
  UserName:     String
  Title:        String
  Text:         String
  DateCreation: Number

module.exports = mongoose.model 'Post', postSchema

