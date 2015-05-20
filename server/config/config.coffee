module.exports =
  port : process.env.PORT or 3000
  mongoUrl : process.env.MONGO_URL or 'mongodb://localhost/cinema'
  tokenSecret : process.env.TOKEN_SECRET or 'A hard to guess string'
  googleSecret : process.env.GOOGLE_SECRET or '99sV-h9AJxgQS-Wj5UASECgU'
  facebookSecret : process.env.FACEBOOK_SECRET or '4c999318d9cc99b18a404f554084e98b'
  twitterKey : process.env.TWITTER_KEY or 'vKhGVGsnCRHV5qKO3g0b8jTSa'
  twitterSecret : process.env.TWITTER_SECRET or '9L0UdrluqoHDs8RorFrlL7P6Hv751iuEeJL3ke4AsVoTw861Ym'
  twitterCallback : process.env.TWITTER_CALLBACK or 'http://localhost:3000'
  githubSecret : process.env.GITHUB_SECRET or '6038e35e20e6b4fc86e7a0694329eee7f8cf9814'
