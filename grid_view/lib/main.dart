import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detail.dart';
import 'model/modelgrid.dart';


extension DateParsing on String {
  int getYearFromDateString() {
    // Parse the date string into a DateTime object
    DateTime date = DateTime.parse(this);

    // Return the year from the DateTime object
    return date.year;
  }
}


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  CurvedGridViewScreen(),
    );
  }
}
class CurvedGridViewScreen extends StatefulWidget {
  @override
  _CurvedGridViewScreenState createState() => _CurvedGridViewScreenState();
}

class _CurvedGridViewScreenState extends State<CurvedGridViewScreen> {
  List<Show> shows = [];
  bool isLoading = false;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=spiderman'));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        shows = jsonList.map((e) => Show.fromJson(e['show'])).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error loading data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(top: 8.0,bottom: 8.0),
            child: const Text('Find Movies, TV Series,\nand more..',style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 28.0,top: 10.0),
        child: Column(
          children: <Widget>[
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,

              ),
              itemCount: shows.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(show: shows[index]),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    margin: const EdgeInsets.all(4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          Container(
                           height: MediaQuery.of(context).size.height * 0.18,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(shows[index].image?.medium ?? 'https://via.placeholder.com/150'),
                                fit: BoxFit.cover, // Fill the image in the container
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Container(
                                margin:EdgeInsets.only(top: 6.0),
                                constraints: BoxConstraints(maxWidth: 100.0),
                                child: Text(

                                  shows[index].name ?? '',
                                  overflow: TextOverflow.ellipsis,maxLines: 1,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin:EdgeInsets.only(top: 6.0,left: 2.0),
                                child: Text(
                                  "(${shows[index].premiered?.getYearFromDateString()?.toString()  ?? ''})"  ,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),


          ],
        ),
      ),
    );
  }
}

