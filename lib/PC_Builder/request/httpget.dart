import 'dart:convert';
import 'package:best_flutter_ui_templates/PC_Builder/providers/Models.dart';
import 'package:http/http.dart';
import '../models/final_model.dart';
import 'package:provider/provider.dart';

class HttpService {


  Uri postsURL = Uri.parse(
    "http://10.0.2.2:8000/get_model/?Cpu_Type=${'Core i5'}&Cpu_core=6&Cpu_gen=10400&Clockable=F&GPU=RTX&Gpu_gen=3070&Gpu_type=Ti&price=${5000.toString()}&PC_Type=gaming",
  );

  Future<List<PC>> getPosts() async {
    Response res = await get(
      postsURL,
      headers: {
        'origin': 'http://localhost',
        'content-type': 'application/json',
      },
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<PC> posts = body
          .map(
            (dynamic item) => PC.fromJson(item),
          )
          .toList();
      // print(posts);

      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
