import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inbound/pages/confirm_page.dart';
import 'package:inbound/services/connect_service.dart';
import 'package:inbound/widgets/animated_texts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({super.key});

  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final ChatService _chatService = ChatService();

  Barcode? result;
  QRViewController? controller;

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
      backgroundColor: const Color(0xFF191919),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: const EdgeInsets.only(bottom: 20),
                child: const SlideInText(
                  value: "Scan your friend's card to connect",
                  size: 30,
                  align: TextAlign.center,
                  weight: FontWeight.bold,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
              const SizedBox.square(
                dimension: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 28,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox.square(
                dimension: 10,
              ),
              const SlideInText(
                value: "Go back",
                size: 14,
                align: TextAlign.center,
                weight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      setState(() async {
        if (result == null) {
          result = scanData;
          var user =
              await _chatService.getUserInfo('qRfXH6m93GY0nOly09dDIKXkZOC3');
          _navigateToScannedDataPage(user['email'] ?? "Error");
        }
      });
    });
  }

  void sendConnect() async {
    print("REQUEST-------------------------");
    await _chatService.sendConnectionRequest(
      '81lz2GPiXwMSFdaCNU5pne7RJF13',
      'Connected',
    );
  }

  _navigateToScannedDataPage(String scannedData) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmPage(result: scannedData),
      ),
    );
    sendConnect();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

// class QRScanPage extends StatefulWidget {
//   const QRScanPage({super.key});

//   @override
//   State<QRScanPage> createState() => _QRScanPageState();
// }

// class _QRScanPageState extends State<QRScanPage> {
//   String value = "-----";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               child: MobileScanner(
//                 onDetect: (barcode) {
//                   String code = barcode.raw;
//                   value = code;
//                   setState(() {});
//                   print(code);
//                 },
//               ),
//             ),
//             Positioned(
//               left: 20,
//               bottom: 20,
//               child: Text(
//                 "Value : $value",
//                 style: const TextStyle(color: Colors.white),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }



