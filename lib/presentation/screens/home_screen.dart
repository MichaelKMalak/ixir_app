import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ixir_app/presentation/bloc/auth/auth_cubit.dart';
import 'package:ixir_app/presentation/bloc/user/user_cubit.dart';
import 'package:ixir_app/presentation/navigation/route_paths.dart';
import 'package:ixir_app/presentation/screens/splash_screen.dart';
import 'package:ixir_app/presentation/widgets/buttons/custom_button_widget.dart';
import 'package:ixir_app/presentation/widgets/theme/app_colors.dart';
import 'package:ixir_app/presentation/widgets/theme/app_dimensions.dart';

import '../../domain/entities/user_entity.dart';
import 'connect_bracelet/enter_bracelet_serial_screen.dart';

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
                    Text('HOME PAGE'),
                    SizedBox(height: 20),
                    CustomButton(
                      buttonLabel: 'Logout',
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
