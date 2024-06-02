import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sehety/core/constants/assets_images.dart';
import 'package:sehety/core/function/routing.dart';
import 'package:sehety/core/util/colors.dart';
import 'package:sehety/core/util/text_style.dart';
import 'package:sehety/core/widget/custom_button.dart';
import 'package:sehety/core/widget/show_loading_and_error.dart';
import 'package:sehety/features/auth/presentation/manager/auth_cubit.dart';
import 'package:sehety/features/auth/presentation/manager/auth_state.dart';
import 'package:sehety/features/auth/presentation/view/forgot_password.dart';
import 'package:sehety/features/auth/presentation/view/registr_view.dart';
import 'package:sehety/features/auth/presentation/widget/custom_text_form_field.dart';

// ignore: must_be_immutable
class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.index});
  final int index;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool visibilPassword = true;

  var emailController = TextEditingController();
  var passwodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String name = widget.index == 0 ? 'دكتور' : 'مريض';
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccessStat) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          showError(context: context, textError: 'Success');
        } else if (state is LoginErrorStat) {
          Navigator.pop(context);
          showError(context: context, textError: state.error);
        } else {
          showLoading(context: context);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: key,
              child: Column(
                children: [
                  const Gap(40),
                  Image.asset(height: 200, width: 200, AssetImages.appIcon),
                  Text(
                    'سجل دخول الان كـ "$name"',
                    style: getBodyStyle(context,
                        color: AppColors.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                  const Gap(25),
                  //email
                  CustomTextFormField(
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'ادخل البريد الالكتروني';
                      }
                      return null;
                    },
                    controller: emailController,
                    hintText: 'البريد الالكتروني',
                    suffixIcon: const SizedBox(),
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  //passwoed
                  const Gap(25),
                  CustomTextFormField(
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'ادخل كلمة السر';
                      }
                      return null;
                    },
                    controller: passwodController,
                    obscureText: visibilPassword,
                    hintText: '*********',
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          visibilPassword = !visibilPassword;
                        });
                      },
                      child: Icon(
                        visibilPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const Gap(10),
                  Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          navigatorTo(
                              context, ForgotPasswordView(index: widget.index));
                        },
                        child: Text(
                          'نسيت كلمة السر ؟',
                          style: getBodyStyle(context,
                              color: AppColors.primaryColor),
                        ),
                      )),
                  //Button Register an account'
                  const Gap(25),
                  CustomButton(
                    height: 45,
                    text: 'تسجيل دخول',
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        context.read<AuthCubit>().login(
                              email: emailController.text,
                              password: passwodController.text,
                            );
                      } else {}
                    },
                    color: AppColors.primaryColor,
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'لدي حساب؟',
                        style: getBodyStyle(context),
                      ),
                      TextButton(
                          onPressed: () {
                            navigatorTo(
                                context,
                                Registr(
                                  index: widget.index,
                                ));
                          },
                          child: Text(
                            'سجل الان',
                            style: getBodyStyle(context,
                                color: AppColors.primaryColor),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
