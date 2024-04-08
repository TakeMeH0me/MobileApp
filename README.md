<a name="readme_top"></a>

# take_me_home

## Getting Started

1. Clone the repository

   ```sh
   git clone https://github.com/TakeMeH0me/take_me_home.git
   ```

2. Install the dependencies

   ```sh
   flutter pub get
   ```

3. Start the app! :)

<p align="right">(<a href="#readme_top">back to top</a>)</p>

## Development

- Verwendung der Stable-Flutter-Version:
  ```bash
  flutter channel stable
  flutter updrade
  ```

### Formatting

- Install VSCode-Extension: [Flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)
- Adjust settings to automatically format on save: `editor.formatOnSave` setting to `true`
- Make sure to only use package imports before submitting a PR. (not relative ones)

<p align="right">(<a href="#readme_top">back to top</a>)</p>

## 🧪 Testing

We use [Mocktail](https://pub.dev/packages/mocktail) in combination with [FlutterTest](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html) for testing.

How to add and run new tests?

1. Create a new file in the `test` folder. The name of the file should be `name_of_the_file_test.dart`. The structure of the test directory should be mirrored to the `lib` directory to keep the structure clean and understandable.
2. Import the needed libraries. (The automatic import does not work all the time sadly)

   ```dart
   import 'package:flutter_test/flutter_test.dart';
   import 'package:mocktail/mocktail.dart';

   // ...
   ```

3. Define your Mock-Classes. (If you need some)

   ```dart
   class MockMyClass extends Mock implements MyClass {}

   // ...
   ```

4. Write your tests. Orientate yourself on existing classes. (Consider when writing tests for multiple methods of a class to use a group for the tests of each method.)

5. Run the tests with the following command:

   ```sh
   flutter test
   ```

   <p align="right">(<a href="#readme_top">back to top</a>)</p>
