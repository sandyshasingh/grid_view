
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'model/modelgrid.dart';



extension  DateParsing on String {
  String formatDate() {
    // Parse the input date string into a DateTime object
    DateTime dateTime = DateTime.parse(this);

    // Format the DateTime object into the desired format
    String formattedDate = DateFormat('MMM d, yyyy').format(dateTime);

    return formattedDate;
  }
}


class DetailScreen extends StatefulWidget {
  final Show show;

  const DetailScreen({required this.show, Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late String premieredYear;

  @override
  void initState() {
    super.initState();
    premieredYear = widget.show.premiered?.formatDate()?.toString() ?? '';
  }




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,

      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 28.0),
        child: SizedBox(
         
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.show.image?.original ??''),
                        fit: BoxFit.cover, // Fill the image in the container
                      ),
                    ),
        
                  ),
                  Positioned(
                    top: 50,
        
                      child: IconButton(onPressed: (){
                        Navigator.pop(context);
                      },
                      icon:  Icon(Icons.arrow_back,color: Colors.white,))),
                ]
              ),
              Row(
        
                children: [
        
                       Expanded(
                         child: Container(
                                 
                           margin: EdgeInsets.only(top: 12.0,left: 12.0),
                             child: Text("${widget.show.name}",style: TextStyle(fontSize: 30,color: Colors.white),overflow: TextOverflow.ellipsis,
                               maxLines: 1,)),
                       ),
                ],
              )
              ,
              Container(
                margin: EdgeInsets.only(left: 12.0,top: 12.0),
                child: Row(
                  children: [
                    const Icon(Icons.timer,color: Colors.grey,size: 20,),
                    Container(
                      margin: EdgeInsets.only(left: 4.0),
                        child: Text("${widget.show.runtime} minutes",style: TextStyle(color: Colors.grey),)),
                    const SizedBox(width: 18,),
                    Row(
                      children: [const Icon(Icons.star,color: Colors.grey,size: 20,),
                        Container(margin:EdgeInsets.only(left: 4.0),
                        child: Text("${widget.show.rating?.average} (IMDb)",style: const TextStyle(color: Colors.grey),)),
                        ],
                    )
        
                  ],
                ),
              ),
        
              Container(
                margin: EdgeInsets.only(top:18.0,left: 12.0,right: 12.0,bottom: 18.0),
                height: 0.4,
                color: Colors.grey,
              ),
            Container(
              margin: EdgeInsets.only(left: 12.0),
              child:   Column(
                  children: [
                    const Row(
                      children: [
                        Text('Premiered',style: TextStyle(color: Colors.white,fontSize: 18.0),),
                        SizedBox(width: 40,),
                        Text('Genre',style: TextStyle(color: Colors.white,fontSize: 18.0),),
                      ],
                    ),
                    Row(
                      children: [
                         Container(
                           width: 126,
                           margin: EdgeInsets.only(top: 6.0),
                             child: Text("${premieredYear}",style: const TextStyle(color: Colors.grey),)),
        
                         Container(
                           width: 70, // Set the desired width
                           height: 30,
                           margin: EdgeInsets.only(top: 6.0),
                           child: OutlinedButton(
        
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.grey, width: 1),
                                padding: EdgeInsets.zero, // Set the padding to zero
                              ),
        
        
                                onPressed: null, child: const Text('deepak',style: TextStyle(color: Colors.grey,fontSize: 12.0),),),
                         ),
        
                         Container(
                           margin: EdgeInsets.only(left: 10.0,top: 6.0),
                           width: 70,
                           height: 30,
                           child: OutlinedButton(onPressed: null,
                               style: OutlinedButton.styleFrom(
                                 side: BorderSide(color: Colors.grey, width: 1),
                                 padding: EdgeInsets.zero, // Set the padding to zero
                               ),
        
                               child: Text('Sci-Fi',style: TextStyle(color: Colors.grey,fontSize: 12.0),)),
                         ),
                      ],
                    ),
        
                  ],
                ),
            ),
        
              Container(
                margin: EdgeInsets.only(top:18.0,left: 12.0,right: 12.0,bottom: 18.0),
                height: 0.4,
                color: Colors.grey,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 12.0,bottom: 6.0),
                      child: Text('Summary',style: TextStyle(color: Colors.white,fontSize: 18.0),)),
                ],
              ),
        
              Row(children: [Flexible(child: Container(
                margin: EdgeInsets.only(left: 12.0),
                  child: Text("${widget.show.summary}",style: TextStyle(color: Colors.grey,fontSize: 14.0),)))])
        
        
        
            ],
          ),
        ),
      ),
    );
  }
}
