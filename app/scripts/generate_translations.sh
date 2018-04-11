# Described in /lib/i18n/regenerate.md
flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/i18n lib/i18n/strings.dart
cd lib/i18n
./convert_to_pot.py
cd ../..
flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/i18n \ --no-use-deferred-loading lib/*.dart lib/i18n/*.arb