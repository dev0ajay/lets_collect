


///validators  for stream
/// if the validation satisfy then data will be added in stream else add error in stream

// mixin Validators {
//   var emailValidator =
//   StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
//     if (isEmail(email)) {
//       sink.add(email);
//     } else {
//       sink.addError(Strings.EMAIL_NOT_VALID);
//     }
//   });
//
//   var usernameValidator = StreamTransformer<String, String>.fromHandlers(
//       handleData: (username, sink) {
//         if (username.length > 0) {
//           sink.add(username);
//         } else {
//           sink.addError(Strings.USERNAME_NOT_VALID);
//         }
//       });
//
//   var passwordValidator = StreamTransformer<String, String>.fromHandlers(
//       handleData: (password, sink) {
//         if (password.length >= 6) {
//           sink.add(password);
//         } else {
//           sink.addError(Strings.PASSWORD_LENGTH);
//         }
//       });
//
//   var mobileValidator = StreamTransformer<String, String>.fromHandlers(
//       handleData: (mobile, sink) {
//         if (isInt(mobile)) {
//           if (mobile.length == 10) {
//             sink.add(mobile);
//           } else {
//             sink.addError(Strings.INVALID_MOBILE_NUM);
//           }
//         }
//       });
//
//   var nameValidator =
//   StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
//     if (name.isNotEmpty) {
//       sink.add(name);
//     } else {
//       sink.addError(Strings.INVALID_NAME);
//     }
//   });
// }
