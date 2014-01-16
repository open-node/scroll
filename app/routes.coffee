# Application routes.
module.exports = (match) ->
  match '',         'home#index'
  match '!/:num',   'home#index'
