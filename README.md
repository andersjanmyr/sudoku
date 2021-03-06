# Sudoku

[![Build Status](https://travis-ci.org/andersjanmyr/sudoku.png?branch=master)](https://travis-ci.org/andersjanmyr/sudoku)

Sudoku is a program for solving sudoku, written in Coffeescript.

## Installation

```
$ npm install -g sudoku-coffee
```

## Usage

```
$ sudoku
Usage: sudoku <filename> or sudoku <gen> [difficulty] [symmetric|shuffled]
```

### Solving

To run the file use the binary `sudoku filename`.
The file should have a row with 9 chars per file and 9 rows.

```
$ cat test/fixtures/easy.sudoku
51.....83
8..416..5
.........
.985.461.
...9.1...
.642.357.
.........
6..157..4
78.....96

$ sudoku test/fixtures/easy.sudoku
Solving board
51.....83
8..416..5
.........
.985.461.
...9.1...
.642.357.
.........
6..157..4
78.....96

Solution
516729483
873416925
942835761
398574612
257961348
164283579
431698257
629157834
785342196
Difficulty: 0
```

### Generating

To generate a new sudoku, run `sudoku generate` and it will generate a new
sudoku.

```
$ sudoku generate
2..7.9.4.
.8...4.67
.4.2.....
7....54..
.5....9.6
...9.35.8
8.5..7..1
...318...
.7...28..
```

## Development

```
$ git clone https://github.com/andersjanmyr/sudoku.git
$ cd sudoku
$ npm install
```

### Test

```
# Run all tests
$ npm test

# Watch files and run tests when files change
$ npm run watch
```

### Running

Five different files are preconfigured to be run with `npm run`, *easy*,
*medium*, *hard*, *samurai*, and *impossible*. The files can be found in
`test/fixtures`.

```
$ npm run samurai

> sudoku@0.0.0 samurai /home/CORPUSERS/23053085/tmp/sudoku
> bin/sudoku test/fixtures/samurai.sudoku

Solving board
5.....1.7
..43..5..
...2...8.
...2...8.
.9.4.2...
4.......6
...1.3.5.
.8...4...
3.9.....1

Solution
528946137
914387562
673215489
165239784
897462315
435711296
246173958
781654923
359828641
Difficulty: 13
```

