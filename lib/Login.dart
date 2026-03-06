import 'package:flutter/material.dart';
import 'package:smvdu_erp/DB2.dart';

// ─── Entry Point (remove if embedding into existing app) ──────────────────────
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
        scaffoldBackgroundColor: const Color(0xFFF4F6FB),
      ),
      home: const LoginScreen(),
    );
  }
}

// ─── Login Screen ─────────────────────────────────────────────────────────────

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _heroCtrl;
  late AnimationController _cardCtrl;
  late Animation<double> _heroFade;
  late Animation<Offset> _heroSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _heroCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _cardCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _heroFade = CurvedAnimation(parent: _heroCtrl, curve: Curves.easeOut);
    _heroSlide = Tween<Offset>(
      begin: const Offset(0, -0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _heroCtrl, curve: Curves.easeOutCubic));

    _cardFade = CurvedAnimation(parent: _cardCtrl, curve: Curves.easeOut);
    _cardSlide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _cardCtrl, curve: Curves.easeOutCubic));

    _heroCtrl.forward();
    Future.delayed(
      const Duration(milliseconds: 200),
      () => _cardCtrl.forward(),
    );
  }

  @override
  void dispose() {
    _heroCtrl.dispose();
    _cardCtrl.dispose();
    super.dispose();
  }

  void _handleSignIn() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const FacultyApp(), // ← your actual home screen
      ),
    ); // Navigator.pushReplacement(context,
    //   MaterialPageRoute(builder: (_) => const DashboardPage()));
  }

  // ─── Hero Panel ──────────────────────────────────────────────────────────────

  Widget _buildHeroPanel(double hPad) {
    return FadeTransition(
      opacity: _heroFade,
      child: SlideTransition(
        position: _heroSlide,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0B2E6E), Color(0xFF0D3B8C), Color(0xFF1565C0)],
              stops: [0.0, 0.5, 1.0],
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0D3B8C).withOpacity(0.35),
                blurRadius: 28,
                spreadRadius: 0,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Decorative blobs
              Positioned(
                top: -30,
                right: -30,
                child: _blob(160, Colors.white.withOpacity(0.04)),
              ),
              Positioned(
                bottom: -40,
                left: -20,
                child: _blob(140, Colors.white.withOpacity(0.05)),
              ),
              Positioned(
                top: 60,
                right: 20,
                child: _blob(60, Colors.white.withOpacity(0.06)),
              ),

              // Content
              Padding(
                padding: EdgeInsets.fromLTRB(hPad, 40, hPad, 44),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.55),
                          width: 1.2,
                        ),
                      ),
                      child: const Text(
                        'University ERP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Headline — matches web style: big, bold, left-aligned
                    const Text(
                      'Streamline\nteaching,\nresearch &\nAPR workflows',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        height: 1.22,
                        letterSpacing: -0.5,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Securely log in with your SMVDU Google Workspace account to access dashboards, upload evidence and track approvals in one place.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.78),
                        fontSize: 14,
                        height: 1.55,
                      ),
                    ),

                    const SizedBox(height: 28),

                    Divider(
                      color: Colors.white.withOpacity(0.25),
                      thickness: 1,
                    ),

                    const SizedBox(height: 28),

                    // Stats row — like web layout
                    Row(
                      children: [
                        _buildStat('128', 'Active faculty\nonboarded'),
                        _vDivider(),
                        _buildStat('1.6K+', 'Evidence files\nsecured'),
                        _vDivider(),
                        _buildStat('52', 'APR workflows\nautomated'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _blob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  Widget _buildStat(String number, String label) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _vDivider() => Container(
    width: 1,
    height: 48,
    color: Colors.white.withOpacity(0.2),
    margin: const EdgeInsets.symmetric(horizontal: 12),
  );

  // ─── Sign-in Card ────────────────────────────────────────────────────────────

  Widget _buildSignInCard(double hPad) {
    return FadeTransition(
      opacity: _cardFade,
      child: SlideTransition(
        position: _cardSlide,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 24,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(hPad, 36, hPad, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar — matches the "S" circle on web
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFF0D3B8C),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0D3B8C).withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'S',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Sign in to SMVDU ERP',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0B2350),
                  letterSpacing: -0.3,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Continue with your institutional Google Workspace credentials.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              // Google Sign-in button — mimics the web tile exactly
              _GoogleSignInButton(
                isLoading: _isLoading,
                onPressed: _handleSignIn,
              ),

              const SizedBox(height: 24),

              // Divider with "or"
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade200)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'or',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade200)),
                ],
              ),

              const SizedBox(height: 20),

              // Info note
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD0DCFF), width: 1),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 18,
                      color: Color(0xFF1565C0),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Need access? Contact the ERP administrator to enable your role.',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final hPad = size.width < 400 ? 20.0 : 24.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FB),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // App bar row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D3B8C).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'SMVDU',
                        style: TextStyle(
                          color: Color(0xFF0D3B8C),
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Text(
                        'v2.0',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                _buildHeroPanel(hPad),

                const SizedBox(height: 20),

                _buildSignInCard(hPad),

                const SizedBox(height: 32),

                // Footer
                Center(
                  child: Text(
                    '© 2025 Shri Mata Vaishno Devi University\nAll rights reserved.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade400,
                      height: 1.6,
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Google Sign-In Button ────────────────────────────────────────────────────

class _GoogleSignInButton extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _GoogleSignInButton({required this.isLoading, required this.onPressed});

  @override
  State<_GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<_GoogleSignInButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        if (!widget.isLoading) widget.onPressed();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 130),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 130),
          height: 54,
          decoration: BoxDecoration(
            color: _pressed ? const Color(0xFFF5F5F5) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _pressed ? Colors.grey.shade300 : Colors.grey.shade200,
              width: 1.5,
            ),
            boxShadow:
                _pressed
                    ? []
                    : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
          ),
          child:
              widget.isLoading
                  ? const Center(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Color(0xFF1565C0),
                      ),
                    ),
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Google "G" logo drawn with colored arcs (no asset needed)
                      _GoogleGIcon(size: 22),
                      const SizedBox(width: 12),
                      const Text(
                        'Sign in as Anushka',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1C1C1E),
                          letterSpacing: 0.1,
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}

