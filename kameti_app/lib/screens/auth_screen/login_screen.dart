import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:kameti_app/Utils/AppColor.dart';
import 'package:kameti_app/app_widgets/AppBarWidget.dart';
import 'package:kameti_app/app_widgets/MyTextField.dart';
import 'package:kameti_app/app_widgets/custom_button.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';
import 'package:kameti_app/screens/all_kameti/all_kameti_screen.dart';
import 'package:kameti_app/screens/auth_screen/forget_screen.dart';
import 'package:kameti_app/screens/auth_screen/sign_up_screen.dart';
import 'package:kameti_app/screens/dash_board_screen/dash_board_screen.dart';
import 'package:kameti_app/utils/extensions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        title: "Sign In",
      ),
      body: Column(
        children: [
          SizedBox(height: context.mqHeight * .08),
          Container(
            height: context.mqHeight * .15,
            width: context.mqWidth * .7,
            decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage(
                      "assets/logoIcon.png",
                    ),
                    fit: BoxFit.contain),
                color: AppColor.grey,
                shape: BoxShape.circle),
          ),
          //  Image.asset("assets/LoginImage.png"),
          16.verSpace,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            clipBehavior: Clip.antiAlias,
            height: 30,
            width: context.mqWidth * .55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.withOpacity(.3),
            ),
            child: TabBar(controller: _tabController, tabs: const [
              Tab(
                text: "User",
              ),
              Tab(
                text: "Admin",
              ),
            ]),
          ),
          15.verSpace,
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              LoginWidget(
                  onTap: () {
                    if (emailController.text.isEmpty) {
                      'Please enter your email'.errorSnack;
                    } else if (passwordController.text.isEmpty) {
                      'Please enter your password'.errorSnack;
                    } else {
                      const AllKametiScreen(
                        isLeading: false,
                      ).navigate;
                      "Login Successfully".successSnack;
                    }
                  },
                  emailController: emailController,
                  passwordController: passwordController),
              LoginWidget(
                  onTap: () {
                    if (emailController.text.isEmpty) {
                      'Please enter your email'.errorSnack;
                    } else if (passwordController.text.isEmpty) {
                      'Please enter your password'.errorSnack;
                    } else {
                      const DashboardScreen().navigate;
                      "Login Successfully".successSnack;
                    }
                  },
                  emailController: emailController,
                  passwordController: passwordController),
            ]),
          )
        ],
      ),
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onTap,
  });
  final VoidCallback onTap;

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 25),
                child: Column(
                  children: [
                    MyTextField(
                        icon: Icons.person,
                        controller: emailController,
                        hintText: " Enter your email",
                        textInputType: TextInputType.emailAddress),
                    12.verSpace,
                    MyTextField(
                        icon: Icons.lock,
                        controller: passwordController,
                        hintText: "Enter your password",
                        textInputType: TextInputType.text),
                    12.verSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showCupertinoModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      height: context.mqHeight * .6,
                                      child: const ForgetPasswordScreen(),
                                    ));
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColor.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff0052a3)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: context.mqHeight * .15,
                child: Column(
                  children: [
                    Column(
                      children: [
                        CustomButton(
                            // isLoading: authProvider.isLoading,
                            onTap: onTap,
                            title: "Login"),
                      ],
                    ),
                    12.verSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "don't have on account: ",
                          fontColor: AppColor.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        GestureDetector(
                          onTap: () {
                            const SignUPScreen().navigate;
                          },
                          child: CustomText(
                            text: "Sign Up",
                            fontColor: AppColor.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
