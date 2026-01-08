import 'package:go_router/go_router.dart';
import 'package:brothers_stock/features/auth/presentation/login_screen.dart';
import 'package:brothers_stock/features/auth/presentation/signup_screen.dart';
import 'package:brothers_stock/features/auth/presentation/forgot_password_screen.dart';
import 'package:brothers_stock/features/home/domain/product.dart';
import 'package:brothers_stock/features/product/presentation/product_details_screen.dart';
import 'package:brothers_stock/features/home/presentation/main_screen.dart';
import 'package:brothers_stock/features/auth/presentation/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignUpScreen()),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        final product = state.extra as Product;
        return ProductDetailsScreen(product: product);
      },
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(path: '/main', builder: (context, state) => const MainScreen()),
  ],
);
