import 'package:employee_records/model/employeeModel.dart';
import 'package:flutter/services.dart';


int id;
String imageurl;
String firstname;
String lastname;
String email;
String contactnumber;
int age;
String dob;
int salary;
String address;
var model;
List employeeArray = [];
List<Employee> employeeList = [];

Future<String> getJson() {
  return rootBundle.loadString('assets/json/employees.json');
}