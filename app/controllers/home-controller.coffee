Controller      = require 'controllers/base/controller'
HeaderView      = require 'views/home/header-view'
HomePageView    = require 'views/home/home-page-view'
Collection      = require 'models/base/collection'
ListView        = require 'views/home/list-view'
data            = require 'data'

module.exports = class HomeController extends Controller
  beforeAction: ->
    super
    @compose 'header', HeaderView, region: 'header'

  index: ->
    listView = new ListView
      collection: new Collection data
      container: $('#page-container')

