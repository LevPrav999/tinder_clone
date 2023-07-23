import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tinder_clone/common/repositories/common_messaging_repository.dart';
import 'package:tinder_clone/common/widgets/error.dart';
import 'package:tinder_clone/common/widgets/loader.dart';
import 'package:tinder_clone/firebase_options.dart';
import 'package:tinder_clone/new/application/user_service.dart';
import 'package:tinder_clone/new/data/auth_repository.dart';
import 'package:tinder_clone/new/presentaion/states/user_state.dart';
import 'package:tinder_clone/routes.dart';

import 'new/domain/user_model.dart';
import 'new/presentaion/screens/home_screen.dart';
import 'new/presentaion/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(ProviderScope(
      child: EasyLocalization(
          supportedLocales: [Locale('en'), Locale('ru')],
          useOnlyLangCode: true,
          saveLocale: false,
          path:
              'assets/translations',
          fallbackLocale: Locale('en'),
          child: MyApp())));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  @override
  void initState(){
    MessagingApi().initNotifications(ref);
    super.initState();
  }

  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(userServiceProvider)
        .getUserData(data.uid)
        .first
        .onError((error, stackTrace) {
      userModel = null;
      return null;
    });
    ref.read(userStateProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return ref.watch(authStateChangeProvider).when(
        data: (data) {
          if (data != null) getData(ref, data);
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
              useMaterial3: false,
            ),
            onGenerateRoute: Routes.generateRoute,
            home: userModel != null ? const HomeScreen() : const LoginScreen(),
          );
        },
        error: (error, trace) => ErrorScreen(error: error.toString()),
        loading: () => const LoaderWidget());
  }
}
