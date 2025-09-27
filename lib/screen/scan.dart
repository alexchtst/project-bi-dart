// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:syndo/screen/tutorial.dart';
import 'package:syndo/utils/data_service.dart';

class Scan extends StatefulWidget {
  const Scan({super.key, required this.name});

  final String name;

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? result;
  bool flashOn = false;
  bool frontCamera = false;

  // Untuk Android, perlu pause dan resume saat lifecycle berubah
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // Toggle Flash
          IconButton(
            onPressed: () async {
              await controller?.toggleFlash();
              setState(() {
                flashOn = !flashOn;
              });
            },
            icon: Icon(
              flashOn ? Icons.flash_on : Icons.flash_off,
              color: Colors.white,
            ),
          ),
          // Toggle Camera
          IconButton(
            onPressed: () async {
              await controller?.flipCamera();
              setState(() {
                frontCamera = !frontCamera;
              });
            },
            icon: const Icon(Icons.flip_camera_ios, color: Colors.white),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          return Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                        borderColor: Colors.green,
                        borderRadius: 10,
                        borderLength: 30,
                        borderWidth: 10,
                        cutOutSize: 250,
                      ),
                      onPermissionSet:
                          (ctrl, p) => _onPermissionSet(context, ctrl, p),
                    ),
                    // Scanning instruction
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: const Text(
                          'Arahkan kamera ke QR code untuk memindai',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code;
      });

      // Pause camera setelah berhasil scan
      controller.pauseCamera();

      // Show success dialog (opsional)
      _showScanResult(scanData.code ?? '');
    });
  }

  void _showScanResult(String code) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('QR Code Berhasil Dipindai'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Hasil:'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SelectableText(
                  code,
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller?.resumeCamera();
                setState(() {
                  result = null;
                });
              },
              child: const Text('Scan Lagi'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _processQRResult(code);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _processQRResult(String code) {
    // Mendapatkan DataProvider dari context menggunakan Provider
    final dataProvider = Provider.of<DataProvider>(context, listen: false);      

    if (code.contains('SCAN-KARTU')) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Berhasil Membuka Kartu: $code')));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Tutorial()),
      );
      } else {
      dataProvider
          .unlockCard(code.toString())
          .then((success) {
            if (success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Card "$code" berhasil di-unlock!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.of(context).pop();
            } else {
              if (dataProvider.error!.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: ${dataProvider.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                // Card tidak ditemukan atau sudah unlocked
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Card "$code" tidak ditemukan atau sudah unlocked',
                    ),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            }
          })
          .catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Gagal unlock card'),
                backgroundColor: Colors.red,
              ),
            );
          });
    }
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Izin kamera diperlukan untuk memindai QR code'),
        ),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
