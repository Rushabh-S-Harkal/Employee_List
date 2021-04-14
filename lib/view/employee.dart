import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_records/controller/getEmployee.dart';
import 'package:employee_records/indexed_list_view.dart';
import 'package:employee_records/model/employeeModel.dart';
import 'package:employee_records/view/employeeDetail.dart';
import 'package:flutter/material.dart';

class employee extends StatefulWidget {
  @override
  _employeeState createState() => _employeeState();
}

class _employeeState extends State<employee> {


bool _hasMore;
  int _pageNumber;
  bool _error;
  bool _loading;
  final int _defaultEmpPerPageCount = 10;
  
  final int _nextPageThreshold = 5;


  @override
  void initState() {
    super.initState();
    _hasMore = true;
    _pageNumber = 1;
    _error = false;
    _loading = true;
   
    getList();
  }

// Code with right side alphabets but not loading properly
  final itemHeight = 100.0;
  Widget itemWidget(BuildContext context, int index) {
    return Column(
      children: [
        Container(
          height: 100,
          child: InkWell(
            onTap: () {
              model = employeeList[index];
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => employeeDetail(
                            imageUrl: model.imageUrl,
                            address: model.address,
                            dob: model.dob,
                            firstName: model.firstName,
                            lastName: model.lastName,
                          )));
            },
            child: Card(
              child: Center(
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: CachedNetworkImage(
                      imageUrl: "${employeeList[index].imageUrl}",
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  title: Text(
                      "${employeeList[index].firstName} ${employeeList[index].lastName}"),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

 //get employees list from local JSON file
 
  getList() async {
   try {
      employeeArray = json.decode(await getJson());
    employeeArray.map((e) {
      print(e);
      id = e['id'];
      imageurl = e['imageUrl'] ??
          'https://hub.dummyapis.com/Image?text=DR&height=120&width=120';
      firstname = e['firstName'] ?? 'NA';
      lastname = e['lastName'] ?? 'NA';
      email = e['email'] ?? 'NA';
      contactnumber = e['contactNumber'] ?? 'NA';
      age = e['age'] ?? 0;
      dob = e['dob'] ?? 'NA';
//salary = e['salary']?? 0;
      address = e['address'] ?? 'NA';
       model = Employee(
          address: address,
          age: age,
          contactNumber: contactnumber,
          dob: dob,
          email: email,
          firstName: firstname,
          id: id,
          imageUrl: imageurl,
          lastName: lastname);

      employeeList.add(model);

     
    }).toList();
    setState(() {
      _hasMore = model.length == _defaultEmpPerPageCount;
        _loading = false;
        _pageNumber = _pageNumber + 1;
        employeeList.addAll(model);
         employeeList.sort((a, b) {
        return a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase());
      });
    });
    print('=======$employeeList');
   } catch (e) {
     setState(() {
        _loading = false;
        _error = true;
      });
   }
  }
///
/// 1) Tried with alphabet sorting / alphabets not loading properly 
///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Employee"),
        ),
        body: Column(
          children: <Widget>[
            // titleWidget(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IndexedListView(
                  itemHeight: itemHeight,
                  items: employeeList,
                  itemBuilder: itemWidget,
                ),
              ),
            )
          ],
        )
       // body: getBody(), // For infinite scrolling
        );
  }

  ///
  /// 2) With only sorted listview with detail page
  ///
  
  
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("Employees"),
  //     ),
  //     body: ListView.builder(
  //       itemCount: employeeList.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         model = employeeList[index];
  //         return Container(
  //           height: 100,
  //           child: InkWell(
  //             onTap: (){
  // model = employeeList[index];
  // Navigator.push(context, MaterialPageRoute(builder: (context) => employeeDetail(imageUrl: model.imageUrl,
  // address: model.address,dob: model.dob,firstName: model.firstName,lastName: model.lastName,)));
  //             },
  //             child: Card(
  //               child: Center(
  //                 child: ListTile(
  //                   title: Text('${model.firstName} ${model.lastName}'),
  //                   leading: ClipRRect(
  //                     borderRadius: BorderRadius.circular(30.0),
  //                     child: CachedNetworkImage(
  //                       imageUrl: "${model.imageUrl}",
  //                       placeholder: (context, url) =>
  //                           CircularProgressIndicator(),
  //                       errorWidget: (context, url, error) => Icon(Icons.error),
  //                     ),
  //                   ),
  //                   subtitle: Text(model.address),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  // 
  

  Widget getBody() {
    if (employeeList.isEmpty) {
      if (_loading) {
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ));
      } else if (_error) {
        return Center(
            child: InkWell(
          onTap: () {
            setState(() {
              _loading = true;
              _error = false;
              getList();
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text("Error while loading photos, tap to try agin"),
          ),
        ));
      }
    } else {
      return ListView.builder(
          itemCount: employeeList.length + (_hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == employeeList.length - _nextPageThreshold) {
              getList();
            }
            if (index == employeeList.length) {
              if (_error) {
                return Center(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      _loading = true;
                      _error = false;
                      getList();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text("Error while loading photos, tap to try agin"),
                  ),
                ));
              } else {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ));
              }
            }
            final Employee photo = employeeList[index];
            return Card(
              child: Column(
                children: <Widget>[
                  Image.network(
                    photo.imageUrl,
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    height: 160,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(photo.firstName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ],
              ),
            );
          });
    }
    return Container();
  }
}
