class Board
  constructor: (@coords) ->

  @fromString: (data) ->
    coords = data.split('\n').map (line) ->
      line.split('')
    new Board(coords)

  @rowCoords: (row) ->
    [row, col] for col in [1..9]

  @colCoords: (col) ->
    [row, col] for row in [1..9]

  @base: (val) ->
    return 0 if val <=3
    return 3 if val <=6
    return 6

  @boxCoords: (row, col) ->
    rowBase = @base row
    colBase = @base col

    [rowBase+r, colBase+c] for [r, c] in [[1, 1], [2, 1], [3, 1], [1, 2],
          [2, 2], [3, 2], [1, 3], [2, 3], [3, 3]]

  @allCoords: ->
    nested = for r in [1..9]
      for c in [1..9]
        [r, c]
    [].concat nested...


  value: (row, col, v) ->
    return @coords[row-1][col-1] unless v
    @coords[row-1][col-1] = v

  values: (coords) ->
    @value(r, c) for [r, c] in coords

  unique: (values) ->
    index = {}
    for v in values when not (v of index or v is '.')
      index[v] = true
      v

  availableValues: (takenValues) ->
    "#{v}" for v in [1..9] when "#{v}" not in takenValues

  possibleValues: (row, col) ->
    val = @value row, col
    return null unless val is '.'
    rs = @values Board.rowCoords(row)
    cs = @values Board.colCoords(col)
    bs = @values Board.boxCoords(row, col)
    takenValues = @unique(rs.concat(cs, bs))
    @availableValues(takenValues)

  toString: ->
    lines = @coords.map (row) ->
      row.join ''
    lines.join '\n'

  copy: ->
    coords = @coords.map (row) ->
      row.slice()
    new Board(coords)

module.exports = Board

