import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';
import '../navigation/route_paths.dart';
import '../screens/connect_bracelet/choose_bracelet_user_screen.dart';
import '../screens/connect_bracelet/connect_other_person_bracelet_screen.dart';
import '../screens/connect_bracelet/connect_own_bracelet_screen.dart';
import '../screens/connect_bracelet/enter_bracelet_serial_screen.dart';
import '../screens/home_screen.dart';
import '../screens/landing/welcome_screen.dart';
import '../screens/privacy_and_terms/privacy_policy_screen.dart';
import '../screens/privacy_and_terms/terms_and_conditions_screen.dart';
import '../screens/sign_in/sign_in_screen.dart';
import '../screens/sign_up/landing/sign_up_landing_screen.dart';
import '../screens/sign_up/with_email/sign_up_with_email_confirmation_screen.dart';
import '../screens/sign_up/with_email/sign_up_with_email_screen.dart';
import '../screens/sign_up/with_phone/sign_up_with_phone_confirmation_screen.dart';
import '../screens/sign_up/with_phone/sign_up_with_phone_screen.dart';
import '../screens/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutePaths.splashScreen:
        return _navigate(SplashScreen());

      case RoutePaths.welcomeScreen:
        return _navigate(WelcomeScreen());

      case RoutePaths.privacyPolicyScreen:
        return _navigate(PrivacyPolicyScreen());

      case RoutePaths.termsAndConditionsScreen:
        return _navigate(TermsAndConditionsScreen());

      case RoutePaths.signInScreen:
        return _navigate(SignInScreen());

      case RoutePaths.signUpLandingScreen:
        return _navigate(SignUpLandingScreen());

      case RoutePaths.signUpPhoneScreen:
        return _navigate(SignUpWithPhoneScreen());

      case RoutePaths.signUpEmailScreen:
        return _navigate(SignUpWithEmailScreen());

      case RoutePaths.signUpPhoneConfirmationScreen:
        return _navigate(SignUpWithPhoneConfirmationScreen(
          newUser: routeSettings.arguments as UserEntity,
        ));

      case RoutePaths.signUpEmailConfirmationScreen:
        return _navigate(SignUpWithEmailConfirmationScreen());

      case RoutePaths.homeScreen:
        return _navigate(const HomeScreen());

      case RoutePaths.enterBraceletSerialScreen:
        return _navigate(EnterBraceletSerialScreen());

      case RoutePaths.chooseBraceletUserScreen:
        return _navigate(ChooseBraceletUserScreen(
          braceletId: routeSettings.arguments as String,
        ));

      case RoutePaths.connectOtherPersonBraceletScreen:
        return _navigate(ConnectOtherPersonBraceletScreen(
          braceletId: routeSettings.arguments as String,
        ));

      case RoutePaths.connectOwnBraceletScreen:
        return _navigate(ConnectOwnBraceletScreen(
          braceletId: routeSettings.arguments as String,
        ));

      default:
        return _navigate(SplashScreen());
    }
  }

  static MaterialPageRoute<dynamic> _navigate(Widget widget) {
    return MaterialPageRoute<dynamic>(builder: (context) => widget);
  }

  // static PageRouteBuilder<dynamic> _navigateWithoutAnimation(Widget widget) {
  //   return PageRouteBuilder<dynamic>(pageBuilder: (_, __, ___) => widget);
  // }
}