// Draws the Google "G" with CustomPainter — no image asset required
class _GoogleGIcon extends StatelessWidget {
  final double size;
  const _GoogleGIcon({required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size(size, size), painter: _GoogleGPainter());
  }
}

class _GoogleGPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = size.width * 0.14;

    // Blue arc (top-right → bottom)
    _drawArc(
      canvas,
      center,
      radius,
      strokeWidth,
      -0.3,
      1.85,
      const Color(0xFF4285F4),
    );
    // Red arc (top-left)
    _drawArc(
      canvas,
      center,
      radius,
      strokeWidth,
      3.6,
      0.85,
      const Color(0xFFEA4335),
    );
    // Yellow arc (bottom-left)
    _drawArc(
      canvas,
      center,
      radius,
      strokeWidth,
      2.45,
      1.2,
      const Color(0xFFFBBC05),
    );
    // Green arc (bottom-right → top)
    _drawArc(
      canvas,
      center,
      radius,
      strokeWidth,
      1.55,
      0.9,
      const Color(0xFF34A853),
    );

    // White horizontal bar for the "G" cutout
    final barPaint =
        Paint()
          ..color = Colors.white
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.square;
    canvas.drawLine(
      Offset(center.dx, center.dy),
      Offset(center.dx + radius * 0.85, center.dy),
      barPaint,
    );
  }

  void _drawArc(
    Canvas canvas,
    Offset center,
    double radius,
    double strokeWidth,
    double startAngle,
    double sweepAngle,
    Color color,
  ) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
