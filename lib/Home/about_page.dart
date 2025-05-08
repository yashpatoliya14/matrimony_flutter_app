import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About Us Demo',
      theme: ThemeData(
        // Set a default primary color or swatch.
        primarySwatch: Colors.red,
      ),
      home: const AboutUsPage(),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with red-orange gradient
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.orange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // "Meet Our Team" Section
            const Text(
              "Meet Our Team",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Example team member list (replace with your own data)
            Card(
              child: ListTile(
                title: const Text("Rajveer Parmar (2010101133)"),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text("Dar Kathiriya (2010101138)"),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text("Parth Joshi (2010101139)"),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text("Jaydeep Vaghela (2010101140)"),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text("Prof. Jignesh Lokhania (Guide)"),
              ),
            ),
            const SizedBox(height: 16),

            // About Section
            const Text(
              "About ASWDC",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "ASWDC is an App, Software, and Website Development "
                  "Center at Darshan University. It is managed by "
                  "students and faculty of Computer Science & Engineering. "
                  "The purpose of ASWDC is to bridge the gap between "
                  "students and industry by developing real-world projects.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Contact / More Info Section
            const Text(
              "Contact & More",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text("aswdc@darshan.ac.in"),
              onTap: () {
                // Implement email launch or other action
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("+91 97277 34713"),
              onTap: () {
                // Implement phone call or other action
              },
            ),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text("http://www.darshan.ac.in"),
              onTap: () {
                // Implement website navigation
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text("Share App"),
              onTap: () {
                // Implement share functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.star_rate),
              title: const Text("Rate App"),
              onTap: () {
                // Implement rate functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.apps),
              title: const Text("More Apps"),
              onTap: () {
                // Show other apps
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text("Privacy Policy"),
              onTap: () {
                // Show privacy policy
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                "© 2025 Darshan University\nMade in India",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class AboutPage extends StatefulWidget  {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with red-orange gradient
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.orange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Text(
          "Meet Our Team",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),

      // Bordered container with the details
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Developed by
            const Text(
              "Developed by :",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            const Text("- Yash Patoliya (2010101206)"),
            const SizedBox(height: 16),

            // Mentored by
            const Text(
              "Mentored by :",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Prof. Mehul bhundiya,\n"
                  "Computer Engineering Department,\n"
                  "School of Computer Science",
            ),
            const SizedBox(height: 16),

            // Explored by
            const Text(
              "Explored by :",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "ASWDC, School Of Computer Science,\n"
                  "School of Computer Science",
            ),
            const SizedBox(height: 16),

            // Eulogized by
            const Text(
              "Eulogized by :",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Darshan University,\n"
                  "Rajkot, Gujarat - INDIA",
            ),
            const SizedBox(height: 8),

            // About Section
            const Text(
              "About ASWDC",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "ASWDC is an App, Software, and Website Development "
                  "Center at Darshan University. It is managed by "
                  "students and faculty of Computer Science & Engineering. "
                  "The purpose of ASWDC is to bridge the gap between "
                  "students and industry by developing real-world projects.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Contact / More Info Section
            const Text(
              "Contact & More",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text("aswdc@darshan.ac.in"),
              onTap: () {
                // Implement email launch or other action
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("+91 70433 33359"),
              onTap: () {
                // Implement phone call or other action
              },
            ),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text("http://www.darshan.ac.in"),
              onTap: () {
                // Implement website navigation
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text("Share App"),
              onTap: () {
                // Implement share functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.star_rate),
              title: const Text("Rate App"),
              onTap: () {
                // Implement rate functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.apps),
              title: const Text("More Apps"),
              onTap: () {
                // Show other apps
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text("Privacy Policy"),
              onTap: () {
                // Show privacy policy
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                "© 2025 Darshan University\nMade in India",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ],
        ),
      ),
    ])));
  }
}
