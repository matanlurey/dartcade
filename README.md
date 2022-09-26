# dartcade

A simple set of terminal-based arcade games written in pure Dart.

<!-- ENABLE WHEN PUBLISHED
[![On pub.dev][pub_img]][pub_url]
[![Code coverage][cov_img]][cov_url]
[![Dartdocs][doc_img]][doc_url]
-->

[![Github action status][gha_img]][gha_url]
[![Style guide][sty_img]][sty_url]

<!-- ENABLE WHEN PUBLISHED
[pub_url]: https://pub.dartlang.org/packages/dartcade
[pub_img]: https://img.shields.io/pub/v/dartcade.svg
[cov_url]: https://codecov.io/gh/matanlurey/dartcade
[cov_img]: https://codecov.io/gh/matanlurey/dartcade/branch/main/graph/badge.svg
[doc_url]: https://www.dartdocs.org/documentation/dartcade/latest
[doc_img]: https://img.shields.io/badge/Documentation-dartcade-blue.svg
-->

[gha_url]: https://github.com/matanlurey/dartcade/actions
[gha_img]: https://github.com/matanlurey/dartcade/workflows/Dart/badge.svg
[sty_url]: https://pub.dev/packages/neodart
[sty_img]: https://img.shields.io/badge/style-neodart-9cf.svg

## Purpose

I was developing some simple 2D UI libraries (such as [`package:griddle`][],
[`package:neokeys`][]), and I wanted a few motivating examples to make sure I
was on the right track and the libraries were providing the right kinds of
abstractions.

[`package:griddle`]: https://pub.dev/packages/griddle
[`package:neokeys`]: https://pub.dev/packages/neokeys

## Usage

Currently, you have two options: clone and build, or use [`dart pub global`][]:

```sh
# Clone and build from source.
git clone https://github.com/matanlurey/dartcade
cd dartcade
dart run :pong

# Activate the set of games.
dart pub global activate -sgit https://github.com/matanlurey/dartcade
dart pub global run dartcade:pong
```

[`dart pub global`]: https://dart.dev/tools/pub/cmd/pub-global
