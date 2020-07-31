import 'package:budget_flows/models/record.dart';
import 'package:budget_flows/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//const baseUrl = 'http://localhost:8080/api/flutter';
//const baseUrl =
//    'http://localhost:8080/spring-server-api-0.0.1-SNAPSHOT/api/flutter';
const baseUrl = 'http://188.166.245.183:8080/budgetflows-server/api/flutter';

Future<bool> login(String email, String password) async {
  final url = '$baseUrl/auth/login';

  try {
    http.Response response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );
    dynamic data = jsonDecode(response.body);
    var resultEmail = data['data']['email'];
    if (email == resultEmail) {
      return true;
    }
  } catch (ex) {
    print(ex);
  }
  return false;
}

Future<bool> register(User newUser) async {
  final url = '$baseUrl/auth/register';

  try {
    http.Response response = await http.post(
      url,
      body: {
        'email': newUser.email,
        'password': newUser.password,
        'fullname': newUser.fullName,
        'phone': newUser.phone,
      },
    );
    dynamic data = jsonDecode(response.body);
    var resultEmail = data['data']['email'];
    if (newUser.email == resultEmail) {
      return true;
    }
  } catch (ex) {
    print(ex);
  }
  return false;
}

Future<void> addRecord(String money, String reason, String email) async {
  var url = '$baseUrl/record/create';

  //http.Response response =
  await http.post(
    url,
    body: {
      'money': money,
      'reason': reason,
      'user_email': email,
    },
  );
//  dynamic data = jsonDecode(response.body);
}

Future<List<Record>> getRecords(String email) async {
  var url = '$baseUrl/record/get';

  http.Response response = await http.post(
    url,
    body: {'email': email},
  );

  dynamic data = jsonDecode(response.body);
  List<Record> records = [];
  for (int i = 0; i < data['data'].length; i++) {
    int id = data['data'][i]['id'];
    double money = data['data'][i]['money'];
    String reason = data['data'][i]['reason'];
    DateTime created = DateTime.parse(data['data'][i]['created']);

    records.add(Record(
      id: id,
      money: money,
      reason: reason,
      created: created,
    ));
  }

  return records;
}

Future<void> deleteRecord(int id) async {
  var url = '$baseUrl/record/delete/$id';

  try {
    // http.Response response =
    await http.delete(url);
  } catch (e) {
    print(e);
  }
}
