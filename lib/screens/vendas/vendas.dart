import 'package:flutter/material.dart';
import '/widgets/bottom_nav_bar.dart';


class VendasPage extends StatefulWidget{
  @override
  _VendasPage createState() => _VendasPage();
  
  }
  class _VendasPage extends State<VendasPage>{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}