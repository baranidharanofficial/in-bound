import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbound/bloc/user_bloc.dart';
import 'package:inbound/bloc/user_event.dart';
// import 'package:inbound/pages/confirm_page.dart';
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
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is UserLoading) {
          return const CircularProgressIndicator();
        } else if (state is UserLoaded) {
          return SafeArea(
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
                      onQRViewCreated: (controller) {
                        _onQRViewCreated(controller, state.user.uid);
                      },
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
          );
        } else if (state is UserError) {
          return const SlideInText(
            value: 'Failed',
            size: 20,
            weight: FontWeight.bold,
          );
        }
        return const Text('None');
      }),
    );
  }

  void _onQRViewCreated(QRViewController controller, String senderId) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        if (result == null && scanData.code != null) {
          result = scanData;
          print(result);
          _navigateToScannedDataPage(result!.code!, senderId);
        }
      });
    });
  }

  void sendConnect(String uid, String senderId) async {
    debugPrint("REQUEST-------------------------");
    await _chatService.sendConnectionRequest(
      uid,
      senderId,
      'Connected',
    );
  }

  _navigateToScannedDataPage(String scannedData, String senderId) {
    Navigator.pop(context);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ConfirmPage(
    //       result: scannedData,
    //       userId: "",
    //     ),
    //   ),
    // );
    sendConnect(scannedData, senderId);
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



