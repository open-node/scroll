View        = require 'views/base/view'

module.exports = class ItemView extends View
  template: require './templates/item'
  tagName: 'section'
  className: 'page'
  autoRender: yes
