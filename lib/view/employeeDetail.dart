import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class employeeDetail extends StatefulWidget {
  @override
  var imageUrl, firstName, lastName, dob, address;
  employeeDetail(
      {this.address, this.dob, this.firstName, this.imageUrl, this.lastName});
  _employeeDetailState createState() => _employeeDetailState();
}

class _employeeDetailState extends State<employeeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EmployeeDetail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
       
        children: [
          Container(
            height: 200,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
                        imageUrl: "${widget.imageUrl}",
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
              text: TextSpan(
                  text: "Employee Name :",
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: "${widget.firstName}${widget.lastName}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14)),
                  ]),
          ),
          RichText(
              text: TextSpan(
                  text: "Employee Address :",
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: "${widget.address}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14)),
                  ]),
          ),
          RichText(
              text: TextSpan(
                  text: "Employee DOB :",
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: "${widget.dob}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14)),
                  ]),
          ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
