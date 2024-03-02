import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbound/bloc/user_bloc.dart';
import 'package:inbound/firebase_options.dart';
import 'package:inbound/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inbound/services/auth_service.dart';
import 'package:inbound/services/local_storage.dart';
import 'package:inbound/services/user_service.dart';
import 'package:inbound/widgets/animated_texts.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(_userService),
        ),
        BlocProvider<SenderBloc>(
          create: (context) => SenderBloc(_userService),
        ),
        BlocProvider<ConnectsBloc>(
          create: (context) => ConnectsBloc(_userService),
        ),
        // Add more BlocProviders as needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        fetchUserData();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthGate(),
          ),
        );
      });
    });
  }

  fetchUserData() async {
    final userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(FetchUser(await localStoreGetUId()));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF191919),
      body: Center(
        child: SlideInText(
          value: 'InBound.',
          size: 30,
          weight: FontWeight.bold,
        ),
      ),
    );
  }
}
