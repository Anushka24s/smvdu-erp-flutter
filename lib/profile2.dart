import 'package:flutter/material.dart';
import 'app_navigation.dart';
import 'app_theme.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', textAlign: TextAlign.start),
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
            icon: ValueListenableBuilder<ThemeMode>(
              valueListenable: themeNotifier,
              builder:
                  (_, mode, __) => Icon(
                    mode == ThemeMode.dark
                        ? Icons.light_mode_outlined
                        : Icons.dark_mode_outlined,
                    color: Colors.white70,
                  ),
            ),
            onPressed: () {
              toggleAppTheme();
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.grey),
            ),
          ),
        ],
      ),
      drawer: const FacultyNavigationDrawer(currentRoute: AppRoute.profile),
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
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(labelText: 'Designation *'),
            controller: TextEditingController(text: 'Assistant Professor'),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(labelText: 'Phone'),
            controller: TextEditingController(text: '+91-9999999999'),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(labelText: 'Email *'),
            controller: TextEditingController(text: 'faculty@smvdu.ac.in'),
          ),
          SizedBox(height: 24),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('Upload Avatar'),
              ),
              SizedBox(width: 16),
              ElevatedButton(onPressed: () {}, child: Text('Upload CV')),
            ],
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
            child: Text('Save changes'),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderTab(String title) {
    return Center(child: Text(title, style: TextStyle(fontSize: 18)));
  }
}
