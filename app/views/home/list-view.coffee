CollectionView        = require 'views/base/collection-view'
ItemView              = require './item-view'

tween = null
playInt = null

module.exports = class ListView extends CollectionView
  template: require './templates/list'
  autoRender: yes
  itemView: ItemView
  listSelector: "div.list"

  scrolling: no
  containerMethod: 'append'
  animationStartClass: no
  events:
    "click": "keyup"
    "click .btn.init": "initScroll"
    "click .btn.slow-show": "slowShow"

  # 初始化抽奖数据，主要是清空localStorage
  initScroll: (e) ->
    e.stopPropagation()
    localStorage.setItem 'list', ''

  # 慢速度播放所有图片
  slowShow: (e) ->
    $el = @$el
    e.stopPropagation()
    $(e.currentTarget).toggleClass "active"
    @isSlowShow = not @isSlowShow
    return clearInterval(playInt) if not @isSlowShow
    # 单页滚动的时间, 单位毫秒
    length = @subviews.length - 1
    height = @$el.parent().height()
    DurationPerOne = 400
    startTop = 0
    endTop = -height
    init = ->
      tween = new TWEEN.Tween({x: startTop})
        .to({x: endTop}, DurationPerOne)
        .onUpdate(-> $el.offset(top: @x))
        .start()
      if endTop is -height * length
        $el.offset(top: 0)
        startTop = 0
      else
        startTop = endTop
      endTop = startTop - height

    animate = ->
      requestAnimationFrame(animate)
      TWEEN.update()

    playInt = setInterval ->
      init()
      animate()
    , 2000

  initialize: ->
    $(document).on 'keyup', @keyup
    super

  remove: ->
    $(document).off 'keyup', @keyup

  stop: ->
    $el = @$el

    # 停下来
    @scrolling = no
    tween.stop()

    # 添加stop样式，让中奖后的操作按钮出现
    $el.addClass "stop"
    @stopAfter()

  stopAfter: =>
    $el = @$el

    height = @$el.parent().height()
    length = @subviews.length - 1
    top = $el.position().top
    mod = Math.abs top % height
    finish = top - height + mod
    finish = height * length if finish > height * length
    $el.offset(top: finish)

  keyup: (e) =>
    me = @
    $el = @$el

    # 慢速播放中，不能抽奖，请先切换状态
    return if @isSlowShow

    # 中奖了需要先处理中奖
    return if $el.hasClass "stop"

    return if e.keyCode in [13, 82, 91]
    return @stop() if @scrolling is yes
    @collection.models = _.shuffle @collection.models
    @renderAllItems()

    # 去掉stop样式，让中奖后的操作按钮消失
    $el.removeClass "stop"

    # 单页滚动的时间, 单位毫秒
    DurationPerOne = 50
    length = @subviews.length - 1
    height = $el.parent().height()

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
