import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login/signin_email_screen.dart';
import 'screens/login/signin_password_screen.dart';
import 'screens/login/account_setup_screen.dart';
import 'screens/student/home_screen.dart';
import 'screens/student//contract_screen.dart';
import 'screens/student/attendance_screen.dart';
import 'screens/student/connections_screen.dart';
import 'screens/student/profile_screen.dart';
import 'screens/staff/staff_home_screen.dart';
import 'screens/staff/staff_roster_screen.dart';
import 'screens/staff/staff_attendance_screen.dart';
import 'screens/staff/staff_qr_screen.dart';
import 'widgets/bottom_nav.dart';
import 'widgets/more_bottom_sheet.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connect — Year Up United',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3D1D8C)),
        useMaterial3: true,
      ),
      home: const _AuthWrapper(),
    );
  }
}

enum _AuthStep { email, password, accountSetup, student, staff }

class _AuthWrapper extends StatefulWidget {
  const _AuthWrapper();

  @override
  State<_AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<_AuthWrapper> {
  _AuthStep _step = _AuthStep.email;
  String _email = '';
  String _token = '';
  String _role = '';

  void _goTo(_AuthStep step) => setState(() => _step = step);

  void _signOut() {
    setState(() {
      _step = _AuthStep.email;
      _token = '';
      _role = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_step) {
      case _AuthStep.email:
        return SignInEmailScreen(
          initialEmail: _email,
          onContinue: (email) {
            setState(() {
              _email = email;
              _step = _AuthStep.password;
            });
          },
        );

      case _AuthStep.password:
        return SignInPasswordScreen(
          email: _email,
          onBack: () => _goTo(_AuthStep.email),
          onSetupPassword: () => _goTo(_AuthStep.accountSetup),
          onSuccess: (token, role) {
            setState(() {
              _token = token;
              _role = role;
              _step = role == 'STAFF' ? _AuthStep.staff : _AuthStep.student;
            });
          },
        );

      case _AuthStep.accountSetup:
        return AccountSetupScreen(
          onBack: () => _goTo(_AuthStep.password),
          onComplete: () => _goTo(_AuthStep.student),
        );

      case _AuthStep.student:
        return MainLayout(
          token: _token,
          onSignOut: _signOut,
        );

      case _AuthStep.staff:
        return StaffLayout(
          token: _token,
          onSignOut: _signOut,
        );
    }
  }
}

// ─── STUDENT LAYOUT ──────────────────────────────────────────────────────────

class MainLayout extends StatefulWidget {
  final String token;
  final VoidCallback onSignOut;

  const MainLayout({super.key, required this.token, required this.onSignOut});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  void _onTabSelected(int index) {
    if (index == 4) {
      showMoreBottomSheet(
        context,
        onSignOut: widget.onSignOut,
        onViewProfile: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ProfileScreen()),
          );
        },
      );
      return;
    }
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(token: widget.token),
      const ContractScreen(),
      const AttendanceScreen(),
      const ConnectionsScreen(),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNav(
        selectedIndex: _selectedIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}

// ─── STAFF LAYOUT ─────────────────────────────────────────────────────────────

class StaffLayout extends StatefulWidget {
  final String token;
  final VoidCallback onSignOut;

  const StaffLayout({super.key, required this.token, required this.onSignOut});

  @override
  State<StaffLayout> createState() => _StaffLayoutState();
}

class _StaffLayoutState extends State<StaffLayout> {
  int _selectedIndex = 0;

  // Tab labels matching the staff bottom nav
  static const _tabs = ['Home', 'Roster', 'Attendance', 'QR'];

  void _onTabSelected(int index) {
    // Index 4 = More/sign out
    if (index == 4) {
      showMoreBottomSheet(
        context,
        onSignOut: widget.onSignOut,
        onViewProfile: () {},
      );
      return;
    }
    setState(() => _selectedIndex = index);
  }

  // Switch tab by name — used by StaffHomeScreen quick action buttons
  void _switchTab(String tabName) {
    switch (tabName) {
      case 'staff-roster':
        setState(() => _selectedIndex = 1);
        break;
      case 'staff-attendance':
        setState(() => _selectedIndex = 2);
        break;
      case 'staff-qr':
        setState(() => _selectedIndex = 3);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      StaffHomeScreen(onSwitchTab: _switchTab),
      const StaffRosterScreen(),
      const StaffAttendanceScreen(),
      const StaffQRScreen(),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNav(
        selectedIndex: _selectedIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}