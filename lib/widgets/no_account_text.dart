import 'package:flutter/material.dart';

class NoAccountText extends StatelessWidget {
  static String routeName = "/sign_up";

  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Bạn không có tài khoản? ",
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, routeName),
          child: const Text(
            "Đăng ký",
            style: TextStyle(
              fontSize: 16,
              color: Colors.blueAccent,
            ),
          ),
        ),
      ],
    );
  }
}
