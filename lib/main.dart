
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(AdoptaClickApp());
}

class AdoptaClickApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AdoptaClick',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        scaffoldBackgroundColor: Colors.blue.shade50,
        textTheme: Typography.blackCupertino.copyWith(
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/ads': (context) => AdsPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🐾 Bienvenido a AdoptaClick 🐾',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text(
                'Una plataforma para conectar perros sin hogar con nuevos amigos humanos.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: Text('Ingresar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido a AdoptaClick.com')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Conéctate y ayuda a encontrar un hogar 🐾',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Coloca tu correo.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    Navigator.pushNamed(context, '/ads');
                  }
                },
                icon: Icon(Icons.pets),
                label: Text('Entrar al portal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdsPage extends StatefulWidget {
  @override
  _AdsPageState createState() => _AdsPageState();
}

class _AdsPageState extends State<AdsPage> {
  String adImageUrl = 'https://via.placeholder.com/320x250.png?text=Anuncio+Inicial';
  int clickCount = 0;
  String dogName = '';
  int dogAge = 0;
  String dogGender = '';

  final List<String> dogNames = [
    'Max', 'Bella', 'Charlie', 'Luna', 'Rocky', 'Lucy', 'Cooper', 'Daisy',
    'Buddy', 'Molly', 'Jack', 'Sadie', 'Toby', 'Chloe', 'Duke', 'Lola',
    'Bear', 'Zoey', 'Bentley', 'Stella', 'Oliver', 'Penny', 'Leo', 'Roxy',
    'Oscar', 'Sasha', 'Zeus', 'Ruby', 'Bruno', 'Ginger', 'Thor', 'Nala',
    'Rex', 'Maya', 'Simba', 'Abby', 'Milo', 'Hazel', 'Bailey', 'Maggie',
    'Finn', 'Ellie', 'Riley', 'Coco', 'Diesel', 'Athena', 'Shadow', 'Pepper',
    'Murphy', 'Izzy', 'Tank', 'Zara', 'Cash', 'Rosie', 'Jax', 'Belle',
    'Sam', 'Bonnie', 'Archie', 'Honey', 'Louie', 'Gracie', 'Henry', 'Layla',
    'Chester', 'Trixie', 'Buster', 'Millie', 'Boomer', 'Lilly', 'Apollo', 'Nova',
  ];

  final List<String> genders = ['Macho', 'Hembra'];

  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchAdData();
  }

  Future<void> _fetchAdData() async {
    final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        adImageUrl = data['message'];
        dogName = dogNames[Random().nextInt(dogNames.length)];
        dogAge = Random().nextInt(15) + 1;
        dogGender = genders[Random().nextInt(genders.length)];
      });
    }
  }

  void _onAdClick() async {
    setState(() {
      clickCount++;
    });
    await Future.delayed(Duration(milliseconds: 300));
    _fetchAdData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' HOLA CLASE DEL SAMUEL')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: Text('Menú', style: TextStyle(fontSize: 24, color: Colors.white)),
            ),
            ListTile(
              title: Text('Inicio'),
              onTap: () => Navigator.pushNamed(context, '/'),
            ),
            ListTile(
              title: Text('Adopciones'),
              onTap: () => Navigator.pushNamed(context, '/ads'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Column(
            children: [
              Text('Haz clic en el anuncio para ver otro perrito 🐶'),
              SizedBox(height: 20),
              InkWell(
                onTap: _onAdClick,
                child: Container(
                  width: 320,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.greenAccent, width: 3),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          adImageUrl,
                          width: 320,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '¡Adóptame!',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Nombre: $dogName'),
              Text('Edad: $dogAge años'),
              Text('Sexo: $dogGender'),
              SizedBox(height: 20),
              Text('Clics registrados: $clickCount'),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text('Contáctanos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    TextFormField(
                      controller: _nameCtrl,
                      decoration: InputDecoration(labelText: 'Tu nombre'),
                      validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
                    ),
                    TextFormField(
                      controller: _messageCtrl,
                      decoration: InputDecoration(labelText: 'Mensaje'),
                      maxLines: 3,
                      validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Mensaje enviado correctamente')),
                          );
                        }
                      },
                      child: Text('Enviar'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
