import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:brothers_stock/core/constants/app_colors.dart';
import 'package:brothers_stock/core/constants/app_strings.dart';
import 'package:brothers_stock/core/widgets/custom_text_field.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:brothers_stock/features/auth/presentation/providers/auth_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    final success = await ref
        .read(authProvider.notifier)
        .register(
          _nameController.text,
          _emailController.text,
          _passwordController.text,
        );

    if (success) {
      if (mounted) context.go('/main');
    } else {
      if (mounted) {
        final error = ref.read(authProvider).error;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error ?? 'Registration failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.signUp),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Fill in your details to get started',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 32.h),
              CustomTextField(
                controller: _nameController,
                hintText: 'Full Name',
                prefixIcon: Icons.person_outline,
              ),
              SizedBox(height: 16.h),
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
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                prefixIcon: Icons.lock_reset_outlined,
                isPassword: true,
              ),
              SizedBox(height: 32.h),
              if (authState.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: _handleSignUp,
                  child: const Text(AppStrings.signUp),
                ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text(AppStrings.login),
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
