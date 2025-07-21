import 'package:quick_print/src/enums/printer_device_type.dart';
import 'package:quick_print/src/printers/bluetooth_printer.dart';
import 'package:quick_print/src/printers/desktop_printer.dart';
import 'package:quick_print/src/printers/interfaces/i_printer.dart';
import 'package:quick_print/src/printers/mobile_printer.dart';
import 'package:quick_print/src/printers/sunmi_printer.dart';
import 'package:quick_print/src/printers/use_printer.dart';
import 'package:quick_print/src/printers/wifi_printer.dart.dart';

/// PrinterDeviceFactory.dart

/// A factory class that creates printer instances based on the specified device type.

class PrinterDeviceFactory {
  /// Creates a printer instance based on the specified device type.
  ///
  /// [type] determines which printer implementation to create.
  ///
  /// Returns an [IPrinter] implementation for the specified device type.
  ///
  /// Throws [UnsupportedError] if the specified [type] is not supported.
  IPrinter createDevice(PrinterDeviceType type) {
    switch (type) {
      case PrinterDeviceType.sunmi:
        return SunmiDevicePrinter();
      case PrinterDeviceType.bluetooth:
        return BluetoothPrinter();
      case PrinterDeviceType.usb:
        return UsbPrinter();
      case PrinterDeviceType.desktop:
        return DesktopPrinter();
      case PrinterDeviceType.mobile:
        return MobilePrinter();
      case PrinterDeviceType.wifi:
        return WifiPrinter();
    }
  }
}
