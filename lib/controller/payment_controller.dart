import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentController {
  static Future<http.Response> sendPaymentRequest(String phoneNumber, double amount) {
    // Format the phone number
    if (phoneNumber.startsWith('0')) {
      phoneNumber = phoneNumber.replaceFirst('0', '254');
    }

    // Replace with your Node.js server URL
    const String url = 'http://localhost:3000/initiate-payment';

    return http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'phoneNumber': phoneNumber,
        'amount': amount,
      }),
    );
  }
}
