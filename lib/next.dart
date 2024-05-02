
import 'package:basicapp/worldtime.dart';
import 'package:flutter/material.dart';


class WorldTimeList extends StatefulWidget {
  const WorldTimeList({super.key});

  @override
  _WorldTimeListState createState() => _WorldTimeListState();
}

class _WorldTimeListState extends State<WorldTimeList> {
  final List<WorldTime> _worldTimes = [
    WorldTime(location: 'New York', url: 'America/New_York'),
    WorldTime(location: 'London', url: 'Europe/London'),
    WorldTime(location: 'Paris', url: 'Europe/Paris'),
    WorldTime(location: 'Tokyo', url: 'Asia/Tokyo'),
    WorldTime(location: 'Sydney', url: 'Australia/Sydney'),
    WorldTime(location: 'Lagos', url: 'Africa/Lagos'),
    WorldTime(location: 'Dubai', url: 'Asia/Dubai'),
    WorldTime(location: 'Qatar', url: 'Asia/Qatar'),
    WorldTime(location: 'Riyadh', url: 'Asia/Riyadh'),
    WorldTime(location: 'Singapore', url: 'Asia/Singapore'),
    WorldTime(location: 'Hong_Kong', url: 'Asia/Hong_Kong'),
    WorldTime(location: 'Gaza', url: 'Asia/Gaza'),
    WorldTime(location: 'Cairo', url: 'Africa/Cairo'),
    WorldTime(location: 'Khartoum', url: 'Africa/Khartoum'),
    WorldTime(location: 'Baghdad', url: 'Asia/Baghdad'),
    WorldTime(location: 'Kolkata', url: 'Asia/Kolkata'),
    WorldTime(location: 'Moscow', url: 'Europe/Moscow'),
    WorldTime(location: 'Rome', url: 'Europe/Rome'),
    WorldTime(location: 'Honolulu', url: 'Pacific/Honolulu'),
    WorldTime(location: 'Istanbul', url: 'Europe/Istanbul'),
    WorldTime(location: 'Lisbon', url: 'Europe/Lisbon'),
  ];

   List<WorldTime> _filteredWorldTimes = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredWorldTimes = _worldTimes;
  }

  void _filterWorldTimes(String query) {
    setState(() {
      _filteredWorldTimes = _worldTimes
          .where((worldTime) =>
              worldTime.location.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(
        title: const Text('World Time'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                    ),
                    onChanged: _filterWorldTimes,
                  ),
                ),
              ),
            ],
            icon: const Icon(Icons.search),
            offset: const Offset(0, 40),
          ),
        ],
      ),
    body: ListView.builder(
        itemCount: _filteredWorldTimes.length,
        itemBuilder: (context, index) {
          return FutureBuilder<Map<String, String>>(
            future: _filteredWorldTimes[index].getTime(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListTile(
                  title: Text(_filteredWorldTimes[index].location),
                  subtitle: const CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return ListTile(
                  title: Text(_filteredWorldTimes[index].location),
                  subtitle: Text('Error: ${snapshot.error}'),
                );
              } else {
                return ListTile(
                  title: Text(_filteredWorldTimes[index].location),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Time: ${snapshot.data!['time']}'),
                      Text('Timezone: ${snapshot.data!['timezone']}'),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}


