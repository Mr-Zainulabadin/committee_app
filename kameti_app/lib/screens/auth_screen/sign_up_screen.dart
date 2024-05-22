import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:kameti_app/Utils/AppColor.dart';
import 'package:kameti_app/app_widgets/AppBarWidget.dart';
import 'package:kameti_app/app_widgets/MyTextField.dart';
import 'package:kameti_app/app_widgets/custom_button.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';
import 'package:kameti_app/screens/all_kameti/all_kameti_screen.dart';
import 'package:kameti_app/screens/auth_screen/login_screen.dart';
import 'package:kameti_app/screens/dash_board_screen/dash_board_screen.dart';
import 'package:kameti_app/utils/extensions.dart';

class SignUPScreen extends StatefulWidget {
  const SignUPScreen({super.key});

  @override
  State<SignUPScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUPScreen> with SingleTickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
          SizedBox(
            height: context.mqHeight * .03,
          ),
          Container(
            height: context.mqHeight * .17,
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
          20.verSpace,
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              AdminSignUpWidget(
                  onTap: () {
                    if (emailController.text.isEmpty) {
                      'Please enter your Name'.errorSnack;
                    } else if (passwordController.text.isEmpty) {
                      'Please enter your email'.errorSnack;
                    } else if (numberController.text.isEmpty) {
                      'Please enter your number'.errorSnack;
                    } else if (passwordController.text.isEmpty) {
                      "Please enter your password".errorSnack;
                    } else if (confirmPasswordController.text.length < 10) {
                      "Please enter your confirm password".errorSnack;
                    } else {
                      const AllKametiScreen(
                        isLeading: false,
                      ).navigate;
                      "Sign Up Successfully".successSnack;
                    }
                  },
                  confirmPasswordController: confirmPasswordController,
                  emailController: emailController,
                  passwordController: passwordController),
              AdminSignUpWidget(
                  onTap: () {
                    if (emailController.text.isEmpty) {
                      'Please enter your Name'.errorSnack;
                    } else if (passwordController.text.isEmpty) {
                      'Please enter your email'.errorSnack;
                    } else if (numberController.text.isEmpty) {
                      'Please enter your number'.errorSnack;
                    } else if (passwordController.text.isEmpty) {
                      "Please enter your password".errorSnack;
                    } else if (confirmPasswordController.text.length < 10) {
                      "Please enter your confirm password".errorSnack;
                    } else {
                      const DashboardScreen().navigate;
                      "Sign Up Successfully".successSnack;
                    }
                  },
                  confirmPasswordController: confirmPasswordController,
                  emailController: emailController,
                  passwordController: passwordController),
            ]),
          )
        ],
      ),
    );
    // return AdminSignUpWidget(confirmPasswordController: confirmPasswordController, emailController: emailController, passwordController: passwordController);
  }
}

class AdminSignUpWidget extends StatelessWidget {
  const AdminSignUpWidget({
    super.key,
    required this.confirmPasswordController,
    required this.emailController,
    required this.passwordController,
    required this.onTap,
  });

  final TextEditingController confirmPasswordController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyTextField(
                  icon: Icons.lock,
                  controller: confirmPasswordController,
                  hintText: "Enter Your Name",
                  textInputType: TextInputType.name),
              8.verSpace,
              MyTextField(
                  icon: Icons.person,
                  controller: emailController,
                  hintText: "Enter Your Email",
                  textInputType: TextInputType.emailAddress),
              8.verSpace,
              MyTextField(
                  icon: Icons.lock,
                  controller: confirmPasswordController,
                  hintText: "Enter Your Phone Number",
                  textInputType: TextInputType.phone),
              8.verSpace,
              MyTextField(
                  icon: Icons.lock,
                  controller: passwordController,
                  hintText: "Enter Your Password",
                  textInputType: TextInputType.text),
              8.verSpace,
              MyTextField(
                  icon: Icons.lock,
                  controller: confirmPasswordController,
                  hintText: "Enter Your Confirm Password",
                  textInputType: TextInputType.text),
              SizedBox(
                height: context.mqHeight * .08,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: context.mqHeight * .15,
                child: Column(
                  children: [
                    CustomButton(onTap: onTap, title: "Sign Up"),
                    12.verSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "you have an account: ",
                          fontColor: AppColor.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        GestureDetector(
                          onTap: () {
                            const LoginScreen().navigate;
                          },
                          child: CustomText(
                            text: "Login",
                            fontColor: AppColor.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
