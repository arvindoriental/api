import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/PhotosModel.dart';
import 'Models/PostsModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostsModel> postList = [];

  Future<List<PostsModel>> getPostsApi() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }



  List<PhotosModel> photosList = [];

  Future<List<PhotosModel>> getPhotosapi() async
  {
    final response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200)
      {
        for(Map i in data)
          {
            PhotosModel photo= PhotosModel(title: i['title'], url: i['url'], id: i['id']);
            photosList.add(photo);
          }
        return photosList;
      }
    return photosList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("API-Photos"),
          backgroundColor: Colors.deepOrange,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: FutureBuilder(
                future: getPhotosapi(),
                builder: (context,snapshot)
                {
                  return ListView.builder(
                      itemCount: photosList.length,
                      itemBuilder: (context,index){
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                      ),
                      subtitle: Text(snapshot.data![index].title.toString()),
                      title: Text(snapshot.data![index].id.toString()),
                    );
                  });
                },
              ),
            ),
          ],
        ),
    );
  }
}
