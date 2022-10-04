import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkOperation {
  NetworkOperation(this.url);
  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(this.url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
