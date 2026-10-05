# Experiment 10 – Add Android as a Build Target

## Aim
To configure and build a Flutter application for Android.

## Steps Implemented
1. **Check Flutter**: Ran `flutter doctor` to verify Flutter SDK and platform tools.
2. **Check Android Devices**: Executed `flutter devices` to list connected emulators/devices.
3. **Check Android Toolchain**: Accepted SDK licenses using `flutter doctor --android-licenses`.
4. **Create Application**: Created Flutter project `android_app` via `flutter create android_app`.
5. **Run on Android**: Executed application using `flutter run`.
6. **Check Android Build**: Compiled release package via `flutter build apk`.
7. **Locate APK**: Output generated at `build/app/outputs/flutter-apk/app-release.apk`.
8. **Test APK**: Installed APK on device via ADB (`adb install build/app/outputs/flutter-apk/app-release.apk`).

## Deployment & Live Demo
- **GitHub Repository**: `FR8ST7/flutter_exp_10`
- **Live Demo**: [https://fr8st7.github.io/flutter_exp_10/](https://fr8st7.github.io/flutter_exp_10/)
