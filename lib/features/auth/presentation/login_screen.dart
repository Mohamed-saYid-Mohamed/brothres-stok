import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:brothers_stock/core/constants/app_colors.dart';
import 'package:brothers_stock/core/constants/app_strings.dart';
import 'package:brothers_stock/core/widgets/custom_text_field.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:brothers_stock/features/auth/presentation/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    final success = await ref
        .read(authProvider.notifier)
        .login(_emailController.text, _passwordController.text);

    if (success) {
      if (mounted) context.go('/main');
    } else {
      if (mounted) {
        final error = ref.read(authProvider).error;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error ?? 'Login failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Login to your Brothers Stock account',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 48.h),
              CustomTextField(
                controller: _emailController,
                hintText: 'Email Address',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _passwordController,
                hintText: 'Password',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.push('/forgot-password'),
                  child: const Text(AppStrings.forgotPassword),
                ),
              ),
              SizedBox(height: 24.h),
              if (authState.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: _handleLogin,
                  child: const Text(AppStrings.login),
                ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: const Text('OR'),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 24.h),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.g_mobiledata, size: 30),
                label: const Text(AppStrings.loginWithGoogle),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.h),
                  side: const BorderSide(color: Colors.grey),
                ),
              ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () => context.push('/signup'),
                    child: const Text(AppStrings.signUp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
