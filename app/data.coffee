module.exports = (num) ->
  _.shuffle _.map [1..num], (x) ->
    logo: "./data/#{x}.jpg"
    text: "Number #{x}."
