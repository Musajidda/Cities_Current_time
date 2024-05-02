import 'dart:convert';
import 'package:http/http.dart' as http;

class WorldTime {
  final String location;
  final String url;

  WorldTime({required this.location, required this.url});

  Future<Map<String, String>> getTime() async {
  try {
    http.Response response = await http.get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    Map data = jsonDecode(response.body);
    String dateTime = data['datetime'];
      String timezone = data['timezone'];

    // Extracting hours, minutes, and seconds from the datetime string
    List<String> timeParts = dateTime.substring(11, 19).split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);
    int seconds = int.parse(timeParts[2]);

    // Determining AM/PM
    String period = hours < 12 ? 'AM' : 'PM';

    // Converting 24-hour format to 12-hour format
    if (hours > 12) {
      hours -= 12;
    }

    // Formatting time string
    String formattedTime = '$hours:$minutes:$seconds $period';

    Map<String, String> result = {
      'time': formattedTime,
      'timezone': timezone,
    };

    return result;
  } catch (e) {
    return {'time': 'Error fetching time', 'timezone': ''};
  }
}

}