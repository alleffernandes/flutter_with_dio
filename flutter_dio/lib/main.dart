import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  final controller = DioController();
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Center(child: Text('Dio'))),
        body: FutureBuilder<List>(
          future: controller.getHttp(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Text('Erro');
            }
            final newslist = snapshot.data!;
            return ListView.builder(
                itemCount: newslist.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return ListTile(
                    title: Text('${item['name']}'),
                    subtitle: Text('${item['email']}'),
                  );
                });
          },
        ),
      ),
    ),
  );
}

class DioController {
  final dio = Dio();
  Future<List> getHttp() async {
    final response =
        await dio.get('https://jsonplaceholder.typicode.com/comments');
    return response.data;
  }
}
