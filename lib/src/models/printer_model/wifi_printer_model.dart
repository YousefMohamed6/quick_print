// Model for Wi-Fi printers

import 'package:quick_print/quick_print.dart';
import 'package:quick_print/src/models/printer_model/i_printer_model.dart';

/// Model representing a Wi-Fi printer device
class WifiPrinterModel extends IPrinterModel {
  /// Creates a new Wi-Fi printer model
  ///
  /// [name] is the display name of the printer
  /// [ip] is the IP address of the printer
  /// [port] is the port used for communication (default: 9100)
  const WifiPrinterModel({
    required this.name,
    required this.ip,
    this.port = 9100,
  });

  @override
  final String name;

  /// The IP address of the printer
  final String ip;

  /// The port number (usually 9100)
  final int port;

  @override
  String toString() =>
      'WifiPrinterModel(name: $name, ip: $ip, port: $port)';

  @override
  PrinterDeviceType get type => PrinterDeviceType.wifi;
}
