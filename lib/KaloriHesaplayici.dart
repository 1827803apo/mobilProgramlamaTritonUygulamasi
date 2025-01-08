import 'package:flutter/material.dart';

class KaloriHesaplayiciPage extends StatefulWidget {
  const KaloriHesaplayiciPage({super.key});

  @override
  _KaloriHesaplayiciPageState createState() => _KaloriHesaplayiciPageState();
}

class _KaloriHesaplayiciPageState extends State<KaloriHesaplayiciPage> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String? selectedGender;
  String? selectedActivityLevel;
  String result = "";

  void calculateCalories() {
    if (selectedGender == null || selectedActivityLevel == null) {
      setState(() {
        result = "Lütfen tüm bilgileri doldurun.";
      });
      return;
    }

    final age = int.tryParse(ageController.text);
    final height = double.tryParse(heightController.text);
    final weight = double.tryParse(weightController.text);

    if (age == null || height == null || weight == null) {
      setState(() {
        result = "Geçerli bir sayı girin.";
      });
      return;
    }

    // Harris-Benedict formülü
    double bmr;
    if (selectedGender == "Erkek") {
      bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else {
      bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    }

    // Aktivite düzeyi çarpanı
    double multiplier;
    switch (selectedActivityLevel) {
      case "Hareketsiz":
        multiplier = 1.2;
        break;
      case "Hafif aktif":
        multiplier = 1.375;
        break;
      case "Orta aktif":
        multiplier = 1.55;
        break;
      case "Çok aktif":
        multiplier = 1.725;
        break;
      default:
        multiplier = 1.0;
    }

    final dailyCalories = bmr * multiplier;
    setState(() {
      result = "Günlük kalori ihtiyacınız: ${dailyCalories.toStringAsFixed(0)} kcal";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalori Hesaplayıcı', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFFA0EC67),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: "Yaş", border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: heightController,
              decoration: const InputDecoration(labelText: "Boy (cm)", border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(labelText: "Kilo (kg)", border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedGender,
              hint: const Text("Cinsiyet"),
              items: ["Erkek", "Kadın"]
                  .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedActivityLevel,
              hint: const Text("Aktivite Düzeyi"),
              items: [
                "Sedanter (hareketsiz)",
                "Hafif aktif",
                "Orta aktif",
                "Çok aktif"
              ].map((level) => DropdownMenuItem(value: level, child: Text(level))).toList(),
              onChanged: (value) {
                setState(() {
                  selectedActivityLevel = value;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateCalories,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA0EC67)),
              child: const Text("Hesapla"),
            ),
            const SizedBox(height: 16),
            Text(
              result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

