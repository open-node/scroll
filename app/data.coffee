module.exports = (num) ->
  list = (localStorage.getItem('list') or '').split(',')
  list = _.map(list, (x) -> +x)
  list = _.filter(list, (x) -> x)
  res = _.map([1..num], (x) ->
    id: x
    logo: "./data/#{x}.jpg"
    text: "Number #{x}."
  )
  res = _.filter(res, (x) -> x.id not in list)

  _.shuffle res
