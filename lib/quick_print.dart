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

export 'src/enums/paper_size.dart';
export 'src/enums/printer_device_type.dart';
export 'src/models/printer_model/wifi_printer_model.dart';
export 'src/quick_print_base.dart';
export 'src/service/printer_discovery_service.dart';

