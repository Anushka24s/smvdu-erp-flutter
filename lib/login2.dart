import 'package:flutter/material.dart';
import 'DB2.dart';
import 'package:flutter/services.dart'; // for SystemChannels

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMVDU ERP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0D47A1),
          primary: const Color(0xFF1565C0),
        ),
        scaffoldBackgroundColor: Colors.grey.shade50,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutCubic,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _handleSignIn() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    // Simulate network delay – replace with real Google Sign-In later
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (_) => FacultyApp(
              //isDarkMode: false,
              //toggleTheme: (bool isDarkMode) {},
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 400;
    final horizontalPadding = isSmall ? 20.0 : 28.0;

    return GestureDetector(
      onTap:
          () =>
              FocusScope.of(
                context,
              ).unfocus(), // Tap anywhere → dismiss keyboard
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Enhanced Blue Hero Section ────────────────────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 16,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF0B3D91),
                            Color(0xFF1565C0),
                            Color(0xFF1E88E5),
                          ],
                          stops: [0.0, 0.55, 1.0],
                        ),
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.26),
                            blurRadius: 22,
                            spreadRadius: 1,
                            offset: const Offset(0, 10),
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(0.14),
                            blurRadius: 12,
                            spreadRadius: -4,
                            offset: const Offset(0, -4),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.12),
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          52,
                          horizontalPadding,
                          56,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 8),

                            // University ERP badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 26,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.14),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.65),
                                  width: 1.3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.22),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: const Text(
                                "University ERP",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ),

                            const SizedBox(height: 32),

                            Text(
                              "Streamline teaching,\nresearch & APR workflows",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isSmall ? 26 : 28,
                                fontWeight: FontWeight.w700,
                                height: 1.32,
                                letterSpacing: 0.2,
                                shadows: const [
                                  Shadow(
                                    color: Colors.black38,
                                    blurRadius: 8,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 32),

                            Divider(
                              color: Colors.white.withOpacity(0.50),
                              thickness: 1.5,
                              indent: 70,
                              endIndent: 70,
                            ),

                            const SizedBox(height: 36),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildStat(
                                  "128",
                                  "Active faculty\nonboarded",
                                  isSmall,
                                ),
                                _buildStat(
                                  "1.6K+",
                                  "Evidence files\nsecured",
                                  isSmall,
                                ),
                                _buildStat(
                                  "52",
                                  "APR workflows\nautomated",
                                  isSmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ── Sign-in Card ─────────────────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: Card(
                      elevation: 6,
                      shadowColor: Colors.blueGrey.withOpacity(0.24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(28, 40, 28, 44),
                        child: Column(
                          children: [
                            const Text(
                              "Sign in to SMVDU ERP",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0D47A1),
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Continue with your institutional Google Workspace account",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade700,
                                height: 1.45,
                              ),
                            ),
                            const SizedBox(height: 40),

                            SizedBox(
                              width: double.infinity,
                              height: 58,
                              child: AnimatedScaleButton(
                                onPressed: _isLoading ? null : _handleSignIn,
                                child: ElevatedButton(
                                  onPressed: null, // controlled by parent
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4285F4),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    elevation: 3,
                                    padding: EdgeInsets.zero,
                                  ),
                                  child:
                                      _isLoading
                                          ? const SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2.8,
                                            ),
                                          )
                                          : Image.asset(
                                            'assets/googleIcon.png',
                                            width: 180,
                                            height: 50,
                                            fit: BoxFit.contain,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Text(
                                                      "Sign in with Google",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                          ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 28),

                            Text(
                              "Need access? Contact the ERP administrator to enable your role.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String number, String label, bool isSmall) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            color: Colors.white,
            fontSize: isSmall ? 24 : 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.88),
            fontSize: isSmall ? 12 : 13,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

// Reusable subtle scale + opacity feedback on press
class AnimatedScaleButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const AnimatedScaleButton({super.key, required this.child, this.onPressed});

  @override
  State<AnimatedScaleButton> createState() => _AnimatedScaleButtonState();
}

class _AnimatedScaleButtonState extends State<AnimatedScaleButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed?.call();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        child: AnimatedOpacity(
          opacity: _isPressed ? 0.92 : 1.0,
          duration: const Duration(milliseconds: 140),
          child: widget.child,
        ),
      ),
    );
  }
}
