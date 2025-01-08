import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spor_programi_uygulamasi/KaloriHesaplayici.dart';

void main() {
  runApp(FitnessApp());
}

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.white,
      hintColor: const Color(0xFFA0EC67),
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.black), bodyMedium: TextStyle(color: Colors.black),
      ),
    ),
    home: RegistrationPage(),
  );
}

class RegistrationPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıt Ol', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 10, // Resmi yukarı taşır
            left: 0,
            right: 0,
            child: Container(
              height: 250, // Resim boyutunu ayarlar
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://i.pinimg.com/736x/85/2e/7c/852e7c077ee31cb0f34f36ee42524e8a.jpg',
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-posta',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Color(0xFFA0EC67)),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Şifre',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Color(0xFFA0EC67)),
                  ),
                  obscureText: true,
                  style: const TextStyle(color: Colors.black),
                ),

          const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA0EC67)),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('email', emailController.text);
                  await prefs.setString('password', passwordController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Kayıt başarılı!')),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: const Text('Kayıt Ol'),
              ),
            ],
          ),
        ),
      ],
    )
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş Yap', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body:Stack(
        children: [
        Positioned(
        top: 10, // Resmi yukarı taşır
        left: 0,
        right: 0,
        child: Container(
          height: 250, // Resim boyutunu ayarlar
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://i.pinimg.com/736x/85/2e/7c/852e7c077ee31cb0f34f36ee42524e8a.jpg',
              ),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'E-posta',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Color(0xFFA0EC67)),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Şifre',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Color(0xFFA0EC67)),
              ),
              obscureText: true,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA0EC67)),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                final savedEmail = prefs.getString('email');
                final savedPassword = prefs.getString('password');

                if (emailController.text == savedEmail &&
                    passwordController.text == savedPassword) {
                  // Hoşgeldiniz mesajını göster
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Hoşgeldiniz')),
                  );

                  // SnackBar tamamlandıktan sonra yönlendirme yap
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GoalSelectionPage()),
                    );
                  });
                } else {
                  // Hatalı giriş mesajını göster
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Hatalı giriş!')),
                  );
                }
              },

              child: const Text('Giriş Yap'),
            ),
          ],
        ),
      ),
      ],
      )
    );
  }
}

class GoalSelectionPage extends StatefulWidget {
  const GoalSelectionPage({super.key});

  @override
  _GoalSelectionPageState createState() => _GoalSelectionPageState();
}

