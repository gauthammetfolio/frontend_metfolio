// import 'package:flutter/material.dart';
// // import 'package:intercom_flutter/intercom_flutter.dart';



// class SampleApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Intercom example app'),
//         ),
//         body: Center(
//           child: TextButton(
//             onPressed: () {
//               // NOTE:
//               // Messenger will load the messages only if the user is registered
//               // in Intercom.
//               // Either identified or unidentified.
//               // So make sure to login the user in Intercom first before opening
//               // the intercom messenger.
//               // Otherwise messenger will not load.
//               Intercom.instance.displayMessenger();
//             },
//             child: Text('Show messenger'),
//           ),
//         ),
//       ),
//     );
//   }
// }