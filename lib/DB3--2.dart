import 'package:flutter/material.dart';
import 'profilepage.dart';

// Entry point wrapper to handle Theme state
class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  bool _isDarkMode = false;

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMVDU ERP',
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      home: DashboardScreen1(
        isDarkMode: _isDarkMode,
        toggleTheme: _toggleTheme,
      ),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    const primaryColor = Color(0xFF0D47A1); // SMVDU Blue

    final scaffoldBg = isDark ? const Color(0xFF121212) : Colors.grey.shade50;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1E1E1E);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: brightness,
      ),
      scaffoldBackgroundColor: scaffoldBg,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardTheme(
        color: cardColor,
        elevation: isDark ? 0 : 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadowColor: Colors.black12,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(color: textColor),
        bodySmall: TextStyle(
          color: isDark ? Colors.grey[400]! : Colors.grey[600]!,
        ),
      ),
      dividerColor: isDark ? Colors.grey[800] : Colors.grey[200],
      iconTheme: IconThemeData(color: isDark ? Colors.white : primaryColor),
    );
  }
}

class DashboardScreen1 extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme;

  const DashboardScreen1({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  State<DashboardScreen1> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen1> {
  // Mock User Data
  final String _userName = "Dr. R. Sharma";
  final String _userRole = "Associate Professor";
  final String _userEmail = "23bee006@smvdu.ac.in";

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final theme = Theme.of(context);

    return Scaffold(
      drawer: _buildDrawer(context, isDark),
      body: CustomScrollView(
        slivers: [
          // App Bar with solid color (removed gradient for a more professional look)
          SliverAppBar(
            expandedHeight: 80, // Slightly reduced height for a cleaner feel
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Dashboard',
                style: TextStyle(
                  fontWeight:
                      FontWeight.w400, // Bolder font for professionalism
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              background: Container(
                color: const Color(
                  0xFF0D47A1,
                ), // Solid color instead of gradient
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                color: Colors.white,
                onPressed: () => widget.toggleTheme(!widget.isDarkMode),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: CircleAvatar(
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ],
          ),

          // Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Header
                  _buildWelcomeSection(theme),
                  const SizedBox(height: 8), // Reduced gap from 14 to 8
                  // Stats Grid
                  _buildStatsGrid(theme),
                  const SizedBox(height: 24),

                  // Points Section
                  _buildPointsCard(theme, isDark),
                  const SizedBox(height: 24),

                  // Deadlines Section
                  _buildDeadlinesCard(theme),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome back', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 4),
        Text(
          'Here is your activity summary for today.',
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(ThemeData theme) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.3,
      children: [
        _buildStatTile(
          title: 'Pending Tasks',
          value: '4',
          subtitle: 'Approvals',
          icon: Icons.pending_actions,
          color: Colors.orange,
        ),
        _buildStatTile(
          title: 'Missing Docs',
          value: '6',
          subtitle: 'Upload proof',
          icon: Icons.warning_amber_rounded,
          color: Colors.red,
        ),
        _buildStatTile(
          title: 'APR Status',
          value: 'Draft',
          subtitle: 'Compile now',
          icon: Icons.description_outlined,
          color: Colors.blue,
        ),
        _buildStatTile(
          title: 'Feedback',
          value: '4.3/5',
          subtitle: 'Avg. Score',
          icon: Icons.star_rounded,
          color: Colors.teal,
        ),
      ],
    );
  }

  Widget _buildStatTile({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Colors.grey[400],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsCard(ThemeData theme, bool isDark) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Points by Category', style: theme.textTheme.titleLarge),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D47A1).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Total: 154',
                    style: TextStyle(
                      color: Color(0xFF0D47A1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildProgressRow(
              'Teaching & Mentoring',
              72,
              100,
              const Color(0xFF1976D2),
            ),
            const SizedBox(height: 16),
            _buildProgressRow(
              'Research & Pub.',
              54,
              100,
              const Color(0xFF388E3C),
            ),
            const SizedBox(height: 16),
            _buildProgressRow(
              'Projects & Consultancy',
              28,
              100,
              const Color(0xFFFFA000),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressRow(String label, int value, int max, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            Text(
              '$value pts',
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: value / max,
            minHeight: 8,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _buildDeadlinesCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Upcoming Deadlines', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            _buildDeadlineItem(
              icon: Icons.calendar_today,
              title: 'Upload Mentoring Minutes',
              subtitle: 'Mentoring',
              date: '12 Mar 2025',
              urgencyColor: Colors.red,
            ),
            const Divider(height: 24),
            _buildDeadlineItem(
              icon: Icons.description,
              title: 'Attach Indexing Proof',
              subtitle: 'Publication',
              date: '15 Mar 2025',
              urgencyColor: Colors.orange,
            ),
            const Divider(height: 24),
            _buildDeadlineItem(
              icon: Icons.check_circle_outline,
              title: 'Submit QPR',
              subtitle: 'Admin',
              date: '20 Mar 2025',
              urgencyColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeadlineItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String date,
    required Color urgencyColor,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: urgencyColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: urgencyColor, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: urgencyColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            date,
            style: TextStyle(
              fontSize: 11,
              color: urgencyColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context, bool isDark) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.school, size: 48, color: Color(0xFF0D47A1)),
                ),
                SizedBox(height: 13),
                Text(
                  'Faculty Member',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 0),
                Text(
                  '23bee006@smvdu.ac.in',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          _drawerItem(Icons.dashboard, 'Dashboard', true, () {}),
          _drawerHeader('Academic'),
          _drawerItem(Icons.person, 'My Profile', false, () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ProfileScreen(
                      //isDarkMode: isDark,
                      //toggleTheme: widget.toggleTheme,
                    ),
              ),
            );
          }),
          _drawerItem(Icons.school, 'Teaching', false, () {}),
          _drawerItem(Icons.group, 'Mentoring', false, () {}),
          _drawerItem(Icons.lightbulb, 'Guidance', false, () {}),
          _drawerHeader('Research & Projects'),
          _drawerItem(Icons.article, 'Publications & IP', false, () {}),
          _drawerItem(
            Icons.donut_small,
            'Projects & Consultancy',
            false,
            () {},
          ),
          _drawerItem(Icons.event, 'Events Organized', false, () {}),
          _drawerItem(
            Icons.design_services_rounded,
            'Service & Outreach',
            false,
            () {},
          ),
          const Divider(),
          _drawerItem(Icons.logout, 'Logout', false, () {}, color: Colors.red),
        ],
      ),
    );
  }

  Widget _drawerItem(
    IconData icon,
    String title,
    bool selected,
    VoidCallback onTap, {
    Color? color,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: selected ? const Color(0xFF0D47A1) : (color ?? Colors.grey[700]),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: selected ? const Color(0xFF0D47A1) : Colors.black87,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: selected,
      selectedTileColor: const Color(0xFF0D47A1).withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
    );
  }

  Widget _drawerHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
