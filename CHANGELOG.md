## 0.0.4
- Set optional `url` in `Ipfs` factory constructor to not overwrite previous value if left unset.

## 0.0.3
- Fix docstring for `Ipfs` class.
- Move statement in example file ('example/main.dart') inside `print()`.

## 0.0.2
- [**BREAKING CHANGE**] Privated methods that where previously public (`fileFormData()`, `post()`, `interceptDioResponse()`, etc.).
- Remove export file 'lib/command.dart'.
- Correclty add files in 'lib/command/*' as parts for library.
- Remove unused `get()` method.
- Add example at 'example/main.dart'.

## 0.0.1
- Initial release.