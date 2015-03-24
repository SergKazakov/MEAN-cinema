'use strict'

express    = require 'express'
router     = express.Router()
mongoose   = require 'mongoose'
Post       = require '../models/post'
Friend     = require '../models/friend'
UserApp    = require 'userapp'
async      = require 'async'

UserApp
.initialize appId: '54e0a91dd2235'
.setToken   'g4EkA_oqSrCw38SZXObpuw'

router
  .route '/user/:userId'
  .get (req, res) ->
    async.parallel [
      (cb) ->
        Post.find UserId: req.params.userId, (err, posts) ->
          throw err if err
          cb null, posts
      (cb) ->
        Friend.findOne UserId: req.params.userId, (err, user) ->
          throw err if err
          cb null, user
      (cb) ->
        UserApp.User.get 'user_id': req.params.userId, (err, user) ->
          throw err if err
          cb null, user[0]
    ], (err, results) ->
      throw err if err
      postsCount    = if results[0] then results[0].length else 0
      friendsCount  = if results[1] then results[1].Friends.length else 0
      profile       = results[2]
      res
      .status 200
      .send
        PostsCount:   postsCount
        FriendsCount: friendsCount
        UserName:     profile.first_name
        UserEmail:    profile.email

router
  .route '/friend/:friendId'
  .post (req, res) ->
    Friend.findOneAndUpdate
      UserId: req.body.userId
    ,
      $addToSet:
        Friends: req.params.friendId
    ,
      upsert: on,
      (err, friend) ->
        throw err if err
        res
          .status 200
          .send friend
  .put (req, res) ->
    Friend.findOneAndUpdate
      UserId: req.body.userId
    ,
      $pull: Friends: req.params.friendId
    ,
      (err, friend) ->
        throw err if err
        res.status(200).send friend

router
  .route '/users'
  .post (req, res) ->
    async.waterfall [
      (cb) ->
        UserApp.User.search
          fields: 'user_id',
          (err, users) ->
            throw err if err
            ids = []
            for i in users.items
              ids.push i.user_id
            cb null, ids
      (ids, cb) ->
        UserApp.User.get
          'user_id': ids,
          (err, users) ->
            cb null, users
      (users, cb) ->
        Friend.findOne
          UserId: req.body.userId,
          (err, friend) ->
            throw err if err
            if friend and friend.Friends.length
              for user in users
                for id in friend.Friends
                    user.properties.isFriend.value = on if user.user_id is id
            cb null, users
    ], (err, result) ->
      throw err if err
      res
        .status 200
        .send result

router
  .route '/post'
  .post (req, res) ->
    post = new Post req.body
    post.save (err, post) ->
      throw err if err
      res
        .status 200
        .send post

router
  .route '/post/:postId'
  .get (req, res) ->
    Post.findById mongoose.Types.ObjectId(req.params.postId),
      (err, post) ->
        throw err if err
        res
          .status 200
          .send post
  .put (req, res) ->
    Post.findOneAndUpdate
      _id: mongoose.Types.ObjectId req.params.postId
    ,
      $set:
        Title: req.body.Title
        Text: req.body.Text
    ,
      (err, post) ->
        throw err if err
        res
          .status 200
          .send post
  .delete (req, res) ->
    Post.remove
      _id: mongoose.Types.ObjectId req.params.postId
    ,
      (err) ->
        throw err if err
        res.sendStatus 200

router
  .route '/posts'
  .post (req, res) ->
    ids = []
    Friend.findOne
      UserId: req.body.userId
    ,
      (err, user) ->
        throw err if err
        ids = user.Friends if user and user.Friends.length
        ids.push req.body.userId
        Post
          .find UserId: $in: ids
          .sort DateCreation: -1
          .skip req.body.skipPages
          .limit req.body.pageSize
          .exec (err, posts) ->
            throw err if err
            if not req.body.skipPages
              Post.count
                UserId: $in: ids
              ,
                (err, postsCount) ->
                  throw err if err
                  res
                    .status 200
                    .send
                      posts: posts
                      postsCount: postsCount
            else
              res
                .status 200
                .send posts: posts

module.exports = (app) -> app.use '/api/v1', router
