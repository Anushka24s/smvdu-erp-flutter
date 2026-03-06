import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: const Color(0xFF0D47A1),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() => _isDarkMode = !_isDarkMode);
              // TODO: implement real theme switching (e.g. via Provider)
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: Icon(
                Icons.person,
                color: const Color(0xFF0D47A1),
                size: 22,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF0D47A1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.school,
                      size: 48,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Faculty Member',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '23bee006@smvdu.ac.in',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              selected: true,
              selectedTileColor: const Color(0xFF0D47A1).withOpacity(0.1),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('My Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('My Teaching, Mentoring & Guidance'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Teaching'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Mentoring'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.lightbulb),
              title: const Text('Guidance'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.article),
              title: const Text('My Publications & IP'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.donut_small),
              title: const Text('Projects & Consultancy'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Events Organized'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.design_services_rounded),
              title: const Text('Service & Outreach'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                // TODO: logout logic
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── 2×2 Grid of Stat Cards ────────────────────────────────
            Builder(
              builder: (context) {
                final width = MediaQuery.of(context).size.width;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.6,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return _buildStatCard(
                      title:
                          [
                            'Pending tasks',
                            'Documents missing proof',
                            'APR status',
                            'Student feedback summary',
                          ][index],
                      value: ['4', '6', 'Draft', '4.3 / 5'][index],
                      subtitle:
                          [
                            'Approvals awaiting action',
                            'Upload evidence to claim points',
                            'Compile APR to begin submission',
                            'Latest academic year average',
                          ][index],
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 24),

            // ── Full-width rectangular Events card ────────────────────
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Events this year',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Attended or organized',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    Text(
                      '9',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Points by category ────────────────────────────────────
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Points by category',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildProgressBar(
                      'Teaching & Mentoring',
                      72,
                      100,
                      const Color(0xFF1976D2),
                    ),
                    const SizedBox(height: 16),
                    _buildProgressBar(
                      'Research & Publications',
                      54,
                      100,
                      const Color(0xFF388E3C),
                    ),
                    const SizedBox(height: 16),
                    _buildProgressBar(
                      'Projects & Consultancy',
                      28,
                      100,
                      const Color(0xFFFFA000),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Upcoming deadlines ────────────────────────────────────
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Upcoming deadlines',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16),
                    ListTile(
                      leading: Icon(Icons.calendar_today, color: Colors.red),
                      title: Text('Upload mentoring minutes'),
                      subtitle: Text('Mentoring • 12 Mar 2025'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.description, color: Colors.orange),
                      title: Text('Attach indexing proof'),
                      subtitle: Text('Pending action'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
                maxLines: 1,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(String label, int value, int max, Color color) {
    final progress = value / max;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 12,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '$value pts',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
