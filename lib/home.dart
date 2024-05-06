import 'package:basicapp/next.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
   final String companyName = 'Jidda.Co';
  final DateTime creationDate = DateTime(2024, 5, 2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(44, 104, 234, 0.122),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(1, 16, 49, 0.122),
      ),
      body: Center(
        child: Column(
          children: [
            const Icon(
              Icons.access_time_rounded,
              size: 200,
              color: Colors.amber,
            ),
            const SizedBox(height: 220),
            const Text(
              'Tap to check your city current time!',
              style: TextStyle(color: Colors.grey),
            ),
              const SizedBox(height: 20),
            OutlinedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                  return  const WorldTimeList();
                  }));
                },
                child: const Text(
                  'Check',
                  style: TextStyle(color: Colors.amber, fontSize: 25),
                ))
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(31, 12, 16, 24),
 child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(left: 200),
       
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$companyName © ${creationDate.year}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
