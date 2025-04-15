import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdsPage extends StatefulWidget {
  @override
  _AdsPageState createState() => _AdsPageState();
}

class _AdsPageState extends State<AdsPage> {
  String adImageUrl = '';
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
        dogAge = Random().nextInt(15) + 1; // Edad entre 1 y 15
        dogGender = genders[Random().nextInt(genders.length)];
      });
    }
  }

  void _onAdClick() {
    setState(() {
      clickCount++;
    });
    _fetchAdData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AdoptaClick - Anuncios'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Haz clic en el anuncio para ver otro perrito 🐶'),
            SizedBox(height: 20),
            InkWell(
              onTap: _onAdClick,
              child: Container(
                width: 320,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange, width: 3),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: adImageUrl.isNotEmpty
                          ? Image.network(
                              adImageUrl,
                              width: 320,
                              height: 250,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 320,
                              height: 250,
                              color: Colors.grey[300],
                              child: Center(child: CircularProgressIndicator()),
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
            Text(
              'Nombre: $dogName',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Edad: $dogAge años',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Sexo: $dogGender',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text('Clics registrados: $clickCount'),
          ],
        ),
      ),
    );
  }
}