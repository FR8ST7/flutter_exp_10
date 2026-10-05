import 'package:flutter/material.dart';

void main() {
  runApp(const AndroidBuildApp());
}

class AndroidBuildApp extends StatelessWidget {
  const AndroidBuildApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Experiment 10 - Android Target',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3DDC84), // Android Green
          brightness: Brightness.dark,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const AndroidHomeScreen(),
    );
  }
}

class AndroidHomeScreen extends StatefulWidget {
  const AndroidHomeScreen({super.key});

  @override
  State<AndroidHomeScreen> createState() => _AndroidHomeScreenState();
}

class _AndroidHomeScreenState extends State<AndroidHomeScreen> {
  int _selectedTab = 0;
  bool _licensesAccepted = true;
  bool _isBuildingApk = false;
  double _buildProgress = 0.0;
  String _buildStatusText = 'Ready to build APK';
  final List<String> _buildLogs = [];

  final List<Map<String, dynamic>> _devices = [
    {
      'name': 'Pixel 7 Pro (Simulator)',
      'id': 'emulator-5554',
      'platform': 'Android 13.0 (API 33)',
      'type': 'emulator',
      'active': true,
    },
    {
      'name': 'Samsung Galaxy S23',
      'id': 'R58M90ABC12',
      'platform': 'Android 14.0 (API 34)',
      'type': 'device',
      'active': true,
    },
    {
      'name': 'Chrome (Web)',
      'id': 'chrome',
      'platform': 'Web JavaScript',
      'type': 'web',
      'active': false,
    },
  ];

