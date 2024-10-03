
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:http/http.dart' as http;
Future<dynamic> getHttpRequest({
  required String url,
  Map<String, String>? headers,
}) async {
  try {
    var headersGloble = await getHeaders();
    var request = http.MultipartRequest('GET', Uri.parse(url));
    request.headers.addAll(headers ?? headersGloble);

    // Sending the request
    http.StreamedResponse response = await request.send();

    // Handling the final response
    var finalResponse = await getFinalResponse(response);

    // Check if the response was successful
    if (response.statusCode == 200 || response.statusCode == 200) {
      return finalResponse;
    } else {
      throw Exception('Failed to load data from $url');
    }
  } catch (error) {
    throw Exception('Error making request: $error');
  }
}


