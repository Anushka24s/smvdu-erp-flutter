import 'dart:async';
import 'package:flutter/material.dart';

// Make sure these imports point to your actual file locations
import 'login.dart'; // ← your Login screen file
import 'dashboard.dart'; // ← your Dashboard screen file (adjust name if different)

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();

    // Start navigation logic after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateAfterDelay();
    });
  }

  Future<void> _navigateAfterDelay() async {
    // Minimum splash display time (adjust as you like: 2–4 seconds is common)
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // Replace this with your real authentication check later
    // Example:
    // bool isLoggedIn = await AuthService.isUserLoggedIn();
    // or FirebaseAuth.instance.currentUser != null
    const bool isLoggedIn =
        false; // ← for testing: change to true to go directly to dashboard

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SMVDU Logo
                Image.asset(
                  'assets/logo_smvdu.png',
                  width: 220,
                  height: 220,
                  fit: BoxFit.contain,
                  semanticLabel: 'SMVDU Logo',
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.school,
                      size: 180,
                      color: Color(0xFF0D47A1),
                    );
                  },
                ),

                const SizedBox(height: 40),

                // University ERP text (you had it commented — adding it back)
                const SizedBox(height: 60),

                // Loading indicator
                const SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF1565C0),
                    ),
                    strokeWidth: 4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
