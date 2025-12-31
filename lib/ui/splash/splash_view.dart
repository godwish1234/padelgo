import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:padelgo/constants/icon.dart';
import 'package:padelgo/constants/image.dart';
import 'package:padelgo/ui/base/loading_aware_view_model_builder.dart';
import 'package:padelgo/ui/splash/splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingAwareViewModelBuilder<SplashViewModel>(
      viewModelBuilder: () => SplashViewModel(),
      onViewModelReady: (vm) {
        vm.setContext(context);
        vm.initialize();
      },
      builder: (context, vm, child) => Material(
        color: const Color(0xFFEBF5FD),
        child: Stack(children: [
          Container(color: const Color(0xFFEBF5FD)),
          Image.asset(
            ImageConstants.splash,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // RichText(
                      //     textAlign: TextAlign.center,
                      //     text: TextSpan(children: [
                      //       TextSpan(
                      //           text:
                      //               LocaleKeys.splash_title.tr().toUpperCase(),
                      //           style: const TextStyle(
                      //               color: Color(0xFF222222),
                      //               fontSize: 30,
                      //               fontWeight: FontWeight.bold,
                      //               fontStyle: FontStyle.italic)),
                      //       TextSpan(
                      //           text: LocaleKeys.splash_title_nominal
                      //               .tr()
                      //               .toUpperCase(),
                      //           style: const TextStyle(
                      //               color: Color(0xFFFF7116),
                      //               fontSize: 30,
                      //               fontWeight: FontWeight.bold,
                      //               fontStyle: FontStyle.italic))
                      //     ])),
                      // const SizedBox(height: 4),
                      // RichText(
                      //     textAlign: TextAlign.center,
                      //     text: TextSpan(children: [
                      //       TextSpan(
                      //           text: LocaleKeys.splash_subtitle
                      //               .tr()
                      //               .toUpperCase(),
                      //           style: const TextStyle(
                      //               color: Color(0xFF222222),
                      //               fontSize: 30,
                      //               fontWeight: FontWeight.bold,
                      //               fontStyle: FontStyle.italic)),
                      //       TextSpan(
                      //           text: LocaleKeys.app_name.tr().toUpperCase(),
                      //           style: const TextStyle(
                      //               color: Color(0xFF0467FF),
                      //               fontSize: 30,
                      //               fontWeight: FontWeight.bold,
                      //               fontStyle: FontStyle.italic))
                      //     ])),
                      // const SizedBox(height: 50),
                      // ClipRRect(
                      //     borderRadius: BorderRadius.circular(12),
                      //     child: Image.asset(
                      //       IconConstants.logo,
                      //       width: 95,
                      //       height: 95,
                      //       fit: BoxFit.cover,
                      //     )),
                      const SizedBox(height: 25),
                    ]),
              ))
        ]),
      ),
    );
  }
}
