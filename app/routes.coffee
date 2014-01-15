# Application routes.
module.exports = (match) ->
  match '', 'home#index'
  match '!', 'home#index'
