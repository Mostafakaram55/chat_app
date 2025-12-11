import 'dart:developer';

import 'package:cubit_pro/config/routes/routes_name.dart';
import 'package:cubit_pro/core/funcations/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_pro/core/utiles/app_colors.dart';
import 'package:cubit_pro/core/utiles/app_styles.dart';
import 'package:cubit_pro/featuers/auth/presentation/authe_cubit/cubit.dart';
import 'package:cubit_pro/featuers/auth/presentation/authe_cubit/states.dart';
import 'package:cubit_pro/featuers/auth/presentation/params/sign_in_params.dart.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signIn(
        params: AuthParams(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackgroundColor,
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            showToastificationWidget(
              message: 'تم تسجيل الدخول بنجاح',
              context: context,
              notificationType: ToastificationType.success,
            );
            // Navigate to home or main screen
            // Navigator.pushReplacementNamed(context, '/home');
          } else if (state is LoginErrorState) {
            showToastificationWidget(
              message: state.error,
              context: context,
              notificationType: ToastificationType.error,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginLoadingState;
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.lock_person_rounded,
                        size: 80,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'مرحباً بك',
                        style: AppStyles.bold22(
                          context,
                        ).copyWith(color: AppColors.primary),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'سجل دخولك للمتابعة',
                        style: AppStyles.regular16(
                          context,
                        ).copyWith(color: AppColors.grey7A),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 48),
                      _buildTextField(
                        controller: _emailController,
                        label: 'البريد الإلكتروني',
                        hint: 'example@email.com',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال البريد الإلكتروني';
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return 'الرجاء إدخال بريد إلكتروني صحيح';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      _buildTextField(
                        controller: _passwordController,
                        label: 'كلمة المرور',
                        hint: '••••••••',
                        prefixIcon: Icons.lock_outline,
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.grey7A,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال كلمة المرور';
                          }
                          if (value.length < 6) {
                            return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            // Navigate to forgot password
                          },
                          child: Text(
                            'نسيت كلمة المرور؟',
                            style: AppStyles.medium14(
                              context,
                            ).copyWith(color: AppColors.primary),
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      _buildLoginButton(isLoading),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(child: Divider(color: AppColors.greyD8)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'أو',
                              style: AppStyles.regular14(context),
                            ),
                          ),
                          Expanded(child: Divider(color: AppColors.greyD8)),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ليس لديك حساب؟',
                            style: AppStyles.regular16(context),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate to sign up
                              context.push(Routes.signUpView);
                            },
                            child: Text(
                              'إنشاء حساب',
                              style: AppStyles.semiBold16(
                                context,
                              ).copyWith(color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.medium14(context).copyWith(color: AppColors.black2A),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          style: AppStyles.regular16(context),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppStyles.regular14(
              context,
            ).copyWith(color: AppColors.grey7A),
            prefixIcon: Icon(prefixIcon, color: AppColors.grey7A),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.greyE7),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.greyE7),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.red, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton(bool isLoading) {
    return ElevatedButton(
      onPressed: isLoading ? null : _handleLogin,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.grey300,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
              ),
            )
          : Text('تسجيل الدخول', style: AppStyles.semiBold16(context)),
    );
  }
}
