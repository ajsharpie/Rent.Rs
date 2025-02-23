import 'package:flutter/material.dart';
import 'package:rently/models/property.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rently/services/firebase_services.dart';
import 'firebase_options.dart';
import 'package:rently/screens/add_property_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    print('Firebase initialized.');

    // Create a property instance
    var apache = Property("660 Apache", "660 Apache Street", 1950);

    // Add apache to the db
    await FirebaseService().addProperty(apache);

    print('Property added: $apache');
  } catch (e) {
    print('Error initializing Firebase or adding property: $e');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Rently'),
        ),
        backgroundColor: Colors.deepPurple[400],
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.teal[100],
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPropertyScreen(),
                    ),
                  );
                },
                child: Text('Add Property'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  var property =
                      await FirebaseService().getProperty("660 Apache");
                  print('Property retrieved: $property');
                },
                child: Text('Get Property'),
              ),
              SizedBox(height: 20),
              FutureBuilder<Property>(
                future: FirebaseService().getProperty("660 Apache"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return Text('No property found');
                  } else {
                    var property = snapshot.data!;
                    return Text(
                      'Property: ${property.name}, ${property.address}, ${property.rent}',
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
