import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ixir_app/presentation/bloc/connect_bracelet/connect_bracelet_cubit.dart';
import 'package:ixir_app/presentation/bloc/email_auth/email_auth_cubit.dart';

import 'injection_container.dart' as di;
import 'presentation/bloc/auth/auth_cubit.dart';
import 'presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'presentation/bloc/user/user_cubit.dart';
import 'presentation/navigation/route_generator.dart';
import 'presentation/navigation/route_paths.dart';
import 'presentation/widgets/theme/app_themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();

  /// TODO: put in its own service
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthCubit>()..checkAuth(),
        ),
        BlocProvider(
          create: (_) => di.sl<PhoneAuthCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl<EmailAuthCubit>(),
        ),
        BlocProvider<UserCubit>(
          create: (_) => di.sl<UserCubit>()..getUsers(),
        ),
        BlocProvider<ConnectBraceletCubit>(
          create: (_) => di.sl<ConnectBraceletCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ixir',
        //  supportedLocales: S.delegate.supportedLocales,
        // supportedLocales: Localizations.,
        // localizationsDelegates: Localizations.delegate,
        theme: AppThemes.getMainTheme(context),
        initialRoute: RoutePaths.splashScreen,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