class _GoalSelectionPageState extends State<GoalSelectionPage> {
  final Map<String, List<SporProgrami>> goalPrograms = {
    'Fit Kalmak İçin': [
      SporProgrami("Hafif Fit Program", "Squat (5 dakika x 10) \nLunge (2 x 5) \nJumping Jacks \nPlank (5 x 2)", 300),
      SporProgrami("Orta Düzey Fit Program", "Jumping Jacks (5 x 10) \nHigh Knees (2 x 5) \nBurpee (5 x 10) \nMountain Climbers (5 x 4) \nButt Kicks (3 x 2)", 450),
      SporProgrami("Yoğun Fit Program", "Push-up (50 x 2) \nSquat (8 x 2) \nLunge (4 x 2) \nDumbbell Rows (40 x 2) \nPlank (5 dakika x 2)", 600),
      SporProgrami("Ekstra Yoğun Fit Program", "Push-up (50 x 2) \nSquat (8 x 2) \nLunge (4 x 2) \nDumbbell Rows (40 x 2) \nPlank (5 dakika x 2) \nMountain Climbers (8 x 5)", 900),
      SporProgrami("Ekstra Yoğun Fit Program", "Squat (50 saniye x 2) \nSquat (8 x 2) \nLunge (4 x 2) \nDumbbell Rows (40 x 2) \nPlank (5 dakika x 2) \nMountain Climbers (8 x 5)", 900),
    ],
    'Kilo Vermek İçin': [
      SporProgrami("Hafif Kilo Verme Programı", "Burpee (10 x 3) \nMountain Climbers (20 x 3) \nJump Squats (15 x 3) \nHigh Knees (30 saniye x 3) \nSkater Jumps (20 x 3)", 700),
      SporProgrami("Orta Düzey Kilo Verme Programı", "Squat (15 x 2) \nJumping Jacks (20 x 3) \nDumbbell Rows (10 x 2) \nMountain Climbers (20 x 3) \nLungee (10 x 2) \nBurpee (10 x 2) \nPush-up (10 x 3) \nDeadlift (10 x 3)", 950),
      SporProgrami("Yoğun Kilo Verme Programı", "Squat (15 x 2) \nJumping Jacks (20 x 3) \nDumbbell Rows (10 x 2) \nMountain Climbers (20 x 3) \nLungee (10 x 2) \nBurpee (10 x 2) \nPush-up (10 x 3) \nDeadlift (10 x 3) \nLungee (10 x 2) \nButt Kicks (5 x 2)", 1050),
      SporProgrami("Ekstra Yoğun Kilo Verme Program", "Push-up (50 x 2) \nSquat (8 x 2) \nLunge (4 x 2) \nDumbbell Rows (40 x 2) \nPlank (5 dakika x 2) \nMountain Climbers (8 x 5) \nHigh Knees (30 saniye x 3) \nSkater Jumps (20 x 3)", 1200),
    ],
    'Kas Geliştirmek İçin': [
      SporProgrami("Tüm Vücut Geliştirme", "Squat (10 x 4) \nDumbbell Bench Press (10 x 4) \nDumbbell Rows (10 x 4) \nLunge (10 x 4) \nDeadlift (8 x 4) \nBicep Curl (12 x 3) \nTriceps Dips (10 x 3)", 450),
      SporProgrami("Göğüs Geliştirme", "Dumbbell Bench Press (10 x 4) \nIncline Dumbbell Press (10 x 4) \nChest Fly (10 x 4)", 400),
      SporProgrami("Sırt Geliştirme" ,"Dumbbell Rows (10 x 4) \nLat Pulldown (10 x 4) \nSeated Row (10 x 4) " , 600),
      SporProgrami("Bacak Geliştirme" ,"Squat (10 x 4) \nLeg Press (10 x 4) \nLunges (12 x 4) " , 600),
      SporProgrami("Omuz Geliştirme" ,"Overhead Shoulder Press (10 x 4) \nLateral Raises (12 x 3) \nFront Raises (12 x 3) " , 500),
      SporProgrami("Biceps Geliştirme" ,"Dumbbell Bicep Curl (12 x 3) \nHammer Curl (12 x 3)" , 300),

    ],
    'Dayanıklılık Artırmak İçin': [
      SporProgrami("Hafif Dayanıklılık Programı", "Jumping Jacks (30 saniye) \nBurpee (10 x 3) \nHigh Knees (30 saniye x 3) \nSquat (15 x 3) \nJumping Jacks (20 x 3)", 600),
      SporProgrami("Orta Düzey Dayanıklılık Program", "Push-up (50 x 2) \nSquat (8 x 2) \nPlank (5 dakika x 2) \nMountain Climbers (8 x 5) \nHigh Knees (30 saniye x 3) \nSkater Jumps (20 x 3)", 900),
      SporProgrami("Yoğun Dayanıklılık Programı", "Burpee (10 x 4) \nDumbbell Row (10 x 4) \nJump Squat (15 x 4) \nPush-up (15 x 4) \nDeadlift (12 x 4) \nMountain Climbers (30 saniye x 4) \nWalking Lunge (12 x 4) \nDumbbell Press (12 x 4)", 1050),
      SporProgrami("Ekstra Yoğun Dayanıklılık Program", "Push-up (50 x 2) \nSquat (8 x 2) \nLunge (4 x 2) \nDumbbell Rows (40 x 2) \nPlank (5 dakika x 2) \nMountain Climbers (8 x 5) \nHigh Knees (30 saniye x 3) \nSkater Jumps (20 x 3)", 1200),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spor Programı', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFFA0EC67),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFA0EC67),
              ),
              child: Text(
                'Hedef Seçimi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            for (var goal in goalPrograms.keys)
              ListTile(
                title: Text(goal),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProgramListScreen(
                        title: goal,
                        programs: goalPrograms[goal]!,
                      ),
                    ),
                  );
                },
              ),
            ListTile(
              title: const Text("Kalori Hesaplayıcı"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KaloriHesaplayiciPage()),
                );
              },
            ),

          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://www.bradfieldsportscomplex.co.uk/wp-content/uploads/2024/01/New-Gym-Pic-6.jpg'), /*buradan resim degiştirilebilir.*/
            fit: BoxFit.fitHeight,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Text(
                  'Lütfen bir hedef seçin.',
                  style: TextStyle(fontSize: 30, color: Colors.white, shadows: [ Shadow(offset: Offset(2.0, 2.0), blurRadius: 3.0, color: Colors.grey)]),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgramListScreen extends StatelessWidget {
  final String title;
  final List<SporProgrami> programs;

  const ProgramListScreen({super.key, required this.title, required this.programs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFFA0EC67),
      ),
      body: ListView.builder(
        itemCount: programs.length,
        itemBuilder: (context, index) {
          final program = programs[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(program.isim, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(program.aciklama),
              trailing: Text('${program.kalori} kalori'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProgramDetailScreen(program: program),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ProgramDetailScreen extends StatelessWidget {
  final SporProgrami program;

  const ProgramDetailScreen({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(program.isim, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFFA0EC67),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Program Adı: ${program.isim}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              "Program Açıklaması:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(program.aciklama, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text(
              "Kalori: ${program.kalori} yakacaksınız.",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class CalorieCalculatorPage extends StatelessWidget {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  CalorieCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalori Hesaplama', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFFA0EC67),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: weightController,
              decoration: const InputDecoration(
                labelText: 'Kilonuz (kg)',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Color(0xFFA0EC67)),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: durationController,
              decoration: const InputDecoration(
                labelText: 'Süre (dakika)',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Color(0xFFA0EC67)),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA0EC67)),
              onPressed: () {
                final weight = double.tryParse(weightController.text);
                final duration = double.tryParse(durationController.text);
                if (weight != null && duration != null) {
                  final caloriesBurned = (weight * duration * 0.0175 * 8).toInt();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Sonuç'),
                      content: Text('Yaklaşık $caloriesBurned kalori yaktınız!'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Tamam'),
                        ),
                      ],
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Lütfen geçerli bir değer girin!')),
                  );
                }
              },
              child: const Text('Hesapla'),
            ),
          ],
        ),
      ),
    );
  }
}

class SporProgrami {
  String isim;
  String aciklama;
  int kalori;

  SporProgrami(this.isim, this.aciklama, this.kalori);
}
