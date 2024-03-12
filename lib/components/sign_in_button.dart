import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignInButton extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final String text;
  const SignInButton(
      {super.key,
      required this.text,
      required this.usernameController,
      required this.passwordController}
      );
  void onPressed() async {
    String username = this.usernameController.text;
    String password = this.passwordController.text;
    Uri url = Uri.parse("http://localhost:8080/send-data");
    Map<String, String> headers = {"Content-type": "application/json"};

    String json =
        '{"message": "Hello from Flutter","username": "$username","password": "$password"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    if (response.statusCode == 200) {
      print('Data sent successfully');
    } else {
      print('Failed to send data. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 120),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}