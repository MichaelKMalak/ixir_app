import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common.dart';
import '../../domain/entities/user_entity.dart';
import '../bloc/auth/auth_cubit.dart';
import '../bloc/user/user_cubit.dart';
import '../navigation/route_paths.dart';
import '../widgets/buttons/custom_button_widget.dart';
import '../widgets/theme/app_colors.dart';
import '../widgets/theme/app_dimensions.dart';
import 'connect_bracelet/enter_bracelet_serial_screen.dart';
import 'splash_screen.dart';

class HomeScreen extends StatefulWidget {
  final UserEntity user;

  const HomeScreen({Key key, this.user}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, userState) {
      if (userState is UserNotConnectedBracelet) {
        return EnterBraceletSerialScreen();
      }

      if (userState is UserFailure) {
        return SplashScreen();
      }

      if (userState is UserLoading) {
        return LoadingScreen();
      }

      if (userState is UserLoaded) {
        return _Home();
      }

      return LoadingScreen();
    });
  }
}

class _Home extends StatefulWidget {
  @override
  __HomeState createState() => __HomeState();
}

class __HomeState extends State<_Home> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, authState) {
        if (authState is UnAuthenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutePaths.splashScreen, (route) => false);
        }
      },
      builder: (context, authState) {
        return Scaffold(
          body: Center(
            child: Padding(
                padding: AppDimensions.leftRightPagePadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('HOME PAGE PLACEHOLDER'),
                    const SizedBox(height: 20),
                    CustomButton(
                      buttonLabel: AppLocalizations.of(context).logout,
                      onClick: () async {
                        await BlocProvider.of<AuthCubit>(context).logOut();
                      },
                      buttonColorBt: AppColors.blueColor,
                      labelColorBt: AppColors.whiteColor,
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
