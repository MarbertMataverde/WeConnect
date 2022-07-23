import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weconnect/features/layout/constant/constant_screen_sizes.dart';
import 'package:weconnect/features/layout/constant/constant_sizebox.dart';
import 'package:weconnect/features/login/widget/widget_login_text.dart';
import 'package:weconnect/features/login/widget/widget_login_textbutton.dart';
import 'package:weconnect/features/login/widget/widget_login_textformfield.dart';
import 'package:weconnect/features/login/widget/widget_svg.dart';

late bool _passwordVisible;

class LoginPhone extends StatefulWidget {
  const LoginPhone({Key? key}) : super(key: key);

  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: desktopSize * 0.030),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                svgAssetLogo(
                  assetPath: 'assets/app_icon/plain_light_logo.svg',
                  width: desktopSize * 0.080,
                ),
                sizedBox(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      globalLoginText(
                        text: 'Login your account.',
                        textScaleFactor: 2,
                        fontWeight: FontWeight.w600,
                      ),
                      globalLoginText(
                        text: '"Nurturing Tommorow\'s Noblest"',
                        fontWeight: FontWeight.w100,
                      ),
                      sizedBox(height: 20),
                      loginTextFormField(
                        context: context,
                        label: 'Email',
                        textInputType: TextInputType.emailAddress,
                        prefixIcon: Icon(
                          Iconsax.sms,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      ),
                      sizedBox(),
                      loginTextFormField(
                        context: context,
                        label: 'Password',
                        textInputType: TextInputType.visiblePassword,
                        isObscure: !_passwordVisible,
                        prefixIcon: Icon(
                          Iconsax.password_check,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                        passwordVisibilityIconButton: IconButton(
                          splashRadius: 0.1,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                          onPressed: () => setState(
                            () => _passwordVisible = !_passwordVisible,
                          ),
                          icon: Icon(
                            _passwordVisible ? Iconsax.eye : Iconsax.eye_slash,
                          ),
                        ),
                      ),
                      loginForgotPassword(context: context),
                      sizedBox(height: 20),
                      loginTextButton(
                        context: context,
                        text: 'Login',
                      ),
                    ],
                  ),
                ),
                sizedBox(height: 20),
                loginCreate(context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
