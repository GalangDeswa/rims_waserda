// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:rims_waserda/Modules/kasir/view_detail_penjualan_kasir.dart';
//
// import '../../Templates/setting.dart';
// import '../Widgets/stack bg.dart';
// import 'controller_kasir.dart';
// import 'view_list_kasir.dart';
//
// class kasir extends GetView<kasirController> {
//   const kasir({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       // minimum: EdgeInsets.all(10),
//       child: Scaffold(
//           backgroundColor: color_template().primary.withOpacity(0.2),
//           // appBar: appbar_custom(
//           //     height: 50,
//           //     child: Row(
//           //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //       children: [
//           //         Text(
//           //           'kasir',
//           //           style: font().header,
//           //         ),
//           //         IconButton(
//           //             onPressed: () {
//           //               controller.refresh();
//           //             },
//           //             icon: Icon(
//           //               Icons.refresh,
//           //               color: Colors.white,
//           //             ))
//           //       ],
//           //     )),
//           body: stack_bg(
//             child: Padding(
//               padding: const EdgeInsets.all(30),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Expanded(child: list_kasir()),
//                   detail_penjualan_kasir(),
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }
