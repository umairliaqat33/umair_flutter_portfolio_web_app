import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_bloc.dart';
import 'package:umair_liaqat/bloc/home_bloc/home_bloc.dart';
import 'package:umair_liaqat/bloc/login_bloc/login_bloc.dart';
import 'package:umair_liaqat/config/app_configurations.dart';
import 'package:umair_liaqat/firebase_options.dart';
import 'package:umair_liaqat/ui/home/home_screen.dart';
import 'package:umair_liaqat/utils/app_routes.dart';
import 'package:umair_liaqat/utils/app_theme.dart';

import 'bloc/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfigurations.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // await setupRemoteConfig(); // Initialize Remote Config
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(),
        ),
        BlocProvider<DetailsBloc>(
          create: (_) => DetailsBloc(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(1440, 1024),
        child: MaterialApp(
          title: 'Umair Liaqat',
          debugShowCheckedModeBanner: false,
          theme: PortfolioAppTheme.baseTheme(),
          initialRoute: HomeScreen.routeName,
          routes: routes,
        ),
      ),
    );
  }
}

// Future<FirebaseRemoteConfig> setupRemoteConfig() async {
//   final remoteConfig = FirebaseRemoteConfig.instance;

//   try {
//     await remoteConfig.setConfigSettings(RemoteConfigSettings(
//       fetchTimeout: const Duration(seconds: 10),
//       minimumFetchInterval:
//           const Duration(hours: 1), // Reduce unnecessary fetches
//     ));

//     await remoteConfig.fetchAndActivate();

//     debugPrint("🔥 Remote Config Fetched Successfully");
//   } catch (e) {
//     debugPrint("⚠️ Remote Config Error: $e");
//   }

//   return remoteConfig;
// }
