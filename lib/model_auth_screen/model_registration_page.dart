// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// final _auth = FirebaseAuth.instance;
// dynamic user;
// String userEmail;
// final _firestore = FirebaseFirestore.instance;
//
// void getCurrentUserInfo() {
//   user = _auth.currentUser;
//   userEmail = user.email;
// }
//
// void addUserDb() async {
//   if (indexNumber == 0) {
//     await _firestore
//         .collection('${userEmail}Dic')
//         .doc('${userEmail}Voc')
//         .update({
//       iDForCanUse: FieldValue.arrayUnion([
//         {
//           'word': '${data[dataLength - 1][valueOfWord]}',
//           'wordClass': '${data[dataLength - 1][valueOfWordClass]}',
//         },
//       ]),
//     });
//     await _firestore
//         .collection('${userEmail}Dic')
//         .doc('${userEmail}Voc')
//         .update({
//       iDForCanRead: FieldValue.arrayUnion([
//         {
//           'word': '${data[dataLength - 1][valueOfWord]}',
//           'wordClass': '${data[dataLength - 1][valueOfWordClass]}',
//         },
//       ]),
//     });
//     await _firestore
//         .collection('${userEmail}Dic')
//         .doc('${userEmail}Voc')
//         .update({
//       iDForHaveSeen: FieldValue.arrayUnion([
//         {
//           'word': '${data[dataLength - 1][valueOfWord]}',
//           'wordClass': '${data[dataLength - 1][valueOfWordClass]}',
//         },
//       ]),
//     });
//     await _firestore
//         .collection('${userEmail}Dic')
//         .doc('${userEmail}Voc')
//         .update({
//       iDForNiceToMeetYou: FieldValue.arrayUnion([
//         {
//           'word': '${data[dataLength - 1][valueOfWord]}',
//           'wordClass': '${data[dataLength - 1][valueOfWordClass]}',
//         },
//       ]),
//     });
//   }
// }
