ItemView              = require './item-view'

module.exports = class ListView extends Chaplin.CollectionView
  template: require './templates/list'
  autoRender: yes
  itemView: ItemView
  containerMethod: 'append'

