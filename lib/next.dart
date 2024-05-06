import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WorldTimeList extends StatefulWidget {
  const WorldTimeList({super.key});

  @override
  _WorldTimeListState createState() => _WorldTimeListState();
}

class _WorldTimeListState extends State<WorldTimeList> {
  List<String> _timezones = [];
  final List<Map<String, String>> _cityData = [];

  @override
  void initState() {
    super.initState();
    getTimezones();
  }

  Future<void> getTimezones() async {
    try {
      final response = await http.get(Uri.parse('http://worldtimeapi.org/api/timezone'));
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _timezones = data.cast<String>();
      });
      await fetchCityData();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchCityData() async {
    for (String timezone in _timezones) {
      try {
        final response = await http.get(Uri.parse('http://worldtimeapi.org/api/timezone/$timezone'));
        final Map<String, dynamic> cityData = json.decode(response.body);
        setState(() {
          _cityData.add({
            'location': timezone.split('/').last.replaceAll('_', ' '), // Extract city name from timezone
            'time': cityData['datetime'].substring(11, 19),
            'timezone': cityData['timezone'],
          });
        });
      } catch (e) {
        print('Error fetching data for $timezone: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('World Time'),
      ),
      body: ListView.builder(
        itemCount: _cityData.length,
        itemBuilder: (context, index) {
          final city = _cityData[index];
          return ListTile(
            title: Text(city['location'] ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Time: ${city['time'] ?? ''}'),
                Text('Timezone: ${city['timezone'] ?? ''}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
