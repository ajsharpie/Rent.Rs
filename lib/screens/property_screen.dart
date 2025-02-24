import 'package:flutter/material.dart';
import 'package:rently/services/firebase_services.dart'; // Adjust the path as necessary
import 'package:rently/screens/rent_screen.dart'; // Adjust the path as necessary

class PropertyScreen extends StatefulWidget {
  @override
  _PropertyScreenState createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  String? selectedProperty;
  Map properties = {};

  @override
  void initState() {
    super.initState();
    _fetchProperties();
  }

  Future<void> _fetchProperties() async {
    // Assuming you have a Firebase service class with a method to get properties
    var firebaseService = FirebaseService();
    var fetchedProperties = await firebaseService.getProperties();
    setState(() {
      properties = Map.fromEntries(fetchedProperties
          .map((property) => MapEntry(property.name, property)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              hint: Text('Select a property'),
              value: selectedProperty,
              onChanged: (String? newValue) {
                setState(() {
                  selectedProperty = newValue;
                });
              },
              items: properties.entries.map<DropdownMenuItem<String>>((entry) {
                return DropdownMenuItem<String>(
                  value: entry.key,
                  child: Text(entry.key),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            selectedProperty != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${properties[selectedProperty].name} is located at ${properties[selectedProperty].address} and rents for \$${properties[selectedProperty].rent}",
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RentScreen(
                                property: properties[selectedProperty],
                              ),
                            ),
                          );
                        },
                        child: Text('Go to Rent Screen'),
                      ),
                    ],
                  )
                : Text('Please select a property to see the details'),
          ],
        ),
      ),
    );
  }
}
