.PHONY: integration test

integration:
	@(cd example && flutter test \
		--coverage \
		integration_test/app_test.dart)

test:
	@flutter test test/country_picker_test.dart
