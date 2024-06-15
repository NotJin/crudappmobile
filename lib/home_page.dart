import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'entities/place_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Future<List<Place>> fetchData () async {
    String url = "http://10.0.2.2:8081/place/get-all";
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body) as List;
        return data.map((e) => Place.valueFromJson(e)).toList();
      }
    }catch(e){
      print(e);
    }
    return [];
  }
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white,
      margin: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height,
      child: (
          Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi Guy!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                      SizedBox(height: 30,),
                      Text(
                        "Where are you going next?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 170,
                left: 40,
                right: 40,
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top:220,
                  left:0,
                  right:0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(margin: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: Row(children: [
                          Expanded(flex: 1,
                              child: Column(children: [
                                Container(width: double.infinity,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.pinkAccent,),
                                  child: Center(
                                    child: Image.asset("images/ico_hotel.png"),),),
                                const Text("Hotels", style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300))
                              ],)),
                          const SizedBox(width: 10,),
                          Expanded(flex: 1,
                              child: Column(children: [
                                Container(width: double.infinity,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.red,),
                                  child: Center(
                                    child: Image.asset("images/ico_plane.png"),),),
                                const Text("Flights", style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300))
                              ],)),
                          const SizedBox(width: 10,),
                          Expanded(flex: 1,
                              child: Column(children: [
                                Container(width: double.infinity,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.greenAccent,),
                                  child: Center(
                                    child: Image.asset("images/ico_hotel_plane.png"),),),
                                const Text("All", style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),)
                              ],)),
                        ],),),
                      const Text("Popular Destinations",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      FutureBuilder<List<Place>>(
                        future: fetchData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Text("Error loading data");
                          } else if (snapshot.hasData) {
                            List<Place> places = snapshot.data!;
                            return SizedBox(
                              height: 200,
                              child: GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20,
                                children: places.map((Place item) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(item.image??""),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom: 10,
                                          left: 10,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.name??"",
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    "${item.star}",
                                                    style: const TextStyle(fontSize: 14, color: Colors.white),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          } else {
                            return const Text("No data");
                          }
                        },
                      )
                    ],
                  )
              )
            ],
          )

      ),
    );
  }
}