  void _simulateApkBuild() async {
    setState(() {
      _isBuildingApk = true;
      _buildProgress = 0.1;
      _buildStatusText = 'Initializing Gradle build...';
      _buildLogs.clear();
      _buildLogs.add('> flutter build apk');
      _buildLogs.add('Running Gradle task "assembleRelease"...');
    });

    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      _buildProgress = 0.35;
      _buildStatusText = 'Compiling Dart code to native ARM64 architecture...';
      _buildLogs.add('√ Built build/app/outputs/flutter-apk/app.apk');
      _buildLogs.add('Compiling Kotlin/Java source files...');
    });

    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _buildProgress = 0.70;
      _buildStatusText = 'Packaging APK assets and signing release bundle...';
      _buildLogs.add('Signing APK with default debug keystore...');
      _buildLogs.add('Optimizing dex files with R8...');
    });

    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _buildProgress = 1.0;
      _isBuildingApk = false;
      _buildStatusText = 'APK Build Succeeded!';
      _buildLogs.add('✓ Built build/app/outputs/flutter-apk/app-release.apk (18.4 MB).');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.android, color: Color(0xFF3DDC84)),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAlignment.start,
              children: [
                Text(
                  'Experiment 10: Android Build Target',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'flutter create android_app && flutter build apk',
                  style: TextStyle(fontSize: 11, color: Colors.white60, fontFamily: 'monospace'),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
      ),
      body: Row(
        children: [
          // Navigation Sidebar
          NavigationRail(
            backgroundColor: const Color(0xFF1E293B),
            selectedIndex: _selectedTab,
            onDestinationSelected: (index) {
              setState(() => _selectedTab = index);
            },
            labelType: NavigationRailLabelType.selected,
            selectedIconTheme: const IconThemeData(color: Color(0xFF3DDC84)),
            unselectedIconTheme: const IconThemeData(color: Colors.white38),
            selectedLabelStyle: const TextStyle(color: Color(0xFF3DDC84), fontSize: 12),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: Text('Overview'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.medical_services_outlined),
                selectedIcon: Icon(Icons.medical_services),
                label: Text('Doctor Check'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.phonelink_setup_outlined),
                selectedIcon: Icon(Icons.phonelink_setup),
                label: Text('Devices'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.build_circle_outlined),
                selectedIcon: Icon(Icons.build_circle),
                label: Text('APK Builder'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1, color: Color(0xFF334155)),

          // Main View Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildSelectedTabContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedTabContent() {
    switch (_selectedTab) {
      case 0:
        return _buildOverviewTab();
      case 1:
        return _buildDoctorTab();
      case 2:
        return _buildDevicesTab();
      case 3:
        return _buildApkBuilderTab();
      default:
        return _buildOverviewTab();
    }
  }

  Widget _buildOverviewTab() {
    return ListView(
      children: [
        const Text(
          'Android Target Configuration Overview',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 6),
        const Text(
          'Configuring, compiling, building, and deploying a Flutter application for the Android platform.',
          style: TextStyle(color: Colors.white60, fontSize: 14),
        ),
        const SizedBox(height: 20),

        // Steps Grid
        GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 2.2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildStepCard(
              stepNum: 'Step 1-3',
              title: 'Environment & Licenses',
              desc: 'Run flutter doctor & accept licenses via --android-licenses',
              icon: Icons.verified_user,
              status: 'Checked',
              statusColor: const Color(0xFF3DDC84),
            ),
            _buildStepCard(
              stepNum: 'Step 4',
              title: 'Create Application',
              desc: 'flutter create android_app && cd android_app',
              icon: Icons.create_new_folder,
              status: 'Created',
              statusColor: Colors.blueAccent,
            ),
            _buildStepCard(
              stepNum: 'Step 5',
              title: 'Run on Device',
              desc: 'flutter run -d <android-device-id>',
              icon: Icons.play_circle_fill,
              status: 'Ready',
              statusColor: Colors.purpleAccent,
            ),
            _buildStepCard(
              stepNum: 'Step 6-8',
              title: 'Build & Locate APK',
              desc: 'flutter build apk -> build/app/outputs/flutter-apk/app-release.apk',
              icon: Icons.android,
              status: 'Executable',
              statusColor: Colors.amberAccent,
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Quick Command Console
        Card(
          color: const Color(0xFF1E293B),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.terminal, color: Color(0xFF3DDC84), size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Terminal Execution Sequence',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                const Divider(height: 20, color: Colors.white12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF090D16),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: const Text(
                    '# 1. Verify Flutter environment\nflutter doctor\n\n# 2. Check Android devices & toolchain licenses\nflutter devices\nflutter doctor --android-licenses\n\n# 3. Create project & build APK\nflutter create android_app\ncd android_app\nflutter run\nflutter build apk\n\n# 4. Locate APK output file\nls build/app/outputs/flutter-apk/app-release.apk',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 13, color: Color(0xFFA7F3D0), height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepCard({
    required String stepNum,
    required String title,
    required String desc,
    required IconData icon,
    required String status,
    required Color statusColor,
  }) {
    return Card(
      color: const Color(0xFF1E293B),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: statusColor.withOpacity(0.4)),
                  ),
                  child: Text(
                    stepNum,
                    style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Icon(icon, color: statusColor, size: 20),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              desc,
              style: const TextStyle(fontSize: 11, color: Colors.white54),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorTab() {
    return ListView(
      children: [
        const Text(
          'Step 1 & 3: Flutter Doctor Diagnostic Checklist',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 6),
        const Text(
          'Validating installed SDKs, Android Studio, Java Development Kit (JDK), and Android licenses.',
          style: TextStyle(color: Colors.white60, fontSize: 13),
        ),
        const SizedBox(height: 16),
        _buildDoctorCheckItem(
          title: 'Flutter SDK (Channel stable, 3.22.0)',
          subtitle: 'Tools installed and available in PATH',
          isOK: true,
        ),
        _buildDoctorCheckItem(
          title: 'Android Toolchain - develop for Android devices',
          subtitle: 'Android SDK version 34.0.0, Platform android-34, Build-tools 34.0.0',
          isOK: true,
        ),
        _buildDoctorCheckItem(
          title: 'Android Licenses Accepted',
          subtitle: 'All required Android SDK licenses accepted (flutter doctor --android-licenses)',
          isOK: _licensesAccepted,
        ),
        _buildDoctorCheckItem(
          title: 'Android Studio (version 2024.1)',
          subtitle: 'Flutter plugin & Dart plugin installed',
          isOK: true,
        ),
        _buildDoctorCheckItem(
          title: 'Connected Devices (1 available)',
          subtitle: 'Pixel 7 Pro (mobile) • emulator-5554 • android-arm64 • Android 13.0',
          isOK: true,
        ),
        const SizedBox(height: 20),
        Card(
          color: const Color(0xFF1E293B),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.gavel, color: Color(0xFF3DDC84)),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAlignment.start,
                    children: [
                      Text(
                        'Android License Acceptance Status',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        'Command: flutter doctor --android-licenses',
                        style: TextStyle(fontSize: 12, color: Colors.white54, fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _licensesAccepted,
                  activeColor: const Color(0xFF3DDC84),
                  onChanged: (val) {
                    setState(() => _licensesAccepted = val);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorCheckItem({
    required String title,
    required String subtitle,
    required bool isOK,
  }) {
    return Card(
      color: const Color(0xFF1E293B),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isOK ? Colors.green.withOpacity(0.2) : Colors.amber.withOpacity(0.2),
          child: Icon(
            isOK ? Icons.check_circle : Icons.warning_amber_rounded,
            color: isOK ? const Color(0xFF3DDC84) : Colors.amber,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Colors.white60),
        ),
      ),
    );
  }

  Widget _buildDevicesTab() {
    return ListView(
      children: [
        const Text(
          'Step 2: Available Build Devices (`flutter devices`)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 6),
        const Text(
          'Target devices detected by Flutter for app execution and deployment.',
          style: TextStyle(color: Colors.white60, fontSize: 13),
        ),
        const SizedBox(height: 16),
        ..._devices.map((device) => Card(
              color: const Color(0xFF1E293B),
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: device['type'] == 'emulator' || device['type'] == 'device'
                      ? const Color(0xFF3DDC84).withOpacity(0.2)
                      : Colors.blueAccent.withOpacity(0.2),
                  child: Icon(
                    device['type'] == 'web' ? Icons.language : Icons.phone_android,
                    color: device['type'] == 'web' ? Colors.blueAccent : const Color(0xFF3DDC84),
                  ),
                ),
                title: Text(
                  device['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                subtitle: Text(
                  'ID: ${device['id']} • Platform: ${device['platform']}',
                  style: const TextStyle(fontSize: 12, color: Colors.white54, fontFamily: 'monospace'),
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: device['active'] ? Colors.green.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: device['active'] ? const Color(0xFF3DDC84) : Colors.grey,
                    ),
                  ),
                  child: Text(
                    device['active'] ? 'Connected' : 'Offline',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: device['active'] ? const Color(0xFF3DDC84) : Colors.grey,
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildApkBuilderTab() {
    return ListView(
      children: [
        const Text(
          'Step 6 & 7: Android APK Build Simulator',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 6),
        const Text(
          'Execute `flutter build apk` to compile native binaries into Android package outputs.',
          style: TextStyle(color: Colors.white60, fontSize: 13),
        ),
        const SizedBox(height: 16),
        Card(
          color: const Color(0xFF1E293B),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAlignment.start,
              children: [
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: _isBuildingApk ? null : _simulateApkBuild,
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: Text(_isBuildingApk ? 'Building APK...' : 'Build APK (flutter build apk)'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3DDC84),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      _buildStatusText,
                      style: TextStyle(
                        color: _buildProgress == 1.0 ? const Color(0xFF3DDC84) : Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                if (_isBuildingApk || _buildProgress > 0) ...[
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: _buildProgress,
                    color: const Color(0xFF3DDC84),
                    backgroundColor: Colors.white12,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
                if (_buildLogs.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF090D16),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAlignment.start,
                      children: _buildLogs
                          .map((log) => Text(
                                log,
                                style: const TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                  color: Color(0xFF3DDC84),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Step 7: APK Location Card
        Card(
          color: const Color(0xFF1E293B),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.folder_open, color: Colors.amberAccent),
                    SizedBox(width: 10),
                    Text(
                      'Step 7: Generated APK Output Location',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF090D16),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.amberAccent.withOpacity(0.3)),
                  ),
                  child: const SelectableText(
                    'build/app/outputs/flutter-apk/app-release.apk\nbuild/app/outputs/flutter-apk/app-debug.apk',
                    style: TextStyle(fontFamily: 'monospace', color: Colors.amberAccent, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Step 8: Installation onto Android Device via ADB:',
                  style: TextStyle(fontSize: 12, color: Colors.white60, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const SelectableText(
                    'adb install build/app/outputs/flutter-apk/app-release.apk',
                    style: TextStyle(fontFamily: 'monospace', color: Colors.white90, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
