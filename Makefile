check: get format analyze

get:
	dart pub get

format:
	dart format . --set-exit-if-changed

analyze:
	dart analyze --fatal-infos

tests:
	dart run coverage:test_with_coverage
