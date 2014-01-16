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

  initialize: ->
    $(document).on 'keyup', @keyup
    super

  remove: ->
    $(document).off 'keyup', @keyup

  stop: ->
    @scrolling = no
    tween.stop()
    # 停下来
    $el = @$el
    height = @$el.parent().height()
    top = $el.position().top
    mod = Math.abs top % height
    $el.offset(top: top - height + mod)

  keyup: (e) =>
    return if e.keyCode in [82, 91]
    return @stop() if @scrolling is yes
    @collection.models = _.shuffle @collection.models
    @renderAllItems()
    me = @
    $el = @$el
    height = @$el.parent().height()
    # 单页滚动的时间, 单位毫秒
    DurationPerOne = 50
    length = @subviews.length - 1
    init = ->
      tween = new TWEEN.Tween({x: 0})
        .to({x: -height * length}, DurationPerOne * length)
        .repeat(Infinity)
        #.easing(TWEEN.Easing.Circular.Out)
        .onUpdate(-> $el.offset(top: @x))
        .start()

    animate = ->
      requestAnimationFrame(animate)
      TWEEN.update()

    init()
    animate()
    @scrolling = yes


