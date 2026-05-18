import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/signin_email_screen.dart';
import 'screens/signin_password_screen.dart';
import 'screens/account_setup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/contract_screen.dart';
import 'screens/attendance_screen.dart';
import 'screens/connections_screen.dart';
import 'screens/profile_screen.dart';
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

// Tracks which screen we're on during auth flow
enum _AuthStep { email, password, accountSetup, student, staff }

class _AuthWrapper extends StatefulWidget {
  const _AuthWrapper();

  @override
  State<_AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<_AuthWrapper> {
  _AuthStep _step = _AuthStep.email;
  String _email = '';
  String _token = '';  // stores JWT token after login
  String _role = '';   // stores STUDENT or STAFF after login

  void _goTo(_AuthStep step) => setState(() => _step = step);

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
          // Called when login succeeds — saves token and routes by role
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
          onSignOut: () {
            setState(() {
              _step = _AuthStep.email;
              _token = '';
              _role = '';
            });
          },
        );

      case _AuthStep.staff:
      // Staff dashboard — to be built
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Staff Dashboard',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _step = _AuthStep.email;
                      _token = '';
                      _role = '';
                    });
                  },
                  child: const Text('Sign out'),
                ),
              ],
            ),
          ),
        );
    }
  }
}

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