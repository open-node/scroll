ItemView              = require './item-view'

tween = null

module.exports = class ListView extends Chaplin.CollectionView
  template: require './templates/list'
  autoRender: yes
  itemView: ItemView
  className: 'list'
  scrolling: no
  containerMethod: 'append'
  animationStartClass: no
  events:
    "click": "keyup"

  stop: ->
    tween.stop()
    @scrolling = no

  keyup: (e) ->
    return @stop() if @scrolling is yes
    $el = @$el
    height = @$el.parent().height()
    DurationPerOne = 50
    length = @subviews.length - 1
    init = ->
      tween = new TWEEN.Tween({x: 0})
        .to({x: -height * length}, DurationPerOne * length)
        .repeat(Infinity)
        .onUpdate(-> $el.offset(top: @x))
        .start()

    animate = ->
      requestAnimationFrame(animate)
      TWEEN.update()

    init()
    animate()
    @scrolling = yes


