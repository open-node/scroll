View        = require 'views/base/view'

module.exports = class ItemView extends View
  template: require './templates/item'
  tagName: 'section'
  className: 'page'
  autoRender: yes

  initialize: ->
    $(window).on('resize', @resize)
    super

  resize: =>
    @$el.height($('#page-container').height())

  remove: ->
    $(window).off('resize', @resize)
    super

  render: ->
    super
    @resize()

