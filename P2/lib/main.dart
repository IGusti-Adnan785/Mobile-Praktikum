import 'package:flutter/material.dart';

void main() {
  runApp(const Kalkulator());
}

class Kalkulator extends StatelessWidget {
  const Kalkulator({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator BMI', home: BMIScreen());
  }
}

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _berat = TextEditingController();
  final _tinggi = TextEditingController();

  String? _gender;
  double? _hasil;
  String? _keterangan;

  void _hitungBMI() {
    final double weight = double.tryParse(_berat.text) ?? 0;
    final double height = double.tryParse(_tinggi.text) ?? 0;
    setState(() {
      if (_gender != null && weight > 0 && height > 0) {
        final double heightInM = height / 100;
        final double bmi = weight / (heightInM * heightInM);
        _hasil = bmi;

        if (_gender == 'Laki-laki') {
          if (bmi < 18.5) {
            _keterangan = "Kurus";
          } else if (bmi < 25) {
            _keterangan = "Ideal";
          } else if (bmi < 30) {
            _keterangan = "Gemuk";
          } else {
            _keterangan = "Obesitas";
          }
        } else if (_gender == 'Perempuan') {
          if (bmi < 18) {
            _keterangan = "Kurus";
          } else if (bmi < 24) {
            _keterangan = "Ideal";
          } else if (bmi < 29) {
            _keterangan = "Gemuk";
          } else {
            _keterangan = "Obesitas";
          }
        }
      } else {
        _hasil = null;
        _keterangan = "Masukkan data yang sesuai dan pilih jenis kelamin!";
      }
    });
  }

  void _restart() {
    setState(() {
      _berat.clear();
      _tinggi.clear();
      _hasil = null;
      _keterangan = null;
      _gender = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 68, 68),
        title: const Text(
          "Kalkulator BMI",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: _berat,
              decoration: const InputDecoration(
                labelText: 'Berat Badan (kg)',
                prefixIcon: Icon(Icons.monitor_weight),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _tinggi,
              decoration: const InputDecoration(
                labelText: 'Tinggi Badan (cm)',
                prefixIcon: Icon(Icons.height),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 25),
            const Text(
              "Pilih Jenis Kelamin:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _gender = "Laki-laki";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _gender == "Laki-laki"
                        ? Colors.blue
                        : Colors.white,
                  ),
                  child: const Text("Laki-laki"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _gender = "Perempuan";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _gender == "Perempuan"
                        ? Colors.pink
                        : Colors.white,
                  ),
                  child: const Text("Perempuan"),
                ),
              ],
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: _hitungBMI,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
              ),
              child: const Text("Hitung BMI"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _restart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
              ),
              child: const Text("Reset"),
            ),
            const SizedBox(height: 30),
            const Text(
              "Hasil BMI:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 179, 237, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    _hasil != null ? _hasil!.toStringAsFixed(1) : '---',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _keterangan ?? 'Masukkan data',
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
