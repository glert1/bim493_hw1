import 'package:flutter/material.dart';
import 'package:department_app/services/auth_service.dart';
import 'package:department_app/screens/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authService = AuthService();

  Future<void> _logout() async {
    await _authService.logout();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Department Application',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue[700],
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: _logout,
            ),
          ],
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'HAKKINDA'),
              Tab(text: 'KİŞİLER'),
              Tab(text: 'ALTYAPI'),
              Tab(text: 'DERSLER'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAboutTab(),
            _buildPeopleTab(),
            _buildInfrastructureTab(),
            _buildCoursesTab(),
          ],
        ),
      ),
    );
  }

  // HAKKINDA TAB
  Widget _buildAboutTab() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 80, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              'Bölüm Hakkında',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Bu bölüm mobil programlama ve yazılım geliştirme alanında eğitim vermektedir.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  // KİŞİLER TAB
  Widget _buildPeopleTab() {
    final instructors = [
      {
        'name': 'Dr. Öğr. Üyesi Murat ÖZTÜRK',
        'email': 'murat.ozturk@isikun.edu.tr',
        'phone': '0505 412 87 36',
        'images': 'assets/images/aziz.jpeg',
      },
      {
        'name': 'Doç. Dr. Emre KARAHAN',
        'email': 'emre.karahan@isikun.edu.tr',
        'phone': '0532 654 29 15',
        'images': 'assets/images/celal.jpeg',
      },
      {
        'name': 'Dr. Öğr. Üyesi Hakan YILDIZ',
        'email': 'hakan.yildiz@isikun.edu.tr',
        'phone': '0541 297 63 82',
        'images': 'assets/images/ilber.jpeg',
      },
      {
        'name': 'Prof. Dr. Serkan DEMİRCİ',
        'email': 'serkan.demirci@isikun.edu.tr',
        'phone': '0564 318 40 27',
        'images': 'assets/images/sadi.jpeg',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: instructors.length,
      itemBuilder: (context, index) {
        final instructor = instructors[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(instructor['images']!),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            instructor['name']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            
                          ),
                          const SizedBox(height: 4),
                          Text(
                            instructor['email']!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            instructor['phone']!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _showCallDialog(
                      instructor['name']!,
                      instructor['phone']!,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                    ),
                    child: const Text(
                      'CALL',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCallDialog(String name, String phone) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dial a Number'),
        content: Text('Would you like to call $name?\n$phone'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _makePhoneCall(phone);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber.replaceAll(' ', ''),
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  // ALTYAPI TAB
  Widget _buildInfrastructureTab() {
    final classrooms = [
      {'name': 'Derslik-B1', 'capacity': '36'},
      {'name': 'Derslik-B2', 'capacity': '15'},
      {'name': 'Derslik-B3', 'capacity': '18'},
      {'name': 'Derslik-B4', 'capacity': '24'},
      {'name': 'Derslik-B5', 'capacity': '15'},
      {'name': 'Derslik-B6', 'capacity': '18'},
      {'name': 'Derslik-B7', 'capacity': '54'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: classrooms.length,
      itemBuilder: (context, index) {
        final classroom = classrooms[index];
        return GestureDetector(
          onDoubleTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageDetailScreen(
                  classroomName: classroom['name']!,
                ),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.meeting_room, color: Colors.blue),
              title: Text(
                classroom['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Kapasite: ${classroom['capacity']!}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
        );
      },
    );
  }

  // DERSLER TAB
  Widget _buildCoursesTab() {
    final courses = [
      {'code': 'BIM493', 'name': 'Mobile Programming I'},
      {'code': 'BIM494', 'name': 'Mobile Programming II'},
      {'code': 'BIM101', 'name': 'Introduction to Programming'},
      {'code': 'BIM201', 'name': 'Data Structures'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[700],
              child: Text(
                course['code']!.substring(3, 6),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              course['code']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(course['name']!),
          ),
        );
      },
    );
  }
}

// Resim detay ekranı için yeni dosya
class ImageDetailScreen extends StatelessWidget {
  final String classroomName;

  const ImageDetailScreen({super.key, required this.classroomName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          classroomName,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[700],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: Image.asset(
            'assets/classrooms/classroom.jpg',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Resim bulunamadı',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}