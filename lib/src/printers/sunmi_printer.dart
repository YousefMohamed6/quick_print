import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:quick_print/src/enums/paper_size.dart';
import 'package:quick_print/src/exceptions/printer_exception.dart';
import 'package:quick_print/src/models/printer_model/i_printer_model.dart';
import 'package:quick_print/src/printers/interfaces/i_printer.dart';

/// Printer implementation for Sunmi Android devices.
class SunmiDevicePrinter with IPrinterMixin implements IPrinter {
  @override
  Future<void> printPdf({
    required String path,
    PaperSize paperSize = PaperSize.mm80,
    IPrinterModel? model,
  }) async {
    final bytes = await convertPdfToImage(
      path: path,
      paperSize: paperSize,
      widthScale: 2.7,
      heightScale: 1.8,
    );
    await _print(bytes);
  }

  @override
  Future<void> printImage({
    required Uint8List bytes,
    PaperSize paperSize = PaperSize.mm80,
    IPrinterModel? model,
  }) async {
    await _print(bytes);
  }

  Future<void> _print(Uint8List bytes) async {
    if (!Platform.isAndroid) {
      throw const PrinterException(
        'Sunmi printer is only supported on Android',
      );
    }
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    if (!androidInfo.brand.contains('SUNMI')) {
      throw const PrinterException(
        'Sunmi printer is only supported on Sunmi devices',
      );
    }
    await SunmiDevicePrinter().printImage(bytes: bytes);
  }
}
