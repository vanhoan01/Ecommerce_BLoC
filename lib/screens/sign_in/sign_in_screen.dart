import 'package:ecommerce_bloc/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = "/sign_in";
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SignInScreen(),
    );
  }

  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Đăng nhập",
          style: Theme.of(context).textTheme.headline3,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  const Center(
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      width: 70,
                      height: 70,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  const SignForm(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocalCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/facebook-2.svg",
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/twitter.svg",
                        press: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const NoAccountText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
