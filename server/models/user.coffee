mongoose = require 'mongoose'
Schema   = mongoose.Schema
bcrypt   = require 'bcryptjs'

userSchema = new Schema
  email :
    type : String
    unique : on
    lowercase : on
  password :
    type : String
    select : no
  displayName : String
  picture :
    type : String
    default : 'http://placehold.it/100x100'
  role :
    type : String
    default : 'User'
    enum : ['User', 'Admin']
  facebook : String
  foursquare : String
  google : String
  github : String
  linkedin : String
  live : String
  yahoo : String
  twitter : String

userSchema.pre 'save', (next) ->
  user = @
  next() if not user.isModified 'password'
  bcrypt.genSalt 10, (err, salt) ->
    bcrypt.hash user.password, salt, (err, hash) ->
      user.password = hash
      next()

userSchema.methods.comparePassword = (password, done) ->
  bcrypt.compare password, this.password, (err, isMatch) ->
    done err, isMatch

module.exports = mongoose.model 'User', userSchema
