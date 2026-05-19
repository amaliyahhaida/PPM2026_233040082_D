import 'package:flutter/material.dart';
import 'gallery_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            const ListTile(leading: Icon(Icons.home), title: Text('Beranda')),
            const ListTile(leading: Icon(Icons.person), title: Text('Profil')),
            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Widget Gallery'),
              onTap: () {
                Navigator.pop(context); // tutup drawer dulu
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GalleryHome()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Pengaturan'),
                    content: const Text('Fitur pengaturan belum tersedia.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Tutup'),
                      ),
                    ],
                  ),
                );
              },
            ),
            const ListTile(leading: Icon(Icons.info), title: Text('Tentang')),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // === HEADER PROFIL ===
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue.shade200,
                      child: ClipOval(
                          child: Image.network(
                            'https://api.dicebear.com/9.x/adventurer/png?seed=princess',
                            fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.person,
                                size: 50, color: Colors.white);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Amaliyah Nur Haida',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Mahasiswa Teknik Informatika',
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // === BARIS STATISTIK (Row + Expanded) ===
              Row(
                children: [
                  Expanded(child: _StatBox(label: 'Post', value: '15')),
                  Expanded(child: _StatBox(label: 'Teman', value: '99')),
                  Expanded(child: _StatBox(label: 'Like', value: '2.2K')),
                ],
              ),
              const SizedBox(height: 24),
              // === SECTION CARD ===
              _SectionCard(
                icon: Icons.info_outline,
                title: 'Tentang Saya',
                content: 'Saya suka belajar hal baru, terutama yang berkaitan '
                    'dengan teknologi dan pengembangan aplikasi mobile.',
              ),
              _SectionCard(
                icon: Icons.school,
                title: 'Pendidikan',
                content: 'Universitas Pasundan — Semester 6\nIPK: 4.00',
              ),
              _SectionCard(
                icon: Icons.favorite,
                title: 'Hobi & Minat',
                content: 'Musik • Olahraga • Game',
              ),
              _SectionCard(
                icon: Icons.email,
                title: 'Kontak',
                content: 'amaliyahnrhh@gmail.com\n+62 857-2346-9983',
              ),
              _SectionCard(
                icon: Icons.star,
                title: 'Skills',
                child: Wrap(
                  spacing: 8,
                  children: const [
                    Chip(label: Text('UI/UX Design')),
                    Chip(label: Text('Flutter')),
                    Chip(label: Text('Analisis Sistem')),
                    Chip(label: Text('Database')),
                    Chip(label: Text('Dart')),
                  ],
                ),
              ),
              const SizedBox(height: 80), // ruang agar FAB tidak nutupi konten
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Edit profil belum tersedia')),
          );
        },
        icon: const Icon(Icons.edit),
        label: const Text('Edit Profil'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profil'),
          NavigationDestination(icon: Icon(Icons.message_outlined), label: 'Pesan'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Setting'),
        ],
        onDestinationSelected: (i) {},
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? content;
  final Widget? child;
  const _SectionCard({
    required this.icon,
    required this.title,
    this.content,
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blue, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  if (content != null)
                    Text(content!, style: const TextStyle(height: 1.4)),
                  if (child != null) child!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
