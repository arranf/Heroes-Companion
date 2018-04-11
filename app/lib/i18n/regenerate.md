## Regenerating the i18n files

The files in this directory are based on ../strings.dart
which defines all of the localizable strings used by the stocks
app. The stocks app uses
the [Dart `intl` package](https://github.com/dart-lang/intl).

Rebuilding everything requires two steps.

With the `/app` as the current directory, generate
`intl_messages.arb` from `lib/i8n/strings.dart`:

```
flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/i18n lib/i18n/strings.dart
```

The `intl_messages.arb` file is a JSON format map with one entry for
each `Intl.message()` function defined in `strings.dart`. The `intl_messages.arb` shouldn't
checked into the repository, since it only serves as a template for
the other `.arb` files.

With the `/app` as the current directory, generate a
`messages_<locale>.dart` for each `<locale>.arb` file and
`messages_all.dart`, which imports all of the messages files:

```
flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/i18n \ --no-use-deferred-loading lib/*.dart lib/i18n/*.arb
```

The `AppStrings` class uses the generated `initializeMessages()`
function (`messages_all.dart`) to load the localized messages
and `Intl.message()` to look them up.