import 'dart:typed_data';

import 'package:flutter_pos_printer_platform_image_3_sdt/flutter_pos_printer_platform_image_3_sdt.dart'
    as pos;
import 'package:quick_print/src/enums/paper_size.dart';
import 'package:quick_print/src/exceptions/invalid_type_exception.dart';
import 'package:quick_print/src/exceptions/unconnected_device_exception.dart';
import 'package:quick_print/src/models/printer_model/i_printer_model.dart';
import 'package:quick_print/src/models/printer_model/wifi_printer_model.dart';
import 'package:quick_print/src/printers/interfaces/i_printer.dart';

/// Wi-Fi (network) printer implementation
class WifiPrinter with IPrinterMixin implements IPrinter {
  @override
  Future<void> printPdf({
    required String path,
    PaperSize paperSize = PaperSize.mm80,
    IPrinterModel? model,
  }) async {
    final bytes = await convertPdfToImage(path: path, paperSize: paperSize);
    await _print(model, bytes);
  }

  @override
  Future<void> printImage({
    required Uint8List bytes,
    PaperSize paperSize = PaperSize.mm80,
    IPrinterModel? model,
  }) async {
    await _print(model, bytes);
  }

  Future<void> _print(IPrinterModel? model, Uint8List bytes) async {
    if (model is! WifiPrinterModel) {
      throw InvalidTypeException('model must be WifiPrinterModel');
    }

    final printerManager = pos.PrinterManager.instance;
    final isConnected = await printerManager.connect(
      type: pos.PrinterType.network,
      model: pos.TcpPrinterInput(
        ipAddress: model.ip,
        port: model.port,
      ),
    );

    if (!isConnected) {
      throw UnConnectedDeviceException(model.ip);
    }

    await printerManager.send(type: pos.PrinterType.network, bytes: bytes);
  }
}
