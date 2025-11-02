# Changelog

## 1.0.2 (2025-11-02)

### Added
- Top-level exports for public API in `lib/quick_print.dart` so consumers can import models, printers, services and exceptions directly from `package:quick_print/quick_print.dart` (for example `BluetoothPrinterModel`).

### Changed
- Bumped package version to `1.0.2` in `pubspec.yaml`.
- Reorganized exports in `lib/quick_print.dart` to include core, models, printers, services and exceptions.

### Fixed
- Resolved a filename/import issue: `lib/src/printers/wifi_printer.dart.dart` was removed and the implementation now lives in `lib/src/printers/wifi_printer.dart`.

### Notes
- If you maintain downstream tooling or custom imports, update any references to the old `wifi_printer.dart.dart` path to `wifi_printer.dart`.

## 1.0.1

### Added
- `printImage` method to the printer interface (`IPrinter`), allowing direct image printing from bytes.
- Documentation improvements for public classes and members.
- README updated with image printing usage and feature.
- Expanded topics in pubspec.yaml for better discoverability.

### Changed
- Lowered Dart SDK constraint to ">=3.4.0 <4.0.0" and Flutter to ">=3.22.0" for broader compatibility with dependencies.

### Fixed
- Linter warnings for missing documentation on public members.

## 1.0.0

Initial release with the following features:

### Added
- Multi-printer support:
  - Sunmi printer support for Android devices
  - Bluetooth printer integration
  - USB printer compatibility
  - Desktop system printer support
  - Mobile device printing
- Paper size options:
  - 80mm paper width
  - 58mm paper width
  - A4 paper size
- Platform support:
  - Android
  - iOS
  - Windows
  - Linux
  - macOS
- Printer models:
  - Bluetooth printer model with BLE support
  - USB printer model
- Factory pattern for printer creation
- Platform-specific implementations
- Comprehensive documentation and examples

### Platform-specific Features
- iOS: Swift support with use_frameworks!
- macOS: Print entitlements support
- Android: Bluetooth permissions handling
