/// A comprehensive Flutter package for handling PDF printing across different platforms
/// and devices. This package provides a unified interface for printing PDFs using
/// various printer types including ESC/POS, Sunmi, Bluetooth, USB, and system printers.
///
/// ## Features
///
/// * Multi-printer Support:
///   - Sunmi printer support for Android devices
///   - Bluetooth printer integration (including BLE)
///   - USB printer compatibility
///   - Desktop system printer support
///   - Mobile device printing
///
/// * Paper Size Options:
///   - 80mm paper width (POS printers)
///   - 58mm paper width (Thermal printers)
///   - A4 paper size
///
/// * Platform Support:
///   - Android
///   - iOS
///   - Windows
///   - Linux
///   - macOS
///
/// ## Usage
///
/// ```dart
/// // Create a printer instance
/// final printer = Printer(PrinterDeviceType.mobile);
///
/// // Print a PDF file
/// await printer.instance.print(
///   path: 'assets/document.pdf',
///   paperSize: PaperSize.a4,
/// );
/// ```
library;

// Enums
export 'src/enums/paper_size.dart';
export 'src/enums/printer_device_type.dart';

// Core
export 'src/quick_print_base.dart';

// Models
export 'src/models/printer_model/i_printer_model.dart';
export 'src/models/printer_model/bluetooth_printer_model.dart';
export 'src/models/printer_model/decktop_printer_model.dart';
export 'src/models/printer_model/use_printer_model.dart';
export 'src/models/printer_model/wifi_printer_model.dart';

// Printers & interfaces
export 'src/printers/interfaces/i_printer.dart';
export 'src/printers/bluetooth_printer.dart';
export 'src/printers/desktop_printer.dart';
export 'src/printers/mobile_printer.dart';
export 'src/printers/sunmi_printer.dart';
export 'src/printers/use_printer.dart';
export 'src/printers/wifi_printer.dart';

// Services & factories
export 'src/service/printer_discovery_service.dart';
export 'src/service/printer_device_factory.dart';

// Exceptions
export 'src/exceptions/printer_exception.dart';
export 'src/exceptions/invalid_file_exception.dart';
export 'src/exceptions/invalid_type_exception.dart';
export 'src/exceptions/unconnected_device_exception.dart';

