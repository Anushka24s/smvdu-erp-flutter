import 'package:flutter/material.dart';
import 'DB2.dart';

class ProfileScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme;

  const ProfileScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = widget.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile', textAlign: TextAlign.start),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'PERSONAL'),
            Tab(text: 'EMPLOYMENT'),
            Tab(text: 'DEPARTMENT MAPPING'),
            Tab(text: 'QUALIFICATIONS'),
            Tab(text: 'RESEARCH AREAS'),
            Tab(text: 'IDENTIFIERS'),
            Tab(text: 'BANK / PAN'),
            Tab(text: 'ADDRESS'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => widget.toggleTheme(!widget.isDarkMode),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.grey),
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
                  SizedBox(height: 13),
                  Text(
                    'Faculty Member',
                    style: TextStyle(color: Colors.white, fontSize: 20),
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
              selected: false,
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('My Profile'),
              selected: true,
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
            // Add more menu items as needed...
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
              leading: const Icon(Icons.logout),
              title: const Text('logout'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPersonalTab(theme),
          _buildPlaceholderTab('Employment Content'),
          _buildPlaceholderTab('Department Mapping Content'),
          _buildPlaceholderTab('Qualifications Content'),
          _buildPlaceholderTab('Research Areas Content'),
          _buildPlaceholderTab('Identifiers Content'),
          _buildPlaceholderTab('Bank / PAN Content'),
          _buildPlaceholderTab('Address Content'),
        ],
      ),
    );
  }

  Widget _buildPersonalTab(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Full Name *'),
            controller: TextEditingController(text: 'Faculty Member'),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(labelText: 'Designation *'),
            controller: TextEditingController(text: 'Assistant Professor'),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(labelText: 'Phone'),
            controller: TextEditingController(text: '+91-9999999999'),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(labelText: 'Email *'),
            controller: TextEditingController(text: 'faculty@smvdu.ac.in'),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Upload Avatar'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(onPressed: () {}, child: const Text('Upload CV')),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text('Save changes'),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderTab(String title) {
    return Center(child: Text(title, style: const TextStyle(fontSize: 18)));
  }
}
