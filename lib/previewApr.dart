import 'package:flutter/material.dart';
import 'app_navigation.dart';
import 'app_theme.dart';

void main() => runApp(const _AprApp());

class _AprApp extends StatelessWidget {
  const _AprApp();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder:
          (_, mode, __) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: buildLightTheme(),
            darkTheme: buildDarkTheme(),
            themeMode: mode,
            home: const PreviewAprPage(),
          ),
    );
  }
}

// ─── Page ─────────────────────────────────────────────────────────────────────

class PreviewAprPage extends StatefulWidget {
  const PreviewAprPage({super.key});

  @override
  State<PreviewAprPage> createState() => _PrepareAprPageState();
}

class _PrepareAprPageState extends State<PreviewAprPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeCtrl;
  late Animation<double> _fade;

  // Workflow step states
  bool _compiling = false;
  bool _compiled = false;
  bool _validating = false;
  bool _validated = false;
  bool _computing = false;
  bool _computed = false;

  // Score data (mock)
  final Map<String, double> _scores = {
    'Teaching & Mentoring': 72,
    'Research & Publications': 54,
    'Projects & Consultancy': 28,
    'Events & Outreach': 36,
    'Service': 18,
  };
  double get _totalScore => _scores.values.fold(0, (a, b) => a + b);

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fade = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  // ─── Drawer ──────────────────────────────────────────────────────────────────

  // ignore: unused_element
  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFFFAFAFD),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0A2540), Color(0xFF1565C0)],
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 52, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white30, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: Color(0xFF1E3A5F),
                    child: Icon(Icons.person, size: 36, color: Colors.white70),
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  'Faculty Member',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '23bee006@smvdu.ac.in',
                  style: TextStyle(color: Colors.white60, fontSize: 12.5),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          _dItem(
            Icons.dashboard_outlined,
            'Dashboard',
            false,
            onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (r) => r.isFirst);
            },
          ),
          _dItem(Icons.person_outline, 'My Profile', false),
          _dSection('Teaching & Mentoring'),
          _dItem(
            Icons.school_outlined,
            'My Teaching, Mentoring & Guidance',
            false,
          ),
          _dSub(Icons.menu_book_outlined, 'Teaching', false),
          _dSub(Icons.group_outlined, 'Mentoring', false),
          _dSub(Icons.lightbulb_outline, 'Guidance', false),
          _dSection('Research'),
          _dItem(Icons.article_outlined, 'My Publications & IP', false),
          _dSub(Icons.library_books_outlined, 'Publications', false),
          _dSub(Icons.verified_outlined, 'IP & Patents', false),
          _dItem(
            Icons.business_center_outlined,
            'Projects & Consultancy',
            false,
          ),
          _dSection('Events & Service'),
          _dItem(
            Icons.event_note_outlined,
            'Conferences / FDP / Workshops',
            false,
          ),
          _dItem(Icons.campaign_outlined, 'Events Organized', false),
          _dItem(
            Icons.volunteer_activism_outlined,
            'Service & Outreach',
            false,
          ),
          _dSection('APR'),
          _dItem(Icons.assignment_outlined, 'APR', false),
          _dSub(Icons.edit_note_outlined, 'Prepare APR', true),
          _dSub(Icons.send_outlined, 'Preview & Submit', false),
          SizedBox(height: 8),
          Divider(indent: 16, endIndent: 16),
          _dItem(Icons.logout_rounded, 'Logout', false, isLogout: true),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _dSection(String l) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
    child: Text(
      l.toUpperCase(),
      style: TextStyle(
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        letterSpacing: 1.2,
      ),
    ),
  );

  Widget _dItem(
    IconData icon,
    String label,
    bool selected, {
    bool isLogout = false,
    VoidCallback? onTap,
  }) {
    final c =
        isLogout
            ? Colors.red[400]!
            : selected
            ? const Color(0xFF1565C0)
            : const Color(0xFF546E7A);
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(icon, size: 20, color: c),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          color:
              isLogout
                  ? Colors.red[400]
                  : selected
                  ? const Color(0xFF0A2540)
                  : const Color(0xFF37474F),
        ),
      ),
      selected: selected,
      selectedTileColor: const Color(0xFFE3F2FD),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: onTap ?? () => Navigator.pop(context),
    );
  }

  Widget _dSub(
    IconData icon,
    String label,
    bool selected, {
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        leading: Icon(
          icon,
          size: 18,
          color: selected ? const Color(0xFF1565C0) : const Color(0xFF78909C),
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected ? const Color(0xFF0A2540) : const Color(0xFF546E7A),
          ),
        ),
        selected: selected,
        selectedTileColor: const Color(0xFFE3F2FD),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onTap: onTap ?? () => Navigator.pop(context),
      ),
    );
  }

  // ─── Step Progress Bar ────────────────────────────────────────────────────────

  Widget _buildProgressBar() {
    final steps = [
      {'label': 'Compile', 'done': _compiled},
      {'label': 'Validate', 'done': _validated},
      {'label': 'Compute', 'done': _computed},
      {'label': 'Submit', 'done': false},
    ];
    final activeStep =
        _computed
            ? 3
            : _validated
            ? 2
            : _compiled
            ? 1
            : 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'APR Progress',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children:
                steps.asMap().entries.map((e) {
                  final i = e.key;
                  final step = e.value;
                  final isActive = i == activeStep;
                  final isDone = step['done'] as bool;
                  return Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color:
                                      isDone
                                          ? const Color(0xFF2E7D32)
                                          : isActive
                                          ? const Color(0xFF0A2540)
                                          : const Color(0xFFF0F4F8),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        isDone
                                            ? const Color(0xFF2E7D32)
                                            : isActive
                                            ? const Color(0xFF0A2540)
                                            : const Color(0xFFD0D8E0),
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child:
                                      isDone
                                          ? Icon(
                                            Icons.check_rounded,
                                            size: 16,
                                            color: Colors.white,
                                          )
                                          : Text(
                                            '${i + 1}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                              color:
                                                  isActive
                                                      ? Colors.white
                                                      : const Color(0xFF90A4AE),
                                            ),
                                          ),
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                step['label'] as String,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight:
                                      isActive || isDone
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                  color:
                                      isDone
                                          ? const Color(0xFF2E7D32)
                                          : isActive
                                          ? const Color(0xFF0A2540)
                                          : const Color(0xFF90A4AE),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (i < steps.length - 1)
                          Expanded(
                            child: Container(
                              height: 2,
                              margin: const EdgeInsets.only(bottom: 22),
                              color:
                                  isDone
                                      ? const Color(0xFF2E7D32)
                                      : const Color(0xFFE0E7EF),
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  // ─── Workflow Cards ───────────────────────────────────────────────────────────

  Widget _buildWorkflowCard({
    required int stepIndex,
    required String title,
    required String statusLabel,
    required Color statusColor,
    required Color statusBg,
    required IconData stepIcon,
    required String description,
    required String buttonLabel,
    required IconData buttonIcon,
    required bool loading,
    required bool done,
    required VoidCallback onTap,
  }) {
    return AnimatedBuilder(
      animation: _fade,
      builder:
          (_, child) => FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 0.06 * (stepIndex + 1)),
                end: Offset.zero,
              ).animate(_fade),
              child: child,
            ),
          ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border:
              done
                  ? Border.all(color: const Color(0xFF2E7D32).withOpacity(0.3))
                  : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title + status badge
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          done
                              ? const Color(0xFFE8F5E9)
                              : const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      stepIcon,
                      size: 20,
                      color:
                          done
                              ? const Color(0xFF2E7D32)
                              : const Color(0xFF0A2540),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: statusColor.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (done)
                          Icon(
                            Icons.check_circle_rounded,
                            size: 12,
                            color: Color(0xFF2E7D32),
                          )
                        else
                          Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        SizedBox(width: 5),
                        Text(
                          statusLabel,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 14),

              Text(
                description,
                style: TextStyle(
                  fontSize: 13.5,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 18),

              // Action button
              SizedBox(
                width: double.infinity,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors:
                          done
                              ? [
                                const Color(0xFF2E7D32),
                                const Color(0xFF43A047),
                              ]
                              : [
                                const Color(0xFF0A2540),
                                const Color(0xFF1565C0),
                              ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: (done
                                ? const Color(0xFF2E7D32)
                                : const Color(0xFF0A2540))
                            .withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: loading ? null : onTap,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        child:
                            loading
                                ? Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  ),
                                )
                                : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      done ? Icons.check_rounded : buttonIcon,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      done ? 'Done' : buttonLabel,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Score Card ───────────────────────────────────────────────────────────────

  Widget _buildScoreCard() {
    if (!_computed) return const SizedBox.shrink();
    return AnimatedBuilder(
      animation: _fade,
      builder: (_, child) => FadeTransition(opacity: _fade, child: child),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Live Scorecard',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_totalScore.toInt()} pts total',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ..._scores.entries.map((e) => _scorebar(e.key, e.value)),
          ],
        ),
      ),
    );
  }

  Widget _scorebar(String label, double score) {
    const maxScore = 100.0;
    final colors = [
      const Color(0xFF0A2540),
      const Color(0xFF1565C0),
      const Color(0xFF00897B),
      const Color(0xFF6A1B9A),
      const Color(0xFFE65100),
    ];
    final idx = _scores.keys.toList().indexOf(label);
    final color = colors[idx % colors.length];

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${score.toInt()} pts',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: score / maxScore),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              builder:
                  (_, val, __) => LinearProgressIndicator(
                    value: val,
                    minHeight: 7,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Action Handlers ──────────────────────────────────────────────────────────

  Future<void> _handleCompile() async {
    setState(() => _compiling = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _compiling = false;
      _compiled = true;
    });
    _showSnack('APR compiled successfully!', const Color(0xFF2E7D32));
  }

  Future<void> _handleValidate() async {
    if (!_compiled) {
      _showSnack('Please compile APR first.', const Color(0xFFE65100));
      return;
    }
    setState(() => _validating = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _validating = false;
      _validated = true;
    });
    _showSnack(
      'Validation complete — 2 items need proof.',
      const Color(0xFF1565C0),
    );
  }

  Future<void> _handleCompute() async {
    if (!_validated) {
      _showSnack('Please run validation first.', const Color(0xFFE65100));
      return;
    }
    setState(() => _computing = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _computing = false;
      _computed = true;
    });
    _showSnack(
      'Score computed — ${_totalScore.toInt()} pts!',
      const Color(0xFF2E7D32),
    );
  }

  void _handlePreview() {
    if (!_computed) {
      _showSnack('Please compute score first.', const Color(0xFFE65100));
      return;
    }
    _showPreviewSheet();
  }

  void _showSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // ─── Preview & Submit Sheet ───────────────────────────────────────────────────

  void _showPreviewSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => DraggableScrollableSheet(
            initialChildSize: 0.75,
            maxChildSize: 0.95,
            minChildSize: 0.5,
            builder:
                (_, ctrl) => Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: ListView(
                    controller: ctrl,
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // APR preview header
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0A2540), Color(0xFF1565C0)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Annual Performance Report',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'AY 2024–25 • Faculty Member',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 14),
                            Row(
                              children: [
                                _previewStat(
                                  '${_totalScore.toInt()}',
                                  'Total Score',
                                ),
                                _previewStat('${_scores.length}', 'Categories'),
                                _previewStat('2', 'Pending Proof'),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),
                      Text(
                        'Score Breakdown',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 12),

                      ..._scores.entries.map((e) {
                        final colors = [
                          const Color(0xFF0A2540),
                          const Color(0xFF1565C0),
                          const Color(0xFF00897B),
                          const Color(0xFF6A1B9A),
                          const Color(0xFFE65100),
                        ];
                        final idx = _scores.keys.toList().indexOf(e.key);
                        final c = colors[idx % colors.length];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: c,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  e.key,
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              Text(
                                '${e.value.toInt()} pts',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                  color: c,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      SizedBox(height: 20),
                      Divider(color: Color(0xFFF0F4F8)),
                      SizedBox(height: 16),

                      // Warning box
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFFFCC80)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              size: 18,
                              color: Color(0xFFE65100),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '2 records have pending proof. Only validated items earn points. Upload proof before submitting.',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: Color(0xFFE65100),
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24),
                      FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showSnack(
                            'APR submitted to HOD for review!',
                            const Color(0xFF2E7D32),
                          );
                        },
                        icon: Icon(Icons.send_rounded),
                        label: Text(
                          'Submit to HOD',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          minimumSize: const Size(double.infinity, 52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      OutlinedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.picture_as_pdf_outlined),
                        label: Text('Download PDF Preview'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          ),
    );
  }

  Widget _previewStat(String v, String l) => Expanded(
    child: Column(
      children: [
        Text(
          v,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(l, style: TextStyle(color: Colors.white60, fontSize: 11)),
      ],
    ),
  );

  // ─── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const FacultyNavigationDrawer(currentRoute: AppRoute.previewApr),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          'Prepare APR',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
        actions: [
          ThemeToggleButton(),
          CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFF1E3A5F),
            child: Icon(Icons.person, size: 18, color: Colors.white70),
          ),
          SizedBox(width: 12),
        ],
      ),
      body: RefreshIndicator(
        color: Theme.of(context).colorScheme.primary,
        onRefresh: () async => Future.delayed(const Duration(seconds: 1)),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // Page title
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                child: Text(
                  'APR Workflow',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.onSurface,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ),

            // Progress bar
            SliverToBoxAdapter(child: _buildProgressBar()),
            SliverToBoxAdapter(child: SizedBox(height: 8)),

            // ── Step 1: Compile ──────────────────────────────────
            SliverToBoxAdapter(
              child: _buildWorkflowCard(
                stepIndex: 0,
                title: 'Prepare APR',
                statusLabel: _compiled ? 'Compiled' : 'Draft',
                statusColor:
                    _compiled
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFF78909C),
                statusBg:
                    _compiled
                        ? const Color(0xFFE8F5E9)
                        : const Color(0xFFF0F4F8),
                stepIcon: Icons.description_outlined,
                description:
                    'Compile all records from the current academic year into the APR worksheet.',
                buttonLabel: 'Compile now',
                buttonIcon: Icons.auto_awesome_rounded,
                loading: _compiling,
                done: _compiled,
                onTap: _handleCompile,
              ),
            ),

            // ── Step 2: Validate ─────────────────────────────────
            SliverToBoxAdapter(
              child: _buildWorkflowCard(
                stepIndex: 1,
                title: 'Validate Evidence',
                statusLabel:
                    _validated ? 'Validated' : 'Evidence check pending',
                statusColor:
                    _validated
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFF1565C0),
                statusBg:
                    _validated
                        ? const Color(0xFFE8F5E9)
                        : const Color(0xFFE3F2FD),
                stepIcon: Icons.verified_outlined,
                description:
                    'Highlight records missing mandatory proofs. Only validated items earn points.',
                buttonLabel: 'Run validation',
                buttonIcon: Icons.fact_check_outlined,
                loading: _validating,
                done: _validated,
                onTap: _handleValidate,
              ),
            ),

            // ── Step 3: Compute ──────────────────────────────────
            SliverToBoxAdapter(
              child: _buildWorkflowCard(
                stepIndex: 2,
                title: 'Compute Points',
                statusLabel:
                    _computed ? 'Computed' : 'Last computed 2 days ago',
                statusColor:
                    _computed
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFF6A1B9A),
                statusBg:
                    _computed
                        ? const Color(0xFFE8F5E9)
                        : const Color(0xFFF3E5F5),
                stepIcon: Icons.bar_chart_rounded,
                description:
                    'Generate live scorecard per rubric with weighted points per section.',
                buttonLabel: 'Compute score',
                buttonIcon: Icons.calculate_outlined,
                loading: _computing,
                done: _computed,
                onTap: _handleCompute,
              ),
            ),

            // Live scorecard (shown after compute)
            SliverToBoxAdapter(child: _buildScoreCard()),

            // ── Step 4: Preview & Submit ─────────────────────────
            SliverToBoxAdapter(
              child: _buildWorkflowCard(
                stepIndex: 3,
                title: 'Preview & Submit',
                statusLabel: 'Not submitted',
                statusColor: const Color(0xFFE65100),
                statusBg: const Color(0xFFFFF3E0),
                stepIcon: Icons.send_outlined,
                description: 'Preview PDF snapshot and send to HOD for review.',
                buttonLabel: 'Open preview',
                buttonIcon: Icons.preview_outlined,
                loading: false,
                done: false,
                onTap: _handlePreview,
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }
}
