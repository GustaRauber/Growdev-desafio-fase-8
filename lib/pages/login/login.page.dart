import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:social_login_notification_fase_8/pages/login/login.store.dart';
import 'profile.page.dart';

import 'widgets/login_button.widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginStore = LoginStore();
  void navigateToProfilePage() {
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const ProfilePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 35,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Create an Account o sign to save and see your concersation history.",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              Observer(
                builder: (context) {
                  return LoginButton(
                    isLoading: loginStore.isGoogleLoading,
                    pathImage: "assets/images/google.png",
                    text: "Continue with Google",
                    onPressed: () async {
                      await loginStore.signInWithGoogle();

                      navigateToProfilePage();
                    },
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Observer(
                builder: (context) {
                  return LoginButton(
                    isLoading: loginStore.isFacebookLoading,
                    pathImage: "assets/images/facebook.png",
                    text: "Continue with Facebook",
                    onPressed: () async {
                      await loginStore.signInWithFacebook();
                      navigateToProfilePage();
                    },
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              LoginButton(
                pathImage: "assets/images/apple.png",
                text: "Continue with Apple",
                onPressed: () async {},
              ),
              const SizedBox(
                height: 40,
              ),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Text(
                      "or",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              LoginButton(
                icon: Icons.phone_iphone,
                text: "Use phone number",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
