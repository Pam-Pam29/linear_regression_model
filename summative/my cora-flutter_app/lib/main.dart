import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

void main() {
  runApp(const InsurancePredictorApp());
}

class InsurancePredictorApp extends StatelessWidget {
  const InsurancePredictorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cora - Your Health Insurance Predictor',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: const Color(0xFF1A237E), // Navy
          onPrimary: Colors.white,
          secondary: const Color(0xFF26A69A), // Teal
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A237E),
          foregroundColor: Colors.white,
          elevation: 1,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A237E),
            foregroundColor: Colors.white,
            textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 2,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF1A237E)),
          ),
          labelStyle: GoogleFonts.montserrat(),
        ),
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const IntroductionPage(),
        '/predict': (context) => const PredictionPage(),
        '/about': (context) => const AboutPage(),
      },
    );
  }
}

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Cora'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Welcome to Cora - Your Health Insurance Predictor!',
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A237E),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Your health is your greatest asset. Health insurance helps you protect it by giving you peace of mind, access to care, and financial security when you need it most.',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Hi, I am Cora and I give you a quick personalized estimate. Give me a try!',
                    style: GoogleFonts.montserrat(
                      fontSize: 17,
                      color: Color(0xFF26A69A),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 36),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/predict'),
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Start Prediction with Cora'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _sex;
  final TextEditingController _bmiController = TextEditingController();
  final TextEditingController _childrenController = TextEditingController();
  String? _smoker;
  String? _result;
  bool _loading = false;

  Future<void> _predict() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _result = null;
      _loading = true;
    });
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 20),
            Expanded(child: Text('Cora is calculating your estimate...', style: GoogleFonts.montserrat())),
          ],
        ),
      ),
    );
    final url = Uri.parse('http://10.0.2.2:8000/predict'); // Use 10.0.2.2 for Android emulator
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'age': int.tryParse(_ageController.text),
          'sex': _sex,
          'bmi': double.tryParse(_bmiController.text),
          'children': int.tryParse(_childrenController.text),
          'smoker': _smoker,
        }),
      );
      Navigator.of(context, rootNavigator: true).pop(); // Close loading dialog
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
              name: _nameController.text.trim(),
              predictedCharges: (data['predicted_charges'] as num).toDouble(),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sorry, Cora could not calculate your estimate. Please try again later.', style: GoogleFonts.montserrat()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop(); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Network error: Please check your connection and try again.', style: GoogleFonts.montserrat()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cora - Your Health Insurance Predictor'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(context, '/'),
          tooltip: 'Back to Introduction',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.pushNamed(context, '/about'),
            tooltip: 'About',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.person, color: Color(0xFF1A237E), size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _nameController.text.trim().isEmpty
                        ? 'Welcome! Please enter your details below.'
                        : 'Welcome, ${_nameController.text.trim()}!',
                      style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600, color: const Color(0xFF1A237E)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Get an instant estimate of your insurance charges! Your health and security matter.',
                        style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xFF1A237E)),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
            Text(
                        'Enter Details for Prediction',
                        style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (_) => setState(() {}),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _ageController,
                        decoration: const InputDecoration(
                          labelText: 'Age (18-100)',
                          prefixIcon: Icon(Icons.cake_outlined),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          final age = int.tryParse(value ?? '');
                          if (age == null || age < 18 || age > 100) {
                            return 'Enter a valid age (18-100)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _sex,
                        decoration: const InputDecoration(
                          labelText: 'Sex',
                          prefixIcon: Icon(Icons.wc),
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'male', child: Text('Male')),
                          DropdownMenuItem(value: 'female', child: Text('Female')),
                        ],
                        onChanged: (val) => setState(() => _sex = val),
                        validator: (value) => value == null ? 'Select sex' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _bmiController,
                        decoration: const InputDecoration(
                          labelText: 'BMI (10-60)',
                          prefixIcon: Icon(Icons.monitor_weight_outlined),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          final bmi = double.tryParse(value ?? '');
                          if (bmi == null || bmi < 10 || bmi > 60) {
                            return 'Enter a valid BMI (10-60)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _childrenController,
                        decoration: const InputDecoration(
                          labelText: 'Number of Children (0-10)',
                          prefixIcon: Icon(Icons.child_care_outlined),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          final children = int.tryParse(value ?? '');
                          if (children == null || children < 0 || children > 10) {
                            return 'Enter a valid number (0-10)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _smoker,
                        decoration: const InputDecoration(
                          labelText: 'Smoker',
                          prefixIcon: Icon(Icons.smoking_rooms_outlined),
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'yes', child: Text('Yes')),
                          DropdownMenuItem(value: 'no', child: Text('No')),
                        ],
                        onChanged: (val) => setState(() => _smoker = val),
                        validator: (value) => value == null ? 'Select smoker status' : null,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _loading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  _predict();
                                }
                              },
                        icon: _loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : const Icon(Icons.calculate),
                        label: const Text('Predict'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final String name;
  final double predictedCharges;
  const ResultPage({required this.name, required this.predictedCharges, super.key});

  @override
  Widget build(BuildContext context) {
    final tips = [
      'Tip: Small healthy habits can lead to big savings on your insurance!',
      'Tip: Regular checkups help catch issues early and keep costs down.',
      'Tip: Staying active and eating well can lower your insurance costs.',
      'Tip: Review your policy yearly to make sure it fits your needs.',
      'Tip: Non-smokers often pay less for health insurance.',
    ];
    final randomTip = tips[Random().nextInt(tips.length)];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cora - Your Result'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Back',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.verified_user, color: Color(0xFF26A69A), size: 60),
              const SizedBox(height: 24),
              Text(
                'Hi $name,',
                style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A237E)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Cora has detected that your annual health insurance charges are',
                style: GoogleFonts.montserrat(fontSize: 18, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                  child: Text(
                    '\$${predictedCharges.toStringAsFixed(2)}',
                    style: GoogleFonts.montserrat(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A237E)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                randomTip,
                style: GoogleFonts.montserrat(fontSize: 16, color: Color(0xFF26A69A)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Cora'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'Cora - Your Health Insurance Predictor\n\nEnter your details to predict insurance charges using a machine learning model.\n\nThis app is for demonstration purposes.',
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
