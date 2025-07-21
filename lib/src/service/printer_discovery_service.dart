import 'dart:async';
import 'dart:io';

import 'package:flutter_pos_printer_platform_image_3_sdt/flutter_pos_printer_platform_image_3_sdt.dart';
import 'package:printing/printing.dart';
import 'package:quick_print/src/exceptions/printer_exception.dart';
import 'package:quick_print/src/models/printer_model/bluetooth_printer_model.dart';
import 'package:quick_print/src/models/printer_model/decktop_printer_model.dart';
import 'package:quick_print/src/models/printer_model/i_printer_model.dart';
import 'package:quick_print/src/models/printer_model/use_printer_model.dart';
import 'package:quick_print/src/models/printer_model/wifi_printer_model.dart';
import 'package:win_ble/win_ble.dart';
import 'package:win_ble/win_file.dart';

/// The PrinterDiscoveryService class is responsible for discovering and managing printer devices on various platforms (Windows, Android, iOS, Linux, and macOS).
class PrinterDiscoveryService {
  /// The list of discovered printer devices.
  final List<IPrinterModel> _printerDevicesList = [];

  /// The subscription to the printer device stream.
  StreamSubscription<PrinterDevice>? _streamSubscription;

  /// The subscription to the BLE device stream.
  StreamSubscription<BleDevice>? _bleStreamSubscription;

  /// Whether the service has been initialized.
  bool _isInitialized = false;

  /// Returns an unmodifiable list of discovered printer devices.
  List<IPrinterModel> get printerDevicesList =>
      List.unmodifiable(_printerDevicesList);

  /// Returns an unmodifiable list of discovered printer devices.
  ///
  /// This method returns a list of all printer devices that have been discovered by the service.
  Future<void> initialize() async {
    try {
      if (!_isInitialized) {
        await WinBle.initialize(serverPath: await WinServer.path());
        _isInitialized = true;
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Discovers both Bluetooth and USB devices, and adds them to the list of discovered devices.
  ///
  /// This method discovers all available printer devices on the system and adds them to the list of discovered devices.
  ///
  /// [timeout] The duration to wait for device discovery to complete. Defaults to 5 seconds.
  Future<void> discoverDevices({
    Duration timeout = const Duration(seconds: 5),
  }) async {
    _printerDevicesList.clear();
    discoverBluetoothDevices();
    discoverBleDevices();
    discoverWifiDevices();
    await Future.delayed(timeout, discoverUsbDevices);
    await discoverDesktopDevices();
  }

  /// Discovers Bluetooth devices on Android and iOS platforms.
  ///
  /// This method is used internally by the service to discover Bluetooth devices on Android and iOS platforms.
  List<BluetoothPrinterModel> discoverBluetoothDevices() {
    final bluetoothDevices = <BluetoothPrinterModel>[];
    if (Platform.isAndroid || Platform.isIOS) {
      _streamSubscription = PrinterManager.instance
          .discovery(type: PrinterType.bluetooth, isBle: true)
          .listen(
            (device) {
              final model = BluetoothPrinterModel(
                name: device.name,
                address: device.address ?? '',
              );
              bluetoothDevices.add(model);
              _addDevice(model);
            },
            onError:
                (e) => throw Exception('Error during Bluetooth discovery: $e'),
          );
    }
    return bluetoothDevices;
  }

  /// Discovers Bluetooth Low Energy (BLE) devices on Windows platforms.
  ///
  /// This method is used internally by the service to discover BLE devices on Windows platforms.
  List<BluetoothPrinterModel> discoverBleDevices() {
    if (!_isInitialized && Platform.isWindows) {
      throw const PrinterException(
        'Service not initialized. Please call initialize first.',
      );
    }
    final bleDevices = <BluetoothPrinterModel>[];
    if (Platform.isWindows) {
      WinBle.startScanning();
      _bleStreamSubscription = WinBle.scanStream.listen((device) {
        if (device.name.isNotEmpty && device.address.isNotEmpty) {
          final model = BluetoothPrinterModel(
            name: device.name,
            address: device.address,
            isBle: true,
          );
          bleDevices.add(model);
          _addDevice(model);
        }
      }, onError: (e) => throw Exception('Error during Bluetooth scan: $e'));
    }
    return bleDevices;
  }

  // Discovers Wifi devices on Android and iOS platforms.
  ///
  /// This method is used internally by the service to discover Wifi devices on Android and iOS platforms.
  List<WifiPrinterModel> discoverWifiDevices() {
  final wifiDevices = <WifiPrinterModel>[];
  if (Platform.isAndroid || Platform.isIOS) {
    _streamSubscription = PrinterManager.instance
        .discovery(type: PrinterType.network)
        .listen(
          (device) {
            final model = WifiPrinterModel(
              name: device.name,
              ip: device.address ?? '',
            );
            wifiDevices.add(model);
            _addDevice(model);
          },
          onError: (e) => throw Exception('Error during Wi-Fi discovery: $e'),
        );
  }
  return wifiDevices;
}

  /// Discovers USB devices on all platforms.
  ///
  /// This method is used internally by the service to discover USB devices on all platforms.
  List<UsbPrinterModel> discoverUsbDevices() {
    final usbDevices = <UsbPrinterModel>[];
    _streamSubscription = PrinterManager.instance
        .discovery(type: PrinterType.usb)
        .listen(
          (device) {
            final model = UsbPrinterModel(
              name: device.name,
              productId: device.productId ?? '',
              vendorId: device.vendorId ?? '',
            );
            usbDevices.add(model);
            _addDevice(model);
          },
          onError: (e) => throw Exception('Error during USB discovery: $e'),
          onDone: WinBle.stopScanning,
        );
    return usbDevices;
  }

  /// Discovers desktop printers on Windows, Linux, and macOS platforms.
  ///
  /// This method is used internally by the service to discover desktop printers on Windows, Linux, and macOS platforms.
  Future<List<DesktopPrinterModel>> discoverDesktopDevices() async {
    final allprinters = <DesktopPrinterModel>[];
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      final printers = await Printing.listPrinters();
      if (printers.isEmpty) {
        return [];
      }
      for (final printer in printers) {
        final model = DesktopPrinterModel(
          name: printer.name,
          url: printer.url,
          isAvailable: printer.isAvailable,
          isDefault: printer.isDefault,
          comment: printer.comment,
          location: printer.location,
          model: printer.model,
        );
        allprinters.add(model);
        _addDevice(model);
      }
    }
    return allprinters;
  }

  /// Adds a device to the list if it doesn't already exist
  void _addDevice(IPrinterModel printerDevice) {
    if (!_printerDevicesList.contains(printerDevice)) {
      _printerDevicesList.add(printerDevice);
    }
  }

  /// Cleans up resources and cancels subscriptions
  void dispose() {
    _streamSubscription?.cancel();
    _bleStreamSubscription?.cancel();
    WinBle.stopScanning();
    WinBle.dispose();
    _isInitialized = false;
  }
}
