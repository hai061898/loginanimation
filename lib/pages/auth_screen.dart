import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/utils/animation.dart';
import 'package:login/utils/color.dart';
import 'package:login/utils/layout.dart';
import 'package:login/widgets/button_socical.dart';
import 'package:login/widgets/loginpage.dart';
import 'package:login/widgets/signup_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool isshowSignUp = false;
  late AnimationController animationController;
  late Animation<double> animationText;
  void setUP() {
    animationController =
        AnimationController(vsync: this, duration: defaultDuration);
    animationText =
        Tween<double>(begin: 0, end: 90).animate(animationController);
  }

  void updateV() {
    setState(() {
      isshowSignUp = !isshowSignUp;
    });
    isshowSignUp
        ? animationController.forward()
        : animationController.reverse();
  }

  @override
  void initState() {
    setUP();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
          animation: animationController,
          builder: (context, _) {
            return Stack(
              children: [
                AnimatedPositioned(
                  duration: defaultDuration,
                  top: size.height * 0.1,
                  left: 0,
                  right: size.width * 0.06,
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: AnimatedSwitcher(
                        duration: defaultDuration,
                        child: isshowSignUp
                            ? SvgPicture.asset(
                                "assets/animation_logo.svg",
                                color: login_bg,
                              )
                            : SvgPicture.asset(
                                "assets/animation_logo.svg",
                                color: signup_bg,
                              ),
                      )),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: size.width * 0.88,
                  height: size.height,
                  left: isshowSignUp ? size.width * 0.75 : 0,
                  child: Container(
                    color: login_bg,
                    child: LoginForm(),
                  ),
                ),
                Positioned(
                  height: size.height,
                  width: size.width * 0.88,
                  left: isshowSignUp ? size.width * 0.12 : size.width * 0.88,
                  child: Container(
                    color: signup_bg,
                    child: SignUpForm(),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: size.width,
                  bottom: size.height * 0.1,
                  right: isshowSignUp ? size.width * 0.06 : size.width * 0.86,
                  child: SocalButtns(),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  bottom: isshowSignUp ? size.height / 2 : size.height * 0.3,
                  left: isshowSignUp ? 0 : size.width * 0.44 - 80,
                  child: Container(
                    width: 160,
                    child: AnimatedDefaultTextStyle(
                      duration: defaultDuration,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isshowSignUp ? 20 : 32,
                        fontWeight: FontWeight.bold,
                        color: isshowSignUp ? Colors.white : Colors.white70,
                      ),
                      child: Transform.rotate(
                        alignment: Alignment.topLeft,
                        angle: animationText.value * pi / 180,
                        child: InkWell(
                          onTap: () {
                            if (isshowSignUp) {
                              updateV();
                            } else {}
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: defpaultPadding * 0.75),
                            width: 160,
                            child: Text(
                              "LogIn".toUpperCase(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  bottom: !isshowSignUp ? size.height / 2 : size.height * 0.3,
                  right: isshowSignUp ? size.width * 0.44 - 80 : 0,
                  child: Container(
                    width: 160,
                    child: AnimatedDefaultTextStyle(
                      duration: defaultDuration,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: !isshowSignUp ? 20 : 32,
                        fontWeight: FontWeight.bold,
                        color: isshowSignUp ? Colors.white : Colors.white70,
                      ),
                      child: Transform.rotate(
                        alignment: Alignment.topRight,
                        angle: (90 - animationText.value) * pi / 180,
                        child: InkWell(
                          onTap: () {
                            if (isshowSignUp) {
                            } else {
                              updateV();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: defpaultPadding * 0.75),
                            width: 160,
                            child: Text(
                              "SignUp".toUpperCase(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
