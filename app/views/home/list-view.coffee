ItemView              = require './item-view'

tween = null

module.exports = class ListView extends Chaplin.CollectionView
  template: require './templates/list'
  autoRender: yes
  itemView: ItemView
  className: 'list'
  containerMethod: 'append'
  animationStartClass: no
  events:
    "click": "keyup"

  keyup: (e) ->
    return if e.charCode in [13, 27, 9]
    $el = @$el
    height = @$el.parent().height()
    length = @subviews.length
    init = ->
      tween = new TWEEN.Tween({x: 0})
        .to({x: -height * (length - 1)}, 100 * length)
        .repeat(3000)
        .onUpdate(-> $el.offset(top: @x))
        .start()
      debugger

    animate = ->
      requestAnimationFrame(animate)
      TWEEN.update()

    init()
    animate()


