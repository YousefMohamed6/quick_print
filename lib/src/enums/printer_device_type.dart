import 'package:quick_print/src/service/printer_device_factory.dart'
    show PrinterDeviceFactory;

/// Defines the type of printer device to be used.
///
/// This enum is used to specify which type of printer implementation should be created
/// by the [PrinterDeviceFactory]. Each value represents a different printer technology or
/// connection method.
///
/// Example:
/// ```dart
/// final printer = Printer(PrinterDeviceType.bluetooth);
/// ```
enum PrinterDeviceType {
  /// Sunmi printer specific for Android devices.
  /// Only available on Android devices with Sunmi hardware.
  sunmi,

  /// Bluetooth printer connection.
  /// Supports both classic Bluetooth and BLE (Bluetooth Low Energy) devices.
  bluetooth,

  /// USB printer connection.
  /// Available on desktop platforms and Android devices with USB OTG support.
  usb,

  /// Desktop system printer (Windows, macOS, Linux).
  /// Uses the operating system's native printing system.
  desktop,

  /// Mobile device printer (iOS, Android).
  /// Uses the platform's default printing mechanism.
  mobile,

  /// wifi printer connection.
  /// Uses the platform's default printing mechanism.
  wifi,
}
