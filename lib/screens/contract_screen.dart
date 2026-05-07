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
      width: ,
      color: ,
      padding: EdgeInsets.fromLTRB(20, 50, 20, 30),
    );
  }

  Widget _buildPointHistory() {
    return Container(

    );
  }
}