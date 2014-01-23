View        = require 'views/base/view'

module.exports = class ItemView extends View
  template: require './templates/item'
  tagName: 'section'
  className: 'page'
  autoRender: yes
  events:
    "click .btn.ok": "enter" # 确认中奖，将中奖者剔除
    "click .btn.cancel": "cancel" # 放弃中奖，不进行任何操作

  cancel: (e) ->
    e.stopPropagation()
    @$el.parents('.list').removeClass('stop')

  enter: (e) ->
    debugger
    e.stopPropagation()
    list = _.uniq (localStorage.getItem('list') or '').split(',')
    list = _.filter(list, (x) -> x)
    list.push @model.id
    localStorage.setItem('list', list.join(','))
    @$el.parents('.list').removeClass('stop')
    @model.collection.remove @model

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

