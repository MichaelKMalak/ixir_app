import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_cubit.dart';
import '../widgets/image_paths.dart';
import '../widgets/theme/app_colors.dart';
import 'home_screen.dart';
import 'landing/welcome_screen.dart';
import 'sign_up/with_email/sign_up_with_email_confirmation_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BlocProvider.of<AuthCubit>(context).checkAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        if (authState is UnAuthenticated) {
          return WelcomeScreen();
        }

        if (authState is AuthenticatedEmailNotVerified) {
          return SignUpWithEmailConfirmationScreen();
        }

        if (authState is Authenticated) {
          return const HomeScreen();
        }

        return LoadingScreen();
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.blueColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Center(
            child: Image(
              width: screenWidth * 0.4,
              fit: BoxFit.cover,
              image: const AssetImage(ImagePaths.ixirLogo),
            ),
          ),
        ),
      ),
    );
  }
}
