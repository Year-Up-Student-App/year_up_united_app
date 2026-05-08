import 'package:flutter/material.dart';

class ContractScreen extends StatelessWidget{
  const ContractScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(

      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildHeader(), _buildPointHistory()],

        )
      ),

    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF3D1A8C),
      padding: EdgeInsets.fromLTRB(20, 50, 20, 30),
      child: Column(
        children: [
          Text('My Contract',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPointCircle(),
              _buildStats(),
            ],
          )],
      ),
    );
  }

  Widget _buildPointHistory() {
    return Container(

    );
  }

  Widget _buildPointCircle() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
          border: Border.all(
          color: Colors.white38,
          width: 3,
      )
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('170',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800
          ),),
          Text("POINTS",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),)],
      ),
    );
  }

  Widget _buildStats(){
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Row(),
          SizedBox(),],

      ),
    );
  }
}