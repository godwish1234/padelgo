import 'dart:async';
import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:padelgo/constants/colors.dart';
import 'package:padelgo/enums/language.dart';
import 'package:padelgo/firebase_options.dart';
import 'package:padelgo/generated/codegen_loader.g.dart';
import 'package:padelgo/helpers/preference_helper.dart';
import 'package:padelgo/initialization/padelgoinit.dart';
import 'package:padelgo/ui/base/keyboard_dismissible_wrapper.dart';
import 'package:padelgo/config/environment.dart';
import 'package:padelgo/config/router_config.dart' as app_router;
import 'package:padelgo/utils/appsflyer_util.dart';

var initError = false;

void main() {
  runZonedGuarded(
    () async {
      try {
        WidgetsFlutterBinding.ensureInitialized();
        await EasyLocalization.ensureInitialized();

        final savedLanguageId = await PkPreferenceHelper.getSelectedLanguage();
        Locale? savedLocale;
        if (savedLanguageId != null) {
          final savedLanguage = Language.byId(savedLanguageId);
          savedLocale = savedLanguage.toLocale();
        }

        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform);

        // Initialize Firebase Crashlytics
        if (!kIsWeb) {
          FlutterError.onError =
              FirebaseCrashlytics.instance.recordFlutterFatalError;

          PlatformDispatcher.instance.onError = (error, stack) {
            FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
            return true;
          };
        }

        AppsFlyerUtil.init();

        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.black));

        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
          SystemUiOverlay.top,
          SystemUiOverlay.bottom,
        ]);

        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);

        await PadelGoInit.launchInit();

        EnvironmentConfig.printEnvironmentInfo();

        return runApp(EasyLocalization(
            path: 'assets/translations',
            supportedLocales: [
              Language.englishUS.toLocale(),
              Language.bahasa.toLocale()
            ],
            startLocale: savedLocale ?? Language.bahasa.toLocale(),
            fallbackLocale: Language.bahasa.toLocale(),
            assetLoader: const CodegenLoader(),
            child: const PadelGo()));
      } catch (e) {
        initError = true;
        rethrow;
      }
    },
    (error, stack) {
      if (kDebugMode) {
        debugPrint(
            "ERROR main.dart (initError: $initError): ${error.toString()}");
      }
    },
  );
}

class PadelGo extends StatefulWidget {
  const PadelGo({super.key});

  @override
  State<StatefulWidget> createState() => _PadelGoState();
}

class _PadelGoState extends State<PadelGo> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pilih Kredit',
      routerConfig: app_router.RouterConfig.router,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: KeyboardDismissibleWrapper(
            child: BotToastInit()(context, child),
          ),
        );
      },
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primaryColor: BaseColors.primaryColor,
        colorScheme: ColorScheme.fromSeed(seedColor: BaseColors.primaryColor),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(0, 163, 124, 124),
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
